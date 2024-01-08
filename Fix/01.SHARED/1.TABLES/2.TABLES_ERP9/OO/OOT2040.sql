---- Create by Nguyen Hoang Bao Thy on 02/12/2015 9:43:07 AM
---- Đơn Xin Phép Bổ Sung/Hủy Quẹt Thẻ

 
IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT2040]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[OOT2040]
     (
		[APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
		[APKMaster] UNIQUEIDENTIFIER NOT NULL,
		[Status] TINYINT DEFAULT (0) NOT NULL,
		[DeleteFlag] TINYINT DEFAULT (0) NULL,
		[InOut] TINYINT NULL,
		[EditType] TINYINT NOT NULL,
		[Date] DATETIME NOT NULL,
		[DivisionID] VARCHAR(50) NOT NULL,
		[EmployeeID] VARCHAR(50) NOT NULL,
		[Reason] NVARCHAR(250) NULL,
		[Note] NVARCHAR(250) NULL
	CONSTRAINT [PK_OOT2040] PRIMARY KEY CLUSTERED
      (
		[APK],
		[DivisionID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		)
	ON [PRIMARY]
END
----Add Column----
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2040' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT2040' AND col.name = 'EditType')
        ALTER TABLE OOT2040 ADD EditType TINYINT NULL
    END

--Modified on 07/12/2016 by Bảo Thy: Bổ sung WorkingDate lưu ngày làm việc của NV
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2040' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT2040' AND col.name = 'WorkingDate')
        ALTER TABLE OOT2040 ADD WorkingDate DATETIME NULL
    END

---- Modified on 03/01/2019 by Bảo Anh: Bổ sung cột số cấp phải duyệt và số cấp đã duyệt
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2040' AND xtype = 'U')
BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT2040' AND col.name = 'ApproveLevel') 
			ALTER TABLE OOT2040 ADD ApproveLevel TINYINT NOT NULL DEFAULT(0)

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT2040' AND col.name = 'ApprovingLevel') 
			ALTER TABLE OOT2040 ADD ApprovingLevel TINYINT NOT NULL DEFAULT(0)
END
--Modified on 15/07/2020 by Tuấn Anh: Bổ sung ShiftID ca làm việc
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2040' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT2040' AND col.name = 'ShiftID')
        ALTER TABLE OOT2040 ADD ShiftID VARCHAR(50) NULL
    END
	
	