-- <Summary>
---- 
-- <History>
---- Create on 28/04/2021 by Đình Hòa: Bảng chi phí (Detail)
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SOT2114]') AND type in (N'U'))
CREATE TABLE [dbo].[SOT2114](
	[APK] [uniqueidentifier] NOT NULL DEFAULT NEWID(),
	[DivisionID] [varchar](50) NOT NULL,
	[APKMaster] [uniqueidentifier] NOT NULL,
	[TypeOfCost] [varchar](50) NULL,
	[CostID] [varchar](50) NULL,
	[Percentage] [decimal](28, 8) NULL,
	[PriceCost] [decimal](28, 8) NULL,
	[AmountCost] [decimal](28, 8) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [varchar](50) NULL,
	[LastModifyUserID] [varchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[DeleteFlag] [int] NULL
	
 CONSTRAINT [PK_SOT2114] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2114' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2114' AND col.name = 'QuantityCost')
	BEGIN
    ALTER TABLE SOT2114 ADD QuantityCost decimal(28,8) NULL
	END
END