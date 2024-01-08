-- <Summary>
---- Giải chấp tài sản - Detail (Asoft-LM)
-- <History>
---- Create on 25/10/2017 by Hải Long
---- Modified on ... by 
-- <Example> drop table [LMT2061]

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[LMT2061]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[LMT2061]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] NVARCHAR(50) NOT NULL,
	  [VoucherID] NVARCHAR(50) NOT NULL,
	  [TransactionID] NVARCHAR(50) NOT NULL,	  
	  [AssetID] NVARCHAR(50) NOT NULL,	
	  [LoanVoucherID] NVARCHAR(50) NULL,
	  [LoanTransactionID] NVARCHAR(50) NULL,
	  [UnwindAmount] DECIMAL(28,8) NULL,
	  [Orders] TINYINT NULL
    CONSTRAINT [PK_LMT2061] PRIMARY KEY CLUSTERED
      (
		[DivisionID],
		[VoucherID],
		[TransactionID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END