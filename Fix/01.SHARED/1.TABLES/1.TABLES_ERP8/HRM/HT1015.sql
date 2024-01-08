-- <Summary>
---- 
-- <History>
---- Create on 11/10/2010 by Thanh Trẫm
---- Modified on 15/03/2021 by Lê Hoàng: Bổ sung cột Kế thừa từ CI, mã khuôn (MAITHU)
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT1015]') AND type in (N'U'))
CREATE TABLE [dbo].[HT1015](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[ProductID] [nvarchar](50) NOT NULL,
	[ProductName] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[Disabled] [tinyint] NOT NULL,
	[MethodID] [tinyint] NOT NULL,
	[UnitPrice] [decimal](28, 8) NULL,
	[ProductTypeID] [nvarchar](50) NULL,
	[Orders] [int] NOT NULL,
	[CreateDate] [datetime] NULL,
	[LastModifyDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[UnitID] [nvarchar](50) NULL,
	CONSTRAINT [PK_HT1015] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC	
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HT1015_Disabled]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT1015] ADD  CONSTRAINT [DF_HT1015_Disabled]  DEFAULT ((0)) FOR [Disabled]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HT1015_MethodID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT1015] ADD  CONSTRAINT [DF_HT1015_MethodID]  DEFAULT ((0)) FOR [MethodID]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HT1015_Orders]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT1015] ADD  CONSTRAINT [DF_HT1015_Orders]  DEFAULT ((0)) FOR [Orders]
END

---- Modified on 15/03/2021 by Lê Hoàng: Bổ sung cột Kế thừa từ CI, mã khuôn (MAITHU)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='HT1015' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HT1015' AND col.name='InheritFromCI')
			ALTER TABLE HT1015 ADD InheritFromCI TINYINT NOT NULL DEFAULT(0)
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HT1015' AND col.name='MoldID')
			ALTER TABLE HT1015 ADD MoldID NVARCHAR(50) NULL 
	END

