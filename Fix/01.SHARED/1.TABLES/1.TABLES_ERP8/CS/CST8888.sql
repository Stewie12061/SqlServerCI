
---- Create by tanphu on 3/3/2015 1:32:23 PM
----

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CST8888]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CST8888]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NULL,
  [DivisionID] NVARCHAR(3) NOT NULL,
  [ReportID] NVARCHAR(50) NOT NULL,
  [ReportName] NVARCHAR(250) NULL,
  [Title] NVARCHAR(250) NULL,
  [GroupID] NVARCHAR(50) NOT NULL,
  [Type] TINYINT NOT NULL,
  [Disabled] TINYINT NOT NULL,
  [SQLstring] NVARCHAR(4000) NULL,
  [Orderby] NVARCHAR(100) NULL,
  [Description] NVARCHAR(250) NULL,
  [DescriptionE] NVARCHAR(250) NULL,
  [TitleE] NVARCHAR(250) NULL,
  [ReportNameE] NVARCHAR(250) NULL
CONSTRAINT [PK_CST8888] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [ReportID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

Declare @DefaultName varchar(200), @DefaultText varchar(200), @AllowNull varchar(50), @SQL varchar(500)
If Exists (Select * From sysobjects Where name = 'CST8888' and xtype ='U') 
Begin
          Select @AllowNull = Case When col.isnullable  = 1 Then 'NULL' Else 'NOT NULL' End 
          From syscolumns col inner join sysobjects tab 
          On col.id = tab.id where tab.name =   'CST8888'  and col.name = 'DivisionID'
          If @AllowNull Is Not Null        Begin 
               Select @DefaultName = def.name, @DefaultText = cmm.text from sysobjects def inner join syscomments cmm 
                   on def.id = cmm.id inner join syscolumns col on col.cdefault = def.id 
                   inner join sysobjects tab on col.id = tab.id  
                   where tab.name = 'CST8888'  and col.name = 'DivisionID'  
                   --drop constraint 
                   if @DefaultName Is Not Null Execute ('Alter Table CST8888 Drop Constraint ' + @DefaultName)
                   --change column type
                   Set @SQL = 'Alter Table CST8888  Alter Column DivisionID nvarchar(50)'  + @AllowNull 
                   Execute(@SQL) 
                   --restore constraint 
                   if @DefaultName Is Not Null 
                   Execute( 'Alter Table CST8888  Add Constraint ' + @DefaultName   + ' Default (' + @DefaultText + ') For DivisionID')
        End
END