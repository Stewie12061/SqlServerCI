-- <Summary>
---- 
-- <History>
---- Create on 05/04/2016 by Bảo Anh: Danh mục loại thùng (Angel)
---- Modified on ... by ...
---- Modified on 22/12/2021 by Nhựt Trường: Merge code Angel - Edit độ dài chuỗi DivisionID lên 50 ký tự (Do Fix bảng cũ ở Angel đang được khai báo là 3 ký tự).

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT0168]') AND type in (N'U'))
CREATE TABLE [dbo].[AT0168](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[KITTypeID] [nvarchar](50) NOT NULL,
	[KITTypeName] [nvarchar](250) NULL,
	[Weight] [DECIMAL](28,8) NULL,
	[Notes] [nvarchar](250) NULL,
	[Disabled] [tinyint] NOT NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
 CONSTRAINT [PK_AT0168] PRIMARY KEY NONCLUSTERED 
(
	[DivisionID] ASC,
	[KITTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

---- Merge code Angel: Edit độ dài chuỗi DivisionID lên 50 ký tự (Do Fix bảng cũ ở Angel đang được khai báo là 3 ký tự).
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0168' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0168' AND col.name='DivisionID')
		ALTER TABLE AT0168 ALTER COLUMN DivisionID NVARCHAR(50) NOT NULL
	END