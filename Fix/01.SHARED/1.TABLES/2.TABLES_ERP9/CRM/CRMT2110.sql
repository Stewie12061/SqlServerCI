---- Create by Minh Dũng 13/11/2023
---- Update by Minh Dũng 20/11/2023: Bổ sung một số cột cần thiết
---- Dự toán ( NKC = 166) 
-- - DROP TABLE CRMT2110

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CRMT2110]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CRMT2110]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [VoucherTypeID] VARCHAR(50) NULL,
  [TranMonth] INT NULL,
  [Tranyear] INT NULL,
  [VoucherDate] DATETIME NULL,
  [VoucherNo] VARCHAR(50) NULL,
  [InventoryID] VARCHAR(50) NULL,
  [ApprovePerson01ID] VARCHAR(50) NULL,
  [ApprovePerson01Status] INT NULL, 
  [ObjectID] VARCHAR(50) NULL,
  [Address] NVARCHAR(250) NULL,
  [DeliveryTime] DATETIME NULL
  
 
CONSTRAINT [PK_CRMT2110] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---- Modified by Kiều Nga on 17/02/2020: Bổ sung trường APKMaster_9000
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CRMT2110' AND col.name = 'APKMaster_9000')
    ALTER TABLE CRMT2110 ADD APKMaster_9000 UNIQUEIDENTIFIER NULL
END

---- Modified by Kiều Nga on 17/02/2020: Bổ sung trường Status
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CRMT2110' AND col.name = 'Status')
    ALTER TABLE CRMT2110 ADD Status tinyint NULL DEFAULT ((0))
END

---- Modified by Đình Ly on 07/12/2020: Update tên cột Địa chỉ giao hàng.
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2111' AND xtype = 'U') 
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CRMT2110' AND col.name = 'Address')
	EXEC sp_RENAME 'CRMT2110.Address', 'DeliveryAddressName', 'COLUMN'
END

---- Modified by Đình Ly on 07/12/2020: Thêm cột bảng được kế thừa.
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CRMT2110' AND col.name = 'TableInherited')
    ALTER TABLE CRMT2110 ADD TableInherited VARCHAR(50) NULL
END

---- Modified by Đình Ly on 28/12/2020: Thêm cột bán thành phẩm.
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CRMT2110' AND col.name = 'SemiProduct')
    ALTER TABLE CRMT2110 ADD SemiProduct VARCHAR(50) NULL
END


IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2110' AND col.name = 'S01ID') 
	ALTER TABLE CRMT2110 ADD S01ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2110' AND col.name = 'S02ID') 
	ALTER TABLE CRMT2110 ADD S02ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2110' AND col.name = 'S03ID') 
	ALTER TABLE CRMT2110 ADD S03ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2110' AND col.name = 'S04ID') 
	ALTER TABLE CRMT2110 ADD S04ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2110' AND col.name = 'S05ID') 
	ALTER TABLE CRMT2110 ADD S05ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2110' AND col.name = 'S06ID') 
	ALTER TABLE CRMT2110 ADD S06ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2110' AND col.name = 'S07ID') 
	ALTER TABLE CRMT2110 ADD S07ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2110' AND col.name = 'S08ID') 
	ALTER TABLE CRMT2110 ADD S08ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2110' AND col.name = 'S09ID') 
	ALTER TABLE CRMT2110 ADD S09ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2110' AND col.name = 'S10ID') 
	ALTER TABLE CRMT2110 ADD S10ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2110' AND col.name = 'S11ID') 
	ALTER TABLE CRMT2110 ADD S11ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2110' AND col.name = 'S12ID') 
	ALTER TABLE CRMT2110 ADD S12ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2110' AND col.name = 'S13ID') 
	ALTER TABLE CRMT2110 ADD S13ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2110' AND col.name = 'S14ID') 
	ALTER TABLE CRMT2110 ADD S14ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2110' AND col.name = 'S15ID') 
	ALTER TABLE CRMT2110 ADD S15ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2110' AND col.name = 'S16ID') 
	ALTER TABLE CRMT2110 ADD S16ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2110' AND col.name = 'S17ID') 
	ALTER TABLE CRMT2110 ADD S17ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2110' AND col.name = 'S18ID') 
	ALTER TABLE CRMT2110 ADD S18ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2110' AND col.name = 'S19ID') 
	ALTER TABLE CRMT2110 ADD S19ID NVARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2110' AND col.name = 'S20ID') 
	ALTER TABLE CRMT2110 ADD S20ID NVARCHAR(50) NULL
END

-- [Minh Dũng]: 20/11/2023: Bổ sung cột
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2110' AND col.name = 'PriceListID') 
	ALTER TABLE CRMT2110 ADD PriceListID VARCHAR(50) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2110' AND col.name = 'APK_BomVersion') 
	ALTER TABLE CRMT2110 ADD APK_BomVersion VARCHAR(50) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2110' AND col.name = 'ActualQuantity') 
	ALTER TABLE CRMT2110 ADD ActualQuantity DECIMAL (28,8) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2110' AND col.name = 'TotalAmount') 
	ALTER TABLE CRMT2110 ADD TotalAmount DECIMAL (28,8) NULL
END