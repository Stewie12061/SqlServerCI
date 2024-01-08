IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[PQ2101]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[PQ2101]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--Create By: Dang Le Bao Quynh; Date 22/04/2009
--Purpose: View chet loc danh sach master don hang san xuat.
---- Modified by Hải Long on 22/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE VIEW [dbo].[PQ2101]
AS
SELECT   P.DivisionID,  
VoucherID, TranMonth, TranYear, VoucherTypeID, VoucherNo, VoucherDate, P.OrderStatus, Q.Description  As OrderStatusName, P.ObjectID, 
Case When A2.IsUpdateName = 1 Then P.ObjectName Else A2.ObjectName End As ObjectName, 
Case When A2.IsUpdateName = 1 Then P.VATNo Else A2.VATNo End As VATNo, 
Case When A2.IsUpdateName = 1 Then P.Address Else A2.Address End As Address, 
ContractNo, ContractDate, ShipDate, DeliveryAddress, Transport, Contact, 
SalesManID, A3.FullName As SalesManName, P.EmployeeID, Notes, 
P.Disabled, P.CreateDate, P.CreateUserID, P.LastModifyUserID, P.LastModifyDate
FROM PT2101 P 
Inner Join AT1202 A2 On A2.DivisionID IN (P.DivisionID, '@@@') AND P.ObjectID = A2.ObjectID
Left Join AT1103 A3 On P.SalesManID = A3.EmployeeID
Left Join PQ2222 Q On P.OrderStatus = Q.OrderStatus

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO



