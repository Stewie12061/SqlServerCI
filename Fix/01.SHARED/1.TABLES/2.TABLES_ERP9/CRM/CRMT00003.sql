---- Create by truonglam on 2/7/2020 11:00:03 AM
---- Danh mục lịch sử

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CRMT00003]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CRMT00003]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [HistoryID] INT NULL,
  [Description] NVARCHAR(MAX) NULL,
  [RelatedToID] VARCHAR(50) NULL,
  [RelatedToTypeID] INT NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [StatusID] INT NULL,
  [ScreenID] VARCHAR(250) NULL,
  [TableID] VARCHAR(50) NULL
CONSTRAINT [PK_CRMT00003] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-------------------- 07/02/2020 - Truong Lam: Bổ sung cột ScreenID, TableID --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'CRMT00003' AND col.name = 'ScreenID')
BEGIN
  ALTER TABLE CRMT00003 ADD ScreenID VARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'CRMT00003' AND col.name = 'TableID')
BEGIN
  ALTER TABLE CRMT00003 ADD TableID VARCHAR(50) NULL
END