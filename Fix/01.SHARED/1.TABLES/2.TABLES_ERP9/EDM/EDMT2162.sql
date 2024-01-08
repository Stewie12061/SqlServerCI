--- Create by Hồng Thảo on 17/10/2018
---- Tạo dự thu học phí detail khoản thu 
IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT2162]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[EDMT2162]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [APKMaster] VARCHAR(50) NOT NULL,
  [ReceiptTypeID] VARCHAR(50) NULL,
  [Amount] DECIMAL(28,8) NULL,
  [CreateUserID] VARCHAR (50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR (50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_EDMT2162] PRIMARY KEY CLUSTERED
(
  [APK],
  [DivisionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END




------Modified by Hồng Thảo on 23/01/2019: Bổ sung MPT doanh thu 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2162' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2162' AND col.name = 'AnaID') 
   ALTER TABLE EDMT2162 ADD AnaID VARCHAR(50) NULL 
END 





------Modified by Hồng Thảo on 17/1/2020: Bổ sung cột kế thừa master, detail từ nghiệp vụ đăng ký dịch vụ  
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2162' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2162' AND col.name = 'InheritVoucherID') 
   ALTER TABLE EDMT2162 ADD InheritVoucherID VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2162' AND col.name = 'InheritTransactionID') 
   ALTER TABLE EDMT2162 ADD InheritTransactionID VARCHAR(50) NULL


END 

------Modified by Hồng Thảo on 3/2/2020: Bổ sung cột DeleteFlg, cột kế thừa xuống phiếu thu 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2162' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2162' AND col.name = 'DeleteFlg') 
   ALTER TABLE EDMT2162 ADD DeleteFlg TINYINT DEFAULT (0) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab  ----cột kế thừa xuống 8  
   ON col.id = tab.id WHERE tab.name = 'EDMT2162' AND col.name = 'IsInherit') 
   ALTER TABLE EDMT2162 ADD IsInherit TINYINT DEFAULT (0) NULL

END 