IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7016]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP7016]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- CREATE BY Nguyen Thi Ngoc Minh, Date 10/04/2004
---- Purpose: So du theo mat hang theo kho, co the chon theo ngay hay theo ky
---dung trong nhat ky nhap xuat kho, tinh hinh nhap xuat ton theo kho, theo mat hang
---- Edited BY Nguyen Quoc Huy, Date 07/08/2006

/********************************************
'* Edited by: [GS] [Việt Khánh] [29/07/2010]
					[Hoang Phuoc] [25/10/2010] Sửa tất cả thành WFML000139, và thêm N''
'********************************************/
--- Modify on 21/06/2016 by Bảo Anh: Sửa lỗi tồn đầu Begin Quantity sai khi in theo kỳ
--- Modified by Bảo Thy on 26/04/2017: Bổ sung 20 quy cách
--- Modified by Bảo Thy on 10/05/2017: Sửa danh mục dùng chung
--- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
--- Modified by Nhựt Trường on 01/12/2022: [2022/11/IS/0271] - Thay đổi vị trí điều kiện where để cải tiến tốc độ load dữ liệu.
--- Modified by Thanh Lượng on 06/02/2023: [2023/02/IS/0006] - Trả lại vị trí điều kiện where fix lỗi load dữ liệu chậm.
--- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
--- Modified by Thành Sang on 18/04/2023: - Thay đổi View Load. Cải tiến tốc độ (cus Thiên Nam)

CREATE PROCEDURE [dbo].[AP7016] 
    @DivisionID NVARCHAR(50), 
    @FromWareHouseID NVARCHAR(50), 
    @ToWareHouseID NVARCHAR(50), 
    @FromInventoryID NVARCHAR(50), 
    @ToInventoryID NVARCHAR(50), 
    @AccountID NVARCHAR(50), 
    @FromMonth INT, 
    @FromYear INT, 
    @ToMonth INT, 
    @ToYear INT, 
    @FromDate DATETIME, 
    @ToDate DATETIME, 
    @IsDate TINYINT, 
    @IsInner TINYINT
AS
DECLARE 
	@CustomerName INT,
    @sSQL1 AS VARCHAR(MAX), 
    @sSQL2 AS VARCHAR(MAX), 
    @View AS NVARCHAR(50),
	@Table AS NVARCHAR(50),
	@sSelect AS VARCHAR(MAX) = '',
	@sGroup AS VARCHAR(MAX) = ''

SET @CustomerName = (SELECT CustomerName FROM CustomerIndex)

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND ISNULL(IsSpecificate,0) = 1)
BEGIN
	SET @Table = 'AT2008_QC'

	SET @sSelect = '
	, ISNULL(S01ID,'''') S01ID, ISNULL(S02ID,'''') S02ID, ISNULL(S03ID,'''') S03ID, ISNULL(S04ID,'''') S04ID, ISNULL(S05ID,'''') S05ID, 
	ISNULL(S06ID,'''') S06ID, ISNULL(S07ID,'''') S07ID, ISNULL(S08ID,'''') S08ID, ISNULL(S09ID,'''') S09ID, ISNULL(S10ID,'''') S10ID, 
	ISNULL(S11ID,'''') S11ID, ISNULL(S12ID,'''') S12ID, ISNULL(S13ID,'''') S13ID, ISNULL(S14ID,'''') S14ID, ISNULL(S15ID,'''') S15ID, 
	ISNULL(S16ID,'''') S16ID, ISNULL(S17ID,'''') S17ID, ISNULL(S18ID,'''') S18ID, ISNULL(S19ID,'''') S19ID, ISNULL(S20ID,'''') S20ID '

	SET @sGroup = '
	,ISNULL(S01ID,''''), ISNULL(S02ID,''''), ISNULL(S03ID,''''), ISNULL(S04ID,''''), ISNULL(S05ID,''''), ISNULL(S06ID,''''), ISNULL(S07ID,''''), 
	ISNULL(S08ID,''''), ISNULL(S09ID,''''), ISNULL(S10ID,''''), ISNULL(S11ID,''''), ISNULL(S12ID,''''), ISNULL(S13ID,''''), ISNULL(S14ID,''''), 
	ISNULL(S15ID,''''), ISNULL(S16ID,''''), ISNULL(S17ID,''''), ISNULL(S18ID,''''), ISNULL(S19ID,''''), ISNULL(S20ID,'''') '

END
ELSE SET @Table = 'AT2008'


IF @CustomerName = 92  -- Cus Thiên Nam
BEGIN
	IF @IsInner = 1 SET @View = 'AV7000_TN' -- dùng cho load nhật ký Nhập xuất kho (AP2017)	
	ELSE SET @View = 'AV7001' -- khong lay van chuyen noi bo
END

ELSE

BEGIN
	IF @IsInner = 1 SET @View = 'AV7000' -- co lay van chuyen noi bo
	ELSE SET @View = 'AV7001' -- khong lay van chuyen noi bo
END



SET @View = LTRIM(RTRIM(@View))

-- PRINT @View

IF @IsDate = 0 --- Theo ky
    SET @sSQL1 = N'
        SELECT AT2008.DivisionID,
        	AT2008.WareHouseID, 
            AT1303.WareHouseName, 
            AT2008.InventoryID, 
            AT1302.InventoryName, 
            AT2008.InventoryAccountID AS DebitAccountID, 
            AT1302.UnitID,     
            AT1302.S1, AT1302.S2, AT1302.S3, AT1302.I01ID, AT1302.I02ID, AT1302.I03ID, AT1302.I04ID, AT1302.I05ID, 
            AT1304.UnitName, 
            SUM(BeginQuantity) AS BeginQuantity, 
            SUM(BeginAmount) AS BeginAmount
			'+@sSelect+'
        FROM '+@Table+' AT2008 INNER JOIN AT1302 ON AT1302.DivisionID IN (AT2008.DivisionID,''@@@'') AND AT1302.InventoryID = AT2008.InventoryID 
            INNER JOIN AT1304 ON AT1302.DivisionID IN (AT1304.DivisionID,''@@@'') AND AT1304.UnitID = AT1302.UnitID
            INNER JOIN AT1303 ON AT1303.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1303.WareHouseID = AT2008.WareHouseID
            --left join AT1309 ON AT1309.InventoryID = AT2008.InventoryID
        WHERE AT2008.DivisionID = N''' + @DivisionID + ''' 
            AND (AT2008.InventoryID LIKE N''' + @FromInventoryID + ''' OR AT2008.InventoryID BETWEEN N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''') 
            AND (AT2008.WareHouseID LIKE N''' + @FromWareHouseID + ''' OR AT2008.WareHouseID BETWEEN  N''' + @FromWareHouseID + ''' AND  N''' + @ToWareHouseID + ''') 
            AND (TranMonth + TranYear * 100 = ' + STR(@FromMonth) + ' + 100 * ' + STR(@FromYear) + ') 
        GROUP BY AT2008.DivisionID, AT2008.WarehouseID, AT1303.WareHouseName, AT2008.InventoryID, AT1302.InventoryName, AT2008.InventoryAccountID, AT1302.UnitID, 
            --AT1309.UnitID, AT1309.ConversionFactor, 
            AT1304.UnitName, AT1302.S1, AT1302.S2, AT1302.S3, AT1302.I01ID, AT1302.I02ID, AT1302.I03ID, AT1302.I04ID, AT1302.I05ID
			'+@sGroup+'
     '
ELSE
  BEGIN
    SET @sSQL1 = N'
        SELECT ' + @View + '.DivisionID,
        	' + @View + '.WareHouseID, 
            ' + @View + '.WareHouseName, 
            ' + @View + '.InventoryID, 
            ' + @View + '.InventoryName, 
            ' + @View + '.DebitAccountID, 
            ' + @View + '.CreditAccountID, 
            ' + @View + '.UnitID, 
            ' + @View + '.S1, 
            ' + @View + '.S2, 
            ' + @View + '.S3, 
            ' + @View + '.I01ID, 
            ' + @View + '.I02ID, 
            ' + @View + '.I03ID, 
            ' + @View + '.I04ID, 
            ' + @View + '.I05ID, 
            ' + @View + '.UnitName, 
            SUM(CASE WHEN D_C = ''D'' THEN ISNULL(ActualQuantity, 0) ELSE -ISNULL(ActualQuantity, 0) END) AS BeginQuantity, 
            SUM(CASE WHEN D_C = ''D'' THEN ISNULL(ConvertedAmount, 0) ELSE -ISNULL(ConvertedAmount, 0) END) AS BeginAmount
            --SUM(ISNULL(ActualQuantity, 0)) AS BeginQuantity, 
            --SUM(ISNULL(ConvertedAmount, 0)) AS BeginAmount
			'+@sSelect+'
        FROM ' + @View + '
        WHERE ' + @View + '.DivisionID = ''' + @DivisionID + ''' 
            AND D_C in (''D'', ''C'') 
            AND (' + @View + '.InventoryID LIKE N''' + @FromInventoryID + ''' OR ' + @View + '.InventoryID BETWEEN N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''') 
            AND (' + @View + '.WareHouseID LIKE N''' + @FromWareHouseID + ''' OR ' + @View + '.WareHouseID BETWEEN  N''' + @FromWareHouseID + ''' AND  N''' + @ToWareHouseID + ''') 
            AND (' + @View + '.DebitAccountID LIKE ''' + @AccountID + ''' OR ' + @View + '.CreditAccountID LIKE ''' + @AccountID + ''') 
            AND (VoucherDate < ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''')
        GROUP BY ' + @View + '.DivisionID,
        	' + @View + '.WarehouseID, 
            ' + @View + '.WareHouseName, 
            ' + @View + '.InventoryID, 
            ' + @View + '.InventoryName, 
            ' + @View + '.DebitAccountID, 
            ' + @View + '.CreditAccountID, 
            ' + @View + '.UnitID, 
            ' + @View + '.UnitName, 
            ' + @View + '.S1, 
            ' + @View + '.S2, 
            ' + @View + '.S3, 
            ' + @View + '.I01ID, 
            ' + @View + '.I02ID, 
            ' + @View + '.I03ID, 
            ' + @View + '.I04ID, 
            ' + @View + '.I05ID
			'+@sGroup+'
    '

    SET @sSQL2 = N' 
        UNION ALL
        SELECT ' + @View + '.DivisionID,
            ' + @View + '.WareHouseID, 
            ' + @View + '.WareHouseName, 
            ' + @View + '.InventoryID, 
            ' + @View + '.InventoryName, 
            ' + @View + '.DebitAccountID, 
            ' + @View + '.CreditAccountID, 
            ' + @View + '.UnitID, 
            ' + @View + '.S1, 
            ' + @View + '.S2, 
            ' + @View + '.S3, 
            ' + @View + '.I01ID, 
            ' + @View + '.I02ID, 
            ' + @View + '.I03ID, 
            ' + @View + '.I04ID, 
            ' + @View + '.I05ID, 
            ' + @View + '.UnitName,
            SUM(CASE WHEN D_C = ''BD'' THEN ISNULL(ActualQuantity, 0) ELSE -ISNULL(ActualQuantity, 0) END) AS BeginQuantity, 
            SUM(CASE WHEN D_C = ''BD'' THEN ISNULL(ConvertedAmount, 0) ELSE -ISNULL(ConvertedAmount, 0) END) AS BeginAmount
            --SUM(ISNULL(ActualQuantity, 0)) AS BeginQuantity, 
            --SUM(ISNULL(ConvertedAmount, 0)) AS BeginAmount
			'+@sSelect+'
        FROM ' + @View + '
        WHERE ' + @View + '.DivisionID = N''' + @DivisionID + ''' 
            AND D_C in (''BD'', ''BC'') 
            AND (' + @View + '.InventoryID LIKE N''' + @FromInventoryID + ''' OR ' + @View + '.InventoryID BETWEEN N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''') 
            AND (' + @View + '.WareHouseID LIKE N''' + @FromWareHouseID + ''' OR ' + @View + '.WareHouseID BETWEEN  N''' + @FromWareHouseID + ''' AND  N''' + @ToWareHouseID + ''') 
            AND (' + @View + '.DebitAccountID LIKE N''' + @AccountID + ''' OR ' + @View + '.CreditAccountID LIKE N''' + @AccountID + ''')
        GROUP BY ' + @View + '.DivisionID,
        	' + @View + '.WarehouseID, 
            ' + @View + '.WareHouseName, 
            ' + @View + '.InventoryID, 
            ' + @View + '.InventoryName, 
            ' + @View + '.DebitAccountID, 
            ' + @View + '.CreditAccountID, 
            ' + @View + '.UnitID, 
            ' + @View + '.UnitName, 
            ' + @View + '.S1, 
            ' + @View + '.S2, 
            ' + @View + '.S3, 
            ' + @View + '.I01ID, 
            ' + @View + '.I02ID, 
            ' + @View + '.I03ID, 
            ' + @View + '.I04ID, 
            ' + @View + '.I05ID
			'+@sGroup+'
    '

END
--print ('AP7016'+@sSQL1)
--print (@sSQL2)

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE Xtype = 'V' AND Name = 'AV7017')
    EXEC('CREATE VIEW AV7017 AS --AP7016
     ' +  @sSQL1 + @sSQL2)
ELSE
    EXEC('ALTER VIEW AV7017 AS  --AP7016
    ' +  @sSQL1 + @sSQL2)

---Print ' @FromWareHouseID ' + @FromWareHouseID
IF @FromWareHouseID = '%'
    SET @sSQL1 = N'
        SELECT DivisionID, ''%'' AS WareHouseID, ''WFML000139'' AS WareHouseName, InventoryID, InventoryName, DebitAccountID, UnitID, UnitName, 
            S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, SUM(ISNULL(BeginQuantity, 0)) AS BeginQuantity, SUM(ISNULL(BeginAmount, 0)) AS BeginAmount
			'+@sSelect+'
        FROM AV7017
        GROUP BY DivisionID, WareHouseID, WareHouseName, InventoryID, InventoryName, DebitAccountID, UnitID, UnitName, S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID 
		'+@sGroup+'
    '
ELSE
    SET @sSQL1 = N'
        SELECT DivisionID, WareHouseId, WareHouseName, InventoryID, InventoryName, DebitAccountID, UnitID, UnitName, 
            S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, SUM(ISNULL(BeginQuantity, 0)) AS BeginQuantity, SUM(ISNULL(BeginAmount, 0)) AS BeginAmount
			'+@sSelect+'
        FROM AV7017
        GROUP BY DivisionID, WareHouseId, WareHouseName, InventoryID, InventoryName, DebitAccountID, UnitID, UnitName, S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID 
		'+@sGroup+'
    '

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE Xtype = 'V' AND Name = 'AV7016')
    EXEC('CREATE VIEW AV7016 AS  --AP7016
    ' + @sSQL1)
ELSE
    EXEC('ALTER VIEW AV7016 AS  --AP7016
    ' + @sSQL1)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
