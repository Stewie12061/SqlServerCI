-- <Summary>
---- Nghiệp vụ thanh toán hợp đồng tín dụng (Asoft-LM)
-- <History>
---- Create on 07/07/2017 by Bảo Anh
---- Modified on ... by 
-- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[LMT2031]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[LMT2031]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
	  [VoucherID] VARCHAR(50) NOT NULL,
	  [VoucherTypeID] VARCHAR(50) NULL,
	  [VoucherNo] VARCHAR(50) NOT NULL,
	  [VoucherDate] DATETIME NOT NULL,
	  [TranMonth] INT NOT NULL,
	  [TranYear] INT NOT NULL,
	  [BankAccountID] VARCHAR(50) NULL,
	  [CreditVoucherID] VARCHAR(50) NULL,	--- hợp đồng tín dụng
	  [DisburseVoucherID] VARCHAR(50) NULL,	--- chứng từ giải ngân
	  [CurrencyID] VARCHAR(50) NULL,
	  [ExchangeRate] DECIMAL(28,8) NULL,
	  [AfterRatePercent] DECIMAL(28,8) NULL,	--- lãi suất phạt quá hạn
	  [Description] NVARCHAR(250) NULL,
	  [TransactionID] VARCHAR(50) NOT NULL,
	  [Orders] INT NULL,
	  [PaymentPlanTransactionID] VARCHAR(50) NULL,	--- TransactionID của lịch trả nợ
	  [PaymentDate] DATETIME NULL,	--- ngày thanh toán theo lịch trả nợ
	  [PaymentName] NVARCHAR(250) NULL,	--- Tên khoản thanh toán
	  [PaymentType] INT NOT NULL DEFAULT(0),	--- loại thanh toán (0: nợ gốc, 1: lãi vay, 2: phạt trước hạn, 3: phạt trễ hạn)
	  [ActualDate] DATETIME NULL,	--- ngày thanh toán thực tế
	  [ActualOriginalAmount] DECIMAL(28,8) NULL,	--- nguyên tệ thanh toán thực tế
	  [ActualConvertedAmount] DECIMAL(28,8) NULL,	--- quy đổi thanh toán thực tế
	  [IsPrePayment] BIT NOT NULL DEFAULT(0),	--- là khoản trả trước
	  [PaymentAccountID] VARCHAR(50) NULL,	--- TK ghi nhận khoản thanh toán
	  [CostTypeID] VARCHAR(50) NULL,	--- loại chi phí
      [Notes] NVARCHAR(250) NULL,
	  [InheritTableName] VARCHAR(50) NULL,
	  [InheritVoucherID] VARCHAR(50) NULL,
	  [InheritTransactionID] VARCHAR(50) NULL,
	  [RelatedToTypeID] INT NOT NULL DEFAULT(7),	--- mã loại nghiệp vụ (dùng ghi nhận lịch sử, email, đính kèm, ghi chú)
      [CreateUserID] VARCHAR(50) NULL,
      [CreateDate] DATETIME NULL,
      [LastModifyUserID] VARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL
    CONSTRAINT [PK_LMT2031] PRIMARY KEY CLUSTERED
      (
	  [DivisionID],
      [VoucherID],
	  [TransactionID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='LMT2031' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='LMT2031' AND col.name='PaymentTransactionID')
		ALTER TABLE LMT2031 ADD PaymentTransactionID VARCHAR(50) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='LMT2031' AND col.name='Paymentsource')
		ALTER TABLE LMT2031 ADD Paymentsource NVARCHAR(100) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='LMT2031' AND col.name='BeforeRatePercent')
		ALTER TABLE LMT2031 ADD BeforeRatePercent DECIMAL(28,8) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='LMT2031' AND col.name='LateRatePercent')
		ALTER TABLE LMT2031 ADD LateRatePercent DECIMAL(28,8) NULL
	END