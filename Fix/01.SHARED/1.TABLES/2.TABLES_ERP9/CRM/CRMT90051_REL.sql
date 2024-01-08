--- Create by Cao Thị Phượng on 3/4/2017 8:32:06 AM
---- Sự kiện và đối tượng liên quan

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CRMT90051_REL]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CRMT90051_REL]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [EventID] INT NOT NULL,
  [RelatedToTypeID_REL] INT NOT NULL,
  [RelatedToID] Varchar(50) NOT NULL
CONSTRAINT [PK_CRMT90051_REL] PRIMARY KEY CLUSTERED
(
  [EventID],
  [RelatedToID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---Modified by Thị Phượng on 21/04/2017 Bổ sung lưu tên và mã khi chọn đối tượng liên quan
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT90051_REL' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT90051_REL' AND col.name = 'ObjectID') 
   ALTER TABLE CRMT90051_REL ADD ObjectID VARCHAR(50) NULL 
END
--- 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT90051_REL' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT90051_REL' AND col.name = 'ObjectName') 
   ALTER TABLE CRMT90051_REL ADD ObjectName NVARCHAR(250) NULL 
END
