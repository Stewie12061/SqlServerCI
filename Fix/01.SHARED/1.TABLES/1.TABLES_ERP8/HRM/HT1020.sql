-- <Summary>
---- 
-- <History>
---- Create on 11/10/2010 by Thanh Trẫm
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT1020]') AND type in (N'U'))
CREATE TABLE [dbo].[HT1020](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](3) NOT NULL,
	[ShiftID] [nvarchar](50) NOT NULL,
	[ShiftName] [nvarchar](250) NULL,
	[Notes] [nvarchar](250) NULL,
	[RestrictID] [nvarchar](50) NULL,
	[BeginTime] [nvarchar](100) NULL,
	[EndTime] [nvarchar](100) NULL,
	[Disabled] [tinyint] NOT NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[Orders] [tinyint] NULL,
	[WorkingTime] [decimal](28, 8) NULL,
 CONSTRAINT [PK_HT1020] PRIMARY KEY NONCLUSTERED 
(
	[ShiftID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HT1020_Disabled]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT1020] ADD  CONSTRAINT [DF_HT1020_Disabled]  DEFAULT ((0)) FOR [Disabled]
END

--- Modify by Phương Thảo on 20/06/2016 : Add column IsAbsentShift
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1020' AND xtype = 'U')
BEGIN
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'HT1020' AND col.name = 'IsAbsentShift')
    ALTER TABLE HT1020 ADD IsAbsentShift TINYINT NULL
END

--- Modify by Bảo Thy on 06/12/2016: phân biệt ca làm việc theo đơn Approve, theo trạng thái thử việc/chính thức
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1020' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1020' AND col.name = 'IsDXP')
        ALTER TABLE HT1020 ADD IsDXP TINYINT NOT NULL DEFAULT (1) 
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1020' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1020' AND col.name = 'IsDXDC')
        ALTER TABLE HT1020 ADD IsDXDC TINYINT NOT NULL DEFAULT (1) 
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1020' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1020' AND col.name = 'IsDXLTG')
        ALTER TABLE HT1020 ADD IsDXLTG TINYINT NOT NULL DEFAULT (1) 
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1020' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1020' AND col.name = 'IsApprenticeShift')
        ALTER TABLE HT1020 ADD IsApprenticeShift TINYINT NULL
    END

--- Modify by Bảo Thy on 08/12/2016: bổ sung check ca nghỉ
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1020' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1020' AND col.name = 'IsShiftOff')
        ALTER TABLE HT1020 ADD IsShiftOff TINYINT NULL
    END

--- Modify by Khả Vi on 21/09/2017 : Add Column FromBreakTime, ToBreakTime (CustomerIndex = 81)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1020' AND xtype = 'U')
BEGIN
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	 ON col.id = tab.id WHERE tab.name = 'HT1020' AND col.name = 'FromBreakTime')
	ALTER TABLE HT1020 
	ADD FromBreakTime NVARCHAR(100) NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1020' AND xtype = 'U')
BEGIN
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	 ON col.id = tab.id WHERE tab.name = 'HT1020' AND col.name = 'ToBreakTime')
	ALTER TABLE HT1020 
	ADD ToBreakTime NVARCHAR(100) NULL
END