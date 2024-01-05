---- Create by Khâu Vĩnh Tâm on 6/14/2019 4:03:12 PM
---- Chi tiết khai báo định mức dự án

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT2141]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT2141]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER NULL,
  [CostGroup] VARCHAR(50) NULL,
  [CostGroupDetail] VARCHAR(50) NULL,
  [Money] DECIMAL(28,8) NULL,
  [AnaDepartmentID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [Disabled] TINYINT DEFAULT 0 NULL
CONSTRAINT [PK_OOT2141] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-------------------- 23/07/2019 - Vĩnh Tâm: Bổ sung cột APKMaster_9000, DeleteFlg --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2141' AND col.name = 'APKMaster_9000')
BEGIN
	ALTER TABLE OOT2141 ADD APKMaster_9000 UNIQUEIDENTIFIER NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2141' AND col.name = 'DeleteFlg')
BEGIN
	ALTER TABLE OOT2141 ADD DeleteFlg TINYINT DEFAULT 0
END

-------------------- 19/08/2019 - Đình Ly: Bổ sung cột ApproveLevel, ApprovingLevel, DivisionID, Status --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2141' AND col.name = 'ApproveLevel')
BEGIN
	ALTER TABLE OOT2141 ADD ApproveLevel TINYINT DEFAULT 0
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2141' AND col.name = 'ApprovingLevel')
BEGIN
	ALTER TABLE OOT2141 ADD ApprovingLevel TINYINT DEFAULT 0
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2141' AND col.name = 'DivisionID')
BEGIN
	ALTER TABLE OOT2141 ADD DivisionID varchar(50)
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2141' AND col.name = 'Status')
BEGIN
	ALTER TABLE OOT2141 ADD Status TINYINT DEFAULT 0
END
-------------------- 24/10/2019 - Đình Ly: Bổ sung cột ActualMoney --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2141' AND col.name = 'ActualMoney')
BEGIN
	ALTER TABLE OOT2141 ADD ActualMoney DECIMAL(28,8) NULL
END