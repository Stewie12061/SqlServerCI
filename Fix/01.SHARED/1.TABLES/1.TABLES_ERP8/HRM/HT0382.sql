---- Create by truong ngoc phuong thao on 07/04/2016 11:22:48 AM
---- Thiết lập báo cáo công (Master - Meiko)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HT0382]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[HT0382]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
      [ReportID] VARCHAR(50) NOT NULL,
      [ReportName] NVARCHAR(250) NOT NULL,
      [Title] NVARCHAR(250) NULL,
      [Disabled] TINYINT DEFAULT (0) NOT NULL,
      [CreateUserID] VARCHAR(50) NULL,
      [CreateDate] DATETIME NULL,
      [LastModifyUserID] VARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL
    CONSTRAINT [PK_HT0382] PRIMARY KEY CLUSTERED
      (
      [DivisionID],
      [ReportID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END