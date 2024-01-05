---- Create by Hồng Thảo on 22/7/2019
---- Nghiệp vụ Quyết toán master 
 

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT2081]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE  [dbo].[EDMT2081]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [APKMaster] VARCHAR(50) NULL,
  [VoucherNo] VARCHAR(50) NULL,
  [VoucherDate] DATETIME NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
  
CONSTRAINT [PK_EDMT2081] PRIMARY KEY CLUSTERED
(
  [APK],
  [DivisionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END





------Modified by Hồng Thảo on 1/8/2019: Bổ sung cột ngày tiền ăn để tính tiền khi quyết toán
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2081' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2081' AND col.name = 'DatePayment') 
   ALTER TABLE EDMT2081 ADD DatePayment DATETIME NULL

END 




 



