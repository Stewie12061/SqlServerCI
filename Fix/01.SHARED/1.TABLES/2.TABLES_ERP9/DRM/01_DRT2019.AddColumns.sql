--------------------------- AddColumns ------------------------------------------------

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='DRT2019' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='DRT2019' AND col.name='PaidPerMonth')
		ALTER TABLE DRT2019 ADD PaidPerMonth NVARCHAR(250) NULL
	END
	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='DRT2019' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='DRT2019' AND col.name='FirstUnPaidAmount')
		ALTER TABLE DRT2019 ADD FirstUnPaidAmount NVARCHAR(250) NULL
	END

---------------------------- AlterColumns--------------------------------------------
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='DRT2019' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='DRT2019' AND col.name='ContractBeginDate')
		ALTER TABLE DRT2019 ALTER COLUMN ContractBeginDate NVARCHAR(250) NULL 
	END
	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='DRT2019' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='DRT2019' AND col.name='ContractEndDate')
		ALTER TABLE DRT2019 ALTER COLUMN ContractEndDate NVARCHAR(250) NULL 
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='DRT2019' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='DRT2019' AND col.name='LoanBeginDate')
		ALTER TABLE DRT2019 ALTER COLUMN LoanBeginDate NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='DRT2019' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='DRT2019' AND col.name='LoanEndDate')
		ALTER TABLE DRT2019 ALTER COLUMN LoanEndDate NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='DRT2019' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='DRT2019' AND col.name='NearPaidDate')
		ALTER TABLE DRT2019 ALTER COLUMN NearPaidDate NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='DRT2019' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='DRT2019' AND col.name='FirstPaidPeriod')
		ALTER TABLE DRT2019 ALTER COLUMN FirstPaidPeriod NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='DRT2019' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='DRT2019' AND col.name='NextPaidPeriod')
		ALTER TABLE DRT2019 ALTER COLUMN NextPaidPeriod NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='DRT2019' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='DRT2019' AND col.name='AccountingDate')
		ALTER TABLE DRT2019 ALTER COLUMN AccountingDate NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='DRT2019' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='DRT2019' AND col.name='Birthday')
		ALTER TABLE DRT2019 ALTER COLUMN Birthday NVARCHAR(250) NULL 
	END
	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='DRT2019' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='DRT2019' AND col.name='IdentifyCardDate')
		ALTER TABLE DRT2019 ALTER COLUMN IdentifyCardDate NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='DRT2019' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='DRT2019' AND col.name='BikePrice')
		ALTER TABLE DRT2019 ALTER COLUMN BikePrice NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='DRT2019' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='DRT2019' AND col.name='PrePaid')
		ALTER TABLE DRT2019 ALTER COLUMN PrePaid NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='DRT2019' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='DRT2019' AND col.name='WorkHistory')
		ALTER TABLE DRT2019 ALTER COLUMN WorkHistory NVARCHAR(MAX) NULL 
	END
	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='DRT2019' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name = 'DRT2019' AND col.name='Note')
		ALTER TABLE DRT2019 ALTER COLUMN Note NVARCHAR(MAX) NULL 
	END
	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='DRT2019' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name = 'DRT2019' AND col.name='OtherNote')
		ALTER TABLE DRT2019 ALTER COLUMN OtherNote NVARCHAR(MAX) NULL 
	END
