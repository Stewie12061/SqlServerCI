-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Cam Loan
---- Modified on ... by ...
---- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT1302]') AND type in (N'U'))
CREATE TABLE [dbo].[HT1302](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[HistoryID] [nvarchar](50) NOT NULL,
	[EmployeeID] [nvarchar](50) NOT NULL,
	[IsPast] [tinyint] NULL,
	[FromMonth] [int] NULL,
	[FromYear] [int] NULL,
	[ToMonth] [int] NULL,
	[ToYear] [int] NULL,	
	[DivisionName] [nvarchar](250) NULL,
	[DepartmentID] [nvarchar](50) NULL,
	[DepartmentName] [nvarchar](250) NULL,
	[TeamID] [nvarchar](50) NULL,
	[TeamName] [nvarchar](250) NULL,
	[DutyID] [nvarchar](50) NULL,
	[DutyName] [nvarchar](250) NULL,
	[Works] [nvarchar](250) NULL,
	[SalaryAmounts] [decimal](28, 8) NULL,
	[SalaryCoefficient] [decimal](28, 8) NULL,
	[Contactor] [nvarchar](250) NULL,
	[ContactAddress] [nvarchar](250) NULL,
	[ContactTelephone] [nvarchar](50) NULL,
	[DivisionIDOld] [nvarchar](50) NULL,
	[DepartmentIDOld] [nvarchar](50) NULL,
	[TeamIDOld] [nvarchar](50) NULL,
	[DutyIDOld] [nvarchar](50) NULL,
	[WorksOld] [nvarchar](250) NULL,
	[IsBeforeTranfer] [tinyint] NULL,
	[Description] [nvarchar](250) NULL,
	[Notes] [nvarchar](250) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[FromDate] [datetime] NULL,
	[ToDate] [datetime] NULL,
 CONSTRAINT [PK_HT1302] PRIMARY KEY NONCLUSTERED 
(
	[HistoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

--- Modify by Phương Thảo
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1302' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1302' AND col.name = 'SectionIDOld')
        ALTER TABLE HT1302 ADD SectionIDOld NVARCHAR(50) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1302' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1302' AND col.name = 'SectionID')
        ALTER TABLE HT1302 ADD SectionID NVARCHAR(50) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1302' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1302' AND col.name = 'ProcessIDOld')
        ALTER TABLE HT1302 ADD ProcessIDOld NVARCHAR(50) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1302' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1302' AND col.name = 'ProcessID')
        ALTER TABLE HT1302 ADD ProcessID NVARCHAR(50) NULL
    END

--- Modified on 10/01/201 by Bảo Anh: Bổ sung khu vực trước và sau khi thuyên chuyển
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1302' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1302' AND col.name = 'ProvinceOld')
        ALTER TABLE HT1302 ADD ProvinceOld NVARCHAR(500) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1302' AND col.name = 'Province')
        ALTER TABLE HT1302 ADD Province NVARCHAR(500) NULL
    END