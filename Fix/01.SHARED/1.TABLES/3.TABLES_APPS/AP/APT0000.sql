---- Create by Phan thanh hoàng vũ on 2/26/2019 11:01:51 AM
---- Phản hồi ý kiến (master) => BLUESKY

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[APT0000]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[APT0000]
     (
      [Orders] INT IDENTITY(1, 1),
      [DivisionID] VARCHAR(50) NULL,
      [OSName] NVARCHAR(50) NULL,
	  [DeviceName] NVARCHAR(50) NULL,
	  [LogType] NVARCHAR(50) NULL, ---- INFO, DEBUG, ERROR, WARN
	  [LogContent] NTEXT NULL,
	  [DeviceDate] DATETIME NULL,
      [CreateUserID] VARCHAR(50) NULL,     
      [CreateDate] DATETIME NULL
    CONSTRAINT [PK_APT0000] PRIMARY KEY CLUSTERED
      (
      [Orders]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

