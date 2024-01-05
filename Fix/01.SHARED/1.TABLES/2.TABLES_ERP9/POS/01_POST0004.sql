---------------------------Thêm cột ShopID và add thêm vào primary key---------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST0004' AND xtype='U')
BEGIN
	if not exists (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS C JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS K
					ON C.TABLE_NAME = K.TABLE_NAME
					AND C.CONSTRAINT_CATALOG = K.CONSTRAINT_CATALOG
					AND C.CONSTRAINT_SCHEMA = K.CONSTRAINT_SCHEMA
					AND C.CONSTRAINT_NAME = K.CONSTRAINT_NAME
					WHERE C.CONSTRAINT_TYPE = 'PRIMARY KEY'
					and C.TABLE_NAME = 'POST0004'
					AND K.COLUMN_NAME = 'ShopID')
	BEGIN
		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='POST0004' AND col.name='ShopID')
		BEGIN 
			DROP TABLE POST0004

			CREATE TABLE [dbo].[POST0004](
			[APK] [uniqueidentifier] DEFAULT NEWID() NOT NULL,
			[DivisionID] [varchar](50) NOT NULL,
			[ShopID] [varchar](50) NOT NULL,
			[VoucherType01] [varchar](50) NOT NULL, --1: Phiếu nhập
			[VoucherType02] [varchar](50) NOT NULL, --2: Phiếu hàng bán trả lại
			[VoucherType03] [varchar](50) NOT NULL, --3: Phiếu kiểm kê kho
			[VoucherType04] [varchar](50) NOT NULL,
			[VoucherType05] [varchar](50) NOT NULL, --5: Phiếu bán hàng
			[VoucherType06] [varchar](50) NOT NULL, --6: Phiếu nhật ký
			[VoucherType07] [varchar](50) NOT NULL, --7: Phiếu đề nghị xuất/trả hàng
			[VoucherType08] [varchar](50) NOT NULL, --8: Phiếu chênh lệch
			[VoucherType09] [varchar](50) NOT NULL, --9: Phiếu xuất kho
			[VoucherType10] [varchar](50) NOT NULL, --10:Phiếu đề nghị vận chuyện nội bộ
			[VoucherType11] [varchar](50) NOT NULL, --11:Phiếu vận chuyển nội bộ
			[VoucherType12] [varchar](50) NOT NULL, --12:Phiếu đổi hàng
			[VoucherType13] [varchar](50) NOT NULL, --13:Phiếu số dư hàng tồn kho
			[VoucherType14] [varchar](50) NOT NULL, --14:Phiếu thu
			[VoucherType15] [varchar](50) NOT NULL, --15:Phiếu đặt cọc
			[VoucherType16] [varchar](50) NOT NULL, --16:Phiếu đề nghị chi
			[VoucherType17] [varchar](50) NOT NULL, --17:Phiếu yêu cầu xuất hóa đơn
			[VoucherType18] [varchar](50) NOT NULL, --18:Phiếu yêu cầu xuất kho
			[VoucherType19] [varchar](50) NOT NULL, --19:Phiếu yêu cầu nhập kho
			[VoucherType20] [varchar](50) NOT NULL, --20:Phiếu bút toán tổng hợp
			[CreateUserID] [varchar](50) NULL,		
			[CreateDate] [datetime] NULL,
			[LastModifyUserID] [varchar](50) NULL,
			[LastModifyDate] [datetime] NULL,
		 CONSTRAINT [PK_POST0004] PRIMARY KEY CLUSTERED 
		(
			[DivisionID] ASC,
			[ShopID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]

		END
	END
END
---------------------------Thêm cột VoucherType09-------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST0004' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST0004' AND col.name='VoucherType09')
	ALTER TABLE POST0004 ADD VoucherType09 varchar(50) NULL
END

---------------------------Thêm cột VoucherType10-------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST0004' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST0004' AND col.name='VoucherType10')
	ALTER TABLE POST0004 ADD VoucherType10 varchar(50) NULL
END

---------------------------Thêm cột VoucherType11-------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST0004' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST0004' AND col.name='VoucherType11')
	ALTER TABLE POST0004 ADD VoucherType11 varchar(50) NULL
END

---------------------------Thêm cột VoucherType12-------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST0004' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST0004' AND col.name='VoucherType12')
	ALTER TABLE POST0004 ADD VoucherType12 varchar(50) NULL
END

---------------------------Thêm cột VoucherType13-------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST0004' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST0004' AND col.name='VoucherType13')
	ALTER TABLE POST0004 ADD VoucherType13 varchar(50) NULL
END

---------------------------Thị Phượng Thêm cột VoucherType14 bổ sung loại chứng từ mặt định phiếu thu-------------------------------------
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST0004' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST0004' AND col.name = 'VoucherType14') 
   ALTER TABLE POST0004 ADD VoucherType14 VARCHAR(50) NULL 
END
---------------------------Thị Phượng on 08/12/2017 Thêm cột VoucherType15 bổ sung loại chứng từ mặt định -------------------------------------
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST0004' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST0004' AND col.name = 'VoucherType15') 
   ALTER TABLE POST0004 ADD VoucherType15 VARCHAR(50) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST0004' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST0004' AND col.name = 'VoucherType16') 
   ALTER TABLE POST0004 ADD VoucherType16 VARCHAR(50) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST0004' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST0004' AND col.name = 'VoucherType17')
   ALTER TABLE POST0004 ADD VoucherType17 VARCHAR(50) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST0004' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST0004' AND col.name = 'VoucherType18') 
   ALTER TABLE POST0004 ADD VoucherType18 VARCHAR(50) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST0004' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST0004' AND col.name = 'VoucherType19') 
   ALTER TABLE POST0004 ADD VoucherType19 VARCHAR(50) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST0004' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST0004' AND col.name = 'VoucherType20') 
   ALTER TABLE POST0004 ADD VoucherType20 VARCHAR(50) NULL 
END

--Kiều Nga on 17/09/2018: Bổ sung Phiếu yêu cầu dịch vụ 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST0004' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST0004' AND col.name = 'VoucherType21') 
   ALTER TABLE POST0004 ADD VoucherType21 VARCHAR(50) NULL 
END

---END