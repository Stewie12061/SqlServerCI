-- <Summary>
---- Danh mục hợp đồng tín dụng, master (Asoft-LM)
-- <History>
---- Create on 27/06/2017 by Bảo Anh
---- Modified on ... by 
-- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[LMT2001]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[LMT2001]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
	  [VoucherID] VARCHAR(50) NOT NULL,
	  [VoucherTypeID] VARCHAR(50) NULL,
	  [VoucherNo] VARCHAR(50) NOT NULL,
	  [VoucherDate] DATETIME NOT NULL,
	  [TranMonth] INT NOT NULL,
	  [TranYear] INT NOT NULL,
	  [LimitVoucherID] VARCHAR(50) NULL,
	  [CreditFormID] VARCHAR(50) NULL,
	  [BankAccountID] VARCHAR(50) NULL,
	  [FromDate] DATETIME NULL,
	  [ToDate] DATETIME NULL,	  
	  [CurrencyID] VARCHAR(50) NULL,
	  [ExchangeRate] DECIMAL(28,8) NULL,
	  [OriginalAmount] DECIMAL(28,8) NULL,
	  [ConvertedAmount] DECIMAL(28,8) NULL,
	  [ProjectID] VARCHAR(50) NULL,
	  [PurchaseContractID] VARCHAR(50) NULL,
	  [Status] TINYINT NULL,
      [Description] NVARCHAR(500) NULL,
	  [RelatedToTypeID] INT NOT NULL DEFAULT(3),
      [CreateUserID] VARCHAR(50) NULL,
      [CreateDate] DATETIME NULL,
      [LastModifyUserID] VARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL
    CONSTRAINT [PK_LMT2001] PRIMARY KEY CLUSTERED
      (
	  [DivisionID],
      [VoucherID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

----- Modified by Tiểu Mai on 03/10/2017: Bổ sung tham số quản lý vay	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'LMT2001' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id = tab.id WHERE tab.name = 'LMT2001' AND col.name = 'Parameter01')
			ALTER TABLE LMT2001 ADD [Parameter01] nvarchar(250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id = tab.id WHERE tab.name = 'LMT2001' AND col.name = 'Parameter02')
			ALTER TABLE LMT2001 ADD [Parameter02] [nvarchar](250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id = tab.id WHERE tab.name = 'LMT2001' AND col.name = 'Parameter03')
			ALTER TABLE LMT2001 ADD [Parameter03] [nvarchar](250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id = tab.id WHERE tab.name = 'LMT2001' AND col.name = 'Parameter04')
			ALTER TABLE LMT2001 ADD [Parameter04] [nvarchar](250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id = tab.id WHERE tab.name = 'LMT2001' AND col.name = 'Parameter05')
			ALTER TABLE LMT2001 ADD [Parameter05] [nvarchar](250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id = tab.id WHERE tab.name = 'LMT2001' AND col.name = 'Parameter06')
			ALTER TABLE LMT2001 ADD [Parameter06] [nvarchar](250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id = tab.id WHERE tab.name = 'LMT2001' AND col.name = 'Parameter07')
			ALTER TABLE LMT2001 ADD [Parameter07] [nvarchar](250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id = tab.id WHERE tab.name = 'LMT2001' AND col.name = 'Parameter08')
			ALTER TABLE LMT2001 ADD [Parameter08] [nvarchar](250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id = tab.id WHERE tab.name = 'LMT2001' AND col.name = 'Parameter09')
			ALTER TABLE LMT2001 ADD [Parameter09] [nvarchar](250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id = tab.id WHERE tab.name = 'LMT2001' AND col.name = 'Parameter10')
			ALTER TABLE LMT2001 ADD [Parameter10] [nvarchar](250) NULL
			
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id = tab.id WHERE tab.name = 'LMT2001' AND col.name = 'Parameter11')
			ALTER TABLE LMT2001 ADD [Parameter11] nvarchar(250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id = tab.id WHERE tab.name = 'LMT2001' AND col.name = 'Parameter12')
			ALTER TABLE LMT2001 ADD [Parameter12] [nvarchar](250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id = tab.id WHERE tab.name = 'LMT2001' AND col.name = 'Parameter13')
			ALTER TABLE LMT2001 ADD [Parameter13] [nvarchar](250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id = tab.id WHERE tab.name = 'LMT2001' AND col.name = 'Parameter14')
			ALTER TABLE LMT2001 ADD [Parameter14] [nvarchar](250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id = tab.id WHERE tab.name = 'LMT2001' AND col.name = 'Parameter15')
			ALTER TABLE LMT2001 ADD [Parameter15] [nvarchar](250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id = tab.id WHERE tab.name = 'LMT2001' AND col.name = 'Parameter16')
			ALTER TABLE LMT2001 ADD [Parameter16] [nvarchar](250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id = tab.id WHERE tab.name = 'LMT2001' AND col.name = 'Parameter17')
			ALTER TABLE LMT2001 ADD [Parameter17] [nvarchar](250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id = tab.id WHERE tab.name = 'LMT2001' AND col.name = 'Parameter18')
			ALTER TABLE LMT2001 ADD [Parameter18] [nvarchar](250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id = tab.id WHERE tab.name = 'LMT2001' AND col.name = 'Parameter19')
			ALTER TABLE LMT2001 ADD [Parameter19] [nvarchar](250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id = tab.id WHERE tab.name = 'LMT2001' AND col.name = 'Parameter20')
			ALTER TABLE LMT2001 ADD [Parameter20] [nvarchar](250) NULL
	END
	
----- Modified by Hải Long on 20/10/2017: Bổ sung trường hợp đồng bảo lãnh ContractOfGuaranteeID
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'LMT2001' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id = tab.id WHERE tab.name = 'LMT2001' AND col.name = 'ContractOfGuaranteeID')
			ALTER TABLE LMT2001 ADD [ContractOfGuaranteeID] nvarchar(50) NULL
	END				

----- Modified by Như Hàn on 05/03/2018: Bổ sung lưu ngân hàng cho hợp đồng vay
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'LMT2001' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id = tab.id WHERE tab.name = 'LMT2001' AND col.name = 'BankID')
			ALTER TABLE LMT2001 ADD BankID VARCHAR(50) NULL
	END				