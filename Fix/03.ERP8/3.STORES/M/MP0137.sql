IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0137]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0137]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- In bộ định mức theo quy cách - MF0136
-- <History>
---- Created by Tiểu Mai on 25/12/2015
---- Modified by Tiểu Mai on 29/01/2016: Lấy tên thiết lập mã phân tích cho An Phát
---- Modified by Tiểu Mai on 03/06/2016: Bổ sung WITH (NOLOCK), bổ sung trường MaterialTypeID
---- Modified by Bảo Thy on 22/05/2017: Sửa danh mục dùng chung
---- Modified by Nhựt Trường on 13/10/2020: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>

-- EXEC MP0137 'HT', 'DMKT.6635-PO1045'

CREATE PROCEDURE [dbo].[MP0137] 	
	@DivisionID NVARCHAR(50),
	@ApportionID NVARCHAR(50)
AS
DECLARE @sSQL NVARCHAR(MAX), @sSQL1 NVARCHAR(MAX), 
		@sSQL2 NVARCHAR(MAX), @sSQL3 NVARCHAR(MAX),
		@sSQL4 NVARCHAR(MAX)

SET @sSQL = '
SELECT MT0135.DivisionID, MT0135.ApportionID, MT0135.[Description], MT0135.ObjectID, AT1202.ObjectName,MT0135.InventoryTypeID,AT1301.InventoryTypeName, MT0135.[Disabled], MT0135.ApportionTypeID,
MT0135.IsBOM, MT0136.TransactionID, MT0136.ProductID,AT1302.InventoryName, MT0136.UnitID, MT0136.ProductQuantity,MT0136.S01ID, MT0136.S02ID, MT0136.S03ID, MT0136.S04ID, MT0136.S05ID,
MT0136.S06ID, MT0136.S07ID, MT0136.S08ID, MT0136.S09ID, MT0136.S10ID, MT0136.S11ID, MT0136.S12ID, MT0136.S13ID, MT0136.S14ID, MT0136.S15ID,
MT0136.S16ID, MT0136.S17ID, MT0136.S18ID, MT0136.S19ID, MT0136.S20ID, MT0136.Parameter01, MT0136.Parameter02, MT0136.Parameter03, MT0136.Orders,
TotalAmount = ( Select Sum(Case When A.ExpenseID =''COST001''  Or  A.ExpenseID <>''COST001'' and MT0699.IsUsed = 1
 				then IsNull(MaterialAmount,0) Else 0 End )  	From  MT0137  A  Left join  MT0699 on MT0699.MaterialTypeID = A.MaterialTypeID  and MT0699.DivisionID = A.DivisionID
								Where  A.ProductID = MT0137.ProductID  and A.DivisionID = MT0137.DivisionID AND A.ReTransactionID = MT0136.TransactionID
								),
Sum(Case when MT0137.ExpenseID =''COST001''  then 	isnull(MaterialAmount,0) else 0 end) as TotalAmount621,
Sum(Case when MT0137.ExpenseID =''COST002'' And MT0699.IsUsed=1 then 	isnull(MaterialAmount,0) else 0 end) as TotalAmount622,
Sum(Case when MT0137.ExpenseID =''COST003'' And MT0699.IsUsed=1 then 	isnull(MaterialAmount,0) else 0 end) as TotalAmount627,
ProductCost = ( Select Sum(Case When A.ExpenseID =''COST001''  Or  A.ExpenseID <>''COST001'' and MT0699.IsUsed = 1
 				then IsNull(MaterialAmount,0) Else 0 End )  	From  MT0137  A  Left join  MT0699 on MT0699.MaterialTypeID = A.MaterialTypeID  and MT0699.DivisionID = A.DivisionID
								Where A.ProductID = MT0137.ProductID and A.DivisionID = MT0137.DivisionID and A.ReTransactionID = MT0137.ReTransactionID)/isnull(MT0136.ProductQuantity,1),
MT0137.MaterialID, A50.InventoryName as MaterialName, MT0137.MaterialUnitID, A50.InventoryTypeID as MaterialTypeID, MT0137.MaterialQuantity, MT0137.MaterialPrice, MT0137.MaterialAmount,							
MT0137.Rate, MT0137.RateDecimalApp, MT0137.ExpenseID, MT0137.IsExtraMaterial, MT0137.WasteID, MT0137.MaterialGroupID, MT0137.QuantityUnit,
MT0137.[Description] as DDescription , MT0137.DParameter01, MT0137.DParameter02, MT0137.DParameter03,
MT0137.DS01ID, MT0137.DS02ID, MT0137.DS03ID, MT0137.DS04ID, MT0137.DS05ID, MT0137.DS06ID, MT0137.DS07ID, MT0137.DS08ID, MT0137.DS09ID, MT0137.DS10ID,
MT0137.DS11ID, MT0137.DS12ID, MT0137.DS13ID, MT0137.DS14ID, MT0137.DS15ID, MT0137.DS16ID, MT0137.DS17ID, MT0137.DS18ID, MT0137.DS19ID, MT0137.DS20ID,

A01.StandardName AS S01Name, A02.StandardName AS S02Name, A03.StandardName AS S03Name, A04.StandardName AS S04Name, A05.StandardName AS S05Name,
A06.StandardName AS S06Name, A07.StandardName AS S07Name, A08.StandardName AS S08Name, A09.StandardName AS S09Name, A10.StandardName AS S10Name,
A11.StandardName AS S11Name, A12.StandardName AS S12Name, A13.StandardName AS S13Name, A14.StandardName AS S14Name, A15.StandardName AS S15Name,
A16.StandardName AS S16Name, A17.StandardName AS S17Name, A18.StandardName AS SName18, A19.StandardName AS S19Name, A20.StandardName AS S20Name,
A21.StandardName AS DS01Name, A22.StandardName AS DS02Name, A23.StandardName AS DS03Name, A24.StandardName AS DS04Name, A25.StandardName AS DS05Name,
A26.StandardName AS DS06Name, A27.StandardName AS DS07Name, A28.StandardName AS DS08Name, A29.StandardName AS DS09Name, A20.StandardName AS DS10Name,
A31.StandardName AS DS11Name, A32.StandardName AS DS12Name, A33.StandardName AS DS13Name, A34.StandardName AS DS14Name, A35.StandardName AS DS15Name,
A36.StandardName AS DS16Name, A37.StandardName AS DS17Name, A38.StandardName AS DSName18, A39.StandardName AS DS19Name, A40.StandardName AS DS20Name,
a.S01 as UserName01, a.S02 as UserName02, a.S03 as UserName03, a.S04 as UserName04, a.S05 as UserName05, a.S06 as UserName06, a.S07 as UserName07, a.S08 as UserName08, a.S09 as UserName09, a.S10 as UserName10,
a.S11 as UserName11, a.S12 as UserName12, a.S13 as UserName13, a.S14 as UserName14, a.S15 as UserName15, a.S16 as UserName16, a.S17 as UserName17, a.S18 as UserName18, a.S19 as UserName19, a.S20 as UserName20,
MT0136.Begin_ProductQuantity,
MT0137.Begin_MaterialQuantity,
MT0137.Begin_MaterialPrice,
MT0137.Begin_RateDecimalApp,
MT0137.Begin_MaterialAmount,
MT0137.Begin_QuantityUnit,
MT0137.Begin_ConvertedUnit,
Begin_TotalAmount = ( Select Sum(Case When A.ExpenseID =''COST001''  Or  A.ExpenseID <>''COST001'' and MT0699.IsUsed = 1
 				then IsNull(Begin_MaterialAmount,0) Else 0 End )  	From  MT0137 A WITH (NOLOCK) Left join  MT0699 WITH (NOLOCK) on MT0699.MaterialTypeID = A.MaterialTypeID  and MT0699.DivisionID = A.DivisionID
								Where  A.ProductID = MT0137.ProductID  and A.DivisionID = MT0137.DivisionID AND A.ReTransactionID = MT0136.TransactionID
								),
Sum(Case when MT0137.ExpenseID =''COST001''  then 	isnull(Begin_MaterialAmount,0) else 0 end) as TotalAmount621,
Sum(Case when MT0137.ExpenseID =''COST002'' And MT0699.IsUsed=1 then 	isnull(Begin_MaterialAmount,0) else 0 end) as Begin_TotalAmount622,
Sum(Case when MT0137.ExpenseID =''COST003'' And MT0699.IsUsed=1 then 	isnull(Begin_MaterialAmount,0) else 0 end) as Begin_TotalAmount627,
Begin_ProductCost = ( Select Sum(Case When A.ExpenseID =''COST001''  Or  A.ExpenseID <>''COST001'' and MT0699.IsUsed = 1
 				then IsNull(Begin_MaterialAmount,0) Else 0 End )  	From  MT0137 A WITH (NOLOCK) Left join  MT0699 WITH (NOLOCK) on MT0699.MaterialTypeID = A.MaterialTypeID  and MT0699.DivisionID = A.DivisionID
								Where A.ProductID = MT0137.ProductID and A.DivisionID = MT0137.DivisionID and A.ReTransactionID = MT0137.ReTransactionID)/isnull(MT0136.ProductQuantity,1)
'
SET @sSQL1 = '	
From MT0135 WITH (NOLOCK)
LEFT JOIN MT0136 WITH (NOLOCK) ON MT0135.DivisionID = MT0136.DivisionID AND MT0135.ApportionID = MT0136.ApportionID
LEFT JOIN MT0137 WITH (NOLOCK) ON MT0136.DivisionID = MT0137.DivisionID AND MT0136.ProductID = MT0137.ProductID AND MT0137.ReTransactionID = MT0136.TransactionID
LEFT JOIN MT0699 WITH (NOLOCK) on MT0699.MaterialTypeID = MT0137.MaterialTypeID and MT0699.DivisionID = MT0137.DivisionID
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = MT0135.ObjectID
LEFT JOIN AT1301 WITH (NOLOCK) ON AT1301.InventoryTypeID = MT0135.InventoryTypeID
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = Mt0136.ProductID AND AT1302.DivisionID IN (MT0136.DivisionID,''@@@'')
LEFT JOIN AT1302 A50 WITH (NOLOCK) ON A50.InventoryID = MT0137.MaterialID AND A50.DivisionID IN (MT0137.DivisionID,''@@@'')
LEFT JOIN AT0128 A01 WITH (NOLOCK) ON A01.StandardID = MT0136.S01ID AND A01.StandardTypeID = ''S01''
LEFT JOIN AT0128 A02 WITH (NOLOCK) ON A02.StandardID = MT0136.S02ID AND A02.StandardTypeID = ''S02''
LEFT JOIN AT0128 A03 WITH (NOLOCK) ON A03.StandardID = MT0136.S03ID AND A03.StandardTypeID = ''S03''
LEFT JOIN AT0128 A04 WITH (NOLOCK) ON A04.StandardID = MT0136.S04ID AND A04.StandardTypeID = ''S04''
LEFT JOIN AT0128 A05 WITH (NOLOCK) ON A05.StandardID = MT0136.S05ID AND A05.StandardTypeID = ''S05''
LEFT JOIN AT0128 A06 WITH (NOLOCK) ON A06.StandardID = MT0136.S06ID AND A06.StandardTypeID = ''S06''
LEFT JOIN AT0128 A07 WITH (NOLOCK) ON A07.StandardID = MT0136.S07ID AND A07.StandardTypeID = ''S07''
LEFT JOIN AT0128 A08 WITH (NOLOCK) ON A08.StandardID = MT0136.S08ID AND A08.StandardTypeID = ''S08''
LEFT JOIN AT0128 A09 WITH (NOLOCK) ON A09.StandardID = MT0136.S09ID AND A09.StandardTypeID = ''S09''
LEFT JOIN AT0128 A10 WITH (NOLOCK) ON A10.StandardID = MT0136.S10ID AND A10.StandardTypeID = ''S10''
LEFT JOIN AT0128 A11 WITH (NOLOCK) ON A11.StandardID = MT0136.S11ID AND A11.StandardTypeID = ''S11''
LEFT JOIN AT0128 A12 WITH (NOLOCK) ON A12.StandardID = MT0136.S12ID AND A12.StandardTypeID = ''S12''
LEFT JOIN AT0128 A13 WITH (NOLOCK) ON A13.StandardID = MT0136.S13ID AND A13.StandardTypeID = ''S13''
LEFT JOIN AT0128 A14 WITH (NOLOCK) ON A14.StandardID = MT0136.S14ID AND A14.StandardTypeID = ''S14''
LEFT JOIN AT0128 A15 WITH (NOLOCK) ON A15.StandardID = MT0136.S15ID AND A15.StandardTypeID = ''S15''
LEFT JOIN AT0128 A16 WITH (NOLOCK) ON A16.StandardID = MT0136.S16ID AND A16.StandardTypeID = ''S16''
LEFT JOIN AT0128 A17 WITH (NOLOCK) ON A17.StandardID = MT0136.S17ID AND A17.StandardTypeID = ''S17''
LEFT JOIN AT0128 A18 WITH (NOLOCK) ON A18.StandardID = MT0136.S18ID AND A18.StandardTypeID = ''S18''
LEFT JOIN AT0128 A19 WITH (NOLOCK) ON A19.StandardID = MT0136.S19ID AND A19.StandardTypeID = ''S19''
LEFT JOIN AT0128 A20 WITH (NOLOCK) ON A20.StandardID = MT0136.S20ID AND A20.StandardTypeID = ''S20''
'
SET @sSQL2 = '
LEFT JOIN AT0128 A21 WITH (NOLOCK) ON A21.StandardID = MT0137.DS01ID AND A21.StandardTypeID = ''S01''
LEFT JOIN AT0128 A22 WITH (NOLOCK) ON A22.StandardID = MT0137.DS02ID AND A22.StandardTypeID = ''S02''
LEFT JOIN AT0128 A23 WITH (NOLOCK) ON A23.StandardID = MT0137.DS03ID AND A23.StandardTypeID = ''S03''
LEFT JOIN AT0128 A24 WITH (NOLOCK) ON A24.StandardID = MT0137.DS04ID AND A24.StandardTypeID = ''S04''
LEFT JOIN AT0128 A25 WITH (NOLOCK) ON A25.StandardID = MT0137.DS05ID AND A25.StandardTypeID = ''S05''
LEFT JOIN AT0128 A26 WITH (NOLOCK) ON A26.StandardID = MT0137.DS06ID AND A26.StandardTypeID = ''S06''
LEFT JOIN AT0128 A27 WITH (NOLOCK) ON A27.StandardID = MT0137.DS07ID AND A27.StandardTypeID = ''S07''
LEFT JOIN AT0128 A28 WITH (NOLOCK) ON A28.StandardID = MT0137.DS08ID AND A28.StandardTypeID = ''S08''
LEFT JOIN AT0128 A29 WITH (NOLOCK) ON A29.StandardID = MT0137.DS09ID AND A29.StandardTypeID = ''S09''
LEFT JOIN AT0128 A30 WITH (NOLOCK) ON A30.StandardID = MT0137.DS10ID AND A30.StandardTypeID = ''S10''
LEFT JOIN AT0128 A31 WITH (NOLOCK) ON A31.StandardID = MT0137.DS11ID AND A31.StandardTypeID = ''S11''
LEFT JOIN AT0128 A32 WITH (NOLOCK) ON A32.StandardID = MT0137.DS12ID AND A32.StandardTypeID = ''S12''
LEFT JOIN AT0128 A33 WITH (NOLOCK) ON A33.StandardID = MT0137.DS13ID AND A33.StandardTypeID = ''S13''
LEFT JOIN AT0128 A34 WITH (NOLOCK) ON A34.StandardID = MT0137.DS14ID AND A34.StandardTypeID = ''S14''
LEFT JOIN AT0128 A35 WITH (NOLOCK) ON A35.StandardID = MT0137.DS15ID AND A35.StandardTypeID = ''S15''
LEFT JOIN AT0128 A36 WITH (NOLOCK) ON A36.StandardID = MT0137.DS16ID AND A36.StandardTypeID = ''S16''
LEFT JOIN AT0128 A37 WITH (NOLOCK) ON A37.StandardID = MT0137.DS17ID AND A37.StandardTypeID = ''S17''
LEFT JOIN AT0128 A38 WITH (NOLOCK) ON A38.StandardID = MT0137.DS18ID AND A38.StandardTypeID = ''S18''
LEFT JOIN AT0128 A39 WITH (NOLOCK) ON A39.StandardID = MT0137.DS19ID AND A39.StandardTypeID = ''S19''
LEFT JOIN AT0128 A40 WITH (NOLOCK) ON A40.StandardID = MT0137.DS20ID AND A40.StandardTypeID = ''S20'''

SET @sSQL3 = '
LEFT JOIN (SELECT * FROM  (SELECT UserName, TypeID, DivisionID
		                   FROM AT0005 WITH (NOLOCK) WHERE TypeID LIKE ''S__'') b 
						   PIVOT (max(Username) for TypeID IN (S01, S02, S03, S04, S05, S06, S07, S08, S09, S10,
															S11, S12, S13, S14, S15, S16, S17, S18, S19, S20))  AS a) a ON a.DivisionID IN (MT0137.DivisionID,''@@@'')'

SET @sSQL4 = '
WHERE MT0135.ApportionID = '''+@ApportionID+'''
		AND MT0135.DivisionID = '''+@DivisionID+'''
Group by MT0137.DivisionID, MT0135.DivisionID, MT0135.ApportionID, MT0135.[Description], MT0135.ObjectID, AT1202.ObjectName,MT0135.InventoryTypeID,AT1301.InventoryTypeName, MT0135.[Disabled], MT0135.ApportionTypeID,
MT0135.IsBOM, MT0136.TransactionID, MT0136.ProductID,AT1302.InventoryName, MT0136.UnitID, MT0136.ProductQuantity,MT0136.S01ID, MT0136.S02ID, MT0136.S03ID, MT0136.S04ID, MT0136.S05ID,
MT0136.S06ID, MT0136.S07ID, MT0136.S08ID, MT0136.S09ID, MT0136.S10ID, MT0136.S11ID, MT0136.S12ID, MT0136.S13ID, MT0136.S14ID, MT0136.S15ID,
MT0136.S16ID, MT0136.S17ID, MT0136.S18ID, MT0136.S19ID, MT0136.S20ID,
MT0137.ProductID,	ProductQuantity, MT0136.TransactionID, MT0136.Parameter01, MT0136.Parameter02, MT0136.Parameter03, MT0137.ReTransactionID, MT0136.Orders,
MT0137.MaterialID, A50.InventoryName, MT0137.MaterialUnitID, A50.InventoryTypeID, MT0137.MaterialQuantity, MT0137.MaterialPrice, MT0137.MaterialAmount,							
MT0137.Rate, MT0137.RateDecimalApp, MT0137.ExpenseID, MT0137.IsExtraMaterial, MT0137.WasteID, MT0137.MaterialGroupID, MT0137.QuantityUnit,
MT0137.[Description], MT0137.DParameter01, MT0137.DParameter02, MT0137.DParameter03,
MT0137.DS01ID, MT0137.DS02ID, MT0137.DS03ID, MT0137.DS04ID, MT0137.DS05ID, MT0137.DS06ID, MT0137.DS07ID, MT0137.DS08ID, MT0137.DS09ID, MT0137.DS10ID,
MT0137.DS11ID, MT0137.DS12ID, MT0137.DS13ID, MT0137.DS14ID, MT0137.DS15ID, MT0137.DS16ID, MT0137.DS17ID, MT0137.DS18ID, MT0137.DS19ID, MT0137.DS20ID,

A01.StandardName, A02.StandardName, A03.StandardName, A04.StandardName, A05.StandardName,
A06.StandardName, A07.StandardName, A08.StandardName, A09.StandardName, A10.StandardName,
A11.StandardName, A12.StandardName, A13.StandardName, A14.StandardName, A15.StandardName,
A16.StandardName, A17.StandardName, A18.StandardName, A19.StandardName, A20.StandardName,
 
A21.StandardName, A22.StandardName, A23.StandardName, A24.StandardName, A25.StandardName,
A26.StandardName, A27.StandardName, A28.StandardName, A29.StandardName, A20.StandardName,
A31.StandardName, A32.StandardName, A33.StandardName, A34.StandardName, A35.StandardName,
A36.StandardName, A37.StandardName, A38.StandardName, A39.StandardName, A40.StandardName,
a.S01, a.S02, a.S03, a.S04, a.S05, a.S06, a.S07, a.S08, a.S09, a.S10,
a.S11, a.S12, a.S13, a.S14, a.S15, a.S16, a.S17, a.S18, a.S19, a.S20,
MT0136.Begin_ProductQuantity,
MT0137.Begin_MaterialQuantity,
MT0137.Begin_MaterialPrice,
MT0137.Begin_RateDecimalApp,
MT0137.Begin_MaterialAmount,
MT0137.Begin_QuantityUnit,
MT0137.Begin_ConvertedUnit
Order by MT0136.Orders
' 
EXEC (@sSQL + @sSQL1 + @sSQL2 + @sSQL3 + @sSQL4)
--PRINT @sSQL
--PRINT @sSQL1
--PRINT @sSQL2
--PRINT @sSQL3


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
