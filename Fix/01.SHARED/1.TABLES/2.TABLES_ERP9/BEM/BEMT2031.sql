---- Create by Mai Trọng Kiên on 5/28/2020 2:53:20 PM
---- Phiếu ghi thời gian công tác (Details)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[BEMT2031]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[BEMT2031]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER NULL,
  [DivsionID] VARCHAR(50) NULL,
  [Destination] NVARCHAR(250) NULL,
  [FromDate] DateTime NULL,
  [ToDate] DateTime NULL,
  [WorkContent] NVARCHAR(MAX) NULL,
  [PartnerCompanies] NVARCHAR(MAX) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_BEMT2031] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---------------- 18/06/2020 - Trọng Kiên: Bổ sung cột StartDate ----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2031' AND col.name = 'FromDate')
BEGIN
	EXEC SP_RENAME 'BEMT2031."FromDate"', 'StartDate', 'COLUMN'
END

---------------- 18/06/2020 - Trọng Kiên: Bổ sung cột EndDate ----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2031' AND col.name = 'ToDate')
BEGIN
	EXEC SP_RENAME 'BEMT2031."ToDate"', 'EndDate', 'COLUMN'
END

---------------- 18/06/2020 - Trọng Kiên: Bổ sung cột CompanyName ----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2031' AND col.name = 'PartnerCompanies')
BEGIN
	EXEC SP_RENAME 'BEMT2031."PartnerCompanies"', 'CompanyName', 'COLUMN'
END

---------------- 18/06/2020 - Trọng Kiên: Đổi tên cột DivsionID ----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2031' AND col.name = 'DivsionID')
BEGIN
	EXEC SP_RENAME 'BEMT2031."DivsionID"', 'DivisionID', 'COLUMN'
END

--- 01/07/2020 - Trọng Kiên: Bổ sung cột DeleteFlg
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2031' AND col.name = 'DeleteFlg')
BEGIN
	ALTER TABLE BEMT2031 ADD DeleteFlg  TINYINT DEFAULT 0 NULL
END

--- 02/11/2020 - Vĩnh Tâm: Bổ sung cột OrderNo
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2031' AND col.name = 'OrderNo')
BEGIN
	ALTER TABLE BEMT2031 ADD OrderNo INT NULL
END