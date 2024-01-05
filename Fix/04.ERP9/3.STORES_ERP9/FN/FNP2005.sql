IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[FNP2005]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[FNP2005]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



---- Created BY Như Hàn
---- Created date 20/12/2018
---- Purpose: Đổ nguồn lưới kế thừa quản lý vay
---- Loại thu: load dữ liệu từ nghiệp vụ Giải ngân.
---- Loại chi: load dữ liệu từ nghiệp vụ Lịch trả nợ
/********************************************
EXEC FNP2005 'AIC', 11, 2018, 11, 2018, '2018-02-01 00:00:00.000', '2018-02-01 00:00:00.000', 1, '%', '', 1, 25
EXEC FNP2005 @DivisionID, @FromMonth, @FromYear, @ToMonth, @ToYear, @FromDate, @ToDate, @IsDate, @VoucherNo, @PriorityID, @PageNumber, @PageSize

'********************************************/
---- Modified by .. on .. 

CREATE PROCEDURE [dbo].[FNP2005]
    @DivisionID AS NVARCHAR(50), 
    @FromMonth			INT,
	@FromYear			INT,
	@ToMonth			INT,
	@ToYear				INT,
	@FromDate			DATETIME,
	@ToDate				DATETIME,
	@IsDate				TINYINT, ----0 theo kỳ, 1 theo ngày
	@VoucherNo			NVARCHAR(500),
	@Status				VARCHAR(50),
	@TransactionType	VARCHAR(50),
	@PageNumber INT,
	@PageSize INT

AS

DECLARE @sSQL NVARCHAR (MAX) = N'',
		@sSQL1 NVARCHAR (MAX) = N'',
		@sSQL2 NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'', ---- Điều kiện where của tab phí hợp đồng vay
		@sWhere1 NVARCHAR(MAX) = N'', ---- Điều kiện where của lịch trả nợ
		@sWhere2 NVARCHAR(MAX) = N'', ---- Điều kiện where của chứng từ thanh toán
        @OrderBy NVARCHAR(500) = N'', 
		@BeginDate DATETIME,	
		@EndDate DATETIME,
		@TotalRow VARCHAR(50)

SET @TotalRow = ''
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

--SET @PeriodFrom = @FromMonth+@FromYear*100
--SET @PeriodTo = @ToMonth+@ToYear*100

SELECT @BeginDate = BeginDate FROM AV9999 WHERE TranMonth = @FromMonth AND TranYear = @FromYear

SELECT @EndDate = EndDate FROM AV9999 WHERE TranMonth = @ToMonth AND TranYear = @ToYear

SET @OrderBy = 'LT1.VoucherNo '
SET @sWhere = @sWhere + ' AND LT1.DivisionID IN ('''+@DivisionID+''', ''@@@'') ' 
IF ISNULL(@Status,'') <> ''
SET @sWhere = @sWhere + '
				AND LT1.Status IN ('''+ISNULL(@Status,'')+''')'	
IF ISNULL(@VoucherNo,'') <> ''
SET @sWhere = @sWhere + '
				AND LT1.VoucherNo LIKE ''%'+ISNULL(@VoucherNo,'')+'%'''	

IF ISNULL(@IsDate,0) = 1
	BEGIN	
		IF (@FromDate IS NOT NULL AND @ToDate IS NULL) SET @sWhere = @sWhere + '
			AND CONVERT(VARCHAR(10),LT1.VoucherDate, 112) >= '''+CONVERT(VARCHAR(10),@FromDate,112)+''' '
		IF (@FromDate IS NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
			AND CONVERT(VARCHAR(10),LT1.VoucherDate, 112) <= '''+CONVERT(VARCHAR(10),@ToDate,112)+''' '
		IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
			AND CONVERT(VARCHAR(10),LT1.VoucherDate, 112) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,112)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,112)+'''  '
	END
ELSE IF ISNULL(@IsDate,0) = 0
	BEGIN
		SET @sWhere = @sWhere + '
			AND CONVERT(VARCHAR(10),LT1.VoucherDate, 112) BETWEEN '''+CONVERT(VARCHAR(10),ISNULL(@BeginDate,''),112)+''' AND '''+CONVERT(VARCHAR(10),ISNULL(@EndDate,''),112)+'''  '
	END


SET @sWhere1 = @sWhere1 + ' AND LT2.DivisionID IN ('''+@DivisionID+''', ''@@@'') ' 
IF ISNULL(@Status,'') <> ''
SET @sWhere1 = @sWhere1 + '
				AND LT1.Status IN ('''+ISNULL(@Status,'')+''')'	
IF ISNULL(@VoucherNo,'') <> ''
SET @sWhere1 = @sWhere1 + '
				AND LT3.VoucherNo LIKE ''%'+ISNULL(@VoucherNo,'')+'%'''	

IF ISNULL(@IsDate,0) = 1
	BEGIN	
		IF (@FromDate IS NOT NULL AND @ToDate IS NULL) SET @sWhere1 = @sWhere1 + '
			AND CONVERT(VARCHAR(10),LT2.PaymentDate, 112) >= '''+CONVERT(VARCHAR(10),@FromDate,112)+''' '
		IF (@FromDate IS NULL AND @ToDate IS NOT NULL) SET @sWhere1 = @sWhere1 + '
			AND CONVERT(VARCHAR(10),LT2.PaymentDate, 112) <= '''+CONVERT(VARCHAR(10),@ToDate,112)+''' '
		IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL) SET @sWhere1 = @sWhere1 + '
			AND CONVERT(VARCHAR(10),LT2.PaymentDate, 112) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,112)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,112)+'''  '
	END
ELSE IF ISNULL(@IsDate,0) = 0
	BEGIN
		SET @sWhere1 = @sWhere1 + '
			AND CONVERT(VARCHAR(10),LT2.PaymentDate, 112) BETWEEN '''+CONVERT(VARCHAR(10),ISNULL(@BeginDate,''),112)+''' AND '''+CONVERT(VARCHAR(10),ISNULL(@EndDate,''),112)+'''  '
	END

SET @sWhere2 = @sWhere2 + ' AND LT3.DivisionID IN ('''+@DivisionID+''', ''@@@'') ' 
IF ISNULL(@Status,'') <> ''
SET @sWhere2 = @sWhere2 + '
				AND LT1.Status IN ('''+ISNULL(@Status,'')+''')'	
IF ISNULL(@VoucherNo,'') <> ''
SET @sWhere2 = @sWhere2 + '
				AND LT3.VoucherNo LIKE ''%'+ISNULL(@VoucherNo,'')+'%'''	

IF ISNULL(@IsDate,0) = 1
	BEGIN	
		IF (@FromDate IS NOT NULL AND @ToDate IS NULL) SET @sWhere2 = @sWhere2 + '
			AND CONVERT(VARCHAR(10),LT3.VoucherDate, 112) >= '''+CONVERT(VARCHAR(10),@FromDate,112)+''' '
		IF (@FromDate IS NULL AND @ToDate IS NOT NULL) SET @sWhere2 = @sWhere2 + '
			AND CONVERT(VARCHAR(10),LT3.VoucherDate, 112) <= '''+CONVERT(VARCHAR(10),@ToDate,112)+''' '
		IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL) SET @sWhere2 = @sWhere2 + '
			AND CONVERT(VARCHAR(10),LT3.VoucherDate, 112) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,112)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,112)+'''  '
	END
ELSE IF ISNULL(@IsDate,0) = 0
	BEGIN
		SET @sWhere2 = @sWhere2 + '
			AND CONVERT(VARCHAR(10),LT3.VoucherDate, 112) BETWEEN '''+CONVERT(VARCHAR(10),ISNULL(@BeginDate,''),112)+''' AND '''+CONVERT(VARCHAR(10),ISNULL(@EndDate,''),112)+'''  '
	END



IF ISNULL(@TransactionType,'') = 'T02' ---- Lập kế hoạch chi
BEGIN 
	---Dữ liệu của Tab phí UNION ALL Dữ liệu thông tin chung
SET @sSQL = @sSQL + N'---- Tab phí hợp đồng vay
SELECT LT1.VoucherNo, LT2.Notes As Description, LT1.Status, LT9.Description As StatusName, LT1.CreditFormID, 
LT0.CreditFormName As CreditFormName, 
convert(varchar, LT1.FromDate, 103) +'' - ''+ convert(varchar, LT1.ToDate, 103) AS FromToDate, 
LT2.Notes,
LT2.Ana01ID,
A11.AnaName AS Ana01Name,
LT2.Ana02ID,
A12.AnaName AS Ana02Name,
LT2.Ana03ID,
A13.AnaName AS Ana03Name,
LT2.Ana04ID,
A14.AnaName AS Ana04Name,
LT2.Ana05ID,
A15.AnaName AS Ana05Name,
LT2.Ana06ID,
A16.AnaName AS Ana06Name,
LT2.Ana07ID,
A17.AnaName AS Ana07Name,
LT2.Ana08ID,
A18.AnaName AS Ana08Name,
LT2.Ana09ID,
A19.AnaName AS Ana09Name,
LT2.Ana10ID,
A20.AnaName AS Ana10Name,
SUM(LT2.ConvertedAmount) As OAmount, SUM(LT2.ConvertedAmount) As CAmount
INTO #LMT2002
FROM LMT2002 LT2 WITH (NOLOCK)
INNER JOIN LMT2001 LT1 WITH (NOLOCK) ON LT2.VoucherID = LT1.VoucherID AND LT1.DivisionID = LT2.DivisionID
LEFT JOIN AT1011 A11 WITH (NOLOCK) ON LT2.Ana01ID = A11.AnaID AND A11.AnaTypeID = ''A01''
LEFT JOIN AT1011 A12 WITH (NOLOCK) ON LT2.Ana02ID = A12.AnaID AND A12.AnaTypeID = ''A02''
LEFT JOIN AT1011 A13 WITH (NOLOCK) ON LT2.Ana03ID = A13.AnaID AND A13.AnaTypeID = ''A03''
LEFT JOIN AT1011 A14 WITH (NOLOCK) ON LT2.Ana04ID = A14.AnaID AND A14.AnaTypeID = ''A04''
LEFT JOIN AT1011 A15 WITH (NOLOCK) ON LT2.Ana05ID = A15.AnaID AND A15.AnaTypeID = ''A05''
LEFT JOIN AT1011 A16 WITH (NOLOCK) ON LT2.Ana06ID = A16.AnaID AND A16.AnaTypeID = ''A06''
LEFT JOIN AT1011 A17 WITH (NOLOCK) ON LT2.Ana07ID = A17.AnaID AND A17.AnaTypeID = ''A07''
LEFT JOIN AT1011 A18 WITH (NOLOCK) ON LT2.Ana08ID = A18.AnaID AND A18.AnaTypeID = ''A08''
LEFT JOIN AT1011 A19 WITH (NOLOCK) ON LT2.Ana09ID = A19.AnaID AND A19.AnaTypeID = ''A09''
LEFT JOIN AT1011 A20 WITH (NOLOCK) ON LT2.Ana10ID = A20.AnaID AND A20.AnaTypeID = ''A10''
LEFT JOIN LMT0099 LT9 WITH (NOLOCK) ON LT1.Status = LT9.OrderNo AND LT9.CodeMaster = ''LMT00000003'' AND LT9.Disabled = 0
LEFT JOIN LMT1001 LT0 WITH (NOLOCK) ON LT1.CreditFormID = LT0.CreditFormID AND LT0.Disabled = 0
WHERE 1=1
'+@sWhere +'
GROUP BY 
LT1.VoucherNo, LT2.Notes, LT1.Status, LT9.Description, LT1.CreditFormID, 
LT0.CreditFormName, 
LT1.FromDate, LT1.ToDate, 
LT2.Notes,
LT2.Ana01ID,
A11.AnaName,
LT2.Ana02ID,
A12.AnaName,
LT2.Ana03ID,
A13.AnaName,
LT2.Ana04ID,
A14.AnaName,
LT2.Ana05ID,
A15.AnaName,
LT2.Ana06ID,
A16.AnaName,
LT2.Ana07ID,
A17.AnaName,
LT2.Ana08ID,
A18.AnaName,
LT2.Ana09ID,
A19.AnaName,
LT2.Ana10ID,
A20.AnaName
'

SET @sSQL1 = @sSQL1 + N' ---- Lịch trả nợ
SELECT LT3.VoucherNo, LT2.Description, LT1.Status, LT9.Description As StatusName, LT2.PaymentName As CreditFormName,  
'''' As CreditFormID, 
convert(varchar, LT1.FromDate, 103) +'' - ''+ convert(varchar, LT1.ToDate, 103) AS FromToDate, 
LT4.Notes,
LT4.Ana01ID,
A11.AnaName AS Ana01Name,
LT4.Ana02ID,
A12.AnaName AS Ana02Name,
LT4.Ana03ID,
A13.AnaName AS Ana03Name,
LT4.Ana04ID,
A14.AnaName AS Ana04Name,
LT4.Ana05ID,
A15.AnaName AS Ana05Name,
LT4.Ana06ID,
A16.AnaName AS Ana06Name,
LT4.Ana07ID,
A17.AnaName AS Ana07Name,
LT4.Ana08ID,
A18.AnaName AS Ana08Name,
LT4.Ana09ID,
A19.AnaName AS Ana09Name,
LT4.Ana10ID,
A20.AnaName AS Ana10Name,
SUM(LT2.PaymentOriginalAmount) As OAmount, SUM(LT2.PaymentConvertedAmount) As CAmount
INTO #LMT2004
FROM LMT2022 LT2 WITH (NOLOCK)
INNER JOIN LMT2021 LT3 WITH (NOLOCK) ON LT2.DisburseVoucherID = LT3.VoucherID AND LT2.DivisionID = LT3.DivisionID
INNER JOIN LMT2004 LT4 WITH (NOLOCK) ON LT4.VoucherID = LT3.CreditVoucherID AND LT4.DivisionID = LT3.DivisionID
INNER JOIN LMT2001 LT1 WITH (NOLOCK) ON LT4.VoucherID = LT1.VoucherID  AND LT1.DivisionID = LT4.DivisionID
LEFT JOIN AT1011 A11 WITH (NOLOCK) ON LT4.Ana01ID = A11.AnaID AND A11.AnaTypeID = ''A01''
LEFT JOIN AT1011 A12 WITH (NOLOCK) ON LT4.Ana02ID = A12.AnaID AND A12.AnaTypeID = ''A02''
LEFT JOIN AT1011 A13 WITH (NOLOCK) ON LT4.Ana03ID = A13.AnaID AND A13.AnaTypeID = ''A03''
LEFT JOIN AT1011 A14 WITH (NOLOCK) ON LT4.Ana04ID = A14.AnaID AND A14.AnaTypeID = ''A04''
LEFT JOIN AT1011 A15 WITH (NOLOCK) ON LT4.Ana05ID = A15.AnaID AND A15.AnaTypeID = ''A05''
LEFT JOIN AT1011 A16 WITH (NOLOCK) ON LT4.Ana06ID = A16.AnaID AND A16.AnaTypeID = ''A06''
LEFT JOIN AT1011 A17 WITH (NOLOCK) ON LT4.Ana07ID = A17.AnaID AND A17.AnaTypeID = ''A07''
LEFT JOIN AT1011 A18 WITH (NOLOCK) ON LT4.Ana08ID = A18.AnaID AND A18.AnaTypeID = ''A08''
LEFT JOIN AT1011 A19 WITH (NOLOCK) ON LT4.Ana09ID = A19.AnaID AND A19.AnaTypeID = ''A09''
LEFT JOIN AT1011 A20 WITH (NOLOCK) ON LT4.Ana10ID = A20.AnaID AND A20.AnaTypeID = ''A10''
LEFT JOIN LMT0099 LT9 WITH (NOLOCK) ON  LT1.Status = LT9.OrderNo AND LT9.CodeMaster = ''LMT00000003'' AND LT9.Disabled = 0
LEFT JOIN LMT1001 LT0 WITH (NOLOCK) ON LT1.CreditFormID = LT0.CreditFormID AND LT0.Disabled = 0
WHERE 1=1
'+@sWhere1 +'
GROUP BY 
LT3.VoucherNo, LT2.Description, LT1.Status, LT9.Description, LT2.PaymentName, LT2.PaymentType,
	LT0.CreditFormName, 
	LT1.FromDate, LT1.ToDate, 
	LT4.Notes,
	LT4.Ana01ID,
	A11.AnaName,
	LT4.Ana02ID,
	A12.AnaName,
	LT4.Ana03ID,
	A13.AnaName,
	LT4.Ana04ID,
	A14.AnaName,
	LT4.Ana05ID,
	A15.AnaName,
	LT4.Ana06ID,
	A16.AnaName,
	LT4.Ana07ID,
	A17.AnaName,
	LT4.Ana08ID,
	A18.AnaName,
	LT4.Ana09ID,
	A19.AnaName,
	LT4.Ana10ID,
	A20.AnaName
'

SET @sSQL2 = @sSQL2 + N'

SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY A.VoucherNo)) AS RowNum, '+@TotalRow+' As TotalRow,
A.* FROM (
SELECT * FROM #LMT2002
UNION ALL
SELECT * FROM #LMT2004)A
ORDER BY A.VoucherNo 
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY 
'

EXEC (@sSQL+@sSQL1+@sSQL2)
--PRINT @sSQL
--PRINT @sSQL1
--PRINT @sSQL2
END


ELSE IF ISNULL(@TransactionType,'') = 'T01' ---- Lập kế hoạch thu
BEGIN
SET @sSQL1 = @sSQL1 + N'
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' As TotalRow,
LT3.VoucherNo, LT3.Description, LT1.Status, LT9.Description As StatusName, LT1.CreditFormID, 
LT0.CreditFormName As CreditFormName, 
convert(varchar, LT1.FromDate, 103) +'' - ''+ convert(varchar, LT1.ToDate, 103) AS FromToDate, 
LT4.Notes,
LT4.Ana01ID,
A11.AnaName AS Ana01Name,
LT4.Ana02ID,
A12.AnaName AS Ana02Name,
LT4.Ana03ID,
A13.AnaName AS Ana03Name,
LT4.Ana04ID,
A14.AnaName AS Ana04Name,
LT4.Ana05ID,
A15.AnaName AS Ana05Name,
LT4.Ana06ID,
A16.AnaName AS Ana06Name,
LT4.Ana07ID,
A17.AnaName AS Ana07Name,
LT4.Ana08ID,
A18.AnaName AS Ana08Name,
LT4.Ana09ID,
A19.AnaName AS Ana09Name,
LT4.Ana10ID,
A20.AnaName AS Ana10Name,
SUM(LT3.ConvertedAmount) As OAmount, SUM(LT3.ConvertedAmount) As CAmount
FROM LMT2021 LT3 WITH (NOLOCK)
INNER JOIN LMT2004 LT4 WITH (NOLOCK) ON LT4.VoucherID = LT3.CreditVoucherID AND LT4.DivisionID = LT3.DivisionID
INNER JOIN LMT2001 LT1 WITH (NOLOCK) ON LT4.VoucherID = LT1.VoucherID  AND LT1.DivisionID = LT4.DivisionID
LEFT JOIN AT1011 A11 WITH (NOLOCK) ON LT4.Ana01ID = A11.AnaID AND A11.AnaTypeID = ''A01''
LEFT JOIN AT1011 A12 WITH (NOLOCK) ON LT4.Ana02ID = A12.AnaID AND A12.AnaTypeID = ''A02''
LEFT JOIN AT1011 A13 WITH (NOLOCK) ON LT4.Ana03ID = A13.AnaID AND A13.AnaTypeID = ''A03''
LEFT JOIN AT1011 A14 WITH (NOLOCK) ON LT4.Ana04ID = A14.AnaID AND A14.AnaTypeID = ''A04''
LEFT JOIN AT1011 A15 WITH (NOLOCK) ON LT4.Ana05ID = A15.AnaID AND A15.AnaTypeID = ''A05''
LEFT JOIN AT1011 A16 WITH (NOLOCK) ON LT4.Ana06ID = A16.AnaID AND A16.AnaTypeID = ''A06''
LEFT JOIN AT1011 A17 WITH (NOLOCK) ON LT4.Ana07ID = A17.AnaID AND A17.AnaTypeID = ''A07''
LEFT JOIN AT1011 A18 WITH (NOLOCK) ON LT4.Ana08ID = A18.AnaID AND A18.AnaTypeID = ''A08''
LEFT JOIN AT1011 A19 WITH (NOLOCK) ON LT4.Ana09ID = A19.AnaID AND A19.AnaTypeID = ''A09''
LEFT JOIN AT1011 A20 WITH (NOLOCK) ON LT4.Ana10ID = A20.AnaID AND A20.AnaTypeID = ''A10''
LEFT JOIN LMT0099 LT9 WITH (NOLOCK) ON  LT1.Status = LT9.OrderNo AND LT9.CodeMaster = ''LMT00000003'' AND LT9.Disabled = 0
LEFT JOIN LMT1001 LT0 WITH (NOLOCK) ON LT1.CreditFormID = LT0.CreditFormID AND LT0.Disabled = 0
WHERE 1=1
'+@sWhere2 +'
GROUP BY 
LT3.VoucherNo, LT1.VoucherNo, LT3.Description, LT1.Status, LT9.Description, LT1.CreditFormID, 
LT0.CreditFormName, 
LT1.FromDate, LT1.ToDate, 
LT4.Notes,
LT4.Ana01ID,
A11.AnaName,
LT4.Ana02ID,
A12.AnaName,
LT4.Ana03ID,
A13.AnaName,
LT4.Ana04ID,
A14.AnaName,
LT4.Ana05ID,
A15.AnaName,
LT4.Ana06ID,
A16.AnaName,
LT4.Ana07ID,
A17.AnaName,
LT4.Ana08ID,
A18.AnaName,
LT4.Ana09ID,
A19.AnaName,
LT4.Ana10ID,
A20.AnaName
ORDER BY '+@OrderBy+' 
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY 
'
EXEC (@sSQL1)
--PRINT @sSQL1
END


		
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
