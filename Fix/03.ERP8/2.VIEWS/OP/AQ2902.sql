IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AQ2902]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AQ2902]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--Created by: Thuy Tuyen , date : 01/10/2009
--Purpose: So luong dat hang va so luong hang da mua- AT9000 (view chet)
---- Modified on 08/06/2016 by Bảo Thy: Bổ sung WITH (NOLOCK)
---- Modified on 19/05/2017: Sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung



CREATE VIEW [dbo].[AQ2902] as 
---Lay so luong don hang mua
Select 
	OT3001.DivisionID, TranMonth, TranYear,OT3002.POrderID, 
	OT3001.OrderStatus, TransactionID,
	OT3002.InventoryID, OrderQuantity, AdjustQuantity, 
	(case when OT3002.Finish = 1 then 0   else  isnull(OrderQuantity, 0) - isnull(AdjustQuantity,0) - isnull(ActualQuantityHD,0)end) as EndQuantity
From OT3002 WITH (NOLOCK)
inner join OT3001 WITH (NOLOCK) on OT3002.POrderID = OT3001.POrderID and OT3002.DivisionID = OT3001.DivisionID
Inner join AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN ('@@@', OT3002.DivisionID) AND AT1302.InventoryID = OT3002.InventoryID
Left join  (-- Lap phieu mua hàng  doi voi nhung mat hang AT1302.IsStocked = 0)
	Select AT9000.DivisionID, AT9000.OrderID, OTransactionID, InventoryID, sum(Quantity) As ActualQuantityHD
	From AT9000   WITH (NOLOCK)
	Where isnull(AT9000.OrderID,'') <>'' and TransactionTypeID ='T03' 
	Group by AT9000.DivisionID, AT9000.OrderID, InventoryID, OTransactionID
	) as K  on OT3001.DivisionID = K.DivisionID and OT3002.POrderID = K.OrderID and OT3002.InventoryID = K.InventoryID and
			OT3002.TransactionID = K.OTransactionID and K.DivisionID = OT3002.DivisionID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


