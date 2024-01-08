---- Create by Hồng Thảo on 14/09/2018
---- Tạo tổng khung chương trình chi tiết detail 

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT2112]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[EDMT2112]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [APKMaster] VARCHAR(50) NOT NULL,
  [FromDate] DATETIME NULL,
  [ToDate] DATETIME NULL,
  [Topic] NVARCHAR(250) NULL,
  [Description] NVARCHAR(250) NULL,
  [ActivityTypeID] VARCHAR(50) NULL,
  [ActivityID] VARCHAR(50) NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR (50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR (50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_EDMT2112] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

----Modify on 26/01/2019 by Hồng Thảo thêm cột TranMonth,TranYear
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2112' AND col.name = 'TranMonth') 
   ALTER TABLE EDMT2112 ADD TranMonth INT NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2112' AND col.name = 'TranYear') 
   ALTER TABLE EDMT2112 ADD TranYear INT NULL 

END 




