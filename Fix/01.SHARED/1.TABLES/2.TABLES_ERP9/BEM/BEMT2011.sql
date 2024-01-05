---- Create by Trương Tấn Thành on 5/26/2020 1:28:56 PM
---- Chi tiết lịch trình

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[BEMT2011]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[BEMT2011]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER NOT NULL,
  [DivsionID] VARCHAR(50) NULL,
  [Date] DATETIME NULL,
  [Destination] NVARCHAR(250) NULL,
  [DestinationDetail] NVARCHAR(250) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_BEMT2011] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

--- 10/06/2020 - Tấn Thành: Bổ sung cột APKMaster_9000
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2011' AND col.name = 'APKMaster_9000')
BEGIN
	ALTER TABLE BEMT2011 ADD APKMaster_9000 UNIQUEIDENTIFIER NULL
END

--- 10/06/2020 - Tấn Thành: Bổ sung cột DeleteFlg
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2011' AND col.name = 'DeleteFlg')
BEGIN
	ALTER TABLE BEMT2011 ADD DeleteFlg TINYINT DEFAULT (0) NULL
END

--- 19/06/2020 - Tấn Thành: Đổi tên Cột [DivsionID] thành  [DivisionID]
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2011' AND col.name = 'DivsionID')
BEGIN
	EXEC SP_RENAME 'BEMT2011.DivsionID', 'DivisionID', 'COLUMN';
END

--- 10/07/2020 - Tấn Thành: Thay đổi kiểu dữ liệu Destination
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2011' AND col.name = 'Destination')
BEGIN
	ALTER TABLE BEMT2011 ALTER COLUMN Destination NVARCHAR(MAX) NULL
END

--- 10/07/2020 - Tấn Thành: Thay đổi kiểu dữ liệu DestinationDetail
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2011' AND col.name = 'DestinationDetail')
BEGIN
	ALTER TABLE BEMT2011 ALTER COLUMN DestinationDetail NVARCHAR(MAX) NULL
END

--- 02/11/2020 - Vĩnh Tâm: Bổ sung cột OrderNo
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2011' AND col.name = 'OrderNo')
BEGIN
	ALTER TABLE BEMT2011 ADD OrderNo INT NULL
END
