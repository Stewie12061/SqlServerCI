---- Create by Nguyen Hoang Bao Thy on 02/12/2015 9:31:21 AM
---- Đơn Xin Phép Làm Thêm Giờ
--- Update by Hoài Phong  on 23/11/2020 

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT2030]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[OOT2030]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
      [APKMaster] UNIQUEIDENTIFIER NOT NULL,
      [EmployeeID] VARCHAR(50) NOT NULL,
      [Reason] NVARCHAR(250) NOT NULL,
      [WorkFromDate] DATETIME NOT NULL,
      [WorkToDate] DATETIME NOT NULL,
      [Status] TINYINT DEFAULT (1) NOT NULL,
      [Note] NVARCHAR(250) NULL,
      [DeleteFlag] TINYINT DEFAULT (0) NULL,
      [ShiftID] VARCHAR(50) DEFAULT (0) NOT NULL,
      [TotalTime] DECIMAL(28,8) NULL
    CONSTRAINT [PK_OOT2030] PRIMARY KEY CLUSTERED
      (
      [APK]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

----Add column----
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2030' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT2030' AND col.name = 'OvertTime')
        ALTER TABLE OOT2030 ADD OvertTime DECIMAL(28,8) NULL
    END
    
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2030' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT2030' AND col.name = 'OvertTimeNN')
        ALTER TABLE OOT2030 ADD OvertTimeNN DECIMAL(28,8) NULL
    END
    
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2030' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT2030' AND col.name = 'OvertTimeCompany')
        ALTER TABLE OOT2030 ADD OvertTimeCompany DECIMAL(28,8) NULL
    END

--Modified on 07/12/2016 by Bảo Thy: Bổ sung FromWorkingDate, ToWorkingDate lưu ngày làm việc của NV
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2030' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT2030' AND col.name = 'FromWorkingDate')
        ALTER TABLE OOT2030 ADD FromWorkingDate DATETIME NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2030' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT2030' AND col.name = 'ToWorkingDate')
        ALTER TABLE OOT2030 ADD ToWorkingDate DATETIME NULL
    END

---- Modified on 03/01/2019 by Bảo Anh: Bổ sung cột số cấp phải duyệt và số cấp đã duyệt
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2030' AND xtype = 'U')
BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT2030' AND col.name = 'ApproveLevel') 
			ALTER TABLE OOT2030 ADD ApproveLevel TINYINT NOT NULL DEFAULT(0)

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT2030' AND col.name = 'ApprovingLevel') 
			ALTER TABLE OOT2030 ADD ApprovingLevel TINYINT NOT NULL DEFAULT(0)
END

---- Modified on 03/01/2019 by Hoài Phong: Bổ sung cột  từ ngày WorkDate cho NQH
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2030' AND xtype = 'U')
BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT2030' AND col.name = 'WorkDate') 
			ALTER TABLE OOT2030 ADD WorkDate DATETIME NULL
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2030' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT2030' AND col.name = 'TotalOT')
        ALTER TABLE OOT2030 ADD TotalOT DECIMAL(28,8) NULL
    END
--- Hoài Phong [15/01/2020]  - fix lỗi font do kiểu dữ liệu
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2030' AND xtype = 'U')
    BEGIN         
        ALTER TABLE OOT2030 ALTER COLUMN Reason NVARCHAR(250)         
    END

			