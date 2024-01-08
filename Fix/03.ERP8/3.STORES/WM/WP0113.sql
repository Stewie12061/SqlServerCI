IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0113]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0113]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
--- Chuyển dữ liệu từ phiếu lắp ráp vào Kho và Sổ cái
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by Tiểu Mai on 27/07/2016
---- Modified by Hải Long on 12/08/2016: Bổ sung xử lý cho phiếu tháo dỡ
---- Modified by Hải Long on 16/09/2016: Bổ sung thêm trường SourceNo, LimitDate, ReVoucherID, ReTransactionID khi insert vào AT2007
---- Modified by Tiểu Mai on 16/11/2016: Bổ sung cập nhật số dư tồn kho theo lô date - TTDD
---- Modified by Bảo Thy on 26/05/2017: Sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung

-- <Example>
/*
	WP0113 'HT','AV9bac8887-aedf-4d54-a8f4-aeb1a0edf34f'
*/


CREATE PROCEDURE [DBO].[WP0113]
(
    @DivisionID NVARCHAR(50),
	@VoucherID NVARCHAR(50)
)
AS
DECLARE 					
@TableID NVARCHAR(50),					
@TranMonth	INT,			
@TranYear INT,
@VoucherTypeID NVARCHAR(50),			
@VoucherDate DATETIME,				
@VoucherNo	NVARCHAR(50),			
@ObjectID NVARCHAR(50),
@BatchID NVARCHAR(50),
@Type TINYINT,
@EmployeeID NVARCHAR(50),
@Description NVARCHAR(250),
@CreateDate DATETIME,
@CreateUserID NVARCHAR(50),
@RefNo01 NVARCHAR(100),
@RefNo02 NVARCHAR(100),
@TransactionID NVARCHAR(50),
@KindVoucherID NVARCHAR(50),
@ImWareHouseID NVARCHAR(50),
@ExWareHouseID NVARCHAR(50),
@InventoryID NVARCHAR(50),
@UnitID NVARCHAR(50),
@ActualQuantity DECIMAL(28,8),
@UnitPrice DECIMAL(28,8),
@OriginalAmount DECIMAL(28,8),
@ConvertedAmount DECIMAL(28,8),
@IsLedger TINYINT,
@Notes NVARCHAR(250),
@CurrencyID NVARCHAR(50),
@ExchangeRate DECIMAL(28,8),
@SourceNo NVARCHAR(50),
@DebitAccountID NVARCHAR(50),
@CreditAccountID NVARCHAR(50),
@LocationID NVARCHAR(50),
@ImLocationID NVARCHAR(50),
@LimitDate DATETIME,
@ConversionFactor DECIMAL(28,8),
@ImStoreManID NVARCHAR(50),
@ExStoreManID NVARCHAR(50),
@Ana01ID NVARCHAR(50),
@Ana02ID NVARCHAR(50),
@Ana03ID NVARCHAR(50),
@Ana04ID NVARCHAR(50),
@Ana05ID NVARCHAR(50),
@Ana06ID NVARCHAR(50),
@Ana07ID NVARCHAR(50),
@Ana08ID NVARCHAR(50),
@Ana09ID NVARCHAR(50),
@Ana10ID NVARCHAR(50),
@Parameter01 DECIMAL(28,8),
@Parameter02 DECIMAL(28,8),
@Parameter03 DECIMAL(28,8),
@Parameter04 DECIMAL(28,8),
@Parameter05 DECIMAL(28,8),
@Parameter06 DECIMAL(28,8),
@Parameter07 DECIMAL(28,8),
@Parameter08 DECIMAL(28,8),
@Parameter09 DECIMAL(28,8),
@Parameter10 DECIMAL(28,8),
@ConvertedQuantity DECIMAL(28,8),
@ConvertedPrice DECIMAL(28,8),
@ConvertedUnitID NVARCHAR(50),
@ReVoucherID NVARCHAR(50),
@ReTransactionID NVARCHAR(50),
@VoucherIDNew NVARCHAR(50),
@TransactionIDNew NVARCHAR(50),
@Cur_Ware AS CURSOR,
@IsSource TINYINT,
@IsLimitDate TINYINT,
@MethodID INT ,
@IsNotUpdatePrice TINYINT,
@IsReturn TINYINT,
@Customername INT

SET @CustomerName = (Select CustomerName from CustomerIndex)

SET @Cur_Ware = CURSOR SCROLL KEYSET FOR 
SELECT AT0112.VoucherID, AT0112.TableID, AT0112.TranMonth,AT0112.TranYear, AT0112.VoucherTypeID, AT0112.VoucherDate,
AT0112.VoucherNo,AT0112.ObjectID,AT0112.BatchID,AT0112.[Type],AT0112.EmployeeID,AT0112.[Description],AT0112.CreateDate,AT0112.CreateUserID,AT0112.RefNo01,
AT0112.RefNo02, AT0113.TransactionID, AT0113.KindVoucherID, AT0113.ImWareHouseID, AT0113.ExWareHouseID, 
AT0113.InventoryID, AT0113.UnitID, AT0113.ActualQuantity, AT0113.UnitPrice, AT0113.OriginalAmount, AT0113.ConvertedAmount,
Isnull(AT0113.IsLedger,0), AT0113.Notes, AT0113.CurrencyID, AT0113.ExchangeRate, AT0113.SourceNo, AT0113.DebitAccountID, AT0113.CreditAccountID,
AT0113.LocationID, AT0113.ImLocationID, AT0113.LimitDate, AT0113.ConversionFactor,
AT0113.ImStoreManID,AT0113.ExStoreManID,AT0113.Ana01ID,AT0113.Ana02ID, AT0113.Ana03ID, AT0113.Ana04ID, AT0113.Ana05ID, 
AT0113.Ana06ID, AT0113.Ana07ID, AT0113.Ana08ID, AT0113.Ana09ID, AT0113.Ana10ID,
AT0113.Parameter01, AT0113.Parameter02, AT0113.Parameter03, AT0113.Parameter04, AT0113.Parameter05,
AT0113.Parameter06, AT0113.Parameter07, AT0113.Parameter08, AT0113.Parameter09, AT0113.Parameter10,
AT0113.ConvertedQuantity, AT0113.ConvertedPrice, AT0113.ConvertedUnitID, ReVoucherID, ReTransactionID, AT1302.IsSource, AT1302.IsLimitDate, AT1302.MethodID,
AT0113.IsNotUpdatePrice, AT0113.IsReturn
FROM AT0112 WITH (NOLOCK)
LEFT JOIN AT0113 WITH (NOLOCK) ON AT0113.DivisionID = AT0112.DivisionID AND AT0113.VoucherID = AT0112.VoucherID
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN ('@@@', AT0113.DivisionID) AND AT1302.InventoryID = AT0113.InventoryID
WHERE AT0112.DivisionID = @DivisionID
AND AT0112.VoucherID = @VoucherID

OPEN @Cur_Ware
FETCH NEXT FROM @Cur_Ware INTO  @VoucherID, @TableID, @TranMonth,@TranYear,@VoucherTypeID,@VoucherDate,
@VoucherNo,@ObjectID,@BatchID,@Type,@EmployeeID,@Description,@CreateDate,@CreateUserID,@RefNo01,
@RefNo02, @TransactionID, @KindVoucherID, @ImWareHouseID, @ExWareHouseID, 
@InventoryID, @UnitID, @ActualQuantity, @UnitPrice, @OriginalAmount, @ConvertedAmount,
@IsLedger, @Notes, @CurrencyID, @ExchangeRate, @SourceNo, @DebitAccountID, @CreditAccountID,
@LocationID, @ImLocationID, @LimitDate, @ConversionFactor,
@ImStoreManID,@ExStoreManID,@Ana01ID,@Ana02ID, @Ana03ID, @Ana04ID, @Ana05ID, 
@Ana06ID, @Ana07ID, @Ana08ID, @Ana09ID, @Ana10ID,
@Parameter01, @Parameter02, @Parameter03, @Parameter04, @Parameter05,
@Parameter06, @Parameter07, @Parameter08, @Parameter09, @Parameter10,
@ConvertedQuantity, @ConvertedPrice, @ConvertedUnitID, @ReVoucherID, @ReTransactionID, @IsSource, @IsLimitDate, @MethodID, @IsNotUpdatePrice, @IsReturn

WHILE @@Fetch_Status = 0 
    BEGIN
    	SET @VoucherIDNew = NEWID()
    	SET @TransactionIDNew = NEWID()

    	--SELECT 1  
    	IF NOT EXISTS (SELECT TOP 1 1 FROM AT2007 WITH (NOLOCK) WHERE  DivisionID = @DivisionID AND InheritTableID  = @TableID AND InheritVoucherID = @VoucherID AND InheritTransactionID = @TransactionID )
    	BEGIN 
			IF (@Type = 0)
			BEGIN
				IF @CustomerName = 57
					INSERT INTO AT2006 (DivisionID, VoucherID,TableID,TranMonth,TranYear,VoucherTypeID,VoucherDate,VoucherNo
										,ObjectID,BatchID,WareHouseID,KindVoucherID,STATUS,EmployeeID,Description
										,CreateDate,CreateUserID,LastModifyUserID,LastModifyDate,RefNo01,RefNo02,InventoryTypeID, IsNotUpdatePrice, IsReturn)
    				VALUES (@DivisionID, @VoucherIDNew, @TableID,@TranMonth,@TranYear,@VoucherTypeID,@VoucherDate,@VoucherNo,@ObjectID,@BatchID,
    						(CASE WHEN @KindVoucherID = 1 then @ImWareHouseID ELSE @ExWareHouseID END) ,@KindVoucherID,0,@EmployeeID,
							(CASE WHEN @KindVoucherID = 1 THEN N'Phiếu nhập TP từ lắp ráp' ELSE N'Phiếu xuất NVL đi lắp ráp' END),
							@CreateDate,@CreateUserID,@CreateUserID,@CreateDate,@RefNo01,@RefNo02,'%', @IsNotUpdatePrice, @IsReturn)
				else
    				INSERT INTO AT2006 (DivisionID, VoucherID,TableID,TranMonth,TranYear,VoucherTypeID,VoucherDate,VoucherNo
										,ObjectID,BatchID,WareHouseID,KindVoucherID,STATUS,EmployeeID,Description
										,CreateDate,CreateUserID,LastModifyUserID,LastModifyDate,RefNo01,RefNo02,InventoryTypeID)
    				VALUES (@DivisionID, @VoucherIDNew, @TableID,@TranMonth,@TranYear,@VoucherTypeID,@VoucherDate,@VoucherNo,@ObjectID,@BatchID,
    						(CASE WHEN @KindVoucherID = 1 then @ImWareHouseID ELSE @ExWareHouseID END) ,@KindVoucherID,0,@EmployeeID,
							(CASE WHEN @KindVoucherID = 1 THEN N'Phiếu nhập TP từ lắp ráp' ELSE N'Phiếu xuất NVL đi lắp ráp' END),
							@CreateDate,@CreateUserID,@CreateUserID,@CreateDate,@RefNo01,@RefNo02,'%')
			END
			ELSE
			BEGIN
    			INSERT INTO AT2006 (DivisionID, VoucherID,TableID,TranMonth,TranYear,VoucherTypeID,VoucherDate,VoucherNo
									,ObjectID,BatchID,WareHouseID,KindVoucherID,STATUS,EmployeeID,Description
									,CreateDate,CreateUserID,LastModifyUserID,LastModifyDate,RefNo01,RefNo02,InventoryTypeID, IsNotUpdatePrice, IsReturn)
    			VALUES (@DivisionID, @VoucherIDNew, @TableID,@TranMonth,@TranYear,@VoucherTypeID,@VoucherDate,@VoucherNo,@ObjectID,@BatchID,
    					(CASE WHEN @KindVoucherID = 1 then @ImWareHouseID ELSE @ExWareHouseID END) ,@KindVoucherID,0,@EmployeeID,
						(CASE WHEN @KindVoucherID = 1 THEN N'Phiếu nhập NVL từ tháo dở' ELSE N'Phiếu xuất TP đi tháo dở' END),
						@CreateDate,@CreateUserID,@CreateUserID,@CreateDate,@RefNo01,@RefNo02,'%', @IsNotUpdatePrice, @IsReturn)
			END
    		INSERT INTO AT2007 (DivisionID, TransactionID, VoucherID, BatchID, InventoryID, UnitID, ActualQuantity, UnitPrice, OriginalAmount, ConvertedAmount,Notes,
    							TranMonth, TranYear, CurrencyID, ExchangeRate, DebitAccountID, CreditAccountID, LocationID, ImLocationID, ConversionFactor, 
    							Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID, ConvertedQuantity, ConvertedPrice, ConvertedUnitID,
    							InheritTableID, InheritVoucherID, InheritTransactionID, SourceNo, LimitDate, ReVoucherID, ReTransactionID, MarkQuantity)
    		VALUES (@DivisionID, @TransactionIDNew, @VoucherIDNew, @BatchID, @InventoryID, @UnitID, @ActualQuantity, @UnitPrice, @OriginalAmount, @ConvertedAmount,@Notes,
    							@TranMonth, @TranYear, @CurrencyID, @ExchangeRate, @DebitAccountID, @CreditAccountID, @LocationID, @ImLocationID, @ConversionFactor, 
    							@Ana01ID, @Ana02ID, @Ana03ID, @Ana04ID, @Ana05ID, @Ana06ID, @Ana07ID, @Ana08ID, @Ana09ID, @Ana10ID, @ConvertedQuantity, @ConvertedPrice,@ConvertedUnitID,
    							@TableID, @VoucherID, @TransactionID, @SourceNo, @LimitDate, @ReVoucherID, @ReTransactionID, @ActualQuantity)

		END 
		IF @KindVoucherID = 2 AND (@IsSource <> 0 OR @IsLimitDate <> 0 OR @MethodID = 3) ---------- Update tồn kho theo lô date - TTDD
		BEGIN
			UPDATE AT0114
			 SET
				 DeQuantity = DeQuantity + @ActualQuantity,
				 DeMarkQuantity = DeMarkQuantity + @ConvertedQuantity
			WHERE DivisionID = @DivisionID AND WareHouseID = @ExWareHouseID AND InventoryID = @InventoryID 
				 AND ReVoucherID = @ReVoucherID AND ReTransactionID = @ReTransactionID

			UPDATE AT0114
			SET EndQuantity = isnull(EndQuantity, 0) - @ActualQuantity,
				EndMarkQuantity = isnull(EndMarkQuantity , 0) - @ConvertedQuantity
			WHERE DivisionID = @DivisionID AND WareHouseID = @ExWareHouseID AND InventoryID = @InventoryID 
				AND ReVoucherID = @ReVoucherID AND ReTransactionID = @ReTransactionID

		END
		
		IF @CustomerName = 57
		BEGIN
			IF @IsLedger = 0
			BEGIN 
				IF NOT EXISTS (SELECT TOP 1 1 FROM AT9000 WHERE DivisionID = @DivisionID AND BatchID = @VoucherID AND VoucherNo = @VoucherNo 
																AND CreditAccountID = @CreditAccountID AND DebitAccountID = @DebitAccountID)		
				BEGIN
					IF @Type = 0
					BEGIN 	
						INSERT INTO AT9000  
						(VoucherID, BatchID, TransactionID, TableID,   
						DivisionID, TranMonth, TranYear, TransactionTypeID,   
						CurrencyID, CurrencyIDCN, ObjectID, DebitAccountID, CreditAccountID,   
						ExchangeRate, OriginalAmount, ConvertedAmount,   
						ExchangeRateCN, OriginalAmountCN,   
						VoucherDate, VoucherTypeID, VoucherNo,   
						Orders, EmployeeID,   
						Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID,   
						Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,   
						VDescription, BDescription, TDescription, 
						Quantity, UnitPrice,   
						InventoryID, UnitID, Status,    
						CreateDate, CreateUserID, LastModifyDate, LastModifyUserID,
						ConvertedUnitID, ConvertedQuantity, ConvertedPrice)  
			 
						SELECT @VoucherIDNew, @VoucherID, @TransactionIDNew, AT0112.TableID, 
							AT0112.DivisionID, AT0112.TranMonth,AT0112.TranYear, 
							CASE WHEN KindVoucherID IN (1, 3, 5, 7, 9, 15, 17) THEN 'T05' ELSE  
							CASE WHEN KindVoucherID IN ( 2, 4, 6, 8, 10, 14, 20) THEN 'T06' ELSE 'T99' END END, 
							MAX(AT0113.CurrencyID), MAX(AT0113.CurrencyID), AT0112.ObjectID, AT0113.DebitAccountID, AT0113.CreditAccountID,
							MAX(AT0113.ExchangeRate), SUM(AT0113.OriginalAmount), SUM(ConvertedAmount),
							MAX(AT0113.ExchangeRate), SUM(AT0113.OriginalAmount),   
							AT0112.VoucherDate, AT0112.VoucherTypeID, AT0112.VoucherNo,   
							1, AT0112.EmployeeID,   
							MAX(AT0113.Ana01ID) AS Ana01ID, MAX(AT0113.Ana02ID) Ana02ID, MAX(AT0113.Ana03ID) Ana03ID, MAX(AT0113.Ana04ID) Ana04ID, MAX(AT0113.Ana05ID) Ana05ID,   
							MAX(AT0113.Ana06ID) AS Ana06ID, MAX(AT0113.Ana07ID) Ana07ID, MAX(AT0113.Ana08ID) Ana08ID, MAX(AT0113.Ana09ID) Ana09ID, MAX(AT0113.Ana10ID) Ana10ID,   
							(CASE WHEN @KindVoucherID = 1 THEN N'Phiếu nhập NVL từ tháo dở' ELSE N'Phiếu xuất NPL đi lắp ráp' END),
							(CASE WHEN @KindVoucherID = 1 THEN N'Phiếu nhập NVL từ tháo dở' ELSE N'Phiếu xuất NPL đi lắp ráp' END),
							(CASE WHEN @KindVoucherID = 1 THEN N'Phiếu nhập NVL từ tháo dở' ELSE N'Phiếu xuất NPL đi lắp ráp' END), 
							(SELECT TOP 1 ActualQuantity FROM AT0113 A13 WITH (NOLOCK) WHERE A13.DivisionID = @DivisionID 
																				AND A13.VoucherID = @VoucherID AND A13.DebitAccountID = @DebitAccountID AND A13.CreditAccountID = @CreditAccountID
																				AND A13.KindVoucherID = 2 AND ISNULL(A13.IsLedger,0) = 0 AND @Type = 0) AS Quantity, 
							SUM(ConvertedAmount)/(SELECT TOP 1 ActualQuantity FROM AT0113 A13 WITH (NOLOCK) WHERE A13.DivisionID = @DivisionID
																				AND A13.VoucherID = @VoucherID AND A13.DebitAccountID = @DebitAccountID AND A13.CreditAccountID = @CreditAccountID 
																				AND A13.KindVoucherID = 2 AND ISNULL(A13.IsLedger,0) = 0 AND @Type = 0) AS UnitPrice,   
							(SELECT TOP 1 InventoryID FROM AT0113 A13 WITH (NOLOCK) WHERE A13.DivisionID = @DivisionID
																				AND A13.VoucherID = @VoucherID AND A13.DebitAccountID = @DebitAccountID AND A13.CreditAccountID = @CreditAccountID 
																				AND A13.KindVoucherID = 2 AND ISNULL(A13.IsLedger,0) = 0 AND @Type = 0) AS InventoryID, 
							(SELECT TOP 1 UnitID FROM AT0113 A13 WITH (NOLOCK) WHERE A13.DivisionID = @DivisionID
																				AND A13.VoucherID = @VoucherID AND A13.DebitAccountID = @DebitAccountID AND A13.CreditAccountID = @CreditAccountID 
																				AND A13.KindVoucherID = 2 AND ISNULL(A13.IsLedger,0) = 0 AND @Type = 0) AS UnitID, 
							0,      
							AT0112.CreateDate,AT0112.CreateUserID, AT0112.CreateDate, AT0112.CreateUserID,   
							(SELECT TOP 1  UnitID FROM AT0113 A13 WITH (NOLOCK) WHERE A13.DivisionID = @DivisionID
																				AND A13.VoucherID = @VoucherID AND A13.DebitAccountID = @DebitAccountID AND A13.CreditAccountID = @CreditAccountID 
																				AND A13.KindVoucherID = 2 AND ISNULL(A13.IsLedger,0) = 0 AND @Type = 0) AS ConvertedUnitID, 
							(SELECT TOP 1 ActualQuantity FROM AT0113 A13 WITH (NOLOCK) WHERE A13.DivisionID = @DivisionID
																				AND A13.VoucherID = @VoucherID AND A13.DebitAccountID = @DebitAccountID AND A13.CreditAccountID = @CreditAccountID
																				AND A13.KindVoucherID = 2 AND ISNULL(A13.IsLedger,0) = 0 AND @Type = 0) AS ConvertedQuantity, 
							SUM(ConvertedAmount)/(SELECT TOP 1 ActualQuantity FROM AT0113 A13 WITH (NOLOCK) WHERE A13.DivisionID = @DivisionID 
																				AND A13.VoucherID = @VoucherID AND A13.DebitAccountID = @DebitAccountID AND A13.CreditAccountID = @CreditAccountID 
																				AND A13.KindVoucherID = 2 AND ISNULL(A13.IsLedger,0) = 0 AND @Type = 0) AS ConvertedPrice
			
						FROM AT0112 WITH (NOLOCK)
						LEFT JOIN AT0113 WITH (NOLOCK) ON AT0113.DivisionID = AT0112.DivisionID AND AT0113.VoucherID = AT0112.VoucherID
						LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID = AT0113.DivisionID AND AT1302.InventoryID = AT0113.InventoryID
						WHERE AT0112.DivisionID = @DivisionID
						AND AT0112.VoucherID = @VoucherID AND @KindVoucherID = 2 AND KindVoucherID = 2 AND DebitAccountID = @DebitAccountID AND CreditAccountID = @CreditAccountID
						GROUP BY AT0112.VoucherID, AT0112.BatchID, AT0112.TableID, AT0112.DivisionID, AT0112.TranMonth,AT0112.TranYear, 
							AT0113.DebitAccountID, AT0113.CreditAccountID, AT0112.ObjectID, AT0113.KindVoucherID,
							AT0112.VoucherDate, AT0112.VoucherTypeID, AT0112.VoucherNo, AT0112.EmployeeID, AT0112.CreateDate,AT0112.CreateUserID
					END
					ELSE
					BEGIN
						INSERT INTO AT9000  
						(VoucherID, BatchID, TransactionID, TableID,   
						DivisionID, TranMonth, TranYear, TransactionTypeID,   
						CurrencyID, CurrencyIDCN, ObjectID, DebitAccountID, CreditAccountID,   
						ExchangeRate, OriginalAmount, ConvertedAmount,   
						ExchangeRateCN, OriginalAmountCN,   
						VoucherDate, VoucherTypeID, VoucherNo,   
						Orders, EmployeeID,   
						Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID,   
						Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,   
						VDescription, BDescription, TDescription, 
						Quantity, UnitPrice,   
						InventoryID, UnitID, Status,    
						CreateDate, CreateUserID, LastModifyDate, LastModifyUserID,
						ConvertedUnitID, ConvertedQuantity, ConvertedPrice)  
			 
						SELECT @VoucherIDNew, @VoucherID, @TransactionIDNew, AT0112.TableID, 
							AT0112.DivisionID, AT0112.TranMonth,AT0112.TranYear, 
							CASE WHEN KindVoucherID IN (1, 3, 5, 7, 9, 15, 17) THEN 'T05' ELSE  
							CASE WHEN KindVoucherID IN ( 2, 4, 6, 8, 10, 14, 20) THEN 'T06' ELSE 'T99' END END, 
							MAX(AT0113.CurrencyID), MAX(AT0113.CurrencyID), AT0112.ObjectID, AT0113.DebitAccountID, AT0113.CreditAccountID,
							MAX(AT0113.ExchangeRate), SUM(AT0113.OriginalAmount), SUM(ConvertedAmount),
							MAX(AT0113.ExchangeRate), SUM(AT0113.OriginalAmount),   
							AT0112.VoucherDate, AT0112.VoucherTypeID, AT0112.VoucherNo,   
							1, AT0112.EmployeeID,   
							MAX(AT0113.Ana01ID) AS Ana01ID, MAX(AT0113.Ana02ID) Ana02ID, MAX(AT0113.Ana03ID) Ana03ID, MAX(AT0113.Ana04ID) Ana04ID, MAX(AT0113.Ana05ID) Ana05ID,   
							MAX(AT0113.Ana06ID) AS Ana06ID, MAX(AT0113.Ana07ID) Ana07ID, MAX(AT0113.Ana08ID) Ana08ID, MAX(AT0113.Ana09ID) Ana09ID, MAX(AT0113.Ana10ID) Ana10ID,   
							(CASE WHEN @KindVoucherID = 1 THEN N'Phiếu nhập NVL từ tháo dở' ELSE N'Phiếu xuất NPL đi lắp ráp' END),
							(CASE WHEN @KindVoucherID = 1 THEN N'Phiếu nhập NVL từ tháo dở' ELSE N'Phiếu xuất NPL đi lắp ráp' END),
							(CASE WHEN @KindVoucherID = 1 THEN N'Phiếu nhập NVL từ tháo dở' ELSE N'Phiếu xuất NPL đi lắp ráp' END), 
							(SELECT TOP 1 ActualQuantity FROM AT0113 A13 WITH (NOLOCK) WHERE A13.DivisionID = @DivisionID 
																				AND A13.VoucherID = @VoucherID AND A13.DebitAccountID = @DebitAccountID AND A13.CreditAccountID = @CreditAccountID
																				AND A13.KindVoucherID = 1 AND ISNULL(A13.IsLedger,0) = 0 AND @Type = 1) AS Quantity, 
							SUM(ConvertedAmount)/(SELECT TOP 1 ActualQuantity FROM AT0113 A13 WITH (NOLOCK) WHERE A13.DivisionID = @DivisionID
																				AND A13.VoucherID = @VoucherID AND A13.DebitAccountID = @DebitAccountID AND A13.CreditAccountID = @CreditAccountID 
																				AND A13.KindVoucherID = 1 AND ISNULL(A13.IsLedger,0) = 0 AND @Type = 1) AS UnitPrice,   
							(SELECT TOP 1 InventoryID FROM AT0113 A13 WITH (NOLOCK) WHERE A13.DivisionID = @DivisionID
																				AND A13.VoucherID = @VoucherID AND A13.DebitAccountID = @DebitAccountID AND A13.CreditAccountID = @CreditAccountID  
																				AND A13.KindVoucherID = 1 AND ISNULL(A13.IsLedger,0) = 0 AND @Type = 1) AS InventoryID, 
							(SELECT TOP 1 UnitID FROM AT0113 A13 WITH (NOLOCK) WHERE A13.DivisionID = @DivisionID
																				AND A13.VoucherID = @VoucherID AND A13.DebitAccountID = @DebitAccountID AND A13.CreditAccountID = @CreditAccountID 
																				AND A13.KindVoucherID = 1 AND ISNULL(A13.IsLedger,0) = 0 AND @Type = 1) AS UnitID, 
							0,      
							AT0112.CreateDate,AT0112.CreateUserID, AT0112.CreateDate, AT0112.CreateUserID,   
							(SELECT TOP 1  UnitID FROM AT0113 A13 WITH (NOLOCK) WHERE A13.DivisionID = @DivisionID
																				AND A13.VoucherID = @VoucherID AND A13.DebitAccountID = @DebitAccountID AND A13.CreditAccountID = @CreditAccountID 
																				AND A13.KindVoucherID = 1 AND ISNULL(A13.IsLedger,0) = 0 AND @Type = 1) AS ConvertedUnitID, 
							(SELECT TOP 1 ActualQuantity FROM AT0113 A13 WITH (NOLOCK) WHERE A13.DivisionID = @DivisionID
																				AND A13.VoucherID = @VoucherID AND A13.DebitAccountID = @DebitAccountID AND A13.CreditAccountID = @CreditAccountID
																				AND A13.KindVoucherID = 1 AND ISNULL(A13.IsLedger,0) = 0 AND @Type = 1) AS ConvertedQuantity, 
							SUM(ConvertedAmount)/(SELECT TOP 1 ActualQuantity FROM AT0113 A13 WITH (NOLOCK) WHERE A13.DivisionID = @DivisionID 
																				AND A13.VoucherID = @VoucherID AND A13.DebitAccountID = @DebitAccountID AND A13.CreditAccountID = @CreditAccountID 
																				AND A13.KindVoucherID = 1 AND ISNULL(A13.IsLedger,0) = 0 AND @Type = 1) AS ConvertedPrice
			
						FROM AT0112 WITH (NOLOCK)
						LEFT JOIN AT0113 WITH (NOLOCK) ON AT0113.DivisionID = AT0112.DivisionID AND AT0113.VoucherID = AT0112.VoucherID
						LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID = AT0113.DivisionID AND AT1302.InventoryID = AT0113.InventoryID
						WHERE AT0112.DivisionID = @DivisionID
						AND AT0112.VoucherID = @VoucherID AND @KindVoucherID = 1 AND KindVoucherID = 1 AND DebitAccountID = @DebitAccountID AND CreditAccountID = @CreditAccountID
						GROUP BY AT0112.VoucherID, AT0112.BatchID, AT0112.TableID, AT0112.DivisionID, AT0112.TranMonth,AT0112.TranYear, 
							AT0113.DebitAccountID, AT0113.CreditAccountID, AT0112.ObjectID, AT0113.KindVoucherID,
							AT0112.VoucherDate, AT0112.VoucherTypeID, AT0112.VoucherNo, AT0112.EmployeeID, AT0112.CreateDate,AT0112.CreateUserID
				
					END	
				END 
			END 
		END

        FETCH NEXT FROM @Cur_Ware INTO @VoucherID, @TableID,@TranMonth,@TranYear,@VoucherTypeID,@VoucherDate,
@VoucherNo,@ObjectID,@BatchID,@Type,@EmployeeID,@Description,@CreateDate,@CreateUserID,@RefNo01,
@RefNo02, @TransactionID, @KindVoucherID, @ImWareHouseID, @ExWareHouseID, 
@InventoryID, @UnitID, @ActualQuantity, @UnitPrice, @OriginalAmount, @ConvertedAmount,
@IsLedger, @Notes, @CurrencyID, @ExchangeRate, @SourceNo, @DebitAccountID, @CreditAccountID,
@LocationID, @ImLocationID, @LimitDate, @ConversionFactor,
@ImStoreManID,@ExStoreManID,@Ana01ID,@Ana02ID, @Ana03ID, @Ana04ID, @Ana05ID, 
@Ana06ID, @Ana07ID, @Ana08ID, @Ana09ID, @Ana10ID,
@Parameter01, @Parameter02, @Parameter03, @Parameter04, @Parameter05,
@Parameter06, @Parameter07, @Parameter08, @Parameter09, @Parameter10,
@ConvertedQuantity, @ConvertedPrice, @ConvertedUnitID, @ReVoucherID, @ReTransactionID, @IsSource, @IsLimitDate, @MethodID, @IsNotUpdatePrice, @IsReturn
    END 

CLOSE @Cur_Ware





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
