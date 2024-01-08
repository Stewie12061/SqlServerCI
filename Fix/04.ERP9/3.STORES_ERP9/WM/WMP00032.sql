IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP00032]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP00032]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--------- Created by Hoài Bảo, Date 26/07/2022
--------- Purpose: Tính giá bình quân gia quyền cuối kỳ - Kế thừa từ store AP1309
--------- Modify on ... by ...
----------------------------------------------------------------------------------------------------------------------------------------------------------------
/** exec WMP00032 
	@DivisionID = N'NH'
	, @TranMonth = '3'
	, @TranYear = '2019'
	, @FromInventoryID = N'BS04K004'
	, @ToInventoryID = N'BS04K004'
	, @FromWareHouseID = N'DN010'
	, @ToWareHouseID = N'ZS003'
	, @FromAccountID = N'152'
	, @ToAccountID = N'158'
	, @UserID = N'ASOFTADMIN'
	, @GroupID = N'ADMIN'
**/
CREATE PROCEDURE [dbo].[WMP00032] 
    @DivisionID NVARCHAR(50), 
    @TranMonth NVARCHAR(50), 
    @TranYear NVARCHAR(50), 
    @FromInventoryID NVARCHAR(50), 
    @ToInventoryID NVARCHAR(50), 
    @WareHouseID NVARCHAR(MAX), 
    @UserID NVARCHAR(50),
    @GroupID NVARCHAR (50),
    @TransProcessesID NVARCHAR(50)=''
AS

DECLARE @CountTest INT = 0;
DECLARE @APK_AT2007 NVARCHAR(50) = NULL;
DECLARE @WareHouseIDNew NVARCHAR(MAX) = @WareHouseID

IF ISNULL(@WareHouseID, '') != ''
	SET @WareHouseID = '''' + @WareHouseID + ''''

--- Ghi nhận lịch sử tính giá
INSERT INTO HistoryCalculatePrice (DivisionID
	, TranMonth
	, TranYear
	, FromInventoryID
	, ToInventoryID
	, FromWareHouseID
	, ToWareHouseID
	, FromAccountID
	, ToAccountID
	, CreateUserID
	, CreateDate)
VALUES (@DivisionID
		, @TranMonth
		, @TranYear
		, @FromInventoryID
		, @ToInventoryID
		, @WareHouseID
		, @WareHouseID
		, '%'
		, '%'
		, @UserID
		, GETDATE())
									
IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
	-- Thay thế store AP1309_QC
	EXEC WMP00032_QC @DivisionID, @TranMonth, @TranYear, @FromInventoryID, @ToInventoryID, @WareHouseID, @UserID, @GroupID
ELSE
BEGIN
	DECLARE 
		@sSQL NVARCHAR(4000), 
		@sSQL1 NVARCHAR(4000),
		@sSQL2 NVARCHAR(4000),
		@QuantityDecimals TINYINT, 
		@UnitCostDecimals TINYINT,
		@ConvertedDecimals TINYINT,
		@CustomerName INT

	--Tao bang tam de kiem tra day co phai la khach hang TBIV khong (CustomerName = 29)
	CREATE TABLE #CustomerName (CustomerName INT, ImportExcel int)
	INSERT #CustomerName EXEC AP4444
	SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

	BEGIN TRY
	BEGIN TRANSACTION;
	BEGIN 
		SELECT @QuantityDecimals = QuantityDecimals, 
			@UnitCostDecimals = UnitCostDecimals, 
			@ConvertedDecimals = ConvertedDecimals
		FROM AT1101 WITH (NOLOCK)
		WHERE DivisionID = @DivisionID

		SET @QuantityDecimals = ISNULL(@QuantityDecimals, 2)
		SET @UnitCostDecimals = ISNULL(@UnitCostDecimals, 2)
		SET @ConvertedDecimals = ISNULL(@ConvertedDecimals, 2)
		-- Ghi lai history
		INSERT INTO HistoryInfo(TableID
								, ModifyUserID
								, ModifyDate
								, Action
								, VoucherNo
								, TransactionTypeID
								, DivisionID)
		VALUES ('WMF0003'
					, @UserID
					, GETDATE()
					, 9
					, @GroupID
					, ''
					, @DivisionID)

		--Cap nhat gia xuat tra lai hang mua = gia cua phieu tra lai hang mua
		UPDATE AT2007 
		SET AT2007.UnitPrice = (CASE WHEN ActualQuantity <> 0 
									 THEN ROUND(AT9000.ConvertedAmount/ActualQuantity, @UnitCostDecimals) 
									 ELSE 0 
								END)
			, AT2007.ConvertedPrice =  (CASE WHEN ActualQuantity <> 0 
										   THEN ROUND(AT9000.ConvertedAmount / ActualQuantity, @UnitCostDecimals) 
										   ELSE 0 
									    END)
			, OriginalAmount = AT9000.ConvertedAmount
			, ConvertedAmount = AT9000.ConvertedAmount
		FROM AT2007 WITH (ROWLOCK)
			INNER JOIN AT2006 WITH (ROWLOCK) ON AT2006.DivisionID = AT2007.DivisionID 
													AND AT2006.VoucherID = AT2007.VoucherID
			INNER JOIN AT9000 WITH (ROWLOCK) ON AT9000.DivisionID = AT2007.DivisionID 
													AND AT9000.VoucherID = AT2007.VoucherID 
													AND AT9000.TransactionID = AT2007.TransactionID
		WHERE AT2007.DivisionID =@DivisionID
			AND AT2007.TranMonth = @TranMonth 
			AND AT2007.TranYear = @TranYear 
			AND AT2006.KindVoucherID = 10
			AND AT9000.TransactionTypeID = 'T25' 
			AND AT9000.TranMonth = @TranMonth 
			AND AT9000.TranYear = @TranYear
	


		IF @CustomerName <> 49 --- <> FIGLA
			UPDATE AT2007
			SET UnitPrice = 0,
				ConvertedPrice = 0, 
				OriginalAmount = 0, 
				ConvertedAmount = 0
			FROM AT2007 WITH (ROWLOCK) 
				--INNER JOIN AT2006 WITH (NOLOCK) ON AT2007.DivisionID = AT2006.DivisionID AND AT2007.VoucherID = AT2006.VoucherID
				--INNER Join AT1302 WITH (NOLOCK) ON AT2007.DivisionID = AT1302.DivisionID and AT2007.InventoryID = AT1302.InventoryID
			WHERE AT2007.DivisionID = @DivisionID 
				AND AT2007.TranYear = @TranYear
				AND AT2007.TranMonth = @TranMonth 
				AND (AT2007.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID)
				AND (AT2007.CreditAccountID LIKE N'%')
				AND (SELECT MethodID 
					 FROM AT1302 WITH (NOLOCK) 
					 WHERE DivisionID IN (AT2007.DivisionID,'@@@') 
							AND InventoryID = AT2007.InventoryID
					) IN (5)
				AND (SELECT KindVoucherID 
						FROM AT2006 WITH (NOLOCK) 
						WHERE DivisionID = AT2007.DivisionID 
							AND VoucherID = AT2007.VoucherID
					) = 3
				AND (SELECT WareHouseID2 
						FROM AT2006 WITH (NOLOCK) 
						WHERE DivisionID = AT2007.DivisionID 
							AND VoucherID = AT2007.VoucherID
					) IN (@WareHouseID)
		 
		ELSE --- FIGLA
			UPDATE AT2007 
			SET UnitPrice = 0,
				ConvertedPrice = 0, 
				OriginalAmount = 0, 
				ConvertedAmount = 0
			FROM AT2007 WITH (ROWLOCK) 
				INNER JOIN AT2006 WITH (NOLOCK) ON AT2007.DivisionID = AT2006.DivisionID 
													AND AT2007.VoucherID = AT2006.VoucherID
				INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,'@@@') AND AT2007.InventoryID = AT1302.InventoryID
			WHERE AT2007.TranMonth = @TranMonth 
				AND AT2007.TranYear = @TranYear
				AND (AT2007.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID) 
				AND MethodID IN (4, 5)
				AND (WareHouseID2 IN (@WareHouseID))
				AND (CreditAccountID LIKE N'%')
				AND KindVoucherID IN (2,3)
				AND AT2007.DivisionID = @DivisionID

		If @CustomerName = 8
		BEGIN
			------ Ap gia nhap hang tra lai bang gia dau ky
			IF EXISTS 
			(
				SELECT TOP 1 1 
				FROM AT2007  WITH (NOLOCK)
					INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID 
														AND AT2006.VoucherID = AT2007.VoucherID
					INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,'@@@') AND AT1302.InventoryID = AT2007.InventoryID
				WHERE AT2007.DivisionID = @DivisionID 
				AND AT2007.TranYear = @TranYear 
				AND AT2007.TranMonth = @TranMonth 
				AND KindVoucherID = 7 
				AND At1302.MethodID = 4
			) 
				EXEC AP13081 @DivisionID
								, @TranMonth
								, @TranYear
								, @QuantityDecimals
								, @UnitCostDecimals
								, @ConvertedDecimals

			------ Ap gia nhap hang tai che bang gia dau ky
			IF EXISTS 
			(
				SELECT TOP 1 1 
				FROM AT2007  WITH (NOLOCK)
					INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID 
														AND AT2006.VoucherID = AT2007.VoucherID
					INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,'@@@') AND AT1302.InventoryID = AT2007.InventoryID
				WHERE AT2007.DivisionID = @DivisionID 
				AND AT2007.TranYear = @TranYear
				AND AT2007.TranMonth = @TranMonth 
				AND KindVoucherID = 1 
				AND At1302.MethodID = 4
				AND IsGoodsRecycled = 1
			)
				EXEC AP13082 @DivisionID
							, @TranMonth
							, @TranYear
							, @QuantityDecimals
							, @UnitCostDecimals
							, @ConvertedDecimals
		END

		------------ Xu ly chi tiet gia 
		
		------ Áp giá nhập nguyên vật liệu phát sinh tự động từ xuất thành phẩm
		IF EXISTS 
		(
			SELECT TOP 1 1 
			FROM AT2007  WITH (NOLOCK)
				INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID AND AT2006.VoucherID = AT2007.VoucherID
				INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,'@@@') AND AT1302.InventoryID = AT2007.InventoryID
			WHERE AT2007.DivisionID = @DivisionID 
			AND AT2007.TranYear = @TranYear 
			AND AT2007.TranMonth = @TranMonth 
			AND KindVoucherID = 1 
			AND At1302.MethodID = 4
			AND (IsGoodsRecycled = 1 OR AT2006.IsReturn = 1)
		) 
			EXEC AP13082 @DivisionID
							, @TranMonth
							, @TranYear
							, @QuantityDecimals
							, @UnitCostDecimals
							, @ConvertedDecimals
	
		----------- Tinh gia xuat kho binh quan lien hoan
		IF EXISTS 
		(
			SELECT TOP 1 1 
			FROM AT2007 WITH (NOLOCK) 
				INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID 
													AND AT2006.VoucherID = AT2007.VoucherID
				INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,'@@@') AND AT1302.InventoryID = AT2007.InventoryID
			WHERE AT2007.DivisionID = @DivisionID 
			AND AT2007.TranYear = @TranYear 
			AND AT2007.TranMonth = @TranMonth 
			AND KindVoucherID IN (2, 3, 4, 6, 8) 
			AND AT1302.MethodID = 5
		)
		BEGIN 
			-- Thay thế store AP1410
			EXEC WMP00034 @DivisionID
					, @TranMonth
					, @TranYear
					, @QuantityDecimals
					, @UnitCostDecimals
					, @ConvertedDecimals
					, @FromInventoryID
					, @ToInventoryID
					, @WareHouseID
		END

		----------- Tính giá thực tế đích danh
		IF EXISTS 
		(
			SELECT TOP 1 1 
			FROM AT2007 WITH (NOLOCK) 
				INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID 
													AND AT2006.VoucherID = AT2007.VoucherID
				INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,'@@@') AND AT1302.InventoryID = AT2007.InventoryID
			WHERE AT2007.DivisionID = @DivisionID 
			AND AT2007.TranYear = @TranYear 
			AND AT2007.TranMonth = @TranMonth 
			AND KindVoucherID IN (2, 3, 4, 6, 8) 
			AND At1302.MethodID = 3
			AND (AT2007.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID) 
			AND (WareHouseID IN (@WareHouseID))
		) 
			EXEC AP1305 @DivisionID
						, @TranMonth
						, @TranYear

	IF @CustomerName NOT IN (32, 62)  -- (Phúc Long, PMT)
	BEGIN
		----- XỬ LÝ LÀM TRÒN CHO CÁC PHƯƠNG PHÁP <> FIFO
		DECLARE 
			@TempDivisionID AS NVARCHAR(50), 
			@TempTranYear AS INT, 
			@TempTranMonth AS INT, 
			@InventoryID AS NVARCHAR(50), 
			@AccountID AS NVARCHAR(50), 
			@Amount AS DECIMAL(28, 8), 
			@WareHouseID_Cur AS NVARCHAR(50), 
			@TransactionID AS NVARCHAR(50), 
			@Cur_Ware AS CURSOR, 
			@CountUpdate INT

		Recal: 

		SET @CountUpdate = 0
		SET @Cur_Ware = CURSOR SCROLL KEYSET FOR 
			SELECT AT2008.DivisionID,
				AT2008.TranYear, 
				AT2008.TranMonth, 
				AT2008.WareHouseID, 
				AT2008.InventoryAccountID, 
				AT2008.InventoryID, 
				AT2008.EndAmount
			FROM AT2008 WITH (NOLOCK) ---inner join AT1302 on AT2008.DivisionID = AT1302.DivisionID and AT2008.InventoryID = AT1302.InventoryID
			WHERE AT2008.DivisionID = @DivisionID 
				AND AT2008.TranYear = @TranYear 
				AND AT2008.TranMonth = @TranMonth 
				AND (AT2008.WarehouseID IN (@WareHouseID))
				AND (AT2008.InventoryAccountID LIKE N'%')
				AND (AT2008.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID)
				AND AT2008.EndQuantity = 0 
				AND AT2008.EndAmount <> 0
				AND AT2008.DebitQuantity + AT2008.CreditQuantity <> 0
				AND NOT EXISTS (SELECT 1 FROM AT1302 WITH (NOLOCK) WHERE AT1302.DivisionID IN (AT2008.DivisionID,'@@@') AND InventoryID = AT2008.InventoryID AND MethodID = 1)
        
		OPEN @Cur_Ware
		FETCH NEXT FROM @Cur_Ware INTO 
			@TempDivisionID
			, @TempTranYear
			, @TempTranMonth
			, @WareHouseID_Cur
			, @AccountID
			, @InventoryID
			, @Amount

		WHILE @@Fetch_Status = 0 
			BEGIN
				IF @CustomerName <> 29 or (@CustomerName = 29 and @WareHouseID_Cur <> 'SCTP') --- customize TBIV: nếu là kho sửa chữa thì không làm tròn để phiếu xuất của kho này không bị cập nhật lại tiền
				BEGIN
					SET @TransactionID = 
					(
						SELECT TOP 1 D11.TransactionID
						FROM AT2007 D11 WITH (NOLOCK)
							LEFT JOIN AT2007 D12 WITH (NOLOCK) ON D12.TransactionID = D11.ReTransactionID
							INNER JOIN AT2006 D9 WITH (NOLOCK) ON D9.DivisionID = D11.DivisionID 
																		AND D9.VoucherID = D11.VoucherID
						WHERE D11.DivisionID = @DivisionID
							AND D11.TranYear = @TranYear
							AND D11.TranMonth = @TranMonth
							AND D11.InventoryID = @InventoryID 
							AND D11.CreditAccountID = @AccountID
							AND (CASE WHEN D9.KindVoucherID = 3 
									  THEN D9.WareHouseID2 
									  ELSE D9.WareHouseID 
								 END) = @WareHouseID_Cur 
							AND D9.KindVoucherID IN (2, 3, 4, 6, 8,7) ---,1) 	
						ORDER BY 
								CASE WHEN D9.KindVoucherID = 3 THEN 1 ELSE 0 END
								, ISNULL(
										(SELECT TOP 1 1 
										 FROM AT2007 WITH (NOLOCK) 
										 INNER JOIN AT2006 WITH (NOLOCK) ON AT2007.DivisionID = AT2006.DivisionID 
																				AND AT2007.VoucherID = AT2006.VoucherID
										 WHERE AT2007.DivisionID = @DivisionID 
													AND AT2007.TranMonth = @TranMonth 
													AND AT2007.TranYear = @TranYear
													AND AT2007.InventoryID = @InventoryID 
													AND AT2006.KindVoucherID = 3 
													AND AT2006.WareHouseID2 = D9.WareHouseID)
										, 0)
								, CASE WHEN D11.ActualQuantity = D12.ActualQuantity 
											AND D11.ConvertedAmount < D12.ConvertedAmount 
									 THEN 0 
									 ELSE 1 
								  END, 
								D11.ConvertedAmount DESC
					)			
					IF @TransactionID IS NOT NULL
						BEGIN
							UPDATE AT2007
							SET ConvertedAmount = ISNULL(ConvertedAmount, 0) + @Amount, 
								OriginalAmount = ISNULL(OriginalAmount, 0) + @Amount,
								IsRound = 1
							FROM AT2007 WITH (ROWLOCK) 
							WHERE AT2007.DivisionID = @DivisionID and AT2007.TransactionID = @TransactionID
							SET @CountUpdate = @CountUpdate + 1
						END
				END
		
				FETCH NEXT FROM @Cur_Ware INTO  @TempDivisionID, @TempTranYear, @TempTranMonth,@WareHouseID_Cur, @AccountID, @InventoryID , @Amount
			END 

		CLOSE @Cur_Ware


		IF EXISTS 
		(
			SELECT TOP 1 1 
			FROM AT2008  WITH (NOLOCK)
			WHERE DivisionID = @DivisionID
				AND TranYear = @TranYear 
				AND TranMonth = @TranMonth 
				AND (WarehouseID IN (@WareHouseID))
				AND (InventoryAccountID LIKE N'%')
				AND (InventoryID BETWEEN @FromInventoryID AND @ToInventoryID)
				AND EndQuantity = 0 
				AND EndAmount <> 0
				AND DebitQuantity + CreditQuantity <> 0
				AND NOT EXISTS (SELECT 1 FROM AT1302 WITH (NOLOCK) WHERE AT1302.DivisionID IN (AT2008.DivisionID,'@@@') AND InventoryID = AT2008.InventoryID AND MethodID = 1)
		) 
			AND @CountUpdate > 0
    
			GOTO ReCal
		
	END
	ELSE
	BEGIN

		SET @APK_AT2007 = NULL;
		
		-- Tổng hợp tất cả các mặt hàng làm tròn và Transaction phiếu xuất
		SELECT CONCAT(AT2008.InventoryID,AT2008.InventoryAccountID) AS InventoryID
			, AT2008.WareHouseID
			, AT2008.EndAmount
			, AT2008.TranMonth
			, AT2008.TranYear
			, (SELECT TOP 1 CONCAT(TransactionID, KindVoucherID) 
					FROM AT2007 WITH (NOLOCK)
						LEFT JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID 
							AND AT2006.VoucherID = AT2007.VoucherID
					WHERE AT2007.TranYear = AT2008.TranYear
							AND AT2007.TranMonth = AT2008.TranMonth 
							AND (CASE WHEN AT2006.KindVoucherID = 3 
												  THEN AT2006.WareHouseID2 
												  ELSE AT2006.WareHouseID 
											 END)  = AT2008.WareHouseID
							AND KindVoucherID <> 3
							AND CONCAT(AT2007.InventoryID, AT2007.CreditAccountID) = CONCAT(AT2008.InventoryID, AT2008.InventoryAccountID)
					ORDER BY ActualQuantity DESC 
				) AS TransactionID
        INTO #Temp 
		FROM AT2008 WITH (NOLOCK)
        LEFT JOIN AT2007 WITH (NOLOCK) ON AT2007.DivisionID = AT2008.DivisionID 
									AND AT2007.TranYear = AT2008.TranYear
									AND AT2007.TranMonth = AT2008.TranMonth 
									AND  AT2007.CreditAccountID = AT2008.InventoryAccountID 
									AND AT2007.InventoryID = AT2008.InventoryID 
        LEFT JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID 
											AND AT2006.VoucherID = AT2007.VoucherID 
        WHERE
			AT2008.DivisionID = @DivisionID
		AND AT2008.TranYear = @TranYear 
		AND AT2008.TranMonth = @TranMonth 
		-- Không phải phiếu chuyển kho
		AND AT2006.KindVoucherID <> 3
        AND AT2008.EndAmount <> 0 AND AT2008.EndQuantity = 0  
		AND (AT2008.WarehouseID IN (@WareHouseID))
		AND (AT2008.InventoryAccountID LIKE N'%')
		AND (AT2008.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID)
        GROUP BY AT2008.InventoryID
				, AT2008.InventoryAccountID
				, AT2008.WareHouseID
				, AT2008.EndAmount
				, AT2008.TranMonth
				, AT2008.TranYear
		
		--select '#Temp' AS Title, * From #Temp

		-- Update Xuất 
        UPDATE AT2007
        SET ConvertedAmount = ISNULL(ConvertedAmount, 0) + #Temp.EndAmount
			, OriginalAmount = ISNULL(OriginalAmount, 0) + #Temp.EndAmount
			, IsRound = 1
        FROM AT2007 WITH (ROWLOCK) 
		INNER join #Temp ON SUBSTRING(#Temp.TransactionID,0,LEN(#Temp.TransactionID)) = AT2007.TransactionID
        WHERE AT2007.DivisionID = @DivisionID AND AT2007.TranMonth = @TranMonth AND AT2007.TranYear = @TranYear 
		AND SUBSTRING(#Temp.TransactionID,LEN(#Temp.TransactionID),1) <> '3'
		AND AT2007.TransactionID IS NOT NULL

		-- Update AT2008 phần xuất  
		UPDATE T08
        SET T08.CreditAmount = ISNULL(T08.CreditAmount,0) + #Temp.EndAmount
			, T08.InCreditAmount = (CASE WHEN SUBSTRING(#Temp.TransactionID, LEN(#Temp.TransactionID), 1) = '3' THEN ISNULL(T08.InCreditAmount,0) + #Temp.EndAmount else T08.InCreditAmount END)
			, T08.EndAmount = ISNULL(T08.BeginAmount, 0) + ISNULL(T08.DebitAmount, 0) - (ISNULL(T08.CreditAmount, 0) + #Temp.EndAmount)
        FROM AT2008 T08 WITH (NOLOCK)
        INNER JOIN #Temp ON #Temp.InventoryID = CONCAT(T08.InventoryID, T08.InventoryAccountID) AND #Temp.WareHouseID = T08.WareHouseID
        WHERE T08.TranMonth = @TranMonth
        AND T08.TranYear = @TranYear 
		AND SUBSTRING(#Temp.TransactionID,LEN(#Temp.TransactionID),1) <> '3'
        AND T08.EndAmount <> 0 AND T08.EndQuantity = 0

		-- Chuyển kho
		DECLARE @Cur AS CURSOR,
		@InventoryIDCur  AS NVARCHAR(50),
		@WareHouseIDCur AS NVARCHAR(50),
		@EndAmount INT--,
		--@TransactionID AS NVARCHAR(50)
		Recal1: 
		SET @Cur = CURSOR SCROLL KEYSET FOR
		SELECT  CONCAT(AT2008.InventoryID, AT2008.InventoryAccountID) AS InventoryID
			, AT2008.WareHouseID
			, AT2008.EndAmount
			, (SELECT TOP 1 CONCAT(TransactionID, KindVoucherID)  
				FROM AT2007 WITH (NOLOCK)
					LEFT JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID 
															AND AT2006.VoucherID = AT2007.VoucherID
				WHERE AT2007.TranYear = AT2008.TranYear
						AND AT2007.TranMonth = AT2008.TranMonth 
						AND (CASE WHEN AT2006.KindVoucherID = 3 
									  THEN AT2006.WareHouseID2 
									  ELSE AT2006.WareHouseID 
								 END)  = AT2008.WareHouseID
						AND CONCAT(AT2007.InventoryID, AT2007.CreditAccountID) = CONCAT(AT2008.InventoryID, AT2008.InventoryAccountID)
				ORDER BY ActualQuantity DESC 
			  ) AS TransactionID
		FROM AT2008 WITH (NOLOCK)
		LEFT JOIN AT2007 WITH (NOLOCK) ON AT2007.DivisionID = AT2008.DivisionID 
									AND  AT2007.CreditAccountID = AT2008.InventoryAccountID 
									AND AT2007.InventoryID = AT2008.InventoryID 
									AND AT2007.TranMonth = AT2008.TranMonth 
									AND AT2007.TranYear = AT2008.TranYear
									AND AT2008.InventoryID = AT2007.InventoryID 
		LEFT JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID 
		WHERE
			AT2008.DivisionID = @DivisionID
			AND AT2008.TranYear = @TranYear 
			AND AT2008.TranMonth = @TranMonth 
			--- Lượng hết tiền còn
			AND AT2008.EndAmount <> 0 
			AND AT2008.EndQuantity = 0  

			AND (AT2008.WarehouseID IN (@WareHouseID))
			AND (AT2008.InventoryAccountID LIKE N'%')
			AND (AT2008.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID)
		GROUP BY AT2008.InventoryID
			, AT2008.InventoryAccountID
			, AT2008.WareHouseID
			, AT2008.EndAmount
			, AT2008.TranMonth
			, AT2008.TranYear

		OPEN @Cur 
		FETCH NEXT FROM @Cur INTO 
		@InventoryIDCur,@WareHouseIDCur,@EndAmount,@TransactionID
		WHILE @@Fetch_Status = 0 
		BEGIN
				-- Update chuyển kho
				SELECT TOP 1 @APK_AT2007 = AT2007.APK
				FROM AT2007 WITH (NOLOCK)
				LEFT JOIN AT2006 AT06 WITH (NOLOCK) ON AT06.DivisionID = AT2007.DivisionID AND AT06.VoucherID = AT2007.VoucherID
				WHERE AT2007.DivisionID = @DivisionID 
						AND AT2007.TranYear = @TranYear 
						AND AT2007.TranMonth = @TranMonth
						AND AT2007.TransactionID = SUBSTRING(@TransactionID,0,LEN(@TransactionID))
						AND AT06.WareHouseID = @WareHouseIDCur
				ORDER BY AT2007.ConvertedAmount DESC
				
		        UPDATE AT2007
					SET ConvertedAmount = ISNULL(ConvertedAmount, 0) + @EndAmount
						, OriginalAmount = ISNULL(OriginalAmount, 0) + @EndAmount
						, IsRound = 1
				FROM AT2007 WITH (ROWLOCK)  
				WHERE AT2007.DivisionID = @DivisionID 
						AND AT2007.TranYear = @TranYear 
						AND AT2007.TranMonth = @TranMonth
						AND AT2007.APK = @APK_AT2007

				-- Update phần xuất
				UPDATE T08
					SET T08.CreditAmount = ISNULL(T08.CreditAmount,0) + @EndAmount
					, T08.InCreditAmount = (CASE WHEN SUBSTRING(@TransactionID, LEN(@TransactionID), 1) = '3' 
												 THEN ISNULL(T08.InCreditAmount,0) + @EndAmount 
												 ELSE T08.InCreditAmount END)
					, T08.EndAmount = ISNULL(T08.BeginAmount, 0) + ISNULL(T08.DebitAmount, 0) - (ISNULL(T08.CreditAmount, 0) + @EndAmount)
				FROM AT2008 T08 WITH (NOLOCK)
				WHERE T08.DivisionID = @DivisionID 
				AND T08.TranYear = @TranYear 
				AND T08.TranMonth = @TranMonth
				AND CONCAT(T08.InventoryID, T08.InventoryAccountID) = @InventoryIDCur 
				AND T08.WareHouseID = @WareHouseIDCur 
				AND T08.EndAmount <> 0 
				AND T08.EndQuantity = 0

				-- Update AT2008 phần nhập  
				UPDATE AT2008 
					SET  AT2008.InDebitAmount = ISNULL(AT2008.InDebitAmount,0) + A.EndAmount
						, AT2008.DebitAmount = ISNULL(AT2008.DebitAmount,0) + A.EndAmount
						, AT2008.EndAmount = ISNULL(AT2008.BeginAmount, 0) + (ISNULL(AT2008.DebitAmount, 0) + A.EndAmount) - (ISNULL(AT2008.CreditAmount, 0))
				FROM AT2008 WITH (NOLOCK) 
				INNER JOIN (
							SELECT AT2006.WareHouseID
									, CONCAT(AT2007.InventoryID, AT2007.CreditAccountID) AS InventoryID
									, @EndAmount AS EndAmount
									, AT2007.TranMonth
									, AT2007.TranYear
							FROM AT2007 WITH (NOLOCK)  
							INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID 
																AND AT2006.VoucherID = AT2007.VoucherID 
							INNER JOIN AT2008 T08 WITH (NOLOCK) ON T08.DivisionID = @DivisionID 
																AND CONCAT(T08.InventoryID, T08.InventoryAccountID) = @InventoryIDCur 
																AND T08.WareHouseID = @WareHouseIDCur
							WHERE T08.DivisionID = @DivisionID 
							AND T08.TranYear = @TranYear
							AND T08.TranMonth = @TranMonth
							AND AT2007.TransactionID = SUBSTRING(@TransactionID, 0, LEN(@TransactionID))  
							AND SUBSTRING(@TransactionID, LEN(@TransactionID), 1) = '3'
				) A ON A.TranYear = AT2008.TranYear 
						AND A.TranMonth = AT2008.TranMonth 
						AND A.WareHouseID = AT2008.WareHouseID 
						AND A.InventoryID = CONCAT(AT2008.InventoryID, AT2008.InventoryAccountID) 
				WHERE AT2008.WareHouseID = @WareHouseIDCur

			FETCH NEXT FROM @Cur INTO @InventoryIDCur, @WareHouseIDCur, @EndAmount, @TransactionID
		END
		CLOSE @Cur

		IF EXISTS (
		SELECT TOP 1 1 
			FROM AT2008  WITH (NOLOCK)
			WHERE DivisionID = @DivisionID
				AND TranYear = @TranYear
				AND TranMonth = @TranMonth 
				AND (WarehouseID IN (@WareHouseID))
				AND (InventoryAccountID LIKE N'%')
				AND (InventoryID BETWEEN @FromInventoryID AND @ToInventoryID)
				--- lượng hết tiền còn
				AND EndQuantity = 0 
				AND EndAmount <> 0

				AND DebitQuantity + CreditQuantity <> 0
				AND NOT EXISTS (SELECT 1 FROM AT1302 WITH (NOLOCK) WHERE AT1302.DivisionID IN (AT2008.DivisionID,'@@@') AND InventoryID = AT2008.InventoryID AND MethodID = 1)
		)
			GOTO ReCal1
	END
    
		------------ Tinh gia xuat kho theo PP FIFO 
		IF EXISTS 
		(
			SELECT TOP 1 1 
			FROM AT2007 WITH (NOLOCK)
				INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID 
														AND AT2006.VoucherID = AT2007.VoucherID
				INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,'@@@') AND AT1302.InventoryID = AT2007.InventoryID
			WHERE AT2007.DivisionID = @DivisionID 
				AND AT2007.TranYear = @TranYear 
				AND AT2007.TranMonth = @TranMonth 
				AND KindVoucherID IN (2, 3, 4, 6, 8) 
				AND At1302.MethodID = 1
		) 
		BEGIN
			-- Thay thế store AP1303
			EXEC WMP00033 @DivisionID, @TranMonth, @TranYear, @FromInventoryID, @ToInventoryID, @WareHouseIDNew
			--return -- da xu ly lam trong trong store AP1303 nen thoat luon khong vo doan lam trong ben duoi nua
		END 
	END
COMMIT TRANSACTION;
PRINT(N'Successful')
END TRY
BEGIN CATCH
	SELECT   
		ERROR_NUMBER() AS		ErrorNumber  
		,ERROR_SEVERITY() AS	ErrorSeverity  
		,ERROR_STATE() AS		ErrorState  
		,ERROR_LINE () AS		ErrorLine  
		,ERROR_PROCEDURE() AS	ErrorProcedure  
		,ERROR_MESSAGE() AS		ErrorMessage;  
	ROLLBACK TRANSACTION;
	PRINT('ROLLBACK DONE')
END CATCH

END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
