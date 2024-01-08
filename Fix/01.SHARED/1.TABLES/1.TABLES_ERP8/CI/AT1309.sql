-- <Summary>
---- 
-- <History>
---- Create on 10/08/2010 by Ngọc Nhựt
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT1309]') AND type in (N'U'))
CREATE TABLE [dbo].[AT1309](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] nvarchar(3) NOT NULL,
	[InventoryID] [nvarchar](50) NOT NULL,
	[UnitID] [nvarchar](50) NOT NULL,
	[ConversionFactor] [decimal](28, 8) NULL,
	[Disabled] [tinyint] NOT NULL,
	[Orders] [tinyint] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[Operator] [tinyint] NULL,
	[DataType] [tinyint] NOT NULL,
	[FormulaID] [nvarchar](50) NULL,
 CONSTRAINT [PK_AT1309] PRIMARY KEY NONCLUSTERED 
(
	[InventoryID] ASC,
	[UnitID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT1309_Disabled]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1309] ADD CONSTRAINT [DF_AT1309_Disabled] DEFAULT ((0)) FOR [Disabled]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__AT1309__Operator__6CDF4ED9]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1309] ADD CONSTRAINT [DF__AT1309__Operator__6CDF4ED9] DEFAULT ((0)) FOR [Operator]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__AT1309__DataType__076AF05B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1309] ADD CONSTRAINT [DF__AT1309__DataType__076AF05B] DEFAULT ((0)) FOR [DataType]
END
-- Tạo Column IsCommon by Thinh : 25/08/2015
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'AT1309' AND xtype = 'U') 
BEGIN
    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'AT1309' AND col.name = 'IsCommon')
    ALTER TABLE AT1309 ADD [IsCommon] [tinyint] NULL
END

DECLARE @CustomerName INT
SET @CustomerName = (SELECT TOP 1 CustomerName FROM CustomerIndex)

----- Modified by Tiểu Mai on 13/07/2016: Bổ sung 20 cột quy cách cho An Phát

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'AT1309' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT1309' AND col.name = 'S01ID')
	ALTER TABLE AT1309 ADD	S01ID NVARCHAR(50) NULL,
							S02ID NVARCHAR(50) NULL,
							S03ID NVARCHAR(50) NULL,
							S04ID NVARCHAR(50) NULL,
							S05ID NVARCHAR(50) NULL,
							S06ID NVARCHAR(50) NULL,
							S07ID NVARCHAR(50) NULL,
							S08ID NVARCHAR(50) NULL,
							S09ID NVARCHAR(50) NULL,
							S10ID NVARCHAR(50) NULL,
							S11ID NVARCHAR(50) NULL,
							S12ID NVARCHAR(50) NULL,
							S13ID NVARCHAR(50) NULL,
							S14ID NVARCHAR(50) NULL,
							S15ID NVARCHAR(50) NULL,
							S16ID NVARCHAR(50) NULL,
							S17ID NVARCHAR(50) NULL,
							S18ID NVARCHAR(50) NULL,
							S19ID NVARCHAR(50) NULL,
							S20ID NVARCHAR(50) NULL
								
END
IF @CustomerName = 54
BEGIN	
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'AT1309' AND col.name = 'APK')
    ALTER TABLE AT1309 ADD APK [uniqueidentifier] DEFAULT NEWID() NOT NULL
	
	IF EXISTS (SELECT TOP 1 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
				WHERE TABLE_NAME='AT1309')
	ALTER TABLE AT1309  
	DROP CONSTRAINT PK_AT1309
	
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'AT1309' AND xtype ='U') 
BEGIN
    ALTER TABLE AT1309
    ALTER COLUMN Orders INT NULL
END

