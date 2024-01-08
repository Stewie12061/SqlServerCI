IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[WQ3027]'))
DROP VIEW [dbo].[WQ3027]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

----- Create By: Dang Le Bao Quynh; Date 03/11/2009
----- Purpose: View chet phuc vu viec ke thua du tru chi phi lam phieu xuat kho
----- Modified by TIểu Mai on 24/05/2017: Bổ sung WITH (NOLOCK) và chỉnh sửa danh mục dùng chung
----- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
----- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
----- Modified by Đình Định on 09/03/2023 : [2023/03/IS/0042] - THIENNAM - Lấy lên thẻ OV3027.EmployeeID giống với mẫu cũ ở bản ERP7.


CREATE VIEW [dbo].[WQ3027]
AS

Select 
OT2201.DivisionID, OT2201.EstimateID,  OT2201.TranMonth, OT2201.TranYear, 
OT2201.VoucherTypeID, OT2201.VoucherNo, OT2201.VoucherDate, OT2201.ObjectID, AT1202.ObjectName, OT2201.Description,  
OT2201.WareHouseID, 
OT2203.TransactionID,
OT2203.Orders, OT2203.MaterialID, M.InventoryName As MaterialName, M.UnitID, M.AccountID, OT2203.MaterialDate As EstimateExportDate,  
M.MethodID, M.IsSource, M.IsLimitDate, 
OT2203.MaterialQuantity, 
(Select Max(VoucherDate) From AT2006 WITH (NOLOCK) Inner Join AT2007 WITH (NOLOCK) on AT2006.VoucherID = AT2007.VoucherID Where AT2007.ETransactionID = OT2203.TransactionID) As ExportDate,
isnull((Select Sum(isnull(ActualQuantity,0)) From AT2007 WITH (NOLOCK) Where AT2007.ETransactionID = OT2203.TransactionID),0) As InheritedQuantity,
OT2203.MaterialQuantity - isnull((Select Sum(isnull(ActualQuantity,0)) From AT2007 WITH (NOLOCK) Where AT2007.ETransactionID = OT2203.TransactionID),0) As RemainQuantity,
MDescription, 
OT2201.PeriodID, MT1601.Description As PeriodName, OT2201.EmployeeID,
OT2202.ProductID, P.InventoryName As ProductName ,
OT2202.Ana01ID, OT2202.Ana02ID, OT2202.Ana03ID, OT2202.Ana04ID, OT2202.Ana05ID, 
OT2202.Ana06ID, OT2202.Ana07ID, OT2202.Ana08ID, OT2202.Ana09ID, OT2202.Ana10ID, 
A1.AnaName as Ana01Name, A2.AnaName as Ana02Name, A3.AnaName as Ana03Name, A4.AnaName as Ana04Name, A5.AnaName as Ana05Name,
A1.AnaName as Ana06Name, A2.AnaName as Ana07Name, A3.AnaName as Ana08Name, A4.AnaName as Ana09Name, A5.AnaName as Ana10Name,
OT2202.MOrderID, OT2202.SOrderID, OT2202.MTransactionID, OT2202.STransactionID
FROM OT2201 WITH (NOLOCK) 
Inner Join OT2202 WITH (NOLOCK) On OT2201.DivisionID = OT2202.DivisionID AND OT2201.EstimateID = OT2202.EstimateID 
Inner Join OT2203 WITH (NOLOCK) On OT2203.DivisionID = OT2202.DivisionID AND OT2202.EstimateID = OT2203.EstimateID AND OT2202.EDetailID = OT2203.EDetailID  
Left Join AT1202 WITH (NOLOCK) On AT1202.DivisionID IN ('@@@', OT2201.DivisionID) AND OT2201.ObjectID = AT1202.ObjectID
Left Join AT1302 P WITH (NOLOCK) On P.DivisionID IN ('@@@', OT2202.DivisionID) AND OT2202.ProductID = P.InventoryID
Left Join AT1302 M WITH (NOLOCK) On M.DivisionID IN ('@@@', OT2203.DivisionID) AND OT2203.MaterialID = M.InventoryID
Left Join MT1601 WITH (NOLOCK) On OT2201.DivisionID = MT1601.DivisionID AND OT2201.PeriodID = MT1601.PeriodID
Left Join AT1011 A1 WITH (NOLOCK) On A1.DivisionID IN ('@@@', OT2202.DivisionID) AND A1.AnaTypeID = 'A01' AND OT2202.Ana01ID = A1.AnaID
Left Join AT1011 A2 WITH (NOLOCK) On A2.DivisionID IN ('@@@', OT2202.DivisionID) AND A2.AnaTypeID = 'A02' AND OT2202.Ana02ID = A2.AnaID
Left Join AT1011 A3 WITH (NOLOCK) On A3.DivisionID IN ('@@@', OT2202.DivisionID) AND A3.AnaTypeID = 'A03' AND OT2202.Ana03ID = A3.AnaID
Left Join AT1011 A4 WITH (NOLOCK) On A4.DivisionID IN ('@@@', OT2202.DivisionID) AND A4.AnaTypeID = 'A04' AND OT2202.Ana04ID = A4.AnaID
Left Join AT1011 A5 WITH (NOLOCK) On A5.DivisionID IN ('@@@', OT2202.DivisionID) AND A5.AnaTypeID = 'A05' AND OT2202.Ana05ID = A5.AnaID
Left Join AT1011 A6 WITH (NOLOCK) On A6.DivisionID IN ('@@@', OT2202.DivisionID) AND A6.AnaTypeID = 'A06' AND OT2202.Ana06ID = A6.AnaID
Left Join AT1011 A7 WITH (NOLOCK) On A7.DivisionID IN ('@@@', OT2202.DivisionID) AND A7.AnaTypeID = 'A07' AND OT2202.Ana07ID = A7.AnaID
Left Join AT1011 A8 WITH (NOLOCK) On A8.DivisionID IN ('@@@', OT2202.DivisionID) AND A8.AnaTypeID = 'A08' AND OT2202.Ana08ID = A8.AnaID
Left Join AT1011 A9 WITH (NOLOCK) On A9.DivisionID IN ('@@@', OT2202.DivisionID) AND A9.AnaTypeID = 'A09' AND OT2202.Ana09ID = A9.AnaID
Left Join AT1011 A10 WITH (NOLOCK) On A10.DivisionID IN ('@@@', OT2202.DivisionID) AND A10.AnaTypeID = 'A10' AND OT2202.Ana10ID = A10.AnaID

Where OT2201.OrderStatus = 1