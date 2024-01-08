---- Create by Nguyễn Hoàng Bảo Thy on 1/13/2017 2:30:36 PM
---- Chi phí lưu kho (EIMSKIP)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[WT0099]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[WT0099]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [TransactionID] VARCHAR(50) NOT NULL,
  [VoucherID] VARCHAR(50) NOT NULL,
  [VoucherNo] VARCHAR(50) NULL,
  [VoucherDate] DATETIME NULL,
  [ObjectID] VARCHAR(50) NULL,
  [ContractID] VARCHAR(50) NULL,
  [DayUnit] TINYINT NULL,
  [WareHouseID] VARCHAR(50) NULL,
  [InventoryID] VARCHAR(50) NULL,
  [UnitPrice] DECIMAL(28,8) NULL,
  [Quantity] DECIMAL(28,8) NULL,
  [ConvertCoefficient] DECIMAL(28,8) NULL,
  [UnitID] VARCHAR(50) NULL,
  [FromDate] DATETIME NULL,
  [ToDate] DATETIME NULL,
  [NumDate] INT NULL,
  [OriginalAmount] DECIMAL(28,8) NULL,
  [ExchangeRate] DECIMAL(28,8) NULL,
  [ConvertAmount] DECIMAL(28,8) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_WT0099] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [TransactionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

----Modified by Bảo Thy on 20/03/2017: Bổ sung lưu trạng thái quyết toán
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WT0099' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'WT0099' AND col.name = 'IsFinalCost') 
   ALTER TABLE WT0099 ADD IsFinalCost TINYINT NULL 
END


IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WT0099' AND xtype = 'U')
BEGIN 
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'WT0099' AND col.name = 'TransactionID' AND ISNULL(col.cdefault,0) = 0) 
   ALTER TABLE WT0099 ADD DEFAULT NEWID() FOR TransactionID
END

--- Modified by Huỳnh Thử on 29/11/2019: Bổ sung lưu trạng thái tính phí cuối cùng
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WT0099' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'WT0099' AND col.name = 'IsEnd') 
   ALTER TABLE WT0099 ADD IsEnd TINYINT NULL 
END
--- Modified by Huỳnh Thử on 27/03/2020: Bổ sung lưu trạng Loại tính chi phí
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WT0099' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'WT0099' AND col.name = 'IsRent') 
   ALTER TABLE WT0099 ADD IsRent TINYINT NULL 
END