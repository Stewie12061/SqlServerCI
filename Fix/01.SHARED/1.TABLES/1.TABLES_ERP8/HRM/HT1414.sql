---- Create by truong ngoc phuong thao on 07/01/2016 10:14:19 AM
---- Theo dõi hưởng chế độ con nhỏ
--DROP TABLE [dbo].[HT1414]

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HT1414]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[HT1414]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT newid() NULL,
      [ChangeStatusID] VARCHAR(50) NOT NULL,
      [EmployeeMode] VARCHAR(50)  NULL,
      [EmployeeStatus] VARCHAR(50) NULL,
      [DivisionID] NVARCHAR(50) NOT NULL,
      [EmployeeID] NVARCHAR(50) NOT NULL,
      [BeginDate] DATETIME NULL,
      [EndDate] DATETIME NULL,
      [Notes] NVARCHAR(250) DEFAULT (0) NULL,
      [QuitJobID] NVARCHAR(50) NULL,
      [CreateDate] DATETIME NULL,
      [CreateUserID] VARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL,
      [LastModifyUserID] VARCHAR(50) NULL
    CONSTRAINT [PK_HT1414] PRIMARY KEY CLUSTERED
      (
      [ChangeStatusID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END