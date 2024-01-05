---Created by Thị Phượng on 05/07/2017
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CRMT10501]') 
            AND name = N'CauseID_CauseName')
/****** Object:  Index [CauseID_CauseName]    Script Date: 24/04/2017 11:21:43 AM ******/
CREATE NONCLUSTERED INDEX [CauseID_CauseName] ON [dbo].[CRMT10501]
(
	[CauseID] ASC,
	[CauseName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
