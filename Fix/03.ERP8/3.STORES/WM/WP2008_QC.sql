IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP2008_QC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP2008_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




 ---- Created by: Nguyen  Thuy Tuyen, 
 ---- Date 06/04/2010.
 ---- Purpose: Bao cao ton kho DVT qui doi theo kho cho tung kho (quy cách)
 ---- UPDATE : 15/04/2010 
 ---- Modified on 14/10/2014 by Thanh Sơn: Chuyển lấy dữ liệu trực tiếp từ store (không qua view)
 ---- Modified on 04/05/2016 by Bảo Anh: Bổ sung isnull cho các trường Parameter01 -> 05
 ---- Modified by Tiểu Mai on 14/09/2016: Sửa lại lấy số dư đầu kỳ chưa đúng
 ---- Modified by Tiểu Mai on 190/2016: Bổ sung store cho Angel
 ---- Modified by Tiểu Mai on 21/10/2016: Fix bug cho An Phát
/********************************************
'* Edited by: [GS] [Việt Khánh] [04/08/2010]
'********************************************/

CREATE PROCEDURE [dbo].[WP2008_QC] 
    @DivisionID NVARCHAR(50), 
    @FromMonth INT, 
    @ToMonth INT, 
    @FromYear INT, 
    @ToYear INT, 
    @FromDate DATETIME, 
    @ToDate DATETIME, 
    @FromInventoryID NVARCHAR(50), 
    @ToInventoryID NVARCHAR(50), 
    @WareHouseID NVARCHAR(50), 
    @IsDate TINYINT, 
    @IsGroupID TINYINT, --- 0 --- Khong nhom
                            --- 1 --- Nhom 1 cap
                            --- 2 --- Nhom 2 cap
    @GroupID1 NVARCHAR(50), 
    @GroupID2 NVARCHAR(50) 
    --- Note : GroupID nhan cac gia tri S1, S2, S3, CI1, CI2, CI3 
 AS
 
DECLARE 
    @sSQL1 NVARCHAR(4000), 
    @sSQL2 NVARCHAR(4000), 
    @sSQL3 NVARCHAR(4000),
    @GroupField1 NVARCHAR(50), 
    @GroupField2 NVARCHAR(50), 
    @FromMonthYearText NVARCHAR(20), 
    @ToMonthYearText NVARCHAR(20), 
    @FromDateText NVARCHAR(20), 
    @ToDateText NVARCHAR(20)

    
SET @FromMonthYearText = STR(@FromMonth + @FromYear * 100)
SET @ToMonthYearText = STR(@ToMonth + @ToYear * 100)
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

IF @IsDate = 0 -- theo ky ----------------------------------------------------------------- 

	BEGIN
			------------------------------------- Xac dinh so du theo ky
		SET @sSQL1 = '
			SELECT DivisionID, WareHouseID, InventoryID, InventoryName, UnitID, UnitName, 0 AS DebitQuantity, 0 AS CreditQuantity, 0 AS DebitAmount, 
				0 AS CreditAmount, 0 AS EndQuantity, 0 AS EndAmount, S1, S2, S3, S1Name, S2Name, S3Name, 
				I01ID, I02ID, I03ID, I04ID, I05ID, InventoryTypeID, Specification, Notes01, Notes02, Notes03, 
				SUM(SignQuantity) AS BeginQuantity, 
				SUM(SignAmount) AS BeginAmount, 
                
				Isnull(V7.Parameter01,0) as Parameter01, Isnull(V7.Parameter02,0) as Parameter02, Isnull(V7.Parameter03,0) as Parameter03,
				Isnull(V7.Parameter04,0) as Parameter04, Isnull(V7.Parameter05,0) as Parameter05, 
				V7.ParameterID, 
				V7.ConvertedUnitID, 
				V7.ConvertedUnitName, 
				SUM(ISNULL(SignConvertedQuantity, 0)) AS BeginConvertedQuantity,
				S01ID, S02ID, S03ID, S04ID,S05ID, S06ID, S07ID, S08ID, S09ID, S10ID,
				S11ID, S12ID, S13ID, S14ID,S15ID, S16ID, S17ID, S18ID, S19ID, S20ID					
			FROM WQ7002 V7
			WHERE (V7.TranMonth + V7.TranYear*100< ' + @FromMonthYearText + ' OR D_C = ''BD'' ) AND
				DivisionID LIKE ''' + @DivisionID + ''' AND
				WareHouseID LIKE ''' + @WareHouseID + '''    AND
				(InventoryID BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + ''') 
                
			GROUP BY DivisionID, WareHouseID, InventoryID, InventoryName, UnitID, UnitName, S1, S2, S3, S1Name, S2Name, S3Name, 
					I01ID, I02ID, I03ID, I04ID, I05ID, InventoryTypeID, Specification, Notes01, Notes02, Notes03, 
					V7.ConvertedUnitID, V7.ConvertedUnitName,
					Isnull(V7.Parameter01,0), Isnull(V7.Parameter02,0), Isnull(V7.Parameter03,0),
					Isnull(V7.Parameter04,0), Isnull(V7.Parameter05,0),
					V7.ParameterID,
					S01ID, S02ID, S03ID, S04ID,S05ID, S06ID, S07ID, S08ID, S09ID, S10ID,
					S11ID, S12ID, S13ID, S14ID,S15ID, S16ID, S17ID, S18ID, S19ID, S20ID								
			'
         
			--print @sSQL1
		IF NOT EXISTS (SELECT 1 FROM sysObjects WHERE Xtype = 'V' AND Name = 'WV7018')
			EXEC(' CREATE VIEW WV7018 AS ' + @sSQL1)
		ELSE
			EXEC(' ALTER VIEW WV7018 AS ' + @sSQL1)


/*
SET @sSQL = 
'SELECT InventoryID, 
	InventoryName, 
	WareHouseID, 
	UnitID, 
	UnitName, 
	ISNULL(AV7018.BeginQuantity, 0) AS BeginQuantity, 
	ISNULL(AV7018.BeginAmount, 0) AS BeginAmount, 
	0 AS DebitQuantity, 
	0 AS CreditQuantity, 
	0 AS DebitAmount, 
	0 AS CreditAmount, 
	0 AS InDebitQuantity, 
	0 AS InCreditQuantity, 
	0 AS EndQuantity, 
	0 AS EndAmount, 
	S1, S2, S3, S1Name, S2Name, S3Name, 
	I01ID, I02ID, I03ID, I04ID, I05ID, 
	AV7018.InventoryTypeID, AV7018.Specification, AV7018.Notes01, AV7018.Notes02, AV7018.Notes03, 
	AV7018.Parameter01, AV7018.Parameter02, AV7018.Parameter03, AV7018.Parameter04, AV7018.Parameter05, 
		ConvertedUnitID, 
		ConvertedUnitName, 
		BeginConvertedQuantity, 
		0 AS DebitConvertedQuantity, 
		0 AS CreditConvertedQuantity
	FROM WV7018  AV7018 
WHERE 
(AV7018.InventoryID NOT IN (SELECT InventoryID FROM WQ7002 AV7000 
			WHERE AV7000.DivisionID = ''' + @DivisionID + ''' AND
			AV7000.WareHouseID LIKE ''' + @WareHouseID + ''' AND
			(AV7000.InventoryID BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + ''') AND
			AV7000.D_C IN (''D'', ''C'') AND
			AV7000.TranMonth + 100*AV7000.TranYear  BETWEEN ' + @FromMonthYearText + ' AND ' + @ToMonthYearText + ' )
OR ParameterID NOT IN (SELECT ParameterID FROM WQ7002 AV7000 
			WHERE AV7000.DivisionID = ''' + @DivisionID + ''' AND
			AV7000.WareHouseID LIKE ''' + @WareHouseID + ''' AND
			(AV7000.InventoryID BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + ''') AND
			AV7000.D_C IN (''D'', ''C'') AND
			AV7000.TranMonth + 100*AV7000.TranYear  BETWEEN ' + @FromMonthYearText + ' AND ' + @ToMonthYearText + ' )
)
'

SET @sSQL = @sSQL + 
'UNION ALL
SELECT AV7000.InventoryID, 
	AV7000.InventoryName, 
	AV7000.WareHouseID, 
	AV7000.UnitID, 
	AV7000.UnitName, 
		ISNULL(AV7018.BeginQuantity, 0) AS BeginQuantity, 
		ISNULL(AV7018.BeginAmount, 0) AS BeginAmount, 
	SUM(CASE WHEN D_C = ''D'' THEN ISNULL(AV7000.ActualQuantity, 0) ELSE 0 END) AS DebitQuantity, 
	SUM(CASE WHEN D_C = ''C'' THEN ISNULL(AV7000.ActualQuantity, 0) ELSE 0 END) AS CreditQuantity, 
	SUM(CASE WHEN D_C = ''D'' THEN ISNULL(AV7000.ConvertedAmount, 0) ELSE 0 END) AS DebitAmount, 
	SUM(CASE WHEN D_C = ''C'' THEN ISNULL(AV7000.ConvertedAmount, 0) ELSE 0 END) AS CreditAmount, 
	SUM(CASE WHEN D_C = ''D'' AND KindVoucherID = 3 THEN ISNULL(AV7000.ActualQuantity, 0) ELSE 0 END) AS InDebitQuantity, 
	SUM(CASE WHEN D_C = ''C''  AND KindVoucherID = 3 THEN ISNULL(AV7000.ActualQuantity, 0) ELSE 0 END) AS InCreditQuantity, 
	0 AS EndQuantity, 
	0 AS EndAmount, 
	AV7000.S1, AV7000.S2, AV7000.S3, AV7000.S1Name, AV7000.S2Name, AV7000.S3Name, 
	AV7000.I01ID, AV7000.I02ID, AV7000.I03ID, AV7000.I04ID, AV7000.I05ID, 
	AV7000.InventoryTypeID, AV7000.Specification, AV7000.Notes01, AV7000.Notes02, AV7000.Notes03, 
	ISNULL(AV7000.Parameter01, 0) AS Parameter01, ISNULL(AV7000.Parameter02, 0) AS Parameter02, ISNULL(AV7000.Parameter03, 0) AS Parameter03, 
	ISNULL(AV7000.Parameter04, 0) AS Parameter04, ISNULL(AV7000.Parameter05, 0) AS Parameter05, 
	AV7000.ConvertedUnitID, 
	AV7000.ConvertedUnitName, 
	ISNULL(BeginConvertedQuantity, 0) AS BeginConvertedQuantity, 
	SUM(CASE WHEN D_C = ''D'' THEN ISNULL(AV7000.ConvertedQuantity, 0) ELSE 0 END) AS DebitConvertedQuantity, 
	SUM(CASE WHEN D_C = ''C'' THEN ISNULL(AV7000.ConvertedQuantity, 0) ELSE 0 END) AS CreditConvertedQuantity

FROM WQ7002 AV7000 LEFT JOIN WV7018  AV7018 ON (AV7000.WareHouseID = AV7018.WareHouseID AND AV7000.InventoryID = AV7018.InventoryID)
        
WHERE AV7000.DivisionID = ''' + @DivisionID + ''' AND
	(AV7000.InventoryID BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + ''') AND
	AV7000.WareHouseID LIKE ''' + @WareHouseID + ''' AND
	AV7000.D_C IN (''D'', ''C'') AND
	AV7000.TranMonth + 100*AV7000.TranYear  BETWEEN ' + @FromMonthYearText + ' AND ' + @ToMonthYearText + '
GROUP BY AV7000.InventoryID, AV7000.InventoryName, AV7000.WareHouseID, 
	AV7000.UnitID, AV7000.UnitName, AV7018.BeginQuantity, AV7018.BeginAmount, 
	AV7000.S1, AV7000.S2, AV7000.S3, AV7000.S1Name, AV7000.S2Name, AV7000.S3Name, 
	AV7000.I01ID, AV7000.I02ID, AV7000.I03ID, AV7000.I04ID, AV7000.I05ID, 
	AV7000.InventoryTypeID, AV7000.Specification, AV7000.Notes01, AV7000.Notes02, AV7000.Notes03, 
	AV7000.ConvertedUnitID, AV7000.ConvertedUnitName, BeginConvertedQuantity, 
	ISNULL(AV7000.Parameter01, 0), ISNULL(AV7000.Parameter02, 0), ISNULL(AV7000.Parameter03, 0), ISNULL(AV7000.Parameter04, 0), ISNULL(AV7000.Parameter05, 0) '

	-- print @sSQL
*/
		SET @sSQL1 = ' SELECT AV7016.DivisionID, AV7016.InventoryID, AV7016.InventoryName, AV7016.UnitID, AV7016.WareHouseID, 
				AV7016.S1, AV7016.S2, AV7016.S3, AV7016.I01ID, AV7016.I02ID, AV7016.I03ID, AV7016.I04ID, AV7016.I05ID, AV7016.InventoryTypeID, AV7016.Specification, 
				AV7016.Notes01, AV7016.Notes02, AV7016.Notes03, 
				AV7016.UnitName, 
				AV7016.BeginQuantity, 
				AV7016.BeginAmount, 
				0 AS DebitQuantity, 
				0 AS CreditQuantity, 
				0 AS DebitAmount, 
				0 AS CreditAmount, 
				0 AS EndQuantity, 
				0 AS EndAmount, 
				AV7016.Parameter01, AV7016.Parameter02, AV7016.Parameter03, AV7016.Parameter04, AV7016.Parameter05, 
				AV7016.ConvertedUnitID, 
				AV7016.ConvertedUnitName, 
				AV7016.BeginConvertedQuantity, 
				0 AS DebitConvertedQuantity, 
				0 AS CreditConvertedQuantity,
				AV7016.S01ID, AV7016.S02ID, AV7016.S03ID, AV7016.S04ID, AV7016.S05ID, AV7016.S06ID, AV7016.S07ID, AV7016.S08ID, AV7016.S09ID, AV7016.S10ID,
				AV7016.S11ID, AV7016.S12ID, AV7016.S13ID, AV7016.S14ID, AV7016.S15ID, AV7016.S16ID, AV7016.S17ID, AV7016.S18ID, AV7016.S19ID, AV7016.S20ID							
                
			FROM WV7018 AV7016
			left join (select AV7000.* FROM WQ7001 AV7000
			WHERE AV7000.DivisionID = ''' + @DivisionID + ''' AND    
								(AV7000.InventoryID BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + ''') AND
								AV7000.WareHouseID LIKE ''' + @WareHouseID + ''' AND
								AV7000.D_C IN (''D'', ''C'') AND
								AV7000.TranMonth + 100*AV7000.TranYear BETWEEN ' + @FromMonthYearText + ' AND ' + @ToMonthYearText + ' ) as AV7000 ON 
								AV7000.InventoryID = AV7016.InventoryID --AND ISNULL(AV7000.ConvertedUnitID, AV7000.UnitID) = ISNULL(AV7016.ConvertedUnitID, AV7016.UnitID)
								  AND Isnull(AV7000.S01ID,'''') = Isnull(AV7016.S01ID,'''')
								  AND Isnull(AV7000.S02ID,'''') = Isnull(AV7016.S02ID,'''')
								  AND Isnull(AV7000.S03ID,'''') = Isnull(AV7016.S03ID,'''')
								  AND Isnull(AV7000.S04ID,'''') = Isnull(AV7016.S04ID,'''')
								  AND Isnull(AV7000.S05ID,'''') = Isnull(AV7016.S05ID,'''')
								  AND Isnull(AV7000.S06ID,'''') = Isnull(AV7016.S06ID,'''')
								  AND Isnull(AV7000.S07ID,'''') = Isnull(AV7016.S07ID,'''')
								  AND Isnull(AV7000.S08ID,'''') = Isnull(AV7016.S08ID,'''')
								  AND Isnull(AV7000.S09ID,'''') = Isnull(AV7016.S09ID,'''')
								  AND Isnull(AV7000.S10ID,'''') = Isnull(AV7016.S10ID,'''')
								  AND Isnull(AV7000.S11ID,'''') = Isnull(AV7016.S11ID,'''')
								  AND Isnull(AV7000.S12ID,'''') = Isnull(AV7016.S12ID,'''')
								  AND Isnull(AV7000.S13ID,'''') = Isnull(AV7016.S13ID,'''')
								  AND Isnull(AV7000.S14ID,'''') = Isnull(AV7016.S14ID,'''')
								  AND Isnull(AV7000.S15ID,'''') = Isnull(AV7016.S15ID,'''')
								  AND Isnull(AV7000.S16ID,'''') = Isnull(AV7016.S16ID,'''')
								  AND Isnull(AV7000.S17ID,'''') = Isnull(AV7016.S17ID,'''')
								  AND Isnull(AV7000.S18ID,'''') = Isnull(AV7016.S18ID,'''')
								  AND Isnull(AV7000.S19ID,'''') = Isnull(AV7016.S19ID,'''')
								  AND Isnull(AV7000.S20ID,'''') = Isnull(AV7016.S20ID,'''')
								  AND AV7016.ParameterID = AV7000.ParameterID
            WHERE ISNULL(AV7000.DivisionID,'''') = ''''
				'

		SET @sSQL2 = 
		'UNION ALL
		SELECT 
			AV7000.DivisionID,
			AV7000.InventoryID, 
			AV7000.InventoryName, 
			AV7000.UnitID, 
			AV7000.WareHouseID, 
			AV7000.S1, AV7000.S2, AV7000.S3, AV7000.I01ID, AV7000.I02ID, AV7000.I03ID, AV7000.I04ID, AV7000.I05ID, AV7000. InventoryTypeID, 
						AV7000.Specification, AV7000.Notes01, AV7000.Notes02, AV7000.Notes03, 
			AV7000.UnitName, 
			ISNULL(AV7016.BeginQuantity, 0) AS BeginQuantity, 
			ISNULL(AV7016.BeginAmount, 0) AS BeginAmount, 
			SUM(CASE WHEN D_C = ''D'' THEN ISNULL(AV7000.ActualQuantity, 0) ELSE 0 END) AS DebitQuantity, 
			SUM(CASE WHEN D_C = ''C'' THEN ISNULL(AV7000.ActualQuantity, 0) ELSE 0 END) AS CreditQuantity, 
			SUM(CASE WHEN D_C = ''D'' THEN ISNULL(AV7000.ConvertedAmount, 0) ELSE 0 END) AS DebitAmount, 
			SUM(CASE WHEN D_C = ''C'' THEN ISNULL(AV7000.ConvertedAmount, 0) ELSE 0 END) AS CreditAmount, 
			0 AS EndQuantity, 
			0 AS EndAmount, 

			--- AV7000.Parameter01, AV7000.Parameter02, AV7000.Parameter03, AV7000.Parameter04, AV7000.Parameter05, 
			ISNULL(AV7000.Parameter01, 0) AS Parameter01, ISNULL(AV7000.Parameter02, 0) AS Parameter02, ISNULL(AV7000.Parameter03, 0) AS Parameter03, 
			ISNULL(AV7000.Parameter04, 0) AS Parameter04, ISNULL(AV7000.Parameter05, 0) AS Parameter05, 

			AV7000.ConvertedUnitID, 
			AV7000.ConvertedUnitName, 
			ISNULL(BeginConvertedQuantity, 0) AS BeginConvertedQuantity, 
			SUM(CASE WHEN D_C = ''D'' THEN ISNULL(AV7000.ConvertedQuantity, 0) ELSE 0 END) AS DebitConvertedQuantity, 
			SUM(CASE WHEN D_C = ''C'' THEN ISNULL(AV7000.ConvertedQuantity, 0) ELSE 0 END) AS CreditConvertedQuantity,
            AV7000.S01ID, AV7000.S02ID, AV7000.S03ID, AV7000.S04ID, AV7000.S05ID, AV7000.S06ID, AV7000.S07ID, AV7000.S08ID, AV7000.S09ID, AV7000.S10ID,
			AV7000.S11ID, AV7000.S12ID, AV7000.S13ID, AV7000.S14ID, AV7000.S15ID, AV7000.S16ID, AV7000.S17ID, AV7000.S18ID, AV7000.S19ID, AV7000.S20ID				
        '
        SET @sSQL3 = '    
		FROM WQ7001 AV7000 
		LEFT JOIN WV7018 AV7016 ON (AV7000.InventoryID = AV7016.InventoryID 
									AND AV7000.ParameterID = AV7016.ParameterID  AND AV7000.DivisionID = AV7016.DivisionID 
									AND ISNULL(AV7000.ConvertedUnitID, AV7000.UnitID) = ISNULL(AV7016.ConvertedUnitID, AV7016.UnitID))
									AND ISNULL(AV7000.S01ID,'''') = ISNULL(AV7016.S01ID,'''')
									AND ISNULL(AV7000.S02ID,'''') = ISNULL(AV7016.S02ID,'''')
									AND ISNULL(AV7000.S03ID,'''') = ISNULL(AV7016.S03ID,'''')
									AND ISNULL(AV7000.S04ID,'''') = ISNULL(AV7016.S04ID,'''')
									AND ISNULL(AV7000.S05ID,'''') = ISNULL(AV7016.S05ID,'''')
									AND ISNULL(AV7000.S06ID,'''') = ISNULL(AV7016.S06ID,'''')
									AND ISNULL(AV7000.S07ID,'''') = ISNULL(AV7016.S07ID,'''')
									AND ISNULL(AV7000.S08ID,'''') = ISNULL(AV7016.S08ID,'''')
									AND ISNULL(AV7000.S09ID,'''') = ISNULL(AV7016.S09ID,'''')
									AND ISNULL(AV7000.S10ID,'''') = ISNULL(AV7016.S10ID,'''')
									AND ISNULL(AV7000.S11ID,'''') = ISNULL(AV7016.S11ID,'''')
									AND ISNULL(AV7000.S12ID,'''') = ISNULL(AV7016.S12ID,'''')
									AND ISNULL(AV7000.S13ID,'''') = ISNULL(AV7016.S13ID,'''')
									AND ISNULL(AV7000.S14ID,'''') = ISNULL(AV7016.S14ID,'''')
									AND ISNULL(AV7000.S15ID,'''') = ISNULL(AV7016.S15ID,'''')
									AND ISNULL(AV7000.S16ID,'''') = ISNULL(AV7016.S16ID,'''')
									AND ISNULL(AV7000.S17ID,'''') = ISNULL(AV7016.S17ID,'''')
									AND ISNULL(AV7000.S18ID,'''') = ISNULL(AV7016.S18ID,'''')
									AND ISNULL(AV7000.S19ID,'''') = ISNULL(AV7016.S19ID,'''')
									AND ISNULL(AV7000.S20ID,'''') = ISNULL(AV7016.S20ID,'''')
                
		WHERE AV7000.DivisionID = ''' + @DivisionID + ''' --AND AV7000.IsTemp = 0 
			AND (AV7000.InventoryID BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + ''') AND
			AV7000.WareHouseID LIKE ''' + @WareHouseID + ''' AND
			AV7000.D_C IN (''D'', ''C'') AND
			AV7000.TranMonth + 100*AV7000.TranYear  BETWEEN ' + @FromMonthYearText + ' AND ' + @ToMonthYearText + '

		GROUP BY AV7000.DivisionID, AV7000.InventoryID, AV7000.InventoryName, AV7000.UnitID, AV7000.UnitName, AV7000.WareHouseID, 
			AV7016.BeginQuantity, AV7016.BeginAmount, 
			AV7000.S1, AV7000.S2, AV7000.S3, AV7000.I01ID, AV7000.I02ID, AV7000.I03ID, AV7000.I04ID, AV7000.I05ID, 
				AV7000. InventoryTypeID, AV7000. Specification, AV7000.Notes01, AV7000.Notes02, AV7000.Notes03, 
			AV7000.ConvertedUnitID, AV7000.ConvertedUnitName, BeginConvertedQuantity, 
			ISNULL(AV7000.Parameter01, 0), ISNULL(AV7000.Parameter02, 0), ISNULL(AV7000.Parameter03, 0), 
			ISNULL(AV7000.Parameter04, 0), ISNULL(AV7000.Parameter05, 0),
            AV7000.S01ID, AV7000.S02ID, AV7000.S03ID, AV7000.S04ID, AV7000.S05ID, AV7000.S06ID, AV7000.S07ID, AV7000.S08ID, AV7000.S09ID, AV7000.S10ID,
			AV7000.S11ID, AV7000.S12ID, AV7000.S13ID, AV7000.S14ID, AV7000.S15ID, AV7000.S16ID, AV7000.S17ID, AV7000.S18ID, AV7000.S19ID, AV7000.S20ID				
			'


			print @sSQL1
			print @sSQL2
			PRINT @sSQL3
		IF NOT EXISTS (SELECT 1 FROM sysObjects WHERE Xtype = 'V' AND Name = 'WV2088')
			EXEC(' CREATE VIEW WV2088 AS ' + @sSQL1 + @sSQL2 + @sSQL3)
		ELSE
			EXEC(' ALTER VIEW WV2088 AS ' + @sSQL1 + @sSQL2 + @sSQL3)


		SET @sSQL1 = 
		'SELECT 
			AV2088.DivisionID,
			AV2088.InventoryID, 
			InventoryName, 
			WareHouseID, 
			AV2088.UnitID, 
			UnitName, 
			'''' AS S1, '''' AS S2, '''' AS S3, '''' AS S1Name, '''' AS S2Name, '''' AS S3Name, 
			I01ID, I02ID, I03ID, I04ID, I05ID, InventoryTypeID, Specification, 
			Notes01, Notes02, Notes03, 
			SUM(BeginQuantity) AS BeginQuantity, 
			SUM(BeginAmount) AS BeginAmount, 
			SUM(DebitQuantity) AS DebitQuantity, 
			SUM(CreditQuantity) AS CreditQuantity, 
			SUM(DebitAmount) AS DebitAmount, 
			SUM(CreditAmount) AS CreditAmount, 
			0 AS InDebitAmount, 0 AS InCreditAmount, 
			NULL AS InDebitQuantity, 
			NULL AS InCreditQuantity, 
			SUM(BeginQuantity + DebitQuantity - CreditQuantity) AS EndQuantity, 
			SUM(BeginAmount + DebitAmount - CreditAmount) AS EndAmount, 
			AV2088.Parameter01, AV2088.Parameter02, AV2088.Parameter03, AV2088.Parameter04, AV2088.Parameter05, 
			ConvertedUnitID, 
			ConvertedUnitName, 
			SUM(ISNULL(BeginConvertedQuantity, 0)) AS BeginConvertedQuantity, 
				DebitConvertedQuantity, 
			CreditConvertedQuantity, 
			SUM(ISNULL(BeginConvertedQuantity, 0)) + ISNULL(DebitConvertedQuantity, 0) - ISNULL(CreditConvertedQuantity, 0) AS EndConvertedQuantity,
            AV2088.S01ID, AV2088.S02ID, AV2088.S03ID, AV2088.S04ID, AV2088.S05ID, AV2088.S06ID, AV2088.S07ID, AV2088.S08ID, AV2088.S09ID, AV2088.S10ID,
			AV2088.S11ID, AV2088.S12ID, AV2088.S13ID, AV2088.S14ID, AV2088.S15ID, AV2088.S16ID, AV2088.S17ID, AV2088.S18ID, AV2088.S19ID, AV2088.S20ID		 				
		FROM WV2088 AV2088
			WHERE BeginQuantity <> 0 OR BeginAmount <> 0 OR DebitQuantity <> 0 OR DebitAmount <> 0 OR
			CreditQuantity <> 0 OR CreditAmount <> 0 OR EndQuantity <> 0 OR EndAmount <> 0 
		GROUP BY AV2088.DivisionID, AV2088.InventoryID, InventoryName, WareHouseID, AV2088.UnitID, UnitName, 
            
			----- S1, S2, S3, S1Name, S2Name, S3Name, 
			I01ID, I02ID, I03ID, I04ID, I05ID, InventoryTypeID, Specification, Notes01, Notes02, Notes03, 
			ConvertedUnitID, ConvertedUnitName, DebitConvertedQuantity, CreditConvertedQuantity, 
					AV2088.Parameter01, AV2088.Parameter02, AV2088.Parameter03, AV2088.Parameter04, AV2088.Parameter05,
                    AV2088.S01ID, AV2088.S02ID, AV2088.S03ID, AV2088.S04ID, AV2088.S05ID, AV2088.S06ID, AV2088.S07ID, AV2088.S08ID, AV2088.S09ID, AV2088.S10ID,
				    AV2088.S11ID, AV2088.S12ID, AV2088.S13ID, AV2088.S14ID, AV2088.S15ID, AV2088.S16ID, AV2088.S17ID, AV2088.S18ID, AV2088.S19ID, AV2088.S20ID 						 
					'

	END ---- Theo KY ---------------------------------------------------- 


ELSE -- theo ngay ----------------------------------------------------- 

	BEGIN
	------------------------------------- Xac dinh so du theo ngay
		SET @sSQL1 = '
			SELECT DivisionID, WareHouseID, InventoryID, InventoryName, UnitID, UnitName, 0 AS DebitQuantity, 0 AS CreditQuantity, 0 AS DebitAmount, 
				0 AS CreditAmount, 0 AS EndQuantity, 0 AS EndAmount, S1, S2, S3, S1Name, S2Name, S3Name, 
				I01ID, I02ID, I03ID, I04ID, I05ID, InventoryTypeID, Specification, Notes01, Notes02, Notes03, 
				SUM(SignQuantity) AS BeginQuantity, 
				SUM(SignAmount) AS BeginAmount, 
                
				Isnull(V7.Parameter01,0) as Parameter01, Isnull(V7.Parameter02,0) as Parameter02, Isnull(V7.Parameter03,0) as Parameter03,
				Isnull(V7.Parameter04,0) as Parameter04, Isnull(V7.Parameter05,0) as Parameter05,
				V7.ParameterID, 
				V7.ConvertedUnitID, 
				V7.ConvertedUnitName, 
				SUM(ISNULL(SignConvertedQuantity, 0)) AS BeginConvertedQuantity,
				S01ID, S02ID, S03ID, S04ID,S05ID, S06ID, S07ID, S08ID, S09ID, S10ID,
				S11ID, S12ID, S13ID, S14ID,S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
			FROM WQ7002 V7
			WHERE (VoucherDate<''' + @FromDateText + ''' OR D_C = ''BD'') AND
				DivisionID LIKE ''' + @DivisionID + ''' AND
				WareHouseID LIKE ''' + @WareHouseID + '''    AND
				(InventoryID BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + ''') 
			GROUP BY DivisionID, WareHouseID, InventoryID, InventoryName, UnitID, UnitName, S1, S2, S3, S1Name, S2Name, S3Name, 
					I01ID, I02ID, I03ID, I04ID, I05ID, InventoryTypeID, Specification, Notes01, Notes02, Notes03, 
				V7.ConvertedUnitID, V7.ConvertedUnitName,
				Isnull(V7.Parameter01,0), Isnull(V7.Parameter02,0), Isnull(V7.Parameter03,0),Isnull(V7.Parameter04,0), Isnull(V7.Parameter05,0),
				V7.ParameterID,
				S01ID, S02ID, S03ID, S04ID,S05ID, S06ID, S07ID, S08ID, S09ID, S10ID,
				S11ID, S12ID, S13ID, S14ID,S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
			'
         

		IF NOT EXISTS (SELECT 1 FROM sysObjects WHERE Xtype = 'V' AND Name = 'WV7018')
			EXEC(' CREATE VIEW WV7018 AS ' + @sSQL1)
		ELSE
			EXEC(' ALTER VIEW WV7018 AS ' + @sSQL1)


		SET @sSQL1 = ' SELECT AV7016.DivisionID, AV7016.InventoryID, AV7016.InventoryName, AV7016.UnitID, AV7016.WareHouseID, 
				AV7016.S1, AV7016.S2, AV7016.S3, AV7016.I01ID, AV7016.I02ID, AV7016.I03ID, AV7016.I04ID, AV7016.I05ID, AV7016.InventoryTypeID, AV7016.Specification, 
				AV7016.Notes01, AV7016.Notes02, AV7016.Notes03, 
				AV7016.UnitName, 
				AV7016.BeginQuantity, 
				AV7016.BeginAmount, 
				0 AS DebitQuantity, 
				0 AS CreditQuantity, 
				0 AS DebitAmount, 
				0 AS CreditAmount, 
				0 AS EndQuantity, 
				0 AS EndAmount, 
				AV7016.Parameter01, AV7016.Parameter02, AV7016.Parameter03, AV7016.Parameter04, AV7016.Parameter05, 
				AV7016.ConvertedUnitID, 
				AV7016.ConvertedUnitName, 
				AV7016.BeginConvertedQuantity, 
				0 AS DebitConvertedQuantity, 
				0 AS CreditConvertedQuantity,
				AV7016.S01ID, AV7016.S02ID, AV7016.S03ID, AV7016.S04ID, AV7016.S05ID, AV7016.S06ID, AV7016.S07ID, AV7016.S08ID, AV7016.S09ID, AV7016.S10ID,
				AV7016.S11ID, AV7016.S12ID, AV7016.S13ID, AV7016.S14ID, AV7016.S15ID, AV7016.S16ID, AV7016.S17ID, AV7016.S18ID, AV7016.S19ID, AV7016.S20ID	
                
			FROM WV7018 AV7016
			left join (select AV7000.* FROM WQ7001 AV7000
			WHERE AV7000.DivisionID = ''' + @DivisionID + ''' AND    
								(AV7000.InventoryID BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + ''') AND
								AV7000.WareHouseID LIKE ''' + @WareHouseID + ''' AND
								AV7000.D_C IN (''D'', ''C'') AND
								AV7000.TranMonth + 100*AV7000.TranYear BETWEEN ' + @FromMonthYearText + ' AND ' + @ToMonthYearText + ' ) as AV7000 ON 
								AV7000.InventoryID = AV7016.InventoryID --AND ISNULL(AV7000.ConvertedUnitID, AV7000.UnitID) = ISNULL(AV7016.ConvertedUnitID, AV7016.UnitID)
								  AND Isnull(AV7000.S01ID,'''') = Isnull(AV7016.S01ID,'''')
								  AND Isnull(AV7000.S02ID,'''') = Isnull(AV7016.S02ID,'''')
								  AND Isnull(AV7000.S03ID,'''') = Isnull(AV7016.S03ID,'''')
								  AND Isnull(AV7000.S04ID,'''') = Isnull(AV7016.S04ID,'''')
								  AND Isnull(AV7000.S05ID,'''') = Isnull(AV7016.S05ID,'''')
								  AND Isnull(AV7000.S06ID,'''') = Isnull(AV7016.S06ID,'''')
								  AND Isnull(AV7000.S07ID,'''') = Isnull(AV7016.S07ID,'''')
								  AND Isnull(AV7000.S08ID,'''') = Isnull(AV7016.S08ID,'''')
								  AND Isnull(AV7000.S09ID,'''') = Isnull(AV7016.S09ID,'''')
								  AND Isnull(AV7000.S10ID,'''') = Isnull(AV7016.S10ID,'''')
								  AND Isnull(AV7000.S11ID,'''') = Isnull(AV7016.S11ID,'''')
								  AND Isnull(AV7000.S12ID,'''') = Isnull(AV7016.S12ID,'''')
								  AND Isnull(AV7000.S13ID,'''') = Isnull(AV7016.S13ID,'''')
								  AND Isnull(AV7000.S14ID,'''') = Isnull(AV7016.S14ID,'''')
								  AND Isnull(AV7000.S15ID,'''') = Isnull(AV7016.S15ID,'''')
								  AND Isnull(AV7000.S16ID,'''') = Isnull(AV7016.S16ID,'''')
								  AND Isnull(AV7000.S17ID,'''') = Isnull(AV7016.S17ID,'''')
								  AND Isnull(AV7000.S18ID,'''') = Isnull(AV7016.S18ID,'''')
								  AND Isnull(AV7000.S19ID,'''') = Isnull(AV7016.S19ID,'''')
								  AND Isnull(AV7000.S20ID,'''') = Isnull(AV7016.S20ID,'''')
								  AND AV7016.ParameterID = AV7000.ParameterID
            WHERE ISNULL(AV7000.DivisionID,'''') = ''''
				'

		SET @sSQL2 = 
		'UNION ALL
		SELECT 
			AV7000.DivisionID,
			AV7000.InventoryID, 
			AV7000.InventoryName, 
			AV7000.UnitID, 
			AV7000.WareHouseID, 
			AV7000.S1, AV7000.S2, AV7000.S3, AV7000.I01ID, AV7000.I02ID, AV7000.I03ID, AV7000.I04ID, AV7000.I05ID, AV7000. InventoryTypeID, 
						AV7000.Specification, AV7000.Notes01, AV7000.Notes02, AV7000.Notes03, 
			AV7000.UnitName, 
			ISNULL(AV7016.BeginQuantity, 0) AS BeginQuantity, 
			ISNULL(AV7016.BeginAmount, 0) AS BeginAmount, 
			SUM(CASE WHEN D_C = ''D'' THEN ISNULL(AV7000.ActualQuantity, 0) ELSE 0 END) AS DebitQuantity, 
			SUM(CASE WHEN D_C = ''C'' THEN ISNULL(AV7000.ActualQuantity, 0) ELSE 0 END) AS CreditQuantity, 
			SUM(CASE WHEN D_C = ''D'' THEN ISNULL(AV7000.ConvertedAmount, 0) ELSE 0 END) AS DebitAmount, 
			SUM(CASE WHEN D_C = ''C'' THEN ISNULL(AV7000.ConvertedAmount, 0) ELSE 0 END) AS CreditAmount, 
			0 AS EndQuantity, 
			0 AS EndAmount, 

			--- AV7000.Parameter01, AV7000.Parameter02, AV7000.Parameter03, AV7000.Parameter04, AV7000.Parameter05, 
			ISNULL(AV7000.Parameter01, 0) AS Parameter01, ISNULL(AV7000.Parameter02, 0) AS Parameter02, ISNULL(AV7000.Parameter03, 0) AS Parameter03, 
			ISNULL(AV7000.Parameter04, 0) AS Parameter04, ISNULL(AV7000.Parameter05, 0) AS Parameter05, 

			AV7000.ConvertedUnitID, 
			AV7000.ConvertedUnitName, 
			ISNULL(BeginConvertedQuantity, 0) AS BeginConvertedQuantity, 
			SUM(CASE WHEN D_C = ''D'' THEN ISNULL(AV7000.ConvertedQuantity, 0) ELSE 0 END) AS DebitConvertedQuantity, 
			SUM(CASE WHEN D_C = ''C'' THEN ISNULL(AV7000.ConvertedQuantity, 0) ELSE 0 END) AS CreditConvertedQuantity,
            AV7000.S01ID, AV7000.S02ID, AV7000.S03ID, AV7000.S04ID, AV7000.S05ID, AV7000.S06ID, AV7000.S07ID, AV7000.S08ID, AV7000.S09ID, AV7000.S10ID,
			AV7000.S11ID, AV7000.S12ID, AV7000.S13ID, AV7000.S14ID, AV7000.S15ID, AV7000.S16ID, AV7000.S17ID, AV7000.S18ID, AV7000.S19ID, AV7000.S20ID			
            

		FROM WQ7001 AV7000   
		LEFT JOIN WV7018 AV7016 ON (AV7000.InventoryID = AV7016.InventoryID 
									AND AV7000.ParameterID = AV7016.ParameterID  AND AV7000.DivisionID = AV7016.DivisionID 
									AND ISNULL(AV7000.ConvertedUnitID, AV7000.UnitID) = ISNULL(AV7016.ConvertedUnitID, AV7016.UnitID))
									AND ISNULL(AV7000.S01ID,'''') = ISNULL(AV7016.S01ID,'''')
									AND ISNULL(AV7000.S02ID,'''') = ISNULL(AV7016.S02ID,'''')
									AND ISNULL(AV7000.S03ID,'''') = ISNULL(AV7016.S03ID,'''')
									AND ISNULL(AV7000.S04ID,'''') = ISNULL(AV7016.S04ID,'''')
									AND ISNULL(AV7000.S05ID,'''') = ISNULL(AV7016.S05ID,'''')
									AND ISNULL(AV7000.S06ID,'''') = ISNULL(AV7016.S06ID,'''')
									AND ISNULL(AV7000.S07ID,'''') = ISNULL(AV7016.S07ID,'''')
									AND ISNULL(AV7000.S08ID,'''') = ISNULL(AV7016.S08ID,'''')
									AND ISNULL(AV7000.S09ID,'''') = ISNULL(AV7016.S09ID,'''')
									AND ISNULL(AV7000.S10ID,'''') = ISNULL(AV7016.S10ID,'''')
									AND ISNULL(AV7000.S11ID,'''') = ISNULL(AV7016.S11ID,'''')
									AND ISNULL(AV7000.S12ID,'''') = ISNULL(AV7016.S12ID,'''')
									AND ISNULL(AV7000.S13ID,'''') = ISNULL(AV7016.S13ID,'''')
									AND ISNULL(AV7000.S14ID,'''') = ISNULL(AV7016.S14ID,'''')
									AND ISNULL(AV7000.S15ID,'''') = ISNULL(AV7016.S15ID,'''')
									AND ISNULL(AV7000.S16ID,'''') = ISNULL(AV7016.S16ID,'''')
									AND ISNULL(AV7000.S17ID,'''') = ISNULL(AV7016.S17ID,'''')
									AND ISNULL(AV7000.S18ID,'''') = ISNULL(AV7016.S18ID,'''')
									AND ISNULL(AV7000.S19ID,'''') = ISNULL(AV7016.S19ID,'''')
									AND ISNULL(AV7000.S20ID,'''') = ISNULL(AV7016.S20ID,'''')
                
		WHERE AV7000.DivisionID = ''' + @DivisionID + ''' --AND AV7000.IsTemp = 0 
			AND (AV7000.InventoryID BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + ''') AND
			AV7000.WareHouseID LIKE ''' + @WareHouseID + ''' AND
			AV7000.D_C IN (''D'', ''C'') AND
			AV7000.TranMonth + 100*AV7000.TranYear  BETWEEN ' + @FromMonthYearText + ' AND ' + @ToMonthYearText + '

		GROUP BY AV7000.DivisionID, AV7000.InventoryID, AV7000.InventoryName, AV7000.UnitID, AV7000.UnitName, AV7000.WareHouseID, 
			AV7016.BeginQuantity, AV7016.BeginAmount, 
			AV7000.S1, AV7000.S2, AV7000.S3, AV7000.I01ID, AV7000.I02ID, AV7000.I03ID, AV7000.I04ID, AV7000.I05ID, 
				AV7000. InventoryTypeID, AV7000. Specification, AV7000.Notes01, AV7000.Notes02, AV7000.Notes03, 
			AV7000.ConvertedUnitID, AV7000.ConvertedUnitName, BeginConvertedQuantity, 
			ISNULL(AV7000.Parameter01, 0), ISNULL(AV7000.Parameter02, 0), ISNULL(AV7000.Parameter03, 0), 
			ISNULL(AV7000.Parameter04, 0), ISNULL(AV7000.Parameter05, 0), 
            AV7000.S01ID, AV7000.S02ID, AV7000.S03ID, AV7000.S04ID, AV7000.S05ID, AV7000.S06ID, AV7000.S07ID, AV7000.S08ID, AV7000.S09ID, AV7000.S10ID,
			AV7000.S11ID, AV7000.S12ID, AV7000.S13ID, AV7000.S14ID, AV7000.S15ID, AV7000.S16ID, AV7000.S17ID, AV7000.S18ID, AV7000.S19ID, AV7000.S20ID			
			'

			--- Print @sSQL
	IF NOT EXISTS (SELECT 1 FROM sysObjects WHERE Xtype = 'V' AND Name = 'WV2088')
			EXEC(' CREATE VIEW WV2088 AS ' + @sSQL1 + @sSQL2)
		ELSE
			EXEC(' ALTER VIEW WV2088 AS ' + @sSQL1 + @sSQL2)

		SET @sSQL1 = 
		'SELECT 
			AV2088.DivisionID,
			AV2088.InventoryID, 
			InventoryName, 
			WareHouseID, 
			AV2088.UnitID, 
			UnitName, 
			'''' AS S1, '''' AS S2, '''' AS S3, '''' AS S1Name, '''' AS S2Name, '''' AS S3Name, 
			I01ID, I02ID, I03ID, I04ID, I05ID, InventoryTypeID, Specification, 
			Notes01, Notes02, Notes03, 
			SUM(BeginQuantity) AS BeginQuantity, 
			SUM(BeginAmount) AS BeginAmount, 
			SUM(DebitQuantity) AS DebitQuantity, 
			SUM(CreditQuantity) AS CreditQuantity, 
			SUM(DebitAmount) AS DebitAmount, 
			SUM(CreditAmount) AS CreditAmount, 
			0 AS InDebitAmount, 0 AS InCreditAmount, 
			0 AS InDebitQuantity, 
			0 AS InCreditQuantity, 
			SUM(BeginQuantity + DebitQuantity - CreditQuantity) AS EndQuantity, 
			SUM(BeginAmount + DebitAmount - CreditAmount) AS EndAmount, 

			AV2088.Parameter01, AV2088.Parameter02, AV2088.Parameter03, AV2088.Parameter04, AV2088.Parameter05, 
			ConvertedUnitID, 
			ConvertedUnitName, 
			SUM(ISNULL(BeginConvertedQuantity, 0)) AS BeginConvertedQuantity, 
				DebitConvertedQuantity, 
			CreditConvertedQuantity, 
			SUM(ISNULL(BeginConvertedQuantity, 0)) + ISNULL(DebitConvertedQuantity, 0) - ISNULL(CreditConvertedQuantity, 0) AS EndConvertedQuantity,
            AV2088.S01ID, AV2088.S02ID, AV2088.S03ID, AV2088.S04ID, AV2088.S05ID, AV2088.S06ID, AV2088.S07ID, AV2088.S08ID, AV2088.S09ID, AV2088.S10ID,
			AV2088.S11ID, AV2088.S12ID, AV2088.S13ID, AV2088.S14ID, AV2088.S15ID, AV2088.S16ID, AV2088.S17ID, AV2088.S18ID, AV2088.S19ID, AV2088.S20ID			
		FROM WV2088 AV2088

            

		WHERE BeginQuantity <> 0 OR BeginAmount <> 0 OR DebitQuantity <> 0 OR DebitAmount <> 0 OR
			CreditQuantity <> 0 OR CreditAmount <> 0 OR EndQuantity <> 0 OR EndAmount <> 0 
		GROUP BY AV2088.DivisionID, AV2088.InventoryID, InventoryName, WareHouseID, AV2088.UnitID, UnitName, 
            
			---- S1, S2, S3, S1Name, S2Name, S3Name, 
			I01ID, I02ID, I03ID, I04ID, I05ID, InventoryTypeID, Specification, Notes01, Notes02, Notes03, 
			ConvertedUnitID, ConvertedUnitName, DebitConvertedQuantity, CreditConvertedQuantity, 
					AV2088.Parameter01, AV2088.Parameter02, AV2088.Parameter03, AV2088.Parameter04, AV2088.Parameter05,
            AV2088.S01ID, AV2088.S02ID, AV2088.S03ID, AV2088.S04ID, AV2088.S05ID, AV2088.S06ID, AV2088.S07ID, AV2088.S08ID, AV2088.S09ID, AV2088.S10ID,
			AV2088.S11ID, AV2088.S12ID, AV2088.S13ID, AV2088.S14ID, AV2088.S15ID, AV2088.S16ID, AV2088.S17ID, AV2088.S18ID, AV2088.S19ID, AV2088.S20ID					
					'

	END ---- Theo ngay ---------------------------------------------------- 

	 --Print @sSQL1

IF NOT EXISTS (SELECT 1 FROM sysObjects WHERE Xtype = 'V' AND Name = 'WV2098')
	EXEC(' CREATE VIEW WV2098 AS ' + @sSQL1)
ELSE
	EXEC(' ALTER VIEW WV2098 AS ' + @sSQL1)



IF @IsGroupID = 0 
	SET @sSQL1 = 
	' SELECT 
		AV3098.DivisionID,
		'''' AS GroupID1, '''' AS GroupID2, '''' AS GroupName1, '''' AS GroupName2, 
		AV3098.InventoryID, 
		AV3098.S1, AV3098.S2, AV3098.S3, 
		AV3098.I01ID, AV3098.I02ID, AV3098.I03ID, AV3098.I04ID, AV3098.I05ID, InventoryTypeID, Specification, 
		AV3098.Notes01, AV3098.Notes02, AV3098.Notes03, 
		AV3098.InventoryName, AV3098.UnitID, AV3098.UnitName, 
        
		AV3098.BeginQuantity, AV3098.EndQuantity, 
        
		AV3098.DebitQuantity, AV3098.CreditQuantity, AV3098.BeginAmount, AV3098.EndAmount, 
		AV3098.DebitAmount, AV3098.CreditAmount, 
		AV3098.InDebitAmount, AV3098.InCreditAmount, AV3098.InDebitQuantity, 
		AV3098.InCreditQuantity, 

		AV3098.Parameter01, AV3098.Parameter02, AV3098.Parameter03, AV3098.Parameter04, AV3098.Parameter05, 
		AV3098.ConvertedUnitID, AV3098.ConvertedUnitName, 

		AV3098.BeginConvertedQuantity, AV3098.EndConvertedQuantity, AV3098.DebitConvertedQuantity, AV3098.CreditConvertedQuantity,
		AV3098.S01ID, AV3098.S02ID, AV3098.S03ID, AV3098.S04ID, AV3098.S05ID, AV3098.S06ID, AV3098.S07ID, AV3098.S08ID, AV3098.S09ID, AV3098.S10ID,
		AV3098.S11ID, AV3098.S12ID, AV3098.S13ID, AV3098.S14ID, AV3098.S15ID, AV3098.S16ID, AV3098.S17ID, AV3098.S18ID, AV3098.S19ID, AV3098.S20ID 			

	FROM WV2098 AS AV3098 
	WHERE BeginQuantity <> 0 OR BeginAmount <> 0 OR DebitQuantity <> 0 OR DebitAmount <> 0 OR
		CreditQuantity <> 0 OR CreditAmount <> 0 OR EndQuantity <> 0 OR EndAmount <> 0 
		'
ELSE
	IF @IsGroupID = 1
		BEGIN
			SET @GroupField1 = (SELECT CASE @GroupID1 WHEN 'CI1' THEN 'S1'  WHEN 'CI2' THEN 'S2' WHEN 'CI3' THEN 'S3'
									WHEN 'I01' THEN 'I01ID'   WHEN 'I02' THEN 'I02ID'   WHEN 'I03' THEN 'I03ID'   WHEN 'I04' THEN 'I04ID'   WHEN 'I05' THEN 'I05ID'   END)
			SET @sSQL1 = ' SELECT 
						AV3098.DivisionID,
						V1.ID AS GroupID1, '''' AS GroupID2, 
						V1.SName AS GroupName1, '''' AS GroupName2, 
						AV3098.InventoryID, 
						AV3098.S1, AV3098.S2, AV3098.S3, 
						AV3098.I01ID, AV3098.I02ID, AV3098.I03ID, AV3098.I04ID, AV3098.I05ID, InventoryTypeID, Specification, 
						AV3098.Notes01, AV3098.Notes02, AV3098.Notes03, 
						AV3098.InventoryName, AV3098.UnitID, AV3098.UnitName, 
                        
						AV3098.BeginQuantity, AV3098.EndQuantity, 
                        
						AV3098.DebitQuantity, AV3098.CreditQuantity, AV3098.BeginAmount, AV3098.EndAmount, 
						AV3098.DebitAmount, AV3098.CreditAmount, 
						AV3098.InDebitAmount, AV3098.InCreditAmount, AV3098.InDebitQuantity, 
						AV3098.InCreditQuantity, 
                        
						AV3098.Parameter01, AV3098.Parameter02, AV3098.Parameter03, AV3098.Parameter04, AV3098.Parameter05, 
				AV3098.ConvertedUnitID, AV3098.ConvertedUnitName, 
				AV3098.BeginConvertedQuantity, AV3098.EndConvertedQuantity, AV3098.DebitConvertedQuantity, AV3098.CreditConvertedQuantity,
			    AV3098.S01ID, AV3098.S02ID, AV3098.S03ID, AV3098.S04ID, AV3098.S05ID, AV3098.S06ID, AV3098.S07ID, AV3098.S08ID, AV3098.S09ID, AV3098.S10ID,
			    AV3098.S11ID, AV3098.S12ID, AV3098.S13ID, AV3098.S14ID, AV3098.S15ID, AV3098.S16ID, AV3098.S17ID, AV3098.S18ID, AV3098.S19ID, AV3098.S20ID 					

				FROM WV2098 AS AV3098 LEFT JOIN AV1310 V1 ON AV3098.DivisionID = V1.DivisionID and V1.ID = AV3098.' + @GroupField1 + ' AND V1.TypeID = ''' + @GroupID1 + ''' 

			WHERE BeginQuantity <> 0 OR BeginAmount <> 0 OR DebitQuantity <> 0 OR DebitAmount <> 0 OR
				CreditQuantity <> 0 OR CreditAmount <> 0 OR EndQuantity <> 0 OR EndAmount <> 0 
				'
        
		END    
 
	ELSE
		IF @IsGroupID = 2
			BEGIN
			SET @GroupField1 = (SELECT CASE @GroupID1 WHEN 'CI1' THEN 'S1'  WHEN 'CI2' THEN 'S2' WHEN 'CI3' THEN 'S3'
									WHEN 'I01' THEN 'I01ID'   WHEN 'I02' THEN 'I02ID'   WHEN 'I03' THEN 'I03ID'   WHEN 'I04' THEN 'I04ID'   WHEN 'I05' THEN 'I05ID'   END)

			SET @GroupField2 = (SELECT CASE @GroupID2 WHEN 'CI1' THEN 'S1'  WHEN 'CI2' THEN 'S2' WHEN 'CI3' THEN 'S3'
									WHEN 'I01' THEN 'I01ID'   WHEN 'I02' THEN 'I02ID'   WHEN 'I03' THEN 'I03ID'   WHEN 'I04' THEN 'I04ID'   WHEN 'I05' THEN 'I05ID'   END)


			SET @sSQL1 = ' SELECT 
						AV3098.DivisionID,
						V1.ID AS GroupID1, V2.ID AS GroupID2, 
						V1.SName AS GroupName1, V2.SName AS GroupName2, 
						AV3098.InventoryID, 
						AV3098.S1, AV3098.S2, AV3098.S3, 
						AV3098.I01ID, AV3098.I02ID, AV3098.I03ID, AV3098.I04ID, AV3098.I05ID, InventoryTypeID, Specification, 
						AV3098.Notes01, AV3098.Notes02, AV3098.Notes03, 
						AV3098.InventoryName, AV3098.UnitID, AV3098.UnitName, 
                        
						AV3098.BeginQuantity, AV3098.EndQuantity, 
                        
						AV3098.DebitQuantity, AV3098.CreditQuantity, AV3098.BeginAmount, AV3098.EndAmount, 
						AV3098.DebitAmount, AV3098.CreditAmount, 
						AV3098.InDebitAmount, AV3098.InCreditAmount, AV3098.InDebitQuantity, 
						AV3098.InCreditQuantity, 
            
						AV3098.Parameter01, AV3098.Parameter02, AV3098.Parameter03, AV3098.Parameter04, AV3098.Parameter05, 
						AV3098.ConvertedUnitID, AV3098.ConvertedUnitName, 

						AV3098.BeginConvertedQuantity, AV3098.EndConvertedQuantity, AV3098.DebitConvertedQuantity, AV3098.CreditConvertedQuantity,
			            AV3098.S01ID, AV3098.S02ID, AV3098.S03ID, AV3098.S04ID, AV3098.S05ID, AV3098.S06ID, AV3098.S07ID, AV3098.S08ID, AV3098.S09ID, AV3098.S10ID,
			            AV3098.S11ID, AV3098.S12ID, AV3098.S13ID, AV3098.S14ID, AV3098.S15ID, AV3098.S16ID, AV3098.S17ID, AV3098.S18ID, AV3098.S19ID, AV3098.S20ID 							

				FROM WV2098 AS AV3098 LEFT JOIN AV1310 V1 ON AV3098.DivisionID = V1.DivisionID and V1.ID = AV3098.' + @GroupField1 + ' AND V1.TypeID = ''' + @GroupID1 + ''' 
						LEFT JOIN AV1310 V2 ON V2.ID = AV3098.' + @GroupField2 + ' AND V2.TypeID = ''' + @GroupID2 + ''' 

			WHERE BeginQuantity <> 0 OR BeginAmount <> 0 OR DebitQuantity <> 0 OR DebitAmount <> 0 OR
				CreditQuantity <> 0 OR CreditAmount <> 0 OR EndQuantity <> 0 OR EndAmount <> 0 
				'
            
			END    
EXEC (@sSQL1)
	--- print  @sSQL
--IF NOT EXISTS (SELECT 1 FROM sysObjects WHERE Xtype = 'V' AND Name = 'WV2008')
--    EXEC(' CREATE VIEW WV2008 AS ' + @sSQL1)
--ELSE
--    EXEC(' ALTER VIEW WV2008 AS ' + @sSQL1)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
