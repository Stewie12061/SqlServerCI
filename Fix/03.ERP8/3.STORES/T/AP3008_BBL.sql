IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP3008_BBL]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP3008_BBL]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Nhập xuất tồn theo kho (tất cả các kho)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 15/06/2006 by Nguyen Quoc Huy
---- 
---- Modified on 12/06/2012 by Lê Thị Thu Hiền : Bổ sung MinQuantity, MaxQuantity
---- Modified on 10/09/2012 by Bao Anh : Customize cho 2T (tồn kho theo quy cách), gọi AP3888
---- Modified on 10/09/2012 by Bao Anh : Bổ sung Varchar01 --> Varchar02
---- Modified on 17/06/2014 by Thanh Sơn : Bổ sung TimeOfUse
---- Modified on 08/07/2014 by Bảo Anh : Trả dữ liệu trực tiếp, không tạo view AV3008
---- Modified on 14/05/2015 by Bảo Anh: cải thiện tốc độ (dùng bảng tạm thay view, sửa câu tạo bảng tạm ##AV3088, tính TimeOfUse từ AT2007)
---- Modified on 11/09/2015 by Thanh Thịnh: Chỉ hiện những người có trường Thủ Kho ở AT1303 là khác 1 (Figla)
---- Modified on 14/10/2015 by Tieu Mai: Fix đúp dòng khi xem báo cáo theo ngày.
---- Modified on 15/11/2015 by Bảo Anh: Đưa phần tính TimeOfUse vào customize cho Viện Gút, lấy các trường Notes01 -> 03 từ AT1302 để fix lỗi 1 mặt hàng lên nhiều dòng
---- Modified on 07/01/2016 by Tieu Mai: Bổ sung in báo cáo theo quy cách khi có thiết lập quản lý mặt hàng theo quy cách.
---- Modified on 04/02/2016 by Kim Vu: Bo sung in báo cáo loại trừ kho không chọn in trong thiết lập in
----Modified by Phương Thảo on 27/05/2016: Bổ sung WITH(NOLOCK)
----Modified by Hải Long on 03/02/2017: Fix bug: In báo cáo theo ngày bị double dữ liệu
---- Modified by Hải Long on 17/07/2017: Bổ sung trường Barcode
---- Modified by khả Vi on 25/10/2017: Bổ sung trường WarehouseID, WarehouseName
---- Modified by Bảo Thy on 19/01/2018: Bổ sung lọc báo cáo theo quy cách
---- Modified by Kim Thư on 21/10/2018: Thay đổi load table AV7000, cải tiến tốc độ in theo ngày
---- Modified by Kim Thư on 22/04/2019: Bổ sung thêm trường nhóm người dùng (GroupID), UserID
---- Modified by Khánh Đoan on 30/08/2019: Bổ sung  KindVoucherID = 3 khi  chọn in tất cả kho bỏ check 1 kho
---- Modified by Khánh Đoan on 05/09/2019:Bổ sung thêm biến 
---- Modified by Văn Tài	on 05/11/2019:Bổ sung AT1401.DivisionID = N''' +@DivisionID+ '''
---- Modified by Văn Tài	on 07/11/2019:Loại bỏ dấu nháy dư.
---- Modified by Huỳnh Thử	on 06/05/2020: không hiển thị số lượng nhập xuất của phiếu chuyển kho khi không bỏ check kho nào
---- Modified by Huỳnh Thử	on 20/08/2020: Customer BASON: Lỗi khi appen chuỗi.
---- Modified by Đức Thông	on 01/09/2020: Customer SAVI: Không lấy GroupID, GroupName
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Lê Hoàng on 21/10/2020: Điều kiện dư thừa sai lỗi
---- Modified by Nhựt Trường on 18/05/2021: Chỉnh sửa điều kiện DivisionID khi join bảng AT1303.
---- Modified by Nhật Thanh on 11/10/2021: Cập nhật độ dài cho @sSQL2a
---- Modified by Xuân Nguyên on 13/01/2022: Chỉnh sửa dùng LEFT JOIN khi join bảng AT1304 thay vì dùng INNER JOIN
---- Modified by Nhật Quang on 06/10/2022: Thêm biến sDivision khi chọn tất cả đơn vị (%), thay IN bằng LIKE %.
---- Modified by Thanh Lượng on 25/11/2022: [2022/11/IS/0238] - Fix lỗi đặt sai vị trí BEGIN/END của câu điều kiện rẻ nhánh sang luồng chuẩn.
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Nhật Thanh on 22/02/2023: Bổ sung lấy mã tham chiếu từ bảng mặt hàng
---- Modified by Thành Sang on 25/04/2023: Fix bổ sung lấy mã tham chiếu từ bảng mặt hàng
---- Modified by Đình Định on 11/08/2023: BBL - Mẫu AR3008: Lấy lên thẻ BeginConvertedQuantity, DebitConvertedQuantity, CreditConvertedQuantity, EndConvertedQuantity, ConvertedUnitID.

---- <Example>
-- exec AP3008 @DivisionID=N'MP',@FromMonth=4,@ToMonth=4,@FromYear=2019,@ToYear=2019,@FromDate='2019-04-22 00:00:00',@ToDate='2019-04-22 00:00:00',@FromInventoryID=N'A1200L',
-- @ToInventoryID=N'ZZZ',@IsDate=0,@IsGroupID=2,@GroupID1=N'I01',@GroupID2=N'I02',@LstWareHouseID=N'',@IsSearchStandard=0,@StandardList=NULL, @UserID='ASOFTADMIN'
-- exec AP3008 'SBS',11,11,2019,2019,'2019-10-30','2019-10-30','01DV001','ZZ002',0,0,NULL,NULL,NULL,0,'ASOFTADMIN'

CREATE PROCEDURE AP3008_BBL
(
    @DivisionID AS nvarchar(50), 
    @FromMonth AS int, 
    @ToMonth AS int, 
    @FromYear AS int, 
    @ToYear AS int, 
    @FromDate AS datetime, 
    @ToDate AS datetime, 
    @FromInventoryID AS nvarchar(50), 
    @ToInventoryID AS nvarchar(50), 
    @IsDate AS tinyint, 
    @IsGroupID AS tinyint, --- 0 Khong nhom; 1 Nhom 1 cap; 2 Nhom 2 cap
    @GroupID1 AS nvarchar(50), 
    @GroupID2 AS nvarchar(50), --- Note : GroupID nhan cac gia tri S1, S2, S3, CI1, CI2, CI3
	@LstWareHouseID as nvarchar(Max),--- Danh sach cac kho loại trừ khong in
	@IsSearchStandard TINYINT,
	@StandardList XML,
	@UserID nvarchar(50)
)
AS
DECLARE @CustomerName INT, @GroupID VARCHAR(50)
--Tao bang tam de kiem tra day co phai la khach hang 2T khong (CustomerName = 15)
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

SET @GroupID= (SELECT TOP 1 AT1402.GroupID FROM AT1402 WITH(NOLOCK) WHERE AT1402.UserID = @UserID AND AT1402.DivisionID LIKE @DivisionID)

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH(NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN
	EXEC AP3009 @DivisionID, @FromMonth, @ToMonth, @FromYear, @ToYear, @FromDate, @ToDate, @FromInventoryID, @ToInventoryID, @IsDate, @IsGroupID, @GroupID1, @GroupID2, @LstWareHouseID, @IsSearchStandard,@StandardList,@UserID 
END
ELSE
	BEGIN
		DECLARE 
			@sSQL1 AS NVARCHAR(max), 
			@sSQL01 AS NVARCHAR(max), 
			@sSQL01_1 AS NVARCHAR(max),
			@sSQL2 AS nvarchar(max), 
			@sSQL2a AS nvarchar(max),
			@sSQL2b AS nvarchar(4000),
			@sSQL2c AS nvarchar(4000),
			@sSQL3 AS nvarchar(4000), 
			@sSQL4 AS nvarchar(4000), 
			@sSQLDrop AS nvarchar(4000), 
			@GroupField1 AS nvarchar(20), 
			@GroupField2 AS nvarchar(20), 
			@FromMonthYearText NVARCHAR(20), 
			@ToMonthYearText NVARCHAR(20), 
			@FromDateText NVARCHAR(20), 
			@ToDateText NVARCHAR(20),
			@3MonthPrevious INT,
			@YearPrevious INT	,	
			@sSQL2d AS nvarchar(4000),
			@sSQL2e AS nvarchar(4000),
			@sDivision NVARCHAR(1000),
			@sSQL_Temp01 NVARCHAR(MAX),
			@sSQL_Temp01_1 NVARCHAR(MAX),
			@sSQL_Temp02 NVARCHAR(MAX),
			@sSQL_Temp02_2 NVARCHAR(MAX)

		SET @FromMonthYearText = STR(@FromMonth + @FromYear * 100)
		SET @ToMonthYearText = STR(@ToMonth + @ToYear * 100)
		SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
		SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

		IF @DivisionID = N'%'
		BEGIN
			SET @sDivision = 'LIKE ''%'''
		END
		ELSE
		BEGIN
			SET @sDivision = 'IN ('''+@DivisionID+''', ''@@@'')'
		END
		--- Xóa các bảng tạm nếu đã tồn tại
		SET @sSQLDrop='
		IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N''tempdb.dbo.##AV7016'+LTRIM(@@SPID)+''')) 
			DROP TABLE ##AV7016'+LTRIM(@@SPID)+'

		IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N''tempdb.dbo.##AV3088'+LTRIM(@@SPID)+''')) 
			DROP TABLE ##AV3088'+LTRIM(@@SPID)+'

		IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N''tempdb.dbo.##AV3098'+LTRIM(@@SPID)+''')) 
			DROP TABLE ##AV3098'+LTRIM(@@SPID)+'
		'
		EXEC (@sSQLDrop)

		IF @IsDate = 0 --theo ky
		BEGIN
			IF @ToMonth > 3	BEGIN SET @3MonthPrevious = @ToMonth - 3 SET @YearPrevious = @ToYear END
			ELSE BEGIN SET @3MonthPrevious = 9 + @ToMonth SET @YearPrevious = @ToYear - 1 END

		-- 1. Lấy số dư đầu kỳ Begin vào bảng tạm Temp.
		SET @sSQL_Temp01 = N'
			SELECT AV7000.DivisionID, AV7000.InventoryID, AV7000.ConvertedQuantity, AV7000.ConvertedUnitID
			  INTO #Temp
			FROM  (
			       SELECT D17.TranMonth, D17.TranYear, D02.S1, D02.S2, D02.S3, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, 
			       		  D02.Notes01 , D02.Notes02, D02.Notes03,
			       		  D02.SalePrice01, D17.InventoryID, D02.InventoryName,
			       		  D02.InventoryTypeID, D02.Specification, D02.UnitID, D04.UnitName, 
			       		  D17.ActualQuantity AS SignQuantity, D17.ConvertedAmount AS SignAmount,
			       		  D16.WareHouseID, D17.DivisionID, D02.Barcode, D03.WarehouseName,
			       		  D02.Varchar01, D02.ETaxConvertedUnit, D16.VoucherDate, ''BD'' AS D_C,
			       		  D17.ConvertedQuantity, D17.ConvertedUnitID
			         FROM AT2017 D17 WITH (NOLOCK)
			        INNER JOIN AT2016 D16 WITH (NOLOCK) ON D16.VoucherID = D17.VoucherID AND D16.DivisionID = D17.DivisionID
			       	INNER JOIN AT1302 D02 WITH (NOLOCK) ON D02.DivisionID IN (D17.DivisionID,''@@@'') AND D02.InventoryID = D17.InventoryID
			         LEFT JOIN AT1304 D04 WITH (NOLOCK) ON D04.DivisionID IN (D17.DivisionID,''@@@'') AND D04.UnitID = D02.UnitID
			       	INNER JOIN AT1303 D03 WITH (NOLOCK) ON D03.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND D03.WareHouseID = D16.WareHouseID
			       	WHERE ISNULL(D17.DebitAccountID,'''') <>'''' 
					UNION ALL -- Nhập kho
					SELECT D07.TranMonth, D07.TranYear, D02.S1, D02.S2, D02.S3, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, 
					       D02.Notes01 , D02.Notes02, D02.Notes03,
					       D02.SalePrice01, D07.InventoryID, D02.InventoryName,
					       D02.InventoryTypeID, D02.Specification, D02.UnitID, D04.UnitName, 
					       D07.ActualQuantity AS SignQuantity, D07.ConvertedAmount AS SignAmount,
					       D06.WareHouseID, D07.DivisionID, D02.Barcode, D03.WarehouseName,
					       D02.Varchar01, D02.ETaxConvertedUnit, D06.VoucherDate, ''D'' AS D_C,
					       D07.ConvertedQuantity, D07.ConvertedUnitID
					  FROM AT2007 D07 WITH (NOLOCK)
					 INNER JOIN AT2006 D06 WITH (NOLOCK) ON D06.VoucherID = D07.VoucherID AND D06.DivisionID = D07.DivisionID
					 INNER JOIN AT1302 D02 WITH (NOLOCK) ON D02.DivisionID IN (D07.DivisionID,''@@@'') AND D02.InventoryID = D07.InventoryID
					  LEFT JOIN AT1304 D04 WITH (NOLOCK) ON D04.DivisionID IN (D07.DivisionID,''@@@'') AND D04.UnitID = D02.UnitID
					 INNER JOIN AT1303 D03 WITH (NOLOCK) ON D03.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND D03.WareHouseID = D06.WareHouseID
					 WHERE
					 D06.KindVoucherID IN (1,3,5,7,9,15,17) AND Isnull(D06.TableID,'''') <> ''AT0114'' ------- Phi?u nh?p bù c?a ANGEL
					'
		SET @sSQL_Temp01_1 = N'
			UNION ALL -- Xuất kho
			SELECT D07.TranMonth, D07.TranYear, D02.S1, D02.S2, D02.S3, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, 
				   D02.Notes01, D02.Notes02, D02.Notes03,
				   D02.SalePrice01, D07.InventoryID, D02.InventoryName,
				   D02.InventoryTypeID, D02.Specification, D02.UnitID, D04.UnitName, 
				   -D07.ActualQuantity AS SignQuantity, -D07.ConvertedAmount AS SignAmount,
				   CASE WHEN D06.KindVoucherID = 3 then D06.WareHouseID2 ELSE D06.WareHouseID END AS WareHouseID,
				   D07.DivisionID, D02.Barcode, D03.WareHouseName,
				   D02.Varchar01, D02.ETaxConvertedUnit, D06.VoucherDate, ''C'' AS D_C,
				   D07.ConvertedQuantity,
				   D07.ConvertedUnitID
			  FROM AT2007 D07 WITH (NOLOCK)
			 INNER JOIN AT2006 D06 WITH (NOLOCK) ON D06.VoucherID = D07.VoucherID AND D06.DivisionID = D07.DivisionID
			 INNER JOIN AT1302 D02 WITH (NOLOCK) ON D02.DivisionID IN (D07.DivisionID,''@@@'') AND D02.InventoryID = D07.InventoryID
			  LEFT JOIN AT1304 D04 WITH (NOLOCK) ON D04.DivisionID IN (D07.DivisionID,''@@@'') AND D04.UnitID = D02.UnitID
			 INNER JOIN AT1303 D03 WITH (NOLOCK) ON D03.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND D03.WareHouseID = CASE WHEN D06.KindVoucherID = 3 THEN D06.WareHouseID2 Else  D06.WareHouseID End
			 WHERE D06.KindVoucherID IN (2,3,4,6,8,10,14,20)
				) AV7000
			WHERE AV7000.DivisionID IN ( ''' + @DivisionID + ''', ''@@@'')
			  AND AV7000.TranMonth + 100 * AV7000.TranYear < ''' + @FromMonthYearText + ''' OR D_C = ''BD''
			 
		'
		EXEC (@sSQL_Temp01 + @sSQL_Temp01_1)
		PRINT @sSQL_Temp01 
		PRINT @sSQL_Temp01_1

		-- 2. Lấy số dư trong kỳ Debit & Credit vào bảng tạm Temp2.
		SET @sSQL_Temp02 = N'
			SELECT AV7001.DivisionID, AV7001.InventoryID,
			       CASE WHEN AV7001.D_C = ''D'' THEN ISNULL(AV7001.ConvertedQuantity, 0) ELSE 0 END AS DebitConvertedQuantity,
			       CASE WHEN AV7001.D_C = ''C'' THEN ISNULL(AV7001.ConvertedQuantity, 0) ELSE 0 END AS CreditConvertedQuantity
			  INTO #Temp2
			FROM (
				SELECT D17.DivisionID, D16.WarehouseID, D03.WarehouseName, D16.VoucherDate, D17.TranMonth, D17.TranYear,
				       D17.InventoryID, D02.InventoryName, D02.RefInventoryID, D02.UnitID, D02.Barcode,
				       D02.S1, D02.S2, D02.S3, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, 
				       D02.VATPercent, D02.InventoryTypeID, D02.Specification, 
				       D02.Notes01, D02.Notes02, D02.Notes03,
				       D02.Varchar01, D02.Varchar02, D02.Varchar03, D02.Varchar04, D02.Varchar05, 
				       D04.UnitName, D17.ActualQuantity, D17.ConvertedAmount, ''BD'' AS D_C, ISNULL(D03.IsTemp,0) AS IsTemp, D03.FullName AS WHFullName,
				       D17.ConvertedQuantity, 0 AS DebitConvertedQuantity, 0 AS CreditConvertedQuantity
				  FROM AT2017 D17 WITH (NOLOCK)
				 INNER JOIN AT2016 D16 WITH (NOLOCK) ON D16.DivisionID = D17.DivisionID AND D16.VoucherID = D17.VoucherID
				 INNER JOIN AT1302 D02 WITH (NOLOCK) ON D02.DivisionID IN (D17.DivisionID,''@@@'') AND D02.InventoryID = D17.InventoryID
				  LEFT JOIN AT1304 D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID
				 INNER JOIN AT1303 D03 WITH (NOLOCK) ON D03.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND D03.WareHouseID = D16.WareHouseID
			     WHERE ISNULL(D17.DebitAccountID,'''') <>''''
			UNION ALL -- Số dư có
			    SELECT D17.DivisionID, D16.WarehouseID, D03.WarehouseName, D16.VoucherDate, D17.TranMonth, D17.TranYear,
					   D17.InventoryID, D02.InventoryName, D02.RefInventoryID, D02.UnitID, D02.Barcode,
					   D02.S1, D02.S2, D02.S3, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, 
					   D02.VATPercent, D02.InventoryTypeID, D02.Specification, 
					   D02.Notes01, D02.Notes02, D02.Notes03,
					   D02.Varchar01, D02.Varchar02, D02.Varchar03, D02.Varchar04, D02.Varchar05, 
					   D04.UnitName, D17.ActualQuantity, D17.ConvertedAmount, ''BC'' AS D_C, ISNULL(D03.IsTemp,0) AS IsTemp, D03.FullName AS WHFullName,
					   D17.ConvertedQuantity, 0 AS DebitConvertedQuantity, 0 AS CreditConvertedQuantity
			      FROM AT2017 D17 WITH (NOLOCK)
			     INNER JOIN AT2016 D16 WITH (NOLOCK) ON D16.DivisionID = D17.DivisionID AND D16.VoucherID = D17.VoucherID
			     INNER JOIN AT1302 D02 WITH (NOLOCK) ON D02.DivisionID IN (D17.DivisionID,''@@@'') AND D02.InventoryID = D17.InventoryID
			      LEFT JOIN AT1304 D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID AND D04.DivisionID '+@sDivision+'
			     INNER JOIN AT1303 D03 WITH (NOLOCK) ON D03.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND D03.WareHouseID = D16.WareHouseID
			     WHERE ISNULL(D17.CreditAccountID,'''') <>''''	
		'
		SET @sSQL_Temp02_2=N'
		UNION ALL
			SELECT D07.DivisionID, D06.WarehouseID, D03.WarehouseName, D06.VoucherDate, D07.TranMonth, D07.TranYear,
			       D07.InventoryID, D02.InventoryName, D02.RefInventoryID, D02.UnitID, D02.Barcode,
			       D02.S1, D02.S2, D02.S3, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, 
			       D02.VATPercent, D02.InventoryTypeID, D02.Specification, 
			       D02.Notes01, D02.Notes02, D02.Notes03,
			       D02.Varchar01, D02.Varchar02, D02.Varchar03, D02.Varchar04, D02.Varchar05, 
			       D04.UnitName, D07.ActualQuantity, D07.ConvertedAmount, ''D'' AS D_C, isnull(D03.IsTemp,0) AS IsTemp, D03.FullName AS WHFullName,
			       D07.ConvertedQuantity, D07.ConvertedQuantity as DebitConvertedQuantity , 0 as CreditConvertedQuantity
			  FROM AT2007 D07 WITH (NOLOCK)
			 INNER JOIN AT2006 D06 WITH (NOLOCK) ON D06.DivisionID = D07.DivisionID AND D06.VoucherID = D07.VoucherID
			 INNER JOIN AT1302 D02 WITH (NOLOCK) ON D02.DivisionID IN (D07.DivisionID,''@@@'') AND D02.InventoryID = D07.InventoryID
			  LEFT JOIN AT1304 D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID AND D04.DivisionID '+@sDivision+'
			 INNER JOIN AT1303 D03 WITH (NOLOCK) ON D03.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND D03.WareHouseID = D06.WareHouseID
			 WHERE D06.KindVoucherID in (1'+CASE WHEN Isnull(@LstWareHouseID,'''') = '' THEN '' ELSE ',3' END +',5,7,9)
		UNION ALL
			SELECT D07.DivisionID, CASE WHEN D06.KindVoucherID = 3 THEN D06.WareHouseID2 ELSE D06.WareHouseID END AS WarehouseID, 
				   D03.WarehouseName, D06.VoucherDate, D07.TranMonth, D07.TranYear,
				   D07.InventoryID, D02.InventoryName, D02.RefInventoryID, D02.UnitID, D02.Barcode,
				   D02.S1, D02.S2, D02.S3, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, 
				   D02.VATPercent, D02.InventoryTypeID, D02.Specification, 
				   D02.Notes01, D02.Notes02, D02.Notes03,
				   D02.Varchar01, D02.Varchar02, D02.Varchar03, D02.Varchar04, D02.Varchar05, 
				   D04.UnitName, D07.ActualQuantity, D07.ConvertedAmount, ''C'' AS D_C, isnull(D03.IsTemp,0) AS IsTemp, D03.FullName AS WHFullName,
				   D07.ConvertedQuantity, 0 AS DebitConvertedQuantity, D07.ConvertedQuantity AS CreditConvertedQuantity
			  FROM AT2007 AS D07 WITH (NOLOCK)
			 INNER JOIN AT2006 AS D06 WITH (NOLOCK) ON D06.DivisionID = D07.DivisionID AND D06.VoucherID = D07.VoucherID
			 INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D07.DivisionID,''@@@'') AND D02.InventoryID = D07.InventoryID
			  LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID  AND D04.DivisionID '+@sDivision+'
			 INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND D03.WareHouseID = D06.WareHouseID
			 WHERE D06.KindVoucherID in (2'+CASE WHEN Isnull(@LstWareHouseID,'''') = '' THEN '' ELSE ',3' END +',4,10)
		)	AV7001	
		WHERE AV7001.DivisionID IN ( ''' + @DivisionID + ''', ''@@@'') 
		  AND AV7001.TranMonth + 100 * AV7001.TranYear BETWEEN ''' + @FromMonthYearText + ''' AND ''' + @ToMonthYearText + ''''

		EXEC (@sSQL_Temp02+@sSQL_Temp02_2)
		PRINT @sSQL_Temp02
		PRINT @sSQL_Temp02_2

		SET @sSQL1 = N' 
			SELECT AT2008.DivisionID, AT2008.InventoryID, 
				   AT1302.InventoryName, 
				   AT1302.RefInventoryID, 
				   AT1302.UnitID, AT1304.UnitName,
				   AT1302.VATPercent, AT1302.Barcode,		
				   AT1309.UnitID AS ConversionUnitID, AT1309.ConversionFactor, AT1309.Operator, 
				   AT1302.S1, AT1302.S2, AT1302.S3, AT1302.I01ID, 
				   AT1302.I02ID, AT1302.I03ID, AT1302.I04ID, AT1302.I05ID, AT1302.InventoryTypeID, AT1302.Specification, 
				   AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, 
				   AT1302.Varchar01, AT1302.Varchar02, AT1302.Varchar03, AT1302.Varchar04, AT1302.Varchar05,
				   SUM(CASE WHEN AT2008.TranMonth + AT2008.TranYear * 100 = ' + @FromMonthYearText + '
				   	THEN ISNULL(BeginQuantity, 0) ELSE 0 END) AS BeginQuantity, 
				   SUM(CASE WHEN AT2008.TranMonth + AT2008.TranYear * 100 = ' + @ToMonthYearText + '
				   	THEN ISNULL(EndQuantity, 0) ELSE 0 END) AS EndQuantity, 
				   '+CASE WHEN Isnull(@LstWareHouseID,'') = '' THEN 'SUM(ISNULL(AT2008.DebitQuantity, 0) - ISNULL(AT2008.InDebitQuantity, 0))' ELSE 'SUM(ISNULL(AT2008.DebitQuantity, 0))' END +' AS DebitQuantity, 
				   '+CASE WHEN Isnull(@LstWareHouseID,'') = '' THEN 'SUM(ISNULL(AT2008.CreditQuantity, 0) -ISNULL(AT2008.InCreditQuantity, 0))' ELSE'SUM(ISNULL(AT2008.CreditQuantity, 0))' END +'AS CreditQuantity, 
				   SUM(CASE WHEN AT2008.TranMonth + AT2008.TranYear * 100 = ' + @FromMonthYearText + '
				   	THEN ISNULL(AT2008.BeginAmount, 0) ELSE 0 END) AS BeginAmount, 
				   SUM(CASE WHEN AT2008.TranMonth + AT2008.TranYear * 100 = ' + @ToMonthYearText + '
				   	THEN ISNULL(AT2008.EndAmount, 0) ELSE 0 END) AS EndAmount, 
				   '+CASE WHEN Isnull(@LstWareHouseID,'') = '' THEN 'SUM(ISNULL(AT2008.DebitAmount, 0) - ISNULL(AT2008.InDebitAmount, 0))' ELSE 'SUM(ISNULL(AT2008.DebitAmount, 0)) 'END +'  AS DebitAmount, 
				   '+CASE WHEN Isnull(@LstWareHouseID,'') = '' THEN 'SUM(ISNULL(AT2008.CreditAmount, 0) - ISNULL(AT2008.InCreditAmount, 0))'ELSE'SUM(ISNULL(AT2008.CreditAmount, 0))'  END +' AS CreditAmount, 
				   SUM(ISNULL(AT2008.InDebitAmount, 0)) AS InDebitAmount, 
				   SUM(ISNULL(AT2008.InCreditAmount, 0)) AS InCreditAmount, 
				   SUM(ISNULL(AT2008.InDebitQuantity, 0)) AS InDebitQuantity, 
				   SUM(ISNULL(AT2008.InCreditQuantity, 0)) AS InCreditQuantity, 
				   ISNULL(#Temp.ConvertedQuantity, 0) AS BeginConvertedQuantity,
				   ISNULL(#Temp.ConvertedUnitID,'''') AS ConvertedUnitID,
				   ISNULL(#Temp2.DebitConvertedQuantity,0) AS DebitConvertedQuantity,
				   ISNULL(#Temp2.CreditConvertedQuantity, 0) AS CreditConvertedQuantity	'

		SET @sSQL2 = N'
			    INTO ##AV3098'+LTRIM(@@SPID)+'
				 FROM AT2008 WITH(NOLOCK)
				INNER JOIN AT1302 WITH(NOLOCK) ON AT1302.DivisionID IN (AT2008.DivisionID,''@@@'') AND AT1302.InventoryID = AT2008.InventoryID
				 LEFT JOIN AT1304 WITH(NOLOCK) ON AT1302.DivisionID '+@sDivision+' AND AT1304.UnitID = AT1302.UnitID AND AT1304.DivisionID '+@sDivision+'
				INNER JOIN AT1303 WITH(NOLOCK) ON AT1303.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1303.WareHouseID = AT2008.WareHouseID
				 LEFT JOIN AT1309 WITH(NOLOCK) ON AT1309.InventoryID = AT2008.InventoryID AND AT1309.UnitID = AT1302.UnitID
				 LEFT JOIN #Temp2 ON AT2008.DivisionID = #Temp2.DivisionID AND AT2008.InventoryID = #Temp2.InventoryID
				 LEFT JOIN #Temp ON AT2008.DivisionID = #Temp.DivisionID AND AT2008.InventoryID = #Temp.InventoryID
				WHERE AT1303.IsTemp = 0 
				  AND AT2008.DivisionID LIKE ''' + @DivisionID + '''
				  AND AT2008.InventoryID BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + '''
				  AND AT2008.TranMonth + AT2008.TranYear * 100 BETWEEN ' + @FromMonthYearText + ' AND ' + @ToMonthYearText + ''

			SET @sSQL2a =N'AND AT2008.WareHouseID NOT IN (''' + ISNULL(@LstWareHouseID,'') + ''')'

			SET @sSQL2b=N'
			GROUP BY AT2008.DivisionID, AT2008.InventoryID, AT1302.InventoryName, AT1302.RefInventoryID, AT1302.UnitID, AT1304.UnitName, AT1302.VATPercent, AT1302.Barcode,
				     AT1309.UnitID, AT1309.ConversionFactor, AT1309.Operator, 
				     AT1302.S1, AT1302.S2, AT1302.S3, AT1302.I01ID, AT1302.I02ID, AT1302.I03ID, AT1302.I04ID, AT1302.I05ID, 
				     AT1302.InventoryTypeID, AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03,
				     AT1302.Varchar01, AT1302.Varchar02, AT1302.Varchar03, AT1302.Varchar04, AT1302.Varchar05, 
				     #Temp.ConvertedQuantity, #Temp.ConvertedUnitID,
					 #Temp2.DebitConvertedQuantity,
					 #Temp2.CreditConvertedQuantity
					 '
			PRINT @sSQL1
			PRINT @sSQL2
			PRINT @sSQL01
			PRINT @sSQL01_1
			PRINT @sSQL2a
			PRINT @sSQL2b
			EXEC(@sSQL_Temp01 + @sSQL_Temp01_1 + @sSQL_Temp02 + @sSQL_Temp02_2 + @sSQL1 + @sSQL2 + @sSQL2a + @sSQL2b)
		
		END
		ELSE -- theo ngay
			BEGIN
				IF Month(@ToDate) > 3 BEGIN SET @3MonthPrevious = Month(@ToDate) - 3  SET @YearPrevious = YEAR(@ToDate) END
				ELSE BEGIN SET @3MonthPrevious = 9 + Month(@ToDate) SET @YearPrevious = Month(@ToDate) - 1 END
			
				SET @sSQL1 = N'
					SELECT V7.DivisionID, V7.InventoryID, V7.InventoryName, V7.RefInventoryID,  V7.UnitID, V7.Barcode,
					V7.S1, V7.S2, V7.S3, V7.I01ID, V7.I02ID, V7.I03ID, V7.I04ID, V7.I05ID, 
					V7.UnitName, V7.VATPercent, V7.InventoryTypeID, V7.Specification, 
					V7.Notes01, V7.Notes02, V7.Notes03, 
					V7.Varchar01, V7.Varchar02, V7.Varchar03, V7.Varchar04, V7.Varchar05,
					SUM(V7.BeginQuantity) AS BeginQuantity, 
					SUM(V7.BeginAmount) AS BeginAmount
					'
				SET @sSQL2 = N' INTO ##AV7016'+LTRIM(@@SPID)+'
					FROM (
						-- Số dư nợ
						SELECT D17.DivisionID, D16.WareHouseID, D03.WarehouseName, D03.FullName AS WHFullName, D16.VoucherDate,
						D17.InventoryID, D02.InventoryName, D02.RefInventoryID,  D02.UnitID, D02.Barcode,
						D02.S1, D02.S2, D02.S3, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, 
						D04.UnitName, D02.VATPercent, D02.InventoryTypeID, D02.Specification, 
						D02.Notes01 as Notes01, D02.Notes02 as Notes02, D02.Notes03 as Notes03, 
						D02.Varchar01, D02.Varchar02, D02.Varchar03, D02.Varchar04, D02.Varchar05,
						D17.ActualQuantity AS BeginQuantity, 
						D17.ConvertedAmount AS BeginAmount,''BD'' AS D_C
						FROM AT2017 D17 WITH (NOLOCK)
						INNER JOIN AT2016 D16 WITH (NOLOCK) ON D16.VoucherID = D17.VoucherID AND D16.DivisionID = D17.DivisionID
						INNER JOIN AT1302 D02 WITH (NOLOCK) ON D02.DivisionID IN (D17.DivisionID,''@@@'') AND D02.InventoryID = D17.InventoryID
						LEFT JOIN AT1304 D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID AND D04.DivisionID '+@sDivision+'
						INNER JOIN AT1303 D03 WITH (NOLOCK) ON D03.DivisionID IN ('''+@DivisionID+''',''@@@'') AND D03.WareHouseID = D16.WareHouseID
						Where isnull(D17.DebitAccountID,'''') <>''''
					'
				SET @sSQL2a=N'	
						UNION ALL -- Số dư có
						SELECT D17.DivisionID, D16.WareHouseID, D03.WareHouseName, D03.FullName AS WHFullName, D16.VoucherDate,
						D17.InventoryID, D02.InventoryName, D02.RefInventoryID, D02.UnitID, D02.Barcode,
						D02.S1, D02.S2, D02.S3, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, 
						D04.UnitName, D02.VATPercent, D02.InventoryTypeID, D02.Specification, 
						D02.Notes01 as Notes01, D02.Notes02 as Notes02, D02.Notes03 as Notes03, 
						D02.Varchar01, D02.Varchar02, D02.Varchar03, D02.Varchar04, D02.Varchar05,
						-D17.ActualQuantity AS BeginQuantity, 
						-D17.ConvertedAmount AS BeginAmount,''BC'' AS D_C
						FROM AT2017 AS D17 WITH (NOLOCK)
						INNER JOIN AT2016 AS D16 WITH (NOLOCK) ON D16.VoucherID = D17.VoucherID AND D16.DivisionID = D17.DivisionID
						INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D17.DivisionID,''@@@'') AND D02.InventoryID = D17.InventoryID
						LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID AND D04.DivisionID '+@sDivision+'
						INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND D03.WareHouseID = D16.WareHouseID
						Where isnull(D17.CreditAccountID,'''') <>'''' 
					'
				SET @sSQL2b=N'
						UNION ALL -- Nhập kho
						SELECT D07.DivisionID, D06.WareHouseID, D03.WareHouseName, D03.FullName AS WHFullName, D06.VoucherDate,
						D07.InventoryID, D02.InventoryName, D02.RefInventoryID, D02.UnitID, D02.Barcode,
						D02.S1, D02.S2, D02.S3, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, 
						D04.UnitName, D02.VATPercent, D02.InventoryTypeID, D02.Specification, 
						D02.Notes01 as Notes01, D02.Notes02 as Notes02, D02.Notes03 as Notes03, 
						D02.Varchar01, D02.Varchar02, D02.Varchar03, D02.Varchar04, D02.Varchar05,
						D07.ActualQuantity AS BeginQuantity, 
						D07.ConvertedAmount AS BeginAmount,''D'' AS D_C
						FROM AT2007 AS D07 WITH (NOLOCK)
						INNER JOIN AT2006 AS D06 WITH (NOLOCK) ON D06.VoucherID = D07.VoucherID AND D06.DivisionID = D07.DivisionID
						INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D07.DivisionID,''@@@'') AND D02.InventoryID = D07.InventoryID
						LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID AND D04.DivisionID '+@sDivision+'
						INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID '+@sDivision+' AND D03.WareHouseID = D06.WareHouseID
						Where D06.KindVoucherID in (1'+CASE WHEN Isnull(@LstWareHouseID,'') = '' THEN '' ELSE ',3' END +',5,7,9,15,17) AND Isnull(D06.TableID,'''') <> ''AT0114''
					'
				SET @sSQL2c=N'
						UNION ALL -- XUất kho
						SELECT D07.DivisionID, CASE WHEN D06.KindVoucherID = 3 then D06.WareHouseID2 Else  D06.WareHouseID End AS WarehouseID, 
						D03.WarehouseName, 
						D03.FullName AS WHFullName, D06.VoucherDate,
						D07.InventoryID, D02.InventoryName, D02.RefInventoryID, D02.UnitID, D02.Barcode,
						D02.S1, D02.S2, D02.S3, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, 
						D04.UnitName, D02.VATPercent, D02.InventoryTypeID, D02.Specification, 
						D02.Notes01 as Notes01, D02.Notes02 as Notes02, D02.Notes03 as Notes03, 
						D02.Varchar01, D02.Varchar02, D02.Varchar03, D02.Varchar04, D02.Varchar05,
						-D07.ActualQuantity AS BeginQuantity, 
						-D07.ConvertedAmount AS BeginAmount,''C'' AS D_C
						FROM AT2007 AS D07 WITH (NOLOCK)
						INNER JOIN AT2006 AS D06 WITH (NOLOCK) ON D06.VoucherID = D07.VoucherID AND D06.DivisionID = D07.DivisionID
						INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D07.DivisionID,''@@@'') AND D02.InventoryID = D07.InventoryID
						LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID  AND D04.DivisionID '+@sDivision+'
						INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND D03.WareHouseID = CASE WHEN D06.KindVoucherID = 3 then D06.WareHouseID2 Else  D06.WareHouseID End
						Where D06.KindVoucherID in (2'+CASE WHEN Isnull(@LstWareHouseID,'') = '' THEN '' ELSE ',3' END +',4,6,8,10,14,20)
						) V7			
						WHERE V7.DivisionID LIKE ''' + @DivisionID + '''
						'+CASE WHEN  @CustomerName = 49 THEN 'AND ISNULL(V7.WHFullName,'''') <> ''1'' ' ELSE ''END  +'
						AND (V7.VoucherDate < ''' + @FromDateText + ''' OR V7.D_C = ''BD'')
						AND V7.InventoryID BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + ''''
		SET @sSQL2d = N'AND V7.WareHouseID not in (''' + Isnull(@LstWareHouseID,'') + ''')'
		SET @sSQL2e = N'GROUP BY V7.DivisionID, V7.InventoryID, V7.InventoryName, V7.RefInventoryID, V7.UnitID, V7.Barcode,
								 V7.S1, V7.S2, V7.S3, V7.I01ID, V7.I02ID, V7.I03ID, V7.I04ID, V7.I05ID, 
								 V7.UnitName, V7.VATPercent, V7.InventoryTypeID, V7.Specification, 
								 V7.Notes01, V7.Notes02, V7.Notes03, V7.Varchar01, V7.Varchar02, V7.Varchar03, V7.Varchar04, V7.Varchar05
						'
		print @sSQL1
		print @sSQL2
		print @sSQL2a
		print @sSQL2b
		print @sSQL2c
		print @sSQL3
		print @sSQL2d
		print @sSQL2e
		EXEC(@sSQL1 + @sSQL2 + @sSQL2a + @sSQL2b + @sSQL2c + @sSQL3 + @sSQL2d + @sSQL2e)

		
		SET @sSQL1 = N'
		SELECT AV7016.DivisionID, InventoryID, InventoryName,RefInventoryID, UnitID, Barcode,
		S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, VATPercent, InventoryTypeID, Specification, 
		Notes01, Notes02, Notes03, 
		Varchar01,Varchar02,Varchar03,Varchar04,Varchar05,
		UnitName, 
		BeginQuantity, 
		BeginAmount, 
		0 AS DebitQuantity, 
		0 AS CreditQuantity, 
		0 AS DebitAmount, 
		0 AS CreditAmount, 
		0 AS EndQuantity, 
		0 AS EndAmount
		'
		SET @sSQL2 = N' INTO ##AV3088'+LTRIM(@@SPID)+'
		FROM ##AV7016'+LTRIM(@@SPID)+' AV7016
		--WHERE AV7016.InventoryID NOT IN 
		--(
		--SELECT InventoryID 
		--FROM AV7001 AV7000 
		--WHERE AV7000.DivisionID LIKE ''' + @DivisionID + ''' 
		--AND AV7000.InventoryID BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + '''
		--AND AV7000.D_C IN (''D'', ''C'') 
		--AND AV7000.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''')
		--AND AV7016.DivisionID LIKE ''' + @DivisionID + ''' 
		'
		SET @sSQL2a = N'
		UNION ALL

		SELECT AV7001.DivisionID, 
		AV7001.InventoryID, AV7001.InventoryName, RefInventoryID,AV7001.UnitID, Barcode,
		AV7001.S1, AV7001.S2, AV7001.S3, AV7001.I01ID, AV7001.I02ID, AV7001.I03ID, AV7001.I04ID, AV7001.I05ID, 
		AV7001.VATPercent, AV7001.InventoryTypeID, AV7001.Specification, 
		AV7001.Notes01, AV7001.Notes02, AV7001.Notes03,
		AV7001.Varchar01,AV7001.Varchar02,AV7001.Varchar03,AV7001.Varchar04,AV7001.Varchar05, 
		AV7001.UnitName, 
		0 AS BeginQuantity, 
		0 AS BeginAmount, 
		SUM(CASE WHEN D_C = ''D'' THEN ISNULL(AV7001.ActualQuantity, 0) ELSE 0 END) AS DebitQuantity, 
		SUM(CASE WHEN D_C = ''C'' THEN ISNULL(AV7001.ActualQuantity, 0) ELSE 0 END) AS CreditQuantity, 
		SUM(CASE WHEN D_C = ''D'' THEN ISNULL(AV7001.ConvertedAmount, 0) ELSE 0 END) AS DebitAmount, 
		SUM(CASE WHEN D_C = ''C'' THEN ISNULL(AV7001.ConvertedAmount, 0) ELSE 0 END) AS CreditAmount, 
		0 AS EndQuantity, 
		0 AS EndAmount
		'

		SET @sSQL2b =N'
		FROM ( -- Số dư nợ
			SELECT D17.DivisionID, D16.WarehouseID, D03.WarehouseName, D16.VoucherDate,
			D17.InventoryID, D02.InventoryName, D02.RefInventoryID,D02.UnitID, D02.Barcode,
			D02.S1, D02.S2, D02.S3, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, 
			D02.VATPercent, D02.InventoryTypeID, D02.Specification, 
			D02.Notes01, D02.Notes02, D02.Notes03,
			D02.Varchar01, D02.Varchar02, D02.Varchar03, D02.Varchar04, D02.Varchar05, 
			D04.UnitName, D17.ActualQuantity, D17.ConvertedAmount, ''BD'' AS D_C, isnull(D03.IsTemp,0) AS IsTemp, D03.FullName AS WHFullName
			FROM AT2017 AS D17 WITH (NOLOCK)
			INNER JOIN AT2016 AS D16 WITH (NOLOCK) ON D16.DivisionID = D17.DivisionID AND D16.VoucherID = D17.VoucherID
			INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D17.DivisionID,''@@@'') AND D02.InventoryID = D17.InventoryID
			LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID
			INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND D03.WareHouseID = D16.WareHouseID
			Where isnull(D17.DebitAccountID,'''') <>''''
			UNION ALL -- Số dư có
			SELECT D17.DivisionID, D16.WarehouseID, D03.WarehouseName, D16.VoucherDate,
			D17.InventoryID, D02.InventoryName, D02.RefInventoryID, D02.UnitID, D02.Barcode,
			D02.S1, D02.S2, D02.S3, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, 
			D02.VATPercent, D02.InventoryTypeID, D02.Specification, 
			D02.Notes01, D02.Notes02, D02.Notes03,
			D02.Varchar01, D02.Varchar02, D02.Varchar03, D02.Varchar04, D02.Varchar05, 
			D04.UnitName, D17.ActualQuantity, D17.ConvertedAmount, ''BC'' AS D_C, isnull(D03.IsTemp,0) AS IsTemp, D03.FullName AS WHFullName
			FROM AT2017 AS D17 WITH (NOLOCK)
			INNER JOIN AT2016 AS D16 WITH (NOLOCK) ON D16.DivisionID = D17.DivisionID AND D16.VoucherID = D17.VoucherID
			INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D17.DivisionID,''@@@'') AND D02.InventoryID = D17.InventoryID
			LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID AND D04.DivisionID '+@sDivision+'
			INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND D03.WareHouseID = D16.WareHouseID
			Where isnull(D17.CreditAccountID,'''') <>''''		 
		'
		SET @sSQL2c=N'
			UNION ALL
			SELECT D07.DivisionID, D06.WarehouseID, D03.WarehouseName, D06.VoucherDate,
			D07.InventoryID, D02.InventoryName, D02.RefInventoryID, D02.UnitID, D02.Barcode,
			D02.S1, D02.S2, D02.S3, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, 
			D02.VATPercent, D02.InventoryTypeID, D02.Specification, 
			D02.Notes01, D02.Notes02, D02.Notes03,
			D02.Varchar01, D02.Varchar02, D02.Varchar03, D02.Varchar04, D02.Varchar05, 
			D04.UnitName, D07.ActualQuantity, D07.ConvertedAmount, ''D'' AS D_C, isnull(D03.IsTemp,0) AS IsTemp, D03.FullName AS WHFullName
			FROM AT2007 AS D07 WITH (NOLOCK)
			INNER JOIN AT2006 AS D06 WITH (NOLOCK) ON D06.DivisionID = D07.DivisionID AND D06.VoucherID = D07.VoucherID
			INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D07.DivisionID,''@@@'') AND D02.InventoryID = D07.InventoryID
			LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID AND D04.DivisionID '+@sDivision+'
			INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND D03.WareHouseID = D06.WareHouseID
			Where D06.KindVoucherID in (1'+CASE WHEN Isnull(@LstWareHouseID,'') = '' THEN '' ELSE ',3' END +',5,7,9)
			UNION ALL
			SELECT D07.DivisionID, CASE WHEN D06.KindVoucherID = 3 then D06.WareHouseID2 Else  D06.WareHouseID End AS WarehouseID
			, D03.WarehouseName, D06.VoucherDate,
			D07.InventoryID, D02.InventoryName, D02.RefInventoryID, D02.UnitID, D02.Barcode,
			D02.S1, D02.S2, D02.S3, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, 
			D02.VATPercent, D02.InventoryTypeID, D02.Specification, 
			D02.Notes01, D02.Notes02, D02.Notes03,
			D02.Varchar01, D02.Varchar02, D02.Varchar03, D02.Varchar04, D02.Varchar05, 
			D04.UnitName, D07.ActualQuantity, D07.ConvertedAmount, ''C'' AS D_C, isnull(D03.IsTemp,0) AS IsTemp, D03.FullName AS WHFullName
			FROM AT2007 AS D07 WITH (NOLOCK)
			INNER JOIN AT2006 AS D06 WITH (NOLOCK) ON D06.DivisionID = D07.DivisionID AND D06.VoucherID = D07.VoucherID
			INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D07.DivisionID,''@@@'') AND D02.InventoryID = D07.InventoryID
			LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID  AND D04.DivisionID '+@sDivision+'
			INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND D03.WareHouseID = D06.WareHouseID
			Where D06.KindVoucherID in (2'+CASE WHEN Isnull(@LstWareHouseID,'') = '' THEN '' ELSE ',3' END +',4,10)
		)	AV7001
		'
		SET @sSQL3=N'
		WHERE AV7001.IsTemp = 0 	
		'+CASE WHEN @CustomerName = 49 THEN 'AND ISNULL(AV7001.WHFullName,'''') <> ''1'' ' ELSE '' END  +'	
		AND AV7001.D_C IN (''D'', ''C'') 
		AND AV7001.DivisionID LIKE ''' + @DivisionID + ''' 
		AND AV7001.InventoryID BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + '''
		AND AV7001.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''''

		SET @sSQL2d =N'AND AV7001.WareHouseID not in (''' + Isnull(@LstWareHouseID,'') + ''')'

		SET @sSQL2e =N'GROUP BY AV7001.DivisionID, AV7001.InventoryID, AV7001.InventoryName, AV7001.RefInventoryID, AV7001.UnitID, AV7001.Barcode, AV7001.UnitName, 
		AV7001.S1, AV7001.S2, AV7001.S3, AV7001.I01ID, AV7001.I02ID, AV7001.I03ID, AV7001.I04ID, AV7001.I05ID, 
		AV7001.VATPercent, AV7001.InventoryTypeID, AV7001.Specification, 
		AV7001.Notes01, AV7001.Notes02, AV7001.Notes03,
		AV7001.Varchar01,AV7001.Varchar02,AV7001.Varchar03,AV7001.Varchar04,AV7001.Varchar05
		'
	
		PRINT @sSQL1  Print  @sSQL2  Print  @sSQL2a  Print  @sSQL2b  Print  @sSQL2c  Print  @sSQL3 Print @sSQL2d Print @sSQL2e
		EXEC(@sSQL1 + @sSQL2 + @sSQL2a + @sSQL2b + @sSQL2c + @sSQL3+@sSQL2d+@sSQL2e)


		SET @sSQL1 = N'
			SELECT AV3088.InventoryID, 
			       InventoryName, RefInventoryID,
			       AV3088.UnitID, 
			       UnitName, AV3088.VATPercent, Barcode, AV3088.InventoryTypeID, Specification, 
			       AV3088.Notes01, AV3088.Notes02, AV3088.Notes03, 
			       AV3088.Varchar01,AV3088.Varchar02,AV3088.Varchar03,AV3088.Varchar04,AV3088.Varchar05, 
			       AT1309.UnitID AS ConversionUnitID, AT1309.ConversionFactor, AT1309.Operator, 
			       S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, 
			       SUM(BeginQuantity) AS BeginQuantity, 
			       SUM(BeginAmount) AS BeginAmount, 
			       SUM(DebitQuantity) AS DebitQuantity, 
			       SUM(CreditQuantity) AS CreditQuantity, 
			       SUM(DebitAmount) AS DebitAmount, 
			       SUM(CreditAmount) AS CreditAmount, 
			       0 AS InDebitAmount, 0 AS InCreditAmount, 0 AS InDebitQuantity, 
			       0 AS InCreditQuantity, 
			       SUM(BeginQuantity) + SUM(DebitQuantity) - SUM(CreditQuantity) AS EndQuantity, 
			       SUM(BeginAmount) + SUM(DebitAmount) - SUM(CreditAmount) AS EndAmount, AV3088.DivisionID 
			'

		SET @sSQL2 = N' INTO ##AV3098'+LTRIM(@@SPID)+'
			FROM ##AV3088'+LTRIM(@@SPID)+' AV3088 
			LEFT JOIN AT1309 WITH(NOLOCK) ON AT1309.InventoryID = AV3088.InventoryID AND AT1309.UnitID = AV3088.UnitID AND AT1309.DivisionID IN (''@@@'',AV3088.DivisionID)

			GROUP BY S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, 
			AV3088.InventoryID, InventoryName,RefInventoryID, AV3088.UnitID, UnitName, 
			AT1309.UnitID, AT1309.ConversionFactor, AT1309.Operator, 
			--DebitQuantity, DebitAmount, CreditQuantity, CreditAmount, 
			AV3088.VATPercent, Barcode, AV3088.InventoryTypeID, Specification, 
			AV3088.Notes01, AV3088.Notes02, AV3088.Notes03, 
			AV3088.Varchar01,AV3088.Varchar02,AV3088.Varchar03,AV3088.Varchar04,AV3088.Varchar05, 
			AV3088.DivisionID '
			
		PRINT @sSQL1 PRINT  @sSQL2
		EXEC(@sSQL1 + @sSQL2)
			END --- theo ngay -------------------------------------------------------	
	--EXEC(@sSQL1 + @sSQL2 +@sSQL2a+@sSQL2b )

		SET @GroupField1 = (
			SELECT CASE @GroupID1
				WHEN 'CI1' THEN 'S1'
				WHEN 'CI2' THEN 'S2'
				WHEN 'CI3' THEN 'S3'
				WHEN 'I01' THEN 'I01ID'
				WHEN 'I02' THEN 'I02ID'
				WHEN 'I03' THEN 'I03ID'
				WHEN 'I04' THEN 'I04ID'
				WHEN 'I05' THEN 'I05ID' 
			END
			)
			SET @GroupField2 = @GroupField1
			
			SET @GroupField2 = 
			(
				SELECT CASE @GroupID2
					WHEN 'CI1' THEN 'S1'
					WHEN 'CI2' THEN 'S2'
					WHEN 'CI3' THEN 'S3'
					WHEN 'I01' THEN 'I01ID'
					WHEN 'I02' THEN 'I02ID'
					WHEN 'I03' THEN 'I03ID'
					WHEN 'I04' THEN 'I04ID'
					WHEN 'I05' THEN 'I05ID' 
				END
			)

		SET @GroupField1 = ISNULL(@GroupField1, '')
		SET @GroupField2 = ISNULL(@GroupField2, '')
		        
		IF ((@IsGroupID >= 2) AND (@GroupField1 <> '') AND (@GroupField2 <> ''))
		BEGIN
		SET @sSQL1 = N' ---A
			SELECT V1.ID AS GroupID1, V2.ID AS GroupID2, V1.SName AS GroupName1, V2.SName AS GroupName2, 
			       AV3098.InventoryID, S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, 
			       AV3098.InventoryName, RefInventoryID, AV3098.UnitID, AV3098.UnitName, VATPercent, Barcode, AV3098.InventoryTypeID, AV3098.Specification, 
			       AV3098.Notes01, AV3098.Notes02, AV3098.Notes03, 
			       AV3098.Varchar01, AV3098.Varchar02, AV3098.Varchar03, AV3098.Varchar04, AV3098.Varchar05, 
			       AV3098.ConversionUnitID, AV3098.ConversionFactor, AV3098.Operator, 
			       SUM(AV3098.BeginQuantity) AS BeginQuantity, SUM(AV3098.EndQuantity) AS EndQuantity, 
			       CASE WHEN AV3098.ConversionFactor = NULL OR AV3098.ConversionFactor = 0 THEN NULL
			       ELSE ISNULL(SUM(AV3098.EndQuantity), 0) / AV3098.ConversionFactor END AS ConversionQuantity, 
			       SUM(AV3098.DebitQuantity) AS DebitQuantity, 
				   SUM(AV3098.CreditQuantity) AS CreditQuantity, SUM(AV3098.BeginAmount) AS BeginAmount, SUM(AV3098.EndAmount) AS EndAmount, 
			       SUM(AV3098.DebitAmount) AS DebitAmount, SUM(AV3098.CreditAmount) AS CreditAmount, 
			       SUM(AV3098.InDebitAmount) AS InDebitAmount, SUM(AV3098.InCreditAmount) AS InCreditAmount, SUM(AV3098.InDebitQuantity) as InDebitQuantity, 
			       SUM(AV3098.InCreditQuantity) as InCreditQuantity, AV3098.DivisionID,
			       AT1314.MinQuantity, AT1314.MaxQuantity, N'''+@GroupID+''' AS GroupID, AT1401.GroupName,
				   AV3098.BeginConvertedQuantity,
				   AV3098.ConvertedUnitID,
				   AV3098.DebitConvertedQuantity,
				   AV3098.CreditConvertedQuantity,
				   (AV3098.BeginConvertedQuantity) + (AV3098.DebitConvertedQuantity) - (AV3098.CreditConvertedQuantity) AS EndConvertedQuantity
				   '

		SET @sSQL2 = N'
			FROM ##AV3098'+LTRIM(@@SPID)+' AV3098
			LEFT JOIN AV1310 V1 (NOLOCK) ON V1.ID = AV3098.' + @GroupField1 + ' AND V1.TypeID =''' + @GroupID1 + ''' AND V1.DivisionID = AV3098.DivisionID
			LEFT JOIN AV1310 V2 (NOLOCK) ON V2.ID = AV3098.' + @GroupField2 + ' AND V2.TypeID =''' + @GroupID2 + ''' AND V2.DivisionID = AV3098.DivisionID
			LEFT JOIN (	SELECT A.InventoryID, SUM(A.MinQuantity) AS MinQuantity, SUM(A.MaxQuantity) AS MaxQuantity, DivisionID
						FROM AT1314 A WITH(NOLOCK) GROUP BY InventoryID, DivisionID ) AT1314
				   ON AT1314.DivisionID IN (AV3098.DivisionID, ''@@@'') AND AT1314.InventoryID = AV3098.InventoryID
			LEFT JOIN AT1401 WITH (NOLOCK) on AT1401.GroupID = N''' +@GroupID+ ''' AND AT1401.DivisionID = N''' +@DivisionID+ '''
			WHERE ( BeginQuantity <> 0 OR BeginAmount <> 0 OR DebitQuantity <> 0 OR DebitAmount <> 0 OR
			        CreditQuantity <> 0 OR CreditAmount <> 0 OR EndQuantity <> 0 OR EndAmount <>0 )
			  AND AV3098.DivisionID '+@sDivision+'
			GROUP BY V1.ID, V2.ID, V1.SName, V2.SName, 
			         AV3098.InventoryID, S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, 
			         AV3098.InventoryName, RefInventoryID, AV3098.UnitID, AV3098.UnitName, VATPercent, Barcode, AV3098.InventoryTypeID, AV3098.Specification, 
			         AV3098.Notes01, AV3098.Notes02, AV3098.Notes03, 
			         AV3098.Varchar01,AV3098.Varchar02,AV3098.Varchar03,AV3098.Varchar04,AV3098.Varchar05, 
			         AV3098.ConversionUnitID, AV3098.ConversionFactor, AV3098.Operator, 
			         AV3098.DivisionID,  AT1314.MinQuantity, AT1314.MaxQuantity, AT1401.GroupName,
					 AV3098.BeginConvertedQuantity,
					 AV3098.ConvertedUnitID,
				     AV3098.DebitConvertedQuantity,
					 AV3098.CreditConvertedQuantity
			'
			PRINT @sSQL1
			PRINT @sSQL2
	END 
	ELSE IF ((@IsGroupID >= 1) AND ((@GroupField1 <> '') OR (@GroupField2 <> '')))
	BEGIN        
		IF(@GroupField1 = '') SET @GroupField1 = @GroupField2
		SET @sSQL1 = N'
				SELECT V1.ID AS GroupID1, '''' AS GroupID2, 
				       V1.SName AS GroupName1, '''' AS GroupName2, 
				       AV3098.InventoryID, S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, 
				       AV3098.InventoryName, AV3098.RefInventoryID, AV3098.UnitID, AV3098.UnitName, AV3098.VATPercent, Barcode, AV3098.InventoryTypeID, AV3098.Specification, 
				       AV3098.Notes01, AV3098.Notes02, AV3098.Notes03, 
				       AV3098.Varchar01,AV3098.Varchar02,AV3098.Varchar03,AV3098.Varchar04,AV3098.Varchar05, 
				       AV3098.ConversionUnitID, AV3098.ConversionFactor, AV3098.Operator, 
				       AV3098.BeginQuantity, AV3098.EndQuantity, 
				       CASE WHEN AV3098.ConversionFactor = NULL OR AV3098.ConversionFactor = 0 THEN NULL
				       ELSE ISNULL(AV3098.EndQuantity, 0) / AV3098.ConversionFactor END AS ConversionQuantity, 
				       AV3098.DebitQuantity, AV3098.CreditQuantity, AV3098.BeginAmount, AV3098.EndAmount, 
				       AV3098.DebitAmount, AV3098.CreditAmount, 
				       AV3098.InDebitAmount, AV3098.InCreditAmount, AV3098.InDebitQuantity, 
				       AV3098.InCreditQuantity, AV3098.DivisionID,
				       AT1314.MinQuantity, AT1314.MaxQuantity, N'''+@GroupID+''' AS GroupID, AT1401.GroupName'
		
		SET @sSQL2 = N'
				FROM ##AV3098'+LTRIM(@@SPID)+' AV3098 
				LEFT JOIN AV1310 V1 WITH (NOLOCK) ON V1.ID = AV3098.' + @GroupField1 + ' AND V1.TypeID =''' + @GroupID1 + ''' AND V1.DivisionID = AV3098.DivisionID
				LEFT JOIN (	SELECT A.InventoryID, SUM(A.MinQuantity) AS MinQuantity, SUM(A.MaxQuantity) AS MaxQuantity, DivisionID
				FROM AT1314 A WITH(NOLOCK) GROUP BY InventoryID, DivisionID ) AT1314
				ON		AT1314.DivisionID IN (''@@@'', AV3098.DivisionID) AND AT1314.InventoryID = AV3098.InventoryID
				LEFT JOIN AT1401 WITH (NOLOCK) on AT1401.GroupID = N''' +@GroupID+ ''' AND AT1401.DivisionID = N''' +@DivisionID+ '''
				WHERE (BeginQuantity <> 0 OR BeginAmount <> 0 OR DebitQuantity <> 0 OR DebitAmount <> 0 OR
				CreditQuantity <> 0 OR CreditAmount <> 0 OR EndQuantity <> 0 OR EndAmount <>0 )
				AND AV3098.DivisionID '+@sDivision+'
				'
		PRINT @sSQL1
		PRINT @sSQL2

		END     
		ELSE
		BEGIN
			SET @sSQL1 = N'
		     SELECT '''' AS GroupID1, '''' AS GroupID2, '''' AS GroupName1, '''' AS GroupName2, 
		            AV3098.InventoryID, S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, 
		            AV3098.InventoryName, AV3098.RefInventoryID, AV3098.UnitID, AV3098.UnitName, AV3098.VATPercent, Barcode, AV3098.InventoryTypeID, Specification, 
		            AV3098.Notes01, AV3098.Notes02, AV3098.Notes03, 
		            AV3098.Varchar01,AV3098.Varchar02,AV3098.Varchar03,AV3098.Varchar04,AV3098.Varchar05, 
		            AV3098.ConversionUnitID, AV3098.ConversionFactor, AV3098.Operator, 
		            AV3098.BeginQuantity, AV3098.EndQuantity, 
		            CASE WHEN AV3098.ConversionFactor = NULL OR AV3098.ConversionFactor = 0 THEN NULL
		            ELSE ISNULL(AV3098.EndQuantity, 0) / AV3098.ConversionFactor END AS ConversionQuantity, 
		            AV3098.DebitQuantity, AV3098.CreditQuantity, AV3098.BeginAmount, AV3098.EndAmount, 
		            AV3098.DebitAmount, AV3098.CreditAmount, 
		            AV3098.InDebitAmount, AV3098.InCreditAmount, AV3098.InDebitQuantity, 
		            AV3098.InCreditQuantity, AV3098.DivisionID,
		            AT1314.MinQuantity, AT1314.MaxQuantity, N'''+@GroupID+''' AS GroupID, AT1401.GroupName'
		
			SET @sSQL2 = N'
				FROM ##AV3098'+LTRIM(@@SPID)+' AV3098 
				LEFT JOIN (	SELECT A.InventoryID, SUM(A.MinQuantity) AS MinQuantity, SUM(A.MaxQuantity) AS MaxQuantity, DivisionID
							FROM AT1314 A WITH(NOLOCK) GROUP BY InventoryID, DivisionID  ) AT1314
					ON		AT1314.DivisionID IN (''@@@'', AV3098.DivisionID) AND AT1314.InventoryID = AV3098.InventoryID
				LEFT JOIN AT1401 WITH (NOLOCK) on AT1401.GroupID = N''' +@GroupID+ ''' AND AT1401.DivisionID = N''' +@DivisionID+ '''
				WHERE ( BeginQuantity <> 0 OR BeginAmount <> 0 OR DebitQuantity <> 0 OR DebitAmount <> 0 OR
				        CreditQuantity <> 0 OR CreditAmount <> 0 OR EndQuantity <> 0 OR EndAmount <>0 )
				  AND AV3098.DivisionID '+@sDivision+'
				'
			END
	
		EXEC(@sSQL1 + @sSQL2)
		PRINT @sSQL1 
		PRINT @sSQL2
		
		END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
