---- Create by Hoài Bảo on 08/12/2022 14:39:00 AM
---- Thiết lập ca dao, thành ngữ hiển thị ở màn hình Workspace

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[AT14054]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[AT14054]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [IDNumber] INT NULL,
  [Idioms] NVARCHAR(MAX) NULL,
  [Author] NVARCHAR (250) NULL
CONSTRAINT [PK_AT14054] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-------------------- 09/12/2022 - [Hoài Bảo] - Cập nhật loại dữ liệu cột Author
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT14054' AND col.name = 'Author')
BEGIN
	ALTER TABLE AT14054
	ALTER COLUMN Author NVARCHAR(MAX) NULL
END