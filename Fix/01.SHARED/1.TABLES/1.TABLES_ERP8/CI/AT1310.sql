﻿-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Quốc Cường
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT1310]') AND type in (N'U'))
CREATE TABLE [dbo].[AT1310](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] nvarchar(3) NOT NULL,
	[S] [nvarchar](50) NOT NULL,
	[STypeID] [nvarchar](50) NOT NULL,
	[SName] [nvarchar](250) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[Disabled] [tinyint] NULL,
 CONSTRAINT [PK_AT1310] PRIMARY KEY NONCLUSTERED 
(
	[S] ASC,
	[STypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
--Modify by Thị Phượng: Bổ sung ngạch ca Customize Index  = 79 (Minh Sang)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1310' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1310' AND col.name = 'Shifts') 
   ALTER TABLE AT1310 ADD Shifts DECIMAL(28,8) NULL 
END


