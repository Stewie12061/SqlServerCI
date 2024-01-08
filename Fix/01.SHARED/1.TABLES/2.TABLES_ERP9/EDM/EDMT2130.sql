---- Create by Hồng Thảo on 08/10/2018
---- Tạo đăng ký dịch vụ master 

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT2130]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[EDMT2130]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [VoucherNo] VARCHAR(50) NOT NULL, 
  [ReceiptTypeID] VARCHAR(50) NULL,
  [ExtracurricularActivity] NVARCHAR(250) NULL,
  [Cost] DECIMAL(28,8) NULL, 
  [DateSchedule] DATETIME NULL,
  [Place] NVARCHAR(250) NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_EDMT2130] PRIMARY KEY CLUSTERED
(
  [APK],
  [DivisionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END


------Modified by Hồng Thảo on 24/01/2019: Bổ sung năm học, TranMonth,TranYear, loại dịch vụ, loại hoạt động, mã hoạt hoạt động, diễn giải 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2130' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2130' AND col.name = 'TranMonth') 
   ALTER TABLE EDMT2130 ADD TranMonth INT NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2130' AND col.name = 'TranYear') 
   ALTER TABLE EDMT2130 ADD TranYear INT NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2130' AND col.name = 'ServiceTypeID') 
   ALTER TABLE EDMT2130 ADD ServiceTypeID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2130' AND col.name = 'ActivityTypeID') 
   ALTER TABLE EDMT2130 ADD ActivityTypeID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2130' AND col.name = 'ActivityID') 
   ALTER TABLE EDMT2130 ADD ActivityID VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2130' AND col.name = 'SchoolYearID') 
   ALTER TABLE EDMT2130 ADD SchoolYearID VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2130' AND col.name = 'Description') 
   ALTER TABLE EDMT2130 ADD Description NVARCHAR(MAX) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2130' AND col.name = 'AnaID') 
   ALTER TABLE EDMT2130 ADD AnaID VARCHAR(50) NULL
 
END 


------Modified by Hồng Thảo on 16/5/2019: chuyển đổi kiểu dữ liệu Description
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2130' AND xtype = 'U')
BEGIN 
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2130' AND col.name = 'Description') 
   ALTER TABLE EDMT2130 ALTER COLUMN  Description NVARCHAR(MAX) NULL 


END 




------Modified by Hồng Thảo on 6/1/2020: Bổ sung cột từ ngày đến ngày, tháng 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2130' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2130' AND col.name = 'FromDate') 
   ALTER TABLE EDMT2130 ADD  FromDate DATETIME NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2130' AND col.name = 'ToDate') 
   ALTER TABLE EDMT2130 ADD  ToDate DATETIME NULL 


END 

 



