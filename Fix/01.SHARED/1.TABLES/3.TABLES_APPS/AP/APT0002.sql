---- Create by Đặng Thị Tiểu Mai on 30/03/2016 3:09:41 PM
--- Updated by Tấn Phú on 04/05/2019: Add column InsertDate
---- Tọa độ Sales man

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[APT0002]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[APT0002]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] NVARCHAR(50) NULL,
      [UserID] NVARCHAR(50) NULL,
      [Longitude] DECIMAL(28,8) NULL,
      [Latitude] DECIMAL(28,8) NULL,
      [Address] NVARCHAR(250) NULL,
      [DateTime] DATETIME NULL
    CONSTRAINT [PK_APT0002] PRIMARY KEY CLUSTERED
      (
      [APK]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END
---- Alter Columns
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='APT0002' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='APT0002' AND col.name='InsertDate')
	ALTER TABLE APT0002 ADD [InsertDate] DATETIME NULL
END	

-- Bổ sung constraint mặc định ngày tạo là getdate
IF EXISTS(SELECT * FROM SYS.OBJECTS WHERE TYPE_DESC = 'DEFAULT_CONSTRAINT' AND NAME = 'DF_InsertDate')
BEGIN
	ALTER TABLE dbo.APT0002 DROP CONSTRAINT DF_InsertDate
	ALTER TABLE dbo.APT0002 ADD CONSTRAINT DF_InsertDate DEFAULT GETDATE() FOR [InsertDate]
END


