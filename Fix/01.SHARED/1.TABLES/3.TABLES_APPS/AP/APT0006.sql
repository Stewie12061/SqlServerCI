---- Create by Cao Thị Phượng on 12/28/2017 9:42:56 AM
---- Bảng chứa hình ảnh check-in giao hàng (OKIA)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[APT0006]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[APT0006]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [APKMInherited] VARCHAR(50) NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [MemberID] VARCHAR(50) NOT NULL,
  [ImageID] XML NULL,
  [Orders] INT NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL
CONSTRAINT [PK_APT0006] PRIMARY KEY CLUSTERED
(
  [APK],
  [APKMInherited]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

------Modified by [CTV][Manh Nguyen] on [23/12/2019]: Bổ sung cột CheckInCount
If Exists (Select * From sysobjects Where name = 'APT0006' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'APT0006'  and col.name = 'CheckInCount')
ALTER TABLE dbo.APT0006 ADD CheckInCount BIGINT NULL
End 
GO