IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP2501]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP2501]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Chi tiet tinh hinh ton kho
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 28/08/2004 by Nguyen Van Nhan
---- 
---- Edited by: Vo Thanh  Huong, date : 11/04/2005
---- Last Edit : NGuyen Thi Thuy Tuyen Date:30/10/2006
---- Edit By : Thuy Tuyen, them cac thong tin loc theo mat hang. theo thoi gian, date 19/05/2010
---- Modified on 18/11/2011 by Le Thi Thu Hien : Chinh sua so ton cuoi ky 
---- Modified on 14/12/2011 by Le Thi Thu Hien : Them dieu kien DivisionID
---- Modified on 03/01/2012 by Nguyễn Bình Minh : Sửa điều kiện kết tại phần mã hàng vì không lấy được tên do không kết đúng Division 
---- Modified on 30/01/2012 by Le Thi Thu Hien : Sua dieu kien CONVERT theo ngay
---- Modified on 09/09/2013 by Le Thi Thu Hien : Số tồn cuối phải lấy theo Đến ngày
---- Modified on 14/07/2014 by Bảo Anh: Bổ sung WarehouseName
---- Modified on 24/02/2016 by Tiểu Mai: Sửa lấy sai số tồn kho thực tế
---- Modified on 03/05/2017 by Bảo Thy: Bổ sung thông tin quy cách
---- Modified by Phương Thảo on 15/05/2017: Sửa danh mục dùng chung
---- Modified by Bảo Thy on 02/11/2017:bổ sung số lượng Hàng đặt trước (THUANGIA)
---- Modified by Bảo Anh on 30/03/2018: Bổ sung I04ID, I06ID
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.

-- <Example>
---- exec op2501 'ht',1,2016,1,2016,'2016-01-01','2016-01-31',0,'','','',''

CREATE PROCEDURE [dbo].[OP2501]
(
    @DivisionID NVARCHAR(50), 
    @FromMonth INT, 
    @FromYear INT, 
    @ToMonth INT, 
    @ToYear INT, 
    @FromDate DATETIME, 
    @ToDate DATETIME, 
    @IsDate TINYINT, 
    @FromInventoryID NVARCHAR(50), 
    @ToInventoryID NVARCHAR(50), 
    @FromWareHouseID NVARCHAR(50), 
    @ToWareHouseID NVARCHAR(50)
)    
AS

DECLARE 
    @sSQL VARCHAR(MAX), 
	@ssSQL VARCHAR(MAX), 
	@sSQL1 VARCHAR(MAX), 
    @IsColumn TINYINT, 
    @RowField NVARCHAR(50), 
    @Caption NVARCHAR(150), 
    @AmountType1 NVARCHAR(50), 
    @AmountType2 NVARCHAR(50), 
    @AmountType3 NVARCHAR(50), 
    @AmountType4 NVARCHAR(50), 
    @AmountType5 NVARCHAR(50), 
    @ColumnID NVARCHAR(50), 
    @Sign1 NVARCHAR(50), 
    @Sign2 NVARCHAR(50), 
    @Sign3 NVARCHAR(50), 
    @Sign4 NVARCHAR(50), 
    @Sign5 NVARCHAR(50), 
    @SQL NVARCHAR(4000), 
    @cur CURSOR, 
    @Index TINYINT, 
    @FromMonthYearText NVARCHAR(20), 
    @ToMonthYearText NVARCHAR(20), 
    @FromDateText NVARCHAR(20), 
    @ToDateText NVARCHAR(20),
	@CustomerIndex INT

SELECT TOP 1 @CustomerIndex = ISNULL(CustomerName,-1) FROM CustomerIndex
SET @FromMonthYearText = STR(@FromMonth + @FromYear * 100)
SET @ToMonthYearText = STR(@ToMonth + @ToYear * 100)
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

IF @CustomerIndex = 85 ---THUANGIA
BEGIN
	SET @ssSQL = 'IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N''OT3101_OP2501''))
DROP TABLE OT3101_OP2501

SELECT T1.DivisionID, T2.InventoryID, SUM(T2.OrderQuantity) AS BookingQuantity
INTO OT3101_OP2501
FROM OT3101 T1 WITH (NOLOCK)
INNER JOIN OT3102 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.ROrderID = T2.ROrderID
WHERE T1.DivisionID = ''' + @DivisionID + ''' 
AND T2.InventoryID BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + ''' 
'+ CASE WHEN @IsDate = 1 THEN 'AND CONVERT(DATETIME,CONVERT(NVARCHAR(10),ISNULL(T1.OrderDate, ''''),101),101) BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''''
ELSE 'AND T1.TranMonth + T1.TranYear * 100 BETWEEN ' + @FromMonthYearText + ' AND ' + @ToMonthYearText END + ' 
GROUP BY T1.DivisionID, T2.InventoryID'
END

SET @sSQL = '
SELECT 
OV2800.DivisionID, 
OV2800.InventoryID, 
OV2800.WareHouseID, 
SUM(CASE WHEN TypeID <> ''PO'' AND Finish <> 1 THEN OV2800.OrderQuantity - OV2800.ActualQuantity ELSE 0 END) AS SQuantity, 
SUM(CASE WHEN TypeID = ''PO'' AND Finish <> 1 THEN OV2800.OrderQuantity - OV2800.ActualQuantity ELSE 0 END) AS PQuantity,
ISNULL(OV2800.S01ID,'''') AS S01ID, ISNULL(OV2800.S02ID,'''') AS S02ID, ISNULL(OV2800.S03ID,'''') AS S03ID, ISNULL(OV2800.S04ID,'''') AS S04ID, 
ISNULL(OV2800.S05ID,'''') AS S05ID, ISNULL(OV2800.S06ID,'''') AS S06ID, ISNULL(OV2800.S07ID,'''') AS S07ID, ISNULL(OV2800.S08ID,'''') AS S08ID, 
ISNULL(OV2800.S09ID,'''') AS S09ID, ISNULL(OV2800.S10ID,'''') AS S10ID, ISNULL(OV2800.S11ID,'''') AS S11ID, ISNULL(OV2800.S12ID,'''') AS S12ID, 
ISNULL(OV2800.S13ID,'''') AS S13ID, ISNULL(OV2800.S14ID,'''') AS S14ID, ISNULL(OV2800.S15ID,'''') AS S15ID, ISNULL(OV2800.S16ID,'''') AS S16ID, 
ISNULL(OV2800.S17ID,'''') AS S17ID, ISNULL(OV2800.S18ID,'''') AS S18ID, ISNULL(OV2800.S19ID,'''') AS S19ID, ISNULL(OV2800.S20ID,'''') AS S20ID
FROM OV2800
WHERE OV2800.DivisionID = ''' + @DivisionID + ''' 
AND OV2800.WareHouseID BETWEEN ''' + @FromWareHouseID + ''' AND ''' + @ToWareHouseID + ''' 
AND OV2800.InventoryID BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + ''' 
'+ CASE WHEN @IsDate = 1 THEN 'AND CONVERT(DATETIME,CONVERT(NVARCHAR(10),ISNULL(OV2800.Orderdate, ''''),101),101) BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''''
                      ELSE 'AND OV2800.TranMonth + OV2800.TranYear * 100 BETWEEN ' + @FromMonthYearText + ' AND ' + @ToMonthYearText END + ' 
GROUP BY OV2800.DivisionID, OV2800.InventoryID, OV2800.WareHouseID, ISNULL(OV2800.S01ID,''''), ISNULL(OV2800.S02ID,''''), ISNULL(OV2800.S03ID,''''), ISNULL(OV2800.S04ID,''''), ISNULL(OV2800.S05ID,''''), 
ISNULL(OV2800.S06ID,''''), ISNULL(OV2800.S07ID,''''), ISNULL(OV2800.S08ID,''''), ISNULL(OV2800.S09ID,''''), ISNULL(OV2800.S10ID,''''),
ISNULL(OV2800.S11ID,''''), ISNULL(OV2800.S12ID,''''), ISNULL(OV2800.S13ID,''''), ISNULL(OV2800.S14ID,''''), ISNULL(OV2800.S15ID,''''), 
ISNULL(OV2800.S16ID,''''), ISNULL(OV2800.S17ID,''''), ISNULL(OV2800.S18ID,''''), ISNULL(OV2800.S19ID,''''), ISNULL(OV2800.S20ID,'''')'
--PRINT(@ssSQL)
--PRINT(@sSQL)
EXEC (@ssSQL)
	
IF NOT EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS WHERE XTYPE = 'V' AND NAME = 'OV2801')
	EXEC('CREATE VIEW OV2801 -- Tạo bởi OP2501
		AS ' + @sSQL)
ELSE 
	EXEC('ALTER VIEW OV2801 -- Tạo bởi OP2501
		AS ' + @sSQL)
SET @sSQL = ' 
SELECT 
ISNULL(V00.DivisionID, V01.DivisionID) AS DivisionID, ISNULL(V00.InventoryID, V01.InventoryID) AS InventoryID, 
InventoryName, AT1310_S1.SName AS SName1, AT1310_S2.SName AS SName2, T00.Notes01 AS InNotes01, T00.Notes02 AS InNotes02, T00.Specification, 
T00.UnitID, UnitName, ISNULL(V00.WareHouseID, V01.WareHouseID) AS WareHouseID, 
CASE WHEN EndQuantity = 0 THEN NULL ELSE EndQuantity END AS EndQuantity, 
CASE WHEN SQuantity = 0 THEN NULL ELSE SQuantity END AS SQuantity, 
CASE WHEN PQuantity = 0 THEN NULL ELSE PQuantity END AS PQuantity, 
ISNULL(EndQuantity, 0) - ISNULL(SQuantity, 0) + ISNULL(PQuantity, 0) AS ReadyQuantity, 
CASE WHEN ISNULL(MaxQuantity, 0) = 0 THEN NULL ELSE MaxQuantity END AS MaxQuantity, 
CASE WHEN ISNULL(MinQuantity, 0) = 0 THEN NULL ELSE MinQuantity END AS MinQuantity, 
CASE WHEN ISNULL(ReOrderQuantity, 0) = 0 THEN NULL ELSE ReOrderQuantity END AS ReOrderQuantity, 
T00.InventoryTypeID, Isnull(T31.WareHouseName, T32.WareHouseName) as WareHouseName,
ISNULL(V00.S01ID,'''') AS S01ID, ISNULL(V00.S02ID,'''') AS S02ID, ISNULL(V00.S03ID,'''') AS S03ID, ISNULL(V00.S04ID,'''') AS S04ID, 
ISNULL(V00.S05ID,'''') AS S05ID, ISNULL(V00.S06ID,'''') AS S06ID, ISNULL(V00.S07ID,'''') AS S07ID, ISNULL(V00.S08ID,'''') AS S08ID, 
ISNULL(V00.S09ID,'''') AS S09ID, ISNULL(V00.S10ID,'''') AS S10ID, ISNULL(V00.S11ID,'''') AS S11ID, ISNULL(V00.S12ID,'''') AS S12ID, 
ISNULL(V00.S13ID,'''') AS S13ID, ISNULL(V00.S14ID,'''') AS S14ID, ISNULL(V00.S15ID,'''') AS S15ID, ISNULL(V00.S16ID,'''') AS S16ID, 
ISNULL(V00.S17ID,'''') AS S17ID, ISNULL(V00.S18ID,'''') AS S18ID, ISNULL(V00.S19ID,'''') AS S19ID, ISNULL(V00.S20ID,'''') AS S20ID,
T00.I04ID,T00.I06ID
FROM OV2801 V00
FULL JOIN 
(
    SELECT TOP 100 Percent DivisionID, WareHouseID, InventoryID, SUM(ISNULL(EndQuantity, 0)) AS EndQuantity,
	ISNULL(S01ID,'''') AS S01ID, ISNULL(S02ID,'''') AS S02ID, ISNULL(S03ID,'''') AS S03ID, ISNULL(S04ID,'''') AS S04ID, 
	ISNULL(S05ID,'''') AS S05ID, ISNULL(S06ID,'''') AS S06ID, ISNULL(S07ID,'''') AS S07ID, ISNULL(S08ID,'''') AS S08ID, 
	ISNULL(S09ID,'''') AS S09ID, ISNULL(S10ID,'''') AS S10ID, ISNULL(S11ID,'''') AS S11ID, ISNULL(S12ID,'''') AS S12ID, 
	ISNULL(S13ID,'''') AS S13ID, ISNULL(S14ID,'''') AS S14ID, ISNULL(S15ID,'''') AS S15ID, ISNULL(S16ID,'''') AS S16ID, 
	ISNULL(S17ID,'''') AS S17ID, ISNULL(S18ID,'''') AS S18ID, ISNULL(S19ID,'''') AS S19ID, ISNULL(S20ID,'''') AS S20ID
    FROM OV2411 
    WHERE DivisionID = ''' + @DivisionID + ''' 
    AND WareHouseID BETWEEN ''' + @FromWareHouseID + ''' AND ''' + @ToWareHouseID + ''' 
    AND InventoryID BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + ''' 
    AND ' + CASE WHEN @IsDate = 1 THEN ' CONVERT(DATETIME,CONVERT(NVARCHAR(10),VoucherDate,101),101) < = ''' + @ToDateText + '''' 
                          ELSE ' TranMonth + TranYear * 100 < = ' + @ToMonthYearText + '' END + '
    GROUP BY DivisionID, WareHouseID, InventoryID,
	ISNULL(S01ID,''''), ISNULL(S02ID,''''), ISNULL(S03ID,''''), ISNULL(S04ID,''''), ISNULL(S05ID,''''), 
	ISNULL(S06ID,''''), ISNULL(S07ID,''''), ISNULL(S08ID,''''), ISNULL(S09ID,''''), ISNULL(S10ID,''''),
	ISNULL(S11ID,''''), ISNULL(S12ID,''''), ISNULL(S13ID,''''), ISNULL(S14ID,''''), ISNULL(S15ID,''''), 
	ISNULL(S16ID,''''), ISNULL(S17ID,''''), ISNULL(S18ID,''''), ISNULL(S19ID,''''), ISNULL(S20ID,'''')
    HAVING SUM(ISNULL(EndQuantity, 0)) <> 0
    ORDER BY DivisionID, WareHouseID, InventoryID 
) V01 -- Lay so ton cuoi'
SET @sSQL1 = '
ON V00.DivisionID = V01.DivisionID AND V00.InventoryID = V01.InventoryID AND V00.WareHouseID = V01.WareHouseID
AND ISNULL(V00.S01ID,'''') = isnull(V01.S01ID,'''') AND ISNULL(V00.S02ID,'''') = isnull(V01.S02ID,'''')
AND ISNULL(V00.S03ID,'''') = isnull(V01.S03ID,'''') AND ISNULL(V00.S04ID,'''') = isnull(V01.S04ID,'''') 
AND ISNULL(V00.S05ID,'''') = isnull(V01.S05ID,'''') AND ISNULL(V00.S06ID,'''') = isnull(V01.S06ID,'''') 
AND ISNULL(V00.S07ID,'''') = isnull(V01.S07ID,'''') AND ISNULL(V00.S08ID,'''') = isnull(V01.S08ID,'''') 
AND ISNULL(V00.S09ID,'''') = isnull(V01.S09ID,'''') AND ISNULL(V00.S10ID,'''') = isnull(V01.S10ID,'''') 
AND ISNULL(V00.S11ID,'''') = isnull(V01.S11ID,'''') AND ISNULL(V00.S12ID,'''') = isnull(V01.S12ID,'''') 
AND ISNULL(V00.S13ID,'''') = isnull(V01.S13ID,'''') AND ISNULL(V00.S14ID,'''') = isnull(V01.S14ID,'''') 
AND ISNULL(V00.S15ID,'''') = isnull(V01.S15ID,'''') AND ISNULL(V00.S16ID,'''') = isnull(V01.S16ID,'''') 
AND ISNULL(V00.S17ID,'''') = isnull(V01.S17ID,'''') AND ISNULL(V00.S18ID,'''') = isnull(V01.S18ID,'''') 
AND ISNULL(V00.S19ID,'''') = isnull(V01.S19ID,'''') AND ISNULL(V00.S20ID,'''') = isnull(V01.S20ID,'''')
LEFT JOIN AT1302 T00 ON T00.DivisionID IN (''@@@'', V00.DivisionID) AND T00.InventoryID = ISNULL(V00.InventoryID, V01.InventoryID)
LEFT JOIN AT1304 T02 ON T02.UnitID = T00.UnitID
LEFT JOIN AT1314 T01 ON T01.InventoryID = ISNULL(V00.InventoryID, V01.InventoryID) 
        AND ISNULL(V00.WareHouseID, V01.WareHouseID) LIKE T01.WareHouseID
LEFT JOIN AT1310 AT1310_S1 ON AT1310_S1.STypeID = ''I01'' AND AT1310_S1.S = T00.S1 
LEFT JOIN AT1310 AT1310_S2 ON AT1310_S2.STypeID = ''I02'' AND AT1310_S2.S = T00.S2
LEFT JOIN AT1303 T31 ON T31.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND V00.WareHouseID = T31.WareHouseID
LEFT JOIN AT1303 T32 ON T32.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND V01.WareHouseID = T32.WareHouseID
WHERE (ISNULL(EndQuantity, 0) <> 0 OR ISNULL(SQuantity, 0) <> 0 OR PQuantity <> 0) 
AND ISNULL(V00.DivisionID, V01.DivisionID) = ''' + @DivisionID + ''' 
AND ISNULL(V00.WareHouseID, V01.WareHouseID) BETWEEN ''' + @FromWareHouseID + ''' AND ''' + @ToWareHouseID + ''' 
AND ISNULL (V00.InventoryID, V01.InventoryID) BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + '''
'
--PRINT @sSQL
--PRINT @sSQL1

IF NOT EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS WHERE XTYPE = 'V' AND NAME = 'OV2501')
    EXEC('CREATE VIEW OV2501 -- Tạo bởi OP2501
        AS ' + @sSQL + @sSQL1)
ELSE 
    EXEC('ALTER VIEW OV2501 -- Tạo bởi OP2501
        AS ' + @sSQL + @sSQL1)
        
-- Xu ly cot dong --
SET @sSQL = '
SELECT ''' + @Caption + ''' AS Caption01, '
SET @Index = 1 
SET @SQL = ''
SET @cur = CURSOR SCROLL KEYSET FOR 
SELECT ColumnID, Caption, IsColumn, Sign1, AmountType1, Sign2, AmountType2, Sign3, AmountType3
FROM OT4010 ORDER BY ColumnID

OPEN @cur
FETCH NEXT FROM @cur INTO @ColumnID, @Caption, @IsColumn, @Sign1, @AmountType1, @Sign2, @AmountType2, @Sign3, @AmountType3
WHILE @@FETCH_STATUS = 0
BEGIN
    SET @SQL = @SQL + '('
    IF ISNULL(@Sign1, '') <> ''
        BEGIN
            IF ISNULL(@AmountType1, '') = 'DD'								-- Hàng đã đặt
                SET @SQL = @SQL + @Sign1 + ' ISNULL (BQuantity, 0) '
			ELSE IF ISNULL(@AmountType1, '') = 'DV'                         -- hang dang ve
                SET @SQL = @SQL + @Sign1 + ' ISNULL (PQuantity, 0) '
            ELSE IF ISNULL(@AmountType1, '') = 'GC'                         -- Hang giu cho 
                SET @SQL = @SQL + @Sign1 + ' ISNULL(SQuantity, 0) '
            ELSE IF ISNULL(@AmountType1, '') = 'TT'                         -- Ton kho thuc te
                SET @SQL = @SQL + @Sign1 + ' ISNULL (EndQuantity, 0) '
            ELSE IF ISNULL(@AmountType1, '') = 'MIN'                        -- Ton kho thuc te
                SET @SQL = @SQL + @Sign1 + ' ISNULL (MinQuantity, 0) '
            ELSE IF ISNULL(@AmountType1, '') = 'MAX'                        -- Ton kho thuc te
                SET @SQL = @SQL + @Sign1 + ' ISNULL (MaxQuantity, 0) '
		END
        
    IF ISNULL(@Sign2, '') <> ''
        BEGIN 
            IF ISNULL(@AmountType2, '') = 'DD'								-- Hàng đã đặt
                SET @SQL = @SQL + @Sign2 + ' ISNULL (BQuantity, 0) '
			ELSE IF ISNULL(@AmountType2, '') = 'DV'                         -- Hang dang ve
                SET @SQL = @SQL + @Sign2 + ' ISNULL(PQuantity, 0) '
            ELSE IF ISNULL(@AmountType2, '') = 'GC'                         -- Hang giu cho
                SET @SQL = @SQL + @Sign2 + ' ISNULL(SQuantity, 0) '
            ELSE IF ISNULL(@AmountType2, '') = 'TT'                         -- Ton kho thuc te
                SET @SQL = @SQL + @Sign2 + ' ISNULL(EndQuantity, 0)'
            ELSE IF ISNULL(@AmountType2, '') = 'MIN'                        -- Ton kho thuc te
                SET @SQL = @SQL + @Sign2 + ' ISNULL (MinQuantity, 0) '
            ELSE IF ISNULL(@AmountType2, '') = 'MAX'                        -- Ton kho thuc te
                SET @SQL = @SQL + @Sign2 + ' ISNULL (MaxQuantity, 0) '
        END 

    IF ISNULL(@Sign3, '') <> ''
        BEGIN
            IF ISNULL(@AmountType3, '') = 'DD'								-- Hàng đã đặt
                SET @SQL = @SQL + @Sign3 + ' ISNULL (BQuantity, 0) '
			ELSE IF ISNULL(@AmountType3, '') = 'DV'                         -- Hang dang ve
                SET @SQL = @SQL + @Sign3 + ' ISNULL(PQuantity, 0) '
            ELSE IF ISNULL(@AmountType3, '') = 'GC'                         -- Hang giu cho
                SET @SQL = @SQL + @Sign3 + ' ISNULL(SQuantity, 0) '
            ELSE IF ISNULL(@AmountType3, '') = 'TT'                         -- Ton kho thuc te
                SET @SQL = @SQL + @Sign3 + ' ISNULL(EndQuantity, 0)'
            ELSE IF ISNULL(@AmountType3, '') = 'MIN'                        -- Ton kho thuc te
                SET @SQL = @SQL + @Sign3 + ' ISNULL (MinQuantity, 0) '
            ELSE IF ISNULL(@AmountType3, '') = 'MAX'                        -- Ton kho thuc te
                SET @SQL = @SQL + @Sign3 + ' ISNULL (MaxQuantity, 0) '
        END
    
    IF ISNULL(@Sign4, '') <> ''
        BEGIN
            IF ISNULL(@AmountType4, '') = 'DD'								-- Hàng đã đặt
                SET @SQL = @SQL + @Sign4 + ' ISNULL (BQuantity, 0) '
			ELSE IF ISNULL(@AmountType4, '') = 'DV'                         -- Hang dang ve
                SET @SQL = @SQL + @Sign4 + ' ISNULL(PQuantity, 0) '
            ELSE IF ISNULL(@AmountType4, '') = 'GC'                         -- Hang giu cho
                SET @SQL = @SQL + @Sign4 + ' ISNULL(SQuantity, 0) '
            ELSE IF ISNULL(@AmountType4, '') = 'TT'                         -- Ton kho thuc te
                SET @SQL = @SQL + @Sign4 + ' ISNULL(EndQuantity, 0)'
            ELSE IF ISNULL(@AmountType4, '') = 'MIN'                        -- Ton kho thuc te
                SET @SQL = @SQL + @Sign4 + ' ISNULL (MinQuantity, 0) '
            ELSE IF ISNULL(@AmountType4, '') = 'MAX'                        -- Ton kho thuc te
                SET @SQL = @SQL + @Sign4 + ' ISNULL (MaxQuantity, 0) '
        END
        
    IF ISNULL(@Sign5, '') <> ''
        BEGIN
            IF ISNULL(@AmountType5, '') = 'DD'								-- Hàng đã đặt
                SET @SQL = @SQL + @Sign5 + ' ISNULL (BQuantity, 0) '
			ELSE IF ISNULL(@AmountType5, '') = 'DV'                         -- Hang dang ve
                SET @SQL = @SQL + @Sign5 + ' ISNULL(PQuantity, 0) '
            ELSE IF ISNULL(@AmountType5, '') = 'GC'                         -- Hang giu cho
                SET @SQL = @SQL + @Sign5 + ' ISNULL(SQuantity, 0) '
            ELSE IF ISNULL(@AmountType5, '') = 'TT'                         -- Ton kho thuc te
                SET @SQL = @SQL + @Sign5 + ' ISNULL(EndQuantity, 0)'
            ELSE IF ISNULL(@AmountType5, '') = 'MIN'                        -- Ton kho thuc te
                SET @SQL = @SQL + @Sign5 + ' ISNULL (MinQuantity, 0) '
            ELSE IF ISNULL(@AmountType5, '') = 'MAX'                        -- Ton kho thuc te
                SET @SQL = @SQL + @Sign5 + ' ISNULL (MaxQuantity, 0) '
        END
        
    SET @SQL = @SQL + ') AS ColumnValue' + LTrim(@Index) + ', '
    SET @Index = @Index + 1
    -- PRINT @SQL
    FETCH NEXT FROM @cur INTO @ColumnID, @Caption, @IsColumn, @Sign1, @AmountType1, @Sign2, @AmountType2, @Sign3, @AmountType3
END
CLOSE @cur

SET @sSQL = '
SELECT ' + @SQL + ' OV2501.*,
'+CASE WHEN @CustomerIndex = 85 THEN 'T1.BookingQuantity AS BQuantity,' ELSE '' END+'
A01.StandardName AS StandardName01, A02.StandardName AS StandardName02, A03.StandardName AS StandardName03, A04.StandardName AS StandardName04, 
A05.StandardName AS StandardName05, A06.StandardName AS StandardName06, A07.StandardName AS StandardName07, A08.StandardName AS StandardName08, 
A09.StandardName AS StandardName09, A10.StandardName AS StandardName10, A11.StandardName AS StandardName11, A12.StandardName AS StandardName12,
A13.StandardName AS StandardName13, A14.StandardName AS StandardName14, A15.StandardName AS StandardName15, A16.StandardName AS StandardName16,
A17.StandardName AS StandardName17, A18.StandardName AS StandardName18, A19.StandardName AS StandardName19, A20.StandardName AS StandardName20
FROM OV2501 
'+CASE WHEN @CustomerIndex = 85 THEN 'LEFT JOIN OT3101_OP2501 T1 ON OV2501.DivisionID = T1.DivisionID AND OV2501.InventoryID = T1.InventoryID' ELSE '' END+'
LEFT JOIN AT0128 A01 WITH (NOLOCK) ON OV2501.S01ID = A01.StandardID AND A01.StandardTypeID = ''S01''
LEFT JOIN AT0128 A02 WITH (NOLOCK) ON OV2501.S02ID = A02.StandardID AND A02.StandardTypeID = ''S02''
LEFT JOIN AT0128 A03 WITH (NOLOCK) ON OV2501.S03ID = A03.StandardID AND A03.StandardTypeID = ''S03''
LEFT JOIN AT0128 A04 WITH (NOLOCK) ON OV2501.S04ID = A04.StandardID AND A04.StandardTypeID = ''S04''
LEFT JOIN AT0128 A05 WITH (NOLOCK) ON OV2501.S05ID = A05.StandardID AND A05.StandardTypeID = ''S05''
LEFT JOIN AT0128 A06 WITH (NOLOCK) ON OV2501.S06ID = A06.StandardID AND A06.StandardTypeID = ''S06''
LEFT JOIN AT0128 A07 WITH (NOLOCK) ON OV2501.S07ID = A07.StandardID AND A07.StandardTypeID = ''S07''
LEFT JOIN AT0128 A08 WITH (NOLOCK) ON OV2501.S08ID = A08.StandardID AND A08.StandardTypeID = ''S08''
LEFT JOIN AT0128 A09 WITH (NOLOCK) ON OV2501.S09ID = A09.StandardID AND A09.StandardTypeID = ''S09''
LEFT JOIN AT0128 A10 WITH (NOLOCK) ON OV2501.S10ID = A10.StandardID AND A10.StandardTypeID = ''S10''
LEFT JOIN AT0128 A11 WITH (NOLOCK) ON OV2501.S11ID = A11.StandardID AND A11.StandardTypeID = ''S11''
LEFT JOIN AT0128 A12 WITH (NOLOCK) ON OV2501.S12ID = A12.StandardID AND A12.StandardTypeID = ''S12''
LEFT JOIN AT0128 A13 WITH (NOLOCK) ON OV2501.S13ID = A13.StandardID AND A13.StandardTypeID = ''S13''
LEFT JOIN AT0128 A14 WITH (NOLOCK) ON OV2501.S14ID = A14.StandardID AND A14.StandardTypeID = ''S14''
LEFT JOIN AT0128 A15 WITH (NOLOCK) ON OV2501.S15ID = A15.StandardID AND A15.StandardTypeID = ''S15''
LEFT JOIN AT0128 A16 WITH (NOLOCK) ON OV2501.S16ID = A16.StandardID AND A16.StandardTypeID = ''S16''
LEFT JOIN AT0128 A17 WITH (NOLOCK) ON OV2501.S17ID = A17.StandardID AND A17.StandardTypeID = ''S17''
LEFT JOIN AT0128 A18 WITH (NOLOCK) ON OV2501.S18ID = A18.StandardID AND A18.StandardTypeID = ''S18''
LEFT JOIN AT0128 A19 WITH (NOLOCK) ON OV2501.S19ID = A19.StandardID AND A19.StandardTypeID = ''S19''
LEFT JOIN AT0128 A20 WITH (NOLOCK) ON OV2501.S20ID = A20.StandardID AND A20.StandardTypeID = ''S20''

WHERE OV2501.DivisionID = ''' + @DivisionID + '''
'

 --PRINT @sSQL
IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE XTYPE = 'V' AND NAME = 'OV2505')
    EXEC('CREATE VIEW OV2505 -- Tạo bởi OP2501
        AS ' + @sSQL)
ELSE 
    EXEC('ALTER VIEW OV2505 -- Tạo bởi OP2501
        AS ' + @sSQL)
        



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
