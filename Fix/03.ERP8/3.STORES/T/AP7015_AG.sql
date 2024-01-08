IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7015_AG]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP7015_AG]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Create by Tieu Mai on 16/03/2017
---- Purpose: So du dau ky chi tiet nhap xuat ton (ANGEL)
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.

-- <Example>
---- 


CREATE PROCEDURE [dbo].[AP7015_AG] 
    @DivisionID NVARCHAR(50), 
    @WareHouseID NVARCHAR(50), 
    @FromInventoryID NVARCHAR(50), 
    @ToInventoryID NVARCHAR(50), 
    @FromMonth INT, 
    @FromYear INT, 
    @ToMonth INT, 
    @ToYear INT, 
    @FromDate DATETIME, 
    @ToDate DATETIME, 
    @IsDate TINYINT,
	@IsAll AS tinyint
AS

DECLARE 
    @sSQL NVARCHAR(4000), 
    @WareHouseID2 NVARCHAR(50), 
    @WareHouseName NVARCHAR(250),
	@WareHouseIDNotAll NVARCHAR(50)

IF @IsAll = 1
    BEGIN
        SET @WareHouseID2 = '''%'''
        SET @WareHouseName = '''WFML000110'''        
    END    
ELSE
    BEGIN
    	SET @WareHouseID2 = 'AT2008.WareHouseID'
        SET @WareHouseName = 'AT1303.WareHouseName'
		SET @WareHouseIDNotAll = (Select top 1 WareHouseID from TBL_WareHouseIDAP7015)
    END
	
IF @IsDate = 0 --- Theo ky
BEGIN 
	SET @Ssql = N'
		SELECT	AT2008.DivisionID,' + @WareHouseID2 + ' AS WareHouseID, 
				' + @WareHouseName + ' AS WareHouseName, 
				AT2008.InventoryID, 
				AT1302.InventoryName, 
				AT1302.UnitID, 
				AT1304.UnitName, 
				SUM(BeginQuantity) AS BeginQuantity, 
				SUM(EndQuantity) AS EndQuantity, 
				SUM(BeginAmount) AS BeginAmount, 
				SUM(EndAmount) AS EndAmount
		FROM	AT2008 WITH (NOLOCK) 
		INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = AT2008.InventoryID and  AT1302.DivisionID in (''@@@'',AT2008.DivisionID)
		INNER JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT1302.UnitID and  AT1304.DivisionID in (''@@@'',AT2008.DivisionID)
		INNER JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID in (''@@@'','''+@DivisionID+''') AND AT1303.WareHouseID = AT2008.WareHouseID
		WHERE AT2008.DivisionID = N''' + @DivisionID + ''' 
				AND AT2008.InventoryID BETWEEN N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''' '+
				(CASE WHEN @IsAll = 1 THEN ' AND AT1303.IsTemp = 0 ' ELSE '' END) +
				'AND AT2008.WareHouseID '+CASE WHEN ISNULL(@WareHouseID,'%') =  '%' THEN ' LIKE N''%'' ' ELSE ' = '''+@WareHouseID+''' ' END +' 
				AND TranMonth + TranYear * 100 = ' + STR(@FromMonth) + ' + 100 * ' + STR(@FromYear) + ' 
		GROUP BY AT2008.DivisionID,AT2008.InventoryID, AT1302.InventoryName, AT1302.UnitID, AT1304.UnitName
	'

	IF @IsAll = 0
		SET @sSQL = @sSQL + N', AT2008.WareHouseID, AT1303.WareHouseName '
END 
ELSE
BEGIN
	IF @IsAll = 0
		SET @sSQL = N'    
			SELECT	DivisionID, WareHouseID, 
					WareHouseName, 
					InventoryID, 
					InventoryName, 
					UnitID, UnitName, 
					SUM(SignQuantity) AS BeginQuantity, 
					SUM(SignAmount) AS BeginAmount, 
					0 AS EndQuantity, 
					0 AS EndAmount
			FROM	AV7011
			WHERE	DivisionID LIKE N''' + @DivisionID + ''' 
					AND ((D_C in (''D'', ''C'') AND CONVERT(DATETIME, CONVERT(VARCHAR(10), VoucherDate, 101), 101) < ''' + Convert(NVARCHAR(10), @FromDate, 101) + ''') 
							OR D_C = ''BD'') 
					AND WareHouseID like N''' + @WareHouseID + '''
					AND InventoryID BETWEEN N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''' 
			GROUP BY DivisionID, InventoryID, InventoryName, UnitID, UnitName, WareHouseID, WareHouseName
			---Having SUM(SignQuantity) <> 0 OR SUM(SignAmount) <> 0 
		'
	ELSE
		SET @sSQL = N'
			SELECT	DivisionID, 
					' + @WareHouseID2 + ' AS WareHouseID, 
					' + @WareHouseName + ' AS WareHouseName, 
					InventoryID, 
					InventoryName, 
					UnitID, UnitName, 
					SUM(SignQuantity) AS BeginQuantity, 
					SUM(SignAmount) AS BeginAmount, 
					0 AS EndQuantity, 
					0 AS EndAmount
			FROM	AV7011
			WHERE	DivisionID LIKE N''' + @DivisionID + ''' 
					AND ((D_C in (''D'', ''C'') 
							AND CONVERT(DATETIME, CONVERT(VARCHAR(10), VoucherDate, 101), 101) < ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''') 
							OR D_C = ''BD'') 
					AND WareHouseID '+CASE WHEN ISNULL(@WareHouseID,'%') =  '%' THEN ' LIKE N''%'' ' ELSE ' = '''+@WareHouseID+''' ' END +' 
					AND InventoryID BETWEEN N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''' 
			GROUP BY DivisionID, InventoryID, InventoryName, UnitID, UnitName 
			---Having SUM(SignQuantity) <> 0 OR SUM(SignAmount) <> 0 
		'
END
    
    
--PRINT @sSQL    
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE Xtype = 'V' AND Name = 'AV7015_AG')
    EXEC('CREATE VIEW AV7015_AG 	--CREATED BY AP7015_AG
    AS ' + @sSQL)
ELSE
    EXEC('ALTER VIEW AV7015_AG 	--CREATED BY AP7015_AG
    AS ' + @sSQL)
---- Lay so phat sinh





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
