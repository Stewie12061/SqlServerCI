IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BEMP2021]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BEMP2021]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Grid: màn hình kế thừa đề nghị công tác
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by  Trọng Kiên  on 06/06/2020
----Modified by Vĩnh Tâm    on 12/06/2020: Bổ sung điều kiện load dữ liệu và các cột còn thiếu
----Modified by Vĩnh Tâm    on 03/11/2020: Thay đổi điều kiện sort
----Modified by Vĩnh Tâm    on 15/12/2020: Bổ sung load cột RemainingAmount
/* <Example>
    BEMP2021 @DivisionID = 'DTI', @UserID = 'D41001', @PageNumber = 1, @PageSize = 100, @APKMaster = '92fd9b56-d6b4-46df-9e8d-1a753018997f'
 */

CREATE PROCEDURE [dbo].[BEMP2021]
( 
     @DivisionID VARCHAR(50),
     @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT,
     @APKMaster NVARCHAR(MAX)
)
AS 
BEGIN
    DECLARE @sSQL NVARCHAR(MAX) = N'',
            @sWhere NVARCHAR(MAX) = N'',
            @TotalRow NVARCHAR(50) = N'',
            @OrderBy NVARCHAR(500) = N'',
            @sJoin NVARCHAR(MAX) = N''

    SET @OrderBy = 'M.VoucherNo DESC, M.OrderNo'
    SET @sWhere = ''

    SET @sSQL = @sSQL + N'
        SELECT  B2.APK, B1.DivisionID, B5.AdvancePaymentUserID AS ObjectID, ISNULL(A4.ObjectName, B5.AdvancePaymentUserID) AS ObjectName, A4.Address AS ObjectAddress
                , B1.VoucherNo, B2.Date AS VoucherDate, B2.Contents AS Description
                , B2.CurrencyID, ISNULL(A5.CurrencyName, B2.CurrencyID) AS CurrencyName, A5.ExchangeRate
                , B2.FeeID, ISNULL(B3.FeeName, B2.FeeID) AS FeeName, B2.CostAnaID, ISNULL(A1.AnaName, B2.CostAnaID) AS CostAnaName
                , B2.DepartmentAnaID, ISNULL(A2.AnaName, B2.DepartmentAnaID) AS DepartmentAnaName
                , B2.Amount AS OriginalAmount, B2.ConvertedAmount, B2.ConvertedAmount AS RemainingAmount, B2.OrderNo

        INTO #TempBEMT2021
        FROM BEMT2020 B1 WITH (NOLOCK)
            INNER JOIN BEMT2010 B5 WITH (NOLOCK) ON B5.APK = B1.APKMaster AND ISNULL(B5.DeleteFlg, 0) = 0
            INNER JOIN BEMT2021 B2 WITH (NOLOCK) ON B1.APK = B2.APKMaster AND ISNULL(B2.Amount, 0) > 0 AND ISNULL(B2.IsInherited, 0) = 0
            LEFT JOIN BEMT2001 B6 WITH (NOLOCK) ON B6.APKDInherited = B2.APK
            LEFT JOIN BEMT1000 B3 WITH (NOLOCK) ON B3.DivisionID IN (B1.DivisionID, ''@@@'') AND B2.FeeID = B3.FeeID
            LEFT JOIN BEMT0000 B4 WITH (NOLOCK) ON B4.DivisionID = B1.DivisionID
            LEFT JOIN AT1011 A1 WITH (NOLOCK) ON A1.DivisionID = B1.DivisionID AND A1.AnaTypeID = B4.CostAnaID AND A1.AnaID = B2.CostAnaID
            LEFT JOIN AT1011 A2 WITH (NOLOCK) ON A2.DivisionID = B1.DivisionID AND A2.AnaTypeID = B4.DepartmentAnaID AND A2.AnaID = B2.DepartmentAnaID
            LEFT JOIN AT1202 A4 WITH (NOLOCK) ON A4.DivisionID IN (B1.DivisionID, ''@@@'') AND A4.ObjectID = B5.AdvancePaymentUserID
            LEFT JOIN AT1004 A5 WITH (NOLOCK) ON A5.DivisionID IN (B1.DivisionID, ''@@@'') AND A5.CurrencyID = B2.CurrencyID
        WHERE B1.DivisionID = ''' + @DivisionID + ''' AND B1.APKMaster = ''' + @APKMaster + '''

        DECLARE @Count INT
        SELECT @Count = COUNT (*) FROM #TempBEMT2021

        SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow
                , M.APK, M.VoucherNo, M.VoucherDate, M.Description, M.ObjectID, M.ObjectName, M.ObjectAddress, M.CurrencyID, M.CurrencyName, M.ExchangeRate
                , M.FeeID, M.FeeName, M.OriginalAmount, M.CostAnaID, M.CostAnaName, M.DepartmentAnaID, M.DepartmentAnaName, M.ConvertedAmount, M.RemainingAmount, M.OrderNo
        FROM #TempBEMT2021 M
        ORDER BY ' + @OrderBy + '
        OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
        FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
    EXEC (@sSQL)
    --PRINT(@sSQL)

END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
