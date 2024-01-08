IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0348]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP0348]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Created by Nguyen Thi Ngoc Minh.
--- Date 15/09/2004
---- purpose: In bao cao chi tiet doi chieu cong no phai thu va phai tra cho cung 1 doi tuong
--- Edit by Nguyen Quoc Huy, Data 27.04/2007
---Last Edt : Thuy Tuyen 25/01/2007 Lay ten Ma phan tich 
---Edit by: Dang Le Bao Quynh; Date 08/11/2008
---Purpose: Bo sung truong TDescription cho view AV0348
---- Modified on 28/09/2011 by Le Thi Thu Hien : Chinh sua Division
---- Modify on 20/06/2012 by Bao Anh : Cai thien toc do
---- Modify on 18/03/2013 by bao Anh: Bo sung truong
---- Modified on 14/06/2013 by Thiên Huỳnh: Bổ sung Mã phân tích
---- Modified on 07/07/2014 by Thanh Sơn: Chuyển create view thành exec store
---- Modify on 13/04/2016 by Bảo Anh: Tạo view AV0348 để set location cho report (khắc phục lỗi in báo cáo chậm)
---- Modified by Tiểu Mai on 10/05/2016: Bổ sung lấy phiếu chi đã giải trừ cho hóa đơn mua hàng
---- Modified by Bảo Thy on 26/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Tiểu Mai on 27/05/2016: Bổ sung các trường: Contactor, Note, Note1, BankName, BankAccountNo, LicenseNo cho ANPHAT
---- Modified by Tiểu Mai on 15/12/2016: Fix bị double công nợ do có nhiều ngày giải trừ cho 1 hóa đơn
---- Modified by Tiểu Mai on 27/12/2016: Bỏ lấy phiếu chi đã giải trừ cho hóa đơn mua hàng
---- Modified by Bảo Thy on 29/11/2017: Bỏ đoạn "Tạo view AV0348 để set location"
---- Modified by Huỳnh Thử on 09/11/2020: Bổ sung trường DParameter01, DParameter02, DParameter03, DParameter04, DParameter05
---- Modified by Nhựt Trường on 01/04/2021: Bổ sung các trường DivisionName, DivisionAddress, DivisionTel, DivisionFax, DivisionVATNo
---- Modified by Nhựt Trường on 15/04/2021: Fix lỗi Ambiguous column name ''.
---- Modified by Nhựt Trường on 27/04/2021: Bổ sung Where theo DivisionID khi lấy dữ liệu từ AT0368.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
/***************************************************************
'* Edited by : [GS] [Quoc Cuong] [29/07/2010]
					[Hoang Phuoc] [16/11/2010] 
'**************************************************************/

CREATE PROCEDURE [dbo].[AP0348] 
				@DivisionID as nvarchar(50), 
				@FromObjectID  as nvarchar(50),  
				@ToObjectID  as nvarchar(50),  
				@FromRecAccountID  as nvarchar(50),  
				@ToRecAccountID  as nvarchar(50), 
				@FromPayAccountID  as nvarchar(50),  
				@ToPayAccountID  as nvarchar(50), 
				@CurrencyID  as nvarchar(50),  
				@FromInventoryID as nvarchar(50),
				@ToInventoryID as nvarchar(50),
				@IsDate as tinyint, 
				@FromMonth as int, 
				@FromYear  as int,  
				@ToMonth as int,
				@ToYear as int,
				@FromDate as Datetime, 
				@ToDate as Datetime,
				@IsPayable TINYINT
				--@Orderby NVARCHAR(4000)

AS

Declare @sSQL as nvarchar(4000), @sSQL1 as nvarchar(max)
Declare @AccountName as nvarchar(250),
		@CurrencyName as nvarchar(250)


Set @CurrencyName = (Case When  Isnull(@CurrencyID,'') ='%' then 'Tất cả' else Isnull(@CurrencyID,'') End) 

	EXEC AP0368 @DivisionID, @FromObjectID, @ToObjectID, @FromRecAccountID, @ToRecAccountID,
				@FromPayAccountID, @ToPayAccountID, @CurrencyID, @FromInventoryID, 
				@ToInventoryID, @IsDate, @FromMonth, @FromYear, @FromDate, @IsPayable



	EXEC AP0358 @DivisionID, @FromObjectID, @ToObjectID, @FromRecAccountID, @ToRecAccountID,
				@FromPayAccountID, @ToPayAccountID, @CurrencyID,  @FromInventoryID, 
				@ToInventoryID, @IsDate, @FromMonth, @FromYear, @ToMonth, @ToYear, @FromDate, @ToDate, @IsPayable
/*
--- tạo view để set location cho report, khắc phục lỗi in báo cáo chậm
IF  EXISTS (SELECT TOP 1 1 FROM sys.views WITH (NOLOCK) WHERE object_id = OBJECT_ID(N'[dbo].[AV0348]'))
	DROP VIEW [dbo].[AV0348]

Set @sSQL='CREATE VIEW AV0348
AS
SELECT 	Top 0 Isnull(AV0358.ObjectID, AT0368.ObjectID) as GroupID,
		Isnull(AV0358.ObjectName, AT0368.ObjectName) as GroupName, 
		---AT0368.InvoiceList, 
		---AT0368.InvoiceDateList, 

		case when isnull(AT0368.ObjectAddress,'''')='''' then AV0358.Address else AT0368.ObjectAddress end as ObjectAddress,
		
		isnull(AT0368.Tel, AV0358.Tel) as TEL,
		isnull(AT0368.Fax, AV0358.Fax) as FAX,
		isnull(AT0368.Email, AV0358.Email) as  EMAIL,
		isnull(AT0368.VATNo, AV0358.VATNo) as VATNo,

		isnull(At0368.S1,AV0358.S1) as  S1,
		isnull(At0368.S2, AV0358.S2) as  S2,
		isnull( At0368.S3, AV0358.S3) as  S3,
		isnull( At0368.O01ID,AV0358.O01ID) as  O01ID,
		isnull(At0368.O02ID, AV0358.O02ID) as  O02ID,
		isnull(At0368.O03ID, AV0358.O03ID) as  O03ID,
		isnull( At0368.O04ID, AV0358.O04ID) as  O04ID,
		isnull( At0368.O05ID,AV0358.O05ID) as  O05ID,

		
		isnull(AV0358.R_P, Case when isnull(ReBeConvertedAmount,0)=0 then ''P'' else ''R'' end) as R_P,
		'''+@CurrencyName+''' as CurrencyID, TransactionTypeID,
		VoucherDate,
		VoucherNo,
		VoucherID,
		BatchID,
		VoucherTypeID,
		InvoiceDate,
		InvoiceNo,
		Serial,
		DebitAccountID, CreditAccountID,
		Ana01ID, AnaName01, Ana02ID, AnaName02, Ana03ID, AnaName03, Ana04ID, AnaName04, Ana05ID, AnaName05,
		Ana06ID, AnaName06, Ana07ID, AnaName07, Ana08ID, AnaName08, Ana09ID, AnaName09, Ana10ID, AnaName10,
		AV0358.InventoryID,
		AV0358.InventoryName,
		AV0358.TDescription,
		AV0358.VDescription,
		AV0358.BDescription,
		isnull(DebitOriginalAmount,0) as DebitOriginalAmount, 
		isnull(DebitConvertedAmount,0) as DebitConvertedAmount, 
		isnull(DebitQuantity,0) as DebitQuantity, 
		isnull(DebitUnitPrice,0) as DebitUnitPrice,
		isnull(DebitDiscountRate,0) as DebitDiscountRate,
		isnull(CreditOriginalAmount,0) as CreditOriginalAmount,
		isnull(CreditConvertedAmount,0) as CreditConvertedAmount,
		isnull(CreditQuantity,0) as CreditQuantity,
		isnull(ReBeConvertedAmount,0) as OpeningRecConvertedAmount,
		isnull(ReBeOriginalAmount,0) as OpeningRecOriginalAmount,
		isnull(PaBeConvertedAmount,0) as OpeningPayConvertedAmount,
		isnull(PaBeOriginalAmount,0) as OpeningPayOriginalAmount,
		(Select Sum(ConvertedAmount) From AV4202  Where ObjectID = AT0368.ObjectID And Ana03ID = AV0358.Ana03ID) as OpeningAna03ID,
		ISNULL(AV0358.DivisionID, AT0368.DivisionID) AS DivisionID,
		AV0358.Parameter01, AV0358.Parameter02, AV0358.Parameter03, AV0358.Parameter04, AV0358.Parameter05,
		AV0358.ConvertedUnitID, AV0358.ConvertedUnitName, AV0358.DebitConvertedQuantity, AV0358.CreditConvertedQuantity,
		isnull(MarkQuantity,0) as MarkQuantity
		
FROM		AV0358
FULL JOIN	(Select DivisionID, ObjectID, ObjectName, ObjectAddress, Tel, Fax, Email, VATNo, S1, S2, S3, O01ID, O02ID, O03ID, O04ID, O05ID,
		Sum(ReBeConvertedAmount) as ReBeConvertedAmount, Sum(ReBeOriginalAmount) as ReBeOriginalAmount, Sum(PaBeConvertedAmount) as PaBeConvertedAmount, 
		Sum(PaBeOriginalAmount) as PaBeOriginalAmount FROM AT0368 WITH (NOLOCK) 
         	GROUP BY DivisionID, ObjectID, ObjectName, ObjectAddress, Tel, Fax, Email, VATNo, S1, S2, S3, O01ID, O02ID, O03ID, O04ID, O05ID) AT0368  
	ON 		AT0368.ObjectID = AV0358.ObjectID 
			AND AT0368.DivisionID = AV0358.DivisionID'
EXEC(@sSQL)
*/
--SET @sSQL = '
--SELECT AT0404.DivisionID, AT0404.ObjectID, AT0404.AccountID, AT0404.CurrencyID, AT0404.DebitVoucherID, AT0404.DebitBatchID, AT9000.VoucherNo as DebitVoucherNo, 
--		AT0404.DebitVoucherDate, AT0404.CreditVoucherID, AT0404.CreditBatchID, --AT0404.CreditVoucherDate, 
--		SUM(ISNULL(AT0404.OriginalAmount,0)) AS OriginalAmount, SUM(ISNULL(AT0404.ConvertedAmount,0)) AS ConvertedAmount
--FROM AT0404 WITH (NOLOCK)
--LEFT JOIN AT9000 WITH (NOLOCK) ON AT0404.DivisionID = AT9000.DivisionID AND AT0404.DebitVoucherID = AT9000.VoucherID AND AT0404.DebitBatchID = AT9000.BatchID
--WHERE AT0404.DivisionID = '''+@DivisionID+''' AND
--	AT0404.ObjectID BETWEEN '''+@FromObjectID+''' AND '''+@ToObjectID+''' AND 
--	AT0404.AccountID BETWEEN '''+@FromPayAccountID+''' AND '''+@ToPayAccountID+''' AND 
--	AT0404.CurrencyID LIKE '''+@CurrencyID+'''
--GROUP BY AT0404.DivisionID, AT0404.ObjectID, AT0404.AccountID, AT0404.CurrencyID, AT0404.DebitVoucherID, AT0404.DebitBatchID, AT0404.DebitVoucherDate, 
--		AT0404.CreditVoucherID, AT0404.CreditBatchID, AT9000.VoucherNo --, AT0404.CreditVoucherDate
--'	

--IF  EXISTS (SELECT * FROM sys.views WITH (NOLOCK) WHERE object_id = OBJECT_ID(N'[dbo].[AV03481]'))
--	DROP VIEW [dbo].[AV03481]
--EXEC ('  CREATE VIEW AV03481
--			AS ' + @sSQL)

Set @sSQL='
SELECT 	Isnull(AV0358.ObjectID, AT0368.ObjectID) as GroupID,
		Isnull(AV0358.ObjectName, AT0368.ObjectName) as GroupName, 
		---AT0368.InvoiceList, 
		---AT0368.InvoiceDateList, 

		case when isnull(AT0368.ObjectAddress,'''')='''' then AV0358.Address else AT0368.ObjectAddress end as ObjectAddress,
		
		isnull(AT0368.Tel, AV0358.Tel) as TEL,
		isnull(AT0368.Fax, AV0358.Fax) as FAX,
		isnull(AT0368.Email, AV0358.Email) as  EMAIL,
		isnull(AT0368.VATNo, AV0358.VATNo) as VATNo,

		isnull(At0368.S1,AV0358.S1) as  S1,
		isnull(At0368.S2, AV0358.S2) as  S2,
		isnull( At0368.S3, AV0358.S3) as  S3,
		isnull( At0368.O01ID,AV0358.O01ID) as  O01ID,
		isnull(At0368.O02ID, AV0358.O02ID) as  O02ID,
		isnull(At0368.O03ID, AV0358.O03ID) as  O03ID,
		isnull( At0368.O04ID, AV0358.O04ID) as  O04ID,
		isnull( At0368.O05ID,AV0358.O05ID) as  O05ID,

		
		isnull(AV0358.R_P, Case when isnull(ReBeConvertedAmount,0)=0 then ''P'' else ''R'' end) as R_P,
		'''+@CurrencyName+''' as CurrencyID, TransactionTypeID,
		VoucherDate,
		VoucherNo,
		VoucherTypeID,
		InvoiceDate,
		InvoiceNo,
		Serial,
		DebitAccountID, CreditAccountID,
		Ana01ID, AnaName01, Ana02ID, AnaName02, Ana03ID, AnaName03, Ana04ID, AnaName04, Ana05ID, AnaName05,
		Ana06ID, AnaName06, Ana07ID, AnaName07, Ana08ID, AnaName08, Ana09ID, AnaName09, Ana10ID, AnaName10,
		AV0358.InventoryID,
		AV0358.InventoryName,
		AV0358.TDescription,
		AV0358.VDescription,
		AV0358.BDescription,
		isnull(DebitOriginalAmount,0) as DebitOriginalAmount, 
		isnull(DebitConvertedAmount,0) as DebitConvertedAmount, 
		isnull(DebitQuantity,0) as DebitQuantity, 
		isnull(DebitUnitPrice,0) as DebitUnitPrice,
		isnull(DebitDiscountRate,0) as DebitDiscountRate,
		isnull(CreditOriginalAmount,0) as CreditOriginalAmount,
		isnull(CreditConvertedAmount,0) as CreditConvertedAmount,
		isnull(CreditQuantity,0) as CreditQuantity,
		isnull(ReBeConvertedAmount,0) as OpeningRecConvertedAmount,
		isnull(ReBeOriginalAmount,0) as OpeningRecOriginalAmount,
		isnull(PaBeConvertedAmount,0) as OpeningPayConvertedAmount,
		isnull(PaBeOriginalAmount,0) as OpeningPayOriginalAmount,
		(Select Sum(ConvertedAmount) From AV4202  Where ObjectID = AT0368.ObjectID And Ana03ID = AV0358.Ana03ID) as OpeningAna03ID,
		ISNULL(AV0358.DivisionID, AT0368.DivisionID) AS DivisionID,
		AV0358.Parameter01, AV0358.Parameter02, AV0358.Parameter03, AV0358.Parameter04, AV0358.Parameter05,
		AV0358.DParameter01, AV0358.DParameter02, AV0358.DParameter03, AV0358.DParameter04, AV0358.DParameter05,
		AV0358.ConvertedUnitID, AV0358.ConvertedUnitName, AV0358.DebitConvertedQuantity, AV0358.CreditConvertedQuantity,
		isnull(MarkQuantity,0) as MarkQuantity
		--,
		--AV03481.DebitVoucherNo,
		--AV03481.DebitVoucherDate,
		--AV03481.OriginalAmount as DebitPayOriginalAmount,
		--AV03481.ConvertedAmount as DebitPayConvertedAmount,
		--AV0358.Contactor, AV0358.Note, AV0358.Note1, AV0358.BankName, AV0358.BankAccountNo, AV0358.LicenseNo

		, ISNULL(AV0358.DivisionName, AT0368.DivisionName) AS DivisionName, ISNULL(AV0358.DivisionAddress, AT0368.DivisionAddress) AS DivisionAddress
		, ISNULL(AV0358.DivisionTel, AT0368.DivisionTel) AS DivisionTel, ISNULL(AV0358.DivisionFax, AT0368.DivisionFax) AS DivisionFax
		, ISNULL(AV0358.DivisionVATNo, AT0368.DivisionVATNo) AS DivisionVATNo
		, isnull(AT0368.Note, AV0358.Note) as Note '
		
Set @sSQL1 = '
FROM		AV0358
FULL JOIN	(Select AT0368.DivisionID, AT0368.ObjectID, AT0368.ObjectName, ObjectAddress, AT0368.Tel, AT0368.Fax, AT0368.Email, AT0368.VATNo,
		AT0368.S1, AT0368.S2, AT0368.S3, AT0368.O01ID, AT0368.O02ID, AT0368.O03ID, AT0368.O04ID, AT0368.O05ID,
		Sum(ReBeConvertedAmount) as ReBeConvertedAmount, Sum(ReBeOriginalAmount) as ReBeOriginalAmount, Sum(PaBeConvertedAmount) as PaBeConvertedAmount, 
		Sum(PaBeOriginalAmount) as PaBeOriginalAmount
		, AT1101.DivisionName, AT1101.Address as DivisionAddress, AT1101.Tel as DivisionTel, AT1101.Fax as DivisionFax
		, AT1101.VATNo as DivisionVATNo, AT1202.Note
		FROM AT0368  WITH (NOLOCK)
		LEFT JOIN AT1101  WITH (NOLOCK) on AT0368.DivisionID = AT1101.DivisionID
		LEFT JOIN AT1202  WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT0368.ObjectID = AT1202.ObjectID
		WHERE AT0368.DivisionID IN ('''+@DivisionID+''', ''@@@'')
         	GROUP BY AT0368.DivisionID, AT0368.ObjectID, AT0368.ObjectName, ObjectAddress, AT0368.Tel, AT0368.Fax, AT0368.Email, AT0368.VATNo, AT0368.S1, AT0368.S2, AT0368.S3, AT0368.O01ID, AT0368.O02ID, AT0368.O03ID, AT0368.O04ID, AT0368.O05ID,
			AT1101.DivisionName, AT1101.Address, AT1101.Tel, AT1101.Fax, AT1101.VATNo, AT1202.Note
			) AT0368 ON	AT0368.ObjectID = AV0358.ObjectID AND AT0368.DivisionID = AV0358.DivisionID
--LEFT JOIN AV03481 ON AV0358.DivisionID = AV03481.DivisionID AND AV0358.VoucherID = AV03481.CreditVoucherID AND AV0358.BatchID = AV03481.CreditBatchID
LEFT JOIN AT1101  WITH (NOLOCK) on AV0358.DivisionID = AT1101.DivisionID '

--print @sSQL + @sSQL1
EXEC (@sSQL + @sSQL1)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON