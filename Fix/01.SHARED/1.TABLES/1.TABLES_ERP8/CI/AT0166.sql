---- Create by Đặng Thị Tiểu Mai on 07/03/2016 10:24:46 AM
---- Danh mục linh kiện (Angel)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[AT0166]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[AT0166]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NULL,
      [DivisionID] NVARCHAR(50) NOT NULL,
      [ComponentID] NVARCHAR(50) NOT NULL,
      [ComponentName] NVARCHAR(250) NULL,
      [Notes] NVARCHAR(250) NULL,
      [Disabled] TINYINT DEFAULT (0) NULL,
      [CreateDate] DATETIME NULL,
      [CreateUserID] NVARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL,
      [LastModifyUserID] NVARCHAR(50) NULL
    CONSTRAINT [PK_AT0166] PRIMARY KEY CLUSTERED
      (
      [DivisionID],
      [ComponentID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END