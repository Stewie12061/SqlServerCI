IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0100_TL]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0100_TL]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
--- Load danh sách các phiếu yêu cầu lên màn hình kế thừa
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Thanh Sơn on 29/05/2014
---- 
---- Modified on 01/07/2014 by Le Thi Thu Hien : Sửa lại A04.WareHouseID = W95.WareHouseID2
---- Modified by Tieu Mai on 29/12/2015: Load phieu yeu cau chua xuat/nhap het so luong yeu cau
---- Modified on 02/06/2016 by Bảo Thy: Bổ sung WITH (NOLOCK)
---- Modified by Tiểu Mai on 07/06/2016: Fix bug do chiều dài quá chuỗi
---- Modified by Tiểu Mai on 07/07/2016: Fix bị double dòng
---- Modified by Bảo Thy on 18/05/2017: Bổ sung thông tin hợp đồng trường hợp có quy cách (EIMSKIP)
---- Modified on 08/06/2017 by Bảo Thy: Fix lỗi Phiếu xuất kho kế thừa phiếu yêu cầu xuất kho lỗi
---- Modified on 03/07/2017 by Bảo Thy: Lỗi khi kế thừa nhiều lần
---- Modified on 20/10/2017 by Hải Long: Bổ sung trường ObjectID, Contactor
---- Modified on 26/06/2018 by Trà Giang: Fix lỗi kế thừa phiếu vận chuyển nội bộ trên POS
---- Modified on 06/09/2018 by Trà Giang: Fix lỗi kế thừa phiếu vận chuyển nội bộ khi chuyển kho dưới ERP
---- Modified on 06/09/2018 by Trà Giang: Fix lỗi thứ tự chạy sql
---- Modified on 25/02/2019 by Hoàng Vũ: Fix lỗi Exec câu SQL load sai trường chuỗi truyền vào
---- Modified on 27/03/2019 by Hoàng Vũ: Fix lỗi AT1303 và AT1202 dùng chung không kết DivisionID
---- Modified on 17/12/2019 by Văn Tài: Bổ sung load thêm cột RefNo01.
---- Modified on 18/03/2020 by Văn Minh: Bổ sung Order By cho LIỄN QUÁN
---- Modified on 11/11/2020 by Đức Thông: Bổ sung cột danh sách đơn hàng mua kế thừa
---- Modified on 11/11/2020 by Nhựt Trường: Thêm parameter @InventoryID để bổ sung điều kiện lọc theo mã mặt hàng.
---- Modified on 18/11/2020 by Đức Thông: Lấy thêm chuỗi select kho nhập (fix bug dự án Liễn Quán)
---- Modified on 15/09/2023 by Nhật Thanh: Bổ sung % vào so sánh like mặt hàng
-- <Example>
/*
    EXEC WP0100_TL 'ESP','',1,2017,3,2017, '2014-05-29 11:32:10.833', '2014-05-29 11:32:10.833','%',0, 1
	exec WP0100_TL @DivisionID='VS',@UserID='NV06',@FromMonth=6,@FromYear=2018,@ToMonth=6,@ToYear=2018,@FromDate='2018-07-09 07:57:48.373',@ToDate='2018-07-09 07:57:48.373',@ObjectID='%',@IsDate=0,@Mode=3

*/

 CREATE PROCEDURE WP0100_TL
(
     @DivisionID VARCHAR(50),
     @UserID VARCHAR(50),
     @FromMonth INT,
     @FromYear INT,
     @ToMonth INT,
     @ToYear INT,
     @FromDate DATETIME,
     @ToDate DATETIME,
     @ObjectID VARCHAR(50),
	 @InventoryID VARCHAR(50),
     @IsDate TINYINT,
     @Mode TINYINT, --1: Phiếu yêu cầu nhập, 2: Xuất, 3: VCNB,
	 @IsExportCompanyToShop TINYINT = 0
)
AS
DECLARE @sSQL NVARCHAR(MAX), @sSQL1 NVARCHAR(MAX),
		@sWhere NVARCHAR(2000),
		@CustomerIndex INT,
		@sSelect NVARCHAR(MAX)='',
		@sSelect1 NVARCHAR(MAX)='',
		@sJoin NVARCHAR(MAX)='',
		@sSQL01 NVARCHAR(MAX)='',
		@sOrderBy NVARCHAR(MAX) = ''
	
SET @sSQL1 = ''			
SET @sWhere = ''

SELECT @CustomerIndex = ISNULL(CustomerName,-1) FROM CustomerIndex

IF @CustomerIndex = 70 ----EIMSKIP
BEGIN
	SET @sSelect = ', W95.ContractID, W95.ContractNo, W95.WareHouseID, W95.WareHouseID2'
	SET @sSelect1 = ', (CASE WHEN W95.KindVoucherID IN (1,3,5,7,9) THEN A33.InventoryName ELSE '''' END) ImWareHouseName,
					(CASE WHEN W95.KindVoucherID in (2,4,6,8,10) THEN A33.InventoryName
					ELSE CASE WHEN W95.KindVoucherID = 3 THEN A03.InventoryName ELSE '''' END END) ExWareHouseName'

	SET @sJoin = 'LEFT JOIN AT1302 A33 WITH (NOLOCK) ON A33.DivisionID = W95.DivisionID AND A33.InventoryID = W95.WareHouseID
				  LEFT JOIN AT1302 A03 WITH (NOLOCK) ON A03.DivisionID = W95.DivisionID AND A03.InventoryID = W95.WareHouseID2'
END



IF @CustomerIndex != 70 --- Các khách hàng không phải EIMSKIP
BEGIN
	SET @sSelect = ', W95.ContractID, W95.ContractNo, W95.WareHouseID, W95.WareHouseID2'
	SET @sJoin = 'LEFT JOIN AT1303 A33 WITH (NOLOCK) ON A33.DivisionID in ('''+@DivisionID+''', ''@@@'') AND A33.WareHouseID = W95.WareHouseID
				  LEFT JOIN AT1303 A03 WITH (NOLOCK) ON A03.DivisionID in ('''+@DivisionID+''', ''@@@'') AND A03.WareHouseID = W95.WareHouseID2'

	SET @sSelect1 = ', (CASE WHEN W95.KindVoucherID IN (1,3,5,7,9) THEN A33.WareHouseName ELSE '''' END) ImWareHouseName,
		(CASE WHEN W95.KindVoucherID in (2,4,6,8,10) THEN A33.WareHouseName
		  ELSE CASE WHEN W95.KindVoucherID = 3 THEN A03.WareHouseName ELSE '''' END END) ExWareHouseName'
END

IF @CustomerIndex = 105 --- Customize LIỄN QUÁN
	SET @sSelect = @sSelect + ', STUFF(
         (SELECT DISTINCT '';'' + A.OrderID
          FROM  WT0096 A     
		  WHERE A.VoucherID = W96.VoucherID 
          FOR XML PATH (''''))
          , 1, 1, '''')  AS POrderIDList '


IF @IsDate = 0 SET @sWhere = 'AND W95.TranMonth + W95.TranYear * 100 BETWEEN '+STR(@FromMonth + @FromYear * 100)+' AND '+STR(@ToMonth + @ToYear * 100)+' '
IF @IsDate = 1 SET @sWhere = 'AND CONVERT(VARCHAR, W95.VoucherDate,112) BETWEEN '+CONVERT(VARCHAR,@FromDate,112)+' AND '+CONVERT(VARCHAR,@ToDate,112)+' '
IF @Mode = 1 SET @sWhere = @sWhere + '
AND W95.KindVoucherID IN (1,3,5,7,9) AND W95.WareHouseID2 IS NULL'
IF @Mode = 2 SET @sWhere = @sWhere + '
AND W95.KindVoucherID IN (2,4,6,8,10)'
IF @Mode = 3 SET @sWhere = @sWhere + '
AND W95.KindVoucherID = 3 AND W95.WareHouseID2 IS NOT NULL'

IF @IsExportCompanyToShop = 1
	SET @sWhere = @sWhere + '
	AND ISNULL(P22.IsRefund,0) = 2 '
ELSE
	SET @sWhere = @sWhere + '
	AND ISNULL(P22.IsRefund,0) <> 2 '

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN

	SET @sSQL = '
	SELECT DISTINCT CONVERT(TINYINT,0) Choose, W95.VoucherID, W95.VoucherNo, W95.VoucherTypeID, W95.VoucherDate, A02.ObjectName, W95.[Description], A02.ObjectID, A02.Contactor, W95.RefNo01,P22.IsRefund
	'+@sSelect+@sSelect1+'
	FROM WT0095 W95 WITH (NOLOCK)
	LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID in ('''+@DivisionID+''', ''@@@'')  AND A02.ObjectID = W95.ObjectID
	LEFT JOIN WT0096 W96 WITH (NOLOCK) ON W96.DivisionID = W95.DivisionID AND W96.VoucherID = W95.VoucherID AND W96.InventoryID LIKE ''%'+@InventoryID+'%''
	LEFT JOIN WT8899 O99 WITH (NOLOCK) ON O99.DivisionID = W96.DivisionID AND O99.VoucherID = W96.VoucherID AND O99.TransactionID = W96.TransactionID AND O99.TableID = ''WT0096''
	LEFT JOIN POST0022 P22 WITH (NOLOCK) ON P22.VoucherNo = W95.RefNo01  AND P22.DivisionID = W95.DivisionID
	'+@sJoin+'
	'
	SET @sSQL1 = '	
	LEFT JOIN (SELECT 
		AT2007.DivisionID, 
		AT2007.OrderID,
		AT2007.InheritVoucherID,
		AT2007.InheritTransactionID, 
		AT2007.OTransactionID,
		AT2007.InventoryID, 
		SUM(ISNULL(AT2007.ConvertedQuantity, 0)) AS ActualConvertedQuantity, 
		SUM(ISNULL(AT2007.ActualQuantity, 0)) AS ActualQuantity, 
		SUM(ISNULL(AT2007.OriginalAmount, 0)) AS ActualOriginalAmount, 
		SUM(ISNULL(AT2007.ConvertedAmount, 0)) AS ActualConvertedAmount,
		O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
		O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID
		FROM AT2007  WITH (NOLOCK)
		INNER JOIN AT2006 WITH (NOLOCK) ON AT2007.VoucherID = AT2006.VoucherID AND AT2007.DivisionID = AT2006.DivisionID
		LEFT JOIN WT8899 O99 WITH (NOLOCK) ON O99.DivisionID = AT2007.DivisionID AND O99.VoucherID = AT2007.VoucherID AND O99.TransactionID = AT2007.TransactionID AND O99.TableID = ''AT2007''
		WHERE AT2007.InheritTableID = ''WT0095''
		GROUP BY AT2007.DivisionID, AT2007.OrderID, InventoryID, OTransactionID, AT2007.InheritVoucherID, AT2007.InheritTransactionID, 
		O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
		O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID) AS G 
												ON G.InheritVoucherID = W96.VoucherID AND G.InventoryID = W96.InventoryID AND 
												G.InheritTransactionID = W96.TransactionID AND
												Isnull(G.S01ID,'''') = Isnull(O99.S01ID,'''') AND	Isnull(G.S11ID,'''') = Isnull(O99.S11ID,'''') AND 
												Isnull(G.S02ID,'''') = Isnull(O99.S02ID,'''') AND	Isnull(G.S12ID,'''') = Isnull(O99.S12ID,'''') AND 
												Isnull(G.S03ID,'''') = Isnull(O99.S03ID,'''') AND	Isnull(G.S13ID,'''') = Isnull(O99.S13ID,'''') AND 
												Isnull(G.S04ID,'''') = Isnull(O99.S04ID,'''') AND	Isnull(G.S14ID,'''') = Isnull(O99.S14ID,'''') AND 
												Isnull(G.S05ID,'''') = Isnull(O99.S05ID,'''') AND	Isnull(G.S15ID,'''') = Isnull(O99.S15ID,'''') AND 
												Isnull(G.S06ID,'''') = Isnull(O99.S06ID,'''') AND	Isnull(G.S16ID,'''') = Isnull(O99.S16ID,'''') AND 
												Isnull(G.S07ID,'''') = Isnull(O99.S07ID,'''') AND	Isnull(G.S17ID,'''') = Isnull(O99.S17ID,'''') AND 
												Isnull(G.S08ID,'''') = Isnull(O99.S08ID,'''') AND	Isnull(G.S18ID,'''') = Isnull(O99.S18ID,'''') AND
												Isnull(G.S09ID,'''') = Isnull(O99.S09ID,'''') AND	Isnull(G.S19ID,'''') = Isnull(O99.S19ID,'''') AND 
												Isnull(G.S10ID,'''') = Isnull(O99.S10ID,'''') AND	Isnull(G.S20ID,'''') = Isnull(O99.S20ID,'''')
	WHERE W95.DivisionID = '''+@DivisionID+'''
	AND W95.IsCheck = 1 '
	IF EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS TAB WHERE TAB.Name like 'POST%')		
	BEGIN
			SET @sSQL01 = N'
			AND W95.VoucherID NOT IN( SELECT W96.VoucherID FROM POST0015 P15 INNER JOIN POST00151 P151 ON P15.APK=P151.APKMaster
	 INNER JOIN WT0095 W95 ON P151.APKMInherited=W95.APK INNER JOIN WT0096 W96 ON W95.VoucherID=W96.VoucherID
	  union 
	  SELECT W96.VoucherID FROM POST0015 P15 INNER JOIN POST00151 P151 ON P15.APK=P151.APKMaster
	 INNER JOIN WT0095 W95 ON P151.APKMInherited=W95.VoucherID INNER JOIN WT0096 W96 ON W95.VoucherID=W96.VoucherID)
	 '
	 
	END

		SET @sSQL01 = @sSQL + @sSQL1 + @sSQL01+ N'
	AND Isnull(W96.ActualQuantity, 0) - isnull(G.ActualQuantity,0) > 0
	--AND W95.VoucherID NOT IN (SELECT ISNULL(InheritVoucherID,'''') FROM AT2007 WITH (NOLOCK) WHERE InheritTableID = ''WT0095'')
	AND ISNULL(W95.ObjectID,'''') LIKE '''+@ObjectID+'''
	'+@sWhere+'
	'
END
ELSE
	SET @sSQL = '
	SELECT DISTINCT CONVERT(TINYINT,0) Choose, W95.VoucherID, W95.VoucherNo, W95.VoucherTypeID, W95.VoucherDate, A02.ObjectName, W95.[Description], A02.ObjectID, A02.Contactor, W95.RefNo01,P22.IsRefund
	'+@sSelect+@sSelect1+'
	FROM WT0095 W95 WITH (NOLOCK)
	LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID in ('''+@DivisionID+''', ''@@@'') AND A02.ObjectID = W95.ObjectID
	LEFT JOIN WT0096 W96 WITH (NOLOCK) ON W96.DivisionID = W95.DivisionID AND W96.VoucherID = W95.VoucherID AND W96.InventoryID LIKE ''%'+@InventoryID+'%''
	LEFT JOIN POST0022 P22 WITH (NOLOCK) ON P22.VoucherNo = W95.RefNo01  AND P22.DivisionID = W95.DivisionID
	'+@sJoin+'
	LEFT JOIN 
	(
		SELECT 
		AT2007.DivisionID, 
		AT2007.OrderID,
		AT2007.InheritVoucherID, 
		AT2007.InheritTransactionID, 		
		AT2007.OTransactionID,
		AT2007.InventoryID, 
		SUM(ISNULL(AT2007.ConvertedQuantity, 0)) AS ActualConvertedQuantity, 
		SUM(ISNULL(AT2007.ActualQuantity, 0)) AS ActualQuantity, 
		SUM(ISNULL(AT2007.OriginalAmount, 0)) AS ActualOriginalAmount, 
		SUM(ISNULL(AT2007.ConvertedAmount, 0)) AS ActualConvertedAmount
		FROM AT2007  WITH (NOLOCK)
		INNER JOIN AT2006 WITH (NOLOCK) ON AT2007.VoucherID = AT2006.VoucherID AND AT2007.DivisionID = AT2006.DivisionID
		WHERE AT2007.InheritTableID = ''WT0095''
		GROUP BY AT2007.DivisionID, AT2007.OrderID, InventoryID, OTransactionID, AT2007.InheritVoucherID, AT2007.InheritTransactionID
	) AS G ON G.DivisionID = W96.DivisionID AND G.InheritVoucherID = W96.VoucherID AND G.InheritTransactionID = W96.TransactionID
	WHERE W95.DivisionID = '''+@DivisionID+'''
	AND W95.IsCheck = 1 '
	IF EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS TAB WHERE TAB.Name like 'POST%')		
	BEGIN
			SET @sSQL01 = N'
			AND W95.VoucherID NOT IN( SELECT W96.VoucherID FROM POST0015 P15 INNER JOIN POST00151 P151 ON P15.APK=P151.APKMaster
	 INNER JOIN WT0095 W95 ON P151.APKMInherited=W95.APK INNER JOIN WT0096 W96 ON W95.VoucherID=W96.VoucherID
	 union 
	  SELECT W96.VoucherID FROM POST0015 P15 INNER JOIN POST00151 P151 ON P15.APK=P151.APKMaster
	 INNER JOIN WT0095 W95 ON P151.APKMInherited=W95.VoucherID INNER JOIN WT0096 W96 ON W95.VoucherID=W96.VoucherID)
	  '
	 
	END

		SET @sSQL01 = @sSQL + @sSQL1+  @sSQL01+ N'AND Isnull(W96.ActualQuantity, 0) - isnull(G.ActualQuantity,0) > 0
	--AND W95.VoucherID NOT IN (SELECT ISNULL(InheritVoucherID,'''') FROM AT2007 WITH (NOLOCK) WHERE InheritTableID = ''WT0095'')
	AND ISNULL(W95.ObjectID,'''') LIKE '''+@ObjectID+'''
	'+@sWhere+'
	'
IF @CustomerIndex = 105 -- LIỄN QUÁN
BEGIN
	SET @sOrderBy = '
	ORDER BY VoucherDate ,VoucherNo'
END


EXEC(@sSQL01 + @sOrderBy)
PRINT @sSQL01
PRINT  @sOrderBy
--print @sSQL1




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO