IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OV2901]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[OV2901]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/****** Object:  View [dbo].[OV2901]    Script Date: 12/16/2010 15:08:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

--Created by: Vo Thanh Huong, date : 28/04/2005
--Purpose: So luong dat hang va so luong hang da giao (view chet)
--Edit by : Thuy Tuyen , date  27/08/2009, date 12/09/2008
--Edit by: Thuy Tuyen,  date: 22/04/2010, them phan chuyen kho
---- Modified by TIểu Mai on 24/05/2017: Bổ sung WITH (NOLOCK) và chỉnh sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung


CREATE VIEW [dbo].[OV2901] as 
---Lay so luong don hang ban
Select OT2001.DivisionID, TranMonth, TranYear, OT2002.SOrderID,  OT2001.OrderStatus, TransactionID, OT2001.Duedate, OT2001.Shipdate,
	OT2002.InventoryID, OrderQuantity, ActualQuantity, OT2001.PaymentTermID,AT1208.Duedays,
	 case when OT2002.Finish = 1 then NULL else (  Case When  Isnull (AT1302.IsStocked,0) = 0  then 0 else  isnull(OrderQuantity, 0)- isnull(ActualQuantity, 0) end)end as EndQuantity
From OT2002 WITH (NOLOCK) 
inner join OT2001 WITH (NOLOCK) on OT2002.SOrderID = OT2001.SOrderID and OT2002.DivisionID = OT2001.DivisionID
Inner Join AT1302 WITH (NOLOCK) on AT1302.DivisionID IN ('@@@', OT2002.DivisionID) AND AT1302.InventoryID = OT2002.InventoryID 	
left join AT1208 WITH (NOLOCK) on AT1208.PaymentTermID = OT2001.PaymentTermID
left join 	(Select AT2006.DivisionID, AT2007.OrderID, OTransactionID,
			InventoryID, sum(ActualQuantity) As ActualQuantity
		From AT2007 WITH (NOLOCK) inner join AT2006 WITH (NOLOCK) on AT2006.VoucherID = AT2007.VoucherID
		Where isnull(AT2007.OrderID,'') <>'' and
			KindVoucherID in (2,4,6,8,3 ) 
		Group by AT2006.DivisionID, AT2007.OrderID, InventoryID, OTransactionID) as G  --- (co nghia la Giao  hang)
		on 	OT2001.DivisionID = G.DivisionID and
			OT2002.SOrderID = G.OrderID and
			OT2002.InventoryID = G.InventoryID and
			OT2002.TransactionID = G.OTransactionID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
