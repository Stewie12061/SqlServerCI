IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1309]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1309]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--------- Created by Nguyen Van Nhan, Date 06/09/2003
--------- Purpose: Tinh gia binh quan gia quyen cuoi ky
--------- Edit by: Dang Le Bao Quynh, Date 08/12/2006
--------- Purpose: Them phuong phap tinh gia binh quan lien hoan
--------- Edit by: Dang Le Bao Quynh, Date 30/06/2008
--------- Purpose: Xu ly lam tron
--------- Edit by: Dang Le Bao Quynh, Date 05/09/2008
--------- Purpose: Cap nhat cac phieu VCNB = 0 truoc khi tinh cho cac ma hang tinh theo phuong phap binh quan
--------- Edit by: Dang Le Bao Quynh, Date 19/09/2008
--------- Purpose: Cap nhat cac phieu nhap hang ban tra lai = 0 truoc khi tinh cho cac ma hang tinh theo phuong phap binh quan
--------- Edit by: Dang Le Bao Quynh, Date 19/05/2010
--------- Purpose: Sap xep lai thu tu cac phieu xuat khi lam tron.
--------- Edit by: Khanh Van, Date 23/01/2013
--------- Purpose: Ap gia nhap hang tra lai va hang tai che bang gia ton dau cho Binh Tay
--------- Edit by: Khanh Van, Date 02/07/2013
--------- Purpose: Áp giá đầu kỳ cho nguyên vật liệu cho PMT
--------- Edit by: Khanh Van, Date 16/09/2013
--------- Purpose: Kết thêm division và tối ưu hóa câu query
--------- Modify on 27/12/2013 by Bảo Anh: Dùng biến table @AV1309 thay AV1309 để cải thiện tốc độ
--------- Modify on 31/12/2013 by Khanh Van: Ghi lại history tính giá thành
--------- Modify on 20/02/2014 by Bảo Anh: Không dùng biến table @AV1309 thay AV1309 nữa vì tính giá xuất không đúng
--------- Modify on 08/05/2014 by Bảo Anh: Bỏ cập nhật thành tiền cho phiếu nhập khi xử lý làm tròn (lỗi TBIV)
--------- Modify on 27/05/2014 by Bảo Anh: khi xử lý làm tròn không cập nhật thành tiền cho phiếu xuất từ kho sửa chữa (customize TBIV)
--------- Modify on 18/08/2015 by Tiểu Mai: Bổ sung đơn giá quy đổi = đơn giá chuẩn
--------- Modified on 08/10/2015 by Tieu Mai: Sửa phần làm tròn số lẻ theo thiết lập đơn vị-chi nhánh
--------- Modified on 04/11/2015 by Tiểu Mai: Bổ sung xử lý tính giá hàng hóa theo quy cách.
--------- Modify on 18/12/2015 by Bảo Anh: khi xử lý làm tròn không dùng Round cho @Amount
--------- Modify on 11/01/2016 by Bảo Anh:	1/ khi tính đơn giá xuất,không trừ số lượng VCNB khi giá trị VCNB = 0
---------									2/ Bổ sung convert khi tính đơn giá bình quân ở view AV1309 để số lẻ không bị làm tròn
--------- Modify on 11/01/2016 by Bảo Anh:	Cải tiến tốc độ
--------- Modify on 22/04/2016 by Bảo Anh:	Update giá = 0 cho phiếu xuất trước khi tính (Customize FIGLA)
--------- Modified by Bảo Thy on 27/05/2016: Bổ sung WITH (NOLOCK)
--------- Modified by Bảo Anh on 11/07/2016: Bổ sung WITH (ROWLOCK) để giải quyết deadlock, cải tiến tốc độ
--------- Modified by Tiểu Mai on 02/08/2016: Bổ sung áp giá xuất cho phiếu lắp ráp ANGEL (AT0113)
--------- Modified by Phương Thảo on 31/08/2016: Bổ sung WITH(ROWLOCK) cho đoạn áp giá phiếu lắp ráp
--------- Modified by Tiểu Mai on 21/11/2016: Bổ sung gọi store riêng cho ANGEL (CustomizeIndex = 57)
--------- Modify on 18/05/2017 by Bảo Anh: Sửa danh mục dùng chung
--------- Modified by Tiểu Mai on 29/06/2017: Bổ sung tham số @TransProcessesID (quy trình chuyển kho)
--------- Modified by Hải Long on 11/08/2017: Bổ sung trường hợp KindVoucherID = 10 (Hàng mua trả lại) cho trường hợp tính giá FIFO
--------- Modified by Phương Thảo on 16/08/2017: Bổ sung áp giá cho phiếu nhập kho trả lại
--------- Modified by Phương Thảo on 14/11/2017: Bổ sung truyền biến tài khoản tồn kho cho sp AP1305 (TTDD)
--------- Modified by Bảo Anh on 28/12/2017: Trừ thêm tiền giảm giá hàng mua khi tính đơn giá ở AV1309
--------- Modified by Bảo Anh on 26/01/2018: Bổ sung store tính giá riêng cho Phúc Long
--------- Modified by Bảo Anh on 05/06/2018: Chuyển đoạn tính giá FIFO ra sau cùng để không bị thoát khỏi đoạn làm tròn cho các phương pháp khác
--------- Modified by Bảo Anh on 18/06/2018: Bổ sung ghi nhận lịch sử tính giá, store customize FIGLA
--------- Modified by Bảo Anh on 10/07/2018: Cải tiến tốc độ
--------- Modified by Kim Thư on 24/01/2019: Bổ sung lấy phiếu update giá ưu tiên phiếu có kho nhập mà kho này không xuất hàng trong kỳ nữa
--------- Modified by Kim Thư on 06/03/2019: Sắp xếp thứ tự where để cải thiện tốc độ
--------- Modified by Kim Thư on 09/04/2019: Sửa kết bảng danh mục dùng chung
--------- Modified by Kim Thư on 04/07/2019: Bổ sung điều kiện WarehouseID và AccountID khi kiểm tra làm tròn (vì có trường hợp ko tính giá tất cả kho / mặt hàng / tài khoản)
--------- Modified by Trà Giang on 01/07/2019: Tính giá xuất kho PP bình quân gia quyền bằng ma trận. 
--------- Modified by Văn Tài	on 12/11/2019: Bổ sung kiểm tra vùng mặt hàng và vùng tài khoản khi tính: thực tế đích danh.
--------- Modified by Minh Chương on 12/12/2019: Thay đổi điều kiện WarehouseID tại Tính giá mặt hàng thực tế đích danh.
--------- Modified by Văn Tài	on 04/07/2020: Điều chỉnh lại format sql, không thay đổi cấu trúc code.
--------- Modified by Huỳnh Thử	on 23/07/2020: [Phúc Long] -- Đưa phần làm tròn lên code
--------- Modified by Huỳnh Thử	on 23/07/2020: [Phúc Long] -- Đưa phần làm tròn xuống Store -- Tránh bị Delock
--------- Modified by Huỳnh Thử	on 19/08/2020: Merge Code: MEKIO và MTE -- Tách Store: AP1303
--------- Modified by Huỳnh Thử	on 28/08/2020: [Phúc Long] -- Làm tròn những phiếu chuyển (Lấy transactionID <> KindVoucherID = 3)
--------- Modified by Huỳnh Thử	on 23/09/2020: [Phúc Long] -- Làm tròn những phiếu chuyển (Bỏ transactionID <> KindVoucherID = 3)
--------- Modify on 02/10/2020 by Nhựt Trường: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
--------- Modify on 01/12/2020 by Huỳnh Thử: Bổ sung ELSE cho trường hợp Phú Long
--------- Modify on 01/12/2020 by Huỳnh Thử: Update Giá = 0 tại phiếu nhập IsGoodsRecycled = 1 
--------- Modify on 29/12/2020 by Huỳnh Thử: Đưa PMT(62) vào luồng làm tròn PL--> Cải thiện tốc tộ
--------- Modified by Huỳnh Thử on 12/01/2021: Customezie KoYo: Sử dụng lại store cũ trước đưa vào ma trận. Vì ma trận không xử lý được trường hợp Chuyển Kho Chuyển Tài Khoản.
--------- Modified by Huỳnh Thử on 18/01/2021: Customezie PMT: Tách Store: Sử dụng lại store cũ trước đưa vào ma trận. Vì ma trận không xử lý được trường hợp Chuyển Kho lòng vòng
--------- Modified by Huỳnh Thử on 12/01/2021: Customezie [Tiên Tiến] -- Tách Store: Phiếu nhập xuất sửa tài khoản không cập nhật AT2008.
--------- Modified by Văn Tài	on 27/10/2021: Xử lý vấn đề giải quyết EndAmount cho các phiếu chuyển kho và dữ liệu kho AT2008.
--------- Modified by Xuân Nguyên	on 14/02/2022: [BASON] -[2022/02/IS/0048] -- Tách sotre : làm tròn thành tiền theo thiết lập
--------- Modified by Xuân Nguyên	on 15/02/2022: [2022/02/IS/0005] -- Bổ sung Try Cacth
--------- Modified by Nhựt Trường	on 29/04/2022: Customize Angel - Bổ sung bảng AT1334.
--------- Modified by Văn Tài		on 18/07/2022: Điều chỉnh quy tắc đặt tên. Dùng tên bảng theo quy định để xử lý kế thừa dữ liệu ở các store.
--------- Modified by Nhựt Trường   on 30/03/2023: Khai báo lại kiểu dữ liệu biến @EndAmount khi xử lý lượng hết tiền còn PP bình quân gia quyền.
----------------------------------------------------------------------------------------------------------------------------------------------------------------
/** exec AP1309 
	@DivisionID = N'NH'
	, @TranMonth = 3
	, @TranYear = 2016
	, @FromInventoryID = N'BS04K004'
	, @ToInventoryID = N'BS04K004'
	, @FromWareHouseID = N'DN010'
	, @ToWareHouseID = N'ZS003'
	, @FromAccountID = N'152'
	, @ToAccountID = N'158'
	, @UserID = N'ASOFTADMIN'
	, @GroupID = N'ADMIN'
**/
CREATE PROCEDURE [dbo].[AP1309] 
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
    @TransProcessesID NVARCHAR(50)=''
AS

DECLARE @CountTest INT = 0;
DECLARE @APK_AT2007 NVARCHAR(50) = NULL

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

		IF EXISTS (Select * From sysobjects Where name = 'AT1334' and xtype ='U')
		BEGIN
			DELETE FROM AT1334
		END
		ELSE 
			CREATE TABLE AT1334 (InventoryID NVARCHAR(50), [Type] INT)

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
	ELSE IF @CustomerName = 13	--- TienTien
	BEGIN
		EXEC AP1309_TIENTIEN @DivisionID
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
	ELSE IF @CustomerName = 84	--- BASON
	BEGIN
		EXEC AP1309_BS @DivisionID
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
		AND (AT2008.WarehouseID BETWEEN @FromWarehouseID AND @ToWarehouseID)
		AND (AT2008.InventoryAccountID BETWEEN @FromAccountID AND @ToAccountID)
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
		@EndAmount Decimal(28,8)--,
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

			AND (AT2008.WarehouseID BETWEEN @FromWarehouseID AND @ToWarehouseID)
			AND (AT2008.InventoryAccountID BETWEEN @FromAccountID AND @ToAccountID)
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
				-- TEST
				--SELECT @CountTest = COUNT(*)
				--FROM AT2008 WITH (NOLOCK)
				--LEFT JOIN AT2007 WITH (NOLOCK) ON AT2007.DivisionID = AT2008.DivisionID 
				--							AND  AT2007.CreditAccountID = AT2008.InventoryAccountID 
				--							AND AT2007.InventoryID = AT2008.InventoryID 
				--							AND AT2007.TranMonth = AT2008.TranMonth 
				--							AND AT2007.TranYear = AT2008.TranYear
				--							AND AT2008.InventoryID = AT2007.InventoryID 
				--LEFT JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID 
				--WHERE
				--	AT2008.DivisionID = @DivisionID
				--	AND AT2008.TranYear = @TranYear 
				--	AND AT2008.TranMonth = @TranMonth 
				--	AND AT2008.EndAmount <> 0 AND AT2008.EndQuantity = 0  
				--	AND (AT2008.WarehouseID BETWEEN @FromWarehouseID AND @ToWarehouseID)
				--	AND (AT2008.InventoryAccountID BETWEEN @FromAccountID AND @ToAccountID)
				--	AND (AT2008.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID)
				--GROUP BY AT2008.InventoryID
				--	, AT2008.InventoryAccountID
				--	, AT2008.WareHouseID
				--	, AT2008.EndAmount
				--	, AT2008.TranMonth
				--	, AT2008.TranYear
					
				--PRINT ('COUNT STEP 3: ' + STR(@CountTest))
				--PRINT (@WareHouseIDCur)
				--PRINT (@TransactionID)
				--PRINT (SUBSTRING(@TransactionID,0,LEN(@TransactionID)))
				--PRINT ('@EndAmount: ' + STR(@EndAmount))
				
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

		--- TEST
		--SELECT @CountTest = COUNT(*)
		--FROM AT2008  WITH (NOLOCK)
		--	WHERE DivisionID = @DivisionID
		--		AND TranYear = @TranYear
		--		AND TranMonth = @TranMonth 
		--		AND (WarehouseID BETWEEN @FromWarehouseID AND @ToWarehouseID)
		--		AND (InventoryAccountID BETWEEN @FromAccountID AND @ToAccountID)
		--		AND (InventoryID BETWEEN @FromInventoryID AND @ToInventoryID)
		--		AND EndQuantity = 0 
		--		AND EndAmount <> 0
		--		AND DebitQuantity + CreditQuantity <> 0
		--		AND NOT EXISTS (SELECT 1 FROM AT1302 WITH (NOLOCK) WHERE AT1302.DivisionID IN (AT2008.DivisionID,'@@@') AND InventoryID = AT2008.InventoryID AND MethodID = 1)
		--PRINT ('FromWarehouseID: ' + @FromWarehouseID)
		--PRINT ('ToWarehouseID: ' + @ToWarehouseID)
		--PRINT ('FromAccountID: ' + @FromAccountID)
		--PRINT ('ToWarehouseID: ' + @ToAccountID)
		--PRINT ('FromInventoryID: ' + @FromInventoryID)
		--PRINT ('ToInventoryID: ' + @ToInventoryID)
		--PRINT ('END COUNT: ' + STR(@CountTest))

		IF EXISTS (
		SELECT TOP 1 1 
			FROM AT2008  WITH (NOLOCK)
			WHERE DivisionID = @DivisionID
				AND TranYear = @TranYear
				AND TranMonth = @TranMonth 
				AND (WarehouseID BETWEEN @FromWarehouseID AND @ToWarehouseID)
				AND (InventoryAccountID BETWEEN @FromAccountID AND @ToAccountID)
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
