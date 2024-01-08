IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2159_1]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2159_1]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO










-- <Summary>
---- Load Detail Tính Dự trù OT2203
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Trọng Kiên on 23/03/2021
-- <Example> EXEC MP2159_1 @DivisionID = 'BE', @UserID = '', @APK = '9B8430BF-53C2-4EAB-A524-50BC4F2FCA82'
CREATE PROCEDURE MP2159_1
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50)
)

AS 

	DECLARE @sSQL NVARCHAR(MAX) = N'',
			@OrderBy NVARCHAR(MAX) = N'', 
			@TotalRow NVARCHAR(50) = N'',
			@sWhere NVARCHAR(MAX) = N''

	SET @OrderBy = N'Orders'

	SET @sSQL = N'
				SELECT  O1.APK, O1.DivisionID, O1.EstimateID, O1.TranMonth, O1.TranYear, O1.MaterialID, O1.SemiProduct, O1.MaterialQuantity, O1.MDescription
						, O1.Orders, O1.WareHouseID, O1.IsPicking, O1.EDetailID, O1.UnitID, O1.ExpenseID, O1.MaterialTypeID, O1.ConvertedAmount
						, O1.MaterialPrice, O1.ConvertedUnit, O1.QuantityUnit, O1.Num01, O1.Num02, O1.ProductID, O1.PeriodID, O1.MaterialDate
						, O1.MOrderID, O1.SOrderID, O1.MTransactionID, O1.STransactionID, O1.APKMaster, O1.MaterialOriginal, O1.MaterialGroupID
						, O1.IsChange, O1.S01ID, O1.S02ID, O1.S03ID, O1.S05ID, O1.S06ID, O1.S07ID, O1.S08ID, O1.S09ID, O1.S10ID, O1.S11ID, O1.S12ID
						, O1.S13ID, O1.S14ID, O1.S15ID, O1.S16ID, O1.S17ID, O1.S18ID, O1.S19ID, O1.S20ID, O1.DS20ID, O1.DS19ID, O1.DS18ID, O1.DS17ID
						, O1.DS16ID, O1.DS15ID, O1.DS14ID, O1.DS13ID, O1.DS12ID, O1.DS11ID, O1.DS10ID, O1.DS09ID, O1.DS08ID, O1.DS07ID, O1.DS06ID
						, O1.DS05ID, O1.DS04ID, O1.DS03ID, O1.DS02ID, O1.DS01ID, O1.S04ID, O1.TransactionID, O1.ProductName, O1.MaterialName, O1.UnitName
						, O1.ApporitionID, O1.DS01IDOriginal, O1.DS02IDOriginal, O1.DS03IDOriginal
						, O1.Specification, O1.APK_OT2202, O1.RoutingID, O1.PhaseID, O1.NodeTypeID, O1.NodeLevel, O1.NodeParent, O1.NodeOrder, O1.QuantitativeValue, O1.CoValues, O1.LossValue
				INTO #TempMP2159_1
				FROM OT2203 O1 WITH (NOLOCK)
					LEFT JOIN OT2201 O2 WITH (NOLOCK) ON O1.APKMaster = O2.APK
				WHERE (CONVERT(VARCHAR(50),O2.APKMaster_9000) = '''+@APK+''' OR CONVERT(VARCHAR(50),O2.APK) = '''+@APK+''') AND O2.DivisionID = ''' + @DivisionID + '''

				DECLARE @Count INT
				SELECT @Count = COUNT(*) FROM #TempMP2159_1
				
				SELECT  CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, @Count AS TotalRow
						, APK, DivisionID, EstimateID, TranMonth, TranYear, MaterialID, SemiProduct, MaterialQuantity, MDescription
						, Orders, WareHouseID, IsPicking, EDetailID, UnitID, ExpenseID, MaterialTypeID, ConvertedAmount
						, MaterialPrice, ConvertedUnit, QuantityUnit, Num01, Num02, ProductID, PeriodID, MaterialDate
						, MOrderID, SOrderID, MTransactionID, STransactionID, APKMaster, MaterialOriginal, MaterialGroupID
						, IsChange, S01ID, S02ID, S03ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID
						, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID, DS20ID, DS19ID, DS18ID, DS17ID
						, DS16ID, DS15ID, DS14ID, DS13ID, DS12ID, DS11ID, DS10ID, DS09ID, DS08ID, DS07ID, DS06ID
						, DS05ID, DS04ID, DS03ID, DS02ID, DS01ID, S04ID, TransactionID, ProductName, MaterialName, UnitName
						, ApporitionID, DS01IDOriginal, DS02IDOriginal, DS03IDOriginal
						, Specification, APK_OT2202, RoutingID, PhaseID, NodeTypeID, NodeLevel, NodeParent, NodeOrder, QuantitativeValue, CoValues, LossValue
				FROM #TempMP2159_1 WITH (NOLOCK) 
				ORDER BY '+@OrderBy+''

 	 EXEC (@sSQL)
	 PRINT (@sSQL)








GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
