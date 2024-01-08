-- <Summary>
---- Danh mục số seri theo mặt hàng
-- <History>
---- Create on 02/05/2018 by Bảo Anh
---- Modified on ... by ...
---- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BT1302]') AND type in (N'U'))
CREATE TABLE [dbo].[BT1302](
    [APK] [uniqueidentifier] DEFAULT NEWID(),
    [DivisionID] [varchar] (50) NOT NULL,
	[SeriID] [varchar](50) NOT NULL,
	[SeriNo] [varchar](50) NOT NULL,
	[InventoryID] [varchar](50) NOT NULL,
	[Type] [tinyint] NOT NULL,
	[Disabled] [tinyint] NOT NULL DEFAULT(0),
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
CONSTRAINT [PK_BT1302] PRIMARY KEY CLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
