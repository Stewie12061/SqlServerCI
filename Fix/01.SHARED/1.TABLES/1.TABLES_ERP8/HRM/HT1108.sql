---- Create by truong ngoc phuong thao on 30/12/2015 11:45:46 AM
---- Danh mục Hình thức kỷ luật

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HT1108]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[HT1108]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NULL,
      [DivisionID] NVARCHAR(50) NOT NULL,
      [FormID] NVARCHAR(50) NOT NULL,
      [FormName] NVARCHAR(250) NOT NULL,
      [Description] NVARCHAR(250) NULL,
      [Level] INT DEFAULT (0) NULL,
      [Disabled] TINYINT DEFAULT (0) NULL,
      [CreateUserID] NVARCHAR(50) NULL,
      [CreateDate] DATETIME NULL,
      [LastModifyUserID] NVARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL
    CONSTRAINT [PK_HT1108] PRIMARY KEY CLUSTERED
      (
      [DivisionID],
      [FormID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

--Modified by Bảo Thy on 31/03/2016: Add column IsReward

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1108' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1108' AND col.name = 'IsReward')
        ALTER TABLE HT1108 ADD IsReward TINYINT NULL
    END