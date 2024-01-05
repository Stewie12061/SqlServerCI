---- Create by Cao Thị Phượng on 12/28/2017 9:45:25 AM
---- Bảng chứa tọa độ check-in giao hàng OKIA

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[APT0007]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[APT0007]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [APKMInherited] VARCHAR(50) NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [MemberID] VARCHAR(50) NOT NULL,
  [CheckinTime] DATETIME NULL,
  [CheckinLongitude] DECIMAL(28,8) NULL,
  [CheckinLatitude] DECIMAL(28,8) NULL,
  [CheckinAddress] NVARCHAR(500) NULL,
  [Notes] NTEXT NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL
CONSTRAINT [PK_APT0007] PRIMARY KEY CLUSTERED
(
  [APK],
  [APKMInherited]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0007' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'APT0007' AND col.name = 'Notes_CheckIn') 
   ALTER TABLE APT0007 ADD Notes_CheckIn NVARCHAR(250) NULL 
END
/*===============================================END Notes_CheckIn===============================================*/ 


IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'APT0007' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'APT0007' AND col.name = 'Notes_TransferMoney') 
   ALTER TABLE APT0007 ADD Notes_TransferMoney NVARCHAR(250) NULL 
END
/*===============================================END Notes_TransferMoney===============================================*/ 

------Modified by [Manh Nguyen] on [23/12/2019]: Bổ sung cột CheckInCount
If Exists (Select * From sysobjects Where name = 'APT0007' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'APT0007'  and col.name = 'CheckInCount')
ALTER TABLE dbo.APT0007 ADD CheckInCount BIGINT NULL
End 
GO

------Modified by [Manh Nguyen] on [24/02/2020]: Bổ sung cột Distance
If Exists (Select * From sysobjects Where name = 'APT0007' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'APT0007'  and col.name = 'Distance')
ALTER TABLE dbo.APT0007 ADD Distance DECIMAL(10, 2) NULL
End 
GO