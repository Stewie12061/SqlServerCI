-- <Summary>
---- 
-- <History>
---- Create on 12/09/2013 by Bảo Anh
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CMT8888]') AND type in (N'U'))
CREATE TABLE [dbo].[CMT8888](
	[APK] [uniqueidentifier] NULL,
	[DivisionID] [nvarchar](50) NOT NULL,
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
 CONSTRAINT [PK_CMT8888] PRIMARY KEY CLUSTERED 
(
	[DivisionID] ASC,
	[ReportID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__CMT8888__APK__2C9FA266]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CMT8888] ADD  CONSTRAINT [DF__CMT8888__APK__2C9FA266]  DEFAULT (newid()) FOR [APK]
END
---- Add Columns
If Exists (Select * From sysobjects Where name = 'CMT8888' and xtype ='U') 
Begin
    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'CMT8888'  and col.name = 'IsDelete')
    Alter Table  CMT8888 ADD IsDelete TINYINT NOT NULL DEFAULT(0)
End 


Declare @DefaultName varchar(200), @DefaultText varchar(200), @AllowNull varchar(50), @SQL varchar(500)
If Exists (Select * From sysobjects Where name = 'CMT8888' and xtype ='U') 
Begin
          Select @AllowNull = Case When col.isnullable  = 1 Then 'NULL' Else 'NOT NULL' End 
          From syscolumns col inner join sysobjects tab 
          On col.id = tab.id where tab.name =   'CMT8888'  and col.name = 'DivisionID'
          If @AllowNull Is Not Null        Begin 
               Select @DefaultName = def.name, @DefaultText = cmm.text from sysobjects def inner join syscomments cmm 
                   on def.id = cmm.id inner join syscolumns col on col.cdefault = def.id 
                   inner join sysobjects tab on col.id = tab.id  
                   where tab.name = 'CMT8888'  and col.name = 'DivisionID'  
                   --drop constraint 
                   if @DefaultName Is Not Null Execute ('Alter Table CMT8888 Drop Constraint ' + @DefaultName)
                   --change column type
                   Set @SQL = 'Alter Table CMT8888  Alter Column DivisionID nvarchar(50)'  + @AllowNull 
                   Execute(@SQL) 
                   --restore constraint 
                   if @DefaultName Is Not Null 
                   Execute( 'Alter Table CMT8888  Add Constraint ' + @DefaultName   + ' Default (' + @DefaultText + ') For DivisionID')
        End
END