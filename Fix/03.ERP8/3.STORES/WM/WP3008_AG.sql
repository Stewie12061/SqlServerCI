IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP3008_AG]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[WP3008_AG]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- IN bao cao nhap xuat ton theo DVT qui doi cho ANGEL (CustomizeIndex = 57)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 31/03/2010 by Thuy Tuyen
---- 
---- Modified on 13/04/2010 by Thuy Tuyen : Them truong parameterID
---- Modified on 07/03/2012 by Lê Thị Thu Hiền : Sửa Group ISNULL(V7.Parameter01,0)
---- Modified on 07/03/2012 by Thanh Sơn: Lấy dữ liệu trực tiếp từ store, không qua view
---- Modified on 11/09/2015 by Thanh Thịnh: Chỉ hiện những người có trường Thủ Kho ở AT1303 là khác 1 (Figla)
---- Modified by Tiểu Mai on 14/09/2016: Sửa lại lấy số dư đầu kỳ chưa đúng
---- Modified by Phương Thảo on 26/05/2017: Sửa danh mục dùng chung
-- <Example>
/*
EXEC WP3008
@DivisionID = 'MP', @FromMonth = 2, @ToMonth = 2, @FromYear = 2012, @ToYear = 2012, @FromDate = '01/02/2012', @ToDate = '28/02/2012',
@FromInventoryID = '000000000009', @ToInventoryID = '000000000009', @IsDate = 0, @IsGroupID = 1, @GroupID1 = 'I01', @GroupID2 = '' 
*/



CREATE PROCEDURE [dbo].[WP3008_AG] 
    @DivisionID AS NVARCHAR(50), 
    @FromMonth INT, 
    @ToMonth INT, 
    @FromYear INT, 
    @ToYear INT, 
    @FromDate DATETIME, 
    @ToDate DATETIME, 
    @FromInventoryID NVARCHAR(50), 
    @ToInventoryID NVARCHAR(50), 
    @IsDate TINYINT, 
    @IsGroupID TINYINT,  --- 0 --- Khong nhom
                            --- 1 --- Nhom 1 cap
                            --- 2 --- Nhom 2 cap
    @GroupID1 NVARCHAR(50), 
    @GroupID2 NVARCHAR(50) 
    --- Note : GroupID nhan cac gia tri S1, S2, S3, CI1, CI2, CI3
AS
 
DECLARE 
    @sSQL1 NVARCHAR(4000), 
    @sSQL2 NVARCHAR(4000), 
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

DECLARE @CustomerName INT
--Tao bang tam de kiem tra day co phai la khach hang Figla khong (CustomerName = 49)
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)


IF @IsDate = 0 -- theo ky
    BEGIN
        SET @sSQL1 = '
            SELECT DivisionID, InventoryID, InventoryName, UnitID, S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, UnitName, VATPercent, InventoryTypeID, Specification, 
                V7.Notes01, V7.Notes02, V7.Notes03, 
                SUM(SignQuantity) AS BeginQuantity, 
                SUM(SignAmount) AS BeginAmount, 
                ISNULL(V7.Parameter01,0) AS Parameter01, 
                ISNULL(V7.Parameter02,0) AS Parameter02, 
                ISNULL(V7.Parameter03,0) AS Parameter03, 
                ISNULL(V7.Parameter04,0) AS Parameter04,
                ISNULL(V7.Parameter05,0) AS Parameter05, 
                V7.ParameterID, 
                --V7.ConvertedUnitID, 
                --V7.ConvertedUnitName, 
                SUM(ISNULL(SignConvertedQuantity, 0)) AS BeginConvertedQuantity
            FROM WQ7002 V7
            WHERE DivisionID LIKE ''' + @DivisionID + ''' 
                AND (V7.TranMonth + V7.TranYear*100 < ' + @FromMonthYearText + ' OR D_C = ''BD'' ) 
                AND (InventoryID BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + ''') 
            GROUP BY DivisionID, InventoryID, InventoryName, UnitID, S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, UnitName, VATPercent, InventoryTypeID, Specification, V7.Notes01, V7.Notes02, V7.Notes03, 
                --V7.ConvertedUnitID, V7.ConvertedUnitName, 
                ISNULL(V7.Parameter01,0), ISNULL(V7.Parameter02,0), ISNULL(V7.Parameter03,0), ISNULL(V7.Parameter04,0), ISNULL(V7.Parameter05,0), V7.ParameterID
        '

        IF NOT EXISTS (SELECT 1 FROM sysObjects WHERE Xtype = 'V' AND Name = 'WV7016')
            EXEC(' CREATE VIEW WV7016 AS ' + @sSQL1) -- tao boi store  WP3008
        ELSE
            EXEC(' ALTER VIEW WV7016 AS ' + @sSQL1) ----- tao boi store  WP3008

        SET @sSQL1 = '
            SELECT DivisionID, InventoryID, InventoryName, UnitID, 
                S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, VATPercent, InventoryTypeID, Specification, 
                Notes01, Notes02, Notes03, 
                UnitName, 
                BeginQuantity, 
                BeginAmount, 
                0 AS DebitQuantity, 
                0 AS CreditQuantity, 
                0 AS DebitAmount, 
                0 AS CreditAmount, 
                0 AS EndQuantity, 
                0 AS EndAmount, 
                AV7016.Parameter01, AV7016.Parameter02, AV7016.Parameter03, AV7016.Parameter04, AV7016.Parameter05, 
                --ConvertedUnitID, 
                --ConvertedUnitName, 
                BeginConvertedQuantity, 
                0 AS DebitConvertedQuantity, 
                0 AS CreditConvertedQuantity        
            FROM WV7016 AV7016
            WHERE (InventoryID NOT IN (SELECT InventoryID 
                                       FROM WQ7001 AV7000 
                                       WHERE AV7000.DivisionID = ''' + @DivisionID + ''' 
                                           AND (AV7000.InventoryID BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + ''') 
                                           AND AV7000.D_C IN (''D'', ''C'') 
										   '+CASE WHEN @CustomerName = 49 THEN 'AND ISNULL(AV7000.WHFullName,'''') = ''1'' ' ELSE'' END  +'
                                           AND AV7000.TranMonth + 100*AV7000.TranYear BETWEEN ' + @FromMonthYearText + ' AND ' + @ToMonthYearText + ' )
                   OR ParameterID NOT IN (SELECT ParameterID 
                                          FROM WQ7001 AV7000 
                                          WHERE AV7000.DivisionID = ''' + @DivisionID + ''' 
                                              AND (AV7000.InventoryID BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + ''') 
                                              AND AV7000.D_C IN (''D'', ''C'') 
											  '+CASE WHEN @CustomerName = 49 THEN 'AND ISNULL(AV7000.WHFullName,'''') = ''1'' 'ELSE'' END +'
                                              AND AV7000.TranMonth + 100*AV7000.TranYear  BETWEEN ' + @FromMonthYearText + ' AND ' + @ToMonthYearText + ' ))
        '

        SET @sSQL2 = '
            UNION ALL
            SELECT AV7000.DivisionID, AV7000.InventoryID, 
                AV7000.InventoryName, 
                AV7000.UnitID, 
                AV7000.S1, AV7000.S2, AV7000.S3, AV7000.I01ID, AV7000.I02ID, AV7000.I03ID, AV7000.I04ID, AV7000.I05ID, AV7000.VATPercent, AV7000. InventoryTypeID, 
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
                ISNULL(AV7000.Parameter01, 0) AS Parameter01, ISNULL(AV7000.Parameter02, 0) AS Parameter02, ISNULL(AV7000.Parameter03, 0) AS Parameter03, 
                ISNULL(AV7000.Parameter04, 0) AS Parameter04, ISNULL(AV7000.Parameter05, 0) AS Parameter05, 
                --AV7000.ConvertedUnitID, 
                --AV7000.ConvertedUnitName, 
                ISNULL(BeginConvertedQuantity, 0) AS BeginConvertedQuantity, 
                SUM(CASE WHEN D_C = ''D'' THEN ISNULL(AV7000.ConvertedQuantity, 0) ELSE 0 END) AS DebitConvertedQuantity, 
                SUM(CASE WHEN D_C = ''C'' THEN ISNULL(AV7000.ConvertedQuantity, 0) ELSE 0 END) AS CreditConvertedQuantity
            FROM WQ7001 AV7000 
			LEFT JOIN WV7016 AV7016 ON (AV7000.InventoryID = AV7016.InventoryID 
									AND AV7000.ParameterID = AV7016.ParameterID  AND AV7000.DivisionID = AV7016.DivisionID )
									--AND ISNULL(AV7000.ConvertedUnitID, AV7000.UnitID) = ISNULL(AV7016.ConvertedUnitID, AV7016.UnitID))
            WHERE AV7000.DivisionID = ''' + @DivisionID + ''' --AND AV7000.IsTemp = 0 
                AND (AV7000.InventoryID BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + ''') 
                AND AV7000.D_C IN (''D'', ''C'') 
				'+CASE WHEN @CustomerName = 49 THEN 'AND ISNULL(AV7000.WHFullName,'''') <> ''1'' 'ELSE''END  +'
                AND AV7000.TranMonth + 100*AV7000.TranYear  BETWEEN ' + @FromMonthYearText + ' AND ' + @ToMonthYearText + '
            GROUP BY AV7000.DivisionID, AV7000.InventoryID, AV7000.InventoryName, AV7000.UnitID, AV7000.UnitName, AV7016.BeginQuantity, AV7016.BeginAmount, 
                AV7000.S1, AV7000.S2, AV7000.S3, AV7000.I01ID, AV7000.I02ID, AV7000.I03ID, AV7000.I04ID, AV7000.I05ID, 
                AV7000.VATPercent, AV7000. InventoryTypeID, AV7000. Specification, AV7000.Notes01, AV7000.Notes02, AV7000.Notes03, 
                --AV7000.ConvertedUnitID, AV7000.ConvertedUnitName, 
                BeginConvertedQuantity, 
                ISNULL(AV7000.Parameter01, 0), ISNULL(AV7000.Parameter02, 0), ISNULL(AV7000.Parameter03, 0), 
                ISNULL(AV7000.Parameter04, 0), ISNULL(AV7000.Parameter05, 0) 
         '

         --- print @sSQL
        IF NOT EXISTS (SELECT 1 FROM sysObjects WHERE Xtype = 'V' AND Name = 'WV3088')
            EXEC(' CREATE VIEW WV3088 AS ' + @sSQL1 + @sSQL2) --- TAO BOI  WP3008
        ELSE
            EXEC(' ALTER VIEW WV3088 AS ' + @sSQL1 + @sSQL2) --- TAO BOI  WP3008

        SET @sSQL1 = '
            SELECT AV3088.DivisionID, AV3088.InventoryID, 
                InventoryName, 
                AV3088.UnitID, 
                UnitName, AV3088.VATPercent, AV3088. InventoryTypeID, Specification, 
                AV3088.Notes01, AV3088.Notes02, AV3088.Notes03, 
                --AT1309.UnitID AS ConversionUnitID, AT1309.ConversionFactor, AT1309.Operator, 
                S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, 
                SUM(BeginQuantity) AS BeginQuantity, 
                SUM(BeginAmount) AS BeginAmount, 
                DebitQuantity, 
                CreditQuantity, 
                DebitAmount, 
                CreditAmount, 
                0 AS InDebitAmount, 0 AS InCreditAmount, 0 AS InDebitQuantity, 
                0 AS InCreditQuantity, 
                SUM(BeginQuantity) + DebitQuantity - CreditQuantity AS EndQuantity, 
                SUM(BeginAmount) + DebitAmount - CreditAmount AS EndAmount, 
                AV3088.Parameter01, AV3088.Parameter02, AV3088.Parameter03, AV3088.Parameter04, AV3088.Parameter05, 
                --ConvertedUnitID, 
                --ConvertedUnitName, 
                SUM(ISNULL(BeginConvertedQuantity, 0)) AS BeginConvertedQuantity, 
                DebitConvertedQuantity, 
                CreditConvertedQuantity, 
                SUM(ISNULL(BeginConvertedQuantity, 0)) + ISNULL(DebitConvertedQuantity, 0) - ISNULL(CreditConvertedQuantity, 0) AS EndConvertedQuantity
            FROM WV3088 AV3088 
            --LEFT JOIN AT1309 WITH (NOLOCK) ON AT1309.InventoryID = AV3088.InventoryID and AT1309.DivisionID = AV3088.DivisionID AND AV3088.UnitID = AT1309.UnitID
            GROUP BY AV3088.DivisionID, S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, AV3088.InventoryID, InventoryName, AV3088.UnitID, UnitName, 
                --AT1309.UnitID, AT1309.ConversionFactor, AT1309.Operator, 
                DebitQuantity, DebitAmount, CreditQuantity, CreditAmount, 
                AV3088.VATPercent, AV3088. InventoryTypeID, Specification, AV3088.Notes01, AV3088.Notes02, AV3088.Notes03, 
                --ConvertedUnitID, ConvertedUnitName, 
                DebitConvertedQuantity, CreditConvertedQuantity, 
                AV3088.Parameter01, AV3088.Parameter02, AV3088.Parameter03, AV3088.Parameter04, AV3088.Parameter05
        '
    END --- theo KY ------------------------------------------------------- 
ELSE -- THEO NGAY
    BEGIN
        SET @sSQL1 = '
            SELECT DivisionID, InventoryID, InventoryName, UnitID, S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, UnitName, VATPercent, InventoryTypeID, Specification, 
                V7.Notes01, V7.Notes02, V7.Notes03, 
                SUM(SignQuantity) AS BeginQuantity, 
                SUM(SignAmount) AS BeginAmount, 
                ISNULL(V7.Parameter01,0) AS Parameter01, 
                ISNULL(V7.Parameter02,0) AS Parameter02, 
                ISNULL(V7.Parameter03,0) AS Parameter03, 
                ISNULL(V7.Parameter04,0) AS Parameter04,
                ISNULL(V7.Parameter05,0) AS Parameter05, 
                V7.ParameterID, 
                --V7.ConvertedUnitID, 
                --V7.ConvertedUnitName, 
                SUM(ISNULL(SignConvertedQuantity, 0)) AS BeginConvertedQuantity
            FROM WQ7002 V7
            WHERE DivisionID LIKE ''' + @DivisionID + ''' 
                AND (VoucherDate <''' + @FromDateText + '''  OR D_C = ''BD'' )
                AND (InventoryID BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + ''') 
            GROUP BY DivisionID, InventoryID, InventoryName, UnitID, S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, UnitName, VATPercent, InventoryTypeID, Specification, V7.Notes01, V7.Notes02, V7.Notes03, 
                --V7.ConvertedUnitID, V7.ConvertedUnitName, 
                ISNULL(V7.Parameter01,0), ISNULL(V7.Parameter02,0), ISNULL(V7.Parameter03,0), ISNULL(V7.Parameter04,0), ISNULL(V7.Parameter05,0),
                V7.ParameterID
        '

        IF NOT EXISTS (SELECT 1 FROM sysObjects WHERE Xtype = 'V' AND Name = 'WV7016')
            EXEC(' CREATE VIEW WV7016 AS ' + @sSQL1) -- Tao boi store WV7016
        ELSE
            EXEC(' ALTER VIEW WV7016 AS ' + @sSQL1) ---- Tao boi store WV7016

        SET @sSQL1 = '
            SELECT DivisionID, InventoryID, InventoryName, UnitID, 
                S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, VATPercent, InventoryTypeID, Specification, 
                Notes01, Notes02, Notes03, 
                UnitName, 
                BeginQuantity, 
                BeginAmount, 
                0 AS DebitQuantity, 
                0 AS CreditQuantity, 
                0 AS DebitAmount, 
                0 AS CreditAmount, 
                0 AS EndQuantity, 
                0 AS EndAmount,         
                AV7016.Parameter01, AV7016.Parameter02, AV7016.Parameter03, AV7016.Parameter04, AV7016.Parameter05, 
                --ConvertedUnitID, 
                --ConvertedUnitName, 
                BeginConvertedQuantity, 
                0 AS DebitConvertedQuantity, 
                0 AS CreditConvertedQuantity
            FROM WV7016 AV7016
            WHERE InventoryID NOT IN (SELECT InventoryID FROM WQ7001 AV7000 
                                      WHERE AV7000.DivisionID = ''' + @DivisionID + ''' 
                                          AND (AV7000.InventoryID BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + ''') 
                                          AND AV7000.D_C IN (''D'', ''C'') 
										  '+CASE WHEN @CustomerName = 49 THEN'AND ISNULL(AV7000.WHFullName,'''') = ''1'' 'ELSE''END  +'
                                          AND AV7000.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''')
        '

        SET @sSQL2 = '
            UNION AL
            SELECT AV7000.DivisionID, AV7000.InventoryID, 
                AV7000.InventoryName, 
                AV7000.UnitID, 
                AV7000.S1, AV7000.S2, AV7000.S3, AV7000.I01ID, AV7000.I02ID, AV7000.I03ID, AV7000.I04ID, AV7000.I05ID, AV7000.VATPercent, AV7000. InventoryTypeID, 
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
                AV7000.Parameter01, AV7000.Parameter02, AV7000.Parameter03, AV7000.Parameter04, AV7000.Parameter05, 
                --AV7000.ConvertedUnitID, 
                --AV7000.ConvertedUnitName, 
                ISNULL(BeginConvertedQuantity, 0) AS BeginConvertedQuantity, 
                SUM(CASE WHEN D_C = ''D'' THEN ISNULL(AV7000.ConvertedQuantity, 0) ELSE 0 END) AS DebitConvertedQuantity, 
                SUM(CASE WHEN D_C = ''C'' THEN ISNULL(AV7000.ConvertedQuantity, 0) ELSE 0 END) AS CreditConvertedQuantity
            FROM WQ7001 AV7000 
            LEFT JOIN WV7016 AV7016   ON (AV7000.InventoryID = AV7016.InventoryID and AV7000.DivisionID = AV7016.DivisionID 
									AND ISNULL(AV7000.ConvertedUnitID, AV7000.UnitID) = ISNULL(AV7016.ConvertedUnitID, AV7016.UnitID))
            WHERE AV7000.DivisionID = ''' + @DivisionID + ''' --AND AV7000.IsTemp = 0 
                AND (AV7000.InventoryID BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + ''') 
                AND AV7000.D_C IN (''D'', ''C'') 
				'+CASE WHEN @CustomerName = 49 THEN 'AND ISNULL(AV7000.WHFullName,'''') <> ''1'' 'ELSE'' END +'
    AND AV7000.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + '''
            GROUP BY AV7000.DivisionID, AV7000.InventoryID, AV7000.InventoryName, AV7000.UnitID, AV7000.UnitName, AV7016.BeginQuantity, AV7016.BeginAmount, 
                AV7000.S1, AV7000.S2, AV7000.S3, AV7000.I01ID, AV7000.I02ID, AV7000.I03ID, AV7000.I04ID, AV7000.I05ID, 
                AV7000.VATPercent, AV7000. InventoryTypeID, AV7000. Specification, AV7000.Notes01, AV7000.Notes02, AV7000.Notes03, 
                --AV7000.ConvertedUnitID, AV7000.ConvertedUnitName, 
                BeginConvertedQuantity, 
                AV7000.Parameter01, AV7000.Parameter02, AV7000.Parameter03, AV7000.Parameter04, AV7000.Parameter05
        '

 --- print @sSQL
        IF NOT EXISTS (SELECT 1 FROM sysObjects WHERE Xtype = 'V' AND Name = 'WV3088')
            EXEC(' CREATE VIEW WV3088 AS ' + @sSQL1 + @sSQL2) --- TAO BOI  AP3008
        ELSE
            EXEC(' ALTER VIEW WV3088 AS ' + @sSQL1 + @sSQL2) --- TAO BOI  AP3008

        SET @sSQL1 = '
            SELECT AV3088.DivisionID, AV3088.InventoryID, 
                InventoryName, 
                AV3088.UnitID, 
                UnitName, AV3088.VATPercent, AV3088. InventoryTypeID, Specification, 
                AV3088.Notes01, AV3088.Notes02, AV3088.Notes03, 
                --AV3088.ConvertedUnitID AS ConversionUnitID, AT1309.ConversionFactor, AT1309.Operator, 
                S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, 
                SUM(BeginQuantity) AS BeginQuantity, 
                SUM(BeginAmount) AS BeginAmount, 
                DebitQuantity, 
                CreditQuantity, 
                DebitAmount, 
                CreditAmount, 
                0 AS InDebitAmount, 0 AS InCreditAmount, 0 AS InDebitQuantity, 
                0 AS InCreditQuantity, 
                SUM(BeginQuantity) + DebitQuantity - CreditQuantity AS EndQuantity, 
                SUM(BeginAmount) + DebitAmount - CreditAmount AS EndAmount,             
                AV3088.Parameter01, AV3088.Parameter02, AV3088.Parameter03, AV3088.Parameter04, AV3088.Parameter05, 
                --ConvertedUnitID, 
                --ConvertedUnitName, 
                SUM(ISNULL(BeginConvertedQuantity, 0)) AS BeginConvertedQuantity, 
                DebitConvertedQuantity, 
                CreditConvertedQuantity, 
                SUM(ISNULL(BeginConvertedQuantity, 0)) + ISNULL(DebitConvertedQuantity, 0) - ISNULL(CreditConvertedQuantity, 0) AS EndConvertedQuantity
            FROM WV3088 AV3088 
            LEFT JOIN AT1309 WITH (NOLOCK) ON AT1309.InventoryID = AV3088.InventoryID and AV3088.UnitID = AT1309.UnitID
            GROUP BY AV3088.DivisionID, S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, AV3088.InventoryID, InventoryName, AV3088.UnitID, UnitName, 
               --AT1309.ConversionFactor, AT1309.Operator, 
                DebitQuantity, DebitAmount, CreditQuantity, CreditAmount, 
                AV3088.VATPercent, AV3088. InventoryTypeID, Specification, AV3088.Notes01, AV3088.Notes02, AV3088.Notes03, 
                --ConvertedUnitID, ConvertedUnitName, 
                DebitConvertedQuantity, CreditConvertedQuantity, 
                AV3088.Parameter01, AV3088.Parameter02, AV3088.Parameter03, AV3088.Parameter04, AV3088.Parameter05 
    '
END --- theo ngay ------------------------------------------------------- 

 -- print @sSQL
IF NOT EXISTS (SELECT 1 FROM sysObjects WHERE Xtype = 'V' AND Name = 'WV3098')
    EXEC(' CREATE VIEW WV3098 AS ' + @sSQL1) -- Tao boi store WP3008
ELSE
    EXEC(' ALTER VIEW WV3098 AS ' + @sSQL1) ---- Tao boi store WP3008

IF @IsGroupID = 0 
    SET @sSQL1 = '
        SELECT	AV3098.DivisionID, '''' AS GroupID1, '''' AS GroupID2, '''' AS GroupName1, '''' AS GroupName2, 
				AV3098.InventoryID, S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, 
				AV3098.InventoryName, AV3098.UnitID, AV3098.UnitName, AV3098.VATPercent, AV3098. InventoryTypeID, Specification, 
				AV3098.Notes01, AV3098.Notes02, AV3098.Notes03, 
				--AV3098.ConversionUnitID, AV3098.ConversionFactor, AV3098.Operator, 
				AV3098.BeginQuantity, AV3098.EndQuantity, 
				--CASE WHEN AV3098.ConversionFactor = NULL OR AV3098.ConversionFactor = 0 THEN NULL
				--	ELSE ISNULL(AV3098.EndQuantity, 0) / AV3098.ConversionFactor END AS ConversionQuantity, 
				AV3098.DebitQuantity, AV3098.CreditQuantity, AV3098.BeginAmount, AV3098.EndAmount, 
				AV3098.DebitAmount, AV3098.CreditAmount, 
				AV3098.InDebitAmount, AV3098.InCreditAmount, AV3098.InDebitQuantity, 
				AV3098.InCreditQuantity, 
				AV3098.Parameter01, AV3098.Parameter02, AV3098.Parameter03, AV3098.Parameter04, AV3098.Parameter05, 
				--AV3098.ConvertedUnitID, AV3098.ConvertedUnitName, 
				AV3098.BeginConvertedQuantity, AV3098.EndConvertedQuantity, AV3098.DebitConvertedQuantity, AV3098.CreditConvertedQuantity
        FROM	WV3098 AV3098 
        WHERE	BeginQuantity <> 0 OR BeginAmount <> 0 OR DebitQuantity <> 0 OR DebitAmount <> 0 
				OR CreditQuantity <> 0 OR CreditAmount <> 0 OR EndQuantity <> 0 OR EndAmount <> 0 
     '
ELSE IF @IsGroupID = 1
    BEGIN
        SET @GroupField1 = (SELECT CASE @GroupID1 WHEN 'CI1' THEN 'S1'  WHEN 'CI2' THEN 'S2' WHEN 'CI3' THEN 'S3'
                            WHEN 'I01' THEN 'I01ID'   WHEN 'I02' THEN 'I02ID'   WHEN 'I03' THEN 'I03ID'   WHEN 'I04' THEN 'I04ID'   WHEN 'I05' THEN 'I05ID'   END)
        SET @sSQL1 = '
            SELECT	AV3098.DivisionID, V1.ID AS GroupID1, '''' AS GroupID2, 
					V1.SName AS GroupName1, '''' AS GroupName2, 
					AV3098.InventoryID, S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, 
					AV3098.InventoryName, AV3098.UnitID, AV3098.UnitName, AV3098.VATPercent, AV3098. InventoryTypeID, AV3098.Specification, 
					AV3098.Notes01, AV3098.Notes02, AV3098.Notes03, 
					--AV3098.ConversionUnitID, AV3098.ConversionFactor, AV3098.Operator, 
					AV3098.BeginQuantity, AV3098.EndQuantity, 
					--CASE WHEN AV3098.ConversionFactor = NULL OR AV3098.ConversionFactor = 0 THEN NULL
					--	ELSE ISNULL(AV3098.EndQuantity, 0) / AV3098.ConversionFactor END AS ConversionQuantity, 
					AV3098.DebitQuantity, AV3098.CreditQuantity, AV3098.BeginAmount, AV3098.EndAmount, 
					AV3098.DebitAmount, AV3098.CreditAmount, 
					AV3098.InDebitAmount, AV3098.InCreditAmount, AV3098.InDebitQuantity, 
					AV3098.InCreditQuantity,                 
					AV3098.Parameter01, AV3098.Parameter02, AV3098.Parameter03, AV3098.Parameter04, AV3098.Parameter05, 
					--AV3098.ConvertedUnitID, AV3098.ConvertedUnitName, 
					AV3098.BeginConvertedQuantity, AV3098.EndConvertedQuantity, AV3098.DebitConvertedQuantity, AV3098.CreditConvertedQuantity
            FROM	WV3098 AV3098 
            LEFT JOIN AV1310 V1 ON AV3098.DivisionID = V1.DivisionID and  V1.ID = AV3098.' + @GroupField1 + ' AND V1.TypeID = ''' + @GroupID1 + ''' 
            WHERE BeginQuantity <> 0 OR BeginAmount <> 0 OR DebitQuantity <> 0 OR DebitAmount <> 0 
                OR CreditQuantity <> 0 OR CreditAmount <> 0 OR EndQuantity <> 0 OR EndAmount <> 0
        '
    END
ELSE IF @IsGroupID = 2
    BEGIN
        SET @GroupField1 = (SELECT CASE @GroupID1 WHEN 'CI1' THEN 'S1'  WHEN 'CI2' THEN 'S2' WHEN 'CI3' THEN 'S3'
                            WHEN 'I01' THEN 'I01ID'   WHEN 'I02' THEN 'I02ID'   WHEN 'I03' THEN 'I03ID'   WHEN 'I04' THEN 'I04ID'   WHEN 'I05' THEN 'I05ID'   END)

        SET @GroupField2 = (SELECT CASE @GroupID2 WHEN 'CI1' THEN 'S1'  WHEN 'CI2' THEN 'S2' WHEN 'CI3' THEN 'S3'
                            WHEN 'I01' THEN 'I01ID'   WHEN 'I02' THEN 'I02ID'   WHEN 'I03' THEN 'I03ID'   WHEN 'I04' THEN 'I04ID'   WHEN 'I05' THEN 'I05ID'   END)

        SET @sSQL1 = '
            SELECT AV3098.DivisionID, V1.ID AS GroupID1, V2.ID AS GroupID2, 
                V1.SName AS GroupName1, V2.SName AS GroupName2, 
                AV3098.InventoryID, S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, 
                AV3098.InventoryName, AV3098.UnitID, AV3098.UnitName, VATPercent, AV3098. InventoryTypeID, AV3098.Specification, 
                AV3098.Notes01, AV3098.Notes02, AV3098.Notes03, 
                --AV3098.ConversionUnitID, AV3098.ConversionFactor, AV3098.Operator, 
                AV3098.BeginQuantity, AV3098.EndQuantity, 
                --CASE WHEN AV3098.ConversionFactor = NULL OR AV3098.ConversionFactor = 0 THEN NULL
                --    ELSE ISNULL(AV3098.EndQuantity, 0) / AV3098.ConversionFactor END AS ConversionQuantity, 
                AV3098.DebitQuantity, AV3098.CreditQuantity, AV3098.BeginAmount, AV3098.EndAmount, 
                AV3098.DebitAmount, AV3098.CreditAmount, 
                AV3098.InDebitAmount, AV3098.InCreditAmount, AV3098.InDebitQuantity, 
                AV3098.InCreditQuantity, 
 ---- Thong tin don tinh qui doi
                --AV3098.ConvertedUnitID, AV3098.ConvertedUnitName, 
                AV3098.Parameter01, AV3098.Parameter02, AV3098.Parameter03, AV3098.Parameter04, AV3098.Parameter05, 
                AV3098.BeginConvertedQuantity, AV3098.EndConvertedQuantity, AV3098.DebitConvertedQuantity, AV3098.CreditConvertedQuantity
            FROM WV3098 AV3098 LEFT JOIN AV1310 V1 ON AV3098.DivisionID = V1.DivisionID and V1.ID = AV3098.' + @GroupField1 + ' 
                    AND V1.TypeID = ''' + @GroupID1 + ''' 
                LEFT JOIN AV1310 V2 ON AV3098.DivisionID = V2.DivisionID and  V2.ID = AV3098.' + @GroupField2 + ' 
                    AND V2.TypeID = ''' + @GroupID2 + ''' 
            WHERE BeginQuantity <> 0 OR BeginAmount <> 0 OR DebitQuantity <> 0 OR DebitAmount <> 0 
                OR CreditQuantity <> 0 OR CreditAmount <> 0 OR EndQuantity <> 0 OR EndAmount <> 0 
     '
   END    

  PRINT @sSQL1
 EXEC ('SELECT A.DivisionID, A.GroupID1, A.GroupID2, 
                A.GroupName1, A.GroupName2, 
                A.InventoryID, A.S1, A.S2, A.S3, A.I01ID, A.I02ID, A.I03ID, A.I04ID, A.I05ID, 
                A.InventoryName, A.UnitID, A.UnitName, A.VATPercent, A.InventoryTypeID, A.Specification, 
                A.Notes01, A.Notes02, A.Notes03, 
                A.BeginQuantity, A.EndQuantity, 
                A.DebitQuantity, A.CreditQuantity, A.BeginAmount, A.EndAmount, 
                A.DebitAmount, A.CreditAmount, 
                A.InDebitAmount, A.InCreditAmount, A.InDebitQuantity, 
                A.InCreditQuantity, 
                A.Parameter01, A.Parameter02, A.Parameter03, A.Parameter04, A.Parameter05, 
                CASE WHEN ISNULL(AT1309.Operator,0) = 0 THEN ISNULL(A.BeginQuantity,0)/ISNULL(AT1309.ConversionFactor,1) ELSE ISNULL(A.BeginQuantity,0)*ISNULL(AT1309.ConversionFactor,1)
                END AS BeginConvertedQuantity,
                CASE WHEN ISNULL(AT1309.Operator,0) = 0 THEN ISNULL(A.EndQuantity,0)/ISNULL(AT1309.ConversionFactor,1) ELSE ISNULL(A.EndQuantity,0)*ISNULL(AT1309.ConversionFactor,1)
                END AS EndConvertedQuantity, 
                CASE WHEN ISNULL(AT1309.Operator,0) = 0 THEN ISNULL(A.DebitQuantity,0)/ISNULL(AT1309.ConversionFactor,1) ELSE ISNULL(A.DebitQuantity,0)*ISNULL(AT1309.ConversionFactor,1)
                END AS DebitConvertedQuantity, 
                CASE WHEN ISNULL(AT1309.Operator,0) = 0 THEN ISNULL(A.CreditQuantity,0)/ISNULL(AT1309.ConversionFactor,1) ELSE ISNULL(A.CreditQuantity,0)*ISNULL(AT1309.ConversionFactor,1)
                END AS CreditConvertedQuantity, 
                AT1309.UnitID AS ConvertedUnitID, AT1309.UnitID AS ConversionUnitID, AT1309.ConversionFactor, AT1309.Operator,
		CASE WHEN AT1309.ConversionFactor = NULL OR AT1309.ConversionFactor = 0 THEN NULL
                    ELSE ISNULL(A.EndQuantity, 0) / AT1309.ConversionFactor END AS ConversionQuantity 
FROM ( '+@sSQL1 + ' ) A   
             
LEFT JOIN AT1309 WITH (NOLOCK) ON AT1309.DivisionID = A.DivisionID AND AT1309.InventoryID = A.InventoryID
WHERE AT1309.UnitID IN (SELECT ConvertedUnitID FROM WQ7002 WHERE WQ7002.InventoryID = AT1309.InventoryID) ')
 
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

