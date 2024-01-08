---- Đình Hòa on 13/01/2020 : Chuyển fix từ Dự án sàn STD 
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OT2003_MT]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[OT2003_MT](
		[APK] [uniqueidentifier] NOT NULL,
		[DivisionID] [nvarchar](3) NOT NULL,
		[SOrderID] [nvarchar](50) NOT NULL,
		[Date] [datetime] NULL,
		[Address] [nvarchar](250) NULL,
		[Quantity] [nvarchar](50) NULL,
		[InheritVoucherID] [nvarchar](50) NULL,
		[InheritTransactionID] [nvarchar](50) NULL,
		[DeleteFlg] [tinyint] NULL,
		[CreateUserID] [nvarchar](50) NULL,
		[CreateDate] [datetime] NULL,
		[LastModifyUserID] [nvarchar](50) NULL,
		[LastModifyDate] [datetime] NULL,
	 CONSTRAINT [PK_OT2003_MT] PRIMARY KEY CLUSTERED 
	(
		[APK] ASC,
		[DivisionID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
	ALTER TABLE [dbo].[OT2003_MT] ADD  DEFAULT (newid()) FOR [APK]
	ALTER TABLE [dbo].[OT2003_MT] ADD  DEFAULT ((0)) FOR [DeleteFlg]
END

	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OT2003_MT' AND col.name = 'DivisionID')
BEGIN
	ALTER TABLE OT2003_MT DROP CONSTRAINT [PK_OT2003_MT]
	ALTER TABLE OT2003_MT ADD CONSTRAINT [PK_OT2003_MT] PRIMARY KEY ([APK])
	ALTER TABLE OT2003_MT ALTER COLUMN DivisionID VARCHAR(10) NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003_MT' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003_MT' AND col.name='WarrantyID')
		ALTER TABLE OT2003_MT ADD WarrantyID NVARCHAR(50) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003_MT' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003_MT' AND col.name='DInheritVoucherID')
		ALTER TABLE OT2003_MT ADD DInheritVoucherID NVARCHAR(50) NULL
	END