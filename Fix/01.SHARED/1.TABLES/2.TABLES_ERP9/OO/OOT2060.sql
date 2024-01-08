---- Create by Nguyen Hoang Bao Thy on 18/12/2015 8:32:41 AM
---- Danh Sach Xu Ly Bat Thuong

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT2060]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[OOT2060]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
      [EmployeeID] VARCHAR(50) NOT NULL,
      [Date] DATETIME NOT NULL,
      [Status] TINYINT DEFAULT (0) NOT NULL,
      [Fact] NVARCHAR(250) NOT NULL,
      [JugdeUnusualType] NVARCHAR(250) NOT NULL,
      [WorkingDate] DATETIME NULL,
      [BeginTime] DATETIME NULL,
      [EndTime] DATETIME NULL,
      [TranMonth] INT NOT NULL,
      [TranYear] INT NOT NULL,
      [DeleteFlag] TINYINT DEFAULT (0) NULL
    CONSTRAINT [PK_OOT2060] PRIMARY KEY CLUSTERED
      (
      [APK]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

--Đổi kiểu dữ liệu column
ALTER TABLE OOT2060
ALTER COLUMN BeginTime NVARCHAR(100)

ALTER TABLE OOT2060
ALTER COLUMN EndTime NVARCHAR(100)

ALTER TABLE OOT2060
ALTER COLUMN  [JugdeUnusualType] VARCHAR(50)

ALTER TABLE OOT2060
ALTER COLUMN  [Fact] VARCHAR(50)

 --Add column
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2060' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT2060' AND col.name = 'HandleMethodID')
        ALTER TABLE OOT2060 ADD HandleMethodID VARCHAR(50) NULL
    END
    
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2060' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT2060' AND col.name = 'ActBeginTime')
        ALTER TABLE OOT2060 ADD ActBeginTime NVARCHAR(100) NULL
    END
    
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2060' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT2060' AND col.name = 'ActEndTime')
        ALTER TABLE OOT2060 ADD ActEndTime NVARCHAR(100) NULL
    END
    
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2060' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT2060' AND col.name = 'CreateUserID')
        ALTER TABLE OOT2060 ADD CreateUserID VARCHAR(50) NULL
    END
    
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2060' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT2060' AND col.name = 'CreateDate')
        ALTER TABLE OOT2060 ADD CreateDate DATETIME NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2060' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT2060' AND col.name = 'LastModifyUserID')
        ALTER TABLE OOT2060 ADD LastModifyUserID VARCHAR(50) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2060' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT2060' AND col.name = 'LastModifyDate')
        ALTER TABLE OOT2060 ADD LastModifyDate DATETIME NULL
    END    

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2060' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT2060' AND col.name = 'IOCode')
        ALTER TABLE OOT2060 ADD IOCode TINYINT NULL
    END