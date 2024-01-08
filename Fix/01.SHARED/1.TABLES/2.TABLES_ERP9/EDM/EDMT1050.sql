---- Create by Hồng Thảo on 23/08/2018
---- Danh mục loại hình thu 

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT1050]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[EDMT1050]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [ReceiptTypeID] VARCHAR(50) NOT NULL,
  [ReceiptTypeName] NVARCHAR(250) NULL,
  [IsCommon] TINYINT DEFAULT (0) NULL,
  [Disabled] TINYINT DEFAULT (0) NULL,	
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_EDMT1050] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [ReceiptTypeID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END


------Modified by Hồng Thảo on 12/02/2019: Bổ sung khoản thu và tài khoản 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT1050' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT1050' AND col.name = 'AnaRevenueID') 
   ALTER TABLE EDMT1050 ADD AnaRevenueID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT1050' AND col.name = 'AccountID') 
   ALTER TABLE EDMT1050 ADD AccountID VARCHAR(50) NULL

END 


------Modified by Hồng Thảo on 01/07/2019: Bổ sung tiền ăn/ngày, tiền ăn trưa/xế, tiền hoàn trả lại/ngày, tiền hoàn trả lại/trưa xế 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT1050' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT1050' AND col.name = 'IsMoney') 
   ALTER TABLE EDMT1050 ADD IsMoney TINYINT DEFAULT (0) NULL  

END 



------Modified by Xuân Hiển on 25/12/2019:Bổ sung combo loại phí,  
------  , textbox ghi chú, checkbox bắt buộc, checkbox bảo lưu, checkbox chuyển nhượng.
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT1050' AND xtype = 'U')
BEGIN 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT1050' AND col.name = 'TypeOfFee') 
   ALTER TABLE EDMT1050 ADD TypeOfFee VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT1050' AND col.name = 'Note') 
   ALTER TABLE EDMT1050 ADD Note NVARCHAR(250) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT1050' AND col.name = 'IsObligatory') 
   ALTER TABLE EDMT1050 ADD IsObligatory TINYINT DEFAULT (0) NULL  

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT1050' AND col.name = 'IsReserve') 
   ALTER TABLE EDMT1050 ADD IsReserve TINYINT DEFAULT (0) NULL  

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT1050' AND col.name = 'IsTransfer') 
   ALTER TABLE EDMT1050 ADD IsTransfer TINYINT DEFAULT (0) NULL  

END 








