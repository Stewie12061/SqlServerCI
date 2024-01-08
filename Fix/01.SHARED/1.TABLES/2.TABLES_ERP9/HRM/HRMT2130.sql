﻿---- Create by Phan Hải Long on 9/22/2017 1:45:02 PM
---- Ghi nhận chi phí

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HRMT2130]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HRMT2130]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NULL,
  [DivisionID] NVARCHAR(50) NOT NULL,
  [TrainingCostID] NVARCHAR(50) NOT NULL,
  [TrainingScheduleID] NVARCHAR(50) NULL,
  [CostAmount] DECIMAL(28,8) NULL,  
  [FromDate] DATETIME NULL,
  [ToDate] DATETIME NULL,
  [Description] NVARCHAR(50) NULL,
  [AssignedToUserID] NVARCHAR(50) NULL,
  [CreateUserID] NVARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] NVARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_HRMT2130] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [TrainingCostID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END