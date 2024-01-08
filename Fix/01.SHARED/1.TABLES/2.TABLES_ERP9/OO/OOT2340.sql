---- Create by Văn Tài on 06/05/2022
---- Update by Đức Tuyên on 08/07/2022 Thêm trường
---- Quản lý văn bản

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT2340]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT2340]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [APKMaster_9000] UNIQUEIDENTIFIER NULL,			--- APK : OOT9000.
  [DivisionID] VARCHAR(50) NOT NULL,				
  [TranYear]	INT	NOT NULL,
  [TranMonth]	INT NOT NULL,
  [DocumentID] VARCHAR(50) NOT NULL,				--- Mã văn bản.
  [UseDocumentNumberInto] VARCHAR(50) NULL,			--- Số văn bản đến.
  [DocumentName] NVARCHAR(250) NULL,				--- Tên văn bản.
  [DocumentMode] VARCHAR(50) NULL,						--- Văn bản đến / Đi (VBDEN/VBDI)
  [UseDocumentTypeName] NVARCHAR(250) NULL,		--- Tên loại văn bản.
  [DocumentTypeID] VARCHAR(50) NULL,				--- Phân loại văn bản
  [RefID]		VARCHAR(100) NULL,					--- Key văn bản khi upload văn bản lên hệ thống nhà phân phối.
  [IsInternal]	TINYINT NULL,						--- Văn bản nội bộ.
  [Status]	TINYINT NULL,							--- Trạng thái duyệt nội bộ.
  [SignedStatus]	TINYINT NULL,					--- Trạng thái ký điện tử.
  [ComposePlace]	NVARCHAR(500) NULL,			--- Nơi biên soạn.
  [PublishPlace]	NVARCHAR(500),					--- Nơi phát hành.
  [ReceivedDate] DATETIME NULL,						--- Ngày nhận.
  [ReceivedPlace] NVARCHAR(500),					--- Nơi nhận.
  [SentDate] DATETIME NULL,							--- Ngày gửi.
  [SentPlace] NVARCHAR(500) NULL,					--- Nơi gửi.
  [DocumentSignDate] DATETIME NULL,					--- Ngày ký (thông tin mô tả trên phiếu).
  [UseSignerName] NVARCHAR(250) NULL,				--- Sử dụng chữ ký - nhập tay.
  [UseSignerDutyName] NVARCHAR(250) NULL,		--- Sử dụng chức vụ người ký - nhập tay.
  [UseSignerAuthority] NVARCHAR(250) NULL,	--- Sử dụng thẩm quyền người ký - nhập tay.
  [OutOfDate] DATETIME NULL,						--- Ngày hết hạn xử lý.
  [Summary] NVARCHAR(MAX) NULL,						--- Trích yếu.
  --[PriorityID] TINYINT DEFAULT 0 NULL,			--- Độ ưu tiên (optional) chưa phát triển.
  [AssignedToUserID] VARCHAR(50) NULL,				--- Người phụ trách.
  [DecidedToUserID] VARCHAR(50) NULL,				--- Người có thẩm quyền giải quyết.
  [HardStoreDepartmentID] NVARCHAR(500) NULL,		--- Nơi lưu bản cứng.  
  [DeleteFlg] TINYINT DEFAULT 0 NULL,				--- Cờ xóa văn bản.
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_OOT2340] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2340' AND xtype = 'U')
BEGIN 

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT2340' AND col.name = 'RefID') 
			ALTER TABLE OOT2340 ADD RefID VARCHAR(100) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT2340' AND col.name = 'DocumentMode') 
			ALTER TABLE OOT2340 ADD DocumentMode INT DEFAULT 0 NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT2340' AND col.name = 'TranYear') 
			ALTER TABLE OOT2340 ADD TranYear INT NOT NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT2340' AND col.name = 'TranMonth') 
			ALTER TABLE OOT2340 ADD TranMonth INT NOT NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT2340' AND col.name = 'IsInternal') 
			ALTER TABLE OOT2340 ADD IsInternal TINYINT NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT2340' AND col.name = 'PublishPlace') 
			ALTER TABLE OOT2340 ADD PublishPlace NVARCHAR(500) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT2340' AND col.name = 'DocumentNumberInto') 
			ALTER TABLE OOT2340 ADD DocumentNumberInto VARCHAR(50) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT2340' AND col.name = 'UseDocumentTypeName') 
			ALTER TABLE OOT2340 ADD UseDocumentTypeName NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT2340' AND col.name = 'ComposePlace') 
			ALTER TABLE OOT2340 ADD ComposePlace NVARCHAR(500) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT2340' AND col.name = 'UseSignerName') 
			ALTER TABLE OOT2340 ADD UseSignerName NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT2340' AND col.name = 'UseSignerDutyName') 
			ALTER TABLE OOT2340 ADD UseSignerDutyName NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT2340' AND col.name = 'UseSignerAuthority') 
			ALTER TABLE OOT2340 ADD UseSignerAuthority NVARCHAR(250) NULL

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT2340' AND col.name = 'DocumentID') 
			ALTER TABLE OOT2340 ALTER COLUMN DocumentID NVARCHAR(250) NOT NULL
END