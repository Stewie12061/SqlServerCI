-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Mỹ Tuyền
---- Modified by Tiểu Mai on 14/01/2016: Bổ sung 20 cột quy cách sản phẩm (PSxxID).
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MT4000]') AND type in (N'U'))
CREATE TABLE [dbo].[MT4000](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[DetailCostID] [nvarchar](50) NOT NULL,
	[PeriodID] [nvarchar](50) NOT NULL,
	[ProductID] [nvarchar](50) NOT NULL,
	[ExpenseID] [nvarchar](50) NULL,
	[MaterialTypeID] [nvarchar](50) NULL,
	[MaterialID] [nvarchar](50) NULL,
	[ProductUnitID] [nvarchar](50) NULL,
	[MaterialUnitID] [nvarchar](50) NULL,
	[ConvertedUnit] [decimal](28, 8) NULL,
	[QuantityUnit] [decimal](28, 8) NULL,
	[VoucherTypeID] [nvarchar](50) NULL,
	[VoucherNo] [nvarchar](50) NULL,
	[VoucherID] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[VoucherDate] [datetime] NULL,
	[Description] [nvarchar](250) NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[EmployeeID] [nvarchar](50) NULL,
 CONSTRAINT [PK_MT4000] PRIMARY KEY NONCLUSTERED 
(
	[DetailCostID] ASC,
	[VoucherID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'MT4000' AND col.name = 'PS01ID')
        ALTER TABLE MT4000 ADD	PS01ID NVARCHAR(50) NULL,
								PS02ID NVARCHAR(50) NULL,
								PS03ID NVARCHAR(50) NULL,
								PS04ID NVARCHAR(50) NULL,
								PS05ID NVARCHAR(50) NULL,
								PS06ID NVARCHAR(50) NULL,
								PS07ID NVARCHAR(50) NULL,
								PS08ID NVARCHAR(50) NULL,
								PS09ID NVARCHAR(50) NULL,
								PS10ID NVARCHAR(50) NULL,
								PS11ID NVARCHAR(50) NULL,
								PS12ID NVARCHAR(50) NULL,
								PS13ID NVARCHAR(50) NULL,
								PS14ID NVARCHAR(50) NULL,
								PS15ID NVARCHAR(50) NULL,
								PS16ID NVARCHAR(50) NULL,
								PS17ID NVARCHAR(50) NULL,
								PS18ID NVARCHAR(50) NULL,
								PS19ID NVARCHAR(50) NULL,
								PS20ID NVARCHAR(50) NULL,
								S01ID NVARCHAR(50) NULL,
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
