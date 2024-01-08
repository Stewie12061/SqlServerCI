-- <Summary>
---- Giải chấp tài sản - Master (Asoft-LM)
-- <History>
---- Create on 25/10/2017 by Hải Long
---- Modified on ... by 
-- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[LMT2060]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[LMT2060]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] NVARCHAR(50) NOT NULL,
	  [VoucherID] NVARCHAR(50) NOT NULL,	  
	  [TranMonth] INT NOT NULL,
	  [TranYear] INT NOT NULL,
	  [LoanVoucherID] NVARCHAR(50) NOT NULL,
	  [UnwindDate] DATETIME NOT NULL,
      [Description] NVARCHAR(250) NULL,
	  [RelatedToTypeID] INT,
      [CreateUserID] VARCHAR(50) NULL,
      [CreateDate] DATETIME NULL,
      [LastModifyUserID] VARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL
    CONSTRAINT [PK_LMT2060] PRIMARY KEY CLUSTERED
      (
		[DivisionID],
		[VoucherID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

