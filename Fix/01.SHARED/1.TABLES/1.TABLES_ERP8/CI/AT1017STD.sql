-- <Summary>
---- 
-- <History>
---- Create on 13/12/2010 by Thanh Trẫm
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT1017STD]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AT1017STD](
	[VoucherGroupID] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[Disabled] [tinyint] NOT NULL,
	[IsUsed] [tinyint] NOT NULL
) ON [PRIMARY]
END
