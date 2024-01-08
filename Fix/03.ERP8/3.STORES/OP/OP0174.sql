IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0174]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0174]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load ds các đơn hàng sản xuất trễ hạn
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 26/12/2018 by Tra Giang
---- Modify on 11/06/2019 by Tra Giang: Bổ sung trường tổng số lượng TotalQuantity (Customize NNP = 104) 
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
/*
	OP0174 @DivisionID = 'NNP', @Date =15
	OP0174 @DivisionID, @Date
*/
----
CREATE PROCEDURE OP0174
( 
				@DivisionID VARCHAR(50), 
				@Date INT 
) 
AS 
DECLARE @sSQL NVARCHAR(MAX) 
		

SET @sSQL = N'
SELECT	DISTINCT
		OT2001.SOrderID, 
		OT2001.VoucherTypeID, 
		OT2001.VoucherNo, 
		OT2001.DivisionID, 
		OT2001.TranMonth, 
		OT2001.TranYear,
		OT2001.OrderDate, 
		OT2001.ContractNo, 
		OT2001.ContractDate, 
		OT2001.InventoryTypeID, 
		
		OT2001.CurrencyID, 
		CurrencyName, 	
		OT2001.ExchangeRate,  
		OT2001.PaymentID, 
		OT2001.DepartmentID,  
		AT1102.DepartmentName, 
		OT2001.IsPeriod, 
		OT2001.IsPlan, 
		OT2001.ObjectID,  
		ISNULL(OT2001.ObjectName, AT1202.ObjectName)   AS ObjectName, 
		ISNULL(OT2001.VatNo, AT1202.VatNo)  AS VatNo, 
		ISNULL( OT2001.Address, AT1202.Address)  AS Address,
		OT2001.DeliveryAddress, 
		OT2001.ClassifyID, 
	
		OT2001.InheritSOrderID,
		OT2001.EmployeeID,  
		AT1103.FullName,  
		OT2001.Transport, 
		AT1202.IsUpdateName, 
		AT1202.IsCustomer, 
		AT1202.IsSupplier,
		ConvertedAmount = (SELECT Sum(ISNULL(ConvertedAmount,0)- ISNULL(DiscountConvertedAmount,0)- ISNULL(CommissionCAmount,0) +
		ISNULL(VATConvertedAmount, 0))  FROM OT2002 Where OT2002.SOrderID = OT2001.SOrderID),
		OriginalAmount = (SELECT Sum(ISNULL(OriginalAmount,0)- ISNULL(DiscountOriginalAmount,0) - ISNULL(CommissionOAmount, 0) +
		ISNULL(VAToriginalAmount, 0))  FROM OT2002 Where OT2002.SOrderID = OT2001.SOrderID),
		OT2001.Notes, 
		OT2001.Disabled, 
		OT2001.OrderStatus, 
		OT2001.QuotationID,
		OT2001.OrderType,  
		OT2001.CreateUserID, 
		OT2001.CreateDate, 
		OT2001.SalesManID, 
		AT1103_2.FullName AS SalesManName, 
		OT2001.SalesMan2ID,		
		AT1103_3.FullName AS SalesMan2Name, 
		OT2001.ShipDate, 
		OT2001.LastModifyUserID, 
		OT2001.LastModifyDate, 
		OT2001.DueDate, 
		OT2001.PaymentTermID,
		OT2001.contact,
		OT2001.VATObjectID,
		ISNULL(OT2001.VATObjectName,T02.ObjectName) AS  VATObjectName,
		OT2001.IsInherit,
		OT1102.Description AS  IsConfirm,
		OT1102.EDescription AS EIsConfirm,
		OT2001.DescriptionConfirm,OT2001.PeriodID, OT2001.PriceListID
		,DATEDIFF(DAY, OT2002.EndDate,CONVERT(VARCHAR(10), getdate(), 120)) AS [Date],A.TotalQuantity
FROM OT2001  WITH (NOLOCK)
LEFT JOIN OT2002 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID and OT2001.SOrderID = OT2002.SOrderID and OT2002.OrderQuantity >0
LEFT JOIN OT0099 WITH (NOLOCK) ON OT0099.ID = OT2001.OrderTypeID and OT0099.CodeMaster = ''OrderTypeID''
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = OT2001.ObjectID
LEFT JOIN AT1202 T02 WITH (NOLOCK) ON T02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T02.ObjectID = OT2001.VATObjectID


LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = OT2001.CurrencyID
LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = OT2001.EmployeeID
LEFT JOIN AT1103 AT1103_2 WITH (NOLOCK) ON AT1103_2.EmployeeID = OT2001.SalesManID
LEFT JOIN AT1103 AT1103_3 WITH (NOLOCK) ON AT1103_3.EmployeeID = OT2001.SalesMan2ID

LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = OT2001.DepartmentID
LEFT JOIN OT1102 WITH (NOLOCK) ON OT1102.Code = OT2001.IsConfirm AND OT1102.TypeID = ''SO'' AND OT2001.DivisionID = OT1102.DivisionID
LEFT JOIN ( SELECT SOrderID, SUM(OrderQuantity) AS TotalQuantity FROM OT2002 WITH (NOLOCK) GROUP BY SOrderID) A  ON OT2001.SOrderID = A.SOrderID
Where OrderType=1 
AND DATEDIFF(DAY, OT2002.EndDate, CONVERT(VARCHAR(10), getdate(), 120))  >= '+STR(@Date)+' 
 AND OT2001.SOrderID NOT IN ( SELECT MOrderID FROM MT1001 WITH (NOLOCK) 
						LEFT JOIN OT2001 WITH (NOLOCK) ON MT1001.MOrderID = OT2001.SOrderID ) 
 '



--PRINT @sSQL

EXEC (@sSQL )









GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
