IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP2018_FL]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP2018_FL]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Chi tiet nhap xuat vat tu
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 06/08/2003 by Nguyen Van Nhan
---- 
---- Edit by Nguyen Quoc Huy, Date 12/07/2006
---- Last Edit : Nguyen Thi Thuy Tuyen: Lay them truong ObjectID, ObjectName,Notes01,Notes02,Notes03
---- Last Edit : 12/11/2007  Nguyen Thi Thuy Tuyen: Lay them truong  UnitName
---- Modified on 16/01/2009 by Dang Le Bao Quynh  : Bo sung truong hop xuat hang mua tra lai
---- Modified on 11/01/2012 by Le Thi Thu Hien : Sua lai dieu kien ngay
---- Modified on 21/01/2012 by Le Thi Thu Hien : Sửa lỗi Có số dư đầu kỳ nhưng không có số phát sinh trong kỳ thì không lên
---- Modified on 04/10/2012 by Bao Anh : Customize cho 2T (chi tiet nhap xuat vat tu theo quy cách), gọi AP2088
---- Edit by: Dang Le Bao Quynh: Bo sung MPT tu 6-10	
---- Edit by: on 04/04/2014 by Mai Duyen: Bo sung  truong AT9000.InvoiceNo(KH PrintTech)
---- Modified on 16/07/2014 by Thanh Sơn: lấy dữ liệu trực tiếp từ store, không sinh view AV2018
---- Modified on 09/10/2014 by Thanh Sơn: lấy thêm trường ConvertedUnitID cho SOFA
---- Modified on 11/09/2015 by Tiểu Mai: Bổ sung tên 10 MPT, 5 tham số
---- Modified on 22/04/2016 by Bảo Anh: Sửa thành store customize cho Figla
---- Modified on 25/04/2016 by Phương Thảo: Chỉnh sửa sp do thay đổi cách truyền @WarehouseID khi in tất cả kho
---- Modified on 11/05/2016 by Bảo Anh: Bổ sung order by theo TranMonth, TranYear
---- Modified by Bảo Thy on 27/05/2016: Bổ sung WITH (NOLOCK)
---- Modified on 01/08/2018 by Bảo Anh: Đối với phiếu VCNB thì Order by phiếu có loại chứng từ XCK trước NCK để giảm thiểu xuất âm
---- Modified on 29/11/2018 by Kim Thư: Sửa lỗi T6.WareHouseID2 -> AT2006.WareHouseID2. Sửa lấy index theo store cũ, hiển thị theo thứ tự phiếu nhập - VCNB - phiếu xuất
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

-- <Example>
----
-- exec AP2018_FL @DivisionID=N'AS',@WareHouseID=N'%',@FromInventoryID=N'G00001',@ToInventoryID=N'P00001',@FromMonth=8,@FromYear=2015,@ToMonth=8,@ToYear=2015,@FromDate='2015-09-11 00:00:00',@ToDate='2015-09-11 00:00:00',@IsDate=0,@IsInner=0,@IsAll=0


CREATE PROCEDURE [dbo].[AP2018_FL]
       @DivisionID nvarchar(50) ,
       @WareHouseID AS xml ,
       @FromInventoryID AS nvarchar(50) ,
       @ToInventoryID AS nvarchar(50) ,
       @FromMonth AS int ,
       @FromYear AS int ,
       @ToMonth AS int ,
       @ToYear AS int ,
       @FromDate AS datetime ,
       @ToDate AS datetime ,
       @IsDate AS tinyint ,
       @IsInner AS tinyint,
	   @IsAll AS tinyint
AS

--Declare @SqlCreateTable Varchar(Max)
	
---- Xu li du lieu xml
--SET @SqlCreateTable = '
--IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N''[dbo].[#TBL_WareHouseIDAP2018_FL]'''+@@SPID+') AND TYPE IN (N''U''))
--BEGIN
--	CREATE TABLE TBL_WareHouseIDAP2018_FL'+@@SPID+' (WareHouseID VARCHAR(50))
--END

---- Xoa du lieu hien tai
--DELETE TBL_WareHouseIDAP2018_FL'+@@SPID+'

--INSERT INTO TBL_WareHouseIDAP2018_FL'+@@SPID+'
--SELECT X.Data.query(''WareHouseID'').value(''.'', ''NVARCHAR(50)'') AS WareHouseID
--FROM '+@WareHouseID+'.nodes(''//Data'') AS X (Data)
--'


-- Xu li du lieu xml
IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[#TBL_WareHouseIDAP2018_FL]') AND TYPE IN (N'U'))
BEGIN
	CREATE TABLE #TBL_WareHouseIDAP2018_FL (WareHouseID VARCHAR(50))
END

-- Xoa du lieu hien tai
DELETE #TBL_WareHouseIDAP2018_FL

INSERT INTO #TBL_WareHouseIDAP2018_FL
SELECT X.Data.query('WareHouseID').value('.', 'NVARCHAR(50)') AS WareHouseID
FROM @WareHouseID.nodes('//Data') AS X (Data)


DECLARE @CustomerName INT
--Tao bang tam de kiem tra day co phai la khach hang 2T khong (CustomerName = 15)
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

IF @CustomerName = 15 --- Customize 2T
	EXEC AP2088 @DivisionID, @WareHouseID, @FromInventoryID, @ToInventoryID, @FromMonth, @FromYear, @ToMonth, @ToYear, @FromDate, @ToDate, @IsDate, @IsInner
ELSE
BEGIN
	DECLARE
			@sSQlSelect0 AS nvarchar(4000) ,
			@sSQlSelect AS nvarchar(4000) ,
			@sSQlSelect1 AS nvarchar(4000) ,
			@sSQlSelect1A AS nvarchar(4000) = '' ,
			@sSQlSelect2 AS nvarchar(4000) ,
			@sSQlSelect3 AS nvarchar(4000) ,
			@sSQlSelect4 AS nvarchar(4000) ,
			@sSQlFrom AS nvarchar(4000) ,
			@sSQlWhere AS nvarchar(4000) ,
			@sSQlUnionSelect AS nvarchar(4000) ,
			@sSQlUnionSelectA AS nvarchar(4000) = '',
			@sSQlUnionFrom AS nvarchar(4000) ,
			@sSQlUnionWhere AS nvarchar(4000) ,
			@WareHouseName AS nvarchar(4000),
			@WareHouseName1 AS nvarchar(4000) ,
			@WareHouseName11 AS nvarchar(4000) ,
			@WareHouseID2 AS nvarchar(4000) ,
			@WareHouseID21 AS nvarchar(4000) ,
			@WareHouseID1 AS nvarchar(4000) ,
			@KindVoucherListIm AS nvarchar(4000) ,
			@KindVoucherListEx1 AS nvarchar(4000) ,
			@KindVoucherListEx2 AS nvarchar(4000),
			--@sSQlSelect1 AS nvarchar(4000) ,
			@sSQlUnionSelect1 AS nvarchar(4000),
			@sSQlUnionSelect11 AS nvarchar(4000),
			@sSQlSelect11 AS nvarchar(4000) ,
			@WareHouseIDNotAll NVARCHAR(50),
			@sSQlUpdate AS nvarchar(4000), 
			@sSQL AS nvarchar(4000)

	SELECT  @WareHouseName1 = WareHouseName
	FROM    AT1303
	WHERE   WareHouseID = (SELECT TOP 1 WareHouseID FROM #TBL_WareHouseIDAP2018_FL) AND DivisionID IN (@DivisionID, '@@@')
		    
	--EXEC AP7015 @DivisionID , @WareHouseID , @FromInventoryID , @ToInventoryID , @FromMonth , @FromYear , @ToMonth , @ToYear , @FromDate , @ToDate , @IsDate, @IsAll

	IF @IsInner = 0
	BEGIN
			SET @KindVoucherListEx1 = '(2,4,8,10,14,20) '
			SET @KindVoucherListEx2 = '(2,4,8,10,14,20) '
			SET @KindVoucherListIm = '(1,5,7,9,15,17) '
	END
	ELSE
	BEGIN
			SET @KindVoucherListEx1 = '(2,4,3,8,10,14,20) '
			SET @KindVoucherListEx2 = '(2,4,8,10,14,20) '
			SET @KindVoucherListIm = '(1,3,5,7,9,15,17) '
	END

	IF @IsAll = 1
	BEGIN
			SET @WareHouseID2 = '''%'''
			SET @WareHouseID1 = '''%'''
			SET @WareHouseName = 'WFML000110'
			SET @WareHouseID21 = '''%'''
			SET @WareHouseName1 = '''WFML000110''' 

	END
	ELSE
	BEGIN
	--Set @WareHouseID2 = ' CASE WHEN KindVoucherID = 3 then AT2006.WareHouseID2 else AT2006.WareHouseID end'
			SET @WareHouseID2 = ' AT2006.WareHouseID '
			SET @WareHouseID1 = ' CASE WHEN KindVoucherID = 3 then AT2006.WareHouseID2 else AT2006.WareHouseID end '
			SET @WareHouseName = +'' + @WareHouseName1 + ''
			SET @WareHouseIDNotAll = (Select top 1 WareHouseID from #TBL_WareHouseIDAP2018_FL)
			SET @WareHouseID21 = 'AT2008.WareHouseID'
			SET @WareHouseName1 = 'AT1303.WareHouseName'

	END


---------->>>  Lay du lieu ton kho	
IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN
	IF @IsDate = 0 --- Theo ky
    BEGIN 
        SET @sSQlSelect0 = N'
            SELECT	AT2008.DivisionID,' + @WareHouseID21 + ' AS WareHouseID, 
					' + @WareHouseName1 + ' AS WareHouseName, 
					AT2008.InventoryID, 
					--AT1302.InventoryName, 
					--AT1302.UnitID, 
					--AT1304.UnitName, 
					convert(nvarchar(250),'''') as InventoryName,
					convert(nvarchar(50),'''') as UnitID,
					convert(nvarchar(250),'''') as UnitName,
					SUM(BeginQuantity) AS BeginQuantity, 
					SUM(EndQuantity) AS EndQuantity, 
					SUM(BeginAmount) AS BeginAmount, 
					SUM(EndAmount) AS EndAmount,
					AT2008.S01ID, AT2008.S02ID, AT2008.S03ID, AT2008.S04ID, AT2008.S05ID, AT2008.S06ID, AT2008.S07ID, AT2008.S08ID, AT2008.S09ID, AT2008.S10ID,
					AT2008.S11ID, AT2008.S12ID, AT2008.S13ID, AT2008.S14ID, AT2008.S15ID, AT2008.S16ID, AT2008.S17ID, AT2008.S18ID, AT2008.S19ID, AT2008.S20ID
			INTO	#AP2018_AV7015
            FROM	AT2008_QC AT2008 WITH (NOLOCK) 
            --INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2008.DivisionID,''@@@'') and AT1302.InventoryID = AT2008.InventoryID
            --INNER JOIN AT1304 WITH (NOLOCK) ON AT1302.DivisionID IN (AT1304.DivisionID,''@@@'') AND AT1304.UnitID = AT1302.UnitID and  AT1304.DivisionID = AT2008.DivisionID
            INNER JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1303.WareHouseID = AT2008.WareHouseID
            WHERE AT2008.DivisionID = N''' + @DivisionID + ''' 
					AND AT2008.InventoryID BETWEEN N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''' '+ 
					(CASE WHEN @IsAll = 1 THEN ' AND AT1303.IsTemp = 0 ' ELSE '' END) + '
					AND AT2008.WareHouseID IN (Select WareHouseID from #TBL_WareHouseIDAP2018_FL) 
					AND TranMonth + TranYear * 100 = ' + STR(@FromMonth) + ' + 100 * ' + STR(@FromYear) + ' 
            GROUP BY AT2008.DivisionID,AT2008.InventoryID, AT1302.InventoryName, AT1302.UnitID, AT1304.UnitName,
					AT2008.S01ID, AT2008.S02ID, AT2008.S03ID, AT2008.S04ID, AT2008.S05ID, AT2008.S06ID, AT2008.S07ID, AT2008.S08ID, AT2008.S09ID, AT2008.S10ID,
					AT2008.S11ID, AT2008.S12ID, AT2008.S13ID, AT2008.S14ID, AT2008.S15ID, AT2008.S16ID, AT2008.S17ID, AT2008.S18ID, AT2008.S19ID, AT2008.S20ID
			'
			IF @IsAll = 0
					SET @sSQlSelect0 = @sSQlSelect0 + N', AT2008.WareHouseID, AT1303.WareHouseName '

			SELECT @sSQlSelect0 =  @sSQlSelect0+ N'
			UPDATE T1
			SET T1.UnitID = T2.UnitID,
				T1.InventoryName = T2.InventoryName
			FROM #AP2018_AV7015 T1
			INNER JOIN AT1302 T2 ON T2.DivisionID IN (T1.DivisionID,''@@@'') AND T1.InventoryID = T2.InventoryID
			UPDATE T1
			SET T1.UnitName = T2.UnitName
			FROM #AP2018_AV7015 T1
			INNER JOIN AT1304 T2 ON T1.UnitID = T2.UnitID AND T1.DivisionID = T2.DivisionID
            '
    END 
	ELSE
    BEGIN
        IF @IsAll = 0
            SET @sSQlSelect0 = N'    
                SELECT	DivisionID, WareHouseID, 
						WareHouseName, 
						InventoryID, 
						--InventoryName, 
						--UnitID, UnitName, 
						convert(nvarchar(250),'''') as InventoryName,
						convert(nvarchar(50),'''') as UnitID,
						convert(nvarchar(250),'''') as UnitName,
						SUM(SignQuantity) AS BeginQuantity, 
						SUM(SignAmount) AS BeginAmount, 
						0 AS EndQuantity, 
						0 AS EndAmount,
						AV7002.S01ID, AV7002.S02ID, AV7002.S03ID, AV7002.S04ID, AV7002.S05ID, AV7002.S06ID, AV7002.S07ID, AV7002.S08ID, AV7002.S09ID, AV7002.S10ID,
						AV7002.S11ID, AV7002.S12ID, AV7002.S13ID, AV7002.S14ID, AV7002.S15ID, AV7002.S16ID, AV7002.S17ID, AV7002.S18ID, AV7002.S19ID, AV7002.S20ID
				INTO	#AP2018_AV7015		
                FROM	AV7002
                WHERE	DivisionID LIKE N''' + @DivisionID + ''' 
						AND ((D_C in (''D'', ''C'') AND CONVERT(DATETIME, CONVERT(VARCHAR(10), VoucherDate, 101), 101) < ''' + Convert(NVARCHAR(10), @FromDate, 101) + ''') 
								OR D_C = ''BD'') 
						AND WareHouseID LIKE N''' + @WareHouseIDNotAll + ''' 
						AND InventoryID BETWEEN N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''' 
                GROUP BY DivisionID, InventoryID, InventoryName, UnitID, UnitName, WareHouseID, WareHouseName,
						AV7002.S01ID, AV7002.S02ID, AV7002.S03ID, AV7002.S04ID, AV7002.S05ID, AV7002.S06ID, AV7002.S07ID, AV7002.S08ID, AV7002.S09ID, AV7002.S10ID,
						AV7002.S11ID, AV7002.S12ID, AV7002.S13ID, AV7002.S14ID, AV7002.S15ID, AV7002.S16ID, AV7002.S17ID, AV7002.S18ID, AV7002.S19ID, AV7002.S20ID
                ---Having SUM(SignQuantity) <> 0 OR SUM(SignAmount) <> 0 

				UPDATE T1
				SET T1.UnitID = T2.UnitID,
					T1.InventoryName = T2.InventoryName
				FROM #AP2018_AV7015 T1
				INNER JOIN AT1302 T2 ON T2.DivisionID IN (T1.DivisionID,''@@@'') AND T1.InventoryID = T2.InventoryID

				UPDATE T1
				SET T1.UnitName = T2.UnitName
				FROM #AP2018_AV7015 T1
				INNER JOIN AT1304 T2 ON T1.UnitID = T2.UnitID AND T1.DivisionID = T2.DivisionID
            '
        ELSE
            SET @sSQlSelect0 = N'
				SELECT	DivisionID, 
						' + @WareHouseID21 + ' AS WareHouseID, 
						' + @WareHouseName1 + ' AS WareHouseName, 
						InventoryID, 
						--InventoryName, 
						--UnitID, UnitName, 
						convert(nvarchar(250),'''') as InventoryName,
						convert(nvarchar(50),'''') as UnitID,
						convert(nvarchar(250),'''') as UnitName,
						SUM(SignQuantity) AS BeginQuantity, 
						SUM(SignAmount) AS BeginAmount, 
						0 AS EndQuantity, 
						0 AS EndAmount,
						AV7002.S01ID, AV7002.S02ID, AV7002.S03ID, AV7002.S04ID, AV7002.S05ID, AV7002.S06ID, AV7002.S07ID, AV7002.S08ID, AV7002.S09ID, AV7002.S10ID,
						AV7002.S11ID, AV7002.S12ID, AV7002.S13ID, AV7002.S14ID, AV7002.S15ID, AV7002.S16ID, AV7002.S17ID, AV7002.S18ID, AV7002.S19ID, AV7002.S20ID
                INTO	#AP2018_AV7015
				FROM	AV7002
                WHERE	DivisionID LIKE N''' + @DivisionID + ''' 
						AND ((D_C in (''D'', ''C'') 
								AND CONVERT(DATETIME, CONVERT(VARCHAR(10), VoucherDate, 101), 101) < ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''') 
								OR D_C = ''BD'') 
						AND WareHouseID in (Select WareHouseID from #TBL_WareHouseIDAP2018_FL) 
						AND InventoryID BETWEEN N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''' 
                GROUP BY DivisionID, InventoryID, InventoryName, UnitID, UnitName,
						AV7002.S01ID, AV7002.S02ID, AV7002.S03ID, AV7002.S04ID, AV7002.S05ID, AV7002.S06ID, AV7002.S07ID, AV7002.S08ID, AV7002.S09ID, AV7002.S10ID,
						AV7002.S11ID, AV7002.S12ID, AV7002.S13ID, AV7002.S14ID, AV7002.S15ID, AV7002.S16ID, AV7002.S17ID, AV7002.S18ID, AV7002.S19ID, AV7002.S20ID 
                ---Having SUM(SignQuantity) <> 0 OR SUM(SignAmount) <> 0 
				'
		IF @IsAll = 0
			SET @sSQlSelect0 = @sSQlSelect0 + N', AT2008.WareHouseID, AT1303.WareHouseName '

		SELECT @sSQlSelect0 =  @sSQlSelect0+ N'
		UPDATE T1
		SET T1.UnitID = T2.UnitID,
			T1.InventoryName = T2.InventoryName
		FROM #AP2018_AV7015 T1
		INNER JOIN AT1302 T2 ON T2.DivisionID IN (T1.DivisionID,''@@@'') AND T1.InventoryID = T2.InventoryID

		UPDATE T1
		SET T1.UnitName = T2.UnitName
		FROM #AP2018_AV7015 T1
		INNER JOIN AT1304 T2 ON T1.UnitID = T2.UnitID AND T1.DivisionID = T2.DivisionID
    '
			
    END
END
ELSE
BEGIN
	
	IF @IsDate = 0 --- Theo ky
	BEGIN 
		SET @sSQlSelect0 = N'
			SELECT	AT2008.DivisionID,' + @WareHouseID21 + ' AS WareHouseID, 
					' + @WareHouseName1 + ' AS WareHouseName, 
					AT2008.InventoryID, 
					--AT1302.InventoryName, 
					--AT1302.UnitID, 
					--AT1304.UnitName, 
					convert(nvarchar(250),'''') as InventoryName,
					convert(nvarchar(50),'''') as UnitID,
					convert(nvarchar(250),'''') as UnitName,
					SUM(BeginQuantity) AS BeginQuantity, 
					SUM(EndQuantity) AS EndQuantity, 
					SUM(BeginAmount) AS BeginAmount, 
					SUM(EndAmount) AS EndAmount
			INTO	#AP2018_AV7015
			FROM	AT2008 WITH (NOLOCK) 
			INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2008.DivisionID,''@@@'') AND AT1302.InventoryID = AT2008.InventoryID
			INNER JOIN AT1304 WITH (NOLOCK) ON AT1302.DivisionID IN (AT1304.DivisionID,''@@@'') AND AT1304.UnitID = AT1302.UnitID and  AT1304.DivisionID = AT2008.DivisionID
			INNER JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1303.WareHouseID = AT2008.WareHouseID
			WHERE AT2008.DivisionID = N''' + @DivisionID + ''' 
					AND AT2008.InventoryID BETWEEN N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''' '+
					(CASE WHEN @IsAll = 1 THEN ' AND AT1303.IsTemp = 0 ' ELSE '' END) +
					'AND AT2008.WareHouseID in (Select WareHouseID from #TBL_WareHouseIDAP2018_FL) 
					AND TranMonth + TranYear * 100 = ' + STR(@FromMonth) + ' + 100 * ' + STR(@FromYear) + ' 
			GROUP BY AT2008.DivisionID,AT2008.InventoryID, AT1302.InventoryName, AT1302.UnitID, AT1304.UnitName'

			IF @IsAll = 0
			SET @sSQlSelect0 = @sSQlSelect0 + N', AT2008.WareHouseID, AT1303.WareHouseName '

			SET @sSQlSelect0 = @sSQlSelect0 + N'

			UPDATE T1
			SET T1.UnitID = T2.UnitID,
				T1.InventoryName = T2.InventoryName
			FROM #AP2018_AV7015 T1
			INNER JOIN AT1302 T2 ON T2.DivisionID IN (T1.DivisionID,''@@@'') AND T1.InventoryID = T2.InventoryID

			UPDATE T1
			SET T1.UnitName = T2.UnitName
			FROM #AP2018_AV7015 T1
			INNER JOIN AT1304 T2 ON T1.UnitID = T2.UnitID AND T1.DivisionID = T2.DivisionID

		'
		
	END 
	ELSE
	BEGIN
		IF @IsAll = 0
			SET @sSQlSelect0 = N'    
				SELECT	DivisionID, WareHouseID, 
						WareHouseName, 
						InventoryID, 
						--InventoryName, 
						--UnitID, UnitName, 
						convert(nvarchar(250),'''') as InventoryName,
						convert(nvarchar(50),'''') as UnitID,
						convert(nvarchar(250),'''') as UnitName,
						SUM(SignQuantity) AS BeginQuantity, 
						SUM(SignAmount) AS BeginAmount, 
						0 AS EndQuantity, 
						0 AS EndAmount
				INTO	#AP2018_AV7015
				FROM	AV7011
				WHERE	DivisionID LIKE N''' + @DivisionID + ''' 
						AND ((D_C in (''D'', ''C'') AND CONVERT(DATETIME, CONVERT(VARCHAR(10), VoucherDate, 101), 101) < ''' + Convert(NVARCHAR(10), @FromDate, 101) + ''') 
								OR D_C = ''BD'') 
						AND WareHouseID like N''' + @WareHouseIDNotAll + '''
						AND InventoryID BETWEEN N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''' 
				GROUP BY DivisionID, InventoryID, InventoryName, UnitID, UnitName, WareHouseID, WareHouseName
				---Having SUM(SignQuantity) <> 0 OR SUM(SignAmount) <> 0 

				UPDATE T1
				SET T1.UnitID = T2.UnitID,
					T1.InventoryName = T2.InventoryName
				FROM #AP2018_AV7015 T1
				INNER JOIN AT1302 T2 ON T2.DivisionID IN (T1.DivisionID,''@@@'') AND T1.InventoryID = T2.InventoryID

				UPDATE T1
				SET T1.UnitName = T2.UnitName
				FROM #AP2018_AV7015 T1
				INNER JOIN AT1304 T2 ON T1.UnitID = T2.UnitID AND T1.DivisionID = T2.DivisionID

			'
		ELSE
			SET @sSQlSelect0 = N'
				SELECT	DivisionID, 
						' + @WareHouseID21 + ' AS WareHouseID, 
						' + @WareHouseName1 + ' AS WareHouseName, 
						InventoryID, 
						--InventoryName, 
						--UnitID, UnitName, 
						convert(nvarchar(250),'''') as InventoryName,
						convert(nvarchar(50),'''') as UnitID,
						convert(nvarchar(250),'''') as UnitName,
						SUM(SignQuantity) AS BeginQuantity, 
						SUM(SignAmount) AS BeginAmount, 
						0 AS EndQuantity, 
						0 AS EndAmount
				INTO	#AP2018_AV7015
				FROM	AV7011
				WHERE	DivisionID LIKE N''' + @DivisionID + ''' 
						AND ((D_C in (''D'', ''C'') 
								AND CONVERT(DATETIME, CONVERT(VARCHAR(10), VoucherDate, 101), 101) < ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''') 
								OR D_C = ''BD'') 
						AND WareHouseID IN (Select WareHouseID from #TBL_WareHouseIDAP2018_FL) 
						AND InventoryID BETWEEN N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''' 
				GROUP BY DivisionID, InventoryID, InventoryName, UnitID, UnitName, WareHouseID, WareHouseName,
				---Having SUM(SignQuantity) <> 0 OR SUM(SignAmount) <> 0 

				UPDATE T1
				SET T1.UnitID = T2.UnitID,
					T1.InventoryName = T2.InventoryName
				FROM #AP2018_AV7015 T1
				INNER JOIN AT1302 T2 ON T2.DivisionID IN (T1.DivisionID,''@@@'') AND T1.InventoryID = T2.InventoryID

				UPDATE T1
				SET T1.UnitName = T2.UnitName
				FROM #AP2018_AV7015 T1
				INNER JOIN AT1304 T2 ON T1.UnitID = T2.UnitID AND T1.DivisionID = T2.DivisionID
	
			'
	END
 
END  
	
IF @IsDate = 0
BEGIN
	SET @sSQlSelect1 = '--- Phan Nhap kho
	SELECT 	' + @WareHouseID2 + ' AS WareHouseID,
			N''' + isnull(@WareHouseName,'') + ''' AS WareHouseName, 
			AT2007.VoucherID,
			AT2007.TransactionID,
			AT2007.Orders,
			VoucherDate,
			VoucherNo,	
			VoucherDate AS ImVoucherDate,
			VoucherNo AS ImVoucherNo,		
			SourceNo AS ImSourceNo,
			LimitDate AS ImLimitDate,	
 			AT2006.WareHouseID AS ImWareHouseID,		
			AT2006.RefNo01 AS ImRefNo01 , AT2006.RefNo02 AS ImRefNo02 , 
			AT2007.ActualQuantity AS ImQuantity,
			AT2007.UnitPrice AS ImUnitPrice ,
			AT2007.ConvertedAmount AS ImConvertedAmount,
			AT2007.OriginalAmount AS ImOriginalAmount,
			isnull(AT2007.ConversionFactor ,1)*ActualQuantity AS ImConvertedQuantity,
			Null AS ExVoucherDate,
			Null AS ExVoucherNo,		
			Null AS ExSourceNo,
			Null AS ExLimitDate,	
 			Null AS ExWareHouseID,		
			Null AS ExRefNo01 , Null AS ExRefNo02 , 
			0 AS ExQuantity,
			Null AS ExUnitPrice ,
			0 AS ExConvertedAmount,
			0 AS ExOriginalAmount,
			0 AS ExConvertedQuantity,
			VoucherTypeID,
			AT2006.Description,
			AT2007.Notes,
			AT2007.InventoryID,	
			--AT1302.InventoryName,
			Convert(NVarchar(250),'''') AS InventoryName,
			AT2007.UnitID,		
			isnull(AT2007.ConversionFactor ,1) AS ConversionFactor,
			--isnull(AV7015.BeginQuantity,0) AS BeginQuantity,
			--isnull(AV7015.BeginAmount,0) AS BeginAmount,
			Convert(Decimal(28,8),0) AS BeginQuantity,
			Convert(Decimal(28,8),0) AS BeginAmount,
'
	SET @sSQlSelect1A = N'
			(CASE WHEN KindVoucherID = 7 then 3 else 1 end) AS ImExOrders,
			AT2007.DebitAccountID, AT2007.CreditAccountID,
			At2006.ObjectID,
			--AT1202.ObjectName,
			--AT1302.Notes01,
			--AT1302.Notes02,
			--AT1302.Notes03, 
			Convert(NVarchar(250),'''') AS ObjectName, Convert(NVarchar(250),'''') AS Notes01, 
			Convert(NVarchar(250),'''') AS Notes02, Convert(NVarchar(250),'''') AS Notes03, 
			AT2007.DivisionID, AT2007.ConvertedUnitID,
			AT2007.Ana01ID, AT2007.Ana02ID, AT2007.Ana03ID, AT2007.Ana04ID, AT2007.Ana05ID, AT2007.Ana06ID, AT2007.Ana07ID, AT2007.Ana08ID, AT2007.Ana09ID, AT2007.Ana10ID ,
			--(Select Distinct InvoiceNo from AT9000 WITH (NOLOCK) Where VoucherID = AT2007.VoucherID and TransactionID = AT2007.TransactionID and Isnull(InvoiceNo,'''')<>'''') as InvoiceNo,
		Convert(NVarchar(50),'''') AS InvoiceNo,
			--A01.AnaName AS Ana01Name, A02.AnaName AS Ana02Name, A03.AnaName AS Ana03Name, A04.AnaName AS Ana04Name, A05.AnaName AS Ana05Name,
			--A06.AnaName AS Ana06Name, A07.AnaName AS Ana07Name, A08.AnaName AS Ana08Name, A09.AnaName AS Ana09Name, A10.AnaName AS Ana10Name,
			Convert(NVarchar(250),'''') AS Ana01Name, Convert(NVarchar(250),'''') AS Ana02Name, Convert(NVarchar(250),'''') AS Ana03Name, Convert(NVarchar(250),'''') AS Ana04Name,
			Convert(NVarchar(250),'''') AS Ana05Name, Convert(NVarchar(250),'''') AS Ana06Name, Convert(NVarchar(250),'''') AS Ana07Name, Convert(NVarchar(250),'''') AS Ana08Name,
			Convert(NVarchar(250),'''') AS Ana09Name, Convert(NVarchar(250),'''') AS Ana10Name,
			AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05, AT2006.CreateDate,
			--case	when AT2006.KindVoucherID IN (1, 5, 7, 9 ,15, 17) THEN 1
			--		WHEN AT2006.KindVoucherID = 3 AND AT2006.WareHouseID2 IN (''KGC001'', ''KGC002'', ''KGC003'', ''KSX001'', ''KSX002'', ''KSX003'')
			--			THEN (CASE WHEN AT2006.VoucherTypeID = ''XCK'' THEN 2 ELSE 3 END)
			--		WHEN AT2006.KindVoucherID = 3 AND AT2006.WareHouseID2 NOT IN (''KGC001'', ''KGC002'', ''KGC003'', ''KSX001'', ''KSX002'', ''KSX003'') THEN 2
			--		ELSE 4 end as Indexs,	
			case	when AT2006.KindVoucherID IN (1, 5, 7, 9 ,15, 17) THEN 1
						WHEN AT2006.KindVoucherID = 3 THEN 2
						ELSE 3 end as Indexs,					
			AT2007.TranMonth, AT2007.TranYear'

	SET @sSQlFrom = ' 
		INTO #AP2018_AV2028
		FROM AT2007 WITH (NOLOCK)
		INNER JOIN AT2006 WITH (NOLOCK) on AT2006.VoucherID = AT2007.VoucherID  AND AT2006.DivisionID = AT2007.DivisionID
		INNER JOIN AT1303 WITH (NOLOCK) on AT1303.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1303.WareHouseID = AT2006.WareHouseID
		'
	SET @sSQlWhere = ' 
		WHERE	
		AT2007.DivisionID =N''' + @DivisionID + ''' ' +
				(CASE WHEN @IsAll = 1 THEN ' AND AT1303.IsTemp = 0 ' ELSE '' END) + ' AND
				'+CASE WHEN @CustomerName = 49 THEN ' (CASE WHEN '+STR(@IsAll)+' = 1  then   isnull(AT1303.FullName,'''') else 0 end  <> ''1'' ) AND 'ELSE '' END +'
				(AT2007.TranMonth + AT2007.TranYear*100 between (' + str(@FromMonth) + ' + ' + str(@FromYear) + ' *100) AND  (' + str(@ToMonth) + ' + ' + str(@ToYear) + ' *100) )  AND
				KindVoucherID in ' + @KindVoucherListIm + ' AND
				(AT2007.InventoryID between N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''') AND
				AT2006.WareHouseID IN (SELECT WareHouseID from #TBL_WareHouseIDAP2018_FL)	
				'												
							
	SET @sSQlUnionSelect = N' 
	UNION ALL
	--- Phan Xuat kho
	SELECT 	' + @WareHouseID1 + ' AS WareHouseID,
		N''' + isnull(@WareHouseName,'') + ''' AS WareHouseName, 
		AT2007.VoucherID,
		AT2007.TransactionID,
		AT2007.Orders,
		VoucherDate,
		VoucherNo,	
		Null AS ImVoucherDate,
		Null AS ImVoucherNo,		
		Null AS ImSourceNo,
		Null AS ImLimitDate,	
 		Null AS ExWareHouseID,	
		Null AS ImRefNo01 , Null  AS ImRefNo02 , 
		0 AS ImQuantity,
		Null AS ImUnitPrice ,
		0 AS ImConvertedAmount,
		0 AS ImOriginalAmount,
		0 AS ImConvertedQuantity,
		VoucherDate AS ExVoucherDate,
		VoucherNo AS ExVoucherNo,		
		SourceNo AS ExSourceNo,
		LimitDate AS ExLimitDate,	
 		(CASE WHEN KindVoucherID = 3 then WareHouseID2 else AT2006.WareHouseID end) AS ExWareHouseID,	
		AT2006.RefNo01 AS ExRefNo01 , AT2006.RefNo02 AS ExRefNo02 , 
		AT2007.ActualQuantity AS ExQuantity,
		AT2007.UnitPrice AS ExUnitPrice ,
		AT2007.ConvertedAmount AS ExConvertedAmount,
		AT2007.OriginalAmount AS ExOriginalAmount,
		isnull(AT2007.ConversionFactor ,1)*ActualQuantity AS ExConvertedQuantity,
		VoucherTypeID,
		AT2006.Description,
		AT2007.Notes,
		AT2007.InventoryID,	
		--AT1302.InventoryName,
		Convert(NVarchar(250),'''') AS InventoryName,
		AT2007.UnitID,		
		isnull(AT2007.ConversionFactor ,1) AS ConversionFactor,
		--isnull(AV7015.BeginQuantity,0) AS BeginQuantity,
		--isnull(AV7015.BeginAmount,0) AS BeginAmount,
		Convert(Decimal(28,8),0) AS BeginQuantity,
		Convert(Decimal(28,8),0) AS BeginAmount,'

	SET @sSQlUnionSelectA = N' 
			2 AS ImExOrders,
			AT2007.DebitAccountID, AT2007.CreditAccountID,
			At2006.ObjectID,
			--AT1202.ObjectName,
			--AT1302.Notes01,
			--AT1302.Notes02,
			--AT1302.Notes03, 
			Convert(NVarchar(250),'''') AS ObjectName, Convert(NVarchar(250),'''') AS Notes01, 
			Convert(NVarchar(250),'''') AS Notes02, Convert(NVarchar(250),'''') AS Notes03, 
			AT2007.DivisionID,  AT2007.ConvertedUnitID,
			AT2007.Ana01ID, AT2007.Ana02ID, AT2007.Ana03ID, AT2007.Ana04ID, AT2007.Ana05ID, AT2007.Ana06ID, AT2007.Ana07ID, AT2007.Ana08ID, AT2007.Ana09ID, AT2007.Ana10ID,
			--(Select Distinct InvoiceNo from AT9000 WITH (NOLOCK) Where VoucherID = AT2007.VoucherID and TransactionID = AT2007.TransactionID and Isnull(InvoiceNo,'''')<>'''') as InvoiceNo,
			Convert(NVarchar(50),'''') AS InvoiceNo,
			--A01.AnaName AS Ana01Name, A02.AnaName AS Ana02Name, A03.AnaName AS Ana03Name, A04.AnaName AS Ana04Name, A05.AnaName AS Ana05Name,
			--A06.AnaName AS Ana06Name, A07.AnaName AS Ana07Name, A08.AnaName AS Ana08Name, A09.AnaName AS Ana09Name, A10.AnaName AS Ana10Name,
			Convert(NVarchar(250),'''') AS Ana01Name, Convert(NVarchar(250),'''') AS Ana02Name, Convert(NVarchar(250),'''') AS Ana03Name, Convert(NVarchar(250),'''') AS Ana04Name,
			Convert(NVarchar(250),'''') AS Ana05Name, Convert(NVarchar(250),'''') AS Ana06Name, Convert(NVarchar(250),'''') AS Ana07Name, Convert(NVarchar(250),'''') AS Ana08Name,
			Convert(NVarchar(250),'''') AS Ana09Name, Convert(NVarchar(250),'''') AS Ana10Name,
			AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05, AT2006.CreateDate,
			--case	when AT2006.KindVoucherID IN (1, 5, 7, 9 ,15, 17) THEN 1
			--			WHEN AT2006.KindVoucherID = 3 AND AT2006.WareHouseID2 IN (''KGC001'', ''KGC002'', ''KGC003'', ''KSX001'', ''KSX002'', ''KSX003'')
			--				THEN (CASE WHEN AT2006.VoucherTypeID = ''XCK'' THEN 2 ELSE 3 END)
			--			WHEN AT2006.KindVoucherID = 3 AND AT2006.WareHouseID2 NOT IN (''KGC001'', ''KGC002'', ''KGC003'', ''KSX001'', ''KSX002'', ''KSX003'') THEN 2
			--			ELSE 4 end as Indexs,
			case	when AT2006.KindVoucherID IN (1, 5, 7, 9 ,15, 17) THEN 1
						WHEN AT2006.KindVoucherID = 3 THEN 2
						ELSE 3 end as Indexs,
			AT2007.TranMonth, AT2007.TranYear'
	SET @sSQlUnionFrom = ' 	
		FROM AT2007 WITH (NOLOCK)
		INNER JOIN AT2006 WITH (NOLOCK) on AT2006.VoucherID = AT2007.VoucherID  AND AT2006.DivisionID = AT2007.DivisionID
		INNER JOIN AT1303 WITH (NOLOCK) on AT1303.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1303.WareHouseID = AT2006.WareHouseID
		'
	SET @sSQlUnionWhere = ' 
		WHERE	AT2007.DivisionID =N''' + @DivisionID + ''' ' +
			(CASE WHEN @IsAll = 1 THEN ' AND AT1303.IsTemp = 0 ' ELSE '' END) + ' AND
			'+CASE WHEN @CustomerName = 49  THEN ' (CASE WHEN '+STR(@IsAll)+' = 1  then   isnull(AT1303.FullName,'''') else 0 end  <> ''1'' ) AND ' ELSE'' END +'
			AT2006.KindVoucherID in ' + @KindVoucherListEx1 + ' AND
			(AT2007.TranMonth + AT2007.TranYear*100 between (' + str(@FromMonth) + ' + ' + str(@FromYear) + ' *100) AND  (' + str(@ToMonth) + ' + ' + str(@ToYear) + '*100) )  AND	
			(AT2007.InventoryID between N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''') AND
			( (KindVoucherID in ' + @KindVoucherListEx2 + ' AND AT2006.WareHouseID IN (SELECT WareHouseID from #TBL_WareHouseIDAP2018_FL) or  ( KindVoucherID = 3 AND AT2006.WareHouseID2 IN (SELECT WareHouseID from #TBL_WareHouseIDAP2018_FL))) ) 
		
		--- AT1302
		UPDATE T1			
		SET	T1.InventoryName = T2.InventoryName,
			T1.Notes01 = T2.Notes01,
			T1.Notes02 = T2.Notes02,
			T1.Notes03 = T2.Notes03
		FROM #AP2018_AV2028 T1
		INNER JOIN AT1302 T2 ON T2.DivisionID IN (T1.DivisionID,''@@@'') AND T1.InventoryID = T2.InventoryID 
		
		--- AT1202
		UPDATE T1			
		SET	T1.ObjectName = T2.ObjectName
		FROM #AP2018_AV2028 T1
		INNER JOIN AT1202 T2 ON T2.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T1.ObjectID = T2.ObjectID		

		--Invoice
		UPDATE T1			
		SET	T1.InvoiceNo = T2.InvoiceNo
		FROM #AP2018_AV2028 T1
		INNER JOIN AT9000 T2  WITH (NOLOCK) ON T1.VoucherID = T2.VoucherID and T1.TransactionID = T2.TransactionID and Isnull(T1.InvoiceNo,'''')<>''''

		--- So du
		UPDATE T1			
		SET	T1.BeginQuantity = Isnull(T2.BeginQuantity,0),
			T1.BeginAmount = Isnull(T2.BeginAmount,0)
		FROM #AP2018_AV2028 T1
		INNER JOIN #AP2018_AV7015 T2 ON T1.InventoryID = T2.InventoryID AND T1.DivisionID = T2.DivisionID			

		--- Khoan muc
		UPDATE T1			
		SET	T1.Ana01Name = T2.AnaName
		FROM #AP2018_AV2028 T1
		INNER JOIN AT1011 T2 ON T1.Ana01ID = T2.AnaID AND T1.DivisionID = T2.DivisionID AND T2.AnaTypeID = ''A01''			

		UPDATE T1			
		SET	T1.Ana02Name = T2.AnaName
		FROM #AP2018_AV2028 T1
		INNER JOIN AT1011 T2 ON T1.Ana02ID = T2.AnaID AND T1.DivisionID = T2.DivisionID AND T2.AnaTypeID = ''A02''	

		UPDATE T1			
		SET	T1.Ana03Name = T2.AnaName
		FROM #AP2018_AV2028 T1
		INNER JOIN AT1011 T2 ON T1.Ana03ID = T2.AnaID AND T1.DivisionID = T2.DivisionID AND T2.AnaTypeID = ''A03''	

		UPDATE T1			
		SET	T1.Ana04Name = T2.AnaName
		FROM #AP2018_AV2028 T1
		INNER JOIN AT1011 T2 ON T1.Ana04ID = T2.AnaID AND T1.DivisionID = T2.DivisionID AND T2.AnaTypeID = ''A04''	

		UPDATE T1			
		SET	T1.Ana05Name = T2.AnaName
		FROM #AP2018_AV2028 T1
		INNER JOIN AT1011 T2 ON T1.Ana05ID = T2.AnaID AND T1.DivisionID = T2.DivisionID AND T2.AnaTypeID = ''A05''	

		UPDATE T1			
		SET	T1.Ana06Name = T2.AnaName
		FROM #AP2018_AV2028 T1
		INNER JOIN AT1011 T2 ON T1.Ana06ID = T2.AnaID AND T1.DivisionID = T2.DivisionID AND T2.AnaTypeID = ''A06''	

		UPDATE T1			
		SET	T1.Ana07Name = T2.AnaName
		FROM #AP2018_AV2028 T1
		INNER JOIN AT1011 T2 ON T1.Ana07ID = T2.AnaID AND T1.DivisionID = T2.DivisionID AND T2.AnaTypeID = ''A07''	

		UPDATE T1			
		SET	T1.Ana08Name = T2.AnaName
		FROM #AP2018_AV2028 T1
		INNER JOIN AT1011 T2 ON T1.Ana08ID = T2.AnaID AND T1.DivisionID = T2.DivisionID AND T2.AnaTypeID = ''A08''	

		UPDATE T1			
		SET	T1.Ana09Name = T2.AnaName
		FROM #AP2018_AV2028 T1
		INNER JOIN AT1011 T2 ON T1.Ana09ID = T2.AnaID AND T1.DivisionID = T2.DivisionID AND T2.AnaTypeID = ''A09''	

		UPDATE T1			
		SET	T1.Ana10Name = T2.AnaName
		FROM #AP2018_AV2028 T1
		INNER JOIN AT1011 T2 ON T1.Ana10ID = T2.AnaID AND T1.DivisionID = T2.DivisionID AND T2.AnaTypeID = ''A10''	
			'
END
ELSE
BEGIN	
	SET @sSQlSelect1 = N'
	--- Phan Nhap kho
	SELECT 	' + @WareHouseID2 + ' AS WareHouseID,
			N''' + isnull(@WareHouseName,'') + ''' AS WareHouseName, 
			AT2007.VoucherID,
			AT2007.TransactionID,
			AT2007.Orders,
			VoucherDate,
			VoucherNo,	
			VoucherDate AS ImVoucherDate,
			VoucherNo AS ImVoucherNo,		
			SourceNo AS ImSourceNo,
			LimitDate AS ImLimitDate,	
 			AT2006.WareHouseID AS ImWareHouseID,		
			AT2006.RefNo01 AS ImRefNo01 , AT2006.RefNo02 AS ImRefNo02 , 
			AT2007.ActualQuantity AS ImQuantity,
			AT2007.UnitPrice AS ImUnitPrice ,
			AT2007.ConvertedAmount AS ImConvertedAmount,
			AT2007.OriginalAmount AS ImOriginalAmount,
			isnull(AT2007.ConversionFactor ,1)*ActualQuantity AS ImConvertedQuantity,
			Null AS ExVoucherDate,
			Null AS ExVoucherNo,		
			Null AS ExSourceNo,
			Null AS ExLimitDate,	
 			Null AS ExWareHouseID,		
			Null AS ExRefNo01 , Null AS ExRefNo02 , 
			0 AS ExQuantity,
			Null AS ExUnitPrice ,
			0 AS ExConvertedAmount,
			0 AS ExOriginalAmount,
			0 AS ExConvertedQuantity,
			VoucherTypeID,
			AT2006.Description,
			AT2007.Notes,
			AT2007.InventoryID,	
			--AT1302.InventoryName,
			Convert(NVarchar(250),'''') AS InventoryName,
			AT2007.UnitID,		
			isnull(AT2007.ConversionFactor ,1) AS ConversionFactor,
			--isnull(AV7015.BeginQuantity,0) AS BeginQuantity,
			--isnull(AV7015.BeginAmount,0) AS BeginAmount,
			Convert(Decimal(28,8),0) AS BeginQuantity,
			Convert(Decimal(28,8),0) AS BeginAmount,'

	SET @sSQlSelect1A = N'
			(CASE WHEN KindVoucherID = 7 then 3 else 1 end) AS ImExOrders,
			AT2007.DebitAccountID, AT2007.CreditAccountID,
			At2006.ObjectID,
			--AT1202.ObjectName,
			--AT1302.Notes01,
			--AT1302.Notes02,
			--AT1302.Notes03, 
			Convert(NVarchar(250),'''') AS ObjectName, Convert(NVarchar(250),'''') AS Notes01, 
			Convert(NVarchar(250),'''') AS Notes02, Convert(NVarchar(250),'''') AS Notes03,  
			AT2007.DivisionID, AT2007.ConvertedUnitID,
			AT2007.Ana01ID, AT2007.Ana02ID, AT2007.Ana03ID, AT2007.Ana04ID, AT2007.Ana05ID, AT2007.Ana06ID, AT2007.Ana07ID, AT2007.Ana08ID, AT2007.Ana09ID, AT2007.Ana10ID,
			--(Select Distinct InvoiceNo from AT9000 WITH (NOLOCK) Where VoucherID = AT2007.VoucherID and TransactionID = AT2007.TransactionID and Isnull(InvoiceNo,'''')<>'''') as InvoiceNo,
			Convert(NVarchar(50),'''') AS InvoiceNo,
			--A01.AnaName AS Ana01Name, A02.AnaName AS Ana02Name, A03.AnaName AS Ana03Name, A04.AnaName AS Ana04Name, A05.AnaName AS Ana05Name,
			--A06.AnaName AS Ana06Name, A07.AnaName AS Ana07Name, A08.AnaName AS Ana08Name, A09.AnaName AS Ana09Name, A10.AnaName AS Ana10Name,
			Convert(NVarchar(250),'''') AS Ana01Name, Convert(NVarchar(250),'''') AS Ana02Name, Convert(NVarchar(250),'''') AS Ana03Name, Convert(NVarchar(250),'''') AS Ana04Name,
			Convert(NVarchar(250),'''') AS Ana05Name, Convert(NVarchar(250),'''') AS Ana06Name, Convert(NVarchar(250),'''') AS Ana07Name, Convert(NVarchar(250),'''') AS Ana08Name,
			Convert(NVarchar(250),'''') AS Ana09Name, Convert(NVarchar(250),'''') AS Ana10Name,
			AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05, AT2006.CreateDate,
			--case	when AT2006.KindVoucherID IN (1, 5, 7, 9 ,15, 17) THEN 1
			--		WHEN AT2006.KindVoucherID = 3 AND T6.WareHouseID2 IN (''KGC001'', ''KGC002'', ''KGC003'', ''KSX001'', ''KSX002'', ''KSX003'')
			--			THEN (CASE WHEN AT2006.VoucherTypeID = ''XCK'' THEN 2 ELSE 3 END)
			--		WHEN AT2006.KindVoucherID = 3 AND T6.WareHouseID2 NOT IN (''KGC001'', ''KGC002'', ''KGC003'', ''KSX001'', ''KSX002'', ''KSX003'') THEN 2
			--		ELSE 4 end as Indexs,
			case	when AT2006.KindVoucherID IN (1, 5, 7, 9 ,15, 17) THEN 1
						WHEN AT2006.KindVoucherID = 3 THEN 2
						ELSE 3 end as Indexs,
			AT2007.TranMonth, AT2007.TranYear
			INTO #AP2018_AV2028		
			'
				
	SET @sSQlFrom = ' 
		FROM AT2007 WITH (NOLOCK)
		INNER JOIN AT2006 WITH (NOLOCK) on AT2006.VoucherID = AT2007.VoucherID  AND AT2006.DivisionID = AT2007.DivisionID
		INNER JOIN AT1303 WITH (NOLOCK) on AT1303.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1303.WareHouseID = AT2006.WareHouseID 	
		'
			
	SET @sSQlWhere = ' 
		WHERE	AT2007.DivisionID =N''' + @DivisionID + ''' ' +
				(CASE WHEN @IsAll = 1 THEN ' AND AT1303.IsTemp = 0 ' ELSE '' END) + ' AND
				'+CASE WHEN @CustomerName = 49 THEN ' (CASE WHEN '+STR(@IsAll)+' = 1  then   isnull(AT1303.FullName,'''') else 0 end  <> ''1'' ) AND 'ELSE '' END +'
				(AT2007.TranMonth + AT2007.TranYear*100 between (' + str(@FromMonth) + ' + ' + str(@FromYear) + ' *100) AND  (' + str(@ToMonth) + ' + ' + str(@ToYear) + ' *100) )  AND
				KindVoucherID in ' + @KindVoucherListIm + ' AND
				(AT2007.InventoryID between N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''') AND
				AT2006.WareHouseID IN (SELECT WareHouseID from #TBL_WareHouseIDAP2018_FL)'

	SET @sSQlUnionSelect = ' 
		UNION
	--- Phan Xuat kho
		SELECT  ' + @WareHouseID1 + ' AS WareHouseID,
				N''' + isnull(@WareHouseName,'') + ''' AS WareHouseName, 
				AT2007.VoucherID,
				AT2007.TransactionID,
				AT2007.Orders,
				VoucherDate,
				VoucherNo,	
				Null AS ImVoucherDate,
				Null AS ImVoucherNo,		
				Null AS ImSourceNo,
				Null AS ImLimitDate,	
 				Null AS ExWareHouseID,	
				Null AS ImRefNo01 , Null AS ImRefNo02 , 
				0 AS ImQuantity,
				Null AS ImUnitPrice ,
				0 AS ImConvertedAmount,
				0 AS ImOriginalAmount,
				0 AS ImConvertedQuantity,
				VoucherDate AS ExVoucherDate,
				VoucherNo AS ExVoucherNo,		
				SourceNo AS ExSourceNo,
				LimitDate AS ExLimitDate,	
 				(CASE WHEN KindVoucherID = 3 then WareHouseID2 else AT2006.WareHouseID end) AS ExWareHouseID,	
				AT2006.RefNo01 AS ExRefNo01 , AT2006.RefNo02 AS ExRefNo02 , 
				AT2007.ActualQuantity AS ExQuantity,
				AT2007.UnitPrice AS ExUnitPrice ,
				AT2007.ConvertedAmount AS ExConvertedAmount,
				AT2007.OriginalAmount AS ExOriginalAmount,'

	SET @sSQlUnionSelectA = ' 
				isnull(AT2007.ConversionFactor ,1)*ActualQuantity AS ExConvertedQuantity,
				VoucherTypeID,
				AT2006.Description,
				AT2007.Notes,
				AT2007.InventoryID,	
				--AT1302.InventoryName,
				Convert(NVarchar(250),'''') AS InventoryName,
				AT2007.UnitID,		 							isnull(AT2007.ConversionFactor ,1) AS ConversionFactor,
				--isnull(AV7015.BeginQuantity,0) AS BeginQuantity,
				--isnull(AV7015.BeginAmount,0) AS BeginAmount,
				Convert(Decimal(28,8),0) AS BeginQuantity,
				Convert(Decimal(28,8),0) AS BeginAmount,
				2 AS ImExOrders,
				AT2007.DebitAccountID, AT2007.CreditAccountID,
				At2006.ObjectID,
				--AT1202.ObjectName,
				--AT1302.Notes01,
				--AT1302.Notes02,
				--AT1302.Notes03, 
				Convert(NVarchar(250),'''') AS ObjectName, Convert(NVarchar(250),'''') AS Notes01, 
				Convert(NVarchar(250),'''') AS Notes02, Convert(NVarchar(250),'''') AS Notes03,
				AT2007.DivisionID, AT2007.ConvertedUnitID,
				AT2007.Ana01ID, AT2007.Ana02ID, AT2007.Ana03ID, AT2007.Ana04ID, AT2007.Ana05ID, AT2007.Ana06ID, AT2007.Ana07ID, AT2007.Ana08ID, AT2007.Ana09ID, AT2007.Ana10ID ,
				--(Select Distinct InvoiceNo from AT9000 WITH (NOLOCK) Where VoucherID = AT2007.VoucherID and TransactionID = AT2007.TransactionID and Isnull(InvoiceNo,'''')<>'''') as InvoiceNo,
		Convert(NVarchar(50),'''') AS InvoiceNo,
				--A01.AnaName AS Ana01Name, A02.AnaName AS Ana02Name, A03.AnaName AS Ana03Name, A04.AnaName AS Ana04Name, A05.AnaName AS Ana05Name,
				--A06.AnaName AS Ana06Name, A07.AnaName AS Ana07Name, A08.AnaName AS Ana08Name, A09.AnaName AS Ana09Name, A10.AnaName AS Ana10Name,
				Convert(NVarchar(250),'''') AS Ana01Name, Convert(NVarchar(250),'''') AS Ana02Name, Convert(NVarchar(250),'''') AS Ana03Name, Convert(NVarchar(250),'''') AS Ana04Name,
				Convert(NVarchar(250),'''') AS Ana05Name, Convert(NVarchar(250),'''') AS Ana06Name, Convert(NVarchar(250),'''') AS Ana07Name, Convert(NVarchar(250),'''') AS Ana08Name,
				Convert(NVarchar(250),'''') AS Ana09Name, Convert(NVarchar(250),'''') AS Ana10Name,
				AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05, AT2006.CreateDate,
				--case	when AT2006.KindVoucherID IN (1, 5, 7, 9 ,15, 17) THEN 1
				--	WHEN AT2006.KindVoucherID = 3 AND T6.WareHouseID2 IN (''KGC001'', ''KGC002'', ''KGC003'', ''KSX001'', ''KSX002'', ''KSX003'')
				--		THEN (CASE WHEN AT2006.VoucherTypeID = ''XCK'' THEN 2 ELSE 3 END)
				--	WHEN AT2006.KindVoucherID = 3 AND T6.WareHouseID2 NOT IN (''KGC001'', ''KGC002'', ''KGC003'', ''KSX001'', ''KSX002'', ''KSX003'') THEN 2
				--	ELSE 4 end as Indexs,
				case	when AT2006.KindVoucherID IN (1, 5, 7, 9 ,15, 17) THEN 1
						WHEN AT2006.KindVoucherID = 3 THEN 2
						ELSE 3 end as Indexs,
				AT2007.TranMonth, AT2007.TranYear'	
							
	SET @sSQlUnionFrom = ' 
		FROM AT2007 WITH (NOLOCK)
		INNER JOIN AT2006 WITH (NOLOCK) on AT2006.VoucherID = AT2007.VoucherID  AND AT2006.DivisionID = AT2007.DivisionID
		INNER JOIN AT1303 WITH (NOLOCK) on AT1303.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1303.WareHouseID = AT2006.WareHouseID
		'
						
	SET @sSQlUnionWhere = ' 
		WHERE	AT2007.DivisionID = N''' + @DivisionID + ''' ' +
			(CASE WHEN @IsAll = 1 THEN ' AND AT1303.IsTemp = 0 ' ELSE '' END) + ' AND
			'+CASE WHEN @CustomerName = 49 THEN ' (CASE WHEN '+STR(@IsAll)+' = 1  then   isnull(AT1303.FullName,'''') else 0 end  <> ''1'' ) AND 'ELSE '' END +'
				AT2006.KindVoucherID in ' + @KindVoucherListEx1 + ' AND
				(CONVERT(DATETIME, CONVERT(VARCHAR(10), VoucherDate, 101), 101) Between ''' + CONVERT(varchar(10) , @FromDate , 101) + ''' AND ''' + CONVERT(varchar(10) , @ToDate , 101) + ''' ) AND
				(AT2007.InventoryID between N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''') AND
				( (KindVoucherID in ' + @KindVoucherListEx2 + '  AND 
				AT2006.WareHouseID IN (SELECT WareHouseID from #TBL_WareHouseIDAP2018_FL) or  (KindVoucherID = 3 AND AT2006.WareHouseID2 IN (SELECT WareHouseID from #TBL_WareHouseIDAP2018_FL))) )
	
			--- AT1302
		UPDATE T1			
		SET	T1.InventoryName = T2.InventoryName,
			T1.Notes01 = T2.Notes01,
			T1.Notes02 = T2.Notes02,
			T1.Notes03 = T2.Notes03
		FROM #AP2018_AV2028 T1
		INNER JOIN AT1302 T2 ON T2.DivisionID IN (T1.DivisionID,''@@@'') AND T1.InventoryID = T2.InventoryID
		
		--- AT1202
		UPDATE T1			
		SET	T1.ObjectName = T2.ObjectName
		FROM #AP2018_AV2028 T1
		INNER JOIN AT1202 T2 ON T2.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T1.ObjectID = T2.ObjectID		

		--- So du
		UPDATE T1			
		SET	T1.BeginQuantity = Isnull(T2.BeginQuantity,0),
			T1.BeginAmount = Isnull(T2.BeginAmount,0)
		FROM #AP2018_AV2028 T1
		INNER JOIN #AP2018_AV7015 T2 ON T1.InventoryID = T2.InventoryID AND T1.DivisionID = T2.DivisionID			

		--Invoice
		UPDATE T1			
		SET	T1.InvoiceNo = T2.InvoiceNo
		FROM #AP2018_AV2028 T1
		INNER JOIN AT9000 T2  WITH (NOLOCK) ON T1.VoucherID = T2.VoucherID and T1.TransactionID = T2.TransactionID and Isnull(T1.InvoiceNo,'''')<>''''


		--- Khoan muc
		UPDATE T1			
		SET	T1.Ana01Name = T2.AnaName
		FROM #AP2018_AV2028 T1
		INNER JOIN AT1011 T2 ON T1.Ana01ID = T2.AnaID AND T1.DivisionID = T2.DivisionID AND T2.AnaTypeID = ''A01''			

		UPDATE T1			
		SET	T1.Ana02Name = T2.AnaName
		FROM #AP2018_AV2028 T1
		INNER JOIN AT1011 T2 ON T1.Ana02ID = T2.AnaID AND T1.DivisionID = T2.DivisionID AND T2.AnaTypeID = ''A02''	

		UPDATE T1			
		SET	T1.Ana03Name = T2.AnaName
		FROM #AP2018_AV2028 T1
		INNER JOIN AT1011 T2 ON T1.Ana03ID = T2.AnaID AND T1.DivisionID = T2.DivisionID AND T2.AnaTypeID = ''A03''	

		UPDATE T1			
		SET	T1.Ana04Name = T2.AnaName
		FROM #AP2018_AV2028 T1
		INNER JOIN AT1011 T2 ON T1.Ana04ID = T2.AnaID AND T1.DivisionID = T2.DivisionID AND T2.AnaTypeID = ''A04''	

		UPDATE T1			
		SET	T1.Ana05Name = T2.AnaName
		FROM #AP2018_AV2028 T1
		INNER JOIN AT1011 T2 ON T1.Ana05ID = T2.AnaID AND T1.DivisionID = T2.DivisionID AND T2.AnaTypeID = ''A05''	

		UPDATE T1			
		SET	T1.Ana06Name = T2.AnaName
		FROM #AP2018_AV2028 T1
		INNER JOIN AT1011 T2 ON T1.Ana06ID = T2.AnaID AND T1.DivisionID = T2.DivisionID AND T2.AnaTypeID = ''A06''	

		UPDATE T1			
		SET	T1.Ana07Name = T2.AnaName
		FROM #AP2018_AV2028 T1
		INNER JOIN AT1011 T2 ON T1.Ana07ID = T2.AnaID AND T1.DivisionID = T2.DivisionID AND T2.AnaTypeID = ''A07''	

		UPDATE T1			
		SET	T1.Ana08Name = T2.AnaName
		FROM #AP2018_AV2028 T1
		INNER JOIN AT1011 T2 ON T1.Ana08ID = T2.AnaID AND T1.DivisionID = T2.DivisionID AND T2.AnaTypeID = ''A08''	

		UPDATE T1			
		SET	T1.Ana09Name = T2.AnaName
		FROM #AP2018_AV2028 T1
		INNER JOIN AT1011 T2 ON T1.Ana09ID = T2.AnaID AND T1.DivisionID = T2.DivisionID AND T2.AnaTypeID = ''A09''	

		UPDATE T1			
		SET	T1.Ana10Name = T2.AnaName
		FROM #AP2018_AV2028 T1
		INNER JOIN AT1011 T2 ON T1.Ana10ID = T2.AnaID AND T1.DivisionID = T2.DivisionID AND T2.AnaTypeID = ''A10''	
		'
END	 


				--PRINT 'aa' + @sSQLSelect + @sSQlFrom + @sSQlWhere
				--PRINT @sSQlUnionSelect + @sSQlUnionFrom + @sSQlUnionWhere

	--Edit by Nguyen Quoc Huy

	--print @sSQLSelect+@sSQlFrom+@sSQlWhere+@sSQlUnionSelect+@sSQlUnionFrom+@sSQlUnionWhere
		
	--print @sSQLSelect
	--print @sSQlFrom
	--print @sSQlWhere
	--print @sSQlUnionSelect
	--print @sSQlUnionFrom
	--print @sSQlUnionWhere
		
	--EXEC (@sSQLSelect+@sSQlFrom+@sSQlWhere+@sSQlUnionSelect+@sSQlUnionFrom+@sSQlUnionWhere)

	--IF NOT EXISTS ( SELECT 1 FROM SysObjects WITH (NOLOCK) WHERE Xtype = 'V' AND Name = 'AV2028' )
	--   BEGIN
	--		 EXEC ( 'CREATE VIEW AV2028 --CREATED BY AP2018_FL
	--					AS '+@sSQLSelect+@sSQlFrom+@sSQlWhere+@sSQlUnionSelect+@sSQlUnionFrom+@sSQlUnionWhere )
	--   END
	--ELSE
	--   BEGIN
	--		 EXEC ( 'ALTER VIEW AV2028 --CREATED BY AP2018_FL
	--					as '+@sSQLSelect+@sSQlFrom+@sSQlWhere+@sSQlUnionSelect+@sSQlUnionFrom+@sSQlUnionWhere )
	--   END
		 
	--- Lay du su va phat sinh
	SET @sSQLSelect11 = N' 
		SELECT	AV2028.WareHouseID, AV2028.WareHouseName, AV2028.VoucherID, AV2028.TransactionID, AV2028.Orders,
				DATEADD(d, 0, DATEDIFF(d, 0, AV2028.VoucherDate)) AS VoucherDate, AV2028.VoucherNo, AV2028.ImVoucherDate, AV2028.ImVoucherNo, AV2028.ImSourceNo,
				AV2028.ImLimitDate, AV2028.ImWareHouseID, 
				AV2028.ImRefNo01, AV2028.ImRefNo02,
				AV2028.ImQuantity, AV2028.ImUnitPrice, AV2028.ImConvertedAmount,
				AV2028.ImOriginalAmount, AV2028.ImConvertedQuantity,  
				AV2028.ExVoucherDate, AV2028.ExVoucherNo, AV2028.ExSourceNo,
				AV2028.ExLimitDate, AV2028.ExWareHouseID, 
				AV2028.ExRefNo01, AV2028.ExRefNo02,
				AV2028.ExQuantity, AV2028.ExUnitPrice, AV2028.ExConvertedAmount,
				AV2028.ExOriginalAmount, AV2028.ExConvertedQuantity, AV2028.VoucherTypeID, AV2028.Description,
				AV2028.Notes, AV2028.InventoryID, AV2028.InventoryName, AV2028.UnitID,  AT1304.UnitName, AV2028.ConversionFactor,
				AT1309.UnitID AS ConversionUnitID, AT1309.ConversionFactor AS  ConversionFactor01, AT1309.Operator,
				AV2028.BeginQuantity, AV2028.BeginAmount, AV2028.ImExOrders, AV2028.DebitAccountID, AV2028.CreditAccountID,
				AV2028.ObjectID, AV2028.ObjectName, AV2028.Notes01, AV2028.Notes02, AV2028.Notes03, AV2028.DivisionID,
				AV2028.Ana01ID, AV2028.Ana02ID, AV2028.Ana03ID, AV2028.Ana04ID, AV2028.Ana05ID, AV2028.Ana06ID, AV2028.Ana07ID, AV2028.Ana08ID, AV2028.Ana09ID, AV2028.Ana10ID ,
				AV2028.Ana01Name, AV2028.Ana02Name, AV2028.Ana03Name, AV2028.Ana04Name, AV2028.Ana05Name, AV2028.Ana06Name, AV2028.Ana07Name, AV2028.Ana08Name, AV2028.Ana09Name, AV2028.Ana10Name ,
					AV2028.InvoiceNo, AV2028.ConvertedUnitID,
					AV2028.Parameter01,AV2028.Parameter02,AV2028.Parameter03,AV2028.Parameter04,AV2028.Parameter05, AV2028.CreateDate, AV2028.Indexs,
					AV2028.TranMonth, AV2028.TranYear
		INTO #TAM
		FROM	#AP2018_AV2028 AV2028 
		LEFT JOIN AT1304 WITH (NOLOCK) on AT1304.UnitID = AV2028.UnitID AND  AT1304.DivisionID = AV2028.DivisionID 
		LEFT JOIN AT1309 WITH (NOLOCK) on AT1309.InventoryID = AV2028.InventoryID AND AT1309.UnitID = AV2028.UnitID AND AT1309.DivisionID = AV2028.DivisionID 

		WHERE	AV2028.BeginQuantity <> 0 or AV2028.BeginAmount <> 0 or AV2028.ImQuantity <> 0 or
				AV2028.ImConvertedAmount <> 0 or AV2028.ExQuantity <> 0 or AV2028.ExConvertedAmount <> 0 '

	SET @sSQlUnionSelect11 = N' 
		UNION ALL

		SELECT  AV7015.WareHouseID  AS WareHouseID, AV7015.WareHouseName AS WareHouseName, Null AS VoucherID, Null AS TransactionID, 
				Null AS Orders,null AS VoucherDate, null AS VoucherNo, null AS ImVoucherDate, null AS ImVoucherNo, 
				null AS ImSourceNo,null AS ImLimitDate, null AS ImWareHouseID,
    			Null AS ImRefNo01, Null AS  ImRefNo02,

				0 AS ImQuantity, 0 AS ImUnitPrice, 0 AS ImConvertedAmount,
				0 AS ImOriginalAmount, 0 AS ImConvertedQuantity,   0 AS ExVoucherDate, null AS ExVoucherNo, 
				null AS ExSourceNo, null AS ExLimitDate, null AS ExWareHouseID, 
				Null AS ExRefNo01, Null AS  ExRefNo02,
				0 AS ExQuantity, 0 AS ExUnitPrice, 
				0 AS ExConvertedAmount,0 AS ExOriginalAmount, 0 AS ExConvertedQuantity, 
        		null AS VoucherTypeID, null AS Description,null AS Notes, 
				AV7015.InventoryID, InventoryName, AV7015.UnitID, AT1304.UnitName, 1 AS ConversionFactor,
				AT1309.UnitID AS ConversionUnitID, AT1309.ConversionFactor AS  ConversionFactor01, AT1309.Operator,
				BeginQuantity, BeginAmount, 0 AS ImExOrders,NULL AS DebitAccountID, NULL AS CreditAccountID,
				null AS ObjectID,  null AS ObjectName,null AS Notes01, Null AS Notes02, Null AS Notes03, AV7015.DivisionID,
				NULL AS Ana01ID, NULL AS Ana02ID, NULL AS Ana03ID, NULL AS Ana04ID, NULL AS Ana05ID, NULL AS Ana06ID, NULL AS Ana07ID, NULL AS Ana08ID, NULL AS Ana09ID, NULL AS Ana10ID,
				NULL as Ana01Name, NULL as Ana02Name, NULL as Ana03Name, NULL as Ana04Name, NULL as Ana05Name, NULL as Ana06Name, NULL as Ana07Name, NULL as Ana08Name, NULL as Ana09Name, NULL as Ana10Name , 
				NULL AS InvoiceNo, NULL AS ConvertedUnitID,
				NULL as Parameter01,NULL as Parameter02,NULL as Parameter03,NULL as Parameter04,NULL as Parameter05, NULL as CreateDate, NULL as Indexs,
				NULL as TranMonth, NULL as TranYear
		FROM	#AP2018_AV7015 AV7015 
		INNER JOIN AT1304 WITH (NOLOCK) on AT1304.UnitID = AV7015.UnitID AND AT1304.DivisionID = AV7015.DivisionID
		LEFT JOIN AT1309 WITH (NOLOCK) on AT1309.InventoryID = AV7015.InventoryID AND AT1309.UnitID = AV7015.UnitID AND AT1309.DivisionID = AV7015.DivisionID
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #AP2018_AV2028 AV2028 WHERE AV7015.InventoryID = AV2028.InventoryID)		
		AND (BeginQuantity<>0 or BeginAmount<>0)

		DROP TABLE #AP2018_AV2028	
		DROP TABLE #AP2018_AV7015	

		
		'
	SET @sSQL=N'SELECT * FROM #TAM ORDER BY InventoryID, TranYear, TranMonth, Indexs, VoucherDate, CreateDate'

	--select @sSQLSelect0
	--select @sSQLSelect1
	--select @sSQLSelect1A
	--select @sSQlFrom
	--select @sSQlWhere
	--select @sSQlUnionSelect
	--select @sSQlUnionSelectA
	--select @sSQlUnionFrom
	--select @sSQlUnionWhere
	--select @sSQLSelect11
	--select @sSQlUnionSelect11
	--select @sSQL
	--EXEC (@sSQLSelect0+@sSQLSelect1+@sSQLSelect1A+@sSQlFrom+@sSQlWhere+@sSQlUnionSelect+@sSQlUnionSelectA+@sSQlUnionFrom+@sSQlUnionWhere+@sSQLSelect11+@sSQlUnionSelect11
	--+ ' ' + '
	--SELECT * FROM #TAM ORDER BY InventoryID, TranYear, TranMonth, Indexs,VoucherDate, CreateDate
	
	--')

	EXEC (@sSQLSelect0+@sSQLSelect1+@sSQLSelect1A+@sSQlFrom+@sSQlWhere+@sSQlUnionSelect+@sSQlUnionSelectA+@sSQlUnionFrom+@sSQlUnionWhere+@sSQLSelect11+@sSQlUnionSelect11+@sSQL)

	-- EXEC (@sSQLSelect+@sSQlUnionSelect + ' ' + 'SELトryidECT * FROM #TAM ORDER BY InventoryID, TranYear, TranMonth, Indexs,VoucherDate, CreateDate')
	--IF NOT EXISTS ( SELECT  1 FROM  SysObjects  WHERE  Xtype = 'V' AND Name = 'AV2018' )
	--   BEGIN
	--		 EXEC ( 'CREATE VIEW AV2018 	--CREATED BY AP2018_FL
	--				AS '+@sSQLSelect+@sSQlUnionSelect )
	--   END
	--ELSE
	--   BEGIN
	--		 EXEC ( 'ALTER VIEW AV2018 		--CREATED BY AP2018_FL
	--				AS '+@sSQLSelect+@sSQlUnionSelect )
	--   END
END





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
