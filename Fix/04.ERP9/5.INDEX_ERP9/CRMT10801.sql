---Created by Thị Phượng on 06/07/2017
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CRMT10801]') 
            AND name = N'NextActionID')
/****** Object:  Index [NextActionID]    Script Date: 07/06/2017 2:03:00 PM ******/
CREATE NONCLUSTERED INDEX [NextActionID] ON [dbo].[CRMT10801]
(
	[NextActionID] ASC,
	[NextActionName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


