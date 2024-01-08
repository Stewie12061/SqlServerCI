-- <Summary>
---- Lưu thiết lập xét duyệt
-- <History>
---- Create on 18/12/2018 Bảo Anh
---- Modified on 19/06/2020 Vĩnh Tâm: Bổ sung column IsApplyCondition cho các db Old.
---- Modified on 20/11/2023 Thanh Lượng: Bổ sung column SameLevel(Customize Gree)
IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[ST0010]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[ST0010]
     (
		[APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
		[DivisionID] VARCHAR(50) NOT NULL,
		[TypeID] VARCHAR(50) NOT NULL,
		[Levels] INT NOT NULL,
		[ConditionTypeID] VARCHAR(50) NULL,
		[ID] VARCHAR(50) NULL,
		[IsAppCondition] TINYINT NOT NULL DEFAULT(0),
		[DataTypeID] INT NULL,
		[DirectionTypeID] TINYINT NOT NULL DEFAULT(0),	--- 1: duyệt từ trên xuống, 0: duyệt từ dưới lên 
		[LevelNo] INT NULL,
		[ConditionFrom] DECIMAL(28,8) NULL,
		[ConditionTo] DECIMAL(28,8) NULL		

	CONSTRAINT [PK_ST0010] PRIMARY KEY CLUSTERED
      (
		[APK]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		)
	ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST0010' AND col.name = 'IsApplyCondition')
BEGIN
	ALTER TABLE ST0010 ADD IsApplyCondition INT DEFAULT 0
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab  ON col.id = tab.id WHERE tab.name = 'ST0010' AND col.name = 'CaseID')
	ALTER TABLE ST0010 ADD CaseID INT NULL
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab  ON col.id = tab.id WHERE tab.name = 'ST0010' AND col.name = 'ApproveTypeID1')
	ALTER TABLE ST0010 ADD ApproveTypeID1 VARCHAR(50) NULL
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab  ON col.id = tab.id WHERE tab.name = 'ST0010' AND col.name = 'DepartmentID')
	ALTER TABLE ST0010 ADD DepartmentID VARCHAR(50) NULL

	
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab  ON col.id = tab.id WHERE tab.name = 'ST0010' AND col.name = 'ConditionFrom')
	ALTER TABLE ST0010 alter column ConditionFrom VARCHAR(50) NULL
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab  ON col.id = tab.id WHERE tab.name = 'ST0010' AND col.name = 'ConditionTo')
	ALTER TABLE ST0010 alter column ConditionTo VARCHAR(50) NULL

-- 20/11/2023 BEGIN ADD - Customize thêm trường SameLevel cho KH GREE
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST0010' AND col.name = 'SameLevels')
BEGIN
	ALTER TABLE ST0010 ADD SameLevels INT NULL
END

-- 20/11/2023 BEGIN ADD - Customize thêm trường SameLevel cho KH GREE
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'ST0010' AND col.name = 'IsSameLevels')
BEGIN
	ALTER TABLE ST0010 ADD IsSameLevels TINYINT NULL
END