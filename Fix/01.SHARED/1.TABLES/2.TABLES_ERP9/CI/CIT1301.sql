---- Create by Văn Tài on 10/05/2023.
---- Update by Trọng Phúc on 23/10/2023 Bổ sung customize cho NKC
---- Dữ liệu thông tin tuyến phụ của Xe (Details).

IF EXISTS (SELECT * FROM CustomerIndex WHERE CustomerName = 166)
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CIT1301]') AND TYPE IN (N'U'))
	BEGIN
		CREATE TABLE [dbo].[CIT1301]
		(
		  [APK]				UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,  
		  [APKMaster]		VARCHAR(50) NOT NULL,	--- CIT1300.APK: Khóa chính thông tin xe.
		  [AssetID]			VARCHAR(50) NOT NULL,	--- CIT1300.Asset: Mã xe.
		  [Orders]			INT NULL,				--- Thứ tự tuyến phụ.
		  [SubRouteID]		VARCHAR(50) NOT NULL,	--- CT0143.RouteID: Mã tuyến.
  
		CONSTRAINT [PK_CIT1301] PRIMARY KEY CLUSTERED
		(
		  [APK]
		)
		WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		)
		ON [PRIMARY]
	END
	---- Modified by Trọng Phúc on 9/11/2023: Bổ sung các cột
	---- Cột đơn vị
	IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CIT1301' AND xtype = 'U') 
	BEGIN
		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'CIT1301' AND col.name = 'DivisionID')
		BEGIN
		ALTER TABLE CIT1301 ADD DivisionID NVARCHAR(50) NOT NULL
		END
	END
	---- Cột người tạo
	IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CIT1301' AND xtype = 'U') 
	BEGIN
		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'CIT1301' AND col.name = 'CreateUserID')
		BEGIN
		ALTER TABLE CIT1301 ADD CreateUserID VARCHAR(50) NULL
		END
	END
	---- Cột ngày tạo
	IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CIT1301' AND xtype = 'U') 
	BEGIN
		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'CIT1301' AND col.name = 'CreateDate')
		BEGIN
		ALTER TABLE CIT1301 ADD CreateDate DATETIME NULL
		END
	END
	---- Cột người sửa
	IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CIT1301' AND xtype = 'U') 
	BEGIN
		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'CIT1301' AND col.name = 'LastModifyUserID')
		BEGIN
		ALTER TABLE CIT1301 ADD LastModifyUserID VARCHAR(50) NULL
		END
	END
	---- Cột ngày sửa
	IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CIT1301' AND xtype = 'U') 
	BEGIN
		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'CIT1301' AND col.name = 'LastModifyDate')
		BEGIN
		ALTER TABLE CIT1301 ADD LastModifyDate DATETIME NULL
		END
	END
	---- Cột ngày sửa
	IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CIT1301' AND xtype = 'U') 
	BEGIN
		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'CIT1301' AND col.name = 'DeleteFlg')
		BEGIN
		ALTER TABLE CIT1301 ADD DeleteFlg TINYINT DEFAULT (0) NULL
		END
	END
END