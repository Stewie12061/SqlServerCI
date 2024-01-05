-- <Summary>
---- 
-- <History>
---- Create on 12/10/2015 by Thanh Thịnh
--- Modified by Nhật Thanh on 23/03/2022: Sửa divisionID thành 50 kí tự
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OT1312]') AND type in (N'U'))
CREATE TABLE [dbo].[OT1312](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] nvarchar(50) NOT NULL,
	[DetailID] [nvarchar](50) NOT NULL,
	[ID] [nvarchar](50) NOT NULL,
	[PriceID] [nvarchar](50) NULL,
	[InventoryID] [nvarchar](50) NULL,	
	[Qtyfrom] [decimal](28,8) NULL,
	[QtyTo] [decimal](28,8) NULL,
	[UnitPrice] [decimal](28, 8) NULL,
	[ConvertedUnitPrice] [decimal](28, 8) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL
 CONSTRAINT [PK_OT1312] PRIMARY KEY CLUSTERED 
(
	[DetailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


--- Modified by Nhật Thanh on 23/03/2022: Sửa divisionID thành 50 kí tự
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT1312' AND xtype = 'U')
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'OT1312' AND col.name = 'DivisionID')
    ALTER TABLE OT1312 ALTER COLUMN DivisionID NVARCHAR(50) NOT NULL
END  