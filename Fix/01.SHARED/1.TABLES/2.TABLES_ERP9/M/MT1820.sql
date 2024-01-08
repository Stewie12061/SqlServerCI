---- Create by Đình Ly on 06/10/2020
---- Bảng dữ liệu danh mục Nguồn lực.

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[MT1820]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[MT1820]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
	  [ResourceTypeID] VARCHAR(50) NOT NULL,
      [ResourceID] VARCHAR(50) NOT NULL,
      [ResourceName] NVARCHAR(250) NULL,
	  [Notes] NVARCHAR(500) NULL,
      [Efficiency] DECIMAL(28) NULL,
	  [LinedUpTime] DECIMAL(28) NULL,
	  [SettingTime] DECIMAL(28) NULL,
	  [WaittingTime] DECIMAL(28) NULL,
	  [TransferTime] DECIMAL(28)  NULL,
	  [MaxTime] DECIMAL(28) NULL,
	  [MinTime] DECIMAL(28) NULL,
      [Disabled] TINYINT DEFAULT (0) NOT NULL,
	  [IsCommon] TINYINT DEFAULT (0) NOT NULL,
      [CreateUserID] VARCHAR(50) NULL,
      [CreateDate] DATETIME NULL,
      [LastModifyUserID] VARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL
    CONSTRAINT [PK_MT1820] PRIMARY KEY CLUSTERED
      (
      [DivisionID],
      [ResourceID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

---------------- 27/12/2020 - Đình Ly: Bổ sung cột UnitID ----------------

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'MT1820' AND col.name = 'UnitID')
BEGIN
	ALTER TABLE MT1820 ADD UnitID VARCHAR(50) NULL
END