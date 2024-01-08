-- <Summary>
---- Danh mục hợp đồng bảo lãnh, chi tiết hợp đồng vay (Asoft-LM)
-- <History>
---- Create by Tiểu Mai on 12/10/2017
---- Modified on ... by 
-- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[LMT2053]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[LMT2053]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
	  [VoucherID] VARCHAR(50) NOT NULL,
	  [TransactionID] VARCHAR(50) NOT NULL,
	  [Orders] INT NULL,
	  [ContractID] NVARCHAR(50) NULL,
	  [OriginalAmount] DECIMAL(28,8) NULL,
	  [ConvertedAmount] DECIMAL(28,8) NULL,
      [Notes] NVARCHAR(250) NULL     
    CONSTRAINT [PK_LMT2053] PRIMARY KEY CLUSTERED
      (
      [TransactionID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END


