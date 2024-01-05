---- Create by Hồng Thảo on 10/08/2018 
---- Mapping mặt hàng từ đề nghị mua hàng 
---- Modifier by Như Hàn on 30/11/2018: Thêm cột và sửa tên (ghi chú chi tiết phía dưới)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CIT1176]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CIT1176]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [InventoryIDProject] VARCHAR(50) NOT NULL,
  [InventoryNameProject] NVARCHAR(4000) NULL,
  [DivisionID] VARCHAR(50) NULL,
  [ProjectID] VARCHAR(50) NOT NULL,
  [SpecificationProject] NVARCHAR(4000) NULL,
  [InventoryID] VARCHAR(50) NULL,
  [SpecificationCI] NVARCHAR(250) NULL,
  [StatusID] VARCHAR(50) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_CIT1176] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END
/*
- Thêm mới các cột
ASCIDProJ : ID dự án bên ASC
ASCIDInven: ID hàng hóa bên ASC
ASCModel: Model hàng hóa bên ASC
ASCMadeby: Hãng sản xuất bên ASC
ASCInvenType: Loại hàng hóa bên ASC
ASCMadeIn: Xuất xứ bên ASC
ASCEquipment : Đầu mục thiết bị
ASCProJBeginDate: Ngày bắt đầu dự án
ASCProJEndDate: Ngày kết thúc dự án
- sửa tên các cột
InventoryIDProject -> ASCInventoryID : Mã hàng hóa bên ASC
InventoryNameProject -> ASCInvenName : Tên hàng hóa bên ASC
SpecificationProject -> ASCSpecIn	 : Thông số kỹ thật ASC
SpecificationCI -> SpecIn			 : Thông số kỹ thuật ERP
ProjectID -> ASCProjectID			 : Mã dự án bên ASC
*/
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CIT1176' AND xtype = 'U')
    BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'CIT1176' AND col.name = 'InventoryIDProject')
		EXEC sp_rename 'CIT1176.InventoryIDProject', 'ASCInventoryID', 'COLUMN';

		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'CIT1176' AND col.name = 'InventoryNameProject')
		EXEC sp_rename 'CIT1176.InventoryNameProject', 'ASCInvenName', 'COLUMN';

		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'CIT1176' AND col.name = 'SpecificationProject')
		EXEC sp_rename 'CIT1176.SpecificationProject', 'ASCSpecIn', 'COLUMN';

		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'CIT1176' AND col.name = 'SpecificationCI')
		EXEC sp_rename 'CIT1176.SpecificationCI', 'SpecIn', 'COLUMN';

		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'CIT1176' AND col.name = 'ProjectID')
		EXEC sp_rename 'CIT1176.ProjectID', 'ASCProjectID', 'COLUMN';
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CIT1176' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'CIT1176' AND col.name = 'ASCIDProJ')
        ALTER TABLE CIT1176 ADD ASCIDProJ INT NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'CIT1176' AND col.name = 'ASCIDInven')
        ALTER TABLE CIT1176 ADD ASCIDInven INT NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'CIT1176' AND col.name = 'ASCModel')
        ALTER TABLE CIT1176 ADD ASCModel NVARCHAR(250) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'CIT1176' AND col.name = 'ASCMadeby')
        ALTER TABLE CIT1176 ADD ASCMadeby NVARCHAR(250) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'CIT1176' AND col.name = 'ASCInvenType')
        ALTER TABLE CIT1176 ADD ASCInvenType VARCHAR(50) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'CIT1176' AND col.name = 'ASCMadeIn')
        ALTER TABLE CIT1176 ADD ASCMadeIn NVARCHAR(250) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'CIT1176' AND col.name = 'ASCProJBeginDate')
        ALTER TABLE CIT1176 ADD ASCProJBeginDate DATETIME NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'CIT1176' AND col.name = 'ASCProJEndDate')
        ALTER TABLE CIT1176 ADD ASCProJEndDate DATETIME NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'CIT1176' AND col.name = 'ASCEquipment')
        ALTER TABLE CIT1176 ADD ASCEquipment NVARCHAR(250) NULL
    END


