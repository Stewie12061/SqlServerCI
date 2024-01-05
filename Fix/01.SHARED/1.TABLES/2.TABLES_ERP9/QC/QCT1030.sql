---- Create by Đình Ly on 23/02/2021
---- Bảng dữ liệu danh mục Lý do.

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[QCT1030]') AND TYPE IN (N'U'))
BEGIN
	CREATE TABLE [dbo].[QCT1030]
	(
		[APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
		[DivisionID] VARCHAR(50) NOT NULL,
		[ReasonID] VARCHAR(50) NOT NULL,
		[ReasonName] NVARCHAR(500) NULL,
		[DepartmentID] VARCHAR(50) NOT NULL,
		[PhaseID] VARCHAR(50) NOT NULL,
		[Description] NVARCHAR(500) NULL,
		[Disabled] TINYINT DEFAULT (0) NOT NULL,
		[IsCommon] TINYINT DEFAULT (0) NOT NULL,
		[CreateUserID] VARCHAR(50) NULL,
		[CreateDate] DATETIME NULL,
		[LastModifyUserID] VARCHAR(50) NULL,
		[LastModifyDate] DATETIME NULL
    CONSTRAINT [PK_QCT1030] PRIMARY KEY CLUSTERED
	(
		[DivisionID],
		[ReasonID]
	)
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]) ON [PRIMARY]
END

---------------- 19/05/2021 - Minh Phúc: Drop cột DepartmentID ----------------
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'QCT1030' AND xtype ='U') 
BEGIN
     If EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name =   'QCT1030'  AND col.name = 'DepartmentID')
     ALTER TABLE QCT1030 DROP COLUMN DepartmentID 
END

---------------- 19/05/2021 - Minh Phúc: Modify cho phép PhaseID NULL ----------------
IF EXISTS (SELECT * From sysobjects WHERE name = 'QCT1030' AND xtype ='U') 
BEGIN
     If EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name =   'QCT1030'  AND col.name = 'PhaseID')
     ALTER TABLE QCT1030 ALTER COLUMN PhaseID [varchar](50) NULL
END
