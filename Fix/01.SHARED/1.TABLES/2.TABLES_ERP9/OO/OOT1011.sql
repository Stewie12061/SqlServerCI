---- Create by Bảo Anh on 30/08/2018
---- Danh Mục Loại Bất Thường (bảng chi tiết loại công theo ngày)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT1011]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[OOT1011]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
      [APKMaster] UNIQUEIDENTIFIER NOT NULL,
      [FromDate] TINYINT NULL,
      [ToDate] TINYINT NULL,
      [AbsentTypeID] VARCHAR(50) NULL
      
    CONSTRAINT [PK_OOT1011] PRIMARY KEY CLUSTERED
      (
		[APK]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

---------------- 05/08/2020 - Trọng Kiên: Đổi kiểu dữ liệu FromDate ----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT1011' AND col.name = 'FromDate')
BEGIN
	ALTER TABLE OOT1011 ALTER COLUMN FromDate DATETIME NULL
END

---------------- 05/08/2020 - Trọng Kiên: Đổi kiểu dữ liệu ToDate ----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT1011' AND col.name = 'ToDate')
BEGIN
	ALTER TABLE OOT1011 ALTER COLUMN ToDate DATETIME NULL
END