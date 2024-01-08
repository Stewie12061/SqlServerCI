-- <Summary>
---- Danh mục hợp đồng hạn mức tín dụng, master (Asoft-LM)
-- <History>
---- Create on 25/06/2017 by Bảo Anh
---- Modified on ... by 
-- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[LMT1010]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[LMT1010]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
	  [TranMonth] INT NOT NULL,
	  [TranYear] INT NOT NULL,
	  [VoucherID] VARCHAR(50) NOT NULL,
	  [VoucherTypeID] VARCHAR(50) NULL,
	  [VoucherNo] VARCHAR(50) NOT NULL,
	  [VoucherDate] DATETIME NOT NULL,
	  [FromDate] DATETIME NULL,
	  [ToDate] DATETIME NULL,
	  [BankID] VARCHAR(50) NULL,
	  [BankAccountID] VARCHAR(50) NULL,
	  [CurrencyID] VARCHAR(50) NULL,
	  [ExchangeRate] DECIMAL(28,8) NULL,
	  [OriginalLimitTotal] DECIMAL(28,8) NULL,
	  [ConvertedLimitTotal] DECIMAL(28,8) NULL,
      [Description] NVARCHAR(250) NULL,
	  [RelatedToTypeID] INT NOT NULL DEFAULT(2),
      [CreateUserID] VARCHAR(50) NULL,
      [CreateDate] DATETIME NULL,
      [LastModifyUserID] VARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL
    CONSTRAINT [PK_LMT1010] PRIMARY KEY CLUSTERED
      (
	  [DivisionID],
      [VoucherID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

---- Modififed by Như Hàn on 09/01/2018: Bổ sung trường IsAppendixofcontract (Là phụ lục hợp đồng), ContractNo (Số hợp đồng gốc)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'LMT1010' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'LMT1010' AND col.name = 'IsAppendixofcontract') 
   ALTER TABLE LMT1010 ADD IsAppendixofcontract TINYINT NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'LMT1010' AND col.name = 'ContractNo') 
   ALTER TABLE LMT1010 ADD ContractNo VARCHAR(50) NULL 
END