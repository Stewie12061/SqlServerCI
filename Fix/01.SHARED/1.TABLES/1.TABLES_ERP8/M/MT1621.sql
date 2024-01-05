-- <Summary>
---- Master tình hình sản xuất (Bê Tông Long An)
-- <History>
---- Create on 15/08/2017 by Hải Long
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MT1621]') AND type in (N'U'))
CREATE TABLE [dbo].[MT1621](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[VoucherID] [nvarchar](50) NOT NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[VoucherDate] [datetime] NULL,	
	[ProductionDate] [datetime] NULL,		
	[VoucherNo] [nvarchar](50) NULL,
	[VoucherTypeID]	[nvarchar](50) NULL,
	[ShiftID] [nvarchar](50) NULL,	
	[EmployeeID] [nvarchar](50) NULL,		
	[RefNo01] [nvarchar](50) NULL,		
	[RefNo02] [nvarchar](50) NULL,			
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL
 CONSTRAINT [PK_MT1621] PRIMARY KEY NONCLUSTERED 
(
	[VoucherID] ASC,
	[DivisionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]