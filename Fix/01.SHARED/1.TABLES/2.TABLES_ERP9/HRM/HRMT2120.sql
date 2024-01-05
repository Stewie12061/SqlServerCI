---- Create by Phan Hải Long on 9/26/2017 8:20:21 AM
---- Ghi nhận kết quả đào tạo (Master)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HRMT2120]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HRMT2120]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NULL,
  [DivisionID] NVARCHAR(50) NOT NULL,
  [TrainingResultID] NVARCHAR(50) NOT NULL,
  [TrainingScheduleID] NVARCHAR(50) NULL,  
  [ResultTypeID] NVARCHAR(50) NULL,  
  [Description1] NVARCHAR(1000) NULL,
  [Description2] NVARCHAR(1000) NULL,  
  [AssignedToUserID] NVARCHAR(50) NULL,
  [CreateUserID] NVARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] NVARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_HRMT2120] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [TrainingResultID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

--- 07/08/2020 - Trọng Kiên: Bổ sung cột TrainingScheduleName
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT2120' AND col.name = 'TrainingScheduleName')
BEGIN
	ALTER TABLE HRMT2120 ADD TrainingScheduleName NVARCHAR(250) NULL
END

--- 07/08/2020 - Trọng Kiên: Bổ sung cột AssignedToUserName
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT2120' AND col.name = 'AssignedToUserName')
BEGIN
	ALTER TABLE HRMT2120 ADD AssignedToUserName NVARCHAR(250) NULL
END

--Thanh Hải Create 24/10/2023 --Bổ sung cột DeleteFlg
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name]='HRMT2120' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id=tab.id WHERE tab.name='HRMT2120' and col.name='DeleteFlg')
	ALTER TABLE HRMT2120 ADD DeleteFlg TINYINT DEFAULT 0 NULL
END