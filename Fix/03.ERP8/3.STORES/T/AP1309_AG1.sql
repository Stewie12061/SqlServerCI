IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1309_AG1]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1309_AG1]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



--------- Created by Tiểu Mai on 21/11/2016: Tách riêng store cho Angel, xử lý riêng vì có phiếu lắp ráp, tháo dỡ
--------- Modified by Tiểu Mai on 22/12/2016: Bổ sung xử lý giá cho ANGEL 
--------- Modified by Tiểu Mai on 27/02/2017: Bổ sung xử lý giá phiếu nhập hàng trả lại cho ANGEL 
--------- Modified by Tiểu Mai on 02/03/2017: Bổ sung xử lý giá chênh lệch cho ANGEL 
--------- Modified by Nhựt Trường on 29/04/2022: Cập nhật bổ sung từ bản Customize Angel.

CREATE PROCEDURE [dbo].[AP1309_AG1] 
    @DivisionID NVARCHAR(50), 
    @TranMonth INT, 
    @TranYear INT, 
    @FromInventoryID NVARCHAR(50), 
    @ToInventoryID NVARCHAR(50), 
    @FromWareHouseID NVARCHAR(50), 
    @ToWareHouseID NVARCHAR(50), 
    @FromAccountID NVARCHAR(50), 
    @ToAccountID NVARCHAR(50),
    @UserID NVARCHAR(50),
    @GroupID NVARCHAR (50)
AS
DECLARE 
    @sSQL NVARCHAR(4000), 
    @sSQL1 NVARCHAR(4000),
    @sSQL2 NVARCHAR(4000),
    @sSQL3 NVARCHAR(4000),
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
	AND AT2007.InventoryID between ''' + @FromInventoryID + ''' and ''' + @ToInventoryID + '''
	
UPDATE AT2007
SET UnitPrice = 0,
	ConvertedPrice = 0, 
	OriginalAmount = 0, 
	ConvertedAmount = 0
FROM AT20072 AT2007 WITH (ROWLOCK) 
WHERE AT2007.CreditAccountID BETWEEN '''+@FromAccountID+''' AND '''+@ToAccountID+'''
	AND (Select MethodID From AT1302 WITH (NOLOCK) Where DivisionID = AT2007.DivisionID And InventoryID = AT2007.InventoryID) IN (4, 5)
	AND AT2007.WareHouseID2 BETWEEN '''+@FromWareHouseID+''' AND '''+@ToWareHouseID+'''
	AND AT2007.KindVoucherID = 3
	AND ISNULL(AT2007.IsNotUpdatePrice,0) = 0
	AND AT2007.InventoryID between ''' + @FromInventoryID + ''' and ''' + @ToInventoryID + '''
'
--PRINT @sSQL
EXEC (@sSQL)
		 
SET @sSQL = '
SELECT AT2008.WareHouseID, 
    AT2008.InventoryID, 
    AT2008.InventoryAccountID, 
    AT1302.InventoryName AS InventoryName, 
    AT1303.WareHouseName AS WareHouseName, 
    AT2008.DivisionID,
    SUM(ISNULL(AT2008.BeginQuantity, 0)) AS ActBegQty, 
    SUM(ISNULL(AT2008.BeginAmount, 0)) AS ActBegTotal, 
    SUM(ISNULL(AT2008.DebitQuantity, 0)) AS ActReceivedQty, 
    SUM(ISNULL(AT2008.DebitAmount, 0)) AS ActReceivedTotal, 
    SUM(ISNULL(AT2008.CreditQuantity, 0)) AS ActDeliveryQty, 
    SUM(ISNULL(AT2008.EndQuantity, 0)) AS ActEndQty, 
    CASE WHEN (SUM(ISNULL(AT2008.BeginQuantity, 0) + ISNULL(AT2008.DebitQuantity, 0) - ISNULL(B.Quantity,0)  
              )) = 0 
        THEN 0 
        ELSE convert(decimal(28,8),(SUM(ISNULL(AT2008.BeginAmount, 0) + ISNULL(AT2008.DebitAmount, 0) - ISNULL(B.Amount,0) 
					))) / 
            convert(decimal(28,8),(SUM(ISNULL(AT2008.BeginQuantity, 0) + ISNULL(AT2008.DebitQuantity, 0) - ISNULL(B.Quantity,0) 
					)))
    END AS UnitPrice
FROM AT20082 AT2008 WITH (NOLOCK)
INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2008.DivisionID,''@@@'') AND AT1302.InventoryID = AT2008.InventoryID 
INNER JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN (AT2008.DivisionID,''@@@'') AND AT1303.WareHouseID = AT2008.WareHouseID 
LEFT JOIN (SELECT WareHouseID, InventoryID, DebitAccountID, SUM(ActualQuantity) AS Quantity, SUM(ConvertedAmount) AS Amount
			FROM AT20072 with (nolock)
			WHERE (ISNULL(IsReturn,0) = 1 OR (KindVoucherID IN (7) AND ISNULL(IsNotUpdatePrice,0) = 0))
			GROUP BY WareHouseID, InventoryID, DebitAccountID) B
	ON AT2008.WareHouseID = B.WareHouseID AND B.InventoryID = AT2008.InventoryID AND B.DebitAccountID = AT2008.InventoryAccountID
WHERE AT1302.MethodID = 4
	AND AT2008.InventoryID between ''' + @FromInventoryID + ''' and ''' + @ToInventoryID + '''
GROUP BY AT2008.WareHouseID, 
    AT2008.InventoryID, 
    AT1303.WareHouseName, 
    AT1302.InventoryName, 
    AT2008.InventoryAccountID,
    AT2008.DivisionID,
    B.Quantity, B.Amount
'

IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE Xtype = 'V' AND Name = 'AV1309')
    EXEC (' CREATE VIEW AV1309 AS ' + @sSQL)
ELSE
    EXEC (' ALTER VIEW AV1309 AS ' + @sSQL)

--PRINT @sSQL1
--PRINT @sSQL2    
------------ Xu ly chi tiet gia 
------ Tinh gia xuat kho; Gia Binh quan cho cac phieu xuat van chuyen noi bo
IF EXISTS 
(
    SELECT TOP 1 1 
    FROM AT20072 AT2007 WITH (NOLOCK)
        INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,'@@@') AND AT1302.InventoryID = AT2007.InventoryID
    WHERE KindVoucherID = 3 
    AND At1302.MethodID = 4
	AND AT2007.InventoryID between @FromInventoryID and @ToInventoryID
) 
BEGIN
    EXEC AP1308_AG @DivisionID, @TranMonth, @TranYear, @QuantityDecimals, @UnitCostDecimals, @ConvertedDecimals
END

------ Tinh gia xuat kho; Gia Binh quan cho cac phieu xuat kho thuong
IF EXISTS 
(
    SELECT TOP 1 1 
    FROM AT20072 AT2007 WITH (NOLOCK)
        INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,'@@@') AND AT1302.InventoryID = AT2007.InventoryID
    WHERE KindVoucherID IN (2, 4, 6, 8) 
    AND At1302.MethodID = 4
	AND AT2007.InventoryID between @FromInventoryID and @ToInventoryID
)
BEGIN	
	EXEC AP1307 @DivisionID, @TranMonth, @TranYear, @QuantityDecimals, @UnitCostDecimals, @ConvertedDecimals
END

-------------- Update về phiếu lắp ráp, tháo dỡ
SET @sSQL = '
--------------- Update về phần xuất kho của phiếu lắp ráp
	UPDATE AT0113
	SET
		UnitPrice = AT2007.UnitPrice,
		OriginalAmount = AT2007.OriginalAmount,
		ConvertedPrice = AT2007.ConvertedPrice,
		ConvertedAmount = AT2007.ConvertedAmount
	FROM AT0113 WITH (ROWLOCK) 
	INNER JOIN AT0112 WITH (NOLOCK)  ON AT0112.DivisionID = AT0113.DivisionID AND AT0112.VoucherID = AT0113.VoucherID 
	LEFT JOIN AT20072 AT2007 WITH (NOLOCK) ON AT2007.DivisionID = AT0113.DivisionID AND AT2007.InheritVoucherID = AT0113.VoucherID AND AT2007.InheritTransactionID = AT0113.TransactionID
	WHERE AT2007.KindVoucherID = 2
		AND AT2007.InheritTableID = ''AT0112''
		AND AT2007.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+'''
		AND AT0112.[Type] = 0
		--AND AT0113.InventoryID between ''' + @FromInventoryID + ''' and ''' + @ToInventoryID + '''
				
-------------- Update về phiếu lắp ráp phần nhập kho	
	UPDATE 	AT0113
	SET OriginalAmount = Isnull(A.OrginalAmount,0),
		ConvertedAmount = Isnull(A.ConvertedAmount,0),
		UnitPrice = CASE WHEN Isnull(ActualQuantity,0) = 0 THEN 0 ELSE ROUND(Isnull(A.OrginalAmount,0)/Isnull(ActualQuantity,0), '+str(@UnitCostDecimals)+') END,
		ConvertedPrice = CASE WHEN Isnull(ActualQuantity,0) = 0 THEN 0 ELSE ROUND(Isnull(A.ConvertedAmount,0)/Isnull(ActualQuantity,0), '+str(@UnitCostDecimals)+') END
	FROM AT0113 WITH (ROWLOCK) 
	INNER JOIN AT0112 WITH (NOLOCK)  ON AT0112.DivisionID = AT0113.DivisionID AND AT0112.VoucherID = AT0113.VoucherID
	INNER JOIN (
	SELECT DivisionID, VoucherID, KindVoucherID, SUM(OriginalAmount) AS OrginalAmount, SUM(AT0113.ConvertedAmount) AS ConvertedAmount
	FROM AT0113 WITH (NOLOCK) 
	WHERE AT0113.KindVoucherID = 2 AND AT0113.DivisionID = ''' + @DivisionID + '''
	GROUP BY DivisionID, KindVoucherID, VoucherID) A ON A.DivisionID = AT0113.DivisionID AND A.VoucherID = AT0113.VoucherID
	WHERE AT0113.KindVoucherID = 1
		AND AT0112.TranMonth = ' + str(@TranMonth) + '
		AND AT0112.TranYear = ' + str(@TranYear) + '
		AND AT0112.DivisionID = ''' + @DivisionID + '''
		AND AT0112.[Type] = 0
'
SET @sSQL1 = '		
-------------- Update về phiếu tháo dở phần nhập kho	
	UPDATE 	AT0113 
	SET OriginalAmount = ROUND(ISNULL(ROUND(AV1309.UnitPrice, '+str(@UnitCostDecimals)+'),0) * AT0113.ActualQuantity,'+STR(@ConvertedDecimals)+'),
		ConvertedAmount = ROUND(ISNULL(ROUND(AV1309.UnitPrice, '+str(@UnitCostDecimals)+'),0) * AT0113.ActualQuantity,'+STR(@ConvertedDecimals)+'),
		UnitPrice = ROUND(ISNULL(AV1309.UnitPrice,0), '+str(@UnitCostDecimals)+'),
		ConvertedPrice = ROUND(ISNULL(AV1309.UnitPrice,0), '+str(@UnitCostDecimals)+')
	FROM AT0113 WITH (ROWLOCK) 
	INNER JOIN AT0112 WITH (NOLOCK)  ON AT0112.DivisionID = AT0113.DivisionID AND AT0112.VoucherID = AT0113.VoucherID
	INNER JOIN AV1309 AV1309 WITH (NOLOCK) ON AT0113.DivisionID = AV1309.DivisionID AND AT0113.InventoryID = AV1309.InventoryID 
				and AT0113.DebitAccountID = AV1309.InventoryAccountID AND AT0113.ImWareHouseID = AV1309.WareHouseID
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
	INNER JOIN AT0112 WITH (NOLOCK)  ON AT0112.DivisionID = AT0113.DivisionID AND AT0112.VoucherID = AT0113.VoucherID
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
-------------- Update về phần nhập kho ở kho (phiếu lắp ráp, tháo dỡ bắn qua)
SET @sSQL2 = '
----------------- Update về AT2007 cho phần nhập kho lắp ráp
	UPDATE AT2007
	SET ConvertedAmount = Isnull(AT0113.ConvertedAmount,0),
	OriginalAmount = Isnull(AT0113.OriginalAmount,0),
	UnitPrice = CASE WHEN ISNULL(AT2007.ActualQuantity,0) = 0 THEN 0 ELSE ROUND(Isnull(AT0113.OriginalAmount,0)/ISNULL(AT2007.ActualQuantity,0), '+str(@UnitCostDecimals)+') END,
	ConvertedPrice = CASE WHEN ISNULL(AT2007.ActualQuantity,0) = 0 THEN 0 ELSE ROUND(Isnull(AT0113.ConvertedAmount,0)/ISNULL(AT2007.ActualQuantity,0), '+str(@UnitCostDecimals)+') END
	FROM AT20072 AT2007 WITH (ROWLOCK)
	LEFT JOIN AT0113 WITH (NOLOCK)  ON AT2007.DivisionID = AT0113.DivisionID AND AT2007.InheritVoucherID = AT0113.VoucherID AND AT2007.InheritTransactionID = AT0113.TransactionID
	LEFT JOIN AT0112 WITH (NOLOCK)  ON AT0112.DivisionID = AT0113.DivisionID AND AT0112.VoucherID = AT0113.VoucherID
	LEFT JOIN AT0113 A13 WITH (NOLOCK) ON A13.DivisionID = AT0112.DivisionID AND A13.VoucherID = AT0112.VoucherID AND A13.TranMonth = AT0112.TranMonth AND A13.TranYear = AT0112.TranYear AND A13.KindVoucherID = 2
	WHERE AT0113.KindVoucherID = 1
		AND A13.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+'''
		AND AT0112.TranMonth = ' + str(@TranMonth) + '
		AND AT0112.TranYear = ' + str(@TranYear) + '
		AND AT0112.DivisionID = ''' + @DivisionID + '''
		AND AT0112.[Type] = 0

-------------- Update giá cho các phiếu nhập hàng trả về
	UPDATE AT2007 
	SET UnitPrice = ROUND(AV1309.UnitPrice, '+str(@UnitCostDecimals)+'),
		ConvertedPrice =  ROUND(AV1309.UnitPrice, '+str(@UnitCostDecimals)+'),
		OriginalAmount = ROUND(ROUND(AV1309.UnitPrice, '+str(@UnitCostDecimals)+') * ROUND(AT2007.ActualQuantity, '+Str(@QuantityDecimals) +'), '+Str(@ConvertedDecimals) +'), 
		ConvertedAmount = ROUND(ROUND(AV1309.UnitPrice, '+str(@UnitCostDecimals)+') * ROUND(AT2007.ActualQuantity, '+Str(@QuantityDecimals) +'), '+Str(@ConvertedDecimals) +') 
	FROM AT20072 AT2007 WITH (ROWLOCK)
	INNER JOIN AV1309 ON AV1309.DivisionID = AT2007.DivisionID AND AT2007.WareHouseID = AV1309.WareHouseID AND AT2007.InventoryID = AV1309.InventoryID
							AND AV1309.InventoryAccountID  = AT2007.DebitAccountID
	WHERE ((Isnull(IsReturn,0) = 1 AND KindVoucherID = 1) OR KindVoucherID IN (7)) 
		AND ISNULL(AT2007.IsNotUpdatePrice,0) = 0
		AND AT2007.InventoryID between ''' + @FromInventoryID + ''' and ''' + @ToInventoryID + '''
'

SET @sSQL3 = '		
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
	LEFT JOIN AT0113 WITH (NOLOCK) ON AT2007.DivisionID = AT0113.DivisionID AND AT2007.InheritVoucherID = AT0113.VoucherID AND AT2007.InheritTransactionID = AT0113.TransactionID
	LEFT JOIN AT0112 WITH (NOLOCK) ON AT0112.DivisionID = AT0113.DivisionID AND AT0112.VoucherID = AT0113.VoucherID
	LEFT JOIN AT0113 A13 WITH (NOLOCK) ON A13.DivisionID = AT0112.DivisionID AND A13.VoucherID = AT0112.VoucherID AND A13.TranMonth = AT0112.TranMonth AND A13.TranYear = AT0112.TranYear AND A13.KindVoucherID = 1
	WHERE AT0113.KindVoucherID = 2
		AND A13.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+'''
		AND AT0112.TranMonth = ' + str(@TranMonth) + '
		AND AT0112.TranYear = ' + str(@TranYear) + '
		AND AT0112.DivisionID = ''' + @DivisionID + '''
		AND AT0112.[Type] = 1
'

EXEC (@sSQL + @sSQL1 + @sSQL2 + @sSQL3)

--DECLARE 
--    @InventoryID AS NVARCHAR(50), 
--    @AccountID AS NVARCHAR(50), 
--    @Amount AS DECIMAL(28, 8), 
--    @WareHouseID AS NVARCHAR(50), 
--    @TransactionID AS NVARCHAR(50), 
--    @Cur_Ware AS CURSOR, 
--    @CountUpdate INT,
--    @TableID NVARCHAR(50),
--    @InheritTransactionID NVARCHAR(50),
--    @InheritVoucherID NVARCHAR(50),
--    @InheritImTransactionID NVARCHAR(50)


------- XU LY LAM TRON
--Recal:

--SELECT @CountUpdate AS CountUpdate ,  WareHouseID, 
--        AT2008.InventoryID, 
--        InventoryAccountID, 
--        EndAmount
--    FROM AT2008 WITH (NOLOCK)
--    WHERE TranMonth = @TranMonth 
--        AND TranYear = @TranYear 
--        AND EndQuantity = 0 
--        AND EndAmount <> 0 
--        AND AT2008.DivisionID = @DivisionID 
--        --AND (AT2008.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID)

--SET @CountUpdate = 0      
--SET @Cur_Ware = CURSOR SCROLL KEYSET FOR 
--    SELECT WareHouseID, 
--        AT2008.InventoryID, 
--        InventoryAccountID, 
--        EndAmount
--    FROM AT2008 WITH (NOLOCK)
--    WHERE TranMonth = @TranMonth 
--        AND TranYear = @TranYear 
--        AND EndQuantity = 0 
--        AND EndAmount <> 0 
--        AND AT2008.DivisionID = @DivisionID 
--        AND (AT2008.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID)
        
--OPEN @Cur_Ware
--FETCH NEXT FROM @Cur_Ware INTO  @WareHouseID, @InventoryID, @AccountID, @Amount

--WHILE @@Fetch_Status = 0 
--    BEGIN
--        SET @TransactionID = 
--	(
--		SELECT TOP 1 TransactionID
--		FROM AT2007 WITH (NOLOCK)
--		INNER JOIN (SELECT TOP 1 VoucherID FROM ( SELECT D11.VoucherID, SUM(D11.ConvertedAmount) AS ConvertedAmount
--						FROM AT2007 D11 WITH (NOLOCK)
--							LEFT JOIN AT2007 D12 WITH (NOLOCK) ON D12.TransactionID = D11.ReTransactionID
--							INNER JOIN AT2006 D9 WITH (NOLOCK) ON D9.DivisionID = D11.DivisionID AND D9.VoucherID = D11.VoucherID
--						WHERE D11.InventoryID = @InventoryID 
--							AND D11.TranMonth = @TranMonth
--							AND D11.TranYear = @TranYear
--							AND D11.DivisionID = @DivisionID
--							AND (CASE WHEN D9.KindVoucherID = 3 THEN D9.WareHouseID2 ELSE D9.WareHouseID END) = @WareHouseID
--							AND D9.KindVoucherID IN (2, 3, 4, 6, 8,7) 
--							AND D11.CreditAccountID = @AccountID
--						GROUP BY D11.VoucherID) A ORDER BY A.ConvertedAmount DESC ) B ON B.VoucherID = AT2007.VoucherID
--		WHERE AT2007.InventoryID = @InventoryID AND AT2007.CreditAccountID = @AccountID     
--	)
		
--		IF @TransactionID IS NOT NULL
--			BEGIN
--				UPDATE AT2007
--				SET ConvertedAmount = ISNULL(ConvertedAmount, 0) + @Amount, 
--					OriginalAmount = ISNULL(OriginalAmount, 0) + @Amount
--				FROM AT2007 WITH (ROWLOCK) 
--				WHERE AT2007.DivisionID = @DivisionID and AT2007.TransactionID = @TransactionID
--				SET @CountUpdate = @CountUpdate + 1
				
--				SELECT @TableID = TableID FROM AT2006 A06 WITH (NOLOCK)
--				LEFT JOIN AT2007 A07 WITH (NOLOCK) ON A07.DivisionID = A06.DivisionID AND A07.VoucherID = A06.VoucherID
--				WHERE A06.DivisionID = @DivisionID AND A07.TransactionID = @TransactionID
				
--				IF ISNULL(@TableID,'') = 'AT0112'
--				BEGIN
--					SELECT @InheritTransactionID = A07.InheritTransactionID,  @InheritVoucherID = A07.InheritVoucherID
--					FROM AT2007 A07 WITH (NOLOCK) WHERE A07.TransactionID = @TransactionID AND A07.DivisionID = @DivisionID
					
--					-------------- Update về phiếu lắp ráp, tháo dỡ phần xuất kho
--					UPDATE AT0113
--					SET OriginalAmount = ISNULL(OriginalAmount, 0) + @Amount,
--						ConvertedAmount = ConvertedAmount + @Amount
--					FROM AT0113 WITH (ROWLOCK) 
--					WHERE TransactionID = @InheritTransactionID
--						AND VoucherID = @InheritVoucherID
			
	
--				-------------- Update về phiếu lắp ráp, tháo dỡ phần nhập kho
--					SELECT TOP 1 @InheritImTransactionID  = TransactionID
--					FROM AT0113 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND VoucherID = @InheritVoucherID AND KindVoucherID = 1
				
--					UPDATE 	AT0113 
--					SET OriginalAmount = Isnull(OriginalAmount,0) + @Amount,
--						ConvertedAmount = Isnull(ConvertedAmount,0) + @Amount
--					FROM AT0113 WITH (ROWLOCK) 
--					WHERE AT0113.KindVoucherID = 1
--						AND VoucherID = @InheritVoucherID
--						AND TransactionID = @InheritImTransactionID
				
--				-------------- Update về phần nhập kho ở kho (phiếu lắp ráp, tháo dỡ bắn qua)
--					UPDATE AT2007
--					SET ConvertedAmount = Isnull(ConvertedAmount,0) + @Amount,
--						OriginalAmount = Isnull(OriginalAmount,0) + @Amount
--					FROM AT2007 WITH (ROWLOCK) 
--					WHERE AT2007.DivisionID = @DivisionID 
--						AND InheritVoucherID = @InheritVoucherID 
--						AND InheritTransactionID = @InheritImTransactionID 
--						AND InheritTableID = 'AT0112'
					
--				END
--				SET @CountUpdate = @CountUpdate + 1
				
--			END
--        FETCH NEXT FROM @Cur_Ware INTO @WareHouseID, @InventoryID, @AccountID, @Amount
--    END 

--CLOSE @Cur_Ware

--SELECT N'làm tròn' AS [TEXT], * 
--    FROM AT2008  WITH (NOLOCK)
--    WHERE TranMonth = @TranMonth 
--        AND TranYear = @TranYear 
--        AND EndQuantity = 0 
--        AND EndAmount <> 0 
--        AND DivisionID = @DivisionID

--IF EXISTS 
--(
--    SELECT TOP 1 1 
--    FROM AT2008  WITH (NOLOCK)
--    WHERE TranMonth = @TranMonth 
--        AND TranYear = @TranYear 
--        AND EndQuantity = 0 
--        AND EndAmount <> 0 
--        AND DivisionID = @DivisionID
--		AND (InventoryID BETWEEN @FromInventoryID AND @ToInventoryID)
--) 
--    AND @CountUpdate > 0
    
--	GOTO ReCal














GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
