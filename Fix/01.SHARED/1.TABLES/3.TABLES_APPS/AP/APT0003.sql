-- <Summary>
---- Bảng chứa dữ liệu check - in (APP - MOBILE)
-- <History>
---- Create on 09/06/2017 by Hải Long
---- Modified on
---- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[APT0003]') AND type in (N'U'))
CREATE TABLE [dbo].[APT0003](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[VisitID] [nvarchar](50) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,		
	[ObjectID] [nvarchar](50) NOT NULL,	
	[CheckinTime] DATETIME NULL,	
	[CheckinLongitude] [decimal](28, 8) NULL,
	[CheckinLatitude] [decimal](28, 8) NULL,
	[CheckinAddress] [nvarchar](500) NULL,		
	[CheckoutTime] DATETIME NULL,	
	[CheckoutLongitude] [decimal](28, 8) NULL,
	[CheckoutLatitude] [decimal](28, 8) NULL,
	[CheckoutAddress] [nvarchar](500) NULL,			
	[Notes] [nvarchar](MAX) NULL
 CONSTRAINT [PK_APT0003] PRIMARY KEY NONCLUSTERED 
(
	[DivisionID] ASC,	
	[VisitID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

---- Modified on 31/03/2022 by Nhựt Trường: Bổ sung cột FakeGPS
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='APT0003' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='APT0003' AND col.name='FakeGPS')
		ALTER TABLE APT0003 ADD FakeGPS tinyint NULL
	END