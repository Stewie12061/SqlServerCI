---- Create by Bảo Anh on 11/01/2019
---- Kết quả thử việc

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HT0534]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[HT0534]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT newid() NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
      [ResultNo] VARCHAR(50) NOT NULL,
      [ResultDate] DATETIME NULL,
	  [ReviewPerson] VARCHAR(50) NULL,
      [DecidePerson] VARCHAR(50) NULL,
      [EmployeeID] VARCHAR(50) NULL,
	  [ContractNo] VARCHAR(50) NULL,
	  [TestFromDate] DATETIME NULL,
	  [TestToDate] DATETIME NULL,
      [ResultID] TINYINT NULL,
      [IsStopBeforeEndDate] TINYINT NULL,
      [EndDate] DATETIME NULL,
      [Notes] NVARCHAR(250) NULL,
      [CreateUserID] VARCHAR(50) NULL,
      [CreateDate] DATETIME DEFAULT getdate() NULL,
      [LastModifyUserID] VARCHAR(50) NULL,
      [LastModifyDate] DATETIME DEFAULT getdate() NULL
    CONSTRAINT [PK_HT0534] PRIMARY KEY CLUSTERED
      (
      [DivisionID],
      [ResultNo]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END