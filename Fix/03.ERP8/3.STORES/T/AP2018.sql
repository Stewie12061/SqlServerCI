IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP2018]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP2018]
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
---- Modified on 07/01/2016 by Tiểu Mai: Bổ sung in báo cáo khi có thiết lập quản lý mặt hàng theo quy cách.
---- Modified on 17/03/2016 by Thị Phượng: Sửa lại điều kiện lấy thời gian của phiếu
---- Modified on 18/03/2016 by Kim Vu: Bo sung loc theo kho
---- Modify on 08/04/2016 by Bảo Anh: Bổ sung gọi store customize cho FIGLA
---- Modified on 25/04/2016 by Phương Thảo: Chỉnh sửa sp do thay đổi cách truyền @WarehouseID khi in tất cả kho
---- Modified on 06/05/2016 by Thị Phượng:lấy Isnull trường AT2007.ConvertedAmount trước trường hợp in thành tiền rỗng
---- Modified by Bảo Thy on 27/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Kim Vũ on 14/10/2016: Chuyển kiểu dữ liệu biến @WareHouseID sang xml để tránh tràn dữ liệu
---- Modified by Phương Thảo on 20/01/2017: Bổ sung KindVoucherID
---- Modified by Hải Long on 28/02/2017: Bổ sung VDescription, BDescription, TDescription lấy từ AT9000 (KH: GODTEST)
---- Modified by Bảo Thy on 08/05/2017: Sửa danh mục dùng chung
---- Modified by Hải Long on 29/05/2017: Sửa lỗi double dữ liệu do câu nối sang AT9000 sai
---- Modified by Bảo Thy on 05/12/2017: Sửa cách lấy AT9000.InvoiceNo
---- Modified by Bảo Anh on 21/12/2017: trả lại cách lấy AT9000.InvoiceNo như các bản trước vì không lên được dữ liệu nhập xuất phát sinh
---- Modified by Bảo Thy on 27/12/2017: Fix lỗi không hiển thị dữ liệu nhập kho
---- Modified by Bảo Anh on 03/01/2018: Sửa lại cách lấy AT9000.InvoiceNo dùng sub query, không Left Join AT9000
---- Modified by Bảo Thy on 20/01/2018: Bổ sung lọc báo cáo theo quy cách
---- Modified by Kim Thư on 16/11/2018: Bổ sung @UserID, lấy thêm cột AT2006.OrderID (Mạnh Phương)
---- Modified by Kim Thư on 29/11/2018: Sửa lỗi truyền biến @WareHouseIDCus
---- Modified by Kim Thư on 17/12/2018: Bỏ truyền @UserID, dùng biến bảng lấy view AV7015 và AV2028 để nhiều User cùng in không bị trùng bảng tạm
---- Modified by Kim Thư on 04/03/2019: Bổ sung kết bảng #AV7015.OrderID để sửa lỗi double dòng
---- Modified by Kim Thư on 14/03/2019: Viết lại câu lấy số dư đầu kỳ trong select con, do Mạnh Phương các dòng có phân biệt OrderID nên không thể kết bảng
---- Modified by Kim Thư on 22/04/2019: Bổ sung thêm trường nhóm người dùng (GroupID) , truyền @UserID
---- Modified by Kim Thư on 03/05/2019: Bổ sung thêm trường đơn hàng mua AT2007.OrderID vào dữ liệu trong kỳ (sửa bản chuẩn, theo yêu cầu của Mạnh Phương)
---- Modified by Huỳnh Thử on 16/03/2020: Nếu số lượng tồn đầu và thành tiền = null, default = 0
---- Modified by Văn Tài on 12/06/2020: Bổ sung lấy dữ liệu barcode.
---- Modified by Đức Thông on 31/07/2020: Bổ sung lấy dữ liệu phiếu kiểm nghiệm, kệ, tầng theo phiếu nhập và phiếu xuất.
---- Modified by Nhựt Trường on 31/08/2020: Sửa lại cách join 2 bảng WT0169, WT0170 từ inner join thành left join.
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Nhựt Trường on 05/01/2021: Bổ sung thêm điều kiện DivisionID khi join bảng AT1401.
---- Modified by Huỳnh Thử on 22/04/2021: Bỏ VDescription, BDescription lấy từ AT9000 bị double khi Phiếu nhập bị kế thừa nhiều phiếu mua hàng
---- Modified by Nhựt Trường on 14/05/2021: Bổ sung lấy dữ liệu notes01, notes02, notes03 từ AT1302 khi select dữ liệu từ bảng tạm #AV7015.
---- Modified by Nhựt Trường on 18/05/2021: Bổ sung thêm trường MOrderID và SOrderID từ AT2007.
---- Modified by Nhật Thanh on 17/02/2022: Bổ sung thêm trường CHỨNG TỪ NHẬP ( NHẬP XUẤT THEO LÔ) từ at2006
---- Modified by Nhật Thanh on 21/02/2022: Bổ sung thêm trường hợp CHỨNG TỪ NHẬP ( NHẬP XUẤT THEO LÔ) lấy từ at9000
---- Modified by Nhựt Trường on 02/04/2022: Tăng độ rộng cột SOrderID khi tạo bảng @AV2028.
---- Modified by Nhật Thanh on 28/04/2022: Tách luồng angel
---- Modified by Thành Sang on 05/10/2022: Bố sung trường ProductID từ AT2007
---- Modified by Nhựt Trường on 01/12/2022: Fix lỗi Ambiguous column 'SourceNo'.
---- Modified by Thanh Lượng on 22/12/2022:[2022/12/IS/0124]- Edit ImSourceNo NVARCHAR(50) -> ImSourceNo NVARCHAR(100) fix lỗi tràn dữ liệu.
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified by Thành Sang on 21/02/2023 - Tăng độ rộng cho các cột ghi chú
---- Modified by Kiều Nga on 31/08/2023: [2023/08/IS/0330] Fix lỗi load tên Kho khi in Sổ chi tiết vật tư

-- declare @p2 xml
--set @p2=convert(xml,N'<DataSET><Data><WareHouseID>K01</WareHouseID></Data></DataSET>')
--exec AP2018 @DivisionID=N'MP',@UserID = 'ASOFTADMIN', @WareHouseID=@p2,@FromInventoryID=N'A1200L',@ToInventoryID=N'ZZZ',@FromMonth=11,@FromYear=2018,@ToMonth=11,@ToYear=2018,@FromDate='2018-11-16 00:00:00',@ToDate='2018-11-16 00:00:00',@IsDate=0,@IsInner=1,@IsAll=0,@IsSearchStandard=0,@StandardList=NULL



CREATE PROCEDURE [dbo].[AP2018]
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
	   @IsAll AS tinyint,
	   @IsSearchStandard TINYINT,
	   @StandardList XML,
	   @UserID VARCHAR(50)
AS

-- Xu li du lieu xml

--IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[#TBL_WareHouseID]') AND TYPE IN (N'U'))
--BEGIN
--	CREATE TABLE #TBL_WareHouseID (WareHouseID VARCHAR(50))
--END

---- Xoa du lieu hien tai
--DELETE TBL_WareHouseID WHERE UserID=@UserID

--INSERT INTO TBL_WareHouseID
SELECT X.Data.query('WareHouseID').value('.', 'NVARCHAR(50)') AS WareHouseID
INTO #TBL_WareHouseID
FROM @WareHouseID.nodes('//Data') AS X (Data)

DECLARE @CustomerName INT,
		@WareHouseIDCus XML = '%'

--Tao bang tam de kiem tra day co phai la khach hang 2T khong (CustomerName = 15)
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444

SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

IF @CustomerName = 57 
BEGIN
	exec AP2018_AG  @DivisionID ,@WareHouseID, @FromInventoryID,@ToInventoryID,@FromMonth,@FromYear,@ToMonth,@ToYear,@FromDate,@ToDate, @IsDate , @IsInner,@IsAll
END
ELSE
BEGIN
IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
	EXEC AP2015 @DivisionID, @WareHouseID, @FromInventoryID, @ToInventoryID, @FromMonth, @FromYear, @ToMonth, @ToYear, @FromDate, @ToDate, @IsDate, @IsInner, @IsAll,@IsSearchStandard,@StandardList, @UserID
ELSE
BEGIN
IF((select count(*) from #TBL_WareHouseID) = 1)
begin 
	SET @WareHouseIDCus = N'<DataSET><Data><WareHouseID>'+(Select top 1 WareHouseID from #TBL_WareHouseID)+'</WareHouseID></Data></DataSET>'
end
else 
	SET @WareHouseIDCus = @WareHouseID

IF @CustomerName = 15 --- Customize 2T
	EXEC AP2088 @DivisionID, @WareHouseIDCus, @FromInventoryID, @ToInventoryID, @FromMonth, @FromYear, @ToMonth, @ToYear, @FromDate, @ToDate, @IsDate, @IsInner

ELSE IF @CustomerName = 49 --- Customize FIGLA
	EXEC AP2018_FL @DivisionID, @WareHouseIDCus, @FromInventoryID, @ToInventoryID, @FromMonth, @FromYear, @ToMonth, @ToYear, @FromDate, @ToDate, @IsDate, @IsInner, @IsAll
ELSE
	BEGIN
		DECLARE
				@sSQlSelect AS nvarchar(4000) ,
				@sSQlFrom AS nvarchar(4000) ,
				@sSQlWhere AS nvarchar(4000) ,
				@sSQlUnionSelect AS nvarchar(4000) ,
				@sSQlUnionFrom AS nvarchar(4000) ,
				@sSQlUnionWhere AS nvarchar(4000) ,
				@sSQlSelect2 AS nvarchar(4000) ,
				@sSQlUnionSelect2 AS nvarchar(4000) ,
				@WareHouseName AS nvarchar(4000) ,
				@WareHouseName1 AS nvarchar(4000) ,
				@WareHouseID2 AS nvarchar(4000) ,
				@WareHouseID1 AS nvarchar(4000) ,
				@KindVoucherListIm AS nvarchar(4000) ,
				@KindVoucherListEx1 AS nvarchar(4000) ,
				@KindVoucherListEx2 AS nvarchar(4000),
				@FromMonthYearText NVARCHAR(20), 
				@ToMonthYearText NVARCHAR(20), 
				@FromDateText NVARCHAR(20), 
				@ToDateText NVARCHAR(20),
				@DropTBLWareHouseID Nvarchar(1000),
				@GroupID varchar (50)
    
		SET @FromMonthYearText = STR(@FromMonth + @FromYear * 100)
		SET @ToMonthYearText = STR(@ToMonth + @ToYear * 100)
		SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
		SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'
		SET @GroupID = (SELECT TOP 1 AT1402.GroupID FROM AT1402 WITH(NOLOCK) WHERE AT1402.UserID = @UserID)

		IF((select count(*) from #TBL_WareHouseID) = 1)
		begin
			SET @WareHouseName1 = (SELECT TOP 1 WareHouseName
									FROM    AT1303 WITH (NOLOCK)
									WHERE   WareHouseID in (Select top 1 WareHouseID from  #TBL_WareHouseID) AND DivisionID IN ('@@@',@DivisionID))
		end

		--EXEC AP7015 @DivisionID , @WareHouseID , @FromInventoryID , @ToInventoryID , @FromMonth , @FromYear , @ToMonth , @ToYear , @FromDate , @ToDate , @IsDate, @IsAll
		--TẠO BIẾN BẢNG THAY CHO VIEW AV7015
		DECLARE @AV7015 AS TABLE (DivisionID VARCHAR(50), WareHouseID VARCHAR(50), WareHouseName NVARCHAR(250), InventoryID VARCHAR(50), InventoryName NVARCHAR(250), UnitID VARCHAR(50),
								 UnitName NVARCHAR(250), BeginQuantity DECIMAL(28,8), BeginAmount DECIMAL(28,8), EndQuantity DECIMAL(28,8), EndAmount DECIMAL(28,8), OrderID VARCHAR(50))
		INSERT INTO @AV7015

	
		EXEC AP7015 @DivisionID , @WareHouseID , @FromInventoryID , @ToInventoryID , @FromMonth , @FromYear , @ToMonth , @ToYear , @FromDate , @ToDate , @IsDate, @IsAll
    	--PRINT 'DECLARE @AV7015 AS TABLE (DivisionID VARCHAR(50), WareHouseID VARCHAR(50), WareHouseName NVARCHAR(250), InventoryID VARCHAR(50), InventoryName NVARCHAR(250), UnitID VARCHAR(50),
		--						 UnitName NVARCHAR(250), BeginQuantity DECIMAL(28,8), BeginAmount DECIMAL(28,8), EndQuantity DECIMAL(28,8), EndAmount DECIMAL(28,8), OrderID VARCHAR(50))
		--INSERT INTO @AV7015';

		--PRINT 'EXEC AP7015'+ @DivisionID +','+ CONVERT(NVARCHAR(MAX),@WareHouseID) +','+ @FromInventoryID +','+ @ToInventoryID +','+ CONVERT(NVARCHAR(20),@FromMonth) +','+  CONVERT(NVARCHAR(20),@FromYear) +','+  CONVERT(NVARCHAR(20),@ToMonth) +','+ CONVERT(NVARCHAR(20),@ToYear)  +','+ CONVERT(NVARCHAR(20),@FromDate)  +','+ CONVERT(NVARCHAR(20),@ToDate) +','+ CONVERT(NVARCHAR(20),@IsDate)+','+ CONVERT(NVARCHAR(20),@IsAll)
		SELECT * INTO #AV7015 FROM @AV7015

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

		   END
		ELSE
		   BEGIN
			--Set @WareHouseID2 = ' CASE WHEN KindVoucherID = 3 then AT2006.WareHouseID2 else AT2006.WareHouseID end'
				 SET @WareHouseID2 = ' AT2006.WareHouseID '
				 SET @WareHouseID1 = ' CASE WHEN A61.KindVoucherID = 3 then A61.WareHouseID2 else A61.WareHouseID end '
				 SET @WareHouseName = @WareHouseName1 

		   END

		IF @IsDate = 0
		   BEGIN
				 SET @sSQlSelect = '--- Phan Nhap kho
					SELECT 	' + @WareHouseID2 + ' AS WareHouseID,
							N''' + isnull(@WareHouseName,'') + ''' AS WareHouseName, 
							AT2007.VoucherID,
							AT2007.TransactionID,
							AT2007.Orders,
							AT2006.VoucherDate,
							AT2006.VoucherNo,	
							AT2006.VoucherDate AS ImVoucherDate,
							AT2006.VoucherNo AS ImVoucherNo,		
							AT2007.SourceNo AS ImSourceNo,
							LimitDate AS ImLimitDate,	
 							AT2006.WareHouseID AS ImWareHouseID,		
							AT2006.RefNo01 AS ImRefNo01 , AT2006.RefNo02 AS ImRefNo02 , 
							AT2007.ActualQuantity AS ImQuantity,
							AT2007.UnitPrice AS ImUnitPrice ,
							Isnull(AT2007.ConvertedAmount, AT2007.OriginalAmount) AS ImConvertedAmount,
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
							AT2006.VoucherTypeID,
							AT2006.Description,
							AT2007.Notes,
							AT2007.InventoryID,	
							AT1302.InventoryName,
							AT2007.UnitID,		
							isnull(AT2007.ConversionFactor ,1) AS ConversionFactor,
							IsNULL((SELECT SUM(BeginQuantity) from #AV7015 AV7015 WHERE AV7015.InventoryID = AT2007.InventoryID AND AV7015.DivisionID = AT2007.DivisionID),0) AS BeginQuantity,
							IsNULL((SELECT SUM(BeginAmount) from #AV7015 AV7015 WHERE AV7015.InventoryID = AT2007.InventoryID AND AV7015.DivisionID = AT2007.DivisionID),0) AS BeginAmount,
							--isnull(AV7015.BeginQuantity,0) AS BeginQuantity,
							--isnull(AV7015.BeginAmount,0) AS BeginAmount,
							(CASE WHEN KindVoucherID = 7 then 3 else 1 end) AS ImExOrders,
							AT2007.DebitAccountID, AT2007.CreditAccountID,
							At2006.ObjectID,
							AT1202.ObjectName,
							AT1302.Notes01,
							AT1302.Notes02,
							AT1302.Notes03, AT2007.DivisionID, AT2007.ConvertedUnitID,
							AT2007.Ana01ID, AT2007.Ana02ID, AT2007.Ana03ID, AT2007.Ana04ID, AT2007.Ana05ID, AT2007.Ana06ID, AT2007.Ana07ID, AT2007.Ana08ID, AT2007.Ana09ID, AT2007.Ana10ID,							
							(Select top 1 InvoiceNo from AT9000 WITH (NOLOCK) Where DivisionID = AT2007.DivisionID And VoucherID = AT2007.VoucherID and TransactionID = AT2007.TransactionID and Isnull(InvoiceNo,'''')<>'''') as InvoiceNo,
							A01.AnaName AS Ana01Name, A02.AnaName AS Ana02Name, A03.AnaName AS Ana03Name, A04.AnaName AS Ana04Name, A05.AnaName AS Ana05Name,
							A06.AnaName AS Ana06Name, A07.AnaName AS Ana07Name, A08.AnaName AS Ana08Name, A09.AnaName AS Ana09Name, A10.AnaName AS Ana10Name,
							AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05,
							AT2006.KindVoucherID, AT2006.OrderID, AT2007.OrderID as POrderID,
							AT2007.MOrderID, AT2007.SOrderID,
							AT1302.Barcode,
							at2007.WarrantyNo,
							at2007.ShelvesID,
							wt0169.ShelvesName,
							at2007.FloorID,
							wt0170.FloorName,
							null as Revoucherno,
							AT2007.ProductID as ProductID, D02.InventoryName as ProductName
							'

				SET @sSQlFrom = ' 
					FROM AT1302 WITH (NOLOCK)					
					INNER JOIN AT2007 WITH (NOLOCK) on AT1302.DivisionID IN (AT2007.DivisionID,''@@@'') AND AT1302.InventoryID = AT2007.InventoryID
					LEFT JOIN AT1302 D02 WITH (NOLOCK) on D02.DivisionID IN (AT2007.DivisionID,''@@@'') AND D02.InventoryID = AT2007.ProductID
					LEFT JOIN wt0169 WITH (NOLOCK) on wt0169.ShelvesID = at2007.ShelvesID
					LEFT JOIN wt0170 WITH (NOLOCK) on wt0170.FloorID = at2007.FloorID
					INNER JOIN AT2006 WITH (NOLOCK) on AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID
					INNER JOIN AT1303 WITH (NOLOCK) on AT1303.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1303.WareHouseID = AT2006.WareHouseID
					LEFT  JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT2006.ObjectID
					LEFT JOIN AT1011 AS A01 WITH (NOLOCK) ON A01.AnaID = AT2007.Ana01ID AND A01.AnaTypeID = ''A01''
					LEFT JOIN AT1011 AS A02 WITH (NOLOCK) ON A02.AnaID = AT2007.Ana02ID AND A02.AnaTypeID = ''A02''
					LEFT JOIN AT1011 AS A03 WITH (NOLOCK) ON A03.AnaID = AT2007.Ana03ID AND A03.AnaTypeID = ''A03''
					LEFT JOIN AT1011 AS A04 WITH (NOLOCK) ON A04.AnaID = AT2007.Ana04ID AND A04.AnaTypeID = ''A04''
					LEFT JOIN AT1011 AS A05 WITH (NOLOCK) ON A05.AnaID = AT2007.Ana05ID AND A05.AnaTypeID = ''A05''
					LEFT JOIN AT1011 AS A06 WITH (NOLOCK) ON A06.AnaID = AT2007.Ana06ID AND A06.AnaTypeID = ''A06''
					LEFT JOIN AT1011 AS A07 WITH (NOLOCK) ON A07.AnaID = AT2007.Ana07ID AND A07.AnaTypeID = ''A07''
					LEFT JOIN AT1011 AS A08 WITH (NOLOCK) ON A08.AnaID = AT2007.Ana08ID AND A08.AnaTypeID = ''A08''
					LEFT JOIN AT1011 AS A09 WITH (NOLOCK) ON A09.AnaID = AT2007.Ana09ID AND A09.AnaTypeID = ''A09''
					LEFT JOIN AT1011 AS A10 WITH (NOLOCK) ON A10.AnaID = AT2007.Ana10ID AND A10.AnaTypeID = ''A10''		
					LEFT JOIN OT3002 WITH (NOLOCK) ON AT2007.OTransactionID = OT3002.TransactionID AND OT3002.POrderID = AT2007.OrderID									
					'
			
				SET @sSQlWhere = ' 
					WHERE	AT2007.DivisionID =N''' + @DivisionID + ''' ' +
							(CASE WHEN @IsAll = 1 THEN ' AND AT1303.IsTemp = 0 ' ELSE '' END) + ' AND
							'+CASE WHEN @CustomerName = 49 THEN ' (CASE WHEN '+STR(@IsAll)+' = 1 then   isnull(AT1303.FullName,'''') else 0 end  <> ''1'' ) AND 'ELSE '' END +'
							(Isnull(AT2007.TranMonth,AT2006.TranMonth) + 100*Isnull(AT2007.TranYear,AT2006.TranYear) between '+@FromMonthYearText+' AND  '+@ToMonthYearText+' )  AND
							KindVoucherID in ' + @KindVoucherListIm + ' AND
							(AT2007.InventoryID between N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''') AND
							AT2006.WareHouseID IN (Select WareHouseID from #TBL_WareHouseID)
				'
			--PRINT @sSQlWhere	

				 SET @sSQlUnionSelect = N' 
				 UNION
				--- Phan Xuat kho
				SELECT 	' + @WareHouseID1 + ' AS WareHouseID,
						N''' + isnull(@WareHouseName,'') + ''' AS WareHouseName, 
						AT2007.VoucherID,
						AT2007.TransactionID,
						AT2007.Orders,
						A61.VoucherDate,
						A61.VoucherNo,	
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
						A61.VoucherDate AS ExVoucherDate,
						A61.VoucherNo AS ExVoucherNo,		
						AT2007.SourceNo AS ExSourceNo,
						AT2007.LimitDate AS ExLimitDate,	
 						(CASE WHEN A61.KindVoucherID = 3 then A61.WareHouseID2 else A61.WareHouseID end) AS ExWareHouseID,	
						A61.RefNo01 AS ExRefNo01 , A61.RefNo02 AS ExRefNo02 , 
						AT2007.ActualQuantity AS ExQuantity,
						AT2007.UnitPrice AS ExUnitPrice ,
						AT2007.ConvertedAmount AS ExConvertedAmount,
						AT2007.OriginalAmount AS ExOriginalAmount,
						isnull(AT2007.ConversionFactor ,1)*ActualQuantity AS ExConvertedQuantity,
						A61.VoucherTypeID,
						A61.Description,
						AT2007.Notes,
						AT2007.InventoryID,	
						AT1302.InventoryName,
						AT2007.UnitID,		
						isnull(AT2007.ConversionFactor ,1) AS ConversionFactor,
						IsNULL((SELECT SUM(BeginQuantity) from #AV7015 AV7015 WHERE AV7015.InventoryID = AT2007.InventoryID AND AV7015.DivisionID = AT2007.DivisionID),0) AS BeginQuantity,
						IsNULL((SELECT SUM(BeginAmount) from #AV7015 AV7015 WHERE AV7015.InventoryID = AT2007.InventoryID AND AV7015.DivisionID = AT2007.DivisionID),0) AS BeginAmount,
						--isnull(AV7015.BeginQuantity,0) AS BeginQuantity,
						--isnull(AV7015.BeginAmount,0) AS BeginAmount,
						2 AS ImExOrders,
						AT2007.DebitAccountID, AT2007.CreditAccountID,
						A61.ObjectID,
						AT1202.ObjectName,
						AT1302.Notes01,
						AT1302.Notes02,
						AT1302.Notes03, AT2007.DivisionID,  AT2007.ConvertedUnitID,
						AT2007.Ana01ID, AT2007.Ana02ID, AT2007.Ana03ID, AT2007.Ana04ID, AT2007.Ana05ID, AT2007.Ana06ID, AT2007.Ana07ID, AT2007.Ana08ID, AT2007.Ana09ID, AT2007.Ana10ID,						
						(Select top 1 InvoiceNo from AT9000 WITH (NOLOCK) Where DivisionID = AT2007.DivisionID And VoucherID = AT2007.VoucherID and TransactionID = AT2007.TransactionID and Isnull(InvoiceNo,'''')<>'''') as InvoiceNo,
						A01.AnaName AS Ana01Name, A02.AnaName AS Ana02Name, A03.AnaName AS Ana03Name, A04.AnaName AS Ana04Name, A05.AnaName AS Ana05Name,
						A06.AnaName AS Ana06Name, A07.AnaName AS Ana07Name, A08.AnaName AS Ana08Name, A09.AnaName AS Ana09Name, A10.AnaName AS Ana10Name,
						AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05,
						A61.KindVoucherID, A61.OrderID, AT2007.OrderID as POrderID,
						AT2007.MOrderID, AT2007.SOrderID,
						AT1302.Barcode,
						at2007.WarrantyNo,
						at2007.ShelvesID,
						wt0169.ShelvesName,
						at2007.FloorID,
						wt0170.FloorName,
						case when isnull(A62.VoucherNo,'''')='''' then A90.VoucherNo else A62.VoucherNo end as RevoucherNo,
						AT2007.ProductID as ProductID, D02.InventoryName as ProductName'
				SET @sSQlUnionFrom = ' 
					FROM AT1302 WITH (NOLOCK) 	
					LEFT JOIN AT2007 WITH (NOLOCK) on AT1302.DivisionID IN (AT2007.DivisionID,''@@@'') AND AT1302.InventoryID = AT2007.InventoryID
					LEFT JOIN AT1302 D02 WITH (NOLOCK) on D02.DivisionID IN (AT2007.DivisionID,''@@@'') AND D02.InventoryID = AT2007.ProductID
					LEFT JOIN wt0169 WITH (NOLOCK) on wt0169.ShelvesID = at2007.ShelvesID
					LEFT JOIN wt0170 WITH (NOLOCK) on wt0170.FloorID = at2007.FloorID
					INNER JOIN AT2006 A61 WITH (NOLOCK) on A61.VoucherID = AT2007.VoucherID AND A61.DivisionID = AT2007.DivisionID
					LEFT JOIN AT2006 A62 WITH (NOLOCK) on A62.VoucherID = AT2007.ReVoucherID AND A62.DivisionID = AT2007.DivisionID
					LEFT JOIN AT9000 A90 WITH (NOLOCK) on A90.VoucherID = AT2007.ReVoucherID AND A90.DivisionID = AT2007.DivisionID
					INNER JOIN AT1303 WITH (NOLOCK) on AT1303.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1303.WareHouseID = ( CASE WHEN A61.KindVoucherID = 3 Then A61.WareHouseID2  Else A61.WareHouseID end)
					LEFT JOIN AT1202 on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = A61.ObjectID
					LEFT JOIN AT1011 AS A01 WITH (NOLOCK) ON A01.AnaID = AT2007.Ana01ID AND A01.AnaTypeID = ''A01''
					LEFT JOIN AT1011 AS A02 WITH (NOLOCK) ON A02.AnaID = AT2007.Ana02ID AND A02.AnaTypeID = ''A02''
					LEFT JOIN AT1011 AS A03 WITH (NOLOCK) ON A03.AnaID = AT2007.Ana03ID AND A03.AnaTypeID = ''A03''
					LEFT JOIN AT1011 AS A04 WITH (NOLOCK) ON A04.AnaID = AT2007.Ana04ID AND A04.AnaTypeID = ''A04''
					LEFT JOIN AT1011 AS A05 WITH (NOLOCK) ON A05.AnaID = AT2007.Ana05ID AND A05.AnaTypeID = ''A05''
					LEFT JOIN AT1011 AS A06 WITH (NOLOCK) ON A06.AnaID = AT2007.Ana06ID AND A06.AnaTypeID = ''A06''
					LEFT JOIN AT1011 AS A07 WITH (NOLOCK) ON A07.AnaID = AT2007.Ana07ID AND A07.AnaTypeID = ''A07''
					LEFT JOIN AT1011 AS A08 WITH (NOLOCK) ON A08.AnaID = AT2007.Ana08ID AND A08.AnaTypeID = ''A08''
					LEFT JOIN AT1011 AS A09 WITH (NOLOCK) ON A09.AnaID = AT2007.Ana09ID AND A09.AnaTypeID = ''A09''
					LEFT JOIN AT1011 AS A10 WITH (NOLOCK) ON A10.AnaID = AT2007.Ana10ID AND A10.AnaTypeID = ''A10''	
					LEFT JOIN OT3002 WITH (NOLOCK) ON AT2007.OTransactionID = OT3002.TransactionID AND OT3002.POrderID = AT2007.OrderID										
					'
				SET @sSQlUnionWhere = ' 
				WHERE	AT2007.DivisionID = N''' + @DivisionID + ''' ' +
							(CASE WHEN @IsAll = 1 THEN ' AND AT1303.IsTemp = 0 ' ELSE '' END) + ' AND
						'+CASE WHEN @CustomerName = 49  THEN ' (CASE WHEN '+STR(@IsAll)+' = 1  then   isnull(AT1303.FullName,'''') else 0 end  <> ''1'' ) AND ' ELSE'' END +'
						A61.KindVoucherID in ' + @KindVoucherListEx1 + ' AND
						(Isnull(AT2007.TranMonth,A61.TranMonth) + 100*Isnull(AT2007.TranYear,A61.TranYear) between '+@FromMonthYearText+' AND  '+@ToMonthYearText+' )  AND	
						(AT2007.InventoryID between N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''') AND
						( (A61.KindVoucherID in ' + @KindVoucherListEx2 + ' AND A61.WareHouseID IN (Select WareHouseID from #TBL_WareHouseID)) 
						or  ( A61.KindVoucherID = 3 AND A61.WareHouseID2 IN (Select WareHouseID from #TBL_WareHouseID))) 
				'
			   END
			ELSE
			   BEGIN
					SET @sSQlSelect = N'
				--- Phan Nhap kho
				SELECT 	' + @WareHouseID2 + ' AS WareHouseID,
						N''' + isnull(@WareHouseName,'') + ''' AS WareHouseName, 
						AT2007.VoucherID,
						AT2007.TransactionID,
						AT2007.Orders,
						AT2006.VoucherDate,
						AT2006.VoucherNo,	
						AT2006.VoucherDate AS ImVoucherDate,
						AT2006.VoucherNo AS ImVoucherNo,		
						AT2007.SourceNo AS ImSourceNo,
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
						AT2006.VoucherTypeID,
						AT2006.Description,
						AT2007.Notes,
						AT2007.InventoryID,	
						AT1302.InventoryName,
						AT2007.UnitID,		
						isnull(AT2007.ConversionFactor ,1) AS ConversionFactor,
						IsNULL((SELECT SUM(BeginQuantity) from #AV7015 AV7015 WHERE AV7015.InventoryID = AT2007.InventoryID AND AV7015.DivisionID = AT2007.DivisionID),0) AS BeginQuantity,
						IsNULL((SELECT SUM(BeginAmount) from #AV7015 AV7015 WHERE AV7015.InventoryID = AT2007.InventoryID AND AV7015.DivisionID = AT2007.DivisionID),0) AS BeginAmount,		
						--isnull(AV7015.BeginQuantity,0) AS BeginQuantity,
						--isnull(AV7015.BeginAmount,0) AS BeginAmount,

						(CASE WHEN KindVoucherID = 7 then 3 else 1 end) AS ImExOrders,
						AT2007.DebitAccountID, AT2007.CreditAccountID,
						At2006.ObjectID,
						AT1202.ObjectName,
						AT1302.Notes01,
						AT1302.Notes02,
						AT1302.Notes03, AT2007.DivisionID, AT2007.ConvertedUnitID,
						AT2007.Ana01ID, AT2007.Ana02ID, AT2007.Ana03ID, AT2007.Ana04ID, AT2007.Ana05ID, AT2007.Ana06ID, AT2007.Ana07ID, AT2007.Ana08ID, AT2007.Ana09ID, AT2007.Ana10ID,
						(Select top 1 InvoiceNo from AT9000 WITH (NOLOCK) Where DivisionID = AT2007.DivisionID And VoucherID = AT2007.VoucherID and TransactionID = AT2007.TransactionID and Isnull(InvoiceNo,'''')<>'''') as InvoiceNo,
						A01.AnaName AS Ana01Name, A02.AnaName AS Ana02Name, A03.AnaName AS Ana03Name, A04.AnaName AS Ana04Name, A05.AnaName AS Ana05Name,
						A06.AnaName AS Ana06Name, A07.AnaName AS Ana07Name, A08.AnaName AS Ana08Name, A09.AnaName AS Ana09Name, A10.AnaName AS Ana10Name,
						AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05, 
						AT2006.KindVoucherID, AT2006.OrderID, AT2007.OrderID as POrderID,
						AT2007.MOrderID, AT2007.SOrderID,						AT1302.Barcode,
						at2007.WarrantyNo,
						at2007.ShelvesID,
						wt0169.ShelvesName,
						at2007.FloorID,
						wt0170.FloorName,
						null as RevoucherNo,
						AT2007.ProductID as ProductID, D02.InventoryName as ProductName'
				
				SET @sSQlFrom = ' 
					FROM AT1302 WITH (NOLOCK)	
					LEFT JOIN AT2007  WITH (NOLOCK) on AT1302.DivisionID IN (AT2007.DivisionID,''@@@'') AND AT1302.InventoryID = AT2007.InventoryID
					LEFT JOIN AT1302 D02 WITH (NOLOCK) on D02.DivisionID IN (AT2007.DivisionID,''@@@'') AND D02.InventoryID = AT2007.ProductID
					LEFT JOIN wt0169 WITH (NOLOCK) on wt0169.ShelvesID = at2007.ShelvesID
					LEFT JOIN wt0170 WITH (NOLOCK) on wt0170.FloorID = at2007.FloorID
					INNER JOIN AT2006  WITH (NOLOCK)on At2006.VoucherID = AT2007.VoucherID AND At2006.DivisionID = AT2007.DivisionID
					INNER JOIN AT1303 WITH (NOLOCK) on AT1303.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1303.WareHouseID = AT2006.WareHouseID
					LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT2006.ObjectID
					LEFT JOIN AT1011 AS A01 WITH (NOLOCK) ON A01.AnaID = AT2007.Ana01ID AND A01.AnaTypeID = ''A01''
					LEFT JOIN AT1011 AS A02 WITH (NOLOCK) ON A02.AnaID = AT2007.Ana02ID AND A02.AnaTypeID = ''A02''
					LEFT JOIN AT1011 AS A03 WITH (NOLOCK) ON A03.AnaID = AT2007.Ana03ID AND A03.AnaTypeID = ''A03''
					LEFT JOIN AT1011 AS A04 WITH (NOLOCK) ON A04.AnaID = AT2007.Ana04ID AND A04.AnaTypeID = ''A04''
					LEFT JOIN AT1011 AS A05 WITH (NOLOCK) ON A05.AnaID = AT2007.Ana05ID AND A05.AnaTypeID = ''A05''
					LEFT JOIN AT1011 AS A06 WITH (NOLOCK) ON A06.AnaID = AT2007.Ana06ID AND A06.AnaTypeID = ''A06''
					LEFT JOIN AT1011 AS A07 WITH (NOLOCK) ON A07.AnaID = AT2007.Ana07ID AND A07.AnaTypeID = ''A07''
					LEFT JOIN AT1011 AS A08 WITH (NOLOCK) ON A08.AnaID = AT2007.Ana08ID AND A08.AnaTypeID = ''A08''
					LEFT JOIN AT1011 AS A09 WITH (NOLOCK) ON A09.AnaID = AT2007.Ana09ID AND A09.AnaTypeID = ''A09''
					LEFT JOIN AT1011 AS A10 WITH (NOLOCK) ON A10.AnaID = AT2007.Ana10ID AND A10.AnaTypeID = ''A10''
					LEFT JOIN OT3002 WITH (NOLOCK) ON AT2007.OTransactionID = OT3002.TransactionID AND OT3002.POrderID = AT2007.OrderID											
					'
				
				SET @sSQlWhere = ' 
					WHERE	AT2007.DivisionID = N''' + @DivisionID + ''' ' +
							(CASE WHEN @IsAll = 1 THEN ' AND AT1303.IsTemp = 0 ' ELSE '' END) + ' AND
							'+CASE WHEN @CustomerName = 49 THEN ' (CASE WHEN '+STR(@IsAll)+' = 1  then   isnull(AT1303.FullName,'''') else 0 end  <> ''1'' ) AND ' ELSE '' END +'
							(CONVERT(DATETIME, CONVERT(VARCHAR(10), AT2006.VoucherDate, 101), 101) Between ''' +@FromDateText + ''' AND ''' + @ToDateText + ''' ) AND
							KindVoucherID in ' + @KindVoucherListIm + ' AND
							(AT2007.InventoryID between N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''') AND
							AT2006.WareHouseID IN (Select WareHouseID from #TBL_WareHouseID)
				'

				SET @sSQlUnionSelect = ' 
					UNION
				--- Phan Xuat kho
					SELECT  ' + @WareHouseID1 + ' AS WareHouseID,
							N''' + isnull(@WareHouseName,'') + ''' AS WareHouseName, 
							AT2007.VoucherID,
							AT2007.TransactionID,
							AT2007.Orders,
							A61.VoucherDate,
							A61.VoucherNo,	
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
							A61.VoucherDate AS ExVoucherDate,
							A61.VoucherNo AS ExVoucherNo,		
							AT2007.SourceNo AS ExSourceNo,
							AT2007.LimitDate AS ExLimitDate,	
 							(CASE WHEN A61.KindVoucherID = 3 then A61.WareHouseID2 else A61.WareHouseID end) AS ExWareHouseID,	
							A61.RefNo01 AS ExRefNo01 , A61.RefNo02 AS ExRefNo02 , 
							AT2007.ActualQuantity AS ExQuantity,
							AT2007.UnitPrice AS ExUnitPrice ,
							AT2007.ConvertedAmount AS ExConvertedAmount,
							AT2007.OriginalAmount AS ExOriginalAmount,
							isnull(AT2007.ConversionFactor ,1)*ActualQuantity AS ExConvertedQuantity,
							A61.VoucherTypeID,
							A61.Description,
							AT2007.Notes,
							AT2007.InventoryID,	
							AT1302.InventoryName,
							AT2007.UnitID, isnull(AT2007.ConversionFactor ,1) AS ConversionFactor,
									IsNULL((SELECT SUM(BeginQuantity) from #AV7015 AV7015 WHERE AV7015.InventoryID = AT2007.InventoryID AND AV7015.DivisionID = AT2007.DivisionID),0) AS BeginQuantity,
						IsNULL((SELECT SUM(BeginAmount) from #AV7015 AV7015 WHERE AV7015.InventoryID = AT2007.InventoryID AND AV7015.DivisionID = AT2007.DivisionID),0) AS BeginAmount,		
							--isnull(AV7015.BeginQuantity,0) AS BeginQuantity,
							--isnull(AV7015.BeginAmount,0) AS BeginAmount,
							2 AS ImExOrders,
							AT2007.DebitAccountID, AT2007.CreditAccountID,
							A61.ObjectID,
							AT1202.ObjectName,
							AT1302.Notes01,
							AT1302.Notes02,
							AT1302.Notes03,AT2007.DivisionID, AT2007.ConvertedUnitID,
							AT2007.Ana01ID, AT2007.Ana02ID, AT2007.Ana03ID, AT2007.Ana04ID, AT2007.Ana05ID, AT2007.Ana06ID, AT2007.Ana07ID, AT2007.Ana08ID, AT2007.Ana09ID, AT2007.Ana10ID ,
							(Select top 1 InvoiceNo from AT9000 WITH (NOLOCK) Where DivisionID = AT2007.DivisionID And VoucherID = AT2007.VoucherID and TransactionID = AT2007.TransactionID and Isnull(InvoiceNo,'''')<>'''') as InvoiceNo,
							A01.AnaName AS Ana01Name, A02.AnaName AS Ana02Name, A03.AnaName AS Ana03Name, A04.AnaName AS Ana04Name, A05.AnaName AS Ana05Name,
							A06.AnaName AS Ana06Name, A07.AnaName AS Ana07Name, A08.AnaName AS Ana08Name, A09.AnaName AS Ana09Name, A10.AnaName AS Ana10Name,
							AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05,
							A61.KindVoucherID, A61.OrderID, AT2007.OrderID as POrderID,
							AT2007.MOrderID, AT2007.SOrderID,							AT1302.Barcode,
							at2007.WarrantyNo,
							at2007.ShelvesID,
							wt0169.ShelvesName,
							at2007.FloorID,
							wt0170.FloorName,
							case when isnull(A62.VoucherNo,'''')='''' then A90.VoucherNo else A62.VoucherNo end as RevoucherNo,
							AT2007.ProductID as ProductID, D02.InventoryName as ProductName'
							
					SET @sSQlUnionFrom = ' 
						FROM AT1302  WITH (NOLOCK)	
						LEFT JOIN AT2007 WITH (NOLOCK) on AT1302.DivisionID IN (AT2007.DivisionID,''@@@'') AND AT1302.InventoryID = AT2007.InventoryID
						LEFT JOIN AT1302 D02 WITH (NOLOCK) on D02.DivisionID IN (AT2007.DivisionID,''@@@'') AND D02.InventoryID = AT2007.ProductID
						LEFT JOIN wt0169 WITH (NOLOCK) on wt0169.ShelvesID = at2007.ShelvesID
						LEFT JOIN wt0170 WITH (NOLOCK) on wt0170.FloorID = at2007.FloorID
						INNER JOIN AT2006 A61 WITH (NOLOCK) on A61.VoucherID = AT2007.VoucherID AND A61.DivisionID = AT2007.DivisionID
						LEFT JOIN AT2006 A62 WITH (NOLOCK) on A62.VoucherID = AT2007.ReVoucherID AND A62.DivisionID = AT2007.DivisionID
						LEFT JOIN AT9000 A90 WITH (NOLOCK) on A90.VoucherID = AT2007.ReVoucherID AND A90.DivisionID = AT2007.DivisionID
						INNER JOIN AT1303 WITH (NOLOCK) on AT1303.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1303.WareHouseID = ( CASE WHEN A61.KindVoucherID = 3 Then A61.WareHouseID2  Else A61.WareHouseID end)
						LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = A61.ObjectID
						LEFT JOIN AT1011 AS A01 WITH (NOLOCK) ON A01.AnaID = AT2007.Ana01ID AND A01.AnaTypeID = ''A01''
						LEFT JOIN AT1011 AS A02 WITH (NOLOCK) ON A02.AnaID = AT2007.Ana02ID AND A02.AnaTypeID = ''A02''
						LEFT JOIN AT1011 AS A03 WITH (NOLOCK) ON A03.AnaID = AT2007.Ana03ID AND A03.AnaTypeID = ''A03''
						LEFT JOIN AT1011 AS A04 WITH (NOLOCK) ON A04.AnaID = AT2007.Ana04ID AND A04.AnaTypeID = ''A04''
						LEFT JOIN AT1011 AS A05 WITH (NOLOCK) ON A05.AnaID = AT2007.Ana05ID AND A05.AnaTypeID = ''A05''
						LEFT JOIN AT1011 AS A06 WITH (NOLOCK) ON A06.AnaID = AT2007.Ana06ID AND A06.AnaTypeID = ''A06''
						LEFT JOIN AT1011 AS A07 WITH (NOLOCK) ON A07.AnaID = AT2007.Ana07ID AND A07.AnaTypeID = ''A07''
						LEFT JOIN AT1011 AS A08 WITH (NOLOCK) ON A08.AnaID = AT2007.Ana08ID AND A08.AnaTypeID = ''A08''
						LEFT JOIN AT1011 AS A09 WITH (NOLOCK) ON A09.AnaID = AT2007.Ana09ID AND A09.AnaTypeID = ''A09''
						LEFT JOIN AT1011 AS A10 WITH (NOLOCK) ON A10.AnaID = AT2007.Ana10ID AND A10.AnaTypeID = ''A10''
						LEFT JOIN OT3002 WITH (NOLOCK) ON AT2007.OTransactionID = OT3002.TransactionID AND OT3002.POrderID = AT2007.OrderID																	
						'

					SET @sSQlUnionWhere = ' 
						WHERE	AT2007.DivisionID = N''' + @DivisionID + ''' ' +
								(CASE WHEN @IsAll = 1 THEN ' AND AT1303.IsTemp = 0 ' ELSE '' END) + ' AND
								'+CASE WHEN @CustomerName = 49 THEN ' (CASE WHEN '+STR(@IsAll)+' = 1  then  isnull(AT1303.FullName,'''') else 0 end  <> ''1'' ) AND 'ELSE '' END +'
								A61.KindVoucherID in ' + @KindVoucherListEx1 + ' AND
								(CONVERT(DATETIME, CONVERT(VARCHAR(10), A61.VoucherDate, 101), 101) Between ''' +@FromDateText+ ''' AND ''' +@ToDateText+ ''' ) AND
								(AT2007.InventoryID between N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''') AND
								( (A61.KindVoucherID in ' + @KindVoucherListEx2 + '  AND 
								 A61.WareHouseID IN (Select WareHouseID from #TBL_WareHouseID)) or  (A61.KindVoucherID = 3 AND A61.WareHouseID2 IN (Select WareHouseID from #TBL_WareHouseID))) 
					'
				   END	 


				 PRINT @sSQLSelect 
				 print @sSQlFrom 
				 print @sSQlWhere
				 PRINT @sSQlUnionSelect 
				 print @sSQlUnionFrom 
				 print @sSQlUnionWhere

		--Edit by Nguyen Quoc Huy

		--print @sSQLSelect+@sSQlFrom+@sSQlWhere+@sSQlUnionSelect+@sSQlUnionFrom+@sSQlUnionWhere
		
		--print @sSQLSelect
		--print @sSQlFrom
		--print @sSQlWhere
		--print @sSQlUnionSelect
		--print @sSQlUnionFrom
		--print @sSQlUnionWhere	

		--IF NOT EXISTS ( SELECT 1 FROM SysObjects WITH (NOLOCK) WHERE Xtype = 'V' AND Name = 'AV2028' )
		--   BEGIN
		--		 EXEC ( 'CREATE VIEW AV2028 --CREATED BY AP2018
		--					AS '+@sSQLSelect+@sSQlFrom+@sSQlWhere+@sSQlUnionSelect+@sSQlUnionFrom+@sSQlUnionWhere )
		--   END
		--ELSE
		--   BEGIN
		--		 EXEC ( 'ALTER VIEW AV2028 --CREATED BY AP2018
		--					as '+@sSQLSelect+@sSQlFrom+@sSQlWhere+@sSQlUnionSelect+@sSQlUnionFrom+@sSQlUnionWhere )
		--   END
		 
		-- KHAI BÁO BIẾN TABLE THAY CHO VIEW AV2028
		DECLARE @AV2028 AS TABLE (WarehouseID VARCHAR(50), WarehouseName NVARCHAR(250), VoucherID VARCHAR(50), TransactionID VARCHAR(50), Orders INT, VoucherDate DATETIME,
						VoucherNo VARCHAR(50), ImVoucherDate DATETIME, ImVoucherNo VARCHAR(50),	ImSourceNo NVARCHAR(50), ImLimitDate DATETIME,	
 						ImWareHouseID VARCHAR(50), ImRefNo01 NVARCHAR(100), ImRefNo02 NVARCHAR(100), ImQuantity DECIMAL(28,8), ImUnitPrice DECIMAL(28,8), 
						ImConvertedAmount DECIMAL(28,8), ImOriginalAmount DECIMAL(28,8), ImConvertedQuantity DECIMAL(28,8), ExVoucherDate DATETIME, ExVoucherNo VARCHAR(50), 
						ExSourceNo  NVARCHAR(50), ExLimitDate DATETIME,	ExWareHouseID VARCHAR(50), ExRefNo01 NVARCHAR(100), ExRefNo02  NVARCHAR(100), 
						ExQuantity DECIMAL(28,8), ExUnitPrice DECIMAL(28,8), ExConvertedAmount DECIMAL(28,8), ExOriginalAmount DECIMAL(28,8), ExConvertedQuantity DECIMAL(28,8),
						VoucherTypeID NVARCHAR(50), Description NVARCHAR(500), Notes NVARCHAR(500), InventoryID VARCHAR(50), InventoryName NVARCHAR(250), UnitID VARCHAR(50), 
						ConversionFactor DECIMAL(28,8), BeginQuantity DECIMAL(28,8), BeginAmount DECIMAL(28,8), ImExOrders INT, DebitAccountID NVARCHAR(50), CreditAccountID NVARCHAR(50),
						ObjectID NVARCHAR(50), ObjectName NVARCHAR(250), Notes01 NVARCHAR(500), Notes02 NVARCHAR(250), Notes03 NVARCHAR(250), DivisionID NVARCHAR(50), 
						ConvertedUnitID VARCHAR(50), 
						Ana01ID NVARCHAR(50), Ana02ID NVARCHAR(50), Ana03ID NVARCHAR(50), Ana04ID NVARCHAR(50), Ana05ID NVARCHAR(50), 
						Ana06ID NVARCHAR(50), Ana07ID NVARCHAR(50), Ana08ID NVARCHAR(50), Ana09ID NVARCHAR(50), Ana10ID NVARCHAR(50),
						InvoiceNo NVARCHAR(50), 
						Ana01Name NVARCHAR(MAX), Ana02Name NVARCHAR(MAX), Ana03Name NVARCHAR(MAX), Ana04Name NVARCHAR(MAX), Ana05Name NVARCHAR(MAX),
						Ana06Name NVARCHAR(MAX), Ana07Name NVARCHAR(MAX), Ana08Name NVARCHAR(MAX), Ana09Name NVARCHAR(MAX), Ana10Name NVARCHAR(MAX),
						Parameter01 DECIMAL(28,8), Parameter02 DECIMAL(28,8), Parameter03 DECIMAL(28,8), Parameter04 DECIMAL(28,8), Parameter05 DECIMAL(28,8), 
						KindVoucherID INT, OrderID VARCHAR(50), POrderID NVARCHAR(50), MOrderID NVARCHAR(50), SOrderID NVARCHAR(MAX), Barcode NVARCHAR(50) , 
						WarrantyNo nvarchar(250),
						ShelvesID nvarchar(50),
						ShelvesName nvarchar(250),
						FloorID nvarchar(50),
						FloorName nvarchar(250),
						RevoucherNo nvarchar(250),
						ProductID VARCHAR(50), ProductName NVARCHAR(250))

		INSERT INTO @AV2028 EXEC ( @sSQLSelect+@sSQlFrom+@sSQlWhere+@sSQlUnionSelect+@sSQlUnionFrom+@sSQlUnionWhere )
		SELECT * INTO #AV2028 FROM @AV2028

		--- Lay du su va phat sinh
		
		SET @sSQLSelect2 = N' 
			SELECT	DISTINCT AV2018.WareHouseID, AV2018.WareHouseName, AV2018.VoucherID, AV2018.TransactionID, AV2018.Orders,
					DATEADD(d, 0, DATEDIFF(d, 0, AV2018.VoucherDate)) AS VoucherDate, AV2018.VoucherNo, AV2018.ImVoucherDate, AV2018.ImVoucherNo, AV2018.ImSourceNo,
					AV2018.ImLimitDate, AV2018.ImWareHouseID, 
					AV2018.ImRefNo01, AV2018.ImRefNo02,
					AV2018.ImQuantity, AV2018.ImUnitPrice, AV2018.ImConvertedAmount,
					AV2018.ImOriginalAmount, AV2018.ImConvertedQuantity,  
					AV2018.ExVoucherDate, AV2018.ExVoucherNo, AV2018.ExSourceNo,
					AV2018.ExLimitDate, AV2018.ExWareHouseID, 
					AV2018.ExRefNo01, AV2018.ExRefNo02,
					AV2018.ExQuantity, AV2018.ExUnitPrice, AV2018.ExConvertedAmount,
					AV2018.ExOriginalAmount, AV2018.ExConvertedQuantity, AV2018.VoucherTypeID, AV2018.Description,
					AV2018.Notes, AV2018.InventoryID, AV2018.InventoryName, AV2018.UnitID,  AT1304.UnitName, AV2018.ConversionFactor,
					AT1309.UnitID AS ConversionUnitID, AT1309.ConversionFactor AS  ConversionFactor01, AT1309.Operator,
					AV2018.BeginQuantity, AV2018.BeginAmount, AV2018.ImExOrders, AV2018.DebitAccountID, AV2018.CreditAccountID,
					AV2018.ObjectID, AV2018.ObjectName, AV2018.Notes01, AV2018.Notes02, AV2018.Notes03, AV2018.DivisionID,
					AV2018.Ana01ID, AV2018.Ana02ID, AV2018.Ana03ID, AV2018.Ana04ID, AV2018.Ana05ID, AV2018.Ana06ID, AV2018.Ana07ID, AV2018.Ana08ID, AV2018.Ana09ID, AV2018.Ana10ID ,
					AV2018.Ana01Name, AV2018.Ana02Name, AV2018.Ana03Name, AV2018.Ana04Name, AV2018.Ana05Name, AV2018.Ana06Name, AV2018.Ana07Name, AV2018.Ana08Name, AV2018.Ana09Name, AV2018.Ana10Name ,
					AV2018.InvoiceNo, AV2018.ConvertedUnitID,
					AV2018.Parameter01,AV2018.Parameter02,AV2018.Parameter03,AV2018.Parameter04,AV2018.Parameter05,
					AV2018.KindVoucherID, NULL AS VDescription, NULL AS BDescription, AT9000.TDescription, AV2018.OrderID, N'''+@GroupID+''' as GroupID, AT1401.GroupName, AV2018.POrderID,
					AV2018.MOrderID, AV2018.SOrderID,					AV2018.Barcode,
					AV2018.WarrantyNo,
					AV2018.ShelvesID,
					AV2018.ShelvesName,
					AV2018.FloorID,
					AV2018.FloorName, AV2018.RevoucherNo,
					AV2018.ProductID as ProductID, D02.InventoryName as ProductName
			FROM	#AV2028  AV2018 WITH (NOLOCK)
			LEFT JOIN AT1302 D02 WITH (NOLOCK) on D02.DivisionID IN (AV2018.DivisionID,''@@@'') AND D02.InventoryID = AV2018.ProductID
			LEFT JOIN AT1304 WITH (NOLOCK) on AT1304.UnitID = AV2018.UnitID
			LEFT JOIN AT1309 WITH (NOLOCK) on AT1309.InventoryID = AV2018.InventoryID AND AT1309.UnitID = AV2018.UnitID
			LEFT JOIN AT9000 WITH (NOLOCK) on AT9000.DivisionID = AV2018.DivisionID AND AT9000.WOrderID = AV2018.VoucherID AND AT9000.WTransactionID = AV2018.TransactionID AND AT9000.InventoryID = AV2018.InventoryID
			LEFT JOIN AT1401 WITH (NOLOCK) on AT1401.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1401.GroupID = N''' +@GroupID+ '''

			WHERE	AV2018.BeginQuantity <> 0 or AV2018.BeginAmount <> 0 or AV2018.ImQuantity <> 0 or
					AV2018.ImConvertedAmount <> 0 or AV2018.ExQuantity <> 0 or AV2018.ExConvertedAmount <> 0 '

		SET @sSQlUnionSelect2 = N' 
			UNION 

			SELECT  DISTINCT AV7015.WareHouseID  AS WareHouseID, AV7015.WareHouseName AS WareHouseName, Null AS VoucherID, Null AS TransactionID, 
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
					NULL as Parameter01,NULL as Parameter02,NULL as Parameter03,NULL as Parameter04,NULL as Parameter05,
					1 AS KindVoucherID, NULL AS VDescription, NULL AS BDescription, NULL AS TDescription, AV7015.OrderID, N'''+@GroupID+''' as GroupID, AT1401.GroupName, null AS POrderID,
					NULL AS MOrderID, NULL AS SOrderID,					NULL AS Barcode, null as WarrantyNo,
					null as ShelvesID,
					null as ShelvesName,
					null as FloorID,
					null as FloorName, null as RevoucherNo,
					null as ProductID, null as ProductName
			FROM	#AV7015 AV7015 WITH (NOLOCK)
			INNER JOIN AT1304 WITH (NOLOCK) on AT1304.UnitID = AV7015.UnitID
			LEFT JOIN AT1309 WITH (NOLOCK) on AT1309.InventoryID = AV7015.InventoryID AND AT1309.UnitID = AV7015.UnitID
			LEFT JOIN AT1401 WITH (NOLOCK) on AT1401.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1401.GroupID = N''' +@GroupID+ '''
			LEFT JOIN AT2007 D07 WITH (NOLOCK) on AV7015.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AV7015.InventoryID = D07.ProductID
			WHERE AV7015.InventoryID NOT IN (SELECT DISTINCT InventoryID From #AV2028) AND (BeginQuantity<>0 or BeginAmount<>0)
		 '

		 SET @DropTBLWareHouseID ='
		 Drop Table #TBL_WareHouseID'
		--Print @sSQL
		--PRINT (@sSQLSelect2)
		--PRINT (@sSQlUnionSelect2)
		--PRINT (@DropTBLWareHouseID)

		--EXEC (@sSQLSelect+@sSQlUnionSelect + @DropTBLWareHouseID)
		EXEC (@sSQLSelect2+@sSQlUnionSelect2)
		--IF NOT EXISTS ( SELECT  1 FROM  SysObjects  WHERE  Xtype = 'V' AND Name = 'AV2018' )
		--   BEGIN
		--		 EXEC ( 'CREATE VIEW AV2018 	--CREATED BY AP2018
		--				AS '+@sSQLSelect+@sSQlUnionSelect )
		--   END
		--ELSE
		--   BEGIN
		--		 EXEC ( 'ALTER VIEW AV2018 		--CREATED BY AP2018
		--				AS '+@sSQLSelect+@sSQlUnionSelect )
		--   END
	END
	
END		



END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
