-- <Summary>
---- Lịch trả nợ (Asoft-LM)
-- <History>
---- Create on 11/07/2017 by Bảo Anh
---- Modified on ... by 
-- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[LMT2022]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[LMT2022]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
	  [TransactionID] VARCHAR(50) NOT NULL,
	  [DisburseVoucherID] VARCHAR(50) NULL,
	  [Description] NVARCHAR(250) NULL,
	  [PaymentDate] DATETIME NOT NULL,
	  [TranMonth] INT NOT NULL,
	  [TranYear] INT NOT NULL,
	  [CurrencyID] VARCHAR(50) NULL,
	  [ExchangeRate] DECIMAL(28,8) NULL,
	  [PaymentName] NVARCHAR(250) NOT NULL,
	  [PaymentOriginalAmount] DECIMAL(28,8) NULL,
	  [PaymentConvertedAmount] DECIMAL(28,8) NULL,
	  [PaymentAccountID] VARCHAR(50) NULL,
	  [CostTypeID] VARCHAR(50) NULL,
	  [PaymentType] INT NOT NULL,	--- 0: nợ gốc, 1: lãi vay, 2: phạt trước hạn, 3: phạt trễ hạn
	  [IsNotPayment] BIT NOT NULL DEFAULT(0),	--- 1: đối với tiền lãi của các khoản trả trước (phần điều chỉnh)
	  [RelatedToTypeID] INT NOT NULL DEFAULT(6),
	  [CreateUserID] VARCHAR(50) NULL,
      [CreateDate] DATETIME NULL,
      [LastModifyUserID] VARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL
    CONSTRAINT [PK_LMT2022] PRIMARY KEY CLUSTERED
      (
	  [DivisionID],
      [TransactionID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END