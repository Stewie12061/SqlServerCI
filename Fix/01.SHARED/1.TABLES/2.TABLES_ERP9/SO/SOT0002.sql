---- Create by Kiều Nga on 07/11/2019
---- Thiết lập mặc định loại chứng từ

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[SOT0002]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[SOT0002]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [VoucherQuotationA] VARCHAR(50) NULL, -- Phiếu báo giá NC
  [VoucherQuotationB] VARCHAR(50) NULL, -- Phiếu báo giá Sale
  [VoucherQuotationC] VARCHAR(50) NULL, -- Phiếu báo giá KHCU
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_SOT0002] PRIMARY KEY CLUSTERED
(
  [APK],
  [DivisionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END   

---- Modified on 19/11/2019 by Học Huy: Bổ sung trường VoucherOutSource (Loại CT đơn hàng gia công)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'SOT0002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'SOT0002' AND col.name = 'VoucherOutSource') 
   ALTER TABLE SOT0002 ADD VoucherOutSource NVARCHAR(MAX) NULL 
END

---- Modified on 19/11/2019 by Học Huy: Bổ sung trường VoucherSalesPlan (Loại CT kế hoạch bán hàng)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'SOT0002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'SOT0002' AND col.name = 'VoucherSalesPlan') 
   ALTER TABLE SOT0002 ADD VoucherSalesPlan NVARCHAR(MAX) NULL 
END

---- Modified on 13/12/2019 by Đình Ly: Bổ sung trường VoucherDeliveryProgress (Loại CT kế hoạch giao hàng)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'SOT0002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'SOT0002' AND col.name = 'VoucherDeliveryProgress') 
   ALTER TABLE SOT0002 ADD VoucherDeliveryProgress NVARCHAR(MAX) NULL 
END

---- Modified on 18/12/2019 by Đình Ly: Bổ sung trường VoucherProductInfo (Loại CT thông tin sản xuất)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'SOT0002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'SOT0002' AND col.name = 'VoucherProductInfo') 
   ALTER TABLE SOT0002 ADD VoucherProductInfo NVARCHAR(MAX) NULL 
END

---- Modified on 02/03/2020 by Kiều Nga: Bổ sung trường GroupRoleID (Nhóm xem báo giá SALE không cần duyệt)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'SOT0002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'SOT0002' AND col.name = 'GroupRoleID') 
   ALTER TABLE SOT0002 ADD GroupRoleID NVARCHAR(MAX) NULL 
END
---- Modified on 26/03/2020 by Đình Ly: Bổ sung trường VoucherReceiveProgress (Loại CT kế hoạch nhận hàng)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'SOT0002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'SOT0002' AND col.name = 'VoucherReceiveProgress') 
   ALTER TABLE SOT0002 ADD VoucherReceiveProgress NVARCHAR(MAX) NULL 
END

---- Modified on 05/06/2020 by Kiều Nga: Bổ sung trường VoucherSaleOrder (Loại CT đơn hàng bán)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'SOT0002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'SOT0002' AND col.name = 'VoucherSaleOrder') 
   ALTER TABLE SOT0002 ADD VoucherSaleOrder NVARCHAR(MAX) NULL 
END

---- Modified on 29/07/2020 by Kiều Nga: Bổ sung trường VoucherQuotation (Loại CT phiếu báo giá)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'SOT0002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'SOT0002' AND col.name = 'VoucherQuotation') 
   ALTER TABLE SOT0002 ADD VoucherQuotation NVARCHAR(MAX) NULL 
END

---- Modified on 29/07/2020 by Kiều Nga: Bổ sung trường VoucherAdjustOrder (Loại CT Đơn hàng điều chỉnh)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'SOT0002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'SOT0002' AND col.name = 'VoucherAdjustOrder') 
   ALTER TABLE SOT0002 ADD VoucherAdjustOrder NVARCHAR(MAX) NULL 
END

---- Modified on 28/12/2020 by Trọng Kiên: Bổ sung trường VoucherOutOfStock
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'SOT0002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'SOT0002' AND col.name = 'VoucherOutOfStock') 
   ALTER TABLE SOT0002 ADD VoucherOutOfStock NVARCHAR(MAX) NULL 
END

---- Modified on 23/06/2021 by Đình Hòa: Bổ sung trường VoucherSpreadSheet
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'SOT0002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'SOT0002' AND col.name = 'VoucherSpreadSheet') 
   ALTER TABLE SOT0002 ADD VoucherSpreadSheet NVARCHAR(MAX) NULL 
END

---- Modified on 23/08/2021 by Kiều Nga: Bổ sung trường VoucherBusinessPlan
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'SOT0002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'SOT0002' AND col.name = 'VoucherBusinessPlan') 
   ALTER TABLE SOT0002 ADD VoucherBusinessPlan NVARCHAR(MAX) NULL 
END

