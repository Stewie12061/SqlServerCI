-- <Summary>
---- 
-- <History>
---- Create on 29/11/2023 by Hoàng Long
---- <Example>

--DROP TABLE [SOT2200]
--sp [SOT2200]

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SOT2200]') AND type in (N'U'))
CREATE TABLE [SOT2200](
	[APK] [uniqueidentifier] NOT NULL DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[TranMonth] [INT] NULL,
    [TranYear] [INT] NULL,
	[AccountNo] [nvarchar](50) NULL,
	[AccountName] [nvarchar](50) NULL,
	[Tel] [nvarchar](10) NULL,
	[Type] [int] NULL DEFAULT 0 ,
	[AccountType] [int] NULL DEFAULT 0 ,
	[CCCD] [nvarchar](50) NULL,
	[BirthDay] [datetime] NULL,
	[Address] [nvarchar](500) NULL,
	[Province] [nvarchar](50) NULL,
	[District] [nvarchar](50) NULL,
	[MstNumber] [nvarchar](50) NULL,
	[AccountDate] [datetime] NULL,
	[Status] [int] NULL DEFAULT 0 ,
	[CompanyName] [nvarchar](50) NULL,
	[Representative] [nvarchar](50) NULL,
	[MstCompany] [nvarchar](50) NULL,
	[ApartmentCompany] [nvarchar](50) NULL,
	[RoadCompany] [nvarchar](50) NULL,
	[WardCompany] [nvarchar](50)  NULL,
	[DistrictCompany] [nvarchar](50) NULL,
	[ProvinceCompany] [nvarchar](50) NULL,
	[ApartmentShop] [nvarchar](50) NULL,
	[RoadShop] [nvarchar](50) NULL,
	[WardShop] [nvarchar](50) NULL,
	[DistrictShop] [nvarchar](50) NULL,
	[ProvinceShop] [nvarchar](50) NULL,
	[EmailShop] [nvarchar](50) NULL,
	[TypeStore] [nvarchar](50) NULL,
	[AreaStore] [nvarchar](50) NULL,
	[TotalRevenue] [nvarchar](50) NULL,
	[AirConditionerSales] [nvarchar](50) NULL,
	[CustomerClassification] [nvarchar](50) NULL,
	[FinancialCapacity] [nvarchar](50) NULL,
	[StrongSelling1] [nvarchar](50) NULL,
	[StrongSelling2] [nvarchar](50) NULL,
	[StrongSelling3] [nvarchar](50) NULL,
	[ImportSource1] [nvarchar](50) NULL,
	[ImportSource2] [nvarchar](50) NULL,
	[ImportSource3] [nvarchar](50) NULL,
	[SellGree] [nvarchar](50) NULL,
	[GreeDisplay] [nvarchar](50) NULL,
	[SellingCapacity] [nvarchar](50) NULL,
	[ClassificationCustomer] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [varchar](50) NULL,
	[LastModifyUserID] [varchar](50) NULL,
	[LastModifyDate] [datetime] NULL
 CONSTRAINT [PK_SOT2200] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
