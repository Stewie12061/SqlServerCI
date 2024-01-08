-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Tố Oanh
---- Modified by Tiểu Mai on 14/01/2016: Bổ sung 20 cột quy cách sản phẩm (PSxxID).
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MT1614]') AND type in (N'U'))
CREATE TABLE [dbo].[MT1614](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[PeriodID] [nvarchar](50) NOT NULL,
	[ProductID] [nvarchar](50) NULL,
	[Cost] [decimal](28, 8) NULL,
	[CostUnit] [decimal](28, 8) NULL,
	[ProductQuantity] [decimal](28, 8) NULL,
	[EmployeeID] [nvarchar](50) NULL,
	[VoucherDate] [datetime] NULL,
	[VoucherID] [nvarchar](50) NOT NULL,
	[VoucherNo] [nvarchar](50) NULL,
	[TransactionID] [nvarchar](50) NOT NULL,
	[LastModifyDate] [datetime] NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[VoucherTypeID] [nvarchar](50) NULL,
	[Cost621] [decimal](28, 8) NULL,
	[Cost622] [decimal](28, 8) NULL,
	[Cost627] [decimal](28, 8) NULL,
	[BeginningInprocessCost] [decimal](28, 8) NULL,
	[AriseCost] [decimal](28, 8) NULL,
	[EndInprocessCost] [decimal](28, 8) NULL,
	[Description] [nvarchar](250) NULL,
 CONSTRAINT [PK_MT1614] PRIMARY KEY NONCLUSTERED 
(
	[VoucherID] ASC,
	[TransactionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'MT1614' AND col.name = 'PS01ID')
        ALTER TABLE MT1614 ADD	PS01ID NVARCHAR(50) NULL,
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
								PS20ID NVARCHAR(50) NULL

