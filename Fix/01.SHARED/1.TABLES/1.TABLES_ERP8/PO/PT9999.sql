-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Hoang Phuoc
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PT9999]') AND type in (N'U'))
CREATE TABLE [dbo].[PT9999](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[TranMonth] [int] NOT NULL,
	[TranYear] [int] NOT NULL,
	[Closing] [tinyint] NOT NULL,
	[BeginDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
 CONSTRAINT [PK_PT9999] PRIMARY KEY CLUSTERED 
(
	[DivisionID] ASC,
	[TranMonth] ASC,
	[TranYear] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
