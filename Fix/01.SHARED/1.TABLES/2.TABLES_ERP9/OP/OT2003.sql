-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Cam Loan
---- Modified by Hải Long on 05/09/2016: Bổ sung các trường cho ANPHAT
---- Modified by Hoàng Lâm on 21/09/2023: Bổ sung 2 cột VoucherNo và VoucherDate bị mất
---- Modify by Minh Dũng on 05/10/2023: Add Column Address from 01 to 30.
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

---- Modified by Trọng Kiên on 13/01/2021: Bổ sung trường ShipStartDate cho CLOUD
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='ShipStartDate')
		ALTER TABLE OT2003 ADD ShipStartDate DATETIME NULL
	END

--- Modify by Minh Dũng on 05/10/2023: Thêm 30 cột địa chỉ.
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='Address01')
		ALTER TABLE OT2003 ADD Address01 NVARCHAR(MAX) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='Address02')
		ALTER TABLE OT2003 ADD Address02 NVARCHAR(MAX) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='Address03')
		ALTER TABLE OT2003 ADD Address03 NVARCHAR(MAX) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='Address04')
		ALTER TABLE OT2003 ADD Address04 NVARCHAR(MAX) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='Address05')
		ALTER TABLE OT2003 ADD Address05 NVARCHAR(MAX) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='Address06')
		ALTER TABLE OT2003 ADD Address06 NVARCHAR(MAX) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='Address07')
		ALTER TABLE OT2003 ADD Address07 NVARCHAR(MAX) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='Address08')
		ALTER TABLE OT2003 ADD Address08 NVARCHAR(MAX) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='Address09')
		ALTER TABLE OT2003 ADD Address09 NVARCHAR(MAX) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='Address10')
		ALTER TABLE OT2003 ADD Address10 NVARCHAR(MAX) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='Address11')
		ALTER TABLE OT2003 ADD Address11 NVARCHAR(MAX) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='Address12')
		ALTER TABLE OT2003 ADD Address12 NVARCHAR(MAX) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='Address13')
		ALTER TABLE OT2003 ADD Address13 NVARCHAR(MAX) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='Address14')
		ALTER TABLE OT2003 ADD Address14 NVARCHAR(MAX) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='Address15')
		ALTER TABLE OT2003 ADD Address15 NVARCHAR(MAX) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='Address16')
		ALTER TABLE OT2003 ADD Address16 NVARCHAR(MAX) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='Address17')
		ALTER TABLE OT2003 ADD Address17 NVARCHAR(MAX) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='Address18')
		ALTER TABLE OT2003 ADD Address18 NVARCHAR(MAX) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='Address19')
		ALTER TABLE OT2003 ADD Address19 NVARCHAR(MAX) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='Address20')
		ALTER TABLE OT2003 ADD Address20 NVARCHAR(MAX) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='Address21')
		ALTER TABLE OT2003 ADD Address21 NVARCHAR(MAX) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='Address22')
		ALTER TABLE OT2003 ADD Address22 NVARCHAR(MAX) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='Address23')
		ALTER TABLE OT2003 ADD Address23 NVARCHAR(MAX) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='Address24')
		ALTER TABLE OT2003 ADD Address24 NVARCHAR(MAX) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='Address25')
		ALTER TABLE OT2003 ADD Address25 NVARCHAR(MAX) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='Address26')
		ALTER TABLE OT2003 ADD Address26 NVARCHAR(MAX) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='Address27')
		ALTER TABLE OT2003 ADD Address27 NVARCHAR(MAX) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='Address28')
		ALTER TABLE OT2003 ADD Address28 NVARCHAR(MAX) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='Address29')
		ALTER TABLE OT2003 ADD Address29 NVARCHAR(MAX) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='Address30')
		ALTER TABLE OT2003 ADD Address30 NVARCHAR(MAX) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='VoucherNo')
		ALTER TABLE OT2003 ADD VoucherNo varchar(50) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='VoucherDate')
		ALTER TABLE OT2003 ADD VoucherDate DATETIME NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2003' AND col.name='WarrantyID')
		ALTER TABLE OT2003 ADD WarrantyID NVARCHAR(50) NULL
	END

	
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OT2003' AND col.name = 'WarrantyID')
BEGIN
	ALTER TABLE OT2003 ALTER COLUMN WarrantyID NVARCHAR(50) NOT NULL
END

ALTER TABLE OT2003 DROP CONSTRAINT [PK_OT2003];
ALTER TABLE OT2003 ADD constraint [PK_OT2003] Primary key(
	[SOrderID],
	[WarrantyID]) 
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]