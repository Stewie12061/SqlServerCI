-- <Summary>
---- 
-- <History>
---- Create on 01/07/2020 by Văn Tài
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT4444_Auto]') AND type in (N'U'))
CREATE TABLE [dbo].[AT4444_Auto](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] nvarchar(3) NOT NULL,
	[TABLENAME] [nvarchar](50) NULL,
	[KEYSTRING] [nvarchar](50) NULL,
	[LASTKEY] [int] NULL,
	CONSTRAINT [PK_AT4444_Auto] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

) ON [PRIMARY]


---- Add Columns
If Exists (Select * From sysobjects Where name = 'AT4444_Auto' and xtype ='U') 
Begin
           If exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT4444_Auto'  and col.name = 'DivisionID')
           Alter Table  AT4444_Auto Alter column DivisionID nvarchar(50) NOT NULL
End