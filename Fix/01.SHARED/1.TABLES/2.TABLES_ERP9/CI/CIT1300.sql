---- Create by Văn Tài on 10/05/2023.
---- Update by Trọng Phúc on 23/10/2023 Bổ sung customize cho NKC
---- Dữ liệu thông tin Xe (Master).

IF EXISTS (SELECT * FROM CustomerIndex WHERE CustomerName = 166)
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CIT1300]') AND TYPE IN (N'U'))
	BEGIN
		CREATE TABLE [dbo].[CIT1300]
		(
		  [APK]				UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,  
		  [DivisionID]		VARCHAR(50) NOT NULL,
		  [AssetID]			VARCHAR(50) NOT NULL,	--- Mã xe.
		  [CarNumber]		VARCHAR(50) NULL,		--- Biển số xe.
		  [MainRouteID]		VARCHAR(50) NOT NULL,	--- Tuyến chính của xe khi chạy.
		  [EmployeeID]		VARCHAR(50) NOT NULL,	--- Mã tài xế phụ trách.
		  [Weight]			DECIMAL(28, 8) NULL,	--- Tải trọng
		  [Height]			DECIMAL(28, 8) NULL,	--- Kích thước thùng: Cao.
		  [Length]			DECIMAL(28, 8) NULL,	--- Kích thước thùng: Dài.
		  [Width]			DECIMAL(28, 8) NULL,	--- Kích thước thùng: Rộng.
		  [DeliveryStart]	VARCHAR(50) NULL,		--- Khung giờ được phép lưu thông: Giờ bắt đầu.
		  [DeliveryEnd]		VARCHAR(50) NULL,		--- Khung giờ được phép lưu thông: Giờ kết thúc.
		  [IsNextDay]		TINYINT		NULL,		--- Khung giờ được phép lưu thông: Đánh dấu qua ngày hôm sau.
		  [CreateUserID]	VARCHAR(50) NULL,		
		  [CreateDate]		DATETIME	NULL,
		  [LastModifyUserID] VARCHAR(50) NULL,
		  [LastModifyDate]	 DATETIME NULL,
		CONSTRAINT [PK_CIT1300] PRIMARY KEY CLUSTERED
		(
		  [APK]
		)
		WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		)
		ON [PRIMARY]
	END
	
---- Modified by Trọng Phúc on 9/11/2023: Bổ sung các cột
---- Cột Notes
	IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CIT1300' AND xtype = 'U') 
	BEGIN
		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'CIT1300' AND col.name = 'Notes')
		BEGIN
		ALTER TABLE CIT1300 ADD Notes NVARCHAR(50) NULL
		END
	END
---- Cột thể tích
	IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CIT1300' AND xtype = 'U') 
	BEGIN
		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'CIT1300' AND col.name = 'Volume')
		BEGIN
		ALTER TABLE CIT1300 ADD Volume DECIMAL(28,8) NULL
		END
	END
---- Cột tên xe
	IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CIT1300' AND xtype = 'U') 
	BEGIN
		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'CIT1300' AND col.name = 'AssetName')
		BEGIN
		ALTER TABLE CIT1300 ADD AssetName NVARCHAR(50) NOT NULL
		END
	END
---- Cột deleteflg
	IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CIT1300' AND xtype = 'U') 
	BEGIN
		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'CIT1300' AND col.name = 'DeleteFlg')
		BEGIN
		ALTER TABLE CIT1300 ADD DeleteFlg TINYINT NOT NULL DEFAULT (0)
		END
	END
---- Cột dùng chung
	IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CIT1300' AND xtype = 'U') 
	BEGIN
		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'CIT1300' AND col.name = 'IsCommon')
		BEGIN
		ALTER TABLE CIT1300 ADD IsCommon TINYINT NOT NULL DEFAULT (0)
		END
	END
END

