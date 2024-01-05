---- Create by Cao Thị Phượng on 2/21/2017 10:08:04 AM
---- Danh sách Email đi
---- Modify by Tấn Lộc - 26/09/2020 - Thay đổi cấu trúc bảng CMNT90051
IF EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CMNT90051]') AND TYPE IN (N'U'))
	AND NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CMNT90051' AND col.name = 'UIDMail')
BEGIN
	DROP TABLE CMNT90051
END

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CMNT90051]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CMNT90051]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [UIDMail] VARCHAR(250) NULL,
  [SubjectName] NVARCHAR(MAX) NULL,
  [From] NVARCHAR(MAX) NULL,
  [To] NVARCHAR(MAX) NULL,
  [Cc] NVARCHAR(MAX) NULL,
  [Bcc] NVARCHAR(MAX) NULL,
  [UserID] VARCHAR(50) NULL,
  [StatusID] VARCHAR(50) NULL,
  [TypeOfProtocol] VARCHAR(50) NULL,
  [Description] NVARCHAR(MAX) NULL,
  [EmailTemplateID] NVARCHAR(MAX) NULL,
  [NoOfAttachFile] INT NULL,
  [TypeOfEmail] VARCHAR(50) NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_CMNT90051] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---------------- 03/03/2021 - Tấn Lộc: Bổ sung cột SendMailDate ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CMNT90051' AND col.name = 'SendMailDate')
BEGIN
	ALTER TABLE CMNT90051 ADD SendMailDate DATETIME NULL
END

---------------- 03/03/2021 - Tấn Lộc: Bổ sung cột ReplyTo ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CMNT90051' AND col.name = 'ReplyTo')
BEGIN
	ALTER TABLE CMNT90051 ADD ReplyTo VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CMNT90051' AND col.name = 'APKEmail_ChooseReply')
BEGIN
	ALTER TABLE CMNT90051 ADD APKEmail_ChooseReply VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CMNT90051' AND col.name = 'References_ReplyTo')
BEGIN
	ALTER TABLE CMNT90051 ADD References_ReplyTo VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CMNT90051' AND col.name = 'Forward')
BEGIN
	ALTER TABLE CMNT90051 ADD Forward VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CMNT90051' AND col.name = 'References_Forward')
BEGIN
	ALTER TABLE CMNT90051 ADD References_Forward VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CMNT90051' AND col.name = 'APKEmail_ChooseForward')
BEGIN
	ALTER TABLE CMNT90051 ADD APKEmail_ChooseForward VARCHAR(250) NULL
END

---------------- 23/06/2021 - Tấn Lộc: Bổ sung cột GroupReceiverID - Lưu thông tin Nhóm nhận ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CMNT90051' AND col.name = 'GroupReceiverID')
BEGIN
	ALTER TABLE CMNT90051 ADD GroupReceiverID NVARCHAR(MAX) NULL
END