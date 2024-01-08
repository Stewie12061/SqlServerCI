---- Create by Đình Ly on 06/10/2020
---- Bảng dữ liệu master Nghiệp vụ quy trình sản xuất.

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[MT2130]') AND TYPE IN (N'U'))
BEGIN
	CREATE TABLE [dbo].[MT2130]
	(
		[APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
		[DivisionID] VARCHAR(50) NOT NULL,
		[RoutingID] VARCHAR(50) NOT NULL,
		[RoutingName] NVARCHAR(250) NOT NULL,
		[RoutingTypeID] VARCHAR(50) NULL,
		[UnitID] VARCHAR(50) NOT NULL,
		[Notes] NVARCHAR(500) NULL,
		[RoutingTime] DECIMAL(28) NULL,
		[Disabled] TINYINT DEFAULT (0) NOT NULL,
		[CreateUserID] VARCHAR(50) NULL,
		[CreateDate] DATETIME NULL,
		[LastModifyUserID] VARCHAR(50) NULL,
		[LastModifyDate] DATETIME NULL

    CONSTRAINT [PK_MT2130] PRIMARY KEY CLUSTERED ([DivisionID],[RoutingID])
		WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
END

---------------- Đình Ly - [25/06/2021] : Cập nhật kiểu dữ liệu ----------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='MT2130' AND xtype='U')
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='MT2130' AND col.name='RoutingTime')
	
	ALTER TABLE MT2130 ALTER COLUMN RoutingTime DECIMAL(28,8) NULL
END
