-- <Summary>
---- 
-- <History>
---- Create on 13/12/2010 by Thanh Trẫm
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT1410STD]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AT1410STD](
	[ModuleID] [nvarchar](50) NOT NULL,
	[ModuleName] [nvarchar](250) NULL,
	[ModuleNameE] [nvarchar](250) NULL,
	[GroupID] [nvarchar](50) NULL,
	[Status] [tinyint] NOT NULL
) ON [PRIMARY]
END