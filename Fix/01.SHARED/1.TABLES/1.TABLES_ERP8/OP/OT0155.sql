-- <Summary>
---- 
-- <History>
---- Create on 02/03/2016 by Bảo Anh: kế hoạch mua hàng tổng hợp (Angel)
---- Modified on ... by ...

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OT0155]') AND type in (N'U'))
CREATE TABLE [dbo].[OT0155](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[VoucherID] [nvarchar](50) NOT NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[VoucherTypeID] [nvarchar](50) NULL,
	[VoucherNo] [nvarchar](50) NULL,
	[VoucherDate] [datetime] NULL,
	[Description] [nvarchar](250) NULL,
	[EmployeeID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
 CONSTRAINT [PK_OT0155] PRIMARY KEY NONCLUSTERED 
(
	[DivisionID] ASC,
	[VoucherID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]