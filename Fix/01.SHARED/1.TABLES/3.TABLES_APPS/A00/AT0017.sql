---- Create by Đoàn Duy on 10/02/2021
---- 1BOSS Quan hệ Thuê bao - Gói/Module lẻ (AT0014 - AT0016/AT1302) 
IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[AT0017]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[AT0017]
(
  [SubscriberID] VARCHAR(50) NOT NULL,
  [PackageID] NVARCHAR(50) NOT NULL, 
  [IsPackage] TINYINT DEFAULT 0 NULL,
  [Type] TINYINT DEFAULT 0 NULL, -- Phân biệt Gói (0), Nghành (1)
CONSTRAINT [AT0017_PK] PRIMARY KEY CLUSTERED
(
  [SubscriberID],[PackageID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---------------- 28/03/2022 - Hoài Bảo: Bổ sung cột APK ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT0017' AND col.name = 'APK')
BEGIN
	ALTER TABLE AT0017 ADD APK UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL
	
END

---------------- 05/03/2022 - Hoài Bảo: Thay đổi tên cột PackageID -> InventoryID ----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT0017' AND col.name = 'PackageID')
BEGIN
	EXEC SP_RENAME 'AT0017.PackageID','InventoryID','COLUMN'
END


---------------- 06/05/2022 - Tấn Lộc: Loại bỏ CONSTRAINT củ ----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT0017')
BEGIN
	ALTER TABLE AT0017 DROP CONSTRAINT [AT0017_PK];
END

---------------- 06/05/2022 - Tấn Lộc: Tạo lại CONSTRAINT mới ----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT0017')
BEGIN
	ALTER TABLE AT0017 ADD CONSTRAINT [AT0017_PK] PRIMARY KEY (APK);
END

---------------- 06/05/2022 - Tấn Lộc: Thay đổi kiểu dữ liệu của cột SubscriberID, InventoryID ----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT0017' AND col.name = 'SubscriberID')
BEGIN
	ALTER TABLE AT0017 ALTER COLUMN SubscriberID VARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT0017' AND col.name = 'InventoryID')
BEGIN
	ALTER TABLE AT0017 ALTER COLUMN InventoryID VARCHAR(50) NULL
END