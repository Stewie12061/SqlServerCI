IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1309_AG_ALL]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1309_AG_ALL]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--------- Created by Huỳnh Thử on 05/05/2020: Tách riêng store cho Angel, Tính giá all kho
--------- Modified by Văn Tài	on 18/07/2022: Điều chỉnh quy tắc đặt tên. Dùng tên bảng theo quy định để xử lý kế thừa dữ liệu ở các store.

CREATE PROCEDURE [dbo].[AP1309_AG_ALL] 
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
    
DECLARE 
    @InventoryID AS NVARCHAR(50), 
    @AccountID AS NVARCHAR(50), 
    @Amount AS DECIMAL(28, 8), 
    @WareHouseID AS NVARCHAR(50), 
    @TransactionID AS NVARCHAR(50), 
    @Cur_Ware AS CURSOR

SELECT @QuantityDecimals = QuantityDecimals, 
    @UnitCostDecimals = UnitCostDecimals, 
    @ConvertedDecimals = ConvertedDecimals
FROM AT1101 WITH (NOLOCK)
WHERE DivisionID =@DivisionID

SET @QuantityDecimals = ISNULL(@QuantityDecimals, 2)
SET @UnitCostDecimals = ISNULL(@UnitCostDecimals, 2)
SET @ConvertedDecimals = ISNULL(@ConvertedDecimals, 2)

IF EXISTS (Select * From sysobjects Where name = 'AT1334' and xtype ='U')
BEGIN
	DELETE FROM AT1334
END
ELSE 
	CREATE TABLE AT1334 (InventoryID NVARCHAR(50), [Type] INT)
	
--- Insert dữ liệu vào các table dùng để tính giá
DELETE AT20072

INSERT INTO AT20072 (DivisionID,TransactionID,VoucherID,KindVoucherID,WarehouseID,WarehouseID2,InventoryID,UnitID,ActualQuantity,
					UnitPrice, ConvertedPrice,OriginalAmount,ConvertedAmount,TranMonth,TranYear,TableID,DebitAccountID,CreditAccountID,ReTransactionID,
					InheritVoucherID, InheritTransactionID, InheritTableID, IsNotUpdatePrice, IsReturn)
SELECT	T07.DivisionID,TransactionID,T07.VoucherID,KindVoucherID,WarehouseID,WarehouseID2,InventoryID,UnitID,ActualQuantity,
		UnitPrice, ConvertedPrice,OriginalAmount,ConvertedAmount,T07.TranMonth,T07.TranYear,TableID,DebitAccountID,CreditAccountID,ReTransactionID,
		T07.InheritVoucherID, T07.InheritTransactionID, T07.InheritTableID, T06.IsNotUpdatePrice, T06.IsReturn
FROM AT2007 T07 WITH (NOLOCK)
INNER JOIN AT2006 T06 WITH (NOLOCK) ON T07.DivisionID = T06.DivisionID AND T07.VoucherID = T06.VoucherID
WHERE T07.DivisionID = @DivisionID AND T07.TranMonth = @TranMonth AND T07.TranYear = @TranYear
AND T07.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID

DELETE AT20082
-- Tạo bảng chứa những mặt hàng không tham gia tính giá

SELECT InventoryID,WareHouseID,DebitAccountID, SUM(ActualQuantity) AS ActualQuantity , SUM(ConvertedAmount) AS ConvertedAmount INTO #TamNotJoinPrice  FROM AT2007 WITH(NOLOCK)
LEFT JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID
WHERE AT2006.DivisionID = @DivisionID AND ISNULL(IsNotJoinPrice,0) = 1 AND AT2006.TranMonth = @TranMonth AND AT2006.TranYear = @TranYear
GROUP BY InventoryID,WareHouseID,DebitAccountID

INSERT INTO AT20082 (DivisionID,WareHouseID,TranMonth,TranYear,InventoryID,InventoryAccountID,BeginQuantity,EndQuantity,DebitQuantity,QuantityNotJoinPrice, CreditQuantity,
					InDebitQuantity,InCreditQuantity,BeginAmount,EndAmount,DebitAmount,AmountNotJoinPrice, CreditAmount,InDebitAmount,InCreditAmount,UnitPrice)
SELECT	DivisionID,AT2008.WareHouseID,TranMonth,TranYear,AT2008.InventoryID,InventoryAccountID,BeginQuantity,EndQuantity,DebitQuantity, ISNULL(#TamNotJoinPrice.ActualQuantity,0),CreditQuantity,
		InDebitQuantity,InCreditQuantity,BeginAmount,EndAmount,DebitAmount, ISNULL(#TamNotJoinPrice.ConvertedAmount,0),CreditAmount,InDebitAmount,InCreditAmount,UnitPrice
FROM AT2008 WITH (NOLOCK)
LEFT JOIN #TamNotJoinPrice ON #TamNotJoinPrice.InventoryID = AT2008.InventoryID AND #TamNotJoinPrice.DebitAccountID = AT2008.InventoryAccountID AND #TamNotJoinPrice.WareHouseID = AT2008.WareHouseID
WHERE DivisionID = @DivisionID AND TranMonth = @TranMonth AND TranYear = @TranYear
AND AT2008.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID
AND InventoryAccountID BETWEEN @FromAccountID AND @ToAccountID

INSERT INTO AT1334
SELECT DISTINCT AT2007.InventoryID, 0 AS [Type] 
FROM AT20072 AT2007 WITH (NOLOCK)
LEFT JOIN AT0113 WITH (NOLOCK) ON AT2007.InheritVoucherID = AT0113.VoucherID AND AT2007.InheritTransactionID = AT0113.TransactionID
LEFT JOIN AT0112 WITH (NOLOCK) ON AT0112.DivisionID = AT0113.DivisionID AND AT0112.VoucherID = AT0113.VoucherID
WHERE AT2007.TableID = 'AT0112' AND AT2007.KindVoucherID = 2 AND [Type] = 0
	AND AT2007.InventoryID NOT IN (SELECT AT2007.InventoryID FROM AT20072 AT2007 WITH (NOLOCK)
									LEFT JOIN AT0113 WITH (NOLOCK) ON AT2007.InheritVoucherID = AT0113.VoucherID AND AT2007.InheritTransactionID = AT0113.TransactionID
									LEFT JOIN AT0112 WITH (NOLOCK) ON AT0112.DivisionID = AT0113.DivisionID AND AT0112.VoucherID = AT0113.VoucherID
									WHERE AT2007.TableID = 'AT0112' AND AT2007.KindVoucherID = 1 AND [Type] = 0)
UNION ALL 
SELECT DISTINCT AT2007.InventoryID, 1 AS [Type]
FROM AT20072 AT2007 WITH (NOLOCK)
LEFT JOIN AT0113 WITH (NOLOCK) ON AT2007.InheritVoucherID = AT0113.VoucherID AND AT2007.InheritTransactionID = AT0113.TransactionID
LEFT JOIN AT0112 WITH (NOLOCK) ON AT0112.DivisionID = AT0113.DivisionID AND AT0112.VoucherID = AT0113.VoucherID
WHERE AT2007.TableID = 'AT0112' AND AT2007.KindVoucherID = 2 AND [Type] = 0
	AND AT2007.InventoryID IN (SELECT AT2007.InventoryID FROM AT20072 AT2007 WITH (NOLOCK)
								LEFT JOIN AT0113 WITH (NOLOCK) ON AT2007.InheritVoucherID = AT0113.VoucherID AND AT2007.InheritTransactionID = AT0113.TransactionID
								LEFT JOIN AT0112 WITH (NOLOCK) ON AT0112.DivisionID = AT0113.DivisionID AND AT0112.VoucherID = AT0113.VoucherID
								WHERE AT2007.TableID = 'AT0112' AND AT2007.KindVoucherID = 1 AND [Type] = 0)
UNION ALL 
SELECT DISTINCT AT2007.InventoryID, 2 AS [Type]
FROM AT20072 AT2007 WITH (NOLOCK)
LEFT JOIN AT0113 WITH (NOLOCK) ON AT2007.InheritVoucherID = AT0113.VoucherID AND AT2007.InheritTransactionID = AT0113.TransactionID
LEFT JOIN AT0112 WITH (NOLOCK) ON AT0112.DivisionID = AT0113.DivisionID AND AT0112.VoucherID = AT0113.VoucherID
WHERE AT2007.TableID = 'AT0112' AND AT2007.KindVoucherID = 1 AND [Type] = 0
	AND AT2007.InventoryID NOT IN (SELECT AT2007.InventoryID FROM AT20072 AT2007 WITH (NOLOCK)
							LEFT JOIN AT0113 WITH (NOLOCK) ON AT2007.InheritVoucherID = AT0113.VoucherID AND AT2007.InheritTransactionID = AT0113.TransactionID
							LEFT JOIN AT0112 WITH (NOLOCK) ON AT0112.DivisionID = AT0113.DivisionID AND AT0112.VoucherID = AT0113.VoucherID
							WHERE AT2007.TableID = 'AT0112' AND AT2007.KindVoucherID = 2 AND [Type] = 0)

IF EXISTS (SELECT 1 FROM AT1334 WITH (NOLOCK))
BEGIN	
	UPDATE AT0113 
	SET ConvertedAmount = 0,
	OriginalAmount = 0,
	UnitPrice = 0,
	ConvertedPrice = 0
	FROM AT0113 WITH (ROWLOCK) 
	LEFT JOIN AT0112 WITH (NOLOCK) ON AT0112.DivisionID = AT0113.DivisionID AND AT0112.VoucherID = AT0113.VoucherID
	WHERE AT0113.KindVoucherID = 1 AND ISNULL(AT0113.IsNotUpdatePrice,0) = 0 AND AT0112.TableID = 'AT0112'
		--AND AT0112.TranMonth = @TranMonth
		--AND AT0112.TranYear = @TranYear
		--AND AT0112.DivisionID = @DivisionID
	
	UPDATE AT2007
	SET ConvertedAmount = 0,
	OriginalAmount = 0,
	UnitPrice = 0,
	ConvertedPrice = 0
	FROM AT20072 AT2007 WITH (ROWLOCK)
	WHERE AT2007.KindVoucherID = 1 AND ISNULL(AT2007.IsNotUpdatePrice,0) = 0 AND AT2007.TableID = 'AT0112'

	UPDATE AT2007
	SET UnitPrice = 0,
		ConvertedPrice = 0, 
		OriginalAmount = 0, 
		ConvertedAmount = 0
	FROM AT20072 AT2007 WITH (ROWLOCK)
	WHERE --AT2007.DebitAccountID BETWEEN @FromAccountID AND @ToAccountID
		 (Select MethodID From AT1302 WITH (NOLOCK) Where DivisionID = AT2007.DivisionID And InventoryID = AT2007.InventoryID) IN (4, 5)
		AND ((AT2007.KindVoucherID IN (1, 3) AND ISNULL(IsReturn,0) = 1) OR AT2007.KindVoucherID IN (7))
		AND ISNULL(AT2007.IsNotUpdatePrice,0) = 0
		
	----------- Bổ sung Customize cho ANGEL, tính giá cho phiếu lắp ráp, tháo dỡ trước
	SET @Cur_Ware = CURSOR SCROLL KEYSET FOR 
		SELECT A.InventoryID
		FROM AT1334 A
		LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = A.InventoryID
		ORDER BY A.[Type], ISNULL(AT1302.AssemblyRank,0)
	OPEN @Cur_Ware
	FETCH NEXT FROM @Cur_Ware INTO  @InventoryID
	WHILE @@Fetch_Status = 0 
		BEGIN
			EXEC AP1309_AG1_All @DivisionID,@TranMonth, @TranYear, @InventoryID, @InventoryID, @FromAccountID, @ToAccountID, @UserID, @GroupID
			FETCH NEXT FROM @Cur_Ware INTO  @InventoryID
		END
	CLOSE @Cur_Ware
END 
		
EXEC AP1309_AG2_All @DivisionID,@TranMonth, @TranYear, @FromInventoryID, @ToInventoryID, @FromAccountID, @ToAccountID, @UserID, @GroupID		

-- XU LY LAM TRON
EXEC AP1309_AG3 @DivisionID, @TranMonth, @TranYear, @FromInventoryID, @ToInventoryID

----- CẬP NHẬT KẾT QUẢ TÍNH GIÁ VÀO AT2007
UPDATE AT2007
SET AT2007.UnitPrice = AT20072.UnitPrice,
	AT2007.ConvertedPrice = AT20072.ConvertedPrice,
	AT2007.OriginalAmount = AT20072.OriginalAmount,
	AT2007.ConvertedAmount = AT20072.ConvertedAmount
FROM AT2007
INNER JOIN AT20072 ON AT20072.TransactionID = AT2007.TransactionID
AND AT20072.KindVoucherID in (1,2,3,4,6,7,8)


UPDATE 	AT0113
	SET OriginalAmount = Isnull(A.OrginalAmount,0),
		ConvertedAmount = Isnull(A.ConvertedAmount,0),
		UnitPrice = CASE WHEN Isnull(ActualQuantity,0) = 0 THEN 0 ELSE Isnull(A.OrginalAmount,0)/Isnull(ActualQuantity,0) END,
		ConvertedPrice = CASE WHEN Isnull(ActualQuantity,0) = 0 THEN 0 ELSE Isnull(A.ConvertedAmount,0)/Isnull(ActualQuantity,0) END
	FROM AT0113 WITH (ROWLOCK) 
	INNER JOIN AT0112 WITH (NOLOCK)  ON AT0112.DivisionID = AT0113.DivisionID AND AT0112.VoucherID = AT0113.VoucherID
	INNER JOIN (
	SELECT DivisionID, VoucherID, KindVoucherID, SUM(OriginalAmount) AS OrginalAmount, SUM(AT0113.ConvertedAmount) AS ConvertedAmount
	FROM AT0113 WITH (NOLOCK) 
	WHERE AT0113.KindVoucherID = 2 AND AT0113.DivisionID = @DivisionID
	GROUP BY DivisionID, KindVoucherID, VoucherID) A ON A.DivisionID = AT0113.DivisionID AND A.VoucherID = AT0113.VoucherID
	WHERE AT0113.KindVoucherID = 1
		AND AT0112.TranMonth = @TranMonth
		AND AT0112.TranYear = @TranYear
		AND AT0112.DivisionID = @DivisionID
		AND AT0112.[Type] = 0

-- Sum và đưa vào bảng tạm
SELECT SUM(ConvertedAmount) AS ConvertedAmount,  SUM(OriginalAmount) AS OriginalAmount, AT2007.BatchID, WareHouseID  INTO #TAM
FROM AT2007 WITH (NoLOCK)
LEFT JOIN AT2006 WITH (NoLOCK) on AT2006.VoucherID = AT2007.VoucherID								
where  AT2007.TranMonth = @TranMonth 
And AT2007.TranYear= @TranYear 
AND AT2006.KindVoucherID = 2  
and AT2006.TableID = 'AT0112' 
AND (AT2007.InventoryID BETWEEN  @FromInventoryID AND @ToInventoryID)
AND AT2006.VoucherTypeID like 'LR%' 
GROUP BY AT2007.BatchID,WareHouseID


-- Đưa vào bảng tạm phiếu lắp ráp có độ chênh lệnh theo BatchID
SELECT SUM(A.ConvertedAmount) AS ConvertedAmount,  SUM(A.OriginalAmount) AS OriginalAmount,A.BatchID  INTO #TAM2 FROM(
SELECT SUM(ConvertedAmount) AS ConvertedAmount,  SUM(OriginalAmount) AS OriginalAmount,AT2007.BatchID FROM AT2007 WITH(NOLOCK) 
LEFT JOIN AT2006 ON AT2006.VoucherID = AT2007.VoucherID 
WHERE   KindVoucherID = 1 
AND AT2006.TranMonth = @TranMonth 
AND AT2006.TranYear = @TranYear
AND (AT2007.InventoryID BETWEEN  @FromInventoryID AND @ToInventoryID)
and AT2006.TableID = 'AT0112' 
AND AT2006.VoucherTypeID like 'LR%' 
AND ActualQuantity > 0 AND UnitPrice > 0
GROUP BY AT2007.BatchID
UNION ALL
SELECT -#TAM.ConvertedAmount, 
 -#TAM.OriginalAmount,#TAM.BatchID
FROM AT2007  WITH (ROWLOCK)
LEFT JOIN AT2006  WITH (ROWLOCK) on AT2006.VoucherID = AT2007.VoucherID
LEFT JOIN #TAM WITH (ROWLOCK) on #TAM.BatchID = AT2007.BatchID
AND ActualQuantity > 0 AND UnitPrice > 0
where AT2006.KindVoucherID = 1 and AT2007.BatchID IN ( select BatchID from #TAM) 
AND AT2006.VoucherTypeID like 'LR%' ) A
GROUP	BY A.BatchID

-- Update phiếu nhập lắp ráp
update AT2007 SET ConvertedAmount =  AT2007.ConvertedAmount - #TAM2.ConvertedAmount, 
OriginalAmount = AT2007.OriginalAmount - #TAM2.OriginalAmount
FROM AT2007  WITH (ROWLOCK)
LEFT JOIN AT2006  WITH (ROWLOCK) on AT2006.VoucherID = AT2007.VoucherID
LEFT JOIN #TAM2 WITH (ROWLOCK) on #TAM2.BatchID = AT2007.BatchID
where AT2006.KindVoucherID = 1 and AT2007.BatchID IN ( select BatchID from #TAM2)  
AND AT2006.VoucherTypeID like 'LR%'  AND #TAM2.ConvertedAmount <> 0 AND #TAM2.OriginalAmount <> 0

-- lấy được mặt hàng lệch của phiếu nhật lắp ráp
SELECT InventoryID, #TAM2.ConvertedAmount,#TAM2.OriginalAmount,WareHouseID INTO #TAM3 FROM AT2007 WITH	(NOLOCK)
LEFT JOIN AT2006 ON AT2006.VoucherID = AT2007.VoucherID
AND (AT2007.InventoryID BETWEEN  @FromInventoryID AND @ToInventoryID)
LEFT JOIN #TAM2 ON #TAM2.BatchID = AT2006.BatchID 
WHERE KindVoucherID = 1   and AT2006.BatchID IN ( select BatchID from #TAM2 WHERE ISNULL(#TAM2.BatchID,'') <> '') 
AND #TAM2.ConvertedAmount <> 0 AND #TAM2.OriginalAmount <> 0 

DECLARE 
			@InventoryID1 AS NVARCHAR(50), 
			@ConvertedAmount AS NVARCHAR(50), 
			@OriginalAmount AS DECIMAL(28, 8), 
			@WareHouseID1 AS NVARCHAR(50), 
			@TransactionID1  AS NVARCHAR(50),
			@Cur_Ware1 AS CURSOR
SET @Cur_Ware1 = CURSOR SCROLL KEYSET FOR 
SELECT InventoryID,ConvertedAmount,OriginalAmount,WareHouseID FROM #TAM3
OPEN @Cur_Ware1
		FETCH NEXT FROM @Cur_Ware1 INTO  @InventoryID1, @ConvertedAmount, @OriginalAmount, @WareHouseID1
		WHILE @@Fetch_Status = 0 
		BEGIN
			SET @TransactionID1 = 
					(
						SELECT TOP 1 D11.TransactionID
						FROM AT2007 D11 WITH (NOLOCK)
							LEFT JOIN AT2007 D12 WITH (NOLOCK) ON D12.TransactionID = D11.ReTransactionID
							INNER JOIN AT2006 D9 WITH (NOLOCK) ON D9.DivisionID = D11.DivisionID AND D9.VoucherID = D11.VoucherID
						WHERE D11.DivisionID = @DivisionID
							AND D11.TranYear = @TranYear
							AND D11.TranMonth = @TranMonth
							AND D11.InventoryID = @InventoryID1
							AND (CASE WHEN D9.KindVoucherID = 3 THEN D9.WareHouseID2 ELSE D9.WareHouseID END) = @WareHouseID1
							AND D9.KindVoucherID IN (2, 3, 4, 6, 8,7)---,1) 	
							AND D9.TableID ='AT2006'
						ORDER BY CASE WHEN D9.KindVoucherID = 3 THEN 1 ELSE 0 END, 
							ISNULL((SELECT TOP 1 1 FROM AT2007 WITH (NOLOCK) INNER JOIN AT2006 WITH (NOLOCK) ON AT2007.DivisionID = AT2006.DivisionID AND AT2007.VoucherID = AT2006.VoucherID
								WHERE AT2007.DivisionID = @DivisionID AND AT2007.TranMonth = 12 AND AT2007.TranYear = 2019
								AND AT2007.InventoryID = @InventoryID1  AND AT2006.KindVoucherID = 3 AND AT2006.WareHouseID2 = D9.WareHouseID),0), 
							CASE WHEN D11.ActualQuantity = D12.ActualQuantity AND D11.ConvertedAmount < D12.ConvertedAmount THEN 0 ELSE 1 END, D11.ConvertedAmount DESC
					)		
					IF @TransactionID1 IS NOT NULL
						BEGIN
							UPDATE AT2007
							SET ConvertedAmount = ISNULL(ConvertedAmount, 0) - @ConvertedAmount, 
								OriginalAmount = ISNULL(OriginalAmount, 0) - @OriginalAmount
							FROM AT2007 WITH (ROWLOCK) 
							WHERE AT2007.DivisionID = @DivisionID and AT2007.TransactionID = @TransactionID1
						END
		FETCH NEXT FROM @Cur_Ware1 INTO @InventoryID1, @ConvertedAmount, @OriginalAmount, @WareHouseID1
		END

----- CẬP NHẬT AT9000
UPDATE AT9000
SET OriginalAmount = A.Amount,
	ConvertedAmount = A.Amount
FROM AT9000 WITH (ROWLOCK) 
LEFT JOIN (
	SELECT AT0112.VoucherID, AT0113.DebitAccountID, AT0113.CreditAccountID, SUM(ISNULL(AT0113.ConvertedAmount,0)) AS Amount
	  FROM AT0113 WITH (NOLOCK)
	LEFT JOIN AT0112 WITH (NOLOCK) ON AT0112.DivisionID = AT0113.DivisionID AND AT0112.VoucherID = AT0113.VoucherID
	WHERE ISNULL(IsLedger,0) = 0 AND AT0112.TranMonth = @TranMonth AND AT0112.TranYear = @TranYear
	AND ((KindVoucherID = 2 AND [Type] = 0) OR (KindVoucherID = 1 AND [Type] = 1))
	GROUP BY AT0112.VoucherID, AT0113.DebitAccountID, AT0113.CreditAccountID
) A ON A.VoucherID = AT9000.BatchID AND A.DebitAccountID = AT9000.DebitAccountID AND A.CreditAccountID = AT9000.CreditAccountID
WHERE AT9000.TableID = 'AT0112' AND TranMonth = @TranMonth AND TranYear = @TranYear


----- XU LY LAM TRON
		
		DECLARE 
			@Cur_Ware2 AS CURSOR, 
			@CountUpdate INT

		Recal: 
		
		SET @CountUpdate = 0
		SET @Cur_Ware2 = CURSOR SCROLL KEYSET FOR 
			SELECT WareHouseID, 
				AT2008.InventoryID, 
				--InventoryAccountID, 
				EndAmount
			FROM AT2008 WITH (NOLOCK) ---inner join AT1302 on AT2008.DivisionID = AT1302.DivisionID and AT2008.InventoryID = AT1302.InventoryID
			WHERE TranMonth = @TranMonth 
				AND TranYear = @TranYear 
				AND EndQuantity = 0 
				AND EndAmount <> 0 
				AND AT2008.DivisionID = @DivisionID 
				AND (AT2008.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID)
        
		OPEN @Cur_Ware2
		FETCH NEXT FROM @Cur_Ware2 INTO  @WareHouseID, @InventoryID, @Amount

		WHILE @@Fetch_Status = 0 
			BEGIN
				IF (@Amount < 0)
				BEGIN
					SET @TransactionID = 
					(
						SELECT TOP 1 D11.TransactionID
						FROM AT2007 D11 WITH (NOLOCK)
							LEFT JOIN AT2007 D12 WITH (NOLOCK) ON D12.TransactionID = D11.ReTransactionID
							INNER JOIN AT2006 D9 WITH (NOLOCK) ON D9.DivisionID = D11.DivisionID AND D9.VoucherID = D11.VoucherID
						WHERE D11.InventoryID = @InventoryID 
							AND D11.TranMonth = @TranMonth
							AND D11.TranYear = @TranYear
							AND D11.DivisionID = @DivisionID
							AND (CASE WHEN D9.KindVoucherID = 3 THEN D9.WareHouseID2 ELSE D9.WareHouseID END) = @WareHouseID 
							AND D9.KindVoucherID IN (2, 3, 4, 6, 8,7)---,1) 
							AND ISNULL(D9.IsNotUpdatePrice,0) = 0
							--AND D11.CreditAccountID = @AccountID
						ORDER BY D11.ConvertedAmount DESC
					)			
					
				END
				else
				BEgin
				SET @TransactionID = 
					(
						SELECT TOP 1 D11.TransactionID
						FROM AT2007 D11 WITH (NOLOCK)
							LEFT JOIN AT2007 D12 WITH (NOLOCK) ON D12.TransactionID = D11.ReTransactionID
							INNER JOIN AT2006 D9 WITH (NOLOCK) ON D9.DivisionID = D11.DivisionID AND D9.VoucherID = D11.VoucherID
						WHERE D11.InventoryID = @InventoryID 
							AND D11.TranMonth = @TranMonth
							AND D11.TranYear = @TranYear
							AND D11.DivisionID = @DivisionID
							AND (CASE WHEN D9.KindVoucherID = 3 THEN D9.WareHouseID2 ELSE D9.WareHouseID END) = @WareHouseID 
							AND D9.KindVoucherID IN (2, 3, 4, 6, 8,7)---,1) 
							AND ISNULL(D9.IsNotUpdatePrice,0) = 0
							--AND D11.CreditAccountID = @AccountID
						ORDER BY D11.ConvertedAmount
					)			
					
				end
				IF @TransactionID IS NOT NULL
						BEGIN
							UPDATE AT2007
							SET ConvertedAmount = ISNULL(ConvertedAmount, 0) + @Amount, 
								OriginalAmount = ISNULL(OriginalAmount, 0) + @Amount
							FROM AT2007 WITH (ROWLOCK) 
							WHERE AT2007.DivisionID = @DivisionID and AT2007.TransactionID = @TransactionID
							SET @CountUpdate = @CountUpdate + 1
						END
				FETCH NEXT FROM @Cur_Ware2 INTO @WareHouseID, @InventoryID, @Amount
			END 

		CLOSE @Cur_Ware2


		IF EXISTS 
		(
			SELECT TOP 1 1 
			FROM AT2008  WITH (NOLOCK)
			WHERE TranMonth = @TranMonth 
				AND TranYear = @TranYear 
				AND EndQuantity = 0 
				AND EndAmount <> 0 
				AND DivisionID = @DivisionID
				AND (InventoryID BETWEEN @FromInventoryID AND @ToInventoryID)
		) 
			AND @CountUpdate > 0
    
			GOTO ReCal






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO