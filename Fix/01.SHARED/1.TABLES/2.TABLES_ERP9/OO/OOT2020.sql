---- Create by Nguyen Hoang Bao Thy on 02/12/2015 9:13:59 AM
---- Đơn Xin Phép Ra Ngoài

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT2020]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[OOT2020]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
      [APKMaster] UNIQUEIDENTIFIER NOT NULL,
      [EmployeeID] VARCHAR(50) NOT NULL,
      [Status] TINYINT DEFAULT (1) NOT NULL,
      [Reason] NVARCHAR(250) NULL,
      [Place] NVARCHAR(250) NULL,
      [GoFromDate] DATETIME NOT NULL,
      [GoToDate] DATETIME NOT NULL,
      [Note] NVARCHAR(250) NULL,
      [DeleteFlag] TINYINT DEFAULT (0) NULL
    CONSTRAINT [PK_OOT2020] PRIMARY KEY CLUSTERED
      (
      [APK]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

--Add column

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2020' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT2020' AND col.name = 'TotalTime')
        ALTER TABLE OOT2020 ADD TotalTime DECIMAL(28,8) NULL
    END
    
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2020' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT2020' AND col.name = 'GoStraight')
        ALTER TABLE OOT2020 ADD GoStraight TINYINT NULL
    END
    
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2020' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT2020' AND col.name = 'ComeStraight')
        ALTER TABLE OOT2020 ADD ComeStraight TINYINT NULL
    END

--Modified on 07/12/2016 by Bảo Thy: Bổ sung FromWorkingDate, ToWorkingDate lưu ngày làm việc của NV
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2020' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT2020' AND col.name = 'FromWorkingDate')
        ALTER TABLE OOT2020 ADD FromWorkingDate DATETIME NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2020' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT2020' AND col.name = 'ToWorkingDate')
        ALTER TABLE OOT2020 ADD ToWorkingDate DATETIME NULL
    END

---- Modified on 03/01/2019 by Bảo Anh: Bổ sung cột số cấp phải duyệt và số cấp đã duyệt
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2020' AND xtype = 'U')
BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT2020' AND col.name = 'ApproveLevel') 
			ALTER TABLE OOT2020 ADD ApproveLevel TINYINT NOT NULL DEFAULT(0)

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT2020' AND col.name = 'ApprovingLevel') 
			ALTER TABLE OOT2020 ADD ApprovingLevel TINYINT NOT NULL DEFAULT(0)
END