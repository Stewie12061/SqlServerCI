﻿-- <Summary>
---- 
-- <History>
---- Create on 28/12/2010 by Phát Danh
---- Modified on 19/07/2012 by T.Khánh: add a new column IsDelete to AT8888
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT8888]') AND type in (N'U'))
CREATE TABLE [dbo].[AT8888](
    [APK] [uniqueidentifier] DEFAULT NEWID(),
    [DivisionID] [nvarchar] (3) NOT NULL,
	[ReportID] [nvarchar](50) NOT NULL,
	[ReportName] [nvarchar](250) NULL,
	[Title] [nvarchar](250) NULL,
	[GroupID] [nvarchar](50) NOT NULL,
	[Type] [tinyint] NOT NULL,
	[Disabled] [tinyint] NOT NULL,
	[SQLstring] [nvarchar](4000) NULL,
	[Orderby] [nvarchar](100) NULL,
	[Description] [nvarchar](250) NULL,
	[DescriptionE] [nvarchar](250) NULL,
	[TitleE] [nvarchar](250) NULL,
	[ReportNameE] [nvarchar](250) NULL,
CONSTRAINT [PK_AT8888] PRIMARY KEY CLUSTERED 
(
	[ReportID] ASC,
	[DivisionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add Columns
If Exists (Select * From sysobjects Where name = 'AT8888' and xtype ='U') 
Begin
    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT8888'  and col.name = 'IsDelete')
    Alter Table  AT8888 Add IsDelete tinyint Not Null Default(0)
End 

---- Modified by Bảo Thy on 25/04/2017: Alter column Type TINYINT -> INT
IF EXISTS (SELECT * FROM Sysobjects WHERE Name = 'AT8888' and xtype ='U') 
BEGIN
    IF EXISTS (SELECT * FROM Syscolumns Col INNER JOIN Sysobjects Tab ON Col.ID = tab.ID where Tab.Name = 'AT8888' AND Col.Name = 'Type')
    ALTER TABLE  AT8888 ALTER COLUMN [Type] INT NULL
END 
