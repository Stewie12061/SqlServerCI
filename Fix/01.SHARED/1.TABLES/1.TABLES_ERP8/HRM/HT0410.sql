
---- Create by Tiểu Mai on 2/23/2017 3:57:53 PM
---- Chấm công theo sản phẩm (Customize = 72 BourBon)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HT0410]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HT0410]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID(),
  [DivisionID] NVARCHAR(50) NOT NULL,
  [TrackingID] NVARCHAR(50) NOT NULL,
  [TrackingDate] DATETIME NULL,
  [TranMonth] INT NULL,
  [TranYear] INT NULL,
  [Description] NVARCHAR(250) NULL,
  [EmployeeID] NVARCHAR(50) NULL,
  [TotalAmount] DECIMAL(28,8) NULL,
  [CreateDate]	DATETIME NULL,
  [CreateUserID]	NVARCHAR(50) NULL,
  [LastModifyUserID]	NVARCHAR(50) NULL,
  [LastModifyDate]	DATETIME NULL,
  [InheritPTransactionID] NVARCHAR(50) NULL
CONSTRAINT [PK_HT0410] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [TrackingID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END
--- Modified by Tiểu Mai on 08/03/2017: Bổ sung cho Bourbon
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='HT0410' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HT0410' AND col.name='VoucherTypeID')
		ALTER TABLE HT0410 ADD VoucherTypeID NVARCHAR(50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HT0410' AND col.name='SOrderID')
		ALTER TABLE HT0410 ADD SOrderID NVARCHAR(50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HT0410' AND col.name='SOrderDate')
		ALTER TABLE HT0410 ADD SOrderDate DATETIME NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HT0410' AND col.name='ShipDate')
		ALTER TABLE HT0410 ADD ShipDate DATETIME NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HT0410' AND col.name='ReceiveDate')
		ALTER TABLE HT0410 ADD ReceiveDate DATETIME NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HT0410' AND col.name='ObjectID')
		ALTER TABLE HT0410 ADD ObjectID NVARCHAR(50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HT0410' AND col.name='InventoryID')
		ALTER TABLE HT0410 ADD InventoryID NVARCHAR(50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HT0410' AND col.name='OrderQuantity')
		ALTER TABLE HT0410 ADD OrderQuantity DECIMAL(28,8) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HT0410' AND col.name='Ana04ID')
		ALTER TABLE HT0410 ADD Ana04ID NVARCHAR(50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HT0410' AND col.name='Ana07ID')
		ALTER TABLE HT0410 ADD Ana07ID NVARCHAR(50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HT0410' AND col.name='PurchasePrice')
		ALTER TABLE HT0410 ADD PurchasePrice DECIMAL(28,8) NULL
	END