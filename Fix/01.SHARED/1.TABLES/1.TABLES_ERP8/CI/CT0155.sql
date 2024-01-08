-- <Summary>
----Nghiệp vụ lập hợp đồng SIKICO
-- <History>
---- Create on 22/03/2022 by Kiều Nga 

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CT0155]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CT0155]
(
	[APK] [uniqueidentifier] DEFAULT NEWID(),
    [DivisionID] VARCHAR(50) NOT NULL,
	[TranMonth] int NULL,
	[TranYear] int NULL,
	[ContractNo] VARCHAR(50) NOT NULL,	
	[VoucherTypeID] VARCHAR(50) NOT NULL,	
	[ContractName] NVARCHAR(250) NULL,	
	[ContractType] TINYINT NULL,	
	[SignDate] DATETIME NULL,	
	[ObjectID] VARCHAR(50) NULL,	
	[BeginDate] DATETIME NULL,	
	[EndDate] DATETIME NULL,	
	[CurrencyID] VARCHAR(50) NULL,	
	[ExchangeRate] DECIMAL(28,8) NULL,	
	[Description] NVARCHAR(250) NULL,	
	[OriginalAmount] DECIMAL(28,8) NULL,	
	[ConvertedAmount] DECIMAL(28,8) NULL,
	[ConvertedAmountLandLease] DECIMAL(28,8) NULL,	
	[ConvertedAmountBrokerage] DECIMAL(28,8) NULL,
	[AdministrativeExpenses] DECIMAL(28,8) NULL,
	[IsInheritMemorandum] TINYINT DEFAULT (0) NULL,
	[InheritMemorandumID] VARCHAR(50),
	[IsInheritOriginalContract] TINYINT DEFAULT (0) NULL,
	[InheritOriginalContractID] VARCHAR(50),
	[IsInheritLandLease] TINYINT DEFAULT (0) NULL,
	[InheritLandLeaseID] VARCHAR(50),
	[CreateUserID] VARCHAR(50) NULL,
    [CreateDate] DATETIME NULL,
    [LastModifyUserID] VARCHAR(50) NULL,
    [LastModifyDate] DATETIME NULL,
	CONSTRAINT [PK_CT0155] PRIMARY KEY NONCLUSTERED 
	(
		[DivisionID] ASC,
		[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
) ON [PRIMARY]
END

---- Modified on 14/04/2022 by Kiều Nga: Bổ sung trường chỉ số đăng ký điện, nước, nước xả thải
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0155' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'CT0155' AND col.name = 'RegistrationWater')
        ALTER TABLE CT0155 ADD RegistrationWater DECIMAL(28,8) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'CT0155' AND col.name = 'RegistrationElectricity')
        ALTER TABLE CT0155 ADD RegistrationElectricity DECIMAL(28,8) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'CT0155' AND col.name = 'RegistrationEnvironmentalFees')
        ALTER TABLE CT0155 ADD RegistrationEnvironmentalFees DECIMAL(28,8) NULL
    END	 

---- Modified on 22/04/2022 by Kiều Nga: Bổ sung trường tình trạng
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0155' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'CT0155' AND col.name = 'StatusID')
        ALTER TABLE CT0155 ADD StatusID TINYINT DEFAULT (1) NOT NULL
    END	 

---- Modified on 25/04/2022 by Kiều Nga: Bổ sung trường ngày bàn giao, ngày tính phí quản lý
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0155' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'CT0155' AND col.name = 'HandOverDate')
        ALTER TABLE CT0155 ADD HandOverDate DATETIME NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'CT0155' AND col.name = 'AdministrativeExpensesDate')
        ALTER TABLE CT0155 ADD AdministrativeExpensesDate DATETIME NULL
    END	 

	---- Modified on 14/07/2022 by Kiều Nga: Bổ sung trường ContractID
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0155' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'CT0155' AND col.name = 'ContractID')
        ALTER TABLE CT0155 ADD ContractID VARCHAR(50) NULL
    END	 