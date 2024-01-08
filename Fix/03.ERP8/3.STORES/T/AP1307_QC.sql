IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1307_QC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1307_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--------- Created by Tiểu Mai, Date 05/11/2015
--------- Purpose: Tinh gia binh quan gia quyen cuoi ky cho truong hop xuat kho thong thuong hoac ban hang xuat kho (quản lý theo quy cách)
--------- Modified by Bảo Thy on 27/05/2016: Bổ sung WITH (NOLOCK)
--------- Modified by Tiểu Mai on 16/06/2016: Cải tiến tốc độ


CREATE PROCEDURE [dbo].[AP1307_QC] 
    @DivisionID NVARCHAR(50), 
    @TranMonth INT, 
    @TranYear INT, 
    @QuantityDecimals TINYINT, 
    @UnitCostDecimals TINYINT, 
    @ConvertedDecimals TINYINT
    
AS
	UPDATE AT2007
	SET AT2007.UnitPrice = ROUND(AV1309.UnitPrice, @UnitCostDecimals),
		ConvertedPrice =  ROUND(AV1309.UnitPrice, @UnitCostDecimals), 
		OriginalAmount = ROUND(ROUND(AV1309.UnitPrice, @UnitCostDecimals) * ROUND(AT2007.ActualQuantity, @QuantityDecimals), @ConvertedDecimals), 
		ConvertedAmount = ROUND(ROUND(AV1309.UnitPrice, @UnitCostDecimals) * ROUND(AT2007.ActualQuantity, @QuantityDecimals), @ConvertedDecimals) 
	FROM AT2007 WITH (ROWLOCK)  INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID
	LEFT JOIN WT8899 O99 ON O99.DivisionID = AT2007.DivisionID AND O99.TransactionID = AT2007.TransactionID AND O99.VoucherID = AT2007.VoucherID
	INNER JOIN (Select WareHouseID, InventoryID, InventoryAccountID, UnitPrice,
						AV1309_QC.S01ID, AV1309_QC.S02ID, AV1309_QC.S03ID, AV1309_QC.S04ID, AV1309_QC.S05ID, AV1309_QC.S06ID, AV1309_QC.S07ID, AV1309_QC.S08ID, AV1309_QC.S09ID, AV1309_QC.S10ID,
						AV1309_QC.S11ID, AV1309_QC.S12ID, AV1309_QC.S13ID, AV1309_QC.S14ID, AV1309_QC.S15ID, AV1309_QC.S16ID, AV1309_QC.S17ID, AV1309_QC.S18ID, AV1309_QC.S19ID, AV1309_QC.S20ID
				FROM AV1309_QC) AV1309
	ON AT2006.WareHouseID = AV1309.WareHouseID And AT2007.InventoryID = AV1309.InventoryID and AT2007.CreditAccountID = AV1309.InventoryAccountID
				AND ISNULL(O99.S01ID,'') = Isnull(AV1309.S01ID,'')
				AND ISNULL(O99.S02ID,'') = isnull(AV1309.S02ID,'') 
				AND ISNULL(O99.S03ID,'') = isnull(AV1309.S03ID,'') 	
				AND ISNULL(O99.S04ID,'') = isnull(AV1309.S04ID,'') 
				AND ISNULL(O99.S05ID,'') = isnull(AV1309.S05ID,'') 
				AND ISNULL(O99.S06ID,'') = isnull(AV1309.S06ID,'') 
				AND ISNULL(O99.S07ID,'') = isnull(AV1309.S07ID,'') 
				AND ISNULL(O99.S08ID,'') = isnull(AV1309.S08ID,'') 
				AND ISNULL(O99.S09ID,'') = isnull(AV1309.S09ID,'') 
				AND ISNULL(O99.S10ID,'') = isnull(AV1309.S10ID,'') 
				AND ISNULL(O99.S11ID,'') = isnull(AV1309.S11ID,'') 
				AND ISNULL(O99.S12ID,'') = isnull(AV1309.S12ID,'') 
				AND ISNULL(O99.S13ID,'') = isnull(AV1309.S13ID,'') 
				AND ISNULL(O99.S14ID,'') = isnull(AV1309.S14ID,'') 
				AND ISNULL(O99.S15ID,'') = isnull(AV1309.S15ID,'') 
				AND ISNULL(O99.S16ID,'') = isnull(AV1309.S16ID,'') 
				AND ISNULL(O99.S17ID,'') = isnull(AV1309.S17ID,'') 
				AND ISNULL(O99.S18ID,'') = isnull(AV1309.S18ID,'') 
				AND ISNULL(O99.S19ID,'') = isnull(AV1309.S19ID,'')
				AND ISNULL(O99.S20ID,'') = isnull(AV1309.S20ID,'')
	WHERE AT2006.KindVoucherID IN (2, 4, 6) ---- 2: xuat kho thong thuong, 4: ban hang xuat kho            
		AND AT2007.TranMonth = @TranMonth 
		AND AT2007.TranYear = @TranYear 
		AND AT2007.DivisionID = @DivisionID 


	UPDATE WT8899
	SET 
		QC_OriginalAmount = ROUND(ROUND(AV1309.UnitPrice, @UnitCostDecimals) * ROUND(O99.QC_OriginalQuantity, @QuantityDecimals), @ConvertedDecimals), 
		QC_ConvertedAmount = ROUND(ROUND(AV1309.UnitPrice, @UnitCostDecimals) * ROUND(O99.QC_OriginalQuantity, @QuantityDecimals), @ConvertedDecimals) 
	FROM WT8899 O99 WITH (ROWLOCK)  
	LEFT JOIN AT2007 WITH (NOLOCK) ON O99.DivisionID = AT2007.DivisionID AND O99.TransactionID = AT2007.TransactionID AND O99.VoucherID = AT2007.VoucherID
	INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID
	INNER JOIN (Select WareHouseID, InventoryID, InventoryAccountID, UnitPrice,
						AV1309_QC.S01ID, AV1309_QC.S02ID, AV1309_QC.S03ID, AV1309_QC.S04ID, AV1309_QC.S05ID, AV1309_QC.S06ID, AV1309_QC.S07ID, AV1309_QC.S08ID, AV1309_QC.S09ID, AV1309_QC.S10ID,
						AV1309_QC.S11ID, AV1309_QC.S12ID, AV1309_QC.S13ID, AV1309_QC.S14ID, AV1309_QC.S15ID, AV1309_QC.S16ID, AV1309_QC.S17ID, AV1309_QC.S18ID, AV1309_QC.S19ID, AV1309_QC.S20ID
				FROM AV1309_QC) AV1309
	ON AT2006.WareHouseID = AV1309.WareHouseID And AT2007.InventoryID = AV1309.InventoryID and AT2007.CreditAccountID = AV1309.InventoryAccountID
				AND ISNULL(O99.S01ID,'') = Isnull(AV1309.S01ID,'')
				AND ISNULL(O99.S02ID,'') = isnull(AV1309.S02ID,'') 
				AND ISNULL(O99.S03ID,'') = isnull(AV1309.S03ID,'') 	
				AND ISNULL(O99.S04ID,'') = isnull(AV1309.S04ID,'') 
				AND ISNULL(O99.S05ID,'') = isnull(AV1309.S05ID,'') 
				AND ISNULL(O99.S06ID,'') = isnull(AV1309.S06ID,'') 
				AND ISNULL(O99.S07ID,'') = isnull(AV1309.S07ID,'') 
				AND ISNULL(O99.S08ID,'') = isnull(AV1309.S08ID,'') 
				AND ISNULL(O99.S09ID,'') = isnull(AV1309.S09ID,'') 
				AND ISNULL(O99.S10ID,'') = isnull(AV1309.S10ID,'') 
				AND ISNULL(O99.S11ID,'') = isnull(AV1309.S11ID,'') 
				AND ISNULL(O99.S12ID,'') = isnull(AV1309.S12ID,'') 
				AND ISNULL(O99.S13ID,'') = isnull(AV1309.S13ID,'') 
				AND ISNULL(O99.S14ID,'') = isnull(AV1309.S14ID,'') 
				AND ISNULL(O99.S15ID,'') = isnull(AV1309.S15ID,'') 
				AND ISNULL(O99.S16ID,'') = isnull(AV1309.S16ID,'') 
				AND ISNULL(O99.S17ID,'') = isnull(AV1309.S17ID,'') 
				AND ISNULL(O99.S18ID,'') = isnull(AV1309.S18ID,'') 
				AND ISNULL(O99.S19ID,'') = isnull(AV1309.S19ID,'')
				AND ISNULL(O99.S20ID,'') = isnull(AV1309.S20ID,'')
	WHERE AT2006.KindVoucherID IN (2, 4, 6) ---- 2: xuat kho thong thuong, 4: ban hang xuat kho            
		AND AT2007.TranMonth = @TranMonth 
		AND AT2007.TranYear = @TranYear 
		AND AT2007.DivisionID = @DivisionID 

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
