---- Create by Nguyễn Tấn Lộc on 10/08/2020 9:33:05 AM
---- Thiết lập mail nhận theo user

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[AT14052]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[AT14052]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [APKMaster] VARCHAR(250) NULL,
  [DivisionID] VARCHAR(50) NULL,
  [Protocol] NVARCHAR (250) NULL,
  [Server] VARCHAR(50) NULL,
  [Port] VARCHAR(50) NULL,
  [Email] NVARCHAR(250) NULL,
  [Password] VARCHAR(MAX) NULL,
  [EnableSsl] TINYINT DEFAULT 0 NULL,
  [UserID] VARCHAR(50) NULL,
  [DisplayName] NVARCHAR(MAX) NULL,
  [UserMailSettingReceives] NVARCHAR(MAX) NULL,
  [DeleteFlg] TINYINT DEFAULT 0 NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_AT14052] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---------------- 10/09/2020 - Tấn Lộc: Bổ sung cột SignatureSendMail ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT14052' AND col.name = 'SignatureSendMail')
BEGIN
	ALTER TABLE AT14052 ADD SignatureSendMail NVARCHAR(MAX) NULL
END

---------------- 10/09/2020 - Tấn Lộc: Bổ sung cột SignatureFeedbackMail ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT14052' AND col.name = 'SignatureFeedbackMail')
BEGIN
	ALTER TABLE AT14052 ADD SignatureFeedbackMail NVARCHAR(MAX) NULL
END

---------------- 15/09/2020 - Tấn Lộc: Bổ sung cột ProtocolSend ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT14052' AND col.name = 'ProtocolSend')
BEGIN
	ALTER TABLE AT14052 ADD ProtocolSend NVARCHAR(250) NULL
END

---------------- 15/09/2020 - Tấn Lộc: Bổ sung cột ServerSend ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT14052' AND col.name = 'ServerSend')
BEGIN
	ALTER TABLE AT14052 ADD ServerSend VARCHAR(50) NULL
END

---------------- 15/09/2020 - Tấn Lộc: Bổ sung cột PortSend ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT14052' AND col.name = 'PortSend')
BEGIN
	ALTER TABLE AT14052 ADD PortSend VARCHAR(50) NULL
END

---------------- 15/09/2020 - Tấn Lộc: Bổ sung cột UserMailSettingSend ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT14052' AND col.name = 'UserMailSettingSend')
BEGIN
	ALTER TABLE AT14052 ADD UserMailSettingSend NVARCHAR(MAX) NULL
END

---------------- 07/10/2020 - Tấn Lộc: Bổ sung cột EmailDefault ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT14052' AND col.name = 'EmailDefault')
BEGIN
	ALTER TABLE AT14052 ADD EmailDefault TINYINT DEFAULT 0
END
