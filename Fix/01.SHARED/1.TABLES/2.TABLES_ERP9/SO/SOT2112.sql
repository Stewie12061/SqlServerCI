-- <Summary>
---- 
-- <History>
---- Create on 28/04/2021 by Đình Hòa: Vật tư tiêu hao (Detail)
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SOT2112]') AND type in (N'U'))
CREATE TABLE [dbo].[SOT2112](
	[APK] [uniqueidentifier] NOT NULL DEFAULT NEWID(),
	[DivisionID] [varchar](50) NOT NULL,
	[APKMaster] [uniqueidentifier] NOT NULL,
	[NodeID] [varchar](250) NULL,
	[NodeName] [nvarchar](250) NULL,
	[Price] [decimal](28, 8) NULL,
	[Amount] [decimal](28, 8) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [varchar](50) NULL,
	[LastModifyUserID] [varchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[DeleteFlag] [int] NULL
	
 CONSTRAINT [PK_SOT2112] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2112' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2112' AND col.name = 'Quantity')
	BEGIN
    ALTER TABLE SOT2112 ADD Quantity decimal(28,8) NULL
	END
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2112' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2112' AND col.name = 'PercentageLoss')
	BEGIN
    ALTER TABLE SOT2112 ADD PercentageLoss decimal(28,8) NULL
	END
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2112' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2112' AND col.name = 'Density')
	BEGIN
    ALTER TABLE SOT2112 ADD Density decimal(28,8) NULL
	END
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2112' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2112' AND col.name = 'QuantityBOM')
	BEGIN
    ALTER TABLE SOT2112 ADD QuantityBOM decimal(28,8) NULL
	END
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2112' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2112' AND col.name = 'CategoryID')
	BEGIN
    ALTER TABLE SOT2112 ADD CategoryID NVARCHAR(250) NULL
	END
END

-- Đình Hoà [15/07/2021] : Bổ sung cột đơn vị(UnitID,UnitName), số thứ tự(OrderNo)
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2112' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2112' AND col.name = 'UnitID')
	BEGIN
    ALTER TABLE SOT2112 ADD UnitID VARCHAR(50) NULL
	END
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2112' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2112' AND col.name = 'OrderStd')
	BEGIN
    ALTER TABLE SOT2112 ADD OrderStd INT DEFAULT(0) NULL
	END
END

