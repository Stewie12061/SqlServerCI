---- Create by Khâu Vĩnh Tâm on 7/8/2019 4:11:47 PM
---- Danh mục Quy chuẩn Up&Down đánh giá KPI

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[KPIT2020]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[KPIT2020]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [EmployeeID] VARCHAR(50) NULL,
  [FixedSalary] DECIMAL(28,8) NULL,
  [EffectiveSalary] DECIMAL(28,8) NULL,
  [TargetSales] DECIMAL(28,8) NULL,
  [TargetSalesRate] DECIMAL(28,8) NULL,
  [RedLimit] DECIMAL(28,8) NULL,
  [WarningLimit] DECIMAL(28,8) NULL,
  [EffectDate] DATETIME NULL,
  [ExpiryDate] DATETIME NULL,
  [RelatedToTypeID] INT DEFAULT 47 NULL,
  [Disabled] TINYINT DEFAULT 0 NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_KPIT2020] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-------------------- 17/08/2019 - Tấn Lộc: Bổ sung cột TableID (Bảng hệ số lương mềm) --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'KPIT2020' AND col.name = 'TableID')
BEGIN
	ALTER TABLE KPIT2020 ADD TableID VARCHAR(MAX)
END
-------------------- 24/09/2019 - Tấn Lộc: Bổ sung cột TargetSalesKPI, BonusSalesKPI, PercentKPIManager --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'KPIT2020' AND col.name = 'TargetSalesKPI')
BEGIN
	ALTER TABLE KPIT2020 ADD TargetSalesKPI DECIMAL(28,8)
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'KPIT2020' AND col.name = 'BonusSalesKPI')
BEGIN
	ALTER TABLE KPIT2020 ADD BonusSalesKPI DECIMAL(28,8)
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'KPIT2020' AND col.name = 'PercentKPIManager')
BEGIN
	ALTER TABLE KPIT2020 ADD PercentKPIManager DECIMAL(28,8)
END

-------------------- 25/12/2019 - Tấn Lộc: Bổ sung cột ManagementStaff --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'KPIT2020' AND col.name = 'ManagementStaff')
BEGIN
	ALTER TABLE KPIT2020 ADD ManagementStaff VARCHAR(50)
END

-------------------- 17/08/2019 - Tấn Lộc: Bổ sung cột TableViolatedID (Bảng quy định giờ công vi phạm) --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'KPIT2020' AND col.name = 'TableViolatedID')
BEGIN
	ALTER TABLE KPIT2020 ADD TableViolatedID VARCHAR(50)
END