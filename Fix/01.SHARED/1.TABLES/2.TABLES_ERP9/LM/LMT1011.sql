-- <Summary>
---- Danh mục hợp đồng hạn mức tín dụng, detail (Asoft-LM)
-- <History>
---- Create on 25/06/2017 by Bảo Anh
---- Modified on ... by 
-- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[LMT1011]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[LMT1011]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
	  [VoucherID] VARCHAR(50) NOT NULL,
	  [Orders] INT NULL,
	  [CreditFormID] VARCHAR(50) NOT NULL,
	  [OriginalLimitAmount] DECIMAL(28,8) NULL,
	  [ConvertedLimitAmount] DECIMAL(28,8) NULL,
      [Notes] NVARCHAR(250) NULL      
    CONSTRAINT [PK_LMT1011] PRIMARY KEY CLUSTERED
      (
      [VoucherID],
	  [CreditFormID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END