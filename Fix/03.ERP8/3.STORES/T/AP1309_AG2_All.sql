IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1309_AG2_ALL]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1309_AG2_ALL]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--------- Created by Huỳnh Thử on 05/05/2020: Tách riêng store cho Angel, Tính giá all kho
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.

CREATE PROCEDURE [dbo].[AP1309_AG2_All] 
    @DivisionID NVARCHAR(50), 
    @TranMonth INT, 
    @TranYear INT, 
    @FromInventoryID NVARCHAR(50), 
    @ToInventoryID NVARCHAR(50), 
    @FromAccountID NVARCHAR(50), 
    @ToAccountID NVARCHAR(50),
    @UserID NVARCHAR(50),
    @GroupID NVARCHAR (50)
AS
DECLARE 
    @sSQL NVARCHAR(4000), 
    @sSQL1 NVARCHAR(4000),
    @sSQL2 NVARCHAR(4000),
    @QuantityDecimals TINYINT, 
    @UnitCostDecimals TINYINT,
    @ConvertedDecimals TINYINT

SELECT @QuantityDecimals = QuantityDecimals, 
    @UnitCostDecimals = UnitCostDecimals, 
    @ConvertedDecimals = ConvertedDecimals
FROM AT1101 WITH (NOLOCK)
WHERE DivisionID =@DivisionID

SET @QuantityDecimals = ISNULL(@QuantityDecimals, 2)
SET @UnitCostDecimals = ISNULL(@UnitCostDecimals, 2)
SET @ConvertedDecimals = ISNULL(@ConvertedDecimals, 2)
-- Ghi lai history
Insert into HistoryInfo(TableID, ModifyUserID, ModifyDate, Action, VoucherNo, TransactionTypeID, DivisionID)
Values ('WF0056', @UserID, GETDATE(), 9, @GroupID,'',@DivisionID)

--Cap nhat gia xuat tra lai hang mua = gia cua phieu tra lai hang mua
SET @sSQL = '
UPDATE AT2007 
SET AT2007.UnitPrice = (CASE WHEN ActualQuantity <> 0 THEN ROUND(AT9000.ConvertedAmount / ActualQuantity, '+str(@UnitCostDecimals)+') ELSE 0 END),
	AT2007.ConvertedPrice =  (CASE WHEN ActualQuantity <> 0 THEN ROUND(AT9000.ConvertedAmount / ActualQuantity, '+str(@UnitCostDecimals)+') ELSE 0 END),
    OriginalAmount = AT9000.ConvertedAmount, 
    ConvertedAmount = AT9000.ConvertedAmount
FROM AT20072 AT2007 WITH (ROWLOCK)
    INNER JOIN AT9000 WITH (NOLOCK) ON AT9000.DivisionID = AT2007.DivisionID AND AT9000.VoucherID = AT2007.VoucherID AND AT9000.TransactionID = AT2007.TransactionID
WHERE AT2007.KindVoucherID = 10
    AND AT9000.TransactionTypeID = ''T25'' 
    AND AT9000.TranMonth = ' + str(@TranMonth) + ' 
    AND AT9000.TranYear = ' + str(@TranYear) + '
    AND NOT EXISTS (SELECT 1 FROM AT1309_AG_TEM WHERE InventoryID  = AT2007.InventoryID)
	
	UPDATE AT2007
	SET UnitPrice = 0,
		ConvertedPrice = 0, 
		OriginalAmount = 0, 
		ConvertedAmount = 0
	FROM AT20072 AT2007 WITH (ROWLOCK)
	WHERE AT2007.CreditAccountID BETWEEN '''+@FromAccountID+''' AND '''+@ToAccountID+'''
		AND (Select MethodID From AT1302 WITH (NOLOCK) Where DivisionID = AT2007.DivisionID And InventoryID = AT2007.InventoryID) IN (4, 5)
		AND KindVoucherID = 3
		AND NOT EXISTS (SELECT 1 FROM AT1309_AG_TEM WHERE InventoryID  = AT2007.InventoryID)
		AND ISNULL(AT2007.IsNotUpdatePrice,0) = 0
'

EXEC (@sSQL)
		 
SET @sSQL = '
SELECT 
    AT2008.InventoryID, 
    AT2008.DivisionID,
    SUM(ISNULL(AT2008.BeginQuantity, 0)) AS ActBegQty, 
    SUM(ISNULL(AT2008.BeginAmount, 0)) AS ActBegTotal, 
    SUM(ISNULL(AT2008.DebitQuantity, 0)) AS ActReceivedQty, 
    SUM(ISNULL(AT2008.DebitAmount, 0)) AS ActReceivedTotal, 
    SUM(ISNULL(AT2008.CreditQuantity, 0)) AS ActDeliveryQty, 
    SUM(ISNULL(AT2008.EndQuantity, 0)) AS ActEndQty, 
    SUM(AT2008.InDebitAmount) AS InDebitAmount,
	SUM(AT2008.InDebitQuantity) AS InDebitQuantity,
	ISNULL(B.Quantity,0)  AS  Quantity ,
	ISNULL(B.Amount,0) AS Amount  ,
	SUM(ISNULL(QuantityNotJoinPrice,0)) AS QuantityNotJoinPrice,
	SUM(ISNULL(AmountNotJoinPrice,0)) AS AmountNotJoinPrice,
    CASE WHEN SUM(ISNULL(AT2008.BeginQuantity, 0)) + SUM(ISNULL(AT2008.DebitQuantity, 0)) - ISNULL(B.Quantity,0)
	- SUM(ISNULL(AT2008.InDebitQuantity,0))
	- SUM(ISNULL(QuantityNotJoinPrice,0)) = 0 
        THEN 0 
        ELSE convert(decimal(28,8),
				SUM(ISNULL(AT2008.BeginAmount, 0)) + SUM(ISNULL(AT2008.DebitAmount, 0)) - ISNULL(B.Amount,0) 
			- SUM(ISNULL(AT2008.InDebitAmount,0))
			- SUM(ISNULL(AmountNotJoinPrice,0))
	) / 
            convert(decimal(28,8),
				SUM(ISNULL(AT2008.BeginQuantity, 0)) + SUM(ISNULL(AT2008.DebitQuantity, 0)) - ISNULL(B.Quantity,0)
			- SUM(ISNULL(AT2008.InDebitQuantity,0))
			- SUM(ISNULL(QuantityNotJoinPrice,0)))
    END AS UnitPrice
FROM AT20082 AT2008 WITH (NOLOCK)
--INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID = AT2008.DivisionID AND AT1302.InventoryID = AT2008.InventoryID 
INNER JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN (''' + @DivisionID + ''', ''@@@'') AND AT1303.WareHouseID = AT2008.WareHouseID
LEFT JOIN (SELECT  InventoryID, SUM(ActualQuantity) AS Quantity, SUM(ConvertedAmount) AS Amount
			FROM AT20072 AT2007 WITH (NOLOCK)
			WHERE ((ISNULL(AT2007.IsReturn,0) = 1 AND AT2007.KindVoucherID <> 3) OR (AT2007.KindVoucherID IN (7) AND ISNULL(AT2007.IsNotUpdatePrice,0) = 0))
			GROUP BY InventoryID) B ON  B.InventoryID = AT2008.InventoryID --AND B.DebitAccountID = AT2008.InventoryAccountID
WHERE (Select MethodID From AT1302 WITH (NOLOCK) Where InventoryID = AT2008.InventoryID) = 4
    AND NOT EXISTS (SELECT 1 FROM AT1309_AG_TEM WHERE InventoryID  = AT2008.InventoryID)
GROUP BY 
    AT2008.InventoryID, 
    AT2008.DivisionID,
    B.Quantity, B.Amount
'

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE Xtype = 'V' AND Name = 'AV1309')
    EXEC (' CREATE VIEW AV1309 AS ' + @sSQL)
ELSE
    EXEC (' ALTER VIEW AV1309 AS ' + @sSQL)
EXEC(@sSQL)
--PRINT @sSQL1
--PRINT @sSQL2    
------------ Xu ly chi tiet gia


------ Tinh gia xuat kho; Gia Binh quan cho cac phieu xuat kho thuong
IF EXISTS 
(
    SELECT TOP 1 1 
    FROM AT20072 AT2007 WITH (NOLOCK) 
        INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID = AT2007.DivisionID AND AT1302.InventoryID = AT2007.InventoryID
    WHERE AT2007.KindVoucherID IN (2, 4, 6, 8) 
    AND At1302.MethodID = 4
)
BEGIN	
	EXEC AP1307_All @DivisionID, @TranMonth, @TranYear, @QuantityDecimals, @UnitCostDecimals, @ConvertedDecimals
END

-------------- Update giá cho các phiếu nhập hàng trả về
SET @sSQL = '
	UPDATE AT2007 
	SET UnitPrice = ROUND(AV1309.UnitPrice, '+str(@UnitCostDecimals)+'),
		ConvertedPrice =  ROUND(AV1309.UnitPrice, '+str(@UnitCostDecimals)+'),
		OriginalAmount = ROUND(ROUND(AV1309.UnitPrice, '+str(@UnitCostDecimals)+') * ROUND(AT2007.ActualQuantity, '+Str(@QuantityDecimals) +'), '+Str(@ConvertedDecimals) +'), 
		ConvertedAmount = ROUND(ROUND(AV1309.UnitPrice, '+str(@UnitCostDecimals)+') * ROUND(AT2007.ActualQuantity, '+Str(@QuantityDecimals) +'), '+Str(@ConvertedDecimals) +') 
	FROM AT20072 AT2007 WITH (ROWLOCK)
	INNER JOIN AV1309 ON AV1309.DivisionID = AT2007.DivisionID AND AT2007.InventoryID = AV1309.InventoryID
	WHERE ((Isnull(IsReturn,0) = 1 AND KindVoucherID = 1) OR KindVoucherID IN (7))
		AND ISNULL(IsNotUpdatePrice,0) = 0
		AND NOT EXISTS (SELECT 1 FROM AT1309_AG_TEM WHERE InventoryID = AT2007.InventoryID)
'
SET @sSQL1 = '		
-------------- Update về phiếu tháo dở phần nhập kho	
	UPDATE 	AT0113 
	SET OriginalAmount = ROUND(ISNULL(ROUND(AV1309.UnitPrice, '+str(@UnitCostDecimals)+'),0) * AT0113.ActualQuantity,'+STR(@ConvertedDecimals)+'),
		ConvertedAmount = ROUND(ISNULL(ROUND(AV1309.UnitPrice, '+str(@UnitCostDecimals)+'),0) * AT0113.ActualQuantity,'+STR(@ConvertedDecimals)+'),
		UnitPrice = ROUND(ISNULL(AV1309.UnitPrice,0), '+str(@UnitCostDecimals)+'),
		ConvertedPrice = ROUND(ISNULL(AV1309.UnitPrice,0), '+str(@UnitCostDecimals)+')
	FROM AT0113 WITH (ROWLOCK) 
	LEFT JOIN AT0112 WITH (NOLOCK)  ON AT0112.DivisionID = AT0113.DivisionID AND AT0112.VoucherID = AT0113.VoucherID
	INNER JOIN AV1309 AV1309 WITH (NOLOCK) ON AT0113.DivisionID = AV1309.DivisionID AND AT0113.InventoryID = AV1309.InventoryID 
	WHERE AT0113.KindVoucherID = 1 AND ISNULL(AT0113.IsNotUpdatePrice,0) = 0
		AND AT0112.TranMonth = ' + str(@TranMonth) + '
		AND AT0112.TranYear = ' + str(@TranYear) + '
		AND AT0112.DivisionID = ''' + @DivisionID + '''
		AND AT0112.[Type] = 1
		
	-------------- Update về phiếu tháo dở phần xuất kho	
	UPDATE 	AT0113 
	SET OriginalAmount = Isnull(A.OrginalAmount,0),
		ConvertedAmount = Isnull(A.ConvertedAmount,0),
		UnitPrice = CASE WHEN Isnull(ActualQuantity,0) = 0 THEN 0 ELSE ROUND(Isnull(A.OrginalAmount,0)/Isnull(ActualQuantity,0), '+str(@UnitCostDecimals)+') END,
		ConvertedPrice = CASE WHEN Isnull(ActualQuantity,0) = 0 THEN 0 ELSE ROUND(Isnull(A.ConvertedAmount,0)/Isnull(ActualQuantity,0), '+str(@UnitCostDecimals)+') END
	FROM AT0113 WITH (ROWLOCK) 
	LEFT JOIN AT0112 WITH (NOLOCK)  ON AT0112.DivisionID = AT0113.DivisionID AND AT0112.VoucherID = AT0113.VoucherID
	INNER JOIN (
	SELECT DivisionID, VoucherID, KindVoucherID, SUM(OriginalAmount) AS OrginalAmount, SUM(AT0113.ConvertedAmount) AS ConvertedAmount
	FROM AT0113 WITH (NOLOCK) 
	WHERE AT0113.KindVoucherID = 1 AND AT0113.DivisionID = ''' + @DivisionID + '''
	GROUP BY DivisionID, KindVoucherID, VoucherID) A ON A.DivisionID = AT0113.DivisionID AND A.VoucherID = AT0113.VoucherID
	WHERE AT0113.KindVoucherID = 2
		AND AT0112.TranMonth = ' + str(@TranMonth) + '
		AND AT0112.TranYear = ' + str(@TranYear) + '
		AND AT0112.DivisionID = ''' + @DivisionID + '''
		AND AT0112.[Type] = 1
'

SET @sSQL2 = '		
----------------- Update về AT2007 cho phần nhập kho tháo dở
	UPDATE AT2007
	SET ConvertedAmount = Isnull(AT0113.ConvertedAmount,0),
	OriginalAmount = Isnull(AT0113.OriginalAmount,0),
	UnitPrice = CASE WHEN ISNULL(AT2007.ActualQuantity,0) = 0 THEN 0 ELSE ROUND(Isnull(AT0113.OriginalAmount,0)/ISNULL(AT2007.ActualQuantity,0), '+str(@UnitCostDecimals)+') END,
	ConvertedPrice = CASE WHEN ISNULL(AT2007.ActualQuantity,0) = 0 THEN 0 ELSE ROUND(Isnull(AT0113.ConvertedAmount,0)/ISNULL(AT2007.ActualQuantity,0), '+str(@UnitCostDecimals)+') END
	FROM AT20072 AT2007 WITH (ROWLOCK)
	LEFT JOIN AT0113 WITH (NOLOCK) ON AT2007.DivisionID = AT0113.DivisionID AND AT2007.InheritVoucherID = AT0113.VoucherID AND AT2007.InheritTransactionID = AT0113.TransactionID
	LEFT JOIN AT0112 WITH (NOLOCK) ON AT0112.DivisionID = AT0113.DivisionID AND AT0112.VoucherID = AT0113.VoucherID
	WHERE AT0113.KindVoucherID = 1
		AND AT0113.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+'''
		AND AT0112.TranMonth = ' + str(@TranMonth) + '
		AND AT0112.TranYear = ' + str(@TranYear) + '
		AND AT0112.DivisionID = ''' + @DivisionID + '''
		AND AT0112.[Type] = 1
		AND ISNULL(AT0113.IsNotUpdatePrice,0) = 0
		
----------------- Update về AT2007 cho phần xuất kho tháo dở
	UPDATE AT2007
	SET ConvertedAmount = Isnull(AT0113.ConvertedAmount,0),
	OriginalAmount = Isnull(AT0113.OriginalAmount,0),
	UnitPrice = CASE WHEN ISNULL(AT2007.ActualQuantity,0) = 0 THEN 0 ELSE ROUND(Isnull(AT0113.OriginalAmount,0)/ISNULL(AT2007.ActualQuantity,0), '+str(@UnitCostDecimals)+') END,
	ConvertedPrice = CASE WHEN ISNULL(AT2007.ActualQuantity,0) = 0 THEN 0 ELSE ROUND(Isnull(AT0113.ConvertedAmount,0)/ISNULL(AT2007.ActualQuantity,0), '+str(@UnitCostDecimals)+') END
	FROM AT20072 AT2007 WITH (ROWLOCK)
	LEFT JOIN AT0113 WITH (NOLOCK)  ON AT2007.DivisionID = AT0113.DivisionID AND AT2007.InheritVoucherID = AT0113.VoucherID AND AT2007.InheritTransactionID = AT0113.TransactionID
	LEFT JOIN AT0112 WITH (NOLOCK)  ON AT0112.DivisionID = AT0113.DivisionID AND AT0112.VoucherID = AT0113.VoucherID
	LEFT JOIN AT0113 A13 WITH (NOLOCK) ON A13.DivisionID = AT0112.DivisionID AND A13.VoucherID = AT0112.VoucherID AND A13.TranMonth = AT0112.TranMonth AND A13.TranYear = AT0112.TranYear AND A13.KindVoucherID = 1
	WHERE AT0113.KindVoucherID = 2
		AND A13.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+'''
		AND AT0112.TranMonth = ' + str(@TranMonth) + '
		AND AT0112.TranYear = ' + str(@TranYear) + '
		AND AT0112.DivisionID = ''' + @DivisionID + '''
		AND AT0112.[Type] = 1
'
PRINT @sSQL print @sSQL1 print @sSQL2
EXEC (@sSQL + @sSQL1 + @sSQL2)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
