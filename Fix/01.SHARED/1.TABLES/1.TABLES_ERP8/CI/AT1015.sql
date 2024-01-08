-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Tố Oanh
---- Modified on 02/10/2020 by Lê Hoàng : Bổ sung cột Tên mã phân tích (Tiếng anh)
---- Modified on ... by ...
-- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT1015]') AND type in (N'U'))
CREATE TABLE [dbo].[AT1015](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[AnaID] [nvarchar](50) NOT NULL,
	[AnaTypeID] [nvarchar](50) NOT NULL,
	[AnaName] [nvarchar](250) NULL,
	[Notes] [nvarchar](250) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[Disabled] [tinyint] NOT NULL,
 CONSTRAINT [PK_AT1015] PRIMARY KEY NONCLUSTERED 
(
	[AnaID] ASC,
	[AnaTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

---- Add giá trị default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT1015_Disabled]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1015] ADD  CONSTRAINT [DF_AT1015_Disabled]  DEFAULT ((0)) FOR [Disabled]
END
---- Bổ sung cột Tên mã phân tích (Tiếng anh)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1015' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'AT1015' AND col.name = 'AnaNameE')
   ALTER TABLE AT1015 ADD AnaNameE NVARCHAR(250) NULL
END
---- Bổ sung cột Ghi chú 01
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1015' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'AT1015' AND col.name = 'Notes01')
   ALTER TABLE AT1015 ADD Notes01 NVARCHAR(250) NULL
END