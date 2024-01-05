IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BP3021]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BP3021]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---- Purpose: Bao cao ton kho theo kho cho tung kho - Được chỉnh sửa từ store AP2008
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Tấn Lộc, Date 20/06/2021.

/*
    EXEC AP2008 'KHV', 1, 2016, 1,2016, '01/01/2016', '01/10/2016', 'CRA00710', 'G80A4550', 'HGK', 1, 0, '', ''
*/

CREATE PROCEDURE BP3021
(
    @DivisionID NVARCHAR(50), 
    @FromMonth INT, 
    @ToMonth INT, 
    @FromYear INT, 
    @ToYear INT, 
    @FromDate DATETIME, 
    @ToDate DATETIME, 
    @ListInventoryID AS VARCHAR(MAX),
    @ListWareHouseID NVARCHAR(MAX), 
    @IsDate TINYINT,
	--@IsGroupID TINYINT, --- 0 Khong nhom; 1 Nhom 1 cap; 2 Nhom 2 cap
    --@IsGroupID TINYINT, --- 0 Khong nhom; 1 Nhom 1 cap; 2 Nhom 2 cap
    @GroupID1 NVARCHAR(50), 
    --@GroupID2 NVARCHAR(50),--- Note : GroupID nhan cac gia tri S1, S2, S3, CI1, CI2, CI3
	@IsSearchStandard TINYINT,
	@StandardList XML,
	@UserID VARCHAR(50)
)
AS

--IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
--	EXEC AP2008_QC @DivisionID, @FromMonth, @ToMonth, @FromYear, @ToYear, @FromDate, @ToDate, @FromInventoryID, @ToInventoryID, @WareHouseID, @IsDate, @IsGroupID, @GroupID1, @GroupID2,@IsSearchStandard,@StandardList, @UserID
--ELSE
BEGIN 
DECLARE @CustomerName INT
--Tao bang tam de kiem tra day co phai la khach hang 2T khong (CustomerName = 15)
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)


BEGIN
		DECLARE
			@sSQLDrop AS VARCHAR(MAX),
			@sSQLSelect AS VARCHAR(MAX), 
			@sSQLFrom AS VARCHAR(MAX), 
			@sSQLFrom1 AS VARCHAR(MAX), 
			@sSQLWhere AS VARCHAR(MAX),
			@sSQLUnion AS VARCHAR(MAX), 
			@sSQLUnion1 AS VARCHAR(MAX),
			@sSQLUpdate AS VARCHAR(MAX) ='',
			@GroupField1 AS VARCHAR(50), 
			@GroupField2 AS VARCHAR(50), 
			@FromMonthYearText VARCHAR(20), 
			@ToMonthYearText VARCHAR(20), 
			@FromDateText VARCHAR(20), 
			@ToDateText VARCHAR(20),
			@WhereTime AS VARCHAR(4000),
			@3MonthPrevious INT,
			@YearPrevious INT,
			@GroupID VARCHAR(50),
			@sGroupByChild nvarchar(MAX),
			@curListInventoryID AS VARCHAR(MAX),
			@curListWareHouseID NVARCHAR(MAX),
			@curListWareHouseID1 NVARCHAR(MAX), -- do có nhìu chỗ AS khác nhau nên sử dụng nhìu biến curListWareHouseID1
			@curListInventoryID1 AS VARCHAR(MAX),
			@curListInventoryID2 AS VARCHAR(MAX),
			@curListWareHouseID2 NVARCHAR(MAX)
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
		SET @curListWareHouseID = 'ANd 1=1'
		SET @curListInventoryID = 'AND 1=1'

		SET @curListWareHouseID1 = 'ANd 1=1'
		SET @curListInventoryID1 = 'AND 1=1'

		SET @curListWareHouseID2 = '1=1'
		SET @curListInventoryID2 = 'AND 1=1'

		SET @FromMonthYearText = STR(@FromMonth + @FromYear * 100)
		SET @ToMonthYearText = STR(@ToMonth + @ToYear * 100)
		SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
		SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'
		SET @GroupID= (SELECT TOP 1 AT1402.GroupID FROM AT1402 WITH(NOLOCK) WHERE AT1402.UserID = @UserID)

		IF ISNULL(@ListWareHouseID, '') != ''
			SET @curListWareHouseID = 'AND AT2008.WareHouseID IN (''' + @ListWareHouseID + ''')'

		IF ISNULL(@ListInventoryID, '') != ''
			SET @curListInventoryID = 'AND AT2008.InventoryID IN (''' + @ListInventoryID + ''')'

		IF ISNULL(@ListWareHouseID, '') != ''
				SET @curListWareHouseID1 = 'AND AV7000.WareHouseID IN ('''+ISNULL(@ListWareHouseID, '')+''')'

		IF ISNULL(@ListInventoryID, '') != ''
				SET @curListInventoryID1 = 'AND AV7000.InventoryID IN ('''+ISNULL(@ListInventoryID, '')+''')'

		IF ISNULL(@ListWareHouseID, '') != ''
				SET @curListWareHouseID2 = 'A.WareHouseID IN ( '''+@ListWareHouseID+''')'
		

		--- Xóa các bảng tạm nếu đã tồn tại
		 SET @sSQLDrop = @sSQLDrop +'
		IF EXISTS (SELECT TOP 1 1 FROM tempdb.dbo.sysobjects WITH (NOLOCK) WHERE ID = OBJECT_ID(N''tempdb.dbo.##AV7018'+ltrim(@@SPID)+''')) 
			DROP TABLE ##AV7018'+ltrim(@@SPID)+'

		IF EXISTS (SELECT TOP 1 1 FROM tempdb.dbo.sysobjects WITH (NOLOCK) WHERE ID = OBJECT_ID(N''tempdb.dbo.##AV2088'+ltrim(@@SPID)+''')) 
			DROP TABLE ##AV2088'+ltrim(@@SPID)+'

		IF EXISTS (SELECT TOP 1 1 FROM tempdb.dbo.sysobjects WITH (NOLOCK) WHERE ID = OBJECT_ID(N''tempdb.dbo.##AV2098'+ltrim(@@SPID)+''')) 
			DROP TABLE ##AV2098'+ltrim(@@SPID)+''

		
		IF @IsDate = 0 --Xac dinh so du theo ky
		BEGIN
			IF @ToMonth > 3	BEGIN SET @3MonthPrevious = @ToMonth - 3 SET @YearPrevious = @ToYear END
			ELSE BEGIN SET @3MonthPrevious = 9 + @ToMonth SET @YearPrevious = @ToYear - 1 END

			SET @WhereTime = ' AV7000.TranMonth + AV7000.TranYear*100 BETWEEN ' + @FromMonthYearText + ' AND ' + @ToMonthYearText
			SET @sSQLSelect = '
				SELECT AT1302.S1, AT1302.S2, AT1302.S3, AT1302.I01ID, AT1302.I02ID, AT1302.I03ID, AT1302.I04ID, AT1302.I05ID,
				Max(Isnull(AT1302.Notes01,'''')) as Notes01, Max(isnull(AT1302.Notes02,'''')) as Notes02, Max(isnull(AT1302.Notes03,'''')) as Notes03,
					AT1302.SalePrice01, AT2008.InventoryID, AT1302.InventoryName,
				AT1302.InventoryTypeID, AT1302.Specification, AT1302.UnitID, AT1304.UnitName,
				SUM(CASE WHEN TranMonth + TranYear * 100 = ' + @FromMonthYearText + ' THEN ISNULL(BeginQuantity, 0) ELSE 0 END) AS BeginQuantity, 
				SUM(ISNULL(DebitQuantity, 0)) AS DebitQuantity, SUM(ISNULL(CreditQuantity, 0)) AS CreditQuantity, 
				SUM(CASE WHEN TranMonth + TranYear * 100 = ' + @ToMonthYearText + ' THEN ISNULL(EndQuantity, 0) ELSE 0 END) AS EndQuantity, 
				SUM(CASE WHEN TranMonth + TranYear * 100 = ' + @FromMonthYearText + ' THEN ISNULL(BeginAmount, 0) ELSE 0 END) AS BeginAmount, 
				SUM(ISNULL(DebitAmount, 0)) AS DebitAmount, SUM(ISNULL(CreditAmount, 0)) AS CreditAmount, 
				SUM(CASE WHEN TranMonth + TranYear * 100 = ' + @ToMonthYearText + ' THEN ISNULL(EndAmount, 0) ELSE 0 END) AS EndAmount,
				SUM(ISNULL(InDebitQuantity, 0)) AS InDebitQuantity, SUM(ISNULL(InCreditQuantity, 0)) AS InCreditQuantity,
				SUM(ISNULL(InDebitAmount, 0)) AS InDebitAmount, SUM(ISNULL(InCreditAmount, 0)) AS InCreditAmount, 
				AT2008.WareHouseID, AT2008.DivisionID, AT1302.Barcode, AT1303.WarehouseName,
				AT1302.Varchar01, AT1302.ETaxConvertedUnit' 
			SET @sSQLFrom = ' INTO ##AV7018'+ltrim(@@SPID)+'
				FROM AT2008  WITH (NOLOCK)
				INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2008.DivisionID,''@@@'') AND AT1302.InventoryID = AT2008.InventoryID
				LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.DivisionID IN (AT2008.DivisionID,''@@@'') AND AT1304.UnitID = AT1302.UnitID
				--LEFT JOIN AT1309 WITH (NOLOCK) ON AT1302.DivisionID IN (AT1309.DivisionID,''@@@'') AND AT1309.InventoryID = AT1302.InventoryID
				LEFT JOIN AT1303 WITH (NOLOCK) ON AT1303.WareHouseID = AT2008.WareHouseID' 
			SET @sSQLWhere = ' 
				WHERE AT2008.DivisionID = ''' + ISNULL(@DivisionID, '''') +'''
				'+ISNULL(@curListWareHouseID, '''')
				+ISNULL(@curListInventoryID, '''')+'
				AND AT2008.TranMonth + 100 * AT2008.TranYear BETWEEN ' + @FromMonthYearText + ' AND ' + @ToMonthYearText + '
				GROUP BY 
				AT2008.DivisionID, AT2008.InventoryID, InventoryName, AT2008.WareHouseID, AT1302.UnitID, 
				--AT1309.UnitID, AT1309.ConversionFactor, AT1309.Operator, 
				AT1304.UnitName, AT1302.S1, AT1302.S2, AT1302.S3, 
				AT1302.I01ID, AT1302.I02ID, AT1302.I03ID, AT1302.I04ID, AT1302.I05ID, AT1302. InventoryTypeID, AT1302.Specification, 
				--AT1302.Notes01, AT1302.Notes02, AT1302.Notes03,
				AT1302.SalePrice01, AT1302.Barcode, AT1303.WarehouseName,
				AT1302.Varchar01, AT1302.ETaxConvertedUnit'
		END
		ELSE --Xac dinh so du theo ngay
		BEGIN
			IF Month(@ToDate) > 3 BEGIN SET @3MonthPrevious = Month(@ToDate) - 3  SET @YearPrevious = YEAR(@ToDate) END
			ELSE BEGIN SET @3MonthPrevious = 9 + Month(@ToDate) SET @YearPrevious = Month(@ToDate) - 1 END

			SET @WhereTime = ' AV7000.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''''
			SET @sSQLSelect = ' 
				SELECT AV7000.S1, AV7000.S2, AV7000.S3, AV7000.I01ID, AV7000.I02ID, AV7000.I03ID, AV7000.I04ID, AV7000.I05ID, 
				Max(isnull(AV7000.Notes01,'''')) as Notes01 , Max(Isnull(AV7000.Notes02,'''')) as Notes02, Max(Isnull(AV7000.Notes03,'''')) as Notes03,
				AV7000.SalePrice01, AV7000.InventoryID, AV7000.InventoryName,
				AV7000.InventoryTypeID, AV7000.Specification, AV7000.UnitID, AV7000.UnitName, SUM(SignQuantity) AS BeginQuantity, 
				0 AS DebitQuantity, 0 AS CreditQuantity, 0 AS DebitAmount, SUM(SignAmount) AS BeginAmount, 0 AS CreditAmount, 
				0 AS EndQuantity, 0 AS EndAmount, 0 AS InDebitQuantity, 0 AS InCreditQuantity, 0 AS InDebitAmount, 
				0 AS InCreditAmount, AV7000.WareHouseID, AV7000.DivisionID, AV7000.Barcode, AV7000.WarehouseName,
				AV7000.Varchar01, AV7000.ETaxConvertedUnit'
			SET @sSQLFrom = N' INTO ##AV7018'+ltrim(@@SPID)+'
				FROM ( -- Số dư nợ
					SELECT D17.TranMonth, D17.TranYear, D02.S1, D02.S2, D02.S3, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, 
					D02.Notes01 , D02.Notes02, D02.Notes03,
					D02.SalePrice01, D17.InventoryID, D02.InventoryName,
					D02.InventoryTypeID, D02.Specification, D02.UnitID, D04.UnitName, 
					D17.ActualQuantity AS SignQuantity, D17.ConvertedAmount AS SignAmount,
					D16.WareHouseID, D17.DivisionID, D02.Barcode, D03.WarehouseName,
					D02.Varchar01, D02.ETaxConvertedUnit, D16.VoucherDate, ''BD'' AS D_C
					From AT2017 AS D17 WITH (NOLOCK)
					INNER JOIN AT2016 AS D16 WITH (NOLOCK) ON D16.VoucherID = D17.VoucherID AND D16.DivisionID = D17.DivisionID
					INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D17.DivisionID,''@@@'') AND D02.InventoryID = D17.InventoryID
					LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.DivisionID IN (D17.DivisionID,''@@@'') AND D04.UnitID = D02.UnitID
					INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.WareHouseID = D16.WareHouseID
					Where isnull(D17.DebitAccountID,'''') <>''''
					UNION ALL -- Số dư có
					SELECT D17.TranMonth, D17.TranYear, D02.S1, D02.S2, D02.S3, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, 
					D02.Notes01 , D02.Notes02, D02.Notes03,
					D02.SalePrice01, D17.InventoryID, D02.InventoryName,
					D02.InventoryTypeID, D02.Specification, D02.UnitID, D04.UnitName, 
					-D17.ActualQuantity AS SignQuantity, -D17.ConvertedAmount AS SignAmount,
					D16.WareHouseID, D17.DivisionID, D02.Barcode, D03.WarehouseName,
					D02.Varchar01, D02.ETaxConvertedUnit, D16.VoucherDate, ''BC'' AS D_C
					From AT2017 AS D17 WITH (NOLOCK)
					INNER JOIN AT2016 AS D16 WITH (NOLOCK) ON D16.VoucherID = D17.VoucherID AND D16.DivisionID = D17.DivisionID
					INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D17.DivisionID,''@@@'') AND D02.InventoryID = D17.InventoryID
					LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.DivisionID IN (D17.DivisionID,''@@@'') AND D04.UnitID = D02.UnitID
					INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.WareHouseID = D16.WareHouseID
					Where isnull(D17.CreditAccountID,'''') <>''''
				'
			SET @sSQLFrom1='	
					UNION ALL -- Nhập kho
					SELECT D07.TranMonth, D07.TranYear, D02.S1, D02.S2, D02.S3, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, 
					D02.Notes01 , D02.Notes02, D02.Notes03,
					D02.SalePrice01, D07.InventoryID, D02.InventoryName,
					D02.InventoryTypeID, D02.Specification, D02.UnitID, D04.UnitName, 
					D07.ActualQuantity AS SignQuantity, D07.ConvertedAmount AS SignAmount,
					D06.WareHouseID, D07.DivisionID, D02.Barcode, D03.WarehouseName,
					D02.Varchar01, D02.ETaxConvertedUnit, D06.VoucherDate, ''D'' AS D_C
					From AT2007 AS D07 WITH (NOLOCK)
					INNER JOIN AT2006 AS D06 WITH (NOLOCK) ON D06.VoucherID = D07.VoucherID AND D06.DivisionID = D07.DivisionID
					INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D07.DivisionID,''@@@'') AND D02.InventoryID = D07.InventoryID
					LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.DivisionID IN (D07.DivisionID,''@@@'') AND D04.UnitID = D02.UnitID
					INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.WareHouseID = D06.WareHouseID
					WHERE D06.KindVoucherID in (1,3,5,7,9,15,17) AND Isnull(D06.TableID,'''') <> ''AT0114'' ------- Phiếu nhập bù của ANGEL
					UNION ALL -- Xuất kho
					SELECT D07.TranMonth, D07.TranYear, D02.S1, D02.S2, D02.S3, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, 
					D02.Notes01 , D02.Notes02, D02.Notes03,
					D02.SalePrice01, D07.InventoryID, D02.InventoryName,
					D02.InventoryTypeID, D02.Specification, D02.UnitID, D04.UnitName, 
					-D07.ActualQuantity AS SignQuantity, -D07.ConvertedAmount AS SignAmount,
					CASE WHEN D06.KindVoucherID = 3 then D06.WareHouseID2 Else  D06.WareHouseID End AS WareHouseID,
					D07.DivisionID, D02.Barcode, D03.WareHouseName,
					D02.Varchar01, D02.ETaxConvertedUnit, D06.VoucherDate, ''C'' AS D_C
					From AT2007 AS D07 WITH (NOLOCK)
					INNER JOIN AT2006 AS D06 WITH (NOLOCK) ON D06.VoucherID = D07.VoucherID AND D06.DivisionID = D07.DivisionID
					INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D07.DivisionID,''@@@'') AND D02.InventoryID = D07.InventoryID
					LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.DivisionID IN (D07.DivisionID,''@@@'') AND D04.UnitID = D02.UnitID
					INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.WareHouseID = CASE WHEN D06.KindVoucherID = 3 then D06.WareHouseID2 Else  D06.WareHouseID End
					Where D06.KindVoucherID in (2,3,4,6,8,10,14,20)
				) AV7000
			'
			SET @sSQLWhere = '
			WHERE AV7000.DivisionID = ''' + ISNULL(@DivisionID, '''') +'''
			'+ISNULL(@curListWareHouseID1, '''')
			+ISNULL(@curListInventoryID1, '''')+'
			AND (AV7000.VoucherDate < ''' + @FromDateText + ''' OR D_C = ''BD'')
			GROUP BY DivisionID, WareHouseID, InventoryID, InventoryName, UnitID, UnitName, S1, S2, S3, 
			I01ID, I02ID, I03ID, I04ID, I05ID, InventoryTypeID, Specification, 
			--Notes01, Notes02, Notes03,
			SalePrice01, Barcode, WarehouseName, AV7000.Varchar01, AV7000.ETaxConvertedUnit'
		END
		
		--SELECT @sSQLDrop
		--SELECT @sSQLSelect
		--SELECT @sSQLFrom
		--SELECT @sSQLFrom1
		--SELECT @sSQLWhere

		EXEC(@sSQLDrop + @sSQLSelect + @sSQLFrom + @sSQLFrom1 + @sSQLWhere)
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
		--print @sSQLFrom1
		--print  @sSQLWhere
		
 

		SET @sSQLSelect = '
			SELECT AV7018.S1, AV7018.S2, AV7018.S3, AV7018.I01ID, AV7018.I02ID, AV7018.I03ID, AV7018.I04ID, AV7018.I05ID, 
			AV7018.Notes01 , AV7018.Notes02, AV7018.Notes03,
			AV7018.SalePrice01, AV7018.InventoryID, AV7018.InventoryName,
			AV7018.InventoryTypeID, AV7018.Specification, AV7018.UnitID, AV7018.UnitName,
			ISNULL(AV7018.BeginQuantity, 0) AS BeginQuantity, ISNULL(AV7018.BeginAmount, 0) AS BeginAmount, AV7018.DebitQuantity, AV7018.CreditQuantity, 
			AV7018.EndQuantity, AV7018.DebitAmount, AV7018.CreditAmount, 
			AV7018.EndAmount, AV7018.InDebitQuantity, AV7018.InCreditQuantity, AV7018.WareHouseID, AV7018.DivisionID, AV7018.Barcode, AV7018.WarehouseName,
			AV7018.Varchar01, AV7018.ETaxConvertedUnit'
		SET @sSQLFrom = ' INTO ##AV2088'+ltrim(@@SPID)+'
			FROM ##AV7018'+ltrim(@@SPID)+' AV7018'

		IF @IsDate <> 0
			SET @sSQLWhere = ''
		ELSE
			SET @sSQLWhere = ' 
		WHERE AV7018.WareHouseID IN (''' + @ListWareHouseID + ''') AND AV7018.DivisionID = '''+@DivisionID+''' 
		AND AV7018.InventoryID NOT IN 
		(
			SELECT InventoryID FROM AV7000 
			WHERE AV7000.DivisionID ='''+@DivisionID+''' 
			'+ISNULL(@curListWareHouseID1, '''')
			+ISNULL(@curListInventoryID1, '''')+'
			AND AV7000.D_C IN (''D'', ''C'') 
			AND '+@WhereTime+'
		)'

		SET @sSQLUnion = '
			UNION ALL
			SELECT AV7000.S1, AV7000.S2, AV7000.S3, AV7000.I01ID, AV7000.I02ID, AV7000.I03ID, AV7000.I04ID, AV7000.I05ID, 
			Max(Isnull(AV7000.Notes01,'''')) as Notes01, Max(Isnull(AV7000.Notes02,'''')) as Notes02, Max(Isnull(AV7000.Notes03,'''')) as Notes03 ,
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
			AV7000.WareHouseID, AV7000.DivisionID, AV7000.Barcode, AV7000.WarehouseName, AV7000.Varchar01, AV7000.ETaxConvertedUnit
			FROM ( -- Số dư nợ
					SELECT D17.TranMonth, D17.TranYear, D02.S1, D02.S2, D02.S3, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, 
					D02.Notes01 , D02.Notes02, D02.Notes03,
					D02.SalePrice01, D17.InventoryID, D02.InventoryName,
					D02.InventoryTypeID, D02.Specification, D02.UnitID, D04.UnitName, 
					D17.ActualQuantity, D17.ConvertedAmount,
					D16.WareHouseID, D17.DivisionID, D02.Barcode, D03.WarehouseName,
					D02.Varchar01, D02.ETaxConvertedUnit, D16.VoucherDate, ''BD'' AS D_C, 0 AS KindVoucherID
					From AT2017 AS D17 WITH (NOLOCK)
					INNER JOIN AT2016 AS D16 WITH (NOLOCK) ON D16.VoucherID = D17.VoucherID AND D16.DivisionID = D17.DivisionID
					INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D17.DivisionID,''@@@'') AND D02.InventoryID = D17.InventoryID
					LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.DivisionID IN (D17.DivisionID,''@@@'') AND D04.UnitID = D02.UnitID
					INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.WareHouseID = D16.WareHouseID
					Where isnull(D17.DebitAccountID,'''') <>''''
					UNION ALL -- Số dư có
					SELECT D17.TranMonth, D17.TranYear, D02.S1, D02.S2, D02.S3, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, 
					D02.Notes01 , D02.Notes02, D02.Notes03,
					D02.SalePrice01, D17.InventoryID, D02.InventoryName,
					D02.InventoryTypeID, D02.Specification, D02.UnitID, D04.UnitName, 
					-D17.ActualQuantity AS ActualQuantity, -D17.ConvertedAmount AS ConvertedAmount,
					D16.WareHouseID, D17.DivisionID, D02.Barcode, D03.WarehouseName,
					D02.Varchar01, D02.ETaxConvertedUnit, D16.VoucherDate, ''BC'' AS D_C, 0 AS KindVoucherID
					From AT2017 AS D17 WITH (NOLOCK)
					INNER JOIN AT2016 AS D16 WITH (NOLOCK) ON D16.VoucherID = D17.VoucherID AND D16.DivisionID = D17.DivisionID
					INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D17.DivisionID,''@@@'') AND D02.InventoryID = D17.InventoryID
					LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.DivisionID IN (D17.DivisionID,''@@@'') AND D04.UnitID = D02.UnitID
					INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.WareHouseID = D16.WareHouseID
					Where isnull(D17.CreditAccountID,'''') <>''''
			'
		SET @sSQLUnion1='
					UNION ALL -- Nhập kho
					SELECT D07.TranMonth, D07.TranYear, D02.S1, D02.S2, D02.S3, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, 
					D02.Notes01 , D02.Notes02, D02.Notes03,
					D02.SalePrice01, D07.InventoryID, D02.InventoryName,
					D02.InventoryTypeID, D02.Specification, D02.UnitID, D04.UnitName, 
					D07.ActualQuantity, D07.ConvertedAmount,
					D06.WareHouseID, D07.DivisionID, D02.Barcode, D03.WarehouseName,
					D02.Varchar01, D02.ETaxConvertedUnit, D06.VoucherDate, ''D'' AS D_C, CASE WHEN D06.KindVoucherID = 3 then 3 else 0 end AS KindVoucherID
					From AT2007 AS D07 WITH (NOLOCK)
					INNER JOIN AT2006 AS D06 WITH (NOLOCK) ON D06.VoucherID = D07.VoucherID AND D06.DivisionID = D07.DivisionID
					INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D07.DivisionID,''@@@'') AND D02.InventoryID = D07.InventoryID
					LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.DivisionID IN (D07.DivisionID,''@@@'') AND D04.UnitID = D02.UnitID
					INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.WareHouseID = D06.WareHouseID
					WHERE D06.KindVoucherID in (1,3,5,7,9,15,17) AND Isnull(D06.TableID,'''') <> ''AT0114'' ------- Phiếu nhập bù của ANGEL
					UNION ALL -- Xuất kho
					SELECT D07.TranMonth, D07.TranYear, D02.S1, D02.S2, D02.S3, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, 
					D02.Notes01 , D02.Notes02, D02.Notes03,
					D02.SalePrice01, D07.InventoryID, D02.InventoryName,
					D02.InventoryTypeID, D02.Specification, D02.UnitID, D04.UnitName, 
					D07.ActualQuantity AS ActualQuantity, D07.ConvertedAmount AS ConvertedAmount,
					CASE WHEN D06.KindVoucherID = 3 then D06.WareHouseID2 Else  D06.WareHouseID End AS WareHouseID,
					D07.DivisionID, D02.Barcode, D03.WareHouseName,
					D02.Varchar01, D02.ETaxConvertedUnit, D06.VoucherDate, ''C'' AS D_C, CASE WHEN D06.KindVoucherID = 3 then 3 else 0 end AS KindVoucherID
					From AT2007 AS D07 WITH (NOLOCK)
					INNER JOIN AT2006 AS D06 WITH (NOLOCK) ON D06.VoucherID = D07.VoucherID AND D06.DivisionID = D07.DivisionID
					INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D07.DivisionID,''@@@'') AND D02.InventoryID = D07.InventoryID
					LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.DivisionID IN (D07.DivisionID,''@@@'') AND D04.UnitID = D02.UnitID
					INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.WareHouseID = CASE WHEN D06.KindVoucherID = 3 then D06.WareHouseID2 Else  D06.WareHouseID End
					Where D06.KindVoucherID in (2,3,4,6,8,10,14,20)		
			)AV7000'
		IF @IsDate = 0
			SET @sSQLUnion1 = @sSQLUnion1 + '	LEFT JOIN ##AV7018'+ltrim(@@SPID)+' AV7018 ON AV7018.DivisionID = AV7000.DivisionID AND AV7000.WareHouseID = AV7018.WareHouseID AND AV7000.InventoryID = AV7018.InventoryID'

		SET @sSQLUnion1 = @sSQLUnion1 + '
			WHERE AV7000.DivisionID ='''+@DivisionID+''' 
			'+ISNULL(@curListWareHouseID1, '''')
			+ISNULL(@curListInventoryID1, '''')+'
			AND AV7000.D_C IN (''D'', ''C'') 
			AND '+@WhereTime+'
			GROUP BY 
			AV7000.S1, AV7000.S2, AV7000.S3, AV7000.I01ID, AV7000.I02ID, AV7000.I03ID, AV7000.I04ID, AV7000.I05ID, 
			--AV7000.Notes01, AV7000.Notes02, AV7000.Notes03 ,
			AV7000.SalePrice01, AV7000.InventoryID, AV7000.InventoryName,
			AV7000.InventoryTypeID, AV7000.Specification, AV7000.UnitID, AV7000.UnitName,'

		IF @IsDate = 0
			SET @sSQLUnion1 = @sSQLUnion1 + 'AV7018.BeginQuantity, AV7018.BeginAmount,'

		SET @sSQLUnion1 = @sSQLUnion1 + 'AV7000.WareHouseID, AV7000.DivisionID, AV7000.Barcode, AV7000.WarehouseName, AV7000.Varchar01, AV7000.ETaxConvertedUnit'

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
			AV2088.SalePrice01,
			AV2088.InventoryID, AV2088.InventoryName, AV2088.InventoryTypeID,AT1301.InventoryTypeName, AV2088.Specification, AV2088.UnitID,
			AV2088.UnitName, CONVERT(NVARCHAR(50),'''') AS ConversionUnitID, CONVERT(DECIMAL(28,8),0) AS ConversionFactor, CONVERT(TINYINT,0) AS Operator,
			SUM(AV2088.BeginQuantity) AS BeginQuantity, SUM(AV2088.DebitQuantity) AS DebitQuantity, 
			SUM(AV2088.CreditQuantity) AS CreditQuantity, SUM(AV2088.BeginQuantity + DebitQuantity - CreditQuantity) AS EndQuantity,
			SUM(AV2088.BeginAmount) AS BeginAmount, SUM(AV2088.DebitAmount) AS DebitAmount, 
			SUM(AV2088.CreditAmount) AS CreditAmount, SUM(AV2088.BeginAmount + DebitAmount - CreditAmount) AS EndAmount,
			0 AS InDebitAmount, 0 AS InCreditAmount, SUM(AV2088.InDebitQuantity) AS InDebitQuantity, 
			SUM(AV2088.InCreditQuantity) AS InCreditQuantity, AV2088.WareHouseID, AV2088.DivisionID, AV2088.Barcode, AV2088.WarehouseName, AV2088.Varchar01, AV2088.ETaxConvertedUnit
		'
		
		SET @sSQLFrom = ' INTO ##AV2098'+ltrim(@@SPID)+' 
			FROM ##AV2088'+ltrim(@@SPID)+' AV2088 
			LEFT JOIN AT1301 WITH (NOLOCK) ON AT1301.InventoryTypeID = AV2088.InventoryTypeID
		'

		SET @sSQLWhere = ' 
			WHERE (BeginQuantity <> 0 OR BeginAmount <> 0 
			OR DebitQuantity <> 0 OR DebitAmount <> 0 
			OR CreditQuantity <> 0 OR CreditAmount <> 0 
			OR EndQuantity <> 0 OR EndAmount <> 0)
			AND AV2088.DivisionID =''' + @DivisionID + ''' 
	
			GROUP BY AV2088.S1, AV2088.S2, AV2088.S3, AV2088.I01ID, AV2088.I02ID, AV2088.I03ID, AV2088.I04ID, AV2088.I05ID, 
			--AV2088.Notes01, AV2088.Notes02, AV2088.Notes03 ,
			AV2088.SalePrice01, AV2088.InventoryID, AV2088.InventoryName,
			AV2088.InventoryTypeID,AT1301.InventoryTypeName, AV2088.Specification, AV2088.UnitID, AV2088.UnitName,
			---AT1309.UnitID, AT1309.ConversionFactor, AT1309.Operator,
			AV2088.WareHouseID, AV2088.DivisionID, AV2088.Barcode, AV2088.WarehouseName, AV2088.Varchar01, AV2088.ETaxConvertedUnit '
	
		SET @sSQLUpdate = '
			UPDATE T1
			SET T1.ConversionUnitID = AT1309.ConvertUnitID, T1.ConversionFactor = AT1309.ConversionFactor, T1.Operator = AT1309.Operator
			FROM ##AV2098'+ltrim(@@SPID)+' T1
			LEFT JOIN AV1399 as AT1309 ON AT1309.InventoryID = T1.InventoryID AND AT1309.UnitID = T1.UnitID
		'
	
	----Theo ngay----------------------------------------------------
		EXEC(@sSQLSelect + @sSQLFrom + @sSQLWhere+@sSQLUpdate)
		/*
		IF NOT EXISTS ( SELECT 1 FROM sysObjects WHERE Xtype = 'V' AND Name = 'AV2098' )
			EXEC ('CREATE VIEW AV2098 -- Tao boi AP2008
				AS ' + @sSQLSelect + @sSQLFrom + @sSQLWhere)
		ELSE
			EXEC ('ALTER VIEW AV2098 -- Tao boi AP2008
				AS ' + @sSQLSelect + @sSQLFrom + @sSQLWhere)
		*/
		--Print  ('TEST'+@sSQLSelect) 
		--Print  @sSQLFrom 
		--Print  @sSQLWhere
		--Print  @sSQLUpdate

		
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

		SET @GroupField1 = ISNULL(@GroupField1, '')
		SET @GroupField2 = ISNULL(@GroupField2, '')

		SET @sSQLFrom1 = ' 
			LEFT JOIN (	SELECT	A.InventoryID, SUM(A.MinQuantity) AS MinQuantity, SUM(A.MaxQuantity) AS MaxQuantity, A.DivisionID, A.WareHouseID
						FROM	AT1314 A  WITH (NOLOCK)
           				WHERE '+ISNULL(@curListWareHouseID2, '''')+'
           				GROUP BY A.InventoryID, A.DivisionID, A.WareHouseID ) AT1314
				ON		AT1314.InventoryID = AV2098.InventoryID AND AV2098.WareHouseID = AT1314.WareHouseID
			--LEFT JOIN AT1303 ON AV2098.DivisionID = AT1303.DivisionID AND AV2098.WareHouseID = AT1303.WareHouseID'

	   IF (@GroupID1 != '')
			BEGIN 
				SET @sSQLSelect = ' SELECT V1.ID AS GroupID1, V1.SName GroupName1, '''' AS GroupID2, '''' GroupName2, '
				SET @sSQLFrom = ' 
				FROM		##AV2098'+ltrim(@@SPID)+' AS AV2098 
				LEFT JOIN	AV1310 V1 ON V1.DivisionID = AV2098.DivisionID AND V1.ID = AV2098.' + @GroupField1 + ' AND V1.TypeID =''' + @GroupID1 + ''' 
				'
				SET @sGroupByChild = 'V1.ID,V1.SName,'
			END
		ELSE
			BEGIN
				SET @sSQLSelect = ' SELECT '''' AS GroupID1, '''' AS GroupName1, '''' AS GroupID2, '''' AS GroupName2, '
				SET @sSQLFrom = 'FROM	##AV2098'+ltrim(@@SPID)+' AS AV2098'
				SET @sGroupByChild = ''
			END

		SET @sSQLSelect = @sSQLSelect + '
			AV2098.S1, AV2098.S2, AV2098.S3, AV2098.I01ID, AV2098.I02ID, AV2098.I03ID, AV2098.I04ID, AV2098.I05ID, 
			AV2098.Notes01, AV2098.Notes02, AV2098.Notes03 ,AV2098.SalePrice01, AV2098.InventoryID, AV2098.InventoryName,
			AV2098.InventoryTypeID,AV2098.InventoryTypeName, AV2098.Specification, AV2098.UnitID, AV2098.UnitName,
			AV2098.ConversionUnitID, AV2098.ConversionFactor, AV2098.Operator,
			CASE WHEN (AV2098.ConversionFactor = NULL OR AV2098.ConversionFactor = 0) 
			THEN NULL ELSE ISNULL(AV2098.EndQuantity, 0) / AV2098.ConversionFactor END AS ConversionQuantity,
			AV2098.BeginQuantity, AV2098.DebitQuantity, AV2098.CreditQuantity, AV2098.EndQuantity, AV2098.BeginAmount, 
			AV2098.DebitAmount, AV2098.CreditAmount, AV2098.EndAmount, AV2098.InDebitAmount, AV2098.InCreditAmount, 
			AV2098.InDebitQuantity, AV2098.InCreditQuantity, AV2098.DivisionID, AT1314.MinQuantity, AT1314.MaxQuantity,
			AV2098.WarehouseID, AV2098.WarehouseName, AV2098.Varchar01, AV2098.ETaxConvertedUnit,
			CASE WHEN (SELECT SUM(ActualQuantity) FROM AT2007 WITH (NOLOCK) WHERE InventoryID = AV2098.InventoryID 
				AND TranMonth + TranYear * 100 >= '+STR(@3MonthPrevious + @YearPrevious * 100)+'
				AND TranMonth + TranYear * 100 < '+STR(@ToMonth + @ToYear * 100)+' ) = 0 THEN 0
				ELSE AV2098.EndQuantity/ ((SELECT SUM(ActualQuantity) FROM AT2007 WHERE InventoryID = AV2098.InventoryID 
				AND TranMonth + TranYear * 100 >= '+STR(@3MonthPrevious + @YearPrevious * 100)+'
				AND TranMonth + TranYear * 100 < '+STR(@ToMonth + @ToYear * 100)+' )/3) END TimeOfUse , AV2098.Barcode,
				N'''+@GroupID+''' as GroupID, AT1401.GroupName '
		SET @sSQLFrom = @sSQLFrom + @sSQLFrom1 + ' 
			--Left join AT1302 On AV2098.DivisionID = AT1302.DivisionID AND AT1302.InventoryID = AV2098.InventoryID
			LEFT JOIN AT1401 WITH (NOLOCK) on AT1401.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1401.GroupID = N''' +@GroupID+ '''
			WHERE (BeginQuantity <> 0 OR BeginAmount <> 0 
			OR DebitQuantity <> 0 OR DebitAmount <> 0 
			OR CreditQuantity <> 0 OR CreditAmount <> 0 
			OR EndQuantity <> 0 OR EndAmount <> 0)
			AND AV2098.DivisionID =''' + @DivisionID + '''

			GROUP BY ' + @sGroupByChild + 'AV2098.S1, AV2098.S2, AV2098.S3, AV2098.I01ID, AV2098.I02ID, AV2098.I03ID, AV2098.I04ID, AV2098.I05ID, 
			AV2098.Notes01, AV2098.Notes02, AV2098.Notes03 ,AV2098.SalePrice01, AV2098.InventoryID, AV2098.InventoryName,
			AV2098.InventoryTypeID,AV2098.InventoryTypeName, AV2098.Specification, AV2098.UnitID, AV2098.UnitName,
			AV2098.ConversionUnitID, AV2098.ConversionFactor, AV2098.Operator,
			AV2098.BeginQuantity, AV2098.DebitQuantity, AV2098.CreditQuantity, AV2098.EndQuantity, AV2098.BeginAmount, 
			AV2098.DebitAmount, AV2098.CreditAmount, AV2098.EndAmount, AV2098.InDebitAmount, AV2098.InCreditAmount, 
			AV2098.InDebitQuantity, AV2098.InCreditQuantity, AV2098.DivisionID, AT1314.MinQuantity, AT1314.MaxQuantity,
			AV2098.WarehouseID, AV2098.WarehouseName, AV2098.Varchar01, AV2098.ETaxConvertedUnit, 
			AT1401.GroupName, AV2098.Barcode 
		'
		print @sSQLSelect 
		print  @sSQLFrom
		EXEC(@sSQLSelect + @sSQLFrom)		
		END

END 






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
