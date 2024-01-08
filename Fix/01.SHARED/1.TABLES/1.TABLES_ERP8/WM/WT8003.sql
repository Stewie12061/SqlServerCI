-- <Summary>
---- Chứa dữ liệu check tồn kho xuất đích danh
-- <History>
---- Create on 23/10/2018 by Kim Thư
IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[WT8003]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[WT8003](
	[APK] [uniqueidentifier] NOT NULL DEFAULT (NEWID()),
	InventoryID VARCHAR(50) NOT NULL, 
	UnitID VARCHAR(5) NULL, 
	ConversionFactor DECIMAL(28,8) NULL, 
	ReOldVoucherID NVARCHAR(50) NULL, 
	ReOldTransactionID NVARCHAR(50) NULL, 
	ReNewVoucherID NVARCHAR(50) NULL, 
	ReNewTransactionID NVARCHAR(50) NULL,
	OldQuantity DECIMAL(28,8) NULL, 
	NewQuantity DECIMAL(28,8) NULL
	
	CONSTRAINT [PK_WT8003] PRIMARY KEY NONCLUSTERED 
	(
		[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
) ON [PRIMARY]
END
----------------------- Modified on 23/10/2018 by Kim Thư - Bổ sung UserID, DivisionID---------------------------
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='WT8003' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='WT8003' AND col.name='UserID')
	ALTER TABLE WT8003 ADD UserID VARCHAR(50) NOT NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='WT8003' AND col.name='DivisionID')
	ALTER TABLE WT8003 ADD DivisionID VARCHAR(50) NOT NULL
END
