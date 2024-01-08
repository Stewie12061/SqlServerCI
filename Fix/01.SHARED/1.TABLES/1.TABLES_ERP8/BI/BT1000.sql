-- <Summary>
---- 
-- <History>
---- Create on 04/05/2018 by Bảo Anh
---- Modified on ... by ...
---- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BT1000]') AND type in (N'U'))
CREATE TABLE [dbo].[BT1000](
	[APK] [uniqueidentifier] NULL,
	[DivisionID] [varchar](50) NOT NULL,
	[VoucherID] [varchar](50) NOT NULL,
	[TransactionID] [varchar](50) NOT NULL,
	
 CONSTRAINT [PK_BT1000] PRIMARY KEY CLUSTERED 
(
	[DivisionID] ASC,
	[VoucherID] ASC,
	[TransactionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]