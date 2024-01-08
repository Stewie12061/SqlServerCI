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

--- 18/10/2023 - Phương Thảo: Bổ sung cột DeleteFlg,Status,ApprovingLevel,ApprovalNotes,ApproveLevel Begin ADD
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='HT0534' AND xtype='U')
	BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HT0534' AND col.name='DeleteFlg')
		ALTER TABLE HT0534 ADD DeleteFlg TINYINT DEFAULT (0) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='HT0534' AND xtype='U')
	BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HT0534' AND col.name='Status')
		ALTER TABLE HT0534 ADD Status TINYINT DEFAULT (0) NULL
	END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HT0534' AND col.name = 'ApprovingLevel')
BEGIN
	ALTER TABLE HT0534 ADD ApprovingLevel INT NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HT0534' AND col.name = 'ApprovalNotes')
BEGIN
	ALTER TABLE HT0534 ADD ApprovalNotes NVARCHAR(MAX) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HT0534' AND col.name = 'ApproveLevel')
BEGIN
	ALTER TABLE HT0534 ADD ApproveLevel INT NULL
END

--- 18/10/2023 - Phương Thảo: Bổ sung cột DeleteFlg,Status,ApprovingLevel,ApprovalNotes,ApproveLevel End ADD


