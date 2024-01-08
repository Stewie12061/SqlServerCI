IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0318]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0318]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

 ---- Created by Bảo Thy on 03/07/2017
 ---- purpose: Load chứng từ nhập khi tạo yêu cầu xuất kho (lấy số lượng tồn từ Yêu cầu xuất kho và Phiếu xuất kho) (EIMSKIP)
 ---- Modified by on 
 ---- Modified by Bảo Thy on 21/07/2017: sửa cách lấy dữ liệu trường hợp xuất kho nhưng kế thừa chưa hết
 ---- Modified by Bảo Thy on 25/08/2017: Load chứng từ nhập của đối tượng khai báo
 ---- Modified by Bảo Anh on 11/07/2018: Sửa lỗi load số lượng còn lại của chứng từ nhập không đúng
 ---- Modified by Kim Thư on 05/06/2019: Chỉ hiển thị chứng từ nhập có tồn cuối > 0 (Eimskip) 
 ---- Modified by Thanh Lượng on 04/12/2023: [2023/10/TA/0219] Bổ sung thêm trường load cho chứng từ nhập.
/********************************************
EXEC WP0318 @DivisionID = 'EM', @WareHouseID = '', @InventoryID = '', @ReVoucherDate = ''
********************************************/

CREATE PROCEDURE [dbo].[WP0318] 
    @DivisionID VARCHAR(50), 
    @WareHouseID VARCHAR(50),
	@InventoryID VARCHAR(50),
	@ReVoucherDate DATETIME,
	@ObjectID VARCHAR(50) = ''
AS

IF EXISTS (SELECT TOP 1 1 FROM CustomerIndex WHERE CustomerName = 70) ----EIMSKIP
BEGIN
	
	SELECT 
	      AT0114.DivisionID, AT0114.WareHouseID, AT0114.InventoryID, AT0114.LimitDate, 
	      AT0114.ReVoucherID, AT0114.ReVoucherNo, AT0114.ReVoucherDate, AT0114.ReTransactionID, AT0114.ReSourceNo, 
	      AT0114.ReQuantity, AT0114.DeQuantity, 0 AS EndConvertedQuantity, AT0114.EndQuantity, AT0114.UnitPrice,
	      ISNULL(AT2007.ConvertedUnitID, AT2017.ConvertedUnitID) AS ConvertedUnitID,
	      ISNULL(AT2007.Parameter01, AT2017.Parameter01) AS Parameter01,
	      ISNULL(AT2007.Parameter02, AT2017.Parameter02) AS Parameter02,
	      ISNULL(AT2007.Parameter03, AT2017.Parameter03) AS Parameter03,
	      ISNULL(AT2007.Parameter04, AT2017.Parameter04) AS Parameter04,
	      ISNULL(AT2007.Parameter05, AT2017.Parameter05) AS Parameter05,
	      ISNULL(AT2007.Notes01, AT2017.Notes01) AS WNotes01,
	      ISNULL(AT2007.Notes02, AT2017.Notes02) AS WNotes02,
	      ISNULL(AT2007.Notes03, AT2017.Notes03) AS WNotes03,
	      ISNULL(AT2007.Notes04, AT2017.Notes04) AS WNotes04,
	      ISNULL(AT2007.Notes05, AT2017.Notes05) AS WNotes05,
	      ISNULL(AT2007.Notes06, AT2017.Notes06) AS WNotes06,
	      ISNULL(AT2007.Notes07, AT2017.Notes07) AS WNotes07,
	      ISNULL(AT2007.Notes08, AT2017.Notes08) AS WNotes08,
	      ISNULL(AT2007.Notes09, AT2017.Notes09) AS WNotes09,
	      ISNULL(AT2007.Notes10, AT2017.Notes10) AS WNotes10,
		  ISNULL(AT2007.Notes11, AT2017.Notes11) AS WNotes11,
		  ISNULL(AT2007.Notes12, AT2017.Notes12) AS WNotes12,
		  ISNULL(AT2007.Notes13, AT2017.Notes13) AS WNotes13,
		  ISNULL(AT2007.Notes14, AT2017.Notes14) AS WNotes14,
		  ISNULL(AT2007.Notes15, AT2017.Notes15) AS WNotes15,
	      ISNULL(AT2007.Ana01ID, AT2017.Ana01ID) AS Ana01ID,
	      ISNULL(AT2007.Ana02ID, AT2017.Ana02ID) AS Ana02ID,
	      ISNULL(AT2007.Ana03ID, AT2017.Ana03ID) AS Ana03ID,
	      ISNULL(AT2007.Ana04ID, AT2017.Ana04ID) AS Ana04ID,
	      ISNULL(AT2007.Ana05ID, AT2017.Ana05ID) AS Ana05ID,
	      ISNULL(AT2007.Ana06ID, AT2017.Ana06ID) AS Ana06ID,
	      ISNULL(AT2007.Ana07ID, AT2017.Ana07ID) AS Ana07ID,
	      ISNULL(AT2007.Ana08ID, AT2017.Ana08ID) AS Ana08ID,
	      ISNULL(AT2007.Ana09ID, AT2017.Ana09ID) AS Ana09ID,
	      ISNULL(AT2007.Ana10ID, AT2017.Ana10ID) AS Ana10ID
	INTO #AT0114_WP0318
	FROM AT0114 WITH (NOLOCK)
	LEFT JOIN AT2007 WITH (NOLOCK) ON AT0114.ReVoucherID = AT2007.VoucherID AND AT0114.ReTransactionID = AT2007.TransactionID AND AT0114.DivisionID = AT2007.DivisionID
	LEFT JOIN AT2017 WITH (NOLOCK) ON AT0114.ReVoucherID = AT2017.VoucherID AND AT0114.ReTransactionID = AT2017.TransactionID AND AT0114.DivisionID = AT2017.DivisionID
	LEFT JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID
	
	WHERE AT0114.DivisionID = @DivisionID
	AND AT0114.Status = 0 AND AT0114.IsLocked = 0 
	AND AT0114.EndQuantity > 0 
	AND AT0114.WareHouseID = @WareHouseID AND AT0114.InventoryID = @InventoryID
	AND AT2006.ObjectID = @ObjectID
	AND AT0114.ReVoucherDate <= @ReVoucherDate
	--ORDER BY ReVoucherDate
	
-----trường hợp chua xuất kho
--	SELECT WT0096.DivisionID, WT0096.ReVoucherID, WT0096.ReTransactionID, 
--	SUM(ISNULL(WT0096.ActualQuantity,0)) AS ActualQuantity
--	INTO #BT
--	FROM WT0096 WITH (NOLOCK) 
--	INNER JOIN WT0095 WITH (NOLOCK) ON WT0096.DivisionID = WT0095.DivisionID AND WT0096.VoucherID = WT0095.VoucherID
--	WHERE WT0096.DivisionID = @DivisionID
--	AND WT0095.WareHouseID = @WareHouseID AND WT0096.InventoryID = @InventoryID
--	AND WT0095.ObjectID = @ObjectID
--	AND WT0095.VoucherDate <= @ReVoucherDate
--	AND NOT EXISTS (SELECT TOP 1 1 FROM AT2007 A27 
--					INNER JOIN AT2006 A26 WITH (NOLOCK) ON A27.DivisionID = A26.DivisionID AND A27.VoucherID = A26.VoucherID
--					WHERE A27.DivisionID = WT0096.DivisionID AND A27.InheritTransactionID = WT0096.TransactionID AND A27.ReTransactionID = WT0096.ReTransactionID
--					AND A26.VoucherDate <= @ReVoucherDate
--					AND A27.DivisionID = @DivisionID
--					AND A26.ObjectID = @ObjectID
--					AND A26.WareHouseID = @WareHouseID AND A27.InventoryID = @InventoryID AND KindVoucherID IN (2,4,6,8,10))
--	AND WT0095.KindVoucherID IN (2,4,6,8,10)
--	GROUP BY WT0096.DivisionID, WT0096.ReVoucherID, WT0096.ReTransactionID

-----trường hợp xuất kho nhưng kế thừa chưa hết
--	SELECT WT0096.TransactionID, temp.InheritTransactionID,  WT0096.DivisionID, WT0096.ReVoucherID, WT0096.ReTransactionID, 
--	SUM(ISNULL(WT0096.ActualQuantity,0)) - SUM(ISNULL(Temp.ActualQuantity,0)) AS ActualQuantity
--	INTO #BT1
--	FROM WT0096 WITH (NOLOCK) 
--	INNER JOIN WT0095 WITH (NOLOCK) ON WT0096.DivisionID = WT0095.DivisionID AND WT0096.VoucherID = WT0095.VoucherID
--	INNER JOIN 
--	(SELECT A27.DivisionID, A27.InheritTransactionID, A27.ReTransactionID, A27.ActualQuantity
--	 FROM AT2007 A27 
--	 INNER JOIN AT2006 A26 WITH (NOLOCK) ON A27.DivisionID = A26.DivisionID AND A27.VoucherID = A26.VoucherID
--	 WHERE A26.VoucherDate <= @ReVoucherDate
--	 AND A27.DivisionID = @DivisionID
--	 AND A26.ObjectID = @ObjectID
--	 AND A26.WareHouseID = @WareHouseID AND A27.InventoryID = @InventoryID AND KindVoucherID IN (2,4,6,8,10)
--	 --GROUP BY A27.DivisionID, A27.InheritTransactionID, A27.ReTransactionID
--	)Temp ON Temp.DivisionID = WT0096.DivisionID AND Temp.InheritTransactionID = WT0096.TransactionID AND Temp.ReTransactionID = WT0096.ReTransactionID
--	WHERE WT0096.DivisionID = @DivisionID
--	AND WT0095.WareHouseID = @WareHouseID AND WT0096.InventoryID = @InventoryID
--	AND WT0095.ObjectID = @ObjectID
--	AND WT0095.VoucherDate <= @ReVoucherDate
--	AND WT0095.KindVoucherID IN (2,4,6,8,10)
--	GROUP BY  WT0096.TransactionID, temp.InheritTransactionID,WT0096.DivisionID, WT0096.ReVoucherID, WT0096.ReTransactionID
--	HAVING SUM(ISNULL(WT0096.ActualQuantity,0)) - SUM(ISNULL(Temp.ActualQuantity,0)) > 0

	UPDATE T1
	SET T1.EndQuantity = T1.ReQuantity - ISNULL((SELECT SUM(ActualQuantity) FROM WT0096 WITH (NOLOCK)
												INNER JOIN WT0095 WITH (NOLOCK) ON WT0096.DivisionID = WT0095.DivisionID AND WT0096.VoucherID = WT0095.VoucherID
												WHERE WT0096.DivisionID = @DivisionID AND WT0096.ReTransactionID = T1.ReTransactionID),0),
		T1.DeQuantity = ISNULL((SELECT SUM(ActualQuantity) FROM WT0096 WITH (NOLOCK)
												INNER JOIN WT0095 WITH (NOLOCK) ON WT0096.DivisionID = WT0095.DivisionID AND WT0096.VoucherID = WT0095.VoucherID
												WHERE WT0096.DivisionID = @DivisionID AND WT0096.ReTransactionID = T1.ReTransactionID),0)
	FROM #AT0114_WP0318 T1
	
	SELECT * FROM #AT0114_WP0318 WHERE EndQuantity > 0 ORDER BY ReVoucherDate
END
ELSE
BEGIN
	  SELECT 
      AT0114.DivisionID, AT0114.WareHouseID, AT0114.InventoryID, AT0114.LimitDate, 
      AT0114.ReVoucherID, AT0114.ReVoucherNo, Convert(varchar, AT0114.ReVoucherDate, 103) ReVoucherDate, AT0114.ReTransactionID, AT0114.ReSourceNo, AT0114.ReWarrantyNo,
	  AT0114.ReShelvesID, AT0114.ReFloorID,
      AT0114.ReQuantity, AT0114.DeQuantity, 0 AS EndConvertedQuantity, AT0114.EndQuantity, AT0114.UnitPrice,
      ISNULL(AT2007.ConvertedUnitID, AT2017.ConvertedUnitID) AS ConvertedUnitID,
      ISNULL(AT2007.Parameter01, AT2017.Parameter01) AS Parameter01,
      ISNULL(AT2007.Parameter02, AT2017.Parameter02) AS Parameter02,
      ISNULL(AT2007.Parameter03, AT2017.Parameter03) AS Parameter03,
      ISNULL(AT2007.Parameter04, AT2017.Parameter04) AS Parameter04,
      ISNULL(AT2007.Parameter05, AT2017.Parameter05) AS Parameter05,
      ISNULL(AT2007.Notes01, AT2017.Notes01) AS WNotes01,
      ISNULL(AT2007.Notes02, AT2017.Notes02) AS WNotes02,
      ISNULL(AT2007.Notes03, AT2017.Notes03) AS WNotes03,
      ISNULL(AT2007.Notes04, AT2017.Notes04) AS WNotes04,
      ISNULL(AT2007.Notes05, AT2017.Notes05) AS WNotes05,
      ISNULL(AT2007.Notes06, AT2017.Notes06) AS WNotes06,
      ISNULL(AT2007.Notes07, AT2017.Notes07) AS WNotes07,
      ISNULL(AT2007.Notes08, AT2017.Notes08) AS WNotes08,
      ISNULL(AT2007.Notes09, AT2017.Notes09) AS WNotes09,
      ISNULL(AT2007.Notes10, AT2017.Notes10) AS WNotes10,
	  ISNULL(AT2007.Notes11, AT2017.Notes11) AS WNotes11,
	  ISNULL(AT2007.Notes12, AT2017.Notes12) AS WNotes12,
	  ISNULL(AT2007.Notes13, AT2017.Notes13) AS WNotes13,
	  ISNULL(AT2007.Notes14, AT2017.Notes14) AS WNotes14,
	  ISNULL(AT2007.Notes15, AT2017.Notes15) AS WNotes15,
      ISNULL(AT2007.Ana01ID, AT2017.Ana01ID) AS Ana01ID,
      ISNULL(AT2007.Ana02ID, AT2017.Ana02ID) AS Ana02ID,
      ISNULL(AT2007.Ana03ID, AT2017.Ana03ID) AS Ana03ID,
      ISNULL(AT2007.Ana04ID, AT2017.Ana04ID) AS Ana04ID,
      ISNULL(AT2007.Ana05ID, AT2017.Ana05ID) AS Ana05ID,
      ISNULL(AT2007.Ana06ID, AT2017.Ana06ID) AS Ana06ID,
      ISNULL(AT2007.Ana07ID, AT2017.Ana07ID) AS Ana07ID,
      ISNULL(AT2007.Ana08ID, AT2017.Ana08ID) AS Ana08ID,
      ISNULL(AT2007.Ana09ID, AT2017.Ana09ID) AS Ana09ID,
      ISNULL(AT2007.Ana10ID, AT2017.Ana10ID) AS Ana10ID
      FROM AT0114 WITH (NOLOCK)
      LEFT JOIN AT2007 WITH (NOLOCK) ON AT0114.ReVoucherID = AT2007.VoucherID AND AT0114.ReTransactionID = AT2007.TransactionID AND AT0114.DivisionID = AT2007.DivisionID
      LEFT JOIN AT2017 WITH (NOLOCK) ON AT0114.ReVoucherID = AT2017.VoucherID AND AT0114.ReTransactionID = AT2017.TransactionID AND AT0114.DivisionID = AT2017.DivisionID
	  WHERE AT0114.DivisionID = @DivisionID
	  AND AT0114.Status = 0 AND AT0114.IsLocked = 0 
	  AND AT0114.EndQuantity > 0 
	  AND AT0114.WareHouseID = @WareHouseID AND AT0114.InventoryID = @InventoryID
	  AND AT0114.ReVoucherDate <= @ReVoucherDate
      Order by AT0114.LimitDate, AT0114.ReVoucherDate, AT0114.ReVoucherNo
END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
