﻿IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0318]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP0318]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Liet ke chi tiet phat sinh theo mat hang, phieu thu
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----- Created by Nguyen Van  Nhan, Date 12/02/2004
---
---- Edited by Nguyen Quoc Huy.
---- Edit by: Dang Le Bao Quynh; Date 05/10/2009
---- Purpose: Bo sung 5 truong ten ma phan tich doi tuong,PhoneNumber, Contactor, DueDate
---- Edit by B.Anh, date 27/12/2009	Lay MPT 4,5
---- Edit by B.Anh, date 26/04/2010	Bo sung MPT mat hang
---- Modified on 06/12/2011 by Le Thi Thu Hien : Sua ngay CONVERT(varchar(10),VoucherDate,101)
---- Modified on 16/01/2012 by Le Thi Thu Hien : CONVERT ngay
---- Modified on 27/05/2013 by Le Thi Thu Hien : Bo sung Ana06ID --> Ana10ID
---- Modified by Bảo Thy on 26/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Hoàng vũ on 14/07/2016: Customize secoin, xem báo cáo từ tài khoản 131 -> 171 loại từ tài khoản kho 151 -> 159
---- Modified by Bảo Thy on 15/05/2017: Sửa danh mục dùng chung
---- Modified by Bảo Anh on 23/03/2018: Sửa lỗi không lấy được Mã và tên hàng đối với TK bên có
---- Modified by Bảo Anh on 12/04/2018: Bổ sung GiveUpDate
---- Modified by Huỳnh Thử on 15/06/2020: Đổi OriginalAmount thành OriginalAmountCN
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Đức Thông on 15/01/2021: [KHV] 2021/01/IS/0175: Kéo thêm trường thông tin kinh doanh lên báo cáo đối chiếu công nợ phải thu
---- Modified by Thanh Lượng on 18/11/2022: [TIENTIEN_N][2022/11/IS/0162]: Bổ sung điều kiện DivisionID dùng chung cho bảng AT1202,AT1010
-- <Example> EXEC AP0318 'HT','22247-B.TD*HBC','Z-TVTB2','001','911','VND','3C-700A','YN',0,10,2016,12,2016,'2016-10-01','2016-12-31'

CREATE PROCEDURE [dbo].[AP0318] 
				@DivisionID AS nvarchar(50), 
				@FromObjectID  AS nvarchar(50),  
				@ToObjectID  AS nvarchar(50), 
				@FromAccountID  AS nvarchar(50),  
				@ToAccountID  AS nvarchar(50),  
				@CurrencyID  AS nvarchar(50),  
				@FromInventoryID AS nvarchar(50),
				@ToInventoryID AS nvarchar(50),
				@IsDate AS tinyint, 
				@FromMonth AS int, 
				@FromYear  AS int,  
				@ToMonth AS int,
				@ToYear AS int,
				@FromDate AS Datetime, 
				@ToDate AS Datetime

AS

--PRINT ' AP0318'

Declare @sSQLselect AS nvarchar(4000),
		@sSQLfrom AS nvarchar(4000),
		@sSQLunionselect AS nvarchar(4000),
		@sSQLunionfrom AS nvarchar(4000),
		@TypeDate AS nvarchar(50),
		@FromPeriod AS int,
		@ToPeriod AS int,
		@SQLwhere AS nvarchar(4000),
		@sWHEREDebit AS NVARCHAR(MAX),
		@sWHERECredit AS NVARCHAR(MAX),
		@CustomerName INT,
		@ToGiveUpDate NVARCHAR(20)		
		
		CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
		INSERT #CustomerName EXEC AP4444
		SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)
		Set @sWHEREDebit = ''
		Set @sWHERECredit = ''
		IF @CustomerName = 43 --- Customize Secoin
		Begin
			Set @sWHEREDebit = @sWHEREDebit + ' AND AT9000.DebitAccountID Not like N''15%'''
			Set @sWHERECredit = @sWHERECredit + ' AND AT9000.CreditAccountID Not like N''15%'''
		End
SET @TypeDate ='VoucherDate'

SET @FromPeriod = (@FromMonth + @FromYear*100)	
SET @ToPeriod = (@ToMonth + @ToYear*100)	

IF @IsDate =0   ----- Truong hop tinh Tu ky den ky 
	SET @SQLwhere ='  AND   (AT9000.TranMonth+ AT9000.TranYear*100 Between '+str(@FromPeriod)+' AND '+str(@ToPeriod)+')   '

Else
	SET @SQLwhere ='  AND (CONVERT(DATETIME,CONVERT(varchar(10),AT9000.'+ltrim(Rtrim(@TypeDate))+',101),101) BETWEEN '''+convert(nvarchar(10),@FromDate,101)+''' AND '''+convert(nvarchar(10),@ToDate,101)+''')  '

IF @IsDate = 0
	SET @ToGiveUpDate = CONVERT(NVARCHAR(20), EOMONTH(CONVERT(DATETIME,LTRIM(@ToYear) + Case When @ToMonth < 10 then '0' Else '' End + LTRIM(@ToMonth) + '01')), 101) + ' 23:59:59'
ELSE
	SET @ToGiveUpDate = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

--print(@SQLwhere)

SET @sSQLselect='
SELECT 	AT9000.Orders, 
		TransactionTypeID,
		AT9000.ObjectID,
		AT1202.ObjectName,
		AT1202.PhoneNumber,AT1202.Contactor,
		AT9000.DebitAccountID,
		AT9000.CreditAccountID,
		VoucherDate, VoucherNo, VoucherTypeID, 
		Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID,
		Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
		AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID, 
		O1.AnaName AS O01Name, O2.AnaName AS O02Name, O3.AnaName AS O03Name, O4.AnaName AS O04Name, O5.AnaName AS O05Name, 
		AT1302.I01ID, AT1302.I02ID, AT1302.I03ID, AT1302.I04ID, AT1302.I05ID,
		I1.AnaName AS I01Name, I2.AnaName AS I02Name, I3.AnaName AS I03Name, I4.AnaName AS I04Name, I5.AnaName AS I05Name,
		AT9000.TDescription,
		isnull(AT1010.VATRate,0) AS VATRate,
		AT9000.InvoiceDate, AT9000.InvoiceNo, AT9000.Serial, AT9000.DueDate,
		isnull(AT9000.InventoryID,'''') AS InventoryID,
		CASE WHEN isnull(AT9000.InventoryName1,'''')= ''''  then Isnull(InventoryName,isnull(AT9000.TDescription,''''))Else AT9000.InventoryName1 end AS InventoryName,
		VDescription,
		AT9000.UnitID,
		OriginalAmountCN AS DebitOriginalAmount, 
		ConvertedAmount AS DebitConvertedAmount, 
		isnull(Quantity,0) AS DebitQuantity, 
		UnitPrice AS DebitUnitPrice,
		0 AS CreditOriginalAmount,
		0 AS CreditConvertedAmount,
		0 AS CreditQuantity, AT9000.DivisionID,
		AT9000.RefInfor	-- thông tin kinh doanh
		' 

IF @CustomerName = 45 --- Karaben
	SET @sSQLselect = @sSQLselect + ', (Select MAX(GiveUpDate) From AT0303 WITH (NOLOCK)
										Where DivisionID = AT9000.DivisionID And DebitVoucherID = AT9000.VoucherID And CONVERT(NVARCHAR(20), GiveUpDate, 101) <= ''' + @ToGiveUpdate + '''
										) AS GiveUpDate'		
SET @sSQLfrom='
FROM AT9000  WITH (NOLOCK)	
LEFT JOIN AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT1302.InventoryID = AT9000.InventoryID
LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT1202.ObjectID = AT9000.ObjectID
LEFT JOIN AT1010 WITH (NOLOCK) on AT1010.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT1010.VATGroupID = AT9000.VATGroupID
LEFT JOIN AT1015 O1 WITH (NOLOCK) on AT1202.O01ID = O1.AnaID AND O1.AnaTypeID = ''O01'' 
LEFT JOIN AT1015 O2 WITH (NOLOCK) on AT1202.O02ID = O2.AnaID AND O2.AnaTypeID = ''O02'' 
LEFT JOIN AT1015 O3 WITH (NOLOCK) on AT1202.O03ID = O3.AnaID AND O3.AnaTypeID = ''O03'' 
LEFT JOIN AT1015 O4 WITH (NOLOCK) on AT1202.O04ID = O4.AnaID AND O4.AnaTypeID = ''O04'' 
LEFT JOIN AT1015 O5 WITH (NOLOCK) on AT1202.O05ID = O5.AnaID AND O5.AnaTypeID = ''O05'' 
LEFT JOIN AT1015 I1 WITH (NOLOCK) on AT1302.DivisionID IN (I1.DivisionID,''@@@'') AND AT1302.I01ID = I1.AnaID AND I1.AnaTypeID = ''I01''
LEFT JOIN AT1015 I2 WITH (NOLOCK) on AT1302.DivisionID IN (I2.DivisionID,''@@@'') AND AT1302.I02ID = I2.AnaID AND I2.AnaTypeID = ''I02''
LEFT JOIN AT1015 I3 WITH (NOLOCK) on AT1302.DivisionID IN (I3.DivisionID,''@@@'') AND AT1302.I03ID = I3.AnaID AND I3.AnaTypeID = ''I03''
LEFT JOIN AT1015 I4 WITH (NOLOCK) on AT1302.DivisionID IN (I4.DivisionID,''@@@'') AND AT1302.I04ID = I4.AnaID AND I4.AnaTypeID = ''I04''
LEFT JOIN AT1015 I5 WITH (NOLOCK) on AT1302.DivisionID IN (I5.DivisionID,''@@@'') AND AT1302.I05ID = I5.AnaID AND I5.AnaTypeID = ''I05''
WHERE 	((TransactionTypeID <>''T00'' AND TransactionTypeID not in (''T24'',''T34'') 
		AND DebitAccountID BETWEEN  '''+@FromAccountID+''' AND '''+@ToAccountID+''') or
		(TransactionTypeID in (''T24'',''T34'') AND DebitAccountID BETWEEN  '''+@FromAccountID+''' AND '''+@ToAccountID+''')) AND 
		AT9000.DivisionID ='''+@DivisionID+''' AND
		(AT9000.ObjectID BETWEEN  '''+@FromObjectID+''' AND '''+@ToObjectID+''' AND AT1202.Disabled = 0) AND
		CurrencyIDCN like '''+@CurrencyID+''' '+ @SQLwhere+ @sWHEREDebit

SET @sSQLunionselect= ' 
UNION ALL
SELECT 	999 AS Orders,
		TransactionTypeID,
		CASE WHEN TransactionTypeID =''T99'' then AT9000.CreditObjectID else AT9000.ObjectID end AS ObjectID ,
		CASE WHEN TransactionTypeID =''T99'' then C.ObjectName else AT1202.ObjectName end AS ObjectName,
		CASE WHEN TransactionTypeID =''T99'' then C.PhoneNumber else AT1202.PhoneNumber end AS PhoneNumber,
		CASE WHEN TransactionTypeID =''T99'' then C.Contactor else AT1202.Contactor end AS Contactor,

		AT9000.DebitAccountID,
		AT9000.CreditAccountID,
		VoucherDate, VoucherNo,VoucherTypeID,
		Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID,
		Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
		CASE WHEN TransactionTypeID =''T99'' then C.O01ID else AT1202.O01ID end AS O01ID,
		CASE WHEN TransactionTypeID =''T99'' then C.O02ID else AT1202.O02ID end AS O02ID,
		CASE WHEN TransactionTypeID =''T99'' then C.O03ID else AT1202.O03ID end AS O03ID,
		CASE WHEN TransactionTypeID =''T99'' then C.O04ID else AT1202.O04ID end AS O04ID,
		CASE WHEN TransactionTypeID =''T99'' then C.O05ID else AT1202.O05ID end AS O05ID,
		O1.AnaName AS O01Name, O2.AnaName AS O02Name, O3.AnaName AS O03Name, O4.AnaName AS O04Name, O5.AnaName AS O05Name, 
		AT1302.I01ID, AT1302.I02ID, AT1302.I03ID, AT1302.I04ID, AT1302.I05ID,
		I1.AnaName AS I01Name, I2.AnaName AS I02Name, I3.AnaName AS I03Name, I4.AnaName AS I04Name, I5.AnaName AS I05Name,
		AT9000.TDescription,
		isnull(AT1010.VATRate,0) AS VATRate,
		AT9000.InvoiceDate, AT9000.InvoiceNo, AT9000.Serial, AT9000.DueDate,
		--'''' AS InventoryID,
		--(CASE WHEN TransactionTypeID in (''T24'',''T34'') then Isnull(InventoryName,isnull(AT9000.TDescription,''''))
		--		else VDescription end) AS InventoryName,
		isnull(AT9000.InventoryID,'''') AS InventoryID,
		CASE WHEN isnull(AT9000.InventoryName1,'''')= ''''  then Isnull(InventoryName,isnull(AT9000.TDescription,''''))Else AT9000.InventoryName1 end AS InventoryName,
		VDescription,
		AT9000.UnitID,
		0 AS DebitOriginalAmount, 
		0 AS DebitConvertedAmount, 
		0 AS DebitQuantity, 
		0 AS DebitUnitPrice,
		Sum(OriginalAmountCN) AS CreditOriginalAmount,
		Sum(ConvertedAmount) AS CreditConvertedAmount,
		Sum(isnull(Quantity,0)) AS CreditQuantity, AT9000.DivisionID,
		AT9000.RefInfor	-- thông tin kinh doanh
		'

IF @CustomerName = 45 --- Karaben
	SET @sSQLunionselect = @sSQLunionselect + ', (Select MAX(GiveUpDate) From AT0303 WITH (NOLOCK)
										Where DivisionID = AT9000.DivisionID And CreditVoucherID = AT9000.VoucherID And CONVERT(NVARCHAR(20), GiveUpDate, 101) <= ''' + @ToGiveUpdate + '''
										) AS GiveUpDate'
		
SET @sSQLunionfrom = '
FROM	AT9000  WITH (NOLOCK)	
LEFT JOIN AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT1302.InventoryID = AT9000.InventoryID
LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT1202.ObjectID = AT9000.ObjectID
LEFT JOIN AT1202 C WITH (NOLOCK) on C.DivisionID IN (AT9000.DivisionID,''@@@'') AND C.ObjectID = AT9000.CreditObjectID
LEFT JOIN AT1015 O1 WITH (NOLOCK) on (CASE WHEN TransactionTypeID =''T99'' then C.O01ID else AT1202.O01ID end) = O1.AnaID AND O1.AnaTypeID = ''O01'' 
LEFT JOIN AT1015 O2 WITH (NOLOCK) on (CASE WHEN TransactionTypeID =''T99'' then C.O02ID else AT1202.O02ID end) = O2.AnaID AND O2.AnaTypeID = ''O02'' 
LEFT JOIN AT1015 O3 WITH (NOLOCK) on (CASE WHEN TransactionTypeID =''T99'' then C.O03ID else AT1202.O03ID end) = O3.AnaID AND O3.AnaTypeID = ''O03'' 
LEFT JOIN AT1015 O4 WITH (NOLOCK) on (CASE WHEN TransactionTypeID =''T99'' then C.O04ID else AT1202.O04ID end) = O4.AnaID AND O4.AnaTypeID = ''O04'' 
LEFT JOIN AT1015 O5 WITH (NOLOCK) on (CASE WHEN TransactionTypeID =''T99'' then C.O05ID else AT1202.O05ID end) = O5.AnaID AND O5.AnaTypeID = ''O05'' 
LEFT JOIN AT1015 I1 WITH (NOLOCK) on AT1302.DivisionID IN (I1.DivisionID,''@@@'') AND AT1302.I01ID = I1.AnaID AND I1.AnaTypeID = ''I01'' 
LEFT JOIN AT1015 I2 WITH (NOLOCK) on AT1302.DivisionID IN (I2.DivisionID,''@@@'') AND AT1302.I02ID = I2.AnaID AND I2.AnaTypeID = ''I02'' 
LEFT JOIN AT1015 I3 WITH (NOLOCK) on AT1302.DivisionID IN (I3.DivisionID,''@@@'') AND AT1302.I03ID = I3.AnaID AND I3.AnaTypeID = ''I03'' 
LEFT JOIN AT1015 I4 WITH (NOLOCK) on AT1302.DivisionID IN (I4.DivisionID,''@@@'') AND AT1302.I04ID = I4.AnaID AND I4.AnaTypeID = ''I04'' 
LEFT JOIN AT1015 I5 WITH (NOLOCK) on AT1302.DivisionID IN (I5.DivisionID,''@@@'') AND AT1302.I05ID = I5.AnaID AND I5.AnaTypeID = ''I05''
LEFT JOIN AT1010 WITH (NOLOCK) on AT1010.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT1010.VATGroupID = AT9000.VATGroupID
WHERE 	((TransactionTypeID <>''T00'' AND TransactionTypeID not in (''T24'',''T34'') 
		and CreditAccountID BETWEEN  '''+@FromAccountID+''' AND '''+@ToAccountID+''') or
		(TransactionTypeID in (''T24'',''T34'') AND CreditAccountID BETWEEN  '''+@FromAccountID+''' AND '''+@ToAccountID+''')) AND 
		AT9000.DivisionID ='''+@DivisionID+''' AND
		(  	(AT9000.ObjectID between  '''+@FromObjectID+''' AND '''+@ToObjectID+''' AND TransactiontypeID<>''T99'')		
			or (AT9000.CreditObjectID between  '''+@FromObjectID+''' AND '''+@ToObjectID+''' AND TransactiontypeID=''T99'')	
		) AND
		CurrencyIDCN like '''+@CurrencyID+'''  
		'+@SQLwhere +  @sWHERECredit+'
GROUP BY	TransactionTypeID, AT9000.ObjectID, AT1202.ObjectName, AT1202.PhoneNumber, AT1202.Contactor, AT1010.VATRate, 
			AT9000.DebitAccountID,AT9000.CreditAccountID,VoucherDate, 
			VoucherNo,VoucherTypeID, VoucherID,
			Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID,
			Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
			AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID, 
			C.O01ID, C.O02ID, C.O03ID, C.O04ID, C.O05ID, 
			O1.AnaName, O2.AnaName, O3.AnaName, O4.AnaName, O5.AnaName, 
			AT1302.I01ID, AT1302.I02ID, AT1302.I03ID, AT1302.I04ID, AT1302.I05ID,
			I1.AnaName, I2.AnaName, I3.AnaName, I4.AnaName, I5.AnaName,
			AT9000.InvoiceDate, AT9000.InvoiceNo, AT9000.Serial, AT9000.DueDate, AT9000.CreditObjectID, C.ObjectName, C.PhoneNumber, C.Contactor, 
			VDescription, InventoryName, TDescription, AT9000.UnitID, AT9000.DivisionID, isnull(AT9000.InventoryID,''''),
			(CASE WHEN isnull(AT9000.InventoryName1,'''')= ''''  then Isnull(InventoryName,isnull(AT9000.TDescription,''''))Else AT9000.InventoryName1 end),
			AT9000.RefInfor	-- thông tin kinh doanh
'

	--Print @sSQLselect + @sSQLfrom + @sSQLunionselect + @sSQLunionfrom

IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV0318]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
 		EXEC ('  CREATE VIEW AV0318 --AP0318
 		AS ' + @sSQLselect + @sSQLfrom + @sSQLunionselect + @sSQLunionfrom)
	ELSE
		EXEC ('  ALTER VIEW AV0318  --AP0318
		 AS ' + @sSQLselect + @sSQLfrom + @sSQLunionselect + @sSQLunionfrom)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

