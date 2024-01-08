-- <Summary>
---- 
-- <History>
---- Create on 04/01/2016 by Bảo Anh: Danh mục lỗi sản phẩm
---- Modified on ... by ...

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT0148]') AND type in (N'U'))
CREATE TABLE [dbo].[AT0148](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[ProErrorID] [nvarchar](50) NOT NULL,
	[ProErrorName] [nvarchar](250) NULL,
	[TeamID] [nvarchar](50) NULL,
	[Notes] [nvarchar](250) NULL,
	[Disabled] [tinyint] NOT NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
 CONSTRAINT [PK_AT0148] PRIMARY KEY NONCLUSTERED 
(
	[DivisionID] ASC,
	[ProErrorID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0148' AND xtype = 'U')
    BEGIN
        IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0148' AND col.name = 'DivisionID')
        ALTER TABLE AT0148 ALTER COLUMN DivisionID [nvarchar](50) NOT NULL
    END    