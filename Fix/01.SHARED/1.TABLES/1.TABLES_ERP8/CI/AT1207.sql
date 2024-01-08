-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Tố Oanh
---- Modified on 11/04/2017 by Hoàng vũ: bổ sung trường TypeID
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT1207]') AND type in (N'U'))
CREATE TABLE [dbo].[AT1207](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[S] [nvarchar](50) NOT NULL,
	[STypeID] [nvarchar](50) NOT NULL,
	[SName] [nvarchar](250) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[Disabled] [tinyint] NULL,
 CONSTRAINT [PK_AT1207] PRIMARY KEY NONCLUSTERED 
(
	[S] ASC,
	[STypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

--Quản lý mã tăng tự động đối tượng và bổ sung đối tượng bên CRM
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1207' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1207' AND col.name = 'TypeID') 
   ALTER TABLE AT1207 ADD TypeID VARCHAR(50) NULL 
END

--Quản lý mã tăng tự động đối tượng và bổ sung đối tượng bên CRM
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1207' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1207' AND col.name = 'TableID') 
   ALTER TABLE AT1207 ADD TableID VARCHAR(50) NULL 
END