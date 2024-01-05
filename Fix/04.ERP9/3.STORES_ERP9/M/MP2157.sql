IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2157]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2157]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
--- Đối chiếu NVL khi thay đổi combobox MaterialID
-- <Param> DivisionID
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



Create PROCEDURE [dbo].[MP2157]
(
    @DivisionID VARCHAR(50),
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
		@OrderBy NVARCHAR(MAX) = N'', 
		@TotalRow NVARCHAR(50) = N'',
		@sWhere NVARCHAR(MAX) = N'',
		@CheckQC INT,
		@CustomerIndex INT = (SELECT CustomerName FROM CustomerIndex)

IF (@CustomerIndex IN (117,158)) -- Khách hàng MAITHU và HIPC
BEGIN
SET @sWhere = N' A1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND A1.InventoryID = '''+@MaterialID+''' AND A1.TranMonth = '+@TranMonth+' AND A1.TranYear = '+@TranYear+' AND A1.WareHouseID IN ('''+@listWareHouseID+''')
				 AND ISNULL(A1.S02ID, '''') = '''+@S02ID+''' AND ISNULL(A1.S03ID, '''') = '''+@S03ID+''' AND ISNULL(A1.S04ID, '''') = '''+@S04ID+''' AND ISNULL(A1.S05ID, '''') = '''+@S05ID+''' AND ISNULL(A1.S06ID, '''') = '''+@S06ID+''' 
				 AND ISNULL(A1.S07ID, '''') = '''+@S07ID+''' AND ISNULL(A1.S08ID, '''') = '''+@S08ID+''' AND ISNULL(A1.S09ID, '''') = '''+@S09ID+''' AND ISNULL(A1.S10ID, '''') = '''+@S10ID+''' AND ISNULL(A1.S11ID, '''') = '''+@S11ID+'''
				 AND ISNULL(A1.S16ID, '''') = '''+@S16ID+''' AND ISNULL(A1.S17ID, '''') = '''+@S17ID+''' AND ISNULL(A1.S18ID, '''') = '''+@S18ID+''' AND ISNULL(A1.S20ID, '''') = '''+@S12ID+''' AND ISNULL(A1.S01ID, '''') = '''+@S01ID+'''
				 AND ISNULL(A1.S12ID, '''') = '''+@S12ID+''' AND ISNULL(A1.S13ID, '''') = '''+@S13ID+''' AND ISNULL(A1.S14ID, '''') = '''+@S14ID+''' AND ISNULL(A1.S15ID, '''') = '''+@S15ID+'''';

SET @sSQL = 'SELECT ISNULL(SUM(A1.EndQuantity), 0) AS EndQuantity, ISNULL(SUM(A2.MinQuantity), 0) AS SafeQuantity

			 FROM AT2008_QC A1 WITH (NOLOCK)
			 	 LEFT JOIN AT1314 A2 WITH (NOLOCK) ON A1.InventoryID = A2.InventoryID AND A2.WareHouseID IN ('''+@listWareHouseID+''') AND A2.TranMonth = A1.TranMonth
													AND A1.TranYear = A2.TranYear AND A1.S01ID = A2.S01ID AND A1.S02ID = A2.S02ID AND A1.S03ID = A2.S03ID
													AND A1.S04ID = A2.S04ID AND A1.S05ID = A2.S05ID AND A1.S06ID = A2.S06ID AND A1.S07ID = A2.S07ID
													AND A1.S08ID = A2.S08ID AND A1.S09ID = A2.S09ID AND A1.S10ID = A2.S10ID AND A1.S11ID = A2.S11ID
													AND A1.S16ID = A2.S16ID AND A1.S17ID = A2.S17ID AND A1.S18ID = A2.S19ID AND A1.S20ID = A2.S20ID
													AND A1.S12ID = A2.S12ID AND A1.S13ID = A2.S13ID AND A1.S14ID = A2.S14ID AND A1.S15ID = A2.S15ID
				 WHERE ';
END
ELSE
BEGIN
SET @sWhere = N' A1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND A1.InventoryID = '''+@MaterialID+''' AND A1.TranMonth = '+@TranMonth+' AND A1.TranYear = '+@TranYear+' AND A1.WareHouseID IN ('''+@listWareHouseID+''')'

SET @sSQL = 'SELECT IIF(ISNULL(SUM(A1.EndQuantity), 0) < 0, 0, ISNULL(SUM(A1.EndQuantity), 0)) AS EndQuantity, ISNULL(SUM(A2.MinQuantity), 0) AS SafeQuantity

			 FROM AT2008 A1 WITH (NOLOCK)
			 	 LEFT JOIN AT1314 A2 WITH (NOLOCK) ON A1.InventoryID = A2.InventoryID AND A2.WareHouseID IN ('''+@listWareHouseID+''') 
													--AND A2.TranMonth = A1.TranMonth AND A1.TranYear = A2.TranYear 
				 WHERE '
END
EXEC (@sSQL + @sWhere)
PRINT (@sSQL)
PRINT (@sWhere)







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
