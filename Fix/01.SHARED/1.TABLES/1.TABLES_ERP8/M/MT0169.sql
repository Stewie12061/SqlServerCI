-- <Summary>
---- 
-- <History>
---- Create on 02/03/2016 by Bảo Anh: kế hoạch dự tính sản xuất (Angel)
---- Modified on ... by ...

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MT0169]') AND type in (N'U'))
CREATE TABLE [dbo].[MT0169](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[VoucherID] [nvarchar](50) NOT NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[VoucherTypeID] [nvarchar](50) NULL,
	[VoucherNo] [nvarchar](50) NULL,
	[VoucherDate] [datetime] NULL,
	[Description] [nvarchar](250) NULL,
	[EmployeeID] [nvarchar](50) NULL,
	[PurchasePlanID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
 CONSTRAINT [PK_MT0169] PRIMARY KEY NONCLUSTERED 
(
	[DivisionID] ASC,
	[VoucherID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

---- Modified on 17/03/2019 by Kim Thư: Bổ sung PlanPeriodMonth, PlanPeriodYear Kỳ kế hoạch, TypeOfAdjustPlan - loại điều chỉnh
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'MT0169' AND xtype ='U') 
BEGIN
    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT0169' AND col.name = 'PlanPeriodMonth')
    ALTER TABLE MT0169 ADD PlanPeriodMonth INT NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT0169' AND col.name = 'PlanPeriodYear')
    ALTER TABLE MT0169 ADD PlanPeriodYear INT NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT0169' AND col.name = 'TypeOfAdjustPlan')
    ALTER TABLE MT0169 ADD TypeOfAdjustPlan TINYINT NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT0169' AND col.name = 'VoucherDateOrigin')
    ALTER TABLE MT0169 ADD VoucherDateOrigin DATETIME NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT0169' AND col.name = 'InheritVoucherID')
    ALTER TABLE MT0169 ADD InheritVoucherID VARCHAR(50) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT0169' AND col.name = 'TeamID')
    ALTER TABLE MT0169 ADD TeamID VARCHAR(50) NULL
END 

