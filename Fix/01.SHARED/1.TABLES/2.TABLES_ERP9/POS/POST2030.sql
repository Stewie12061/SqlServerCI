---- Create by Cao Thị Phượng on 12/14/2017 11:52:56 AM
---- Phiếu đề nghị xuất hóa đơn master

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[POST2030]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[POST2030]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [VoucherTypeID] VARCHAR(50) NOT NULL,
  [VoucherNo] VARCHAR(50) NOT NULL,
  [VoucherDate] DATETIME NOT NULL,
  [TranYear] INT NOT NULL,
  [TranMonth] INT NOT NULL,
  [ShopID] VARCHAR(50) NOT NULL,	--Mã cửa hàng
  [SuggestUserID] VARCHAR(50) NULL,
  [ObjectID] VARCHAR(50) NOT NULL,	--Mã cửa hàng
  [ObjectName] NVARCHAR(250) NULL,	--tên cửa hàng
  [VATObjectID] VARCHAR(50) NULL,	--mã hội viên
  [VATObjectName] NVARCHAR(250) NULL,	--tên công ty
  [VATObjectAddress] NVARCHAR(250) NULL,	--Địa chỉ công ty
  [VATNo] VARCHAR(50) NULL,					--Mã số thuế (Công ty)
  [Status] TINYINT DEFAULT (0) NULL,
  [InvoiceVoucherNo] VARCHAR(50) NULL,
  [TableID] VARCHAR(50) NULL,
  [Description] NVARCHAR(250) NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [RelatedToTypeID] INT DEFAULT (51) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_POST2030] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END


--2018-04-27, Hoàng vũ: Người liên hệ
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST2030' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST2030' AND col.name = 'DeliveryContact') 
   ALTER TABLE POST2030 ADD DeliveryContact NVARCHAR(250) NULL 
END
/*===============================================END DeliveryContact===============================================*/ 

 --2018-04-27, Hoàng vũ: Người nhận hàng
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST2030' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST2030' AND col.name = 'DeliveryReceiver') 
   ALTER TABLE POST2030 ADD DeliveryReceiver NVARCHAR(250) NULL 
END
/*===============================================END DeliveryReceiver===============================================*/

--2018-04-27, Hoàng vũ: Điện thoại
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST2030' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST2030' AND col.name = 'DeliveryMobile') 
   ALTER TABLE POST2030 ADD DeliveryMobile NVARCHAR(250) NULL 
END
/*===============================================END DeliveryMobile===============================================*/

--2018-04-27, Hoàng vũ: Địa chỉ nhận hàng
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST2030' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST2030' AND col.name = 'DeliveryAddress') 
   ALTER TABLE POST2030 ADD DeliveryAddress NVARCHAR(250) NULL 
END
/*===============================================END DeliveryAddress===============================================*/





 --2019-01-23, Hoàng vũ: Mã số thuế => Khi lưu đề nghị xuất hóa đơn thì hệ thống check nếu Mã số thuế tồng tại thì Update tên công ty và địa chỉ công ty xuống ngược lại chưa tồn tại mã số thuế thì insert đối tượng theo mã số thuế
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST2030' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST2030' AND col.name = 'VATNo') 
   ALTER TABLE POST2030 ADD VATNo NVARCHAR(250) NULL 
END
/*===============================================END VATNo===============================================*/

--2019-01-23, Hoàng vũ: Tên công ty
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST2030' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST2030' AND col.name = 'ObjectName') 
   ALTER TABLE POST2030 ADD ObjectName NVARCHAR(250) NULL 
END
/*===============================================END ObjectName===============================================*/

--2019-01-23, Hoàng vũ: Địa chỉ công ty
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST2030' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST2030' AND col.name = 'Address') 
   ALTER TABLE POST2030 ADD Address NVARCHAR(250) NULL 
END
/*===============================================END Address===============================================*/


--2019-01-24, Hoàng vũ: Tên hội viên
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST2030' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST2030' AND col.name = 'MemberName') 
   ALTER TABLE POST2030 ADD MemberName NVARCHAR(250) NULL 
END
/*===============================================END MemberName===============================================*/