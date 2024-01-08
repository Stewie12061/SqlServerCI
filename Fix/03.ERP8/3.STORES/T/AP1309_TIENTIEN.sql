IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1309_TienTien]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1309_TienTien]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





--------- Created by Huỳnh Thử, Date 12/07/2021
--------- Purpose: Phiếu nhập xuất sửa tài khoản không cập nhật AT2008.
/********************************************
'* Edited by: [GS] [Việt Khánh] [29/07/2010]
'* Update by: [ThànhSang] [06/06/2022]: Sửa câu truy vấn Khóa sổ 
'********************************************/
--- exec AP1309 @DivisionID=N'NH',@TranMonth=3,@TranYear=2016,@FromInventoryID=N'BS04K004',@ToInventoryID=N'BS04K004',@FromWareHouseID=N'DN010',@ToWareHouseID=N'ZS003',@FromAccountID=N'152',@ToAccountID=N'158',@UserID=N'ASOFTADMIN',@GroupID=N'ADMIN'

CREATE PROCEDURE [dbo].[AP1309_TienTien] 
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
    @GroupID NVARCHAR (50),
    @TransProcessesID NVARCHAR(50)
AS
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
		, @FromWareHouseID
		, @ToWareHouseID
		, @FromAccountID
		, @ToAccountID
		, @UserID
		, GETDATE())
									
IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
	EXEC AP1309_QC @DivisionID
					, @TranMonth
					, @TranYear
					, @FromInventoryID
					, @ToInventoryID
					, @FromWareHouseID
					, @ToWareHouseID
					, @FromAccountID
					, @ToAccountID
					, @UserID
					, @GroupID
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

	IF @CustomerName = 57 -------- ANGEL
	BEGIN
		EXEC AP1309_AG @DivisionID
				, @TranMonth
				, @TranYear
				, @FromInventoryID
				, @ToInventoryID
				, @FromWareHouseID
				, @ToWareHouseID
				, @FromAccountID
				, @ToAccountID
				, @UserID
				, @GroupID
	END
	--ELSE IF @CustomerName = 32	--- PHÚC LONG
	--BEGIN
	--	EXEC AP1309_PL @DivisionID, @TranMonth, @TranYear, @FromInventoryID, @ToInventoryID, @FromWareHouseID, @ToWareHouseID, @FromAccountID, @ToAccountID, @UserID, @GroupID
	--END
	ELSE IF @CustomerName = 49	--- FIGLA
	BEGIN
		EXEC AP1309_FL @DivisionID
						, @TranMonth
						, @TranYear
						, @FromInventoryID
						, @ToInventoryID
						, @FromWareHouseID
						, @ToWareHouseID
						, @FromAccountID
						, @ToAccountID
						, @UserID
						, @GroupID
						, @TransProcessesID
	END	
	ELSE IF @CustomerName = 52	--- KoYo
	BEGIN
		EXEC AP1309_KoYo @DivisionID
						 , @TranMonth
						 , @TranYear
						 , @FromInventoryID
						 , @ToInventoryID
						 , @FromWareHouseID
						 , @ToWareHouseID
						 , @FromAccountID
						 , @ToAccountID
						 , @UserID
						 , @GroupID
						 , @TransProcessesID
	END
	ELSE IF @CustomerName = 62	--- PMT
	BEGIN
		EXEC AP1309_PMT @DivisionID
						 , @TranMonth
						 , @TranYear
						 , @FromInventoryID
						 , @ToInventoryID
						 , @FromWareHouseID
						 , @ToWareHouseID
						 , @FromAccountID
						 , @ToAccountID
						 , @UserID
						 , @GroupID
						 , @TransProcessesID
	END
	ELSE 
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
		Insert into HistoryInfo(TableID
								, ModifyUserID
								, ModifyDate
								, Action
								, VoucherNo
								, TransactionTypeID
								, DivisionID)
		Values ('WF0056'
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
				AND (AT2007.CreditAccountID BETWEEN @FromAccountID AND @ToAccountID)
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
					) BETWEEN @FromWareHouseID AND @ToWareHouseID
		 
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
				AND (WareHouseID2 BETWEEN @FromWareHouseID AND @ToWareHouseID )
				AND (CreditAccountID BETWEEN @FromAccountID AND @ToAccountID )
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
			EXEC AP1410 @DivisionID
					, @TranMonth
					, @TranYear
					, @QuantityDecimals
					, @UnitCostDecimals
					, @ConvertedDecimals
					, @FromInventoryID
					, @ToInventoryID
					, @FromWareHouseID
					, @ToWareHouseID
					, @FromAccountID
					, @ToAccountID
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
			AND (WareHouseID BETWEEN @FromWareHouseID AND @ToWareHouseID)
		) 
			EXEC AP1305 @DivisionID
						, @TranMonth
						, @TranYear
						, @FromAccountID
						, @ToAccountID

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
			@WareHouseID AS NVARCHAR(50), 
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
				AND (AT2008.WarehouseID BETWEEN @FromWarehouseID AND @ToWarehouseID)
				AND (AT2008.InventoryAccountID BETWEEN @FromAccountID AND @ToAccountID)
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
			, @WareHouseID
			, @AccountID
			, @InventoryID
			, @Amount

		WHILE @@Fetch_Status = 0 
			BEGIN
				IF @CustomerName <> 29 or (@CustomerName = 29 and @WareHouseID <> 'SCTP') --- customize TBIV: nếu là kho sửa chữa thì không làm tròn để phiếu xuất của kho này không bị cập nhật lại tiền
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
								 END) = @WareHouseID 
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
		
				FETCH NEXT FROM @Cur_Ware INTO  @TempDivisionID, @TempTranYear, @TempTranMonth,@WareHouseID, @AccountID, @InventoryID , @Amount
			END 

		CLOSE @Cur_Ware


		IF EXISTS 
		(
			SELECT TOP 1 1 
			FROM AT2008  WITH (NOLOCK)
			WHERE DivisionID = @DivisionID
				AND TranYear = @TranYear 
				AND TranMonth = @TranMonth 
				AND (WarehouseID BETWEEN @FromWarehouseID AND @ToWarehouseID)
				AND (InventoryAccountID BETWEEN @FromAccountID AND @ToAccountID)
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
		
		-- Tổng hợp tất cả các mặt hàng làm tròn và Transaction phiếu xuất

		SELECT  CONCAT(AT2008.InventoryID,AT2008.InventoryAccountID) AS InventoryID,AT2008.WareHouseID, AT2008.EndAmount,AT2008.TranMonth,AT2008.TranYear, 
	    (SELECT TOP 1 CONCAT(TransactionID , KindVoucherID)  FROM  AT2007 WITH (NOLOCK)
		LEFT JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID
		WHERE CONCAT(AT2007.InventoryID,AT2007.CreditAccountID) = CONCAT(AT2008.InventoryID,AT2008.InventoryAccountID)
		AND AT2007.TranMonth = AT2008.TranMonth AND AT2007.TranYear = AT2008.TranYear
		AND (CASE WHEN AT2006.KindVoucherID = 3 
									  THEN AT2006.WareHouseID2 
									  ELSE AT2006.WareHouseID 
								 END)  = AT2008.WareHouseID
					  AND KindVoucherID <> 3
		ORDER BY ActualQuantity DESC ) AS TransactionID
        INTO #Temp FROM AT2008 WITH (NOLOCK)
        LEFT JOIN AT2007 WITH (NOLOCK) ON AT2007.DivisionID = AT2008.DivisionID 
									AND  AT2007.CreditAccountID = AT2008.InventoryAccountID 
									AND AT2007.InventoryID = AT2008.InventoryID 
									AND AT2007.TranMonth = AT2008.TranMonth 
									AND AT2007.TranYear = AT2008.TranYear
									AND AT2008.InventoryID = AT2007.InventoryID 
									
        LEFT JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID 
        WHERE
		At2008.DivisionID = @DivisionID
		AND AT2008.TranMonth = @TranMonth 
		AND AT2008.TranYear = @TranYear 
        AND AT2008.EndAmount <> 0 AND AT2008.EndQuantity = 0  
		AND (AT2008.WarehouseID BETWEEN @FromWarehouseID AND @ToWarehouseID)
		AND (AT2008.InventoryAccountID BETWEEN @FromAccountID AND @ToAccountID)
		AND (AT2008.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID)
		AND AT2006.KindVoucherID <> 3
        GROUP BY AT2008.InventoryID,AT2008.InventoryAccountID,AT2008.WareHouseID, AT2008.EndAmount ,AT2008.TranMonth,AT2008.TranYear
        

		-- SELECT * FROM #Temp
		-- Chuyển kho
		--SELECT * FROM AT2007  WHERE TransactionID = 'BD20200000007164'		
		---- Master chuyển kho
		--SELECT WareHouseID,WareHouseID2 FROM AT2006  WHERE VoucherID = 'AD20200000000223'

		-- Update Xuất 
        UPDATE AT2007
        SET ConvertedAmount = ISNULL(ConvertedAmount, 0) + #Temp.EndAmount, 
		OriginalAmount = ISNULL(OriginalAmount, 0) + #Temp.EndAmount,IsRound = 1
        FROM AT2007 WITH (ROWLOCK) 
		INNER join #Temp ON SUBSTRING(#Temp.TransactionID,0,LEN(#Temp.TransactionID)) = AT2007.TransactionID
        WHERE AT2007.DivisionID = @DivisionID AND AT2007.TranMonth = @TranMonth AND AT2007.TranYear = @TranYear 
		AND SUBSTRING(#Temp.TransactionID,LEN(#Temp.TransactionID),1) <> '3'
		AND AT2007.TransactionID IS NOT NULL

		-- Update AT2008 phần xuất  
		UPDATE T08
        SET T08.CreditAmount = ISNULL(T08.CreditAmount,0) + #Temp.EndAmount,
        T08.InCreditAmount = (CASE WHEN SUBSTRING(#Temp.TransactionID,LEN(#Temp.TransactionID),1) = '3' THEN ISNULL(T08.InCreditAmount,0) + #Temp.EndAmount else T08.InCreditAmount END ) ,
        T08.EndAmount = ISNULL(T08.BeginAmount,0) + ISNULL(T08.DebitAmount,0) - (ISNULL(T08.CreditAmount,0)	+#Temp.EndAmount)
        FROM AT2008 T08 WITH (NOLOCK)
        INNER JOIN #Temp ON #Temp.InventoryID = CONCAT(T08.InventoryID,T08.InventoryAccountID) AND #Temp.WareHouseID = T08.WareHouseID
        WHERE T08.TranMonth = @TranMonth
        AND T08.TranYear = @TranYear 
		AND SUBSTRING(#Temp.TransactionID,LEN(#Temp.TransactionID),1) <> '3'
        AND T08.EndAmount <> 0 AND T08.EndQuantity =0

		-- Chuyển kho
		DECLARE @Cur AS CURSOR,
		@InventoryIDCur  AS NVARCHAR(50),
		@WareHouseIDCur AS NVARCHAR(50),
		@EndAmount INT--,
		--@TransactionID AS NVARCHAR(50)
		Recal1: 
		SET @Cur = CURSOR SCROLL KEYSET FOR
		SELECT  CONCAT(AT2008.InventoryID,AT2008.InventoryAccountID) AS InventoryID,AT2008.WareHouseID, AT2008.EndAmount,
	    (SELECT TOP 1 CONCAT(TransactionID , KindVoucherID)  FROM  AT2007 WITH (NOLOCK)
		LEFT JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID
		WHERE CONCAT(AT2007.InventoryID,AT2007.CreditAccountID) = CONCAT(AT2008.InventoryID,AT2008.InventoryAccountID)
		AND AT2007.TranMonth = AT2008.TranMonth AND AT2007.TranYear = AT2008.TranYear
		AND (CASE WHEN AT2006.KindVoucherID = 3 
									  THEN AT2006.WareHouseID2 
									  ELSE AT2006.WareHouseID 
								 END)  = AT2008.WareHouseID
	
		ORDER BY ActualQuantity DESC ) AS TransactionID
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
		AND AT2008.TranMonth = @TranMonth AND AT2008.TranYear = @TranYear 
        AND AT2008.EndAmount <> 0 AND AT2008.EndQuantity = 0  
		AND (AT2008.WarehouseID BETWEEN @FromWarehouseID AND @ToWarehouseID)
		AND (AT2008.InventoryAccountID BETWEEN @FromAccountID AND @ToAccountID)
		AND (AT2008.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID)
		
        GROUP BY AT2008.InventoryID,AT2008.InventoryAccountID,AT2008.WareHouseID, AT2008.EndAmount ,AT2008.TranMonth,AT2008.TranYear
		OPEN @Cur 
		FETCH NEXT FROM @Cur INTO 
		@InventoryIDCur,@WareHouseIDCur,@EndAmount,@TransactionID
		WHILE @@Fetch_Status = 0 
		BEGIN
				
				-- Update chuyển kho
		        UPDATE AT2007
				SET ConvertedAmount = ISNULL(ConvertedAmount, 0) + @EndAmount, 
				OriginalAmount = ISNULL(OriginalAmount, 0) +@EndAmount,IsRound = 1
				FROM AT2007 WITH (ROWLOCK)  
				WHERE AT2007.DivisionID = @DivisionID AND AT2007.TranMonth = @TranMonth AND AT2007.TranYear = @TranYear 
				AND AT2007.TransactionID = SUBSTRING(@TransactionID,0,LEN(@TransactionID))
				-- Update phần xuất
				UPDATE T08
				SET T08.CreditAmount = ISNULL(T08.CreditAmount,0) + @EndAmount,
				T08.InCreditAmount = (CASE WHEN SUBSTRING(@TransactionID,LEN(@TransactionID),1) = '3' THEN ISNULL(T08.InCreditAmount,0) + @EndAmount else T08.InCreditAmount END ) ,
				T08.EndAmount = ISNULL(T08.BeginAmount,0) + ISNULL(T08.DebitAmount,0) - (ISNULL(T08.CreditAmount,0)	+@EndAmount)
				FROM AT2008 T08 WITH (NOLOCK)
				WHERE T08.DivisionID = @DivisionID 
				AND  T08.TranMonth = @TranMonth
				AND T08.TranYear = @TranYear 
				AND CONCAT(T08.InventoryID,T08.InventoryAccountID) = @InventoryIDCur AND T08.WareHouseID = @WareHouseIDCur 
				AND T08.EndAmount <> 0 AND T08.EndQuantity = 0

				-- Update AT2008 phần nhập  
				UPDATE AT2008 set  AT2008.InDebitAmount = ISNULL(AT2008.InDebitAmount,0) + A.EndAmount , AT2008.DebitAmount = ISNULL(AT2008.DebitAmount,0) + A.EndAmount,
						AT2008.EndAmount = ISNULL(AT2008.BeginAmount,0) + (ISNULL(AT2008.DebitAmount,0 )  + A.EndAmount) - (ISNULL(AT2008.CreditAmount,0)	)
				FROM AT2008 WITH (NOLOCK) 
				INNER JOIN (
					SELECT AT2006.WareHouseID, CONCAT(AT2007.InventoryID,AT2007.CreditAccountID) AS InventoryID,  @EndAmount AS EndAmount,AT2007.TranMonth,AT2007.TranYear
				FROM AT2007 WITH (NOLOCK)  
				INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID 
				INNER JOIN AT2008 T08 WITH (NOLOCK) ON  CONCAT(T08.InventoryID,T08.InventoryAccountID) =  @InventoryIDCur AND T08.WareHouseID = @WareHouseIDCur
				WHERE T08.DivisionID = @DivisionID 
				AND T08.TranMonth = @TranMonth
				AND T08.TranYear = @TranYear
				AND AT2007.TransactionID = SUBSTRING(@TransactionID,0,LEN(@TransactionID))  
				AND SUBSTRING(@TransactionID,LEN(@TransactionID),1) = '3'
				) A ON  A.InventoryID = CONCAT(AT2008.InventoryID,AT2008.InventoryAccountID) AND A.TranMonth = AT2008.TranMonth AND A.TranYear = AT2008.TranYear AND A.WareHouseID = AT2008.WareHouseID

			FETCH NEXT FROM @Cur INTO @InventoryIDCur, @WareHouseIDCur, @EndAmount, @TransactionID
		END
		CLOSE @Cur

		IF EXISTS (
		SELECT TOP 1 1 
			FROM AT2008  WITH (NOLOCK)
			WHERE DivisionID = @DivisionID
				AND TranYear = @TranYear
				AND TranMonth = @TranMonth 
				AND (WarehouseID BETWEEN @FromWarehouseID AND @ToWarehouseID)
				AND (InventoryAccountID BETWEEN @FromAccountID AND @ToAccountID)
				AND (InventoryID BETWEEN @FromInventoryID AND @ToInventoryID)
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
			
			
			IF (@CustomerName = 50 OR @CustomerName = 115) -- Mekio or Mte
				BEGIN
						EXEC AP1303_MK @DivisionID
								  , @TranMonth
								  , @TranYear
								  , @FromInventoryID
								  , @ToInventoryID
								  , @FromWareHouseID
								  , @ToWareHouseID
						
				END
			ELSE
						EXEC AP1303 @DivisionID
								  , @TranMonth
								  , @TranYear
								  , @FromInventoryID
								  , @ToInventoryID
								  , @FromWareHouseID
								  , @ToWareHouseID	
			--return -- da xu ly lam trong trong store AP1303 nen thoat luon khong vo doan lam trong ben duoi nua
		END
	
	END
END 

	-- khoa xo 
	declare @sSQL_Thu  as nvarchar(500),
			@TranMonthText AS NVARCHAR(50),
			@TranYearText AS NVARCHAR(50)
	SET @TranMonthText = Convert( NVARCHAR(2),@TranMonth)
	SET @TranYearText = Convert( NVARCHAR(6),@TranYear)
	set @sSQL_Thu = N'
						Exec AP9998 '''+@DivisionID+''', '''+@TranMonthText+''', '''+@TranYearText+''',	'+CASE WHEN @TranMonthText = '12' THEN '1' ELSE STR(CONVERT(INT,@TranMonthText) + 1) END +','+CASE WHEN @TranMonthText = '12' THEN STR(CONVERT(INT,@TranYearText) + 1) ELSE @TranYearText END +'
				'
	EXEC(@sSQL_Thu)
		IF @TranYear*100 + @TranMonth = (Select Max (Tranyear *100 + Tranmonth) FROM WT9999) 
		BEGIN
		DELETE FROM AT2008 WHERE  TranMonth = CASE WHEN @TranMonth=12 THEN 1 ELSE @TranMonth + 1 END  AND TranYear = CASE WHEN @TranMonth=12 THEN @TranYearText + 1 ELSE @TranYearText END 
		END




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
