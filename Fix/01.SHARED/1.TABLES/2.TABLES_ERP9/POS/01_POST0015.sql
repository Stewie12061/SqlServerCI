--Create by: Phan thanh hoang vu
--Create Date: 08/05/04/2014
--Drop column "TableID"
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST0015' AND xtype='U')
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST0015' AND col.name='TableID')
	ALTER TABLE POST0015 Drop Column TableID
END

----------------Dùng để lấy chứng từ tham chiếu phiếu nhập/phiếu xuất sinh ra từ ----------------------
----------------phiếu bán hàng/ phiếu đổi hàng/phiếu trả hàng VoucherID--------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='POST0015' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='POST0015' AND col.name='VoucherID')
	ALTER TABLE POST0015 ADD VoucherID varchar(50) NULL
END
