---- Create by Nguyễn Tấn Lộc on 11/11/2020 2:11:33 PM
---- Mối liên hệ giữa nhóm nhân mail và người nhận

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CRMT10302]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CRMT10302]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [GroupReceiverID] VARCHAR(50) NULL,
  [RelatedToID] VARCHAR(50) NULL,
  [ReceiverID] VARCHAR(50) NULL,
  [ReceiverName] NVARCHAR(MAX) NULL,
  [Address] NVARCHAR(MAX) NULL,
  [Email] NVARCHAR(MAX) NULL,
  [Mobile] NVARCHAR(250) NULL,
  [Tel] NVARCHAR(250) NULL,
  [RelatedToTypeID_REL] VARCHAR(50) NULL,
  [RelTableID] VARCHAR(50) NULL,
  [RelatedToTypeName] NVARCHAR(MAX) NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_CRMT10302] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END
---------------- 26/11/2020 - Tấn Lộc: Bổ sung cột APKGroupReceiverEmail ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT10302' AND col.name = 'APKGroupReceiverEmail')
BEGIN
	ALTER TABLE CRMT10302 ADD APKGroupReceiverEmail VARCHAR(250) NULL
END

---------------- 14/12/2020 - Tấn Lộc: Bổ sung cột Prefix, FirstName, LastName ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT10302' AND col.name = 'Prefix')
BEGIN
	ALTER TABLE CRMT10302 ADD Prefix NVARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT10302' AND col.name = 'FirstName')
BEGIN
	ALTER TABLE CRMT10302 ADD FirstName NVARCHAR(MAX) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT10302' AND col.name = 'LastName')
BEGIN
	ALTER TABLE CRMT10302 ADD LastName NVARCHAR(MAX) NULL
END