IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WZ8899]') AND OBJECTPROPERTY(ID, N'IsTrigger') = 1)
DROP TRIGGER [DBO].[WZ8899]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET NOCOUNT ON
GO

--- Created by Tiểu Mai on 18/10/2016: Cập nhật tồn kho khi chạy tính giá (theo thiết lập quy cách)


CREATE TRIGGER [dbo].[WZ8899] ON [dbo].[WT8899]
FOR UPDATE 
AS

DECLARE 
@D07_Cursor CURSOR

DECLARE 
@KindVoucherID TINYINT, 
@TransactionID NVARCHAR(50), 
@DivisionID NVARCHAR(50),  
@RDVoucherID NVARCHAR(50), 
@TranYear Int, @TranMonth int, 
@InventoryID NVARCHAR(50), @UnitID NVARCHAR(50), 
@UnitPrice DECIMAL(28, 8), 
@DebitAccountID NVARCHAR(20), @CreditAccountID NVARCHAR(20), 
@WareHouseID NVARCHAR(50), @WareHouseID2 NVARCHAR(50), 
@OldQC_OriginalQuantity DECIMAL(28, 8), @NewQC_OriginalQuantity DECIMAL(28, 8),
@OldQC_OriginalAmount DECIMAL(28, 8), @NewQC_OriginalAmount DECIMAL(28, 8),  
@OldQC_ConvertedQuantity DECIMAL(28, 8), @NewQC_ConvertedQuantity DECIMAL(28, 8),
@OldQC_ConvertedAmount DECIMAL(28, 8), @NewQC_ConvertedAmount DECIMAL(28, 8), 
@Parameter01 AS DECIMAL(28,8), @Parameter02 AS DECIMAL(28,8), @Parameter03 AS DECIMAL(28,8), @Parameter04 AS DECIMAL(28,8), @Parameter05 AS DECIMAL(28,8),
@OldMarkQuantity AS DECIMAL(28,8), @NewMarkQuantity AS DECIMAL(28,8),
@S01ID VARCHAR(50), @S02ID VARCHAR(50), @S03ID VARCHAR(50), @S04ID VARCHAR(50),
@S05ID VARCHAR(50), @S06ID VARCHAR(50), @S07ID VARCHAR(50), @S08ID VARCHAR(50), @S09ID VARCHAR(50), @S10ID VARCHAR(50),
@S11ID VARCHAR(50), @S12ID VARCHAR(50), @S13ID VARCHAR(50), @S14ID VARCHAR(50), @S15ID VARCHAR(50), @S16ID VARCHAR(50),
@S17ID VARCHAR(50), @S18ID VARCHAR(50), @S19ID VARCHAR(50), @S20ID VARCHAR(50)

DECLARE @CustomerName INT
--Tao bang tam de kiem tra day co phai la khach hang ANGEL khong (CustomerName = 57)
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

SET @D07_Cursor = CURSOR SCROLL KEYSET FOR
    SELECT Inserted.DivisionID, A07.TranMonth, A07.TranYear, A07.TransactionID, Inserted.VoucherID, 
    AT2006.KindVoucherID, AT2006.WareHouseID, AT2006.WareHouseID2,  
    A07.InventoryID, A07.UnitID, 
    A07.UnitPrice, 
    Deleted.QC_OriginalQuantity, 
    Inserted.QC_OriginalQuantity,
    Deleted.QC_ConvertedQuantity, 
    Inserted.QC_ConvertedQuantity, 
    Deleted.QC_ConvertedAmount, 
    Inserted.QC_ConvertedAmount, 
    Deleted.QC_OriginalAmount, 
    Inserted.QC_OriginalAmount, 
    A07.DebitAccountID, A07.CreditAccountID,  
    Isnull(A07.Parameter01,0), Isnull(A07.Parameter02,0), Isnull(A07.Parameter03,0), Isnull(A07.Parameter04,0), Isnull(A07.Parameter05,0),
    A07.MarkQuantity, A07.MarkQuantity,
    Inserted.S01ID, Inserted.S02ID, Inserted.S03ID, Inserted.S04ID, Inserted.S05ID, Inserted.S06ID, Inserted.S07ID, Inserted.S08ID, Inserted.S09ID, Inserted.S10ID,
    Inserted.S11ID, Inserted.S12ID, Inserted.S13ID, Inserted.S14ID, Inserted.S15ID, Inserted.S16ID, Inserted.S17ID, Inserted.S18ID, Inserted.S19ID, Inserted.S20ID
    
    FROM Deleted  
    INNER JOIN Inserted ON Inserted.VoucherID = Deleted.VoucherID AND Inserted.TransactionID = Deleted.TransactionID and Inserted.DivisionID = Deleted.DivisionID 
    INNER JOIN AT2007 A07 WITH (NOLOCK) ON A07.DivisionID = Inserted.DivisionID AND A07.VoucherID = Inserted.VoucherID AND A07.TransactionID = Inserted.TransactionID
    INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = Inserted.VoucherID and AT2006.DivisionID = Inserted.DivisionID
OPEN @D07_Cursor
FETCH NEXT FROM @D07_Cursor INTO @DivisionID, @TranMonth, @TranYear, @TransactionID, @RDVoucherID, 
@KindVoucherID, @WareHouseID, @WareHouseID2, 
@InventoryID, @UnitID, 
@UnitPrice, 
@OldQC_OriginalQuantity, @NewQC_OriginalQuantity,
@OldQC_ConvertedQuantity, @NewQC_ConvertedQuantity, 
@OldQC_ConvertedAmount,  @NewQC_ConvertedAmount, 
@OldQC_OriginalAmount,  @NewQC_OriginalAmount, 
@DebitAccountID, @CreditAccountID, 
@Parameter01, @Parameter02, @Parameter03, @Parameter04, @Parameter05, @OldMarkQuantity, @NewMarkQuantity,
@S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID

WHILE @@FETCH_STATUS = 0
BEGIN
	---- Thiết lập quy cách
	EXEC AP0600_QC @KindVoucherID, @DivisionID, @TranMonth, @TranYear, @WareHouseID, @WareHouseID2, @InventoryID, 
		@DebitAccountID, @CreditAccountID, @DebitAccountID, @CreditAccountID, 
		@OldQC_OriginalQuantity, @NewQC_OriginalQuantity, @OldQC_OriginalAmount, @NewQC_OriginalAmount,
		@Parameter01, @Parameter02, @Parameter03, @Parameter04, @Parameter05, @OldMarkQuantity, @NewMarkQuantity, 
		@S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
		@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID

    FETCH NEXT FROM @D07_Cursor INTO @DivisionID, @TranMonth, @TranYear, @TransactionID, @RDVoucherID, 
@KindVoucherID, @WareHouseID, @WareHouseID2, 
@InventoryID, @UnitID, 
@UnitPrice, 
@OldQC_OriginalQuantity, @NewQC_OriginalQuantity,
@OldQC_ConvertedQuantity, @NewQC_ConvertedQuantity, 
@OldQC_ConvertedAmount,  @NewQC_ConvertedAmount, 
@OldQC_OriginalAmount,  @NewQC_OriginalAmount, 
@DebitAccountID, @CreditAccountID, 
@Parameter01, @Parameter02, @Parameter03, @Parameter04, @Parameter05, @OldMarkQuantity, @NewMarkQuantity,
@S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID

END 
Close @D07_Cursor

GO
SET NOCOUNT OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON