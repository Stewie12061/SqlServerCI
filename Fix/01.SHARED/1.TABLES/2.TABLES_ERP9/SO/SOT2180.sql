---- Create by Trà Giang on 26/11/2019
---- Dự toán ( MAITHU = 107) 

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[SOT2180]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[SOT2180]
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
  
 
CONSTRAINT [PK_SOT2180] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---- Modified by Kiều Nga on 17/02/2020: Bổ sung trường APKMaster_9000
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2180' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2180' AND col.name = 'APKMaster_9000')
    ALTER TABLE SOT2180 ADD APKMaster_9000 UNIQUEIDENTIFIER NULL
END

---- Modified by Kiều Nga on 17/02/2020: Bổ sung trường Status
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2180' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2180' AND col.name = 'Status')
    ALTER TABLE SOT2180 ADD Status tinyint NULL DEFAULT ((0))
END

---- Modified by Đình Ly on 07/12/2020: Update tên cột Địa chỉ giao hàng.
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2111' AND xtype = 'U') 
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2180' AND col.name = 'Address')
	EXEC sp_RENAME 'SOT2180.Address', 'DeliveryAddressName', 'COLUMN'
END

---- Modified by Đình Ly on 07/12/2020: Thêm cột bảng được kế thừa.
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2180' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2180' AND col.name = 'TableInherited')
    ALTER TABLE SOT2180 ADD TableInherited VARCHAR(50) NULL
END

---- Modified by Đình Ly on 28/12/2020: Thêm cột bán thành phẩm.
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2180' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2180' AND col.name = 'SemiProduct')
    ALTER TABLE SOT2180 ADD SemiProduct VARCHAR(50) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
ON col.id = tab.id WHERE tab.name = 'SOT2080' AND col.name = 'InheritAPKMaster')
BEGIN
	ALTER TABLE SOT2080 ADD InheritAPKMaster [uniqueidentifier] NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
ON col.id = tab.id WHERE tab.name = 'SOT2080' AND col.name = 'InheritAPKDetail')
BEGIN
	ALTER TABLE SOT2080 ADD InheritAPKDetail [uniqueidentifier] NULL
END
