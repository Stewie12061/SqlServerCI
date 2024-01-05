---- Create by Khâu Vĩnh Tâm on 11/7/2018 10:20:08 AM
---- Danh mục Từ điển hỗ trợ

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CRMT1090]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CRMT1090]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [SupportDictionaryID] VARCHAR(50) NULL,
  [DivisionID] VARCHAR(50) NULL,
  [SupportDictionarySubject] NVARCHAR(MAX) NULL,
  [RelatedToTypeID] INT NULL,
  [KindID] VARCHAR(50) NULL,
  [PriorityID] INT DEFAULT 1 NULL,
  [TimeFeedback] VARCHAR(10) DEFAULT 1 NULL,
  [FeedbackDescription] NVARCHAR(MAX) NULL,
  [RequestDescription] NVARCHAR(MAX) NULL,
  [AttachFile] NVARCHAR(MAX) NULL,
  [Disabled] TINYINT DEFAULT 0 NULL,
  [IsCommon] TINYINT DEFAULT 0 NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_CRMT1090] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-- 22/09/2020 - Vĩnh Tâm: Bổ sung cột APK
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
       ON col.id = tab.id WHERE tab.name = 'CRMT1090' AND col.name = 'APK')
BEGIN
    ALTER TABLE CRMT1090 ADD APK UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL
END

-- 22/01/2021 - Vĩnh Tâm: Bổ sung cột InventoryID
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
       ON col.id = tab.id WHERE tab.name = 'CRMT1090' AND col.name = 'InventoryID')
BEGIN
    ALTER TABLE CRMT1090 ADD InventoryID VARCHAR(50) NULL
END
