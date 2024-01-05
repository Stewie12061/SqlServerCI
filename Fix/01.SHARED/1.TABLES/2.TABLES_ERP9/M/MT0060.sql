---- Create by Đình Ly on 04/02/2021 8:52:59 PM
---- Bảng thiết lập hệ thống module M (Quản lý sản xuất)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[MT0060]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[MT0060]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL

CONSTRAINT [PK_MT0060] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-- 04/02/2021 - [Đình Ly] - Begin add
-- Thêm cột Số chứng từ Sắp xếp cont (VoucherSortCont) 
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'MT0060' AND col.name = 'VoucherSortCont')
BEGIN
	ALTER TABLE MT0060 ADD VoucherSortCont VARCHAR(50) NULL
END
-- Thêm cột Số chứng từ Tính thùng đóng gói
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'MT0060' AND col.name = 'VoucherParking')
BEGIN
	ALTER TABLE MT0060 ADD VoucherParking VARCHAR(50) NULL
END
-- Thêm cột Số chứng từ Đóng gói thành phẩm giao khách hàng
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'MT0060' AND col.name = 'VoucherParkingRequest')
BEGIN
	ALTER TABLE MT0060 ADD VoucherParkingRequest VARCHAR(50) NULL
END
-- 04/02/2021 - [Đình Ly] - End add

-- 01/03/2021 - [Trọng Kiên] - Begin add
-- Thêm cột Số chứng từ kế hoạch sản xuất
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'MT0060' AND col.name = 'VoucherManufacturingPlan')
BEGIN
	ALTER TABLE MT0060 ADD VoucherManufacturingPlan VARCHAR(50) NULL
END

-- 01/03/2021 - [Trọng Kiên] - End add

-- 17/03/2021 - [Trọng Kiên] - Begin add
-- Thêm cột Số chứng từ dự trù sản xuất
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'MT0060' AND col.name = 'VoucherEstimate')
BEGIN
	ALTER TABLE MT0060 ADD VoucherEstimate VARCHAR(50) NULL
END
-- 17/03/2021 - [Trọng Kiên] - End add



-- 18/03/2021 - Kiều Nga] - Begin add
-- Thêm cột Số chứng từ Thống kê kết quả sản xuất
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'MT0060' AND col.name = 'VoucherProductionResult')
BEGIN
	ALTER TABLE MT0060 ADD VoucherProductionResult VARCHAR(50) NULL
END
-- 18/03/2021 - Kiều Nga] - End add

-- 13/04/2021 - [Trọng Kiên] - Begin add
-- Thêm cột Số chứng từ lệnh sản xuất
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'MT0060' AND col.name = 'VoucherProductOrder')
BEGIN
	ALTER TABLE MT0060 ADD VoucherProductOrder VARCHAR(50) NULL
END
-- 17/03/2021 - [Trọng Kiên] - End add

-- 16/05/2021 - [Đình Hòa] - Begin add :  Thêm cột Số chứng từ đơn hàng sản xuất
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'MT0060' AND col.name = 'VoucherManufacturingOrder')
BEGIN
	ALTER TABLE MT0060 ADD VoucherManufacturingOrder VARCHAR(50) NULL
END
-- 16/05/2021 - [Đình Hòa] - End add