-- <Summary>
---- Phân quyền người dùng quản lý đối tượng ( CUstomer THL = 122) 
-- <History>
---- Create on 11/03/2020 by Trà Giang
---- Modified on ... by 
-- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[AT0083]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[AT0083]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
	  [APKMaster] UNIQUEIDENTIFIER  NOT NULL, -- Phân biệt những đối tượng được quản lý bởi 1 UserID cùng 1 time
      [DivisionID] NVARCHAR(50) NULL,
      [CreateUserID] NVARCHAR(50) NULL,
      [CreateDate] DATETIME NULL,
      [LastModifyUserID] NVARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL,
	  [GroupID] NVARCHAR(50) NULL,
	  [UserID] NVARCHAR(50) NOT NULL,
      [AreaID] NVARCHAR(50) NOT NULL,
	  [FromDate] DATETIME NULL,
	  [ToDate] DATETIME NULL,
	  [Description] NVARCHAR(MAX) NULL,
	  [ObjectID] NVARCHAR(50) NULL,
	  [ObjectName] NVARCHAR(250) NULL,
	  [LstInheritUserID] NVARCHAR(250) NULL
    CONSTRAINT [PK_AT0083] PRIMARY KEY CLUSTERED
      (
      [APK] ASC
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END
