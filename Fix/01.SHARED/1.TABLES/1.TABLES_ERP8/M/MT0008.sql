-- <Summary>
---- 
-- <History>
---- Create on 04/09/2015 by Tiểu Mai
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MT0008]') AND type in (N'U'))
CREATE TABLE [dbo].[MT0008](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] nvarchar(50) NOT NULL,
	[TypeID] [nvarchar](50) NOT NULL,
	[SystemName] [nvarchar](250) NULL,
	SystemNameE NVARCHAR(50) NULL,
	[UserName] [nvarchar](250) NULL,
	[IsUsed] [tinyint] NOT NULL,
	[UserNameE] [nvarchar](250) NULL,
 CONSTRAINT [PK_MT0008] PRIMARY KEY CLUSTERED 
(
	[TypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_MT0008_IsUsed]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[MT0008] ADD  CONSTRAINT [DF_MT0008_IsUsed]  DEFAULT ((1)) FOR [IsUsed]
END


Declare @DefaultName varchar(200), @DefaultText varchar(200), @AllowNull varchar(50), @SQL varchar(500)
If Exists (Select * From sysobjects Where name = 'MT0008' and xtype ='U') 
Begin
          Select @AllowNull = Case When col.isnullable  = 1 Then 'NULL' Else 'NOT NULL' End 
          From syscolumns col inner join sysobjects tab 
          On col.id = tab.id where tab.name =   'MT0008'  and col.name = 'DivisionID'
          If @AllowNull Is Not Null        Begin 
               Select @DefaultName = def.name, @DefaultText = cmm.text from sysobjects def inner join syscomments cmm 
                   on def.id = cmm.id inner join syscolumns col on col.cdefault = def.id 
                   inner join sysobjects tab on col.id = tab.id  
                   where tab.name = 'MT0008'  and col.name = 'DivisionID'  
                   --drop constraint 
                   if @DefaultName Is Not Null Execute ('Alter Table MT0008 Drop Constraint ' + @DefaultName)
                   --change column type
                   Set @SQL = 'Alter Table MT0008  Alter Column DivisionID nvarchar(50)'  + @AllowNull 
                   Execute(@SQL) 
                   --restore constraint 
                   if @DefaultName Is Not Null 
                   Execute( 'Alter Table MT0008  Add Constraint ' + @DefaultName   + ' Default (' + @DefaultText + ') For DivisionID')
        End
END