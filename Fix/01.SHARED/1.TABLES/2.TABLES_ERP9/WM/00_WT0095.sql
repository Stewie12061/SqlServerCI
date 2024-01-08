IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[WT0095]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[WT0095]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
      [TranMonth] INT NOT NULL,
      [TranYear] INT NOT NULL,
      [VoucherTypeID] VARCHAR(50) NULL,
      [VoucherID] VARCHAR(50) NOT NULL,
      [VoucherNo] VARCHAR(50) NULL,
      [VoucherDate] DATETIME NULL,
      [RefNo01] NVARCHAR(100) NULL,
      [RefNo02] NVARCHAR(100) NULL,
      [ObjectID] VARCHAR(50) NULL,
      [WareHouseID] VARCHAR(50) NULL,
      [InventoryTypeID] VARCHAR(50) NULL,
      [EmployeeID] VARCHAR(50) NULL,
      [ContactPerson] NVARCHAR(250) NULL,
      [RDAddress] NVARCHAR(250) NULL,
      [Description] NVARCHAR(1000) NULL,
      [TableID] VARCHAR(50) NULL,
      [ProjectID] VARCHAR(50) NULL,
      [OrderID] VARCHAR(50) NULL,
      [BatchID] VARCHAR(50) NULL,
      [ReDeTypeID] VARCHAR(50) NULL,
      [KindVoucherID] INT NULL,
      [WareHouseID2] VARCHAR(50) NULL,
      [Status] TINYINT DEFAULT (0) NULL,
      [VATObjectName] NVARCHAR(250) NULL,
      [IsGoodsFirstVoucher] TINYINT DEFAULT (0) NULL,
      [MOrderID] VARCHAR(50) NULL,
      [ApportionID] VARCHAR(50) NULL,
      [IsInheritWarranty] TINYINT DEFAULT (0) NULL,
      [EVoucherID] NVARCHAR(500) NULL,
      [IsGoodsRecycled] TINYINT DEFAULT (0) NULL,
      [RefVoucherID] VARCHAR(50) NULL,
      [IsCheck] TINYINT DEFAULT (0) NULL,
      [IsVoucher] TINYINT DEFAULT (0) NULL,
      [CreateUserID] VARCHAR(50) NULL,
      [CreateDate] DATETIME NULL,
      [LastModifyUserID] VARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL,
      [StandardPrice] DECIMAL(28,8) DEFAULT (0) NULL
    CONSTRAINT [PK_WT0095] PRIMARY KEY CLUSTERED
      (
      [DivisionID],
      [VoucherID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

----- 16/03/2022 - Hoài Bảo: Bổ sung cột ApproveLevel
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'WT0095' AND col.name = 'ApproveLevel')
BEGIN
	ALTER TABLE WT0095 ADD ApproveLevel INT NULL
END

----- 16/03/2022 - Hoài Bảo: Bổ sung cột ApprovingLevel
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'WT0095' AND col.name = 'ApprovingLevel')
BEGIN
	ALTER TABLE WT0095 ADD ApprovingLevel INT NULL
END

--- 16/03/2022 - Hoài Bảo: Bổ sung cột APKMaster_9000
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'WT0095' AND xtype = 'U') 
BEGIN
    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'WT0095' AND col.name = 'APKMaster_9000')
    ALTER TABLE WT0095 ADD APKMaster_9000 UNIQUEIDENTIFIER NULL
END

--- 16/03/2022 - Hoài Bảo: Bổ sung cột APKMaster
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'WT0095' AND xtype = 'U') 
BEGIN
    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'WT0095' AND col.name = 'APKMaster')
    ALTER TABLE WT0095 ADD APKMaster UNIQUEIDENTIFIER NULL
END

--- 15/09/2023 - Hoàng Long: Bổ sung cột PONumber
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'WT0095' AND xtype = 'U') 
BEGIN
    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'WT0095' AND col.name = 'PONumber')
    ALTER TABLE WT0095 ADD PONumber NVARCHAR(50) NULL
END