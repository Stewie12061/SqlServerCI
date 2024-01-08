IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0178]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0178]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load đề nghị định mức - MF0176
-- <History>
---- Created by Tiểu Mai on 20/08/2016
---- Modified by Hải Long on 25/05/2017: Sửa danh mục dùng chung
---- Modified by Nhựt Trường on 13/10/2020: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>

/*
 * exec MP0178 'PC', 'BD33EEA8-6290-4E43-83E4-C93AE23BA4F9'
 */

CREATE PROCEDURE [dbo].[MP0178] 	
	@DivisionID NVARCHAR(50),
	@VoucherID NVARCHAR(500)
AS
DECLARE @sSQL NVARCHAR(MAX) = '', @sSQL1 NVARCHAR(MAX) = ''

---- Load đề nghị định mức theo quy cách MT0176
SET @sSQL = N'
SELECT MT0176.DivisionID, MT0176.VoucherID, MT0176.VoucherNo, MT0176.[Description], MT0135.ApportionID, MT0135.[Description] as ApportionName,  MT0135.ObjectID, AT1202.ObjectName, MT0176.Notes, 
MT0135.InventoryTypeID, MT0176.VoucherDate, Case when Isnull(MT0135.InventoryTypeID,'''') = ''%'' Then N''Tất cả'' Else AT1301.InventoryTypeName END as InventoryTypeName, MT0176.[Disabled], MT0176.TypeID,
MT0176.TransactionID, MT0176.ProductID,AT1302.InventoryName, MT0176.UnitID, MT0176.ProductQuantity,MT0176.S01ID, MT0176.S02ID, MT0176.S03ID, MT0176.S04ID, MT0176.S05ID,
MT0176.S06ID, MT0176.S07ID, MT0176.S08ID, MT0176.S09ID, MT0176.S10ID, MT0176.S11ID, MT0176.S12ID, MT0176.S13ID, MT0176.S14ID, MT0176.S15ID,
MT0176.S16ID, MT0176.S17ID, MT0176.S18ID, MT0176.S19ID, MT0176.S20ID, MT0176.Parameter01, MT0176.Parameter02, MT0176.Parameter03, MT0176.Orders,
MT0176.InheritTransactionID,
TotalAmount = ( Select Sum(Case When A.ExpenseID =''COST001''  Or  A.ExpenseID <>''COST001'' and MT0699.IsUsed = 1
 				then IsNull(MaterialAmount,0) Else 0 End )  	From  MT0177  A WITH (NOLOCK)  Left join  MT0699 WITH (NOLOCK) on MT0699.MaterialTypeID = A.MaterialTypeID  and MT0699.DivisionID = A.DivisionID
                Where A.DivisionID = MT0177.DivisionID AND A.ReTransactionID = MT0176.TransactionID
								),
Sum(Case when MT0177.ExpenseID =''COST001''  then 	isnull(MaterialAmount,0) else 0 end) as TotalAmount621,
Sum(Case when MT0177.ExpenseID =''COST002'' And MT0699.IsUsed=1 then 	isnull(MaterialAmount,0) else 0 end) as TotalAmount622,
Sum(Case when MT0177.ExpenseID =''COST003'' And MT0699.IsUsed=1 then 	isnull(MaterialAmount,0) else 0 end) as TotalAmount627,
ProductCost = ( Select Sum(Case When A.ExpenseID =''COST001''  Or  A.ExpenseID <>''COST001'' and MT0699.IsUsed = 1
 				then IsNull(MaterialAmount,0) Else 0 End )  	From  MT0177  A WITH (NOLOCK)  Left join  MT0699 WITH (NOLOCK) on MT0699.MaterialTypeID = A.MaterialTypeID  and MT0699.DivisionID = A.DivisionID
								Where A.DivisionID = MT0177.DivisionID and A.ReTransactionID = MT0177.ReTransactionID)/isnull(MT0176.ProductQuantity,1),
Begin_ProductQuantity,			
Begin_TotalAmount = ( Select Sum(Case When A.ExpenseID =''COST001''  Or  A.ExpenseID <>''COST001'' and MT0699.IsUsed = 1
 				then IsNull(Begin_MaterialAmount,0) Else 0 End )  	From  MT0177  A WITH (NOLOCK)  Left join  MT0699 WITH (NOLOCK) on MT0699.MaterialTypeID = A.MaterialTypeID  and MT0699.DivisionID = A.DivisionID
                Where A.DivisionID = MT0177.DivisionID AND A.ReTransactionID = MT0176.TransactionID
								),
Sum(Case when MT0177.ExpenseID =''COST001''  then 	isnull(Begin_MaterialAmount,0) else 0 end) as Begin_TotalAmount621,
Sum(Case when MT0177.ExpenseID =''COST002'' And MT0699.IsUsed=1 then 	isnull(Begin_MaterialAmount,0) else 0 end) as Begin_TotalAmount622,
Sum(Case when MT0177.ExpenseID =''COST003'' And MT0699.IsUsed=1 then 	isnull(Begin_MaterialAmount,0) else 0 end) as Begin_TotalAmount627,
Begin_ProductCost = ( Select Sum(Case When A.ExpenseID =''COST001''  Or  A.ExpenseID <>''COST001'' and MT0699.IsUsed = 1
 				then IsNull(Begin_MaterialAmount,0) Else 0 End )  	From  MT0177  A  Left join  MT0699 on MT0699.MaterialTypeID = A.MaterialTypeID  and MT0699.DivisionID = A.DivisionID
								Where A.DivisionID = MT0177.DivisionID and A.ReTransactionID = MT0177.ReTransactionID)/isnull(MT0176.Begin_ProductQuantity,1)
'

SET @sSQL1 = '	
From MT0176 WITH (NOLOCK) 
LEFT JOIN MT0177 WITH (NOLOCK) ON MT0176.DivisionID = MT0177.DivisionID AND MT0177.ReTransactionID = MT0176.TransactionID
LEFT JOIN MT0135 WITH (NOLOCK) ON MT0135.DivisionID = MT0176.DivisionID AND MT0135.ApportionID = MT0176.InheritApportionID
LEFT JOIN MT0699 WITH (NOLOCK) on  MT0699.MaterialTypeID = MT0177.MaterialTypeID and MT0699.DivisionID = MT0177.DivisionID
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = MT0176.ProductID AND AT1302.DivisionID IN (MT0176.DivisionID,''@@@'')
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = MT0135.ObjectID
LEFT JOIN AT1301 WITH (NOLOCK) ON AT1301.InventoryTypeID = MT0135.InventoryTypeID
WHERE MT0176.VoucherID = '''+@VoucherID+''' 
		AND MT0176.DivisionID = '''+@DivisionID+'''
Group by MT0177.DivisionID, MT0176.DivisionID, MT0176.VoucherID, MT0176.VoucherNo, MT0176.[Description], MT0135.ObjectID, AT1202.ObjectName, MT0176.Notes,
MT0135.InventoryTypeID,AT1301.InventoryTypeName, MT0176.[Disabled], MT0176.TypeID,
MT0176.TransactionID, MT0176.ProductID,AT1302.InventoryName, MT0176.UnitID, MT0176.ProductQuantity,MT0176.S01ID, MT0176.S02ID, MT0176.S03ID, MT0176.S04ID, MT0176.S05ID,
MT0176.S06ID, MT0176.S07ID, MT0176.S08ID, MT0176.S09ID, MT0176.S10ID, MT0176.S11ID, MT0176.S12ID, MT0176.S13ID, MT0176.S14ID, MT0176.S15ID,
MT0176.S16ID, MT0176.S17ID, MT0176.S18ID, MT0176.S19ID, MT0176.S20ID,
ProductQuantity, MT0176.TransactionID, MT0176.Parameter01, MT0176.Parameter02, MT0176.Parameter03, MT0177.ReTransactionID, MT0176.Orders, Begin_ProductQuantity,
MT0135.InventoryTypeID, MT0176.VoucherDate,  MT0135.ApportionID, MT0176.InheritTransactionID, MT0135.[Description]
Order by MT0176.Orders
'
EXEC (@sSQL + @sSQL1)
PRINT @sSQL
PRINT @sSQL1


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
