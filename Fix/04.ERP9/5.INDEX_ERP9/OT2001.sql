---Created by Thị Phượng on 06/07/2017
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[OT2001]') 
            AND name = N'Index_Combox')
/****** Object:  Index [Index_Combox]    Script Date: 07/06/2017 2:00:14 PM ******/
CREATE NONCLUSTERED INDEX [Index_Combox] ON [dbo].[OT2001]
(
	[DivisionID] ASC,
	[EmployeeID] ASC
)
INCLUDE ( 	[APK],
	[VoucherTypeID],
	[VoucherNo],
	[OrderDate],
	[ObjectID],
	[OrderStatus],
	[CreateUserID],
	[ObjectName],
	[IsConfirm],
	[TranMonth],
	[TranYear]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[OT2001]') 
            AND name = N'DivisionID-SorderID')
CREATE NONCLUSTERED INDEX [DivisionID-SorderID] ON [dbo].[OT2001]
(
	[OrderType] ASC,
	[IsConfirm] ASC,
	[DivisionID] ASC
)
INCLUDE ( 	[SOrderID],
	[OrderDate],
	[ObjectID],
	[CreateUserID],
	[TranMonth],
	[TranYear],
	[SalesManID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [DivisionID_ObjectID]    Script Date: 07/07/2017 10:52:37 AM ******/
--Index cải tiến báo cáo số lượng khách hàng theo nhân viên
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[OT2001]') 
            AND name = N'DivisionID_ObjectID')
CREATE NONCLUSTERED INDEX [DivisionID_ObjectID] ON [dbo].[OT2001]
(
	[OrderType] ASC,
	[ObjectID] ASC,
	[IsConfirm] ASC,
	[DivisionID] ASC
)
INCLUDE ( 	[SOrderID],
	[TranMonth],
	[TranYear]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO



