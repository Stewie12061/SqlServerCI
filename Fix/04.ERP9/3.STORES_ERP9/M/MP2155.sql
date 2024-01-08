IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2155]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2155]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
--- Đối chiếu NVL
-- <Param> listAPK
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
---- Update by: Đình Hoà Date: 24/07/2021 : Tính dự trù khi kế thừa từ đơn hàng sản xuất
---- Update by: Kiều Nga Date: 07/02/2022 : Fix lỗi load tab đối chiếu
---- Update by: Đức Tuyên Date: 28/11/2022 : Điều chỉnh đối chiếu lấy BOM version mới nhất.
---- Update by: Kiều Nga Date: 11/01/2023 : Fix lỗi kế thừa thông tin sản xuất bị double dòng


Create PROCEDURE [dbo].[MP2155]
(
    @DivisionID VARCHAR(50),
	@listAPK VARCHAR(MAX),
	@TranMonth VARCHAR(50),
	@TranYear VARCHAR(50),
	@listWareHouseID VARCHAR(MAX),
	@ProductID VARCHAR(MAX) = '',
	@MOrderID VARCHAR(MAX) = '',
	@ProductQuantity DECIMAL(28,8) = 0,
	@APK_BomVersion VARCHAR(50) = '',
	@APK_OT2202 VARCHAR(50) = ''
)
AS

DECLARE @sSQL NVARCHAR(MAX) = N'',
		@sSQL01 NVARCHAR(MAX) = N'',
		@OrderBy NVARCHAR(MAX) = N'', 
		@TotalRow NVARCHAR(50) = N'',
		@sWhere NVARCHAR(MAX) = N'',
		@sLeftJoin01 NVARCHAR(MAX) = N'',
		@sLeftJoin02 NVARCHAR(MAX) = N'',
		@CheckQC INT

IF EXISTS(SELECT TOP 1 1 FROM CustomerIndex WHERE CustomerName = 117)
BEGIN
SET @sWhere = N' S2.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), S1.APKMaster) IN (''' + @listAPK + ''')
				GROUP BY S2.APK, S2.VoucherNo, S2.InventoryID, A3.InventoryName, S2.SemiProduct, S1.MaterialID, A1.InventoryName, S3.Length, S3.Width, S3.Height
				    , S1.UnitID, A2.UnitName, S1.S01ID, S1.S02ID, S1.S03ID, S1.S04ID, S1.S05ID, S1.S06ID, S1.S07ID
				    , S1.S08ID, S1.S09ID, S1.S10ID, S1.S11ID, S1.S12ID, S1.S13ID, S1.S14ID, S1.S15ID
				    , S1.S16ID, S1.S17ID, S1.S18ID, S1.S19ID, S1.S20ID, M2.MaterialGroupID, M2.MaterialID
					, A4.InventoryName, M2.QuantitativeTypeID, M2.QuantitativeValue, M2.MaterialConstant,O2.MaterialQuantity
				    , S1.Gsm, S1.Sheets, S1.Ram, S1.Kg, S1.M2, S1.PhaseOrder, O1.OrderQuantity, A7.ActualQuantity, A8.ActualQuantity
				'
SET @OrderBy = N' ORDER BY S2.VoucherNo, S1.PhaseOrder'

SET @CheckQC = (SELECT COUNT(A05.TypeID)
FROM AT0005 A05 With (NOLOCK)
WHERE (A05.DivisionID = '' + @DivisionID + '' or IsCommon =1) and IsUsed =1 
AND A05.TypeID LIKE 'S%')

IF @CheckQC > 0
	SET @sLeftJoin01 = N' LEFT JOIN AT2008_QC A5 WITH (NOLOCK) ON S1.MaterialID = A5.InventoryID AND A5.WareHouseID IN ('''+@listWareHouseID+''') AND A5.TranMonth = '+@TranMonth+'
																AND A5.TranYear = '+@TranYear+' AND S1.S01ID = ISNULL(A5.S01ID, '''') AND S1.S02ID = ISNULL(A5.S02ID, '''') AND S1.S03ID = ISNULL(A5.S03ID, '''')
																AND S1.S04ID = ISNULL(A5.S04ID, '''') AND S1.S05ID = ISNULL(A5.S05ID, '''') AND S1.S06ID = ISNULL(A5.S06ID, '''') AND S1.S07ID = ISNULL(A5.S07ID, '''')
																AND S1.S08ID = ISNULL(A5.S08ID, '''') AND S1.S09ID = ISNULL(A5.S09ID, '''') AND S1.S10ID = ISNULL(A5.S10ID, '''') AND S1.S11ID = ISNULL(A5.S11ID, '''')
																AND S1.S16ID = ISNULL(A5.S16ID, '''') AND S1.S17ID = ISNULL(A5.S17ID, '''') AND S1.S18ID = ISNULL(A5.S19ID, '''') AND S1.S20ID = ISNULL(A5.S20ID, '''')
																AND S1.S12ID = ISNULL(A5.S12ID, '''') AND S1.S13ID = ISNULL(A5.S13ID, '''') AND S1.S14ID = ISNULL(A5.S14ID, '''') AND S1.S15ID = ISNULL(A5.S15ID, '''')
						LEFT JOIN AT1314 A6 WITH (NOLOCK) ON S1.MaterialID = A6.InventoryID AND A6.WareHouseID IN ('''+@listWareHouseID+''') AND A6.TranMonth = '+@TranMonth+'
																AND A6.TranYear = '+@TranYear+' AND S1.S01ID = ISNULL(A6.S01ID, '''') AND S1.S02ID = ISNULL(A6.S02ID, '''') AND S1.S03ID = ISNULL(A6.S03ID, '''')
																AND S1.S04ID = ISNULL(A6.S04ID, '''') AND S1.S05ID = ISNULL(A6.S05ID, '''') AND S1.S06ID = ISNULL(A6.S06ID, '''') AND S1.S07ID = ISNULL(A6.S07ID, '''')
																AND S1.S08ID = ISNULL(A6.S08ID, '''') AND S1.S09ID = ISNULL(A6.S09ID, '''') AND S1.S10ID = ISNULL(A6.S10ID, '''') AND S1.S11ID = ISNULL(A6.S11ID, '''')
																AND S1.S16ID = ISNULL(A6.S16ID, '''') AND S1.S17ID = ISNULL(A6.S17ID, '''') AND S1.S18ID = ISNULL(A6.S19ID, '''') AND S1.S20ID = ISNULL(A6.S20ID, '''')
																AND S1.S12ID = ISNULL(A6.S12ID, '''') AND S1.S13ID = ISNULL(A6.S13ID, '''') AND S1.S14ID = ISNULL(A6.S14ID, '''') AND S1.S15ID = ISNULL(A6.S15ID, '''')
						LEFT JOIN OT3002 O1 WITH (NOLOCK) ON S1.MaterialID = O1.InventoryID AND O1.TransactionID IS NOT NULL
						LEFT JOIN AT2007 A7 WITH (NOLOCK) ON A7.InheritTransactionID = O1.APK AND O1.Status = 1 AND A7.TranMonth = '+@TranMonth+'	AND A7.TranYear = '+@TranYear+''
	SET @sLeftJoin02 = N' LEFT JOIN OT2203 O2 WITH (NOLOCK) ON S1.MaterialID = O2.MaterialID AND IIF(S2.SemiProduct <> '''', S2.SemiProduct, S2.InventoryID) = O2.ProductID
															 AND S1.S01ID = ISNULL(O2.DS01ID, '''') AND S1.S02ID = ISNULL(O2.DS02ID, '''') AND S1.S03ID = ISNULL(O2.DS03ID, '''')
															 AND S1.S04ID = ISNULL(O2.DS04ID, '''') AND S1.S05ID = ISNULL(O2.DS05ID, '''') AND S1.S06ID = ISNULL(O2.DS06ID, '''') AND S1.S07ID = ISNULL(O2.DS07ID, '''')
															 AND S1.S08ID = ISNULL(O2.DS08ID, '''') AND S1.S09ID = ISNULL(O2.DS09ID, '''') AND S1.S10ID = ISNULL(O2.DS10ID, '''') AND S1.S11ID = ISNULL(O2.DS11ID, '''')
															 AND S1.S16ID = ISNULL(O2.DS16ID, '''') AND S1.S17ID = ISNULL(O2.DS17ID, '''') AND S1.S18ID = ISNULL(O2.DS19ID, '''') AND S1.S20ID = ISNULL(O2.DS20ID, '''')
															 AND S1.S12ID = ISNULL(O2.DS12ID, '''') AND S1.S13ID = ISNULL(O2.DS13ID, '''') AND S1.S14ID = ISNULL(O2.DS14ID, '''') AND S1.S15ID = ISNULL(O2.DS15ID, '''')
						  LEFT JOIN AT2007 A8 WITH (NOLOCK) ON A8.ETransactionID = O2.TransactionID AND A8.TranMonth = '+@TranMonth+'	AND A8.TranYear = '+@TranYear+'
			 WHERE ' + @sWhere + @OrderBy

SET @sSQL = 'SELECT S2.APK, S2.VoucherNo, S2.InventoryID, A3.InventoryName, S2.SemiProduct, S1.MaterialID, A1.InventoryName AS MaterialName, S3.Length AS S01ID, S3.Width AS S02ID, S3.Height AS S03ID
				    , S1.UnitID, A2.UnitName, S1.S01ID AS DS01ID, S1.S02ID AS DS02ID, S1.S03ID AS DS03ID, S1.S04ID AS DS04ID, S1.S05ID AS DS05ID, S1.S06ID AS DS06ID, S1.S07ID AS DS07ID
				    , S1.S08ID AS DS08ID, S1.S09ID AS DS09ID, S1.S10ID AS DS10ID, S1.S11ID AS DS11ID, S1.S12ID AS DS12ID, S1.S13ID AS DS13ID, S1.S14ID AS DS14ID, S1.S15ID AS DS15ID
				    , S1.S16ID AS DS16ID, S1.S17ID AS DS17ID, S1.S18ID AS DS18ID, S1.S19ID AS DS19ID, S1.S20ID AS DS20ID, M2.MaterialGroupID, M2.MaterialID AS MaterialIDChange
					, A4.InventoryName AS MaterialNameChange, M2.QuantitativeTypeID, M2.QuantitativeValue, M2.MaterialConstant, ISNULL(SUM(A5.EndQuantity), 0) AS EndQuantity, ISNULL(O1.OrderQuantity, 0) AS OrderQuantity
					, ISNULL(A7.ActualQuantity, 0) AS ActualQuantity, (ISNULL(O1.OrderQuantity, 0) - ISNULL(A7.ActualQuantity, 0)) AS PickingQuantity, ISNULL(SUM(A6.MinQuantity), 0) AS MinQuantity
				    , ISNULL(CASE WHEN ISNULL(S1.Gsm, 0) <> 0 THEN S1.Gsm
						   WHEN ISNULL(S1.Sheets, 0) <> 0 THEN S1.Sheets
						   WHEN ISNULL(S1.Ram, 0) <> 0 THEN S1.Ram
						   WHEN ISNULL(S1.Kg, 0) <> 0 THEN S1.Kg
						   WHEN ISNULL(S1.M2, 0) <> 0 THEN S1.M2 END, 0) AS Quantity
					, ISNULL(O2.MaterialQuantity, 0) AS QuantityInherit, ISNULL(A8.ActualQuantity, 0) AS ActualQuantityInherit
			 INTO #TempMP2155
			 FROM SOT2082 S1 WITH (NOLOCK)
			 	 LEFT JOIN AT1302 A1 WITH (NOLOCK) ON S1.MaterialID = A1.InventoryID
			 	 LEFT JOIN AT1304 A2 WITH (NOLOCK) ON S1.UnitID = A2.UnitID
			 	 LEFT JOIN SOT2080 S2 WITH (NOLOCK) ON S1.APKMaster = S2.APK
			 	 LEFT JOIN SOT2081 S3 WITH (NOLOCK) ON S2.APK = S3.APKMaster
			 	 LEFT JOIN AT1302 A3 WITH (NOLOCK) ON S2.InventoryID = A3.InventoryID
				 LEFT JOIN MT2120 M1 WITH (NOLOCK) ON S2.InventoryID = M1.NodeID
				 LEFT JOIN MT2121 M2 WITH (NOLOCK) ON M1.APK = M2.APKMaster AND S1.MaterialID = M2.NodeID
				 LEFT JOIN AT1302 A4 WITH (NOLOCK) ON M2.MaterialID = A4.InventoryID'
			
SET @sSQL01 = N'  SELECT MaterialID, MaterialName, UnitID, UnitName, DS01ID AS S01ID, DS02ID AS S02ID, DS03ID AS S03ID, DS04ID AS S04ID, DS05ID AS S05ID, DS06ID AS S06ID, DS07ID AS S07ID
						, DS08ID AS S08ID, DS09ID AS S09ID, DS10ID AS S10ID, DS11ID AS S11ID, DS12ID AS S12ID, DS13ID AS S13ID, DS14ID AS S14ID, DS15ID AS S15ID
						, DS16ID AS S16ID, DS17ID AS S17ID, DS18ID AS S18ID, DS19ID AS S19ID, DS20ID AS S20ID, QuantityInherit
						, SUM(Quantity) AS MaterialQuantity, IIF(EndQuantity < 0, 0, EndQuantity) AS EndQuantity, ActualQuantityInherit
						, MinQuantity AS SafeQuantity, SUM(PickingQuantity) AS PickingQuantity
				 INTO #TempMP2155_1
				 FROM #TempMP2155
				 GROUP BY MaterialID, MaterialName, UnitID, UnitName, DS01ID, DS02ID, DS03ID, DS04ID, DS05ID, DS06ID, DS07ID
						  , DS08ID, DS09ID, DS10ID, DS11ID, DS12ID, DS13ID, DS14ID, DS15ID
						  , DS16ID, DS17ID, DS18ID, DS19ID, DS20ID, QuantityInherit, EndQuantity, MinQuantity, PickingQuantity, ActualQuantityInherit
						  
				  SELECT MaterialID, MaterialName, UnitID, UnitName, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID
						, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID
						, S16ID, S17ID, S18ID, S19ID, S20ID, SUM(QuantityInherit) AS QuantityInherit
						, MaterialQuantity, EndQuantity, ActualQuantityInherit, SafeQuantity, PickingQuantity
				 INTO #TempMP2155_2
				 FROM #TempMP2155_1
				 GROUP BY MaterialID, MaterialName, UnitID, UnitName, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID
						  , S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID
						  , S16ID, S17ID, S18ID, S19ID, S20ID, MaterialQuantity, EndQuantity, SafeQuantity, PickingQuantity, ActualQuantityInherit
				 SELECT MaterialID, MaterialName, UnitID, UnitName, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID
						, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID
						, S16ID, S17ID, S18ID, S19ID, S20ID, QuantityInherit, PickingQuantity
						, MaterialQuantity, EndQuantity, SUM(ActualQuantityInherit) AS ActualQuantityInherit, SafeQuantity
						, (QuantityInherit + (MaterialQuantity - SUM(ActualQuantityInherit))) AS IntendedPickingQuantity
						, (MaterialQuantity - EndQuantity + (QuantityInherit + (MaterialQuantity - SUM(ActualQuantityInherit))) + SafeQuantity - PickingQuantity) AS SuggestQuantity
				 INTO #TempMP2155_3
				 FROM #TempMP2155_2
				 GROUP BY MaterialID, MaterialName, UnitID, UnitName, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID
						  , S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID
						  , S16ID, S17ID, S18ID, S19ID, S20ID, MaterialQuantity, EndQuantity, SafeQuantity, PickingQuantity, QuantityInherit
						  
				SELECT MaterialID, MaterialName, UnitID, UnitName, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID
						, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID
						, S16ID, S17ID, S18ID, S19ID, S20ID, QuantityInherit, SUM(ISNULL(PickingQuantity,0)) AS PickingQuantity
						, MaterialQuantity,EndQuantity, ActualQuantityInherit
						, SafeQuantity
						, IntendedPickingQuantity AS IntendedPickingQuantity
						, SUM(ISNULL(SuggestQuantity,0)) AS SuggestQuantity
				 FROM #TempMP2155_3
				 GROUP BY MaterialID, MaterialName, UnitID, UnitName, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID
						  , S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID
						  , S16ID, S17ID, S18ID, S19ID, S20ID,QuantityInherit, MaterialQuantity,EndQuantity,ActualQuantityInherit
						  , SafeQuantity, IntendedPickingQuantity '

EXEC (@sSQL + @sLeftJoin01 + @sLeftJoin02 + @sSQL01)
END
ELSE
BEGIN 

IF @APK_BomVersion IS NULL
	SET @APK_BomVersion = ''
IF (ISNULL(@listAPK, '') <> '')
BEGIN
--Version1
	SET @sWhere = N' M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND  CONVERT(VARCHAR(50), M1.APK) IN (''' + @listAPK + ''')'
	
	SET @sLeftJoin01 =N'SELECT  
						M1.APK AS APKDetail
						, M2.APK, M2.VoucherNo
						, M1.InventoryID 
						, CASE WHEN  M10.NodeTypeID = ''2'' THEN M10.NodeID
							ELSE ''''
							END AS MaterialID
						, CASE WHEN  M10.NodeTypeID = ''1'' THEN M10.NodeID
							ELSE ''''
							END AS SemiProduct
						, M11.InventoryName AS MaterialName
						, M10.UnitID,M8.UnitName
						,  (M1.OrderQuantity * ISNULL(M10.QuantitativeValue,0)) AS Quantity
						, M10.MaterialGroupID, M10.MaterialID AS MaterialIDChange
						, M11.InventoryName AS MaterialNameChange
						, M10.QuantitativeTypeID,	M10.QuantitativeValue
						, M10.MaterialConstant, M9.NodeID
						, M10.NodeLevel AS NodeLevel, M10.NodeOrder AS OrderStd, M10.NodeParent AS NodeParent
						, ISNULL(SUM(A5.EndQuantity), 0) AS EndQuantity
						, ISNULL(SUM(A6.MinQuantity), 0) AS MinQuantity
						, ISNULL(O1.OrderQuantity, 0) AS OrderQuantity
						, ISNULL(A7.ActualQuantity, 0) AS ActualQuantity 
						,(ISNULL(O1.OrderQuantity, 0) - ISNULL(A7.ActualQuantity, 0)) AS PickingQuantity
						, ISNULL(O2.MaterialQuantity, 0) AS QuantityInherit, ISNULL (A8.ActualQuantity, 0) AS ActualQuantityInherit
						, ''' + @APK_OT2202 + ''' AS APK_OT2202

					INTO #TempMP2155
					FROM OT2002 M1 WITH(NOLOCK)

					LEFT JOIN OT2001 M2 WITH(NOLOCK) ON M2.SOrderID = M1.SOrderID AND M2.OrderType = 1 AND M2.DivisionID = M1.DivisionID
					CROSS APPLY
					(
						SELECT *
						FROM MT2122 MT22 WITH (NOLOCK)
						WHERE 
							MT22.DivisionID = M1.DivisionID
							AND CONVERT(NVARCHAR(50), MT22.APK) = ''' + @APK_BomVersion + '''
					) M9
					LEFT JOIN MT2123 M10 WITH (NOLOCK) ON M9.APK = M10.APK_2120 AND M10.DivisionID = M9.DivisionID AND M10.NodeTypeID <> 0
					LEFT JOIN AT1302 M11 WITH (NOLOCK) ON M10.NodeID = M11.InventoryID AND M11.DivisionID IN (M10.DivisionID,''@@@'')
					LEFT JOIN AT1304 M8 WITH (NOLOCK) ON M10.UnitID = M8.UnitID AND M8.DivisionID IN (M11.DivisionID, ''@@@'')
					LEFT JOIN AT2008 A5 WITH (NOLOCK) ON M10.NodeID = A5.InventoryID 
													AND A5.WareHouseID IN ('''+@listWareHouseID+''') 
													AND A5.TranMonth = '+@TranMonth+' AND A5.TranYear = '+@TranYear+'
					LEFT JOIN AT1314 A6 WITH (NOLOCK) ON M10.NodeID = A6.InventoryID 
													AND A6.WareHouseID IN ('''+@listWareHouseID+''') 
													--AND A6.TranMonth = '+@TranMonth+' AND A6.TranYear = '+@TranYear+' 
					LEFT JOIN OT3002 O1 WITH (NOLOCK) ON M10.NodeID = O1.InventoryID AND O1.TransactionID IS NOT NULL
					LEFT JOIN AT2007 A7 WITH (NOLOCK) ON A7.InheritTransactionID = O1.APK AND O1.Status = 1 AND A7.TranMonth = '+@TranMonth+'	AND A7.TranYear =    '+@TranYear+'
					LEFT JOIN OT2203 O2 WITH (NOLOCK) ON M10.NodeID = O2.MaterialID AND M9.NodeID = O2.ProductID
					LEFT JOIN AT2007 A8 WITH (NOLOCK) ON A8.ETransactionID = O2.TransactionID AND A8.TranMonth = '+@TranMonth+'	AND A8.TranYear = '+@TranYear+'
					WHERE '+ @sWhere +' AND M10.NodeID IS NOT NULL AND M10.NodeID <> M1.InventoryID
					GROUP BY M1.APK, M2.APK, M2.VoucherNo, M1.InventoryID ,M10.NodeID , M11.InventoryName , M10.UnitID, M8.UnitName,  M1.OrderQuantity,		M10.QuantitativeValue
					, M10.MaterialGroupID, M10.MaterialID, M10.NodeTypeID, M11.InventoryName, M10.QuantitativeTypeID, M10.QuantitativeValue, M10.MaterialConstant, M9.NodeID, M10.NodeLevel, M10.NodeOrder, M10.NodeParent
					, O1.OrderQuantity, A7.ActualQuantity,O2.MaterialQuantity,A8.ActualQuantity

					ORDER BY NodeLevel, OrderStd, NodeParent'
			
	SET @sSQL01 = N'  SELECT  APKDetail, MaterialID, SemiProduct, MaterialName, UnitID, UnitName, QuantityInherit
							, Quantity AS MaterialQuantity, IIF(EndQuantity < 0, 0, EndQuantity) AS EndQuantity, ActualQuantityInherit, APK_OT2202
							, MinQuantity AS SafeQuantity, SUM(PickingQuantity) AS PickingQuantity, NodeLevel, OrderStd, NodeParent
					 INTO #TempMP2155_1
					 FROM #TempMP2155
					 GROUP BY  APKDetail, MaterialID, SemiProduct, MaterialName, UnitID, UnitName, QuantityInherit,Quantity,EndQuantity, MinQuantity,	ActualQuantityInherit, APK_OT2202, NodeLevel, OrderStd, NodeParent
						  
					  SELECT  APKDetail, MaterialID, SemiProduct, MaterialName, UnitID, UnitName, SUM(QuantityInherit) AS QuantityInherit
							, MaterialQuantity, EndQuantity, ActualQuantityInherit, APK_OT2202, SafeQuantity, PickingQuantity, NodeLevel, OrderStd, NodeParent
					 INTO #TempMP2155_2
					 FROM #TempMP2155_1
					 GROUP BY  APKDetail, MaterialID, SemiProduct, MaterialName, UnitID, UnitName, MaterialQuantity, EndQuantity, SafeQuantity, PickingQuantity,		ActualQuantityInherit, APK_OT2202, NodeLevel, OrderStd, NodeParent
	
					 SELECT  APKDetail, MaterialID, SemiProduct, MaterialName, UnitID, UnitName, QuantityInherit, APK_OT2202, PickingQuantity
							, MaterialQuantity, EndQuantity, SUM(ActualQuantityInherit) AS ActualQuantityInherit, SafeQuantity
							, (QuantityInherit + (MaterialQuantity - SUM(ActualQuantityInherit))) AS IntendedPickingQuantity
							, (MaterialQuantity - EndQuantity + (QuantityInherit + (MaterialQuantity - SUM(ActualQuantityInherit))) + SafeQuantity -	PickingQuantity) AS SuggestQuantity, NodeLevel, OrderStd, NodeParent
					 INTO #TempMP2155_3
					 FROM #TempMP2155_2
					 GROUP BY APKDetail, MaterialID, SemiProduct, MaterialName, UnitID, UnitName, MaterialQuantity, EndQuantity, SafeQuantity, PickingQuantity,	QuantityInherit, APK_OT2202, NodeLevel, OrderStd, NodeParent
				 
					 SELECT  APKDetail, MaterialID, SemiProduct, MaterialName, UnitID, UnitName,QuantityInherit, APK_OT2202, SUM(ISNULL(PickingQuantity,0)) AS PickingQuantity
							, MaterialQuantity,EndQuantity,ActualQuantityInherit
							, SafeQuantity
							, IntendedPickingQuantity
							, IIF(SUM(ISNULL(SuggestQuantity,0)) < 0, 0, SUM(ISNULL(SuggestQuantity,0))) AS SuggestQuantity, NodeLevel, OrderStd, NodeParent
					 FROM #TempMP2155_3
					 GROUP BY	APKDetail,MaterialID, SemiProduct,MaterialName,UnitID,UnitName,QuantityInherit, APK_OT2202, MaterialQuantity,EndQuantity,ActualQuantityInherit,SafeQuantity,IntendedPickingQuantity, NodeLevel, OrderStd, NodeParent 
					 
					 ORDER BY NodeLevel, OrderStd, NodeParent'
	EXEC (@sSQL + @sLeftJoin01 + @sSQL01)
	PRINT (@sSQL)
	PRINT (@sLeftJoin01)
	PRINT (@sLeftJoin02)
	PRINT (@sSQL01)
END
ELSE
BEGIN
	--Vesion2
	SET @sSQL =  'SELECT 
					M9.APK AS APKDetail
					--, M2.APK
					--, M2.VoucherNo
					, '''+@ProductID+''' AS InventoryID
					, M11.InventoryName AS MaterialName
					, M10.UnitID, M8.UnitName
					, ('+LTRIM(@ProductQuantity)+' * ISNULL(M10.QuantitativeValue,0)) AS Quantity
					, M10.MaterialGroupID, M10.MaterialID AS MaterialIDChange, M11.InventoryName AS MaterialNameChange, M10.QuantitativeTypeID,		M10.QuantitativeValue, M10.MaterialConstant, M9.NodeID,  M10.NodeOrder AS OrderStd
					, ISNULL(SUM(A5.EndQuantity), 0) AS EndQuantity, ISNULL(SUM(A6.MinQuantity), 0) AS MinQuantity, ISNULL(O1.OrderQuantity, 0) AS OrderQuantity,    ISNULL(A7.ActualQuantity, 0) AS ActualQuantity 
					,(ISNULL(O1.OrderQuantity, 0) - ISNULL(A7.ActualQuantity, 0)) AS PickingQuantity, ISNULL(O2.MaterialQuantity, 0) AS QuantityInherit
					, ISNULL(A8.ActualQuantity, 0) AS ActualQuantityInherit
					, CASE WHEN  M10.NodeTypeID = ''2'' THEN M10.NodeID
							ELSE ''''
							END AS MaterialID
					, CASE WHEN  M10.NodeTypeID = ''1'' THEN M10.NodeID
							ELSE ''''
							END AS SemiProduct
				
					INTO #TempMP2155
					FROM MT2122 M9 WITH (NOLOCK)
					LEFT JOIN MT2123 M10 WITH (NOLOCK) ON M9.APK = M10.APK_2120 AND M10.DivisionID = M9.DivisionID AND M10.NodeTypeID <> 0
					LEFT JOIN AT1302 M11 WITH (NOLOCK) ON M10.NodeID = M11.InventoryID AND M11.DivisionID IN (M10.DivisionID,''@@@'')
					LEFT JOIN AT1304 M8 WITH (NOLOCK) ON M10.UnitID = M8.UnitID AND M8.DivisionID IN (M11.DivisionID, ''@@@'')
					LEFT JOIN AT2008 A5 WITH (NOLOCK) ON M10.NodeID = A5.InventoryID 
													AND A5.WareHouseID IN ('''+@listWareHouseID+''') 
													AND A5.TranMonth = '+@TranMonth+' AND A5.TranYear = '+@TranYear+'
					LEFT JOIN AT1314 A6 WITH (NOLOCK) ON M10.NodeID = A6.InventoryID 
													AND A6.WareHouseID IN ('''+@listWareHouseID+''') 
													--AND A6.TranMonth = '+@TranMonth+' AND A6.TranYear = '+@TranYear+' 
					LEFT JOIN OT3002 O1 WITH (NOLOCK) ON M10.NodeID = O1.InventoryID AND O1.TransactionID IS NOT NULL
					LEFT JOIN AT2007 A7 WITH (NOLOCK) ON A7.InheritTransactionID = O1.APK AND O1.Status = 1 AND A7.TranMonth = '+@TranMonth+'	AND A7.TranYear =    '+@TranYear+'
					LEFT JOIN OT2203 O2 WITH (NOLOCK) ON M10.NodeID = O2.MaterialID AND M9.NodeID = O2.ProductID
	
					LEFT JOIN AT2007 A8 WITH (NOLOCK) ON A8.ETransactionID = O2.TransactionID AND A8.TranMonth = '+@TranMonth+'	AND A8.TranYear = '+@TranYear+'
				
					WHERE M9.DivisionID  IN (''@@@'', ''EXV'')
						AND CONVERT(NVARCHAR(50), M9.APK) = ''' + @APK_BomVersion + '''
						AND M9.NodeID = ''' + @ProductID + '''
						AND M10.NodeID IS NOT NULL
				
					GROUP BY M9.APK ,M10.NodeID , M11.InventoryName , M10.UnitID, M8.UnitName,  Quantity, M10.QuantitativeValue
						, M10.MaterialGroupID, M10.NodeTypeID, M10.MaterialID, M11.InventoryName, M10.QuantitativeTypeID, M10.QuantitativeValue,	M10.MaterialConstant, M9.NodeID,  M10.NodeOrder
						, O1.OrderQuantity, A7.ActualQuantity,O2.MaterialQuantity,A8.ActualQuantity
				
					ORDER BY OrderStd'
			
	SET @sSQL01 = N'  SELECT  APKDetail, MaterialID, SemiProduct, MaterialName, UnitID, UnitName, QuantityInherit
							, Quantity AS MaterialQuantity, IIF(EndQuantity < 0, 0, EndQuantity) AS EndQuantity, ActualQuantityInherit
							, MinQuantity AS SafeQuantity, SUM(PickingQuantity) AS PickingQuantity,OrderStd
					 INTO #TempMP2155_1
					 FROM #TempMP2155
					 GROUP BY  APKDetail, MaterialID, SemiProduct, MaterialName, UnitID, UnitName, QuantityInherit,Quantity,EndQuantity, MinQuantity,	ActualQuantityInherit,OrderStd
						  
					  SELECT  APKDetail, MaterialID, SemiProduct, MaterialName, UnitID, UnitName, SUM(QuantityInherit) AS QuantityInherit
							, MaterialQuantity, EndQuantity, ActualQuantityInherit, SafeQuantity, PickingQuantity,OrderStd
					 INTO #TempMP2155_2
					 FROM #TempMP2155_1
					 GROUP BY  APKDetail, MaterialID, SemiProduct, MaterialName, UnitID, UnitName, MaterialQuantity, EndQuantity, SafeQuantity, PickingQuantity,	ActualQuantityInherit,OrderStd
	
					 SELECT  APKDetail, MaterialID, SemiProduct, MaterialName, UnitID, UnitName, QuantityInherit, PickingQuantity
							, MaterialQuantity, EndQuantity, SUM(ActualQuantityInherit) AS ActualQuantityInherit, SafeQuantity
	
							, (QuantityInherit + (MaterialQuantity - SUM(ActualQuantityInherit))) AS IntendedPickingQuantity
	
							, (MaterialQuantity - EndQuantity + (QuantityInherit + (MaterialQuantity - SUM(ActualQuantityInherit))) + SafeQuantity -	PickingQuantity) AS SuggestQuantity,OrderStd
					 INTO #TempMP2155_3
					 FROM #TempMP2155_2
					 GROUP BY APKDetail, MaterialID, SemiProduct, MaterialName, UnitID, UnitName, MaterialQuantity, EndQuantity, SafeQuantity, PickingQuantity,		QuantityInherit,OrderStd
				 
					 SELECT  APKDetail, MaterialID, SemiProduct, MaterialName, UnitID, UnitName,QuantityInherit,SUM(ISNULL(PickingQuantity,0)) AS PickingQuantity
							, MaterialQuantity,EndQuantity,ActualQuantityInherit
							, SafeQuantity
							, IntendedPickingQuantity
							, IIF(SUM(ISNULL(SuggestQuantity,0)) < 0, 0, SUM(ISNULL(SuggestQuantity,0))) AS SuggestQuantity,OrderStd
					 FROM #TempMP2155_3
					 GROUP BY APKDetail,MaterialID, SemiProduct,	MaterialName,UnitID,UnitName,QuantityInherit,MaterialQuantity,EndQuantity,ActualQuantityInherit,SafeQuantity,IntendedPickingQuantity,OrderStd '
	--PRINT (@sSQL)
	--PRINT (@sSQL01)
	EXEC (@sSQL + @sSQL01)
END

END




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
