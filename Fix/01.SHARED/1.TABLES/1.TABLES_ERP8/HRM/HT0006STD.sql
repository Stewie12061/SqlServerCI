-- <Summary>
---- 
-- <History>
---- Create on 11/10/2010 by Thanh Trẫm
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT0006STD]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[HT0006STD](
	[DefineID] [nvarchar](50) NOT NULL,
	[DefineCaption] [nvarchar](250) NULL,
	[DefineCaptionE] [nvarchar](250) NULL,
	[ParentID] [nvarchar](50) NULL,
	[IsUsed] [tinyint] NOT NULL
) ON [PRIMARY]
END