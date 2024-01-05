---- Create by Cao Thị Phượng on 12/8/2017 7:12:36 PM
---- Phiếu đề nghị chi (Detail)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[POST2021]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[POST2021]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [APKMaster] VARCHAR(50) NOT NULL,
  [InVoucherTypeID] VARCHAR(50) NOT NULL,
  [InVoucherDate] VARCHAR(50) NOT NULL,
  [InVoucherNo] VARCHAR(50) NOT NULL,
  [InMemberID] VARCHAR(50) NOT NULL,
  [Address] NVARCHAR(250) NULL,
  [Tel] NVARCHAR(100) NULL,
  [Amount] DECIMAL(28,8) NULL,
  [Notes] NVARCHAR(250) NULL,
  [Orders] int NULL,
  [APKMInherited] VARCHAR(50) NULL,
  [APKDInherited] VARCHAR(50) NULL
CONSTRAINT [PK_POST2021] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST2021' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST2021' AND col.name = 'DeleteFlg') 
   ALTER TABLE POST2021 ADD DeleteFlg TINYINT NULL 
END

--Sửa lại tên cột, khai báo sai tên cột
if  exists (select 1 from sys.columns where name = 'MeberID' and object_name(object_id) = 'POST2021') AND
not exists (select 1 from sys.columns where name = 'InMemberID' and object_name(object_id) = 'POST2021')
Begin
	EXEC sp_rename 'POST2021.MeberID', 'InMemberID', 'COLUMN';
End

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST2021' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST2021' AND col.name = 'Orders') 
   ALTER TABLE POST2021 ADD Orders INT NULL 
END
/*===============================================END Orders===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST2021' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'POST2021' AND col.name = 'DeleteFlg') 
   ALTER TABLE POST2021 ADD DeleteFlg TINYINT NULL 
END
/*===============================================END DeleteFlg===============================================*/ 