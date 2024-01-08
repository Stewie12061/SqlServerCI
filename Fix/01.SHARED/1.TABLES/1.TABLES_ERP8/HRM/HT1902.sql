-- <Summary>
---- 
-- <History>
---- Create on 11/10/2010 by Thanh Trẫm
---- Modified on 27/02/2018 by Khả Vi CustomerIndex = 88 (VIETFIRST): Add columns FromDate, ToDate 
---- Modified on 16/03/2021 by Lê Hoàng CustomerIndex = 117 (MAITHU): Add columns PhaseID, MethodID 
---- <Example>
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT1902]') AND type in (N'U'))
CREATE TABLE [dbo].[HT1902](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] nvarchar(3) NOT NULL,
	[PriceSheetID] [nvarchar](50) NOT NULL,
	[PriceSheetName] [nvarchar](250) NOT NULL,
	[Notes] [nvarchar](250) NULL,
	[Disabled] [tinyint] NOT NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
 CONSTRAINT [PK_HT19023] PRIMARY KEY NONCLUSTERED 
(
	[PriceSheetID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default 
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HT1902_Disabled]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT1902] ADD  CONSTRAINT [DF_HT1902_Disabled]  DEFAULT ((0)) FOR [Disabled]
END
---- CustomerIndex = 88 (VIETFIRST): Add columns FromDate, ToDate
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1902' AND xtype = 'U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'HT1902' AND col.name = 'FromDate')
    ALTER TABLE HT1902 ADD FromDate DATETIME NULL
	    
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'HT1902' AND col.name = 'ToDate')
    ALTER TABLE HT1902 ADD ToDate DATETIME NULL
END

---- CustomerIndex = 117 (MAITHU): Add columns PhaseID, MethodID 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1902' AND xtype = 'U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'HT1902' AND col.name = 'PhaseID')
    ALTER TABLE HT1902 ADD PhaseID NVARCHAR(50) NULL
	    
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'HT1902' AND col.name = 'MethodID')
    ALTER TABLE HT1902 ADD MethodID INT NULL
END