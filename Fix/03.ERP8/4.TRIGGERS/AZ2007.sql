IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AZ2007]') AND OBJECTPROPERTY(ID, N'IsTrigger') = 1)
DROP TRIGGER [DBO].[AZ2007]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



--Created by Van Nhan.
--Purpose: UPDATE lai so du va bang so cai
--Edit by Nguyen Quoc Huy, 
--Last Edit : Thuy Tuyen, them truong OTransactionID, date :27/08/2008
--Edit by: Dang Le Bao Quynh; Date: 21/04/2009
--Purpose: Bo sung ma phan tich 4 5
--Edit By: Dang Le Bao Quynh, Date 16/09/2009
--Purpose: Cap nhat lai so chung tu cho bang AT0114
--Edit by: Dang Le Bao Quynh; Date: 23/02/2010
--Purpose: Them kindvoucherID cho cac truong hop nhap kho mua hang, xuat kho ban hang
--Edit by: Trần Lê Thiên Huỳnh; Date: 06/06/2012: Bổ sung 5 Khoản mục Ana06ID - Ana10ID
--- Edited by Bao Anh	Date: 05/08/2012
--- Purpose: Them quy cach va so luong mark (yeu cau cua 2T)
--- Edited by Bao Anh	Date: 30/10/2012
--- Purpose: Cap nhat so du theo mark (yeu cau cua 2T)
--- Edited by Bao Anh	Date: 20/11/2012	
--- Purpose:	Bo sung cap nhat ConvertedQuantity vao AT9000
--- Edited by Bao Quynh	Date: 27/12/2012	
--- Purpose:	Bo inner join bang AT1302, Do moi lan chay cap nhat AT2007, cau truy van nay rat cham. 
------------------Doi AT1302.MethodID, AT1302.IsLimitDate, AT1302.IsSource vao trong truy van tung dong.
--- Edited by Trung Dung	Date: 04/03/2013	
--- Purpose:	Bo sung cap nhat luon gia tri SourceNo phong truong hop nguoi dung thay doi lo nhap
/********************************************
'* Edited by: [GS] [Hoàng Phước] [30/07/2010]
'********************************************/ 
---- Modified on 29/07/2013 by Lê Thị Thu Hiền : Bổ sung RefNo01, RefNo02
---- Modified on 02/03/2016 by Tiểu Mai: Bổ sung update Kết quả sx cho ANGEL
---- Modified on 16/06/2016 by Tiểu Mai: Bổ sung cập nhật số dư khi quản lý theo quy cách
---- Modified on 11/07/2016 by Bảo Anh: Bổ sung WITH (ROWLOCK)
---- Modified by Tiểu Mai on 11/08/2016: Bổ sung trường hợp phiếu lắp ráp
---- Modified by Tiểu Mai on 06/10/2016: Fix bug tồn kho chưa đúng
---- Modified by Phương Thảo on 24/11/2016: Bổ sung customize Phúc Long: Chuyển dữ liệu qua POST
---- Modified by Bảo Thy on 20/04/2017: Nếu ko quản lý theo quy cách thì update AT0114 tại đây. Ngược lại thì update trong WY8899 (TUNGTEX)
---- Modified by Bảo Thy on 19/05/2017: Sửa danh mục dùng chung
---- Modified on 05/04/2018 by Bảo Anh: Update AT0114 cho trường hợp sửa phiếu chuyển kho chọn lại chứng từ nhập
---- Modified on 20/9/2019 by Kim Thư: Bổ sung trường hợp update phiếu nhập thay đổi mặt hàng
---- Modified on 13/02/2019 by Kim Thư: Bổ sung customize cho Phúc Long
---- Modified on 18/02/2019 by Kim Thư: Bổ sung cập nhật số dữ thực tế đích danh cho phiếu nhập trường hợp OldInventoryID <> NewInventoryID
---- Modified on 27/03/2019 by Kim Thư: Bổ sung ReTransactionID_OLD, ReVoucherID_OLD, SourceNo_OLD vào table AT20071 để xử lý trường hợp phiếu xuất thay đổi chứng từ nhập, lô nhập, mặt hàng ở phiếu xuất
---- Modified on 10/04/2019 by Kim Thư: Tách trường hợp cập nhật AT0114 khi edit thông tin nhập và thông tin xuất
---- Modified on 13/06/2020 by Huỳnh Thử: Insert và Delete AT0114 khi cập nhật phiếu nhập(Đổi từ mặt hàng method 1 sang 4 và ngược lại)
---- Modified on 23/07/2020 by Huỳnh Thử: [Phúc Long] -- Mang phần update làm tròn lên code
---- Modified on 24/07/2020 by Huỳnh Thử: [Phúc Long] -- Update AT9000 khi làm tròn giá
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Lê Hoàng on 04/10/2021 : Bổ sung custom NamHoa - khi vận chuyển nội bộ
---- Modified by Lê Hoàng on 14/10/2021 : Stored AP0516 bổ sung biến DebitAccountID, CreditAccountID

CREATE TRIGGER [dbo].[AZ2007] ON [dbo].[AT2007]
FOR UPDATE 
AS

DECLARE 
@D07_Cursor CURSOR, 
@BaseCurrencyID NVARCHAR(50)

DECLARE 
@KindVoucherID TINYINT, 
@TransactionID NVARCHAR(50), 
@DivisionID NVARCHAR(50), @ModuleID NVARCHAR(50), 
@VoucherTypeID NVARCHAR(50), 
@RDVoucherID NVARCHAR(50), @RDVoucherNo NVARCHAR(50), 
@BatchID NVARCHAR(50), 
@RDVoucherDate Datetime, 
@TranYear Int, @TranMonth int, 
@OldInventoryID NVARCHAR(50),
@NewInventoryID NVARCHAR(50), @UnitID NVARCHAR(50), 
@UnitPrice DECIMAL(28, 8), 
@CurrencyID NVARCHAR(50), @ExchangeRate DECIMAL(28, 8), 
@ConvertedAmount DECIMAL(28, 8), @OriginalAmount DECIMAL(28, 8), 
@DebitAccountID NVARCHAR(20), @CreditAccountID NVARCHAR(20), 
@DebitAccountID_Old NVARCHAR(50), @CreditAccountID_Old NVARCHAR(50), 
@DebitAccountID_New NVARCHAR(50), @CreditAccountID_New NVARCHAR(50), 
@WareHouseID NVARCHAR(50), @WareHouseID2 NVARCHAR(50), 
@Description NVARCHAR(255), @SourceNo NVARCHAR(50), @WarrantyNo NVARCHAR(250), @ShelvesID NVARCHAR(50), @FloorID NVARCHAR(50),
@LimitDate Datetime, 
@EmployeeID NVARCHAR(50), @MethodID TINYINT, 
@ObjectID NVARCHAR(250), @IsLimitDate TINYINT, 
@IsSource TINYINT, @TableID NVARCHAR(50), 
@Ana01ID NVARCHAR(50), @Ana02ID NVARCHAR(50), @Ana03ID NVARCHAR(50), @Ana04ID NVARCHAR(50), @Ana05ID NVARCHAR(50), 
@Ana06ID NVARCHAR(50), @Ana07ID NVARCHAR(50), @Ana08ID NVARCHAR(50), @Ana09ID NVARCHAR(50), @Ana10ID NVARCHAR(50), 
@Notes NVARCHAR(250), @PeriodID NVARCHAR(50), @ProductID NVARCHAR(50), @OrderID NVARCHAR(50), 
@IsTemp TINYINT, 
@OldQuantity DECIMAL(28, 8), @NewQuantity DECIMAL(28, 8), @OldConvertedAmount DECIMAL(28, 8), @NewConvertedAmount DECIMAL(28, 8), 
@LastModifyDate DATETIME, @LastModifyUserID NVARCHAR(50), 
@OldProductID NVARCHAR(50), @NewProductID NVARCHAR(50), 
@OldPeriodID NVARCHAR(50), @NewPeriodID NVARCHAR(50), @OTransactionID NVARCHAR(50), @MOrderID NVARCHAR(50), @SOrderID NVARCHAR(50),
@Parameter01 AS DECIMAL(28,8), @Parameter02 AS DECIMAL(28,8), @Parameter03 AS DECIMAL(28,8), @Parameter04 AS DECIMAL(28,8), @Parameter05 AS DECIMAL(28,8),
@OldMarkQuantity AS DECIMAL(28,8), @NewMarkQuantity AS DECIMAL(28,8),
@ReTransactionID AS NVARCHAR(50), @ReVoucherID AS NVARCHAR(50),
@OldConvertedQuantity DECIMAL(28, 8), @NewConvertedQuantity DECIMAL(28, 8),
@RefNo01 NVARCHAR(100),
@RefNo02 NVARCHAR(100),
@IsProduct TINYINT, @CreateDate DATETIME, @CreateUserID NVARCHAR(50),
@KITID NVARCHAR(50), @KITQuantity DECIMAL(28,8),@S01ID VARCHAR(50), @S02ID VARCHAR(50), @S03ID VARCHAR(50), @S04ID VARCHAR(50),
@S05ID VARCHAR(50), @S06ID VARCHAR(50), @S07ID VARCHAR(50), @S08ID VARCHAR(50), @S09ID VARCHAR(50), @S10ID VARCHAR(50),
@S11ID VARCHAR(50), @S12ID VARCHAR(50), @S13ID VARCHAR(50), @S14ID VARCHAR(50), @S15ID VARCHAR(50), @S16ID VARCHAR(50),
@S17ID VARCHAR(50), @S18ID VARCHAR(50), @S19ID VARCHAR(50), @S20ID VARCHAR(50), @DepartmentCode Nvarchar(250),
@ReTransactionID_Old NVARCHAR(50), @ReVoucherID_Old NVARCHAR(50)

DECLARE @CustomerName INT
--Tao bang tam de kiem tra day co phai la khach hang ANGEL khong (CustomerName = 57)
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

IF @CustomerName = 32 -- PHÚC LONG
BEGIN
	DELETE AT20071
	--SELECT * FROM Inserted
	INSERT INTO AT20071 (DivisionID,TranMonth,TranYear,TransactionID,RDVoucherID,BatchID, ReTransactionID, ReVoucherID, ReTransactionID_OLD, ReVoucherID_OLD, RDVoucherDate, RDVoucherNo,
					VoucherTypeID, KindVoucherID, TableID, WareHouseID, WareHouseID2, ObjectID, EmployeeID, Description, LastModifyDate, LastModifyUserID
					, CurrencyID, ExchangeRate, InventoryID, InventoryID_Old, UnitID, MethodID, IsLimitDate, IsSource, UnitPrice, OldQuantity, NewQuantity,
					OldConvertedAmount, NewConvertedAmount, OriginalAmount, DebitAccountID_Old, CreditAccountID_Old, DebitAccountID_New, CreditAccountID_New,
					Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID, Notes,
					NewPeriodID, NewProductID, OldPeriodID, OldProductID, LimitDate, SourceNo, SourceNo_OLD, OrderID, OTransactionID, MOrderID,
					SOrderID, Parameter01, Parameter02, Parameter03, Parameter04, Parameter05,OldMarkQuantity, NewMarkQuantity, OldConvertedQuantity, NewConvertedQuantity
					, RefNo01, RefNo02, IsProduct, CreateDate, CreateUserID, KITID, KITQuantity,
					S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID,
					S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID,IsRound)
    SELECT Inserted.DivisionID, Inserted.TranMonth, Inserted.TranYear, Inserted.TransactionID,
	Inserted.VoucherID, AT2006.BatchID, 
    Inserted.ReTransactionID, Inserted.ReVoucherID, Deleted.ReTransactionID, Deleted.ReVoucherID,
    AT2006.VoucherDate, AT2006.VoucherNo, AT2006.VoucherTypeID, 
    AT2006.KindVoucherID, AT2006.TableID, AT2006.WareHouseID, AT2006.WareHouseID2, 
    AT2006.ObjectID, AT2006.EmployeeID, AT2006.Description, 
    AT2006.LastModifyDate, AT2006.LastModifyUserID, 
    Inserted.CurrencyID, Inserted.ExchangeRate, 
    Inserted.InventoryID, Deleted.InventoryID, Inserted.UnitID, 
    AT1302.MethodID, AT1302.IsLimitDate, AT1302.IsSource, 
    --4, 0, 0, 
    Inserted.UnitPrice, 
    Deleted.ActualQuantity, 
    Inserted.ActualQuantity, 
    Deleted.ConvertedAmount, 
    Inserted.ConvertedAmount, 
    Inserted.OriginalAmount, 
    Deleted.DebitAccountID, Deleted.CreditAccountID, 
    Inserted.DebitAccountID, Inserted.CreditAccountID, 
    Inserted.Ana01ID, Inserted.Ana02ID, Inserted.Ana03ID, Inserted.Ana04ID, Inserted.Ana05ID, 
    Inserted.Ana06ID, Inserted.Ana07ID, Inserted.Ana08ID, Inserted.Ana09ID, Inserted.Ana10ID,
    Inserted.Notes, 
    Inserted.PeriodID, 
    Inserted.ProductID, 
    Deleted.PeriodID, 
    Deleted.ProductID, 
    Inserted.LimitDate, Inserted.SourceNo, Deleted.SourceNo, Inserted.OrderID, Inserted.OTransactionID,
	Inserted.MOrderID, Inserted.SOrderID,
    Isnull(INSERTED.Parameter01,0), Isnull(INSERTED.Parameter02,0), Isnull(INSERTED.Parameter03,0),
	Isnull(INSERTED.Parameter04,0), Isnull(INSERTED.Parameter05,0),
    DELETED.MarkQuantity, INSERTED.MarkQuantity, Deleted.ConvertedQuantity,
	Inserted.ConvertedQuantity,
    AT2006.RefNo01,AT2006.RefNo02, AT2006.IsProduct, AT2006.CreateDate, AT2006.CreateUserID,
    INSERTED.KITID, INSERTED.KITQuantity,
    O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID,
	O99.S09ID, O99.S10ID,
    O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID,
	O99.S18ID, O99.S19ID, O99.S20ID,Inserted.IsRound
    
    FROM Deleted  
    INNER JOIN Inserted ON Inserted.TransactionID = Deleted.TransactionID and Inserted.DivisionID = Deleted.DivisionID 
    INNER JOIN AT2006 ON AT2006.VoucherID = Inserted.VoucherID and AT2006.DivisionID = Inserted.DivisionID
    INNER JOIN AT1302 ON AT1302.InventoryID = Inserted.InventoryID and AT1302.DivisionID IN ('@@@',Inserted.DivisionID)
    LEFT JOIN WT8899 O99 ON O99.DivisionID = DELETED.DivisionID AND O99.VoucherID = Deleted.VoucherID AND O99.TransactionID = Deleted.TransactionID

	IF EXISTS (SELECT TOP 1 1 FROM AT20071 WHERE IsRound = 0)
		EXEC AP0609
	ELSE
		EXEC AP0609_PL
END
ELSE
BEGIN

	SET @D07_Cursor = CURSOR SCROLL KEYSET FOR
		SELECT Inserted.DivisionID, Inserted.TranMonth, Inserted.TranYear, Inserted.TransactionID, Inserted.VoucherID, AT2006.BatchID, 
		Inserted.ReTransactionID, Inserted.ReVoucherID, Deleted.ReTransactionID, Deleted.ReVoucherID,
		AT2006.VoucherDate, AT2006.VoucherNo, AT2006.VoucherTypeID, 
		AT2006.KindVoucherID, AT2006.TableID, AT2006.WareHouseID, AT2006.WareHouseID2, 
		AT2006.ObjectID, AT2006.EmployeeID, AT2006.Description, 
		AT2006.LastModifyDate, AT2006.LastModifyUserID, 
		Inserted.CurrencyID, Inserted.ExchangeRate, Deleted.InventoryID,
		Inserted.InventoryID, Inserted.UnitID, 
		AT1302.MethodID, AT1302.IsLimitDate, AT1302.IsSource, 
		--4 as MethodID, 0 As IsLimitDate, 0 As IsSource, 
		Inserted.UnitPrice, 
		Deleted.ActualQuantity, 
		Inserted.ActualQuantity, 
		Deleted.ConvertedAmount, 
		Inserted.ConvertedAmount, 
		Inserted.OriginalAmount, 
		Deleted.DebitAccountID, Deleted.CreditAccountID, 
		Inserted.DebitAccountID, Inserted.CreditAccountID, 
		Inserted.Ana01ID, Inserted.Ana02ID, Inserted.Ana03ID, Inserted.Ana04ID, Inserted.Ana05ID, 
		Inserted.Ana06ID, Inserted.Ana07ID, Inserted.Ana08ID, Inserted.Ana09ID, Inserted.Ana10ID,
		Inserted.Notes, 
		Inserted.PeriodID, 
		Inserted.ProductID, 
		Deleted.PeriodID, 
		Deleted.ProductID, 
		Inserted.LimitDate, Inserted.SourceNo, Inserted.WarrantyNo, Inserted.ShelvesID, Inserted.FloorID, Inserted.OrderID, Inserted.OTransactionID, Inserted.MOrderID, Inserted.SOrderID,
		Isnull(INSERTED.Parameter01,0), Isnull(INSERTED.Parameter02,0), Isnull(INSERTED.Parameter03,0), Isnull(INSERTED.Parameter04,0), Isnull(INSERTED.Parameter05,0),
		DELETED.MarkQuantity, INSERTED.MarkQuantity, Deleted.ConvertedQuantity, Inserted.ConvertedQuantity,
		AT2006.RefNo01,AT2006.RefNo02, AT2006.IsProduct, AT2006.CreateDate, AT2006.CreateUserID,
		INSERTED.KITID, INSERTED.KITQuantity,
		O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
		O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID
    
		FROM Deleted  
		INNER JOIN Inserted ON Inserted.TransactionID = Deleted.TransactionID and Inserted.DivisionID = Deleted.DivisionID 
		INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = Inserted.VoucherID and AT2006.DivisionID = Inserted.DivisionID
		LEFT JOIN AT1302 ON AT1302.InventoryID = Inserted.InventoryID and AT1302.DivisionID IN ('@@@',Inserted.DivisionID)
		LEFT JOIN WT8899 O99 WITH (NOLOCK) ON O99.DivisionID = DELETED.DivisionID AND O99.VoucherID = Deleted.VoucherID AND O99.TransactionID = Deleted.TransactionID
	OPEN @D07_Cursor
	FETCH NEXT FROM @D07_Cursor INTO @DivisionID, @TranMonth, @TranYear, @TransactionID, @RDVoucherID, @BatchID, 
	@ReTransactionID, @ReVoucherID, @ReTransactionID_Old, @ReVoucherID_Old,
	@RDVoucherDate, @RDVoucherNo, @VoucherTypeID, 
	@KindVoucherID, @TableID, @WareHouseID, @WareHouseID2, 
	@ObjectID, @EmployeeID, @Description, 
	@LastModifyDate, @LastModifyUserID, 
	@CurrencyID, @ExchangeRate, @OldInventoryID,
	@NewInventoryID, @UnitID, 
	@MethodID, @IsLimitDate, @IsSource, 
	@UnitPrice, 
	@OldQuantity, @NewQuantity, 
	@OldConvertedAmount, @NewConvertedAmount, 
	@OriginalAmount, 
	@DebitAccountID_Old, @CreditAccountID_Old, 
	@DebitAccountID_New, @CreditAccountID_New, 
	@Ana01ID, @Ana02ID, @Ana03ID, @Ana04ID, @Ana05ID, 
	@Ana06ID, @Ana07ID, @Ana08ID, @Ana09ID, @Ana10ID,
	@Notes, 
	@NewPeriodID, @NewProductID, 
	@OldPeriodID, @OldProductID, 
	@LimitDate, @SourceNo, @WarrantyNo, @ShelvesID, @FloorID, @OrderID, @OTransactionID, @MOrderID, @SOrderID,
	@Parameter01, @Parameter02, @Parameter03, @Parameter04, @Parameter05, @OldMarkQuantity, @NewMarkQuantity,
	@OldConvertedQuantity, @NewConvertedQuantity,
	@RefNo01, @RefNo02, @IsProduct, @CreateDate, @CreateUserID,
	@KITID, @KITQuantity, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
	@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID

	WHILE @@FETCH_STATUS = 0
	BEGIN
	
		Select @MethodID=MethodID,@IsLimitDate=IsLimitDate, @IsSource = IsSource
		From AT1302 WITH (NOLOCK) Where DivisionID IN (@DivisionID,'@@@') And InventoryID = @NewInventoryID

		IF @KindVoucherID IN (1, 3, 5, 7, 9, 15, 17) --- Truong hop phieu nhap kho
			IF NOT EXISTS (SELECT TOP 1 1 FROM AT2008 WHERE  WarehouseID=@WareHouseID and InventoryID=@NewInventoryID and InventoryAccountID=@DebitAccountID_New and TranMonth=@TranMonth and TranYear=@TranYear)
			BEGIN
				INSERT INTO AT2008 (DivisionID, TranMonth, TranYear, WareHouseID, InventoryID, InventoryAccountID, BeginQuantity, BeginAmount, DebitQuantity, DebitAmount, 
								InDebitQuantity, InDebitAmount, CreditQuantity, CreditAmount, InCreditQuantity, InCreditAmount, EndQuantity, EndAmount)
				VALUES (@DivisionID, @TranMonth, @TranYear, @WareHouseID, @NewInventoryID, @DebitAccountID_New, 0, 0, @NewQuantity, @NewConvertedAmount,
								NULL, NULL, 0, 0, NULL, NULL, @NewQuantity, @NewConvertedAmount)
			END
		
		-- Cập nhật thực tế đích danh khi edit thông tin nhập
		IF (@IsSource = 1 Or @IsLimitDate = 1 or @MethodID IN (1, 2, 3))
		AND @KindVoucherID IN (1, 3, 5, 7, 9, 15, 17)
		AND (SELECT ISNULL(IsSpecificate,0) FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID) = 0 ---Nếu ko quản lý theo quy cách thì update AT0114 tại đây. Ngược lại thì update trong WY8899
		BEGIN
			IF @OldInventoryID = @NewInventoryID -- Đổi mặt hàng
				UPDATE AT0114 WITH (ROWLOCK)
				SET ReQuantity = @NewQuantity, 
				EndQuantity = ISNULL(@NewQuantity, 0) - ISNULL(DeQuantity, 0),
				ReMarkQuantity = @NewMarkQuantity, 
				EndMarkQuantity = ISNULL(@NewMarkQuantity, 0) - ISNULL(DeMarkQuantity, 0),
				UnitPrice = @UnitPrice, 
				ReVoucherDate = @RDVoucherDate, 
				ReVoucherNo = @RDVoucherNo,
				ReSourceNo = @SourceNo,
				ReWarrantyNo = @WarrantyNo,
				ReShelvesID = @ShelvesID,
				ReFloorID = @FloorID
				WHERE DivisionID = @DivisionID 
				AND ReVoucherID = @RDVoucherID 
				AND ReTransactionID = @TransactionID
			ELSE -- Không đổi mặt hàng
					IF EXISTS ( SELECT TOP 1 1 FROM AT0114 WHERE DivisionID = @DivisionID 
								AND ReVoucherID = @RDVoucherID 
								AND ReTransactionID = @TransactionID)
					BEGIN
					UPDATE AT0114 WITH (ROWLOCK)
						SET	InventoryID =  @NewInventoryID,
						DeQuantity = 0,
						ReQuantity = @NewQuantity, 
						EndQuantity = ISNULL(@NewQuantity, 0),
						DeMarkQuantity = 0,
						ReMarkQuantity = @NewMarkQuantity, 
						EndMarkQuantity = ISNULL(@NewMarkQuantity, 0),
						UnitPrice = @UnitPrice, 
						ReVoucherDate = @RDVoucherDate, 
						ReVoucherNo = @RDVoucherNo,
						ReSourceNo = @SourceNo,
						ReWarrantyNo = @WarrantyNo,
						ReShelvesID = @ShelvesID,
						ReFloorID = @FloorID
						WHERE DivisionID = @DivisionID 
						AND ReVoucherID = @RDVoucherID 
						AND ReTransactionID = @TransactionID
					END
				ELSE
					BEGIN
						-- Nếu là Method 1 mà chưa có trong AT0114 thì Insert
					  INSERT AT0114 (InventoryID, DivisionID, WareHouseID, ReVoucherID, ReTransactionID, ReVoucherNo, 
					  ReVoucherDate, ReTranMonth, ReTranYear, ReSourceNo, ReQuantity, DeQuantity, 
					  EndQuantity, UnitPrice, Status, LimitDate, ReMarkQuantity, DeMarkQuantity, EndMarkQuantity)
					  VALUES (@NewInventoryID, @DivisionID, @WareHouseID, @RDVoucherID, @TransactionID, @RDVoucherNo, 
					  @RDVoucherDate, @TranMonth, @TranYear, @SourceNo, @NewQuantity, 0, 
					  @NewQuantity, 
					  CASE WHEN @NewQuantity <> 0 THEN @ConvertedAmount/@NewQuantity ELSE @UnitPrice END, 0, @LimitDate,
					  @NewMarkQuantity, 0, @NewMarkQuantity)
					END 
		END 
		ELSE
			BEGIN
				-- không phải Method 1 2 3 thì xóa trong AT0114 
				DELETE AT0114 WHERE DivisionID = @DivisionID 
					AND ReVoucherID = @RDVoucherID 
					AND ReTransactionID = @TransactionID
		END	

		-- Cập nhật thực tế đích danh khi edit thông tin xuất
		IF (@IsSource = 1 Or @IsLimitDate = 1 or @MethodID IN (1, 2, 3))
		AND @KindVoucherID IN (2,3,4,6,8,10,14,20)
		AND (SELECT ISNULL(IsSpecificate,0) FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID) = 0 ---Nếu ko quản lý theo quy cách thì update AT0114 tại đây. Ngược lại thì update trong WY8899
		BEGIN
			-- Trường hợp update chọn lại chứng từ nhập hoặc lô nhập hoặc mặt hàng
			IF @ReTransactionID_Old <> @ReTransactionID 
			BEGIN
				-- Cập nhật số dư thực tế đích danh cho phiếu nhập cũ
				UPDATE AT0114 WITH (ROWLOCK) 
				SET DeQuantity = ISNULL(DeQuantity, 0) - ISNULL(@OldQuantity, 0), 
				EndQuantity = ISNULL(EndQuantity, 0) + ISNULL(@OldQuantity, 0)
				WHERE DivisionID = @DivisionID 
				AND ReVoucherID = @ReVoucherID_Old 
				AND ReTransactionID = @ReTransactionID_Old          
				
				-- Cập nhật số dư thực tế đích danh cho phiếu nhập mới
				UPDATE AT0114 WITH (ROWLOCK) 
				SET DeQuantity = ISNULL(DeQuantity, 0) + ISNULL(@NewQuantity, 0), 
				EndQuantity = ISNULL(EndQuantity, 0) - ISNULL(@NewQuantity, 0)
				WHERE DivisionID = @DivisionID 
				AND ReVoucherID = @ReVoucherID 
				AND ReTransactionID = @ReTransactionID  				   	
			END
			ELSE
			---- Trường hợp update đổi mã hàng
			--IF @OldInventoryID <> @NewInventoryID
			--	UPDATE AT0114 WITH (ROWLOCK)
			--	SET	InventoryID =  @NewInventoryID,
			--	DeQuantity = 0,
			--	ReQuantity = @NewQuantity, 
			--	EndQuantity = ISNULL(@NewQuantity, 0),
			--	DeMarkQuantity = 0,
			--	ReMarkQuantity = @NewMarkQuantity, 
			--	EndMarkQuantity = ISNULL(@NewMarkQuantity, 0),
			--	UnitPrice = @UnitPrice, 
			--	ReVoucherDate = @RDVoucherDate, 
			--	ReVoucherNo = @RDVoucherNo,
			--	ReSourceNo = @SourceNo
			--	WHERE DivisionID = @DivisionID 
			--	--AND WareHouseID = @WareHouseID 
			--	AND ReVoucherID = @RDVoucherID 
			--	AND ReTransactionID = @TransactionID
			
			--ELSE
			BEGIN
				-- Cập nhật số dư thực tế đích danh cho phiếu xuất
				UPDATE AT0114 WITH (ROWLOCK) 
				SET DeQuantity = ISNULL(DeQuantity, 0) - ISNULL(@OldQuantity, 0) + ISNULL(@NewQuantity, 0), 
				EndQuantity = ISNULL(EndQuantity, 0) + ISNULL(@OldQuantity, 0) - ISNULL(@NewQuantity, 0),
				DeMarkQuantity = ISNULL(DeMarkQuantity, 0) - ISNULL(@OldMarkQuantity, 0) + ISNULL(@NewMarkQuantity, 0), 
				EndMarkQuantity = ISNULL(EndMarkQuantity, 0) + ISNULL(@OldMarkQuantity, 0) - ISNULL(@NewMarkQuantity, 0)
				WHERE DivisionID = @DivisionID 
				--AND WareHouseID = @WareHouseID2 
				AND ReVoucherID = @ReVoucherID 
				AND ReTransactionID = @ReTransactionID            	
			END			
		END

		IF @CustomerName = 57 AND @KindVoucherID = 1 AND @IsProduct = 1 --- ANGEL
		BEGIN
			IF NOT EXISTS (SELECT TOP 1 1 FROM MT0810 WHERE DivisionID = @DivisionID AND VoucherID = @RDVoucherID AND TableID = 'AT2006')
			BEGIN 
        		INSERT INTO MT0810
					(DivisionID, VoucherTypeID, VoucherID, PeriodID, TranMonth, TranYear, CurrencyID, ExchangeRate, VoucherNo,
					DepartmentID, OriginalAmount, ConvertedAmount, VoucherDate, EmployeeID,
					[Description], CreateDate, CreateUserID, LastModifyUserID, LastModifyDate,
					ResultTypeID, InventoryTypeID, [Disabled], IsPrice, [Status], IsDistribute,
					WareHouseID, IsWareHouseID, IsWareHouse, TeamID, ObjectID, IsTransfer, TableID
					)
				VALUES
					(@DivisionID, @VoucherTypeID, @RDVoucherID, @NewPeriodID, @TranMonth, @TranYear, @CurrencyID, @ExchangeRate, @RDVoucherNo,
					N'%', 0, 0, @RDVoucherDate, @EmployeeID,
					N'Phát sinh từ phiếu nhập kho', @CreateDate, @CreateUserID, @LastModifyUserID, @LastModifyDate,
					'R01', '%', 0, 0, 0, 0, @WareHouseID, 1, 1, N'%', @ObjectID, 0, 'AT2006')
			END 
			ELSE 
				UPDATE MT0810 WITH (ROWLOCK)
				SET VoucherNo = @RDVoucherNo,
					VoucherDate = @RDVoucherDate,
					ObjectID = @ObjectID,
					WareHouseID = @WareHouseID,
					PeriodID = @NewPeriodID,
					LastModifyUserID = @LastModifyUserID,
					LastModifyDate = @LastModifyDate
				WHERE DivisionID = @DivisionID AND VoucherID = @RDVoucherID AND TableID = 'AT2006'		
			
			IF EXISTS (SELECT TOP 1 1 FROM MT1001 WHERE DivisionID = @DivisionID AND VoucherID = @RDVoucherID AND TransactionID = @TransactionID)		
			BEGIN

				DELETE FROM MT1001
				WHERE DivisionID = @DivisionID AND VoucherID = @RDVoucherID AND TransactionID = @TransactionID
				AND TranMonth = @TranMonth AND TranYear = @TranYear
							
			END	
			INSERT INTO MT1001
				(DivisionID, TransactionID, VoucherID, TranMonth, TranYear, 
				InventoryID, Quantity, Price, OriginalAmount, ConvertedAmount,
				ProductID, DebitAccountID,CreditAccountID, KITID, KITQuantity, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID,
				Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID, SourceNo, LimitDate, Note
				)
			VALUES (@DivisionID, @TransactionID, @RDVoucherID, @TranMonth, @TranYear,
				@NewInventoryID, @NewQuantity, @UnitPrice, @NewConvertedAmount, @NewConvertedAmount,
				@NewInventoryID, @DebitAccountID_New, @CreditAccountID_New, @KITID, @KITQuantity, @Ana01ID, @Ana02ID, @Ana03ID, @Ana04ID, @Ana05ID,
				@Ana06ID, @Ana07ID, @Ana08ID, @Ana09ID, @Ana10ID, @SourceNo, @LimitDate, @Notes)
				
		END
		
		IF @CustomerName = 57 AND @KindVoucherID = 1 AND @IsProduct = 0 --- ANGEL, bỏ check Nhập kho từ sx
		BEGIN 
			DELETE FROM MT1001 
			WHERE DivisionID = @DivisionID AND VoucherID = @RDVoucherID AND TransactionID = @TransactionID
				AND TranMonth = @TranMonth AND TranYear = @TranYear
		
			DELETE FROM MT0810 
			WHERE DivisionID = @DivisionID AND VoucherID = @RDVoucherID 
				AND TranMonth = @TranMonth AND TranYear = @TranYear	
		
		END 
	
		IF NOT EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1) AND Isnull(@TableID,'') <> 'AT0114'
		BEGIN  
			
			EXEC AP0600 @KindVoucherID, @DivisionID, @TranMonth, @TranYear, @WareHouseID, @WareHouseID2, @OldInventoryID, @NewInventoryID, 
			@DebitAccountID_Old, @CreditAccountID_Old, @DebitAccountID_New, @CreditAccountID_New, 
			@OldQuantity, @NewQuantity, @OldConvertedAmount, @NewConvertedAmount,
			@Parameter01, @Parameter02, @Parameter03, @Parameter04, @Parameter05, @OldMarkQuantity, @NewMarkQuantity
		END 

		IF (@TableID IN ('AT2006', 'MT0810', 'AT0112')) AND @KindVoucherID Not In (3,10)
			UPDATE AT9000 WITH (ROWLOCK) 
			SET VoucherDate = @RDVoucherDate, VoucherNo = @RDVoucherNo, VoucherTypeID = @VoucherTypeID, 
			ObjectID = @ObjectID, VDescription = @Description, BDescription = @Description, 
			LastModifyDate = @LastModifyDate, LastModifyUserID = @LastModifyUserID, 
			CurrencyID = @CurrencyID, ExchangeRate = @ExchangeRate, 
			InventoryID = @NewInventoryID, UnitID = @UnitID, UnitPrice = @UnitPrice, 
			Quantity = @NewQuantity, ConvertedAmount = @NewConvertedAmount, OriginalAmount = @OriginalAmount, 
			OriginalAmountCN = @OriginalAmount, CurrencyIDCN = @CurrencyID, ExchangeRateCN = @ExchangeRate, 
			DebitAccountID = @DebitAccountID_New, CreditAccountID = @CreditAccountID_New, 
			Ana01ID = @Ana01ID, Ana02ID = @Ana02ID, Ana03ID = @Ana03ID, Ana04ID = @Ana04ID, Ana05ID = @Ana05ID, 
			Ana06ID = @Ana06ID, Ana07ID = @Ana07ID, Ana08ID = @Ana08ID, Ana09ID = @Ana09ID, Ana10ID = @Ana10ID, 
			TDescription = @Notes, 
			OrderID = @OrderID, 
			PeriodID = (CASE WHEN ISNULL(@OldPeriodID, '') = ISNULL(@NewPeriodID, '') THEN PeriodID ELSE @NewPeriodID END), 
			ProductID = (CASE WHEN ISNULL(@OldProductID, '') = ISNULL(@NewProductID, '') THEN ProductID ELSE @NewProductID END), 
			OTransactionID = @OTransactionID, 
			MOrderID = @MOrderID, 
			SOrderID = @SOrderID,
			UParameter01 = @Parameter01, UParameter02 = @Parameter02, UParameter03 = @Parameter03, UParameter04 = @Parameter04, UParameter05 = @Parameter05,
			MarkQuantity = @NewMarkQuantity, ConvertedQuantity = @NewConvertedQuantity
			WHERE TransactionID = @TransactionID 
			AND VoucherID = @RDVoucherID 
			AND TableID = @TableID 
			AND TranMonth = @TranMonth 
			AND TranYear = @TranYear 
			AND DivisionID = @DivisionID 

			IF @CustomerName = 144
			BEGIN
			EXEC AP0516 @DivisionID,@TranYear,@TranMonth,1,@KindVoucherID,@RDVoucherID,@TransactionID,
			@Ana01ID,@Ana02ID,@Ana03ID,@Ana04ID,@Ana05ID,@Ana06ID,@Ana07ID,@Ana08ID,@Ana09ID,@Ana10ID,
			@OriginalAmount,@ConvertedAmount,@UnitPrice,@Notes,@NewQuantity,@NewInventoryID,@UnitID,
			@ProductID,@NewPeriodID,@OrderID,@OTransactionID,
			@Parameter01,@Parameter02,@Parameter03,@Parameter04,@Parameter05,
			@NewMarkQuantity,@UnitID,@NewConvertedQuantity,@UnitPrice,1,@TableID, @DebitAccountID_New, @CreditAccountID_New
			END
		ELSE
		IF @KindVoucherID = 3 AND Isnull(@TableID,'') <> 'AT0114'
		BEGIN
			--print 'co'
			---1. DELETE AT9000 (neu co du lieu) 
			DELETE AT9000 WHERE TransactionID = @TransactionID AND VoucherID = @RDVoucherID AND TableID = @TableID AND TranMOnth = @TranMOnth AND TranYear = @TranYear AND DivisionID = @DivisionID 

			---2. INSERT du lieu neu thoa man dieu kien
			IF @DebitAccountID_New <> @CreditAccountID_New
				INSERT INTO AT9000 (VoucherID, BatchID, TransactionID, TableID, 
				DivisionID, TranMonth, TranYear, TransactionTypeID, 
				CurrencyID, CurrencyIDCN, ObjectID, DebitAccountID, CreditAccountID, 
				ExchangeRate, OriginalAmount, ConvertedAmount, 
				ExchangeRateCN, OriginalAmountCN, 
				VoucherDate, VoucherTypeID, VoucherNo, 
				Orders, EmployeeID, 
				Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, 
				Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID, 
				VDescription, BDescription, TDescription, Quantity, UnitPrice, 
				InventoryID, UnitID, Status, 
				ProductID, PeriodID, OrderID, 
				CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, OTransactionID, MOrderID, SOrderID,
				UParameter01, UParameter02, UParameter03, UParameter04, UParameter05, MarkQuantity, ConvertedQuantity,
				RefNo01, RefNo02
				) 
				VALUES
				(@RDVoucherID, ISNULL(@BatchID, ''), @TransactionID, @TableID, 
				@DivisionID, @TranMonth, @TranYear, 
				CASE WHEN @KindVoucherID IN (1, 3, 5, 7) THEN 'T05' ELSE
				CASE WHEN @KindVoucherID IN ( 2, 4, 6) THEN 'T06' ELSE'T99' END END, 
				@CurrencyID, @CurrencyID, @ObjectID, @DebitAccountID_New, @CreditAccountID_New, 
				@ExchangeRate, @OriginalAmount, @NewConvertedAmount, 
				@ExchangeRate, @OriginalAmount, 
				@RDVoucherDate, @VoucherTypeID, @RDVoucherNo, 
				1, @EmployeeID, 
				@Ana01ID, @Ana02ID, @Ana03ID, @Ana04ID, @Ana05ID, 
				@Ana06ID, @Ana07ID, @Ana08ID, @Ana09ID, @Ana10ID, 
				@Description, @Description, @Notes, @NewQuantity, @UnitPrice, 
				@NewInventoryID, @UnitID, 0, 
				@ProductID, @NewPeriodID, @OrderID, 
				@LastModifyDate, @LastModifyUserID, @LastModifyDate, @LastModifyUserID, @OTransactionID, @MOrderID, @SOrderID,
				@Parameter01, @Parameter02, @Parameter03, @Parameter04, @Parameter05, @NewMarkQuantity, @NewConvertedQuantity,
				@RefNo01, @RefNo02
			)

			IF @CustomerName = 144
			BEGIN
			EXEC AP0516 @DivisionID,@TranYear,@TranMonth,1,@KindVoucherID,@RDVoucherID,@TransactionID,
			@Ana01ID,@Ana02ID,@Ana03ID,@Ana04ID,@Ana05ID,@Ana06ID,@Ana07ID,@Ana08ID,@Ana09ID,@Ana10ID,
			@OriginalAmount,@ConvertedAmount,@UnitPrice,@Notes,@NewQuantity,@NewInventoryID,@UnitID,
			@ProductID,@NewPeriodID,@OrderID,@OTransactionID,
			@Parameter01,@Parameter02,@Parameter03,@Parameter04,@Parameter05,
			@NewMarkQuantity,@UnitID,@NewConvertedQuantity,@UnitPrice,1,@TableID, @DebitAccountID_New, @CreditAccountID_New
			END
		END
		

		FETCH NEXT FROM @D07_Cursor INTO @DivisionID, @TranMonth, @TranYear, @TransactionID, @RDVoucherID, @BatchID, 
		@ReTransactionID, @ReVoucherID, @ReTransactionID_Old, @ReVoucherID_Old,
		@RDVoucherDate, @RDVoucherNo, @VoucherTypeID, 
		@KindVoucherID, @TableID, @WareHouseID, @WareHouseID2, 
		@ObjectID, @EmployeeID, @Description, 
		@LastModifyDate, @LastModifyUserID, 
		@CurrencyID, @ExchangeRate, @OldInventoryID,
		@NewInventoryID, @UnitID, 
		@MethodID, @IsLimitDate, @IsSource, 
		@UnitPrice, 
		@OldQuantity, @NewQuantity, 
		@OldConvertedAmount, @NewConvertedAmount, 
		@OriginalAmount, 
		@DebitAccountID_Old, @CreditAccountID_Old, 
		@DebitAccountID_New, @CreditAccountID_New, 
		@Ana01ID, @Ana02ID, @Ana03ID, @Ana04ID, @Ana05ID, 
		@Ana06ID, @Ana07ID, @Ana08ID, @Ana09ID, @Ana10ID, 
		@Notes, 
		@NewPeriodID, @NewProductID, 
		@OldPeriodID, @OldProductID, 
		@LimitDate, @SourceNo, @WarrantyNo, @ShelvesID, @FloorID, @OrderID, @OTransactionID, @MOrderID, @SOrderID,
		@Parameter01, @Parameter02, @Parameter03, @Parameter04, @Parameter05, @OldMarkQuantity, @NewMarkQuantity,
		@OldConvertedQuantity, @NewConvertedQuantity,
		@RefNo01, @RefNo02, @IsProduct, @CreateDate, @CreateUserID,
		@KITID, @KITQuantity, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
		@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID

	END 
	Close @D07_Cursor
END
----- KET CHUYEN DU LIEU QUA POS
--IF (@CustomerName = 32) -- KH PhucLong
--BEGIN
--	SET @D07_Cursor = CURSOR SCROLL KEYSET FOR
--		SELECT Inserted.DivisionID, Inserted.TranMonth, Inserted.TranYear, Inserted.TransactionID, Inserted.VoucherID, AT2006.BatchID, 
--		Inserted.ReTransactionID, Inserted.ReVoucherID,
--		AT2006.VoucherDate, AT2006.VoucherNo, AT2006.VoucherTypeID, 
--		AT2006.KindVoucherID, AT2006.TableID, AT2006.WareHouseID, AT2006.WareHouseID2, 
--		AT2006.ObjectID, AT2006.EmployeeID, AT2006.Description, 
--		AT2006.LastModifyDate, AT2006.LastModifyUserID, 
--		Inserted.CurrencyID, Inserted.ExchangeRate, 
--		Inserted.InventoryID, Inserted.UnitID, 
--		--AT1302.MethodID, AT1302.IsLimitDate, AT1302.IsSource, 
--		4 as MethodID, 0 As IsLimitDate, 0 As IsSource, 
--		Inserted.UnitPrice, 
--		Deleted.ActualQuantity, 
--		Inserted.ActualQuantity, 
--		Deleted.ConvertedAmount, 
--		Inserted.ConvertedAmount, 
--		Inserted.OriginalAmount, 
--		Deleted.DebitAccountID, Deleted.CreditAccountID, 
--		Inserted.DebitAccountID, Inserted.CreditAccountID, 
--		Inserted.Ana01ID, Inserted.Ana02ID, Inserted.Ana03ID, Inserted.Ana04ID, Inserted.Ana05ID, 
--		Inserted.Ana06ID, Inserted.Ana07ID, Inserted.Ana08ID, Inserted.Ana09ID, Inserted.Ana10ID,
--		Inserted.Notes, 
--		Inserted.PeriodID, 
--		Inserted.ProductID, 
--		Deleted.PeriodID, 
--		Deleted.ProductID, 
--		Inserted.LimitDate, Inserted.SourceNo, Inserted.OrderID, Inserted.OTransactionID, Inserted.MOrderID, Inserted.SOrderID,
--		Isnull(INSERTED.Parameter01,0), Isnull(INSERTED.Parameter02,0), Isnull(INSERTED.Parameter03,0), Isnull(INSERTED.Parameter04,0), Isnull(INSERTED.Parameter05,0),
--		DELETED.MarkQuantity, INSERTED.MarkQuantity, Deleted.ConvertedQuantity, Inserted.ConvertedQuantity,
--		AT2006.RefNo01,AT2006.RefNo02, AT2006.IsProduct, AT2006.CreateDate, AT2006.CreateUserID,
--		INSERTED.KITID, INSERTED.KITQuantity,
--		O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
--		O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
--		AT1202.Note 
--		FROM Deleted  
--		INNER JOIN Inserted ON Inserted.TransactionID = Deleted.TransactionID and Inserted.DivisionID = Deleted.DivisionID 
--		INNER JOIN AT2006 ON AT2006.VoucherID = Inserted.VoucherID and AT2006.DivisionID = Inserted.DivisionID
--		--INNER JOIN AT1302 ON AT1302.InventoryID = Inserted.InventoryID and AT1302.DivisionID = Inserted.DivisionID
--		LEFT JOIN WT8899 O99 ON O99.DivisionID = DELETED.DivisionID AND O99.VoucherID = Deleted.VoucherID AND O99.TransactionID = Deleted.TransactionID
--		LEFT JOIN AT1202 ON AT1202.DivisionID = AT2006.DivisionID AND AT1202.ObjectID = AT2006.ObjectID
--		WHERE (ISNULL(AT1202.Note,'') <> '' OR AT2006.VoucherTypeID = 'N11')
--	OPEN @D07_Cursor
--	FETCH NEXT FROM @D07_Cursor INTO @DivisionID, @TranMonth, @TranYear, @TransactionID, @RDVoucherID, @BatchID, 
--	@ReTransactionID, @ReVoucherID,
--	@RDVoucherDate, @RDVoucherNo, @VoucherTypeID, 
--	@KindVoucherID, @TableID, @WareHouseID, @WareHouseID2, 
--	@ObjectID, @EmployeeID, @Description, 
--	@LastModifyDate, @LastModifyUserID, 
--	@CurrencyID, @ExchangeRate, 
--	@NewInventoryID, @UnitID, 
--	@MethodID, @IsLimitDate, @IsSource, 
--	@UnitPrice, 
--	@OldQuantity, @NewQuantity, 
--	@OldConvertedAmount, @NewConvertedAmount, 
--	@OriginalAmount, 
--	@DebitAccountID_Old, @CreditAccountID_Old, 
--	@DebitAccountID_New, @CreditAccountID_New, 
--	@Ana01ID, @Ana02ID, @Ana03ID, @Ana04ID, @Ana05ID, 
--	@Ana06ID, @Ana07ID, @Ana08ID, @Ana09ID, @Ana10ID,
--	@Notes, 
--	@NewPeriodID, @NewProductID, 
--	@OldPeriodID, @OldProductID, 
--	@LimitDate, @SourceNo, @OrderID, @OTransactionID, @MOrderID, @SOrderID,
--	@Parameter01, @Parameter02, @Parameter03, @Parameter04, @Parameter05, @OldMarkQuantity, @NewMarkQuantity,
--	@OldConvertedQuantity, @NewConvertedQuantity,
--	@RefNo01, @RefNo02, @IsProduct, @CreateDate, @CreateUserID,
--	@KITID, @KITQuantity, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
--	@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID, @DepartmentCode

--	WHILE @@FETCH_STATUS = 0
--	BEGIN	

--		UPDATE [ERP_TO_POS].[dbo].[WarehouseObject]
--        SET VoucherDate = @RDVoucherDate, VoucherNo = @RDVoucherNo, VoucherTypeID = @VoucherTypeID, 
--        ObjectID = @ObjectID, Description = @Description, 
--        LastModifyDate = @LastModifyDate, LastModifyUserID = @LastModifyUserID, 
--        CurrencyID = @CurrencyID, ExchangeRate = @ExchangeRate, 
--        InventoryID = @NewInventoryID, 
--		DepartmentCode = case when (@VoucherTypeID = 'N11' AND @KindVoucherID = 1) then @WarehouseID else  @DepartmentCode end ,
--		UnitID = @UnitID, UnitPrice = @UnitPrice, 
--        ActualQuantity = @NewQuantity, ConvertedAmount = @NewConvertedAmount, OriginalAmount = @OriginalAmount, 
--		Notes = @Notes,
--        DebitAccountID = @DebitAccountID_New, CreditAccountID = @CreditAccountID_New, 
--		WarehouseID = @WarehouseID,
--		WarehouseID2 = case when (@VoucherTypeID = 'N11' AND @KindVoucherID = 1) then @ObjectID else  @WarehouseID2 end
--        WHERE TransactionID = @TransactionID 
--        AND VoucherID = @RDVoucherID          
--        AND TranMonth = @TranMonth 
--        AND TranYear = @TranYear 
--        AND DivisionID = @DivisionID  
--		AND ((@VoucherTypeID IN ('VC1','VC2','VC5')		AND @KindVoucherID = 3) 
--		OR (@VoucherTypeID = 'N11'		AND @KindVoucherID = 1))

--		FETCH NEXT FROM @D07_Cursor INTO @DivisionID, @TranMonth, @TranYear, @TransactionID, @RDVoucherID, @BatchID, 
--		@ReTransactionID, @ReVoucherID,
--		@RDVoucherDate, @RDVoucherNo, @VoucherTypeID, 
--		@KindVoucherID, @TableID, @WareHouseID, @WareHouseID2, 
--		@ObjectID, @EmployeeID, @Description, 
--		@LastModifyDate, @LastModifyUserID, 
--		@CurrencyID, @ExchangeRate, 
--		@NewInventoryID, @UnitID, 
--		@MethodID, @IsLimitDate, @IsSource, 
--		@UnitPrice, 
--		@OldQuantity, @NewQuantity, 
--		@OldConvertedAmount, @NewConvertedAmount, 
--		@OriginalAmount, 
--		@DebitAccountID_Old, @CreditAccountID_Old, 
--		@DebitAccountID_New, @CreditAccountID_New, 
--		@Ana01ID, @Ana02ID, @Ana03ID, @Ana04ID, @Ana05ID, 
--		@Ana06ID, @Ana07ID, @Ana08ID, @Ana09ID, @Ana10ID, 
--		@Notes, 
--		@NewPeriodID, @NewProductID, 
--		@OldPeriodID, @OldProductID, 
--		@LimitDate, @SourceNo, @OrderID, @OTransactionID, @MOrderID, @SOrderID,
--		@Parameter01, @Parameter02, @Parameter03, @Parameter04, @Parameter05, @OldMarkQuantity, @NewMarkQuantity,
--		@OldConvertedQuantity, @NewConvertedQuantity,
--		@RefNo01, @RefNo02, @IsProduct, @CreateDate, @CreateUserID,
--		@KITID, @KITQuantity, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
--		@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID,  @DepartmentCode

--	END 
--	Close @D07_Cursor
--END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

