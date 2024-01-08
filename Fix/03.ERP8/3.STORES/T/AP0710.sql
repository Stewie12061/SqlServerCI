IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0710]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0710]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Lọc theo mã phân tích nghiệp vụ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on by 
---- Modified on 06/11/2006 by Nguyễn Quốc Huy
---- Modified on 22/01/2008 by Đặng Lê Bảo Quỳnh
---- Modified on 22/01/2008 by Thanh Nguyen
---- Modified on 22/11/2011 by Nguyễn Bình Minh: Sửa lỗi không lấy được số liệu số dư đầu kỳ nếu không có số phát sinh
---- Modified on 22/08/2013 by Khanh Van: Lay them thong tin Notes, so luong mark cho 2T
---- Modified on 15/07/2014 by Thanh Sơn: Chuyển lấy dữ liệu trực tiếp từ store, không sinh ra view AV0710
---- Modified on 05/10/2015 by Thanh Thịnh: Group by lại các trường dữ liệu
---- Modified on 11/11/2015 by Bảo Anh: Không lấy số dư cho view phát sinh AV0707
---- Modified on 16/11/2015 by Bảo Anh: Sửa lỗi 1 mặt hàng cùng đối tượng nhưng lên nhiều dòng (bỏ group by theo các trường Notes)
---- Modified by Tiểu Mai on 09/06/2016: Fix bug lọc dữ liệu theo kỳ, theo ngày sai
---- Modified by Tiểu Mai on 24/10/2016: Fix bug lên double dữ liệu phát sinh trong kỳ
---- Modified on 13/04/2017 by Bảo Anh: Cải tiến tốc độ (chuyển view sang bảng tạm)
---- Modified by Bảo Thy on 26/04/2017: Bổ sung in báo cáo theo quy cách
---- Modified by Bảo Thy on 29/06/2017: Bổ sung Địa chỉ kho, 10 mã+tên phân tích theo mặt hàng, Hạn sử dụng, Số dư đầu kỳ/nhập/xuất/tồn lấy theo mã hàng, lô, hạn sử dụng (EIMSKIP)
---- Modified by Bảo Thy on 05/07/2017: Thay Full Join bằng UNION 2 bảng lần lượt LEFT JOIN nhau
---- Modified by Bảo Thy on 06/09/2017: chỉ hiển thị thêm những mặt hàng có tồn đầu kỳ nhưng ko phát sinh nhập xuất trong kỳ (EIMSKIP)
---- Modified on 15/03/2018 by Bảo Anh: Bổ sung ConversionFactor cho SGPT
---- Modified on 21/8/2018 by Kim Thư: Bổ sung load các cột Ana01ID -> Ana10ID từ view AV7000 customerindex=70
---- Modified on 07/11/2018 by Kim Thư: Bổ sung điều kiện join theo Mã phân tích (CustomizeIndex=70 - eimskip)
---- Modified on 15/11/2018 by Kim Thư: Lấy riêng bảng ảo #AV7000 (cải thiện tốc độ)
---- Modified on 27/11/2018 by Kim Thư: Bỏ groupby dư ở @sSQL3
---- Modified on 30/05/2019 by Kim Thư: Thêm trường VATNo, Note, Note1 lên view AV0710 (CustomerName = 36) 
---- Modified on 07/01/2020 by Huỳnh Thử: Thêm trường LimitDate
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Hoài Phong  on 17/11/2020: Fix lỗi lấy điều kiện sai I_010
---- Modified by Huỳnh Thử  on 05/01/2021: Format code
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Nhật Thanh on 22/02/2023: Bổ sung lấy mã tham chiếu từ bảng mặt hàng
---- Modified by Đình Định on 18/05/2023: Bổ sung biến để tách chuỗi.
---- Modified by Đình Định on 07/08/2023: BBL - Bổ sung cột ConvertedUnitID.
---- Modified by Thành Sang on 22/08/2023: Bổ sung điều kiện từ kho đến kho.
---- Modified by Thành Sang on 22/08/2023: Bổ sung thêm cột Lô (SourceNo)
---- Modified by Xuân Nguyên on 22/08/2023: Bổ sung thêm cột WareHouseID và WareHouseName 
---- Modified by Xuân Nguyên on 13/09/2023: Bổ sung lấy ConvertedUnitID từ AV0709 và điều kiện lọc các mã hàng không có nhập xuất tồn
---- Modified by Xuân Nguyên on 28/09/2023: Bổ sung điều kiện join WareHouseID và trường hợp beginQuantity = 0
---- Modified by Hương Nhung on 25/10/2023: [2023/10/IS/0209] Fix lỗi do dư cột (SourceNo) nên UNION không combine được 
---- Modified by Đình Định on 08/12/2023: EIMSKIP - Bổ sung điều kiện lấy mã hàng tồn, không lấy mã hàng đã xuất hết.
---- Modified by Đình Định on 12/12/2023: EIMSKIP - Không sum theo SourceNo.
---- Modified by Kiều Nga on 22/12/2023: EIMSKIP - [2023/12/IS/0216] Fix lỗi load lên không đúng số lượng thực tế còn tồn.
---- Modified by Nhựt Trường on 27/12/2023: 2023/12/IS/0300, Bổ sung load trường hợp có tồn kho nhưng không có phát sinh.
---- Modified by Đình Định on 29/12/2023: EIMSKIP - Bỏ lấy MIN theo SourceNo, để tách các lô.

-- <Example>
---- 
CREATE PROCEDURE [dbo].[AP0710]
(
    @DivisionID       AS NVARCHAR(50),
    @FromWareHouseID  AS nvarchar(50),	
	@ToWareHouseID    AS nvarchar(50),		
    @FromObjectID     AS NVARCHAR(50),
    @ToObjectID       AS NVARCHAR(50),
    @FromInventoryID  AS NVARCHAR(50),
    @ToInventoryID    AS NVARCHAR(50),
    @FromMonth        AS INT,
    @FromYear         AS INT,
    @ToMonth          AS INT,
    @ToYear           AS INT,
    @FromDate         AS DATETIME,
    @ToDate           AS DATETIME,
    @IsDate           AS TINYINT,
    @FromAna01ID      NVARCHAR(50) = NULL,
    @ToAna01ID        NVARCHAR(50) = NULL,
    @FromAna02ID      NVARCHAR(50) = NULL,
    @ToAna02ID        NVARCHAR(50) = NULL,
    @FromAna03ID      NVARCHAR(50) = NULL,
    @ToAna03ID        NVARCHAR(50) = NULL,
    @FromAna04ID      NVARCHAR(50) = NULL,
    @ToAna04ID        NVARCHAR(50) = NULL,
    @FromAna05ID      NVARCHAR(50) = NULL,
    @ToAna05ID        NVARCHAR(50) = NULL,
    @FromAna06ID      NVARCHAR(50) = NULL,
    @ToAna06ID        NVARCHAR(50) = NULL,
    @FromAna07ID      NVARCHAR(50) = NULL,
    @ToAna07ID        NVARCHAR(50) = NULL,
    @FromAna08ID      NVARCHAR(50) = NULL,
    @ToAna08ID        NVARCHAR(50) = NULL,
    @FromAna09ID      NVARCHAR(50) = NULL,
    @ToAna09ID        NVARCHAR(50) = NULL,
    @FromAna10ID      NVARCHAR(50) = NULL,
    @ToAna10ID        NVARCHAR(50) = NULL
)
AS
DECLARE @sSQL1           AS VARCHAR(max),
		@sSQL2           AS VARCHAR(max),
		@sSQL3           AS VARCHAR(max),
		@sSQL4           AS VARCHAR(max),
		@sSQL4_01          NVARCHAR(MAX),
		@sSQL4A           AS VARCHAR(max),
		@sSQL5           AS VARCHAR(max),
		@sSQL5a           AS VARCHAR(max)='',
		@sSQL6           AS VARCHAR(max),
		@sSQL6a           AS VARCHAR(max),
		@sSQL7           AS VARCHAR(max),
		@sSQL7_EIMSKIP NVARCHAR(MAX) = N'',
		@sSQL8           AS VARCHAR(max),
        @strTime        AS NVARCHAR(4000),
        @AnaWhere       AS NVARCHAR(4000), 
		@FromMonthYearText NVARCHAR(20), 
		@ToMonthYearText NVARCHAR(20), 
		@FromDateText NVARCHAR(20), 
		@ToDateText NVARCHAR(20), @CustomerName INT,
		@sSQLAV7000_1 AS NVARCHAR(MAX), @sSQLAV7000_1A AS NVARCHAR(MAX),
		@sSQLAV7000_2 AS NVARCHAR(MAX), @sSQLAV7000_2A AS NVARCHAR(MAX),
		@sSQLAV7000_3 AS NVARCHAR(MAX), @sSQLAV7000_4 AS NVARCHAR(MAX),
		@sSQLAV7000_3FROM AS NVARCHAR(MAX), @sSQLAV7000_4FROM AS NVARCHAR(MAX),
		@sSQLWHERE AS NVARCHAR(MAX), @sSQLGroupBy AS NVARCHAR(MAX),
		@sSQLGroupBy_EIMSKIP NVARCHAR(MAX) = N''
    
SET @FromMonthYearText = STR(@FromMonth + @FromYear * 100)
SET @ToMonthYearText = STR(@ToMonth + @ToYear * 100)
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

SET @AnaWhere = ''
SET @sSQL1 = ''
SET @sSQL2 = ''
SET @sSQL3 = ''
SET @sSQLWHERE = ''

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName) 

IF PATINDEX('[%]', @FromAna01ID) > 0
BEGIN
    SET @AnaWhere = @AnaWhere + ' And AV7000.Ana01ID Like N''' + @FromAna01ID + ''''
END
ELSE
	IF @FromAna01ID IS NOT NULL AND @FromAna01ID <> ''
	BEGIN
		SET @AnaWhere = @AnaWhere + ' And Isnull(AV7000.Ana01ID,'''') >= N''' + REPLACE(@FromAna01ID, '[]', '') + 
									''' And Isnull(AV7000.Ana01ID,'''') <= N''' + REPLACE(@ToAna01ID, '[]', '') + ''''
	END	

IF PATINDEX('[%]', @FromAna02ID) > 0
BEGIN
    SET @AnaWhere = @AnaWhere + ' And AV7000.Ana02ID Like N''' + @FromAna02ID + ''''
END
ELSE
	IF @FromAna02ID IS NOT NULL AND @FromAna02ID <> ''
	BEGIN
		SET @AnaWhere = @AnaWhere + ' And Isnull(AV7000.Ana02ID,'''') >= N''' + REPLACE(@FromAna02ID, '[]', '') + 
									''' And Isnull(AV7000.Ana02ID,'''') <= N''' + REPLACE(@ToAna02ID, '[]', '') + ''''
	END	

IF PATINDEX('[%]', @FromAna03ID) > 0
BEGIN
    SET @AnaWhere = @AnaWhere + ' And AV7000.Ana03ID Like N''' + @FromAna03ID + ''''
END
ELSE
	IF @FromAna03ID IS NOT NULL AND @FromAna03ID <> ''
	BEGIN
		SET @AnaWhere = @AnaWhere + ' And Isnull(AV7000.Ana03ID,'''') >= N''' +	REPLACE(@FromAna03ID, '[]', '') + 
									''' And Isnull(AV7000.Ana03ID,'''') <= N''' + REPLACE(@ToAna03ID, '[]', '') + ''''
	END

IF PATINDEX('[%]', @FromAna04ID) > 0
BEGIN
    SET @AnaWhere = @AnaWhere + ' And AV7000.Ana04ID Like N''' + @FromAna04ID + ''''
END
ELSE
	IF @FromAna04ID IS NOT NULL AND @FromAna04ID <> ''
	BEGIN
		SET @AnaWhere = @AnaWhere + ' And Isnull(AV7000.Ana04ID,'''') >= N''' + REPLACE(@FromAna04ID, '[]', '') + 
									''' And Isnull(AV7000.Ana04ID,'''') <= N''' + REPLACE(@ToAna04ID, '[]', '') + ''''
	END	

IF PATINDEX('[%]', @FromAna05ID) > 0
BEGIN
    SET @AnaWhere = @AnaWhere + ' And AV7000.Ana05ID Like N''' + @FromAna05ID + ''''
END
ELSE
	IF @FromAna05ID IS NOT NULL AND @FromAna05ID <> ''
	BEGIN
		SET @AnaWhere = @AnaWhere + ' And Isnull(AV7000.Ana05ID,'''') >= N''' + REPLACE(@FromAna05ID, '[]', '') + 
									''' And Isnull(AV7000.Ana05ID,'''') <= N''' + REPLACE(@ToAna05ID, '[]', '') + ''''
	END
	
IF PATINDEX('[%]', @FromAna06ID) > 0
BEGIN
    SET @AnaWhere = @AnaWhere + ' And AV7000.Ana06ID Like N''' + @FromAna06ID + ''''
END
ELSE
	IF @FromAna06ID IS NOT NULL AND @FromAna06ID <> ''
	BEGIN
		SET @AnaWhere = @AnaWhere + ' And Isnull(AV7000.Ana06ID,'''') >= N''' + REPLACE(@FromAna06ID, '[]', '') + 
									''' And Isnull(AV7000.Ana06ID,'''') <= N''' + REPLACE(@ToAna06ID, '[]', '') + ''''
	END	

IF PATINDEX('[%]', @FromAna07ID) > 0
BEGIN
    SET @AnaWhere = @AnaWhere + ' And AV7000.Ana07ID Like N''' + @FromAna07ID + ''''
END
ELSE
	IF @FromAna07ID IS NOT NULL AND @FromAna07ID <> ''
	BEGIN
		SET @AnaWhere = @AnaWhere + ' And Isnull(AV7000.Ana07ID,'''') >= N''' + REPLACE(@FromAna07ID, '[]', '') + 
									''' And Isnull(AV7000.Ana07ID,'''') <= N''' + REPLACE(@ToAna07ID, '[]', '') + ''''
	END	

IF PATINDEX('[%]', @FromAna08ID) > 0
BEGIN
    SET @AnaWhere = @AnaWhere + ' And AV7000.Ana08ID Like N''' + @FromAna08ID + ''''
END
ELSE
	IF @FromAna08ID IS NOT NULL AND @FromAna08ID <> ''
	BEGIN
		SET @AnaWhere = @AnaWhere + ' And Isnull(AV7000.Ana08ID,'''') >= N''' +	REPLACE(@FromAna08ID, '[]', '') + 
									''' And Isnull(AV7000.Ana08ID,'''') <= N''' + REPLACE(@ToAna08ID, '[]', '') + ''''
	END

IF PATINDEX('[%]', @FromAna09ID) > 0
BEGIN
    SET @AnaWhere = @AnaWhere + ' And AV7000.Ana09ID Like N''' + @FromAna09ID + ''''
END
ELSE
IF @FromAna09ID IS NOT NULL AND @FromAna09ID <> ''
	BEGIN
		SET @AnaWhere = @AnaWhere + ' And Isnull(AV7000.Ana09ID,'''') >= N''' + REPLACE(@FromAna09ID, '[]', '') + 
									''' And Isnull(AV7000.Ana09ID,'''') <= N''' + REPLACE(@ToAna09ID, '[]', '') + ''''
	END	

IF PATINDEX('[%]', @FromAna10ID) > 0
BEGIN
    SET @AnaWhere = @AnaWhere + ' And AV7000.Ana10ID Like N''' + @FromAna10ID + ''''
END
ELSE
	IF @FromAna10ID IS NOT NULL AND @FromAna10ID <> ''
	BEGIN
		SET @AnaWhere = @AnaWhere + ' And Isnull(AV7000.Ana10ID,'''') >= N''' + REPLACE(@FromAna10ID, '[]', '') + 
									''' And Isnull(AV7000.Ana10ID,'''') <= N''' + REPLACE(@ToAna10ID, '[]', '') + ''''
	END

SET @sSQLAV7000_1=N'
		--So du No 
		SELECT  D17.DivisionID, D17.TranMonth, D17.TranYear,
		D16.WareHouseID, D17.InventoryID, ''BD'' AS D_C,  --- So du No
		D17.Notes, D16.VoucherID, D16.VoucherDate, D16.VoucherNo, 
		D16.ObjectID,AT1202.ObjectName, AT1202.Address,
		D02.InventoryName,D02.RefInventoryID, D02.UnitID, D04.UnitName, D02.InventoryTypeID, D02.VATPercent,
		D03.WareHouseName,	ActualQuantity, ConvertedQuantity, ConvertedAmount,
		ActualQuantity AS SignQuantity, ConvertedQuantity AS SignConvertedQuantity, ConvertedAmount AS SignAmount,	
		D02.S1,	D02.S2, D02.S3, D17.Ana01ID,D17.Ana02ID,D17.Ana03ID, D17.Ana04ID,D17.Ana05ID,D17.Ana06ID,D17.Ana07ID,D17.Ana08ID, D17.Ana09ID,D17.Ana10ID,
		D16.VoucherTypeID,D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, D02.Specification, 
		D02.Notes01 as D02Notes01, D02.Notes02 as D02Notes02, D02.Notes03 as D02Notes03,
		D17.SourceNo, D17.Parameter01, D17.Parameter02, D17.Parameter03, D17.Parameter04, D17.Parameter05,
		A01.AnaName AS Ana01Name, A02.AnaName AS Ana02Name, A03.AnaName AS Ana03Name, A04.AnaName AS Ana04Name, A05.AnaName AS Ana05Name,
		A06.AnaName AS Ana06Name, A07.AnaName AS Ana07Name, A08.AnaName AS Ana08Name, A09.AnaName AS Ana09Name,	A10.AnaName AS Ana10Name, 
		D17.Notes01, D17.Notes02, D17.Notes03, D17.Notes04, D17.Notes05, D17.Notes06, D17.Notes07, D17.Notes08, D17.LimitDate,
		D17.Notes09, D17.Notes10, D17.Notes11, D17.Notes12, D17.Notes13, D17.Notes14, D17.Notes15, D17.MarkQuantity, D17.MarkQuantity as SignMarkQuantity,
		D17.ConvertedUnitID,
		ISNULL(W89.S01ID,'''') AS S01ID, ISNULL(W89.S02ID,'''') AS S02ID, ISNULL(W89.S03ID,'''') AS S03ID, ISNULL(W89.S04ID,'''') AS S04ID, ISNULL(W89.S05ID,'''') AS S05ID, 
		ISNULL(W89.S06ID,'''') AS S06ID, ISNULL(W89.S07ID,'''') AS S07ID, ISNULL(W89.S08ID,'''') AS S08ID, ISNULL(W89.S09ID,'''') AS S09ID, ISNULL(W89.S10ID,'''') AS S10ID,
		ISNULL(W89.S11ID,'''') AS S11ID, ISNULL(W89.S12ID,'''') AS S12ID, ISNULL(W89.S13ID,'''') AS S13ID, ISNULL(W89.S14ID,'''') AS S14ID, ISNULL(W89.S15ID,'''') AS S15ID, 
		ISNULL(W89.S16ID,'''') AS S16ID, ISNULL(W89.S17ID,'''') AS S17ID, ISNULL(W89.S18ID,'''') AS S18ID, ISNULL(W89.S19ID,'''') AS S19ID, ISNULL(W89.S20ID,'''') AS S20ID '
	
SET @sSQLAV7000_1A=N'
	INTO #AV7000
	From AT2017 AS D17 WITH (NOLOCK)
	INNER JOIN AT2016 AS D16 WITH (NOLOCK) ON D16.VoucherID = D17.VoucherID AND D16.DivisionID = D17.DivisionID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = D16.ObjectID
	INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D17.DivisionID,''@@@'') AND D02.InventoryID = D17.InventoryID
	LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D02.DivisionID IN (D04.DivisionID,''@@@'') AND D04.UnitID = D02.UnitID
	INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND D03.WareHouseID = D16.WareHouseID
	LEFT JOIN AT1011 A01 WITH (NOLOCK) ON A01.AnaTypeID = ''A01'' AND A01.AnaID = D17.Ana01ID
	LEFT JOIN AT1011 A02 WITH (NOLOCK) ON A02.AnaTypeID = ''A02'' AND A02.AnaID = D17.Ana02ID
	LEFT JOIN AT1011 A03 WITH (NOLOCK) ON A03.AnaTypeID = ''A03'' AND A03.AnaID = D17.Ana03ID
	LEFT JOIN AT1011 A04 WITH (NOLOCK) ON A04.AnaTypeID = ''A04'' AND A04.AnaID = D17.Ana04ID
	LEFT JOIN AT1011 A05 WITH (NOLOCK) ON A05.AnaTypeID = ''A05'' AND A05.AnaID = D17.Ana05ID
	LEFT JOIN AT1011 A06 WITH (NOLOCK) ON A06.AnaTypeID = ''A06'' AND A06.AnaID = D17.Ana06ID
	LEFT JOIN AT1011 A07 WITH (NOLOCK) ON A07.AnaTypeID = ''A07'' AND A07.AnaID = D17.Ana07ID
	LEFT JOIN AT1011 A08 WITH (NOLOCK) ON A08.AnaTypeID = ''A08'' AND A08.AnaID = D17.Ana08ID
	LEFT JOIN AT1011 A09 WITH (NOLOCK) ON A09.AnaTypeID = ''A09'' AND A09.AnaID = D17.Ana09ID
	LEFT JOIN AT1011 A10 WITH (NOLOCK) ON A10.AnaTypeID = ''A10'' AND A10.AnaID = D17.Ana10ID
	LEFT JOIN WT8899 W89 WITH (NOLOCK) ON W89.DivisionID = D17.DivisionID AND W89.TransactionID = D17.TransactionID AND  W89.VoucherID = D17.VoucherID
	Where D17.DivisionID like N''' + @DivisionID + '''  and
	(D16.WareHouseID between N'''+@FromWareHouseID+N''' and N'''+@ToWareHouseID+N''') and
	(D16.ObjectID between  N''' + @FromObjectID + ''' and  N''' + @ToObjectID +''') and
	(D17.InventoryID between N''' + @FromInventoryID + ''' and N''' + @ToInventoryID +''') and
	ISNULL(DebitAccountID,'''') <>''''
	'

SET @sSQLAV7000_2=N'
	UNION ALL--- So du co
	SELECT  D17.DivisionID, D17.TranMonth, D17.TranYear,
		D16.WareHouseID, D17.InventoryID, ''BC'' AS D_C,
		D17.Notes, D16.VoucherID, D16.VoucherDate, D16.VoucherNo, 
		D16.ObjectID,AT1202.ObjectName, AT1202.Address,
		D02.InventoryName, D02.RefInventoryID, D02.UnitID, D04.UnitName, D02.InventoryTypeID , D02.VATPercent,
		D03.WareHouseName,	ActualQuantity, ConvertedQuantity, ConvertedAmount,
		-ActualQuantity AS SignQuantity, -ConvertedQuantity AS SignConvertedQuantity, -ConvertedAmount AS SignAmount,	
		D02.S1,	D02.S2, D02.S3 ,
		D17.Ana01ID,D17.Ana02ID,D17.Ana03ID, D17.Ana04ID,D17.Ana05ID,
		D17.Ana06ID,D17.Ana07ID,D17.Ana08ID, D17.Ana09ID,D17.Ana10ID,
		D16.VoucherTypeID,
		D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, D02.Specification,
		D02.Notes01 as D02Notes01, D02.Notes02 as D02Notes02, D02.Notes03 as D02Notes03,
		D17.SourceNo, D17.Parameter01, D17.Parameter02, D17.Parameter03, D17.Parameter04, D17.Parameter05,
		A01.AnaName AS Ana01Name, A02.AnaName AS Ana02Name, A03.AnaName AS Ana03Name, A04.AnaName AS Ana04Name, A05.AnaName AS Ana05Name,
		A06.AnaName AS Ana06Name, A07.AnaName AS Ana07Name, A08.AnaName AS Ana08Name, A09.AnaName AS Ana09Name,	A10.AnaName AS Ana10Name,
		D17.Notes01, D17.Notes02, D17.Notes03, D17.Notes04, D17.Notes05, D17.Notes06, D17.Notes07, D17.Notes08, D17.LimitDate,
		D17.Notes09, D17.Notes10, D17.Notes11, D17.Notes12, D17.Notes13, D17.Notes14, D17.Notes15, D17.MarkQuantity, -D17.MarkQuantity as SignMarkQuantity,
		D17.ConvertedUnitID,
		ISNULL(W89.S01ID,'''') AS S01ID, ISNULL(W89.S02ID,'''') AS S02ID, ISNULL(W89.S03ID,'''') AS S03ID, ISNULL(W89.S04ID,'''') AS S04ID, ISNULL(W89.S05ID,'''') AS S05ID, 
		ISNULL(W89.S06ID,'''') AS S06ID, ISNULL(W89.S07ID,'''') AS S07ID, ISNULL(W89.S08ID,'''') AS S08ID, ISNULL(W89.S09ID,'''') AS S09ID, ISNULL(W89.S10ID,'''') AS S10ID,
		ISNULL(W89.S11ID,'''') AS S11ID, ISNULL(W89.S12ID,'''') AS S12ID, ISNULL(W89.S13ID,'''') AS S13ID, ISNULL(W89.S14ID,'''') AS S14ID, ISNULL(W89.S15ID,'''') AS S15ID, 
		ISNULL(W89.S16ID,'''') AS S16ID, ISNULL(W89.S17ID,'''') AS S17ID, ISNULL(W89.S18ID,'''') AS S18ID, ISNULL(W89.S19ID,'''') AS S19ID, ISNULL(W89.S20ID,'''') AS S20ID '

SET @sSQLAV7000_2A=N'		
	FROM AT2017 AS D17 WITH (NOLOCK)
	INNER JOIN AT2016 AS D16 WITH (NOLOCK) ON D16.VoucherID = D17.VoucherID AND D16.DivisionID = D17.DivisionID 
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = D16.ObjectID
	INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D17.DivisionID,''@@@'') AND D02.InventoryID = D17.InventoryID
	LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D02.DivisionID IN (D04.DivisionID,''@@@'') AND D04.UnitID = D02.UnitID
	INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND D03.WareHouseID = D16.WareHouseID
	LEFT JOIN AT1011 A01 WITH (NOLOCK) ON A01.AnaTypeID = ''A01'' AND A01.AnaID = D17.Ana01ID
	LEFT JOIN AT1011 A02 WITH (NOLOCK) ON A02.AnaTypeID = ''A02'' AND A02.AnaID = D17.Ana02ID
	LEFT JOIN AT1011 A03 WITH (NOLOCK) ON A03.AnaTypeID = ''A03'' AND A03.AnaID = D17.Ana03ID
	LEFT JOIN AT1011 A04 WITH (NOLOCK) ON A04.AnaTypeID = ''A04'' AND A04.AnaID = D17.Ana04ID
	LEFT JOIN AT1011 A05 WITH (NOLOCK) ON A05.AnaTypeID = ''A05'' AND A05.AnaID = D17.Ana05ID
	LEFT JOIN AT1011 A06 WITH (NOLOCK) ON A06.AnaTypeID = ''A06'' AND A06.AnaID = D17.Ana06ID
	LEFT JOIN AT1011 A07 WITH (NOLOCK) ON A07.AnaTypeID = ''A07'' AND A07.AnaID = D17.Ana07ID
	LEFT JOIN AT1011 A08 WITH (NOLOCK) ON A08.AnaTypeID = ''A08'' AND A08.AnaID = D17.Ana08ID
	LEFT JOIN AT1011 A09 WITH (NOLOCK) ON A09.AnaTypeID = ''A09'' AND A09.AnaID = D17.Ana09ID
	LEFT JOIN AT1011 A10 WITH (NOLOCK) ON A10.AnaTypeID = ''A10'' AND A10.AnaID = D17.Ana10ID
	LEFT JOIN WT8899 W89 WITH (NOLOCK) ON W89.DivisionID = D17.DivisionID AND W89.TransactionID = D17.TransactionID AND  W89.VoucherID = D17.VoucherID
	WHERE D17.DivisionID like N''' + @DivisionID + '''  and
	(D16.WareHouseID between N'''+@FromWareHouseID+N''' and N'''+@ToWareHouseID+N''') and
	(D16.ObjectID between  N''' + @FromObjectID + ''' and  N''' + @ToObjectID +''') and
	(D17.InventoryID between N''' + @FromInventoryID + ''' and N''' + @ToInventoryID +''') and
	ISNULL(CreditAccountID,'''') <>''''
	'

SET @sSQLAV7000_3=N'
	UNION ALL  -- Nhap kho
	SELECT  D07.DivisionID, D07.TranMonth, D07.TranYear,
		D06.WareHouseID, D07.InventoryID, ''D'' AS D_C,  --- Phat sinh No
		D07.Notes, D06.VoucherID, D06.VoucherDate, D06.VoucherNo, 
		D06.ObjectID, AT1202.ObjectName, AT1202.Address,
		D02.InventoryName, D02.RefInventoryID, D02.UnitID, D04.UnitName, D02.InventoryTypeID , D02.VATPercent,
		D03.WareHouseName,	ActualQuantity, ConvertedQuantity, ConvertedAmount,
		ActualQuantity AS SignQuantity, ConvertedQuantity AS SignConvertedQuantity, ConvertedAmount AS SignAmount,	
		D02.S1,	D02.S2, D02.S3, 
		D07.Ana01ID,D07.Ana02ID,D07.Ana03ID, D07.Ana04ID,D07.Ana05ID,
		D07.Ana06ID,D07.Ana07ID,D07.Ana08ID, D07.Ana09ID,D07.Ana10ID,
		D06.VoucherTypeID,
		D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, D02.Specification,
		D02.Notes01 as D02Notes01, D02.Notes02 as D02Notes02, D02.Notes03 as D02Notes03,
		D07.SourceNo, D07.Parameter01, D07.Parameter02, D07.Parameter03, D07.Parameter04, D07.Parameter05,
		A01.AnaName AS Ana01Name, A02.AnaName AS Ana02Name, A03.AnaName AS Ana03Name, A04.AnaName AS Ana04Name, A05.AnaName AS Ana05Name,
		A06.AnaName AS Ana06Name, A07.AnaName AS Ana07Name, A08.AnaName AS Ana08Name, A09.AnaName AS Ana09Name,	A10.AnaName AS Ana10Name,
		D07.Notes01, D07.Notes02, D07.Notes03, D07.Notes04, D07.Notes05, D07.Notes06, D07.Notes07, D07.Notes08, D07.LimitDate,
		D07.Notes09, D07.Notes10, D07.Notes11, D07.Notes12, D07.Notes13, D07.Notes14, D07.Notes15, D07.MarkQuantity, D07.MarkQuantity as SignMarkQuantity,
		D07.ConvertedUnitID,
		ISNULL(W89.S01ID,'''') AS S01ID, ISNULL(W89.S02ID,'''') AS S02ID, ISNULL(W89.S03ID,'''') AS S03ID, ISNULL(W89.S04ID,'''') AS S04ID, ISNULL(W89.S05ID,'''') AS S05ID, 
		ISNULL(W89.S06ID,'''') AS S06ID, ISNULL(W89.S07ID,'''') AS S07ID, ISNULL(W89.S08ID,'''') AS S08ID, ISNULL(W89.S09ID,'''') AS S09ID, ISNULL(W89.S10ID,'''') AS S10ID,
		ISNULL(W89.S11ID,'''') AS S11ID, ISNULL(W89.S12ID,'''') AS S12ID, ISNULL(W89.S13ID,'''') AS S13ID, ISNULL(W89.S14ID,'''') AS S14ID, ISNULL(W89.S15ID,'''') AS S15ID, 
		ISNULL(W89.S16ID,'''') AS S16ID, ISNULL(W89.S17ID,'''') AS S17ID, ISNULL(W89.S18ID,'''') AS S18ID, ISNULL(W89.S19ID,'''') AS S19ID, ISNULL(W89.S20ID,'''') AS S20ID '

SET @sSQLAV7000_3FROM=N'
	FROM AT2007 AS D07 WITH (NOLOCK)
	INNER JOIN AT2006 D06 WITH (NOLOCK) ON D06.VoucherID = D07.VoucherID AND D06.DivisionID = D07.DivisionID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = D06.ObjectID
	INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D07.DivisionID,''@@@'') AND D02.InventoryID = D07.InventoryID
	LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D02.DivisionID IN (D04.DivisionID,''@@@'') AND D04.UnitID = D02.UnitID
	INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND D03.WareHouseID = D06.WareHouseID
	LEFT JOIN AT1302 AS P02 WITH (NOLOCK) ON P02.DivisionID IN (D07.DivisionID,''@@@'') AND P02.InventoryID = D07.ProductID
	LEFT JOIN AT1011 A01 WITH (NOLOCK) ON A01.AnaTypeID = ''A01'' AND A01.AnaID = D07.Ana01ID
	LEFT JOIN AT1011 A02 WITH (NOLOCK) ON A02.AnaTypeID = ''A02'' AND A02.AnaID = D07.Ana02ID
	LEFT JOIN AT1011 A03 WITH (NOLOCK) ON A03.AnaTypeID = ''A03'' AND A03.AnaID = D07.Ana03ID
	LEFT JOIN AT1011 A04 WITH (NOLOCK) ON A04.AnaTypeID = ''A04'' AND A04.AnaID = D07.Ana04ID
	LEFT JOIN AT1011 A05 WITH (NOLOCK) ON A05.AnaTypeID = ''A05'' AND A05.AnaID = D07.Ana05ID
	LEFT JOIN AT1011 A06 WITH (NOLOCK) ON A06.AnaTypeID = ''A06'' AND A06.AnaID = D07.Ana06ID
	LEFT JOIN AT1011 A07 WITH (NOLOCK) ON A07.AnaTypeID = ''A07'' AND A07.AnaID = D07.Ana07ID
	LEFT JOIN AT1011 A08 WITH (NOLOCK) ON A08.AnaTypeID = ''A08'' AND A08.AnaID = D07.Ana08ID
	LEFT JOIN AT1011 A09 WITH (NOLOCK) ON A09.AnaTypeID = ''A09'' AND A09.AnaID = D07.Ana09ID
	LEFT JOIN AT1011 A10 WITH (NOLOCK) ON A10.AnaTypeID = ''A10'' AND A10.AnaID = D07.Ana10ID
	LEFT JOIN WT8899 W89 WITH (NOLOCK) ON W89.DivisionID = D07.DivisionID AND W89.TransactionID = D07.TransactionID AND  W89.VoucherID = D07.VoucherID
	WHERE D07.DivisionID LIKE N''' + @DivisionID + ''' and
	D06.KindVoucherID in (1,3,5,7,9,15,17) AND Isnull(D06.TableID,'''') <> ''AT0114'' and ------- Phiếu nhập bù của ANGEL
	(D06.WareHouseID between N'''+@FromWareHouseID+N''' and N'''+@ToWareHouseID+N''') and
	(D06.ObjectID between  N''' + @FromObjectID + ''' and  N''' + @ToObjectID +''') and 
	(D07.InventoryID between N''' + @FromInventoryID + ''' and N''' + @ToInventoryID +''')
	
'
SET @sSQLAV7000_4='
	UNION ALL  -- xuat kho
	SELECT  D07.DivisionID, D07.TranMonth, D07.TranYear,
		CASE WHEN D06.KindVoucherID = 3 then D06.WareHouseID2 Else  D06.WareHouseID End AS WareHouseID, 
		D07.InventoryID, ''C'' AS D_C,  --- So du Co
		D07.Notes, D06.VoucherID, D06.VoucherDate, D06.VoucherNo, 
		D06.ObjectID, AT1202.ObjectName, AT1202.Address,
		D02.InventoryName, D02.RefInventoryID, D02.UnitID, D04.UnitName, D02.InventoryTypeID , D02.VATPercent,
		CASE WHEN D06.KindVoucherID = 3 then D031.WareHouseName Else  D03.WareHouseName End  AS WareHouseName,	
		ActualQuantity, ConvertedQuantity, ConvertedAmount,
		-ActualQuantity AS SignQuantity, -ConvertedQuantity AS SignConvertedQuantity, -ConvertedAmount AS SignAmount,	
		D02.S1,	D02.S2, D02.S3, 
		D07.Ana01ID,D07.Ana02ID,D07.Ana03ID, D07.Ana04ID,D07.Ana05ID,
		D07.Ana06ID,D07.Ana07ID,D07.Ana08ID, D07.Ana09ID,D07.Ana10ID,
		D06.VoucherTypeID,
		D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, D02.Specification,
		D02.Notes01 as D02Notes01, D02.Notes02 as D02Notes02, D02.Notes03 as D02Notes03,
		D07.SourceNo, D07.Parameter01, D07.Parameter02, D07.Parameter03, D07.Parameter04, D07.Parameter05,
		A01.AnaName AS Ana01Name, A02.AnaName AS Ana02Name, A03.AnaName AS Ana03Name, A04.AnaName AS Ana04Name, A05.AnaName AS Ana05Name,
		A06.AnaName AS Ana06Name, A07.AnaName AS Ana07Name, A08.AnaName AS Ana08Name, A09.AnaName AS Ana09Name,	A10.AnaName AS Ana10Name,
		D07.Notes01, D07.Notes02, D07.Notes03, D07.Notes04, D07.Notes05, D07.Notes06, D07.Notes07, D07.Notes08, D07.LimitDate,
		D07.Notes09, D07.Notes10, D07.Notes11, D07.Notes12, D07.Notes13, D07.Notes14, D07.Notes15, D07.MarkQuantity, -D07.MarkQuantity as SignMarkQuantity,
		D07.ConvertedUnitID,
		ISNULL(W89.S01ID,'''') AS S01ID, ISNULL(W89.S02ID,'''') AS S02ID, ISNULL(W89.S03ID,'''') AS S03ID, ISNULL(W89.S04ID,'''') AS S04ID, ISNULL(W89.S05ID,'''') AS S05ID, 
		ISNULL(W89.S06ID,'''') AS S06ID, ISNULL(W89.S07ID,'''') AS S07ID, ISNULL(W89.S08ID,'''') AS S08ID, ISNULL(W89.S09ID,'''') AS S09ID, ISNULL(W89.S10ID,'''') AS S10ID,
		ISNULL(W89.S11ID,'''') AS S11ID, ISNULL(W89.S12ID,'''') AS S12ID, ISNULL(W89.S13ID,'''') AS S13ID, ISNULL(W89.S14ID,'''') AS S14ID, ISNULL(W89.S15ID,'''') AS S15ID, 
		ISNULL(W89.S16ID,'''') AS S16ID, ISNULL(W89.S17ID,'''') AS S17ID, ISNULL(W89.S18ID,'''') AS S18ID, ISNULL(W89.S19ID,'''') AS S19ID, ISNULL(W89.S20ID,'''') AS S20ID '

SET @sSQLAV7000_4FROM=N'
	From AT2007 AS D07 WITH (NOLOCK)
	INNER JOIN AT2006 D06 WITH (NOLOCK) ON D06.VoucherID = D07.VoucherID AND D06.DivisionID = D07.DivisionID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = D06.ObjectID
	INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D07.DivisionID,''@@@'') AND D02.InventoryID = D07.InventoryID
	LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D02.DivisionID IN (D04.DivisionID,''@@@'') AND D04.UnitID = D02.UnitID
	INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND D03.WareHouseID = D06.WareHouseID
	LEFT JOIN AT1302 AS P02 WITH (NOLOCK) ON P02.DivisionID IN (D07.DivisionID,''@@@'') AND P02.InventoryID = D07.ProductID
	LEFT JOIN AT1303 AS D031 WITH (NOLOCK) ON D031.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND D031.WareHouseID = D06.WareHouseID2
	LEFT JOIN AT1011 A01 WITH (NOLOCK) ON A01.AnaTypeID = ''A01'' AND A01.AnaID = D07.Ana01ID
	LEFT JOIN AT1011 A02 WITH (NOLOCK) ON A02.AnaTypeID = ''A02'' AND A02.AnaID = D07.Ana02ID
	LEFT JOIN AT1011 A03 WITH (NOLOCK) ON A03.AnaTypeID = ''A03'' AND A03.AnaID = D07.Ana03ID
	LEFT JOIN AT1011 A04 WITH (NOLOCK) ON A04.AnaTypeID = ''A04'' AND A04.AnaID = D07.Ana04ID
	LEFT JOIN AT1011 A05 WITH (NOLOCK) ON A05.AnaTypeID = ''A05'' AND A05.AnaID = D07.Ana05ID
	LEFT JOIN AT1011 A06 WITH (NOLOCK) ON A06.AnaTypeID = ''A06'' AND A06.AnaID = D07.Ana06ID
	LEFT JOIN AT1011 A07 WITH (NOLOCK) ON A07.AnaTypeID = ''A07'' AND A07.AnaID = D07.Ana07ID
	LEFT JOIN AT1011 A08 WITH (NOLOCK) ON A08.AnaTypeID = ''A08'' AND A08.AnaID = D07.Ana08ID
	LEFT JOIN AT1011 A09 WITH (NOLOCK) ON A09.AnaTypeID = ''A09'' AND A09.AnaID = D07.Ana09ID
	LEFT JOIN AT1011 A10 WITH (NOLOCK) ON A10.AnaTypeID = ''A10'' AND A10.AnaID = D07.Ana10ID
	LEFT JOIN WT8899 W89 WITH (NOLOCK) ON W89.DivisionID = D07.DivisionID AND W89.TransactionID = D07.TransactionID AND  W89.VoucherID = D07.VoucherID
	Where D07.DivisionID LIKE N''' + @DivisionID + ''' and
	D06.KindVoucherID in (2,3,4,6,8,10,14,20) and
	(CASE WHEN D06.KindVoucherID = 3 then D06.WareHouseID2 Else  D06.WareHouseID End between N'''+@FromWareHouseID+N''' and N'''+@ToWareHouseID+N''') and
	(D06.ObjectID between  N''' + @FromObjectID + ''' and  N''' + @ToObjectID +''') and
	(D07.InventoryID between N''' + @FromInventoryID + ''' and N''' + @ToInventoryID +''')	'

IF @IsDate = 1
    ---- xac dinh so lieu theo ngay
    SET @strTime = ' and (  D_C=''BD''   or VoucherDate < ''' + @FromDateText + ''') '
ELSE
    SET @strTime = ' and ( D_C=''BD'' or TranMonth+ 100*TranYear < ' + @FromMonthYearText +' ) ' 


SET @sSQL1 = ' Select DISTINCT  AV7000.WareHouseID, AV7000.WareHouseName, -- 1. Lấy tồn đầu kỳ.
 AV7000.ObjectID, AV7000.ObjectName,  AV7000.Address,
 AV7000.InventoryID,	 AV7000.InventoryName,  AV7000.RefInventoryID,
 AV7000.UnitID,		 AV7000.S1, 	 AV7000.S2, 
 AV7000.S3, 	 AV7000.I01ID, 	 AV7000.I02ID, 	 AV7000.I03ID, 	 AV7000.I04ID, 	 AV7000.I05ID, 	
ISNULL(AV7000.Parameter01,0) Parameter01, ISNULL(AV7000.Parameter02,0) Parameter02, ISNULL(AV7000.Parameter03,0) Parameter03, ISNULL(AV7000.Parameter04,0) Parameter04, ISNULL(AV7000.Parameter05,0) Parameter05, 
 AV7000.UnitName, AV7000.InventoryTypeID, AV7000.Specification ,
AV7000.D02Notes01 , AV7000.D02Notes02 , AV7000.D02Notes03 ,
sum(isnull(SignQuantity,0))  as BeginQuantity,
sum(isnull(SignConvertedQuantity,0))  as BeginConvertedQuantity,
sum(isnull(SignAmount,0)) as BeginAmount,
sum(isnull(SignMarkQuantity,0))  as BeginMarkQuantity,
AV7000.DivisionID, 
AV7000.ConvertedUnitID,
max(AV7000.Notes01) as Notes01, max(AV7000.Notes02) as Notes02, max(AV7000.Notes03) as Notes03, max(AV7000.Notes04) as Notes04, max(AV7000.Notes05) as Notes05,
max(AV7000.Notes06) as Notes06, max(AV7000.Notes07) as Notes07, max(AV7000.Notes08) as Notes08,	max(AV7000.Notes09) as Notes09, max(AV7000.Notes10) as Notes10,
max(AV7000.Notes11) as Notes11, max(AV7000.Notes12) as Notes12, max(AV7000.Notes13) as Notes13, max(AV7000.Notes14) as Notes14, max(AV7000.Notes15) as Notes15,
ISNULL(AV7000.SourceNo,'''') SourceNo,
ISNULL(AV7000.S01ID,'''') AS S01ID, ISNULL(AV7000.S02ID,'''') AS S02ID, ISNULL(AV7000.S03ID,'''') AS S03ID, ISNULL(AV7000.S04ID,'''') AS S04ID, ISNULL(AV7000.S05ID,'''') AS S05ID, 
ISNULL(AV7000.S06ID,'''') AS S06ID, ISNULL(AV7000.S07ID,'''') AS S07ID, ISNULL(AV7000.S08ID,'''') AS S08ID, ISNULL(AV7000.S09ID,'''') AS S09ID, ISNULL(AV7000.S10ID,'''') AS S10ID,
ISNULL(AV7000.S11ID,'''') AS S11ID, ISNULL(AV7000.S12ID,'''') AS S12ID, ISNULL(AV7000.S13ID,'''') AS S13ID, ISNULL(AV7000.S14ID,'''') AS S14ID, ISNULL(AV7000.S15ID,'''') AS S15ID, 
ISNULL(AV7000.S16ID,'''') AS S16ID, ISNULL(AV7000.S17ID,'''') AS S17ID, ISNULL(AV7000.S18ID,'''') AS S18ID, ISNULL(AV7000.S19ID,'''') AS S19ID, ISNULL(AV7000.S20ID,'''') AS S20ID
'+CASE WHEN (SELECT CustomerName FROM CustomerIndex) = 70 THEN ', AV7000.LimitDate,AV7000.Ana01ID,AV7000.Ana02ID,AV7000.Ana03ID, 
AV7000.Ana04ID,AV7000.Ana05ID,AV7000.Ana06ID,AV7000.Ana07ID,AV7000.Ana08ID, AV7000.Ana09ID,AV7000.Ana10ID, AV7000.Ana01Name,AV7000.Ana02Name,AV7000.Ana03Name,AV7000.Ana04Name,
AV7000.Ana05Name,AV7000.Ana06Name,AV7000.Ana07Name,AV7000.Ana08Name,AV7000.Ana09Name,AV7000.Ana10Name
' ELSE '' END+'

Into #AV0709
From #AV7000  AV7000
Where 	AV7000.DivisionID like N''' + @DivisionID + 
    ''' and D_C in (''D'',''C'', ''BD'' )
 ' + @AnaWhere + ' '

SET @Ssql1 = @Ssql1 + @strTime + ' '

SET @sSQl1 = @sSQL1 + ' Group by  AV7000.DivisionID, AV7000.WareHouseID, AV7000.WareHouseName,  AV7000.ObjectID,    AV7000.InventoryID,	 AV7000.InventoryName, AV7000.RefInventoryID,	  AV7000.UnitID,
 AV7000.S1, 	 AV7000.S2, 	 AV7000.S3, 	 AV7000.I01ID, 	 AV7000.I02ID, 	 AV7000.I03ID, 	 AV7000.I04ID, 	 AV7000.I05ID, 
  ISNULL(AV7000.Parameter01,0) , ISNULL(AV7000.Parameter02,0) , ISNULL(AV7000.Parameter03,0) , ISNULL(AV7000.Parameter04,0) , ISNULL(AV7000.Parameter05,0) , 
 AV7000.UnitName ,AV7000.ObjectName, AV7000.Address , AV7000.InventoryTypeID, AV7000.Specification, AV7000.D02Notes01 , AV7000.D02Notes02 , AV7000.D02Notes03,
 ISNULL(AV7000.S01ID,''''), ISNULL(AV7000.S02ID,''''), ISNULL(AV7000.S03ID,''''), ISNULL(AV7000.S04ID,''''), ISNULL(AV7000.S05ID,''''), ISNULL(AV7000.S06ID,''''), 
 ISNULL(AV7000.S07ID,''''), ISNULL(AV7000.S08ID,''''), ISNULL(AV7000.S09ID,''''), ISNULL(AV7000.S10ID,''''), ISNULL(AV7000.S11ID,''''), ISNULL(AV7000.S12ID,''''), 
 ISNULL(AV7000.S13ID,''''), ISNULL(AV7000.S14ID,''''), ISNULL(AV7000.S15ID,''''), ISNULL(AV7000.S16ID,''''), ISNULL(AV7000.S17ID,''''), ISNULL(AV7000.S18ID,''''), 
 ISNULL(AV7000.S19ID,''''), ISNULL(AV7000.S20ID,'''')'+CASE WHEN (SELECT CustomerName FROM CustomerIndex) = 70 THEN ', AV7000.LimitDate
, AV7000.Ana01ID,AV7000.Ana02ID,AV7000.Ana03ID, AV7000.Ana04ID,AV7000.Ana05ID,AV7000.Ana06ID,AV7000.Ana07ID,AV7000.Ana08ID, AV7000.Ana09ID,AV7000.Ana10ID,
AV7000.Ana01Name,AV7000.Ana02Name,AV7000.Ana03Name,AV7000.Ana04Name,AV7000.Ana05Name,AV7000.Ana06Name,AV7000.Ana07Name,AV7000.Ana08Name,AV7000.Ana09Name,AV7000.Ana10Name
' ELSE '' END+'
, AV7000.SourceNo
, AV7000.ConvertedUnitID
'


IF @IsDate = 1
    ---- xac dinh so lieu theo ngay
    SET @strTime = ' and (VoucherDate  Between  ''' + @FromDateText + '''  and ''' + @ToDateText + '''  ) '
ELSE
    SET @strTime = ' and (TranMonth+ 100*TranYear Between ' + @FromMonthYearText + ' and  ' + @ToMonthYearText + '  ) ' 

----- Phát sinh 
SET @sSQL2 = ' --2 Lấy xuất trong kỳ.
SELECT DISTINCT
AV7000.ObjectID as ObjectID, 
AV7000.ObjectName as ObjectName, 	
AV7000.Address as Address, 
AV7000.InventoryID,
AV7000.InventoryName, AV7000.RefInventoryID,
AV7000.UnitID,
AV7000.S1, AV7000.S2, AV7000.S3, AV7000.I01ID, AV7000.I02ID, AV7000.I03ID, AV7000.I04ID, AV7000.I05ID, 
ISNULL(AV7000.Parameter01,0) Parameter01, ISNULL(AV7000.Parameter02,0) Parameter02, ISNULL(AV7000.Parameter03,0) Parameter03, ISNULL(AV7000.Parameter04,0) Parameter04, ISNULL(AV7000.Parameter05,0) Parameter05, 
AV7000.InventoryTypeID, AV7000.Specification ,
AV7000.D02Notes01 , AV7000.D02Notes02 , AV7000.D02Notes03,
max(AV7000.Notes01) as Notes01, max(AV7000.Notes02) as Notes02, max(AV7000.Notes03) as Notes03, max(AV7000.Notes04) as Notes04, max(AV7000.Notes05) as Notes05,
max(AV7000.Notes06) as Notes06, max(AV7000.Notes07) as Notes07, max(AV7000.Notes08) as Notes08,	max(AV7000.Notes09) as Notes09, max(AV7000.Notes10) as Notes10,
max(AV7000.Notes11) as Notes11, max(AV7000.Notes12) as Notes12, max(AV7000.Notes13) as Notes13, max(AV7000.Notes14) as Notes14, max(AV7000.Notes15) as Notes15,
ISNULL(AV7000.SourceNo,'''') SourceNo , 
AV7000.UnitName,	
0 as BeginQuantity,
0 as BeginConvertedQuantity,
0 as BeginAmount,
0 as BeginMarkQuantity,
Sum(Case when D_C = ''D'' then isnull(AV7000.MarkQuantity,0) else 0 end) as DebitMarkQuantity,
Sum(Case when D_C = ''C'' then isnull(AV7000.MarkQuantity,0) else 0 end) as CreditMarkQuantity,
Sum(Case when D_C = ''D'' then isnull(AV7000.ActualQuantity,0) else 0 end) as DebitQuantity,
Sum(Case when D_C = ''C'' then isnull(AV7000.ActualQuantity,0) else 0 end) as CreditQuantity,
Sum(Case when D_C = ''D'' then isnull(AV7000.ConvertedQuantity,0) else 0 end) as DebitConvertedQuantity,
Sum(Case when D_C = ''C'' then isnull(AV7000.ConvertedQuantity,0) else 0 end) as CreditConvertedQuantity,
Sum(Case when D_C = ''D'' then isnull(AV7000.ConvertedAmount,0) else 0 end) as DebitAmount,
Sum(Case when D_C = ''C'' then isnull(AV7000.ConvertedAmount,0) else 0 end) as CreditAmount, AV7000.DivisionID, AV7000.ConvertedUnitID,
ISNULL(AV7000.S01ID,'''') AS S01ID, ISNULL(AV7000.S02ID,'''') AS S02ID, ISNULL(AV7000.S03ID,'''') AS S03ID, ISNULL(AV7000.S04ID,'''') AS S04ID, ISNULL(AV7000.S05ID,'''') AS S05ID, 
ISNULL(AV7000.S06ID,'''') AS S06ID, ISNULL(AV7000.S07ID,'''') AS S07ID, ISNULL(AV7000.S08ID,'''') AS S08ID, ISNULL(AV7000.S09ID,'''') AS S09ID, ISNULL(AV7000.S10ID,'''') AS S10ID,
ISNULL(AV7000.S11ID,'''') AS S11ID, ISNULL(AV7000.S12ID,'''') AS S12ID, ISNULL(AV7000.S13ID,'''') AS S13ID, ISNULL(AV7000.S14ID,'''') AS S14ID, ISNULL(AV7000.S15ID,'''') AS S15ID, 
ISNULL(AV7000.S16ID,'''') AS S16ID, ISNULL(AV7000.S17ID,'''') AS S17ID, ISNULL(AV7000.S18ID,'''') AS S18ID, ISNULL(AV7000.S19ID,'''') AS S19ID, ISNULL(AV7000.S20ID,'''') AS S20ID,  AV7000.WareHouseID, AV7000.WareHouseName
'+CASE WHEN (SELECT CustomerName FROM CustomerIndex) = 70 THEN ', AV7000.LimitDate, AV7000.Ana01ID, AV7000.Ana02ID, AV7000.Ana03ID, 
AV7000.Ana04ID, AV7000.Ana05ID, AV7000.Ana06ID, AV7000.Ana07ID, AV7000.Ana08ID, AV7000.Ana09ID, AV7000.Ana10ID,AV7000.Ana01Name, AV7000.Ana02Name, AV7000.Ana03Name, 
AV7000.Ana04Name, AV7000.Ana05Name, AV7000.Ana06Name, AV7000.Ana07Name, AV7000.Ana08Name, AV7000.Ana09Name, AV7000.Ana10Name
' ELSE '' END+'
Into #AV0707
From #AV7000 AV7000--Full join AV0709 on 	( AV0709.InventoryID = AV7000.InventoryID) AND		
			--	(AV0709.ObjectID = AV7000.ObjectID) AND AV0709.DivisionID = AV7000.DivisionID 		
Where 	AV7000.DivisionID =''' + @DivisionID + ''' and
AV7000.D_C in (''D'', ''C'') ' + @strTime + @AnaWhere + ' ' +  ' '

SET @sSQL3 = '
Group by  AV7000.ObjectID, AV7000.ObjectName, AV7000.Address,  AV7000.WareHouseID, AV7000.WareHouseName,
AV7000.InventoryID, AV7000.InventoryName, AV7000.RefInventoryID, AV7000.UnitID, AV7000.UnitName, 
AV7000.S1, AV7000.S2, AV7000.S3, AV7000.I01ID, AV7000.I02ID, AV7000.I03ID, AV7000.I04ID, AV7000.I05ID,
 ISNULL(AV7000.Parameter01,0), ISNULL(AV7000.Parameter02,0), ISNULL(AV7000.Parameter03,0), ISNULL(AV7000.Parameter04,0), ISNULL(AV7000.Parameter05,0), 
 AV7000.InventoryTypeID, AV7000.Specification,
AV7000.D02Notes01 , AV7000.D02Notes02 , AV7000.D02Notes03,
---AV7000.Notes01, AV7000.Notes02, AV7000.Notes03, AV7000.Notes04, AV7000.Notes05, AV7000.Notes06, AV7000.Notes07, AV7000.Notes08,
---	AV7000.Notes09, AV7000.Notes10, AV7000.Notes11, AV7000.Notes12, AV7000.Notes13, AV7000.Notes14, AV7000.Notes15,
AV7000.DivisionID, ISNULL(AV7000.S01ID,''''), ISNULL(AV7000.S02ID,''''), ISNULL(AV7000.S03ID,''''), ISNULL(AV7000.S04ID,''''), 
ISNULL(AV7000.S05ID,''''), ISNULL(AV7000.S06ID,''''), ISNULL(AV7000.S07ID,''''), ISNULL(AV7000.S08ID,''''), ISNULL(AV7000.S09ID,''''), ISNULL(AV7000.S10ID,''''),
ISNULL(AV7000.S11ID,''''), ISNULL(AV7000.S12ID,''''), ISNULL(AV7000.S13ID,''''), ISNULL(AV7000.S14ID,''''), ISNULL(AV7000.S15ID,''''), 
ISNULL(AV7000.S16ID,''''), ISNULL(AV7000.S17ID,''''), ISNULL(AV7000.S18ID,''''), ISNULL(AV7000.S19ID,''''), ISNULL(AV7000.S20ID,'''')
'+CASE WHEN (SELECT CustomerName FROM CustomerIndex) = 70 THEN ', AV7000.LimitDate, AV7000.Ana01ID, AV7000.Ana02ID, AV7000.Ana03ID, AV7000.Ana04ID, 
AV7000.Ana05ID, AV7000.Ana06ID, AV7000.Ana07ID, AV7000.Ana08ID, AV7000.Ana09ID, AV7000.Ana10ID,AV7000.Ana01Name, AV7000.Ana02Name, AV7000.Ana03Name, AV7000.Ana04Name, 
AV7000.Ana05Name, AV7000.Ana06Name, AV7000.Ana07Name, AV7000.Ana08Name, AV7000.Ana09Name, AV7000.Ana10Name
' ELSE '' END+', AV7000.ConvertedUnitID, ISNULL(AV7000.SourceNo,'''')	'

------------------------------ KET HOP VOI SO  PHAT SINH
IF @CustomerName IN (70) ---Customize EIMSKIP
BEGIN
	SET @sSQL4 = ' SELECT DISTINCT Temp.*,
				   A01.StandardName AS StandardName01, A02.StandardName AS StandardName02, A03.StandardName AS StandardName03, A04.StandardName AS StandardName04, 
				   A05.StandardName AS StandardName05, A06.StandardName AS StandardName06, A07.StandardName AS StandardName07, A08.StandardName AS StandardName08, 
				   A09.StandardName AS StandardName09, A10.StandardName AS StandardName10, A11.StandardName AS StandardName11, A12.StandardName AS StandardName12,
				   A13.StandardName AS StandardName13, A14.StandardName AS StandardName14, A15.StandardName AS StandardName15, A16.StandardName AS StandardName16,
				   A17.StandardName AS StandardName17, A18.StandardName AS StandardName18, A19.StandardName AS StandardName19, A20.StandardName AS StandardName20, 
				   AT1303.Address AS WarehouseAddress, ISNULL(AT1302.I01ID,'''') I01ID, ISNULL(AT1302.I02ID,'''') I02ID, ISNULL(AT1302.I03ID,'''') I03ID, ISNULL(AT1302.I04ID,'''') I04ID, 
				   ISNULL(AT1302.I05ID,'''') I05ID, ISNULL(AT1302.I06ID,'''') I06ID, ISNULL(AT1302.I07ID,'''') I07ID, ISNULL(AT1302.I08ID,'''') I08ID, ISNULL(AT1302.I09ID,'''') I09ID, 
				   ISNULL(AT1302.I10ID,'''') I10ID, ISNULL(I_01.AnaName,'''') I01Name, ISNULL(I_02.AnaName,'''') I02Name, ISNULL(I_03.AnaName,'''') I03Name, ISNULL(I_04.AnaName,'''') I04Name, 
				   ISNULL(I_05.AnaName,'''') I05Name, ISNULL(I_06.AnaName,'''') I06Name, ISNULL(I_07.AnaName,'''') I07Name, ISNULL(I_08.AnaName,'''') I08Name, ISNULL(I_09.AnaName,'''') I09Name, 
				   ISNULL(I_10.AnaName,'''') I10Name, ISNULL(Temp.Ana01ID,'''') AS Ana01ID, ISNULL(Temp.Ana02ID,'''') AS Ana02ID, ISNULL(Temp.Ana03ID,'''') AS Ana03ID, ISNULL(Temp.Ana04ID,'''') AS Ana04ID,
				   ISNULL(Temp.Ana05ID,'''') AS Ana05ID, ISNULL(Temp.Ana06ID,'''') AS Ana06ID, ISNULL(Temp.Ana07ID,'''') AS Ana07ID, ISNULL(Temp.Ana08ID,'''') AS Ana08ID,
				   ISNULL(Temp.Ana09ID,'''') AS Ana09ID, ISNULL(Temp.Ana10ID,'''') AS Ana10ID, ISNULL(Temp.Ana01Name,'''') AS Ana01Name, 
				   ISNULL(Temp.Ana02Name,'''') AS Ana02Name, ISNULL(Temp.Ana03Name,'''') AS Ana03Name, ISNULL(Temp.Ana04Name,'''') AS Ana04Name,
				   ISNULL(Temp.Ana05Name,'''') AS Ana05Name, ISNULL(Temp.Ana06Name,'''') AS Ana06Name, ISNULL(Temp.Ana07Name,'''') AS Ana07Name,
				   ISNULL(Temp.Ana08Name,'''') AS Ana08Name, ISNULL(Temp.Ana09Name,'''') AS Ana09Name, ISNULL(Temp.Ana10Name,'''') AS Ana10Name 
FROM
(
SELECT DISTINCT
isnull(AV0707.ObjectID,AV0709.ObjectID) as ObjectID, 
isnull(AV0707.ObjectName,AV0709.ObjectName) as ObjectName, 	
isnull(AV0707.Address,AV0709.Address) as Address, 
isnull(AV0707.InventoryID,AV0709.InventoryID) as InventoryID, 
isnull(AV0707.InventoryName,AV0709.InventoryName) as InventoryName, 
isnull(AV0707.RefInventoryID,AV0709.RefInventoryID) as RefInventoryID, 
Isnull(AV0707.UnitID,AV0709.UnitID) as UnitID,
isnull(AV0707.S1, AV0709.S1) as S1, 
isnull(AV0707.S2, AV0709.S2) as S2, 
isnull(AV0707.S3, AV0709.S3) as S3, 
isnull(AV0707.I01ID, AV0709.I01ID) as I01ID, 
isnull(AV0707.I02ID, AV0709.I02ID) as I02ID, 
isnull(AV0707.I03ID, AV0709.I03ID) as I03ID, 
isnull(AV0707.I04ID, AV0709.I04ID) as I04ID, 
isnull(AV0707.I05ID, AV0709.I05ID) as I05ID, 
ISNULL(AV0707.Parameter01,0) Parameter01, ISNULL(AV0707.Parameter02,0) Parameter02, ISNULL(AV0707.Parameter03,0) Parameter03, 
ISNULL(AV0707.Parameter04,0) Parameter04, ISNULL(AV0707.Parameter05,0) Parameter05, 
isnull(AV0707.InventoryTypeID, AV0709.InventoryTypeID) as InventoryTypeID, 
isnull(AV0707.Specification, AV0709.Specification) as Specification, 	
AV0707.D02Notes01, AV0707.D02Notes02, AV0707.D02Notes03, AV0707.Notes01, AV0707.Notes02, AV0707.Notes03, AV0707.Notes04, AV0707.Notes05, AV0707.Notes06, AV0707.Notes07, AV0707.Notes08,
AV0707.Notes09, AV0707.Notes10, AV0707.Notes11, AV0707.Notes12, AV0707.Notes13, AV0707.Notes14, AV0707.Notes15,
isnull(AV0709.UnitName,AV0707.UnitName) as UnitName,	
SUM(isnull(AV0709.BeginQuantity,0)) as BeginQuantity,
SUM(isnull(AV0709.BeginConvertedQuantity,0)) as BeginConvertedQuantity,
SUM(isnull(AV0709.BeginMarkQuantity,0)) as BeginMarkQuantity,
SUM(isnull(AV0709.BeginAmount,0)) as BeginAmount,
SUM(isnull(AV0707.DebitQuantity,0)) as DebitQuantity, 
SUM(isnull(AV0707.CreditQuantity,0)) as CreditQuantity,
SUM(isnull(AV0707.DebitConvertedQuantity,0)) as DebitConvertedQuantity, 
SUM(isnull(AV0707.CreditConvertedQuantity,0)) as CreditConvertedQuantity,
SUM(isnull(AV0707.DebitMarkQuantity,0)) as DebitMarkQuantity, 
SUM(isnull(AV0707.CreditMarkQuantity,0)) as CreditMarkQuantity,
SUM(isnull(AV0707.DebitAmount,0)) as DebitAmount,
SUM(isnull(AV0707.CreditAmount,0)) as CreditAmount,
SUM(isnull(AV0709.BeginQuantity,0) + isnull(AV0707.DebitQuantity,0) - isnull(AV0707.CreditQuantity,0)) as EndQuantity,'

SET @sSQL5 = '
SUM(isnull(AV0709.BeginConvertedQuantity,0) + isnull(AV0707.DebitConvertedQuantity,0) - isnull(AV0707.CreditConvertedQuantity,0)) as EndConvertedQuantity,
SUM(isnull(AV0709.BeginMarkQuantity,0) + isnull(AV0707.DebitMarkQuantity,0) - isnull(AV0707.CreditMarkQuantity,0)) as EndMarkQuantity,
SUM(isnull(AV0709.BeginAmount,0) + isnull(AV0707.DebitAmount,0) - isnull(AV0707.CreditAmount,0)) as EndAmount, 
''' + @DivisionID +  ''' AS DivisionID,
ISNULL(AV0707.S01ID,'''') AS S01ID, ISNULL(AV0707.S02ID,'''') AS S02ID, ISNULL(AV0707.S03ID,'''') AS S03ID, ISNULL(AV0707.S04ID,'''') AS S04ID, 
ISNULL(AV0707.S05ID,'''') AS S05ID, ISNULL(AV0707.S06ID,'''') AS S06ID, ISNULL(AV0707.S07ID,'''') AS S07ID, ISNULL(AV0707.S08ID,'''') AS S08ID, 
ISNULL(AV0707.S09ID,'''') AS S09ID, ISNULL(AV0707.S10ID,'''') AS S10ID, ISNULL(AV0707.S11ID,'''') AS S11ID, ISNULL(AV0707.S12ID,'''') AS S12ID, 
ISNULL(AV0707.S13ID,'''') AS S13ID, ISNULL(AV0707.S14ID,'''') AS S14ID, ISNULL(AV0707.S15ID,'''') AS S15ID, ISNULL(AV0707.S16ID,'''') AS S16ID, 
ISNULL(AV0707.S17ID,'''') AS S17ID, ISNULL(AV0707.S18ID,'''') AS S18ID, ISNULL(AV0707.S19ID,'''') AS S19ID, ISNULL(AV0707.S20ID,'''') AS S20ID,
ISNULL(AV0707.LimitDate, AV0709.LimitDate) AS LimitDate, ISNULL(AV0707.SourceNo,AV0709.SourceNo) AS SourceNo,
ISNULL(AV0707.Ana01ID,AV0709.Ana01ID) AS Ana01ID, ISNULL(AV0707.Ana02ID,AV0709.Ana02ID) AS Ana02ID, ISNULL(AV0707.Ana03ID,AV0709.Ana03ID) AS Ana03ID, ISNULL(AV0707.Ana04ID,AV0709.Ana04ID) AS Ana04ID,
ISNULL(AV0707.Ana05ID,AV0709.Ana05ID) AS Ana05ID, ISNULL(AV0707.Ana06ID,AV0709.Ana06ID) AS Ana06ID, ISNULL(AV0707.Ana07ID,AV0709.Ana07ID) AS Ana07ID, ISNULL(AV0707.Ana08ID,AV0709.Ana08ID) AS Ana08ID,
ISNULL(AV0707.Ana09ID,AV0709.Ana09ID) AS Ana09ID, ISNULL(AV0707.Ana10ID,AV0709.Ana10ID) AS Ana10ID, ISNULL(AV0707.Ana01Name,AV0709.Ana01Name) AS Ana01Name, 
ISNULL(AV0707.Ana02Name,AV0709.Ana02Name) AS Ana02Name, ISNULL(AV0707.Ana03Name,AV0709.Ana03Name) AS Ana03Name, ISNULL(AV0707.Ana04Name,AV0709.Ana04Name) AS Ana04Name,
ISNULL(AV0707.Ana05Name,AV0709.Ana05Name) AS Ana05Name, ISNULL(AV0707.Ana06Name,AV0709.Ana06Name) AS Ana06Name, ISNULL(AV0707.Ana07Name,AV0709.Ana07Name) AS Ana07Name,
ISNULL(AV0707.Ana08Name,AV0709.Ana08Name) AS Ana08Name, ISNULL(AV0707.Ana09Name,AV0709.Ana09Name) AS Ana09Name, ISNULL(AV0707.Ana10Name,AV0709.Ana10Name) AS Ana10Name	'

SET @sSQL5a = @sSQL5a +'
FROM #AV0707 AV0707 --EndAmount
LEFT JOIN #AV0709 AV0709 ON	AV0709.InventoryID = AV0707.InventoryID
				AND ISNULL(AV0709.Ana01ID,'''') = ISNULL(AV0707.Ana01ID,'''')
				AND ISNULL(AV0709.Ana02ID,'''') = ISNULL(AV0707.Ana02ID,'''')
				AND ISNULL(AV0709.Ana03ID,'''') = ISNULL(AV0707.Ana03ID,'''')
				AND ISNULL(AV0709.Ana04ID,'''') = ISNULL(AV0707.Ana04ID,'''')
				AND ISNULL(AV0709.Ana05ID,'''') = ISNULL(AV0707.Ana05ID,'''')
				AND ISNULL(AV0709.Ana06ID,'''') = ISNULL(AV0707.Ana06ID,'''')
				AND ISNULL(AV0709.Ana07ID,'''') = ISNULL(AV0707.Ana07ID,'''')
				AND ISNULL(AV0709.Ana08ID,'''') = ISNULL(AV0707.Ana08ID,'''')
				AND ISNULL(AV0709.Ana09ID,'''') = ISNULL(AV0707.Ana09ID,'''')
				AND ISNULL(AV0709.Ana10ID,'''') = ISNULL(AV0707.Ana10ID,'''')
				AND ISNULL(AV0709.LimitDate,'''') = ISNULL(AV0707.LimitDate,'''') 
				AND ISNULL(AV0709.SourceNo,'''') = ISNULL(AV0707.SourceNo,'''')
				AND (AV0709.ObjectID = AV0707.ObjectID) and (AV0709.DivisionID = AV0707.DivisionID)	
				AND ISNULL(AV0707.S01ID,'''') = Isnull(AV0709.S01ID,'''') AND ISNULL(AV0707.S02ID,'''') = isnull(AV0709.S02ID,'''')
				AND ISNULL(AV0707.S03ID,'''') = isnull(AV0709.S03ID,'''') AND ISNULL(AV0707.S04ID,'''') = isnull(AV0709.S04ID,'''')
				AND ISNULL(AV0707.S05ID,'''') = isnull(AV0709.S05ID,'''') AND ISNULL(AV0707.S06ID,'''') = isnull(AV0709.S06ID,'''')
				AND ISNULL(AV0707.S07ID,'''') = isnull(AV0709.S07ID,'''') AND ISNULL(AV0707.S08ID,'''') = isnull(AV0709.S08ID,'''') 
				AND ISNULL(AV0707.S09ID,'''') = isnull(AV0709.S09ID,'''') AND ISNULL(AV0707.S10ID,'''') = isnull(AV0709.S10ID,'''') 
				AND ISNULL(AV0707.S11ID,'''') = isnull(AV0709.S11ID,'''') AND ISNULL(AV0707.S12ID,'''') = isnull(AV0709.S12ID,'''') 
				AND ISNULL(AV0707.S13ID,'''') = isnull(AV0709.S13ID,'''') AND ISNULL(AV0707.S14ID,'''') = isnull(AV0709.S14ID,'''') 
				AND ISNULL(AV0707.S15ID,'''') = isnull(AV0709.S15ID,'''') AND ISNULL(AV0707.S16ID,'''') = isnull(AV0709.S16ID,'''') 
				AND ISNULL(AV0707.S17ID,'''') = isnull(AV0709.S17ID,'''') AND ISNULL(AV0707.S18ID,'''') = isnull(AV0709.S18ID,'''') 
				AND ISNULL(AV0707.S19ID,'''') = isnull(AV0709.S19ID,'''') AND ISNULL(AV0707.S20ID,'''') = isnull(AV0709.S20ID,'''')	'

SET @sSQL6 = ' UNION
SELECT DISTINCT
isnull(AV0707.ObjectID,AV0709.ObjectID) as ObjectID, 
isnull(AV0707.ObjectName,AV0709.ObjectName) as ObjectName, 	
isnull(AV0707.Address,AV0709.Address) as Address, 
isnull(AV0707.InventoryID,AV0709.InventoryID) as InventoryID, 
isnull(AV0707.InventoryName,AV0709.InventoryName) as InventoryName,
isnull(AV0707.RefInventoryID,AV0709.RefInventoryID) as RefInventoryID,  
Isnull(AV0707.UnitID,AV0709.UnitID) as UnitID,
isnull(AV0707.S1, AV0709.S1) as S1, 
isnull(AV0707.S2, AV0709.S2) as S2, 
isnull(AV0707.S3, AV0709.S3) as S3, 
isnull(AV0707.I01ID, AV0709.I01ID) as I01ID, 
isnull(AV0707.I02ID, AV0709.I02ID) as I02ID, 
isnull(AV0707.I03ID, AV0709.I03ID) as I03ID, 
isnull(AV0707.I04ID, AV0709.I04ID) as I04ID, 
isnull(AV0707.I05ID, AV0709.I05ID) as I05ID, 
ISNULL(AV0707.Parameter01,0) Parameter01, ISNULL(AV0707.Parameter02,0) Parameter02, ISNULL(AV0707.Parameter03,0) Parameter03, 
ISNULL(AV0707.Parameter04,0) Parameter04, ISNULL(AV0707.Parameter05,0) Parameter05, 
isnull(AV0707.InventoryTypeID, AV0709.InventoryTypeID) as InventoryTypeID, 
isnull(AV0707.Specification , AV0709.Specification ) as Specification, 	
AV0707.D02Notes01 , AV0707.D02Notes02 , AV0707.D02Notes03,AV0707.Notes01, AV0707.Notes02, AV0707.Notes03, AV0707.Notes04, AV0707.Notes05, AV0707.Notes06, AV0707.Notes07, AV0707.Notes08,
AV0707.Notes09, AV0707.Notes10, AV0707.Notes11, AV0707.Notes12, AV0707.Notes13, AV0707.Notes14, AV0707.Notes15,
isnull(AV0709.UnitName,	AV0707.UnitName) as UnitName,	
SUM(isnull(AV0709.BeginQuantity,0)) as BeginQuantity,
SUM(isnull(AV0709.BeginConvertedQuantity,0)) as BeginConvertedQuantity,
SUM(isnull(AV0709.BeginMarkQuantity,0)) as BeginMarkQuantity,
SUM(isnull(AV0709.BeginAmount,0)) as BeginAmount,
SUM(isnull(AV0707.DebitQuantity,0)) as DebitQuantity, 
SUM(isnull(AV0707.CreditQuantity,0)) as CreditQuantity,
SUM(isnull(AV0707.DebitConvertedQuantity,0)) as DebitConvertedQuantity, 
SUM(isnull(AV0707.CreditConvertedQuantity,0)) as CreditConvertedQuantity,
SUM(isnull(AV0707.DebitMarkQuantity,0)) as DebitMarkQuantity, 
SUM(isnull(AV0707.CreditMarkQuantity,0)) as CreditMarkQuantity,
SUM(isnull(AV0707.DebitAmount,0 )) as DebitAmount,
SUM(isnull(AV0707.CreditAmount, 0)) as CreditAmount,
SUM(isnull(AV0709.BeginQuantity,0) + isnull(AV0707.DebitQuantity,0)  - isnull(AV0707.CreditQuantity,0)) as EndQuantity,
SUM(isnull(AV0709.BeginConvertedQuantity,0) + isnull(AV0707.DebitConvertedQuantity,0)  - isnull(AV0707.CreditConvertedQuantity,0)) as EndConvertedQuantity,
SUM(isnull(AV0709.BeginMarkQuantity,0) + isnull(AV0707.DebitMarkQuantity,0)  - isnull(AV0707.CreditMarkQuantity,0)) as EndMarkQuantity,
SUM(isnull(AV0709.BeginAmount,0) + isnull(AV0707.DebitAmount,0)  - isnull(AV0707.CreditAmount,0)) as EndAmount,
''' + @DivisionID +  ''' AS DivisionID,
ISNULL(AV0707.S01ID,'''') AS S01ID, ISNULL(AV0707.S02ID,'''') AS S02ID, ISNULL(AV0707.S03ID,'''') AS S03ID, ISNULL(AV0707.S04ID,'''') AS S04ID, 
ISNULL(AV0707.S05ID,'''') AS S05ID, ISNULL(AV0707.S06ID,'''') AS S06ID, ISNULL(AV0707.S07ID,'''') AS S07ID, ISNULL(AV0707.S08ID,'''') AS S08ID, 
ISNULL(AV0707.S09ID,'''') AS S09ID, ISNULL(AV0707.S10ID,'''') AS S10ID, ISNULL(AV0707.S11ID,'''') AS S11ID, ISNULL(AV0707.S12ID,'''') AS S12ID, 
ISNULL(AV0707.S13ID,'''') AS S13ID, ISNULL(AV0707.S14ID,'''') AS S14ID, ISNULL(AV0707.S15ID,'''') AS S15ID, ISNULL(AV0707.S16ID,'''') AS S16ID, 
ISNULL(AV0707.S17ID,'''') AS S17ID, ISNULL(AV0707.S18ID,'''') AS S18ID, ISNULL(AV0707.S19ID,'''') AS S19ID, ISNULL(AV0707.S20ID,'''') AS S20ID,
ISNULL(AV0707.LimitDate, AV0709.LimitDate) AS LimitDate, ISNULL(AV0707.SourceNo,AV0709.SourceNo) AS SourceNo,	'

	SET @sSQL6a='
		ISNULL(AV0707.Ana01ID,AV0709.Ana01ID) AS Ana01ID, ISNULL(AV0707.Ana02ID,AV0709.Ana02ID) AS Ana02ID, ISNULL(AV0707.Ana03ID,AV0709.Ana03ID) AS Ana03ID, ISNULL(AV0707.Ana04ID,AV0709.Ana04ID) AS Ana04ID,
		ISNULL(AV0707.Ana05ID,AV0709.Ana05ID) AS Ana05ID, ISNULL(AV0707.Ana06ID,AV0709.Ana06ID) AS Ana06ID, ISNULL(AV0707.Ana07ID,AV0709.Ana07ID) AS Ana07ID, ISNULL(AV0707.Ana08ID,AV0709.Ana08ID) AS Ana08ID,
		ISNULL(AV0707.Ana09ID,AV0709.Ana09ID) AS Ana09ID, ISNULL(AV0707.Ana10ID,AV0709.Ana10ID) AS Ana10ID,  
		ISNULL(AV0707.Ana01Name,AV0709.Ana01Name) AS Ana01Name, ISNULL(AV0707.Ana02Name,AV0709.Ana02Name) AS Ana02Name, ISNULL(AV0707.Ana03Name,AV0709.Ana03Name) AS Ana03Name,
		ISNULL(AV0707.Ana04Name,AV0709.Ana04Name) AS Ana04Name, ISNULL(AV0707.Ana05Name,AV0709.Ana05Name) AS Ana05Name, ISNULL(AV0707.Ana06Name,AV0709.Ana06Name) AS Ana06Name,
		ISNULL(AV0707.Ana07Name,AV0709.Ana07Name) AS Ana07Name, ISNULL(AV0707.Ana08Name,AV0709.Ana08Name) AS Ana08Name, ISNULL(AV0707.Ana09Name,AV0709.Ana09Name) AS Ana09Name, 
		ISNULL(AV0707.Ana10Name,AV0709.Ana10Name) AS Ana10Name	'

	SET @sSQL7 = '
		FROM #AV0709 AV0709 --EndAmount
		LEFT JOIN #AV0707 AV0707 ON AV0709.InventoryID = AV0707.InventoryID
					AND ISNULL(AV0709.Ana01ID,'''') = ISNULL(AV0707.Ana01ID,'''')
					AND ISNULL(AV0709.Ana02ID,'''') = ISNULL(AV0707.Ana02ID,'''')
					AND ISNULL(AV0709.Ana03ID,'''') = ISNULL(AV0707.Ana03ID,'''')
					AND ISNULL(AV0709.Ana04ID,'''') = ISNULL(AV0707.Ana04ID,'''')
					AND ISNULL(AV0709.Ana05ID,'''') = ISNULL(AV0707.Ana05ID,'''')
					AND ISNULL(AV0709.Ana06ID,'''') = ISNULL(AV0707.Ana06ID,'''')
					AND ISNULL(AV0709.Ana07ID,'''') = ISNULL(AV0707.Ana07ID,'''')
					AND ISNULL(AV0709.Ana08ID,'''') = ISNULL(AV0707.Ana08ID,'''')
					AND ISNULL(AV0709.Ana09ID,'''') = ISNULL(AV0707.Ana09ID,'''')
					AND ISNULL(AV0709.Ana10ID,'''') = ISNULL(AV0707.Ana10ID,'''')
					AND ISNULL(AV0709.LimitDate,'''') = ISNULL(AV0707.LimitDate,'''')  
					AND ISNULL(AV0709.SourceNo,'''') = ISNULL(AV0707.SourceNo,'''')
					AND (AV0709.ObjectID = AV0707.ObjectID) and (AV0709.DivisionID = AV0707.DivisionID)	
					AND ISNULL(AV0707.S01ID,'''') = Isnull(AV0709.S01ID,'''') AND ISNULL(AV0707.S02ID,'''') = isnull(AV0709.S02ID,'''')
					AND ISNULL(AV0707.S03ID,'''') = isnull(AV0709.S03ID,'''') AND ISNULL(AV0707.S04ID,'''') = isnull(AV0709.S04ID,'''')
					AND ISNULL(AV0707.S05ID,'''') = isnull(AV0709.S05ID,'''') AND ISNULL(AV0707.S06ID,'''') = isnull(AV0709.S06ID,'''')
					AND ISNULL(AV0707.S07ID,'''') = isnull(AV0709.S07ID,'''') AND ISNULL(AV0707.S08ID,'''') = isnull(AV0709.S08ID,'''') 
					AND ISNULL(AV0707.S09ID,'''') = isnull(AV0709.S09ID,'''') AND ISNULL(AV0707.S10ID,'''') = isnull(AV0709.S10ID,'''') 
					AND ISNULL(AV0707.S11ID,'''') = isnull(AV0709.S11ID,'''') AND ISNULL(AV0707.S12ID,'''') = isnull(AV0709.S12ID,'''') 
					AND ISNULL(AV0707.S13ID,'''') = isnull(AV0709.S13ID,'''') AND ISNULL(AV0707.S14ID,'''') = isnull(AV0709.S14ID,'''') 
					AND ISNULL(AV0707.S15ID,'''') = isnull(AV0709.S15ID,'''') AND ISNULL(AV0707.S16ID,'''') = isnull(AV0709.S16ID,'''') 
					AND ISNULL(AV0707.S17ID,'''') = isnull(AV0709.S17ID,'''') AND ISNULL(AV0707.S18ID,'''') = isnull(AV0709.S18ID,'''') 
					AND ISNULL(AV0707.S19ID,'''') = isnull(AV0709.S19ID,'''') AND ISNULL(AV0707.S20ID,'''') = isnull(AV0709.S20ID,'''')'

	SET @sSQLGroupBy_EIMSKIP = N'
	GROUP BY AV0707.ObjectID, AV0709.ObjectID, AV0707.ObjectName, AV0709.ObjectName, 	
			 AV0707.Address, AV0709.Address, AV0707.InventoryID, AV0709.InventoryID, 
			 AV0707.InventoryName, AV0709.InventoryName, AV0707.RefInventoryID, AV0709.RefInventoryID,  
			 AV0707.UnitID, AV0709.UnitID,
			 AV0707.S1, AV0709.S1, AV0707.S2, AV0709.S2, AV0707.S3, AV0709.S3, 
			 AV0707.I01ID, AV0709.I01ID, AV0707.I02ID, AV0709.I02ID, AV0707.I03ID,
			 AV0709.I03ID, AV0707.I04ID, AV0709.I04ID, AV0707.I05ID, AV0709.I05ID, 
			 AV0707.Parameter01, AV0707.Parameter02, AV0707.Parameter03, 
			 AV0707.Parameter04, AV0707.Parameter05, 
			 AV0707.InventoryTypeID, AV0709.InventoryTypeID, 
			 AV0707.Specification, AV0709.Specification , 	
			 AV0707.D02Notes01, AV0707.D02Notes02, AV0707.D02Notes03,
			 AV0707.Notes01, AV0707.Notes02, AV0707.Notes03, AV0707.Notes04, AV0707.Notes05, AV0707.Notes06, AV0707.Notes07, AV0707.Notes08,
			 AV0707.Notes09, AV0707.Notes10, AV0707.Notes11, AV0707.Notes12, AV0707.Notes13, AV0707.Notes14, AV0707.Notes15,
			 AV0709.UnitName, AV0707.UnitName,	
			 AV0707.S01ID, AV0707.S02ID, AV0707.S03ID, AV0707.S04ID, 
			 AV0707.S05ID, AV0707.S06ID, AV0707.S07ID, AV0707.S08ID, 
			 AV0707.S09ID, AV0707.S10ID, AV0707.S11ID, AV0707.S12ID, 
			 AV0707.S13ID, AV0707.S14ID, AV0707.S15ID, AV0707.S16ID, 
			 AV0707.S17ID, AV0707.S18ID, AV0707.S19ID, AV0707.S20ID,
			 AV0707.LimitDate, AV0709.LimitDate, AV0707.SourceNo, AV0709.SourceNo,
			 AV0707.Ana01ID, AV0709.Ana01ID, AV0707.Ana02ID, AV0709.Ana02ID, AV0707.Ana03ID, AV0709.Ana03ID, AV0707.Ana04ID, AV0709.Ana04ID,
			 AV0707.Ana05ID, AV0709.Ana05ID, AV0707.Ana06ID, AV0709.Ana06ID, AV0707.Ana07ID, AV0709.Ana07ID, AV0707.Ana08ID, AV0709.Ana08ID,
			 AV0707.Ana09ID, AV0709.Ana09ID, AV0707.Ana10ID, AV0709.Ana10ID,  
			 AV0707.Ana01Name, AV0709.Ana01Name, AV0707.Ana02Name, AV0709.Ana02Name, AV0707.Ana03Name, AV0709.Ana03Name, AV0707.Ana04Name, AV0709.Ana04Name,
			 AV0707.Ana05Name, AV0709.Ana05Name, AV0707.Ana06Name, AV0709.Ana06Name, AV0707.Ana07Name, AV0709.Ana07Name,
			 AV0707.Ana08Name, AV0709.Ana08Name, AV0707.Ana09Name, AV0709.Ana09Name, AV0707.Ana10Name, AV0709.Ana10Name	'

	SET @sSQL7_EIMSKIP = N' )Temp
		LEFT JOIN AT0128 A01 WITH (NOLOCK) ON Temp.S01ID = A01.StandardID AND A01.StandardTypeID = ''S01''
		LEFT JOIN AT0128 A02 WITH (NOLOCK) ON Temp.S02ID = A02.StandardID AND A02.StandardTypeID = ''S02''
		LEFT JOIN AT0128 A03 WITH (NOLOCK) ON Temp.S03ID = A03.StandardID AND A03.StandardTypeID = ''S03''
		LEFT JOIN AT0128 A04 WITH (NOLOCK) ON Temp.S04ID = A04.StandardID AND A04.StandardTypeID = ''S04''
		LEFT JOIN AT0128 A05 WITH (NOLOCK) ON Temp.S05ID = A05.StandardID AND A05.StandardTypeID = ''S05''
		LEFT JOIN AT0128 A06 WITH (NOLOCK) ON Temp.S06ID = A06.StandardID AND A06.StandardTypeID = ''S06''
		LEFT JOIN AT0128 A07 WITH (NOLOCK) ON Temp.S07ID = A07.StandardID AND A07.StandardTypeID = ''S07''
		LEFT JOIN AT0128 A08 WITH (NOLOCK) ON Temp.S08ID = A08.StandardID AND A08.StandardTypeID = ''S08''
		LEFT JOIN AT0128 A09 WITH (NOLOCK) ON Temp.S09ID = A09.StandardID AND A09.StandardTypeID = ''S09''
		LEFT JOIN AT0128 A10 WITH (NOLOCK) ON Temp.S10ID = A10.StandardID AND A10.StandardTypeID = ''S10''
		LEFT JOIN AT0128 A11 WITH (NOLOCK) ON Temp.S11ID = A11.StandardID AND A11.StandardTypeID = ''S11''
		LEFT JOIN AT0128 A12 WITH (NOLOCK) ON Temp.S12ID = A12.StandardID AND A12.StandardTypeID = ''S12''
		LEFT JOIN AT0128 A13 WITH (NOLOCK) ON Temp.S13ID = A13.StandardID AND A13.StandardTypeID = ''S13''
		LEFT JOIN AT0128 A14 WITH (NOLOCK) ON Temp.S14ID = A14.StandardID AND A14.StandardTypeID = ''S14''
		LEFT JOIN AT0128 A15 WITH (NOLOCK) ON Temp.S15ID = A15.StandardID AND A15.StandardTypeID = ''S15''
		LEFT JOIN AT0128 A16 WITH (NOLOCK) ON Temp.S16ID = A16.StandardID AND A16.StandardTypeID = ''S16''
		LEFT JOIN AT0128 A17 WITH (NOLOCK) ON Temp.S17ID = A17.StandardID AND A17.StandardTypeID = ''S17''
		LEFT JOIN AT0128 A18 WITH (NOLOCK) ON Temp.S18ID = A18.StandardID AND A18.StandardTypeID = ''S18''
		LEFT JOIN AT0128 A19 WITH (NOLOCK) ON Temp.S19ID = A19.StandardID AND A19.StandardTypeID = ''S19''
		LEFT JOIN AT0128 A20 WITH (NOLOCK) ON Temp.S20ID = A20.StandardID AND A20.StandardTypeID = ''S20'' '

	SET @sSQL8 = '
		LEFT JOIN AT1303 WITH (NOLOCK) ON AT1303.WarehouseID BETWEEN '''+@FromWareHouseID+''' AND '''+@ToWareHouseID+'''
		LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (Temp.DivisionID,''@@@'') AND Temp.InventoryID = AT1302.InventoryID
		LEFT JOIN AT1015 I_01 WITH (NOLOCK) ON AT1302.DivisionID IN (I_01.DivisionID,''@@@'') AND I_01.AnaID = AT1302.I01ID AND I_01.AnaTypeID = ''I01''
		LEFT JOIN AT1015 I_02 WITH (NOLOCK) ON AT1302.DivisionID IN (I_02.DivisionID,''@@@'') AND I_02.AnaID = AT1302.I02ID AND I_02.AnaTypeID = ''I02''
		LEFT JOIN AT1015 I_03 WITH (NOLOCK) ON AT1302.DivisionID IN (I_03.DivisionID,''@@@'') AND I_03.AnaID = AT1302.I03ID AND I_03.AnaTypeID = ''I03''
		LEFT JOIN AT1015 I_04 WITH (NOLOCK) ON AT1302.DivisionID IN (I_04.DivisionID,''@@@'') AND I_04.AnaID = AT1302.I04ID AND I_04.AnaTypeID = ''I04''
		LEFT JOIN AT1015 I_05 WITH (NOLOCK) ON AT1302.DivisionID IN (I_05.DivisionID,''@@@'') AND I_05.AnaID = AT1302.I05ID AND I_05.AnaTypeID = ''I05''
		LEFT JOIN AT1015 I_06 WITH (NOLOCK) ON AT1302.DivisionID IN (I_06.DivisionID,''@@@'') AND I_06.AnaID = AT1302.I06ID AND I_06.AnaTypeID = ''I06''
		LEFT JOIN AT1015 I_07 WITH (NOLOCK) ON AT1302.DivisionID IN (I_07.DivisionID,''@@@'') AND I_07.AnaID = AT1302.I07ID AND I_07.AnaTypeID = ''I07''
		LEFT JOIN AT1015 I_08 WITH (NOLOCK) ON AT1302.DivisionID IN (I_08.DivisionID,''@@@'') AND I_08.AnaID = AT1302.I08ID AND I_08.AnaTypeID = ''I08''
		LEFT JOIN AT1015 I_09 WITH (NOLOCK) ON AT1302.DivisionID IN (I_09.DivisionID,''@@@'') AND I_09.AnaID = AT1302.I09ID AND I_09.AnaTypeID = ''I09''
		LEFT JOIN AT1015 I_10 WITH (NOLOCK) ON AT1302.DivisionID IN (I_10.DivisionID,''@@@'') AND I_10.AnaID = AT1302.I10ID AND I_10.AnaTypeID = ''I10''
		WHERE (ISNULL(Temp.BeginQuantity,0) = 0 AND (((ISNULL(Temp.DebitQuantity,0) <> 0 AND ISNULL(Temp.CreditQuantity,0) <> 0)) 
		   OR (ISNULL(Temp.DebitQuantity,0) <> 0 OR ISNULL(Temp.CreditQuantity,0) <> 0)) OR (ISNULL(Temp.BeginQuantity,0) <> 0))
		   OR (ISNULL(Temp.BeginQuantity,0)+ISNULL(Temp.DebitQuantity,0) - ISNULL(Temp.CreditQuantity,0)) <> 0 '
END
ELSE
BEGIN
SET @sSQL4 = '
SELECT DISTINCT 
isnull(AV0707.ObjectID,AV0709.ObjectID) as ObjectID, 
isnull(AV0707.ObjectName,AV0709.ObjectName) as ObjectName, 	
isnull(AV0707.Address,AV0709.Address) as Address, 
isnull(AV0707.InventoryID,AV0709.InventoryID) as InventoryID, 
isnull(AV0707.InventoryName,AV0709.InventoryName) as InventoryName, 
isnull(AV0707.RefInventoryID,AV0709.RefInventoryID) as RefInventoryID, 
Isnull(AV0707.UnitID,AV0709.UnitID) as UnitID,
isnull(AV0707.S1, AV0709.S1) as S1, 
isnull(AV0707.S2, AV0709.S2) as S2, 
isnull(AV0707.S3, AV0709.S3) as S3, 
isnull(AV0707.I01ID, AV0709.I01ID) as I01ID, 
isnull(AV0707.I02ID, AV0709.I02ID) as I02ID, 
isnull(AV0707.I03ID, AV0709.I03ID) as I03ID, 
isnull(AV0707.I04ID, AV0709.I04ID) as I04ID, 
isnull(AV0707.I05ID, AV0709.I05ID) as I05ID, 
 AV0707.Parameter01, AV0707.Parameter02, AV0707.Parameter03, AV0707.Parameter04, AV0707.Parameter05, 
isnull(AV0707.InventoryTypeID, AV0709.InventoryTypeID) as InventoryTypeID, 
isnull(AV0707.Specification , AV0709.Specification ) as Specification, 	
AV0707.D02Notes01 , AV0707.D02Notes02 , AV0707.D02Notes03,AV0707.Notes01, AV0707.Notes03, AV0707.Notes04, AV0707.Notes05, AV0707.Notes06, AV0707.Notes07, AV0707.Notes08,
AV0707.Notes09, AV0707.Notes10, AV0707.Notes11, AV0707.Notes12, AV0707.Notes13, AV0707.Notes14, AV0707.Notes15, ISNULL(AV0707.SourceNo,AV0709.SourceNo) as SourceNo ,
isnull(AV0709.UnitName,	AV0707.UnitName) as UnitName,	
SUM(isnull(AV0709.BeginQuantity,0)) as BeginQuantity,
SUM(isnull(AV0709.BeginConvertedQuantity,0)) as BeginConvertedQuantity,
SUM(isnull(AV0709.BeginMarkQuantity,0)) as BeginMarkQuantity,
SUM(isnull(AV0709.BeginAmount,0)) as BeginAmount,
SUM(isnull(AV0707.DebitQuantity,0)) as DebitQuantity, 
SUM(isnull(AV0707.CreditQuantity,0)) as CreditQuantity,
SUM(isnull(AV0707.DebitConvertedQuantity,0)) as DebitConvertedQuantity, 
SUM(isnull(AV0707.CreditConvertedQuantity,0)) as CreditConvertedQuantity,
SUM(isnull(AV0707.DebitMarkQuantity,0)) as DebitMarkQuantity, 
SUM(isnull(AV0707.CreditMarkQuantity,0)) as CreditMarkQuantity,
SUM(isnull(AV0707.DebitAmount,0 )) as DebitAmount,
SUM(isnull(AV0707.CreditAmount, 0)) as CreditAmount,
SUM(isnull(AV0709.BeginQuantity,0) + isnull(AV0707.DebitQuantity,0)  - isnull(AV0707.CreditQuantity,0)) as EndQuantity,
SUM(isnull(AV0709.BeginConvertedQuantity,0) + isnull(AV0707.DebitConvertedQuantity,0)  - isnull(AV0707.CreditConvertedQuantity,0)) as EndConvertedQuantity,
SUM(isnull(AV0709.BeginMarkQuantity,0) + isnull(AV0707.DebitMarkQuantity,0)  - isnull(AV0707.CreditMarkQuantity,0)) as EndMarkQuantity,
SUM(isnull(AV0709.BeginAmount,0) + isnull(AV0707.DebitAmount,0)  - isnull(AV0707.CreditAmount,0) )as EndAmount, 
''' + @DivisionID +  ''' AS DivisionID, 
ISNULL(AV0707.ConvertedUnitID,AV0709.ConvertedUnitID) as ConvertedUnitID,
ISNULL(AV0707.S01ID,'''') AS S01ID, ISNULL(AV0707.S02ID,'''') AS S02ID, ISNULL(AV0707.S03ID,'''') AS S03ID, ISNULL(AV0707.S04ID,'''') AS S04ID, 
ISNULL(AV0707.S05ID,'''') AS S05ID, ISNULL(AV0707.S06ID,'''') AS S06ID, ISNULL(AV0707.S07ID,'''') AS S07ID, ISNULL(AV0707.S08ID,'''') AS S08ID, 
ISNULL(AV0707.S09ID,'''') AS S09ID, ISNULL(AV0707.S10ID,'''') AS S10ID, ISNULL(AV0707.S11ID,'''') AS S11ID, ISNULL(AV0707.S12ID,'''') AS S12ID, 
ISNULL(AV0707.S13ID,'''') AS S13ID, ISNULL(AV0707.S14ID,'''') AS S14ID, ISNULL(AV0707.S15ID,'''') AS S15ID, ISNULL(AV0707.S16ID,'''') AS S16ID, 
ISNULL(AV0707.S17ID,'''') AS S17ID, ISNULL(AV0707.S18ID,'''') AS S18ID, ISNULL(AV0707.S19ID,'''') AS S19ID, ISNULL(AV0707.S20ID,'''') AS S20ID	'

SET @sSQL4_01 = N',
	A01.StandardName AS StandardName01, A02.StandardName AS StandardName02, A03.StandardName AS StandardName03, A04.StandardName AS StandardName04, 
	A05.StandardName AS StandardName05, A06.StandardName AS StandardName06, A07.StandardName AS StandardName07, A08.StandardName AS StandardName08, 
	A09.StandardName AS StandardName09, A10.StandardName AS StandardName10, A11.StandardName AS StandardName11, A12.StandardName AS StandardName12,
	A13.StandardName AS StandardName13, A14.StandardName AS StandardName14, A15.StandardName AS StandardName15, A16.StandardName AS StandardName16,
	A17.StandardName AS StandardName17, A18.StandardName AS StandardName18, A19.StandardName AS StandardName19, A20.StandardName AS StandardName20 , ISNULL(AV0707.WareHouseID,AV0709.WareHouseID) as WareHouseID, ISNULL(AV0707.WareHouseName,AV0709.WareHouseName) as WareHouseName'

SET @sSQL4A =
CASE WHEN @CustomerName=36 THEN ', AT1309.ConversionFactor, AT1202.VATNo, AT1202.Note, AT1202.Note1' ELSE '' END+''


SET @sSQL5 = '
From #AV0707 AV0707 Full join #AV0709 AV0709 on	(AV0709.InventoryID = AV0707.InventoryID) and
				(AV0709.ObjectID = AV0707.ObjectID) and (AV0709.DivisionID = AV0707.DivisionID)	AND (AV0707.SourceNo = AV0709.SourceNo)
				AND AV0707.WareHouseID = AV0709.WareHouseID
				AND ISNULL(AV0707.S01ID,'''') = Isnull(AV0709.S01ID,'''') AND ISNULL(AV0707.S02ID,'''') = isnull(AV0709.S02ID,'''')
				AND ISNULL(AV0707.S03ID,'''') = isnull(AV0709.S03ID,'''') AND ISNULL(AV0707.S04ID,'''') = isnull(AV0709.S04ID,'''')
				AND ISNULL(AV0707.S05ID,'''') = isnull(AV0709.S05ID,'''') AND ISNULL(AV0707.S06ID,'''') = isnull(AV0709.S06ID,'''')
				AND ISNULL(AV0707.S07ID,'''') = isnull(AV0709.S07ID,'''') AND ISNULL(AV0707.S08ID,'''') = isnull(AV0709.S08ID,'''') 
				AND ISNULL(AV0707.S09ID,'''') = isnull(AV0709.S09ID,'''') AND ISNULL(AV0707.S10ID,'''') = isnull(AV0709.S10ID,'''') 
				AND ISNULL(AV0707.S11ID,'''') = isnull(AV0709.S11ID,'''') AND ISNULL(AV0707.S12ID,'''') = isnull(AV0709.S12ID,'''') 
				AND ISNULL(AV0707.S13ID,'''') = isnull(AV0709.S13ID,'''') AND ISNULL(AV0707.S14ID,'''') = isnull(AV0709.S14ID,'''') 
				AND ISNULL(AV0707.S15ID,'''') = isnull(AV0709.S15ID,'''') AND ISNULL(AV0707.S16ID,'''') = isnull(AV0709.S16ID,'''') 
				AND ISNULL(AV0707.S17ID,'''') = isnull(AV0709.S17ID,'''') AND ISNULL(AV0707.S18ID,'''') = isnull(AV0709.S18ID,'''') 
				AND ISNULL(AV0707.S19ID,'''') = isnull(AV0709.S19ID,'''') AND ISNULL(AV0707.S20ID,'''') = isnull(AV0709.S20ID,'''')
LEFT JOIN AT0128 A01 WITH (NOLOCK) ON AV0707.S01ID = A01.StandardID AND A01.StandardTypeID = ''S01''
LEFT JOIN AT0128 A02 WITH (NOLOCK) ON AV0707.S02ID = A02.StandardID AND A02.StandardTypeID = ''S02''
LEFT JOIN AT0128 A03 WITH (NOLOCK) ON AV0707.S03ID = A03.StandardID AND A03.StandardTypeID = ''S03''
LEFT JOIN AT0128 A04 WITH (NOLOCK) ON AV0707.S04ID = A04.StandardID AND A04.StandardTypeID = ''S04''
LEFT JOIN AT0128 A05 WITH (NOLOCK) ON AV0707.S05ID = A05.StandardID AND A05.StandardTypeID = ''S05''
LEFT JOIN AT0128 A06 WITH (NOLOCK) ON AV0707.S06ID = A06.StandardID AND A06.StandardTypeID = ''S06''
LEFT JOIN AT0128 A07 WITH (NOLOCK) ON AV0707.S07ID = A07.StandardID AND A07.StandardTypeID = ''S07''
LEFT JOIN AT0128 A08 WITH (NOLOCK) ON AV0707.S08ID = A08.StandardID AND A08.StandardTypeID = ''S08''
LEFT JOIN AT0128 A09 WITH (NOLOCK) ON AV0707.S09ID = A09.StandardID AND A09.StandardTypeID = ''S09''
LEFT JOIN AT0128 A10 WITH (NOLOCK) ON AV0707.S10ID = A10.StandardID AND A10.StandardTypeID = ''S10''
LEFT JOIN AT0128 A11 WITH (NOLOCK) ON AV0707.S11ID = A11.StandardID AND A11.StandardTypeID = ''S11''
LEFT JOIN AT0128 A12 WITH (NOLOCK) ON AV0707.S12ID = A12.StandardID AND A12.StandardTypeID = ''S12''
LEFT JOIN AT0128 A13 WITH (NOLOCK) ON AV0707.S13ID = A13.StandardID AND A13.StandardTypeID = ''S13''
LEFT JOIN AT0128 A14 WITH (NOLOCK) ON AV0707.S14ID = A14.StandardID AND A14.StandardTypeID = ''S14''
LEFT JOIN AT0128 A15 WITH (NOLOCK) ON AV0707.S15ID = A15.StandardID AND A15.StandardTypeID = ''S15''
LEFT JOIN AT0128 A16 WITH (NOLOCK) ON AV0707.S16ID = A16.StandardID AND A16.StandardTypeID = ''S16''
LEFT JOIN AT0128 A17 WITH (NOLOCK) ON AV0707.S17ID = A17.StandardID AND A17.StandardTypeID = ''S17''
LEFT JOIN AT0128 A18 WITH (NOLOCK) ON AV0707.S18ID = A18.StandardID AND A18.StandardTypeID = ''S18''
LEFT JOIN AT0128 A19 WITH (NOLOCK) ON AV0707.S19ID = A19.StandardID AND A19.StandardTypeID = ''S19''
LEFT JOIN AT0128 A20 WITH (NOLOCK) ON AV0707.S20ID = A20.StandardID AND A20.StandardTypeID = ''S20''	'

SET @sSQL6 = ''+CASE WHEN (SELECT CustomerName FROM CustomerIndex WITH (NOLOCK) ) = 70 THEN '
LEFT JOIN AT1303 WITH (NOLOCK) ON AT1303.WarehouseID BETWEEN N'''+@FromWareHouseID+N''' and N'''+@ToWareHouseID+N'''
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (isnull(AV0707.DivisionID,AV0709.DivisionID),''@@@'') AND isnull(AV0707.InventoryID,AV0709.InventoryID) = AT1302.InventoryID
LEFT JOIN AT1015 I_01 WITH (NOLOCK) ON AT1302.DivisionID IN (I_01.DivisionID,''@@@'') AND I_01.AnaID = AT1302.I01ID AND I_01.AnaTypeID = ''I01''
LEFT JOIN AT1015 I_02 WITH (NOLOCK) ON AT1302.DivisionID IN (I_02.DivisionID,''@@@'') AND I_02.AnaID = AT1302.I02ID AND I_02.AnaTypeID = ''I02''
LEFT JOIN AT1015 I_03 WITH (NOLOCK) ON AT1302.DivisionID IN (I_03.DivisionID,''@@@'') AND I_03.AnaID = AT1302.I03ID AND I_03.AnaTypeID = ''I03''
LEFT JOIN AT1015 I_04 WITH (NOLOCK) ON AT1302.DivisionID IN (I_04.DivisionID,''@@@'') AND I_04.AnaID = AT1302.I04ID AND I_04.AnaTypeID = ''I04''
LEFT JOIN AT1015 I_05 WITH (NOLOCK) ON AT1302.DivisionID IN (I_05.DivisionID,''@@@'') AND I_05.AnaID = AT1302.I05ID AND I_05.AnaTypeID = ''I05''
LEFT JOIN AT1015 I_06 WITH (NOLOCK) ON AT1302.DivisionID IN (I_06.DivisionID,''@@@'') AND I_06.AnaID = AT1302.I06ID AND I_06.AnaTypeID = ''I06''
LEFT JOIN AT1015 I_07 WITH (NOLOCK) ON AT1302.DivisionID IN (I_07.DivisionID,''@@@'') AND I_07.AnaID = AT1302.I07ID AND I_07.AnaTypeID = ''I07''
LEFT JOIN AT1015 I_08 WITH (NOLOCK) ON AT1302.DivisionID IN (I_08.DivisionID,''@@@'') AND I_08.AnaID = AT1302.I08ID AND I_08.AnaTypeID = ''I08''
LEFT JOIN AT1015 I_09 WITH (NOLOCK) ON AT1302.DivisionID IN (I_09.DivisionID,''@@@'') AND I_09.AnaID = AT1302.I09ID AND I_09.AnaTypeID = ''I09''
LEFT JOIN AT1015 I_10 WITH (NOLOCK) ON AT1302.DivisionID IN (I_010.DivisionID,''@@@'') AND I_10.AnaID = AT1302.I10ID AND I_10.AnaTypeID = ''I10'''  ELSE '' END+'
'

IF @CustomerName = 36 ----Customize SaigonPetro
	BEGIN
		SET @sSQL6 = @sSQL6 + '
		LEFT JOIN (Select InventoryID,Min(UnitID) As UnitID, Min(ConversionFactor) As ConversionFactor, Min(Operator) As Operator, DivisionID From AT1309 WITH (NOLOCK) 
					Group By InventoryID, DivisionID) AT1309 On isnull(AV0707.InventoryID,AV0709.InventoryID) = AT1309.InventoryID 
					and isnull(AV0707.DivisionID,AV0709.DivisionID) = AT1309.DivisionID
		LEFT JOIN AT1202 WITH (NOLOCK) ON ISNULL(AV0707.ObjectID,AV0709.ObjectID) = AT1202.ObjectID
		'
	END
IF @CustomerName = 38 ----Customize BOURBON BẾN LỨC
	BEGIN
		SET @sSQLWHERE ='Where  
	(( ISNULL(AV0709.BeginQuantity,0) <> 0 AND (((ISNULL(AV0707.DebitQuantity,0) <> 0 AND  ISNULL(AV0707.CreditQuantity,0) <> 0))  OR(ISNULL(AV0707.DebitQuantity,0) <> 0 OR  ISNULL(AV0707.CreditQuantity,0) <> 0)) )
	 OR ( ISNULL(AV0709.BeginQuantity,0) =0 AND (((ISNULL(AV0707.DebitQuantity,0) <> 0 AND  ISNULL(AV0707.CreditQuantity,0) <> 0))  OR(ISNULL(AV0707.DebitQuantity,0) <> 0 OR  ISNULL(AV0707.CreditQuantity,0) <> 0)) )
	 OR (ISNULL(AV0709.BeginQuantity,0)+ISNULL(AV0707.DebitQuantity,0) - ISNULL(AV0707.CreditQuantity,0)) <> 0)
		'
	END
	SET @sSQLGroupBy =N' Group by  isnull(AV0707.ObjectID,AV0709.ObjectID) , 
isnull(AV0707.ObjectName,AV0709.ObjectName) , 	
isnull(AV0707.Address,AV0709.Address) , 
isnull(AV0707.InventoryID,AV0709.InventoryID) , 
isnull(AV0707.InventoryName,AV0709.InventoryName) , 
isnull(AV0707.RefInventoryID,AV0709.RefInventoryID) , 
Isnull(AV0707.UnitID,AV0709.UnitID) ,
isnull(AV0707.S1, AV0709.S1), 
isnull(AV0707.S2, AV0709.S2), 
isnull(AV0707.S3, AV0709.S3), 
isnull(AV0707.I01ID, AV0709.I01ID), 
isnull(AV0707.I02ID, AV0709.I02ID), 
isnull(AV0707.I03ID, AV0709.I03ID), 
isnull(AV0707.I04ID, AV0709.I04ID), 
isnull(AV0707.I05ID, AV0709.I05ID), 
 AV0707.Parameter01, AV0707.Parameter02, AV0707.Parameter03, AV0707.Parameter04, AV0707.Parameter05, 
isnull(AV0707.InventoryTypeID, AV0709.InventoryTypeID) , 
isnull(AV0707.Specification , AV0709.Specification ) , 	
AV0707.D02Notes01 , AV0707.D02Notes02 , AV0707.D02Notes03,AV0707.Notes01 , AV0707.Notes03, AV0707.Notes04, AV0707.Notes05, AV0707.Notes06, AV0707.Notes07, AV0707.Notes08,
AV0707.Notes09, AV0707.Notes10, AV0707.Notes11, AV0707.Notes12, AV0707.Notes13, AV0707.Notes14, AV0707.Notes15,
ISNULL(AV0707.SourceNo,AV0709.SourceNo) ,
isnull(AV0709.UnitName,	AV0707.UnitName), 
ISNULL(AV0707.ConvertedUnitID,AV0709.ConvertedUnitID),
ISNULL(AV0707.S01ID,'''') , ISNULL(AV0707.S02ID,'''') , ISNULL(AV0707.S03ID,'''') , ISNULL(AV0707.S04ID,''''), 
ISNULL(AV0707.S05ID,'''') , ISNULL(AV0707.S06ID,'''') , ISNULL(AV0707.S07ID,'''') , ISNULL(AV0707.S08ID,''''), 
ISNULL(AV0707.S09ID,'''') , ISNULL(AV0707.S10ID,'''') , ISNULL(AV0707.S11ID,'''') , ISNULL(AV0707.S12ID,''''), 
ISNULL(AV0707.S13ID,'''') , ISNULL(AV0707.S14ID,'''') , ISNULL(AV0707.S15ID,'''') , ISNULL(AV0707.S16ID,''''), 
ISNULL(AV0707.S17ID,'''') , ISNULL(AV0707.S18ID,'''') , ISNULL(AV0707.S19ID,'''') , ISNULL(AV0707.S20ID,''''),ISNULL(AV0707.WareHouseID,AV0709.WareHouseID),ISNULL(AV0707.WareHouseName,AV0709.WareHouseName)
,A01.StandardName    , A02.StandardName , A03.StandardName , A04.StandardName , 
	A05.StandardName , A06.StandardName , A07.StandardName , A08.StandardName , 
	A09.StandardName , A10.StandardName , A11.StandardName , A12.StandardName ,
	A13.StandardName , A14.StandardName , A15.StandardName , A16.StandardName ,
	A17.StandardName , A18.StandardName , A19.StandardName , A20.StandardName  '

END

PRINT (@sSQLAV7000_1)
PRINT (@sSQLAV7000_1A)
PRINT (@sSQLAV7000_2)
PRINT (@sSQLAV7000_2A)
PRINT (@sSQLAV7000_3)
PRINT (@sSQLAV7000_3FROM)
PRINT @sSQLAV7000_4
PRINT @sSQLAV7000_4FROM
PRINT (@sSQL1)
PRINT (@sSQL2)
PRINT (@sSQL3)
PRINT (@sSQL4)
PRINT (@sSQL4_01)
PRINT (@sSQL4A)
PRINT @sSQL5
PRINT @sSQL5a
PRINT @sSQLGroupBy_EIMSKIP
PRINT @sSQL6
PRINT @sSQL6a
print @sSQLWHERE
Print @sSQLGroupBy
PRINT @sSQL7
PRINT @sSQLGroupBy_EIMSKIP
PRINT @sSQL7_EIMSKIP
PRINT @sSQL8

EXEC (@sSQLAV7000_1 + @sSQLAV7000_1A + @sSQLAV7000_2 + @sSQLAV7000_2A + @sSQLAV7000_3 + @sSQLAV7000_3FROM + @sSQLAV7000_4 + @sSQLAV7000_4FROM + @sSQL1 + @sSQL2 + @sSQL3 + @sSQL4 + @sSQL4_01 + @sSQL4A + @sSQL5 + @sSQL5a + @sSQLGroupBy_EIMSKIP + @sSQL6 + @sSQL6a + @sSQLWHERE + @sSQLGroupBy + @sSQL7 + @sSQLGroupBy_EIMSKIP + @sSQL7_EIMSKIP + @sSQL8)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO