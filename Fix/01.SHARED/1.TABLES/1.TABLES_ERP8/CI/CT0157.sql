-- <Summary>
----Nghiệp vụ lập hợp đồng SIKICO
-- <History>
---- Create on 24/03/2022 by Kiều Nga 

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CT0157]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CT0157]
(
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[APKMaster] [uniqueidentifier] NOT NULL,
	[ContractDetailID] [uniqueidentifier] NOT NULL,
    [DivisionID] VARCHAR(50) NOT NULL,
	[Orders] INT NULL,	
	[StepName] NVARCHAR(MAX) NOT NULL,	
	[PaymentPercent] DECIMAL(28,8) NULL,	
	[PaymentAmount] DECIMAL(28,8) NULL,
	[RequestDate] Datetime NULL,
	[PaymentStatus] TINYINT DEFAULT (0),
	[PaymentDate] Datetime NULL,
	[Paymented] DECIMAL(28,8) NULL,
	[Notes] NVARCHAR(MAX) NULL,
	[InheritVoucherID] NVARCHAR(50) NULL,
	[InheritTransactionID] NVARCHAR(50) NULL,
	[InheritTableID] VARCHAR(50) NULL,
	[CreateUserID] VARCHAR(50) NULL,
    [CreateDate] DATETIME NULL,
    [LastModifyUserID] VARCHAR(50) NULL,
    [LastModifyDate] DATETIME NULL,
	CONSTRAINT [PK_CT0157] PRIMARY KEY NONCLUSTERED 
	(
		[DivisionID] ASC,
		[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
) ON [PRIMARY]
END

---- Modified on 05/05/2022 by Kiều Nga: Bổ sung trường ContractDetailID
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0157' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'CT0157' AND col.name = 'ContractDetailID')
        ALTER TABLE CT0157 ADD ContractDetailID [uniqueidentifier] NOT NULL DEFAULT NEWID()
    END	 

---- Modified on 21/06/2022 by Kiều Nga: Bổ sung trường UnpaidPayment
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0157' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'CT0157' AND col.name = 'UnpaidPayment')
        ALTER TABLE CT0157 ADD UnpaidPayment DECIMAL(28,8) NULL
    END	 

---- Modified on 21/06/2022 by Kiều Nga: Bổ sung trường APKDetailID
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0157' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'CT0157' AND col.name = 'APKDetailID')
        ALTER TABLE CT0157 ADD APKDetailID [uniqueidentifier] NOT NULL DEFAULT NEWID()
    END	 


