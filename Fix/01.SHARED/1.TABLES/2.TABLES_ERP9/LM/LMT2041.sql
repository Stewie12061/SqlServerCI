-- <Summary>
---- Nghiệp vụ điều chỉnh (Asoft-LM)
-- <History>
---- Create on 07/07/2017 by Bảo Anh
---- Modified on 24/01/2019 by Như Hàn: Thêm trường thời gian điều chỉnh Từ - Đến
---- Modified on ... by 
-- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[LMT2041]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[LMT2041]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
	  [VoucherID] VARCHAR(50) NOT NULL,
	  [VoucherTypeID] VARCHAR(50) NULL,
	  [VoucherNo] VARCHAR(50) NOT NULL,
	  [VoucherDate] DATETIME NOT NULL,
	  [TranMonth] INT NOT NULL,
	  [TranYear] INT NOT NULL,
	  [AdjustFromDate] DATETIME NOT NULL,
	  [BankAccountID] VARCHAR(50) NULL,
	  [CreditVoucherID] VARCHAR(50) NULL,
	  [DisburseVoucherID] VARCHAR(50) NULL,
	  [CurrencyID] VARCHAR(50) NULL,
	  [ExchangeRate] DECIMAL(28,8),
	  [AdjustTypeID] TINYINT NULL,	--- 0: thay đổi lãi suất, 1: trả trước
	  [BeforeOriginalAmount] DECIMAL(28,8),	--- Số tiền trả trước (nguyên tệ)
	  [BeforeConvertedAmount] DECIMAL(28,8),	--- Số tiền trả trước (quy đổi)
	  [PunishRate] DECIMAL(28,8),	--- Lãi phạt trả trước
	  [AdjustRate] DECIMAL(28,8),	--- Lãi suất điều chỉnh
	  [RateBy] TINYINT NULL,
      [Description] NVARCHAR(500) NULL,
	  [RelatedToTypeID] INT NOT NULL DEFAULT(8),
      [CreateUserID] VARCHAR(50) NULL,
      [CreateDate] DATETIME NULL,
      [LastModifyUserID] VARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL
    CONSTRAINT [PK_LMT2041] PRIMARY KEY CLUSTERED
      (
	  [DivisionID],
      [VoucherID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

If Exists (Select * From sysobjects Where name = 'LMT2041' and xtype ='U') 
Begin 
	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name =   'LMT2041'  and col.name = 'AdjustTime')
	Alter Table  LMT2041 Add AdjustTime INT Null

	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name =   'LMT2041'  and col.name = 'AdjustTimeFromDate')
	Alter Table  LMT2041 Add AdjustTimeFromDate DATETIME Null

	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name =   'LMT2041'  and col.name = 'AdjustTimeToDate')
	Alter Table  LMT2041 Add AdjustTimeToDate DATETIME Null
End
