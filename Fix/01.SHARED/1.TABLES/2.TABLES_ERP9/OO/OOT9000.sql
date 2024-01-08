-- <Summary>
---- Lưu thông tin duyệt master
-- <History>
---- Create on 07/11/2018 Tấn Phú
---- Modified by 07/11/2018 Như Hàn- Không bắt buộc nhập trường Department
-- <Example> 
IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT9000]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[OOT9000]
     (
		[APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
		[Status] TINYINT DEFAULT (0) NOT NULL,
		[DeleteFlag] TINYINT DEFAULT (0) NULL,
		[AppoveLevel] TINYINT DEFAULT (0) NOT NULL,
		[ApprovingLevel] TINYINT DEFAULT (0) NOT NULL,
		[AskForVehicle] TINYINT DEFAULT (0) NULL,
		[UseVehicle] TINYINT DEFAULT (0) NULL,
		[HaveLunch] TINYINT DEFAULT (0) NULL,
		[WorkType] TINYINT DEFAULT (0) NULL,
		[TranMonth] INT NOT NULL,
		[TranYear] INT NOT NULL,
		[CreateDate] DATETIME NULL,
		[LastModifyDate] DATETIME NULL,
		[DivisionID] VARCHAR(50) NOT NULL,
		[ID] VARCHAR(50) NOT NULL,
		[DepartmentID] VARCHAR(50) NOT NULL,
		[Type] VARCHAR(50) NULL,
		[SectionID] VARCHAR(50) NULL,
		[SubsectionID] VARCHAR(50) NULL,
		[ProcessID] VARCHAR(50) NULL,
		[CreateUserID] VARCHAR(50) NULL,
		[LastModifyUserID] VARCHAR(50) NULL,
		[Description] NVARCHAR(250) NULL
	CONSTRAINT [PK_OOT9000] PRIMARY KEY CLUSTERED
      (
		[APK],
		[DivisionID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		)
	ON [PRIMARY]
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT9000' AND xtype = 'U')
BEGIN 
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OOT9000' AND col.name = 'DepartmentID') 
   ALTER TABLE OOT9000 ALTER COLUMN DepartmentID VARCHAR(50) NULL 
END


--Modify by Bảo Toàn Date 20/02/2020 Tăng size [Description] (Đức Tín)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OOT9000' AND xtype='U')
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OOT9000' AND col.name='Description')
	ALTER TABLE OOT9000 ALTER COLUMN [Description] NVARCHAR(MAX) 
END