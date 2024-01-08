IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WY8899]') AND OBJECTPROPERTY(ID, N'IsTrigger') = 1)
DROP TRIGGER [DBO].[WY8899]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



--- Created by Tiểu Mai, on 03/11/2015
--- Purpose: Insert tồn kho theo quy cách hàng hóa.
--- Modified by Tieu Mai on 14/03/2016: Bổ sung TableID ở AT2006
--- Modified by Tiểu Mai on 18/10/2016: Sửa cập nhật tồn kho
--- Modified by Bảo Thy on 03/04/2017: Bổ sung Distinct khi set giá trị @Table
--- Modified by Bảo Thy on 20/04/2017: Bổ sung Insert/update AT0114 khi tính theo PP FIFO có quy cách (TUNGTEX)
--- Modified by Bảo Thy on 10/05/2017: Sửa danh mục dùng chung
--- Modified by Bảo Thy on 30/05/2017: Nếu lập phiếu xuất kho giảm giá hàng bán => update AT0114 đơn giá mặt hàng = đơn giá cũ - số tiền được giảm
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung



CREATE TRIGGER [dbo].[WY8899] ON [dbo].[WT8899]
FOR INSERT 
AS

DECLARE 
    @D89_Cursor CURSOR, 
	@KindVoucherID TINYINT, 
	@TransactionID NVARCHAR(50), 
	@DivisionID NVARCHAR(50),
	@RDVoucherID NVARCHAR(50), 
	@VoucherNo NVARCHAR(50),
	@VoucherDate DATETIME,
	@TranYear INT, 
	@TranMonth INT, 
	@InventoryID NVARCHAR(50), 
	@UnitID NVARCHAR(50),
	@ActualQuantity DECIMAL(28, 8), 
	@UnitPrice DECIMAL(28, 8),
	@ConvertedQuantity DECIMAL(28, 8), 
	@ConvertedUnitPrice DECIMAL(28, 8), 
	@ConvertedAmount DECIMAL(28, 8), 
	@OriginalAmount DECIMAL(28, 8), 
	@DebitAccountID NVARCHAR(50), 
	@CreditAccountID NVARCHAR(50), 
	@WareHouseID NVARCHAR(50),
	@WareHouseID2 NVARCHAR(50), 
	@PeriodID NVARCHAR(50), 
	@ProductID NVARCHAR(50), 
	@ConvertedUnitID NVARCHAR(50),
	@IsUpdatePrice TINYINT,
	@TableID NVARCHAR(50),
	@S01ID VARCHAR(50),
	@S02ID VARCHAR(50),
    @S03ID VARCHAR(50),
    @S04ID VARCHAR(50),
    @S05ID VARCHAR(50),
    @S06ID VARCHAR(50),
    @S07ID VARCHAR(50),
    @S08ID VARCHAR(50),
    @S09ID VARCHAR(50),
    @S10ID VARCHAR(50),
    @S11ID VARCHAR(50),
    @S12ID VARCHAR(50),
    @S13ID VARCHAR(50),
    @S14ID VARCHAR(50),
    @S15ID VARCHAR(50),
    @S16ID VARCHAR(50),
    @S17ID VARCHAR(50),
    @S18ID VARCHAR(50),
    @S19ID VARCHAR(50),
    @S20ID VARCHAR(50),
	@IsTemp TINYINT,
	@IsGoodsFirstVoucher AS TINYINT,
	@InheritTableID VARCHAR(50),
	@QC_OriginalQuantity DECIMAL(28,8),
    @QC_OriginalAmount DECIMAL(28,8),
    @QC_ConvertedQuantity DECIMAL(28,8),
    @QC_ConvertedAmount DECIMAL(28,8),
	@SourceNo NVARCHAR(50),
	@MarkQuantity DECIMAL(28,8),
	@IsSource TINYINT,
	@IsLimitDate TINYINT,
	@MethodID TINYINT,
	@LimitDate DATETIME,
	@ReVoucherID NVARCHAR(50),
	@ReTransactionID NVARCHAR(50)


SET @TableID = (SELECT DISTINCT TableID FROM Inserted)

IF @TableID IN ( 'AT2007', 'MT0810')
BEGIN
	SET @D89_Cursor = CURSOR SCROLL KEYSET FOR
    SELECT Inserted.TransactionID, Inserted.DivisionID, Inserted.VoucherID, AT2006.VoucherNo, AT2006.TranYear, AT2006.TranMonth, AT2006.VoucherDate, ---- Thong tin chung 
    AT2006.WareHouseID, AT2006.WareHouseID2, AT2006.KindVoucherID,
    AT2007.InventoryID, AT2007.UnitID, ActualQuantity, UnitPrice, ISNULL(ConvertedQuantity, 0),
    ISNULL(ConvertedPrice,0), OriginalAmount, ConvertedAmount, DebitAccountID, CreditAccountID,  
    AT2007.PeriodID, AT2007.ProductID,  
    AT2007.ConvertedUnitID, 
    S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID,
	S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID, AT1303.IsTemp, AT2006.IsGoodsFirstVoucher, AT2006.TableID,
	QC_OriginalQuantity, QC_OriginalAmount, QC_ConvertedQuantity, QC_ConvertedAmount, AT2007.SourceNo, AT2007.MarkQuantity, AT1302.IsSource, AT1302.IsLimitDate,
	AT1302.MethodID, AT2007.LimitDate, AT2007.ReVoucherID, AT2007.ReTransactionID
    FROM Inserted
    INNER JOIN AT2006 ON AT2006.DivisionID = Inserted.DivisionID AND Inserted.VoucherID = AT2006.VoucherID 
    INNER JOIN AT2007 ON AT2007.DivisionID = Inserted.DivisionID AND Inserted.VoucherID = AT2007.VoucherID AND AT2007.TransactionID = Inserted.TransactionID
    LEFT JOIN AT1303 ON AT1303.WareHouseID = AT2006.WareHouseID
	LEFT JOIN AT1302 ON AT1302.DivisionID IN ('@@@', Inserted.DivisionID) AND AT1302.InventoryID = AT2007.InventoryID
   
	OPEN @D89_Cursor
	FETCH NEXT FROM @D89_Cursor INTO @TransactionID, @DivisionID, @RDVoucherID, @VoucherNo, @TranYear, @TranMonth, @VoucherDate,---- Thong tin chung
	@WareHouseID, @WareHouseID2, @KindVoucherID,@InventoryID, @UnitID, @ActualQuantity, @UnitPrice,
	@ConvertedQuantity, @ConvertedUnitPrice, @OriginalAmount, @ConvertedAmount, @DebitAccountID, @CreditAccountID, 
	@PeriodID, @ProductID, @ConvertedUnitID,
	@S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
	@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID, @IsTemp, @IsGoodsFirstVoucher, @InheritTableID, @QC_OriginalQuantity, 
	@QC_OriginalAmount, @QC_ConvertedQuantity, @QC_ConvertedAmount, @SourceNo, @MarkQuantity, @IsSource, @IsLimitDate, @MethodID,@LimitDate, @ReVoucherID,@ReTransactionID

	WHILE @@FETCH_STATUS = 0
	BEGIN

		SET @IsUpdatePrice = (SELECT TOP 1 IsUpdatePrice FROM AT0000 WHERE DefDivisionID = @DivisionID)

		IF EXISTS (SELECT TOP 1 1 FROM AT0114 WHERE DivisionID = @DivisionID 
					  AND (WareHouseID = @WareHouseID OR WareHouseID = @WareHouseID2)
					  AND ReVoucherID = @RDVoucherID 
					  AND ReTransactionID = @TransactionID
					  AND ISNULL(S01ID,'') = Isnull(@S01ID,'')  
					  AND ISNULL(S02ID,'') = isnull(@S02ID,'') 
					  AND ISNULL(S03ID,'') = isnull(@S03ID,'') 
					  AND ISNULL(S04ID,'') = isnull(@S04ID,'') 
					  AND ISNULL(S05ID,'') = isnull(@S05ID,'')  
					  AND ISNULL(S06ID,'') = isnull(@S06ID,'') 
					  AND ISNULL(S07ID,'') = isnull(@S07ID,'') 
					  AND ISNULL(S08ID,'') = isnull(@S08ID,'') 
					  AND ISNULL(S09ID,'') = isnull(@S09ID,'') 
					  AND ISNULL(S10ID,'') = isnull(@S10ID,'') 
					  AND ISNULL(S11ID,'') = isnull(@S11ID,'')  
					  AND ISNULL(S12ID,'') = isnull(@S12ID,'') 
					  AND ISNULL(S13ID,'') = isnull(@S13ID,'') 
					  AND ISNULL(S14ID,'') = isnull(@S14ID,'') 
					  AND ISNULL(S15ID,'') = isnull(@S15ID,'') 
					  AND ISNULL(S16ID,'') = isnull(@S16ID,'') 
					  AND ISNULL(S17ID,'') = isnull(@S17ID,'') 
					  AND ISNULL(S18ID,'') = isnull(@S18ID,'') 
					  AND ISNULL(S19ID,'') = isnull(@S19ID,'') 
					  AND ISNULL(S20ID,'') = isnull(@S20ID,''))
		BEGIN

			IF @KindVoucherID IN (1, 3, 5, 7, 9, 15, 17) --- Truong hop phieu nhap kho
				IF (@IsSource = 1 Or @IsLimitDate = 1 or @MethodID IN (1, 2, 3, 5, 7))
				AND (SELECT ISNULL(IsSpecificate,0) FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID) = 1 
				BEGIN
				-- Cập nhật số dư thực tế đích danh cho phiếu xuất
			      UPDATE AT0114 WITH (ROWLOCK)
			      SET ReQuantity = @ActualQuantity, 
			      EndQuantity = ISNULL(@ActualQuantity, 0) - ISNULL(DeQuantity, 0),
			      ReMarkQuantity = ISNULL(@MarkQuantity, 0), 
			      EndMarkQuantity = ISNULL(@MarkQuantity, 0) - ISNULL(DeMarkQuantity, 0),
			      UnitPrice = @UnitPrice, 
			      ReVoucherDate = @VoucherDate, 
			      ReVoucherNo = @VoucherNo,
			      ReSourceNo = @SourceNo
			      WHERE DivisionID = @DivisionID 
			      AND WareHouseID = @WareHouseID 
			      AND ReVoucherID = @RDVoucherID 
			      AND ReTransactionID = @TransactionID
				  AND ISNULL(S01ID,'') = Isnull(@S01ID,'')  
				  AND ISNULL(S02ID,'') = isnull(@S02ID,'') 
				  AND ISNULL(S03ID,'') = isnull(@S03ID,'') 
				  AND ISNULL(S04ID,'') = isnull(@S04ID,'') 
				  AND ISNULL(S05ID,'') = isnull(@S05ID,'')  
				  AND ISNULL(S06ID,'') = isnull(@S06ID,'') 
				  AND ISNULL(S07ID,'') = isnull(@S07ID,'') 
				  AND ISNULL(S08ID,'') = isnull(@S08ID,'') 
				  AND ISNULL(S09ID,'') = isnull(@S09ID,'') 
				  AND ISNULL(S10ID,'') = isnull(@S10ID,'') 
				  AND ISNULL(S11ID,'') = isnull(@S11ID,'')  
				  AND ISNULL(S12ID,'') = isnull(@S12ID,'') 
				  AND ISNULL(S13ID,'') = isnull(@S13ID,'') 
				  AND ISNULL(S14ID,'') = isnull(@S14ID,'') 
				  AND ISNULL(S15ID,'') = isnull(@S15ID,'') 
				  AND ISNULL(S16ID,'') = isnull(@S16ID,'') 
				  AND ISNULL(S17ID,'') = isnull(@S17ID,'') 
				  AND ISNULL(S18ID,'') = isnull(@S18ID,'') 
				  AND ISNULL(S19ID,'') = isnull(@S19ID,'') 
				  AND ISNULL(S20ID,'') = isnull(@S20ID,'')
			      
			      -- Cập nhật số dư thực tế đích danh cho phiếu nhập
			      UPDATE AT0114 WITH (ROWLOCK) 
			      SET DeQuantity = ISNULL(DeQuantity, 0) + ISNULL(@ActualQuantity, 0), 
			      EndQuantity = ISNULL(EndQuantity, 0) - ISNULL(@ActualQuantity, 0),
			      DeMarkQuantity = ISNULL(DeMarkQuantity, 0) + @MarkQuantity, 
			      EndMarkQuantity = ISNULL(EndMarkQuantity, 0) - ISNULL(@MarkQuantity, 0)
			      WHERE DivisionID = @DivisionID 
			      AND WareHouseID = @WareHouseID2 
			      AND ReVoucherID = @RDVoucherID 
			      AND ReTransactionID = @TransactionID
				  AND ISNULL(S01ID,'') = Isnull(@S01ID,'')  
				  AND ISNULL(S02ID,'') = isnull(@S02ID,'') 
				  AND ISNULL(S03ID,'') = isnull(@S03ID,'') 
				  AND ISNULL(S04ID,'') = isnull(@S04ID,'') 
				  AND ISNULL(S05ID,'') = isnull(@S05ID,'')  
				  AND ISNULL(S06ID,'') = isnull(@S06ID,'') 
				  AND ISNULL(S07ID,'') = isnull(@S07ID,'') 
				  AND ISNULL(S08ID,'') = isnull(@S08ID,'') 
				  AND ISNULL(S09ID,'') = isnull(@S09ID,'') 
				  AND ISNULL(S10ID,'') = isnull(@S10ID,'') 
				  AND ISNULL(S11ID,'') = isnull(@S11ID,'')  
				  AND ISNULL(S12ID,'') = isnull(@S12ID,'') 
				  AND ISNULL(S13ID,'') = isnull(@S13ID,'') 
				  AND ISNULL(S14ID,'') = isnull(@S14ID,'') 
				  AND ISNULL(S15ID,'') = isnull(@S15ID,'') 
				  AND ISNULL(S16ID,'') = isnull(@S16ID,'') 
				  AND ISNULL(S17ID,'') = isnull(@S17ID,'') 
				  AND ISNULL(S18ID,'') = isnull(@S18ID,'') 
				  AND ISNULL(S19ID,'') = isnull(@S19ID,'') 
				  AND ISNULL(S20ID,'') = isnull(@S20ID,'')
			  END
			
		END
		ELSE
		BEGIN
			IF (@IsSource <> 0 OR @IsLimitDate <> 0 OR @MethodID IN (1, 2, 3, 5, 7) ) AND @KindVoucherID IN (1, 3, 5, 7, 9, 15, 17) 
			AND (SELECT ISNULL(IsSpecificate,0) FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID) = 1
			BEGIN  
			  --print 'INSERT vao bang tinh gia xuat kho: AT0114'   
			  IF (SELECT CustomerName FROM CustomerIndex) = 15 --- Customize 2T  
			  Begin  
					INSERT AT0114 (InventoryID, DivisionID, WareHouseID, ReVoucherID, ReTransactionID, ReVoucherNo,   
					ReVoucherDate, ReTranMonth, ReTranYear, ReSourceNo, ReQuantity, DeQuantity,   
					EndQuantity, UnitPrice, Status, LimitDate, ReMarkQuantity, DeMarkQuantity, EndMarkQuantity,
					S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID,
					S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID)  
					VALUES (@InventoryID, @DivisionID, @WareHouseID, @RDVoucherID, @TransactionID, @VoucherNo,   
					@VoucherDate, @TranMonth, @TranYear, @SourceNo, @ActualQuantity, 0,   
					@ActualQuantity,   
					CASE WHEN @MarkQuantity <> 0 THEN @ConvertedAmount/@MarkQuantity ELSE @ConvertedUnitPrice END, 0, @LimitDate,  
					@MarkQuantity, 0, @MarkQuantity, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
					@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID)  
			  End  
			  Else  
			  Begin  
					INSERT AT0114 (InventoryID, DivisionID, WareHouseID, ReVoucherID, ReTransactionID, ReVoucherNo,   
					ReVoucherDate, ReTranMonth, ReTranYear, ReSourceNo, ReQuantity, DeQuantity,   
					EndQuantity, UnitPrice, Status, LimitDate, ReMarkQuantity, DeMarkQuantity, EndMarkQuantity,
					S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID,
					S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID)  
					VALUES (@InventoryID, @DivisionID, @WareHouseID, @RDVoucherID, @TransactionID, @VoucherNo,   
					@VoucherDate, @TranMonth, @TranYear, @SourceNo, @ActualQuantity, 0,   
					@ActualQuantity,   
					CASE WHEN @ActualQuantity <> 0 THEN @ConvertedAmount/@ActualQuantity ELSE @ConvertedUnitPrice END, 0, @LimitDate,  
					@MarkQuantity, 0, @MarkQuantity, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
					@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID)  
			  END  
			END  
		END

		IF (@IsSource <> 0 OR @IsLimitDate <> 0 OR @MethodID IN (1, 2, 3, 5, 7) ) AND @KindVoucherID = 10 ----Nếu có giảm giá => đơn giá mặt hàng trừ đi số tiền được giảm
		BEGIN

			UPDATE T1 
			SET T1.UnitPrice = T1.UnitPrice - @UnitPrice
			FROM AT0114 T1
			LEFT JOIN WT8899 T2 ON T1.DivisionID = T2.DivisionID AND T1.ReVoucherID = T2.VoucherID AND T1.ReTransactionID = T2.TransactionID
	    	WHERE T1.InventoryID = @InventoryID AND T1.DivisionID = @DivisionID AND WareHouseID = @WareHouseID
	    	AND T1.ReVoucherID = @ReVoucherID AND T1.ReTransactionID = @ReTransactionID 
			AND ISNULL(T1.S01ID,'') = Isnull(T2.S01ID,'')  
			AND ISNULL(T1.S02ID,'') = isnull(T2.S02ID,'') 
			AND ISNULL(T1.S03ID,'') = isnull(T2.S03ID,'') 
			AND ISNULL(T1.S04ID,'') = isnull(T2.S04ID,'') 
			AND ISNULL(T1.S05ID,'') = isnull(T2.S05ID,'')  
			AND ISNULL(T1.S06ID,'') = isnull(T2.S06ID,'') 
			AND ISNULL(T1.S07ID,'') = isnull(T2.S07ID,'') 
			AND ISNULL(T1.S08ID,'') = isnull(T2.S08ID,'') 
			AND ISNULL(T1.S09ID,'') = isnull(T2.S09ID,'') 
			AND ISNULL(T1.S10ID,'') = isnull(T2.S10ID,'') 
			AND ISNULL(T1.S11ID,'') = isnull(T2.S11ID,'')  
			AND ISNULL(T1.S12ID,'') = isnull(T2.S12ID,'') 
			AND ISNULL(T1.S13ID,'') = isnull(T2.S13ID,'') 
			AND ISNULL(T1.S14ID,'') = isnull(T2.S14ID,'') 
			AND ISNULL(T1.S15ID,'') = isnull(T2.S15ID,'') 
			AND ISNULL(T1.S16ID,'') = isnull(T2.S16ID,'') 
			AND ISNULL(T1.S17ID,'') = isnull(T2.S17ID,'') 
			AND ISNULL(T1.S18ID,'') = isnull(T2.S18ID,'') 
			AND ISNULL(T1.S19ID,'') = isnull(T2.S19ID,'') 
			AND ISNULL(T1.S20ID,'') = isnull(T2.S20ID,'')

		END

		IF @IsUpdatePrice = 0
		BEGIN 
			EXEC AP0599_QC @DivisionID, @TranYear, @TranMonth,
						@WareHouseID, @WareHouseID2,
						@KindVoucherID, @InventoryID, @ActualQuantity, 
						@ConvertedAmount, @DebitAccountID, @CreditAccountID,
						@S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
						@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID, @RDVoucherID, @TransactionID,
						@IsTemp, @IsGoodsFirstVoucher, @InheritTableID
		END 
		ELSE 
			EXEC AP0599TL_QC @DivisionID, @TranYear, @TranMonth, @WareHouseID, @WareHouseID2,
					@KindVoucherID, @InventoryID, @ActualQuantity, 
					@ConvertedAmount, @DebitAccountID, @CreditAccountID,
					@S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
					@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID, @RDVoucherID, @TransactionID,
					@IsTemp, @IsGoodsFirstVoucher, @InheritTableID	

	FETCH NEXT FROM @D89_Cursor INTO @TransactionID, @DivisionID, @RDVoucherID, @VoucherNo, @TranYear, @TranMonth, @VoucherDate,---- Thong tin chung
	@WareHouseID, @WareHouseID2, @KindVoucherID, @InventoryID, @UnitID, @ActualQuantity, @UnitPrice,
	@ConvertedQuantity, @ConvertedUnitPrice, @OriginalAmount, @ConvertedAmount, @DebitAccountID, @CreditAccountID, 
	@PeriodID, @ProductID, @ConvertedUnitID,
	@S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
	@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID, @IsTemp, @IsGoodsFirstVoucher, @InheritTableID, @QC_OriginalQuantity, 
	@QC_OriginalAmount, @QC_ConvertedQuantity, @QC_ConvertedAmount, @SourceNo, @MarkQuantity, @IsSource, @IsLimitDate, @MethodID,@LimitDate, @ReVoucherID, @ReTransactionID

	CLOSE @D89_Cursor
	DEALLOCATE @D89_Cursor
	END 
END
ELSE 
IF @TableID = 'AT2017'
BEGIN	
	
	SET @D89_Cursor = Cursor Scroll KeySet For
	SELECT 	Ins.TransactionID, ins.DivisionID, ins.VoucherID, T09.VoucherNo, T09.TranYear, T09.TranMonth, T09.VoucherDate,   ---- Thong tin chung	
	T09.WareHouseID, T09.WareHouseID2, T09.KindVoucherID,
	T17.InventoryID, T17.UnitID, T17.ActualQuantity, T17.UnitPrice,
	Isnull(ConvertedQuantity,0),---ActualQuantity*isnull(T04.ConversionFactor,1),		
	T17.ConvertedPrice, --UnitPrice/isnull(T04.ConversionFactor,1),
	OriginalAmount, ConvertedAmount,
	DebitAccountID,CreditAccountID,    
	'' AS PeriodID,'' AS ProductID, T17.ConvertedUnitID,
	Ins.S01ID, Ins.S02ID, Ins.S03ID, Ins.S04ID, Ins.S05ID, Ins.S06ID, Ins.S07ID, Ins.S08ID, Ins.S09ID, Ins.S10ID,
	Ins.S11ID, Ins.S12ID, Ins.S13ID, Ins.S14ID, Ins.S15ID, Ins.S16ID, Ins.S17ID, Ins.S18ID, Ins.S19ID, Ins.S20ID,
	QC_OriginalQuantity, QC_OriginalAmount, QC_ConvertedQuantity, QC_ConvertedAmount, AT1302.IsLimitDate, AT1302.IsSource, AT1302.MethodID,
	T17.MarkQuantity, T17.LimitDate
	FROM 	Inserted Ins 	
	INNER JOIN AT2016 T09 	ON 	ins.VoucherID = T09.VoucherID And ins.DivisionID = T09.DivisionID
	LEFT JOIN AT2017 T17 ON T17.DivisionID = ins.DivisionID AND T17.VoucherID = ins.VoucherID AND T17.TransactionID = ins.TransactionID
	INNER JOIN AT1302 T02 ON T17.InventoryID = T02.InventoryID
	LEFT JOIN AT1309 T04 ON	T17.UnitID 	= T04.UnitID AND T17.InventoryID = T04.InventoryID
	INNER JOIN AT1303 T03 ON T03.WareHouseID = T09.WareHouseID
	LEFT JOIN AT1302 ON AT1302.InventoryID = T17.InventoryID
	OPEN @D89_Cursor
	FETCH NEXT FROM @D89_Cursor INTO @TransactionID, @DivisionID, @RDVoucherID, @VoucherNo, @TranYear, @TranMonth,@VoucherDate, ---- Thong tin chung
	@WareHouseID, @WareHouseID2, @KindVoucherID,
	@InventoryID, @UnitID, @ActualQuantity, @UnitPrice,
	@ConvertedQuantity, @ConvertedUnitPrice, @OriginalAmount, @ConvertedAmount, @DebitAccountID, @CreditAccountID, 
	@PeriodID, @ProductID, @ConvertedUnitID,
	@S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
	@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID,
	@QC_OriginalQuantity, @QC_OriginalAmount, @QC_ConvertedQuantity, @QC_ConvertedAmount, @IsLimitDate, @IsSource, @MethodID, @MarkQuantity,@LimitDate
	
	WHILE @@FETCH_STATUS = 0
	BEGIN	
		IF (@IsSource<>0 OR @IsLimitDate <>0 OR @MethodID IN (1,2,3) ) 	--- and    @KindVoucherID in (1,3)
		AND (SELECT ISNULL(IsSpecificate,0) FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID) = 1
		BEGIN
			IF NOT EXISTS (SELECT TOP 1 1 FROM AT0114 WHERE DivisionID = @DivisionID 
					  AND (WareHouseID = @WareHouseID OR WareHouseID = @WareHouseID2)
					  AND ReVoucherID = @RDVoucherID 
					  AND ReTransactionID = @TransactionID
					  AND ISNULL(S01ID,'') = Isnull(@S01ID,'')  
					  AND ISNULL(S02ID,'') = isnull(@S02ID,'') 
					  AND ISNULL(S03ID,'') = isnull(@S03ID,'') 
					  AND ISNULL(S04ID,'') = isnull(@S04ID,'') 
					  AND ISNULL(S05ID,'') = isnull(@S05ID,'')  
					  AND ISNULL(S06ID,'') = isnull(@S06ID,'') 
					  AND ISNULL(S07ID,'') = isnull(@S07ID,'') 
					  AND ISNULL(S08ID,'') = isnull(@S08ID,'') 
					  AND ISNULL(S09ID,'') = isnull(@S09ID,'') 
					  AND ISNULL(S10ID,'') = isnull(@S10ID,'') 
					  AND ISNULL(S11ID,'') = isnull(@S11ID,'')  
					  AND ISNULL(S12ID,'') = isnull(@S12ID,'') 
					  AND ISNULL(S13ID,'') = isnull(@S13ID,'') 
					  AND ISNULL(S14ID,'') = isnull(@S14ID,'') 
					  AND ISNULL(S15ID,'') = isnull(@S15ID,'') 
					  AND ISNULL(S16ID,'') = isnull(@S16ID,'') 
					  AND ISNULL(S17ID,'') = isnull(@S17ID,'') 
					  AND ISNULL(S18ID,'') = isnull(@S18ID,'') 
					  AND ISNULL(S19ID,'') = isnull(@S19ID,'') 
					  AND ISNULL(S20ID,'') = isnull(@S20ID,''))
				BEGIN
					---print 'Insert vao bang tinh gia xuat kho: AT0114'	
					INSERT AT0114 (InventoryID, DivisionID, WareHouseID, ReVoucherID, ReTransactionID, ReVoucherNo,
					            ReVoucherDate,  ReTranMonth,ReTranYear, ReSourceNo, ReQuantity, DeQuantity,
					            EndQuantity, UnitPrice, Status, LimitDate, ReMarkQuantity, DeMarkQuantity, EndMarkQuantity,
								S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID,
								S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID)
					VALUES (@InventoryID, @DivisionID, @WareHouseID, @RDVoucherID, @TransactionID, @VoucherNo, 
						@VoucherDate, @TranMonth, @TranYear, @SourceNo, @ActualQuantity, 0, @ActualQuantity, 
						CASE WHEN @ActualQuantity<>0 THEN @ConvertedAmount/@ActualQuantity ELSE @ConvertedUnitPrice END,
						0, @LimitDate, @MarkQuantity, 0, @MarkQuantity,
						@S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
						@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID)
				END
				ELSE
				BEGIN
		
					UPDATE AT0114 
					SET UnitPrice = CASE WHEN ReQuantity + @ActualQuantity <> 0 THEN @ConvertedAmount/ (ReQuantity + @ActualQuantity) ELSE @UnitPrice END,
						ReQuantity =  @ActualQuantity, 
						EndQuantity = @ActualQuantity,
						ReMarkQuantity = @MarkQuantity, 
						EndMarkQuantity = @MarkQuantity,
						ReVoucherNo = @VoucherNo, 
						ReVoucherDate = @VoucherDate, 
						ReSourceNo = @SourceNo, LimitDate = @LimitDate,
						WareHouseID = @WareHouseID
					WHERE DivisionID = @DivisionID AND ReVoucherID = @RDVoucherID AND ReTransactionID = @TransactionID
					  AND ISNULL(S01ID,'') = Isnull(@S01ID,'')  
					  AND ISNULL(S02ID,'') = isnull(@S02ID,'') 
					  AND ISNULL(S03ID,'') = isnull(@S03ID,'') 
					  AND ISNULL(S04ID,'') = isnull(@S04ID,'') 
					  AND ISNULL(S05ID,'') = isnull(@S05ID,'')  
					  AND ISNULL(S06ID,'') = isnull(@S06ID,'') 
					  AND ISNULL(S07ID,'') = isnull(@S07ID,'') 
					  AND ISNULL(S08ID,'') = isnull(@S08ID,'') 
					  AND ISNULL(S09ID,'') = isnull(@S09ID,'') 
					  AND ISNULL(S10ID,'') = isnull(@S10ID,'') 
					  AND ISNULL(S11ID,'') = isnull(@S11ID,'')  
					  AND ISNULL(S12ID,'') = isnull(@S12ID,'') 
					  AND ISNULL(S13ID,'') = isnull(@S13ID,'') 
					  AND ISNULL(S14ID,'') = isnull(@S14ID,'') 
					  AND ISNULL(S15ID,'') = isnull(@S15ID,'') 
					  AND ISNULL(S16ID,'') = isnull(@S16ID,'') 
					  AND ISNULL(S17ID,'') = isnull(@S17ID,'') 
					  AND ISNULL(S18ID,'') = isnull(@S18ID,'') 
					  AND ISNULL(S19ID,'') = isnull(@S19ID,'') 
					  AND ISNULL(S20ID,'') = isnull(@S20ID,'')
				END
		END

		EXEC AP0612_QC	@DivisionID, @WareHouseID, @TranMonth, @TranYear, @InventoryID, @ConvertedAmount, @ActualQuantity, @DebitAccountID, @CreditAccountID, 1,
						@S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
						@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID -- (1) la cap nhat tang,(0 ) la cap nhat giam

		INSERT INTO AT8899 (DivisionID, VoucherID, TransactionID, TableID, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID,
							S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID)
		VALUES (@DivisionID, @RDVoucherID, @TransactionID, 'AT2017', @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
				@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID)
		
	Fetch Next From @D89_Cursor INTO @TransactionID, @DivisionID, @RDVoucherID, @VoucherNo, @TranYear, @TranMonth,@VoucherDate, ---- Thong tin chung
	@WareHouseID, @WareHouseID2, @KindVoucherID,
	@InventoryID, @UnitID, @ActualQuantity, @UnitPrice,
	@ConvertedQuantity, @ConvertedUnitPrice, @OriginalAmount, @ConvertedAmount, @DebitAccountID, @CreditAccountID, 
	@PeriodID, @ProductID, @ConvertedUnitID,
	@S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
	@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID,
	@QC_OriginalQuantity, @QC_OriginalAmount, @QC_ConvertedQuantity, @QC_ConvertedAmount, @IsLimitDate, @IsSource, @MethodID, @MarkQuantity,@LimitDate                           

	End
	Close @D89_Cursor
	DeAllocate @D89_Cursor
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
