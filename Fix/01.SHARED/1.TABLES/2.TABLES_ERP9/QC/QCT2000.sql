---- Create by Le Hoang on 01/10/2020
---- Phiếu quản lý chất lượng đầu Ca (Master)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[QCT2000]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[QCT2000](
	[APK] [uniqueidentifier] DEFAULT NEWID() NOT NULL,
	[DivisionID] [varchar](50) NOT NULL,
	[VoucherNo] [varchar](50) NULL,
	[VoucherDate] [datetime] NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[ShiftID] [varchar](50) NULL,
	[MachineID] [varchar](50) NULL,
	[EmployeeID01] [varchar](50) NULL,
	[EmployeeID02] [varchar](50) NULL,
	[EmployeeID03] [varchar](50) NULL,
	[EmployeeID04] [varchar](50) NULL,
	[EmployeeID05] [varchar](50) NULL,
	[EmployeeID06] [varchar](50) NULL,
	[Description] [nvarchar](250) NULL,
	[Notes01] [nvarchar](250) NULL,
	[Notes02] [nvarchar](250) NULL,
	[Notes03] [nvarchar](250) NULL,
	[Status] [int] NULL,
	[DeleteFlg] [tinyint] DEFAULT 0 NOT NULL,
	[CreateDate] [datetime] DEFAULT GETDATE() NULL,
	[CreateUserID] [varchar](50) NULL,
	[LastModifyDate] [datetime] DEFAULT GETDATE() NULL,
	[LastModifyUserID] [varchar](50) NULL,
 CONSTRAINT [PK_QCT2000] PRIMARY KEY CLUSTERED 
(
	[APK] ASC,
	[DivisionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
If Exists (Select * From sysobjects Where name = 'QCT2000' and xtype ='U') 
Begin
    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'QCT2000'  and col.name = 'VoucherTypeID')
    Alter Table QCT2000 ADD VoucherTypeID [varchar](50) NULL

	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'QCT2000'  and col.name = 'DepartmentID')
    Alter Table QCT2000 ADD DepartmentID [varchar](50) NULL

	-- 02/02/2021 - [Đình Ly] - Begin add
	-- Bổ sung cột Bảng kế thừa
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id where tab.name =   'QCT2000'  and col.name = 'InheritTable')
	ALTER TABLE QCT2000 ADD InheritTable VARCHAR(50) NULL

	-- Bổ sung cột Phiếu kế thừa
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id where tab.name =   'QCT2000'  and col.name = 'InheritVoucher')
	ALTER TABLE QCT2000 ADD InheritVoucher VARCHAR(50) NULL
	-- 02/02/2021 - [Đình Ly] - End add

	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'QCT2000'  and col.name = 'ObjectID')
    Alter Table QCT2000 ADD ObjectID [varchar](50) NULL

	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'QCT2000'  and col.name = 'Ana04ID')
    Alter Table QCT2000 ADD Ana04ID [varchar](50) NULL

	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'QCT2000'  and col.name = 'Levels')
    Alter Table QCT2000 ADD Levels INT NULL

	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'QCT2000'  and col.name = 'StatusSS')
    Alter Table QCT2000 ADD StatusSS TinyInt NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'QCT2000' AND col.name = 'ApprovingLevel')
    ALTER TABLE QCT2000 ADD ApprovingLevel INT NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'QCT2000' AND col.name = 'ApproveLevel')
    ALTER TABLE QCT2000 ADD ApproveLevel INT NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'QCT2000' AND col.name = 'APKMaster_9000')
	BEGIN
    ALTER TABLE QCT2000 ADD APKMaster_9000 uniqueidentifier NULL
	END

	-- Bổ sung cột Phiếu kế thừa
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id where tab.name =   'QCT2000'  and col.name = 'SourceNo')
	ALTER TABLE QCT2000 ADD SourceNo VARCHAR(50) NULL

	-- Bổ sung cột Phiếu kế thừa
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id where tab.name =   'QCT2000'  and col.name = 'EmployeeID07')
	ALTER TABLE QCT2000 ADD EmployeeID07 VARCHAR(50) NULL
	-- Bổ sung cột Phiếu kế thừa
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id where tab.name =   'QCT2000'  and col.name = 'ApprovalNotes')
	ALTER TABLE QCT2000 ADD ApprovalNotes NVARCHAR(250) NULL
END