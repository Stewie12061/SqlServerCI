-- <Summary>
---- 
-- <History>
---- Create on 26/12/2014 by Lưu Khánh Vân
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CMT9999]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CMT9999](
	[APK] [uniqueidentifier] DEFAULT (newid()) NOT NULL,
	[DivisionID] [nvarchar](50) NOT NULL,
	[TranMonth] [int] NOT NULL,
	[TranYear] [int] NOT NULL,
	[Closing] [tinyint] NOT NULL,
	[BeginDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[Disabled] [tinyint] NOT NULL,
 CONSTRAINT [PK_CMT9999] PRIMARY KEY NONCLUSTERED 
(
	[DivisionID] ASC,
	[TranMonth] ASC,
	[TranYear] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[CMT9999] ADD  CONSTRAINT [DF_CMT9999_Closing]  DEFAULT ((0)) FOR [Closing]

ALTER TABLE [dbo].[CMT9999] ADD  CONSTRAINT [DF_CMT9999_Disabled]  DEFAULT ((0)) FOR [Disabled]


END

Declare @DefaultName varchar(200), @DefaultText varchar(200), @AllowNull varchar(50), @SQL varchar(500)
If Exists (Select * From sysobjects Where name = 'CMT9999' and xtype ='U') 
Begin
          Select @AllowNull = Case When col.isnullable  = 1 Then 'NULL' Else 'NOT NULL' End 
          From syscolumns col inner join sysobjects tab 
          On col.id = tab.id where tab.name =   'CMT9999'  and col.name = 'DivisionID'
          If @AllowNull Is Not Null        Begin 
               Select @DefaultName = def.name, @DefaultText = cmm.text from sysobjects def inner join syscomments cmm 
                   on def.id = cmm.id inner join syscolumns col on col.cdefault = def.id 
                   inner join sysobjects tab on col.id = tab.id  
                   where tab.name = 'CMT9999'  and col.name = 'DivisionID'  
                   --drop constraint 
                   if @DefaultName Is Not Null Execute ('Alter Table CMT9999 Drop Constraint ' + @DefaultName)
                   --change column type
                   Set @SQL = 'Alter Table CMT9999  Alter Column DivisionID nvarchar(50)'  + @AllowNull 
                   Execute(@SQL) 
                   --restore constraint 
                   if @DefaultName Is Not Null 
                   Execute( 'Alter Table CMT9999  Add Constraint ' + @DefaultName   + ' Default (' + @DefaultText + ') For DivisionID')
        End
END