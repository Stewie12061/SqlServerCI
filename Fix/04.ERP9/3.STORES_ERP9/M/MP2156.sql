IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2156]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2156]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
--- Đối chiếu NVL khi thay đổi combobox MaterialID
-- <Param> DivisionID
-- <Param> InventoryID
-- <Param> MaterialID
-- <Param> S01ID
-- <Param> S02ID
-- <Param> S03ID
-- <Param> S04ID
-- <Param> S05ID
-- <Param> S06ID
-- <Param> S07ID
-- <Param> S08ID
-- <Param> S09ID
-- <Param> S10ID
-- <Param> S11ID
-- <Param> S12ID
-- <Param> S13ID
-- <Param> S14ID
-- <Param> S15ID
-- <Param> S16ID
-- <Param> S17ID
-- <Param> S18ID
-- <Param> S19ID
-- <Param> S20ID
-- <Param> TranMonth
-- <Param> TranYear
-- <Param> listWareHouseID
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Trọng Kiên	Create on: 15/03/2021
---- Update by: Kiều Nga on 08/02/2022 : Fix lỗi load lại tab đối chiếu khi thay đổi nvl thay thế


Create PROCEDURE [dbo].[MP2156]
(
    @DivisionID VARCHAR(50),
	@InventoryID VARCHAR(50),
	@MaterialQuantity DECIMAL(28,8) = 0,
	@MaterialID VARCHAR(50),
	@S01ID VARCHAR(50),
	@S02ID VARCHAR(50),
	@S03ID VARCHAR(50),
	@S04ID VARCHAR(50),
	@S05ID VARCHAR(50),
	@S06ID VARCHAR(50),
	@S07ID VARCHAR(50),
	@S08ID VARCHAR(50),
	@S09ID VARCHAR(50),
	@S10ID VARCHAR(50),
	@S11ID VARCHAR(50),
	@S12ID VARCHAR(50),
	@S13ID VARCHAR(50),
	@S14ID VARCHAR(50),
	@S15ID VARCHAR(50),
	@S16ID VARCHAR(50),
	@S17ID VARCHAR(50),
	@S18ID VARCHAR(50),
	@S19ID VARCHAR(50),
	@S20ID VARCHAR(50),
	@TranMonth VARCHAR(50),
	@TranYear VARCHAR(50),
	@listWareHouseID VARCHAR(MAX)
)
AS

DECLARE @sSQL NVARCHAR(MAX) = N'',
		@sSQL01 NVARCHAR(MAX) = N'',
		@sSQL02 NVARCHAR(MAX) = N'',
		@OrderBy NVARCHAR(MAX) = N'', 
		@TotalRow NVARCHAR(50) = N'',
		@sWhere NVARCHAR(MAX) = N'',
		@CheckQC INT,
		@CustomerIndex INT = (SELECT CustomerName FROM CustomerIndex)

IF (@CustomerIndex IN (117,158)) -- Khách hàng MAITHU và HIPC
BEGIN
SET @sWhere = N' M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND M10.NodeID = '''+@MaterialID+''' AND M1.InventoryID ='''+@InventoryID+''' --AND O1.TranMonth = '+@TranMonth+' AND O1.TranYear = '+@TranYear+' --AND A1.WareHouseID IN ('''+@listWareHouseID+''')
				 AND ISNULL(O1.DS02ID, '''') = '''+@S02ID+''' AND ISNULL(O1.DS03ID, '''') = '''+@S03ID+''' AND ISNULL(O1.DS04ID, '''') = '''+@S04ID+''' AND ISNULL(O1.DS05ID, '''') = '''+@S05ID+''' AND ISNULL(O1.DS06ID, '''') = '''+@S06ID+''' 
				 AND ISNULL(O1.DS07ID, '''') = '''+@S07ID+''' AND ISNULL(O1.DS08ID, '''') = '''+@S08ID+''' AND ISNULL(O1.DS09ID, '''') = '''+@S09ID+''' AND ISNULL(O1.DS10ID, '''') = '''+@S10ID+''' AND ISNULL(O1.DS11ID, '''') = '''+@S11ID+'''
				 AND ISNULL(O1.DS16ID, '''') = '''+@S16ID+''' AND ISNULL(O1.DS17ID, '''') = '''+@S17ID+''' AND ISNULL(O1.DS18ID, '''') = '''+@S18ID+''' AND ISNULL(O1.DS20ID, '''') = '''+@S12ID+''' AND ISNULL(O1.DS01ID, '''') = '''+@S01ID+'''
				 AND ISNULL(O1.DS12ID, '''') = '''+@S12ID+''' AND ISNULL(O1.DS13ID, '''') = '''+@S13ID+''' AND ISNULL(O1.DS14ID, '''') = '''+@S14ID+''' AND ISNULL(O1.DS15ID, '''') = '''+@S15ID+''''

SET @sSQL = 'SELECT X.* 
			INTO #TempMP2156 
			FROM (SELECT  ISNULL((O1.MaterialQuantity), 0) AS QuantityInherit, ISNULL((A1.EndQuantity), 0) AS EndQuantity, ISNULL((A2.MinQuantity), 0) AS SafeQuantity
					, (ISNULL((O2.OrderQuantity), 0) - ISNULL((A3.ActualQuantity), 0)) AS PickingQuantity
					, ISNULL((A4.ActualQuantity), 0) AS ActualQuantityInherit
			 FROM OT2002 M1 WITH(NOLOCK)
			 LEFT JOIN OT2001 M2 WITH(NOLOCK) ON M2.SOrderID = M1.SOrderID AND M2.OrderType = 1 AND M2.DivisionID = M1.DivisionID
			 LEFT JOIN OT2002 M3 WITH(NOLOCK) ON  M3.InventoryID = M1.InventoryID AND CONVERT(VARCHAR(50),M3.APK) = M1.InheritVoucherID AND M3.DivisionID = M1.DivisionID
			 LEFT JOIN OT2102 M4 WITH(NOLOCK) ON  M4.QuotationID = M3.InheritVoucherID AND  M4.TransactionID = M3.QuotationID AND  M4.InventoryID = M3.InventoryID AND M4.DivisionID = M1.DivisionID
			 LEFT JOIN SOT2110 M5 WITH(NOLOCK) ON M5.DivisionID = M1.DivisionID AND M4.InheritVoucherID = CONVERT(VARCHAR(50),M5.APK) AND M4.InventoryID = M5.InventoryID
			 LEFT JOIN SOT2112 M6 WITH(NOLOCK) ON M6.DivisionID = M1.DivisionID AND M5.APK = M6.APKMaster
			 LEFT JOIN AT1302 M7 WITH(NOLOCK) ON M6.NodeID = M7.InventoryID AND M7.DivisionID IN (M1.DivisionID, ''@@@'')
			 LEFT JOIN AT1304 M8 WITH (NOLOCK) ON M6.UnitID = M8.UnitID AND M8.DivisionID IN (M1.DivisionID, ''@@@'')
			 LEFT JOIN MT2120 M9 WITH (NOLOCK) ON M5.InventoryID = M9.NodeID AND M5.APK_InheritBOM = CONVERT(varchar(50), M9.APK) AND M9.DivisionID = M5.DivisionID
			 LEFT JOIN MT2121 M10 WITH (NOLOCK) ON M9.APK = M10.APKMaster AND M10.MaterialID = M6.NodeID AND M10.DivisionID = M9.DivisionID
			 LEFT JOIN AT1302 M11 WITH (NOLOCK) ON M10.MaterialID = M11.InventoryID AND M11.DivisionID IN (M10.DivisionID,''@@@'')
			 LEFT JOIN OT3002 O2 WITH (NOLOCK) ON M6.NodeID = O2.InventoryID AND O2.TransactionID IS NOT NULL
			 LEFT JOIN AT2007 A3 WITH (NOLOCK) ON A3.InheritTransactionID = O2.APK AND O2.Status = 1 AND A3.TranMonth = '+@TranMonth+' AND A3.TranYear =  '+@TranMonth+'
			 LEFT JOIN OT2203 O1 WITH (NOLOCK) ON M6.NodeID = O1.MaterialID AND M5.InventoryID = O1.ProductID
				 LEFT JOIN AT2008_QC A1 WITH (NOLOCK) ON A1.InventoryID = O1.MaterialID AND A1.WareHouseID IN ('''+@listWareHouseID+''') AND O1.TranMonth = '+@TranMonth+'
													AND A1.TranYear = '+@TranYear+'AND A1.S01ID = O1.S01ID AND A1.S02ID = O1.S02ID AND A1.S03ID = O1.S03ID
													AND A1.S04ID = O1.S04ID AND A1.S05ID = O1.S05ID AND A1.S06ID = O1.S06ID AND A1.S07ID = O1.S07ID
													AND A1.S08ID = O1.S08ID AND A1.S09ID = O1.S09ID AND A1.S10ID = O1.S10ID AND A1.S11ID = O1.S11ID
													AND A1.S16ID = O1.S16ID AND A1.S17ID = O1.S17ID AND A1.S18ID = O1.S19ID AND A1.S20ID = O1.S20ID
													AND A1.S12ID = O1.S12ID AND A1.S13ID = O1.S13ID AND A1.S14ID = O1.S14ID AND A1.S15ID = O1.S15ID
			 	 LEFT JOIN AT1314 A2 WITH (NOLOCK) ON O1.MaterialID = A2.InventoryID AND A2.WareHouseID IN ('''+@listWareHouseID+''') AND A2.TranMonth = '+@TranMonth+'
													AND O1.TranYear = '+@TranYear+' AND O1.S01ID = A2.S01ID AND O1.S02ID = A2.S02ID AND O1.S03ID = A2.S03ID
													AND O1.S04ID = A2.S04ID AND O1.S05ID = A2.S05ID AND O1.S06ID = A2.S06ID AND O1.S07ID = A2.S07ID
													AND O1.S08ID = A2.S08ID AND O1.S09ID = A2.S09ID AND O1.S10ID = A2.S10ID AND O1.S11ID = A2.S11ID
													AND O1.S16ID = A2.S16ID AND O1.S17ID = A2.S17ID AND O1.S18ID = A2.S19ID AND O1.S20ID = A2.S20ID
													AND O1.S12ID = A2.S12ID AND O1.S13ID = A2.S13ID AND O1.S14ID = A2.S14ID AND O1.S15ID = A2.S15ID'

SET @sSQL01 = ' 
				 LEFT JOIN AT2007 A4 WITH (NOLOCK) ON A4.ETransactionID = O1.TransactionID AND A4.TranMonth = '+@TranMonth+' AND A4.TranYear = '+@TranMonth+'
				 WHERE '+@sWhere+'
                 GROUP BY O1.MaterialQuantity,A1.EndQuantity,A2.MinQuantity,O2.OrderQuantity,A3.ActualQuantity,A4.ActualQuantity 

			 UNION ALL
			 SELECT  ISNULL((O1.MaterialQuantity), 0) AS QuantityInherit, ISNULL((A1.EndQuantity), 0) AS EndQuantity, ISNULL((A2.MinQuantity), 0) AS SafeQuantity
					, (ISNULL((O2.OrderQuantity), 0) - ISNULL((A3.ActualQuantity), 0)) AS PickingQuantity
					, ISNULL((A4.ActualQuantity), 0) AS ActualQuantityInherit
			 FROM OT2002 M1 WITH(NOLOCK)
			 LEFT JOIN OT2001 M2 WITH(NOLOCK) ON M2.SOrderID = M1.SOrderID AND M2.OrderType = 1 AND M2.DivisionID = M1.DivisionID
				CROSS APPLY
				(
					SELECT *
					FROM MT2120 MT20
					WHERE 
						MT20.DivisionID = M1.DivisionID
						AND MT20.APK = (SELECT TOP 1 APK 
										FROM MT2120 T20
										WHERE T20.DivisionID = M1.DivisionID
											AND T20.NodeID = M1.InventoryID)
				) M9
			 LEFT JOIN MT2121 M10 WITH (NOLOCK) ON M9.APK = M10.APK_2120 AND M10.DivisionID = M9.DivisionID AND M10.NodeTypeID <> 0
			 LEFT JOIN AT1302 M11 WITH (NOLOCK) ON M10.NodeID = M11.InventoryID AND M11.DivisionID IN (M10.DivisionID,''@@@'')
			 LEFT JOIN AT1304 M8 WITH (NOLOCK) ON M10.UnitID = M8.UnitID AND M8.DivisionID IN (M11.DivisionID, ''@@@'')
			 LEFT JOIN OT3002 O2 WITH (NOLOCK) ON M10.NodeID = O2.InventoryID AND O2.TransactionID IS NOT NULL
			 LEFT JOIN AT2007 A3 WITH (NOLOCK) ON A3.InheritTransactionID = O2.APK AND O2.Status = 1 AND A3.TranMonth = '+@TranMonth+' AND A3.TranYear =  '+@TranMonth+'
			 LEFT JOIN OT2203 O1 WITH (NOLOCK) ON M10.NodeID = O1.MaterialID AND M9.NodeID = O1.ProductID
				 LEFT JOIN AT2008_QC A1 WITH (NOLOCK) ON A1.InventoryID = O1.MaterialID AND A1.WareHouseID IN ('''+@listWareHouseID+''') AND O1.TranMonth = '+@TranMonth+'
													AND A1.TranYear = '+@TranYear+'AND A1.S01ID = O1.S01ID AND A1.S02ID = O1.S02ID AND A1.S03ID = O1.S03ID
													AND A1.S04ID = O1.S04ID AND A1.S05ID = O1.S05ID AND A1.S06ID = O1.S06ID AND A1.S07ID = O1.S07ID
													AND A1.S08ID = O1.S08ID AND A1.S09ID = O1.S09ID AND A1.S10ID = O1.S10ID AND A1.S11ID = O1.S11ID
													AND A1.S16ID = O1.S16ID AND A1.S17ID = O1.S17ID AND A1.S18ID = O1.S19ID AND A1.S20ID = O1.S20ID
													AND A1.S12ID = O1.S12ID AND A1.S13ID = O1.S13ID AND A1.S14ID = O1.S14ID AND A1.S15ID = O1.S15ID
			 	 LEFT JOIN AT1314 A2 WITH (NOLOCK) ON O1.MaterialID = A2.InventoryID AND A2.WareHouseID IN ('''+@listWareHouseID+''') AND A2.TranMonth = '+@TranMonth+'
													AND O1.TranYear = '+@TranYear+' AND O1.S01ID = A2.S01ID AND O1.S02ID = A2.S02ID AND O1.S03ID = A2.S03ID
													AND O1.S04ID = A2.S04ID AND O1.S05ID = A2.S05ID AND O1.S06ID = A2.S06ID AND O1.S07ID = A2.S07ID
													AND O1.S08ID = A2.S08ID AND O1.S09ID = A2.S09ID AND O1.S10ID = A2.S10ID AND O1.S11ID = A2.S11ID
													AND O1.S16ID = A2.S16ID AND O1.S17ID = A2.S17ID AND O1.S18ID = A2.S19ID AND O1.S20ID = A2.S20ID
													AND O1.S12ID = A2.S12ID AND O1.S13ID = A2.S13ID AND O1.S14ID = A2.S14ID AND O1.S15ID = A2.S15ID
				 LEFT JOIN AT2007 A4 WITH (NOLOCK) ON A4.ETransactionID = O1.TransactionID AND A4.TranMonth = '+@TranMonth+' AND A4.TranYear = '+@TranMonth+''

SET @sSQL02 = '
				 WHERE '+@sWhere+'
                 GROUP BY O1.MaterialQuantity,A1.EndQuantity,A2.MinQuantity,O2.OrderQuantity,A3.ActualQuantity,A4.ActualQuantity) X 

				IF NOT EXISTS (SELECT TOP 1 1 FROM #TempMP2156)
				BEGIN
					SELECT 0 as QuantityInherit,0 as EndQuantity,0 as SafeQuantity,0 as PickingQuantity,0 as ActualQuantityInherit
				END
				ELSE
				BEGIN
					SELECT QuantityInherit,EndQuantity,SafeQuantity,SUM(PickingQuantity) as PickingQuantity,ActualQuantityInherit
					FROM #TempMP2156
					GROUP BY QuantityInherit,EndQuantity,SafeQuantity,ActualQuantityInherit
				END'	
			
EXEC (@sSQL + @sSQL01 +@sSQL02)
PRINT (@sSQL)
PRINT (@sSQL01)
PRINT (@sSQL02)
END
ELSE
BEGIN
SET @sWhere = N' M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND M10.NodeID = '''+@MaterialID+''' AND M1.InventoryID ='''+@InventoryID+''' --AND O1.TranMonth = '+@TranMonth+' AND O1.TranYear = '+@TranYear+' --AND A1.WareHouseID IN ('''+@listWareHouseID+''')
				 AND ISNULL(O1.DS02ID, '''') = '''+@S02ID+''' AND ISNULL(O1.DS03ID, '''') = '''+@S03ID+''' AND ISNULL(O1.DS04ID, '''') = '''+@S04ID+''' AND ISNULL(O1.DS05ID, '''') = '''+@S05ID+''' AND ISNULL(O1.DS06ID, '''') = '''+@S06ID+''' 
				 AND ISNULL(O1.DS07ID, '''') = '''+@S07ID+''' AND ISNULL(O1.DS08ID, '''') = '''+@S08ID+''' AND ISNULL(O1.DS09ID, '''') = '''+@S09ID+''' AND ISNULL(O1.DS10ID, '''') = '''+@S10ID+''' AND ISNULL(O1.DS11ID, '''') = '''+@S11ID+'''
				 AND ISNULL(O1.DS16ID, '''') = '''+@S16ID+''' AND ISNULL(O1.DS17ID, '''') = '''+@S17ID+''' AND ISNULL(O1.DS18ID, '''') = '''+@S18ID+''' AND ISNULL(O1.DS20ID, '''') = '''+@S12ID+''' AND ISNULL(O1.DS01ID, '''') = '''+@S01ID+'''
				 AND ISNULL(O1.DS12ID, '''') = '''+@S12ID+''' AND ISNULL(O1.DS13ID, '''') = '''+@S13ID+''' AND ISNULL(O1.DS14ID, '''') = '''+@S14ID+''' AND ISNULL(O1.DS15ID, '''') = '''+@S15ID+''''
SET @sWhere = N''

SET @sSQL = 'SELECT ''' + @InventoryID + ''' AS InventoryID 
					, ''' + @MaterialID + ''' AS MaterialID
					, ISNULL(O2.MaterialQuantity, 0) AS QuantityInherit, ISNULL (A8.ActualQuantity, 0) AS ActualQuantityInherit
					,(ISNULL(O1.OrderQuantity, 0) - ISNULL(A7.ActualQuantity, 0)) AS PickingQuantity
					--Tồn kho an toàn
					, ISNULL(SUM(A6.MinQuantity), 0) AS MinQuantity
					--Tồn kho thực tế
					, ISNULL(SUM(A5.EndQuantity), 0) AS EndQuantity
					--Số Lượng
					, '+LTRIM(@MaterialQuantity)+' AS Quantity

					INTO #TempMP2155
					FROM AT1302 M1 WITH(NOLOCK)
						LEFT JOIN OT2203 O2 WITH (NOLOCK) ON M1.InventoryID = O2.MaterialID AND O2.ProductID = ''' + @InventoryID + '''
						LEFT JOIN AT2007 A8 WITH (NOLOCK) ON A8.ETransactionID = O2.TransactionID AND A8.TranMonth = '+@TranMonth+'	AND A8.TranYear = '+@TranYear+'
						LEFT JOIN OT3002 O1 WITH (NOLOCK) ON M1.InventoryID = O1.InventoryID AND O1.TransactionID IS NOT NULL
						LEFT JOIN AT2007 A7 WITH (NOLOCK) ON A7.InheritTransactionID = O1.APK AND O1.Status = 1 AND A7.TranMonth = '+@TranMonth+'	AND A7.TranYear =    '+@TranYear+'
						LEFT JOIN AT1314 A6 WITH (NOLOCK) ON M1.InventoryID = A6.InventoryID AND A6.WareHouseID IN ('''+@listWareHouseID+''') 
														--AND A6.TranMonth = '+@TranMonth+' AND A6.TranYear = '+@TranYear+' 
						LEFT JOIN AT2008 A5 WITH (NOLOCK) ON M1.InventoryID = A5.InventoryID AND A5.WareHouseID IN ('''+@listWareHouseID+''') 
													AND A5.TranMonth = '+@TranMonth+' AND A5.TranYear = '+@TranYear+'
		
					WHERE M1.InventoryID IS NOT NULL AND M1.InventoryID = ''' + @MaterialID + ''' '+ @sWhere +'

					GROUP BY M1.InventoryID, O1.OrderQuantity, A7.ActualQuantity, O2.MaterialQuantity, A8.ActualQuantity'

SET @sSQL01 = ' --------------#TempMP2155--------------
				SELECT  MaterialID
						, QuantityInherit, ActualQuantityInherit, SUM(PickingQuantity) AS PickingQuantity
						, MinQuantity AS SafeQuantity
						, IIF(EndQuantity < 0, 0, EndQuantity) AS EndQuantity
						, Quantity AS MaterialQuantity
				INTO #TempMP2155_1
				FROM #TempMP2155
				GROUP BY  MaterialID
							, QuantityInherit, ActualQuantityInherit
							, MinQuantity, EndQuantity, Quantity
				
				--------------#TempMP2155_1--------------
				SELECT  MaterialID
						, SUM(QuantityInherit) AS QuantityInherit, ActualQuantityInherit, PickingQuantity
						, SafeQuantity
						, EndQuantity
						, MaterialQuantity
				INTO #TempMP2155_2
				FROM #TempMP2155_1
				GROUP BY  MaterialID
						, ActualQuantityInherit, PickingQuantity
						, SafeQuantity, EndQuantity, MaterialQuantity

				--------------#TempMP2155_2--------------
				SELECT  MaterialID
						, QuantityInherit, SUM(ActualQuantityInherit) AS ActualQuantityInherit, PickingQuantity
						, SafeQuantity
						, EndQuantity
						, MaterialQuantity
						, (QuantityInherit + (MaterialQuantity - SUM(ActualQuantityInherit))) AS IntendedPickingQuantity
						, (MaterialQuantity - EndQuantity + (QuantityInherit + (MaterialQuantity - SUM(ActualQuantityInherit))) + SafeQuantity - PickingQuantity) AS SuggestQuantity
				INTO #TempMP2155_3
				FROM #TempMP2155_2
				GROUP BY MaterialID
						, QuantityInherit, PickingQuantity
						, SafeQuantity, EndQuantity, MaterialQuantity

				--------------#TempMP2155_3--------------
				SELECT  MaterialID
						,QuantityInherit, ActualQuantityInherit, SUM(ISNULL(PickingQuantity,0)) AS PickingQuantity
						--Tồn kho an toàn
						, SafeQuantity
						--Tồn kho thực tế
						,EndQuantity
						--Số Lượng
						, MaterialQuantity
						--Đơn hàng mua đã duyệt
						, IntendedPickingQuantity
						--Gợi ý mua hàng
						, IIF(SUM(ISNULL(SuggestQuantity,0)) < 0, 0, SUM(ISNULL(SuggestQuantity,0))) AS SuggestQuantity
				FROM #TempMP2155_3
				GROUP BY MaterialID
					 , QuantityInherit, ActualQuantityInherit
					 , SafeQuantity, EndQuantity, MaterialQuantity, IntendedPickingQuantity'

SET @sSQL02 = ''	
			
EXEC (@sSQL + @sSQL01 +@sSQL02)
PRINT (@sSQL)
PRINT (@sSQL01)
PRINT (@sSQL02)
END






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
