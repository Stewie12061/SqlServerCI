IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2159_2]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2159_2]
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
-- <Example> EXEC MP2159_2 @DivisionID = 'BE', @UserID = '', @APK = '9B8430BF-53C2-4EAB-A524-50BC4F2FCA82'
CREATE PROCEDURE MP2159_2
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
				SELECT  O1.APK, O1.DivisionID, O1.EstimateID, O1.TranMonth, O1.TranYear, O1.MaterialID, O1.SemiProduct, O1.MaterialQuantity, O1.Orders, O1.WareHouseID
				, O1.AKPMaster, O1.S01ID, O1.S02ID, O1.S03ID, O1.S05ID, O1.S06ID, O1.S07ID, O1.S08ID, O1.S09ID, O1.S10ID, O1.S11ID, O1.S12ID, O1.S13ID
				, O1.S14ID, O1.S15ID, O1.S16ID, O1.S17ID, O1.S18ID, O1.S19ID, O1.S20ID, O1.S04ID, O1.UnitID, O1.MaterialName, O1.UnitName, O1.SafeQuantity
				, O1.EndQuantity, O1.IntendedPickingQuantity, O1.PickingQuantity
				, O1.SuggestQuantity, O1.TransactionID, O1.WareHouseName
				INTO #TempMP2159_2
				FROM OT2205 O1 WITH (NOLOCK)
					LEFT JOIN OT2201 O2 WITH (NOLOCK) ON O1.APKMaster = O2.APK
				WHERE (CONVERT(VARCHAR(50),O2.APKMaster_9000) = '''+@APK+''' OR CONVERT(VARCHAR(50),O2.APK) = '''+@APK+''') AND O2.DivisionID = ''' + @DivisionID + '''

				DECLARE @Count INT
				SELECT @Count = COUNT(*) FROM #TempMP2159_2
				
				SELECT  CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, @Count AS TotalRow
						, APK, DivisionID, EstimateID, TranMonth, TranYear, MaterialID, SemiProduct, MaterialQuantity, Orders, WareHouseID
						, AKPMaster, S01ID, S02ID, S03ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID
						, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID, S04ID, UnitID, MaterialName, UnitName, SafeQuantity
						, EndQuantity, IntendedPickingQuantity, PickingQuantity
						, SuggestQuantity, TransactionID, WareHouseName
				FROM #TempMP2159_2 WITH (NOLOCK) 
				ORDER BY '+@OrderBy+''

 	 EXEC (@sSQL)
	 PRINT (@sSQL)







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
