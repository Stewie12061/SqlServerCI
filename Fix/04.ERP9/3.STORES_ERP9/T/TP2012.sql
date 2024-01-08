IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[TP2012]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[TP2012]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid Form Lưới detail xem chi tiết đề nghị thu/chi
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Đức Tuyên on 24/08/2022
----Modified by: Nhật Quang on 14/03/2023 - Cập nhật: Bổ sung thêm trường OrderVoucherNo.

-- <Example>
----    exec TP2012 @DivisionID=N'EXV',@UserID=N'ADMIN',@APKMaster_9000=N'd6196220-f698-49aa-bc65-7915c94ee001',@Mode=1,@PageNumber=1,@PageSize=25

CREATE PROCEDURE TP2012 ( 
        	@DivisionID nvarchar(50),
			@APKMaster_9000 VARCHAR(50) = '',
			@Mode INT = 0, ---- 0 Edit, 1 view
			@PageNumber INT = 1,
			@UserID VARCHAR(50),
			@PageSize INT = 25) 
AS 

DECLARE @sSQL NVARCHAR (MAX),
		@sSQL1 NVARCHAR(MAX),
		@sSQL2 NVARCHAR(MAX),
		@sSQL3 NVARCHAR(MAX),
		@sSQL4 NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX),
		@TotalRow VARCHAR(50),
		@OrderBy NVARCHAR(500),
		@Level INT,
		@sSQLSL NVARCHAR (MAX) = '',
		@sSQLJon NVARCHAR (MAX) = '',
		@i INT = 1, @s VARCHAR(2)

set @sSQL2 =''
SET @sSQL1 =''
SET @sWhere ='' 
 

SET @TotalRow = ''
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'


IF EXISTS (SELECT TOP 1 1 FROM OOT9001 WITH (NOLOCK) WHERE CONVERT(VARCHAR(50),APKMaster) = @APKMaster_9000)
--Lấy dữ liệu grid cập nhật
BEGIN
	SET @Swhere = @Swhere + 'AND CONVERT(VARCHAR(50),AT9010.APKMaster_9000)= '''+@APKMaster_9000+'''' 
	SELECT @Level = MAX(Level) FROM OOT9001 WITH (NOLOCK) WHERE CONVERT(VARCHAR(50),APKMaster) = @APKMaster_9000 
END
ELSE 
--Lấy dữ liệu gird detail xem chi tiết
BEGIN
	SET @Swhere = @Swhere + 'AND AT9010.VoucherNo = '''+ ISNULL((SELECT TOP 1 VoucherNo FROM AT9010 WITH (NOLOCK) WHERE CONVERT(VARCHAR(50),APK) = @APKMaster_9000),'')+'''' 
	SELECT @Level = MAX(Level) 
	FROM OOT9001 WITH (NOLOCK) LEFT JOIN AT9010 ON CONVERT(VARCHAR(50),OOT9001.APKMaster) = AT9010.APKMaster_9000 
	WHERE CONVERT(VARCHAR(50), AT9010.APK) = @APKMaster_9000
END

WHILE @i <= @Level
BEGIN
	IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
	ELSE SET @s = CONVERT(VARCHAR, @i)
	SET @sSQLSL=@sSQLSL+' , APK9001'+@s+', Status'+@s+', Approvel'+@s+'Note, ApprovalDate'+@s+''
	SET @sSQLJon =@sSQLJon+ '
				LEFT JOIN (SELECT OOT1.APK APK9001'+@s+', OOT1.APKMaster,OOT1.DivisionID, T94.APKDetail APK2001,
							T94.Status Status'+@s+',
							O99.Description StatusName'+@s+',
							T94.Note Approvel'+@s+'Note,
							T94.ApprovalDate ApprovalDate'+@s+'
							FROM OOT9001 OOT1 WITH (NOLOCK)
							LEFT JOIN OOT9004 T94 WITH (NOLOCK) ON OOT1.APK = T94.APK9001 AND T94.DeleteFlag = 0
							LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1=ISNULL(T94.Status,0) AND O99.CodeMaster=''Status''
							WHERE OOT1.Level='+STR(@i)+')APP'+@s+' 
						ON APP'+@s+'.DivisionID= OOT90.DivisionID  
						AND APP'+@s+'.APKMaster=OOT90.APK 
						AND CASE WHEN ISNULL(CONVERT(Varchar (50),APP'+@s+'.APK2001),'''') <> '''' 
								THEN APP'+@s+'.APK2001 
								ELSE AT9010.APK 
								END = AT9010.APK '
	SET @i = @i + 1		
END	

SET @sSQL = 'SELECT ROW_NUMBER() OVER (ORDER BY AT9010.Orders) AS RowNum, '+@TotalRow+' AS TotalRow,
	AT9010.APK,AT9010.VoucherNo, 
	AT9010.TransactionID,  
	AT1302.InventoryName, 
	AT9010.InventoryID,
	AT9010.Serial,
	Isnull(AT9010.UnitID,AT1302.UnitID) as  UnitID,
	AT04.UnitName,
	AT9010.UnitPrice,
	AT9010.UnitPrice as UnitPriceCof, 
	ISNULL(AT9010.OriginalAmount, 0) AS OriginalAmount, 
	ISNULL(AT9010.VATOriginalAmount, 0) AS VATOriginalAmount, 
	AT9010.Orders, 
	ISNULL(AT9010.ConvertedAmount, 0) AS ConvertedAmount,
	ISNULL(AT9010.VATConvertedAmount, 0) AS VATConvertedAmount,
	AT9010.VATNo,
	AT9010.VATGroupID,
	AT9010.DivisionID,
	AT9010.InheritTableID,
	AT9010.InheritVoucherID,
	AT9010.InheritTransactionID,
	AT9010.InvoiceDate,
	AT9010.InvoiceNo,
	AT9010.ObjectID,
	
	AT9010.InvoiceCode,
	AT9010.InvoiceSign,
	AT9010.DebitAccountID,
	AT9010.CreditAccountID,
	AT9010.OriginalAmount,
	AT9010.ConvertedAmount,
	AT9010.VATTypeID,
	AT9010.VATGroupID,
	AT9010.BDescription,
	AT9010.TDescription,
	AT9010.Orders,
	AT9010.Ana01ID,
	AT9010.Ana02ID,
	AT9010.Ana03ID,
	AT9010.OrderID,
	AT9010.OrderVoucherNo,
	AT12.ObjectName,
	
	AT9010.Ana01ID, T01.AnaName As Ana01Name, AT9010.Ana02ID, T02.AnaName As Ana02Name, AT9010.Ana03ID, T03.AnaName As Ana03Name,
	AT9010.Ana04ID, T04.AnaName As Ana04Name, AT9010.Ana05ID, T05.AnaName As Ana05Name, AT9010.Ana06ID, T06.AnaName As Ana06Name,
	AT9010.Ana07ID, T07.AnaName As Ana07Name, AT9010.Ana08ID, T08.AnaName As Ana08Name, AT9010.Ana09ID, T09.AnaName As Ana09Name,
	AT9010.Ana10ID, T10.AnaName As Ana10Name'

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN
	SET @sSQL1 = @sSQL1 + ',
		O99.S01ID As STypeS01, O99.SUnitPrice01,
		O99.S02ID As STypeS02, O99.SUnitPrice02,
		O99.S03ID As STypeS03, O99.SUnitPrice03,
		O99.S04ID As STypeS04, O99.SUnitPrice04,
		O99.S05ID As STypeS05, O99.SUnitPrice05,
		O99.S06ID As STypeS06, O99.SUnitPrice06,
		O99.S07ID As STypeS07, O99.SUnitPrice07,
		O99.S08ID As STypeS08, O99.SUnitPrice08,
		O99.S09ID As STypeS09, O99.SUnitPrice09,		
		O99.S10ID As STypeS10, O99.SUnitPrice10,
		O99.S11ID As STypeS11, O99.SUnitPrice11,
		O99.S12ID As STypeS12, O99.SUnitPrice12,
		O99.S13ID As STypeS13, O99.SUnitPrice13,
		O99.S14ID As STypeS14, O99.SUnitPrice14,
		O99.S15ID As STypeS15, O99.SUnitPrice15,
		O99.S16ID As STypeS16, O99.SUnitPrice16,
		O99.S17ID As STypeS17, O99.SUnitPrice17,
		O99.S18ID As STypeS18, O99.SUnitPrice18,
		O99.S19ID As STypeS19, O99.SUnitPrice19,
		O99.S20ID As STypeS20, O99.SUnitPrice20 '
	
	SET @sSQL2 = @sSQL2 + '
		LEFT JOIN OT8899 O99 WITH (NOLOCK) ON O99.DivisionID = AT9010.DivisionID AND O99.VoucherID = AT9010.VoucherNo AND O99.TransactionID = AT9010.TransactionID'
END

SET @sSQL3 = + @sSQLSL+'
		FROM AT9010 With (NOLOCK)
		LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON AT9010.APKMaster_9000 = OOT90.APK
		LEFT JOIN AT1202  AT12 WITH (NOLOCK) on AT12.ObjectID= AT9010.ObjectID
		LEFT JOIN AT1302  WITH (NOLOCK) on AT1302.InventoryID= AT9010.InventoryID
		LEFT JOIN AT1304 AT04  WITH (NOLOCK) on AT04.UnitID = AT9010.UnitID
		LEFT JOIN AT1011 T01 WITH (NOLOCK) ON T01.AnaID = AT9010.Ana01ID AND T01.AnaTypeID = ''A01''
		LEFT JOIN AT1011 T02 WITH (NOLOCK) ON T02.AnaID = AT9010.Ana02ID AND T02.AnaTypeID = ''A02''
		LEFT JOIN AT1011 T03 WITH (NOLOCK) ON T03.AnaID = AT9010.Ana03ID AND T03.AnaTypeID = ''A03''
		LEFT JOIN AT1011 T04 WITH (NOLOCK) ON T04.AnaID = AT9010.Ana04ID AND T04.AnaTypeID = ''A04''
		LEFT JOIN AT1011 T05 WITH (NOLOCK) ON T05.AnaID = AT9010.Ana05ID AND T05.AnaTypeID = ''A05''
		LEFT JOIN AT1011 T06 WITH (NOLOCK) ON T06.AnaID = AT9010.Ana06ID AND T06.AnaTypeID = ''A06''
		LEFT JOIN AT1011 T07 WITH (NOLOCK) ON T07.AnaID = AT9010.Ana07ID AND T07.AnaTypeID = ''A07''
		LEFT JOIN AT1011 T08 WITH (NOLOCK) ON T08.AnaID = AT9010.Ana08ID AND T08.AnaTypeID = ''A08''
		LEFT JOIN AT1011 T09 WITH (NOLOCK) ON T09.AnaID = AT9010.Ana09ID AND T09.AnaTypeID = ''A09''
		LEFT JOIN AT1011 T10 WITH (NOLOCK) ON T10.AnaID = AT9010.Ana10ID AND T10.AnaTypeID = ''A10'' 	
		'
		+@sSQLJon

SET @sSQL4 = '
       Where AT9010.DivisionID = '''+@DivisionID+'''' + @sWhere+'
	   Order By AT9010.Orders'
IF @Mode = 1
BEGIN
	SET @sSQL4 = @sSQL4+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
END

PRINT @sSQL
PRINT @sSQL1
PRINT @sSQL3
PRINT @sSQL2
PRINT @sSQL4
EXEC (@sSQL+ @sSQL1+ @sSQL3+@sSQL2+ @sSQL4)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
