IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CMP00121]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CMP00121]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


----- Created by Khanh Van on 17/01/2014
----- Purpose: Tính hoa hồng
----- Modified on 28/12/2021 by Văn Tài: Xử lý tính hoa hồng theo nhóm hàng.
----- Modified on 25/08/2022 by Kiều Nga: Bổ sung xử lý tính huê hồng nhân viên sale theo mặt hàng
----- Modified on 20/09/2022 by Nhật Quang: Bổ sung xử lý tính huê hồng và phí bản quyền theo CustomerIndex EXEDY
----- Modified on 01/11/2022 by Nhật Quang: Bổ sung điều kiện INNER JOIN với bảng CMT0008, chỉ lấy những mặt hàng có trong phương pháp tính hoa hồng để tính.
----- Modified on 01/11/2022 by Nhật Quang: Bổ sung lấy đơn hàng bán trả lại từ AT9000, để tính lại phí hoa hồng.
----- Modified on 02/11/2022 by Nhật Quang: Bổ sung lấy đơn hàng bán trả lại từ AT9000, để tính lại doanh thu thực tế trừ đi doanh thu đơn hàng trả lại.
----- Modified on 28/03/2023 by Văn Tài	  : [2023/03/IS/0254] Điều chỉnh Decimal(28, 8), biến @Royalty dạng số.
--Exec CMP00121 'STH', 6, 2013,	'123', '123', 'abc'	
					
CREATE PROCEDURE [dbo].[CMP00121] 	
				 @DivisionID AS VARCHAR(50),   	
				 @UserID AS VARCHAR(50),
				 @TranMonth AS INT, 			
				 @TranYear AS INT,			
				 @CommissionMethodID AS NVARCHAR(50),
				 @VoucherNo AS NVARCHAR (50),
				 @Notes AS NVARCHAR (250),	
				 @Royalty AS INT = 0

AS
	DECLARE 
	@sSQL0 AS NVARCHAR(4000),
	@sSQL1 AS NVARCHAR(4000),
	@sSQL2 AS NVARCHAR(4000),
	@sSQL3 AS NVARCHAR(4000)

	DECLARE @CustomerIndex INT = (SELECT TOP 1 CustomerIndex.CustomerName FROM CustomerIndex WITH (NOLOCK))
	
	DECLARE
		@VoucherID AS NVARCHAR(50),
		@SOrderID AS VARCHAR(50),
		@PriceListID AS VARCHAR(50),
		@InventoryID AS NVARCHAR(50),
		@ObjectID AS NVARCHAR(50),
		@SalesManID AS NVARCHAR(50),
		@Quantity AS DECIMAL(28,8),
		@OrderQuantity AS DECIMAL(28,8),		
		@ConvertedAmount AS DECIMAL(28,8),
		@ReceivedAmount AS DECIMAL(28,8), -- Tổng thành tiền phiếu thu theo đơn hàng.
		@RevoucherID AS NVARCHAR(50),
		@APK AS VARCHAR(50),
		@IsRate AS TINYINT,  --- 0: Tỉ lệ, 1: Giá trị
		@CommissionType AS TINYINT, --- 0: Nhóm hàng, 1: Mặt hàng
		@RefType AS TINYINT, --- 0: Tham chiếu số lượng, 1: Tham chiếu doanh số.
		@InventoryGroupAnaTypeID AS VARCHAR(50) ='',
		@SaleAnaTypeID AS VARCHAR(50), --- MPT nhân viên bán hàng.
		@PriceUnit DECIMAL(28, 8) = 1,  --- Đơn vị khi tính toán huê hồng: Tỷ lệ: %, giá trị: 1.

		@Cor_cur AS CURSOR,
		@CurTemp CURSOR,
		@SOrderResult as VARCHAR(50),
		@InventoryIDResult as VARCHAR(50),
		@OrderQuantityResult as DECIMAL(28,8),
		@ConvertedAmountResult as DECIMAL(28,8),
		@RateValueResult as DECIMAL(28,8),
		@RefTypeResult as DECIMAL(28,8),
		@IsRateResult as DECIMAL(28,8),
		@CommissionTypeResult as DECIMAL(28,8),
		@CommissionAmount as DECIMAL(28,8),

		--- Khai báo biến tính phí bản quyền
		@RMRate DECIMAL(28, 8),
		@Packing DECIMAL(28, 8),
		@Transport as DECIMAL(28,8),
		@Insuarance as DECIMAL(28,8),
		@NetInvoice as DECIMAL(28,8),
		@RoyaltyPercent as DECIMAL(28,8),
		@RoyaltyRate as DECIMAL(28,8),
		@ExchangeRate as DECIMAL(28,8),
		@IsEXD as DECIMAL(28,8),
		@IsEFM as DECIMAL(28,8),
		@IsEXDExchangeRate as DECIMAL(28,8), 
		@IsEXT as DECIMAL(28,8), 
		@IsOther as DECIMAL(28,8)

	--- Dữ liệu chi tiết phiếu bán hàng.
	CREATE TABLE #CMP00121
	(
		Orders			INT	NULL,
		APK				VARCHAR(50),
		DivisionID		VARCHAR(50),
		VoucherTypeID	VARCHAR(50) NULL,
		SalesManID		VARCHAR(50),
		VoucherID		VARCHAR(50),
		SOrderID		VARCHAR(50),
		PriceListID		VARCHAR(50),
		InventoryID		VARCHAR(50),
		ObjectID		VARCHAR(50),
		OrderQuantity	DECIMAL(28, 8),
		UnitPrice		DECIMAL(28, 8),
		ConvertedAmount DECIMAL(28, 8),
		InventoryGroup	VARCHAR(50),
		RMRate DECIMAL(28, 8),
		Packing DECIMAL(28, 8),
		Transport DECIMAL(28, 8),
		Insuarance DECIMAL(28, 8),
		NetInvoice DECIMAL(28, 8),
		RoyaltyPercent DECIMAL(28, 8),
		RoyaltyRate DECIMAL(28, 8),
		ExchangeRate DECIMAL(28, 8),
	    IsEXD DECIMAL(28, 8),
	    IsEXDExchangeRate DECIMAL(28, 8),
	    IsEXT DECIMAL(28, 8),
	    IsEFM DECIMAL(28, 8),
	    IsOther DECIMAL(28, 8),
		UnitID VARCHAR(50),

	)

	--- Dữ liệu chi tiết phiếu bán hàng nhóm theo MPT nhóm hàng.
	CREATE TABLE #CMP00121Group
	(
		APK				VARCHAR(50),
		DivisionID		VARCHAR(50),
		VoucherTypeID	VARCHAR(50) NULL,
		SalesManID		VARCHAR(50),
		SOrderID		VARCHAR(50),
		VoucherID		VARCHAR(50),
		PriceListID		VARCHAR(50),
		InventoryGroup	VARCHAR(50),
		ObjectID		VARCHAR(50),
		UnitPrice		DECIMAL(28, 8),
		OrderQuantity	DECIMAL(28, 8),
		ConvertedAmount DECIMAL(28, 8),
		CommissionAmount DECIMAL(28, 8) NULL,
		UnitID VARCHAR(50),
	)

	--- Dữ liệu chi tiết phiếu bán hàng nhóm theo từng mặt hàng.
	CREATE TABLE #CMP00121Invent
	(
		APK				VARCHAR(50),
		DivisionID		VARCHAR(50),
		VoucherTypeID	VARCHAR(50) NULL,
		SalesManID		VARCHAR(50),
		SOrderID		VARCHAR(50),
		PriceListID		VARCHAR(50),
		InventoryGroup	VARCHAR(50),
		InventoryID		VARCHAR(50),
		ObjectID		VARCHAR(50),
		UnitPrice		DECIMAL(28, 8),
		OrderQuantity	DECIMAL(28, 8),
		ConvertedAmount DECIMAL(28, 8),
		CommissionAmount DECIMAL(28, 8),
	)

	--- Dữ liệu chi tiết phiếu thu.
	CREATE TABLE #CMP00121Rec
	(
		APK				VARCHAR(50),
		DivisionID		VARCHAR(50),		
		VoucherID		VARCHAR(50),
		TVoucherID		VARCHAR(50),
		ConvertedAmount DECIMAL(28, 8)
	)

Set @sSQL1 = N''
Set @sSQL2 = N''
Set @sSQL3 = N''

-- Thông tin MPT đặc tả nhóm hàng.
SELECT TOP 1 
	@InventoryGroupAnaTypeID = InventoryGroupAnaTypeID
	, @SaleAnaTypeID = SaleAnaTypeID
FROM AT0000 WITH (NOLOCK) 
WHERE DefDivisionID = @DivisionID

DECLARE @Col_InventoryGroupAnaTypeID VARCHAR(50) = @InventoryGroupAnaTypeID
DECLARE @Col_SaleAnaTypeID VARCHAR(50) = @SaleAnaTypeID

-- Xóa bảng tính hoa hồng trong tháng
IF(@Royalty = 1) ---  = 1 : Tính Phí bản quyền
	BEGIN
		DELETE CMT0012 WHERE DivisionID = @DivisionID AND TranYear = @TranYear AND TranMonth = @TranMonth AND IsRoyalty = 1
		DELETE CMT0013 WHERE DivisionID = @DivisionID AND TranYear = @TranYear AND TranMonth = @TranMonth AND IsRoyalty = 1
	END
ELSE 
IF(@Royalty = 0) --- = 0 : Tính huê hồng
	BEGIN
		DELETE CMT0012 WHERE DivisionID = @DivisionID AND TranYear = @TranYear AND TranMonth = @TranMonth AND CommissionMethodID = @CommissionMethodID AND IsRoyalty = 0 
		DELETE CMT0013 WHERE DivisionID = @DivisionID AND TranYear = @TranYear AND TranMonth = @TranMonth AND CommissionMethodID = @CommissionMethodID AND IsRoyalty = 0
	END
--- Thông tin phương pháp tính huê hồng
SELECT TOP 1 @IsRate = IsRate
	, @CommissionType = OptionType
FROM CMT0007 WITH (NOLOCK)
WHERE DivisionID = @DivisionID
	AND ISNULL(Disabled, 0 ) = 0
	AND CommissionMethodID = @CommissionMethodID

PRINT ('STEP 01')

	-- Khách hàng Đại Phát Tài
IF (@CustomerIndex = 145)
	BEGIN

		SET @APK = NULL
		SET @SalesManID = NULL
		SET @SOrderID = NULL
		SET @PriceListID = NULL
		SET @InventoryID = NULL
		SET @ObjectID = NULL
		SET @OrderQuantity = NULL
		SET @ConvertedAmount = NULL

		PRINT ('STEP 02')

		IF (ISNULL(@Col_InventoryGroupAnaTypeID, '') = '')
			SET @Col_InventoryGroupAnaTypeID = ''''
		ELSE
			SET @Col_InventoryGroupAnaTypeID = CONCAT(@Col_InventoryGroupAnaTypeID, 'ID')

		--- Lấy dữ liệu đơn hàng bán.
		BEGIN
			SET @sSQL0 = '
				INSERT INTO #CMP00121
				(
					DivisionID
					, SalesManID
					, SOrderID
					, PriceListID
					, InventoryID
					, ObjectID
					, OrderQuantity
					, UnitPrice
					, ConvertedAmount
					, APK
					, InventoryGroup
				)
				SELECT	  OT01.DivisionID
						, OT01.SalesManID
						, OT01.SOrderID
						, OT01.PriceListID
						, OT02.InventoryID
						, OT01.ObjectID
						, OT02.OrderQuantity
						, OT02.SalePrice
						, OT02.ConvertedAmount
						, OT02.APK
						, ' + @Col_InventoryGroupAnaTypeID + ' AS InventoryGroup					
				FROM OT2002 OT02 WITH (NOLOCK)
				INNER JOIN OT2001 OT01 WITH (NOLOCK) ON OT01.DivisionID = OT02.DivisionID 
						AND OT01.SOrderID = OT02.SOrderID
				LEFT JOIN AT1302 AT02 WITH (NOLOCK) ON AT02.DivisionID IN (''@@@'', OT01.DivisionID)
						AND AT02.InventoryID = OT02.InventoryID
				WHERE OT01.DivisionID = '''  + @DivisionID + '''
					AND OT01.TranYear = ' + STR(@TranYear) + '
					AND OT01.TranMonth = ' +STR(@TranMonth) + '
					AND ISNULL(OT01.OrderStatus, 0) = 1
				ORDER BY VoucherNo
			'

			PRINT (@sSQL0)
			EXEC (@sSQL0)

			--- TEST
			--- Lấy danh sách chi tiết tìm thấy
			SELECT '#CMP00121 Gather' AS #CMP00121
						, * 
			FROM #CMP00121

			-- Xóa các mặt hàng không phù hợp quy tắc bảng giá tối thiểu.
			BEGIN
				SELECT C21.SOrderID
					, C21.InventoryGroup
					, C21.InventoryID
			INTO #DELETE_OT02
			FROM #CMP00121 C21
			GROUP BY
				C21.SOrderID
				, C21.InventoryGroup
				, C21.InventoryID
				, C21.UnitPrice
			HAVING
				EXISTS
				(
					--- Lấy dữ liệu bảng giá với đơn giá gần nhất với đơn giá mặt hàng.
					SELECT TOP 1 1				
					FROM CT0152 CT52 WITH (NOLOCK)
					INNER JOIN CT0153 CT53 WITH (NOLOCK) ON CT53.DivisionID IN ('@@@', @DivisionID)
															AND CT53.ID = CT52.ID
															AND CT53.InventoryTypeID = C21.InventoryGroup
															AND CT53.InventoryID = C21.InventoryID
					INNER JOIN CT0154 CT54 WITH (NOLOCK) ON CT53.DivisionID IN ('@@@', @DivisionID)
															AND CT54.ID = CT52.ID
															AND CT54.InventoryTypeID = C21.InventoryGroup
															AND CT54.APK = CT53.APKValue
					WHERE CT52.DivisionID IN ('@@@', @DivisionID)
								AND CT52.ID = MIN(C21.PriceListID)
								AND ISNULL(CT52.Disabled, 0) = 0
								-- Tồn tại quy định giá tối thiểu.
								AND ISNULL(CT53.MinPrice, 0) <> 0
								AND 
								-- trong khoảng số lượng.
								(
									SUM(C21.OrderQuantity) >= CT54.FromValues
									OR 
									SUM(C21.OrderQuantity) <= CT54.ToValues
								)
								-- nhưng dưới mức giá tối thiểu.
								AND C21.UnitPrice < CT53.MinPrice
					ORDER BY UnitPrice
				)
			END
			
			PRINT ('STEP 03')
			--- TEST
			--- Lấy danh sách chi tiết tìm thấy
			SELECT '#DELETE_OT02' AS DELETE_OT02
						, * 
			FROM #DELETE_OT02
			
			--- Xóa các chi tiết bán hàng không đáp ứng quy định.
			IF EXISTS (SELECT TOP 1 1 #DELETE_OT02)
			BEGIN
				DELETE CT21
				FROM #CMP00121 CT21
				INNER JOIN #DELETE_OT02 OT02 ON OT02.SOrderID = CT21.SOrderID 
													AND OT02.InventoryID = CT21.InventoryID
					
				DELETE #DELETE_OT02
			END
		END

		--- TEST
		--- Lấy danh sách chi tiết kết quả:
		SELECT '#CMP00121' AS #CMP00121
					, * 
		FROM #CMP00121

		-- Xử lý dữ liệu với phương pháp: huê hồng theo nhóm hàng.
		IF ISNULL(@CommissionType, 0) = 0
		BEGIN
			
			IF (@IsRate = 1) -- Tỷ lệ
				SET @PriceUnit = 0.01;
			ELSE			 -- Giá trị
				SET @PriceUnit = 1;
			
			INSERT INTO #CMP00121Group
			(
				APK
				, DivisionID
				, SalesManID		
				, SOrderID		
				, PriceListID		
				, InventoryGroup	
				, OrderQuantity	
				, ConvertedAmount
				, CommissionAmount
			)
			SELECT 
				NEWID()
				, DivisionID
				, SalesManID
				, C21.SOrderID
				, PriceListID		
				, C21.InventoryGroup AS InventoryGroup
				, SUM(OrderQuantity) AS OrderQuantity
				, SUM(ConvertedAmount) AS ConvertedAmount
				, CASE WHEN ISNULL(MIN(A.RefType), 0) = 0 
							-- Số lượng
						THEN SUM(ISNULL(C21.OrderQuantity, 0)) * ISNULL(MIN(A.RateValue), 0) * @PriceUnit
							-- Giá trị
						ELSE SUM(ISNULL(C21.ConvertedAmount, 0)) * ISNULL(MIN(A.RateValue), 0) * @PriceUnit
					END CommissionAmount
			FROM #CMP00121 C21
			CROSS APPLY 
			(
				SELECT TOP 1 RefType
					, RateValue
				FROM CMT0008 C08 WITH (NOLOCK)
				INNER JOIN CMT0007 C07 WITH (NOLOCK) ON C07.DivisionID = C08.DivisionID 
											AND C07.CommissionMethodID = C08.CommissionMethodID
				WHERE
					C08.DivisionID = C21.DivisionID
					AND C08.InventoryTypeID = C21.InventoryGroup
					AND C07.CommissionMethodID = @CommissionMethodID
			) A
			GROUP BY
				C21.DivisionID
				, C21.SalesManID
				, C21.SOrderID
				, C21.PriceListID
				, C21.InventoryGroup

			-- TEST
			PRINT ('STEP 04')
			select * From #CMP00121Group

			-- Insert dữ liệu kết quả.
			BEGIN 
				INSERT CMT0012
				(
					APK
					, DivisionID
					, CommissionMethodID
					, VoucherID
					, VoucherNo
					, TranYear
					, TranMonth
					, ObjectID
					, ComAmount
					, Notes
					, CreateUserID
					, CreateDate
				)
				SELECT
					NEWID()
					, C21.DivisionID
					, @CommissionMethodID
					, C21.SOrderID
					, OT01.VoucherNo
					, @TranYear
					, @TranMonth
					, OT01.ObjectID
					, C21.CommissionAmount
					, @Notes
					, @UserID
					, GETDATE()
				FROM #CMP00121Group C21
				LEFT JOIN OT2001 OT01 WITH (NOLOCK) ON OT01.DivisionID = C21.DivisionID
														AND OT01.TranYear = @TranYear
														AND OT01.TranMonth = @TranMonth
														AND OT01.SOrderID = C21.SOrderID

				INSERT CMT0013
				(
					APK
					, DivisionID
					, CommissionMethodID
					, VoucherNo
					, TranYear
					, TranMonth
					, ObjectID
					, InventoryID
					, ConvertedAmount
					, ComAmount
					, Notes
					, CreateUserID
					, CreateDate
					, SaleManID
				)
				SELECT
					NEWID()
					, C21.DivisionID
					, @CommissionMethodID
					, OT01.VoucherNo
					, @TranYear
					, @TranMonth
					, OT01.ObjectID
					, C21.InventoryGroup
					, C21.ConvertedAmount
					, C21.CommissionAmount
					, @Notes
					, @UserID
					, GETDATE()
					, OT01.SalesManID
				FROM #CMP00121Group C21
				LEFT JOIN OT2001 OT01 WITH (NOLOCK) ON OT01.DivisionID = C21.DivisionID
														AND OT01.TranYear = @TranYear
														AND OT01.TranMonth = @TranMonth
														AND OT01.SOrderID = C21.SOrderID
			END
		END
	END
ELSE
	-- Khách hàng Vĩnh Nam Anh
IF (@CustomerIndex = 147)
	BEGIN
		SET @APK = NULL
		SET @SalesManID = NULL
		SET @SOrderID = NULL
		SET @PriceListID = NULL
		SET @InventoryID = NULL
		SET @ObjectID = NULL
		SET @OrderQuantity = NULL
		SET @ConvertedAmount = NULL

		PRINT ('STEP 02')

		IF ISNULL(@CommissionType, 0) = 0
		BEGIN
			--- Lấy dữ liệu đơn hàng bán.
				SET @sSQL0 = '
					INSERT INTO #CMP00121
					(
						DivisionID
						, SalesManID
						, SOrderID
						, VoucherID
						, PriceListID
						, InventoryID
						, ObjectID
						, OrderQuantity
						, UnitPrice
						, ConvertedAmount
						, APK
						, InventoryGroup
					)
					SELECT	  OT01.DivisionID
							, OT01.SalesManID
							, OT01.SOrderID
							, null as VoucherID
							, OT01.PriceListID
							, OT02.InventoryID
							, OT01.ObjectID
							, ISNULL(AT90.Quantity, 0) AS OrderQuantity
							, ISNULL(AT90.UnitPrice, 0) AS SalePrice
							, ISNULL(AT90.ConvertedAmount, 0) AS ConvertedAmount
							, OT02.APK
							, ' + @InventoryGroupAnaTypeID + 'ID AS InventoryGroup					
					FROM OT2002 OT02 WITH (NOLOCK)
					INNER JOIN OT2001 OT01 WITH (NOLOCK) ON OT01.DivisionID = OT02.DivisionID 
							AND OT01.SOrderID = OT02.SOrderID
					LEFT JOIN AT1302 AT02 WITH (NOLOCK) ON AT02.DivisionID IN (''@@@'', OT01.DivisionID)
							AND AT02.InventoryID = OT02.InventoryID
					WHERE OT01.DivisionID = '''  + @DivisionID + '''
						AND OT01.TranYear = ' + STR(@TranYear) + '
						AND OT01.TranMonth = ' +STR(@TranMonth) + '
						AND ISNULL(OT01.OrderStatus, 0) = 1
					ORDER BY VoucherNo
				'

				PRINT (@sSQL0)
				EXEC (@sSQL0)

				--- TEST
				--- Lấy danh sách chi tiết tìm thấy
				SELECT '#CMP00121 Gather' AS #CMP00121
							, * 
				FROM #CMP00121
		END
		ELSE IF ISNULL(@CommissionType, 0) = 1
		BEGIN
				SET @sSQL0 = '
					INSERT INTO #CMP00121
					(
						DivisionID
						, SalesManID
						, SOrderID
						, VoucherID
						, PriceListID
						, InventoryID
						, ObjectID
						, OrderQuantity
						, UnitPrice
						, ConvertedAmount
						, APK
						, InventoryGroup
					)
				SELECT	OT01.DivisionID
					, AT90.Ana04ID as SalesManID
					, OT01.SOrderID
					, AT90.VoucherID
					, OT01.PriceListID
					, AT90.InventoryID
					, OT01.ObjectID
					, ISNULL(AT90.Quantity, 0) AS OrderQuantity
					, ISNULL(AT90.UnitPrice, 0) AS SalePrice
					, ISNULL(AT90.ConvertedAmount, 0) AS ConvertedAmount
					, AT90.APK
					, ' + @InventoryGroupAnaTypeID + 'ID AS InventoryGroup		
				FROM AT9000 AT90 WITH (NOLOCK)
				INNER JOIN OT2001 OT01 WITH (NOLOCK) ON OT01.DivisionID = AT90.DivisionID 
						AND OT01.SOrderID = AT90.OrderID
				LEFT JOIN AT1302 AT02 WITH (NOLOCK) ON AT02.DivisionID IN (''@@@'', OT01.DivisionID)
						AND AT02.InventoryID = AT90.InventoryID
				WHERE AT90.DivisionID = '''  + @DivisionID + '''
				AND AT90.TranYear = ' + STR(@TranYear) + '
				AND AT90.TranMonth = ' +STR(@TranMonth) + '
				AND ISNULL(OT01.OrderStatus, 0) = 1
				AND AT90.TransactionTypeID IN (''T04'',''T14'')
				ORDER BY AT90.VoucherNo
				'
				
				PRINT (@sSQL0)
				EXEC (@sSQL0)

				--- TEST
				--- Lấy danh sách chi tiết tìm thấy
				SELECT '#CMP00121 Gather' AS #CMP00121
							, * 
				FROM #CMP00121
		END

		--- TEST
		--- Lấy danh sách chi tiết kết quả:
		SELECT '#CMP00121' AS #CMP00121
					, * 
		FROM #CMP00121

		-- Xử lý dữ liệu với phương pháp: huê hồng theo nhóm hàng.
		IF ISNULL(@CommissionType, 0) = 0
		BEGIN
			
			IF (@IsRate = 1) -- Tỷ lệ
				SET @PriceUnit = 0.01;
			ELSE			 -- Giá trị
				SET @PriceUnit = 1;
			
			INSERT INTO #CMP00121Group
			(
				APK
				, DivisionID
				, SalesManID		
				, SOrderID		
				, PriceListID		
				, InventoryGroup	
				, OrderQuantity	
				, ConvertedAmount
				, CommissionAmount
			)
			SELECT 
				NEWID()
				, DivisionID
				, SalesManID
				, C21.SOrderID
				, PriceListID		
				, C21.InventoryGroup AS InventoryGroup
				, SUM(OrderQuantity) AS OrderQuantity
				, SUM(ConvertedAmount) AS ConvertedAmount
				, CASE WHEN ISNULL(MIN(A.RefType), 0) = 0 
							-- Số lượng
						THEN SUM(ISNULL(C21.OrderQuantity, 0)) * ISNULL(MIN(A.RateValue), 0) * @PriceUnit
							-- Giá trị
						ELSE SUM(ISNULL(C21.ConvertedAmount, 0)) * ISNULL(MIN(A.RateValue), 0) * @PriceUnit
					END CommissionAmount
			FROM #CMP00121 C21
			CROSS APPLY 
			(
				SELECT TOP 1 RefType
					, RateValue
				FROM CMT0008 C08 WITH (NOLOCK)
				INNER JOIN CMT0007 C07 WITH (NOLOCK) ON C07.DivisionID = C08.DivisionID 
											AND C07.CommissionMethodID = C08.CommissionMethodID
				WHERE
					C08.DivisionID = C21.DivisionID
					AND C08.InventoryTypeID = C21.InventoryGroup
					AND C07.CommissionMethodID = @CommissionMethodID
			) A
			GROUP BY
				C21.DivisionID
				, C21.SalesManID
				, C21.SOrderID
				, C21.PriceListID
				, C21.InventoryGroup

			-- TEST
			PRINT ('STEP 04')
			select * From #CMP00121Group

			-- Insert dữ liệu kết quả.
			BEGIN 
				INSERT CMT0012
				(
					APK
					, DivisionID
					, CommissionMethodID
					, VoucherID
					, VoucherNo
					, TranYear
					, TranMonth
					, ObjectID
					, ComAmount
					, Notes
					, CreateUserID
					, CreateDate
				)
				SELECT
					NEWID()
					, C21.DivisionID
					, @CommissionMethodID
					, C21.SOrderID
					, OT01.VoucherNo
					, @TranYear
					, @TranMonth
					, OT01.ObjectID
					, C21.CommissionAmount
					, @Notes
					, @UserID
					, GETDATE()
				FROM #CMP00121Group C21
				LEFT JOIN OT2001 OT01 WITH (NOLOCK) ON OT01.DivisionID = C21.DivisionID
														AND OT01.TranYear = @TranYear
														AND OT01.TranMonth = @TranMonth
														AND OT01.SOrderID = C21.SOrderID

				INSERT CMT0013
				(
					APK
					, DivisionID
					, CommissionMethodID
					, VoucherNo
					, TranYear
					, TranMonth
					, ObjectID
					, InventoryID
					, ConvertedAmount
					, ComAmount
					, Notes
					, CreateUserID
					, CreateDate
					, SaleManID
				)
				SELECT
					NEWID()
					, C21.DivisionID
					, @CommissionMethodID
					, OT01.VoucherNo
					, @TranYear
					, @TranMonth
					, OT01.ObjectID
					, C21.InventoryGroup
					, C21.ConvertedAmount
					, C21.CommissionAmount
					, @Notes
					, @UserID
					, GETDATE()
					, OT01.SalesManID
				FROM #CMP00121Group C21
				LEFT JOIN OT2001 OT01 WITH (NOLOCK) ON OT01.DivisionID = C21.DivisionID
														AND OT01.TranYear = @TranYear
														AND OT01.TranMonth = @TranMonth
														AND OT01.SOrderID = C21.SOrderID
			END
		END
		ELSE IF ISNULL(@CommissionType, 0) = 1
		BEGIN

			IF (@IsRate = 1) -- Tỷ lệ
				SET @PriceUnit = 0.01;
			ELSE			 -- Giá trị
				SET @PriceUnit = 1;

			CREATE TABLE #CMP0012102Ignore
			(
				SOrderID VARCHAR(50)
			)

			SELECT M.SOrderID,SUM(AT90.ConvertedAmount) - ISNULL(T.ConvertedAmount, 0) as ConvertedAmount
			INTO #CMP0012102
			FROM AT9000 AT90 WITH (NOLOCK)
			INNER JOIN (SELECT M.SOrderID,M.VoucherID FROM #CMP00121 M WITH (NOLOCK) GROUP BY  M.SOrderID,M.VoucherID) M ON AT90.TVoucherID = M.VoucherID
			LEFT JOIN ( 
						SELECT ReVoucherID,SUM(ConvertedAmount) as ConvertedAmount 
						FROM AT9000 WITH (NOLOCK)
						WHERE TransactionTypeID ='T24' 
						GROUP BY ReVoucherID
			) T ON T.ReVoucherID = M.SOrderID
			WHERE AT90.DivisionID = @DivisionID AND AT90.TransactionTypeID IN ('T01','T21') 
			GROUP BY M.SOrderID, T.ConvertedAmount 
			ORDER BY M.SOrderID

			select * from #CMP0012102

			WHILE EXISTS (SELECT TOP 1 1 FROM #CMP0012102 T1 LEFT JOIN #CMP0012102Ignore T2 ON T1.SOrderID = T2.SOrderID WHERE T2.SOrderID IS NULL)
			BEGIN
			    SET @SOrderID  = null
				SET @ConvertedAmount = null
				SET @CommissionAmount = 0

				SELECT TOP 1 @SOrderID = T1.SOrderID ,@ConvertedAmount = T1.ConvertedAmount
				FROM #CMP0012102 T1
				LEFT JOIN #CMP0012102Ignore T2 ON T1.SOrderID = T2.SOrderID
				WHERE T2.SOrderID IS NULL


				-- Tính huê hồng nhân viên sale
				SET @CurTemp  = CURSOR SCROLL KEYSET FOR
				SELECT M.SOrderID, D.InventoryID, D.OrderQuantity, D.ConvertedAmount,CT08.RateValue,CT08.RefType, CT07.IsRate, CT07.OptionType
				FROM OT2001 M WITH (NOLOCK)
				LEFT JOIN OT2002 D WITH (NOLOCK) ON M.DivisionID = D.DivisionID AND M.SOrderID = D.SOrderID
				LEFT JOIN CMT0007 CT07 WITH (NOLOCK) ON CT07.DivisionID = D.DivisionID AND CT07.CommissionMethodID = @CommissionMethodID
				LEFT JOIN CMT0008 CT08 WITH (NOLOCK) ON CT08.DivisionID = D.DivisionID AND D.InventoryID = CT08.InventoryID AND CT08.CommissionMethodID = @CommissionMethodID
				WHERE M.SOrderID = @SOrderID 
				ORDER BY M.SOrderID, D.Orders

				OPEN @CurTemp
				FETCH NEXT FROM @CurTemp INTO  @SOrderResult ,@InventoryIDResult ,@OrderQuantityResult ,@ConvertedAmountResult ,@RateValueResult,@RefTypeResult ,@IsRateResult,@CommissionTypeResult 
				WHILE @@Fetch_Status = 0 AND @ConvertedAmount > 0
				BEGIN

				SET @ConvertedAmountResult = (CASE WHEN @ConvertedAmount < @ConvertedAmountResult THEN @ConvertedAmount ELSE @ConvertedAmountResult END)
				IF(ISNULL(MIN(@RefTypeResult), 0) = 0)
				BEGIN 
					 SET @CommissionAmount = @OrderQuantityResult * ISNULL(MIN(@RateValueResult), 0) * @PriceUnit
				END
				ELSE
				BEGIN
					SET @CommissionAmount = @ConvertedAmountResult * ISNULL(MIN(@RateValueResult), 0) * @PriceUnit
				END

				

				PRINT ('A')
				
				-- Insert #CMP00121Group
				INSERT INTO #CMP00121Group
				(
					APK
					, DivisionID
					, SalesManID		
					, SOrderID		
					, PriceListID
					, InventoryGroup	
					, OrderQuantity	
					, ConvertedAmount
					, CommissionAmount
				)
				SELECT 
					NEWID()
					, DivisionID
					, SalesManID
					, C21.SOrderID
					, PriceListID
					, C21.InventoryID
					, SUM(OrderQuantity) AS OrderQuantity
					, SUM(ConvertedAmount) AS ConvertedAmount
					, @CommissionAmount as CommissionAmount
				FROM #CMP00121 C21
				WHERE C21.SOrderID = @SOrderID AND C21.InventoryID = @InventoryIDResult
				GROUP BY
					C21.DivisionID
					, C21.SalesManID
					, C21.SOrderID
					, C21.PriceListID
					, C21.InventoryID

					
				PRINT ('B')

				SET @ConvertedAmount = @ConvertedAmount - @ConvertedAmountResult

				FETCH NEXT FROM @curTemp INTO @SOrderResult ,@InventoryIDResult ,@OrderQuantityResult ,@ConvertedAmountResult ,@RateValueResult,@RefTypeResult ,@IsRateResult,@CommissionTypeResult 
				END            
				CLOSE @curTemp
				DEALLOCATE @curTemp

				INSERT INTO #CMP0012102Ignore(SOrderID)
				SELECT @SOrderID

			END
			
			PRINT ('STEP 04')
			select * From #CMP00121Group

			-- Insert dữ liệu kết quả.
			BEGIN 
				INSERT CMT0012
				(
					APK
					, DivisionID
					, CommissionMethodID
					, VoucherID
					, VoucherNo
					, TranYear
					, TranMonth
					, ObjectID
					, ComAmount
					, Notes
					, CreateUserID
					, CreateDate
				)
				SELECT
					NEWID()
					, C21.DivisionID
					, @CommissionMethodID
					, C21.SOrderID
					, OT01.VoucherNo
					, @TranYear
					, @TranMonth
					, OT01.ObjectID
					, C21.CommissionAmount
					, @Notes
					, @UserID
					, GETDATE()
				FROM #CMP00121Group C21
				INNER JOIN OT2001 OT01 WITH (NOLOCK) ON OT01.DivisionID = C21.DivisionID
														AND OT01.TranYear = @TranYear
														AND OT01.TranMonth = @TranMonth
														AND OT01.SOrderID = C21.SOrderID

				INSERT CMT0013
				(
					APK
					, DivisionID
					, CommissionMethodID
					, VoucherNo
					, TranYear
					, TranMonth
					, ObjectID
					, InventoryID
					, ConvertedAmount
					, ComAmount
					, Notes
					, CreateUserID
					, CreateDate
					, SaleManID
				)
				SELECT
					NEWID()
					, C21.DivisionID
					, @CommissionMethodID
					, OT01.VoucherNo
					, @TranYear
					, @TranMonth
					, OT01.ObjectID
					, ISNULL(C21.InventoryGroup,'')
					, C21.ConvertedAmount
					, C21.CommissionAmount
					, @Notes
					, @UserID
					, GETDATE()
					, C21.SalesManID
				FROM #CMP00121Group C21
				INNER JOIN OT2001 OT01 WITH (NOLOCK) ON OT01.DivisionID = C21.DivisionID
														AND OT01.TranYear = @TranYear
														AND OT01.TranMonth = @TranMonth
														AND OT01.SOrderID = C21.SOrderID
			END
		END
	END
ELSE
	-- Khách hàng EXEDY // Tính huê hồng nhân viên từ Hóa đơn bán hàng AT9000
IF (@CustomerIndex = 151)
	BEGIN
		--- tính phí bản quyền nếu Royalty = 1
		IF(@Royalty = '1')
			BEGIN
			IF ISNULL(@CommissionType, 0) = 1 -- 0: Nhóm hàng, 1: Mặt hàng
				BEGIN
				--- Lấy danh sách hóa đơn bán hàng
						SET @sSQL0 = '
							INSERT INTO #CMP00121
							(
								DivisionID
								, SalesManID
								, SOrderID
								, VoucherID
								, PriceListID
								, InventoryID
								, ObjectID
								, OrderQuantity
								, UnitPrice
								, ConvertedAmount
								, APK
								, InventoryGroup
								, RMRate
								, Packing
								, Transport
								, Insuarance
								, NetInvoice
								, RoyaltyPercent
								, RoyaltyRate
								, ExchangeRate
								, IsEXD
								, IsEXDExchangeRate
								, IsEXT
								, IsEFM
								, IsOther
								, UnitID
							)
						SELECT	OT01.DivisionID
							, OT01.Ana01ID as SalesManID
							, OT01.SOrderID
							, AT90.VoucherID
							, OT01.PriceListID
							, AT90.InventoryID
							, OT01.ObjectID
							, AT90.ConvertedQuantity as OrderQuantity
							, AT90.UnitPrice as SalePrice
							, AT90.ConvertedAmount
							, AT90.APK
							, '''' AS InventoryGroup
							, OT03.RMRate
							, OT03.Packing
							, OT03.Transport
							, OT03.Insuarance
							, OT03.NetInvoice
							, OT03.RoyaltyPercent
							, OT03.RoyaltyRate
							, OT03.ExchangeRate
							, OT03.IsEXD
							, OT03.IsEXDExchangeRate
							, OT03.IsEXT
							, OT03.IsEFM
							, OT03.IsOther	
							, AT90.UnitID	
						FROM AT9000 AT90 WITH (NOLOCK)
						LEFT JOIN OT2001 OT01 WITH (NOLOCK) ON OT01.DivisionID = AT90.DivisionID 
								AND OT01.SOrderID = AT90.OrderID
						LEFT JOIN OT1302 OT03 WITH (NOLOCK) ON OT03.DivisionID = AT90.DivisionID 
								AND OT03.InventoryID = AT90.InventoryID
								AND OT03.ID = AT90.PriceListID
								AND (OT03.IsEXD =''1'' OR OT03.IsEXDExchangeRate = ''1'' OR OT03.IsEXT = ''1'' OR OT03.IsEFM = ''1'' OR OT03.IsOther = ''1'')
						LEFT JOIN AT1302 AT02 WITH (NOLOCK) ON AT02.DivisionID IN (''@@@'', OT01.DivisionID)
								AND AT02.InventoryID = AT90.InventoryID
						WHERE AT90.DivisionID = '''  + @DivisionID + '''
						AND AT90.TranYear = ' + STR(@TranYear) + '
						AND AT90.TranMonth = ' +STR(@TranMonth) + '
						AND ISNULL(OT01.OrderStatus, 0) = 1
						AND AT90.TransactionTypeID IN (''T04'',''T14'')
						ORDER BY AT90.VoucherNo
						'

						PRINT (@sSQL0)
						EXEC (@sSQL0)

						--- TEST
						--- Lấy danh sách chi tiết tìm thấy
						SELECT '#CMP00121 Gather' AS #CMP00121, * 
						FROM #CMP00121
				IF (@IsRate = 1) -- Tỷ lệ
					SET @PriceUnit = 0.01;
				ELSE			 -- Giá trị
					SET @PriceUnit = 1;

				CREATE TABLE #CMP0012102Ignore_EXV2
				(
					SOrderID VARCHAR(50)
				)


				--- Lấy tổng tiền từ hóa đơn bán hàng trừ cho hóa đơn hàng trả lại => Tổng tiền
				SELECT AT90.SOrderID,SUM(AT90.ConvertedAmount) - ISNULL(T.ConvertedAmount,0) as ConvertedAmount
				INTO #CMP0012102_EXV2
				FROM #CMP00121 AT90 WITH (NOLOCK)		
				LEFT JOIN ( 
							SELECT ReVoucherID,SUM(ConvertedAmount) as ConvertedAmount 
							FROM AT9000 WITH (NOLOCK)
							WHERE TransactionTypeID ='T24' -- AT1008 TransactionTypeID = T24 là loại hàng bán trả lại.
							GROUP BY ReVoucherID
				) T ON T.ReVoucherID = AT90.SOrderID
				WHERE AT90.DivisionID = @DivisionID
				GROUP BY AT90.SOrderID , T.ConvertedAmount
				ORDER BY AT90.SOrderID

				SELECT * FROM #CMP0012102_EXV2 -- đã tính được Tổng doanh số từ Hóa đơn bán hàng và Hóa đơn trả lại

				WHILE EXISTS (SELECT TOP 1 1 FROM #CMP0012102_EXV2 T1 LEFT JOIN #CMP0012102Ignore_EXV2 T2 ON T1.SOrderID = T2.SOrderID WHERE T2.SOrderID IS NULL)
				BEGIN
					SET @SOrderID  = null
					SET @ConvertedAmount = null
					SET @CommissionAmount = 0

					SELECT TOP 1 @SOrderID = T1.SOrderID ,@ConvertedAmount = T1.ConvertedAmount
					FROM #CMP0012102_EXV2 T1
					LEFT JOIN #CMP0012102Ignore_EXV2 T2 ON T1.SOrderID = T2.SOrderID
					WHERE T2.SOrderID IS NULL

					SELECT M.SOrderID, M.InventoryID, M.OrderQuantity, M.ConvertedAmount, ISNULL(M.RMRate,0), ISNULL(M.Packing,0), ISNULL(M.Transport,0), ISNULL(M.Insuarance,0), ISNULL(M.NetInvoice,1), ISNULL(M.RoyaltyPercent,0)
						, ISNULL(M.RoyaltyRate,0), ISNULL(M.ExchangeRate,0),
						  ISNULL(M.IsEXD,0), ISNULL(M.IsEFM,0), ISNULL(M.IsEXDExchangeRate,0), ISNULL(M.IsEXT,0), ISNULL(M.IsOther,0)
					FROM #CMP00121 M WITH (NOLOCK)
					--LEFT JOIN OT2002 D WITH (NOLOCK) ON M.DivisionID = D.DivisionID AND M.SOrderID = D.SOrderID
					WHERE M.SOrderID = @SOrderID  AND ( M.IsEXD = '1' OR  M.IsEFM = '1' OR M.IsEXDExchangeRate ='1' OR M.IsEXT= '1'OR M.IsOther='1')															
					ORDER BY M.SOrderID		

					-- Tính phí bảng quyển từng cty mẹ
					SET @CurTemp  = CURSOR SCROLL KEYSET FOR							
					SELECT M.SOrderID, M.InventoryID, M.OrderQuantity, M.ConvertedAmount,  ISNULL(M.RMRate,0),  ISNULL(M.Packing,0),  ISNULL(M.Transport,0),  ISNULL(M.Insuarance,0),  ISNULL(M.NetInvoice,1),  ISNULL(M.RoyaltyPercent,0),  ISNULL(M.RoyaltyRate,0),  ISNULL(M.ExchangeRate,0),
		
						   M.IsEXD, M.IsEFM, M.IsEXDExchangeRate, M.IsEXT, M.IsOther
					FROM #CMP00121 M WITH (NOLOCK)
					--LEFT JOIN OT2002 D WITH (NOLOCK) ON M.DivisionID = D.DivisionID AND M.SOrderID = D.SOrderID
					WHERE M.SOrderID = @SOrderID  AND ( M.IsEXD = '1' OR  M.IsEFM = '1' OR M.IsEXDExchangeRate ='1' OR M.IsEXT= '1'OR M.IsOther='1')															
					ORDER BY M.SOrderID																			
						
					OPEN @CurTemp																				
					FETCH NEXT FROM @CurTemp INTO @SOrderResult, @InventoryIDResult, @OrderQuantityResult, @ConvertedAmountResult, @RMRate, @Packing, @Transport,@Insuarance, @NetInvoice, @RoyaltyPercent, @RoyaltyRate,@ExchangeRate,@IsEXD, @IsEFM, @IsEXDExchangeRate, @IsEXT, @IsOther
					WHILE @@Fetch_Status = 0 --AND @ConvertedAmount > 0											
					BEGIN																						

					PRINT @SOrderResult
					PRINT @InventoryIDResult
					PRINT @ConvertedAmountResult
					PRINT @ConvertedAmount

					--- XÉT ĐIỀU KIỆN CTY MẸ LÀ EXD
					IF(ISNULL(@IsEXD,0) = 1) 
						BEGIN
							SET @ConvertedAmountResult = (CASE WHEN @ConvertedAmount < @ConvertedAmountResult THEN @ConvertedAmount ELSE @ConvertedAmountResult END)
							SET	@CommissionAmount = (@ConvertedAmountResult - (@RMRate + @Packing + @Transport + @Insuarance)) * (@RoyaltyPercent/100)
							-- Insert #CMP00121Group
							INSERT INTO #CMP00121Group
							(
								APK
								, DivisionID
								, SalesManID		
								, SOrderID		
								, PriceListID
								, InventoryGroup	
								, OrderQuantity	
								, ConvertedAmount
								, CommissionAmount
								, UnitID
							)
							SELECT 
								NEWID()
								, DivisionID
								, 'EXD'
								, C21.SOrderID
								, PriceListID
								, C21.InventoryID
								, SUM(OrderQuantity) AS OrderQuantity
								, SUM(ConvertedAmount) AS ConvertedAmount
								, @CommissionAmount AS CommissionAmount
								, C21.UnitID
							FROM #CMP00121 C21
							WHERE C21.SOrderID = @SOrderID AND C21.InventoryID = @InventoryIDResult
							GROUP BY
								C21.DivisionID
								, C21.SalesManID
								, C21.SOrderID
								, C21.PriceListID
								, C21.InventoryID
								, C21.UnitID

							SET @ConvertedAmount = @ConvertedAmount - @ConvertedAmountResult

						
					END            
					
					--- XÉT ĐIỀU KIỆN CTY MẸ LÀ EFM
					ELSE IF(ISNULL(@IsEFM,0) = 1) 
						BEGIN
							SET @ConvertedAmountResult = (CASE WHEN @ConvertedAmount < @ConvertedAmountResult THEN @ConvertedAmount ELSE @ConvertedAmountResult END)
							SET	@CommissionAmount = (@ConvertedAmountResult * @NetInvoice) * (@RoyaltyPercent/100)
							-- Insert #CMP00121Group
							INSERT INTO #CMP00121Group
							(
								APK
								, DivisionID
								, SalesManID		
								, SOrderID		
								, PriceListID
								, InventoryGroup	
								, OrderQuantity	
								, ConvertedAmount
								, CommissionAmount
								, UnitID
							)
							SELECT 
								NEWID()
								, DivisionID
								, 'EFM'
								, C21.SOrderID
								, PriceListID
								, C21.InventoryID
								, SUM(OrderQuantity) AS OrderQuantity
								, SUM(ConvertedAmount) AS ConvertedAmount
								, @CommissionAmount AS CommissionAmount
								, C21.UnitID
							FROM #CMP00121 C21
							WHERE C21.SOrderID = @SOrderID AND C21.InventoryID = @InventoryIDResult
							GROUP BY
								C21.DivisionID
								, C21.SalesManID
								, C21.SOrderID
								, C21.PriceListID
								, C21.InventoryID
								, C21.UnitID

							SET @ConvertedAmount = @ConvertedAmount - @ConvertedAmountResult

						
						END       

					--- XÉT ĐIỀU KIỆN CTY MẸ LÀ EXDExchangeRate
					ELSE IF(ISNULL(@IsEXDExchangeRate,0) = 1) 
						BEGIN
							SET @ConvertedAmountResult = (CASE WHEN @ConvertedAmount < @ConvertedAmountResult THEN @ConvertedAmount ELSE @ConvertedAmountResult END)
							SET	@CommissionAmount = (@OrderQuantityResult * @NetInvoice) *(@RoyaltyPercent/100)
							-- Insert #CMP00121Group
							INSERT INTO #CMP00121Group
							(
								APK
								, DivisionID
								, SalesManID		
								, SOrderID		
								, PriceListID
								, InventoryGroup	
								, OrderQuantity	
								, ConvertedAmount
								, CommissionAmount
								, UnitID
							)
							SELECT 
								NEWID()
								, DivisionID
								, 'EXDExchangeRate'
								, C21.SOrderID
								, PriceListID
								, C21.InventoryID
								, SUM(OrderQuantity) AS OrderQuantity
								, SUM(ConvertedAmount) AS ConvertedAmount
								, @CommissionAmount AS CommissionAmount
								, C21.UnitID
							FROM #CMP00121 C21
							WHERE C21.SOrderID = @SOrderID AND C21.InventoryID = @InventoryIDResult
							GROUP BY
								C21.DivisionID
								, C21.SalesManID
								, C21.SOrderID
								, C21.PriceListID
								, C21.InventoryID
								, C21.UnitID

							SET @ConvertedAmount = @ConvertedAmount - @ConvertedAmountResult
	
						END    

					--- XÉT ĐIỀU KIỆN CTY MẸ LÀ EXT
					--ELSE IF(ISNULL(@IsEXT,0) = 1) 
					--	BEGIN
					--		SET @ConvertedAmountResult = (CASE WHEN @ConvertedAmount < @ConvertedAmountResult THEN @ConvertedAmount ELSE @ConvertedAmountResult END)
					--		SET	@CommissionAmount = @ConvertedAmountResult - (@RMRate + @Packing + @Transport + @Insuarance) * @RoyaltyPercent/100
					--		-- Insert #CMP00121Group
					--		INSERT INTO #CMP00121Group
					--		(
					--			APK
					--			, DivisionID
					--			, SalesManID		
					--			, SOrderID		
					--			, PriceListID
					--			, InventoryGroup	
					--			, OrderQuantity	
					--			, ConvertedAmount
					--			, CommissionAmount
					--		)
					--		SELECT 
					--			NEWID()
					--			, DivisionID
					--			, 'EXT'
					--			, C21.SOrderID
					--			, PriceListID
					--			, C21.InventoryID
					--			, SUM(OrderQuantity) AS OrderQuantity
					--			, SUM(ConvertedAmount) AS ConvertedAmount
					--			, @CommissionAmount AS CommissionAmount
					--		FROM #CMP00121 C21
					--		WHERE C21.SOrderID = @SOrderID AND C21.InventoryID = @InventoryIDResult
					--		GROUP BY
					--			C21.DivisionID
					--			, C21.SalesManID
					--			, C21.SOrderID
					--			, C21.PriceListID
					--			, C21.InventoryID

					--		SET @ConvertedAmount = @ConvertedAmount - @ConvertedAmountResult

							
					--	END   

					--- XÉT ĐIỀU KIỆN CTY MẸ LÀ IsOther
					ELSE IF(ISNULL(@IsOther,0) = 1) 
						BEGIN
							SET @ConvertedAmountResult = (CASE WHEN @ConvertedAmount < @ConvertedAmountResult THEN @ConvertedAmount ELSE @ConvertedAmountResult END)
							SET	@CommissionAmount = (@ConvertedAmountResult - (@RMRate + @Packing + @Transport + @Insuarance)) * (@RoyaltyPercent/100)
							-- Insert #CMP00121Group
							INSERT INTO #CMP00121Group
							(
								APK
								, DivisionID
								, SalesManID		
								, SOrderID		
								, PriceListID
								, InventoryGroup	
								, OrderQuantity	
								, ConvertedAmount
								, CommissionAmount
								, UnitID
							)
							SELECT 
								NEWID()
								, DivisionID
								, 'Other'
								, C21.SOrderID
								, PriceListID
								, C21.InventoryID
								, SUM(OrderQuantity) AS OrderQuantity
								, SUM(ConvertedAmount) AS ConvertedAmount
								, @CommissionAmount AS CommissionAmount
								, C21.UnitID
							FROM #CMP00121 C21
							WHERE C21.SOrderID = @SOrderID AND C21.InventoryID = @InventoryIDResult
							GROUP BY
								C21.DivisionID
								, C21.SalesManID
								, C21.SOrderID
								, C21.PriceListID
								, C21.InventoryID
								, C21.UnitID

							SET @ConvertedAmount = @ConvertedAmount - @ConvertedAmountResult

						END  

					FETCH NEXT FROM @CurTemp INTO @SOrderResult, @InventoryIDResult, @OrderQuantityResult, @ConvertedAmountResult, @RMRate, @Packing, @Transport,@Insuarance, @NetInvoice, @RoyaltyPercent, @RoyaltyRate,@ExchangeRate,@IsEXD, @IsEFM, @IsEXDExchangeRate, @IsEXT, @IsOther
					END
					CLOSE @curTemp
					DEALLOCATE @curTemp

					INSERT INTO #CMP0012102Ignore_EXV2(SOrderID)
					SELECT @SOrderID
					-- select * from #CMP0012102Ignore_EXV2
				END -- End begin While()
			
				PRINT ('STEP 04')
				--SELECT * FROM #CMP00121Group

				-- Insert dữ liệu kết quả.
				BEGIN 

				SELECT C21.DivisionID
						, C21.SOrderID
						, OT01.VoucherNo
						, OT01.ObjectID
						, SUM(C21.CommissionAmount) as CommissionAmount
					INTO #CMP00121GroupMaster2
					FROM #CMP00121Group C21
					INNER JOIN OT2001 OT01 WITH (NOLOCK) ON OT01.DivisionID = C21.DivisionID
											AND OT01.TranYear = @TranYear
											AND OT01.TranMonth = @TranMonth
											AND OT01.SOrderID = C21.SOrderID
					GROUP BY C21.DivisionID
						, C21.SOrderID
						, OT01.VoucherNo
						, OT01.ObjectID


				SELECT * from #CMP00121GroupMaster2
					INSERT CMT0012
					(
						APK
						, DivisionID
						, CommissionMethodID
						, VoucherID
						, VoucherNo
						, TranYear
						, TranMonth
						, ObjectID
						, ComAmount
						, Notes
						, CreateUserID
						, CreateDate
						, IsRoyalty
					)
					SELECT
						NEWID()
						, C21.DivisionID
						, '1'
						, C21.SOrderID
						, C21.VoucherNo
						, @TranYear
						, @TranMonth
						, C21.ObjectID
						, C21.CommissionAmount
						, @Notes
						, @UserID
						, GETDATE()
						, '1'
					FROM #CMP00121GroupMaster2 C21
					--INNER JOIN OT2001 OT01 WITH (NOLOCK) ON OT01.DivisionID = C21.DivisionID
					--										AND OT01.TranYear = @TranYear
					--										AND OT01.TranMonth = @TranMonth
					--										AND OT01.SOrderID = C21.SOrderID

					INSERT CMT0013
					(
						APK
						, DivisionID
						, CommissionMethodID
						, VoucherNo
						, TranYear
						, TranMonth
						, ObjectID
						, InventoryID
						, ConvertedAmount
						, ComAmount
						, Notes
						, CreateUserID
						, CreateDate
						, SaleManID
						, IsRoyalty
						, Quantity
						, UnitID
					)
					SELECT
						NEWID()
						, C21.DivisionID
						, @CommissionMethodID
						, OT01.VoucherNo
						, @TranYear
						, @TranMonth
						, OT01.ObjectID
						, ISNULL(C21.InventoryGroup,'')
						, C21.ConvertedAmount
						, C21.CommissionAmount
						, @Notes
						, @UserID
						, GETDATE()
						, C21.SalesManID
						, '1'
						, C21.OrderQuantity
						, C21.UnitID
					FROM #CMP00121Group C21
					INNER JOIN OT2001 OT01 WITH (NOLOCK) ON OT01.DivisionID = C21.DivisionID
															AND OT01.TranYear = @TranYear
															AND OT01.TranMonth = @TranMonth
															AND OT01.SOrderID = C21.SOrderID
				END
			  END
			END
		ELSE IF(@Royalty = '0')
		--- tính hoa hồng
			BEGIN

				SET @APK = NULL
				SET @SalesManID = NULL
				SET @SOrderID = NULL
				SET @PriceListID = NULL
				SET @InventoryID = NULL
				SET @ObjectID = NULL
				SET @OrderQuantity = NULL
				SET @ConvertedAmount = NULL

				PRINT ('STEP 02')

				IF ISNULL(@CommissionType, 0) = 0 -- 0: Nhóm hàng, 1: Mặt hàng
				BEGIN

				-- Lấy dữ liệu hóa đơn bán hàng.
							SET @sSQL0 = '
							INSERT INTO #CMP00121
							(
								DivisionID
								, SalesManID
								, SOrderID
								, VoucherID
								, PriceListID
								, InventoryID
								, ObjectID
								, OrderQuantity
								, UnitPrice
								, ConvertedAmount
								, APK
								, InventoryGroup
							)
						SELECT	OT01.DivisionID
							, ISNULL(OT01.Ana01ID,''01EXV'') as SalesManID
							, OT01.SOrderID
							, AT90.VoucherID
							, OT01.PriceListID
							, AT90.InventoryID
							, OT01.ObjectID
							, AT90.ConvertedQuantity as OrderQuantity
							, AT90.UnitPrice as SalePrice
							, AT90.ConvertedAmount
							, AT90.APK
							, '''' AS InventoryGroup		
						FROM AT9000 AT90 WITH (NOLOCK)
						INNER JOIN OT2001 OT01 WITH (NOLOCK) ON OT01.DivisionID = AT90.DivisionID 
								AND OT01.SOrderID = AT90.OrderID
						LEFT JOIN AT1302 AT02 WITH (NOLOCK) ON AT02.DivisionID IN (''@@@'', OT01.DivisionID)
								AND AT02.InventoryID = AT90.InventoryID

						WHERE AT90.DivisionID = '''  + @DivisionID + '''
						AND AT90.TranYear = ' + STR(@TranYear) + '
						AND AT90.TranMonth = ' +STR(@TranMonth) + '
						AND ISNULL(OT01.OrderStatus, 0) = 1
						AND AT90.TransactionTypeID IN (''T04'',''T14'')
						ORDER BY AT90.VoucherNo
						'

						PRINT (@sSQL0)
						EXEC (@sSQL0)

						--- TEST
						--- Lấy danh sách chi tiết tìm thấy
						--SELECT '#CMP00121 Gather' AS #CMP00121, * 
						--FROM #CMP00121
				END
				ELSE IF ISNULL(@CommissionType, 0) = 1 -- 0: Nhóm hàng, 1: Mặt hàng
				BEGIN
						SET @sSQL0 = '
							INSERT INTO #CMP00121
							(
								DivisionID
								, SalesManID
								, SOrderID
								, VoucherID
								, PriceListID
								, InventoryID
								, ObjectID
								, OrderQuantity
								, UnitPrice
								, ConvertedAmount
								, APK
								, InventoryGroup
							)
						SELECT	OT01.DivisionID
							, ISNULL(OT01.Ana01ID,''01EXV'') as SalesManID
							, OT01.SOrderID
							, AT90.VoucherID
							, OT01.PriceListID
							, AT90.InventoryID
							, OT01.ObjectID
							, AT90.ConvertedQuantity as OrderQuantity
							, AT90.UnitPrice as SalePrice
							, AT90.ConvertedAmount
							, AT90.APK
							, '''' AS InventoryGroup		
						FROM AT9000 AT90 WITH (NOLOCK)
						INNER JOIN OT2001 OT01 WITH (NOLOCK) ON OT01.DivisionID = AT90.DivisionID 
								AND OT01.SOrderID = AT90.OrderID
						--LEFT JOIN AT1302 AT02 WITH (NOLOCK) ON AT02.DivisionID IN (''@@@'', OT01.DivisionID)
						--		AND AT02.InventoryID = AT90.InventoryID
						INNER JOIN CMT0008 CM09 WITH (NOLOCK) ON CM09.DivisionID IN (''@@@'', OT01.DivisionID)
								AND CM09.InventoryID = AT90.InventoryID
								AND CM09.CommissionMethodID = ''' + @CommissionMethodID + '''
						WHERE AT90.DivisionID = '''  + @DivisionID + '''
						AND AT90.TranYear = ' + STR(@TranYear) + '
						AND AT90.TranMonth = ' +STR(@TranMonth) + '
						AND ISNULL(OT01.OrderStatus, 0) = 1
						AND AT90.TransactionTypeID IN (''T04'',''T14'')
						ORDER BY AT90.VoucherNo
						'

						PRINT (@sSQL0)
						EXEC (@sSQL0)

						--- TEST
						--- Lấy danh sách chi tiết tìm thấy
						SELECT '#CMP00121 Gathers' AS #CMP00121
									, * 
						FROM #CMP00121
				END

				--- TEST
				--- Lấy danh sách chi tiết kết quả:
				--SELECT '#CMP00121' AS #CMP00121
				--			, * 
				--FROM #CMP00121

				-- Xử lý dữ liệu với phương pháp: huê hồng theo nhóm hàng.
				IF ISNULL(@CommissionType, 0) = 0 -- 0: Nhóm hàng, 1: Mặt hàng
				BEGIN
			
					IF (@IsRate = 1) -- Tỷ lệ
						SET @PriceUnit = 0.01;
					ELSE			 -- Giá trị
						SET @PriceUnit = 1;
			
					INSERT INTO #CMP00121Group
					(
						APK
						, DivisionID
						, SalesManID		
						, SOrderID		
						, PriceListID		
						, InventoryGroup	
						, OrderQuantity	
						, ConvertedAmount
						, CommissionAmount
					)
					SELECT 
						NEWID()
						, DivisionID
						, SalesManID
						, C21.SOrderID
						, PriceListID		
						, C21.InventoryGroup AS InventoryGroup
						, SUM(OrderQuantity) AS OrderQuantity
						, SUM(ConvertedAmount) AS ConvertedAmount
						, CASE WHEN ISNULL(MIN(A.RefType), 0) = 0 
									-- Số lượng
								THEN SUM(ISNULL(C21.OrderQuantity, 0)) * ISNULL(MIN(A.RateValue), 0) * @PriceUnit
									-- Giá trị
								ELSE SUM(ISNULL(C21.ConvertedAmount, 0)) * ISNULL(MIN(A.RateValue), 0) * @PriceUnit
							END CommissionAmount
					FROM #CMP00121 C21
					CROSS APPLY 
					(
						SELECT TOP 1 RefType
							, RateValue
						FROM CMT0008 C08 WITH (NOLOCK)
						INNER JOIN CMT0007 C07 WITH (NOLOCK) ON C07.DivisionID = C08.DivisionID 
													AND C07.CommissionMethodID = C08.CommissionMethodID
						WHERE
							C08.DivisionID = C21.DivisionID
							AND C08.InventoryTypeID = C21.InventoryGroup
							AND C07.CommissionMethodID = @CommissionMethodID
					) A
					GROUP BY
						C21.DivisionID
						, C21.SalesManID
						, C21.SOrderID
						, C21.PriceListID
						, C21.InventoryGroup

					-- TEST
					PRINT ('STEP 04')
					select * From #CMP00121Group

					-- Insert dữ liệu kết quả.
					BEGIN 
						INSERT CMT0012
						(
							APK
							, DivisionID
							, CommissionMethodID
							, VoucherID
							, VoucherNo
							, TranYear
							, TranMonth
							, ObjectID
							, ComAmount
							, Notes
							, CreateUserID
							, CreateDate
							, IsRoyalty
						)
						SELECT
							NEWID()
							, C21.DivisionID
							, @CommissionMethodID
							, C21.SOrderID
							, OT01.VoucherNo
							, @TranYear
							, @TranMonth
							, OT01.ObjectID
							, C21.CommissionAmount
							, @Notes
							, @UserID
							, GETDATE()
							, '0'
						FROM #CMP00121Group C21
						LEFT JOIN OT2001 OT01 WITH (NOLOCK) ON OT01.DivisionID = C21.DivisionID
																AND OT01.TranYear = @TranYear
																AND OT01.TranMonth = @TranMonth
																AND OT01.SOrderID = C21.SOrderID

						INSERT CMT0013
						(
							APK
							, DivisionID
							, CommissionMethodID
							, VoucherNo
							, TranYear
							, TranMonth
							, ObjectID
							, InventoryID
							, ConvertedAmount
							, ComAmount
							, Notes
							, CreateUserID
							, CreateDate
							, SaleManID
							, IsRoyalty
							, Quantity
						)
						SELECT
							NEWID()
							, C21.DivisionID
							, @CommissionMethodID
							, OT01.VoucherNo
							, @TranYear
							, @TranMonth
							, OT01.ObjectID
							, C21.InventoryGroup
							, C21.ConvertedAmount
							, C21.CommissionAmount
							, @Notes
							, @UserID
							, GETDATE()
							, OT01.SalesManID
							, '0'
							, C21.OrderQuantity
						FROM #CMP00121Group C21
						LEFT JOIN OT2001 OT01 WITH (NOLOCK) ON OT01.DivisionID = C21.DivisionID
																AND OT01.TranYear = @TranYear
																AND OT01.TranMonth = @TranMonth
																AND OT01.SOrderID = C21.SOrderID
					END
				END
				ELSE IF ISNULL(@CommissionType, 0) = 1 -- 0: Nhóm hàng, 1: Mặt hàng
			BEGIN

				IF (@IsRate = 1) -- Tỷ lệ
					SET @PriceUnit = 0.01;
				ELSE			 -- Giá trị
					SET @PriceUnit = 1;

				CREATE TABLE #CMP0012102Ignore_EXV
				(
					SOrderID VARCHAR(50)
				)


				--- Lấy tổng tiền từ hóa đơn bán hàng trừ cho hóa đơn hàng trả lại => Tổng tiền
				SELECT M.SOrderID,SUM(AT90.ConvertedAmount) - ISNULL(T.ConvertedAmount,0) as ConvertedAmount
				INTO #CMP0012102_EXV
				FROM AT9000 AT90 WITH (NOLOCK)	
				INNER JOIN (SELECT M.SOrderID,M.VoucherID FROM #CMP00121 M WITH (NOLOCK) GROUP BY  M.SOrderID, M.VoucherID) M ON AT90.VoucherID = M.VoucherID	
				LEFT JOIN ( 
							SELECT ReVoucherID,SUM(ConvertedAmount) as ConvertedAmount 
							FROM AT9000 WITH (NOLOCK)
							WHERE TransactionTypeID ='T24' -- AT1008 -> T24 là loại hàng bán trả lại.
							GROUP BY ReVoucherID
				) T ON T.ReVoucherID  = M.VoucherID
				WHERE AT90.DivisionID = @DivisionID AND AT90.TransactionTypeID IN ('T04') 
				GROUP BY M.SOrderID , T.ConvertedAmount
				ORDER BY M.SOrderID
										
				SELECT * FROM #CMP0012102_EXV

				WHILE EXISTS (SELECT TOP 1 1 FROM #CMP0012102_EXV T1 LEFT JOIN #CMP0012102Ignore_EXV T2 ON T1.SOrderID = T2.SOrderID WHERE T2.SOrderID IS NULL)
				BEGIN
					SET @SOrderID  = null
					SET @ConvertedAmount = null
					SET @CommissionAmount = 0

					SELECT TOP 1 @SOrderID = T1.SOrderID ,@ConvertedAmount = T1.ConvertedAmount
					FROM #CMP0012102_EXV T1
					LEFT JOIN #CMP0012102Ignore_EXV T2 ON T1.SOrderID = T2.SOrderID
					WHERE T2.SOrderID IS NULL

					-- Tính huê hồng nhân viên sale
					SET @CurTemp  = CURSOR SCROLL KEYSET FOR
					SELECT M.SOrderID, D.InventoryID, D.OrderQuantity, D.ConvertedAmount,CT08.RateValue,CT08.RefType, CT07.IsRate, CT07.OptionType
					FROM #CMP00121 M WITH (NOLOCK)
					LEFT JOIN OT2002 D WITH (NOLOCK) ON M.DivisionID = D.DivisionID AND M.SOrderID = D.SOrderID
					LEFT JOIN CMT0007 CT07 WITH (NOLOCK) ON CT07.DivisionID = M.DivisionID AND CT07.CommissionMethodID = @CommissionMethodID
					LEFT JOIN CMT0008 CT08 WITH (NOLOCK) ON CT08.DivisionID = M.DivisionID AND M.InventoryID = CT08.InventoryID AND CT08.CommissionMethodID = @CommissionMethodID
					WHERE M.SOrderID = @SOrderID 
					ORDER BY M.SOrderID

					OPEN @CurTemp
					FETCH NEXT FROM @CurTemp INTO  @SOrderResult ,@InventoryIDResult ,@OrderQuantityResult ,@ConvertedAmountResult ,@RateValueResult,@RefTypeResult ,@IsRateResult,@CommissionTypeResult 
					WHILE @@Fetch_Status = 0 AND @ConvertedAmount > 0
					BEGIN

					PRINT @InventoryIDResult
					PRINT @CommissionAmount

					SET @ConvertedAmountResult = (CASE WHEN @ConvertedAmount < @ConvertedAmountResult THEN @ConvertedAmount ELSE @ConvertedAmountResult END)
					IF(ISNULL(MIN(@RefTypeResult), 0) = 0)
					BEGIN 
						 SET @CommissionAmount = @OrderQuantityResult * ISNULL(MIN(@RateValueResult), 0) * @PriceUnit
					END
					ELSE
					BEGIN
						SET @CommissionAmount = @ConvertedAmountResult * ISNULL(MIN(@RateValueResult), 0) * @PriceUnit
					END
				
					-- Insert #CMP00121Group
					INSERT INTO #CMP00121Group
					(
						APK
						, DivisionID
						, SalesManID		
						, SOrderID		
						, PriceListID
						, InventoryGroup	
						, OrderQuantity	
						, ConvertedAmount
						, CommissionAmount
					)
					SELECT 
						NEWID()
						, DivisionID
						, SalesManID
						, C21.SOrderID
						, PriceListID
						, C21.InventoryID
						, SUM(OrderQuantity) AS OrderQuantity
						, (SUM(ConvertedAmount)-ISNULL(RConvertedAmount,0)) AS ConvertedAmount --@ConvertedAmount AS ConvertedAmount
						, @CommissionAmount as CommissionAmount
					FROM #CMP00121 C21
						LEFT JOIN ( 
							SELECT ReVoucherID,InventoryID,SUM(ConvertedAmount) as RConvertedAmount 
							FROM AT9000 WITH (NOLOCK)
							WHERE TransactionTypeID ='T24' -- AT1008 -> T24 là loại hàng bán trả lại.
							GROUP BY ReVoucherID,InventoryID
							) T ON T.ReVoucherID  = C21.VoucherID AND T.InventoryID = C21.InventoryID
					WHERE C21.SOrderID = @SOrderID AND C21.InventoryID = @InventoryIDResult
					GROUP BY
						C21.DivisionID
						, C21.SalesManID
						, C21.SOrderID
						, C21.PriceListID
						, C21.InventoryID
						, T.RConvertedAmount
					SET @ConvertedAmount = @ConvertedAmount - @ConvertedAmountResult

					FETCH NEXT FROM @curTemp INTO @SOrderResult ,@InventoryIDResult ,@OrderQuantityResult ,@ConvertedAmountResult ,@RateValueResult,@RefTypeResult ,@IsRateResult,@CommissionTypeResult 
					END
					CLOSE @curTemp
					DEALLOCATE @curTemp

					INSERT INTO #CMP0012102Ignore_EXV(SOrderID)
					SELECT @SOrderID

				END
			
				PRINT ('STEP 04')
				SELECT * FROM #CMP00121Group

				-- Insert dữ liệu kết quả.
				BEGIN 

				SELECT C21.DivisionID
						, C21.SOrderID
						, OT01.VoucherNo
						, OT01.ObjectID
						, SUM(C21.CommissionAmount) as CommissionAmount
					INTO #CMP00121GroupMaster
					FROM #CMP00121Group C21
					INNER JOIN OT2001 OT01 WITH (NOLOCK) ON OT01.DivisionID = C21.DivisionID
											AND OT01.TranYear = @TranYear
											AND OT01.TranMonth = @TranMonth
											AND OT01.SOrderID = C21.SOrderID
					GROUP BY C21.DivisionID
						, C21.SOrderID
						, OT01.VoucherNo
						, OT01.ObjectID


				select * from #CMP00121GroupMaster
					INSERT CMT0012
					(
						APK
						, DivisionID
						, CommissionMethodID
						, VoucherID
						, VoucherNo
						, TranYear
						, TranMonth
						, ObjectID
						, ComAmount
						, Notes
						, CreateUserID
						, CreateDate
						, IsRoyalty
					)
					SELECT
						NEWID()
						, C21.DivisionID
						, @CommissionMethodID
						, C21.SOrderID
						, C21.VoucherNo
						, @TranYear
						, @TranMonth
						, C21.ObjectID
						, C21.CommissionAmount
						, @Notes
						, @UserID
						, GETDATE()
						, '0'
					FROM #CMP00121GroupMaster C21
					--INNER JOIN OT2001 OT01 WITH (NOLOCK) ON OT01.DivisionID = C21.DivisionID
															--AND OT01.TranYear = @TranYear
															--AND OT01.TranMonth = @TranMonth
															--AND OT01.SOrderID = C21.SOrderID

					INSERT CMT0013
					(
						APK
						, DivisionID
						, CommissionMethodID
						, VoucherNo
						, TranYear
						, TranMonth
						, ObjectID
						, InventoryID
						, ConvertedAmount
						, ComAmount
						, Notes
						, CreateUserID
						, CreateDate
						, SaleManID
						, IsRoyalty
						, Quantity
					)
					SELECT
						NEWID()
						, C21.DivisionID
						, @CommissionMethodID
						, OT01.VoucherNo
						, @TranYear
						, @TranMonth
						, OT01.ObjectID
						, ISNULL(C21.InventoryGroup,'')
						, C21.ConvertedAmount
						, C21.CommissionAmount
						, @Notes
						, @UserID
						, GETDATE()
						, C21.SalesManID
						, '0'
						, C21.OrderQuantity
					FROM #CMP00121Group C21
					INNER JOIN OT2001 OT01 WITH (NOLOCK) ON OT01.DivisionID = C21.DivisionID
															AND OT01.TranYear = @TranYear
															AND OT01.TranMonth = @TranMonth
															AND OT01.SOrderID = C21.SOrderID
				END
			END
			END
	END
ELSE
	BEGIN

	SET @Cor_cur = Cursor Scroll KeySet FOR 
	SELECT DISTINCT  VoucherID, InventoryID, ObjectID, Quantity , ReVoucherID
		FROM AT9000
		WHERE DivisionID = @DivisionID
			AND TranYear =@TranYear and TranMonth=@TranMonth
			AND TransactionTypeID = 'T24' 
			and ReVoucherID in (Select distinct VoucherID from CMTT0010 where DivisionID=@DivisionID)
		OPEN	@Cor_cur
		FETCH NEXT FROM @Cor_cur INTO   @VoucherID, @InventoryID, @ObjectID, @Quantity, @RevoucherID
		WHILE @@Fetch_Status = 0
			Begin
				Delete CMT0010 where DivisionID =@DivisionID and VoucherID =@VoucherID and InventoryID=@InventoryID
				Delete CMTT0010 where DivisionID=@DivisionID and VoucherID =@VoucherID and InventoryID=@InventoryID
				Insert into CMT0010 (DivisionID,  TranMonth, TranYear, 
							VoucherID, InventoryID, ObjectID, ComPercent, ComUnit, ComAmount,
							Notes)
				(Select DivisionID,  @TranMonth, @TranYear, @VoucherID, InventoryID, ObjectID, -ComPercent, -ComUnit, -(ComUnit*@Quantity),	N'Trừ hàng bán trả lại'
				From CMT0010 where DivisionID=@DivisionID and VoucherID=@RevoucherID and InventoryID=@InventoryID)	
				Insert into CMTT0010 (DivisionID, InventoryID, VObjectID, VoucherID)
								Values (@DivisionID, @InventoryID, @ObjectID, @VoucherID)	
					FETCH NEXT FROM @Cor_cur INTO  @VoucherID, @InventoryID, @ObjectID, @Quantity, @RevoucherID
			End
		Close @Cor_cur
		DEALLOCATE @Cor_cur
		
	-- Tính hoa hồng theo từng hóa đơn
	Set  @sSQL1 = N' Insert into CMT0012 (DivisionID,CommissionMethodID,VoucherID,VoucherNo,TranMonth,TranYear,ObjectID,ComAmount,Notes,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate)
	Select DivisionID, '''+@CommissionMethodID+''', VoucherID, '''+@VoucherNo+''', TranMonth, TranYear, ObjectID, Sum(ComAmount), '''+@Notes+''', ''ASOFTADMIN'', getdate(),''ASOFTADMIN'', getdate() 
	From CMT0010
	Where TranMonth ='''+STR(@TranMonth)+''' and TranYear ='''+STR(@TranYear)+'''
	and DivisionID ='''+@DivisionID+'''
	Group by DivisionID, VoucherID, TranMonth, TranYear, ObjectID
	'
	---- Tính hoa hồng cho nhân viên phòng ban hỗ trợ
	Set  @sSQL2 = N'Select T90.DivisionID, T90.VoucherID, T90.InvoiceNo, T90.TranMonth, T90.TranYear, T90.InventoryID, T90.ConvertedQuantity, T90.ConvertedAmount, C07.IsRate, C08.RateValue, C09.ObjectID, C09.AmountUnit, T90.InvoiceDate, T90.CreateUserID,
	(Case when C07.IsRate = 1 then (T90.ConvertedAmount*C09.AmountUnit)/100 else T90.ConvertedQuantity*C09.AmountUnit end) as ComAmount, T90.TransactionTypeID
	Into #Temp
	From AT9000 T90 inner join AT1302 on AT1302.DivisionID = T90.DivisionID and AT1302.InventoryID = T90.InventoryID
	inner join CMT0008 C08 on AT1302.DivisionID = C08.DivisionID and AT1302.I01ID = C08.InventoryID
	inner join CMT0009 C09 on C08.DivisionID = C09.DivisionID and C08.InventoryID = C09.InventoryID and C09.CommissionMethodID = C08.CommissionMethodID
	inner join CMT0007 C07 on C09.DivisionID = C07.DivisionID and C09.CommissionMethodID = C07.CommissionMethodID
	where T90.DivisionID ='''+@DivisionID+'''
	and T90.TranMonth = '''+STR(@TranMonth)+'''
	and T90.TranYear = '''+STR(@TranYear)+'''
	and C07.CommissionMethodID ='''+@CommissionMethodID+'''
	and T90.TransactionTypeID in (''T04'', ''T24'')
	--and isnull((Case when T90.TransactionTypeID =''T14'' then 1 else T90.RevoucherID end),'''')<>''''
	and T90.IsCom =1
	AND T90.InvoiceNo IS NOT NULL
	'

	Set  @sSQL3 = N' Insert into CMT0013 (DivisionID,CommissionMethodID,InventoryID,VoucherNo,TranMonth,TranYear,ObjectID,ComAmount,Notes,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate,IsRoyalty,GVoucherID)
	Select DivisionID, '''+@CommissionMethodID+''', InventoryID, InvoiceNo, TranMonth, TranYear, ObjectID, (Case when TransactionTypeID =''T04'' then Sum(ComAmount) else -Sum(ComAmount) end), '''+@Notes+''', CreateUserID, InvoiceDate,''ASOFTADMIN'', getdate(), 0, '' 
	From #Temp
	Group by DivisionID, InventoryID, InvoiceNo, TranMonth, TranYear, ObjectID, CreateUserID, InvoiceDate, TransactionTypeID
	Having Sum(ComAmount)<>0
	'
	PRINT (@sSql1 + @sSql2 + @sSQL3)
	Exec (@sSql1 + @sSql2 + @sSQL3)
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO