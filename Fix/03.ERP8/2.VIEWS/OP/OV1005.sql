IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OV1005]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[OV1005]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Tao du lieu ngam cho combo Don hang
-- <Param>
---- 
-- <Return>
---- 
-- <Reference> Tương tự như view OV1003 (bỏ đoạn không lấy đơn hàng đã kế thừa hết) để dùng cho màn hình báo cáo
---- Giá thành EMS (customize Meiko)
-- <History>
---- Create on 28/12/2016 by Trương Ngọc Phương Thảo
---- Modified by Phương Thảo on 26/05/2017: Sửa danh mục dùng chung
---- Modified by Đức Duy on 17/02/2023: [2023/02/IS/0091] -  Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>

CREATE VIEW [dbo].[OV1005] as 
Select T00.DivisionID, T00.SOrderID as OrderID, VoucherNo, OrderDate, T00.OrderStatus, T00.ObjectID, T01.ObjectName, T00.Notes, 
		T00.TranMonth, T00.TranYear, T00.OrderType, T00.ContractNo, T00.PaymentID,
		T00.Disabled, T00.DeliveryAddress as Address , 'SO' as Type , T00.VoucherTypeID, T00.ShipDate, T00.EmployeeID,
		T00.Varchar01, T00.Varchar02, T00.Varchar03, T00.Varchar04, T00.Varchar05,
		T00.Varchar06, T00.Varchar07, T00.Varchar08, T00.Varchar09, T00.Varchar10,
		T00.Varchar11, T00.Varchar12, T00.Varchar13, T00.Varchar14, T00.Varchar15,
		T00.Varchar16, T00.Varchar17, T00.Varchar18, T00.Varchar19, T00.Varchar20
From OT2001 T00 WITH (NOLOCK) 
left join AT1202 T01 WITH (NOLOCK)  on T01.DivisionID IN (T00.DivisionID, '@@@') AND T00.ObjectID = T01.ObjectID 
INNER JOIN OT2002 WITH (NOLOCK)  ON OT2002.DivisionID = T00.DivisionID AND OT2002.SOrderID = T00.SOrderID
Where OrderStatus not in (0, 9) and  T00.Disabled = 0 --- not in (0, 3, 4, 9)
Union ALL
Select T00.DivisionID,  POrderID as OrderID, VoucherNo, OrderDate,  T00.OrderStatus, T00.ObjectID, T01.ObjectName,  Notes, 
		T00.TranMonth, T00.TranYear,   T00.OrderType, ContractNo,'''' as PaymentID,
		T00.Disabled, T00.ReceivedAddress as Address,  'PO' as Type, T00.VoucherTypeID, ShipDate, T00.EmployeeID,
		T00.Varchar01, T00.Varchar02, T00.Varchar03, T00.Varchar04, T00.Varchar05,
		T00.Varchar06, T00.Varchar07, T00.Varchar08, T00.Varchar09, T00.Varchar10,
		T00.Varchar11, T00.Varchar12, T00.Varchar13, T00.Varchar14, T00.Varchar15,
		T00.Varchar16, T00.Varchar17, T00.Varchar18, T00.Varchar19, T00.Varchar20
From OT3001 T00 WITH (NOLOCK)  
left join AT1202 T01 WITH (NOLOCK)  on T01.DivisionID IN (T00.DivisionID, '@@@') AND T00.ObjectID = T01.ObjectID 
Where OrderStatus not in (0,  9) and  T00.Disabled = 0  ----not in (0, 3, 4, 9)
Union ALL
Select T00.DivisionID,  EstimateID as OrderID, VoucherNo, VoucherDate as OrderDate,  OrderStatus, '' as ObjectID, '' as ObjectName,  
	Description as Notes, 
	T00.TranMonth, T00.TranYear,   '' as OrderType, '' as ContractNo, '' as PaymentID,
	0 as Disabled, '' as  Address,  'ES' as Type, T00.VoucherTypeID, NULL as ShipDate, T00.EmployeeID,
	NULL AS Varchar01, NULL AS Varchar02, NULL AS Varchar03, NULL AS Varchar04, NULL AS Varchar05,
	NULL AS Varchar06, NULL AS Varchar07, NULL AS Varchar08, NULL AS Varchar09, NULL AS Varchar10,
	NULL AS Varchar11, NULL AS Varchar12, NULL AS Varchar13, NULL AS Varchar14, NULL AS Varchar15,
	NULL AS Varchar16, NULL AS Varchar17, NULL AS Varchar18, NULL AS Varchar19, NULL AS Varchar20
From OT2201 T00 WITH (NOLOCK) 
Where OrderStatus not in (0,  9) and Status = 1  --and  Disabled = 0 --- not in (0, 3, 4, 9)
Union
Select T00.DivisionID, QuotationID as OrderID, QuotationNo, QuotationDate, T00.OrderStatus, T00.ObjectID, T01.ObjectName, Description as Notes, 
	T00.TranMonth, T00.TranYear, 0 as OrderType, '' as ContractNo, T00.PaymentID,
	T00.Disabled, T00.DeliveryAddress as Address , 'QU' as Type , T00.VoucherTypeID, NULL as ShipDate, T00.EmployeeID,
	T00.Varchar01, T00.Varchar02, T00.Varchar03, T00.Varchar04, T00.Varchar05,
	T00.Varchar06, T00.Varchar07, T00.Varchar08, T00.Varchar09, T00.Varchar10,
	T00.Varchar11, T00.Varchar12, T00.Varchar13, T00.Varchar14, T00.Varchar15,
	T00.Varchar16, T00.Varchar17, T00.Varchar18, T00.Varchar19, T00.Varchar20
From OT2101 T00 WITH (NOLOCK)  
left join AT1202 T01 WITH (NOLOCK)  on T01.DivisionID IN (T00.DivisionID, '@@@') AND T00.ObjectID = T01.ObjectID 
Where OrderStatus not in (2, 3, 9) and  T00.Disabled = 0 
and QuotationID not in (Select Distinct isnull(QuotationID, '')  From OT2001 WHERE T00.DivisionID = OT2001.DivisionID) --- not in (0, 3, 4, 9) 
Union  --Don hang hieu chinh
Select T00.DivisionID, VoucherID as OrderID, VoucherNo, VoucherDate, T00.OrderStatus, T00.ObjectID, T01.ObjectName, Description as Notes, 
	T00.TranMonth, T00.TranYear, 0 as OrderType, '' as ContractNo, '' as PaymentID,
	T00.Disabled, T00.DeliveryAddress as Address , 'AS' as Type , T00.VoucherTypeID, NULL as ShipDate, T00.EmployeeID,
	NULL AS Varchar01, NULL AS Varchar02, NULL AS Varchar03, NULL AS Varchar04, NULL AS Varchar05,
	NULL AS Varchar06, NULL AS Varchar07, NULL AS Varchar08, NULL AS Varchar09, NULL AS Varchar10,
	NULL AS Varchar11, NULL AS Varchar12, NULL AS Varchar13, NULL AS Varchar14, NULL AS Varchar15,
	NULL AS Varchar16, NULL AS Varchar17, NULL AS Varchar18, NULL AS Varchar19, NULL AS Varchar20
From OT2006 T00 WITH (NOLOCK)  
left join AT1202 T01 WITH (NOLOCK)  on T01.DivisionID IN (T00.DivisionID, '@@@') AND T00.ObjectID = T01.ObjectID
Where OrderStatus not in (2, 3, 9) and  T00.Disabled = 0 --- not in (0, 3, 4, 9) 
Union ---Yeu cau donhang mua
Select T00.DivisionID, ROrderID as OrderID, VoucherNo, OrderDate as VoucherDate, T00.OrderStatus, T00.ObjectID, T01.ObjectName, Description as Notes, 
	T00.TranMonth, T00.TranYear, 0 as OrderType, T00.ContractNo, T00. PaymentID,
	T00.Disabled, T00.ReceivedAddress as Address , 'RO' as Type , T00.VoucherTypeID, ShipDate, T00.EmployeeID,
	NULL AS Varchar01, NULL AS Varchar02, NULL AS Varchar03, NULL AS Varchar04, NULL AS Varchar05,
	NULL AS Varchar06, NULL AS Varchar07, NULL AS Varchar08, NULL AS Varchar09, NULL AS Varchar10,
	NULL AS Varchar11, NULL AS Varchar12, NULL AS Varchar13, NULL AS Varchar14, NULL AS Varchar15,
	NULL AS Varchar16, NULL AS Varchar17, NULL AS Varchar18, NULL AS Varchar19, NULL AS Varchar20
From OT3101 T00 WITH (NOLOCK)  
left join AT1202 T01 WITH (NOLOCK)  on T01.DivisionID IN (T00.DivisionID, '@@@') AND T00.ObjectID = T01.ObjectID
Where OrderStatus not in (0,  9) and  T00.Disabled = 0  ----and ROrderID not in (Select Distinct isnull(RequestID, '')  From OT3001) ----not in (0, 3, 4, 9)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

