-- <Summary>
---- 
-- <History>
---- Dữ liệu FormID, ModuleID cho màn hình duyệt chung
---- Create on 09/11/2018 by Như Hàn
---- Modified on ... by ...:
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WITH (NOLOCK) WHERE object_id = OBJECT_ID(N'[dbo].[ST0000]') AND type in (N'U'))
CREATE TABLE [dbo].[ST0000](
	[Type] [varchar] (50) NOT NULL,
	[FormID] [varchar] (50) NOT NULL,
	[ModuleID] [varchar] (50) NULL,
	[Disabled] TINYINT DEFAULT (0)

CONSTRAINT [PK_ST0000] PRIMARY KEY NONCLUSTERED 
(
	[FormID],
	[Type]
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


