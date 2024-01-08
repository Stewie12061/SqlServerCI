---- Create by Le Hoang on 01/10/2020
---- Chi tiết phiếu Quản lý chất lượng đầu Ca (Detail) - Bảng lưu chi tiết phiếu đầu ca Tạm

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[QCT2001_TEMP]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[QCT2001_TEMP](
	[APK] [uniqueidentifier] DEFAULT NEWID() NOT NULL,
	[DivisionID] [varchar](50) NOT NULL,
	[APKMaster] [uniqueidentifier] NOT NULL,
	[InventoryID] [varchar](50) NULL,
	[SourceNo] [varchar](50) NULL,
	[BatchNo] [varchar](50) NULL,
	[AutoScale] [tinyint] NULL,
	[GrossWeight] [decimal](28, 8) NULL,
	[NetWeight] [decimal](28, 8) NULL,
	[Description] [nvarchar](250) NULL,
	[Notes01] [nvarchar](250) NULL,
	[Notes02] [nvarchar](250) NULL,
	[Notes03] [nvarchar](250) NULL,
	[DParameter01] [nvarchar](250) NULL,
	[DParameter02] [nvarchar](250) NULL,
	[DParameter03] [nvarchar](250) NULL,
	[DParameter04] [nvarchar](250) NULL,
	[DParameter05] [nvarchar](250) NULL,
	[DeleteFlg] [tinyint] DEFAULT 0 NOT NULL,
	[CreateDate] [datetime] DEFAULT GETDATE() NULL,
	[CreateUserID] [varchar](50) NULL,
	[LastModifyDate] [datetime] DEFAULT GETDATE() NULL,
	[LastModifyUserID] [varchar](50) NULL,
 CONSTRAINT [PK_QCT2001_TEMP] PRIMARY KEY CLUSTERED 
(
	[APK] ASC,
	[DivisionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END

--Bổ sung cột Trạng thái
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'QCT2001_TEMP' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'QCT2001_TEMP' AND col.name = 'Status')
   ALTER TABLE QCT2001_TEMP ADD Status INT NULL
END

--Bổ sung cột Đơn vị tính khác
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'QCT2001_TEMP' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'QCT2001_TEMP' AND col.name = 'OtherUnitID')
   ALTER TABLE QCT2001_TEMP ADD OtherUnitID VARCHAR(50) NULL
END

--Bổ sung cột Số lượng đơn vị tính khác 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'QCT2001_TEMP' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'QCT2001_TEMP' AND col.name = 'OtherQuantity')
   ALTER TABLE QCT2001_TEMP ADD OtherQuantity DECIMAL(28,8) NULL
END

--Bổ sung cột Số lần in tem
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'QCT2001_TEMP' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'QCT2001_TEMP' AND col.name = 'TypeID')
   ALTER TABLE QCT2001_TEMP ADD TypeID VARCHAR(25) NULL
END

--Bổ sung cột Số lần in tem
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'QCT2001_TEMP' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'QCT2001_TEMP' AND col.name = 'PrintStamp')
   ALTER TABLE QCT2001_TEMP ADD PrintStamp DECIMAL(28,8) NULL
END

--Bổ sung cột Số lần in tem
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'QCT2001_TEMP' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'QCT2001_TEMP' AND col.name = 'IsScaled')
   ALTER TABLE QCT2001_TEMP ADD IsScaled TINYINT NULL
END

--Bổ sung cột Thứ tự
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'QCT2001_TEMP' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'QCT2001_TEMP' AND col.name = 'Orders')
   ALTER TABLE QCT2001_TEMP ADD Orders INT NULL
END

-- 02/02/2021 - [Đình Ly] - Begin add

-- Bổ sung cột Số lượng kế thừa
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
ON col.id = tab.id where tab.name = 'QCT2001_TEMP'  and col.name = 'QuantityInherit')
ALTER TABLE QCT2001_TEMP ADD QuantityInherit DECIMAL(28,8) NULL

-- Bổ sung cột Số lượng chất lượng
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
ON col.id = tab.id where tab.name = 'QCT2001_TEMP'  and col.name = 'QuantityQC')
ALTER TABLE QCT2001_TEMP ADD QuantityQC DECIMAL(28,8) NULL

-- Bổ sung cột Số lượng không đạt chất lượng
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
ON col.id = tab.id where tab.name = 'QCT2001_TEMP'  and col.name = 'QuantityUnQC')
ALTER TABLE QCT2001_TEMP ADD QuantityUnQC DECIMAL(28,8) NULL

-- Bổ sung cột Xử lý
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
ON col.id = tab.id where tab.name =   'QCT2001_TEMP'  and col.name = 'HandlingID')
ALTER TABLE QCT2001_TEMP ADD HandlingID VARCHAR(50) NULL

-- Bổ sung cột Bảng kế thừa
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
ON col.id = tab.id where tab.name =   'QCT2001_TEMP'  and col.name = 'InheritTable')
ALTER TABLE QCT2001_TEMP ADD InheritTable VARCHAR(50) NULL

-- Bổ sung cột Phiếu kế thừa
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
ON col.id = tab.id where tab.name =   'QCT2001_TEMP'  and col.name = 'InheritVoucher')
ALTER TABLE QCT2001_TEMP ADD InheritVoucher VARCHAR(50) NULL

-- Bổ sung cột item của Phiếu kế thừa
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
ON col.id = tab.id where tab.name =   'QCT2001_TEMP'  and col.name = 'InheritTransaction')
ALTER TABLE QCT2001_TEMP ADD InheritTransaction uniqueidentifier NULL

-- 02/02/2021 - [Đình Ly] - End add

-- 26/02/2021 - [Lê Hoàng] - Begin add
-- Bổ sung cột Lý do (MAITHU)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'QCT2001_TEMP' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'QCT2001_TEMP' AND col.name = 'ReasonID')
   ALTER TABLE QCT2001_TEMP ADD ReasonID VARCHAR(50) NULL
END

-- Bổ sung cột nguyên nhân
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'QCT2001_TEMP' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'QCT2001_TEMP' AND col.name = 'Causal')
   ALTER TABLE QCT2001_TEMP ADD Causal NVARCHAR(500) NULL
END

-- Bổ sung cột biện pháp xử lý
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'QCT2001_TEMP' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'QCT2001_TEMP' AND col.name = 'Solution')
   ALTER TABLE QCT2001_TEMP ADD Solution NVARCHAR(500) NULL
END

-- Bổ sung cột công đoạn
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'QCT2001_TEMP' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'QCT2001_TEMP' AND col.name = 'PhaseID')
   ALTER TABLE QCT2001_TEMP ADD PhaseID NVARCHAR(500) NULL
END

-- Bổ sung cột Phương pháp kiểm thử
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'QCT2001_TEMP' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'QCT2001_TEMP' AND col.name = 'MethodTestID')
   ALTER TABLE QCT2001_TEMP ADD MethodTestID NVARCHAR(500) NULL
END

-- Bổ sung cột Đã giao tới khách hàng chưa?
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'QCT2001_TEMP' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'QCT2001_TEMP' AND col.name = 'DeliveredID')
   ALTER TABLE QCT2001_TEMP ADD DeliveredID NVARCHAR(500) NULL
END
-- 26/02/2021 - [Lê Hoàng] - End add

-- 09/08/2023 - [Anh Đô] - Begin add
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'QCT2001_TEMP' AND xtype = 'U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id = tab.id WHERE tab.name = 'QCT2001_TEMP' AND col.name = 'Ana06ID')
	ALTER TABLE QCT2001_TEMP ADD Ana06ID NVARCHAR(50) NULL
END
-- 09/08/2023 - [Anh Đô] - End add
