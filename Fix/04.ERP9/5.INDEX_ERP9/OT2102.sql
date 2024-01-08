---Created by Hoài Bảo on 12/04/2022
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[OT2102]') 
            AND name = N'DivisionID_QuotationID')
/****** Object:  Index [EmployeeID_FullName]    Script Date: 12/04/2022 11:21:43 AM ******/
CREATE NONCLUSTERED INDEX [DivisionID_QuotationID] ON [dbo].[OT2102]
(
	[DivisionID] ASC,
	[QuotationID] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO