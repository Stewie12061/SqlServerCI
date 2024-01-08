/****** Object:  View [dbo].[MV1001]    Script Date: 12/16/2010 15:23:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

------ Created by Nguyen Van Nhan, Date 28/11/2003.
------ Purpose: In danh sach bo dinh muc san pham
------ Modified by Tiểu Mai on 23/05/2017: Bổ sung WITH (NOLOCK)
------ Modified by Nhựt Trường on 13/10/2020: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.

ALTER VIEW [dbo].[MV1001] as 
Select MT1603.DivisionID,	MT1603.ApportionID , ProductID , AT1302.InventoryName as ProductName,
	AT1302.UnitID, MT1602.Description,
	Sum(ConvertedUnit) as ConvertedUnit,
	Sum (Case when ExpenseID ='COST001' then ConvertedUnit else 0 end) as ConvertedUnit621,
	Sum (Case when ExpenseID ='COST002' then ConvertedUnit else 0 end) as ConvertedUnit622,
	Sum (Case when ExpenseID ='COST003' then ConvertedUnit else 0 end) as ConvertedUnit627
From MT1603 WITH (NOLOCK) 	inner join AT1302 WITH (NOLOCK) on AT1302.InventoryID = MT1603.ProductID AND AT1302.DivisionID IN (MT1603.DivisionID,'@@@')
		inner join MT1602 WITH (NOLOCK) on MT1602.ApportionID = MT1603.ApportionID
Group by MT1603.ApportionID, ProductID, AT1302.InventoryName, AT1302.UnitID,MT1602.Description,
MT1603.DivisionID

GO


