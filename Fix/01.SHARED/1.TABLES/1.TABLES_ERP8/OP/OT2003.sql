-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Cam Loan
---- Modified by Hải Long on 05/09/2016: Bổ sung các trường cho ANPHAT
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OT2003]') AND type in (N'U'))
CREATE TABLE [dbo].[OT2003](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[SOrderID] [nvarchar](50) NOT NULL,
	[Date01] [datetime] NULL,
	[Date02] [datetime] NULL,
	[Date03] [datetime] NULL,
	[Date04] [datetime] NULL,
	[Date05] [datetime] NULL,
	[Date06] [datetime] NULL,
	[Date07] [datetime] NULL,
	[Date08] [datetime] NULL,
	[Date09] [datetime] NULL,
	[Date10] [datetime] NULL,
	[Date11] [datetime] NULL,
	[Date12] [datetime] NULL,
	[Date13] [datetime] NULL,
	[Date14] [datetime] NULL,
	[Date15] [datetime] NULL,
	[Date16] [datetime] NULL,
	[Date17] [datetime] NULL,
	[Date18] [datetime] NULL,
	[Date19] [datetime] NULL,
	[Date20] [datetime] NULL,
	[Date21] [datetime] NULL,
	[Date22] [datetime] NULL,
	[Date23] [datetime] NULL,
	[Date24] [datetime] NULL,
	[Date25] [datetime] NULL,
	[Date26] [datetime] NULL,
	[Date27] [datetime] NULL,
	[Date28] [datetime] NULL,
	[Date29] [datetime] NULL,
	[Date30] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
 CONSTRAINT [PK_OT2003] PRIMARY KEY NONCLUSTERED 
(
	[SOrderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

---- Modified by Hải Long on 05/09/2016: Bổ sung các trường cho ANPHAT
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='Description')
		ALTER TABLE OT2003 ADD Description NVARCHAR(200) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='ObjectID')
		ALTER TABLE OT2003 ADD ObjectID NVARCHAR(50) NULL
	END

	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OT2003' AND col.name = 'DivisionID')
BEGIN
	ALTER TABLE OT2003 DROP CONSTRAINT [PK_OT2003]
	ALTER TABLE OT2003 ADD CONSTRAINT [PK_OT2003] PRIMARY KEY ([SOrderID])
	ALTER TABLE OT2003 ALTER COLUMN DivisionID VARCHAR(10) NULL
END