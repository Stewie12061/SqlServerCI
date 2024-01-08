IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MV1703]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[MV1703]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


--Created by Nguyen Van Nhan 
--Purpose:Dung cho Report MR1605(Bo dinh muc)
--Edit by: Mai Duyen, Date 16/09/2014: Bo sung M.I02ID,M.Specification  (KH Jacon)
---- Modified by Hải Long on 22/05/2017: Bổ sung các cột tham số và các cột ĐVT chuẩn, 3 tham số
---- Modified by TIểu Mai on 24/05/2017: Bổ sung WITH (NOLOCK) và chỉnh sửa danh mục dùng chung
---- Modified by Hải Long on 17/07/2017: Bổ sung cột tài khoản ngân hàng theo NVL
---- Modified by Nhựt Trường on 13/10/2020: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.
---- Modified by Nhựt Trường on 02/08/2021: Bổ sung trường RateWastage,RateWastage02.

CREATE VIEW [dbo].[MV1703] as 
Select  
	( MT1603.ExpenseID) as GroupID ,
	(Case when MT1603.ExpenseID = 'COST001' then 'MFML000039' else 
		Case when MT1603.ExpenseID ='COST002' then 'MFML000040' else
		'MFML000041' end end ) as GroupName,
	MT1603.ApportionID,
	MT1603.DivisionID,
	MT1602.Description,
	MT1603.ExpenseID,		
	ProductID,
	P.InventoryName as ProductName,
	IsNull(MT1603.UnitID, P.UnitID) AS ProductUnitID, 
	(Case when MT1603.ExpenseID ='COST001' then MaterialID else MT1603.MaterialTypeID End) as MaterialID, 
	(Case when MT1603.ExpenseID ='COST001' then M.InventoryName else UserName End) as MaterialName,
	IsNull(MT1603.MaterialUnitID, M.UnitID) AS MaterialUnitID, 
	MT1603.ProductQuantity,
	MT1603.MaterialQuantity,
	MT1603.StandardMaterialQuantity,	
	MT1603.QuantityUnit,
	MT1603.StandardQuantityUnit,
	MT1603.MaterialAmount,
	MT1603.ConvertedUnit,
	M.I02ID,M.Specification,
	MT1603.MaterialPrice,
	MT1603.StandardMaterialPrice,	
	MT1603.Parameter01,
	MT1603.Parameter02,
	MT1603.Parameter03,
	MT1603.Parameter04,
	MT1603.Parameter05,
	MT1603.DParameter01,
	MT1603.DParameter02,
	MT1603.DParameter03,
	M.AccountID AS MaterialAccountID,
	RateWastage,RateWastage02
 From MT1603 WITH (NOLOCK)  	
		Left join AT1302 P WITH (NOLOCK) on P.InventoryID = MT1603.ProductID AND P.DivisionID IN (MT1603.DivisionID,'@@@')
		Left join AT1302 M WITH (NOLOCK) on M.InventoryID = MT1603.MaterialID AND M.DivisionID IN (MT1603.DivisionID,'@@@')
		Left join MT1602 WITH (NOLOCK) on MT1602.ApportionID = MT1603.ApportionID and  MT1602.DivisionID = MT1603.DivisionID
		Left join MT0699 WITH (NOLOCK) on  MT0699.MaterialTypeID = MT1603.MaterialTypeID and  MT0699.DivisionID = MT1603.DivisionID


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

