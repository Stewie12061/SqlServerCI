---- Create by Min Dũng on 24/10/2023 
--Danh mục cước vận chuyển bảng detail

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[AT9041]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].AT9041
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [APKMaster] VARCHAR(100),
  [Address] NVARCHAR (MAX) NULL,
  [RDAddressID] VARCHAR(50) NULL,
  [TotalPrice] DECIMAL (38, 20),
  [TruckType] NVARCHAR(100),
  [ShippingFeeCode] NVARCHAR(100),
  [Discount] DECIMAL(38, 20),
  [AmountAfterDiscount] DECIMAL (38, 20),
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [Orders] INT NULL,
CONSTRAINT [PK_AT9041] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9041' AND xtype = 'U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab ON col.id = tab.id WHERE tab.name = 'AT9041' AND col.name = 'RDAddressID')
		ALTER TABLE AT9041 ADD RDAddressID VARCHAR(50) NULL
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab ON col.id = tab.id WHERE tab.name = 'AT9041' AND col.name = 'Orders')
		ALTER TABLE AT9041 ADD Orders INT NULL
END
