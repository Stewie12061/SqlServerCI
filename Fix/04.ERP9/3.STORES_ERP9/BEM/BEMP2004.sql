IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BEMP2004]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BEMP2004]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load grid kế thừa phiếu đề nghị tạm ứng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 16/06/2020 by Trọng Kiên
-- <Example> EXEC BEMP2013 @DivisionID = 'DTI', @DivisionIDList = '', '2020/05/03', '2020/06/03', 0, 0 , 0 , 0, '331', 'TH/123/232', 'TH', 1, 100

CREATE PROCEDURE [dbo].[BEMP2004]
( 
    @DivisionID VARCHAR(50),
    @DivisionIDList NVARCHAR(MAX),
    @IsDate TINYINT, ---- 0: Lọc theo ngày, 1: Lọc theo kỳ
    @FromDate DATETIME,
    @ToDate DATETIME,
    @FromMonth INT, 
    @FromYear INT, 
    @ToMonth INT, 
    @ToYear INT, 
    @ObjectID NVARCHAR(250),
    @VoucherNo NVARCHAR(250),
    @MethodPay VARCHAR(50),
    @PageNumber INT,
    @PageSize INT
)
AS
BEGIN
    DECLARE @sSQL NVARCHAR (MAX) = N'',
            @OrderBy NVARCHAR(MAX) = N'', 
            @TotalRow NVARCHAR(50) = N'',
            @sWhere NVARCHAR(MAX),
            @sSQLPermission NVARCHAR(MAX),
            @FromDateText NVARCHAR(20),
            @ToDateText NVARCHAR(20)

    SET @OrderBy = 'M.VoucherDate DESC'
    SET @sWhere = ' B1.TypeID = ''DNTU'' AND B1.APKInherited Is NULL AND B1.InheritVoucherNo Is NULL AND ISNULL(B1.Status, 0) = 1'
    SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
    SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

    -- Check Para DivisionIDList null then get DivisionID
    IF ISNULL(@DivisionIDList, '') != ''
        SET @sWhere = @sWhere + ' AND B1.DivisionID IN (''' + @DivisionIDList + ''')'
    ELSE 
        SET @sWhere = @sWhere + ' AND B1.DivisionID IN (''' + @DivisionID + ''')'

    -- Check Para FromDate và ToDate
    IF @IsDate = 0 
    BEGIN
        SET @sWhere = @sWhere + N'
        AND B1.TranMonth + B1.TranYear * 100 BETWEEN ' + STR(@FromMonth + @FromYear * 100) + ' AND ' + STR(@ToMonth + @ToYear * 100) + ''
    END
    ELSE
    BEGIN
        IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '') 
            SET @sWhere = @sWhere + N' AND B1.VoucherDate >= ''' + CONVERT(VARCHAR(10), @FromDate, 120) + ''''

        IF (ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '') 
            SET @sWhere = @sWhere + N' AND B1.VoucherDate <= ''' + CONVERT(VARCHAR(10), @ToDate, 120) + ''''

        IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '') 
            SET @sWhere = @sWhere + N' AND B1.VoucherDate BETWEEN ''' + CONVERT(VARCHAR(10), @FromDate, 120) + ''' AND ''' + CONVERT(VARCHAR(10), @ToDate, 120) + ''' '
    END

    IF ISNULL(@ObjectID, '') != ''
        SET @sWhere = @sWhere + ' AND ISNULL(B1.AdvanceUserID, '''') = ''' + @ObjectID + ''''
        
    IF ISNULL(@VoucherNo, '') != ''
        SET @sWhere = @sWhere + ' AND ISNULL(B1.VoucherNo, '''') LIKE N''%' + @VoucherNo + '%'' '

    IF ISNULL(@MethodPay, '') != ''
        SET @sWhere = @sWhere + ' AND ISNULL(B1.MethodPay, '''') = ''' + @MethodPay + ''''


    IF @PageNumber = 1 SET @TotalRow = 'COUNT OVER ()' ELSE SET @TotalRow = 'NULL'


    SET @sSQL = @sSQL + N'
        SELECT B1.APK, B1.DivisionID, B1.VoucherNo, B1.VoucherDate, B1.AdvanceUserID, B1.AdvanceUserID AS ObjectID
			, A1.ObjectName AS AdvanceUserName, A1.Address AS ObjectAddress, A4.PaymentName AS MethodPay, A2.DepartmentName, A3.FullName AS ApplicantName
			, B2.RequestAmount
				- SUM(ISNULL(IIF(ISNULL(B3.Status, 0) = 0, B3.RequestAmount, 0), 0))
				- SUM(ISNULL(IIF(ISNULL(B3.Status, 0) = 1, B3.SpendAmount, 0), 0))
				AS RemainingAmount, B1.DescriptionMaster, B1.CurrencyID, B1.AdvancePayment
        INTO #TempBEMT2004
        FROM BEMT2000 B1 WITH (NOLOCK)
            LEFT JOIN AT1202 A1 WITH (NOLOCK) ON A1.DivisionID IN (B1.DivisionID, ''@@@'') AND A1.ObjectID = B1.AdvanceUserID
            LEFT JOIN AT1102 A2 WITH (NOLOCK) ON A2.DepartmentID = B1.DepartmentID
            LEFT JOIN AT1103 A3 WITH (NOLOCK) ON A3.EmployeeID = B1.ApplicantID
            LEFT JOIN AT1205 A4 WITH (NOLOCK) ON A4.PaymentID = B1.MethodPay
            LEFT JOIN BEMT2001 B2 WITH (NOLOCK) ON B2.APKMaster = B1.APK
            LEFT JOIN BEMT2001 B3 WITH (NOLOCK) ON B3.APKDInherited = B2.APK
        WHERE ' + @sWhere + '
        GROUP BY B1.APK, B1.DivisionID, B1.VoucherNo, B1.VoucherDate, B1.AdvanceUserID, B1.AdvanceUserID
            , A1.ObjectName, A1.Address, A4.PaymentName,A2.DepartmentName, A3.FullName 
            , B2.RequestAmount, B1.DescriptionMaster, B1.CurrencyID, B1.AdvancePayment

        DECLARE @Count INT
        SELECT @Count = COUNT (*) FROM #TempBEMT2004

        SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow
              , M.APK
              , M.VoucherNo
              , M.VoucherDate
              , M.ObjectID
			  , M.ObjectAddress
              , M.AdvanceUserID
              , M.AdvanceUserName
              , M.MethodPay
              , M.DepartmentName
              , M.ApplicantName
              , SUM(M.RemainingAmount) AS RemainingAmount
			  , M.DescriptionMaster
			  , M.CurrencyID
			  , M.AdvancePayment

        FROM #TempBEMT2004 M
		GROUP BY M.APK, M.VoucherNo, M.VoucherDate, M.ObjectID, M.ObjectAddress, M.AdvanceUserID, M.AdvanceUserName, M.MethodPay, M.DepartmentName, M.ApplicantName, M.DescriptionMaster
			  , M.CurrencyID
			  , M.AdvancePayment
		HAVING SUM(M.RemainingAmount) > 0
        ORDER BY ' + @OrderBy + '
        OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
        FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
    EXEC (@sSQL)
    PRINT(@sSQL)
END







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
