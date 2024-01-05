--- Create by Hồng Thảo on 08/10/2018
---- Tạo  detail đăng ký dịch vụ 

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT2131]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[EDMT2131]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [APKMaster] VARCHAR(50) NOT NULL,
  [StudentID] VARCHAR(50) NULL,
  [Notes] NVARCHAR(250) NULL,
  [PickupPlace] NVARCHAR(250) NULL,
  [ArrivedPlace]NVARCHAR(250) NULL,
  [RoundTrip] TINYINT NULL,
  [FromDate] DATETIME NULL,
  [ToDate] DATETIME NULL,
  [IsEat] TINYINT NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_EDMT2131] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

------Modified by Hồng Thảo on 19/02/2019: Bổ sung khối, lớp grid
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2131' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2131' AND col.name = 'GradeID') 
   ALTER TABLE EDMT2131 ADD GradeID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2131' AND col.name = 'ClassID') 
   ALTER TABLE EDMT2131 ADD ClassID VARCHAR(50) NULL 


END 

------Modified by Hồng Thảo on 1/6/2020: Bổ sung chi phí, Thành tiền khuyến mãi , thành tiền sau khuyến mãi, loại giữ trẻ 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2131' AND xtype = 'U')
BEGIN 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2131' AND col.name = 'TypeKeepID ') 
   ALTER TABLE EDMT2131 ADD TypeKeepID  VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2131' AND col.name = 'Cost') 
   ALTER TABLE EDMT2131 ADD Cost DECIMAL (28,8) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2131' AND col.name = 'AmountPromotion') 
   ALTER TABLE EDMT2131 ADD AmountPromotion DECIMAL (28,8) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2131' AND col.name = 'AmountTotalPromotion') 
   ALTER TABLE EDMT2131 ADD AmountTotalPromotion DECIMAL(28,8) NULL 



END 


------Modified by Hồng Thảo on 17/2/2020: Bổ sung cột mã phân tích số 4
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2131' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2131' AND col.name = 'AnaID') 
   ALTER TABLE EDMT2131 ADD AnaID VARCHAR(50) NULL 


END 


------Modified by Hồng Thảo on 18/2/2020: Bổ sung lưu mã đưa đón 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2131' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2131' AND col.name = 'ShuttleID') 
   ALTER TABLE EDMT2131 ADD ShuttleID VARCHAR(50) NULL 


END 



 
 

