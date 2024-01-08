---- Create by Nguyen Hoang Bao Thy on 27/11/2015 1:09:00 PM
---- Đơn Xin Nghỉ Phép

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT2010]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[OOT2010]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
      [APKMaster] UNIQUEIDENTIFIER NOT NULL,
      [EmployeeID] VARCHAR(50) NOT NULL,
      [Reason] NVARCHAR(250) NOT NULL,
      [AbsentTypeID] VARCHAR(50) NOT NULL,
      [LeaveFromDate] DATETIME NOT NULL,
      [LeaveToDate] DATETIME NOT NULL,
      [Status] TINYINT DEFAULT (1) NOT NULL,
      [Note] NVARCHAR(250) NULL,
      [DeleteFlag] TINYINT DEFAULT (0) NULL,
      [TotalTime] DECIMAL NULL
    CONSTRAINT [PK_OOT2010] PRIMARY KEY CLUSTERED
      (
      [APK]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END


----Đổi kiểu dữ liệu cho comlumn----

ALTER TABLE OOT2010
ALTER COLUMN TotalTime DECIMAL(18,2)

----Add column----
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2010' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT2010' AND col.name = 'OffsetTime')
        ALTER TABLE OOT2010 ADD OffsetTime DECIMAL(28,2) NULL
    END
    
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2010' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT2010' AND col.name = 'TimeAllowance')
        ALTER TABLE OOT2010 ADD TimeAllowance DECIMAL(28,2) NULL
    END

--Modified on 20/02/2016 by Bảo Thy: Bổ sung cột ca làm việc ShiftID, OldShiftID 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2010' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT2010' AND col.name = 'ShiftID')
        ALTER TABLE OOT2010 ADD ShiftID VARCHAR(50) NULL
    END

 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2010' AND xtype = 'U')
    BEGIN
        IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT2010' AND col.name = 'AbsentTypeID')
        ALTER TABLE OOT2010 ALTER COLUMN AbsentTypeID VARCHAR(50) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2010' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT2010' AND col.name = 'OldShiftID')
        ALTER TABLE OOT2010 ADD OldShiftID VARCHAR(50) NULL
    END

--Modified on 07/12/2016 by Bảo Thy: Bổ sung FromWorkingDate, ToWorkingDate lưu ngày làm việc của NV
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2010' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT2010' AND col.name = 'FromWorkingDate')
        ALTER TABLE OOT2010 ADD FromWorkingDate DATETIME NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2010' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT2010' AND col.name = 'ToWorkingDate')
        ALTER TABLE OOT2010 ADD ToWorkingDate DATETIME NULL
    END

--Modified on 04/01/2017 by Bảo Thy: bổ sung check IsNextDay
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2010' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT2010' AND col.name = 'IsNextDay')
        ALTER TABLE OOT2010 ADD IsNextDay TINYINT NOT NULL DEFAULT(0)
    END

---- Modified on 28/06/2017 by Phương Thảo: Check đơn hợp lên theo quy định ĐTVS
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2010' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OOT2010' AND col.name = 'IsValid') 
   ALTER TABLE OOT2010 ADD IsValid INT NULL 
END

---- Modified on 25/12/2018 by Bảo Anh: Bổ sung cột tổng số ngày xin nghỉ, số cấp phải duyệt và số cấp đã duyệt, check phân biệt Xin phép hàng loạt
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2010' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OOT2010' AND col.name = 'TotalDay') 
   ALTER TABLE OOT2010 ADD TotalDay DECIMAL(18,2) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT2010' AND col.name = 'ApproveLevel') 
			ALTER TABLE OOT2010 ADD ApproveLevel TINYINT NOT NULL DEFAULT(0)

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT2010' AND col.name = 'ApprovingLevel') 
			ALTER TABLE OOT2010 ADD ApprovingLevel TINYINT NOT NULL DEFAULT(0)

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT2010' AND col.name = 'IsSeri') 
			ALTER TABLE OOT2010 ADD IsSeri TINYINT NOT NULL DEFAULT(0)

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT2010' AND col.name = 'ID') 
			ALTER TABLE OOT2010 ADD ID VARCHAR(50) NULL
END