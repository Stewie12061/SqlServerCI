-- <Summary>
---- 
-- <History>
---- Create on 05/09/2022 by Kiều Nga: Điều phối
---- Modified on 09/11/2023 by Viết Toàn: Bổ sung cột TableID: Xác định điều phối từ bảo hành sửa chữa/ đơn hàng bán
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SOT2170]') AND type in (N'U'))
CREATE TABLE [dbo].[SOT2170](
	[APK] [uniqueidentifier] NOT NULL DEFAULT NEWID(),
	[DivisionID] [varchar](50) NOT NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[VoucherNo] [varchar](50) NULL,
	[VoucherDate] [DateTime] NULL,
	[TransactionID] [VARCHAR](50) NULL,
	[Lock] [tinyint] NULL,
	[Car] [nvarchar](50) NULL,
	[Transport] [nvarchar](50) NULL,
	[BeginDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[EmployeeID] [nvarchar](50) NULL,
	[Route] [nvarchar](50) NULL,
	[ObjectID] [nvarchar](50) NULL,
	[OrderNo] [nvarchar](50) NULL,
	[InventoryID] [nvarchar](50) NULL,
	[Quantity] [decimal](28,8) NULL,
	[Address] [nvarchar](max) NULL,
	[DeliveryDate] [datetime] NULL,
	[Status] [nvarchar](50) NULL,
	[Notes] [nvarchar](max) NULL,
	[Order] INT NULL,
	[DeleteFlag] [int] DEFAULT 0,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [varchar](50) NULL,
	[LastModifyUserID] [varchar](50) NULL,
	[LastModifyDate] [datetime] NULL
	
 CONSTRAINT [PK_SOT2170] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


-- Thêm cột TransactionID: Cần lưu thông tin từng dòng mặt hàng thay thế Mã hàng.
-- Vì có thể trùng dòng mặt hàng và giao 2 địa chỉ khác nhau.
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2170' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2170' AND col.name = 'TransactionID')
	BEGIN
		ALTER TABLE SOT2170 ADD TransactionID VARCHAR(50) NULL
	END

	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2170' AND col.name = 'Quantity')
	BEGIN
		ALTER TABLE SOT2170 ALTER COLUMN Quantity DECIMAL(28, 8) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2170' AND col.name = 'TableID')
	BEGIN
		ALTER TABLE SOT2170 ADD TableID VARCHAR(50) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2170' AND col.name = 'Distance')
	BEGIN
		ALTER TABLE SOT2170 ADD Distance DECIMAL(28, 8) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2170' AND col.name = 'TypeOrder')
	BEGIN
		ALTER TABLE SOT2170 ADD TypeOrder INT NULL
	END

	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2170' AND col.name = 'Address')
	BEGIN
		ALTER TABLE SOT2170 ALTER COLUMN [Address] NVARCHAR(MAX) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2170' AND col.name = 'S01ID')
	BEGIN
		ALTER TABLE SOT2170 ADD S01ID NVARCHAR(50) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2170' AND col.name = 'S02ID')
	BEGIN
		ALTER TABLE SOT2170 ADD S02ID NVARCHAR(50) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2170' AND col.name = 'S03ID')
	BEGIN
		ALTER TABLE SOT2170 ADD S03ID NVARCHAR(50) NULL
	END
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2170' AND col.name = 'S04ID')
	BEGIN
		ALTER TABLE SOT2170 ADD S04ID NVARCHAR(50) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2170' AND col.name = 'S05ID')
	BEGIN
		ALTER TABLE SOT2170 ADD S05ID NVARCHAR(50) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2170' AND col.name = 'S06ID')
	BEGIN
		ALTER TABLE SOT2170 ADD S06ID NVARCHAR(50) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2170' AND col.name = 'S07ID')
	BEGIN
		ALTER TABLE SOT2170 ADD S07ID NVARCHAR(50) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2170' AND col.name = 'S08ID')
	BEGIN
		ALTER TABLE SOT2170 ADD S08ID NVARCHAR(50) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2170' AND col.name = 'S09ID')
	BEGIN
		ALTER TABLE SOT2170 ADD S09ID NVARCHAR(50) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2170' AND col.name = 'S10ID')
	BEGIN
		ALTER TABLE SOT2170 ADD S10ID NVARCHAR(50) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2170' AND col.name = 'S11ID')
	BEGIN
		ALTER TABLE SOT2170 ADD S11ID NVARCHAR(50) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2170' AND col.name = 'S12ID')
	BEGIN
		ALTER TABLE SOT2170 ADD S12ID NVARCHAR(50) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2170' AND col.name = 'S13ID')
	BEGIN
		ALTER TABLE SOT2170 ADD S13ID NVARCHAR(50) NULL
	END
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2170' AND col.name = 'S14ID')
	BEGIN
		ALTER TABLE SOT2170 ADD S14ID NVARCHAR(50) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2170' AND col.name = 'S15ID')
	BEGIN
		ALTER TABLE SOT2170 ADD S15ID NVARCHAR(50) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2170' AND col.name = 'S16ID')
	BEGIN
		ALTER TABLE SOT2170 ADD S16ID NVARCHAR(50) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2170' AND col.name = 'S17ID')
	BEGIN
		ALTER TABLE SOT2170 ADD S17ID NVARCHAR(50) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2170' AND col.name = 'S18ID')
	BEGIN
		ALTER TABLE SOT2170 ADD S18ID NVARCHAR(50) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2170' AND col.name = 'S19ID')
	BEGIN
		ALTER TABLE SOT2170 ADD S19ID NVARCHAR(50) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2170' AND col.name = 'S20ID')
	BEGIN
		ALTER TABLE SOT2170 ADD S20ID NVARCHAR(50) NULL
	END

END
