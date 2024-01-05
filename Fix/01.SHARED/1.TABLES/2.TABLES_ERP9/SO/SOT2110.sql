-- <Summary>
---- 
-- <History>
---- Create on 28/04/2021 by Đình Hòa: Bảng tính giá (Master)
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SOT2110]') AND type in (N'U'))
CREATE TABLE [dbo].[SOT2110](
	[APK] [uniqueidentifier] NOT NULL DEFAULT NEWID(),
	[DivisionID] [varchar](50) NOT NULL,
	[InventoryID] [varchar](50) NULL,
	[PriceOriginal] [decimal](28, 8) NULL,
	[ProfitRate] [decimal](28, 8) NULL,
	[ProfitDesired] [decimal](28, 8) NULL,
	[PriceSetFactory] [decimal](28, 8) NULL,
	[PriceAcreageFactory] [decimal](28, 8) NULL,
	[PriceSetInstall] [decimal](28, 8) NULL,
	[PriceAcreageInstall] [decimal](28, 8) NULL,
	[PriceRival] [decimal](28, 8) NULL,
	[IsInheritBOM] [tinyint] Null,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [varchar](50) NULL,
	[LastModifyUserID] [varchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[DeleteFlag] [int] NULL
	
 CONSTRAINT [PK_SOT2110] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

-- Thêm cột TranMonth, TranYear
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2110' AND col.name = 'TranMonth')
	BEGIN
    ALTER TABLE SOT2110 ADD TranMonth INT NULL
	END
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2110' AND col.name = 'TranYear')
	BEGIN
    ALTER TABLE SOT2110 ADD TranYear INT NULL
	END
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2110' AND col.name = 'SetNumber')
	BEGIN
    ALTER TABLE SOT2110 ADD SetNumber INT NULL
	END
END

--- Đình Hòa [21/06/2021] : Thêm cột trạng thái bảng tính(spreadsheet status)
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2110' AND col.name = 'StatusSS')
	BEGIN
    ALTER TABLE SOT2110 ADD StatusSS TINYINT NULL
	END
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2110' AND col.name = 'APKMaster_9000')
	BEGIN
    ALTER TABLE SOT2110 ADD APKMaster_9000 uniqueidentifier NULL
	END
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2110' AND col.name = 'VoucherNo')
	BEGIN
    ALTER TABLE SOT2110 ADD VoucherNo VARCHAR(50) NULL
	END
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2110' AND col.name = 'ColorID')
	BEGIN
    ALTER TABLE SOT2110 ADD ColorID VARCHAR(50) NULL
	END
END

-- 07/07/2021 Đình Hòa : Bổ sung cột AccountID và Address
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2110' AND col.name = 'AccountID')
	BEGIN
    ALTER TABLE SOT2110 ADD AccountID VARCHAR(50) NULL
	END
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2110' AND col.name = 'Address')
	BEGIN
    ALTER TABLE SOT2110 ADD [Address] NVARCHAR(MAX) NULL
	END
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2110' AND col.name = 'APK_InheritBOM')
	BEGIN
    ALTER TABLE SOT2110 ADD [APK_InheritBOM] VARCHAR(50) NULL
	END
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2110' AND col.name = 'ApprovingLevel')
	BEGIN
    ALTER TABLE SOT2110 ADD ApprovingLevel INT NULL
	END
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2110' AND col.name = 'ApproveLevel')
	BEGIN
    ALTER TABLE SOT2110 ADD ApproveLevel INT NULL
	END
END

