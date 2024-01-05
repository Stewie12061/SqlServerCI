﻿---- Create by Nguyễn Hoàng Bảo Thy on 9/28/2017 10:06:08 AM
---- Lương năng suất (NewToyo)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HT1118]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HT1118]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [EmployeeID] VARCHAR(50) NOT NULL,
  [TranMonth] INT NOT NULL,
  [TranYear] INT NOT NULL,
  [DepartmentID] VARCHAR(50) NULL,
  [TeamID] VARCHAR(50) NULL,
  [BaseSalary] DECIMAL(28,8) NULL,
  [ExcessQuantity] DECIMAL(28,8) NULL,
  [ExcessAmount] DECIMAL(28,8) NULL,
  [OTQuantity] DECIMAL(28,8) NULL,
  [OTAmount] DECIMAL(28,8) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL
CONSTRAINT [PK_HT1118] PRIMARY KEY CLUSTERED
(
  [APK],
  [DivisionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END