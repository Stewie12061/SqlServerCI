-- <Summary>
---- Nghiệp vụ giải ngân hợp đồng tín dụng (Asoft-LM)
-- <History>
---- Create on 27/06/2017 by Bảo Anh
---- Modified on 16/01/2019 by Như Hàn: Bổ sung thêm LateRatePercent (Lãi chậm trả)
-- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[LMT2021]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[LMT2021]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
	  [VoucherID] VARCHAR(50) NOT NULL,
	  [CreditVoucherID] VARCHAR(50) NULL,
	  [VoucherTypeID] VARCHAR(50) NULL,
	  [VoucherNo] VARCHAR(50) NOT NULL,
	  [VoucherDate] DATETIME NOT NULL,
	  [TranMonth] INT NOT NULL,
	  [TranYear] INT NOT NULL,
	  [FromDate] DATETIME NULL,
	  [ToDate] DATETIME NULL,
	  [BankAccountID] VARCHAR(50) NULL,
	  [NumOfMonths] INT NULL,
	  [CurrencyID] VARCHAR(50) NULL,
	  [ExchangeRate] DECIMAL(28,8) NULL,
	  [AdvanceOAmount] DECIMAL(28,8) NULL,
	  [AdvanceCAmount] DECIMAL(28,8) NULL,
	  [OriginalAmount] DECIMAL(28,8) NULL,
	  [ConvertedAmount] DECIMAL(28,8) NULL,
      [Description] NVARCHAR(250) NULL,
	  [OriginalMethod] TINYINT NULL,
	  [OriginalAccountID] VARCHAR(50) NULL,
	  [OriginalCostTypeID] VARCHAR(50) NULL,
	  [BeforeRatePercent] DECIMAL(28,8) NULL,
	  [AfterRatePercent] DECIMAL(28,8) NULL,
	  [RateMethod] TINYINT NULL,
	  [RateAccountID] VARCHAR(50) NULL,
	  [RateCostTypeID] VARCHAR(50) NULL,
	  [RatePercent] DECIMAL(28,8) NULL,
	  [RateBy] TINYINT NULL,
	  [RelatedToTypeID] INT NOT NULL DEFAULT(5),
      [CreateUserID] VARCHAR(50) NULL,
      [CreateDate] DATETIME NULL,
      [LastModifyUserID] VARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL
    CONSTRAINT [PK_LMT2021] PRIMARY KEY CLUSTERED
      (
	  [DivisionID],
      [VoucherID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='LMT2021' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='LMT2021' AND col.name='LateRatePercent')
		ALTER TABLE LMT2021 ADD LateRatePercent DECIMAL(28,8) NULL
	END	