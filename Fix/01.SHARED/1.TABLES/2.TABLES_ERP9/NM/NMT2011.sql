---- Create by Tra Giang on 16/08/2018 
---- Nghiệp Vụ: Thực đơn ngày( detail: thông tin bữa ăn


IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[NMT2011]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[NMT2011]
(
   [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
   [APKMaster] UNIQUEIDENTIFIER NOT NULL,
   [DivisionID] VARCHAR(50) NULL,
   [MenuDate] DATETIME NULL, 
   [DishID] NVARCHAR(500) NULL,   
   [MealID] NVARCHAR(250) NULL,   
   [DeleteFlg] TINYINT DEFAULT 0 NULL ,
   [CreateUserID] VARCHAR(50) NULL,
   [CreateDate] DATETIME NULL,
   [LastModifyUserID] VARCHAR(50) NULL,
   [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_NMT2011] PRIMARY KEY CLUSTERED
(
  [APK] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END


------Modified by Hồng Thảo on 4/9/2019: Bổ sung  GradeID,FromDate,ToDate, Bỏ các cột bắt buộc nhập 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'NMT2011' AND xtype = 'U')
BEGIN 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'NMT2011' AND col.name = 'MenuDate') 
   ALTER TABLE NMT2011 ADD MenuDate DATETIME NULL

   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'NMT2011' AND col.name = 'DishID') 
   ALTER TABLE NMT2011 ALTER COLUMN DishID NVARCHAR(500) NULL 

   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'NMT2011' AND col.name = 'MealID') 
   ALTER TABLE NMT2011 ALTER COLUMN MealID NVARCHAR(250) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'NMT2011' AND col.name = 'Orders') 
   ALTER TABLE NMT2011 ADD Orders VARCHAR(50) NULL 




END 

 




  