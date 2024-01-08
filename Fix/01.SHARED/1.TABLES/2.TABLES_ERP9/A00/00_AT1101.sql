IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[AT1101]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[AT1101]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
      [DivisionName] NVARCHAR(250) NULL,
      [DivisionNameE] NVARCHAR(250) NULL,
      [Tel] NVARCHAR(100) NULL,
      [Fax] NVARCHAR(100) NULL,
      [Email] NVARCHAR(100) NULL,
      [Address] NVARCHAR(250) NULL,
      [AddressE] NVARCHAR(250) NULL,
      [ContactPerson] NVARCHAR(250) NULL,
      [VATNO] NVARCHAR(50) NULL,
      [BeginMonth] INT NULL,
      [BeginYear] INT NULL,
      [ImageLogo] NTEXT NULL,
      [Logo] IMAGE NULL,
      [Disabled] TINYINT DEFAULT (0) NOT NULL,
      [CreateUserID] VARCHAR(50) NULL,
      [CreateDate] DATETIME NULL,
      [LastModifyUserID] VARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL
    CONSTRAINT [PK_AT1101] PRIMARY KEY CLUSTERED
      (
      [DivisionID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

--Thêm Đơn vị cha để quản lý cây trong sơ đồ tổ chức
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1101' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'ParentDivisionID')
   ALTER TABLE AT1101 ADD ParentDivisionID VARCHAR(50) NULL
END