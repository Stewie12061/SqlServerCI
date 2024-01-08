---- Create by Hồng Thảo on 22/7/2019
---- Nghiệp vụ Quyết toán học detail
 

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT2082]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE  [dbo].[EDMT2082]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [APKMaster] VARCHAR(50) NULL,
  [ReceiptTypeID] VARCHAR(50) NULL,
  [Amount] DECIMAL (28,8) NULL,
  [AnaID] VARCHAR(50)  NULL

CONSTRAINT [PK_EDMT2082] PRIMARY KEY CLUSTERED
(
  [APK],
  [DivisionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END




------Modified by Hồng Thảo on 25/7/2019: Bổ sung cột đơn giá loại hình thu 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2082' AND xtype = 'U')
BEGIN 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2082' AND col.name = 'Price') 
   ALTER TABLE EDMT2082 ADD Price DECIMAL(28,8) NULL


END 


------Modified by Hồng Thảo on 19/2/2020: Bổ sung cột lưu StudentID 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2082' AND xtype = 'U')
BEGIN 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2082' AND col.name = 'StudentID') 
   ALTER TABLE EDMT2082 ADD StudentID VARCHAR(50) NULL
   

END 

