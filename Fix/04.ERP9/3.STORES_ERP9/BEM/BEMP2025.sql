IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BEMP2025]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BEMP2025]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---- Truy vấn load dữ liệu cho lưới details từ màn hình xem chi tiết
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Trọng Kiên, Date: 03/07/2020
----Modified by: Vĩnh Tâm,	Date: 04/11/2020: Thay đổi điều kiện Order By theo cột OrderNo của Detail
-- <Example>
---- 
/*-- <Example>
    BEMP2025 @DivisionID = 'MK', @APK = 'ABCA3441-E076-4D28-88E5-04BF4480B9CB', @PageNumber = 1, @PageSize = 20
----*/

CREATE PROCEDURE [dbo].[BEMP2025]
(
    @DivisionID VARCHAR(50),
    @APK VARCHAR(50),
    @PageNumber INT,
    @Pagesize INT
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500) = N''

SET @OrderBy = 'B3.OrderNo'
SET @sWhere = N''

IF ISNULL(@DivisionID, '') != ''
    SET @sWhere = @sWhere + ' B1.DivisionID IN (''' + @DivisionID + ''') '

IF ISNULL(@APK, '') != ''
    SET @sWhere = @sWhere + ' AND B1.APK = ''' + ISNULL(@APK, '') + ''' OR B1.APKMaster_9000 = ''' + ISNULL(@APK, '') + ''' '

SET @sSQL = N'SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ' ) AS RowNum, COUNT(*) OVER () AS TotalRow
              , B3.APK, B3.Date, B3.Contents, A1.CurrencyName, B3.Amount, B2.FeeName, A2.AnaName AS DepartmentAnaName, A3.AnaName AS CostAnaName
              , ISNULL(B3.ExchangeRate, 0) AS ExchangeRate, ISNULL(B3.ConvertedAmount, 0) AS ConvertedAmount

            FROM BEMT2020 B1 WITH (NOLOCK) 
                LEFT JOIN BEMT2021 B3 WITH (NOLOCK) ON B3.APKMaster = B1.APK
                LEFT JOIN AT1004 AS A1 WITH (NOLOCK) ON A1.CurrencyID = B3.CurrencyID
                LEFT JOIN BEMT1000 AS B2 WITH (NOLOCK) ON B2.FeeID = B3.FeeID
                LEFT JOIN AT1011 A2 WITH (NOLOCK) ON A2.AnaID = B3.DepartmentAnaID
                LEFT JOIN AT1011 A3 WITH (NOLOCK) ON A3.AnaID = B3.CostAnaID

            WHERE ' + @sWhere + '
            ORDER BY ' + @OrderBy + '
            OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
            FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
EXEC (@sSQL)
--PRINT (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
