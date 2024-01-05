-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Mỹ Tuyền
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MT2102]') AND type in (N'U'))
CREATE TABLE [dbo].[MT2102](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[EDetailID] [nvarchar](50) NOT NULL,
	[EstimateID] [nvarchar](50) NOT NULL,
	[TranMonth] [int] NOT NULL,
	[TranYear] [int] NOT NULL,
	[ProductID] [nvarchar](50) NULL,
	[ApportionID] [nvarchar](50) NULL,
	[ProductQuantity] [decimal](28, 8) NULL,
	[PDescription] [nvarchar](250) NULL,
	[LinkNo] [nvarchar](50) NULL,
	[UnitID] [nvarchar](50) NULL,
	[Orders] [int] NULL,
 CONSTRAINT [PK_MT2102] PRIMARY KEY NONCLUSTERED 
(
	[EDetailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


--- Modified by Hải Long on 05/08/2017: Bổ sung trường ConvertedProductQuantity
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'MT2102' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'MT2102' AND col.name = 'ConvertedProductQuantity')
        ALTER TABLE MT2102 ADD ConvertedProductQuantity DECIMAL(28,8) NULL
    END	
    