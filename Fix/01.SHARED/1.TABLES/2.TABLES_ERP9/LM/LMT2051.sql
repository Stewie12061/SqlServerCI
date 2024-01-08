-- <Summary>
---- Danh mục hợp đồng bảo lãnh master (Asoft-LM)
-- <History>
---- Create on 16/10/2017 by Tiểu Mai
---- Modified on 31/01/2019 by Như Hàn: Bổ sung các trương kế thừa
---- Modified on 14/02/2019 by Như Hàn: Bổ sung trường loại điều chỉnh và trường là hợp đồng cũ, trường hợp đồng mới
-- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[LMT2051]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[LMT2051]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] NVARCHAR(50) NOT NULL,
	  [VoucherID] NVARCHAR(50) NOT NULL,
	  [VoucherTypeID] NVARCHAR(50) NULL,
	  [VoucherNo] NVARCHAR(50) NOT NULL,
	  [VoucherDate] DATETIME NOT NULL,
	  [TranMonth] INT NOT NULL,
	  [TranYear] INT NOT NULL,
	  [LimitVoucherID] NVARCHAR(50) NULL,
	  [CreditFormID] NVARCHAR(50) NULL,
	  [FromDate] DATETIME NULL,
	  [ToDate] DATETIME NULL,	  
	  [CurrencyID] NVARCHAR(50) NULL,
	  [ExchangeRate] DECIMAL(28,8) NULL,
	  [OriginalAmount] DECIMAL(28,8) NULL,
	  [ConvertedAmount] DECIMAL(28,8) NULL,
	  [ProjectID] NVARCHAR(50) NULL,
	  [PurchaseContractID] NVARCHAR(50) NULL,
	  [Status] TINYINT NULL,
      [Description] NVARCHAR(500) NULL,
	  [RelatedToTypeID] INT NOT NULL DEFAULT(9),
	  [IsAnswerable] TINYINT NOT NULL DEFAULT(0), 
	  [IsUseLoanContract] TINYINT NOT NULL DEFAULT(0), 
	  [Parameter01] NVARCHAR(250) NULL,
	  [Parameter02] NVARCHAR(250) NULL,
	  [Parameter03] NVARCHAR(250) NULL,
	  [Parameter04] NVARCHAR(250) NULL,
	  [Parameter05] NVARCHAR(250) NULL,
	  [Parameter06] NVARCHAR(250) NULL,
	  [Parameter07] NVARCHAR(250) NULL,
	  [Parameter08] NVARCHAR(250) NULL,
	  [Parameter09] NVARCHAR(250) NULL,
	  [Parameter10] NVARCHAR(250) NULL,
      [Parameter11] NVARCHAR(250) NULL,
	  [Parameter12] NVARCHAR(250) NULL,
	  [Parameter13] NVARCHAR(250) NULL,
	  [Parameter14] NVARCHAR(250) NULL,
	  [Parameter15] NVARCHAR(250) NULL,
	  [Parameter16] NVARCHAR(250) NULL,
	  [Parameter17] NVARCHAR(250) NULL,
	  [Parameter18] NVARCHAR(250) NULL,
	  [Parameter19] NVARCHAR(250) NULL,
	  [Parameter20] NVARCHAR(250) NULL,
	  [IsType] TINYINT DEFAULT(0) NULL, ---- 0: Hợp đồng bảo lãnh, 1: Phiếu điều chỉnh, 2: Hợp đồng bảo lãnh cũ (Lưu vết khi điều chỉnh)
	  [GuaranteeVoucherID] NVARCHAR(50) NULL, ---- VoucherID của Hợp đồng BL có Type = 1 (Phiếu điều chỉnh)
      [CreateUserID] NVARCHAR(50) NULL,
      [CreateDate] DATETIME NULL,
      [LastModifyUserID] NVARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL
    CONSTRAINT [PK_LMT2051] PRIMARY KEY CLUSTERED
      (
	  [DivisionID],
      [VoucherID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'LMT2051' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'LMT2051' AND col.name = 'ObjectID') 
   ALTER TABLE LMT2051 ADD ObjectID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'LMT2051' AND col.name = 'InheritTableID') 
   ALTER TABLE LMT2051 ADD InheritTableID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'LMT2051' AND col.name = 'InheritVoucherID') 
   ALTER TABLE LMT2051 ADD InheritVoucherID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'LMT2051' AND col.name = 'InheritTransactionID') 
   ALTER TABLE LMT2051 ADD InheritTransactionID VARCHAR(50) NULL 
END


IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'LMT2051' AND xtype = 'U')
    BEGIN

        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'LMT2051' AND col.name = 'AdjustedTypeID')
        ALTER TABLE LMT2051 ADD AdjustedTypeID VARCHAR (50) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'LMT2051' AND col.name = 'OldGuaranteeVoucherID')
        ALTER TABLE LMT2051 ADD OldGuaranteeVoucherID VARCHAR (50) NULL ---- VoucherID của Hợp đồng BL được lưu làm lịch sử - phiếu điều chỉnh 

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'LMT2051' AND col.name = 'NewGuaranteeVoucherID')
        ALTER TABLE LMT2051 ADD NewGuaranteeVoucherID VARCHAR (50) NULL ---- VoucherID của Hợp đồng BL ban đầu - dòng lịch sửa điều chỉnh (HĐ BL cũ)
	END

	----- Modified by Như Hàn on 23/04/2019: Bổ sung lưu ngân hàng cho hợp đồng bảo lãnh
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'LMT2051' AND xtype = 'U')
	BEGIN

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'LMT2051' AND col.name = 'BankID')
		ALTER TABLE LMT2051 ADD BankID VARCHAR(50) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'LMT2051' AND col.name = 'BankAccountID')
		ALTER TABLE LMT2051 ADD BankAccountID VARCHAR(50) NULL

	END		