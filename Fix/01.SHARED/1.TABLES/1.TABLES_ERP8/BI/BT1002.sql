-- <Summary>
---- 
-- <History>
---- Create on 11/10/2010 by Thanh Trẫm
---- Modified on 08/05/2018 by Bảo Anh: Bổ sung thêm các cột như của Việt Linh
---- Modified on 23/11/2023 by Trọng Phúc: Bổ sung thêm các cột quy cách
---- Modified on 08/12/2023 by Thành Sang: Bổ sung thêm InheritVoucherID, SourceNo, DriverID, CarID, ProductionOrder
---- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BT1002]') AND type in (N'U'))
CREATE TABLE [dbo].[BT1002](
    [APK] [uniqueidentifier] DEFAULT NEWID(),
    [DivisionID] [nvarchar] (3) NOT NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[TransactionID] [nvarchar](50) NOT NULL,
	[VoucherNo] [nvarchar](50) NULL,
	[VoucherDate] [datetime] NULL,
	[Description] [nvarchar](250) NULL,	
	[SeriNo] [nvarchar](50) NULL,
	[InventoryID] [nvarchar](50) NULL,
	[Quantity] [decimal](28,8) NULL,
	[Notes] [nvarchar](250) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
CONSTRAINT [PK_BT1002] PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

--- Add column
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'BT1002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'BT1002' AND col.name = 'VoucherID') 
   ALTER TABLE BT1002 ADD VoucherID VARCHAR(50) NOT NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'BT1002' AND col.name = 'VoucherTypeID') 
   ALTER TABLE BT1002 ADD VoucherTypeID VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'BT1002' AND col.name = 'ObjectID') 
   ALTER TABLE BT1002 ADD ObjectID VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'BT1002' AND col.name = 'RDAddress') 
   ALTER TABLE BT1002 ADD RDAddress NVARCHAR(250) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'BT1002' AND col.name = 'WareHouseID') 
   ALTER TABLE BT1002 ADD WareHouseID VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'BT1002' AND col.name = 'WareHouseID2') 
   ALTER TABLE BT1002 ADD WareHouseID2 VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'BT1002' AND col.name = 'KindVoucherID') 
   ALTER TABLE BT1002 ADD KindVoucherID int NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'BT1002' AND col.name = 'ReVoucherID') 
   ALTER TABLE BT1002 ADD ReVoucherID VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'BT1002' AND col.name = 'Orders') 
   ALTER TABLE BT1002 ADD Orders int NULL
   
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id = tab.id WHERE tab.name = 'BT1002' AND col.name = 'S01ID')
	ALTER TABLE BT1002 ADD S01ID NVARCHAR(50) NULL 
	
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id = tab.id WHERE tab.name = 'BT1002' AND col.name = 'S02ID')
	ALTER TABLE BT1002 ADD S02ID NVARCHAR(50) NULL 

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id = tab.id WHERE tab.name = 'BT1002' AND col.name = 'S03ID')
	ALTER TABLE BT1002 ADD S03ID NVARCHAR(50) NULL 

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id = tab.id WHERE tab.name = 'BT1002' AND col.name = 'S04ID')
	ALTER TABLE BT1002 ADD S04ID NVARCHAR(50) NULL 

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id = tab.id WHERE tab.name = 'BT1002' AND col.name = 'S05ID')
	ALTER TABLE BT1002 ADD S05ID NVARCHAR(50) NULL 

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id = tab.id WHERE tab.name = 'BT1002' AND col.name = 'S06ID')
	ALTER TABLE BT1002 ADD S06ID NVARCHAR(50) NULL 

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id = tab.id WHERE tab.name = 'BT1002' AND col.name = 'S07ID')
	ALTER TABLE BT1002 ADD S07ID NVARCHAR(50) NULL 

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id = tab.id WHERE tab.name = 'BT1002' AND col.name = 'S08ID')
	ALTER TABLE BT1002 ADD S08ID NVARCHAR(50) NULL 

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id = tab.id WHERE tab.name = 'BT1002' AND col.name = 'S09ID')
	ALTER TABLE BT1002 ADD S09ID NVARCHAR(50) NULL 

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id = tab.id WHERE tab.name = 'BT1002' AND col.name = 'S10ID')
	ALTER TABLE BT1002 ADD S10ID NVARCHAR(50) NULL 

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id = tab.id WHERE tab.name = 'BT1002' AND col.name = 'S11ID')
	ALTER TABLE BT1002 ADD S11ID NVARCHAR(50) NULL 

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id = tab.id WHERE tab.name = 'BT1002' AND col.name = 'S12ID')
	ALTER TABLE BT1002 ADD S12ID NVARCHAR(50) NULL 

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id = tab.id WHERE tab.name = 'BT1002' AND col.name = 'S13ID')
	ALTER TABLE BT1002 ADD S13ID NVARCHAR(50) NULL 

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id = tab.id WHERE tab.name = 'BT1002' AND col.name = 'S14ID')
	ALTER TABLE BT1002 ADD S14ID NVARCHAR(50) NULL 

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id = tab.id WHERE tab.name = 'BT1002' AND col.name = 'S15ID')
	ALTER TABLE BT1002 ADD S15ID NVARCHAR(50) NULL 

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id = tab.id WHERE tab.name = 'BT1002' AND col.name = 'S16ID')
	ALTER TABLE BT1002 ADD S16ID NVARCHAR(50) NULL 

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id = tab.id WHERE tab.name = 'BT1002' AND col.name = 'S17ID')
	ALTER TABLE BT1002 ADD S17ID NVARCHAR(50) NULL 

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id = tab.id WHERE tab.name = 'BT1002' AND col.name = 'S18ID')
	ALTER TABLE BT1002 ADD S18ID NVARCHAR(50) NULL 

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id = tab.id WHERE tab.name = 'BT1002' AND col.name = 'S19ID')
	ALTER TABLE BT1002 ADD S19ID NVARCHAR(50) NULL 

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id = tab.id WHERE tab.name = 'BT1002' AND col.name = 'S20ID')
	ALTER TABLE BT1002 ADD S20ID NVARCHAR(50) NULL 

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'BT1002' AND col.name = 'InheritVoucherID') 
    ALTER TABLE BT1002 ADD InheritVoucherID VARCHAR(50) NULL 

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'BT1002' AND col.name = 'SourceNo') 
    ALTER TABLE BT1002 ADD SourceNo NVARCHAR(50) NULL 
	
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'BT1002' AND col.name = 'DriverID') 
    ALTER TABLE BT1002 ADD DriverID VARCHAR(50) NULL 

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'BT1002' AND col.name = 'CarID') 
    ALTER TABLE BT1002 ADD CarID VARCHAR(50) NULL 

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'BT1002' AND col.name = 'ProductionOrder') 
    ALTER TABLE BT1002 ADD ProductionOrder VARCHAR(50) NULL 
END

