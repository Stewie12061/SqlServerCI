﻿-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Minh Lâm
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OT3003]') AND type in (N'U'))
CREATE TABLE [dbo].[OT3003](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] nvarchar(3) NOT NULL,
	[POrderID] [nvarchar](50) NOT NULL,
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
 CONSTRAINT [PK_OT3003] PRIMARY KEY NONCLUSTERED 
(
	[POrderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

--- 05/11/2020 - Trọng Kiên: Bổ sung cột VoucherNo
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OT3003' AND col.name = 'VoucherNo')
BEGIN
	ALTER TABLE OT3003 ADD VoucherNo VARCHAR(50) NULL
END

--- 05/11/2020 - Trọng Kiên: Bổ sung cột VoucherDate
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OT3003' AND col.name = 'VoucherDate')
BEGIN
	ALTER TABLE OT3003 ADD VoucherDate DATETIME NULL
END

--- 05/11/2020 - Trọng Kiên: Bổ sung cột ObjectID
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OT3003' AND col.name = 'ObjectID')
BEGIN
	ALTER TABLE OT3003 ADD ObjectID VARCHAR(50) NULL
END
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OT3003' AND col.name = 'DivisionID')
BEGIN
	ALTER TABLE OT3003 DROP CONSTRAINT [PK_OT3003]
	ALTER TABLE OT3003 ADD CONSTRAINT [PK_OT3003] PRIMARY KEY ([POrderID])
	ALTER TABLE OT3003 ALTER COLUMN DivisionID VARCHAR(10) NULL
END