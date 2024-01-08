-- <Summary>
---- 
-- <History>
---- Create by Tiểu Mai on 09/03/2016
---- Modified by ... on ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT0010]') AND type in (N'U'))
CREATE TABLE [dbo].[HT0010](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] nvarchar(50) NOT NULL,
	[TypeID] [nvarchar](50) NOT NULL,
	[SystemName] [nvarchar](250) NULL,
	[SystemNameE] NVARCHAR(50) NULL,
	[UserName] [nvarchar](250) NULL,	
	[UserNameE] [nvarchar](250) NULL,
	[IsUsed] [tinyint] DEFAULT (1) NOT NULL,
 CONSTRAINT [PK_HT0010] PRIMARY KEY CLUSTERED 
(	[DivisionID],
	[TypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

