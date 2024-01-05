-- <Summary>
---- 
-- <History>
---- Create on 13/12/2010 by Thanh Trẫm
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT1403]') AND type in (N'U'))
CREATE TABLE [dbo].[AT1403](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[ScreenID] [nvarchar](50) NOT NULL,
	[GroupID] [nvarchar](50) NOT NULL,
	[ModuleID] [nvarchar](50) NOT NULL,
	[IsAddNew] [tinyint] NOT NULL,
	[IsUpdate] [tinyint] NOT NULL,
	[IsDelete] [tinyint] NOT NULL,
	[IsView] [tinyint] NOT NULL,
	[IsPrint] [tinyint] NOT NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
 CONSTRAINT [PK_AT1403] PRIMARY KEY NONCLUSTERED 
(
	[ScreenID] ASC,
	[GroupID] ASC,
	[ModuleID] ASC,
	[DivisionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default 
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT1403_IsAddNew]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1403] ADD CONSTRAINT [DF_AT1403_IsAddNew] DEFAULT ((0)) FOR [IsAddNew]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT1403_IsUpdate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1403] ADD CONSTRAINT [DF_AT1403_IsUpdate] DEFAULT ((0)) FOR [IsUpdate]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT1403_IsDelete]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1403] ADD CONSTRAINT [DF_AT1403_IsDelete] DEFAULT ((0)) FOR [IsDelete]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT1403_IsView]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1403] ADD CONSTRAINT [DF_AT1403_IsView] DEFAULT ((0)) FOR [IsView]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT1403_IsPrint]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1403] ADD CONSTRAINT [DF_AT1403_IsPrint] DEFAULT ((0)) FOR [IsPrint]
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT1403' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1403' AND col.name='SourceID')
		ALTER TABLE AT1403 ADD SourceID VARCHAR(50) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT1403' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1403' AND col.name='IsExportExcel')
		ALTER TABLE AT1403 ADD IsExportExcel TINYINT NOT NULL DEFAULT(0)
	END

--- 26/01/2021 - Tấn Thành: Bổ sung cột IsHidden
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT1403' AND col.name = 'IsHidden')
BEGIN
	ALTER TABLE AT1403 ADD IsHidden TINYINT DEFAULT (0) 
END

--- 28/01/2021 - Tấn Thành: Bổ sung cột CommonID
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT1403' AND col.name = 'CommonID')
BEGIN
	ALTER TABLE AT1403 ADD CommonID VARCHAR(50) NULL
END