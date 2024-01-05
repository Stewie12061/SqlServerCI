-- <Summary>
---- Thông tin phụ kiện
-- <History>
---- Create on 24/08/2019 by Kiều Nga
---- Modified on 20/12/2021 by Nhựt Trường: Edit độ dài chuỗi DivisionID lên 50 ký tự.
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SOT2027]') AND type in (N'U'))
CREATE TABLE [dbo].[SOT2027](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[APKOT2102] [uniqueidentifier] NOT NULL,
	[APKOT2101] [uniqueidentifier] NOT NULL,
	[DivisionID] [varchar](3) NOT NULL,
	[InventoryID] [varchar](50) NOT NULL,
	[Quantity] [decimal](28, 8) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [varchar](50) NULL,
	[LastModifyUserID] [varchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[DeleteFlag] [int] NULL
 CONSTRAINT [PK_SOT2027] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

---- Modified on 20/12/2021 by Nhựt Trường: Edit độ dài chuỗi DivisionID lên 50 ký tự.
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'SOT2027' AND xtype = 'U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'SOT2027' AND col.name = 'DivisionID')
		ALTER TABLE SOT2027 ALTER COLUMN DivisionID VARCHAR(50) NOT NULL
	END
