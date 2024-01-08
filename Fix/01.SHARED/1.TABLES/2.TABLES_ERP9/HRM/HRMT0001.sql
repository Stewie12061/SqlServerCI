---- Create by Phan Hải Long on 9/15/2017 8:20:21 AM
---- Bảng thiết lập module đào tạo

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HRMT0001]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HRMT0001]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NULL,
  [DivisionID] NVARCHAR(50) NOT NULL,
  [VTBudgetID] NVARCHAR(50) NULL,
  [VTTrainingPlanID] NVARCHAR(50) NULL,
  [VTTrainingRequestID] NVARCHAR(50) NULL,  
  [VTTrainingProposeID] NVARCHAR(50) NULL,  
  [VTTrainingScheduleID] NVARCHAR(50) NULL,
  [VTTrainingCostID] NVARCHAR(50) NULL,   
  [VTTrainingResultID] NVARCHAR(50) NULL,     
  [LastModifyUserID] NVARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL    
CONSTRAINT [PK_HRMT0001] PRIMARY KEY CLUSTERED
(
  [DivisionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-- Huỳnh Thử Create 03/11/2020 -- Thiết lập module BlackList
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HRMT0001' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'HRMT0001' AND col.name = 'VTTrainingBlackListID') 
   ALTER TABLE HRMT0001 ADD VTTrainingBlackListID NVARCHAR (50)
END

-- Hoài Phong Create 30/11/2020 -- Thiết lập module danh sách tạm thời
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HRMT0001' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'HRMT0001' AND col.name = 'VTTrainingTransferOfPersonnelID') 
   ALTER TABLE HRMT0001 ADD VTTrainingTransferOfPersonnelID NVARCHAR (50)
END

