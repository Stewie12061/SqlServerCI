-- <Summary>
---- 
-- <History>
---- Create on 11/10/2010 by Thanh Trẫm
---- Modified on 11/04/2017 by Hoàng vũ: bổ sung trường TypeID
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT0002]') AND type in (N'U'))
CREATE TABLE [dbo].[AT0002](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[TableID] [nvarchar](50) NOT NULL,
	[IsAutomatic] [tinyint] NOT NULL,
	[IsS1] [tinyint] NOT NULL,
	[IsS2] [tinyint] NOT NULL,
	[IsS3] [tinyint] NOT NULL,
	[S1] [nvarchar](50) NULL,
	[S2] [nvarchar](50) NULL,
	[S3] [nvarchar](50) NULL,
	[Length] [tinyint] NULL,
	[OutputOrder] [tinyint] NULL,
	[IsSeparator] [tinyint] NULL,
	[Separator] [nvarchar](5) NULL,
 CONSTRAINT [PK_AT0002] PRIMARY KEY NONCLUSTERED 
(
	[TableID] ASC,
	[DivisionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT0002_IsAutomatic]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT0002] ADD  CONSTRAINT [DF_AT0002_IsAutomatic]  DEFAULT ((0)) FOR [IsAutomatic]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT0002_IsS1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT0002] ADD  CONSTRAINT [DF_AT0002_IsS1]  DEFAULT ((0)) FOR [IsS1]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT0002_IsS2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT0002] ADD  CONSTRAINT [DF_AT0002_IsS2]  DEFAULT ((0)) FOR [IsS2]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT0002_IsS3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT0002] ADD  CONSTRAINT [DF_AT0002_IsS3]  DEFAULT ((0)) FOR [IsS3]
END
--Quản lý mã tăng tự động đối tượng và bổ sung đối tượng bên CRM
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0002' AND col.name = 'TypeID') 
   ALTER TABLE AT0002 ADD TypeID VARCHAR(50) NULL 
END