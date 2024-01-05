---- Create by Cao Thị Phượng on 3/4/2017 8:28:57 AM
---- Danh mục sự kiện

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CRMT90051]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CRMT90051]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [EventID] INT Identity(1,1) NOT NULL,
  [EventSubject] NVARCHAR(250) NULL,
  [PriorityID] TINYINT DEFAULT (0) NULL,
  [Location] NVARCHAR(250) NULL,
  [EventStatus] TINYINT DEFAULT (0) NOT NULL,
  [EventStartDate] DATETIME NULL,
  [EventEndDate] DATETIME NULL,
  [Description] NVARCHAR(Max) NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [RelatedToTypeID] INT DEFAULT 8 NOT NULL
CONSTRAINT [PK_CRMT90051] PRIMARY KEY CLUSTERED
(
  [EventID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END
--Bổ sung trường DeleteFlg
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT90051' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT90051' AND col.name = 'DeleteFlg') 
   ALTER TABLE CRMT90051 ADD DeleteFlg TINYINT  DEFAULT (0) NULL 
END
--Loại hoạt động
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT90051' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT90051' AND col.name = 'TypeActive') 
   ALTER TABLE CRMT90051 ADD TypeActive TINYINT NULL 
END
--Người phụ trách (được gán)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT90051' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT90051' AND col.name = 'AssignedToUserID') 
   ALTER TABLE CRMT90051 ADD AssignedToUserID NVARCHAR(MAX) NULL 
END

---Modified by Thị Phượng, 21/04/2017 Phân loại sự kiện hay nhiệm vụ
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT90051' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT90051' AND col.name = 'TypeID') 
   ALTER TABLE CRMT90051 ADD TypeID TINYINT NULL 
END

---Modified by Hồng Thảo, 11/4/2019 bỏ not null cột EventSubject do bảng chuẩn màn hình không có cột này 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT90051' AND xtype = 'U')
BEGIN 
   IF  EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT90051' AND col.name = 'EventSubject') 
   ALTER TABLE CRMT90051 ALTER COLUMN EventSubject NVARCHAR(250) NULL
END