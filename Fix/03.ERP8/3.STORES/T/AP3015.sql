IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP3015]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP3015]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





--In phiÕu tong hop
--Created by Hoang Thi Lan
--Edit by Nguyen Quoc Huy,
--Edit by Nguyen Quoc Huy on 14/01/2020: Bổ sung thêm listVoucherID để In hàng loạt phiếu custom cho Phúc L:ong
 --Last Edit: Thuy Tuyen , date 15/09/2008. lay  truong dia chi doi tuong no va co

/********************************************
'* Edited by: [GS] [Hoàng Phước] [29/07/2010]
'* Edited by: [GS] [Cẩm Loan] [10/01/2010] [Thêm điều kiện DivisionID]
'********************************************/
---- Modify by Phương Thảo on 02/03/2016: Lấy thêm dữ liệu mã phân tích
---- Modified by Hải Long on 18/05/2017: Chỉnh sửa danh mục dùng chung
---- Modify by Bảo Anh on 04/06/2018: Sửa lỗi in khi số hóa đơn có nhập dấu nháy đơn
---- Modify by Nhật Thanh on 14/06/2022: Bổ sung điều kiện divisionID
---- Modify by Đức Tuyên on 05/10/2022: Bổ sung trường DueDate


CREATE PROCEDURE 	[dbo].[AP3015] @DivisionID as nvarchar(50),
					@TranMonth as int,
					@TranYear as int,
					@VoucherID as nvarchar(MAX)
	
 AS
Declare @sSQL1 as nvarchar(4000),
	@sSQL2 as nvarchar(4000),
	@AT9000Cursor as cursor,
	@InvoiceNo as nvarchar(50),
	@Serial as nvarchar(50),
	@InvoiceNoList as nvarchar(500),
	@DebitAccountList as nvarchar(500),
	@DebitAccountID  as nvarchar(50),
	@CreditAccountList as nvarchar(500),
	@CreditAccountID  as nvarchar(50),
	@Flag as tinyint = 0

-- Kiểm tra VoucherID là 1 hay list VoucherID
IF CHARINDEX('trick',@VoucherID) > 0 AND (SELECT CustomerName FROM CustomerIndex) = 32 -- PHÚC LONG
BEGIN
	SET @Flag = 1
	SET @VoucherID = REPLACE(@VoucherID,'trick','')
END

SET @InvoiceNoList =''
SET @AT9000Cursor = CURSOR SCROLL KEYSET FOR
Select Distinct Serial , InvoiceNo From AT9000 WITH (NOLOCK) Where VoucherID IN (@VoucherID) and TransactionTypeID ='T99' and DivisionID = @DivisionID
OPEN @AT9000Cursor
		FETCH NEXT FROM @AT9000Cursor INTO @Serial , @InvoiceNo
			
		WHILE @@FETCH_STATUS = 0
		BEGIN
			If @InvoiceNoList<>''
				Set @InvoiceNoList = @InvoiceNoList+'; '+@Serial+'.'+@InvoiceNo
			Else
				Set @InvoiceNoList =@Serial+'.'+@InvoiceNo

			FETCH NEXT FROM @AT9000Cursor INTO @Serial, @InvoiceNo
		END

CLOSE @AT9000Cursor

If @InvoiceNoList<>'' 
	Set @InvoiceNoList =N' Kèm theo: '+ REPLACE(@InvoiceNoList, '''', '''''') +' chứng từ gốc'

Set @sSQL1 =N'
Select Distinct	VoucherID, AT9000.DivisionID, TranMonth, TranYear, 
	Orders,
	VoucherTypeID, VoucherNo, VoucherDate,
	AT9000.InvoiceNo,
	InvoiceDate,
	AT9000.Serial, 
	--Ana01ID, 
	--Ana02ID, 
	--Ana03ID, 
	AT9000.ObjectID,
	AT9000.CreditObjectID,
	AT9000.ObjectID+ '' - ''+A.ObjectName as DebitObjectName,
	A.Address as DebitAddress,
	AT9000.CreditObjectID+'' - ''+ B.ObjectName as CreditObjectName,
	AT9000.DueDate,
	B.Address as CreditAddress,
	VDescription,
	BDescription,
	TDescription,
	'''+isnull(@InvoiceNoList,'')+''' as InvoiceNoList,
	DebitAccountID,
	C.AccountName as DebitAccountName,
	CreditAccountID, 
	D.AccountName as CreditAccountName,
	FullName,
	ChiefAccountant,

	AT9000.CurrencyID, ExchangeRate,
	ConvertedAmount as ConvertedAmount,
	OriginalAmount as OriginalAmount,	
	AT9000.Ana01ID, A01.AnaName AS Ana01Name, AT9000.Ana02ID, A02.AnaName AS Ana02Name,
	AT9000.Ana03ID, A03.AnaName AS Ana03Name, AT9000.Ana04ID, A04.AnaName AS Ana04Name,
	AT9000.Ana05ID, A05.AnaName AS Ana05Name, AT9000.Ana06ID, A06.AnaName AS Ana06Name,
	AT9000.Ana07ID, A07.AnaName AS Ana07Name, AT9000.Ana08ID, A08.AnaName AS Ana08Name,
	AT9000.Ana09ID, A09.AnaName AS Ana09Name, AT9000.Ana10ID, A10.AnaName AS Ana10Name,
	AT9000.IsWithhodingTax
	'

Set @sSQL2 =N'
 From AT9000  WITH (NOLOCK)	
 Left  join AT1202 A on A.ObjectID = AT9000.ObjectID and A.DivisionID in (''@@@'',AT9000.DivisionID)
 Left  join AT1202 B on B.ObjectID = AT9000.CreditObjectID and B.DivisionID in (''@@@'',AT9000.DivisionID)
 
 Left  join AT1005 C on C.AccountID = AT9000.DebitAccountID and C.DivisionID in (''@@@'',AT9000.DivisionID)
 Left  join AT1005 D on D.AccountID = AT9000.CreditAccountID and D.DivisionID in (''@@@'',AT9000.DivisionID)
 
 Left join AT1103 On AT1103.EmployeeID = AT9000.EmployeeID and AT1103.DivisionID in (''@@@'',AT9000.DivisionID)
 LEFT JOIN AT1011 A01 ON A01.AnaID = AT9000.Ana01ID AND A01.AnaTypeID =''A01'' and A01.DivisionID in (''@@@'',AT9000.DivisionID)
 LEFT JOIN AT1011 A02 ON A02.AnaID = AT9000.Ana02ID AND A02.AnaTypeID =''A02'' and A02.DivisionID in (''@@@'',AT9000.DivisionID)
 LEFT JOIN AT1011 A03 ON A03.AnaID = AT9000.Ana03ID AND A03.AnaTypeID =''A03'' and A03.DivisionID in (''@@@'',AT9000.DivisionID)
 LEFT JOIN AT1011 A04 ON A04.AnaID = AT9000.Ana04ID AND A04.AnaTypeID =''A04'' and A04.DivisionID in (''@@@'',AT9000.DivisionID)
 LEFT JOIN AT1011 A05 ON A05.AnaID = AT9000.Ana05ID AND A05.AnaTypeID =''A05'' and A05.DivisionID in (''@@@'',AT9000.DivisionID)
 LEFT JOIN AT1011 A06 ON A06.AnaID = AT9000.Ana06ID AND A06.AnaTypeID =''A06'' and A06.DivisionID in (''@@@'',AT9000.DivisionID)
 LEFT JOIN AT1011 A07 ON A07.AnaID = AT9000.Ana07ID AND A07.AnaTypeID =''A07'' and A07.DivisionID in (''@@@'',AT9000.DivisionID)
 LEFT JOIN AT1011 A08 ON A08.AnaID = AT9000.Ana08ID AND A08.AnaTypeID =''A08'' and A08.DivisionID in (''@@@'',AT9000.DivisionID)
 LEFT JOIN AT1011 A09 ON A09.AnaID = AT9000.Ana09ID AND A09.AnaTypeID =''A09'' and A09.DivisionID in (''@@@'',AT9000.DivisionID)
 LEFT JOIN AT1011 A10 ON A10.AnaID = AT9000.Ana10ID AND A10.AnaTypeID =''A10'' and A10.DivisionID in (''@@@'',AT9000.DivisionID)
		,
	AT0001

 Where 	AT9000.DivisionID = AT0001.DivisionID and
	TransactionTypeID =''T99'' and
	' + CASE WHEN @Flag = 1 THEN 'VoucherID IN (' + @VoucherID + ')' ELSE ' VoucherID IN ('''+@VoucherID+ ''')' END + ' and
	AT9000.DivisionID ='''+@DivisionID+''' 	 '

--print @sSQL1
--print @sSQL2
If Not Exists (Select 1 From sysObjects Where Name ='AV3015')
	Exec ('Create view AV3015 as '+@sSQL1+@sSQL2)
Else
	Exec( 'Alter view AV3015 as '+@sSQL1+@sSQL2)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
