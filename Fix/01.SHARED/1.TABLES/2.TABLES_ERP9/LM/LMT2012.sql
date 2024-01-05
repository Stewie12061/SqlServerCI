-- <Summary>
---- Nghiệp vụ phong tỏa/giải tỏa TK ký quỹ detail (Asoft-LM)
-- <History>
---- Create on 31/10/2017 by Tiểu Mai
---- Modified on ... by 
-- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[LMT2012]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[LMT2012]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] NVARCHAR(50) NOT NULL,
	  [VoucherID] NVARCHAR(50) NOT NULL,
	  [TransactionID] NVARCHAR(50) NOT NULL,
	  [Orders] INT NULL,
	  [DepositContractNo] NVARCHAR(50) NULL,
	  [BankID] NVARCHAR(50) NULL,
	  [EscrowAmount] DECIMAL(28,8) NULL,
	  [ClearanceAmount] DECIMAL(28,8) NULL,
	  [InterestRate] DECIMAL(28,8) NULL,
	  [FromDate] DATETIME NULL,
	  [ToDate] DATETIME NULL,
	  [InterestAmount] DECIMAL(28,8) NULL
    CONSTRAINT [PK_LMT2012] PRIMARY KEY CLUSTERED
      (
		[DivisionID],
		[VoucherID],
		[TransactionID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

