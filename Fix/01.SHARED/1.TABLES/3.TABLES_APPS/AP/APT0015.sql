IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[APT0015]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[APT0015]
     (
		[APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
		[ClientID] NVARCHAR(250) NOT NULL,
		[Platform] NVARCHAR(50) NOT NULL,
		[Version] VARCHAR(50) NOT NULL,
		[Level] INT NOT NULL,
		[VersionCode] INT NOT NULL,
		[ClientName] NVARCHAR(250) NULL,
		[DownloadLink] NVARCHAR(500) NULL,
		[DeleteFlg] TINYINT DEFAULT (0) NULL,
		[CreateUserID] VARCHAR(50) NULL,
		[LastModifyUserID] VARCHAR(50) NULL,
		[CreateDate] DATETIME2 DEFAULT SYSUTCDATETIME() NULL,
		[LastModifyDate] DATETIME2 DEFAULT SYSUTCDATETIME() NULL

		CONSTRAINT [PK_APT0015] PRIMARY KEY CLUSTERED
		(
			[ClientID],
			[Platform],
			[Version]
		)
		WITH (
			PAD_INDEX  = OFF,
			STATISTICS_NORECOMPUTE  = OFF,
			IGNORE_DUP_KEY = OFF,
			ALLOW_ROW_LOCKS  = ON,
			ALLOW_PAGE_LOCKS  = ON
			)
		ON [PRIMARY]
     )
	 ON [PRIMARY]
END

IF(EXISTS(
	SELECT *
	FROM sys.indexes
	WHERE name='IDX_APT0015_VersionCode' AND object_id = OBJECT_ID('[dbo].[APT0015]')
))
BEGIN
	DROP INDEX [IDX_APT0015_VersionCode] ON dbo.[APT0015];
END

CREATE NONCLUSTERED INDEX [IDX_APT0015_VersionCode] ON [dbo].[APT0015]([VersionCode])

------Modified by Thành Luân on 12/09/2019: Bổ sung CustomKey
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0015' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'APT0015' AND col.name = 'ExtensionKey')
   ALTER TABLE [dbo].[APT0015] ADD ExtensionKey NVARCHAR(512) NULL
END