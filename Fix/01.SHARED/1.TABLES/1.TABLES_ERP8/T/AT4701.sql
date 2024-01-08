-- <Summary>
---- 
-- <History>
---- Create on 11/10/2010 by Thanh Trẫm
---- Modified on 30/06/2011 by Huỳnh Tấn Phú
---- Modified on 14/08/2020 by Huỳnh Thử -- Merge Code: MEKIO và MTE
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT4701]') AND type in (N'U'))
CREATE TABLE [dbo].[AT4701](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] nvarchar(3) NOT NULL,
	[ReportCode] [nvarchar](50) NOT NULL,
	[ColumnID] [nvarchar](50) NOT NULL,
	[ColumnType] [nvarchar](100) NULL,
	[IsOriginal] [tinyint] NOT NULL,
	[ColumnBudget] [nvarchar](50) NULL,
	[FromAccountID] [nvarchar](50) NULL,
	[ToAccountID] [nvarchar](50) NULL,
	[FromCoAccountID] [nvarchar](50) NULL,
	[ToCorAccountID] [nvarchar](50) NULL,
	[IsUsed] [tinyint] NOT NULL,
	[ColumnCaption] [nvarchar](250) NULL,
	[ColumnID1] [nvarchar](50) NULL,
	[ColumnID2] [nvarchar](50) NULL,
	[ColumnID3] [nvarchar](50) NULL,
	[ColumnID4] [nvarchar](50) NULL,
	[Sign1] [nvarchar](5) NULL,
	[Sign2] [nvarchar](5) NULL,
	[Sign3] [nvarchar](5) NULL,
	[Sign4] [nvarchar](5) NULL,
 CONSTRAINT [PK_AT4701] PRIMARY KEY NONCLUSTERED 
(
	[ReportCode] ASC,
	[ColumnID] ASC,
	[DivisionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add Columns
if(isnull(COL_LENGTH('AT4701','PeriodType'),0)<=0)
ALTER TABLE AT4701 ADD PeriodType nvarchar(50) NULL
if(isnull(COL_LENGTH('AT4701STD','PeriodType'),0)<=0)
ALTER TABLE AT4701STD ADD PeriodType nvarchar(50) NULL


DECLARE @CustomerIndex INT 
SELECT @CustomerIndex = CustomerName FROM dbo.CustomerIndex 
----- Modify by Huỳnh Thử on 14/08/2020: Merge Code: MEKIO và MTE
IF(@CustomerIndex= 50 OR @CustomerIndex= 115)
	If Exists (Select * From sysobjects Where name = 'AT4701' and xtype ='U') 
	Begin
		   If not exists (select * from syscolumns col inner join sysobjects tab 
			   On col.id = tab.id where tab.name =   'AT4701'  and col.name = '[FromAccountID]')
				 Alter Table AT4701  Alter Column [FromAccountID] nvarchar(4000)
	end


	If Exists (Select * From sysobjects Where name = 'AT4701' and xtype ='U') 
	Begin
		   If not exists (select * from syscolumns col inner join sysobjects tab 
			   On col.id = tab.id where tab.name =   'AT4701'  and col.name = '[ToAccountID]')
				 Alter Table AT4701  Alter Column [ToAccountID] nvarchar(4000)
	end