-- Bảng tạm lưu xử lý update phiếu nhập - xuất - VCNB
-- Modified by Kim Thư ON 27/03/2019 - Bổ sung ReTransactionID_OLD, ReVoucherID_OLD lưu thay đổi chứng từ nhập, InventoryID_Old lưu thay đổi mặt hàng, SourceNo_OLD lưu thay đổi lô nhập
-- Modified by Nhựt Trường on 22/12/2021: Angel - Bổ sung lại các cột còn thiếu ở bản 8.1 khi merge lên 8.3.7

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT20071]') AND type in (N'U'))
	CREATE TABLE AT20071
	(
	KindVoucherID TINYINT, 
	TransactionID NVARCHAR(50), 
	DivisionID NVARCHAR(50), ModuleID NVARCHAR(50), 
	VoucherTypeID NVARCHAR(50), 
	RDVoucherID NVARCHAR(50), RDVoucherNo NVARCHAR(50), 
	BatchID NVARCHAR(50), 
	RDVoucherDate Datetime, 
	TranYear Int, TranMonth int, 
	InventoryID NVARCHAR(50), UnitID NVARCHAR(50), 
	UnitPrice DECIMAL(28, 8), 
	CurrencyID NVARCHAR(50), ExchangeRate DECIMAL(28, 8), 
	ConvertedAmount DECIMAL(28, 8), OriginalAmount DECIMAL(28, 8), 
	DebitAccountID NVARCHAR(20), CreditAccountID NVARCHAR(20), 
	DebitAccountID_Old NVARCHAR(50), CreditAccountID_Old NVARCHAR(50), 
	DebitAccountID_New NVARCHAR(50), CreditAccountID_New NVARCHAR(50), 
	WareHouseID NVARCHAR(50), WareHouseID2 NVARCHAR(50), 
	Description NVARCHAR(255), SourceNo NVARCHAR(50), 
	LimitDate Datetime, 
	EmployeeID NVARCHAR(50), MethodID TINYINT, 
	ObjectID NVARCHAR(250), IsLimitDate TINYINT, 
	IsSource TINYINT, TableID NVARCHAR(50), 
	Ana01ID NVARCHAR(50), Ana02ID NVARCHAR(50), Ana03ID NVARCHAR(50), Ana04ID NVARCHAR(50), Ana05ID NVARCHAR(50), 
	Ana06ID NVARCHAR(50), Ana07ID NVARCHAR(50), Ana08ID NVARCHAR(50), Ana09ID NVARCHAR(50), Ana10ID NVARCHAR(50), 
	Notes NVARCHAR(250), PeriodID NVARCHAR(50), ProductID NVARCHAR(50), OrderID NVARCHAR(50), 
	IsTemp TINYINT, 
	OldQuantity DECIMAL(28, 8), NewQuantity DECIMAL(28, 8), OldConvertedAmount DECIMAL(28, 8), NewConvertedAmount DECIMAL(28, 8), 
	LastModifyDate DATETIME, LastModifyUserID NVARCHAR(50), 
	OldProductID NVARCHAR(50), NewProductID NVARCHAR(50), 
	OldPeriodID NVARCHAR(50), NewPeriodID NVARCHAR(50), OTransactionID NVARCHAR(50), MOrderID NVARCHAR(50), SOrderID NVARCHAR(50),
	Parameter01 DECIMAL(28,8), Parameter02 DECIMAL(28,8), Parameter03 DECIMAL(28,8), Parameter04 DECIMAL(28,8), Parameter05 DECIMAL(28,8),
	OldMarkQuantity DECIMAL(28,8), NewMarkQuantity DECIMAL(28,8),
	ReTransactionID NVARCHAR(50), ReVoucherID NVARCHAR(50),
	OldConvertedQuantity DECIMAL(28, 8), NewConvertedQuantity DECIMAL(28, 8),
	RefNo01 NVARCHAR(100),
	RefNo02 NVARCHAR(100),
	IsProduct TINYINT, CreateDate DATETIME, CreateUserID NVARCHAR(50),
	KITID NVARCHAR(50), KITQuantity DECIMAL(28,8),S01ID VARCHAR(50), S02ID VARCHAR(50), S03ID VARCHAR(50), S04ID VARCHAR(50),
	S05ID VARCHAR(50), S06ID VARCHAR(50), S07ID VARCHAR(50), S08ID VARCHAR(50), S09ID VARCHAR(50), S10ID VARCHAR(50),
	S11ID VARCHAR(50), S12ID VARCHAR(50), S13ID VARCHAR(50), S14ID VARCHAR(50), S15ID VARCHAR(50), S16ID VARCHAR(50),
	S17ID VARCHAR(50), S18ID VARCHAR(50), S19ID VARCHAR(50), S20ID VARCHAR(50)
	)
GO
-- Modified by Kim Thư ON 27/03/2019 - Bổ sung ReTransactionID_OLD, ReVoucherID_OLD lưu thay đổi chứng từ nhập, InventoryID_Old lưu thay đổi mặt hàng, SourceNo_OLD lưu thay đổi lô nhập
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT20071' AND xtype = 'U')
BEGIN 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'ReTransactionID_OLD') 
	ALTER TABLE AT20071 ADD ReTransactionID_OLD VARCHAR(50) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'ReVoucherID_OLD') 
	ALTER TABLE AT20071 ADD ReVoucherID_OLD VARCHAR(50) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'InventoryID_Old') 
	ALTER TABLE AT20071 ADD InventoryID_Old VARCHAR(50) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'SourceNo_OLD') 
	ALTER TABLE AT20071 ADD SourceNo_OLD VARCHAR(50) NULL

   -- Huỳnh Thử [23/07/2020] -- Bổ sung cột IsRound để phân biệt khi nào làm tròn
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'IsRound') 
   ALTER TABLE AT20071 ADD IsRound TINYINT DEFAULT 0 
END


---- Modified on 22/12/2021 by Nhựt Trường: Angel - Bổ sung lại các cột còn thiếu ở bản 8.1 khi merge lên 8.3.7 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT20071' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'RDVoucherDate') 
   ALTER TABLE AT20071 ADD RDVoucherDate Datetime

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'VoucherTypeID') 
   ALTER TABLE AT20071 ADD VoucherTypeID NVARCHAR(50)

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'ObjectID') 
   ALTER TABLE AT20071 ADD ObjectID NVARCHAR(250)

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'Description') 
   ALTER TABLE AT20071 ADD Description NVARCHAR(255)

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'LastModifyDate') 
   ALTER TABLE AT20071 ADD LastModifyDate DATETIME

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'LastModifyUserID') 
   ALTER TABLE AT20071 ADD LastModifyUserID NVARCHAR(50)

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'CurrencyID') 
   ALTER TABLE AT20071 ADD CurrencyID NVARCHAR(50)

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'ExchangeRate') 
   ALTER TABLE AT20071 ADD ExchangeRate DECIMAL(28, 8)

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'Ana01ID') 
   ALTER TABLE AT20071 ADD Ana01ID NVARCHAR(50)

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'Ana02ID') 
   ALTER TABLE AT20071 ADD Ana02ID NVARCHAR(50)

  IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'Ana03ID') 
   ALTER TABLE AT20071 ADD Ana03ID NVARCHAR(50)

  IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'Ana04ID') 
   ALTER TABLE AT20071 ADD Ana04ID NVARCHAR(50)

  IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'Ana05ID') 
   ALTER TABLE AT20071 ADD Ana05ID NVARCHAR(50)

  IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'Ana06ID') 
   ALTER TABLE AT20071 ADD Ana06ID NVARCHAR(50)

  IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'Ana07ID') 
   ALTER TABLE AT20071 ADD Ana07ID NVARCHAR(50)

  IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'Ana08ID') 
   ALTER TABLE AT20071 ADD Ana08ID NVARCHAR(50)

  IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'Ana09ID') 
   ALTER TABLE AT20071 ADD Ana09ID NVARCHAR(50)

  IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'Ana10ID') 
   ALTER TABLE AT20071 ADD Ana10ID NVARCHAR(50)

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'OldPeriodID') 
   ALTER TABLE AT20071 ADD OldPeriodID NVARCHAR(50)

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'NewPeriodID') 
   ALTER TABLE AT20071 ADD NewPeriodID NVARCHAR(50)

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'OldProductID') 
   ALTER TABLE AT20071 ADD OldProductID NVARCHAR(50)

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'NewProductID') 
   ALTER TABLE AT20071 ADD NewProductID NVARCHAR(50)

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'OTransactionID') 
   ALTER TABLE AT20071 ADD OTransactionID NVARCHAR(50)

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'MOrderID') 
   ALTER TABLE AT20071 ADD MOrderID NVARCHAR(50)

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'SOrderID') 
   ALTER TABLE AT20071 ADD SOrderID NVARCHAR(50)   

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'Parameter01') 
   ALTER TABLE AT20071 ADD Parameter01 DECIMAL(28,8)

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'Parameter02') 
   ALTER TABLE AT20071 ADD Parameter02 DECIMAL(28,8)

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'Parameter03') 
   ALTER TABLE AT20071 ADD Parameter03 DECIMAL(28,8)

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'Parameter04') 
   ALTER TABLE AT20071 ADD Parameter04 DECIMAL(28,8)

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'Parameter05') 
   ALTER TABLE AT20071 ADD Parameter05 DECIMAL(28,8)

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'NewMarkQuantity') 
   ALTER TABLE AT20071 ADD NewMarkQuantity DECIMAL(28,8)

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'ReVoucherID') 
   ALTER TABLE AT20071 ADD ReVoucherID NVARCHAR(50)   

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'SourceNo') 
   ALTER TABLE AT20071 ADD SourceNo NVARCHAR(50)

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'ReTransactionID') 
   ALTER TABLE AT20071 ADD ReTransactionID NVARCHAR(50)

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'OrderID') 
   ALTER TABLE AT20071 ADD OrderID NVARCHAR(50)

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT20071' AND col.name = 'Notes') 
   ALTER TABLE AT20071 ADD Notes NVARCHAR(250)
END