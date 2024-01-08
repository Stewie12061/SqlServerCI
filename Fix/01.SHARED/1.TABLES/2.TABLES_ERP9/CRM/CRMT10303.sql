---- Create by Nguyễn Tấn Lộc on 12/14/2020 1:29:04 PM
---- Bảng đánh dâu người nhận được được gửi mail hay chưa

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CRMT10303]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CRMT10303]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [APKCRMT10302] UNIQUEIDENTIFIER NULL,
  [IsSent] TINYINT DEFAULT (0) NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_CRMT10303] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---------------- 03/03/2021 - Tấn Lộc: Bổ sung cột GroupReceiverID ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT10303' AND col.name = 'GroupReceiverID')
BEGIN
	ALTER TABLE CRMT10303 ADD GroupReceiverID VARCHAR(50) NULL
END

---------------- 01/07/2021 - Tấn Lộc: Bổ sung cột APKCampaignMail ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT10303' AND col.name = 'APKCampaignMail')
BEGIN
	ALTER TABLE CRMT10303 ADD APKCampaignMail VARCHAR(50) NULL
END

---------------- 01/07/2021 - Tấn Lộc: Bổ sung cột APKCampaignSMS ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT10303' AND col.name = 'APKCampaignSMS')
BEGIN
	ALTER TABLE CRMT10303 ADD APKCampaignSMS VARCHAR(50) NULL
END