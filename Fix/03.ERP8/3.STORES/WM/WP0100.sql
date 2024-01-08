IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0100]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0100]
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
---- Modified by Bảo Anh on 27/05/2017: Sửa danh mục dùng chung
---- Modified on 08/06/2017 by Bảo Thy: Fix lỗi Phiếu xuất kho kế thừa phiếu yêu cầu xuất kho lỗi
---- Modified on 03/07/2017 by Hải Long: Lỗi khi kế thừa nhiều lần
---- Modified on 20/10/2017 by Hải Long: Bổ sung trường ObjectID, Contactor
---- Modified on 22/10/2019 by Khánh Đoan :Bổ sung cho EIMSKIP 
---- Modified on 30/03/2020 by Huỳnh Thử : EIMSKIP: yêu cầu xuất kho đã kế thừa lệch xuất kho thì không cho kế thừa ở màn hình xuất kho kế thừa yêu cầu xk.
												 -- Ngược lại đã kế thừa từ màn hình xuast kho thì không hiển thị ở màn hình lệch xuất kho kế thừa yêu cầu xk
---- Modified on 12/06/2020 by Huỳnh Thử :Bỏ Master đã kế thừa hết số lượng
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
---- Modified on 01/10/2020 by Hoài Phong :Bỏ  dấu '' thừa đi
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified by Xuân Nguyên on 26/10/2023: [2023/10/IS/0233] - Sử dụng Left Outer Join để thay cho NOT IN 

-- <Example>
/*
    EXEC WP0100 'ESP','',1,2017,3,2017, '2014-05-29 11:32:10.833', '2014-05-29 11:32:10.833','%',0, 1
*/

CREATE PROCEDURE WP0100
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
    @IsDate TINYINT,
    @Mode TINYINT --1: Phiếu yêu cầu nhập, 2: Xuất, 3: VCNB, 4: Lệnh xuất Kho
)
AS
DECLARE @sSQL NVARCHAR(MAX),
        @sSQL1 NVARCHAR(MAX),
        @sWhere NVARCHAR(2000),
        @CustomerIndex INT,
        @sSelect NVARCHAR(MAX) = '',
        @sSelect1 NVARCHAR(MAX) = '',
        @sJoin NVARCHAR(MAX) = '';
SET @sSQL1 = '';
SET @sWhere = '';

SELECT @CustomerIndex = ISNULL(CustomerName, -1)
FROM CustomerIndex;

IF @CustomerIndex = 70 ----EIMSKIP
BEGIN
    SET @sSelect = ', W95.ContractID, W95.ContractNo, W95.WareHouseID, W95.WareHouseID2';
    SET @sSelect1
        = ', (CASE WHEN W95.KindVoucherID IN (1,3,5,7,9) THEN A33.InventoryName ELSE '''' END) ImWareHouseName,
					(CASE WHEN W95.KindVoucherID in (2,4,6,8,10) THEN A33.InventoryName
					ELSE CASE WHEN W95.KindVoucherID = 3 THEN A03.InventoryName ELSE '''' END END) ExWareHouseName';

    SET @sJoin
        = 'LEFT JOIN AT1302 A33 WITH (NOLOCK) ON A33.DivisionID IN (''@@@'', W95.DivisionID) AND A33.InventoryID = W95.WareHouseID
				  LEFT JOIN AT1302 A03 WITH (NOLOCK) ON A03.DivisionID IN (''@@@'', W95.DivisionID) AND A03.InventoryID = W95.WareHouseID2';
END;
ELSE
BEGIN
    SET @sSelect = ', W95.ContractID, W95.ContractNo, W95.WareHouseID, W95.WareHouseID2';
    SET @sJoin
        = 'LEFT JOIN AT1303 A33 WITH (NOLOCK) ON A33.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND A33.WareHouseID = W95.WareHouseID
				  LEFT JOIN AT1303 A03 WITH (NOLOCK) ON A03.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND A03.WareHouseID = W95.WareHouseID2';

    SET @sSelect1
        = ', (CASE WHEN W95.KindVoucherID IN (1,3,5,7,9) THEN A33.WareHouseName ELSE '''' END) ImWareHouseName,
		(CASE WHEN W95.KindVoucherID in (2,4,6,8,10) THEN A33.WareHouseName
		  ELSE CASE WHEN W95.KindVoucherID = 3 THEN A03.WareHouseName ELSE '''' END END) ExWareHouseName';
END;

IF @IsDate = 0
    SET @sWhere
        = 'AND W95.TranMonth + W95.TranYear * 100 BETWEEN ' + STR(@FromMonth + @FromYear * 100) + ' AND '
          + STR(@ToMonth + @ToYear * 100) + ' ';
IF @IsDate = 1
    SET @sWhere
        = 'AND CONVERT(VARCHAR, W95.VoucherDate,112) BETWEEN ' + CONVERT(VARCHAR, @FromDate, 112) + ' AND '
          + CONVERT(VARCHAR, @ToDate, 112) + ' ';
IF @Mode = 1
    SET @sWhere = @sWhere + '
AND W95.KindVoucherID IN (1,3,5,7,9) AND W95.WareHouseID2 IS NULL';
IF @Mode = 2
    SET @sWhere = @sWhere + '
AND W95.KindVoucherID IN (2,4,6,8,10)';
IF @Mode = 4
    SET @sWhere = @sWhere + '
AND W95.KindVoucherID IN (2,4,6,8,10)';
IF @Mode = 3
    SET @sWhere = @sWhere + '
AND W95.KindVoucherID = 3 AND W95.WareHouseID2 IS NOT NULL';
IF EXISTS
(
    SELECT TOP 1
           1
    FROM AT0000 WITH (NOLOCK)
    WHERE DefDivisionID = @DivisionID
          AND IsSpecificate = 1
)
BEGIN

    SET @sSQL
        = '
	SELECT DISTINCT CONVERT(TINYINT,0) Choose, W95.VoucherID, W95.VoucherNo, W95.VoucherTypeID, W95.VoucherDate, A02.ObjectName, W95.[Description], A02.ObjectID, A02.Contactor 
	' + @sSelect + @sSelect1
          + '
	FROM WT0095 W95 WITH (NOLOCK)
	LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A02.ObjectID = W95.ObjectID
	LEFT JOIN WT0096 W96 WITH (NOLOCK) ON W96.DivisionID = W95.DivisionID AND W96.VoucherID = W95.VoucherID
	LEFT JOIN WT8899 O99 WITH (NOLOCK) ON O99.DivisionID = W96.DivisionID AND O99.VoucherID = W96.VoucherID AND O99.TransactionID = W96.TransactionID AND O99.TableID = ''WT0096''
	' + @sJoin + '
	';
    SET @sSQL1
        = '	
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
												Isnull(G.S01ID,'''') = Isnull(O99.S01ID,'''') AND	Isnull(G.S01ID,'''') = Isnull(O99.S01ID,'''') AND 
												Isnull(G.S01ID,'''') = Isnull(O99.S01ID,'''') AND	Isnull(G.S01ID,'''') = Isnull(O99.S01ID,'''') AND 
												Isnull(G.S01ID,'''') = Isnull(O99.S01ID,'''') AND	Isnull(G.S01ID,'''') = Isnull(O99.S01ID,'''') AND 
												Isnull(G.S01ID,'''') = Isnull(O99.S01ID,'''') AND	Isnull(G.S01ID,'''') = Isnull(O99.S01ID,'''') AND 
												Isnull(G.S01ID,'''') = Isnull(O99.S01ID,'''') AND	Isnull(G.S01ID,'''') = Isnull(O99.S01ID,'''') AND 
												Isnull(G.S01ID,'''') = Isnull(O99.S01ID,'''') AND	Isnull(G.S01ID,'''') = Isnull(O99.S01ID,'''') AND 
												Isnull(G.S01ID,'''') = Isnull(O99.S01ID,'''') AND	Isnull(G.S01ID,'''') = Isnull(O99.S01ID,'''') AND 
												Isnull(G.S01ID,'''') = Isnull(O99.S01ID,'''') AND	Isnull(G.S01ID,'''') = Isnull(O99.S01ID,'''') AND
												Isnull(G.S01ID,'''') = Isnull(O99.S01ID,'''') AND	Isnull(G.S01ID,'''') = Isnull(O99.S01ID,'''') AND 
												Isnull(G.S01ID,'''') = Isnull(O99.S01ID,'''') AND	Isnull(G.S01ID,'''') = Isnull(O99.S01ID,'''')
	WHERE W95.DivisionID = ''' + @DivisionID + '''
    AND W95.IsCheck = 1
	AND Isnull(W96.ActualQuantity, 0) - isnull(G.ActualQuantity,0) > 0
	--AND W95.VoucherID NOT IN (SELECT ISNULL(InheritVoucherID,'''') FROM AT2007 WITH (NOLOCK) WHERE InheritTableID = ''WT0095'')
	AND ISNULL(W95.ObjectID,'''') LIKE ''' + @ObjectID + '''
	' + @sWhere + '
	'	;
END;
ELSE IF @Mode = 4 ---- Lệnh Xuất kho
BEGIN
    SET @sSQL
        = '
	SELECT DISTINCT CONVERT(TINYINT,0) Choose, W95.VoucherID AS InheritVoucherID, 
	W95.VoucherNo, W95.VoucherTypeID, W95.VoucherDate, A02.ObjectName, W95.[Description], A02.ObjectID, A02.Contactor 
	 ,W95.ContractID, W95.ContractNo, W95.WareHouseID
	FROM WT0095 W95 WITH (NOLOCK)
	LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A02.ObjectID = W95.ObjectID
	LEFT JOIN WT0096 W96 WITH (NOLOCK) ON W96.DivisionID = W95.DivisionID AND W96.VoucherID = W95.VoucherID
	LEFT JOIN AT1302 A33 WITH (NOLOCK) ON A33.DivisionID IN (''@@@'', W95.DivisionID) AND A33.InventoryID = W95.WareHouseID
	LEFT JOIN 
	(
		SELECT 
		WT2002.DivisionID, 
		WT2002.InheritVoucherID, 
		WT2002.InventoryID,
		SUM(ISNULL(WT2002.ActualQuantity, 0)) AS ActualQuantity, 
		SUM(ISNULL(WT2002.OriginalAmount, 0)) AS ActualOriginalAmount
		FROM WT2002  WITH (NOLOCK)
		INNER JOIN WT2001 WITH (NOLOCK) ON WT2001.VoucherID = WT2002.VoucherID AND WT2001.DivisionID = WT2002.DivisionID
		WHERE WT2001.KindVoucherID = 2
		GROUP BY WT2002.DivisionID, WT2002.InheritVoucherID, WT2002.InventoryID
		) AS G ON G.DivisionID = W96.DivisionID AND G.InheritVoucherID = W96.VoucherID 
		WHERE W95.DivisionID = ''' + @DivisionID
          + '''
		  AND W95.IsCheck = 1
		  AND W95.VoucherID NOT IN (SELECT 			AT2007.InheritVoucherID
			FROM AT2007  WITH (NOLOCK)
			INNER JOIN AT2006 WITH (NOLOCK) ON AT2007.VoucherID = AT2006.VoucherID AND AT2007.DivisionID = AT2006.DivisionID
			WHERE AT2007.InheritTableID = ''WT0095''
			GROUP BY AT2007.DivisionID, AT2007.OrderID, InventoryID, OTransactionID, AT2007.InheritVoucherID, AT2007.InheritTransactionID)
		--AND Isnull(W96.ActualQuantity, 0) - isnull(G.ActualQuantity,0) > 0
		AND ISNULL(W95.ObjectID,'''') LIKE ''' + @ObjectID + '''
		' + @sWhere + '
		Group by W95.VoucherID , 
		W95.VoucherNo, W95.VoucherTypeID, W95.VoucherDate, A02.ObjectName, W95.[Description], A02.ObjectID, A02.Contactor 
		 ,W95.ContractID, W95.ContractNo, W95.WareHouseID
		 Having Isnull(Sum(W96.ActualQuantity), 0) - isnull(Sum(G.ActualQuantity),0) > 0
	';
END;
ELSE
BEGIN
    SET @sSQL
        = ' 
		SELECT DISTINCT CONVERT(TINYINT,0) Choose, W95.VoucherID AS InheritVoucherID, W95.VoucherNo, W95.VoucherTypeID, W95.VoucherDate, A02.ObjectName, W95.[Description], A02.ObjectID, A02.Contactor 
		' + @sSelect + @sSelect1
          + '
		FROM WT0095 W95 WITH (NOLOCK)
		LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A02.ObjectID = W95.ObjectID
		LEFT JOIN WT0096 W96 WITH (NOLOCK) ON W96.DivisionID = W95.DivisionID AND W96.VoucherID = W95.VoucherID
		' + @sJoin
          + '
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
		'+ CASE WHEN @CustomerIndex = 70 THEN ' LEFT OUTER JOIN WT2002 ON W95.VoucherID = WT2002.InheritVoucherID 	' ELSE '' END +'
		WHERE W95.DivisionID = ''' + @DivisionID + '''
	    AND W95.IsCheck = 1
		AND Isnull(W96.ActualQuantity, 0) - isnull(G.ActualQuantity,0) > 0
		--AND W95.VoucherID NOT IN (SELECT ISNULL(InheritVoucherID,'''') FROM AT2007 WITH (NOLOCK) WHERE InheritTableID = ''WT0095'')
		'+ CASE WHEN @CustomerIndex = 70 THEN '
			AND ISNULL(WT2002.InheritVoucherID,'''') =''''
			' ELSE '' END +'
		AND ISNULL(W95.ObjectID,'''') LIKE ''' + @ObjectID + '''
		' + @sWhere + '
		';
END;

PRINT @sSQL;
PRINT @sSQL1;
EXEC (@sSQL + @sSQL1);
--PRINT(@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
