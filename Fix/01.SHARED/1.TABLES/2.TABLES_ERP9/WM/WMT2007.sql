---- Create by Nguyễn Hoàng Bảo Thy on 2/26/2018 8:34:48 AM
---- Modified by Kim Thư on 11/07/2018 - Bổ sung cột ERPVoucherID - lưu lại VoucherID của phiếu ERP8 đã kế thừa dòng detail này
---- Thông tin detail Nhập-Xuất-VC WM-9.0
---- Modified by Trọng Phúc on 28/11/2023 - Bổ sung cột mã tài xế, mã xe

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[WMT2007]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[WMT2007]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [APKMaster] VARCHAR(50) NOT NULL,
  [InventoryID] VARCHAR(50) NOT NULL,
  [UnitID] VARCHAR(50) NULL,
  [UnitPrice] DECIMAL(28,8) NULL,
  [ActualQuantity] DECIMAL(28,8) NULL,
  [ActualAmount] DECIMAL(28,8) NULL,
  [ConvertedUnitID] VARCHAR(50) NULL,
  [ConvertedPrice] DECIMAL(28,8) NULL,
  [ConvertedQuantity] DECIMAL(28,8) NULL,
  [ConvertedAmount] DECIMAL(28,8) NULL,
  [TranMonth] INT NULL,
  [TranYear] INT NULL,
  [CurrencyID] VARCHAR(50) NULL,
  [ExchangeRate] DECIMAL(28,8) NULL,
  [InheritTableID] VARCHAR(50) NULL,
  [InheritAPKMaster] VARCHAR(50) NULL,
  [InheritAPK] VARCHAR(50) NULL,
  [Ana01ID] NVARCHAR(50) NULL,
  [Ana02ID] NVARCHAR(50) NULL,
  [Ana03ID] NVARCHAR(50) NULL,
  [Ana04ID] NVARCHAR(50) NULL,
  [Ana05ID] NVARCHAR(50) NULL,
  [Ana06ID] NVARCHAR(50) NULL,
  [Ana07ID] NVARCHAR(50) NULL,
  [Ana08ID] NVARCHAR(50) NULL,
  [Ana09ID] NVARCHAR(50) NULL,
  [Ana10ID] NVARCHAR(50) NULL,
  [Parameter01] DECIMAL(28,8) NULL,
  [Parameter02] DECIMAL(28,8) NULL,
  [Parameter03] DECIMAL(28,8) NULL,
  [Parameter04] DECIMAL(28,8) NULL,
  [Parameter05] DECIMAL(28,8) NULL,
  [Notes] NVARCHAR(250) NULL,
  [ConfirmStatus] TINYINT DEFAULT (0) NULL,
  [ConfirmDate] DATETIME NULL,
  [AWBNo] VARCHAR(50) NULL,
  [OrderNo] VARCHAR(50) NULL, --Số đơn hàng
  [HAWBNo] VARCHAR(50) NULL, --Số giao nhận
  [IsProInventoryID] TINYINT DEFAULT (0),
  [ObjectTHCPID] NVARCHAR(250) NULL,
  [ProductID] NVARCHAR(250) NULL
CONSTRAINT [PK_WMT2007] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WMT2007' AND xtype = 'U')
BEGIN
	------------------------------- Bổ sung ERP8VoucherID ----------------------------
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'WMT2007' AND col.name = 'ERP8VoucherID')
    ALTER TABLE WMT2007 ADD ERP8VoucherID VARCHAR(50) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'WMT2007' AND col.name = 'Notes')
    ALTER TABLE WMT2007 ADD Notes NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'WMT2007' AND col.name = 'AWBNo')
    ALTER TABLE WMT2007 ADD AWBNo VARCHAR(50) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'WMT2007' AND col.name = 'HAWBNo')
    ALTER TABLE WMT2007 ADD HAWBNo VARCHAR(50) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'WMT2007' AND col.name = 'ConfirmStatus')
    ALTER TABLE WMT2007 ADD ConfirmStatus TINYINT DEFAULT (0) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'WMT2007' AND col.name = 'ConfirmDate')
    ALTER TABLE WMT2007 ADD ConfirmDate DATETIME NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'WMT2007' AND col.name = 'OrderNo')
    ALTER TABLE WMT2007 ADD OrderNo VARCHAR(50) NULL 

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id = tab.id WHERE tab.name = 'WMT2007' AND col.name = 'IsProInventoryID')
	ALTER TABLE WMT2007 ADD [IsProInventoryID] TINYINT DEFAULT (0)

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'WMT2007' AND col.name = 'ObjectTHCPID')
    ALTER TABLE WMT2007 ADD ObjectTHCPID NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'WMT2007' AND col.name = 'ProductID')
    ALTER TABLE WMT2007 ADD ProductID NVARCHAR(250) NULL

	------------------------------- Bổ sung quy cách ----------------------------
	--Update loại bỏ quy cách (Bảng quy cách moudule WM: WT8899)--
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'WMT2007' AND col.name = 'S01ID') 
	ALTER TABLE WMT2007 DROP COLUMN S01ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'WMT2007' AND col.name = 'S02ID') 
	ALTER TABLE WMT2007 DROP COLUMN S02ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'WMT2007' AND col.name = 'S03ID') 
	ALTER TABLE WMT2007 DROP COLUMN S03ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'WMT2007' AND col.name = 'S04ID') 
	ALTER TABLE WMT2007 DROP COLUMN S04ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'WMT2007' AND col.name = 'S05ID') 
	ALTER TABLE WMT2007 DROP COLUMN S05ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'WMT2007' AND col.name = 'S06ID') 
	ALTER TABLE WMT2007 DROP COLUMN S06ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'WMT2007' AND col.name = 'S07ID') 
	ALTER TABLE WMT2007 DROP COLUMN S07ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'WMT2007' AND col.name = 'S08ID') 
	ALTER TABLE WMT2007 DROP COLUMN S08ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'WMT2007' AND col.name = 'S09ID') 
	ALTER TABLE WMT2007 DROP COLUMN S09ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'WMT2007' AND col.name = 'S10ID') 
	ALTER TABLE WMT2007 DROP COLUMN S10ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'WMT2007' AND col.name = 'S11ID') 
	ALTER TABLE WMT2007 DROP COLUMN S11ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'WMT2007' AND col.name = 'S12ID') 
	ALTER TABLE WMT2007 DROP COLUMN S12ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'WMT2007' AND col.name = 'S13ID') 
	ALTER TABLE WMT2007 DROP COLUMN S13ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'WMT2007' AND col.name = 'S14ID') 
	ALTER TABLE WMT2007 DROP COLUMN S14ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'WMT2007' AND col.name = 'S15ID') 
	ALTER TABLE WMT2007 DROP COLUMN S15ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'WMT2007' AND col.name = 'S16ID') 
	ALTER TABLE WMT2007 DROP COLUMN S16ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'WMT2007' AND col.name = 'S17ID') 
	ALTER TABLE WMT2007 DROP COLUMN S17ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'WMT2007' AND col.name = 'S18ID') 
	ALTER TABLE WMT2007 DROP COLUMN S18ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'WMT2007' AND col.name = 'S19ID') 
	ALTER TABLE WMT2007 DROP COLUMN S19ID

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'WMT2007' AND col.name = 'S20ID') 
	ALTER TABLE WMT2007 DROP COLUMN S20ID

	------------------------------- Bổ sung mã tài xế, mã xe ----------------------------
	IF EXISTS(SELECT * FROM CustomerIndex WHERE CustomerName = 166)
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'WMT2007' AND col.name = 'DriverID')
		ALTER TABLE WMT2007 ADD DriverID VARCHAR(50) NULL 

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'WMT2007' AND col.name = 'CarID')
		ALTER TABLE WMT2007 ADD CarID VARCHAR(50) NULL 
	END
END
