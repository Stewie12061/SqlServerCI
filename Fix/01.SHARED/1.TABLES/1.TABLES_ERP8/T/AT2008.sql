-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Mỹ Tuyền
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT2008]') AND type in (N'U'))
CREATE TABLE [dbo].[AT2008](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[WareHouseID] [nvarchar](50) NOT NULL,
	[TranMonth] [int] NOT NULL,
	[TranYear] [int] NOT NULL,
	[InventoryID] [nvarchar](50) NOT NULL,
	[InventoryAccountID] [nvarchar](50) NOT NULL,
	[BeginQuantity] [decimal](28, 8) NULL,
	[EndQuantity] [decimal](28, 8) NULL,
	[DebitQuantity] [decimal](28, 8) NULL,
	[CreditQuantity] [decimal](28, 8) NULL,
	[InDebitQuantity] [decimal](28, 8) NULL,
	[InCreditQuantity] [decimal](28, 8) NULL,
	[BeginAmount] [decimal](28, 8) NULL,
	[EndAmount] [decimal](28, 8) NULL,
	[DebitAmount] [decimal](28, 8) NULL,
	[CreditAmount] [decimal](28, 8) NULL,
	[InDebitAmount] [decimal](28, 8) NULL,
	[InCreditAmount] [decimal](28, 8) NULL,
	[UnitPrice] [decimal](28, 8) NULL,
 CONSTRAINT [PK_AT2008] PRIMARY KEY NONCLUSTERED 
(
	[WareHouseID] ASC,
	[TranMonth] ASC,
	[TranYear] ASC,
	[DivisionID] ASC,
	[InventoryID] ASC,
	[InventoryAccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

----- Modified by Tiểu Mai on 28/06/2017: Bổ sung cột lưu lại quy trình chuyển kho sau khi tính giá xuất kho (TransProcessesID ứng với AT1332.VoucherID)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2008' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2008' AND col.name = 'TransProcessesID')
        ALTER TABLE AT2008 ADD TransProcessesID NVARCHAR(50) NULL
    END 

----- Modified by Hoài Bảo on 19/07/2022: Bổ sung cột CreateUserID, CreateDate, LastModifyUserID, LastModifyDate
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2008' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2008' AND col.name = 'CreateUserID')
        ALTER TABLE AT2008 ADD CreateUserID VARCHAR(50) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2008' AND col.name = 'CreateDate')
        ALTER TABLE AT2008 ADD CreateDate DATETIME NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2008' AND col.name = 'LastModifyUserID')
        ALTER TABLE AT2008 ADD LastModifyUserID VARCHAR(50) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT2008' AND col.name = 'LastModifyDate')
        ALTER TABLE AT2008 ADD LastModifyDate DATETIME NULL
    END

----- Modified by Đức Tuyên
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT2008' AND xtype = 'U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'AT2008' AND col.name = 'S01ID')
		ALTER TABLE AT2008 ADD S01ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'AT2008' AND col.name = 'S02ID')
		ALTER TABLE AT2008 ADD S02ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'AT2008' AND col.name = 'S03ID')
		ALTER TABLE AT2008 ADD S03ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'AT2008' AND col.name = 'S04ID')
		ALTER TABLE AT2008 ADD S04ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'AT2008' AND col.name = 'S05ID')
		ALTER TABLE AT2008 ADD S05ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'AT2008' AND col.name = 'S06ID')
		ALTER TABLE AT2008 ADD S06ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'AT2008' AND col.name = 'S07ID')
		ALTER TABLE AT2008 ADD S07ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'AT2008' AND col.name = 'S08ID')
		ALTER TABLE AT2008 ADD S08ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'AT2008' AND col.name = 'S09ID')
		ALTER TABLE AT2008 ADD S09ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'AT2008' AND col.name = 'S10ID')
		ALTER TABLE AT2008 ADD S10ID VARCHAR(50) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'AT2008' AND col.name = 'S11ID')
		ALTER TABLE AT2008 ADD S11ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'AT2008' AND col.name = 'S12ID')
		ALTER TABLE AT2008 ADD S12ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'AT2008' AND col.name = 'S13ID')
		ALTER TABLE AT2008 ADD S13ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'AT2008' AND col.name = 'S14ID')
		ALTER TABLE AT2008 ADD S14ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'AT2008' AND col.name = 'S15ID')
		ALTER TABLE AT2008 ADD S15ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'AT2008' AND col.name = 'S16ID')
		ALTER TABLE AT2008 ADD S16ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'AT2008' AND col.name = 'S17ID')
		ALTER TABLE AT2008 ADD S17ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'AT2008' AND col.name = 'S18ID')
		ALTER TABLE AT2008 ADD S18ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'AT2008' AND col.name = 'S19ID')
		ALTER TABLE AT2008 ADD S19ID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'AT2008' AND col.name = 'S20ID')
		ALTER TABLE AT2008 ADD S20ID VARCHAR(50) NULL
END