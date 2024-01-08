---- Create by Đặng Thị Tiểu Mai on 21/01/2016 2:04:47 PM
---- Danh sách cảnh báo được thiết lập theo nhóm người dùng.

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[AT0011]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[AT0011]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] NVARCHAR(50) NOT NULL,
      [GroupID] NVARCHAR(50) NOT NULL,
      [WarningID] NVARCHAR(50) NOT NULL,
      [Status] TINYINT DEFAULT (0) NULL,
    CONSTRAINT [PK_AT0011] PRIMARY KEY CLUSTERED
      (
      [DivisionID],
      [GroupID],
      [WarningID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END