-- <Summary>
---- Detail phương pháp phân bổ nhiều cấp (PACIFIC)
-- <History>
---- Create on 10/04/2017 by Hải Long
---- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT1611]') AND type in (N'U'))
CREATE TABLE [dbo].[AT1611](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[TransactionID] [nvarchar](50) NOT NULL,	
	[AllocationID] [nvarchar](50) NOT NULL,
	[AnaID] [nvarchar](50) NULL,	
	[AnaTypeID] [nvarchar](50) NULL,	
	[PercentRate] decimal(28) NULL,
	[EmployeeNumber] decimal(28) NULL,
	[Notes] [nvarchar](250) NULL,
	[Orders] [int] NULL
 CONSTRAINT [PK_AT1611] PRIMARY KEY NONCLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


