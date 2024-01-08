---- Create by Đức Thông 
---- Lưu thông tin tầng
IF NOT EXISTS (
		SELECT TOP 1 1
		FROM sys.objects
		WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[WT0170]')
			AND TYPE IN (N'U')
		)
BEGIN
	CREATE TABLE [dbo].[WT0170] (
		[APK] [uniqueidentifier] NULL
		,[DivisionID] [nvarchar](50) NOT NULL
		,[FloorID] [nvarchar](50) NOT NULL
		,[ShelvesID] [nvarchar](50) NOT NULL
		,[WareHouseID] [nvarchar](50) NOT NULL
		,[FloorName] [nvarchar](250) NULL
		,[Description] [nvarchar](250) NULL
		,[Disabled] [tinyint] NOT NULL
		,[CreateDate] [datetime] NULL
		,[CreateUserID] [nvarchar](50) NULL
		,[LastModifyDate] [datetime] NULL
		,[LastModifyUserID] [nvarchar](50) NULL
		,CONSTRAINT [PK_WT0170] PRIMARY KEY CLUSTERED (
			[FloorID] ASC
			,[ShelvesID] ASC
			,[WareHouseID] ASC
			,[DivisionID] ASC
			) WITH (
			PAD_INDEX = OFF
			,STATISTICS_NORECOMPUTE = OFF
			,IGNORE_DUP_KEY = OFF
			,ALLOW_ROW_LOCKS = ON
			,ALLOW_PAGE_LOCKS = ON
			) ON [PRIMARY]
		) ON [PRIMARY]

	ALTER TABLE [dbo].[WT0170] ADD DEFAULT(newid())
	FOR [APK]

	ALTER TABLE [dbo].[WT0170] ADD CONSTRAINT [DF_WT0170_Disabled] DEFAULT((0))
	FOR [Disabled]

	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='WT0170' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='WT0170' AND col.name='WarrantyNo')
		ALTER TABLE WT0169 DROP COLUMN WarrantyNo
	END
END

