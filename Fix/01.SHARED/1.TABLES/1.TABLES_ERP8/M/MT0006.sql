
-- <Summary>
---- Bảng master nguyên liệu thay thế
-- <History>
---- Create on 11/10/2010 by Thanh Trẫm
---- Modified on ... by ...
---- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MT0006]') AND type in (N'U'))
CREATE TABLE [dbo].[MT0006](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[MaterialGroupID] [nvarchar](50) NOT NULL,
	[GroupName] [nvarchar](250) NULL,
	[Disabled] [tinyint] NOT NULL,
	[InventoryTypeID] [nvarchar](50) NULL,
	[MaterialID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
 CONSTRAINT [PK_MT0006] PRIMARY KEY CLUSTERED 
(
	[MaterialGroupID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

---------------- 27/12/2020 - Đình Ly: Bổ sung cột IsCommon ----------------

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'MT0006' AND col.name = 'IsCommon')
BEGIN
	ALTER TABLE MT0006 ADD IsCommon TINYINT NULL
END

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'MT0006' AND col.name = 'MaterialName')
BEGIN
	ALTER TABLE MT0006 ADD MaterialName NVARCHAR(500) NULL
END
