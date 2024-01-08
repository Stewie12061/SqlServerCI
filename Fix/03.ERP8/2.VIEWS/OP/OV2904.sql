IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OV2904]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[OV2904]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/****** Object:  View [dbo].[OV2904]    Script Date: 12/16/2010 15:12:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

-----Created by: Vo Thanh Huong, date: 29/11/2005 
-----purpose: SO LUONG GIAO NHAN HANG CUA DON HANG HIEU CHINH
---- Modified by TIểu Mai on 24/05/2017: Bổ sung WITH (NOLOCK) và chỉnh sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung

CREATE VIEW [dbo].[OV2904] as


--DON HANG HIEU CHINH
--LUONG 
Select		'AO' as Type, 
		T01.DivisionID, 
		T01.TranMonth, 
		T01.TranYear, 
		T00.VoucherID as OrderID,
		T01.OrderStatus, 
		T00.InventoryID as InventoryID, 
		T03.IsStocked,
		T00.TransactionID,
		T00.DataType,
		isnull(T00.AdjustQuantity, 0) as OrderQuantity, 
		isnull(T00.AdjustPrice,0)  as AdjustPrice,
		case when T03.IsStocked = 1 then isnull(T02.ActualQuantity, 0) else  isnull(T04.ActualQuantity, 0) end  as ActualQuantity,
		ABS(isnull(AdjustQuantity, 0)) - case when T03.IsStocked = 1 then isnull(T02.ActualQuantity, 0) else  isnull(T04.ActualQuantity, 0) end  AS EndQuantity,
 		0 as OriginalAmount, 
		0 as ConvertedAmount,
		0 as AOriginalAmount, 
		0 as AConvertedAmount,
		0 as EndOriginalAmount,
		0 as EndConvertedAmount
From  OT2007 T00 WITH (NOLOCK) inner join OT2006 T01 WITH (NOLOCK) on T00.VoucherID= T01.VoucherID 
	inner join AT1302 T03 WITH (NOLOCK) ON T03.DivisionID IN ('@@@', T00.DivisionID) AND T03.InventoryID = T00.InventoryID
	left join  (--Giao hang SO cho mat hang co quan ly ton kho
		Select T00.OrderID, 	InventoryID, 	sum(ActualQuantity) as ActualQuantity
		From AT2007 T00 WITH (NOLOCK) 
			inner join AT2006 T01 WITH (NOLOCK) on T00.VoucherID = T01.VoucherID
		Where  isnull(T00.OrderID, '') <> ''  ---PN: cho cac PHIEU DIEU CHINH TANG LUONG, 
						 ---PX: CHO CAC PHIEU DIEU CHINH GIAM LUONG
		Group by T00.OrderID, InventoryID
			) T02 	on T02.InventoryID = T00.InventoryID and 
			T02.OrderID = T00.VoucherID and 
			T03.IsStocked = 1
	left join  (--Giao hang SO cho mat hang dich vu
		Select T00.OrderID, 	InventoryID, 	sum(Quantity) as ActualQuantity
		From AT9000 T00 WITH (NOLOCK) 
		Where  isnull(T00.OrderID, '') <> ''  and TransactionTypeID in  ('T04', 'T24')
		Group by T00.OrderID, InventoryID
			) T04 	
			on T04.InventoryID = T00.InventoryID and 
			T04.OrderID = T00.VoucherID and 
			T03.IsStocked = 0	
Where OrderStatus not in (0, 3,4, 9) and 
		T01.Disabled = 0  and 
		T00.DataType = 2  --LUONG
		--and T00.Finish <> 1 
Union
Select		'AO' as Type, 
		T01.DivisionID, 
		T01.TranMonth, 
		T01.TranYear, 
		T00.VoucherID as OrderID,
		T01.OrderStatus, 
		T00.InventoryID as InventoryID, 
		9 as IsStocked,
		T00.TransactionID,
		T00.DataType,
		isnull(T00.AdjustQuantity, 0) as OrderQuantity, 
		isnull(T00.AdjustPrice, 0) as AdjustPrice,
		0  as ActualQuantity,
		0 as EndQuantity,
 		isnull(T00. OriginalAmount,0) as OriginalAmount, 
		isnull(T00.ConvertedAmount,0) as ConvertedAmount,
		isnull(T02.OriginalAmount,0) as AOriginalAmount, 
		isnull(T02.ConvertedAmount,0) as AConvertedAmount,
		abs(isnull(T00. OriginalAmount,0)) -  isnull(T02.OriginalAmount,0) as EndOriginalAmount,
		abs(isnull(T00.ConvertedAmount,0)) - isnull(T02.ConvertedAmount,0) as EndConvertedAmount
From  OT2007 T00 WITH (NOLOCK) inner join OT2006 T01 WITH (NOLOCK) on T00.VoucherID= T01.VoucherID 		
	left join  (--dieu chinh so tien 
		Select T00.OrderID, 	InventoryID, 	
			sum(isnull(OriginalAmount,0)) as OriginalAmount,
			sum(isnull(ConvertedAmount,0)) as ConvertedAmount
		From AT9000 T00 WITH (NOLOCK) 
		Where  isnull(T00.OrderID, '') <> ''  and TransactionTypeID in ('T04', 'T24')  --HD BAN HANG: cho PHIEU DIEU CHINH TANG GIA 
											---& HB TRA LAI: cho PHIEU DIEU CHINH GIAM GIA
		Group by T00.OrderID, InventoryID
			) T02	
			on T02.InventoryID = T00.InventoryID and 
			T02.OrderID = T00.VoucherID 
Where OrderStatus not in (0, 3,4, 9) and 
		T01.Disabled = 0  and 
		T00.DataType = 1
		--and T00.Finish <> 1

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


