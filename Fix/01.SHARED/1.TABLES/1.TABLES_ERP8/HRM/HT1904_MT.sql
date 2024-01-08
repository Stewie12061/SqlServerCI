-- <Summary>
---- Lưu thông tin chấm công sản phẩm theo công đoạn
-- <History>
---- Create on 22/04/2021 by Lê Hoàng
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT1904_MT]') AND type in (N'U'))
CREATE TABLE [dbo].[HT1904_MT](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] nvarchar(3) NOT NULL,
	[ProductID] [nvarchar](50) NOT NULL,
	[PriceSheetID] [nvarchar](50) NOT NULL,
	[ProducingProcessID] [nvarchar](50) NOT NULL,
	[PhaseID] [nvarchar](50) NOT NULL,
	[UnitID] [nvarchar](50) NOT NULL,
	[TranMonth] [int] NOT NULL,
	[TranYear] [int] NOT NULL,
	[PeriodID] [nvarchar](50) NULL,
	[DepartmentID] [nvarchar](50) NULL,
	[TeamID] [nvarchar](50) NULL,
	[EmployeeID] [nvarchar](MAX) NULL,
	[Employee] [varchar](MAX) NULL,
	[ProduceDate] [datetime] NOT NULL,
	[ProduceQuantity] [decimal](28, 8) NULL,
	[Values01] [nvarchar](50) NOT NULL,
	[Quantity01] [decimal](28, 8) NULL,
	[UnitPrice01] [decimal](28, 8) NULL,
	[Values02] [nvarchar](50) NOT NULL,
	[Quantity02] [decimal](28, 8) NULL,
	[UnitPrice02] [decimal](28, 8) NULL,
	[Values03] [nvarchar](50) NOT NULL,
	[Quantity03] [decimal](28, 8) NULL,
	[UnitPrice03] [decimal](28, 8) NULL,
	[Values04] [nvarchar](50) NOT NULL,
	[Quantity04] [decimal](28, 8) NULL,
	[UnitPrice04] [decimal](28, 8) NULL,
	[Values05] [nvarchar](50) NOT NULL,
	[Quantity05] [decimal](28, 8) NULL,
	[UnitPrice05] [decimal](28, 8) NULL,
	[Properties01] [nvarchar](50) NOT NULL,
	[Properties02] [nvarchar](50) NOT NULL,
	[Properties03] [nvarchar](50) NOT NULL,
	[Quantity] [decimal](28, 8) NULL,
	[UnitPrice] [decimal](28, 8) NULL,
	[Amount] [decimal](28, 8) NULL,
	[MoldID] [nvarchar](50) NOT NULL,
	[MoldAmount] [decimal](28, 8) NULL,
	[Total] [decimal](28, 8) NULL,
	[Notes] [nvarchar](250) NULL,
	CONSTRAINT [PK_HT1904_MT] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME = 'HT1904_MT' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='HT1904_MT' AND col.name='CreateDate')
		ALTER TABLE HT1904_MT ADD CreateDate DATETIME DEFAULT(GETDATE())
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='HT1904_MT' AND col.name='CreateUserID')
		ALTER TABLE HT1904_MT ADD CreateUserID NVARCHAR(50) NULL 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='HT1904_MT' AND col.name='LastModifyDate')
		ALTER TABLE HT1904_MT ADD LastModifyDate DATETIME DEFAULT(GETDATE())
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='HT1904_MT' AND col.name='LastModifyUserID')
		ALTER TABLE HT1904_MT ADD LastModifyUserID NVARCHAR(50) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME = 'HT1904_MT' AND xtype='U')
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='HT1904_MT' AND col.name='UnitID')
		ALTER TABLE HT1904_MT ALTER COLUMN UnitID NVARCHAR(50) NULL 
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='HT1904_MT' AND col.name='EmployeeID')
		ALTER TABLE HT1904_MT ALTER COLUMN EmployeeID NVARCHAR(50) NULL 
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='HT1904_MT' AND col.name='Employee')
		ALTER TABLE HT1904_MT ALTER COLUMN Employee VARCHAR(MAX) NULL 
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='HT1904_MT' AND col.name='ProduceDate')
		ALTER TABLE HT1904_MT ALTER COLUMN ProduceDate DATETIME NULL 
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='HT1904_MT' AND col.name='Values01')
		ALTER TABLE HT1904_MT ALTER COLUMN Values01 NVARCHAR(50) NULL 
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='HT1904_MT' AND col.name='Values02')
		ALTER TABLE HT1904_MT ALTER COLUMN Values02 NVARCHAR(50) NULL 
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='HT1904_MT' AND col.name='Values03')
		ALTER TABLE HT1904_MT ALTER COLUMN Values03 NVARCHAR(50) NULL 
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='HT1904_MT' AND col.name='Values04')
		ALTER TABLE HT1904_MT ALTER COLUMN Values04 NVARCHAR(50) NULL 
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='HT1904_MT' AND col.name='Values05')
		ALTER TABLE HT1904_MT ALTER COLUMN Values05 NVARCHAR(50) NULL 
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='HT1904_MT' AND col.name='MoldID')
		ALTER TABLE HT1904_MT ALTER COLUMN MoldID NVARCHAR(50) NULL 
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='HT1904_MT' AND col.name='Properties01')
		ALTER TABLE HT1904_MT ALTER COLUMN Properties01 DECIMAL(28, 8) NULL 
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='HT1904_MT' AND col.name='Properties02')
		ALTER TABLE HT1904_MT ALTER COLUMN Properties02 DECIMAL(28, 8) NULL 
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='HT1904_MT' AND col.name='Properties03')
		ALTER TABLE HT1904_MT ALTER COLUMN Properties03 DECIMAL(28, 8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME = 'HT1904_MT' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='HT1904_MT' AND col.name='TimekeepingDate')
		ALTER TABLE HT1904_MT ADD TimekeepingDate DATETIME NULL 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='HT1904_MT' AND col.name='RefAPKMaster')
		ALTER TABLE HT1904_MT ADD RefAPKMaster uniqueidentifier NULL
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='HT1904_MT' AND col.name='RefAPKDetail')
		ALTER TABLE HT1904_MT ADD RefAPKDetail uniqueidentifier NULL
END

---- Modified on 22/10/2021 by Lê Hoàng : điều chỉnh thông tin cột
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME = 'HT1904_MT' AND xtype='U')
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='HT1904_MT' AND col.name='EmployeeID')
		ALTER TABLE HT1904_MT ALTER COLUMN EmployeeID NVARCHAR(MAX) NULL 
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='HT1904_MT' AND col.name='Employee')
		ALTER TABLE HT1904_MT ALTER COLUMN Employee NVARCHAR(MAX) NULL 
END
