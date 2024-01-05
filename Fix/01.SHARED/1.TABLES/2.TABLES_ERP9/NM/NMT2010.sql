---- Create by Tra Giang on 16/08/2018 
---- Nghiệp Vụ: Thực đơn Ngày( master)


IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[NMT2010]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[NMT2010]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [GradeID] VARCHAR(50) NULL,
  [FromDate] DATETIME NULL, 
  [ToDate] DATETIME NULL, 
  [DeleteFlg] TINYINT DEFAULT 0 NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_NMT2010] PRIMARY KEY CLUSTERED
(
  [APK] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END



------Modified by Hồng Thảo on 4/9/2019: Bổ sung  GradeID,FromDate,ToDate, Bỏ các cột bắt buộc nhập 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'NMT2010' AND xtype = 'U')
BEGIN 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'NMT2010' AND col.name = 'GradeID') 
   ALTER TABLE NMT2010 ADD GradeID VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'NMT2010' AND col.name = 'FromDate') 
   ALTER TABLE NMT2010 ADD FromDate DATETIME NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'NMT2010' AND col.name = 'ToDate') 
   ALTER TABLE NMT2010 ADD ToDate  DATETIME NULL

   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'NMT2010' AND col.name = 'MenuVoucherNo') 
   ALTER TABLE NMT2010 DROP COLUMN MenuVoucherNo 

   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'NMT2010' AND col.name = 'MenuVoucherDate') 
   ALTER TABLE NMT2010 DROP COLUMN MenuVoucherDate 

   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'NMT2010' AND col.name = 'TranMonth') 
   ALTER TABLE NMT2010 DROP COLUMN TranMonth 

   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'NMT2010' AND col.name = 'TranYear') 
   ALTER TABLE NMT2010 DROP COLUMN TranYear

    IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'NMT2010' AND col.name = 'VoucherNo') 
   ALTER TABLE NMT2010 DROP COLUMN VoucherNo

   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'NMT2010' AND col.name = 'Description') 
   ALTER TABLE NMT2010 DROP COLUMN [Description]

   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'NMT2010' AND col.name = 'MenuTypeID') 
   ALTER TABLE NMT2010 DROP COLUMN MenuTypeID



END 







  