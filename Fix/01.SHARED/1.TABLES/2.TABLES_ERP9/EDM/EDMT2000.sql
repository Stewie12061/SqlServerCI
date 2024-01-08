---- Create by Nguyễn Thị Minh Hòa on 23/9/2018 6:29:31 PM
---- Nghiệp vụ Phiếu thông tin tư vấn
---- Select * from EDMT2000

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT2000]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[EDMT2000]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [VoucherNo] VARCHAR(50) NOT NULL,
  [VoucherDate] DATETIME NULL,
  [IsInheritClue] TINYINT,
  [ParentID] VARCHAR(50) NULL,
  [ParentName] NVARCHAR(250) NOT NULL,
  [ParentDateBirth]  DATETIME NULL,
  [Telephone] VARCHAR(50)  NULL,
  [Address] NVARCHAR (250) NULL,
  [Email] VARCHAR(50)  NULL,
  [StudentName] NVARCHAR(250) NOT NULL,
  [StudentDateBirth]  DATETIME NULL,
  [Sex] TINYINT ,
  [ResultID] VARCHAR (50) NOT NULL,
  [DateFrom] DATETIME NULL,
  [DateTo] DATETIME NULL,
  [Status] VARCHAR(50) NULL,
  [Amount] DECIMAL(28,8) NULL,
  [Information] NVARCHAR(250) NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NOT NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_EDMT2000] PRIMARY KEY CLUSTERED
(
  [APK],
  [DivisionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END




------Modified by Hồng Thảo on 6/4/2019: Bổ sung cột mã học sinh, xưng hô, phân loại cho đối tượng và học sinh để sinh tự đông 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2000' AND col.name = 'StudentID') 
   ALTER TABLE EDMT2000 ADD StudentID VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2000' AND col.name = 'Prefix') 
   ALTER TABLE EDMT2000 ADD Prefix VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2000' AND col.name = 'SType01ID') 
   ALTER TABLE EDMT2000 ADD SType01ID VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2000' AND col.name = 'SType02ID') 
   ALTER TABLE EDMT2000 ADD SType02ID VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2000' AND col.name = 'SType03ID') 
   ALTER TABLE EDMT2000 ADD SType03ID VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2000' AND col.name = 'SType01IDS') 
   ALTER TABLE EDMT2000 ADD SType01IDS VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2000' AND col.name = 'SType02IDS') 
   ALTER TABLE EDMT2000 ADD SType02IDS VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2000' AND col.name = 'SType03IDS') 
   ALTER TABLE EDMT2000 ADD SType03IDS VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2000' AND col.name = 'OldCustomer') 
   ALTER TABLE EDMT2000 ADD OldCustomer TINYINT NULL

   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2000' AND col.name = 'ParentID') 
   ALTER TABLE EDMT2000 ALTER COLUMN ParentID VARCHAR(50) NULL 



END 


---- Modified by Hồng Thảo on 29/8/2019: Tăng kiểu dữ liệu lưu email 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2000' AND xtype = 'U')
BEGIN 
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2000' AND col.name = 'Email') 
   ALTER TABLE EDMT2000 ALTER COLUMN Email NVARCHAR(250) NULL 

   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2000' AND col.name = 'Information') 
   ALTER TABLE EDMT2000 ALTER COLUMN Information NVARCHAR(500) NULL 


END



---- Modified by Hồng Thảo on 26/9/2019: Bổ sung trường lưu vết học viên được điều chuyển qua trường khác 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2000' AND col.name = 'InheritTranfer') 
   ALTER TABLE EDMT2000 ADD InheritTranfer VARCHAR(250) NULL 

 
END



---- Modified by Hồng Thảo on 01/10/2019: Bổ sung lưu vết trường APK của phiếu điều chuyển phục vụ nếu đã lập chuyển trường thì không load lên 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2000' AND col.name = 'APKTransfer') 
   ALTER TABLE EDMT2000 ADD APKTransfer VARCHAR(250) NULL 

 
END


---- Modified by Xuân Hiển on 27/12/2019: Bổ sung ngày nhập học, Biểu phí
----
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2000' AND xtype = 'U')
BEGIN 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2000' AND col.name = 'AdmissionDate') 
   ALTER TABLE EDMT2000 ADD AdmissionDate DATETIME NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2000' AND col.name = 'FeeID') 
   ALTER TABLE EDMT2000 ADD FeeID NVARCHAR(250) NULL 

END
 