---- Create by Phan Hải Long on 9/20/2017 8:21:26 AM
---- Đề xuất đào tạo (Detail)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HRMT2091]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HRMT2091]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NULL,
  [DivisionID] NVARCHAR(50) NOT NULL,
  [TransactionID] NVARCHAR(50) NOT NULL,
  [TrainingProposeID] NVARCHAR(50) NOT NULL,
  [EmployeeID] NVARCHAR(50) NULL,  
  [DepartmentID] NVARCHAR(50) NULL,    
  [TrainingFieldID] NVARCHAR(50) NULL,
  [ProposeAmount] DECIMAL(28,8) NULL, 
  [FromDate] DATETIME,   
  [ToDate] DATETIME,      
  [Notes] NVARCHAR(250) NULL,
  [Orders] TINYINT NULL,
  [InheritID] NVARCHAR(50) NULL,  
  [InheritTableID] NVARCHAR(50) NULL,   
  [ID] NVARCHAR(50) NULL   
CONSTRAINT [PK_HRMT2091] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [TransactionID],
  [TrainingProposeID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HRMT2091' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HRMT2091' AND col.name = 'TranQuarter')
        ALTER TABLE HRMT2091 ADD TranQuarter INT NULL
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HRMT2091' AND col.name = 'TranYear')
        ALTER TABLE HRMT2091 ADD TranYear INT NULL           
    END	 

--- 27/08/2020 - Trọng Kiên: Bổ sung cột TrainingFieldName
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT2091' AND col.name = 'TrainingFieldName')
BEGIN
	ALTER TABLE HRMT2091 ADD TrainingFieldName NVARCHAR(250) NULL
END

--- 27/08/2020 - Trọng Kiên: Bổ sung cột ProposeAmount_DT
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT2091' AND col.name = 'ProposeAmount_DT')
BEGIN
	ALTER TABLE HRMT2091 ADD ProposeAmount_DT DECIMAL(28) NULL
END

--- 27/08/2020 - Trọng Kiên: Bổ sung cột EmployeeName
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT2091' AND col.name = 'EmployeeName')
BEGIN
	ALTER TABLE HRMT2091 ADD EmployeeName NVARCHAR(250) NULL
END

--- 27/08/2020 - Trọng Kiên: Bổ sung cột DepartmentName
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT2091' AND col.name = 'DepartmentName')
BEGIN
	ALTER TABLE HRMT2091 ADD DepartmentName NVARCHAR(250) NULL
END

--- 27/08/2020 - Trọng Kiên: Bổ sung cột DutyName
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT2091' AND col.name = 'DutyName')
BEGIN
	ALTER TABLE HRMT2091 ADD DutyName NVARCHAR(250) NULL
END