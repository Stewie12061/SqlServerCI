---- Create by Nguyễn Thị Minh Hòa on 21/02/2019 2:29:31 PM
---- Nghiệp vụ Kết quả học tập. lưu thông tin Tình trạng của các bữa ăn
---- Select * from EDMT2051


IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT2051]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[EDMT2051]
(
	[APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
	[APKMaster] UNIQUEIDENTIFIER NOT NULL,
	[DivisionID] VARCHAR(50) NOT NULL,
	[MealID] VARCHAR(50) NULL,
	[DishID] VARCHAR(50) NULL,
	[StatusID] VARCHAR(50) NULL,
	[CreateUserID] VARCHAR(50) NULL,
	[CreateDate] DATETIME NULL,
	[LastModifyUserID] VARCHAR(50) NULL,
	[LastModifyDate] DATETIME NULL,
	[DeleteFlg] TINYINT DEFAULT(0) NULL

CONSTRAINT [PK_EDMT2051] PRIMARY KEY CLUSTERED
(
  [APK]
)
) ON [PRIMARY]

END
GO




------Modified by Hồng Thảo on 4/9/2019: Đổi kiểu dữ liệu 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2051' AND xtype = 'U')
BEGIN 

   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2051' AND col.name = 'DishID') 
   ALTER TABLE EDMT2051 ALTER COLUMN DishID NVARCHAR(500) NULL 

   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2051' AND col.name = 'MealID') 
   ALTER TABLE EDMT2051 ALTER COLUMN MealID NVARCHAR(250) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2051' AND col.name = 'Orders') 
   ALTER TABLE EDMT2051 ADD Orders VARCHAR(50) NULL 


END 



 
 