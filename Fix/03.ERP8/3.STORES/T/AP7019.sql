IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7019]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP7019]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- So du  so chi tiet vat tu
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 17/02/2004 by Nguyen Van Nhan
---- 
---- Edit BY Nguyen Quoc Huy, Date 12/07/2006
---- Modified on 25/10/2010 by Hoang Phuoc : Them N''
---- Modified on 11/01/2012 by Le Thi Thu Hien : Sua dieu kien theo ngay
---- Modified on 09/11/2015 by Tieu Mai: Bổ sung trường hợp có thiết lập quản lý theo quy cách hàng.
---- Modified on 18/03/2016 by Kim Vu: Bo sung loc theo kho
---- Modified by Tiểu Mai on 03/06/2016: Bổ sung WITH (NOLOCK)
---- Modified by Kim Vũ on 14/10/2016: Chuyển kiểu dữ liệu biến @WareHouseID sang xml để tránh tràn dữ liệu
-- <Example>
---- 


CREATE PROCEDURE [dbo].[AP7019] 
    @DivisionID NVARCHAR(50), 
    @WareHouseID xml, 
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
	@WareHouseIDNotAll NVARCHAR(50),
	@FromMonthYearText NVARCHAR(20), 
    @ToMonthYearText NVARCHAR(20), 
    @FromDateText NVARCHAR(20), 
    @ToDateText NVARCHAR(20)

    
SET @FromMonthYearText = STR(@FromMonth + @FromYear * 100)
SET @ToMonthYearText = STR(@ToMonth + @ToYear * 100)
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

	
-- Xu li du lieu xml
IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[TBL_WareHouseIDAP7019]') AND TYPE IN (N'U'))
BEGIN
	CREATE TABLE TBL_WareHouseIDAP7019 (WareHouseID VARCHAR(50))
END

-- Xoa du lieu hien tai
DELETE TBL_WareHouseIDAP7019

INSERT INTO TBL_WareHouseIDAP7019
SELECT X.Data.query('WareHouseID').value('.', 'NVARCHAR(50)') AS WareHouseID
FROM @WareHouseID.nodes('//Data') AS X (Data)


IF @IsAll = 1
    BEGIN
        SET @WareHouseID2 = '''%'''
        SET @WareHouseName = '''WFML000110'''        
    END    
ELSE
    BEGIN
    	SET @WareHouseID2 = 'AT2008.WareHouseID'
        SET @WareHouseName = 'AT1303.WareHouseName'
		SET @WareHouseIDNotAll = (Select top 1 WareHouseID from TBL_WareHouseIDAP7019)
    END

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN
	IF @IsDate = 0 --- Theo ky
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
						0 AS EndAmount,
				        ConvertedUnitID, 
				        ConvertedUnitName, 
				        SUM(ISNULL(SignConvertedQuantity, 0)) AS BeginConvertedQuantity,						
						WQ7002.S01ID, WQ7002.S02ID, WQ7002.S03ID, WQ7002.S04ID, WQ7002.S05ID, WQ7002.S06ID, WQ7002.S07ID, WQ7002.S08ID, WQ7002.S09ID, WQ7002.S10ID,
						WQ7002.S11ID, WQ7002.S12ID, WQ7002.S13ID, WQ7002.S14ID, WQ7002.S15ID, WQ7002.S16ID, WQ7002.S17ID, WQ7002.S18ID, WQ7002.S19ID, WQ7002.S20ID
						
                FROM	WQ7002
                WHERE	DivisionID LIKE N''' + @DivisionID + ''' 
						AND (TranMonth + TranYear*100 < ' + @FromMonthYearText + ' OR D_C = ''BD'' )
						AND WareHouseID LIKE N''' + @WareHouseIDNotAll + ''' 
						AND InventoryID BETWEEN N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''' 
                GROUP BY DivisionID, InventoryID, InventoryName, UnitID, UnitName, WareHouseID, WareHouseName, ConvertedUnitID, ConvertedUnitName, 
						WQ7002.S01ID, WQ7002.S02ID, WQ7002.S03ID, WQ7002.S04ID, WQ7002.S05ID, WQ7002.S06ID, WQ7002.S07ID, WQ7002.S08ID, WQ7002.S09ID, WQ7002.S10ID,
						WQ7002.S11ID, WQ7002.S12ID, WQ7002.S13ID, WQ7002.S14ID, WQ7002.S15ID, WQ7002.S16ID, WQ7002.S17ID, WQ7002.S18ID, WQ7002.S19ID, WQ7002.S20ID
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
						0 AS EndAmount,
						ConvertedUnitID, 
				        ConvertedUnitName, 
				        SUM(ISNULL(SignConvertedQuantity, 0)) AS BeginConvertedQuantity,						
						WQ7002.S01ID, WQ7002.S02ID, WQ7002.S03ID, WQ7002.S04ID, WQ7002.S05ID, WQ7002.S06ID, WQ7002.S07ID, WQ7002.S08ID, WQ7002.S09ID, WQ7002.S10ID,
						WQ7002.S11ID, WQ7002.S12ID, WQ7002.S13ID, WQ7002.S14ID, WQ7002.S15ID, WQ7002.S16ID, WQ7002.S17ID, WQ7002.S18ID, WQ7002.S19ID, WQ7002.S20ID
                FROM	WQ7002
                WHERE	DivisionID LIKE N''' + @DivisionID + ''' 
						AND (TranMonth + TranYear*100 < ' + @FromMonthYearText + ' OR D_C = ''BD'' )
						AND WareHouseID in (Select WareHouseID from TBL_WareHouseIDAP7019) 
						AND InventoryID BETWEEN N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''' 
                GROUP BY DivisionID, InventoryID, InventoryName, UnitID, UnitName, ConvertedUnitID, ConvertedUnitName,
						WQ7002.S01ID, WQ7002.S02ID, WQ7002.S03ID, WQ7002.S04ID, WQ7002.S05ID, WQ7002.S06ID, WQ7002.S07ID, WQ7002.S08ID, WQ7002.S09ID, WQ7002.S10ID,
						WQ7002.S11ID, WQ7002.S12ID, WQ7002.S13ID, WQ7002.S14ID, WQ7002.S15ID, WQ7002.S16ID, WQ7002.S17ID, WQ7002.S18ID, WQ7002.S19ID, WQ7002.S20ID 
                ---Having SUM(SignQuantity) <> 0 OR SUM(SignAmount) <> 0 
            '		
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
						0 AS EndAmount,
						ConvertedUnitID, 
				        ConvertedUnitName, 
				        SUM(ISNULL(SignConvertedQuantity, 0)) AS BeginConvertedQuantity,						
						WQ7002.S01ID, WQ7002.S02ID, WQ7002.S03ID, WQ7002.S04ID, WQ7002.S05ID, WQ7002.S06ID, WQ7002.S07ID, WQ7002.S08ID, WQ7002.S09ID, WQ7002.S10ID,
						WQ7002.S11ID, WQ7002.S12ID, WQ7002.S13ID, WQ7002.S14ID, WQ7002.S15ID, WQ7002.S16ID, WQ7002.S17ID, WQ7002.S18ID, WQ7002.S19ID, WQ7002.S20ID
						
                FROM	WQ7002
                WHERE	DivisionID LIKE N''' + @DivisionID + ''' 
						AND ((D_C in (''D'', ''C'') AND CONVERT(DATETIME, CONVERT(VARCHAR(10), VoucherDate, 101), 101) < ''' + Convert(NVARCHAR(10), @FromDate, 101) + ''') 
								OR D_C = ''BD'') 
						AND WareHouseID LIKE N''' + @WareHouseIDNotAll + ''' 
						AND InventoryID BETWEEN N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''' 
                GROUP BY DivisionID, InventoryID, InventoryName, UnitID, UnitName, WareHouseID, WareHouseName, ConvertedUnitID, ConvertedUnitName,
						WQ7002.S01ID, WQ7002.S02ID, WQ7002.S03ID, WQ7002.S04ID, WQ7002.S05ID, WQ7002.S06ID, WQ7002.S07ID, WQ7002.S08ID, WQ7002.S09ID, WQ7002.S10ID,
						WQ7002.S11ID, WQ7002.S12ID, WQ7002.S13ID, WQ7002.S14ID, WQ7002.S15ID, WQ7002.S16ID, WQ7002.S17ID, WQ7002.S18ID, WQ7002.S19ID, WQ7002.S20ID
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
						0 AS EndAmount,
						ConvertedUnitID, 
				        ConvertedUnitName, 
				        SUM(ISNULL(SignConvertedQuantity, 0)) AS BeginConvertedQuantity,						
						WQ7002.S01ID, WQ7002.S02ID, WQ7002.S03ID, WQ7002.S04ID, WQ7002.S05ID, WQ7002.S06ID, WQ7002.S07ID, WQ7002.S08ID, WQ7002.S09ID, WQ7002.S10ID,
						WQ7002.S11ID, WQ7002.S12ID, WQ7002.S13ID, WQ7002.S14ID, WQ7002.S15ID, WQ7002.S16ID, WQ7002.S17ID, WQ7002.S18ID, WQ7002.S19ID, WQ7002.S20ID
                FROM	WQ7002
                WHERE	DivisionID LIKE N''' + @DivisionID + ''' 
						AND ((D_C in (''D'', ''C'') 
								AND CONVERT(DATETIME, CONVERT(VARCHAR(10), VoucherDate, 101), 101) < ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''') 
								OR D_C = ''BD'') 
						AND WareHouseID in (Select WareHouseID from TBL_WareHouseIDAP7019) 
						AND InventoryID BETWEEN N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''' 
                GROUP BY DivisionID, InventoryID, InventoryName, UnitID, UnitName, ConvertedUnitID, ConvertedUnitName,
						WQ7002.S01ID, WQ7002.S02ID, WQ7002.S03ID, WQ7002.S04ID, WQ7002.S05ID, WQ7002.S06ID, WQ7002.S07ID, WQ7002.S08ID, WQ7002.S09ID, WQ7002.S10ID,
						WQ7002.S11ID, WQ7002.S12ID, WQ7002.S13ID, WQ7002.S14ID, WQ7002.S15ID, WQ7002.S16ID, WQ7002.S17ID, WQ7002.S18ID, WQ7002.S19ID, WQ7002.S20ID 
                ---Having SUM(SignQuantity) <> 0 OR SUM(SignAmount) <> 0 
            '
    END
END
ELSE
BEGIN
	IF @IsDate = 0 --- Theo ky
	BEGIN
		IF @IsAll = 0
		BEGIN
			SET @sSQL = N'    
				SELECT	DivisionID, WareHouseID, 
						WareHouseName, 
						InventoryID, 
						InventoryName, 
						UnitID, UnitName, 
						SUM(SignQuantity) AS BeginQuantity, 
						SUM(SignAmount) AS BeginAmount, 
						0 AS EndQuantity, 
						0 AS EndAmount,
						ConvertedUnitID, 
						ConvertedUnitName, 
						SUM(ISNULL(SignConvertedQuantity, 0)) AS BeginConvertedQuantity					
				FROM	WQ7002
				WHERE	DivisionID LIKE N''' + @DivisionID + ''' 
						AND (TranMonth + TranYear*100 < ' + @FromMonthYearText + ' OR D_C = ''BD'' )
						AND WareHouseID like N''' + @WareHouseIDNotAll + '''
						AND InventoryID BETWEEN N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''' 
				GROUP BY DivisionID, InventoryID, InventoryName, UnitID, UnitName, WareHouseID, WareHouseName, ConvertedUnitID, ConvertedUnitName
				---Having SUM(SignQuantity) <> 0 OR SUM(SignAmount) <> 0 
			'	
		END
		ELSE
		BEGIN
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
						0 AS EndAmount,
						ConvertedUnitID, 
						ConvertedUnitName, 
						SUM(ISNULL(SignConvertedQuantity, 0)) AS BeginConvertedQuantity						
				FROM	WQ7002
				WHERE	DivisionID LIKE N''' + @DivisionID + ''' 
						AND (TranMonth + TranYear*100 < ' + @FromMonthYearText + ' OR D_C = ''BD'' )                
						AND WareHouseID IN (Select WareHouseID from TBL_WareHouseIDAP7019) 
						AND InventoryID BETWEEN N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''' 
				GROUP BY DivisionID, InventoryID, InventoryName, UnitID, UnitName, ConvertedUnitID, ConvertedUnitName 
				---Having SUM(SignQuantity) <> 0 OR SUM(SignAmount) <> 0 
			'        	
		END
	END	
	ELSE
	BEGIN
		IF @IsAll = 0
		BEGIN
			SET @sSQL = N'    
				SELECT	DivisionID, WareHouseID, 
						WareHouseName, 
						InventoryID, 
						InventoryName, 
						UnitID, UnitName, 
						SUM(SignQuantity) AS BeginQuantity, 
						SUM(SignAmount) AS BeginAmount, 
						0 AS EndQuantity, 
						0 AS EndAmount,
						ConvertedUnitID, 
						ConvertedUnitName, 
						SUM(ISNULL(SignConvertedQuantity, 0)) AS BeginConvertedQuantity						
				FROM	WQ7002
				WHERE	DivisionID LIKE N''' + @DivisionID + ''' 
						AND ((D_C in (''D'', ''C'') AND CONVERT(DATETIME, CONVERT(VARCHAR(10), VoucherDate, 101), 101) < ''' + Convert(NVARCHAR(10), @FromDate, 101) + ''') 
								OR D_C = ''BD'') 
						AND WareHouseID like N''' + @WareHouseIDNotAll + '''
						AND InventoryID BETWEEN N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''' 
				GROUP BY DivisionID, InventoryID, InventoryName, UnitID, UnitName, WareHouseID, WareHouseName, ConvertedUnitID, ConvertedUnitName
				---Having SUM(SignQuantity) <> 0 OR SUM(SignAmount) <> 0 
			'		
		END
		ELSE
		BEGIN
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
						0 AS EndAmount,
						ConvertedUnitID, 
						ConvertedUnitName, 
						SUM(ISNULL(SignConvertedQuantity, 0)) AS BeginConvertedQuantity						
				FROM	WQ7002
				WHERE	DivisionID LIKE N''' + @DivisionID + ''' 
						AND ((D_C in (''D'', ''C'') 
								AND CONVERT(DATETIME, CONVERT(VARCHAR(10), VoucherDate, 101), 101) < ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''') 
								OR D_C = ''BD'') 
						AND WareHouseID IN (Select WareHouseID from TBL_WareHouseIDAP7019) 
						AND InventoryID BETWEEN N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''' 
				GROUP BY DivisionID, InventoryID, InventoryName, UnitID, UnitName, ConvertedUnitID, ConvertedUnitName 
				---Having SUM(SignQuantity) <> 0 OR SUM(SignAmount) <> 0 
			'		
		END
	END		
END


    
PRINT @sSQL    
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE Xtype = 'V' AND Name = 'AV7019')
    EXEC('CREATE VIEW AV7019 	--CREATED BY AP7019
    AS ' + @sSQL)
ELSE
    EXEC('ALTER VIEW AV7019 	--CREATED BY AP7019
    AS ' + @sSQL)
---- Lay so phat sinh




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
