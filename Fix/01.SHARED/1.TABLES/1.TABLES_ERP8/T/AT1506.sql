-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Quốc Cường
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT1506]') AND type in (N'U'))
CREATE TABLE [dbo].[AT1506](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[RevaluateID] [nvarchar](50) NOT NULL,
	[Tranmonth] [int] NULL,
	[Tranyear] [int] NULL,
	[AssetID] [nvarchar](50) NOT NULL,
	[AssetName] [nvarchar](250) NULL,
	[RevaluateNo] [nvarchar](50) NULL,
	[RevaluateDate] [datetime] NULL,
	[Revaluator] [nvarchar](100) NULL,
	[Description] [nvarchar](250) NULL,
	[OriginalOldAmount] [decimal](28, 8) NULL,
	[ConvertedOldAmount] [decimal](28, 8) NULL,
	[DepOldPeriods] [int] NULL,
	[DepOldAmount] [decimal](28, 8) NULL,
	[OldDepartmentID] [nvarchar](50) NULL,
	[DepreciatedPeriods] [int] NULL,
	[AccuDepAmount] [decimal](28, 8) NULL,
	[DepNewPeriods] [decimal](28, 8) NULL,
	[OriginalNewAmount] [decimal](28, 8) NULL,
	[ConvertedNewAmount] [decimal](28, 8) NULL,
	[DepNewAmount] [decimal](28, 8) NULL,
	[DepNewPercent] [decimal](28, 8) NULL,
	[ResidualOldValue] [decimal](28, 8) NULL,
	[ResidualNewValue] [decimal](28, 8) NULL,
	[AccruedDepNewAmount] [decimal](28, 8) NULL,
	[NewMethodID] [int] NULL,
	[IsChange] [int] NULL,
	[AssetStatus] [int] NULL,
	[NewDepartmentID] [nvarchar](50) NULL,
	[NewEmployeeID] [nvarchar](50) NULL,
	[IsRevaluate] [int] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[Status] [tinyint] NULL,
	CONSTRAINT [PK_AT1506] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


--- Modify by Phương Thảo on 10/03/2016 : Bổ sung check kế thừa bút toán chi phí từ Module T
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1506' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1506' AND col.name = 'IsInheritFACost')
        ALTER TABLE AT1506 ADD IsInheritFACost TINYINT NULL
    END