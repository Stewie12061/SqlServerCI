---- Create by Cao Thị Phượng on 7/28/2017 8:26:09 AM
---- Phiếu đề xuất khuyễn mãi Detail

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[POST00902]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[POST00902]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [ShopID] VARCHAR(50) NOT NULL,
  [APKMaster] VARCHAR(50) NOT NULL,
  [WareHouseID] VARCHAR(50) NOT NULL,
  [InventoryID] VARCHAR(50) NOT NULL,
  [InventoryName] NVARCHAR(250) NOT NULL,
  [ActualQuantity] INT NOT NULL,
  [UnitID] VARCHAR(50) NULL,
  [UnitPrice] DECIMAL(28,8) NULL,
  [CA] DECIMAL(28,8) NULL,
  [PromoteInventoryID] VARCHAR(50) NOT NULL,
  [PromoteUnitPrice] DECIMAL(28,8) NULL,
  [SuggestInventoryID] VARCHAR(50) NOT NULL,
  [SuggestUnitPrice] DECIMAL(28,8) NULL,
  [SuggestCA] DECIMAL(28,8) NULL,
  [NotesConfirm] NVARCHAR(max) NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NOT NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [IsConfirmDetail] TINYINT DEFAULT (0) NULL,
  [Orders] INT NULL
CONSTRAINT [PK_POST00902] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

--Lưu vết khi chọn hàng đề xuất trên POS_WEB
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST00902' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST00902' AND col.name = 'APPDetailSuggestID') 
   ALTER TABLE POST00902 ADD APPDetailSuggestID VARCHAR(50) NULL 
END
/*===============================================END APPDetailSuggestID===============================================*/ 