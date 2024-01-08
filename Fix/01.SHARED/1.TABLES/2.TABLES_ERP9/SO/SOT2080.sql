-- <History>
----Created by: Hoàng Trúc on 25/11/2019
----Updated by: Đình Ly on 11/12/2020
----Updated by: Trọng Kiên on 31/12/2020
----Updated by: Văn Tài	   on 30/12/2021 - Bổ sung xử lý kiểm tra bổ sung cột.
---- Thông tin sản xuất (MAITHU = 107) 

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[SOT2080]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[SOT2080]
(
	[APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
	[DivisionID] VARCHAR(50) NOT NULL,
	[DeleteFlg] TINYINT DEFAULT (0) NULL,
	[CreateUserID] VARCHAR(50) NULL,
	[CreateDate] DATETIME NULL,
	[LastModifyUserID] VARCHAR(50) NULL,
	[LastModifyDate] DATETIME NULL,
	[VoucherTypeID] VARCHAR(50) NULL,
	[TranMonth] INT NULL,
	[Tranyear] INT NULL,
	[VoucherDate] DATETIME NULL,
	[VoucherNo] VARCHAR(50) NULL,
	[InventoryID] VARCHAR(50) NULL,
	[ApprovePerson01ID] VARCHAR(50) NULL,
	[ApprovePerson01Status] INT NULL, 
	[ObjectID] VARCHAR(50) NULL,
	[Address] NVARCHAR(250) NULL,
	[DeliveryTime] DATETIME NULL,
	[DeliveryAddressName] NVARCHAR(250) NULL,
	[Status] tinyint NULL DEFAULT ((0))

CONSTRAINT [PK_SOT2080] PRIMARY KEY CLUSTERED
(
	[APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---- Modified by Đình Ly on 07/12/2020: Thêm cột bảng được kế thừa.
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2080' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2080' AND col.name = 'TableInherited')
	BEGIN
	ALTER TABLE SOT2080 ADD TableInherited VARCHAR(50) NULL
	END
END

---- Modified by Đình Ly on 11/12/2020: Bổ sung thêm cột Thời gian giao hàng.
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'SOT2080' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'SOT2080' AND col.name = 'ShipDate')
   BEGIN
   ALTER TABLE SOT2080 ADD ShipDate DATETIME NULL
   END
END

---- Modified by Đình Ly on 21/12/2020
---- Thêm cột ghi chú giao hàng.
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2080' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2080' AND col.name = 'DeliveryNotes')
	BEGIN
    ALTER TABLE SOT2080 ADD DeliveryNotes NVARCHAR(500) NULL
	END
END

---- Thêm cột người duyệt công đoạn Cắt cuộn.
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2080' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2080' AND col.name = 'CutRollApprovePersonID')
	BEGIN
    ALTER TABLE SOT2080 ADD CutRollApprovePersonID VARCHAR(50) NULL
	END
END

---- Thêm cột trạng thái duyệt công đoạn Cắt cuộn.
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2080' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2080' AND col.name = 'ApproveCutRollStatusID')
	BEGIN
    ALTER TABLE SOT2080 ADD ApproveCutRollStatusID VARCHAR(50) NULL
	END
END

---- Thêm cột người duyệt công đoạn Sóng.
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2080' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2080' AND col.name = 'WaveApprovePersonID')
	BEGIN
    ALTER TABLE SOT2080 ADD WaveApprovePersonID VARCHAR(50) NULL
	END
END

---- Thêm cột trạng thái duyệt công đoạn Sóng.
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2080' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2080' AND col.name = 'ApproveWaveStatusID')
	BEGIN
    ALTER TABLE SOT2080 ADD ApproveWaveStatusID VARCHAR(50) NULL
	END
END

---- Thêm cột trạng thái Phiếu thông tin sản xuất.
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2080' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2080' AND col.name = 'StatusID')
	BEGIN
    ALTER TABLE SOT2080 ADD StatusID VARCHAR(50) NULL
	END
END

---- Thêm cột bán thành phẩm.
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2080' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2080' AND col.name = 'SemiProduct')
	BEGIN
    ALTER TABLE SOT2080 ADD SemiProduct VARCHAR(50) NULL
	END
END

---- Thêm cột APKInherit của đơn hàng bán
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2080' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2080' AND col.name = 'APKInherit')
	BEGIN
    ALTER TABLE SOT2080 ADD APKInherit UNIQUEIDENTIFIER NULL
	END
END

---- Thêm cột APKMaster_9000
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2080' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2080' AND col.name = 'APKMaster_9000')
	BEGIN
    ALTER TABLE SOT2080 ADD APKMaster_9000 UNIQUEIDENTIFIER NULL
	END
END

---- Thêm cột Assemble (Kế thừa lắp ráp)
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2080' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2080' AND col.name = 'Assemble')
	BEGIN
    ALTER TABLE SOT2080 ADD Assemble int NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2080' AND col.name = 'TranMonth')
	BEGIN
    ALTER TABLE SOT2080 ADD TranMonth int NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2080' AND col.name = 'TranYear')
	BEGIN
    ALTER TABLE SOT2080 ADD TranYear int NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2080' AND col.name = 'DeliveryTime')
	BEGIN
		ALTER TABLE SOT2080 ADD [DeliveryTime] DATETIME NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2080' AND col.name = 'DeliveryAddressName')
	BEGIN
		ALTER TABLE SOT2080 ADD DeliveryAddressName NVARCHAR(250) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2080' AND col.name = 'Status')
	BEGIN
		ALTER TABLE SOT2080 ADD Status TINYINT NULL DEFAULT (0)
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2080' AND col.name = 'DeleteFlg')
	BEGIN
		ALTER TABLE SOT2080 ADD DeleteFlg TINYINT NULL DEFAULT (0)
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2080' AND col.name = 'PrintTypeID')
	BEGIN
		ALTER TABLE SOT2080 ADD PrintTypeID VARCHAR(50) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2080' AND col.name = 'PaperTypeID')
	BEGIN
		ALTER TABLE SOT2080 ADD PaperTypeID VARCHAR(50) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2080' AND col.name = 'ActualQuantity')
	BEGIN
		ALTER TABLE SOT2080 ADD ActualQuantity DECIMAL(18, 8) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2080' AND col.name = 'Length')
	BEGIN
		ALTER TABLE SOT2080 ADD Length VARCHAR(25) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2080' AND col.name = 'Width')
	BEGIN
		ALTER TABLE SOT2080 ADD Width VARCHAR(25) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2080' AND col.name = 'Height')
	BEGIN
		ALTER TABLE SOT2080 ADD Height VARCHAR(25) NULL
	END

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2080' AND col.name = 'Notes')
	BEGIN
    ALTER TABLE SOT2080 ADD Notes NVARCHAR(500) NULL
	END

		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2080' AND col.name = 'APK_BomVersion')
	BEGIN
		ALTER TABLE SOT2080 ADD APK_BomVersion VARCHAR(50) NULL
	END
END
