-- <Summary>
---- 
-- <History>
--- Detail Ngân sách
---- Create on 12/11/2018 by Như Hàn 
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TT2101]') AND type in (N'U'))
CREATE TABLE [dbo].[TT2101](
    [APK] [uniqueidentifier] DEFAULT NEWID(),
	[APKMaster] [uniqueidentifier] NOT NULL,
    [DivisionID] [varchar] (50) NOT NULL,
	[Orders] [INT],
	[Notes] [nvarchar](500) NULL,
	[OriginalAmount] [decimal](28, 8) NULL,
	[ConvertedAmount] [decimal](28, 8) NULL,
	[ApprovalOriginalAmount] [decimal](28, 8) NULL,
	[ApprovalConvertedAmount] [decimal](28, 8) NULL,
	[ApprovalAccountNotes] [nvarchar](500) NULL,
	[Ana01ID] [nvarchar](50) NULL,
	[Ana02ID] [nvarchar](50) NULL,
	[Ana03ID] [nvarchar](50) NULL,
	[Ana04ID] [nvarchar](50) NULL,
	[Ana05ID] [nvarchar](50) NULL,
	[Ana06ID] [nvarchar](50) NULL,
	[Ana07ID] [nvarchar](50) NULL,
	[Ana08ID] [nvarchar](50) NULL,
	[Ana09ID] [nvarchar](50) NULL,
	[Ana10ID] [nvarchar](50) NULL,
	[DeleteFlag] TINYINT DEFAULT (0) NOT NULL
CONSTRAINT [PK_TT2101] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'TT2101' AND xtype = 'U')
BEGIN 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'TT2101' AND col.name = 'APKMaster_9000') 
   ALTER TABLE TT2101 ADD APKMaster_9000 VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'TT2101' AND col.name = 'ApproveLevel') 
   ALTER TABLE TT2101 ADD ApproveLevel TINYINT NOT NULL DEFAULT(0)

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'TT2101' AND col.name = 'ApprovingLevel') 
   ALTER TABLE TT2101 ADD ApprovingLevel TINYINT NOT NULL DEFAULT(0)

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'TT2101' AND col.name = 'Status') 
   ALTER TABLE TT2101 ADD Status TINYINT NOT NULL DEFAULT(0)

   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'TT2101' AND col.name = 'ApprovalOriginalAmount')
   EXEC sp_rename 'TT2101.ApprovalOriginalAmount', 'ApprovalOAmount', 'COLUMN';

   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'TT2101' AND col.name = 'ApprovalConvertedAmount')
   EXEC sp_rename 'TT2101.ApprovalConvertedAmount', 'ApprovalCAmount', 'COLUMN';

END