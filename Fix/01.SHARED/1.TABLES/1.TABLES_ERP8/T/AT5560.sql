-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Thanh Nguyen
---- Modified on 14/04/2016 by Kim Vu ADD COLUMN DIEN NUOC, Khong su dung khoa trong table AT5560, se sinh tu dong so chung tu
---- Modified on 26/6/2019 by Kim Thư: Bổ sung cột DVBS, QC
---- Modified on 30/6/2020 by Đức Thông: Bổ sung cột SL ở hóa đơn import
---- Modified on 03/11/2020 by Đức Thông: Bổ sung 2 cột PRO, PTQ
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT5560]') AND type in (N'U'))
CREATE TABLE [dbo].[AT5560](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] nvarchar(3) NOT NULL,
	[Serial] [nvarchar](50) NOT NULL,
	[InvoiceNo] [nvarchar](50) NOT NULL,
	[InvoiceDate] [datetime] NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[TMB] [decimal](28, 8) NULL,
	[PQL] [decimal](28, 8) NULL,
	[TKO] [decimal](28, 8) NULL,
	[SL] [int] NULL,
 CONSTRAINT [PK_AT5560] PRIMARY KEY CLUSTERED 
(
	[Serial] ASC,
	[InvoiceNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT5560_TMB]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT5560] ADD  CONSTRAINT [DF_AT5560_TMB]  DEFAULT ((0)) FOR [TMB]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT5560_PQL]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT5560] ADD  CONSTRAINT [DF_AT5560_PQL]  DEFAULT ((0)) FOR [PQL]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT5560_TKO]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT5560] ADD  CONSTRAINT [DF_AT5560_TKO]  DEFAULT ((0)) FOR [TKO]
END

--	Add Columns DIEN NUOC
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT5560' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT5560' AND col.name = 'NUO')
        ALTER TABLE AT5560 ADD NUO DECIMAL(28,8) NULL DEFAULT (0)

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT5560' AND col.name = 'DIE')
        ALTER TABLE AT5560 ADD DIE DECIMAL(28,8) NULL DEFAULT (0)
    END
-- Bo khoa chinh
IF(EXISTS ( SELECT * FROM sys.key_constraints where Type = 'PK' AND  [parent_object_id] = OBJECT_ID('AT5560')))
	ALTER TABLE AT5560 DROP CONSTRAINT PK_AT5560

---- Modified on 26/6/2019 by Kim Thư: Bổ sung cột DVBS, QC
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT5560' AND xtype = 'U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id = tab.id WHERE tab.name = 'AT5560' AND col.name = 'DVBS')
	ALTER TABLE AT5560 ADD DVBS DECIMAL(28,8) NULL DEFAULT (0)

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id = tab.id WHERE tab.name = 'AT5560' AND col.name = 'QC')
	ALTER TABLE AT5560 ADD QC DECIMAL(28,8) NULL DEFAULT (0)
	
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id = tab.id WHERE tab.name = 'AT5560' AND col.name = 'SL')
	ALTER TABLE AT5560 ADD SL INT NULL DEFAULT (0)

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id = tab.id WHERE tab.name = 'AT5560' AND col.name = 'PRO')
	ALTER TABLE AT5560 ADD PRO DECIMAL(28,8) NULL DEFAULT (0)

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id = tab.id WHERE tab.name = 'AT5560' AND col.name = 'PTQ')
	ALTER TABLE AT5560 ADD PTQ DECIMAL(28,8) NULL DEFAULT (0)
END



