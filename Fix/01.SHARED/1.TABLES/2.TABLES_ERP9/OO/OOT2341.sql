---- Create by Văn Tài on 11/05/2022
---- Quản lý văn bản : luồng người duyệt, ký.

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT2341]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT2341]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER NOT NULL,			--- APK : OOT2340.
  [DivisionID]	VARCHAR(50) NOT NULL,
  [DocumentID]	VARCHAR(50)   NULL,					--- Mã văn bản.  
  [Steps]		INT DEFAULT 0 NULL,					--- Bước cho từng nhóm.
  [Orders]		INT DEFAULT 0 NULL,					--- Thứ tự người ký.
  [RefID]		VARCHAR(100) NULL,					--- Mã mapping với người ký trên hệ thống nhà cung cấp.
  [FollowerID]	NVARCHAR(250) NOT NULL,				--- Tên văn bản.
  [DepartmentID] VARCHAR(50) NULL,					--- Mã phòng ban.
  [DutyID]		VARCHAR(50) NULL,					--- Mã chức vụ.
  [Email]		VARCHAR(50) NULL,					--- Email.
  [Tel]			VARCHAR(50) NULL,					--- SDT.
  [Status]		TINYINT NULL,						--- Trạng thái duyệt nội bộ.
  [SignedStatus]	TINYINT NULL,					--- Trạng thái ký điện tử.
  [UseESign]		TINYINT NULL,					--- Sử dụng chữ ký điện tử.    
  [SignedDate]		DATETIME NULL,					--- Ngày ký số.
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_OOT2341] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2341' AND xtype = 'U')
BEGIN 

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT2341' AND col.name = 'RefID') 
			ALTER TABLE OOT2341 ADD RefID VARCHAR(100) NULL

END