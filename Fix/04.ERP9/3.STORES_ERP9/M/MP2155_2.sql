IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2155_2]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2155_2]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Đối chiếu NVL khi thay đổi combobox MaterialID
-- <Param> DivisionID
-- <Param> MaterialQuantity
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
---- Created by: Đức Tuyên	Create on: 28/03/2023


Create PROCEDURE [dbo].[MP2155_2]
(
    @DivisionID VARCHAR(50),
	@MaterialQuantity DECIMAL(28,8) = 0,
	@MaterialID VARCHAR(50),
	@S01ID VARCHAR(50) = '',
	@S02ID VARCHAR(50) = '',
	@S03ID VARCHAR(50) = '',
	@S04ID VARCHAR(50) = '',
	@S05ID VARCHAR(50) = '',
	@S06ID VARCHAR(50) = '',
	@S07ID VARCHAR(50) = '',
	@S08ID VARCHAR(50) = '',
	@S09ID VARCHAR(50) = '',
	@S10ID VARCHAR(50) = '',
	@S11ID VARCHAR(50) = '',
	@S12ID VARCHAR(50) = '',
	@S13ID VARCHAR(50) = '',
	@S14ID VARCHAR(50) = '',
	@S15ID VARCHAR(50) = '',
	@S16ID VARCHAR(50) = '',
	@S17ID VARCHAR(50) = '',
	@S18ID VARCHAR(50) = '',
	@S19ID VARCHAR(50) = '',
	@S20ID VARCHAR(50) = '',
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
SET @sWhere = N''
SET @sSQL = N''
SET @sSQL01 = N''
SET @sSQL02 = N''		

EXEC (@sSQL + @sSQL01 +@sSQL02)
PRINT (@sSQL)
PRINT (@sSQL01)
PRINT (@sSQL02)
END
ELSE
BEGIN
SET @sWhere = N'
				AND ISNULL(O1.DS01ID, '''') = '''+@S01ID+''' AND ISNULL(O1.DS02ID, '''') = '''+@S02ID+''' AND ISNULL(O1.DS03ID, '''') = '''+@S03ID+''' AND ISNULL(O1.DS04ID, '''') = '''+@S04ID+''' AND ISNULL(O1.DS05ID, '''') = '''+@S05ID+''' 
				AND ISNULL(O1.DS06ID, '''') = '''+@S06ID+''' AND ISNULL(O1.DS07ID, '''') = '''+@S07ID+''' AND ISNULL(O1.DS08ID, '''') = '''+@S08ID+''' AND ISNULL(O1.DS09ID, '''') = '''+@S09ID+''' AND ISNULL(O1.DS10ID, '''') = '''+@S10ID+''' 
				AND ISNULL(O1.DS11ID, '''') = '''+@S11ID+''' AND ISNULL(O1.DS20ID, '''') = '''+@S12ID+''' AND ISNULL(O1.DS12ID, '''') = '''+@S13ID+''' AND ISNULL(O1.DS14ID, '''') = '''+@S14ID+''' AND ISNULL(O1.DS15ID, '''') = '''+@S15ID+'''
				AND ISNULL(O1.DS16ID, '''') = '''+@S16ID+''' AND ISNULL(O1.DS17ID, '''') = '''+@S17ID+''' AND ISNULL(O1.DS18ID, '''') = '''+@S18ID+''' AND ISNULL(O1.DS19ID, '''') = '''+@S19ID+''' AND ISNULL(O1.DS20ID, '''') = '''+@S20ID+''' 
				'
SET @sWhere = N''

SET @sSQL = 'SELECT ''' + @MaterialID + ''' AS MaterialID

					--Tồn kho an toàn
					, (SELECT TOP 1 (ISNULL(A6.MinQuantity,0)) 
						FROM AT1314 A6 WITH (NOLOCK) 
						WHERE	A6.InventoryID = ''' + @MaterialID + ''' 
								AND A6.WareHouseID IN ('''+@listWareHouseID+''') 
								--AND A6.TranMonth = '+@TranMonth+' AND A6.TranYear = '+@TranYear+'
					) AS MinQuantity
					
					--Tồn kho thực tế
					, ISNULL((SELECT SUM(ISNULL((A5.ActualQuantity),0)) 
						FROM AV7000 A5 WITH (NOLOCK) 
						WHERE	A5.DivisionID IN (''@@@'', ''' + @DivisionID + ''')
								AND A5.InventoryID = A02.InventoryID 
								AND A5.WareHouseID IN ('''+@listWareHouseID+''')  
					),0) AS EndQuantity

					--Số lượng đã giữ chổ trước đó
					, ISNULL(SUM(OT03.MaterialQuantity), 0) AS QuantityInherit
					
					--Số Lượng hiện tại
					, '+LTRIM(@MaterialQuantity)+' AS Quantity

					--Số lượng NLV đã xuất kho
					, ISNULL((
						SELECT SUM(ISNULL(A07.ActualQuantity,0)) FROM AT2007 A07
							LEFT JOIN MT2161 M61 ON M61.APK  = A07.APKMT2161
							LEFT JOIN MT2160 M60 ON M60.APK = M61.APKMaster
							LEFT JOIN OT2201 OT01 ON OT01.VoucherNo = M60.MOrderID
						WHERE A07.InheritTableID = ''MT2161'' 
							AND A07.InventoryID = '''+@MaterialID +''' 
							AND A07.TranMonth<= '+@TranMonth+' AND A07.TranYear<= '+@TranYear+' 
							AND OT01.OrderStatus NOT IN(2,3,4) 
					),0) AS ActualQuantityInherit

					--Đơn hàng đã duyệt mua
					, ISNULL((SELECT SUM(ISNULL(O1.OrderQuantity, 0)) 
								FROM OT3002 O1 WITH (NOLOCK) 
								WHERE	O1.InventoryID = ''' + @MaterialID + ''' 
										AND  O1.TransactionID IS NOT NULL 
										AND O1.Status = 1
					), 0) AS PickingQuantity

					INTO #TempMP2155

					From AT1302 A02 WITH (NOLOCK)
						--Số lượng giữ chổ dụ trù trước đó
						LEFT JOIN OT2201 OT01 WITH (NOLOCK) ON OT01.DivisionID = A02.DivisionID
																AND OT01.OrderStatus NOT IN(2,3,4) 
						LEFT JOIN OT2202 OT02 WITH (NOLOCK) ON OT01.DivisionID = OT02.DivisionID
																AND OT01.VoucherNo = OT02.EstimateID 
																AND OT02.APKMaster = OT01.APK
						LEFT JOIN OT2203 OT03 WITH (NOLOCK) ON OT01.DivisionID = OT03.DivisionID
																AND OT03.APK_OT2202 = OT02.APK
																AND OT01.VoucherNo = OT03.EstimateID 
																AND (A02.InventoryID = OT03.SemiProduct OR A02.InventoryID = OT03.MaterialID)
																AND OT03.EstimateID IS NOT NULL

						
		
					WHERE	A02.DivisionID IN (''@@@'', ''' + @DivisionID + ''')
							AND A02.InventoryID = ''' + @MaterialID + '''
					GROUP BY A02.InventoryID'

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
						--, (QuantityInherit + (MaterialQuantity - SUM(ActualQuantityInherit))) AS IntendedPickingQuantity
						, (QuantityInherit - SUM(ActualQuantityInherit)) AS IntendedPickingQuantity
						--, (MaterialQuantity - EndQuantity + (QuantityInherit + (MaterialQuantity - SUM(ActualQuantityInherit))) + SafeQuantity - PickingQuantity) AS SuggestQuantity
						, ((QuantityInherit + (MaterialQuantity - SUM(ActualQuantityInherit))) - EndQuantity + SafeQuantity - PickingQuantity) AS SuggestQuantity
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
