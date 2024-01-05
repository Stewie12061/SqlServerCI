---- Create by Cao Thị Phượng on 9/6/2017 9:47:09 AM
---- Dữ liệu code master loại phiếu cần duyệt

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CIT1200]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CIT1200]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [VoucherTypeID] VARCHAR(50) NOT NULL,
  [VoucherTypeName] NVARCHAR(250) NOT NULL,
  [TableID] VARCHAR(50) NOT NULL,
  [ColumnID] NVARCHAR(max) NOT NULL,
  [LevelID] TINYINT DEFAULT (0) NULL,
  [Disabled] TINYINT DEFAULT (0) NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [ModuleID] VARCHAR(50) NULL,
  [ScreenID] VARCHAR(50) NULL,
  [ConfirmColumnID] VARCHAR(250) NULL
CONSTRAINT [PK_CIT1200] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [VoucherTypeID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-------Tấn Đạt-21/03/2018 ---Add Column: ColumnSearch, TypeApprove, QueryDetail, IsTypeShow
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CIT1200' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CIT1200' AND col.name = 'ColumnSearch') 
   ALTER TABLE CIT1200 ADD ColumnSearch NVARCHAR(Max) NULL 
END

/*===============================================END ColumnSearch===============================================*/ 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CIT1200' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CIT1200' AND col.name = 'IsTypeApprove') 
   ALTER TABLE CIT1200 ADD IsTypeApprove TINYINT NULL 
END

/*===============================================END IsTypeApprove===============================================*/ 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CIT1200' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CIT1200' AND col.name = 'QueryDetail') 
   ALTER TABLE CIT1200 ADD QueryDetail NVARCHAR(Max) NULL 
END

/*===============================================END QueryDetail===============================================*/ 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CIT1200' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CIT1200' AND col.name = 'IsTypeShow') 
   ALTER TABLE CIT1200 ADD IsTypeShow TINYINT NULL 
END

/*===============================================END IsTypeShow===============================================*/ 