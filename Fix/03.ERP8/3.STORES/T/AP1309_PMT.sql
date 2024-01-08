IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1309_PMT]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1309_PMT]
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
--------- Modified by Huỳnh Thử on 18/01/2021: VCNB: Vừa có nhập vừa có xuất (Orders = NULL), Trừ số lượng xuất chuyển nếu InDebitAmount = 0
--------- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.

/********************************************
'* Edited by: [GS] [Việt Khánh] [29/07/2010]
'********************************************/
--- exec AP1309 @DivisionID=N'NH',@TranMonth=3,@TranYear=2016,@FromInventoryID=N'BS04K004',@ToInventoryID=N'BS04K004',@FromWareHouseID=N'DN010',@ToWareHouseID=N'ZS003',@FromAccountID=N'152',@ToAccountID=N'158',@UserID=N'ASOFTADMIN',@GroupID=N'ADMIN'

CREATE PROCEDURE [dbo].[AP1309_PMT] 
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
INSERT INTO HistoryCalculatePrice (DivisionID,TranMonth,TranYear,FromInventoryID,ToInventoryID,FromWareHouseID,ToWareHouseID,
											FromAccountID,ToAccountID,CreateUserID,CreateDate)
VALUES (@DivisionID, @TranMonth, @TranYear, @FromInventoryID, @ToInventoryID, @FromWareHouseID, @ToWareHouseID,
									@FromAccountID, @ToAccountID, @UserID, GETDATE())
									
IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
	EXEC AP1309_QC @DivisionID, @TranMonth, @TranYear, @FromInventoryID, @ToInventoryID, @FromWareHouseID, @ToWareHouseID, @FromAccountID, @ToAccountID, @UserID, @GroupID
ELSE
BEGIN
	DECLARE 
		@sSQL NVARCHAR(MAX), 
		@sSQL1 NVARCHAR(MAX),
		@sSQL2 NVARCHAR(MAX),
		@QuantityDecimals TINYINT, 
		@UnitCostDecimals TINYINT,
		@ConvertedDecimals TINYINT,
		@CustomerName INT

	--Tao bang tam de kiem tra day co phai la khach hang TBIV khong (CustomerName = 29)
	CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
	INSERT #CustomerName EXEC AP4444
	SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

	IF @CustomerName = 57 -------- ANGEL
	BEGIN
		EXEC AP1309_AG @DivisionID, @TranMonth, @TranYear, @FromInventoryID, @ToInventoryID, @FromWareHouseID, @ToWareHouseID, @FromAccountID, @ToAccountID, @UserID, @GroupID
	END
	ELSE IF @CustomerName = 32	--- PHÚC LONG
	BEGIN
		EXEC AP1309_PL @DivisionID, @TranMonth, @TranYear, @FromInventoryID, @ToInventoryID, @FromWareHouseID, @ToWareHouseID, @FromAccountID, @ToAccountID, @UserID, @GroupID
	END
	ELSE IF @CustomerName = 49	--- FIGLA
	BEGIN
		EXEC AP1309_FL @DivisionID, @TranMonth, @TranYear, @FromInventoryID, @ToInventoryID, @FromWareHouseID, @ToWareHouseID, @FromAccountID, @ToAccountID, @UserID, @GroupID, @TransProcessesID
	END	
	ELSE 
	BEGIN 
		SELECT @QuantityDecimals = QuantityDecimals, 
			@UnitCostDecimals = UnitCostDecimals, 
			@ConvertedDecimals = ConvertedDecimals
		FROM AT1101 WITH (NOLOCK)
		WHERE DivisionID =@DivisionID

		SET @QuantityDecimals = ISNULL(@QuantityDecimals, 2)
		SET @UnitCostDecimals = ISNULL(@UnitCostDecimals, 2)
		SET @ConvertedDecimals = ISNULL(@ConvertedDecimals, 2)
		-- Ghi lai history
		Insert into HistoryInfo(TableID, ModifyUserID, ModifyDate, Action, VoucherNo, TransactionTypeID, DivisionID)
		Values ('WF0056', @UserID, GETDATE(), 9, @GroupID,'',@DivisionID)

		--Cap nhat gia xuat tra lai hang mua = gia cua phieu tra lai hang mua
		UPDATE AT2007 
		SET AT2007.UnitPrice = (CASE WHEN ActualQuantity <> 0 THEN ROUND(AT9000.ConvertedAmount / ActualQuantity, @UnitCostDecimals) ELSE 0 END),
			AT2007.ConvertedPrice =  (CASE WHEN ActualQuantity <> 0 THEN ROUND(AT9000.ConvertedAmount / ActualQuantity, @UnitCostDecimals) ELSE 0 END),
			OriginalAmount = AT9000.ConvertedAmount, 
			ConvertedAmount = AT9000.ConvertedAmount
		FROM AT2007 WITH (ROWLOCK)
			INNER JOIN AT2006 WITH (ROWLOCK) ON AT2006.DivisionID = AT2007.DivisionID AND AT2006.VoucherID = AT2007.VoucherID
			INNER JOIN AT9000 WITH (ROWLOCK) ON AT9000.DivisionID = AT2007.DivisionID AND AT9000.VoucherID = AT2007.VoucherID AND AT9000.TransactionID = AT2007.TransactionID
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
				AND (Select MethodID From AT1302 WITH (NOLOCK) Where DivisionID = AT2007.DivisionID And InventoryID = AT2007.InventoryID) IN (4, 5)
				AND (Select KindVoucherID From AT2006 WITH (NOLOCK) Where DivisionID = AT2007.DivisionID And VoucherID = AT2007.VoucherID) = 3
				AND (Select WareHouseID2 From AT2006 WITH (NOLOCK) Where DivisionID = AT2007.DivisionID And VoucherID = AT2007.VoucherID) BETWEEN @FromWareHouseID AND @ToWareHouseID
				
		 
		ELSE --- FIGLA
			UPDATE AT2007 
			SET UnitPrice = 0,
				ConvertedPrice = 0, 
				OriginalAmount = 0, 
				ConvertedAmount = 0
			FROM AT2007 WITH (ROWLOCK) 
				INNER JOIN AT2006 WITH (NOLOCK) ON AT2007.DivisionID = AT2006.DivisionID AND AT2007.VoucherID = AT2006.VoucherID
				INNER Join AT1302 WITH (NOLOCK) ON AT2007.InventoryID = AT1302.InventoryID
			WHERE AT2007.TranMonth = @TranMonth 
				AND AT2007.TranYear = @TranYear
				AND (AT2007.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID) 
				AND MethodID IN (4, 5)
				AND (WareHouseID2 BETWEEN @FromWareHouseID AND @ToWareHouseID )
				AND (CreditAccountID BETWEEN @FromAccountID AND @ToAccountID )
				AND KindVoucherID in (2,3)
				AND AT2007.DivisionID = @DivisionID
		--select *From AV1309 where inventoryid= 'ALTCOB1240/D11'
		SET @sSQL = '
		SELECT AT2008.WareHouseID, 
			AT2008.InventoryID, 
			AT2008.InventoryAccountID, 
			--AT1302.InventoryName AS InventoryName, 
			--AT1303.WareHouseName AS WareHouseName, 
			AT2008.DivisionID,
			SUM(ISNULL(AT2008.BeginQuantity, 0)) AS ActBegQty, 
			SUM(ISNULL(AT2008.BeginAmount, 0)) AS ActBegTotal, 
			SUM(ISNULL(AT2008.DebitQuantity, 0)) AS ActReceivedQty, 
			SUM(ISNULL(AT2008.DebitAmount, 0)) AS ActReceivedTotal, 
			SUM(ISNULL(AT2008.CreditQuantity, 0)) AS ActDeliveryQty, 
			SUM(ISNULL(AT2008.EndQuantity, 0)) AS ActEndQty, 
			CASE WHEN (SUM(ISNULL(AT2008.BeginQuantity, 0) + ISNULL(AT2008.DebitQuantity, 0)
					  )) = 0 
				THEN 0 
				ELSE convert(decimal(28,8),(SUM(ISNULL(AT2008.BeginAmount, 0) + ISNULL(AT2008.DebitAmount, 0)) - ISNULL((Select SUM(AT2007.ConvertedAmount) From AT2007 Inner join AT2006 on AT2006.DivisionID = AT2007.DivisionID And AT2006.VoucherID = AT2007.VoucherID Where AT2007.DivisionID = AT2008.DivisionID And AT2007.TranMonth = ' + LTRIM(@TranMonth) + ' And AT2007.TranYear = ' + LTRIM(@TranYear) + ' And AT2006.WarehouseID = AT2008.WarehouseID And AT2006.KindVoucherID = 10 And AT2007.InventoryID = AT2008.InventoryID And Isnull(AT2007.ActualQuantity,0) = 0),0))) / 
					convert(decimal(28,8),(SUM(ISNULL(AT2008.BeginQuantity, 0) + ISNULL(AT2008.DebitQuantity, 0))
						)) 
			END AS UnitPrice, 
			CASE WHEN (SUM(ISNULL(AT2008.BeginQuantity, 0) + ISNULL(AT2008.DebitQuantity, 0)
					  )) = 0 
				THEN 0 
				ELSE convert(decimal(28,8),(SUM(ISNULL(AT2008.BeginAmount, 0) + CASE WHEN ISNULL(AT2008.DebitQuantity, 0) = ISNULL(AT2008.InDebitQuantity, 0)  AND ISNULL(AT2008.BeginAmount, 0) = 0 
																						THEN ISNULL(AT2008.DebitAmount, 0) 
																						ELSE ISNULL(AT2008.DebitAmount, 0) - ISNULL(AT2008.InDebitAmount, 0) END ) - 
				ISNULL((Select SUM(AT2007.ConvertedAmount) 
				From AT2007 
				Inner join AT2006 on AT2006.DivisionID = AT2007.DivisionID And AT2006.VoucherID = AT2007.VoucherID 
				Where AT2007.DivisionID = AT2008.DivisionID 
				And AT2007.TranMonth = ' + LTRIM(@TranMonth) + ' 
				And AT2007.TranYear = ' + LTRIM(@TranYear) + ' 
				And AT2006.WarehouseID = AT2008.WarehouseID 
				And AT2006.KindVoucherID = 10 
				And AT2007.InventoryID = AT2008.InventoryID 
				And Isnull(AT2007.ActualQuantity,0) = 0),0))) / 
				convert(decimal(28,8),(CASE WHEN SUM(ISNULL(AT2008.BeginQuantity, 0) + CASE WHEN ISNULL(AT2008.DebitQuantity, 0) = ISNULL(AT2008.InDebitQuantity, 0)  AND ISNULL(AT2008.BeginAmount, 0) = 0  
																					THEN ISNULL(AT2008.DebitQuantity, 0) 
																					ELSE ISNULL(AT2008.DebitQuantity, 0) - ISNULL(AT2008.InDebitQuantity, 0) END  ) = 0 THEN 1 ELSE
                                                                                    SUM(ISNULL(AT2008.BeginQuantity, 0) + CASE WHEN ISNULL(AT2008.DebitQuantity, 0) = ISNULL(AT2008.InDebitQuantity, 0)  AND ISNULL(AT2008.BeginAmount, 0) = 0  
																					THEN ISNULL(AT2008.DebitQuantity, 0) 
																					ELSE ISNULL(AT2008.DebitQuantity, 0) - ISNULL(AT2008.InDebitQuantity, 0) END  ) END 

						)) 
			END AS UnitPrice2,
			SUM(AT2008.InDebitQuantity) as InDebitQuantity,
			SUM(ISNULL(AT2008.INDebitAmount, 0))  as INDebitAmount
		FROM AT2008  WITH (NOLOCK)
		--INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = AT2008.InventoryID 
		--INNER JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1303.WareHouseID = AT2008.WareHouseID 
		WHERE AT2008.DivisionID = ''' + @DivisionID + ''' 
			AND AT2008.TranYear = ' + str(@TranYear) + ' 
			AND AT2008.TranMonth = ' + str(@TranMonth) + ' 
			AND (SELECT MethodID FROM AT1302 WITH (NOLOCK) WHERE InventoryID = AT2008.InventoryID) = 4
			AND (AT2008.WareHouseID BETWEEN ''' + @FromWareHouseID + ''' AND ''' + @ToWareHouseID + ''') 
			AND (AT2008.InventoryAccountID BETWEEN ''' + @FromAccountID + ''' AND ''' + @ToAccountID + ''') 
			AND (AT2008.InventoryID BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + ''') 
		GROUP BY AT2008.WareHouseID, 
			AT2008.InventoryID, 
			--AT1303.WareHouseName, 
			--AT1302.InventoryName, 
			AT2008.InventoryAccountID,
			AT2008.DivisionID 
		'

		IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE Xtype = 'V' AND Name = 'AV1309')
			EXEC (' CREATE VIEW AV1309 AS ' + @sSQL)
		ELSE
			EXEC (' ALTER VIEW AV1309 AS ' + @sSQL)


			EXEC( @sSQL)
		--PRINT @sSQL1
		--PRINT @sSQL2    

		If @CustomerName = 8
		BEGIN
			------ Ap gia nhap hang tra lai bang gia dau ky
			IF EXISTS 
			(
				SELECT TOP 1 1 
				FROM AT2007  WITH (NOLOCK)
					INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID AND AT2006.VoucherID = AT2007.VoucherID
					INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = AT2007.InventoryID
				WHERE AT2007.DivisionID = @DivisionID 
				AND AT2007.TranYear = @TranYear 
				AND AT2007.TranMonth = @TranMonth 
				AND KindVoucherID =7 
				AND At1302.MethodID = 4
			) 
				EXEC AP13081 @DivisionID, @TranMonth, @TranYear, @QuantityDecimals, @UnitCostDecimals, @ConvertedDecimals


			------ Ap gia nhap hang tai che bang gia dau ky
			IF EXISTS 
			(
				SELECT TOP 1 1 
				FROM AT2007  WITH (NOLOCK)
					INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID AND AT2006.VoucherID = AT2007.VoucherID
					INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = AT2007.InventoryID
				WHERE AT2007.DivisionID = @DivisionID 
				AND AT2007.TranYear = @TranYear
				AND AT2007.TranMonth = @TranMonth 
				AND KindVoucherID = 1 
				AND At1302.MethodID = 4
				AND IsGoodsRecycled = 1
			) 
				EXEC AP13082 @DivisionID, @TranMonth, @TranYear, @QuantityDecimals, @UnitCostDecimals, @ConvertedDecimals
		END

		------------ Xu ly chi tiet gia 
		
		------ Ap gia nhap nhap nguyen vat lieu phat sinh tu dong tu xuat thanh pham
			IF EXISTS 
			(
				SELECT TOP 1 1 
				FROM AT2007  WITH (NOLOCK)
					INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID AND AT2006.VoucherID = AT2007.VoucherID
					INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = AT2007.InventoryID
				WHERE AT2007.DivisionID = @DivisionID 
				AND AT2007.TranYear = @TranYear 
				AND AT2007.TranMonth = @TranMonth 
				AND KindVoucherID = 1 
				AND At1302.MethodID = 4
				AND (IsGoodsRecycled = 1 OR AT2006.IsReturn = 1)
			) 
				EXEC AP13082 @DivisionID, @TranMonth, @TranYear, @QuantityDecimals, @UnitCostDecimals, @ConvertedDecimals

		------ Tinh gia xuat kho; Gia Binh quan cho cac phieu xuat van chuyen noi bo
		IF EXISTS 
		(
			SELECT TOP 1 1 
			FROM AT2007  WITH (NOLOCK)
				INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID AND AT2006.VoucherID = AT2007.VoucherID
				INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = AT2007.InventoryID
			WHERE AT2007.DivisionID = @DivisionID 
			AND AT2007.TranYear = @TranYear 
			AND AT2007.TranMonth = @TranMonth 
			AND KindVoucherID = 3 
			AND At1302.MethodID = 4
		) 
		BEGIN
			EXEC AP1308 @DivisionID, @TranMonth, @TranYear, @QuantityDecimals, @UnitCostDecimals, @ConvertedDecimals, @TransProcessesID
		END


		------ Tinh gia xuat kho; Gia Binh quan cho cac phieu xuat kho thuong
		IF EXISTS 
		(
			SELECT TOP 1 1 
			FROM AT2007 WITH (NOLOCK) 
				INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID AND AT2006.VoucherID = AT2007.VoucherID
				INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = AT2007.InventoryID
			WHERE AT2007.DivisionID = @DivisionID 
			AND AT2007.TranYear = @TranYear 
			AND AT2007.TranMonth = @TranMonth 
			AND KindVoucherID IN (2, 4, 6, 8) 
			AND At1302.MethodID = 4
		)
		BEGIN
				EXEC AP1307 @DivisionID, @TranMonth, @TranYear, @QuantityDecimals, @UnitCostDecimals, @ConvertedDecimals
		END

		----------- Tinh gia xuat kho binh quan lien hoan
		IF EXISTS 
		(
			SELECT TOP 1 1 
			FROM AT2007 WITH (NOLOCK) 
				INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID AND AT2006.VoucherID = AT2007.VoucherID
				INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = AT2007.InventoryID
			WHERE AT2007.DivisionID = @DivisionID 
			AND AT2007.TranYear = @TranYear 
			AND AT2007.TranMonth = @TranMonth 
			AND KindVoucherID IN (2, 3, 4, 6, 8) 
			AND AT1302.MethodID = 5
		)
		BEGIN 
			EXEC AP1410 @DivisionID, @TranMonth, @TranYear, @QuantityDecimals, @UnitCostDecimals, @ConvertedDecimals, 
				@FromInventoryID, @ToInventoryID, @FromWareHouseID, @ToWareHouseID, @FromAccountID, @ToAccountID
		END

		----------- Tinh gia TTDD
		IF EXISTS 
		(
			SELECT TOP 1 1 
			FROM AT2007 WITH (NOLOCK) 
				INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID AND AT2006.VoucherID = AT2007.VoucherID
				INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = AT2007.InventoryID
			WHERE AT2007.DivisionID = @DivisionID 
			AND AT2007.TranYear = @TranYear 
			AND AT2007.TranMonth = @TranMonth 
			AND KindVoucherID IN (2, 3, 4, 6, 8) 
			AND At1302.MethodID = 3
		) 
			EXEC AP1305 @DivisionID, @TranMonth, @TranYear, @FromAccountID, @ToAccountID

		----- XU LY LAM TRON CHO CÁC PHƯƠNG PHÁP <> FIFO
			
		DECLARE 
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
			SELECT WareHouseID, 
				AT2008.InventoryID, 
				InventoryAccountID, 
				EndAmount
			FROM AT2008 WITH (NOLOCK) ---inner join AT1302 on AT2008.DivisionID = AT1302.DivisionID and AT2008.InventoryID = AT1302.InventoryID
			WHERE AT2008.DivisionID = @DivisionID 
				AND TranYear = @TranYear 
				AND TranMonth = @TranMonth 
				AND (AT2008.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID)
				AND EndQuantity = 0 
				AND EndAmount <> 0
				AND DebitQuantity + CreditQuantity <> 0
				AND NOT EXISTS (SELECT 1 FROM AT1302 WITH (NOLOCK) WHERE InventoryID = AT2008.InventoryID AND MethodID = 1)
				AND (WarehouseID BETWEEN @FromWarehouseID AND @ToWarehouseID)
				AND (InventoryAccountID BETWEEN @FromAccountID AND @ToAccountID)
        
		OPEN @Cur_Ware
		FETCH NEXT FROM @Cur_Ware INTO  @WareHouseID, @InventoryID, @AccountID, @Amount

		WHILE @@Fetch_Status = 0 
			BEGIN
				IF @CustomerName <> 29 or (@CustomerName = 29 and @WareHouseID <> 'SCTP') --- customize TBIV: nếu là kho sửa chữa thì không làm tròn để phiếu xuất của kho này không bị cập nhật lại tiền
				BEGIN
					SET @TransactionID = 
					(
						SELECT TOP 1 D11.TransactionID
						FROM AT2007 D11 WITH (NOLOCK)
							LEFT JOIN AT2007 D12 WITH (NOLOCK) ON D12.TransactionID = D11.ReTransactionID
							INNER JOIN AT2006 D9 WITH (NOLOCK) ON D9.DivisionID = D11.DivisionID AND D9.VoucherID = D11.VoucherID
						WHERE D11.DivisionID = @DivisionID
							AND D11.TranYear = @TranYear
							AND D11.TranMonth = @TranMonth
							AND D11.InventoryID = @InventoryID 
							AND D11.CreditAccountID = @AccountID
							AND (CASE WHEN D9.KindVoucherID = 3 THEN D9.WareHouseID2 ELSE D9.WareHouseID END) = @WareHouseID 
							AND D9.KindVoucherID IN (2, 3, 4, 6, 8,7)---,1) 	
						ORDER BY CASE WHEN D9.KindVoucherID = 3 THEN 1 ELSE 0 END, 
							ISNULL((SELECT TOP 1 1 FROM AT2007 WITH (NOLOCK) INNER JOIN AT2006 WITH (NOLOCK) ON AT2007.DivisionID = AT2006.DivisionID AND AT2007.VoucherID = AT2006.VoucherID
								WHERE AT2007.DivisionID = @DivisionID AND AT2007.TranMonth = @TranMonth AND AT2007.TranYear = @TranYear
								AND AT2007.InventoryID = @InventoryID AND AT2006.KindVoucherID = 3 AND AT2006.WareHouseID2 = D9.WareHouseID),0), 
							CASE WHEN D11.ActualQuantity = D12.ActualQuantity AND D11.ConvertedAmount < D12.ConvertedAmount THEN 0 ELSE 1 END, D11.ConvertedAmount DESC
					)			
					IF @TransactionID IS NOT NULL
						BEGIN
							UPDATE AT2007
							SET ConvertedAmount = ISNULL(ConvertedAmount, 0) + @Amount, 
								OriginalAmount = ISNULL(OriginalAmount, 0) + @Amount
							FROM AT2007 WITH (ROWLOCK) 
							WHERE AT2007.DivisionID = @DivisionID and AT2007.TransactionID = @TransactionID
							SET @CountUpdate = @CountUpdate + 1
						END
				END
		
				FETCH NEXT FROM @Cur_Ware INTO @WareHouseID, @InventoryID, @AccountID, @Amount
			END 

		CLOSE @Cur_Ware


		IF EXISTS 
		(
			SELECT TOP 1 1 
			FROM AT2008  WITH (NOLOCK)
			WHERE DivisionID = @DivisionID
				AND TranYear = @TranYear 
				AND TranMonth = @TranMonth 
				AND (InventoryID BETWEEN @FromInventoryID AND @ToInventoryID)
				AND EndQuantity = 0 
				AND EndAmount <> 0
				AND DebitQuantity + CreditQuantity <> 0
				AND NOT EXISTS (SELECT 1 FROM AT1302 WITH (NOLOCK) WHERE InventoryID = AT2008.InventoryID AND MethodID = 1)
				AND (WarehouseID BETWEEN @FromWarehouseID AND @ToWarehouseID)
				AND (InventoryAccountID BETWEEN @FromAccountID AND @ToAccountID)
		) 
			AND @CountUpdate > 0
    
			GOTO ReCal
		
		------------ Tinh gia xuat kho theo PP FIFO 
		IF EXISTS 
		(
			SELECT TOP 1 1 
			FROM AT2007  WITH (NOLOCK)
				INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID AND AT2006.VoucherID = AT2007.VoucherID
				INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = AT2007.InventoryID
			WHERE AT2007.DivisionID = @DivisionID 
				AND AT2007.TranYear = @TranYear 
				AND AT2007.TranMonth = @TranMonth 
				AND KindVoucherID IN (2, 3, 4, 6, 8) 
				AND At1302.MethodID = 1
		) 
		begin
			EXEC AP1303 @DivisionID, @TranMonth, @TranYear,   @FromInventoryID,   @ToInventoryID, @FromWareHouseID, @ToWareHouseID
			--return -- da xu ly lam trong trong store AP1303 nen thoat luon khong vo doan lam trong ben duoi nua
		end

		IF ISNULL(@TransProcessesID,'') <> ''
		BEGIN
			UPDATE AT2008 SET TransProcessesID = @TransProcessesID
			WHERE AT2008.DivisionID = @DivisionID
				AND TranYear = @TranYear 
				AND TranMonth = @TranMonth 
				AND (WareHouseID BETWEEN @FromWareHouseID AND @ToWareHouseID)
				AND (InventoryAccountID BETWEEN @FromAccountID AND @ToAccountID)
				AND (AT2008.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID)
		END
	END
END 









GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
