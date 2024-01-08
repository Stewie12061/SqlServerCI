---- Create by Hồng Thảo on 06/09/2018
---- Danh mục biểu phí detail 

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT1091]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[EDMT1091]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [APKMaster] VARCHAR(50) NOT NULL,
  [ReceiptTypeID] VARCHAR(50) NOT NULL,
  [FeeTypeID] NVARCHAR(250) NULL,
  [Amount] DECIMAL(28,8) NULL,
  [UnitID] VARCHAR(50) NULL
CONSTRAINT [PK_EDMT1091] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END


------Modified by Xuân Hiển on 27/12/2019:Thêm cột ngày, cột 1 tháng, cột 6 tháng
------, cột 9 tháng, cột năm, cột 1 chiều, cột 2 chiều.

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT1091' AND xtype = 'U')
BEGIN

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT1091' AND col.name = 'AmountOfDay') 
   ALTER TABLE EDMT1091 ADD AmountOfDay DECIMAL(28,8) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT1091' AND col.name = 'AmountOfOneMonth') 
   ALTER TABLE EDMT1091 ADD AmountOfOneMonth DECIMAL(28,8) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT1091' AND col.name = 'AmountOfSixMonth ') 
   ALTER TABLE EDMT1091 ADD AmountOfSixMonth  DECIMAL(28,8) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT1091' AND col.name = 'AmountOfNineMonth') 
   ALTER TABLE EDMT1091 ADD AmountOfNineMonth DECIMAL(28,8) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT1091' AND col.name = 'AmountOfYear') 
   ALTER TABLE EDMT1091 ADD AmountOfYear DECIMAL(28,8) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT1091' AND col.name = 'AmountOfOneWay') 
   ALTER TABLE EDMT1091 ADD AmountOfOneWay DECIMAL(28,8) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT1091' AND col.name = 'AmountOfTwoWay') 
   ALTER TABLE EDMT1091 ADD AmountOfTwoWay DECIMAL(28,8) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT1091' AND col.name = 'FeeType') 
   ALTER TABLE EDMT1091 ADD FeeType VARCHAR(50) NULL

END