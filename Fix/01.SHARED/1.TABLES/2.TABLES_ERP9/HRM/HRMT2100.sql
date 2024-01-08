---- Create by Phan Hải Long on 9/20/2017 8:20:21 AM
---- Lịch đào tạo (Master)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HRMT2100]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HRMT2100]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NULL,
  [DivisionID] NVARCHAR(50) NOT NULL,
  [TrainingScheduleID] NVARCHAR(50) NOT NULL,
  [TrainingFieldID] NVARCHAR(50) NULL,
  [ScheduleAmount] DECIMAL(28,8) NULL,
  [FromDate] DATETIME, 
  [ToDate] DATETIME,   
  [TrainingCourseID] NVARCHAR(50) NULL,
  [Address] NVARCHAR(1000) NULL,  
  [Description1] NVARCHAR(1000) NULL,
  [Description2] NVARCHAR(1000) NULL,  
  [Description3] NVARCHAR(1000) NULL,        
  [AssignedToUserID] NVARCHAR(50) NULL,  
  [CreateUserID] NVARCHAR(50) NULL,  
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] NVARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_HRMT2100] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [TrainingScheduleID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HRMT2100' AND xtype = 'U')
    BEGIN      
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HRMT2100' AND col.name = 'IsAll')
        ALTER TABLE HRMT2100 ADD IsAll TINYINT DEFAULT (0) NULL
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HRMT2100' AND col.name = 'TrainingProposeID')
        ALTER TABLE HRMT2100 ADD TrainingProposeID NVARCHAR(50) NULL
		
		--- Modified on 14/02/2019 by Bảo Anh: Bổ sung Số buổi đào tạo, Số giờ/buổi
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HRMT2100' AND col.name = 'Sessions')
			ALTER TABLE HRMT2100 ADD Sessions INT NULL
			
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HRMT2100' AND col.name = 'HoursPerSession')
			ALTER TABLE HRMT2100 ADD HoursPerSession DECIMAL(8,2) NULL

		--- Modified on 26/09/2023 by Võ Dương: Bổ sung giờ đào tạo cụ thể
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HRMT2100' AND col.name = 'SpecificHours')
			ALTER TABLE HRMT2100 ADD SpecificHours DECIMAL(8,2) NULL
    END
	
---------------- 18/12/2023 - Tấn Lộc: Update độ dài dữ liệu cột SpecificHours ----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT2100' AND col.name = 'SpecificHours')
BEGIN
	ALTER TABLE HRMT2100 ALTER COLUMN SpecificHours DATETIME NULL
END