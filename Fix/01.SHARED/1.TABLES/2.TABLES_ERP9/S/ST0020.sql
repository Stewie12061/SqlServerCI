/****** Object:  Table [dbo].[ST0020]    Script Date: 28/10/2020 12:45:05 PM ******/
---- Create by Lê Hoàng on 28/10/2020 12:00:00 PM
---- Danh mục Thiết lập dữ liệu ngầm

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[ST0020]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[ST0020](
	[APK] [uniqueidentifier] NOT NULL DEFAULT NEWID(),
	[CodeMaster] [varchar](25) NOT NULL,
	[CategoryName] [nvarchar](250) NOT NULL,
	[AttachID] [int] NULL,
	[AttachFile] [varbinary](8000) NULL,
	[AttachName] [nvarchar](max) NULL,
	[ModuleID] [varchar](25) NOT NULL,
	[Disabled] [tinyint] NULL DEFAULT(0),
	[IsCommon] [tinyint] NULL DEFAULT(0),
	[CreateDate] [datetime] NULL,
	[CreateUserID] [varchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [varchar](50) NULL,
 CONSTRAINT [PK_ST0020] PRIMARY KEY CLUSTERED 
(
	[CodeMaster] ASC,
	[ModuleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END

---------------- 29/10/2020 - Lê Hoàng: Thay đổi kiểu dữ liệu của cột CodeMaster ----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST0020' AND col.name = 'CodeMaster')
BEGIN
	ALTER TABLE ST0020 ALTER COLUMN CodeMaster VARCHAR(250) NOT NULL
END

---------------- 19/06/2021 - Văn Tài: Thay đổi kiểu dữ liệu của cột ModuleID ----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST0020' AND col.name = 'ModuleID')
BEGIN
	ALTER TABLE ST0020 ALTER COLUMN ModuleID VARCHAR(50) NOT NULL
END

---------------- 30/07/2021 - Tấn Lộc: Chuyển Not null thành Null ----------------
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'ST0020' AND xtype = 'U')
BEGIN 
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'ST0020' AND col.name = 'CategoryName') 
   ALTER TABLE ST0020 ALTER COLUMN  CategoryName NVARCHAR(MAX) NULL 
END
