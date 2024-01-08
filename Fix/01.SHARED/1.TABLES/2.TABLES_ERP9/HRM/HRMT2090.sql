---- Create by Phan Hải Long on 9/20/2017 8:20:21 AM
---- Đề xuất đào tạo (Master)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HRMT2090]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HRMT2090]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NULL,
  [DivisionID] NVARCHAR(50) NOT NULL,
  [TrainingProposeID] NVARCHAR(50) NOT NULL,
  [DepartmentID] NVARCHAR(50) NULL,
  [ProposeAmount] DECIMAL(28,8) NULL, 
  [Description1] NVARCHAR(1000) NULL,
  [Description2] NVARCHAR(1000) NULL,  
  [Description3] NVARCHAR(1000) NULL,    
  [InheritID1] NVARCHAR(1000) NULL,  
  [InheritID2] NVARCHAR(1000) NULL,
  [AssignedToUserID] NVARCHAR(50) NULL,       
  [CreateUserID] NVARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] NVARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_HRMT2090] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [TrainingProposeID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HRMT2090' AND xtype = 'U')
    BEGIN      
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HRMT2090' AND col.name = 'IsAll')
        ALTER TABLE HRMT2090 ADD IsAll TINYINT DEFAULT (0) NULL      
    END	     

--- 27/08/2020 - Trọng Kiên: Bổ sung cột Attach
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT2090' AND col.name = 'Attach')
BEGIN
	ALTER TABLE HRMT2090 ADD Attach NVARCHAR(250) NULL
END

--- 27/08/2020 - Trọng Kiên: Bổ sung cột Date
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT2090' AND col.name = 'Date')
BEGIN
	ALTER TABLE HRMT2090 ADD Date DATETIME NULL
END

--- 27/08/2020 - Trọng Kiên: Bổ sung cột InheritName
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT2090' AND col.name = 'InheritName')
BEGIN
	ALTER TABLE HRMT2090 ADD InheritName NVARCHAR(250) NULL
END

--- 27/08/2020 - Trọng Kiên: Bổ sung cột DepartmentName
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT2090' AND col.name = 'DepartmentName')
BEGIN
	ALTER TABLE HRMT2090 ADD DepartmentName NVARCHAR(250) NULL
END
