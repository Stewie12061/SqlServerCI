---- Create by Mai Trọng Kiên on 6/3/2020 1:21:02 PM
---- Phiếu đề nghị công tác (Details)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[BEMT2021]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[BEMT2021]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER NULL,
  [Date] Date NULL,
  [Contents] NVARCHAR(MAX) NULL,
  [CurrencyID] VARCHAR(50) NULL,
  [Amount] DECIMAL(28,8) NULL,
  [FeeID] VARCHAR(50) NULL,
  [DepartmentAnaID] VARCHAR(50) NULL,
  [CostAnaID] VARCHAR(50) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_BEMT2021] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

--- 18/06/2020 - Trọng Kiên: Bổ sung cột DivisionID
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2021' AND col.name = 'DivisionID')
BEGIN
	ALTER TABLE BEMT2021 ADD DivisionID VARCHAR(50) NULL
END

--- 01/07/2020 - Trọng Kiên: Bổ sung cột DeleteFlg
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2021' AND col.name = 'DeleteFlg')
BEGIN
	ALTER TABLE BEMT2021 ADD DeleteFlg TINYINT DEFAULT 0 NULL
END

--- 01/07/2020 - Trọng Kiên: Bổ sung cột ExchangeRate
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2021' AND col.name = 'ExchangeRate')
BEGIN
	ALTER TABLE BEMT2021 ADD ExchangeRate  DECIMAL(28,8) NULL
END

--- 01/07/2020 - Trọng Kiên: Bổ sung cột ConvertedAmount
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2021' AND col.name = 'ConvertedAmount')
BEGIN
	ALTER TABLE BEMT2021 ADD ConvertedAmount DECIMAL(28,8) NULL
END

--- 18/07/2020 - Vĩnh Tâm: Bổ sung cột IsInherited
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'BEMT2021' AND col.name = 'IsInherited')
BEGIN
	ALTER TABLE BEMT2021 ADD IsInherited TINYINT DEFAULT 0 NULL
END

--- 02/11/2020 - Vĩnh Tâm: Bổ sung cột OrderNo
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab
	   ON col.id = tab.id WHERE tab.name = 'BEMT2021' AND col.name = 'OrderNo')
BEGIN
	ALTER TABLE BEMT2021 ADD OrderNo INT NULL
END
