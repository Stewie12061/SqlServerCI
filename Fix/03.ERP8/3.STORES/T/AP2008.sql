IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP2008]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP2008]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Purpose: Bao cao ton kho theo kho cho tung kho
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
---- Modified by Tiểu Mai on 30/05/2016: Tách store quy cách hàng hóa.
---- Modified on 01/06/2016 by Bảo Thy : Customize cho Phúc Long , gọi AP2008_PL
---- Modified by Phương Thảo on 06/06/2016: Lấy max trường ĐVT quy đổi 
---- Modified by Tiểu Mai on 06/07/2016: Bổ sung trường Varchar01, ETaxConvertedUnit
---- Modified by Tiểu Mai on 05/08/2016: Fix lỗi nhiều dòng kho mặt hàng có nhiều ĐVT
---- Modified by Tiểu Mai on 12/01/2017: Fix bug lên nhiều dòng do định mức hàng tồn kho
---- Modified by Bảo Thy on 08/05/2017: Sửa danh mục dùng chung
---- Modified by Bảo Thy on 14/07/2017: Fix bug lấy sai ConversionUnitID khi in theo kỳ
---- Modified by Bảo Thy on 19/01/2018: Bổ sung lọc báo cáo theo quy cách
---- Modified by Kim Thư on 19/9/2018: Sửa lỗi nhiều user cùng in báo cáo, bổ sung SPID cho bảng tạm
---- Modified by Kim Thư on 21/10/2018: Thay đổi load table AV7000, cải tiến tốc độ in theo ngày
---- Modified by Kim Thư on 11/03/2019: Bỏ kết AT1309 ở bản tạm ##AV7018 khi in theo kỳ để tránh double dòng
---- Modified by Kim Thư on 22/04/2019: Bổ sung thêm trường nhóm người dùng (GroupID), truyền @UserID
---- Modified by Văn Minh on 28/11/2019: Bổ sung GROUP BY
---- Modified by Văn Minh on 24/12/2019: Bổ sung GROUP BY đối với từng trường hợp của @IsGroupID
---- Modified by Đức Thông on 31/08/2020: Bổ sung custom cho SIEUTHANH: Không lấy groupID, groupName
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Nhựt Trường on 05/01/2021: Bổ sung thêm điều kiện DivisionID khi join bảng AT1401.
---- Modified by Nhựt Trường on 13/01/2021: Chỉnh sửa điều kiện DivisionID khi join bảng AT1304.
---- Modified by Nhựt Trường on 18/05/2021: Bổ sung thêm điều kiện DivisionID khi join bảng AT1303.
---- Modified by Đình Định on 10/08/2023: BBL - Tách store.
/*
    EXEC AP2008 'KHV', 1, 2016, 1,2016, '01/01/2016', '01/10/2016', 'CRA00710', 'G80A4550', 'HGK', 1, 0, '', ''
*/

CREATE PROCEDURE AP2008
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
    @GroupID2 NVARCHAR(50),--- Note : GroupID nhan cac gia tri S1, S2, S3, CI1, CI2, CI3
	@IsSearchStandard TINYINT,
	@StandardList XML,
	@UserID VARCHAR(50)
)
AS

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
	EXEC AP2008_QC @DivisionID, @FromMonth, @ToMonth, @FromYear, @ToYear, @FromDate, @ToDate, @FromInventoryID, @ToInventoryID, @WareHouseID, @IsDate, @IsGroupID, @GroupID1, @GroupID2,@IsSearchStandard,@StandardList, @UserID
ELSE
BEGIN 
DECLARE @CustomerName INT
--Tao bang tam de kiem tra day co phai la khach hang 2T khong (CustomerName = 15)
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

IF @CustomerName = 32 ---- Customize Phúc Long
	BEGIN
		EXEC AP2008_PL @DivisionID, @FromMonth,@ToMonth, @FromYear, @ToYear,@FromDate,@ToDate,@FromInventoryID, @ToInventoryID,@WareHouseID,@IsDate,@IsGroupID, @GroupID1,  @GroupID2
	END
ELSE
IF @CustomerName = 16 --- Customize SIEUTHANH
	BEGIN
		EXEC AP2008_ST @DivisionID, @FromMonth,@ToMonth, @FromYear, @ToYear,@FromDate,@ToDate,@FromInventoryID, @ToInventoryID,@WareHouseID,@IsDate,@IsGroupID, @GroupID1,  @GroupID2
	END
ELSE
IF @CustomerName = 15 --- Customize 2T
	EXEC AP2888 @DivisionID, @FromMonth, @ToMonth, @FromYear, @ToYear, @FromDate, @ToDate, @FromInventoryID, @ToInventoryID, @WareHouseID, @IsDate, @IsGroupID, @GroupID1, @GroupID2
ELSE
IF @CustomerName = 38 --- Customize Bourbon
BEGIN
	EXEC AP2008_BBL @DivisionID, @FromMonth,@ToMonth, @FromYear, @ToYear,@FromDate, @ToDate, @FromInventoryID, @ToInventoryID, @WareHouseID, @IsDate, @IsGroupID, @GroupID1, @GroupID2, @IsSearchStandard, @StandardList, @UserID
END
ELSE
BEGIN
		DECLARE
			@sSQLDrop AS NVARCHAR(4000),
			@sSQLSelect AS NVARCHAR(4000), 
			@sSQLFrom AS NVARCHAR(4000), 
			@sSQLFrom1 AS NVARCHAR(4000), 
			@sSQLWhere AS NVARCHAR(4000),
			@sSQLUnion AS NVARCHAR(4000), 
			@sSQLUnion1 AS NVARCHAR(4000),
			@sSQLUpdate AS NVARCHAR(4000) ='',
			@GroupField1 AS NVARCHAR(50), 
			@GroupField2 AS NVARCHAR(50), 
			@FromMonthYearText NVARCHAR(20), 
			@ToMonthYearText NVARCHAR(20), 
			@FromDateText NVARCHAR(20), 
			@ToDateText NVARCHAR(20),
			@WhereTime AS NVARCHAR(4000),
			@3MonthPrevious INT,
			@YearPrevious INT,
			@GroupID VARCHAR(50),
			@sGroupByChild nvarchar(MAX)
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
				LEFT JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN (AT2008.DivisionID,''@@@'') AND AT1303.WareHouseID = AT2008.WareHouseID' 
			SET @sSQLWhere = ' 
				WHERE AT2008.DivisionID = ''' + @DivisionID + ''' 
				AND AT2008.WareHouseID LIKE ''' + @WareHouseID + ''' 
				AND AT2008.InventoryID BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + '''
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
					INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND D03.WareHouseID = D16.WareHouseID
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
					INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND D03.WareHouseID = D16.WareHouseID
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
					INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND D03.WareHouseID = D06.WareHouseID
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
					INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND D03.WareHouseID = CASE WHEN D06.KindVoucherID = 3 then D06.WareHouseID2 Else  D06.WareHouseID End
					Where D06.KindVoucherID in (2,3,4,6,8,10,14,20)
				) AV7000
			'
			SET @sSQLWhere = '
			WHERE AV7000.DivisionID = ''' + @DivisionID + ''' 
			AND AV7000.WareHouseID LIKE ''' + @WareHouseID + ''' 
			AND AV7000.InventoryID BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + '''
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
		WHERE AV7018.WareHouseID LIKE '''+@WareHouseID+''' AND AV7018.DivisionID = '''+@DivisionID+''' 
		AND AV7018.InventoryID NOT IN 
		(
			SELECT InventoryID FROM AV7000 
			WHERE AV7000.DivisionID ='''+@DivisionID+''' 
			AND AV7000.WareHouseID LIKE '''+@WareHouseID+''' 
			AND AV7000.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+'''
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
					INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND D03.WareHouseID = D16.WareHouseID
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
					INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND D03.WareHouseID = D16.WareHouseID
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
					INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND D03.WareHouseID = D06.WareHouseID
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
					INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND D03.WareHouseID = CASE WHEN D06.KindVoucherID = 3 then D06.WareHouseID2 Else  D06.WareHouseID End
					Where D06.KindVoucherID in (2,3,4,6,8,10,14,20)		
			)AV7000'
		IF @IsDate = 0
			SET @sSQLUnion1 = @sSQLUnion1 + '	LEFT JOIN ##AV7018'+ltrim(@@SPID)+' AV7018 ON AV7018.DivisionID = AV7000.DivisionID AND AV7000.WareHouseID = AV7018.WareHouseID AND AV7000.InventoryID = AV7018.InventoryID'

		SET @sSQLUnion1 = @sSQLUnion1 + '
			WHERE AV7000.DivisionID ='''+@DivisionID+''' 
			AND AV7000.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+'''
			AND AV7000.WareHouseID LIKE '''+@WareHouseID+''' 
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
			LEFT JOIN (	SELECT	A.InventoryID, SUM(A.MinQuantity) AS MinQuantity, SUM(A.MaxQuantity) AS MaxQuantity, A.DivisionID, A.WareHouseID
						FROM	AT1314 A  WITH (NOLOCK)
           				WHERE	A.WareHouseID = '''+@WareHouseID+''' OR A.WareHouseID = ''%''
           				GROUP BY A.InventoryID, A.DivisionID, A.WareHouseID ) AT1314
				ON		AT1314.InventoryID = AV2098.InventoryID AND AV2098.WareHouseID = AT1314.WareHouseID
			--LEFT JOIN AT1303 ON AV2098.DivisionID = AT1303.DivisionID AND AV2098.WareHouseID = AT1303.WareHouseID'

		IF ((@IsGroupID >= 2) AND (@GroupField1 <> '') AND (@GroupField2 <> ''))
			BEGIN
				SET @IsGroupID = 2
				SET @sSQLSelect = 'SELECT V1.ID AS GroupID1, V1.SName GroupName1, V2.ID AS GroupID2, V2.SName GroupName2, '
				SET @sSQLFrom = ' 
				FROM		##AV2098'+ltrim(@@SPID)+' AS AV2098 
				LEFT JOIN	AV1310 V1 ON V1.DivisionID = AV2098.DivisionID AND V1.ID = AV2098.' + @GroupField1 + ' AND V1.TypeID =''' + @GroupID1 + ''' 
				LEFT JOIN	AV1310 V2 ON V2.DivisionID = AV2098.DivisionID AND V2.ID = AV2098.' + @GroupField2 + ' AND V2.TypeID =''' + @GroupID2 + '''
				'
				SET @sGroupByChild = 'V1.ID,V1.SName,V2.ID,V2.SName,'
			END
			ELSE IF ((@IsGroupID >= 1) AND ((@GroupField1 <> '') OR (@GroupField2 <> '')))
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
				SET @sSQLFrom = ' 
					FROM		##AV2098'+ltrim(@@SPID)+' AS AV2098
				'
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
