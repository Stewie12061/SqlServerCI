---- Create by Văn Tài on 12/05/2023
---- Thông tin khoảng thời gian hợp lệ cho Tuyến.

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CT0160]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[CT0160]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [APKMaster]	VARCHAR(50) NULL,
      [RouteID]		VARCHAR(50) NOT NULL,
	  [Orders]		INT	NOT NULL,
      [Description] NVARCHAR(500) NULL,
	  [FromHour]	VARCHAR(50) NULL,
	  [ToHour]		VARCHAR(50) NULL,
	  [IsNextDay]	TINYINT NULL,
      [CreateUserID] VARCHAR(50) NULL,
      [CreateDate] DATETIME NULL,
      [LastModifyUserID] VARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL,      
    CONSTRAINT [PK_CT0160] PRIMARY KEY CLUSTERED
      (      
		[APK]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END


IF EXISTS
  (SELECT *
   FROM sysobjects
   WHERE name = 'CT0160'
     AND xtype ='U') 
BEGIN 
	IF NOT EXISTS (SELECT *
				   FROM syscolumns col
				   INNER JOIN sysobjects tab ON col.id = tab.id
				   WHERE tab.name = 'CT0160'
					 AND col.name = 'IsNextDay')
		ALTER TABLE CT0160 ADD IsNextDay TINYINT DEFAULT(0) NULL 
END