-- <Summary>
---- 
-- <History>
---- Create on 04/08/2021 by Kiều Nga: Bảng phương án kinh doanh (Master)
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SOT2140]') AND type in (N'U'))
CREATE TABLE [dbo].[SOT2140](
	[APK] [uniqueidentifier] NOT NULL DEFAULT NEWID(),
	[DivisionID] [varchar](50) NOT NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[VoucherNo] [varchar](50) NULL,
	[VoucherDate] [datetime] NULL,
	[ObjectID] [nvarchar](50) NULL,
	[CuratorID] [nvarchar](50) NULL,
	[InvestorID] [nvarchar](50) NULL,
	[GeneralContractorID] [nvarchar](50) NULL,
	[ContractID] [nvarchar](50) NULL,
	[AppendixContractID] [nvarchar](50) NULL,
	[EmployeeID] [nvarchar](50) NULL,
	[ProjectManagementID] [nvarchar](50) NULL,
	[ClerkID] [nvarchar](50) NULL,
	[RevenueExcludingVAT] [decimal](28, 8) NULL,
	[Revenue] [decimal](28, 8) NULL,
	[TotalCostOfGoodsSold] [decimal](28, 8) NULL,
	[ProfitBeforeTax] [nvarchar](50) NULL,
	[ProfitMargin] [nvarchar](50) NULL,
	[Description] [nvarchar](250) NULL,
	[IsInheritTPQ] [tinyint] NULL, -- Check kế thừa Phiếu báo giá kĩ tuhật
	[IsInheritSale] [tinyint] NULL, -- Check kế thừa Phiếu báo giá Sale
	[Status] [Tinyint] NULL DEFAULT (0),
	[APKMaster_9000] [varchar](50) NULL,
	[DeleteFlag] [int] NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [varchar](50) NULL,
	[LastModifyUserID] [varchar](50) NULL,
	[LastModifyDate] [datetime] NULL
	
 CONSTRAINT [PK_SOT2140] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

