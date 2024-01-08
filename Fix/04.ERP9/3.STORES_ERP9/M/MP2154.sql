IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2154]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2154]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load nguyên vật liệu thay thế
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Trọng Kiên
-- <Example> exec sp_executesql N'MP2154 @DivisionID=N''HCM'',@TxtSearch=N''77'',@UserID=N''HCM07'',@PageNumber=N''1'',@PageSize=N''25'',@ConditionObjectID=N'''',@IsOrganize=0',N'@CreateUserID nvarchar(5),@LastModifyUserID nvarchar(5),@DivisionID nvarchar(3)',@CreateUserID=N'HCM07',@LastModifyUserID=N'HCM07',@DivisionID=N'HCM'

 CREATE PROCEDURE MP2154 (
     @MaterialGroupID VARCHAR(MAX),
	 @DS01ID VARCHAR (50),
	 @DS02ID VARCHAR (50),
	 @DS03ID VARCHAR (50),
	 @MaterialQuantity Decimal (28,8) = 1,
	 @MaterialOriginal VARCHAR (250)
)
AS
DECLARE @sSQL NVARCHAR (MAX) = '',
        @sWhere NVARCHAR(MAX) = '',
		@CustomerIndex INT = (SELECT CustomerName FROM CustomerIndex)

IF (@CustomerIndex IN (117)) -- Khách hàng MAITHU và HIPC
BEGIN
IF ISNULL(@MaterialGroupID, '') != ''
	SET @sWhere = @sWhere +' WHERE M6.MaterialGroupID = N'''+@MaterialGroupID+''''

	  
SET @sSQL = N'SELECT M7.MaterialID AS MaterialIDChange, A2.InventoryName AS MaterialNameChange, M6.GroupName, M6.MaterialGroupID
					, A2.UnitID, A3.UnitName, M7.CoValues
					, M7.S01ID, M7.S02ID, M7.S03ID, M7.S04ID, M7.S05ID, M7.S06ID, M7.S07ID
				    , M7.S08ID, M7.S09ID, M7.S10ID, M7.S11ID, M7.S12ID, M7.S13ID, M7.S14ID
					, M7.S15ID, M7.S16ID, M7.S17ID, M7.S18ID, M7.S19ID, M7.S20ID
			  FROM MT0007 M7 WITH(NOLOCK)    
				  LEFT JOIN AT1302 A2 WITH (NOLOCK) ON A2.InventoryID = M7.MaterialID 
				  LEFT JOIN AT1304 A3 WITH (NOLOCK) ON A2.UnitID = A3.UnitID
				  LEFT JOIN MT0006 M6 WITH (NOLOCK) ON M6.MaterialGroupID = M7.MaterialGroupID
			  ' + @sWhere + '
			  UNION ALL
			  SELECT '''+@MaterialOriginal+''' AS MaterialIDChange, A1.InventoryName AS MaterialNameChange
					, '''' AS GroupName, '''' AS MaterialGroupID, A1.UnitID, A2.UnitName, 1 AS CoValues
				    , IIF('''+@DS01ID+''' = '''', NULL, '''+@DS01ID+''') AS S01ID, IIF('''+@DS02ID+''' = '''', NULL, '''+@DS02ID+''') AS S02ID
					, IIF('''+@DS03ID+''' = '''', NULL, '''+@DS03ID+''') AS S03ID
					, NULL AS S04ID, NULL AS S05ID, NULL AS S06ID, NULL AS S07ID, NULL AS S08ID
					, NULL AS S09ID, NULL AS S10ID, NULL AS S11ID, NULL AS S12ID, NULL AS S13ID
					, NULL AS S14ID, NULL AS S15ID, NULL AS S16ID, NULL AS S17D, NULL AS S18ID
					, NULL AS S19ID, NULL AS S20ID
			  FROM AT1302 A1 WITH (NOLOCK)
			  	  LEFT JOIN AT1304 A2 WITH (NOLOCK) ON A1.UnitID = A2.UnitID  
			  WHERE A1.InventoryID = '''+@MaterialOriginal+''' '
END
ELSE IF (@CustomerIndex IN (158)) -- Khách hàng HIPC
BEGIN
IF ISNULL(@MaterialGroupID, '') != ''
	SET @sWhere = @sWhere +' AND M6.MaterialGroupID = N'''+@MaterialGroupID+''''

SET @sSQL = N'SELECT M7.MaterialID AS MaterialIDChange, A2.InventoryName AS MaterialNameChange, M6.GroupName, M6.MaterialGroupID
					, A2.UnitID, A3.UnitName
					, M7.S01ID, M7.S02ID, M7.S03ID, M7.S04ID, M7.S05ID, M7.S06ID, M7.S07ID
				    , M7.S08ID, M7.S09ID, M7.S10ID, M7.S11ID, M7.S12ID, M7.S13ID, M7.S14ID
					, M7.S15ID, M7.S16ID, M7.S17ID, M7.S18ID, M7.S19ID, M7.S20ID
					, M7.CoValues
			  FROM MT0007 M7 WITH(NOLOCK)    
				  LEFT JOIN AT1302 A2 WITH (NOLOCK) ON A2.InventoryID = M7.MaterialID 
				  LEFT JOIN AT1304 A3 WITH (NOLOCK) ON A2.UnitID = A3.UnitID
				  LEFT JOIN MT0006 M6 WITH (NOLOCK) ON M6.MaterialGroupID = M7.MaterialGroupID
			  WHERE M6.MaterialID = N'''+@MaterialOriginal+'''' + @sWhere + '
			  UNION ALL
			  SELECT '''+@MaterialOriginal+''' AS MaterialIDChange, A1.InventoryName AS MaterialNameChange
					, '''' AS GroupName, '''' AS MaterialGroupID, A1.UnitID, A2.UnitName
				    , IIF('''+@DS01ID+''' = '''', NULL, '''+@DS01ID+''') AS S01ID, IIF('''+@DS02ID+''' = '''', NULL, '''+@DS02ID+''') AS S02ID
					, IIF('''+@DS03ID+''' = '''', NULL, '''+@DS03ID+''') AS S03ID
					, NULL AS S04ID, NULL AS S05ID, NULL AS S06ID, NULL AS S07ID, NULL AS S08ID
					, NULL AS S09ID, NULL AS S10ID, NULL AS S11ID, NULL AS S12ID, NULL AS S13ID
					, NULL AS S14ID, NULL AS S15ID, NULL AS S16ID, NULL AS S17D, NULL AS S18ID
					, NULL AS S19ID, NULL AS S20ID
					, 1 AS CoValues
			  FROM AT1302 A1 WITH (NOLOCK)
			  	  LEFT JOIN AT1304 A2 WITH (NOLOCK) ON A1.UnitID = A2.UnitID  
			  WHERE A1.InventoryID = '''+@MaterialOriginal+''' '
END
ELSE
BEGIN
IF ISNULL(@MaterialGroupID, '') != ''
	SET @sWhere = @sWhere +' AND M6.MaterialGroupID = N'''+@MaterialGroupID+''''

SET @sSQL = N'SELECT M7.MaterialID AS MaterialIDChange, A2.InventoryName AS MaterialNameChange, M6.GroupName, M6.MaterialGroupID
					, A2.UnitID, A3.UnitName
					, M7.S01ID, M7.S02ID, M7.S03ID, M7.S04ID, M7.S05ID, M7.S06ID, M7.S07ID
				    , M7.S08ID, M7.S09ID, M7.S10ID, M7.S11ID, M7.S12ID, M7.S13ID, M7.S14ID
					, M7.S15ID, M7.S16ID, M7.S17ID, M7.S18ID, M7.S19ID, M7.S20ID
					, M7.CoValues
			  FROM MT0007 M7 WITH(NOLOCK)    
				  LEFT JOIN AT1302 A2 WITH (NOLOCK) ON A2.InventoryID = M7.MaterialID 
				  LEFT JOIN AT1304 A3 WITH (NOLOCK) ON A2.UnitID = A3.UnitID
				  LEFT JOIN MT0006 M6 WITH (NOLOCK) ON M6.MaterialGroupID = M7.MaterialGroupID
			  WHERE M6.MaterialID = N'''+@MaterialOriginal+'''' + @sWhere + '
			  UNION ALL
			  SELECT '''+@MaterialOriginal+''' AS MaterialIDChange, A1.InventoryName AS MaterialNameChange
					, '''' AS GroupName, '''' AS MaterialGroupID, A1.UnitID, A2.UnitName
				    , IIF('''+@DS01ID+''' = '''', NULL, '''+@DS01ID+''') AS S01ID, IIF('''+@DS02ID+''' = '''', NULL, '''+@DS02ID+''') AS S02ID
					, IIF('''+@DS03ID+''' = '''', NULL, '''+@DS03ID+''') AS S03ID
					, NULL AS S04ID, NULL AS S05ID, NULL AS S06ID, NULL AS S07ID, NULL AS S08ID
					, NULL AS S09ID, NULL AS S10ID, NULL AS S11ID, NULL AS S12ID, NULL AS S13ID
					, NULL AS S14ID, NULL AS S15ID, NULL AS S16ID, NULL AS S17D, NULL AS S18ID
					, NULL AS S19ID, NULL AS S20ID
					, 1 AS CoValues
			  FROM AT1302 A1 WITH (NOLOCK)
			  	  LEFT JOIN AT1304 A2 WITH (NOLOCK) ON A1.UnitID = A2.UnitID  
			  WHERE A1.InventoryID = '''+@MaterialOriginal+''' '
END
PRINT  (@sSQL)
EXEC (@sSQL)





















GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
