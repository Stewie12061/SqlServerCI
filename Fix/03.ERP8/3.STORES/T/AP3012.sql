IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP3012]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP3012]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- In phieu Chi
---- Created by Nguyen Van Nhan, Date 08/09/2003
---- Edit by B.Anh, Date 21/04/2008, Purpose: Lay them truong ObjectID
---- Edit by B.Quynh, Date 25/07/2008, Purpose: Bo truong ObjectID
---- Edit by B.Anh, date 27/01/2010	Sua loi thanh tien khong dung
---- Edit by Thien Huynh, date 24/10/2011 Khong Where theo @BatchID nua
---- Vi khong luu BatchID = VoucherID nua ma Sinh BatchID theo tung Hoa don tren luoi
---- Modified on 12/03/2012 by Lê Thị Thu Hiền : Chỉnh sửa SUM(OriginalAmount), SUM(ConvertedAmount)
---- Modified on 03/05/2012 by Thiên Huỳnh : Lấy MAX 1 số Column, Where theo Tài khoản 111
---- Modified on 11/05/2012 by Lê Thị Thu Hiền : Bổ sung BDescription, TDescription
---- Modified on 19/12/2014 by Trần Quốc Tuấn : đổ chi tiết ra cho khách hàng Long Giang
---- Modified on 28/12/2016 by Hải Long: Bổ sung trường DebitConvertedAmount (ANGEL)
---- Modified on 11/01/2018 by Bảo Anh : Bổ sung ISNULL cho các biến @DebitOriginalAmount1, DebitOriginalAmount2, DebitOriginalAmount3, @DebitConvertedAmount1, @DebitConvertedAmount2, @DebitConvertedAmount3
---- Modified on 05/02/2018 by Hoàng vũ: Custmize = 87[OKIA] lấy phiếu mã phân tích cho phiếu chi theo CON yêu cầu làm giống của Long Giang
---- Modified on 14/01/2019 by Kim Thư: Bổ sung WITH (NOLOCK) 
---- Modified on 04/01/2021 by Nhựt Trường: Bổ sung thêm điều kiện DivisionID khi join bảng AT1103.
---- Modified on 06/04/2023 by Đức Duy: [2023/04/IS/0032] - Bổ sung trường Parameter.
---- Modified on 22/12/2023 by Hương Nhung: [2023/12/TA/0226] - Bổ sung trường VATNo, AddressE.
/********************************************
'* Edited by: [GS] [Hoàng Phước] [29/07/2010]
'********************************************/
----- Edit by B.Quynh, Date 05/10/2011, Purpose: Them 6 truong vao view
	--DebitOriginalAmount1,
	--DebitOriginalAmount2,
	--DebitOriginalAmount3,
	--DebitConvertedAmount1,
	--DebitConvertedAmount2,
	--DebitConvertedAmount3
---- Modified by Phương Thảo on 22/05/2017: Sửa danh mục dùng chung
		
CREATE PROCEDURE [dbo].[AP3012] 
				@DivisionID AS nvarchar(50),
				@TranMonth AS int,
				@TranYear AS int,
				@VoucherID AS nvarchar(50),
				@BatchID AS nvarchar(50)=''
	
 AS
Declare @sSQL1 AS nvarchar(4000),
		@sSQL2 AS nvarchar(4000),
		@AT9000Cursor AS cursor,
		@InvoiceNo AS nvarchar(50),
		@Serial AS nvarchar(50),
		@InvoiceNoList AS nvarchar(500),
		@DebitAccountList AS nvarchar(500),
		@DebitConvertedAmountList AS NVARCHAR(MAX),
		@DebitAccountID  AS nvarchar(50),
		@DebitOriginalAmount AS decimal(28,8),
		@DebitOriginalAmount1 AS decimal(28,8),
		@DebitOriginalAmount2 AS decimal(28,8),
		@DebitOriginalAmount3 AS decimal(28,8),
		@DebitConvertedAmount AS decimal(28,8),
		@DebitConvertedAmount1 AS decimal(28,8),
		@DebitConvertedAmount2 AS decimal(28,8),
		@DebitConvertedAmount3 AS decimal(28,8),	
		@CreditAccountList AS nvarchar(500),
		@CreditAccountID  AS nvarchar(50),
		@InvoiceDate nvarchar(10),
		@IsType AS int,
		@i AS int,
		@AndWhereBatchID AS nvarchar(4000),
		@CustomerName AS INT 
		
Declare	@TempTable table(CustomerName  int,IsExcel  int)

INSERT @TempTable
EXEC	[dbo].[AP4444]
-- CustomerName == 2; Customize khách hàng ngọc Tề
select @IsType= CASE WHEN CustomerName<>2 then 0 else 1 end  from @TempTable
-- gán giá trị customer
SET @CustomerName = (SELECT TOP 1 CustomerName FROM @TempTable)

SET @InvoiceNoList =''

IF @BatchID <> ''
	SET @AT9000Cursor = CURSOR SCROLL KEYSET FOR
	SELECT	DISTINCT ISNULL(Serial,'') , isnull(InvoiceNo,''), 
			ISNULL(CONVERT(NVARCHAR(10), InvoiceDate, 103), '')  AS InvoiceDate
	FROM	AT9000 WITH (NOLOCK)  
	WHERE	VoucherID = @VoucherID 
			AND BatchID = @BatchID 
			--and TransactionTypeID ='T02'
			--AND TransactionTypeID in ('T02','T03','T13','T21','T23')
			AND (TransactionTypeID = 'T02' OR (TransactionTypeID IN ('T03', 'T13', 'T21', 'T23') AND CreditAccountID LIKE '111%'))
			AND DivisionID = @DivisionID
ELSE
	SET @AT9000Cursor = CURSOR SCROLL KEYSET FOR
	SELECT	DISTINCT ISNULL(Serial,'') , isnull(InvoiceNo,''), 
			ISNULL(CONVERT(NVARCHAR(10), InvoiceDate, 103), '')  AS InvoiceDate
	FROM	AT9000 WITH (NOLOCK)  
	WHERE	VoucherID = @VoucherID 
			--and BatchID = @BatchID 
			--and TransactionTypeID ='T02'
			--AND TransactionTypeID in ('T02','T03','T13','T21','T23')
			AND (TransactionTypeID = 'T02' OR (TransactionTypeID IN ('T03', 'T13', 'T21', 'T23') AND CreditAccountID LIKE '111%'))
			AND DivisionID = @DivisionID
		
OPEN @AT9000Cursor
		FETCH NEXT FROM @AT9000Cursor INTO @Serial , @InvoiceNo, @InvoiceDate
			
		WHILE @@FETCH_STATUS = 0
		BEGIN
			--If @InvoiceNoList<>''
				--Set @InvoiceNoList = @InvoiceNoList+'; '+@Serial+'.'+@InvoiceNo
				if(@IsType = 0)
					begin
					Set @InvoiceNoList = @InvoiceNoList + @Serial + CASE WHEN @Serial <> '' then ', ' else '' end + @InvoiceNo + 
						CASE WHEN @invoiceNo <> '' then ', '  else '' end + @InvoiceDate + 
						CASE WHEN @Serial +  @InvoiceNo +@InvoiceDate <> '' then    '; ' else '' end
					end
				else
					begin
						Set @InvoiceNoList = @InvoiceNoList + @InvoiceNo + 
						CASE WHEN @InvoiceNo <> '' then    '; ' else '' end
					end
--			Else
				--Set @InvoiceNoList =@Serial+'.'+@InvoiceNo
	--			Set @InvoiceNoList = @Serial +  CASE WHEN @Serial <> '' then ', ' end + @InvoiceNo + 
		--			CASE WHEN @invoiceNo <> '' then ', ' end + @InvoiceDate + '; '
			

			FETCH NEXT FROM @AT9000Cursor INTO @Serial, @InvoiceNo, @InvoiceDate
		END

CLOSE @AT9000Cursor

SET @DebitAccountList =''
SET @DebitConvertedAmountList = ''
SET @i = 1

Set @DebitOriginalAmount = 0
Set @DebitOriginalAmount1 = 0
Set @DebitOriginalAmount2 = 0
Set @DebitOriginalAmount3 = 0
Set @DebitConvertedAmount = 0
Set @DebitConvertedAmount1 = 0
Set @DebitConvertedAmount2 = 0
Set @DebitConvertedAmount3 = 0
IF @BatchID <> ''
	SET @AT9000Cursor = CURSOR SCROLL KEYSET FOR
	SELECT	DISTINCT DebitAccountID, 
			SUM(OriginalAmount) AS OriginalAmount, 
			SUM(ConvertedAmount) AS ConvertedAmount 
	FROM	AT9000  WITH (NOLOCK) 
	WHERE	VoucherID =@VoucherID 
			AND BatchID = @BatchID 
			--and TransactionTypeID ='T02'
			--AND TransactionTypeID in ('T02','T03','T13','T21','T23') 
			AND (TransactionTypeID = 'T02' OR (TransactionTypeID IN ('T03', 'T13', 'T21', 'T23') AND CreditAccountID LIKE '111%'))
			AND DivisionID = @DivisionID
	GROUP BY	DebitAccountID
	Order by DebitAccountID Desc
ELSE
	SET @AT9000Cursor = CURSOR SCROLL KEYSET FOR
	SELECT	DISTINCT DebitAccountID, 
			SUM(OriginalAmount) AS OriginalAmount, 
			SUM(ConvertedAmount) AS ConvertedAmount 
	FROM	AT9000 WITH (NOLOCK)  
	WHERE	VoucherID =@VoucherID 
			--and BatchID = @BatchID 
			--and TransactionTypeID ='T02'
			--AND TransactionTypeID in ('T02','T03','T13','T21','T23') 
			AND (TransactionTypeID = 'T02' OR (TransactionTypeID IN ('T03', 'T13', 'T21', 'T23') AND CreditAccountID LIKE '111%'))
			AND DivisionID = @DivisionID
	GROUP BY	DebitAccountID
	Order by DebitAccountID Desc

OPEN @AT9000Cursor
		FETCH NEXT FROM @AT9000Cursor INTO @DebitAccountID, @DebitOriginalAmount, @DebitConvertedAmount
			
		WHILE @@FETCH_STATUS = 0
		BEGIN
			If @DebitAccountList<>''
				begin
					-- xu ly neu ma tai khoan da ton tai trong danh sach thi khong them vao nua
					if(CHARINDEX(@DebitAccountID, @DebitAccountList) = 0)
						Set @DebitAccountList = @DebitAccountList+'; '+@DebitAccountID
				end
			Else
				Set @DebitAccountList  = @DebitAccountID

			If @DebitConvertedAmountList<>''
				begin
					-- xu ly neu ma tai khoan da ton tai trong danh sach thi khong them vao nua
					if(CHARINDEX(CONVERT(NVARCHAR(50),@DebitConvertedAmount), @DebitConvertedAmountList) = 0)
						Set @DebitConvertedAmountList = @DebitConvertedAmountList+'; '+CONVERT(NVARCHAR(50),@DebitConvertedAmount)
				END
				
			Else
				Set @DebitConvertedAmountList  = CONVERT(NVARCHAR(50),@DebitConvertedAmount)				
				
			If @i = 1
				Begin
					Set @DebitOriginalAmount1 = @DebitOriginalAmount 
					Set @DebitConvertedAmount1 = @DebitConvertedAmount 
				End	
			Else
				If @i = 2
					Begin
						Set @DebitOriginalAmount2 = @DebitOriginalAmount 
						Set @DebitConvertedAmount2 = @DebitConvertedAmount 
					End	
				Else
					If @i =3
						Begin
							Set @DebitOriginalAmount3 = @DebitOriginalAmount 
							Set @DebitConvertedAmount3 = @DebitConvertedAmount 
						End
						
			Set @i = @i + 1
			FETCH NEXT FROM @AT9000Cursor INTO @DebitAccountID, @DebitOriginalAmount, @DebitConvertedAmount
		END

If @InvoiceNoList<>'' 
	Set @InvoiceNoList =replace(@InvoiceNoList,'''','''''')
	
IF @BatchID <> ''
	Set @AndWhereBatchID = ' AND BatchID = ''' + @BatchID + ''''
ELSE
	Set @AndWhereBatchID = ''

IF @CustomerName=40 or @CustomerName=87
BEGIN
	Set @sSQL1 =N'
SELECT 	VoucherID, AT9000.DivisionID, TranMonth, TranYear, 
		VoucherTypeID, VoucherNo, VoucherDate, 
		VDescription, 
		AT9000.InvoiceNo, 
		DebitAccountID,'
		+ ltrim(ISNULL(@DebitOriginalAmount1,0)) + ' AS DebitOriginalAmount1, '
		+ ltrim(ISNULL(@DebitOriginalAmount2,0)) + ' AS DebitOriginalAmount2, '
		+ ltrim(ISNULL(@DebitOriginalAmount3,0)) + ' AS DebitOriginalAmount3, '
		+ ltrim(ISNULL(@DebitConvertedAmount1,0)) + ' AS DebitConvertedAmount1, '
		+ ltrim(ISNULL(@DebitConvertedAmount2,0)) + ' AS DebitConvertedAmount2, '
		+ ltrim(ISNULL(@DebitConvertedAmount3,0)) + ' AS DebitConvertedAmount3, 
		CreditAccountID AS AccountID, 
		--ObjectID,
		AT9000.CurrencyID, ExchangeRate, 
		SenderReceiver, 
		SRDivisionName, 
		SRAddress,
		RefNo01, 
		RefNo02, 
		FullName,
		ChiefAccountant,
		ConvertedAmount,
		OriginalAmount,
		ISNULL(AT9000.BDescription,'''') AS BDescription,
		ISNULL(AT9000.TDescription,'''') AS TDescription,
		AT9000.Ana01ID, A01.AnaName AS Ana01Name, AT9000.Ana02ID, A02.AnaName AS Ana02Name,
		AT9000.Ana03ID, A03.AnaName AS Ana03Name, AT9000.Ana04ID, A04.AnaName AS Ana04Name,
		AT9000.Ana05ID, A05.AnaName AS Ana05Name, AT9000.Ana06ID, A06.AnaName AS Ana06Name,
		AT9000.Ana07ID, A07.AnaName AS Ana07Name, AT9000.Ana08ID, A08.AnaName AS Ana08Name,
		AT9000.Ana09ID, A09.AnaName AS Ana09Name, AT9000.Ana10ID, A10.AnaName AS Ana10Name,
		AT9000.Parameter01,AT9000.Parameter02, AT9000.Parameter03, AT9000.Parameter04, AT9000.Parameter05,
		AT9000.Parameter06, AT9000.Parameter07, AT9000.Parameter08, AT9000.Parameter09, AT9000.Parameter10,
		AT9000.DParameter01, AT9000.DParameter02, AT9000.DParameter03, AT9000.DParameter04, AT9000.DParameter05,
		AT9000.DParameter06, AT9000.DParameter07, AT9000.DParameter08, AT9000.DParameter09, AT9000.DParameter10,
		AT9000.DParameter01, AT9000.DParameter02, AT9000.DParameter03, AT9000.DParameter04, AT9000.DParameter05,
		AT9000.DParameter06, AT9000.DParameter07, AT9000.DParameter08, AT9000.DParameter09, AT9000.DParameter10,
		AT9000.VATNo, AT9000.AddressE'

Set @sSQL2 =N'
FROM	AT9000 WITH (NOLOCK)  
LEFT JOIN AT1103 WITH (NOLOCK)  On AT1103.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1103.EmployeeID = AT9000.EmployeeID
LEFT JOIN AT0001 WITH (NOLOCK)  on AT9000.DivisionID = AT0001.DivisionID
LEFT JOIN AT1011 A01 WITH (NOLOCK)  ON A01.AnaID = AT9000.Ana01ID AND A01.AnaTypeID =''A01''
LEFT JOIN AT1011 A02 WITH (NOLOCK)  ON A02.AnaID = AT9000.Ana02ID AND A02.AnaTypeID =''A02''
LEFT JOIN AT1011 A03 WITH (NOLOCK)  ON A03.AnaID = AT9000.Ana03ID AND A03.AnaTypeID =''A03''
LEFT JOIN AT1011 A04 WITH (NOLOCK)  ON A04.AnaID = AT9000.Ana04ID AND A04.AnaTypeID =''A04''
LEFT JOIN AT1011 A05 WITH (NOLOCK)  ON A05.AnaID = AT9000.Ana05ID AND A05.AnaTypeID =''A05''
LEFT JOIN AT1011 A06 WITH (NOLOCK)  ON A06.AnaID = AT9000.Ana06ID AND A06.AnaTypeID =''A06''
LEFT JOIN AT1011 A07 WITH (NOLOCK)  ON A07.AnaID = AT9000.Ana07ID AND A07.AnaTypeID =''A07''
LEFT JOIN AT1011 A08 WITH (NOLOCK)  ON A08.AnaID = AT9000.Ana08ID AND A08.AnaTypeID =''A08''
LEFT JOIN AT1011 A09 WITH (NOLOCK)  ON A09.AnaID = AT9000.Ana09ID AND A09.AnaTypeID =''A09''
LEFT JOIN AT1011 A10 WITH (NOLOCK)  ON A10.AnaID = AT9000.Ana10ID AND A10.AnaTypeID =''A10''
WHERE 	--TransactionTypeID =''T02''
		--TransactionTypeID in (''T02'',''T03'',''T13'',''T21'',''T23'')
		(TransactionTypeID = ''T02'' OR (TransactionTypeID IN (''T03'', ''T13'', ''T21'', ''T23'') AND CreditAccountID LIKE ''111%''))
		AND VoucherID ='''+@VoucherID+''' 
		--and BatchID = ''' + @BatchID + '''
		' + @AndWhereBatchID + '
		AND AT9000.DivisionID ='''+@DivisionID+''''
END
ELSE
BEGIN
Set @sSQL1 =N'
SELECT 	VoucherID, AT9000.DivisionID, TranMonth, TranYear, 
		VoucherTypeID, VoucherNo, VoucherDate, 
		MAX(VDescription) AS VDescription, 
		N'''+isnull(@InvoiceNoList,'')+''' AS InvoiceNoList, 
		N'''+isnull(@DebitAccountList,'') +''' AS DebitAccountID, 
		N'''+isnull(@DebitConvertedAmountList,'') +''' AS DebitConvertedAmount, '
		+ ltrim(ISNULL(@DebitOriginalAmount1,0)) + ' AS DebitOriginalAmount1, '
		+ ltrim(ISNULL(@DebitOriginalAmount2,0)) + ' AS DebitOriginalAmount2, '
		+ ltrim(ISNULL(@DebitOriginalAmount3,0)) + ' AS DebitOriginalAmount3, '
		+ ltrim(ISNULL(@DebitConvertedAmount1,0)) + ' AS DebitConvertedAmount1, '
		+ ltrim(ISNULL(@DebitConvertedAmount2,0)) + ' AS DebitConvertedAmount2, '
		+ ltrim(ISNULL(@DebitConvertedAmount3,0)) + ' AS DebitConvertedAmount3, 
		CreditAccountID AS AccountID, 
		--ObjectID,
		AT9000.CurrencyID, ExchangeRate, 
		MAX(SenderReceiver) AS SenderReceiver, 
		MAX(SRDivisionName) AS SRDivisionName, 
		MAX(SRAddress) AS SRAddress,
		MAX(RefNo01) AS RefNo01, 
		MAX(RefNo02) AS RefNo02, 
		MAX(FullName) AS FullName,
		MAX(ChiefAccountant) AS ChiefAccountant,
		Sum(ConvertedAmount) AS ConvertedAmount,
		Sum(OriginalAmount) AS OriginalAmount,
		Max(ISNULL(AT9000.BDescription,'''')) AS BDescription,
		Max(ISNULL(AT9000.TDescription,'''')) AS TDescription,
		AT9000.Parameter01, AT9000.Parameter02, AT9000.Parameter03, AT9000.Parameter04, AT9000.Parameter05,
		AT9000.Parameter06, AT9000.Parameter07, AT9000.Parameter08, AT9000.Parameter09, AT9000.Parameter10,
		AT9000.DParameter01, AT9000.DParameter02, AT9000.DParameter03, AT9000.DParameter04, AT9000.DParameter05,
		AT9000.DParameter06, AT9000.DParameter07, AT9000.DParameter08, AT9000.DParameter09, AT9000.DParameter10,
		AT9000.VATNo, AT9000.AddressE'

Set @sSQL2 =N'
FROM	AT9000 WITH (NOLOCK)  
LEFT JOIN AT1103 WITH (NOLOCK)  On AT1103.DivisionID IN ('''+@DivisionID+''',''@@@'')AND AT1103.EmployeeID = AT9000.EmployeeID
LEFT JOIN AT0001 WITH (NOLOCK)  on AT9000.DivisionID = AT0001.DivisionID

WHERE 	--TransactionTypeID =''T02''
		--TransactionTypeID in (''T02'',''T03'',''T13'',''T21'',''T23'')
		(TransactionTypeID = ''T02'' OR (TransactionTypeID IN (''T03'', ''T13'', ''T21'', ''T23'') AND CreditAccountID LIKE ''111%''))
		AND VoucherID ='''+@VoucherID+''' 
		--and BatchID = ''' + @BatchID + '''
		' + @AndWhereBatchID + '
		AND AT9000.DivisionID ='''+@DivisionID+''' 	
					
GROUP BY VoucherID, AT9000.DivisionID, TranMonth, TranYear, 
		VoucherTypeID, VoucherNo, VoucherDate,
		--VDescription, 
		CreditAccountID, 
		--ObjectID,
		AT9000.CurrencyID, ExchangeRate,
		AT9000.Parameter01, AT9000.Parameter02, AT9000.Parameter03, AT9000.Parameter04, AT9000.Parameter05,
		AT9000.Parameter06, AT9000.Parameter07, AT9000.Parameter08, AT9000.Parameter09, AT9000.Parameter10,
		AT9000.DParameter01, AT9000.DParameter02, AT9000.DParameter03, AT9000.DParameter04, AT9000.DParameter05,
		AT9000.DParameter06, AT9000.DParameter07, AT9000.DParameter08, AT9000.DParameter09, AT9000.DParameter10,
		AT9000.VATNo, AT9000.AddressE
		--,SenderReceiver, SRDivisionName, SRAddress,RefNo01, RefNo02,FullName,ChiefAccountant'
	
END

print @sSQL1+@sSQL2

IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE NAME ='AV3012')
	EXEC ('CREATE VIEW AV3012  	-- CREATED BY AP3012
	AS '+@sSQL1+@sSQL2)
ELSE
	EXEC( 'ALTER VIEW AV3012  	-- CREATED BY AP3012
	AS '+@sSQL1+@sSQL2)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

