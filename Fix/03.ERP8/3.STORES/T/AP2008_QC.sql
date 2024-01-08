IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP2008_QC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP2008_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Purpose: Bao cao ton kho theo kho cho tung kho theo quy cach.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Nguyen Van Nhan, Date 17/06/2003.
---- Edited by Nguyen Thi Ngoc Minh, Date 15/04/2004
---- Purpose: them tu ky den ky, tu ngay den ngay
---- Edited by Nguyen Quoc Huy, Date 06/11/2006
---- Edited by Dang Le Bao Quynh, Date 16/09/2008
---- Purpose: Cho phep IN theo toan tu LIKE doi voi ma kho
---- Edit by B.Anh, date 14/11/2009 Sua loi double dong khi mat hang co nhieu DVT
---- Edited by: [GS] [Minh Lâm] [29/07/2010]
---- Modified on 12/06/2012 by Lê Thị Thu Hiền : Bổ sung MinQuantity, MaxQuantity
---- Modified on 21/09/2012 by Bao Anh : Customize cho 2T (tồn kho theo quy cách), gọi AP2888
---- Modified on 17/06/2014 by Thanh Sơn: Lấy thêm trường TimeOfUse
---- Modified on 08/07/2014 by Bảo Anh: Trả trực tiếp dữ liệu, không tạo view AV2008
---- Modified on 11/09/2014 by Mai Duyen: Bo sung them trương SalePrice01 (KH Minh Tien)
---- Modified on 29/10/2014 by Mai Duyen: Bo sung them trương AT1302.Barcode (KH ThuanLoi)
---- Modified on 13/01/2015 by Mai Duyen: Fix loi len du lieu khong dung (KH SOFA)
---- Modified on 13/05/2015 by Bảo Anh: cải thiện tốc độ (dùng bảng tạm thay view, sửa câu tạo bảng tạm ##AV2088)
---- Modified on 25/05/2015 by Bảo Anh: Sửa lỗi double dữ liệu trong ##AV2088 khi in theo kỳ
---- Modified on 27/11/2015 by Hoàng Vũ: Sửa lỗi lấy đơn vị tính quy đổi (Từ bảng AT1309 -> AV1399)
---- Modified on 21/01/2016 by Tiểu Mai: Fix lỗi không lên tồn kho cuối cho Nam Hoa.
---- Modified on 24/02/2016 by Bảo Anh: Không lấy các trường ĐVT quy đổi lên nữa (do mặt hàng có nhiều ĐVT thì lên nhiều dòng)
---- Modified by Bảo Thy on 27/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Tiểu Mai on 20/04/2017: Fix bug len dữ liệu báo cáo chưa đúng khi khác TK tồn kho
---- Modified by Bảo Thy on 08/05/2017: Sửa danh mục dùng chung
---- Modified by Phương Thảo on 17/01/2018: Fix lỗi lấy số dư đầu kỳ sai (http://192.168.0.204:8069/web?db=ASERP#id=6507&view_type=form&model=crm.helpdesk&menu_id=451&action=423)
---- Modified by Bảo Thy on 19/01/2018: Bổ sung lọc báo cáo theo quy cách
---- Modified by Bảo Thy on 14/03/2018: Bổ sung where theo quy cách (#AV2088)
---- Modified by Bảo Thy on 04/04/2018: bổ sung InventoryID_QC
---- Modified by Kim Thư on 19/9/2018: Sửa lỗi nhiều user cùng in báo cáo, bổ sung SPID cho bảng tạm
---- Modified by Kim Thư on 22/04/2019: Bổ sung thêm trường nhóm người dùng (GroupID), truyền @UserID
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.

/*
    EXEC WP0100,0, 1
*/

CREATE PROCEDURE AP2008_QC
(
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
    @IsGroupID TINYINT, --- 0 Khong nhom; 1 Nhom 1 cap; 2 Nhom 2 cap
    @GroupID1 NVARCHAR(50), 
    @GroupID2 NVARCHAR(50), --- Note : GroupID nhan cac gia tri S1, S2, S3, CI1, CI2, CI3
	@IsSearchStandard TINYINT,
	@StandardList XML,
	@UserID VARCHAR(50)
)
AS

DECLARE @CustomerName INT
--Tao bang tam de kiem tra day co phai la khach hang 2T khong (CustomerName = 15)
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

IF ISNULL(@IsSearchStandard,0) = 1
BEGIN
	CREATE TABLE #StandardList_AP2008_QC (InventoryID VARCHAR(50), StandardTypeID VARCHAR(50), StandardID VARCHAR(50))
	
	INSERT INTO #StandardList_AP2008_QC (InventoryID, StandardTypeID, StandardID)
	SELECT	X.Data.query('InventoryID').value('.','VARCHAR(50)') AS InventoryID,
			X.Data.query('StandardTypeID').value('.','VARCHAR(50)') AS StandardTypeID,
			X.Data.query('StandardID').value('.','VARCHAR(50)') AS StandardID
	FROM @StandardList.nodes('//Data') AS X (Data)
END

DECLARE
	@sSQLDrop AS NVARCHAR(4000),
	@sSQLSelect AS NVARCHAR(4000), 
	@sSQLSelect1 AS NVARCHAR(4000),
	@sSQLFrom AS NVARCHAR(4000), 
	@sSQLFrom1 AS NVARCHAR(4000), 
	@sSQLWhere AS NVARCHAR(4000),
	@sSQLUnion AS NVARCHAR(4000), 
	@sSQLUnion1 AS NVARCHAR(4000), 
	@sSQL AS NVARCHAR(4000)='', 
	@GroupField1 AS NVARCHAR(50), 
	@GroupField2 AS NVARCHAR(50), 
	@FromMonthYearText NVARCHAR(20), 
	@ToMonthYearText NVARCHAR(20), 
	@FromDateText NVARCHAR(20), 
	@ToDateText NVARCHAR(20),
	@WhereTime AS NVARCHAR(4000),
	@3MonthPrevious INT,
	@YearPrevious INT,
	@GroupID VARCHAR(50)
-- Đảm bảo chuỗi không bị null dẫn tới ghép chuỗi bị lỗi
SET @sSQLDrop = ''
SET @sSQLSelect = ''
SET @sSQLFrom = ''
SET @sSQLFrom1 = ''
SET @sSQLWhere = ''
SET @sSQLUnion = ''
SET @sSQLUnion1 = ''
SET @GroupField1 = ''
SET @GroupField2 = ''
SET @WhereTime = ''

SET @FromMonthYearText = STR(@FromMonth + @FromYear * 100)
SET @ToMonthYearText = STR(@ToMonth + @ToYear * 100)
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'
SET @GroupID= (SELECT TOP 1 AT1402.GroupID FROM AT1402 WITH(NOLOCK) WHERE AT1402.UserID = @UserID)

--- Xóa các bảng tạm nếu đã tồn tại
		 SET @sSQLDrop = @sSQLDrop +'
		IF EXISTS (SELECT TOP 1 1 FROM tempdb.dbo.sysobjects WITH (NOLOCK) WHERE ID = OBJECT_ID(N''tempdb.dbo.##AV7018'+ltrim(@@SPID)+''')) 
			DROP TABLE ##AV7018'+ltrim(@@SPID)+'

		IF EXISTS (SELECT TOP 1 1 FROM tempdb.dbo.sysobjects WITH (NOLOCK) WHERE ID = OBJECT_ID(N''tempdb.dbo.##AV2088'+ltrim(@@SPID)+''')) 
			DROP TABLE ##AV2088'+ltrim(@@SPID)+'

		IF EXISTS (SELECT TOP 1 1 FROM tempdb.dbo.sysobjects WITH (NOLOCK) WHERE ID = OBJECT_ID(N''tempdb.dbo.##AV2098'+ltrim(@@SPID)+''')) 
			DROP TABLE ##AV2098'+ltrim(@@SPID)+'
		'

IF @IsDate = 0 --Xac dinh so du theo ky
	BEGIN
		IF @ToMonth > 3	BEGIN SET @3MonthPrevious = @ToMonth - 3 SET @YearPrevious = @ToYear END
		ELSE BEGIN SET @3MonthPrevious = 9 + @ToMonth SET @YearPrevious = @ToYear - 1 END
				
		SET @WhereTime = ' AV7000.TranMonth + AV7000.TranYear*100 BETWEEN ' + @FromMonthYearText + ' AND ' + @ToMonthYearText
		SET @sSQLSelect = '
			SELECT AT1302.S1, AT1302.S2, AT1302.S3, AT1302.I01ID, AT1302.I02ID, AT1302.I03ID, AT1302.I04ID, AT1302.I05ID,
				Max(Isnull(AT1302.Notes01,'''')) as Notes01, Max(isnull(AT1302.Notes02,'''')) as Notes02, Max(isnull(AT1302.Notes03,'''')) as Notes03,
				 AT1302.SalePrice01, AT2008.InventoryID, AT1302.InventoryName, AT2008.InventoryAccountID,
				AT1302.InventoryTypeID, AT1302.Specification, AT1302.UnitID, AT1304.UnitName,
				SUM(CASE WHEN TranMonth + TranYear * 100 = ' + @FromMonthYearText + ' THEN ISNULL(BeginQuantity, 0) ELSE 0 END) AS BeginQuantity, 
				0 AS DebitQuantity, 0 AS CreditQuantity, 
				0 AS EndQuantity, 
				SUM(CASE WHEN TranMonth + TranYear * 100 = ' + @FromMonthYearText + ' THEN ISNULL(BeginAmount, 0) ELSE 0 END) AS BeginAmount, 
				0 AS DebitAmount, 0 AS CreditAmount, 
				0 AS EndAmount,
				0 AS InDebitQuantity, 0 AS InCreditQuantity,
				0 AS InDebitAmount, 0 AS InCreditAmount,
				AT2008.WareHouseID, AT2008.DivisionID, AT1302.Barcode, AT1303.WarehouseName,
				AT2008.S01ID, AT2008.S02ID, AT2008.S03ID, AT2008.S04ID, AT2008.S05ID, 
				AT2008.S06ID, AT2008.S07ID, AT2008.S08ID, AT2008.S09ID, AT2008.S10ID, 
				AT2008.S11ID, AT2008.S12ID, AT2008.S13ID, AT2008.S14ID, AT2008.S15ID, 
				AT2008.S16ID, AT2008.S17ID, AT2008.S18ID, AT2008.S19ID, AT2008.S20ID' 
		SET @sSQLFrom = ' INTO ##AV7018'+ltrim(@@SPID)+'
			FROM AT2008_QC AT2008  WITH (NOLOCK)
			INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2008.DivisionID,''@@@'') AND AT1302.InventoryID = AT2008.InventoryID
			LEFT JOIN AT1304 WITH (NOLOCK) ON AT1302.DivisionID IN (AT1304.DivisionID,''@@@'') AND AT1304.UnitID = AT1302.UnitID
			LEFT JOIN AT1309 WITH (NOLOCK) ON AT1302.DivisionID IN (AT1309.DivisionID,''@@@'') AND AT1309.InventoryID = AT1302.InventoryID AND AT1309.UnitID = AT1302.UnitID
			AND ISNULL(AT2008.S01ID,'''') = Isnull(AT1309.S01ID,'''') AND ISNULL(AT2008.S02ID,'''') = isnull(AT1309.S02ID,'''')
			AND ISNULL(AT2008.S03ID,'''') = isnull(AT1309.S03ID,'''') AND ISNULL(AT2008.S04ID,'''') = isnull(AT1309.S04ID,'''')
			AND ISNULL(AT2008.S05ID,'''') = isnull(AT1309.S05ID,'''') AND ISNULL(AT2008.S06ID,'''') = isnull(AT1309.S06ID,'''')
			AND ISNULL(AT2008.S07ID,'''') = isnull(AT1309.S07ID,'''') AND ISNULL(AT2008.S08ID,'''') = isnull(AT1309.S08ID,'''') 
			AND ISNULL(AT2008.S09ID,'''') = isnull(AT1309.S09ID,'''') AND ISNULL(AT2008.S10ID,'''') = isnull(AT1309.S10ID,'''') 
			AND ISNULL(AT2008.S11ID,'''') = isnull(AT1309.S11ID,'''') AND ISNULL(AT2008.S12ID,'''') = isnull(AT1309.S12ID,'''') 
			AND ISNULL(AT2008.S13ID,'''') = isnull(AT1309.S13ID,'''') AND ISNULL(AT2008.S14ID,'''') = isnull(AT1309.S14ID,'''') 
			AND ISNULL(AT2008.S15ID,'''') = isnull(AT1309.S15ID,'''') AND ISNULL(AT2008.S16ID,'''') = isnull(AT1309.S16ID,'''') 
			AND ISNULL(AT2008.S17ID,'''') = isnull(AT1309.S17ID,'''') AND ISNULL(AT2008.S18ID,'''') = isnull(AT1309.S18ID,'''') 
			AND ISNULL(AT2008.S19ID,'''') = isnull(AT1309.S19ID,'''') AND ISNULL(AT2008.S20ID,'''') = isnull(AT1309.S20ID,'''')
			LEFT JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN ('''+@DivisionID+''',''@@@'') AND  AT1303.WareHouseID = AT2008.WareHouseID' 
		SET @sSQLWhere = ' 
			WHERE AT2008.DivisionID = ''' + @DivisionID + ''' 
				AND AT2008.WareHouseID LIKE ''' + @WareHouseID + ''' 
				AND AT2008.InventoryID BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + '''
				AND AT2008.TranMonth + 100 * AT2008.TranYear BETWEEN ' + @FromMonthYearText + ' AND ' + @ToMonthYearText + '
				GROUP BY 
				AT2008.DivisionID, AT2008.InventoryID, InventoryName, AT2008.WareHouseID, AT1302.UnitID, 
				AT1309.UnitID, AT1309.ConversionFactor, AT1309.Operator, 
				AT1304.UnitName, AT1302.S1, AT1302.S2, AT1302.S3, 
				AT1302.I01ID, AT1302.I02ID, AT1302.I03ID, AT1302.I04ID, AT1302.I05ID, AT1302. InventoryTypeID, AT1302.Specification, 
				--AT1302.Notes01, AT1302.Notes02, AT1302.Notes03,
				AT1302.SalePrice01, AT1302.Barcode, AT1303.WarehouseName, AT2008.InventoryAccountID,
				AT2008.S01ID, AT2008.S02ID, AT2008.S03ID, AT2008.S04ID, AT2008.S05ID, 
				AT2008.S06ID, AT2008.S07ID, AT2008.S08ID, AT2008.S09ID, AT2008.S10ID, 
				AT2008.S11ID, AT2008.S12ID, AT2008.S13ID, AT2008.S14ID, AT2008.S15ID, 
				AT2008.S16ID, AT2008.S17ID, AT2008.S18ID, AT2008.S19ID, AT2008.S20ID'
			END
		ELSE --Xac dinh so du theo ngay
		BEGIN
			IF Month(@ToDate) > 3 BEGIN SET @3MonthPrevious = Month(@ToDate) - 3  SET @YearPrevious = YEAR(@ToDate) END
			ELSE BEGIN SET @3MonthPrevious = 9 + Month(@ToDate) SET @YearPrevious = Month(@ToDate) - 1 END
				
			SET @WhereTime = ' AV7000.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''''
			SET @sSQLSelect = ' 
				SELECT AV7000.S1, AV7000.S2, AV7000.S3, AV7000.I01ID, AV7000.I02ID, AV7000.I03ID, AV7000.I04ID, AV7000.I05ID, 
					Max(isnull(AV7000.Notes01,'''')) as Notes01 , Max(Isnull(AV7000.Notes02,'''')) as Notes02, Max(Isnull(AV7000.Notes03,'''')) as Notes03,
					AV7000.SalePrice01, AV7000.InventoryID, AV7000.InventoryName, AV7000.InventoryAccountID,
					AV7000.InventoryTypeID, AV7000.Specification, AV7000.UnitID, AV7000.UnitName, SUM(SignQuantity) AS BeginQuantity, 
					0 AS DebitQuantity, 0 AS CreditQuantity, 0 AS DebitAmount, SUM(SignAmount) AS BeginAmount, 0 AS CreditAmount, 
					0 AS EndQuantity, 0 AS EndAmount, 0 AS InDebitQuantity, 0 AS InCreditQuantity, 0 AS InDebitAmount, 
					0 AS InCreditAmount, AV7000.WareHouseID, AV7000.DivisionID, AV7000.Barcode, AV7000.WarehouseName,
					AV7000.S01ID, AV7000.S02ID, AV7000.S03ID, AV7000.S04ID, AV7000.S05ID, 
					AV7000.S06ID, AV7000.S07ID, AV7000.S08ID, AV7000.S09ID, AV7000.S10ID, 
					AV7000.S11ID, AV7000.S12ID, AV7000.S13ID, AV7000.S14ID, AV7000.S15ID, 
					AV7000.S16ID, AV7000.S17ID, AV7000.S18ID, AV7000.S19ID, AV7000.S20ID'
			SET @sSQLFrom = ' INTO ##AV7018'+ltrim(@@SPID)+'
				FROM AV7002 AV7000'
			SET @sSQLWhere = '
				WHERE AV7000.DivisionID = ''' + @DivisionID + ''' 
					AND AV7000.WareHouseID LIKE ''' + @WareHouseID + ''' 
					AND AV7000.InventoryID BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + '''
					AND (AV7000.VoucherDate < ''' + @FromDateText + ''' OR D_C = ''BD'')
					GROUP BY DivisionID, WareHouseID, InventoryID, InventoryName, UnitID, UnitName, S1, S2, S3, 
					I01ID, I02ID, I03ID, I04ID, I05ID, InventoryTypeID, Specification, 
					--Notes01, Notes02, Notes03,
					SalePrice01, Barcode, WarehouseName, AV7000.InventoryAccountID,
					AV7000.S01ID, AV7000.S02ID, AV7000.S03ID, AV7000.S04ID, AV7000.S05ID, 
					AV7000.S06ID, AV7000.S07ID, AV7000.S08ID, AV7000.S09ID, AV7000.S10ID, 
					AV7000.S11ID, AV7000.S12ID, AV7000.S13ID, AV7000.S14ID, AV7000.S15ID, 
					AV7000.S16ID, AV7000.S17ID, AV7000.S18ID, AV7000.S19ID, AV7000.S20ID'
			END
EXEC(@sSQLDrop + @sSQLSelect + @sSQLFrom + @sSQLWhere)

--PRINT @sSQLSelect
--PRINT @sSQLFrom
--PRINT @sSQLWhere

/*
		IF NOT EXISTS ( SELECT 1 FROM sysObjects WHERE Xtype = 'V' AND Name = 'AV7018' )
			EXEC ('CREATE VIEW AV7018 -- Tao boi AP2008
				AS ' + @sSQLSelect + @sSQLFrom + @sSQLWhere)
		ELSE
			EXEC ('ALTER VIEW AV7018 -- Tao boi AP2008
				AS ' + @sSQLSelect + @sSQLFrom + @sSQLWhere)
*/
 --print @sSQLSelect 
 --print  @sSQLFrom
 --print  @sSQLWhere
 

SET @sSQLSelect = '
	SELECT AV7018.S1, AV7018.S2, AV7018.S3, AV7018.I01ID, AV7018.I02ID, AV7018.I03ID, AV7018.I04ID, AV7018.I05ID, 
		AV7018.Notes01 , AV7018.Notes02, AV7018.Notes03, AV7018.InventoryAccountID,
		AV7018.SalePrice01, AV7018.InventoryID, AV7018.InventoryName,
		AV7018.InventoryTypeID, AV7018.Specification, AV7018.UnitID, AV7018.UnitName,
		ISNULL(AV7018.BeginQuantity, 0) AS BeginQuantity, ISNULL(AV7018.BeginAmount, 0) AS BeginAmount, AV7018.DebitQuantity, AV7018.CreditQuantity, 
		AV7018.EndQuantity, AV7018.DebitAmount, AV7018.CreditAmount, 
		AV7018.EndAmount, AV7018.InDebitQuantity, AV7018.InCreditQuantity, AV7018.WareHouseID, AV7018.DivisionID, AV7018.Barcode, AV7018.WarehouseName,
		AV7018.S01ID, AV7018.S02ID, AV7018.S03ID, AV7018.S04ID, AV7018.S05ID, 
		AV7018.S06ID, AV7018.S07ID, AV7018.S08ID, AV7018.S09ID, AV7018.S10ID, 
		AV7018.S11ID, AV7018.S12ID, AV7018.S13ID, AV7018.S14ID, AV7018.S15ID, 
		AV7018.S16ID, AV7018.S17ID, AV7018.S18ID, AV7018.S19ID, AV7018.S20ID'
		SET @sSQLFrom = ' INTO ##AV2088'+ltrim(@@SPID)+'
FROM ##AV7018'+ltrim(@@SPID)+' AV7018
--LEFT JOIN AV7002 AV7000  ON AV7018.DivisionID = AV7000.DivisionID AND AV7000.WareHouseID = AV7018.WareHouseID AND AV7000.InventoryID = AV7018.InventoryID AND
--																	AV7000.InventoryAccountID = AV7018.InventoryAccountID AND
--																	ISNULL(AV7000.S01ID,'''') = ISNULL(AV7018.S01ID,'''') AND
--																	ISNULL(AV7000.S02ID,'''') = ISNULL(AV7018.S02ID,'''') AND
--																	ISNULL(AV7000.S03ID,'''') = ISNULL(AV7018.S03ID,'''') AND
--																	ISNULL(AV7000.S04ID,'''') = ISNULL(AV7018.S04ID,'''') AND
--																	ISNULL(AV7000.S05ID,'''') = ISNULL(AV7018.S05ID,'''') AND
--																	ISNULL(AV7000.S06ID,'''') = ISNULL(AV7018.S06ID,'''') AND
--																	ISNULL(AV7000.S07ID,'''') = ISNULL(AV7018.S07ID,'''') AND
--																	ISNULL(AV7000.S08ID,'''') = ISNULL(AV7018.S08ID,'''') AND
--																	ISNULL(AV7000.S09ID,'''') = ISNULL(AV7018.S09ID,'''') AND
--																	ISNULL(AV7000.S10ID,'''') = ISNULL(AV7018.S10ID,'''') AND
--																	ISNULL(AV7000.S11ID,'''') = ISNULL(AV7018.S11ID,'''') AND
--																	ISNULL(AV7000.S12ID,'''') = ISNULL(AV7018.S12ID,'''') AND
--																	ISNULL(AV7000.S13ID,'''') = ISNULL(AV7018.S13ID,'''') AND
--																	ISNULL(AV7000.S14ID,'''') = ISNULL(AV7018.S14ID,'''') AND
--																	ISNULL(AV7000.S15ID,'''') = ISNULL(AV7018.S15ID,'''') AND
--																	ISNULL(AV7000.S16ID,'''') = ISNULL(AV7018.S16ID,'''') AND
--																	ISNULL(AV7000.S17ID,'''') = ISNULL(AV7018.S17ID,'''') AND
--																	ISNULL(AV7000.S18ID,'''') = ISNULL(AV7018.S18ID,'''') AND
--																	ISNULL(AV7000.S19ID,'''') = ISNULL(AV7018.S19ID,'''') AND
--																	ISNULL(AV7000.S20ID,'''') = ISNULL(AV7018.S20ID,'''')'

		IF @IsDate <> 0
			SET @sSQLWhere = ''
		ELSE
			SET @sSQLWhere = ' 
		WHERE AV7018.WareHouseID LIKE '''+@WareHouseID+''' AND AV7018.DivisionID = '''+@DivisionID+''' 
		--AND ISNULL(AV7000.InventoryID,'''') <> '''' 
		AND AV7018.InventoryID NOT IN 
		(
			SELECT InventoryID FROM AV7000 
			WHERE AV7000.DivisionID ='''+@DivisionID+''' 
			AND AV7000.WareHouseID LIKE '''+@WareHouseID+''' 
			AND AV7000.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+'''
			AND AV7000.D_C IN (''D'', ''C'') 
			AND ISNULL(AV7000.S01ID,'''') = ISNULL(AV7018.S01ID,'''')
			AND ISNULL(AV7000.S02ID,'''') = ISNULL(AV7018.S02ID,'''') 
			AND ISNULL(AV7000.S03ID,'''') = ISNULL(AV7018.S03ID,'''') 
			AND ISNULL(AV7000.S04ID,'''') = ISNULL(AV7018.S04ID,'''') 
			AND ISNULL(AV7000.S05ID,'''') = ISNULL(AV7018.S05ID,'''') 
			AND ISNULL(AV7000.S06ID,'''') = ISNULL(AV7018.S06ID,'''') 
			AND ISNULL(AV7000.S07ID,'''') = ISNULL(AV7018.S07ID,'''') 
			AND ISNULL(AV7000.S08ID,'''') = ISNULL(AV7018.S08ID,'''') 
			AND ISNULL(AV7000.S09ID,'''') = ISNULL(AV7018.S09ID,'''') 
			AND ISNULL(AV7000.S10ID,'''') = ISNULL(AV7018.S10ID,'''') 
			AND ISNULL(AV7000.S11ID,'''') = ISNULL(AV7018.S11ID,'''') 
			AND ISNULL(AV7000.S12ID,'''') = ISNULL(AV7018.S12ID,'''') 
			AND ISNULL(AV7000.S13ID,'''') = ISNULL(AV7018.S13ID,'''') 
			AND ISNULL(AV7000.S14ID,'''') = ISNULL(AV7018.S14ID,'''') 
			AND ISNULL(AV7000.S15ID,'''') = ISNULL(AV7018.S15ID,'''') 
			AND ISNULL(AV7000.S16ID,'''') = ISNULL(AV7018.S16ID,'''') 
			AND ISNULL(AV7000.S17ID,'''') = ISNULL(AV7018.S17ID,'''') 
			AND ISNULL(AV7000.S18ID,'''') = ISNULL(AV7018.S18ID,'''') 
			AND ISNULL(AV7000.S19ID,'''') = ISNULL(AV7018.S19ID,'''') 
			AND ISNULL(AV7000.S20ID,'''') = ISNULL(AV7018.S20ID,'''')
			AND '+@WhereTime+'
		)
		'

		SET @sSQLUnion = '
		UNION ALL
SELECT AV7000.S1, AV7000.S2, AV7000.S3, AV7000.I01ID, AV7000.I02ID, AV7000.I03ID, AV7000.I04ID, AV7000.I05ID, 
	Max(Isnull(AV7000.Notes01,'''')) as Notes01, Max(Isnull(AV7000.Notes02,'''')) as Notes02, Max(Isnull(AV7000.Notes03,'''')) as Notes03 , AV7000.InventoryAccountID,
	AV7000.SalePrice01, AV7000.InventoryID, AV7000.InventoryName,
	AV7000.InventoryTypeID, AV7000.Specification, AV7000.UnitID, AV7000.UnitName,'
		IF @IsDate = 0
			SET @sSQLUnion = @sSQLUnion + 'AV7018.BeginQuantity AS BeginQuantity, AV7018.BeginAmount AS BeginAmount,'
		ELSE
			SET @sSQLUnion = @sSQLUnion + '0 AS BeginQuantity, 0 AS BeginAmount,'

		SET @sSQLUnion = @sSQLUnion + '
	SUM(CASE WHEN D_C = ''D'' THEN ISNULL(AV7000.ActualQuantity, 0) ELSE 0 END) AS DebitQuantity, 
	SUM(CASE WHEN D_C = ''C'' THEN ISNULL(AV7000.ActualQuantity, 0) ELSE 0 END) AS CreditQuantity, 0 AS EndQuantity,
	SUM(CASE WHEN D_C = ''D'' THEN ISNULL(AV7000.ConvertedAmount, 0) ELSE 0 END) AS DebitAmount, 
	SUM(CASE WHEN D_C = ''C'' THEN ISNULL(AV7000.ConvertedAmount, 0) ELSE 0 END) AS CreditAmount, 0 AS EndAmount, 
	SUM(CASE WHEN D_C = ''D'' AND KindVoucherID = 3 THEN ISNULL(AV7000.ActualQuantity, 0) ELSE 0 END) AS InDebitQuantity, 
	SUM(CASE WHEN D_C = ''C'' AND KindVoucherID = 3 THEN ISNULL(AV7000.ActualQuantity, 0) ELSE 0 END) AS InCreditQuantity,
	AV7000.WareHouseID, AV7000.DivisionID, AV7000.Barcode, AV7000.WarehouseName,
	AV7000.S01ID, AV7000.S02ID, AV7000.S03ID, AV7000.S04ID, AV7000.S05ID, 
	AV7000.S06ID, AV7000.S07ID, AV7000.S08ID, AV7000.S09ID, AV7000.S10ID, 
	AV7000.S11ID, AV7000.S12ID, AV7000.S13ID, AV7000.S14ID, AV7000.S15ID, 
	AV7000.S16ID, AV7000.S17ID, AV7000.S18ID, AV7000.S19ID, AV7000.S20ID
FROM AV7002 AV7000'
	IF @IsDate = 0
		SET @sSQLUnion = @sSQLUnion + '	LEFT JOIN ##AV7018'+ltrim(@@SPID)+' AV7018 ON AV7018.DivisionID = AV7000.DivisionID AND AV7000.WareHouseID = AV7018.WareHouseID AND AV7000.InventoryID = AV7018.InventoryID AND
																	AV7000.InventoryAccountID = AV7018.InventoryAccountID AND
																	ISNULL(AV7000.S01ID,'''') = ISNULL(AV7018.S01ID,'''') AND
																	ISNULL(AV7000.S02ID,'''') = ISNULL(AV7018.S02ID,'''') AND
																	ISNULL(AV7000.S03ID,'''') = ISNULL(AV7018.S03ID,'''') AND
																	ISNULL(AV7000.S04ID,'''') = ISNULL(AV7018.S04ID,'''') AND
																	ISNULL(AV7000.S05ID,'''') = ISNULL(AV7018.S05ID,'''') AND
																	ISNULL(AV7000.S06ID,'''') = ISNULL(AV7018.S06ID,'''') AND
																	ISNULL(AV7000.S07ID,'''') = ISNULL(AV7018.S07ID,'''') AND
																	ISNULL(AV7000.S08ID,'''') = ISNULL(AV7018.S08ID,'''') AND
																	ISNULL(AV7000.S09ID,'''') = ISNULL(AV7018.S09ID,'''') AND
																	ISNULL(AV7000.S10ID,'''') = ISNULL(AV7018.S10ID,'''') AND
																	ISNULL(AV7000.S11ID,'''') = ISNULL(AV7018.S11ID,'''') AND
																	ISNULL(AV7000.S12ID,'''') = ISNULL(AV7018.S12ID,'''') AND
																	ISNULL(AV7000.S13ID,'''') = ISNULL(AV7018.S13ID,'''') AND
																	ISNULL(AV7000.S14ID,'''') = ISNULL(AV7018.S14ID,'''') AND
																	ISNULL(AV7000.S15ID,'''') = ISNULL(AV7018.S15ID,'''') AND
																	ISNULL(AV7000.S16ID,'''') = ISNULL(AV7018.S16ID,'''') AND
																	ISNULL(AV7000.S17ID,'''') = ISNULL(AV7018.S17ID,'''') AND
																	ISNULL(AV7000.S18ID,'''') = ISNULL(AV7018.S18ID,'''') AND
																	ISNULL(AV7000.S19ID,'''') = ISNULL(AV7018.S19ID,'''') AND
																	ISNULL(AV7000.S20ID,'''') = ISNULL(AV7018.S20ID,'''')'

	SET @sSQLUnion1 = @sSQLUnion1 + '
WHERE AV7000.DivisionID ='''+@DivisionID+''' 
	AND AV7000.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+'''
	AND AV7000.WareHouseID LIKE '''+@WareHouseID+''' 
	AND AV7000.D_C IN (''D'', ''C'') 
	AND '+@WhereTime+'
GROUP BY 
	AV7000.S1, AV7000.S2, AV7000.S3, AV7000.I01ID, AV7000.I02ID, AV7000.I03ID, AV7000.I04ID, AV7000.I05ID, 
	--AV7000.Notes01, AV7000.Notes02, AV7000.Notes03 , 
	AV7000.SalePrice01, AV7000.InventoryID, AV7000.InventoryName, AV7000.InventoryAccountID,
	AV7000.InventoryTypeID, AV7000.Specification, AV7000.UnitID, AV7000.UnitName,'

	IF @IsDate = 0
		SET @sSQLUnion1 = @sSQLUnion1 + 'AV7018.BeginQuantity, AV7018.BeginAmount,'

	SET @sSQLUnion1 = @sSQLUnion1 + 'AV7000.WareHouseID, AV7000.DivisionID, AV7000.Barcode, AV7000.WarehouseName,
									AV7000.S01ID, AV7000.S02ID, AV7000.S03ID, AV7000.S04ID, AV7000.S05ID, 
									AV7000.S06ID, AV7000.S07ID, AV7000.S08ID, AV7000.S09ID, AV7000.S10ID, 
									AV7000.S11ID, AV7000.S12ID, AV7000.S13ID, AV7000.S14ID, AV7000.S15ID, 
									AV7000.S16ID, AV7000.S17ID, AV7000.S18ID, AV7000.S19ID, AV7000.S20ID'

		
--Print @sSQLSelect 
--Print  @sSQLFrom 
--Print  @sSQLWhere 
--Print  @sSQLUnion
--Print  @sSQLUnion1

EXEC(@sSQLSelect + @sSQLFrom + @sSQLWhere + @sSQLUnion + @sSQLUnion1)
	/*	
		IF NOT EXISTS ( SELECT 1 FROM sysObjects WHERE Xtype = 'V' AND Name = 'AV2088' ) 
			EXEC ('CREATE VIEW AV2088 -- Tao boi AP2008
				AS ' + @sSQLSelect + @sSQLFrom + @sSQLWhere + @sSQLUnion)
		ELSE
			EXEC ('ALTER VIEW AV2088 -- Tao boi AP2008
				AS ' + @sSQLSelect + @sSQLFrom + @sSQLWhere + @sSQLUnion)
*/

		SET @sSQLSelect = '
SELECT AV2088.S1, AV2088.S2, AV2088.S3, AV2088.I01ID, AV2088.I02ID, AV2088.I03ID,
	AV2088.I04ID, AV2088.I05ID,
	Max(Isnull(AV2088.Notes01,'''')) as Notes01 , Max(Isnull(AV2088.Notes02,'''')) as Notes02, Max(Isnull(AV2088.Notes03,'''')) as Notes03 ,
	AV2088.SalePrice01, AV2088.InventoryAccountID,
	AV2088.InventoryID, AV2088.InventoryName, AV2088.InventoryTypeID,AT1301.InventoryTypeName, AV2088.Specification, AV2088.UnitID,
	AV2088.UnitName, ---AT1309.UnitID AS ConversionUnitID, AT1309.ConversionFactor, AT1309.Operator,
	SUM(AV2088.BeginQuantity) AS BeginQuantity, SUM(AV2088.DebitQuantity) AS DebitQuantity, 
	SUM(AV2088.CreditQuantity) AS CreditQuantity, SUM(AV2088.BeginQuantity + DebitQuantity - CreditQuantity) AS EndQuantity,
	SUM(AV2088.BeginAmount) AS BeginAmount, SUM(AV2088.DebitAmount) AS DebitAmount, 
	SUM(AV2088.CreditAmount) AS CreditAmount, SUM(AV2088.BeginAmount + DebitAmount - CreditAmount) AS EndAmount,
	0 AS InDebitAmount, 0 AS InCreditAmount, SUM(AV2088.InDebitQuantity) AS InDebitQuantity, 
	SUM(AV2088.InCreditQuantity) AS InCreditQuantity, AV2088.WareHouseID, AV2088.DivisionID, AV2088.Barcode, AV2088.WarehouseName,
	AV2088.S01ID, AV2088.S02ID, AV2088.S03ID, AV2088.S04ID, AV2088.S05ID, 
	AV2088.S06ID, AV2088.S07ID, AV2088.S08ID, AV2088.S09ID, AV2088.S10ID, 
	AV2088.S11ID, AV2088.S12ID, AV2088.S13ID, AV2088.S14ID, AV2088.S15ID, 
	AV2088.S16ID, AV2088.S17ID, AV2088.S18ID, AV2088.S19ID, AV2088.S20ID'
		SET @sSQLFrom = ' INTO ##AV2098'+ltrim(@@SPID)+' 
FROM ##AV2088'+ltrim(@@SPID)+' AV2088 
	--LEFT JOIN AV1399 as AT1309 ON AT1309.DivisionID = AV2088.DivisionID AND AT1309.InventoryID = AV2088.InventoryID AND AT1309.UnitID = AV2088.UnitID
	LEFT JOIN AT1301 ON AT1301.InventoryTypeID = AV2088.InventoryTypeID'
	
		SET @sSQLWhere = ' 
WHERE (BeginQuantity <> 0 OR BeginAmount <> 0 
	OR DebitQuantity <> 0 OR DebitAmount <> 0 
	OR CreditQuantity <> 0 OR CreditAmount <> 0 
	OR EndQuantity <> 0 OR EndAmount <> 0)
	AND AV2088.DivisionID =''' + @DivisionID + ''' 
GROUP BY AV2088.S1, AV2088.S2, AV2088.S3, AV2088.I01ID, AV2088.I02ID, AV2088.I03ID, AV2088.I04ID, AV2088.I05ID, 
	--AV2088.Notes01, AV2088.Notes02, AV2088.Notes03 ,
	AV2088.SalePrice01, AV2088.InventoryID, AV2088.InventoryName, AV2088.InventoryAccountID,
	AV2088.InventoryTypeID,AT1301.InventoryTypeName, AV2088.Specification, AV2088.UnitID, AV2088.UnitName,
	---AT1309.UnitID, AT1309.ConversionFactor, AT1309.Operator,
	AV2088.WareHouseID, AV2088.DivisionID, AV2088.Barcode, AV2088.WarehouseName,
	AV2088.S01ID, AV2088.S02ID, AV2088.S03ID, AV2088.S04ID, AV2088.S05ID, 
	AV2088.S06ID, AV2088.S07ID, AV2088.S08ID, AV2088.S09ID, AV2088.S10ID, 
	AV2088.S11ID, AV2088.S12ID, AV2088.S13ID, AV2088.S14ID, AV2088.S15ID, 
	AV2088.S16ID, AV2088.S17ID, AV2088.S18ID, AV2088.S19ID, AV2088.S20ID'
		----Theo ngay----------------------------------------------------

EXEC(@sSQLSelect + @sSQLFrom + @sSQLWhere)
/*
	IF NOT EXISTS ( SELECT 1 FROM sysObjects WHERE Xtype = 'V' AND Name = 'AV2098' )
		EXEC ('CREATE VIEW AV2098 -- Tao boi AP2008
			AS ' + @sSQLSelect + @sSQLFrom + @sSQLWhere)
	ELSE
		EXEC ('ALTER VIEW AV2098 -- Tao boi AP2008
			AS ' + @sSQLSelect + @sSQLFrom + @sSQLWhere)
*/
	--Print  @sSQLSelect 
	--Print  @sSQLFrom 
	--Print  @sSQLWhere



		SET @GroupField1 = ( 
		SELECT CASE @GroupID1
		WHEN 'CI1' THEN 'S1'
		WHEN 'CI2' THEN 'S2'
		WHEN 'CI3' THEN 'S3'
		WHEN 'I01' THEN 'I01ID'
		WHEN 'I02' THEN 'I02ID'
		WHEN 'I03' THEN 'I03ID'
		WHEN 'I04' THEN 'I04ID'
		WHEN 'I05' THEN 'I05ID' END)

		SET @GroupField2 = ( 
		SELECT CASE @GroupID2
		WHEN 'CI1' THEN 'S1'
		WHEN 'CI2' THEN 'S2'
		WHEN 'CI3' THEN 'S3'
		WHEN 'I01' THEN 'I01ID'
		WHEN 'I02' THEN 'I02ID'
		WHEN 'I03' THEN 'I03ID'
		WHEN 'I04' THEN 'I04ID'
		WHEN 'I05' THEN 'I05ID' END)

		SET @GroupField1 = ISNULL(@GroupField1, '')
		SET @GroupField2 = ISNULL(@GroupField2, '')

		SET @sSQLFrom1 = ' 
		LEFT JOIN (	SELECT	A.InventoryID, SUM(A.MinQuantity) AS MinQuantity, SUM(A.MaxQuantity) AS MaxQuantity, A.DivisionID
					FROM	AT1314 A  WITH (NOLOCK)
           			WHERE	A.WareHouseID = '''+@WareHouseID+''' OR A.WareHouseID = ''%''
           			GROUP BY A.InventoryID, A.DivisionID, A.WareHouseID ) AT1314
			ON		AT1314.InventoryID = AV2098.InventoryID
		--LEFT JOIN AT1303 ON AT1303.DivisionID in (''' + @DivisionID + ''',''@@@'') AND AV2098.WareHouseID = AT1303.WareHouseID'

		IF ((@IsGroupID >= 2) AND (@GroupField1 <> '') AND (@GroupField2 <> ''))
			BEGIN
			SET @IsGroupID = 2
			SET @sSQLSelect = 'SELECT V1.ID AS GroupID1, V1.SName GroupName1, V2.ID AS GroupID2, V2.SName GroupName2, '
			SET @sSQLFrom = '
			'+CASE WHEN ISNULL(@IsSearchStandard,0) = 1 THEN N'INTO #AP2008_QC_Report' ELSE '' END+'
			FROM		##AV2098'+ltrim(@@SPID)+' AS AV2098 
			LEFT JOIN	AV1310 V1 ON V1.ID = AV2098.' + @GroupField1 + ' AND V1.TypeID =''' + @GroupID1 + ''' 
			LEFT JOIN	AV1310 V2 ON V2.ID = AV2098.' + @GroupField2 + ' AND V2.TypeID =''' + @GroupID2 + '''
			'
			END
			ELSE IF ((@IsGroupID >= 1) AND ((@GroupField1 <> '') OR (@GroupField2 <> '')))
			BEGIN 
			SET @sSQLSelect = ' SELECT V1.ID AS GroupID1, V1.SName GroupName1, '''' AS GroupID2, '''' GroupName2, '
			SET @sSQLFrom = '
			'+CASE WHEN ISNULL(@IsSearchStandard,0) = 1 THEN N'INTO #AP2008_QC_Report' ELSE '' END+'
			FROM		##AV2098'+ltrim(@@SPID)+' AS AV2098 
			LEFT JOIN	AV1310 V1 ON V1.ID = AV2098.' + @GroupField1 + ' AND V1.TypeID =''' + @GroupID1 + ''' 
			'
			END
		ELSE
			BEGIN
			SET @sSQLSelect = ' SELECT '''' AS GroupID1, '''' AS GroupName1, '''' AS GroupID2, '''' AS GroupName2, '
			SET @sSQLFrom = '
			'+CASE WHEN ISNULL(@IsSearchStandard,0) = 1 THEN N'INTO #AP2008_QC_Report' ELSE '' END+'
			FROM		##AV2098'+ltrim(@@SPID)+' AS AV2098
			'
			END

			SET @sSQLSelect = @sSQLSelect + '
	AV2098.S1, AV2098.S2, AV2098.S3, AV2098.I01ID, AV2098.I02ID, AV2098.I03ID, AV2098.I04ID, AV2098.I05ID, 
	AV2098.Notes01, AV2098.Notes02, AV2098.Notes03 ,AV2098.SalePrice01, AV2098.InventoryID, AV2098.InventoryName,
	AV2098.InventoryTypeID,AV2098.InventoryTypeName, AV2098.Specification, AV2098.UnitID, AV2098.UnitName, AV2098.InventoryAccountID,
	--AV2098.ConversionUnitID, AV2098.ConversionFactor, AV2098.Operator,
	--CASE WHEN (AV2098.ConversionFactor = NULL OR AV2098.ConversionFactor = 0) 
	--THEN NULL ELSE ISNULL(AV2098.EndQuantity, 0) / AV2098.ConversionFactor END AS ConversionQuantity,
	AV2098.BeginQuantity, AV2098.DebitQuantity, AV2098.CreditQuantity, AV2098.EndQuantity, AV2098.BeginAmount, 
	AV2098.DebitAmount, AV2098.CreditAmount, AV2098.EndAmount, AV2098.InDebitAmount, AV2098.InCreditAmount, 
	AV2098.InDebitQuantity, AV2098.InCreditQuantity, AV2098.DivisionID, AT1314.MinQuantity, AT1314.MaxQuantity,
	AV2098.WarehouseID, AV2098.WarehouseName,
	CASE WHEN (SELECT SUM(ActualQuantity) FROM AT2007 WITH (NOLOCK) WHERE InventoryID = AV2098.InventoryID 
				AND TranMonth + TranYear * 100 >= '+STR(@3MonthPrevious + @YearPrevious * 100)+'
				AND TranMonth + TranYear * 100 < '+STR(@ToMonth + @ToYear * 100)+' ) = 0 THEN 0
	ELSE AV2098.EndQuantity/ ((SELECT SUM(ActualQuantity) FROM AT2007 WHERE InventoryID = AV2098.InventoryID 
				AND TranMonth + TranYear * 100 >= '+STR(@3MonthPrevious + @YearPrevious * 100)+'
				AND TranMonth + TranYear * 100 < '+STR(@ToMonth + @ToYear * 100)+' )/3) END TimeOfUse , AV2098.Barcode,
	AV2098.S01ID, AV2098.S02ID, AV2098.S03ID, AV2098.S04ID, AV2098.S05ID, 
	AV2098.S06ID, AV2098.S07ID, AV2098.S08ID, AV2098.S09ID, AV2098.S10ID, 
	AV2098.S11ID, AV2098.S12ID, AV2098.S13ID, AV2098.S14ID, AV2098.S15ID, 
	AV2098.S16ID, AV2098.S17ID, AV2098.S18ID, AV2098.S19ID, AV2098.S20ID,
	A01.StandardName AS StandardName01, A02.StandardName AS StandardName02, A03.StandardName AS StandardName03, A04.StandardName AS StandardName04, 
	A05.StandardName AS StandardName05, A06.StandardName AS StandardName06, A07.StandardName AS StandardName07, A08.StandardName AS StandardName08, 
	A09.StandardName AS StandardName09, A10.StandardName AS StandardName10, A11.StandardName AS StandardName11, A12.StandardName AS StandardName12,
	A13.StandardName AS StandardName13, A14.StandardName AS StandardName14, A15.StandardName AS StandardName15, A16.StandardName AS StandardName16,
	A17.StandardName AS StandardName17, A18.StandardName AS StandardName18, A19.StandardName AS StandardName19, A20.StandardName AS StandardName20,
	a.S01, a.S02, a.S03, a.S04, a.S05, a.S06, a.S07, a.S08, a.S09, a.S10,
	a.S11, a.S12, a.S13, a.S14, a.S15, a.S16, a.S17, a.S18, a.S19, a.S20,'
	SET @sSQLSelect1='
	AV2098.InventoryID + CASE WHEN ISNULL(AV2098.S01ID,'''')<>'''' THEN ''.''+AV2098.S01ID ELSE '''' END+
	CASE WHEN ISNULL(AV2098.S02ID,'''')<>'''' THEN ''.''+AV2098.S02ID ELSE '''' END+
	CASE WHEN ISNULL(AV2098.S03ID,'''')<>'''' THEN ''.''+AV2098.S03ID ELSE '''' END+
	CASE WHEN ISNULL(AV2098.S04ID,'''')<>'''' THEN ''.''+AV2098.S04ID ELSE '''' END+
	CASE WHEN ISNULL(AV2098.S05ID,'''')<>'''' THEN ''.''+AV2098.S05ID ELSE '''' END+
	CASE WHEN ISNULL(AV2098.S06ID,'''')<>'''' THEN ''.''+AV2098.S06ID ELSE '''' END+
	CASE WHEN ISNULL(AV2098.S07ID,'''')<>'''' THEN ''.''+AV2098.S07ID ELSE '''' END+
	CASE WHEN ISNULL(AV2098.S08ID,'''')<>'''' THEN ''.''+AV2098.S08ID ELSE '''' END+
	CASE WHEN ISNULL(AV2098.S09ID,'''')<>'''' THEN ''.''+AV2098.S09ID ELSE '''' END+
	CASE WHEN ISNULL(AV2098.S10ID,'''')<>'''' THEN ''.''+AV2098.S10ID ELSE '''' END+
	CASE WHEN ISNULL(AV2098.S11ID,'''')<>'''' THEN ''.''+AV2098.S11ID ELSE '''' END+
	CASE WHEN ISNULL(AV2098.S12ID,'''')<>'''' THEN ''.''+AV2098.S12ID ELSE '''' END+
	CASE WHEN ISNULL(AV2098.S13ID,'''')<>'''' THEN ''.''+AV2098.S13ID ELSE '''' END+
	CASE WHEN ISNULL(AV2098.S14ID,'''')<>'''' THEN ''.''+AV2098.S14ID ELSE '''' END+
	CASE WHEN ISNULL(AV2098.S15ID,'''')<>'''' THEN ''.''+AV2098.S15ID ELSE '''' END+
	CASE WHEN ISNULL(AV2098.S16ID,'''')<>'''' THEN ''.''+AV2098.S16ID ELSE '''' END+
	CASE WHEN ISNULL(AV2098.S17ID,'''')<>'''' THEN ''.''+AV2098.S17ID ELSE '''' END+
	CASE WHEN ISNULL(AV2098.S18ID,'''')<>'''' THEN ''.''+AV2098.S18ID ELSE '''' END+
	CASE WHEN ISNULL(AV2098.S19ID,'''')<>'''' THEN ''.''+AV2098.S19ID ELSE '''' END+
	CASE WHEN ISNULL(AV2098.S20ID,'''')<>'''' THEN ''.''+AV2098.S20ID ELSE '''' END As InventoryID_QC,
	N'''+@GroupID+''' as GroupID, AT1401.GroupName '
SET @sSQLFrom = @sSQLFrom + ' 
	LEFT JOIN (SELECT * FROM  (SELECT UserName, TypeID, DivisionID
		                   FROM AT0005 WITH (NOLOCK) WHERE TypeID LIKE ''S__'') b PIVOT (max(Username) for TypeID IN (S01, S02, S03, S04, S05, S06, S07, S08, S09, S10,
																										S11, S12, S13, S14, S15, S16, S17, S18, S19, S20))  AS a) a ON a.DivisionID = AV2098.DivisionID
	LEFT JOIN AT0128 A01 WITH (NOLOCK) ON AV2098.S01ID = A01.StandardID AND A01.StandardTypeID = ''S01''
	LEFT JOIN AT0128 A02 WITH (NOLOCK) ON AV2098.S02ID = A02.StandardID AND A02.StandardTypeID = ''S02''
	LEFT JOIN AT0128 A03 WITH (NOLOCK) ON AV2098.S03ID = A03.StandardID AND A03.StandardTypeID = ''S03''
	LEFT JOIN AT0128 A04 WITH (NOLOCK) ON AV2098.S04ID = A04.StandardID AND A04.StandardTypeID = ''S04''
	LEFT JOIN AT0128 A05 WITH (NOLOCK) ON AV2098.S05ID = A05.StandardID AND A05.StandardTypeID = ''S05''
	LEFT JOIN AT0128 A06 WITH (NOLOCK) ON AV2098.S06ID = A06.StandardID AND A06.StandardTypeID = ''S06''
	LEFT JOIN AT0128 A07 WITH (NOLOCK) ON AV2098.S07ID = A07.StandardID AND A07.StandardTypeID = ''S07''
	LEFT JOIN AT0128 A08 WITH (NOLOCK) ON AV2098.S08ID = A08.StandardID AND A08.StandardTypeID = ''S08''
	LEFT JOIN AT0128 A09 WITH (NOLOCK) ON AV2098.S09ID = A09.StandardID AND A09.StandardTypeID = ''S09''
	LEFT JOIN AT0128 A10 WITH (NOLOCK) ON AV2098.S10ID = A10.StandardID AND A10.StandardTypeID = ''S10''
	LEFT JOIN AT0128 A11 WITH (NOLOCK) ON AV2098.S11ID = A11.StandardID AND A11.StandardTypeID = ''S11''
	LEFT JOIN AT0128 A12 WITH (NOLOCK) ON AV2098.S12ID = A12.StandardID AND A12.StandardTypeID = ''S12''
	LEFT JOIN AT0128 A13 WITH (NOLOCK) ON AV2098.S13ID = A13.StandardID AND A13.StandardTypeID = ''S13''
	LEFT JOIN AT0128 A14 WITH (NOLOCK) ON AV2098.S14ID = A14.StandardID AND A14.StandardTypeID = ''S14''
	LEFT JOIN AT0128 A15 WITH (NOLOCK) ON AV2098.S15ID = A15.StandardID AND A15.StandardTypeID = ''S15''
	LEFT JOIN AT0128 A16 WITH (NOLOCK) ON AV2098.S16ID = A16.StandardID AND A16.StandardTypeID = ''S16''
	LEFT JOIN AT0128 A17 WITH (NOLOCK) ON AV2098.S17ID = A17.StandardID AND A17.StandardTypeID = ''S17''
	LEFT JOIN AT0128 A18 WITH (NOLOCK) ON AV2098.S18ID = A18.StandardID AND A18.StandardTypeID = ''S18''
	LEFT JOIN AT0128 A19 WITH (NOLOCK) ON AV2098.S19ID = A19.StandardID AND A19.StandardTypeID = ''S19''
	LEFT JOIN AT0128 A20 WITH (NOLOCK) ON AV2098.S20ID = A20.StandardID AND A20.StandardTypeID = ''S20''
	LEFT JOIN AT1401 WITH (NOLOCK) on AT1401.GroupID = N''' +@GroupID+ '''		
	'
SET @sSQLFrom1 = @sSQLFrom1 + '
	WHERE (BeginQuantity <> 0 OR BeginAmount <> 0 
		OR DebitQuantity <> 0 OR DebitAmount <> 0 
		OR CreditQuantity <> 0 OR CreditAmount <> 0 
		OR EndQuantity <> 0 OR EndAmount <> 0)
		AND AV2098.DivisionID =''' + @DivisionID + '''
		'
IF ISNULL(@IsSearchStandard,0) = 1
BEGIN
	SET @sSQL = N'
	SELECT * 
	FROM
	(
		SELECT T1.*
		FROM #AP2008_QC_Report AS T1
		INNER JOIN #StandardList_AP2008_QC T2 ON T1.InventoryID = T2.InventoryID
		WHERE 
		(	T2.StandardTypeID = ''S01'' AND ISNULL(T1.S01ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S02'' AND ISNULL(T1.S02ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S03'' AND ISNULL(T1.S03ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S04'' AND ISNULL(T1.S04ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S05'' AND ISNULL(T1.S05ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S06'' AND ISNULL(T1.S06ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S07'' AND ISNULL(T1.S07ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S08'' AND ISNULL(T1.S08ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S09'' AND ISNULL(T1.S09ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S10'' AND ISNULL(T1.S10ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S11'' AND ISNULL(T1.S11ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S12'' AND ISNULL(T1.S12ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S13'' AND ISNULL(T1.S13ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S14'' AND ISNULL(T1.S14ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S15'' AND ISNULL(T1.S15ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S16'' AND ISNULL(T1.S16ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S17'' AND ISNULL(T1.S17ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S18'' AND ISNULL(T1.S18ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S19'' AND ISNULL(T1.S19ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S20'' AND ISNULL(T1.S20ID,'''') = T2.StandardID)
		UNION ALL
		SELECT  T1.*
		FROM #AP2008_QC_Report AS T1
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #StandardList_AP2008_QC T2 WHERE T1.InventoryID = T2.InventoryID)
		AND ISNULL(T1.S01ID,'''') = '''' AND ISNULL(T1.S02ID,'''') = '''' AND ISNULL(T1.S03ID,'''') = ''''
		AND ISNULL(T1.S04ID,'''') = '''' AND ISNULL(T1.S05ID,'''') = '''' AND ISNULL(T1.S06ID,'''') = '''' 
		AND ISNULL(T1.S07ID,'''') = '''' AND ISNULL(T1.S08ID,'''') = '''' AND ISNULL(T1.S09ID,'''') = '''' 
		AND ISNULL(T1.S10ID,'''') = '''' AND ISNULL(T1.S11ID,'''') = '''' AND ISNULL(T1.S12ID,'''') = '''' 
		AND ISNULL(T1.S13ID,'''') = '''' AND ISNULL(T1.S14ID,'''') = '''' AND ISNULL(T1.S15ID,'''') = '''' 
		AND ISNULL(T1.S16ID,'''') = '''' AND ISNULL(T1.S17ID,'''') = '''' AND ISNULL(T1.S18ID,'''') = '''' 
		AND ISNULL(T1.S19ID,'''') = '''' AND ISNULL(T1.S20ID,'''') = '''' 
	)Temp'
END
		
		EXEC(@sSQLSelect + @sSQLSelect1 + @sSQLFrom + @sSQLFrom1 + @sSQL)		
	--print @sSQLSelect 
	--print @sSQLSelect1
	--print  @sSQLFrom
	--print  @sSQLFrom1
	--print  @sSQL


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
