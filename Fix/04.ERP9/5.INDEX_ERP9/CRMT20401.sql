
/****** Object:  Index [Index_Combo]    Script Date: 03/05/2017 2:35:57 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CRMT20401]') 
            AND name = N'Index_Combo')

CREATE NONCLUSTERED INDEX [Index_Combo] ON [dbo].[CRMT20401]
(
	[CampaignType] ASC,
	[CampaignStatus] ASC
)
INCLUDE ( 	[APK],
	[DivisionID],
	[CampaignID],
	[CampaignName],
	[AssignedToUserID],
	[Description],
	[ExpectOpenDate],
	[ExpectCloseDate],
	[InventoryID],
	[Sponsor],
	[IsCommon],
	[Disabled],
	[BudgetCost],
	[ExpectedRevenue],
	[ExpectedSales],
	[ExpectedROI],
	[ExpectedResponse],
	[ActualCost],
	[ActualSales],
	[CreateDate],
	[ActualROI],
	[CreateUserID],
	[LastModifyDate],
	[LastModifyUserID],
	[RelatedToTypeID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


