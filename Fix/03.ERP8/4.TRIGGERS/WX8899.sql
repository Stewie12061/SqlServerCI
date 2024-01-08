IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WX8899]') AND OBJECTPROPERTY(ID, N'IsTrigger') = 1)
DROP TRIGGER [DBO].[WX8899]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


--- Created by Tiểu Mai on 05/08/2016
--- Purpose: Cập nhật lại số lượng tồn kho hàng hóa theo quy cách.
--- Modified by Tiểu Mai on 06/10/2016: Fix bug tồn kho chưa đúng
--- Modified by Bảo Thy on 24/04/2017: bổ sung Xóa bang tinh gia AT0114 khi tính theo PP FIFO (TUNGTEX)
--- Modified by Bảo Thy on 30/05/2017: Nếu sửa/xóa phiếu giảm giá xuất kho => đơn giá mặt hàng cộng lại số tiền đã được giảm
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung


CREATE TRIGGER [dbo].[WX8899]  ON [dbo].[WT8899]
FOR DELETE As
Declare		@D89_Cursor		Cursor

Declare  
	@KindVoucherID TINYINT, 
	@DivisionID NVARCHAR(50),
	@TranYear INT, 
	@TranMonth INT, 
	@InventoryID NVARCHAR(50), 
	@UnitID NVARCHAR(50),
	@ActualQuantity DECIMAL(28, 8), 
	@UnitPrice DECIMAL(28, 8),
	@ConvertedQuantity DECIMAL(28, 8), 
	@ConvertedPrice DECIMAL(28, 8), 
	@ConvertedAmount DECIMAL(28, 8), 
	@OriginalAmount DECIMAL(28, 8), 
	@DebitAccountID NVARCHAR(50), 
	@CreditAccountID NVARCHAR(50), 
	@WareHouseID NVARCHAR(50),
	@WareHouseID2 NVARCHAR(50), 
	@ConvertedUnitID NVARCHAR(50),
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
    @QC_OriginalQuantity DECIMAL(28,8),
    @QC_OriginalAmount DECIMAL(28,8),
    @QC_ConvertedQuantity DECIMAL(28,8),
    @QC_ConvertedAmount DECIMAL(28,8),
    @VoucherID NVARCHAR(50),
	@IsSource TINYINT,
	@IsLimitDate TINYINT,
	@MethodID TINYINT,
	@TransactionID VARCHAR(50),
	@ReVoucherID VARCHAR(50),
	@ReTransactionID VARCHAR(50)

SET @TableID = (SELECT TOP 1 Del.TableID FROM DELETED Del)

IF Isnull(@TableID,'') IN ('AT2007', 'AT2017')
BEGIN 
	IF Isnull(@TableID,'') = 'AT2017'
	BEGIN 
		SET @D89_Cursor = Cursor Scroll KeySet For
			SELECT Del.TableID, Del.TransactionID, Del.DivisionID, Del.VoucherID, A06.TranYear, A06.TranMonth, A06.KindVoucherID, A07.DebitAccountID, A07.CreditAccountID, A06.WareHouseID, 
			A06.WareHouseID2, A07.InventoryID, A07.UnitID, A07.ActualQuantity, A07.UnitPrice, A07.OriginalAmount, A07.ConvertedAmount, A07.ConvertedUnitID, 
			A07.ConvertedQuantity, A07.ConvertedPrice, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID,
			S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID,
			QC_OriginalQuantity, QC_OriginalAmount, QC_ConvertedQuantity, QC_ConvertedAmount, A32.IsSource, A32.IsLimitDate, A32.MethodID,
			A07.ReVoucherID, A07.ReTransactionID
			From 	DELETED Del
			LEFT JOIN AT2017 A07 WITH (NOLOCK) ON A07.DivisionID = Del.DivisionID AND A07.VoucherID = Del.VoucherID  AND A07.TransactionID = Del.TransactionID
			LEFT JOIN AT2016 A06 WITH (NOLOCK) ON A06.DivisionID = A07.DivisionID AND A06.VoucherID = A07.VoucherID
			LEFT JOIN AT1302 A32 WITH (NOLOCK) ON A32.DivisionID IN ('@@@', A07.DivisionID) AND A32.InventoryID = A07.InventoryID
	END
	ELSE IF Isnull(@TableID,'')  = 'AT2007'
	BEGIN
		SET @D89_Cursor = Cursor Scroll KeySet For
			SELECT Del.TableID, Del.TransactionID, Del.DivisionID, Del.VoucherID, A06.TranYear, A06.TranMonth, A06.KindVoucherID, A07.DebitAccountID, A07.CreditAccountID, A06.WareHouseID, A06.WareHouseID2,
			A07.InventoryID, A07.UnitID, A07.ActualQuantity, A07.UnitPrice, A07.OriginalAmount, A07.ConvertedAmount, A07.ConvertedUnitID, A07.ConvertedQuantity, A07.ConvertedPrice,
			S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID,
			S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID,
			QC_OriginalQuantity, QC_OriginalAmount, QC_ConvertedQuantity, QC_ConvertedAmount, A32.IsSource, A32.IsLimitDate, A32.MethodID,
			A07.ReVoucherID, A07.ReTransactionID
			From 	DELETED Del
			LEFT JOIN AT2007 A07 WITH (NOLOCK) ON A07.DivisionID = Del.DivisionID AND A07.VoucherID = Del.VoucherID  AND A07.TransactionID = Del.TransactionID
			LEFT JOIN AT2006 A06 WITH (NOLOCK) ON A06.DivisionID = A07.DivisionID AND A06.VoucherID = A07.VoucherID	
			LEFT JOIN AT1302 A32 WITH (NOLOCK) ON A32.DivisionID IN ('@@@', A07.DivisionID) AND A32.InventoryID = A07.InventoryID
	END 
	Open @D89_Cursor
	Fetch Next From @D89_Cursor INTO @TableID, @TransactionID, @DivisionID, @VoucherID, @TranYear, @TranMonth, @KindVoucherID, @DebitAccountID, @CreditAccountID, @WareHouseID, @WareHouseID2,
	@InventoryID, @UnitID, @ActualQuantity, @UnitPrice, @OriginalAmount, @ConvertedAmount, @ConvertedUnitID, @ConvertedQuantity, @ConvertedPrice,
	@S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID, @S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID,
	@QC_OriginalQuantity, @QC_OriginalAmount, @QC_ConvertedQuantity, @QC_ConvertedAmount, @IsSource, @IsLimitDate, @MethodID, @ReVoucherID, @ReTransactionID 
                                         

	While @@FETCH_STATUS = 0
	Begin	

		IF @TableID in ( 'AT2007','MT0810')
		BEGIN
			----- Xoa bang tinh gia	
			If @KindVoucherID in (1,3,5,7,9,15,17) AND (SELECT ISNULL(IsSpecificate,0) FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID) = 1
				IF @IsSource =1 or @IsLimitDate =1 or @MethodID in (1,2,3)
					DELETE AT0114 Where DivisionID =@DivisionID
					AND WareHouseID = @WareHouseID
					AND ReVoucherID = @VoucherID
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

			IF @KindVoucherID = 3 --- la xuat van chuyen noi bo
			BEGIN
				EXEC AP0513_QC @DivisionID, @WareHouseID, @TranMonth, @TranYear, @InventoryID, @QC_OriginalAmount, @QC_OriginalQuantity, @DebitAccountID, @CreditAccountID, 11,
							@S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
							@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID -- (10) la cap nhat tang, (11) la cap nhat giam
				EXEC AP0513_QC @DivisionID, @WareHouseID2, @TranMonth, @TranYear, @InventoryID, @QC_OriginalAmount, @QC_OriginalQuantity, @DebitAccountID, @CreditAccountID, 10,
							@S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
							@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID -- (10) la cap nhat tang, (11) la cap nhat giam 
			END
			ELSE IF @KindVoucherID IN (1, 5, 7, 9, 15, 17) --- Nhap kho, dieu chinh tang : 1: nhap kho - 5: mua hang nhap kho - 7: hang ban tra lai nhap kho - 9: dieu chinh kiem ke kho tang - 15: nhap kho mua hang - 17: nhap kho xuat kho hang ban tra lai
				BEGIN	
					EXEC AP0513_QC @DivisionID, @WareHouseID, @TranMonth, @TranYear, @InventoryID, @QC_OriginalAmount, @QC_OriginalQuantity, @DebitAccountID, @CreditAccountID, 1,
								@S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
								@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID -- (1) la cap nhat tang, (0 ) la cap nhat giam
				END
			ELSE IF @KindVoucherID IN (2, 4, 6, 8, 10, 14, 20) --- Xuat kho, dieu chinh giam: 2: Xuat kho - 4: ban hang xuat kho - 8: dieu chinh kiem ke kho giam -10: hang mua tra lai xuat kho -14: xuat kho ban hang -20: xuat kho nhap kho mua hang tra lai
				BEGIN 
				    
					IF (@IsSource <> 0 OR @IsLimitDate <> 0 OR @MethodID IN (1, 2, 3, 5, 7) ) AND @KindVoucherID = 10 ----Nếu sửa/xóa phiếu giảm giá xuất kho => đơn giá mặt hàng cộng lại số tiền được giảm
					BEGIN
						UPDATE T1 
						SET T1.UnitPrice = T1.UnitPrice + @UnitPrice
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
					--SELECT 'WX8899'
					EXEC AP0513_QC @DivisionID, @WareHouseID, @TranMonth, @TranYear, @InventoryID, @QC_OriginalAmount, @QC_OriginalQuantity, @DebitAccountID, @CreditAccountID, 0,
								@S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
								@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID -- (1) la cap nhat tang, (0 ) la cap nhat giam
				END 

		END
		IF @TableID = 'AT2017'
		BEGIN
			IF (@IsSource =1 Or @IsLimitDate =1 or @MethodID in (1,2,3))
			AND (SELECT ISNULL(IsSpecificate,0) FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID) = 1
				DELETE AT0114 WHERE DivisionID =@DivisionID 
							AND WareHouseID = @WareHouseID 
							AND ReVoucherID = @VoucherID 
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

			DELETE FROM AT8899 WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID AND TableID = 'AT2017'
			
			Exec AP0612_QC	@DivisionID, @WareHouseID, @TranMonth, @TranYear, @InventoryID, @QC_OriginalAmount, @QC_OriginalQuantity, @DebitAccountID, @CreditAccountID, 0,
							@S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
							@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID -- (1) la cap nhat tang,(0 ) la cap nhat giam
	
		END
	Fetch Next From @D89_Cursor Into @TableID, @TransactionID, @DivisionID, @VoucherID, @TranYear, @TranMonth, @KindVoucherID, @DebitAccountID, @CreditAccountID, @WareHouseID, @WareHouseID2,
	@InventoryID, @UnitID, @ActualQuantity, @UnitPrice, @OriginalAmount, @ConvertedAmount, @ConvertedUnitID, @ConvertedQuantity, @ConvertedPrice,
	@S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID, @S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID,
	@QC_OriginalQuantity, @QC_OriginalAmount, @QC_ConvertedQuantity, @QC_ConvertedAmount, @IsSource, @IsLimitDate, @MethodID, @ReVoucherID, @ReTransactionID                                  

	End
	Close @D89_Cursor
	DeAllocate @D89_Cursor
END 

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
