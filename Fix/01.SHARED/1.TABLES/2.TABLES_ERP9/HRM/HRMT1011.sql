---- Create by Nguyễn Hoàng Bảo Thy on 7/18/2017 2:10:23 PM
---- Danh mục hình thức phỏng vấn (Detail)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HRMT1011]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HRMT1011]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [InterviewTypeID] VARCHAR(50) NOT NULL,
  [DutyID] VARCHAR(50) NOT NULL,
  [DetailTypeID] VARCHAR(50) NOT NULL,
  [Description] NVARCHAR(1000) NULL,
  [ResultFormat] TINYINT DEFAULT (0) NULL,
  [FromValue] DECIMAL(28,8) NULL,
  [ToValue] DECIMAL(28,8) NULL,
  [Notes] NVARCHAR(1000) NULL
CONSTRAINT [PK_HRMT1011] PRIMARY KEY CLUSTERED
(
  [APK],
  [DivisionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---------------- 05/10/2022 - Tấn Lộc: Update độ dài dữ liệu cột Description ----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT1011' AND col.name = 'Description')
BEGIN
	ALTER TABLE HRMT1011 ALTER COLUMN Description NVARCHAR(MAX) NULL
END

IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HRMT1011' AND col.name = 'Notes')
BEGIN
	ALTER TABLE HRMT1011 ALTER COLUMN Notes NVARCHAR(MAX) NULL
END