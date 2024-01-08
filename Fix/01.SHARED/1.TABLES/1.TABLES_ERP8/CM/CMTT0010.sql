-- <Summary>
---- 
-- <History>
---- Create on 26/12/2014 by Lưu Khánh Vân
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CMTT0010]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[CMTT0010]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
      [VoucherID] VARCHAR(50) NOT NULL,
      [VoucherDate] DATETIME NULL,
      [InventoryID] VARCHAR(50) NOT NULL,
      [StatusID] TINYINT DEFAULT (0) NULL
    CONSTRAINT [PK_CMTT0010] PRIMARY KEY CLUSTERED
      (
		  [APK]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

---- Add Columns
If Exists (Select * From sysobjects Where name = 'CMTT0010' and xtype ='U') 
Begin 

	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name = 'CMTT0010'  and col.name = 'SaleEmployeeID')
		ALTER TABLE  CMTT0010 ADD SaleEmployeeID VARCHAR(50) NULL

	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name = 'CMTT0010'  and col.name = 'VObjectID')
		ALTER TABLE  CMTT0010 ADD VObjectID VARCHAR(50) NULL

End