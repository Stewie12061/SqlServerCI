﻿-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Mỹ Tuyền
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT1601]') AND type in (N'U'))
CREATE TABLE [dbo].[AT1601](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] nvarchar(3) NOT NULL,
	[ToolID] [nvarchar](50) NOT NULL,
	[TranMonth] [int] NOT NULL,
	[TranYear] [int] NOT NULL,
	[ApportionRate] [decimal](28, 8) NULL,
	[ApportionAmount] [decimal](28, 8) NULL,
 CONSTRAINT [PK_AT1601] PRIMARY KEY NONCLUSTERED 
(
	[ToolID] ASC,
	[TranMonth] ASC,
	[TranYear] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
