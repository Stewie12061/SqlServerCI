---- Create by Trương Tấn Thành on 5/29/2020 2:59:48 PM
---- Danh mục lịch sử BEM

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[BEMT00003]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[BEMT00003]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [HistoryID] INT NULL,
  [Description] NVARCHAR(MAX) NULL,
  [RelatedToID] VARCHAR(25) NULL,
  [RelatedToTypeID] INT NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(25) NULL,
  [StatusID] INT NULL,
  [ScreenID] VARCHAR(250) NULL,
  [TableID] VARCHAR(25) NULL
CONSTRAINT [PK_BEMT00003] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-------------------- 19/06/2020 - Vĩnh Tâm: Đổi kiểu dữ liệu cho cột RelatedToID --------------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT00003' AND col.name = 'RelatedToID')
BEGIN 
   ALTER TABLE BEMT00003 ALTER COLUMN RelatedToID VARCHAR (50) NULL
END
