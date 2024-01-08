---- Created by Anh Đô on 21/06/2023
---- Bảng master chỉ tiêu/công việc

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT2290]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT2290]
(
	[APK]					UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
	[DivisionID]			VARCHAR(50) NOT NULL,
	[TargetTaskID]			VARCHAR(50) NOT NULL,
	[TargetTaskName]		NVARCHAR(250) NOT NULL,
	[TypeID]				VARCHAR(50) NOT NULL,
	[PriorityID]			INT NOT NULL,
	[BeginDate]				DATETIME NOT NULL,
	[EndDate]				DATETIME NOT NULL,
	[RequestUserID]			VARCHAR(50) NOT NULL,
	[AssignedDepartmentID]	VARCHAR(50) NULL,
	[AssignedTeamID]		VARCHAR(50) NULL,
	[AssignedUserID]		VARCHAR(50) NULL,
	[Description]			NVARCHAR(MAX) NULL,
	[CreateUserID]			VARCHAR(50) NOT NULL,
	[CreateDate]			DATETIME NOT NULL,
	[LastModifyUserID]		VARCHAR(50) NULL,
	[LastModifyDate]		DATETIME NULL,
	[DeleteFlg]				TINYINT NOT NULL DEFAULT 0

	CONSTRAINT [PK_OOT2290] PRIMARY KEY CLUSTERED
	(
		[DivisionID], [TargetTaskID]
	)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'OOT2290' AND col.name = 'StatusID')
BEGIN
	ALTER TABLE OOT2290 ADD StatusID VARCHAR(50) NULL
END

---------------- 06/12/2019 - Tấn Lộc: Thay đổi kiểu dữ liệu của các cột ----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2290' AND col.name = 'TargetTaskName')
BEGIN
	ALTER TABLE OOT2290 ALTER COLUMN TargetTaskName NVARCHAR(MAX) NULL
END

IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2290' AND col.name = 'TypeID')
BEGIN
	ALTER TABLE OOT2290 ALTER COLUMN TypeID VARCHAR(250) NULL
END

IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2290' AND col.name = 'RequestUserID')
BEGIN
	ALTER TABLE OOT2290 ALTER COLUMN RequestUserID VARCHAR(250) NULL
END

IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2290' AND col.name = 'CreateUserID')
BEGIN
	ALTER TABLE OOT2290 ALTER COLUMN CreateUserID VARCHAR(250) NULL
END