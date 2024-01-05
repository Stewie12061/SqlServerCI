--Create by Thị Phượng On 24/04/2017
/****** Object:  Index [LeadTypeID_LeadID]    Script Date: 24/04/2017 11:18:08 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CRMT10201]') 
            AND name = N'LeadTypeID_LeadID')
CREATE NONCLUSTERED INDEX [LeadTypeID_LeadID] ON [dbo].[CRMT10201]
(
	[DivisionID] ASC,
	[LeadTypeID] ASC,
	[LeadTypeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


