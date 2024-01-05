-- <Summary>
---- 
-- <History>
---- Create on 22/12/2010 by Vĩnh Phong
---- Modified on 20/11/2020 by Văn Tài: Alter column FormID: 150 cho các plugins tên dài.
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[A00002]') AND type in (N'U'))
CREATE TABLE [dbo].[A00002](
	[ID] [varchar](100) NOT NULL,
	[LanguageID] [varchar](10) NOT NULL,
	[Name] [nvarchar](2000) NULL,
	[InsertDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[Module] [varchar](2) NOT NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_A00002] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[LanguageID] ASC,
	[Module] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__A00002__Deleted__194E6D7E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[A00002] ADD CONSTRAINT [DF__A00002__Deleted__194E6D7E] DEFAULT ((0)) FOR [Deleted]
END
---- Alter Primary Key
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[A00002]') AND name = N'PK_A00002')
ALTER TABLE [dbo].[A00002] DROP CONSTRAINT [PK_A00002]
ALTER TABLE [A00002] ALTER COLUMN  [Module] [nvarchar](5) NOT NULL
ALTER TABLE [dbo].[A00002] ADD  CONSTRAINT [PK_A00002] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[LanguageID] ASC,
	[Module] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
IF(ISNULL(COL_LENGTH('A00002', 'CustomName'), 0) <= 0)
---- Add Columns
ALTER TABLE A00002 ADD CustomName NVARCHAR(100)
If Exists (Select * From sysobjects Where name = 'A00002' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'A00002'  and col.name = 'FormID')
		   BEGIN
				ALTER TABLE A00002 ADD FormID NVARCHAR(150) NULL
		   END
		   ELSE
		   BEGIN
				ALTER TABLE A00002 ALTER COLUMN FormID NVARCHAR(150) NULL
		   END
END
---- Add cột phân biệt Platform: Platform = 0: ERP8, = 1: ERP9, =2: Mobile
 IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
     ON col.id = tab.id WHERE tab.name = 'A00002' AND col.name = 'Platform')
	ALTER TABLE A00002 ADD [Platform] INT NULL