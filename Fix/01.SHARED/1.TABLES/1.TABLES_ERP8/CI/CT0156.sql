-- <Summary>
----Nghiệp vụ lập hợp đồng SIKICO
-- <History>
---- Create on 24/03/2022 by Kiều Nga 

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CT0156]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CT0156]
(
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[APKMaster] [uniqueidentifier] NOT NULL,
	[ContractDetailID] [uniqueidentifier] NOT NULL,
    [DivisionID] VARCHAR(50) NOT NULL,
	[PlotID] VARCHAR(50) NOT NULL,	
	[UnitPrice] DECIMAL(28,8) NULL,	
	[UnitPriceBrokerage] DECIMAL(28,8) NULL,	
	[OriginalAmount] DECIMAL(28,8) NULL,	
	[ConvertedAmount] DECIMAL(28,8) NULL,
	[VATGroupID] VARCHAR(50) NULL,
	[VATPercent] DECIMAL(28,8) NULL,
	[VATOriginalAmount] DECIMAL(28,8) NULL,	
	[VATConvertedAmount] DECIMAL(28,8) NULL,
	[TotalOriginalAmount] DECIMAL(28,8) NULL,	
	[TotalConvertedAmount] DECIMAL(28,8) NULL,
	[MapNo] NVARCHAR(50) NULL,
	[LandPlotNo] NVARCHAR(50) NULL,
	[Certificate] NVARCHAR(250) NULL,
	[CertificateNo] NVARCHAR(50) NULL,
	[CertificateDate] DATETIME NULL,
	[Notes] NVARCHAR(MAX) NULL,
	[InheritVoucherID] NVARCHAR(50) NULL,
	[InheritTransactionID] NVARCHAR(50) NULL,
	[InheritTableID] VARCHAR(50) NULL,
	[CreateUserID] VARCHAR(50) NULL,
    [CreateDate] DATETIME NULL,
    [LastModifyUserID] VARCHAR(50) NULL,
    [LastModifyDate] DATETIME NULL,
	CONSTRAINT [PK_CT0156] PRIMARY KEY NONCLUSTERED 
	(
		[DivisionID] ASC,
		[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
) ON [PRIMARY]
END

---- Modified on 05/05/2022 by Kiều Nga: Bổ sung trường ContractDetailID
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0156' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'CT0156' AND col.name = 'ContractDetailID')
        ALTER TABLE CT0156 ADD ContractDetailID [uniqueidentifier] NOT NULL
    END	 



