-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Mỹ Tuyền
---- Modified by Tiểu Mai on 12/01/2016: Bổ sung 20 cột quy cách sản phẩm (PSxxID), PeriodID.
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MT2222]') AND type in (N'U'))
CREATE TABLE [dbo].[MT2222](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[ProductID] [nvarchar](50) NULL,
	[InventoryTypeID] [nvarchar](50) NULL,
	[UnitID] [nvarchar](50) NULL,
	[ProductQuantity] [decimal](28, 8) NULL,
	[PerfectRate] [decimal](28, 8) NULL,
	[MaterialRate] [decimal](28, 8) NULL,
	[HumanResourceRate] [decimal](28, 8) NULL,
	[OthersRate] [decimal](28, 8) NULL,
	CONSTRAINT [PK_MT2222] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'MT2222' AND col.name = 'PS01ID')
        ALTER TABLE MT2222 ADD	PS01ID NVARCHAR(50) NULL,
								PS02ID NVARCHAR(50) NULL,
								PS03ID NVARCHAR(50) NULL,
								PS04ID NVARCHAR(50) NULL,
								PS05ID NVARCHAR(50) NULL,
								PS06ID NVARCHAR(50) NULL,
								PS07ID NVARCHAR(50) NULL,
								PS08ID NVARCHAR(50) NULL,
								PS09ID NVARCHAR(50) NULL,
								PS10ID NVARCHAR(50) NULL,
								PS11ID NVARCHAR(50) NULL,
								PS12ID NVARCHAR(50) NULL,
								PS13ID NVARCHAR(50) NULL,
								PS14ID NVARCHAR(50) NULL,
								PS15ID NVARCHAR(50) NULL,
								PS16ID NVARCHAR(50) NULL,
								PS17ID NVARCHAR(50) NULL,
								PS18ID NVARCHAR(50) NULL,
								PS19ID NVARCHAR(50) NULL,
								PS20ID NVARCHAR(50) NULL

IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'MT2222' AND col.name = 'PeriodID')
        ALTER TABLE MT2222 ADD	PeriodID NVARCHAR (50) NULL