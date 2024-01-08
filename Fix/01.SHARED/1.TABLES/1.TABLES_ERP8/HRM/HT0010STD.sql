-- <Summary>
---- 
-- <History>
---- Create by Tiểu Mai on 09/03/2016
---- Modified by ... on ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT0010STD]') AND type in (N'U'))
CREATE TABLE [dbo].[HT0010STD](
	[TypeID] [nvarchar](50) NOT NULL,
	[SystemName] [nvarchar](250) NULL,
	[SystemNameE] [NVARCHAR](50) NULL,
	[UserName] [nvarchar](250) NULL,
	[UserNameE] [nvarchar](250) NULL,
	[IsUsed] [tinyint] NOT NULL
) ON [PRIMARY]
