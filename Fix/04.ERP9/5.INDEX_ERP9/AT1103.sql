---Created by Thị Phượng on 24/04/2017
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AT1103]') 
            AND name = N'EmployeeID_FullName')
/****** Object:  Index [EmployeeID_FullName]    Script Date: 24/04/2017 11:21:43 AM ******/
CREATE NONCLUSTERED INDEX [EmployeeID_FullName] ON [dbo].[AT1103]
(
	[DivisionID] ASC,
	[EmployeeID] ASC,
	[FullName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


