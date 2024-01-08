-- <Summary>
----
-- <History>
---- Create on 21/09/2016 by Hải Long
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT1605]') AND type in (N'U'))
CREATE TABLE [dbo].[AT1605](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] nvarchar(3) NOT NULL,
	[ToolID] [nvarchar](50) NOT NULL,
	[AccountID] [nvarchar](50) NOT NULL,
	[DepPercent] [decimal](28, 8) NULL,
	[Ana01ID] [nvarchar](50) NULL,
	[Ana02ID] [nvarchar](50) NULL,
	[Ana03ID] [nvarchar](50) NULL,
	[Ana04ID] [nvarchar](50) NULL,
	[Ana05ID] [nvarchar](50) NULL,
	[Ana06ID] [nvarchar](50) NULL,
	[Ana07ID] [nvarchar](50) NULL,
	[Ana08ID] [nvarchar](50) NULL,
	[Ana09ID] [nvarchar](50) NULL,
	[Ana10ID] [nvarchar](50) NULL,
	[PeriodID] [nvarchar](50) NULL,
	CONSTRAINT [PK_AT1605] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

) ON [PRIMARY]

