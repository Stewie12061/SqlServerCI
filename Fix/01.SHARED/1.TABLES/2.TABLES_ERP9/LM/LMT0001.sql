-- <Summary>
---- Thiết lập hệ thống (Asoft-LM)
-- <History>
---- Create on 30/08/2017 by Bảo Anh
---- Modified on ... by 
-- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[LMT0001]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[LMT0001]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
      [IsWarnPayment] BIT NULL,
      [BeforeDays] INT NULL
    CONSTRAINT [PK_LMT0001] PRIMARY KEY CLUSTERED
      (
		[APK]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END