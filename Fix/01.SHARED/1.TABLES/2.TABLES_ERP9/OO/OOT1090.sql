---- Create by Lê Hoàng on 12/10/2020 15:13:42 PM
---- Modified by Lê Hoàng on 19/10/2020 14:38:00 PM
---- Danh mục Thiết bị/Phòng họp

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT1090]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT1090](
	[APK] [uniqueidentifier] NOT NULL DEFAULT (NEWID()),
	[DivisionID] [nvarchar](50) NOT NULL,
	[DeviceID] [nvarchar](50) NOT NULL,
	[DeviceName] [nvarchar](250) NULL,
	[DeviceNameE] [nvarchar](250) NULL,
	[Disabled] [tinyint] NOT NULL DEFAULT ((0)),
	[AreaID] [nvarchar](50) NULL,
	[TypeID] [nvarchar](50) NULL,
	[IsCommon] [tinyint] NULL DEFAULT ((0)),
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL
 CONSTRAINT [PK_OOT1090] PRIMARY KEY CLUSTERED 
(
	[DeviceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END

----Modified on 19/10/2020 by Lê Hoàng: alter column TypeID, AreaID từ int sang varchar(50)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OOT1090' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OOT1090' AND col.name='AreaID')
		ALTER TABLE OOT1090 ALTER COLUMN AreaID VARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OOT1090' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OOT1090' AND col.name='TypeID')
		ALTER TABLE OOT1090 ALTER COLUMN TypeID VARCHAR(50) NULL
	END

