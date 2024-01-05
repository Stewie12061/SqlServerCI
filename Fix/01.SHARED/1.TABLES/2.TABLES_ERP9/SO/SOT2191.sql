-- <Summary>
---- 
-- <History>
---- Create on 25/10/2023 by Hoàng Long
---- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SOT2191]') AND type in (N'U'))
CREATE TABLE [dbo].[SOT2191](
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] [NVARCHAR](100) NOT NULL,
  [DeleteFlg] [TINYINT] DEFAULT (0) NULL,
  [VoucherID] [NVARCHAR](100) NULL,
  [VoucherNo] [NVARCHAR](100) NULL,
  [SeriNo] [NVARCHAR](100) NULL,
  [InventoryID] [NVARCHAR](100) NULL,
  [InventoryName] [NVARCHAR](100) NULL,
  [Quantity] [decimal](28, 8) NULL,
  [Long] [NVARCHAR](100) NULL,
  [Weight] [NVARCHAR](100) NULL,
  [High] [NVARCHAR](100) NULL,
  [Color] [NVARCHAR](100) NULL,
  [WarrantyPeriod] [NVARCHAR](100) NULL,
  [ItemCondition] [NVARCHAR](100) NULL,
  [CreateUserID] [NVARCHAR](100) NULL,
  [CreateDate] [DATETIME] NULL,
  [LastModifyUserID] [NVARCHAR](100) NULL,
  [LastModifyDate] [DATETIME] NULL,
CONSTRAINT [PK_SOT2191] PRIMARY KEY CLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

--- 06/11/2023 - Viết Toàn: Bổ sung 30 cột Quantity
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='SOT2191' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id=tab.id WHERE tab.name='SOT2191' AND col.name='Quantity01')
			ALTER TABLE SOT2191 ADD Quantity01 DECIMAL(28, 8) DEFAULT (0) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id=tab.id WHERE tab.name='SOT2191' AND col.name='Quantity02')
			ALTER TABLE SOT2191 ADD Quantity02 DECIMAL(28, 8) DEFAULT (0) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id=tab.id WHERE tab.name='SOT2191' AND col.name='Quantity03')
			ALTER TABLE SOT2191 ADD Quantity03 DECIMAL(28, 8) DEFAULT (0) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id=tab.id WHERE tab.name='SOT2191' AND col.name='Quantity04')
			ALTER TABLE SOT2191 ADD Quantity04 DECIMAL(28, 8) DEFAULT (0) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id=tab.id WHERE tab.name='SOT2191' AND col.name='Quantity05')
			ALTER TABLE SOT2191 ADD Quantity05 DECIMAL(28, 8) DEFAULT (0) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id=tab.id WHERE tab.name='SOT2191' AND col.name='Quantity06')
			ALTER TABLE SOT2191 ADD Quantity06 DECIMAL(28, 8) DEFAULT (0) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id=tab.id WHERE tab.name='SOT2191' AND col.name='Quantity07')
			ALTER TABLE SOT2191 ADD Quantity07 DECIMAL(28, 8) DEFAULT (0) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id=tab.id WHERE tab.name='SOT2191' AND col.name='Quantity08')
			ALTER TABLE SOT2191 ADD Quantity08 DECIMAL(28, 8) DEFAULT (0) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id=tab.id WHERE tab.name='SOT2191' AND col.name='Quantity09')
			ALTER TABLE SOT2191 ADD Quantity09 DECIMAL(28, 8) DEFAULT (0) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id=tab.id WHERE tab.name='SOT2191' AND col.name='Quantity10')
			ALTER TABLE SOT2191 ADD Quantity10 DECIMAL(28, 8) DEFAULT (0) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id=tab.id WHERE tab.name='SOT2191' AND col.name='Quantity11')
			ALTER TABLE SOT2191 ADD Quantity11 DECIMAL(28, 8) DEFAULT (0) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id=tab.id WHERE tab.name='SOT2191' AND col.name='Quantity12')
			ALTER TABLE SOT2191 ADD Quantity12 DECIMAL(28, 8) DEFAULT (0) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id=tab.id WHERE tab.name='SOT2191' AND col.name='Quantity13')
			ALTER TABLE SOT2191 ADD Quantity13 DECIMAL(28, 8) DEFAULT (0) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id=tab.id WHERE tab.name='SOT2191' AND col.name='Quantity14')
			ALTER TABLE SOT2191 ADD Quantity14 DECIMAL(28, 8) DEFAULT (0) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id=tab.id WHERE tab.name='SOT2191' AND col.name='Quantity15')
			ALTER TABLE SOT2191 ADD Quantity15 DECIMAL(28, 8) DEFAULT (0) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id=tab.id WHERE tab.name='SOT2191' AND col.name='Quantity16')
			ALTER TABLE SOT2191 ADD Quantity16 DECIMAL(28, 8) DEFAULT (0) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id=tab.id WHERE tab.name='SOT2191' AND col.name='Quantity17')
			ALTER TABLE SOT2191 ADD Quantity17 DECIMAL(28, 8) DEFAULT (0) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id=tab.id WHERE tab.name='SOT2191' AND col.name='Quantity18')
			ALTER TABLE SOT2191 ADD Quantity18 DECIMAL(28, 8) DEFAULT (0) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id=tab.id WHERE tab.name='SOT2191' AND col.name='Quantity19')
			ALTER TABLE SOT2191 ADD Quantity19 DECIMAL(28, 8) DEFAULT (0) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id=tab.id WHERE tab.name='SOT2191' AND col.name='Quantity20')
			ALTER TABLE SOT2191 ADD Quantity20 DECIMAL(28, 8) DEFAULT (0) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id=tab.id WHERE tab.name='SOT2191' AND col.name='Quantity21')
			ALTER TABLE SOT2191 ADD Quantity21 DECIMAL(28, 8) DEFAULT (0) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id=tab.id WHERE tab.name='SOT2191' AND col.name='Quantity22')
			ALTER TABLE SOT2191 ADD Quantity22 DECIMAL(28, 8) DEFAULT (0) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id=tab.id WHERE tab.name='SOT2191' AND col.name='Quantity23')
			ALTER TABLE SOT2191 ADD Quantity23 DECIMAL(28, 8) DEFAULT (0) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id=tab.id WHERE tab.name='SOT2191' AND col.name='Quantity24')
			ALTER TABLE SOT2191 ADD Quantity24 DECIMAL(28, 8) DEFAULT (0) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id=tab.id WHERE tab.name='SOT2191' AND col.name='Quantity25')
			ALTER TABLE SOT2191 ADD Quantity25 DECIMAL(28, 8) DEFAULT (0) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id=tab.id WHERE tab.name='SOT2191' AND col.name='Quantity26')
			ALTER TABLE SOT2191 ADD Quantity26 DECIMAL(28, 8) DEFAULT (0) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id=tab.id WHERE tab.name='SOT2191' AND col.name='Quantity27')
			ALTER TABLE SOT2191 ADD Quantity27 DECIMAL(28, 8) DEFAULT (0) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id=tab.id WHERE tab.name='SOT2191' AND col.name='Quantity28')
			ALTER TABLE SOT2191 ADD Quantity28 DECIMAL(28, 8) DEFAULT (0) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id=tab.id WHERE tab.name='SOT2191' AND col.name='Quantity29')
			ALTER TABLE SOT2191 ADD Quantity29 DECIMAL(28, 8) DEFAULT (0) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id=tab.id WHERE tab.name='SOT2191' AND col.name='Quantity30')
			ALTER TABLE SOT2191 ADD Quantity30 DECIMAL(28, 8) DEFAULT (0) NULL
	END
