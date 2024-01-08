IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP30031]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP30031]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Xu ly hang ton kho
---- Thay cho View AV7000 để dữ liệu khi lấy không bị chậm
---- Dùng cho các store khác lấy dữ liệu
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 23/06/2022 by Hoài Bảo - Clone từ store AP7000 ERP8
---- Modified on ... by ...
---- Update on 17/02/2023 by Anh Đô: Chuyển các Param @InventoryID, @ObjectID sang kiểu NVARCHAR(MAX) để tránh chuỗi bị cắt khi quá dài
-- <Example>
---- EXEC WMP30031 'AS', 'ADMIN', '','','','','','', 0, 1, 2012, 12,2013, NULL, NULL
---- SELECT * FROM AV7008
CREATE PROCEDURE WMP30031
( 
		@DivisionID AS NVARCHAR(50),
		@UserID AS NVARCHAR(50),
		@WareHouseID AS NVARCHAR(50),
		@InventoryID AS NVARCHAR(MAX),
		@ObjectID  AS NVARCHAR(MAX),
		@IsTime AS TINYINT, -- 1 : Ky
							-- 2 : Ngay
		@FromMonth AS int,
		@FromYear AS int,
		@ToMonth AS int,
		@ToYear AS int,
		@FromDate AS Datetime,
		@ToDate AS Datetime
		
) 
AS 

DECLARE @sSQL AS NVARCHAR(MAX),
		@sSQL1 AS NVARCHAR(MAX),
		@sSQL2 AS NVARCHAR(MAX),
		@sSQL3 AS NVARCHAR(MAX),
		@sSQL4 AS NVARCHAR(MAX),
		@sSQL5 AS NVARCHAR(MAX),
		@sSQL6 AS NVARCHAR(MAX),
		@sSQL7 AS NVARCHAR(MAX),
		@sWhere AS NVARCHAR(MAX),
		@sWhere1 AS NVARCHAR(MAX),
		@sWhere2 AS NVARCHAR(MAX),
		@sWhere3 AS NVARCHAR(MAX),
		@sWhere4 AS NVARCHAR(MAX),
		@sWhere5 AS NVARCHAR(MAX)

SET @sWhere = ''
SET @sWhere1 = ''
SET @sWhere2 = ''
SET @sWhere3 = ''
SET @sWhere4 = ''
SET @sWhere5 = ''

IF (@WareHouseID <> '%' AND ISNULL(@WareHouseID, '') <> '')
BEGIN
	SET @sWhere1 = @sWhere1 + N'
		AND D16.WareHouseID = '''+@WareHouseID+''' '
	SET @sWhere2 = @sWhere2 + N'
		AND D16.WareHouseID = '''+@WareHouseID+''' '
	SET @sWhere3 = @sWhere3 + N'
		AND D06.WareHouseID = '''+@WareHouseID+''' '
	SET @sWhere4 = @sWhere4 + N'
		AND CASE WHEN D06.KindVoucherID = 3 THEN D06.WareHouseID2 ELSE  D06.WareHouseID END = '''+@WareHouseID+''' '
END
IF ISNULL(@InventoryID, '') <> ''
BEGIN
	SET @sWhere1 = @sWhere1 + N'
		AND D17.InventoryID IN (SELECT Value FROM dbo.StringSplit('''+@InventoryID+''', '','')) '
	SET @sWhere2 = @sWhere2 + N'
		AND D17.InventoryID IN (SELECT Value FROM dbo.StringSplit('''+@InventoryID+''', '','')) '
	SET @sWhere3 = @sWhere3 + N'
		AND D07.InventoryID IN (SELECT Value FROM dbo.StringSplit('''+@InventoryID+''', '','')) '
	SET @sWhere4 = @sWhere4 + N'
		AND D07.InventoryID IN (SELECT Value FROM dbo.StringSplit('''+@InventoryID+''', '','')) '
END
IF ISNULL(@ObjectID, '') <> ''
BEGIN
	SET @sWhere1 = @sWhere1 + N'
		AND D16.ObjectID IN (SELECT Value FROM dbo.StringSplit('''+@ObjectID+''', '','')) '
	SET @sWhere2 = @sWhere2 + N'
		AND D16.ObjectID IN (SELECT Value FROM dbo.StringSplit('''+@ObjectID+''', '','')) '
	SET @sWhere3 = @sWhere3 + N'
		AND D06.ObjectID IN (SELECT Value FROM dbo.StringSplit('''+@ObjectID+''', '','')) '
	SET @sWhere4 = @sWhere4 + N'
		AND D06.ObjectID IN (SELECT Value FROM dbo.StringSplit('''+@ObjectID+''', '','')) '
END
IF @IsTime = 1 --- Kỳ
	AND (ISNULL(@FromMonth,'') <> '' OR ISNULL(@FromYear,'') <> '' OR ISNULL(@ToMonth,'') <> '' OR ISNULL(@ToYear,'') <> '')	
BEGIN
	SET @sWhere1 = @sWhere1 + N'
		AND D17.TranYear*100+D17.TranMonth <= '+STR(@FromYear*100+@FromMonth)+' '
	SET @sWhere2 = @sWhere2 + N'
		AND D17.TranYear*100+D17.TranMonth <= '+STR(@FromYear*100+@FromMonth)+'  '
	SET @sWhere3 = @sWhere3 + N'
		AND D07.TranYear*100+D07.TranMonth >= '+STR(@FromYear*100+@FromMonth)+' 
		AND D07.TranYear*100+D07.TranMonth <= '+STR(@ToYear*100+@ToMonth)+' '
	SET @sWhere4 = @sWhere4 + N'
		AND D07.TranYear*100+D07.TranMonth >= '+STR(@FromYear*100+@FromMonth)+' 
		AND D07.TranYear*100+D07.TranMonth <= '+STR(@ToYear*100+@ToMonth)+' '
END
IF @IsTime = 2 --- Ngày
	AND (ISNULL(@FromDate,'') <> '' OR ISNULL(@ToDate,'') <> '')
BEGIN
	SET @sWhere1 = @sWhere1 + N'
		AND D16.VoucherDate <= '''+CONVERT(NVARCHAR(20), @FromDate, 101)+''' '
	SET @sWhere2 = @sWhere2 + N'
		AND D16.VoucherDate <= '''+CONVERT(NVARCHAR(20), @FromDate, 101)+'''  '
	SET @sWhere3 = @sWhere3 + N'
		AND D06.VoucherDate >= '''+CONVERT(NVARCHAR(20), @FromDate, 101)+''' 
		AND D06.VoucherDate <= '''+CONVERT(NVARCHAR(20), @ToDate, 101)+ ' 23:59:59'+''' '
	SET @sWhere4 = @sWhere4 + N'
		AND D06.VoucherDate >= '''+CONVERT(NVARCHAR(20), @FromDate, 101)+''' 
		AND D06.VoucherDate <= '''+CONVERT(NVARCHAR(20), @ToDate, 101)+ ' 23:59:59'+''' '
END
	
--- So du No cua tai khoan ton kho
SET @sSQL = N'
SELECT  D17.DivisionID, D17.TranMonth, D17.TranYear, D17.TransactionID,
	D16.WareHouseID, D17.InventoryID, D17.DebitAccountID, D17.CreditAccountID,
	''BD'' AS D_C,  --- So du No
	'''' AS RefNo01, '''' AS RefNo02, 	D17.Notes,
	D16.VoucherID, D16.VoucherDate, D16.VoucherNo, 
	D16.ObjectID,AT1202.ObjectName,
	AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID,
	AT1202.Address,
	D02.InventoryName, D02.UnitID, D04.UnitName, D02.InventoryTypeID, D02.VATPercent,
	D03.WareHouseName,	
	ActualQuantity, 
	ConvertedAmount,
	ActualQuantity AS SignQuantity, 
	ConvertedAmount AS SignAmount,	
	D02.S1,	D02.S2, D02.S3 ,
	D02.S1 AS CI1ID, D02.S2 AS CI2ID, D02.S3 AS CI3ID, 
	D17.Ana01ID,D17.Ana02ID,D17.Ana03ID, D17.Ana04ID,D17.Ana05ID,
	D17.Ana06ID,D17.Ana07ID,D17.Ana08ID, D17.Ana09ID,D17.Ana10ID,
	D16.VoucherTypeID,
	S1.SName AS S1Name,
	S2.SName AS S2Name,
	S3.SName AS S3Name,
	D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, D02.Specification, 
	D17.Notes01, D17.Notes02, D17.Notes03,
	D02.Varchar01,D02.Varchar02,D02.Varchar03,D02.Varchar04,D02.Varchar05,
	I1.AnaName AS  InAnaName1, 
	I2.AnaName AS  InAnaName2, 
	I3.AnaName AS  InAnaName3, 
	I4.AnaName AS  InAnaName4, 
	I5.AnaName AS  InAnaName5, 
	ISNULL(D03.IsTemp,0) AS IsTemp,
	0 AS 	 KindVoucherID,
	(CASE WHEN  D17.TranMonth <10 then ''0''+rtrim(ltrim(str(D17.TranMonth)))+''/''+ltrim(Rtrim(str(D17.TranYear))) 
	Else rtrim(ltrim(str(D17.TranMonth)))+''/''+ltrim(Rtrim(str(D17.TranYear))) End) AS MonthYear,
	(''0''+ ltrim(rtrim(CASE WHEN D17.TranMonth %3 = 0 then D17.TranMonth/3  Else D17.TranMonth/3+1  End))+''/''+ltrim(Rtrim(str(D17.TranYear)))
	)  AS Quarter ,
	str(D17.TranYear) AS Year,D17.SourceNo,
	D17.ConvertedUnitID, D05.UnitName AS ConvertedUnitName
    ,NULL AS ProductID, NULL AS MOrderID, NULL AS ProductName,
    D02.Barcode,D16.Description AS VoucherDesc,
    D17.Parameter01, D17.Parameter02, D17.Parameter03, D17.Parameter04, D17.Parameter05,
	A01.AnaName AS Ana01Name, A02.AnaName AS Ana02Name, A03.AnaName AS Ana03Name, A04.AnaName AS Ana04Name, A05.AnaName AS Ana05Name,
	A06.AnaName AS Ana06Name, A07.AnaName AS Ana07Name, A08.AnaName AS Ana08Name, A09.AnaName AS Ana09Name,	A10.AnaName AS Ana10Name,
    D17.LimitDate, AT0114.RevoucherDate, -- 03/01/2014 My Tuyen add new
    NULL AS RDAddress'

SET @sSQL1 = N'
	FROM AT2017 AS D17  WITH (NOLOCK)
	INNER JOIN AT2016 AS D16 WITH (NOLOCK) ON D16.VoucherID = D17.VoucherID AND D16.DivisionID = D17.DivisionID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = D16.ObjectID 
	INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN ('''+@DivisionID+''',''@@@'') AND D02.InventoryID = D17.InventoryID
	INNER JOIN AT1304 AS D04 WITH (NOLOCK) ON D02.DivisionID IN ('''+@DivisionID+''',''@@@'') AND D04.UnitID = D02.UnitID 
	INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.WareHouseID = D16.WareHouseID
	LEFT JOIN AT1310 S1 WITH (NOLOCK) ON 	D02.DivisionID IN (S1.DivisionID,''@@@'') AND S1.STypeID = ''I01'' AND S1.S = D02.S1 
	LEFT JOIN AT1310 S2 WITH (NOLOCK) ON 	D02.DivisionID IN (S2.DivisionID,''@@@'') AND S2.STypeID = ''I02'' AND S2.S = D02.S2 
	LEFT JOIN AT1310 S3 WITH (NOLOCK) ON 	D02.DivisionID IN (S3.DivisionID,''@@@'') AND S3.STypeID = ''I03'' AND S3.S = D02.S3 
	LEFT JOIN AT1015 I1 WITH (NOLOCK) ON 	D02.DivisionID IN (I1.DivisionID,''@@@'') AND I1.AnaTypeID = ''I01'' AND I1.AnaID = D02.I01ID 
	LEFT JOIN AT1015 I2 WITH (NOLOCK) ON 	D02.DivisionID IN (I2.DivisionID,''@@@'') AND I2.AnaTypeID = ''I02'' AND I2.AnaID = D02.I02ID 
	LEFT JOIN AT1015 I3 WITH (NOLOCK) ON 	D02.DivisionID IN (I3.DivisionID,''@@@'') AND I3.AnaTypeID = ''I03'' AND I3.AnaID = D02.I03ID 
	LEFT JOIN AT1015 I4 WITH (NOLOCK) ON 	D02.DivisionID IN (I4.DivisionID,''@@@'') AND I4.AnaTypeID = ''I04'' AND I4.AnaID = D02.I04ID 
	LEFT JOIN AT1015 I5 WITH (NOLOCK) ON 	D02.DivisionID IN (I5.DivisionID,''@@@'') AND I5.AnaTypeID = ''I05'' AND I5.AnaID = D02.I05ID 
	LEFT JOIN AT1304 AS D05 WITH (NOLOCK) ON D05.UnitID = D17.ConvertedUnitID
	LEFT JOIN AT1011 A01 WITH (NOLOCK) ON A01.AnaTypeID = ''A01'' AND A01.AnaID = D17.Ana01ID
	LEFT JOIN AT1011 A02 WITH (NOLOCK) ON A02.AnaTypeID = ''A02'' AND A02.AnaID = D17.Ana02ID
	LEFT JOIN AT1011 A03 WITH (NOLOCK) ON A03.AnaTypeID = ''A03'' AND A03.AnaID = D17.Ana03ID
	LEFT JOIN AT1011 A04 WITH (NOLOCK) ON A04.AnaTypeID = ''A04'' AND A04.AnaID = D17.Ana04ID
	LEFT JOIN AT1011 A05 WITH (NOLOCK) ON A05.AnaTypeID = ''A05'' AND A05.AnaID = D17.Ana05ID
	LEFT JOIN AT1011 A06 WITH (NOLOCK) ON A06.AnaTypeID = ''A06'' AND A06.AnaID = D17.Ana06ID
	LEFT JOIN AT1011 A07 WITH (NOLOCK) ON A07.AnaTypeID = ''A07'' AND A07.AnaID = D17.Ana07ID
	LEFT JOIN AT1011 A08 WITH (NOLOCK) ON A08.AnaTypeID = ''A08'' AND A08.AnaID = D17.Ana08ID
	LEFT JOIN AT1011 A09 WITH (NOLOCK) ON A09.AnaTypeID = ''A09'' AND A09.AnaID = D17.Ana09ID
	LEFT JOIN AT1011 A10 WITH (NOLOCK) ON A10.AnaTypeID = ''A10'' AND A10.AnaID = D17.Ana10ID
	LEFT JOIN AT0114 WITH (NOLOCK) ON AT0114.Revoucherid=D17.VoucherID AND AT0114.ReTransactionID = D17.TransactionID AND D17.InventoryID = AT0114.InventoryID -- 03/01/2014 My Tuyen add new
	WHERE	ISNULL(DebitAccountID,'''') <>''''
			AND D17.DivisionID IN ('''+@DivisionID+''')
	'
SET @sSQL2 = N'
UNION ALL --- So du co hang ton kho

SELECT  D17.DivisionID, D17.TranMonth, D17.TranYear, D17.TransactionID,
	D16.WareHouseID, D17.InventoryID, D17.DebitAccountID, D17.CreditAccountID,
	''BC'' AS D_C,  --- So du Co
	'''' AS RefNo01, '''' AS RefNo02, 	D17.Notes,
	D16.VoucherID, D16.VoucherDate, D16.VoucherNo, 
	D16.ObjectID,AT1202.ObjectName, 	
	AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID,
	AT1202.Address,
	D02.InventoryName, D02.UnitID, D04.UnitName, D02.InventoryTypeID , D02.VATPercent,
	D03.WareHouseName,	
	ActualQuantity, 
	ConvertedAmount,
	-ActualQuantity AS SignQuantity, 
	-ConvertedAmount AS SignAmount,	
	D02.S1,	D02.S2, D02.S3 ,
	D02.S1 AS CI1ID, D02.S2 AS CI2ID, D02.S3 AS CI3ID, 
	D17.Ana01ID,D17.Ana02ID,D17.Ana03ID, D17.Ana04ID,D17.Ana05ID,
	D17.Ana06ID,D17.Ana07ID,D17.Ana08ID, D17.Ana09ID,D17.Ana10ID,
	D16.VoucherTypeID,
	S1.SName AS S1Name,
	S2.SName AS S2Name,

	S3.SName AS S3Name,
	D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, D02.Specification,
	D17.Notes01, D17.Notes02, D17.Notes03,
	D02.Varchar01,D02.Varchar02,D02.Varchar03,D02.Varchar04,D02.Varchar05,
	I1.AnaName AS  InAnaName1, 
	I2.AnaName AS  InAnaName2, 
	I3.AnaName AS  InAnaName3, 
	I4.AnaName AS  InAnaName4, 
	I5.AnaName AS  InAnaName5, 
	ISNULL(D03.IsTemp,0) AS IsTemp,
	0 AS KindVoucherID,
	(CASE WHEN  D17.TranMonth <10 then ''0''+rtrim(ltrim(str(D17.TranMonth)))+''/''+ltrim(Rtrim(str(D17.TranYear))) 
	Else rtrim(ltrim(str(D17.TranMonth)))+''/''+ltrim(Rtrim(str(D17.TranYear))) End) AS MonthYear,
	(''0''+ ltrim(rtrim(CASE WHEN D17.TranMonth %3 = 0 then D17.TranMonth/3  Else D17.TranMonth/3+1  End))+''/''+ltrim(Rtrim(str(D17.TranYear)))
	)  AS Quarter ,
	str(D17.TranYear) AS Year, D17.SourceNo,
	D17.ConvertedUnitID, D05.UnitName AS ConvertedUnitName
	,NULL AS ProductID, NULL AS MOrderID, NULL AS ProductName,
	D02.Barcode,D16.Description AS VoucherDesc,
    D17.Parameter01, D17.Parameter02, D17.Parameter03, D17.Parameter04, D17.Parameter05,
	A01.AnaName AS Ana01Name, A02.AnaName AS Ana02Name, A03.AnaName AS Ana03Name, A04.AnaName AS Ana04Name, A05.AnaName AS Ana05Name,
	A06.AnaName AS Ana06Name, A07.AnaName AS Ana07Name, A08.AnaName AS Ana08Name, A09.AnaName AS Ana09Name,	A10.AnaName AS Ana10Name,
    D17.LimitDate, AT0114.RevoucherDate,    -- 03/01/2014 My Tuyen add new
    NULL AS RDAddress'
    
SET @sSQL3 = N'	
	FROM AT2017 AS D17  WITH (NOLOCK)
	INNER JOIN AT2016 AS D16 WITH (NOLOCK) ON D16.VoucherID = D17.VoucherID AND D16.DivisionID = D17.DivisionID 
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = D16.ObjectID
	INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN ('''+@DivisionID+''',''@@@'') AND D02.InventoryID = D17.InventoryID
	INNER JOIN AT1304 AS D04 WITH (NOLOCK) ON D02.DivisionID IN ('''+@DivisionID+''',''@@@'') AND D04.UnitID = D02.UnitID
	INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.WareHouseID = D16.WareHouseID
	LEFT JOIN AT1310 S1 WITH (NOLOCK) ON 	D02.DivisionID IN (S1.DivisionID,''@@@'') AND S1.STypeID = ''I01'' AND S1.S = D02.S1
	LEFT JOIN AT1310 S2 WITH (NOLOCK) ON 	D02.DivisionID IN (S2.DivisionID,''@@@'') AND S2.STypeID = ''I02'' AND S2.S = D02.S2
	LEFT JOIN AT1310 S3 WITH (NOLOCK) ON 	D02.DivisionID IN (S3.DivisionID,''@@@'') AND S3.STypeID = ''I03'' AND S3.S = D02.S3
	LEFT JOIN AT1015 I1 WITH (NOLOCK) ON 	D02.DivisionID IN (I1.DivisionID,''@@@'') AND I1.AnaTypeID = ''I01'' AND I1.AnaID = D02.I01ID
	LEFT JOIN AT1015 I2 WITH (NOLOCK) ON 	D02.DivisionID IN (I2.DivisionID,''@@@'') AND I2.AnaTypeID = ''I02'' AND I2.AnaID = D02.I02ID
	LEFT JOIN AT1015 I3 WITH (NOLOCK) ON 	D02.DivisionID IN (I3.DivisionID,''@@@'') AND I3.AnaTypeID = ''I03'' AND I3.AnaID = D02.I03ID
	LEFT JOIN AT1015 I4 WITH (NOLOCK) ON 	D02.DivisionID IN (I4.DivisionID,''@@@'') AND I4.AnaTypeID = ''I04'' AND I4.AnaID = D02.I04ID
	LEFT JOIN AT1015 I5 WITH (NOLOCK) ON 	D02.DivisionID IN (I5.DivisionID,''@@@'') AND I5.AnaTypeID = ''I05'' AND I5.AnaID = D02.I05ID
	LEFT JOIN AT1304 AS D05 WITH (NOLOCK) ON D05.UnitID = D17.ConvertedUnitID
	LEFT JOIN AT1011 A01 WITH (NOLOCK) ON A01.AnaTypeID = ''A01'' AND A01.AnaID = D17.Ana01ID
	LEFT JOIN AT1011 A02 WITH (NOLOCK) ON A02.AnaTypeID = ''A02'' AND A02.AnaID = D17.Ana02ID
	LEFT JOIN AT1011 A03 WITH (NOLOCK) ON A03.AnaTypeID = ''A03'' AND A03.AnaID = D17.Ana03ID
	LEFT JOIN AT1011 A04 WITH (NOLOCK) ON A04.AnaTypeID = ''A04'' AND A04.AnaID = D17.Ana04ID
	LEFT JOIN AT1011 A05 WITH (NOLOCK) ON A05.AnaTypeID = ''A05'' AND A05.AnaID = D17.Ana05ID
	LEFT JOIN AT1011 A06 WITH (NOLOCK) ON A06.AnaTypeID = ''A06'' AND A06.AnaID = D17.Ana06ID
	LEFT JOIN AT1011 A07 WITH (NOLOCK) ON A07.AnaTypeID = ''A07'' AND A07.AnaID = D17.Ana07ID
	LEFT JOIN AT1011 A08 WITH (NOLOCK) ON A08.AnaTypeID = ''A08'' AND A08.AnaID = D17.Ana08ID
	LEFT JOIN AT1011 A09 WITH (NOLOCK) ON A09.AnaTypeID = ''A09'' AND A09.AnaID = D17.Ana09ID
	LEFT JOIN AT1011 A10 WITH (NOLOCK) ON A10.AnaTypeID = ''A10'' AND A10.AnaID = D17.Ana10ID
	LEFT JOIN AT0114 WITH (NOLOCK) ON AT0114.Revoucherid=D17.VoucherID AND AT0114.ReTransactionID = D17.TransactionID AND D17.InventoryID = AT0114.InventoryID  -- 03/01/2014 My Tuyen add new

	WHERE ISNULL(CreditAccountID,'''') <>''''
			AND D17.DivisionID IN ('''+@DivisionID+''')
	'
SET @sSQL4 = N'
UNION ALL  -- Nhap kho

SELECT  D07.DivisionID, D07.TranMonth, D07.TranYear, D07.TransactionID,
	D06.WareHouseID, 
	D07.InventoryID, D07.DebitAccountID, D07.CreditAccountID,
	''D'' AS D_C,  --- Phat sinh No
	RefNo01 AS RefNo01, RefNo02, 	D07.Notes,
	D06.VoucherID, D06.VoucherDate, D06.VoucherNo, 
	D06.ObjectID,AT1202.ObjectName,
	AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID,
	AT1202.Address,
	D02.InventoryName, D02.UnitID, D04.UnitName, D02.InventoryTypeID , D02.VATPercent,
	D03.WareHouseName,	
	ActualQuantity, 
	ConvertedAmount,
	ActualQuantity AS SignQuantity, 
	ConvertedAmount AS SignAmount,	
	D02.S1,	D02.S2, D02.S3, 
	D02.S1 AS CI1ID, D02.S2 AS CI2ID, D02.S3 AS CI3ID, 
	D07.Ana01ID,D07.Ana02ID,D07.Ana03ID, D07.Ana04ID,D07.Ana05ID,
	D07.Ana06ID,D07.Ana07ID,D07.Ana08ID, D07.Ana09ID,D07.Ana10ID,
	D06.VoucherTypeID,
	S1.SName AS S1Name,
	S2.SName AS S2Name,
	S3.SName AS S3Name,
	D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, D02.Specification,
	D07.Notes01, D07.Notes02, D07.Notes03,
	D02.Varchar01,D02.Varchar02,D02.Varchar03,D02.Varchar04,D02.Varchar05,
	I1.AnaName AS  InAnaName1, 
	I2.AnaName AS  InAnaName2, 
	I3.AnaName AS  InAnaName3, 
	I4.AnaName AS  InAnaName4, 
	I5.AnaName AS  InAnaName5,
	ISNULL(D03.IsTemp,0) AS IsTemp,
	CASE WHEN  KindVoucherID = 3 then 3 else 0 end AS KindVoucherID,
	(CASE WHEN  D07.TranMonth <10 then ''0''+rtrim(ltrim(str(D07.TranMonth)))+''/''+ltrim(Rtrim(str(D07.TranYear))) 
	Else rtrim(ltrim(str(D07.TranMonth)))+''/''+ltrim(Rtrim(str(D07.TranYear))) End) AS MonthYear,
	(''0''+ ltrim(rtrim(CASE WHEN D07.TranMonth %3 = 0 then D07.TranMonth/3  Else D07.TranMonth/3+1  End))+''/''+ltrim(Rtrim(str(D07.TranYear)))
	)  AS Quarter ,
	str(D07.TranYear) AS Year, D07.SourceNo,
	D07.ConvertedUnitID, D05.UnitName AS ConvertedUnitName
    ,D07.ProductID, D07.MOrderID, P02.InventoryName AS ProductName,
    D02.Barcode,D06.Description AS VoucherDesc,
    D07.Parameter01, D07.Parameter02, D07.Parameter03, D07.Parameter04, D07.Parameter05,
	A01.AnaName AS Ana01Name, A02.AnaName AS Ana02Name, A03.AnaName AS Ana03Name, A04.AnaName AS Ana04Name, A05.AnaName AS Ana05Name,
	A06.AnaName AS Ana06Name, A07.AnaName AS Ana07Name, A08.AnaName AS Ana08Name, A09.AnaName AS Ana09Name,	A10.AnaName AS Ana10Name,
    D07.LimitDate, AT0114.RevoucherDate,  -- 03/01/2014 My Tuyen add new  
    D06.RDAddress'
    
    SET  @sSQL5 = N'    
	FROM AT2007 AS D07  WITH (NOLOCK)
	INNER JOIN AT2006 D06 WITH (NOLOCK) ON D06.VoucherID = D07.VoucherID AND D06.DivisionID = D07.DivisionID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = D06.ObjectID
	INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN ('''+@DivisionID+''',''@@@'') AND D02.InventoryID = D07.InventoryID
	INNER JOIN AT1304 AS D04 WITH (NOLOCK) ON D02.DivisionID IN ('''+@DivisionID+''',''@@@'') AND D04.UnitID = D02.UnitID
	INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.WareHouseID = D06.WareHouseID
	LEFT JOIN AT1302 AS P02 WITH (NOLOCK) ON P02.InventoryID = D07.ProductID
	LEFT JOIN AT1310 S1 WITH (NOLOCK) ON 	D02.DivisionID IN (S1.DivisionID,''@@@'') AND S1.STypeID = ''I01'' AND S1.S = D02.S1  
	LEFT JOIN AT1310 S2 WITH (NOLOCK) ON 	D02.DivisionID IN (S2.DivisionID,''@@@'') AND S2.STypeID = ''I02'' AND S2.S = D02.S2  
	LEFT JOIN AT1310 S3 WITH (NOLOCK) ON 	D02.DivisionID IN (S3.DivisionID,''@@@'') AND S3.STypeID = ''I03'' AND S3.S = D02.S3  
	LEFT JOIN AT1015 I1 WITH (NOLOCK) ON 	D02.DivisionID IN (I1.DivisionID,''@@@'') AND I1.AnaTypeID = ''I01'' AND I1.AnaID = D02.I01ID 
	LEFT JOIN AT1015 I2 WITH (NOLOCK) ON 	D02.DivisionID IN (I2.DivisionID,''@@@'') AND I2.AnaTypeID = ''I02'' AND I2.AnaID = D02.I02ID 
	LEFT JOIN AT1015 I3 WITH (NOLOCK) ON 	D02.DivisionID IN (I3.DivisionID,''@@@'') AND I3.AnaTypeID = ''I03'' AND I3.AnaID = D02.I03ID 
	LEFT JOIN AT1015 I4 WITH (NOLOCK) ON 	D02.DivisionID IN (I4.DivisionID,''@@@'') AND I4.AnaTypeID = ''I04'' AND I4.AnaID = D02.I04ID 
	LEFT JOIN AT1015 I5 WITH (NOLOCK) ON 	D02.DivisionID IN (I5.DivisionID,''@@@'') AND I5.AnaTypeID = ''I05'' AND I5.AnaID = D02.I05ID 
	LEFT JOIN AT1304 AS D05 WITH (NOLOCK) ON D05.UnitID = D07.ConvertedUnitID
	LEFT JOIN AT1011 A01 WITH (NOLOCK) ON A01.AnaTypeID = ''A01'' AND A01.AnaID = D07.Ana01ID
	LEFT JOIN AT1011 A02 WITH (NOLOCK) ON A02.AnaTypeID = ''A02'' AND A02.AnaID = D07.Ana02ID
	LEFT JOIN AT1011 A03 WITH (NOLOCK) ON A03.AnaTypeID = ''A03'' AND A03.AnaID = D07.Ana03ID
	LEFT JOIN AT1011 A04 WITH (NOLOCK) ON A04.AnaTypeID = ''A04'' AND A04.AnaID = D07.Ana04ID
	LEFT JOIN AT1011 A05 WITH (NOLOCK) ON A05.AnaTypeID = ''A05'' AND A05.AnaID = D07.Ana05ID
	LEFT JOIN AT1011 A06 WITH (NOLOCK) ON A06.AnaTypeID = ''A06'' AND A06.AnaID = D07.Ana06ID
	LEFT JOIN AT1011 A07 WITH (NOLOCK) ON A07.AnaTypeID = ''A07'' AND A07.AnaID = D07.Ana07ID
	LEFT JOIN AT1011 A08 WITH (NOLOCK) ON A08.AnaTypeID = ''A08'' AND A08.AnaID = D07.Ana08ID
	LEFT JOIN AT1011 A09 WITH (NOLOCK) ON A09.AnaTypeID = ''A09'' AND A09.AnaID = D07.Ana09ID
	LEFT JOIN AT1011 A10 WITH (NOLOCK) ON A10.AnaTypeID = ''A10'' AND A10.AnaID = D07.Ana10ID
	LEFT JOIN AT0114 WITH (NOLOCK) ON D07.RevoucherID=AT0114.RevoucherID AND AT0114.ReTransactionID = D07.ReTransactionID AND D07.InventoryID = AT0114.InventoryID     -- 03/01/2014 My Tuyen add new

	WHERE D06.KindVoucherID in (1,3,5,7,9,15,17)
			AND D07.DivisionID IN ('''+@DivisionID+''')
	'
SET @sSQL6 = N'
UNION ALL  -- XUAT KHO

SELECT  D07.DivisionID, D07.TranMonth, D07.TranYear, D07.TransactionID,
	CASE WHEN D06.KindVoucherID = 3 THEN D06.WareHouseID2 ELSE  D06.WareHouseID END AS WareHouseID, 
	D07.InventoryID, D07.DebitAccountID, D07.CreditAccountID,
	''C'' AS D_C,  --- So du Co
	RefNo01 AS RefNo01, RefNo02, 	D07.Notes,
	D06.VoucherID, D06.VoucherDate, D06.VoucherNo, 
	D06.ObjectID,AT1202.ObjectName, 	
	AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID,
	AT1202.Address,
	D02.InventoryName, D02.UnitID, D04.UnitName, D02.InventoryTypeID , D02.VATPercent,

	CASE WHEN D06.KindVoucherID = 3 then D031.WareHouseName Else  D03.WareHouseName End  AS WareHouseName,	

	ActualQuantity, 
	ConvertedAmount,
	-ActualQuantity AS SignQuantity, 
	-ConvertedAmount AS SignAmount,	
	D02.S1,	D02.S2, D02.S3, 
	D02.S1 AS CI1ID, D02.S2 AS CI2ID, D02.S3 AS CI3ID, 
	D07.Ana01ID,D07.Ana02ID,D07.Ana03ID, D07.Ana04ID,D07.Ana05ID,
	D07.Ana06ID,D07.Ana07ID,D07.Ana08ID, D07.Ana09ID,D07.Ana10ID,
	D06.VoucherTypeID,
	S1.SName AS S1Name,
	S2.SName AS S2Name,
	S3.SName AS S3Name,
	D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, D02.Specification,
	D07.Notes01, D07.Notes02, D07.Notes03,
	D02.Varchar01,D02.Varchar02,D02.Varchar03,D02.Varchar04,D02.Varchar05,
	I1.AnaName AS  InAnaName1, 
	I2.AnaName AS  InAnaName2, 
	I3.AnaName AS  InAnaName3, 
	I4.AnaName AS  InAnaName4, 
	I5.AnaName AS  InAnaName5, 
	ISNULL(D03.IsTemp,0) AS IsTemp,
	CASE WHEN  KindVoucherID = 3 then 3 else 0 end AS KindVoucherID,
	(CASE WHEN  D07.TranMonth <10 then ''0''+rtrim(ltrim(str(D07.TranMonth)))+''/''+ltrim(Rtrim(str(D07.TranYear))) 
	Else rtrim(ltrim(str(D07.TranMonth)))+''/''+ltrim(Rtrim(str(D07.TranYear))) End) AS MonthYear,
	(''0''+ ltrim(rtrim(CASE WHEN D07.TranMonth %3 = 0 then D07.TranMonth/3  Else D07.TranMonth/3+1  End))+''/''+ltrim(Rtrim(str(D07.TranYear)))
	)  AS Quarter ,
	str(D07.TranYear) AS Year, D07.SourceNo,
	D07.ConvertedUnitID, D05.UnitName AS ConvertedUnitName
	,D07.ProductID, D07.MOrderID, P02.InventoryName AS ProductName,
	D02.Barcode,D06.Description AS VoucherDesc,
	D07.Parameter01, D07.Parameter02, D07.Parameter03, D07.Parameter04, D07.Parameter05,
	A01.AnaName AS Ana01Name, A02.AnaName AS Ana02Name, A03.AnaName AS Ana03Name, A04.AnaName AS Ana04Name, A05.AnaName AS Ana05Name,
	A06.AnaName AS Ana06Name, A07.AnaName AS Ana07Name, A08.AnaName AS Ana08Name, A09.AnaName AS Ana09Name,	A10.AnaName AS Ana10Name,
    D07.LimitDate, AT0114.ReVoucherDate,   -- 03/01/2014 My Tuyen add new 
    D06.RDAddress'
     
    SET @sSQL7 = N'	
	FROM AT2007 AS D07 WITH (NOLOCK)
	INNER JOIN AT2006 D06 WITH (NOLOCK) ON D06.VoucherID = D07.VoucherID AND D06.DivisionID = D07.DivisionID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = D06.ObjectID 
	INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN ('''+@DivisionID+''',''@@@'') AND D02.InventoryID = D07.InventoryID
	INNER JOIN AT1304 AS D04 WITH (NOLOCK) ON D02.DivisionID IN ('''+@DivisionID+''',''@@@'') AND D04.UnitID = D02.UnitID
	INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.WareHouseID = D06.WareHouseID
	LEFT JOIN AT1302 AS P02 WITH (NOLOCK) ON P02.InventoryID = D07.ProductID
	LEFT JOIN AT1303 AS  D031 WITH (NOLOCK) ON D031.WareHouseID = D06.WareHouseID2
	LEFT JOIN AT1310 S1 WITH (NOLOCK) ON D02.DivisionID IN (S1.DivisionID,''@@@'') AND S1.STypeID = ''I01'' AND S1.S = D02.S1 
	LEFT JOIN AT1310 S2 WITH (NOLOCK) ON D02.DivisionID IN (S2.DivisionID,''@@@'') AND S2.STypeID = ''I02'' AND S2.S = D02.S2 
	LEFT JOIN AT1310 S3 WITH (NOLOCK) ON D02.DivisionID IN (S3.DivisionID,''@@@'') AND S3.STypeID = ''I03'' AND S3.S = D02.S3 
	LEFT JOIN AT1015 I1 WITH (NOLOCK) ON D02.DivisionID IN (I1.DivisionID,''@@@'') AND I1.AnaTypeID = ''I01'' AND I1.AnaID = D02.I01ID
	LEFT JOIN AT1015 I2 WITH (NOLOCK) ON D02.DivisionID IN (I2.DivisionID,''@@@'') AND I2.AnaTypeID = ''I02'' AND I2.AnaID = D02.I02ID
	LEFT JOIN AT1015 I3 WITH (NOLOCK) ON D02.DivisionID IN (I3.DivisionID,''@@@'') AND I3.AnaTypeID = ''I03'' AND I3.AnaID = D02.I03ID
	LEFT JOIN AT1015 I4 WITH (NOLOCK) ON D02.DivisionID IN (I4.DivisionID,''@@@'') AND I4.AnaTypeID = ''I04'' AND I4.AnaID = D02.I04ID
	LEFT JOIN AT1015 I5 WITH (NOLOCK) ON D02.DivisionID IN (I5.DivisionID,''@@@'') AND I5.AnaTypeID = ''I05'' AND I5.AnaID = D02.I05ID
	LEFT JOIN AT1304 AS D05 WITH (NOLOCK) ON D05.UnitID = D07.ConvertedUnitID
	LEFT JOIN AT1011 A01 WITH (NOLOCK) ON A01.AnaTypeID = ''A01'' AND A01.AnaID = D07.Ana01ID
	LEFT JOIN AT1011 A02 WITH (NOLOCK) ON A02.AnaTypeID = ''A02'' AND A02.AnaID = D07.Ana02ID
	LEFT JOIN AT1011 A03 WITH (NOLOCK) ON A03.AnaTypeID = ''A03'' AND A03.AnaID = D07.Ana03ID
	LEFT JOIN AT1011 A04 WITH (NOLOCK) ON A04.AnaTypeID = ''A04'' AND A04.AnaID = D07.Ana04ID
	LEFT JOIN AT1011 A05 WITH (NOLOCK) ON A05.AnaTypeID = ''A05'' AND A05.AnaID = D07.Ana05ID
	LEFT JOIN AT1011 A06 WITH (NOLOCK) ON A06.AnaTypeID = ''A06'' AND A06.AnaID = D07.Ana06ID
	LEFT JOIN AT1011 A07 WITH (NOLOCK) ON A07.AnaTypeID = ''A07'' AND A07.AnaID = D07.Ana07ID
	LEFT JOIN AT1011 A08 WITH (NOLOCK) ON A08.AnaTypeID = ''A08'' AND A08.AnaID = D07.Ana08ID
	LEFT JOIN AT1011 A09 WITH (NOLOCK) ON A09.AnaTypeID = ''A09'' AND A09.AnaID = D07.Ana09ID
	LEFT JOIN AT1011 A10 WITH (NOLOCK) ON A10.AnaTypeID = ''A10'' AND A10.AnaID = D07.Ana10ID
	LEFT JOIN AT0114 WITH (NOLOCK) ON D07.RevoucherID=AT0114.RevoucherID AND AT0114.ReTransactionID = D07.ReTransactionID AND D07.InventoryID = AT0114.InventoryID  -- 03/01/2014 My Tuyen add new

	WHERE D06.KindVoucherID in (2,3,4,6,8,10,14,20)
			AND D07.DivisionID IN ('''+@DivisionID+''')
'
--PRINT(@sSQL1)
--PRINT(@sSQL2)
--PRINT(@sSQL3)
--PRINT(@sSQL4)
--PRINT(@sWhere1)
--PRINT(@sWhere2)
--PRINT(@sWhere3)
--PRINT(@sWhere4)
IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN
	SET @sSQL1 = N', WT8899.S01ID, WT8899.S02ID, WT8899.S03ID, WT8899.S04ID, WT8899.S05ID, WT8899.S06ID, WT8899.S07ID, WT8899.S08ID, WT8899.S09ID, WT8899.S10ID,
	WT8899.S11ID, WT8899.S12ID, WT8899.S13ID, WT8899.S14ID, WT8899.S15ID, WT8899.S16ID, WT8899.S17ID, WT8899.S18ID, WT8899.S19ID, WT8899.S20ID
	FROM AT2017 AS D17 WITH (NOLOCK) 
	INNER JOIN AT2016 AS D16 WITH (NOLOCK) ON D16.VoucherID = D17.VoucherID AND D16.DivisionID = D17.DivisionID
	LEFT JOIN WT8899 WITH (NOLOCK) ON WT8899.DivisionID = D17.DivisionID AND WT8899.VoucherID = D17.VoucherID AND WT8899.TransactionID = D17.TransactionID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = D16.ObjectID
	INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D17.DivisionID,''@@@'') AND D02.InventoryID = D17.InventoryID
	INNER JOIN AT1304 AS D04 WITH (NOLOCK) ON D02.DivisionID IN (D04.DivisionID,''@@@'') AND D04.UnitID = D02.UnitID
	INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.WareHouseID = D16.WareHouseID
	LEFT JOIN AT1310 S1 WITH (NOLOCK) ON 	D02.DivisionID IN (S1.DivisionID,''@@@'') AND S1.STypeID = ''I01'' AND S1.S = D02.S1
	LEFT JOIN AT1310 S2 WITH (NOLOCK) ON 	D02.DivisionID IN (S2.DivisionID,''@@@'') AND S2.STypeID = ''I02'' AND S2.S = D02.S2
	LEFT JOIN AT1310 S3 WITH (NOLOCK) ON 	D02.DivisionID IN (S3.DivisionID,''@@@'') AND S3.STypeID = ''I03'' AND S3.S = D02.S3
	LEFT JOIN AT1015 I1 WITH (NOLOCK) ON 	D02.DivisionID IN (I1.DivisionID,''@@@'') AND I1.AnaTypeID = ''I01'' AND I1.AnaID = D02.I01ID
	LEFT JOIN AT1015 I2 WITH (NOLOCK) ON 	D02.DivisionID IN (I2.DivisionID,''@@@'') AND I2.AnaTypeID = ''I02'' AND I2.AnaID = D02.I02ID
	LEFT JOIN AT1015 I3 WITH (NOLOCK) ON 	D02.DivisionID IN (I3.DivisionID,''@@@'') AND I3.AnaTypeID = ''I03'' AND I3.AnaID = D02.I03ID
	LEFT JOIN AT1015 I4 WITH (NOLOCK) ON 	D02.DivisionID IN (I4.DivisionID,''@@@'') AND I4.AnaTypeID = ''I04'' AND I4.AnaID = D02.I04ID
	LEFT JOIN AT1015 I5 WITH (NOLOCK) ON 	D02.DivisionID IN (I5.DivisionID,''@@@'') AND I5.AnaTypeID = ''I05'' AND I5.AnaID = D02.I05ID
	LEFT JOIN AT1304 AS D05 WITH (NOLOCK) ON D05.UnitID = D17.ConvertedUnitID
	LEFT JOIN AT1011 A01 WITH (NOLOCK) ON A01.AnaTypeID = ''A01'' AND A01.AnaID = D17.Ana01ID
	LEFT JOIN AT1011 A02 WITH (NOLOCK) ON A02.AnaTypeID = ''A02'' AND A02.AnaID = D17.Ana02ID
	LEFT JOIN AT1011 A03 WITH (NOLOCK) ON A03.AnaTypeID = ''A03'' AND A03.AnaID = D17.Ana03ID
	LEFT JOIN AT1011 A04 WITH (NOLOCK) ON A04.AnaTypeID = ''A04'' AND A04.AnaID = D17.Ana04ID
	LEFT JOIN AT1011 A05 WITH (NOLOCK) ON A05.AnaTypeID = ''A05'' AND A05.AnaID = D17.Ana05ID
	LEFT JOIN AT1011 A06 WITH (NOLOCK) ON A06.AnaTypeID = ''A06'' AND A06.AnaID = D17.Ana06ID
	LEFT JOIN AT1011 A07 WITH (NOLOCK) ON A07.AnaTypeID = ''A07'' AND A07.AnaID = D17.Ana07ID
	LEFT JOIN AT1011 A08 WITH (NOLOCK) ON A08.AnaTypeID = ''A08'' AND A08.AnaID = D17.Ana08ID
	LEFT JOIN AT1011 A09 WITH (NOLOCK) ON A09.AnaTypeID = ''A09'' AND A09.AnaID = D17.Ana09ID
	LEFT JOIN AT1011 A10 WITH (NOLOCK) ON A10.AnaTypeID = ''A10'' AND A10.AnaID = D17.Ana10ID
	LEFT JOIN AT0114 WITH (NOLOCK) ON AT0114.Revoucherid=D17.VoucherID AND AT0114.ReTransactionID = D17.TransactionID AND D17.InventoryID = AT0114.InventoryID -- 03/01/2014 My Tuyen add new
	WHERE	ISNULL(DebitAccountID,'''') <>''''
			AND D17.DivisionID LIKE '''+@DivisionID+''''
	SET @sSQL3 = N', WT8899.S01ID, WT8899.S02ID, WT8899.S03ID, WT8899.S04ID, WT8899.S05ID, WT8899.S06ID, WT8899.S07ID, WT8899.S08ID, WT8899.S09ID, WT8899.S10ID,
	WT8899.S11ID, WT8899.S12ID, WT8899.S13ID, WT8899.S14ID, WT8899.S15ID, WT8899.S16ID, WT8899.S17ID, WT8899.S18ID, WT8899.S19ID, WT8899.S20ID
	FROM AT2017 AS D17  WITH (NOLOCK)
	INNER JOIN AT2016 AS D16 WITH (NOLOCK) ON D16.VoucherID = D17.VoucherID AND D16.DivisionID = D17.DivisionID
	LEFT JOIN WT8899 WITH (NOLOCK) ON WT8899.DivisionID = D17.DivisionID AND WT8899.VoucherID = D17.VoucherID AND WT8899.TransactionID = D17.TransactionID 
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = D16.ObjectID
	INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN ('''+@DivisionID+''',''@@@'') AND D02.InventoryID = D17.InventoryID
	INNER JOIN AT1304 AS D04 WITH (NOLOCK) ON D02.DivisionID IN ('''+@DivisionID+''',''@@@'') AND D04.UnitID = D02.UnitID
	INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.WareHouseID = D16.WareHouseID
	LEFT JOIN AT1310 S1 WITH (NOLOCK) ON 	D02.DivisionID IN (S1.DivisionID,''@@@'') AND S1.STypeID = ''I01'' AND S1.S = D02.S1
	LEFT JOIN AT1310 S2 WITH (NOLOCK) ON 	D02.DivisionID IN (S2.DivisionID,''@@@'') AND S2.STypeID = ''I02'' AND S2.S = D02.S2
	LEFT JOIN AT1310 S3 WITH (NOLOCK) ON 	D02.DivisionID IN (S3.DivisionID,''@@@'') AND S3.STypeID = ''I03'' AND S3.S = D02.S3
	LEFT JOIN AT1015 I1 WITH (NOLOCK) ON 	D02.DivisionID IN (I1.DivisionID,''@@@'') AND I1.AnaTypeID = ''I01'' AND I1.AnaID = D02.I01ID
	LEFT JOIN AT1015 I2 WITH (NOLOCK) ON 	D02.DivisionID IN (I2.DivisionID,''@@@'') AND I2.AnaTypeID = ''I02'' AND I2.AnaID = D02.I02ID
	LEFT JOIN AT1015 I3 WITH (NOLOCK) ON 	D02.DivisionID IN (I3.DivisionID,''@@@'') AND I3.AnaTypeID = ''I03'' AND I3.AnaID = D02.I03ID
	LEFT JOIN AT1015 I4 WITH (NOLOCK) ON 	D02.DivisionID IN (I4.DivisionID,''@@@'') AND I4.AnaTypeID = ''I04'' AND I4.AnaID = D02.I04ID
	LEFT JOIN AT1015 I5 WITH (NOLOCK) ON 	D02.DivisionID IN (I5.DivisionID,''@@@'') AND I5.AnaTypeID = ''I05'' AND I5.AnaID = D02.I05ID
	LEFT JOIN AT1304 AS D05 WITH (NOLOCK) ON D05.UnitID = D17.ConvertedUnitID
	LEFT JOIN AT1011 A01 WITH (NOLOCK) ON A01.AnaTypeID = ''A01'' AND A01.AnaID = D17.Ana01ID
	LEFT JOIN AT1011 A02 WITH (NOLOCK) ON A02.AnaTypeID = ''A02'' AND A02.AnaID = D17.Ana02ID
	LEFT JOIN AT1011 A03 WITH (NOLOCK) ON A03.AnaTypeID = ''A03'' AND A03.AnaID = D17.Ana03ID
	LEFT JOIN AT1011 A04 WITH (NOLOCK) ON A04.AnaTypeID = ''A04'' AND A04.AnaID = D17.Ana04ID
	LEFT JOIN AT1011 A05 WITH (NOLOCK) ON A05.AnaTypeID = ''A05'' AND A05.AnaID = D17.Ana05ID
	LEFT JOIN AT1011 A06 WITH (NOLOCK) ON A06.AnaTypeID = ''A06'' AND A06.AnaID = D17.Ana06ID
	LEFT JOIN AT1011 A07 WITH (NOLOCK) ON A07.AnaTypeID = ''A07'' AND A07.AnaID = D17.Ana07ID
	LEFT JOIN AT1011 A08 WITH (NOLOCK) ON A08.AnaTypeID = ''A08'' AND A08.AnaID = D17.Ana08ID
	LEFT JOIN AT1011 A09 WITH (NOLOCK) ON A09.AnaTypeID = ''A09'' AND A09.AnaID = D17.Ana09ID
	LEFT JOIN AT1011 A10 WITH (NOLOCK) ON A10.AnaTypeID = ''A10'' AND A10.AnaID = D17.Ana10ID
	LEFT JOIN AT0114 WITH (NOLOCK) ON AT0114.Revoucherid=D17.VoucherID AND AT0114.ReTransactionID = D17.TransactionID AND D17.InventoryID = AT0114.InventoryID  -- 03/01/2014 My Tuyen add new
	WHERE ISNULL(CreditAccountID,'''') <>''''
			AND D17.DivisionID IN ('''+@DivisionID+''')'
	SET @sSQL5 = N', WT8899.S01ID, WT8899.S02ID, WT8899.S03ID, WT8899.S04ID, WT8899.S05ID, WT8899.S06ID, WT8899.S07ID, WT8899.S08ID, WT8899.S09ID, WT8899.S10ID,
	WT8899.S11ID, WT8899.S12ID, WT8899.S13ID, WT8899.S14ID, WT8899.S15ID, WT8899.S16ID, WT8899.S17ID, WT8899.S18ID, WT8899.S19ID, WT8899.S20ID
	FROM AT2007 AS D07  WITH (NOLOCK)
	INNER JOIN AT2006 D06 WITH (NOLOCK) ON D06.VoucherID = D07.VoucherID AND D06.DivisionID = D07.DivisionID
	LEFT JOIN WT8899 WITH (NOLOCK) ON WT8899.DivisionID = D07.DivisionID AND WT8899.VoucherID = D07.VoucherID AND WT8899.TransactionID = D07.TransactionID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = D06.ObjectID
	INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN ('''+@DivisionID+''',''@@@'') AND D02.InventoryID = D07.InventoryID
	INNER JOIN AT1304 AS D04 WITH (NOLOCK) ON D02.DivisionID IN ('''+@DivisionID+''',''@@@'') AND D04.UnitID = D02.UnitID
	INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.WareHouseID = D06.WareHouseID
	LEFT JOIN AT1302 AS P02 WITH (NOLOCK) ON P02.InventoryID = D07.ProductID
	LEFT JOIN AT1310 S1 WITH (NOLOCK) ON 	D02.DivisionID IN (S1.DivisionID,''@@@'') AND S1.STypeID = ''I01'' AND S1.S = D02.S1
	LEFT JOIN AT1310 S2 WITH (NOLOCK) ON 	D02.DivisionID IN (S2.DivisionID,''@@@'') AND S2.STypeID = ''I02'' AND S2.S = D02.S2
	LEFT JOIN AT1310 S3 WITH (NOLOCK) ON 	D02.DivisionID IN (S3.DivisionID,''@@@'') AND S3.STypeID = ''I03'' AND S3.S = D02.S3
	LEFT JOIN AT1015 I1 WITH (NOLOCK) ON 	D02.DivisionID IN (I1.DivisionID,''@@@'') AND I1.AnaTypeID = ''I01'' AND I1.AnaID = D02.I01ID
	LEFT JOIN AT1015 I2 WITH (NOLOCK) ON 	D02.DivisionID IN (I2.DivisionID,''@@@'') AND I2.AnaTypeID = ''I02'' AND I2.AnaID = D02.I02ID
	LEFT JOIN AT1015 I3 WITH (NOLOCK) ON 	D02.DivisionID IN (I3.DivisionID,''@@@'') AND I3.AnaTypeID = ''I03'' AND I3.AnaID = D02.I03ID
	LEFT JOIN AT1015 I4 WITH (NOLOCK) ON 	D02.DivisionID IN (I4.DivisionID,''@@@'') AND I4.AnaTypeID = ''I04'' AND I4.AnaID = D02.I04ID
	LEFT JOIN AT1015 I5 WITH (NOLOCK) ON 	D02.DivisionID IN (I5.DivisionID,''@@@'') AND I5.AnaTypeID = ''I05'' AND I5.AnaID = D02.I05ID
	LEFT JOIN AT1304 AS D05 WITH (NOLOCK) ON D05.UnitID = D07.ConvertedUnitID
	LEFT JOIN AT1011 A01 WITH (NOLOCK) ON A01.AnaTypeID = ''A01'' AND A01.AnaID = D07.Ana01ID
	LEFT JOIN AT1011 A02 WITH (NOLOCK) ON A02.AnaTypeID = ''A02'' AND A02.AnaID = D07.Ana02ID
	LEFT JOIN AT1011 A03 WITH (NOLOCK) ON A03.AnaTypeID = ''A03'' AND A03.AnaID = D07.Ana03ID
	LEFT JOIN AT1011 A04 WITH (NOLOCK) ON A04.AnaTypeID = ''A04'' AND A04.AnaID = D07.Ana04ID
	LEFT JOIN AT1011 A05 WITH (NOLOCK) ON A05.AnaTypeID = ''A05'' AND A05.AnaID = D07.Ana05ID
	LEFT JOIN AT1011 A06 WITH (NOLOCK) ON A06.AnaTypeID = ''A06'' AND A06.AnaID = D07.Ana06ID
	LEFT JOIN AT1011 A07 WITH (NOLOCK) ON A07.AnaTypeID = ''A07'' AND A07.AnaID = D07.Ana07ID
	LEFT JOIN AT1011 A08 WITH (NOLOCK) ON A08.AnaTypeID = ''A08'' AND A08.AnaID = D07.Ana08ID
	LEFT JOIN AT1011 A09 WITH (NOLOCK) ON A09.AnaTypeID = ''A09'' AND A09.AnaID = D07.Ana09ID
	LEFT JOIN AT1011 A10 WITH (NOLOCK) ON A10.AnaTypeID = ''A10'' AND A10.AnaID = D07.Ana10ID
	LEFT JOIN AT0114 WITH (NOLOCK) ON D07.RevoucherID=AT0114.RevoucherID AND AT0114.ReTransactionID = D07.ReTransactionID AND D07.InventoryID = AT0114.InventoryID    -- 03/01/2014 My Tuyen add new

	WHERE D06.KindVoucherID in (1,3,5,7,9,15,17)
			AND D07.DivisionID IN ('''+@DivisionID+''')'
	SET @sSQL7 = N', WT8899.S01ID, WT8899.S02ID, WT8899.S03ID, WT8899.S04ID, WT8899.S05ID, WT8899.S06ID, WT8899.S07ID, WT8899.S08ID, WT8899.S09ID, WT8899.S10ID,
	WT8899.S11ID, WT8899.S12ID, WT8899.S13ID, WT8899.S14ID, WT8899.S15ID, WT8899.S16ID, WT8899.S17ID, WT8899.S18ID, WT8899.S19ID, WT8899.S20ID
	FROM AT2007 AS D07 WITH (NOLOCK) 
	INNER JOIN AT2006 D06 WITH (NOLOCK) ON D06.VoucherID = D07.VoucherID AND D06.DivisionID = D07.DivisionID
	LEFT JOIN WT8899 WITH (NOLOCK) ON WT8899.DivisionID = D07.DivisionID AND WT8899.VoucherID = D07.VoucherID AND WT8899.TransactionID = D07.TransactionID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = D06.ObjectID
	INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN ('''+@DivisionID+''',''@@@'') AND D02.InventoryID = D07.InventoryID
	INNER JOIN AT1304 AS D04 WITH (NOLOCK) ON D02.DivisionID IN ('''+@DivisionID+''',''@@@'') AND D04.UnitID = D02.UnitID
	INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.WareHouseID = D06.WareHouseID
	LEFT JOIN AT1302 AS P02 WITH (NOLOCK) ON P02.InventoryID = D07.ProductID
	LEFT JOIN AT1303 AS  D031 WITH (NOLOCK) ON D031.WareHouseID = D06.WareHouseID2	
	LEFT JOIN AT1310 S1 WITH (NOLOCK) ON 	D02.DivisionID IN (S1.DivisionID,''@@@'') AND S1.STypeID = ''I01'' AND S1.S = D02.S1
	LEFT JOIN AT1310 S2 WITH (NOLOCK) ON 	D02.DivisionID IN (S2.DivisionID,''@@@'') AND S2.STypeID = ''I02'' AND S2.S = D02.S2
	LEFT JOIN AT1310 S3 WITH (NOLOCK) ON 	D02.DivisionID IN (S3.DivisionID,''@@@'') AND S3.STypeID = ''I03'' AND S3.S = D02.S3
	LEFT JOIN AT1015 I1 WITH (NOLOCK) ON 	D02.DivisionID IN (I1.DivisionID,''@@@'') AND I1.AnaTypeID = ''I01'' AND I1.AnaID = D02.I01ID
	LEFT JOIN AT1015 I2 WITH (NOLOCK) ON 	D02.DivisionID IN (I2.DivisionID,''@@@'') AND I2.AnaTypeID = ''I02'' AND I2.AnaID = D02.I02ID
	LEFT JOIN AT1015 I3 WITH (NOLOCK) ON 	D02.DivisionID IN (I3.DivisionID,''@@@'') AND I3.AnaTypeID = ''I03'' AND I3.AnaID = D02.I03ID
	LEFT JOIN AT1015 I4 WITH (NOLOCK) ON 	D02.DivisionID IN (I4.DivisionID,''@@@'') AND I4.AnaTypeID = ''I04'' AND I4.AnaID = D02.I04ID
	LEFT JOIN AT1015 I5 WITH (NOLOCK) ON 	D02.DivisionID IN (I5.DivisionID,''@@@'') AND I5.AnaTypeID = ''I05'' AND I5.AnaID = D02.I05ID
	LEFT JOIN AT1304 AS D05 WITH (NOLOCK) ON D05.UnitID = D07.ConvertedUnitID
	LEFT JOIN AT1011 A01 WITH (NOLOCK) ON A01.AnaTypeID = ''A01'' AND A01.AnaID = D07.Ana01ID
	LEFT JOIN AT1011 A02 WITH (NOLOCK) ON A02.AnaTypeID = ''A02'' AND A02.AnaID = D07.Ana02ID
	LEFT JOIN AT1011 A03 WITH (NOLOCK) ON A03.AnaTypeID = ''A03'' AND A03.AnaID = D07.Ana03ID
	LEFT JOIN AT1011 A04 WITH (NOLOCK) ON A04.AnaTypeID = ''A04'' AND A04.AnaID = D07.Ana04ID
	LEFT JOIN AT1011 A05 WITH (NOLOCK) ON A05.AnaTypeID = ''A05'' AND A05.AnaID = D07.Ana05ID
	LEFT JOIN AT1011 A06 WITH (NOLOCK) ON A06.AnaTypeID = ''A06'' AND A06.AnaID = D07.Ana06ID
	LEFT JOIN AT1011 A07 WITH (NOLOCK) ON A07.AnaTypeID = ''A07'' AND A07.AnaID = D07.Ana07ID
	LEFT JOIN AT1011 A08 WITH (NOLOCK) ON A08.AnaTypeID = ''A08'' AND A08.AnaID = D07.Ana08ID
	LEFT JOIN AT1011 A09 WITH (NOLOCK) ON A09.AnaTypeID = ''A09'' AND A09.AnaID = D07.Ana09ID
	LEFT JOIN AT1011 A10 WITH (NOLOCK) ON A10.AnaTypeID = ''A10'' AND A10.AnaID = D07.Ana10ID
	LEFT JOIN AT0114 WITH (NOLOCK) ON D07.RevoucherID=AT0114.RevoucherID AND AT0114.ReTransactionID = D07.ReTransactionID AND D07.InventoryID = AT0114.InventoryID  -- 03/01/2014 My Tuyen add new

	WHERE D06.KindVoucherID in (2,3,4,6,8,10,14,20)
			AND D07.DivisionID IN ('''+@DivisionID+''')'
END


--PRINT @sSQL
--PRINT @sSQL1
--PRINT @sWhere1
--PRINT @sSQL2
--PRINT @sSQL3
--PRINT @sWhere2
--PRINT @sSQL4
--PRINT @sSQL5
--PRINT @sWhere3
--PRINT @sSQL6
--PRINT @sSQL7
--PRINT @sWhere4

IF NOT EXISTS (SELECT 1 FROM  SYSOBJECTS WITH (NOLOCK) WHERE Xtype ='V' and Name ='AV7008')
	EXEC(' CREATE VIEW AV7008

 -- Tạo bởi WMP30031 Cách lấy dữ liệu giống AV7000
	        AS '+@sSQL+@sSQL1+@sWhere1+@sSQL2+@sSQL3+@sWhere2+@sSQL4+@sSQL5+@sWhere3+@sSQL6+@sSQL7+@sWhere4)
ELSE
	EXEC(' ALTER VIEW AV7008 -- Tạo bởi WMP30031 Cách lấy dữ liệu giống AV7000
	        AS '+@sSQL+@sSQL1+@sWhere1+@sSQL2+@sSQL3+@sWhere2+@sSQL4+@sSQL5+@sWhere3+@sSQL6+@sSQL7+@sWhere4)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
