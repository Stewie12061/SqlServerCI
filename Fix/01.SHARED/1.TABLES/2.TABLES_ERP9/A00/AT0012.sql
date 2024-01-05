---- Create by Đoàn Duy 2020/11/08.
---- Modified by Đoàn Duy 2020/09/03. Move cột userID xuông dưới DeciceID. Chỉnh DiviceID thành Not Null. Chỉnh lại độ rộng của các cột NVARCHAR 
-- Lưu thông tin thiết bị người dùng.

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[AT0012]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[AT0012]
     (
		[APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
		[DivisionID] VARCHAR(50) NOT NULL,
		[DeviceID] NVARCHAR(250) NOT NULL, -- Unique ID của từng thiết bị 
		[UserID] VARCHAR(50) NOT NULL,
		[DeviceBrand] NVARCHAR(250) NULL, -- Tên thương hiệu
		[DeviceName] NVARCHAR(250) NULL, -- Tên của thiết bị
		[DeviceOS]  NVARCHAR(50) NULL, -- Tên HĐH: Android, IOS, Windows…
		[DeviceOSVersion] NVARCHAR(50) NULL,-- Version của HĐH
		[Status] INT NULL, -- Trạng thái thiết bị (Online/Offline/Disbaled) - (0,1,2)
		[DeviceToken] NVARCHAR(1000) NULL, -- Token thiết bị (dự phòng ở tương lai cần dùng)
		[NotifyToken] NVARCHAR(1000) NULL,-- Token đăng ký nhận thông báo của các service như Firebase, APNS, Amazone
		[FirstInstallTime] DATETIME2 NULL, -- Thời gian lần đầu ứng dụng được install trên thiết bị người dùng
		[LastedUpdateTime] DATETIME2 NULL, -- Lần cập nhật ứng dụng gần nhất trên thiết bị
		[AppVersion] NVARCHAR(50) NULL, -- Phiên bản của ứng dụng
		[LastIPAddress] NVARCHAR(50) NULL, -- Địa chỉ IP
		[LastedLoginTime] DATETIME2 NULL, -- Lần cuối đăng nhập
		[LastLogInfo] NVARCHAR(MAX) NULL, -- Log info  cuối cùng gửi về từ thiết bị
		[LastLogWarn] NVARCHAR(MAX) NULL, -- Log warning cuối cùng gửi về từ thiết bị
		[LastLogError] NVARCHAR(MAX) NULL, -- Log error cuối cùng gửi về từ thiết bị
		[Disable] TINYINT DEFAULT (1) NULL, -- Ẩn/hiện dữ liệu
		[CreateUserID] VARCHAR(50) NULL,
		[LastModifyUserID] VARCHAR(50) NULL,
		[CreateDate] DATETIME2 DEFAULT GETUTCDATE() NULL,
		[LastModifyDate] DATETIME2 DEFAULT GETUTCDATE() NULL

		CONSTRAINT [PK_AT0012] PRIMARY KEY CLUSTERED
		(
			[APK]
		)
		WITH (
			PAD_INDEX  = OFF,
			STATISTICS_NORECOMPUTE  = OFF,
			IGNORE_DUP_KEY = OFF,
			ALLOW_ROW_LOCKS  = ON,
			ALLOW_PAGE_LOCKS  = ON
			)
		ON [PRIMARY]
     )
	 ON [PRIMARY]
END

-- DeviceID index
IF(EXISTS(
	SELECT *
	FROM sys.indexes
	WHERE name='IDX_AT0012_DeviceID' AND object_id = OBJECT_ID('[dbo].[AT0012]')
))
BEGIN
	DROP INDEX [IDX_AT0012_DeviceID] ON dbo.[AT0012];
END

-- 08/10/2020 - Vĩnh Tâm: Cho phép cột DeviceID lưu NULL
ALTER TABLE AT0012 ALTER COLUMN DeviceID NVARCHAR(250) NULL
CREATE NONCLUSTERED INDEX [IDX_AT0012_DeviceID] ON [dbo].[AT0012]([DeviceID])

-- UserID index
IF(EXISTS(
	SELECT *
	FROM sys.indexes
	WHERE name='IDX_AT0012_UserID' AND object_id = OBJECT_ID('[dbo].[AT0012]')
))
BEGIN
	DROP INDEX [IDX_AT0012_UserID] ON dbo.[AT0012];
END

CREATE NONCLUSTERED INDEX [IDX_AT0012_UserID] ON [dbo].[AT0012]([UserID])

-- 02/10/2020 - Vĩnh Tâm: Cho phép cột DivisionID lưu NULL
-- Xóa khóa chính và tạo lại vì cấu trúc cũ lấy khóa chính là APK và DivisionID nên không thể ALTER COLUMN DivisionID
ALTER TABLE AT0012 DROP CONSTRAINT  PK_AT0012
ALTER TABLE AT0012 ADD CONSTRAINT PK_AT0012 PRIMARY KEY (APK);
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'AT0012' AND col.name = 'DivisionID')
BEGIN
  ALTER TABLE AT0012 ALTER COLUMN DivisionID VARCHAR(50) NULL
END
