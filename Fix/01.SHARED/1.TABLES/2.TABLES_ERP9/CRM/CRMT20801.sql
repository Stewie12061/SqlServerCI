---- Create by HOANGVU on 3/13/2017 9:35:22 AM
---- Danh muc yêu cầu

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CRMT20801]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CRMT20801]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [RequestID] INT NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [RequestSubject] NVARCHAR(Max) NOT NULL,
  [RelatedToTypeID] INT NULL,
  [RequestStatus] INT NOT NULL,
  [PriorityID] INT NOT NULL,
  [TimeRequest] DATETIME NOT NULL,
  [DeadlineRequest] DATETIME NOT NULL,
  [AssignedToUserID] VARCHAR(50) NOT NULL,
  [FeedbackDescription] NVARCHAR(Max) NOT NULL,
  [RequestDescription] NVARCHAR(Max) NOT NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NOT NULL,
  [CreateDate] DATETIME NOT NULL,
  [CreateUserID] VARCHAR(50) NOT NULL,
  [LastModifyDate] DATETIME NOT NULL,
  [LastModifyUserID] VARCHAR(50) NOT NULL
CONSTRAINT [PK_CRMT20801] PRIMARY KEY CLUSTERED
(
  [RequestID],
  [DivisionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20801' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20801' AND col.name = 'RequestTypeID') 
   ALTER TABLE CRMT20801 ADD RequestTypeID INT NULL 
END

/*===============================================END RequestTypeID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20801' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20801' AND col.name = 'BugTypeID') 
   ALTER TABLE CRMT20801 ADD BugTypeID VARCHAR(250) NULL 
END

/*===============================================END BugTypeID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20801' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20801' AND col.name = 'ProjectID') 
   ALTER TABLE CRMT20801 ADD ProjectID VARCHAR(50) NULL 
END

/*===============================================END ProjectID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20801' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20801' AND col.name = 'DeadlineExpect') 
   ALTER TABLE CRMT20801 ADD DeadlineExpect DATETIME NULL 
END

/*===============================================END DeadlineExpect===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20801' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20801' AND col.name = 'CompleteDate') 
   ALTER TABLE CRMT20801 ADD CompleteDate DATETIME NULL 
END

/*===============================================END CompleteDate===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20801' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20801' AND col.name = 'DurationTime') 
   ALTER TABLE CRMT20801 ADD DurationTime DECIMAL(10,2) NULL 
END

/*===============================================END DurationTime===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20801' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20801' AND col.name = 'RealTime') 
   ALTER TABLE CRMT20801 ADD RealTime DECIMAL(10,2) NULL 
END

/*===============================================END RealTime===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20801' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20801' AND col.name = 'ProjectID') 
   ALTER TABLE CRMT20801 ADD ProjectID VARCHAR(50) NULL 
END

/*===============================================END ProjectID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20801' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20801' AND col.name = 'Status') 
   ALTER TABLE CRMT20801 ADD Status INT NULL 
END

/*===============================================END Status===============================================*/ 


----Modified by Hồng Thảo on 11/4/2019: Bổ sung cột KindID,SupportDictionaryID
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20801' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20801' AND col.name = 'SupportDictionaryID') 
   ALTER TABLE CRMT20801 ADD SupportDictionaryID varchar(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20801' AND col.name = 'KindID') 
   ALTER TABLE CRMT20801 ADD KindID varchar(50) NULL  
END

----Modified by Bảo Toàn on 04/07/2019: Bổ sung cột OpportunityID
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20801' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20801' AND col.name = 'OpportunityID') 
   ALTER TABLE CRMT20801 ADD OpportunityID varchar(25) NULL 
END
-- Modified by Bảo Toàn on 04/07/2019: chỉnh sửa lại khóa chinh cho APK
if not exists (SELECT  K.TABLE_NAME 
FROM    INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS C
        JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS K ON C.TABLE_NAME = K.TABLE_NAME
                                                         AND C.CONSTRAINT_CATALOG = K.CONSTRAINT_CATALOG
                                                         AND C.CONSTRAINT_SCHEMA = K.CONSTRAINT_SCHEMA
                                                         AND C.CONSTRAINT_NAME = K.CONSTRAINT_NAME
WHERE   C.CONSTRAINT_TYPE = 'PRIMARY KEY'
		and K.COLUMN_NAME = 'APK'
		and C.TABLE_NAME = 'CRMT20801')
BEGIN
	ALTER TABLE CRMT20801
	DROP CONSTRAINT PK_CRMT20801; 

	ALTER TABLE CRMT20801
	ADD CONSTRAINT PK_CRMT20801 PRIMARY KEY (APK); 
end 
----Modified by Bảo Toàn on 11/07/2019: Bổ sung cột FeedbackDescription
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20801' AND xtype = 'U')
BEGIN 
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20801' AND col.name = 'FeedbackDescription') 
   ALTER TABLE CRMT20801 ALTER COLUMN FeedbackDescription NVARCHAR(MAX) NULL 
END

-------------------- 17/12/2019 - Tấn Lộc: Bổ sung cột InventoryID, ContactID, TypeOfRequest, ReleaseVersion --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT20801' AND col.name = 'InventoryID')
BEGIN
	ALTER TABLE CRMT20801 ADD InventoryID VARCHAR(50) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT20801' AND col.name = 'ContactID')
BEGIN
	ALTER TABLE CRMT20801 ADD ContactID VARCHAR(50) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT20801' AND col.name = 'TypeOfRequest')
BEGIN
	ALTER TABLE CRMT20801 ADD TypeOfRequest VARCHAR(50) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT20801' AND col.name = 'ReleaseVersion')
BEGIN
	ALTER TABLE CRMT20801 ADD ReleaseVersion NVARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT20801' AND col.name = 'RequestCustomerID')
BEGIN
	ALTER TABLE CRMT20801 ADD RequestCustomerID NVARCHAR(250) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT20801' AND col.name = 'MilestoneID')
BEGIN
	ALTER TABLE CRMT20801 ADD MilestoneID VARCHAR(50) NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT20801' AND col.name = 'ReleaseID')
BEGIN
	ALTER TABLE CRMT20801 ADD ReleaseID VARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT20801' AND col.name = 'InventoryID')
BEGIN
	ALTER TABLE CRMT20801 ALTER COLUMN InventoryID VARCHAR(MAX) NULL
END