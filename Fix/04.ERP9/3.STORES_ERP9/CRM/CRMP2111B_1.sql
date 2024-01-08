IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP2111B_1]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP2111B_1]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- 
----</Summary>
-- <History>
---		[Minh Dũng]  Create on 11/11/2023
---		[Minh Dũng]  Update on 28/11/2023: Lấy giá dựa theo quy cách
---</History>

CREATE PROCEDURE [dbo].[CRMP2111B_1] 
    @DivisionID NVARCHAR(50), 
    @TranMonth INT, 
    @TranYear INT, 
    @FromInventoryID NVARCHAR(50), 
    @ToInventoryID NVARCHAR(50), 
    @FromWareHouseID NVARCHAR(50), 
    @ToWareHouseID NVARCHAR(50), 
    @FromAccountID NVARCHAR(50), 
    @ToAccountID NVARCHAR(50)
AS

DECLARE @CountTest INT = 0;
DECLARE @APK_AT2007 NVARCHAR(50) = NULL
									
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

		--Cap nhat gia xuat tra lai hang mua = gia cua phieu tra lai hang mua
		UPDATE #AT2007_Result 
		SET #AT2007_Result.UnitPrice = (CASE WHEN ActualQuantity <> 0 
									 THEN ROUND(AT9000.ConvertedAmount/ActualQuantity, @UnitCostDecimals) 
									 ELSE 0 
								END)
			, #AT2007_Result.ConvertedPrice =  (CASE WHEN ActualQuantity <> 0 
										   THEN ROUND(AT9000.ConvertedAmount / ActualQuantity, @UnitCostDecimals) 
										   ELSE 0 
									    END)
			, OriginalAmount = AT9000.ConvertedAmount
			, ConvertedAmount = AT9000.ConvertedAmount
		FROM #AT2007_Result WITH (ROWLOCK)
			INNER JOIN AT2006 WITH (ROWLOCK) ON AT2006.DivisionID = #AT2007_Result.DivisionID 
													AND AT2006.VoucherID = #AT2007_Result.VoucherID
			INNER JOIN AT9000 WITH (ROWLOCK) ON AT9000.DivisionID = #AT2007_Result.DivisionID 
													AND AT9000.VoucherID = #AT2007_Result.VoucherID 
													AND AT9000.TransactionID = #AT2007_Result.TransactionID
		WHERE #AT2007_Result.DivisionID =@DivisionID
			AND #AT2007_Result.TranMonth = @TranMonth 
			AND #AT2007_Result.TranYear = @TranYear 
			AND AT2006.KindVoucherID = 10
			AND AT9000.TransactionTypeID = 'T25' 
			AND AT9000.TranMonth = @TranMonth 
			AND AT9000.TranYear = @TranYear
	


		IF @CustomerName <> 49 --- <> FIGLA
			UPDATE #AT2007_Result
			SET UnitPrice = 0,
				ConvertedPrice = 0, 
				OriginalAmount = 0, 
				ConvertedAmount = 0
			FROM #AT2007_Result WITH (ROWLOCK) 
			WHERE #AT2007_Result.DivisionID = @DivisionID 
				AND #AT2007_Result.TranYear = @TranYear
				AND #AT2007_Result.TranMonth = @TranMonth 
				AND (#AT2007_Result.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID)
				AND (#AT2007_Result.CreditAccountID BETWEEN @FromAccountID AND @ToAccountID)
				AND (SELECT MethodID 
					 FROM AT1302 WITH (NOLOCK) 
					 WHERE DivisionID IN (#AT2007_Result.DivisionID,'@@@') 
							AND InventoryID = #AT2007_Result.InventoryID
					) IN (5)
				AND (SELECT KindVoucherID 
						FROM AT2006 WITH (NOLOCK) 
						WHERE DivisionID = #AT2007_Result.DivisionID 
							AND VoucherID = #AT2007_Result.VoucherID
					) = 3
				AND (SELECT WareHouseID2 
						FROM AT2006 WITH (NOLOCK) 
						WHERE DivisionID = #AT2007_Result.DivisionID 
							AND VoucherID = #AT2007_Result.VoucherID
					) BETWEEN @FromWareHouseID AND @ToWareHouseID
		 
		ELSE --- FIGLA
			UPDATE #AT2007_Result 
			SET UnitPrice = 0,
				ConvertedPrice = 0, 
				OriginalAmount = 0, 
				ConvertedAmount = 0
			FROM #AT2007_Result WITH (ROWLOCK) 
				INNER JOIN AT2006 WITH (NOLOCK) ON #AT2007_Result.DivisionID = AT2006.DivisionID 
													AND #AT2007_Result.VoucherID = AT2006.VoucherID
				INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (#AT2007_Result.DivisionID,'@@@') AND #AT2007_Result.InventoryID = AT1302.InventoryID
			WHERE #AT2007_Result.TranMonth = @TranMonth 
				AND #AT2007_Result.TranYear = @TranYear
				AND (#AT2007_Result.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID) 
				AND MethodID IN (4, 5)
				AND (WareHouseID2 BETWEEN @FromWareHouseID AND @ToWareHouseID )
				AND (CreditAccountID BETWEEN @FromAccountID AND @ToAccountID )
				AND KindVoucherID IN (2,3)
				AND #AT2007_Result.DivisionID = @DivisionID

		------------ Xu ly chi tiet gia 
	
		----------- Tinh gia xuat kho binh quan lien hoan
		IF EXISTS 
		(
			SELECT TOP 1 1 
			FROM #AT2007_Result WITH (NOLOCK) 
				INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = #AT2007_Result.DivisionID 
													AND AT2006.VoucherID = #AT2007_Result.VoucherID
				INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (#AT2007_Result.DivisionID,'@@@') AND AT1302.InventoryID = #AT2007_Result.InventoryID
			WHERE #AT2007_Result.DivisionID = @DivisionID 
			AND #AT2007_Result.TranYear = @TranYear 
			AND #AT2007_Result.TranMonth = @TranMonth 
			AND KindVoucherID IN (2, 3, 4, 6, 8) 
			AND AT1302.MethodID = 5
		)
		BEGIN 

			EXEC CRMP2111B @DivisionID
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
