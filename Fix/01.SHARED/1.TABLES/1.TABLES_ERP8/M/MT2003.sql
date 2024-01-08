-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Quốc Cường
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MT2003]') AND type in (N'U'))
CREATE TABLE [dbo].[MT2003](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[PlanID] [nvarchar](50) NOT NULL,
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
	[Date31] [datetime] NULL,
	[Date32] [datetime] NULL,
	[Date33] [datetime] NULL,
	[Date34] [datetime] NULL,
	[Date35] [datetime] NULL,
	[Date36] [datetime] NULL,
	[Date37] [datetime] NULL,
	[Date38] [datetime] NULL,
	[Date39] [datetime] NULL,
	[Date40] [datetime] NULL,
 CONSTRAINT [PK_MT2003] PRIMARY KEY NONCLUSTERED 
(
	[PlanID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


---- Modified by Hải Long on 07/08/2017: Bổ sung cột tổ nhóm - TeamID (BTLA)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='MT2003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID01')
		ALTER TABLE MT2003 ADD TeamID01 NVARCHAR(50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID02')
		ALTER TABLE MT2003 ADD TeamID02 NVARCHAR(50) NULL		
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID03')
		ALTER TABLE MT2003 ADD TeamID03 NVARCHAR(50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID04')
		ALTER TABLE MT2003 ADD TeamID04 NVARCHAR(50) NULL		
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID05')
		ALTER TABLE MT2003 ADD TeamID05 NVARCHAR(50) NULL	
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID06')
		ALTER TABLE MT2003 ADD TeamID06 NVARCHAR(50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID07')
		ALTER TABLE MT2003 ADD TeamID07 NVARCHAR(50) NULL		
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID08')
		ALTER TABLE MT2003 ADD TeamID08 NVARCHAR(50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID09')
		ALTER TABLE MT2003 ADD TeamID09 NVARCHAR(50) NULL		
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID10')
		ALTER TABLE MT2003 ADD TeamID10 NVARCHAR(50) NULL		
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID11')
		ALTER TABLE MT2003 ADD TeamID11 NVARCHAR(50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID12')
		ALTER TABLE MT2003 ADD TeamID12 NVARCHAR(50) NULL		
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID13')
		ALTER TABLE MT2003 ADD TeamID13 NVARCHAR(50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID14')
		ALTER TABLE MT2003 ADD TeamID14 NVARCHAR(50) NULL		
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID15')
		ALTER TABLE MT2003 ADD TeamID15 NVARCHAR(50) NULL	
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID16')
		ALTER TABLE MT2003 ADD TeamID16 NVARCHAR(50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID17')
		ALTER TABLE MT2003 ADD TeamID17 NVARCHAR(50) NULL		
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID18')
		ALTER TABLE MT2003 ADD TeamID18 NVARCHAR(50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID19')
		ALTER TABLE MT2003 ADD TeamID19 NVARCHAR(50) NULL		
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID20')
		ALTER TABLE MT2003 ADD TeamID20 NVARCHAR(50) NULL	
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID21')
		ALTER TABLE MT2003 ADD TeamID21 NVARCHAR(50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID22')
		ALTER TABLE MT2003 ADD TeamID22 NVARCHAR(50) NULL		
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID23')
		ALTER TABLE MT2003 ADD TeamID23 NVARCHAR(50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID24')
		ALTER TABLE MT2003 ADD TeamID24 NVARCHAR(50) NULL		
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID25')
		ALTER TABLE MT2003 ADD TeamID25 NVARCHAR(50) NULL	
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID26')
		ALTER TABLE MT2003 ADD TeamID26 NVARCHAR(50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID27')
		ALTER TABLE MT2003 ADD TeamID27 NVARCHAR(50) NULL		
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID28')
		ALTER TABLE MT2003 ADD TeamID28 NVARCHAR(50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID29')
		ALTER TABLE MT2003 ADD TeamID29 NVARCHAR(50) NULL		
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID30')
		ALTER TABLE MT2003 ADD TeamID30 NVARCHAR(50) NULL		
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID31')
		ALTER TABLE MT2003 ADD TeamID31 NVARCHAR(50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID32')
		ALTER TABLE MT2003 ADD TeamID32 NVARCHAR(50) NULL		
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID33')
		ALTER TABLE MT2003 ADD TeamID33 NVARCHAR(50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID34')
		ALTER TABLE MT2003 ADD TeamID34 NVARCHAR(50) NULL		
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID35')
		ALTER TABLE MT2003 ADD TeamID35 NVARCHAR(50) NULL	
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID36')
		ALTER TABLE MT2003 ADD TeamID36 NVARCHAR(50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID37')
		ALTER TABLE MT2003 ADD TeamID37 NVARCHAR(50) NULL		
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID38')
		ALTER TABLE MT2003 ADD TeamID38 NVARCHAR(50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID39')
		ALTER TABLE MT2003 ADD TeamID39 NVARCHAR(50) NULL		
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='MT2003' AND col.name='TeamID40')
		ALTER TABLE MT2003 ADD TeamID40 NVARCHAR(50) NULL													
	END
	

