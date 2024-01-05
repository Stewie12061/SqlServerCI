---- Create by Cao Thị Phượng on 10/10/2017 2:17:25 PM
---- Danh sách dự án/nhóm công việc

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT2100]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT2100]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [ProjectID] VARCHAR(50) NOT NULL,
  [ProjectName] NVARCHAR(250) NOT NULL,
  [ProjectType] INT NOT NULL,
  [ProjectSampleID] VARCHAR(50) NULL,
  [ProjectDescription] NVARCHAR(MAX) NULL,
  [StartDate] DATETIME NULL,
  [EndDate] DATETIME NULL,
  [CheckingDate] DATETIME NULL,
  [DepartmentID] VARCHAR(50) NULL,
  [LeaderID] VARCHAR(50) NULL,
  [AssignedToUserID] VARCHAR(250) NULL,
  [ContractID] VARCHAR(50) NULL,
  [StatusID] VARCHAR(50) NULL,
  [DeleteFlg] TINYINT DEFAULT 0 NULL,
  [RelatedToTypeID] INT DEFAULT 47 NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_OOT2100] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END


-------------------- 18/10/2019 - Vĩnh Tâm: Đổi tên cột DeleteFlag thành DeleteFlg --------------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT2100' AND col.name = 'DeleteFlag')
BEGIN
  EXEC sp_RENAME 'OOT2100.DeleteFlag', 'DeleteFlg', 'COLUMN'
END

-------------------- 11/06/2019 - Vĩnh Tâm: Bổ sung cột PercentProgress --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2100' AND col.name = 'PercentProgress')
BEGIN
	ALTER TABLE OOT2100 ADD PercentProgress DECIMAL(28,8) NULL
END

-------------------- 07/07/2019 - Vĩnh Tâm: Bổ sung cột OpportunityID --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2100' AND col.name = 'OpportunityID')
BEGIN
	ALTER TABLE OOT2100 ADD OpportunityID VARCHAR(25) NULL
END

-------------------- 23/08/2019 - Truong Lam: Bổ sung cột DepartmentName --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT2100' AND col.name = 'DepartmentName')
BEGIN
	ALTER TABLE OOT2100 ADD DepartmentName VARCHAR(25) NULL
END

----- 07/01/2020 - Vĩnh Tâm: Bổ sung cột DiscountFactorNC, DiscountFactorKHCU, DiscountFactorKHCUService -----
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT2100' AND col.name = 'DiscountFactorNC')
BEGIN
	ALTER TABLE OOT2100 ADD DiscountFactorNC DECIMAL(28,8) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT2100' AND col.name = 'DiscountFactorKHCU')
BEGIN
	ALTER TABLE OOT2100 ADD DiscountFactorKHCU DECIMAL(28,8) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT2100' AND col.name = 'DiscountFactorKHCUService')
BEGIN
	ALTER TABLE OOT2100 ADD DiscountFactorKHCUService DECIMAL(28,8) NULL
END

----- 22/10/2020 - Trọng Kiên: Bổ sung cột GuestCost
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT2100' AND col.name = 'GuestCost')
BEGIN
	ALTER TABLE OOT2100 ADD GuestCost DECIMAL(28,8) NULL
END

----- 24/11/2020 - Kiều Nga: Bổ sung cột NetSales
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT2100' AND col.name = 'NetSales')
BEGIN
	ALTER TABLE OOT2100 ADD NetSales NVARCHAR(MAX) NULL
END

----- 24/11/2020 - Kiều Nga: Bổ sung cột CommissionCost
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT2100' AND col.name = 'CommissionCost')
BEGIN
	ALTER TABLE OOT2100 ADD CommissionCost NVARCHAR(MAX) NULL
END

----- 24/11/2020 - Kiều Nga: Bổ sung cột BonusSales
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'OOT2100' AND col.name = 'BonusSales')
BEGIN
	ALTER TABLE OOT2100 ADD BonusSales NVARCHAR(MAX) NULL
END



