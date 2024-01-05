---- Create by Truong Lam on 24/08/2019
---- Chi tiết giá trị công việc tham gia

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[KPIT2041]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[KPIT2041]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER NULL,
  [DivisionID] VARCHAR(50) NULL,
  [TargetsGroupID] VARCHAR(50) NULL,
  [TargetsGroupName] NVARCHAR(MAX) NULL,
  [TargetsGroupValue] DECIMAL(28,2) NULL,
  [PercentTargets] DECIMAL(28,2) NULL,
  [TypeTargets] INT NULL
CONSTRAINT [PK_KPIT2041] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-------------------- 26/09/2019 - Truong lam: Thêm cột TypeData- phân loại dữ liệu --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'KPIT2041' AND col.name = 'TypeData')
BEGIN
  ALTER TABLE KPIT2041 ADD TypeData INT
END

-------------------- 08/10/2019 - Truong lam: Thêm cột STT --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'KPIT2041' AND col.name = 'STT')
BEGIN
  ALTER TABLE KPIT2041 ADD STT VARCHAR(50) NULL
END

-------------------- 07/06/2021 - Văn Tài: Cập nhật cột--------------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'KPIT2041' AND col.name = 'TargetsGroupName')
BEGIN
  ALTER TABLE KPIT2041 ALTER COLUMN TargetsGroupName NVARCHAR(MAX) NULL
END

-------------------- 05/07/2021 - Văn Tài: Bổ sung cột cộng dồn: Chỉ số của target group --------------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'KPIT2041' AND col.name = 'ContinuousTargetsValue')
BEGIN
  ALTER TABLE KPIT2041 ALTER COLUMN ContinuousTargetsValue DECIMAL(18, 8) NULL
END

-------------------- 05/07/2021 - Văn Tài: Bổ sung cột cộng dồn: Chỉ số của target group --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'KPIT2041' AND col.name = 'ContinuousTargetsValue')
BEGIN
  ALTER TABLE KPIT2041 ADD ContinuousTargetsValue DECIMAL(18, 8) NULL
END

-------------------- 05/07/2021 - Văn Tài: Bổ sung cột cộng dồn: Chỉ số của percent target --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'KPIT2041' AND col.name = 'ContinuousTargetsPercent')
BEGIN
  ALTER TABLE KPIT2041 ADD ContinuousTargetsPercent DECIMAL(18, 8) NULL
END
