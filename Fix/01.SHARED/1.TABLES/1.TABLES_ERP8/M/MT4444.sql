﻿-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Mỹ Tuyền
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MT4444]') AND type in (N'U'))
CREATE TABLE [dbo].[MT4444](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[ResultTypeID] [nvarchar](50) NULL,
	[ProductID] [nvarchar](50) NULL,
	[InventoryTypeID] [nvarchar](50) NULL,
	[UnitID] [nvarchar](50) NULL,
	[ProductQuantity] [decimal](28, 8) NULL,
	[PerfectRate] [decimal](28, 8) NULL,
	[MaterialRate] [decimal](28, 8) NULL,
	[HumanResourceRate] [decimal](28, 8) NULL,
	[OthersRate] [decimal](28, 8) NULL,
	CONSTRAINT [PK_MT4444] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
