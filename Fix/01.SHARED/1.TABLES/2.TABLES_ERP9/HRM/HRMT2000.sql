---- Create by Nguyễn Hoàng Bảo Thy on 7/27/2017 5:08:04 PM
---- Kế hoạch tuyển dụng (master)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HRMT2000]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HRMT2000]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [RecruitPlanID] VARCHAR(50) NOT NULL,
  [Description] NVARCHAR(1000) NULL,
  [DepartmentID] VARCHAR(50) NULL,
  [TotalCost] DECIMAL(28,8) NULL,
  [FromDate] DATETIME NULL,
  [ToDate] DATETIME NULL,
  [Status] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_HRMT2000] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [RecruitPlanID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

--- 22/10/2020 - Trọng Kiên: Bổ sung cột Status1
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT2000' AND col.name = 'Status1')
BEGIN
	ALTER TABLE HRMT2000 ADD Status1 TINYINT NULL
END

--- 22/10/2020 - Trọng Kiên: Bổ sung cột Status2
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT2000' AND col.name = 'Status2')
BEGIN
	ALTER TABLE HRMT2000 ADD Status2 TINYINT NULL
END

--- 22/10/2020 - Trọng Kiên: Bổ sung cột Status3
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT2000' AND col.name = 'Status3')
BEGIN
	ALTER TABLE HRMT2000 ADD Status3 TINYINT NULL
END

--- 22/10/2020 - Trọng Kiên: Bổ sung cột Status4
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT2000' AND col.name = 'Status4')
BEGIN
	ALTER TABLE HRMT2000 ADD Status4 TINYINT NULL
END

--- 22/10/2020 - Trọng Kiên: Bổ sung cột Status5
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT2000' AND col.name = 'Status5')
BEGIN
	ALTER TABLE HRMT2000 ADD Status5 TINYINT NULL
END

--- 22/10/2020 - Trọng Kiên: Bổ sung cột Approver1
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT2000' AND col.name = 'Approver1')
BEGIN
	ALTER TABLE HRMT2000 ADD Approver1 VARCHAR(50) NULL
END

--- 22/10/2020 - Trọng Kiên: Bổ sung cột Approver2
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT2000' AND col.name = 'Approver2')
BEGIN
	ALTER TABLE HRMT2000 ADD Approver2 VARCHAR(50) NULL
END

--- 22/10/2020 - Trọng Kiên: Bổ sung cột Approver3
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT2000' AND col.name = 'Approver3')
BEGIN
	ALTER TABLE HRMT2000 ADD Approver3 VARCHAR(50) NULL
END

--- 22/10/2020 - Trọng Kiên: Bổ sung cột Approver4
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT2000' AND col.name = 'Approver4')
BEGIN
	ALTER TABLE HRMT2000 ADD Approver4 VARCHAR(50) NULL
END

--- 22/10/2020 - Trọng Kiên: Bổ sung cột Approver5
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT2000' AND col.name = 'Approver5')
BEGIN
	ALTER TABLE HRMT2000 ADD Approver5 VARCHAR(50) NULL
END

--- 22/10/2020 - Trọng Kiên: Bổ sung cột TranMonth
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT2000' AND col.name = 'TranMonth')
BEGIN
	ALTER TABLE HRMT2000 ADD TranMonth INT NULL
END

--- 22/10/2020 - Trọng Kiên: Bổ sung cột TranYear
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT2000' AND col.name = 'TranYear')
BEGIN
	ALTER TABLE HRMT2000 ADD TranYear INT NULL
END

--- 09/11/2020 - Văn Tài: Bổ sung PurposeID và Notes bị thiếu
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT2000' AND col.name = 'PurposeID')
BEGIN
	ALTER TABLE HRMT2000 ADD PurposeID VARCHAR(50)
END

--- 09/11/2020 - Văn Tài: Bổ sung PurposeID và Notes bị thiếu
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT2000' AND col.name = 'Notes')
BEGIN
	ALTER TABLE HRMT2000 ADD Notes NVARCHAR(200)
END

--- 10/11/2020 - Huỳnh Thử: Bổ sung cột ApproveLevel
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT2000' AND col.name = 'ApproveLevel')
BEGIN
	ALTER TABLE HRMT2000 ADD ApproveLevel INT NULL
END

--- 10/11/2020 - Huỳnh Thử: Bổ sung cột ApprovingLevel
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT2000' AND col.name = 'ApprovingLevel')
BEGIN
	ALTER TABLE HRMT2000 ADD ApprovingLevel INT NULL
END

--- 10/11/2020 - Huỳnh Thử: Bổ sung cột Status
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT2000' AND col.name = 'Status')
BEGIN
	ALTER TABLE HRMT2000 ADD Status VARCHAR(50) NULL
END
--- 24/08/2023 - Phương Thảo: Bổ sung cột DeleteFlg
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='HRMT2000' AND xtype='U')
	BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HRMT2000' AND col.name='DeleteFlg')
		ALTER TABLE HRMT2000 ADD DeleteFlg TINYINT DEFAULT (0) NULL
	END
	
---------------- 05/10/2022 - Tấn Lộc: Update độ dài dữ liệu cột Description ----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT2000' AND col.name = 'Description')
BEGIN
	ALTER TABLE HRMT2000 ALTER COLUMN Description NVARCHAR(MAX) NULL
END