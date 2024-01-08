IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2176_NKC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2176_NKC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---		Store Lấy các dữ liệu Đơn hàng bán có thể điều phối ở Giải thuật.
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Văn Tài on [22/05/2023]
----Updated by: Viết Toàn on [08/11/2023]:	-- Bổ sung hàng bảo hành sửa chữa 
											-- Lấy theo tiến độ giao hàng thay vì trực tiếp từ đơn hàng bán
/*
	exec SOP2176_NKC @DivisionID = N'VNA', @IgnoreOrderTransactions = N'', @IgnoreWarrantyTransactions = N''

	Status:
	0	Chờ nhận hàng
	1	Hoàn tất
	2	Từ chối
	3	Đang giao hàng
	3	Hủy đơn
*/

 CREATE PROCEDURE [dbo].[SOP2176_NKC] (
		 @DivisionID VARCHAR(50),
		 @IgnoreOrderTransactions XML NULL,
		 @TranMonth INT,
		 @TranYear INT
     )
AS
BEGIN
	DECLARE @sSQL NVARCHAR (MAX);
	
	-- Tạo bảng và đổ dữ liệu XML
	BEGIN

		--- Danh sách chi tiết đơn hàng loại bỏ.
		CREATE TABLE #SOP2176_NKC_IgnoresOrder
		(
			SOrderID VARCHAR(50) NULL,
			TransactionID VARCHAR(50),
			TypeOrder TINYINT NULL -- 0: đơn hàng bán, 1: hàng bảo hành/ sửa chữa, 2: Hàng hồi
		)

		IF @IgnoreOrderTransactions IS NOT NULL
		BEGIN
		
			--- INSERT danh sách chi tiết đơn cần loại bỏ.
			INSERT INTO #SOP2176_NKC_IgnoresOrder
					(
						SOrderID
						, TransactionID
						, TypeOrder
					)
			SELECT	X.Data.query('SOrderID').value('.','VARCHAR(50)') AS SOrderID,
					X.Data.query('TransactionID').value('.','VARCHAR(50)') AS TransactionID,
					X.Data.query('TypeOrder').value('.','TINYINT') AS TypeOrder
			FROM @IgnoreOrderTransactions.nodes('//Data') AS X (Data)

		END

	END

	--- Xử lý lấy dữ liệu.
	BEGIN

		-- Xử lý điều phối theo đơn hàng bán
		SELECT ROW_NUMBER () OVER (ORDER BY O03_MT.Date) AS Orders
		, T1.DivisionID
		, CASE WHEN (ST76.TransactionID IS NOT NULL) THEN 1 ELSE 0 END AS Lock
		, T2.SOrderID
		, T2.VoucherNo
		--, T1.Orders
		, CONVERT(VARCHAR(50), W96.APK) AS TransactionID
		, T1.InventoryID
		, T11.RouteID
		, O03.ObjectID
		, T3.ObjectName
		, O03_MT.[Date] AS DeliveryDate
		, O03_MT.Address AS DeliveryAddress
		, CASE O03_MT.Quantity 
			WHEN 'Quantity01' THEN T1.Quantity01
			WHEN 'Quantity02' THEN T1.Quantity02
			WHEN 'Quantity03' THEN T1.Quantity03
			WHEN 'Quantity04' THEN T1.Quantity04
			WHEN 'Quantity05' THEN T1.Quantity05
			WHEN 'Quantity06' THEN T1.Quantity06
			WHEN 'Quantity07' THEN T1.Quantity07
			WHEN 'Quantity08' THEN T1.Quantity08
			WHEN 'Quantity09' THEN T1.Quantity09
			WHEN 'Quantity10' THEN T1.Quantity10
			WHEN 'Quantity11' THEN T1.Quantity11
			WHEN 'Quantity12' THEN T1.Quantity12
			WHEN 'Quantity13' THEN T1.Quantity13
			WHEN 'Quantity14' THEN T1.Quantity14
			WHEN 'Quantity15' THEN T1.Quantity15
			WHEN 'Quantity16' THEN T1.Quantity16
			WHEN 'Quantity17' THEN T1.Quantity17
			WHEN 'Quantity18' THEN T1.Quantity18
			WHEN 'Quantity19' THEN T1.Quantity19
			WHEN 'Quantity20' THEN T1.Quantity20
			WHEN 'Quantity21' THEN T1.Quantity21
			WHEN 'Quantity22' THEN T1.Quantity22
			WHEN 'Quantity23' THEN T1.Quantity23
			WHEN 'Quantity24' THEN T1.Quantity24
			WHEN 'Quantity25' THEN T1.Quantity25
			WHEN 'Quantity26' THEN T1.Quantity26
			WHEN 'Quantity27' THEN T1.Quantity27
			WHEN 'Quantity28' THEN T1.Quantity28
			WHEN 'Quantity29' THEN T1.Quantity29
			WHEN 'Quantity30' THEN T1.Quantity30
		ELSE 0 END AS OrderQuantity
		, 1.0 AS Weight
		, W99.S03ID AS Height
		, W99.S01ID AS [Length]
		, W99.S02ID AS Width
		, W99.S04ID AS Color
		, 0 AS TypeOrder
		, T11.Distance
		, W95.RDAddressID
		, A02.Notes01 AS Volume
		INTO #SOP2176_NKC_1
		FROM OT2002 T1 WITH (NOLOCK)
		LEFT JOIN OT2001 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.SOrderID = T2.SOrderID
		LEFT JOIN WT0096 W96 WITH (NOLOCK) ON W96.InheritTransactionID = T1.TransactionID 
											AND W96.DivisionID IN ('@@@', T1.DivisionID)  
											AND T1.InventoryID = W96.InventoryID
		LEFT JOIN WT0095 W95 WITH (NOLOCK) ON W95.VoucherID = W96.VoucherID
		LEFT JOIN OT2003 O03 WITH (NOLOCK) ON T2.SOrderID = O03.SOrderID AND O03.DivisionID IN ('@@@', T2.DivisionID)
		LEFT JOIN OT2003_MT O03_MT WITH (NOLOCK) ON O03_MT.InheritTransactionID = CONVERT(VARCHAR(50), O03.APK) 
												AND O03_MT.SOrderID = T2.SOrderID -- đang xử lý
												AND CONVERT(VARCHAR(50), W96.APK) = O03_MT.DInheritVoucherID
		LEFT JOIN WT8899 W99 WITH (NOLOCK) ON W99.TransactionID = W96.TransactionID 
											AND W99.TableID = N'WT0096' 
											AND W99.VoucherID = W96.VoucherID
		LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.InventoryID = T1.InventoryID AND A02.DivisionID IN ('@@@', T1.DivisionID)
		LEFT JOIN AT1202 T3 WITH (NOLOCK) ON T3.DivisionID IN ('@@@', T2.DivisionID) AND T3.ObjectID = O03.ObjectID
		LEFT JOIN CRMT101011 T11 WITH (NOLOCK) ON T11.DivisionID IN (T1.DivisionID, '@@@') AND CONVERT(VARCHAR(50), T11.APK) = W95.RDAddressID --AND T11.APKMaster = T3.APK
		LEFT JOIN CT0143 T43 WITH (NOLOCK) ON T43.DivisionID IN ('@@@', T2.DivisionID) AND T43.RouteID = T11.RouteID
		LEFT JOIN SOT2170 ST70 WITH (NOLOCK) ON ST70.DivisionID = T1.DivisionID AND ST70.TransactionID = CONVERT(VARCHAR(50), W96.APK)
		LEFT JOIN #SOP2176_NKC_IgnoresOrder ST76 WITH (NOLOCK) ON ST76.SOrderID = W96.SOrderID AND ST76.TransactionID = CONVERT(VARCHAR(50), W96.APK) AND ST76.TypeOrder = 0
		LEFT JOIN SOT2202 ST02 WITH (NOLOCK) ON ST02.DivisionID = T1.DivisionID AND ST02.TransactionVoucher = T1.TransactionID
		LEFT JOIN OOT9000 O90 WITH (NOLOCK) ON CONVERT(VARCHAR(50), O90.APK) = W95.APKMaster_9000
		LEFT JOIN OOT9001 O91 WITH (NOLOCK) ON O91.APKMaster = CONVERT(VARCHAR(50), O90.APK)
		WHERE
			T1.DivisionID IN ('@@@', @DivisionID)
			AND ISNULL(T2.Status, 0) = 1
			AND ISNULL(O91.Status, 0) = 1
			AND O03_MT.[Date] IS NOT NULL
			AND O03_MT.[Address] IS NOT NULL
			AND T11.RouteID IS NOT NULL
			-- Chưa phát sinh điều phối trước đó.
			-- Hoặc thông tin giao hàng đã bị Từ chối thì mới cho phép Điều phối mới.
			AND ( 
					ISNULL(CONVERT(VARCHAR(50), ST70.APK), '') = ''
					OR ISNULL(ST02.[Status], 0) = 2
				) 
			 --Các đơn bị Lock thì loại bỏ ra.
			AND ISNULL(ST76.TransactionID, '') = ''
			AND W95.TranMonth = @TranMonth 
			AND W95.TranYear = @TranYear
		GROUP BY T1.DivisionID, ST76.TransactionID, T2.SOrderID, T2.VoucherNo--, W96.APK--T1.Orders, 
		, T1.InventoryID, T11.RouteID, O03.ObjectID, T3.ObjectName, O03_MT.Address, O03_MT.[Date], O03_MT.Quantity
		, T1.Quantity01, T1.Quantity02, T1.Quantity03, T1.Quantity04, T1.Quantity05, T1.Quantity06, T1.Quantity07, T1.Quantity08, T1.Quantity09, T1.Quantity10
		, T1.Quantity11, T1.Quantity12, T1.Quantity13, T1.Quantity14, T1.Quantity15, T1.Quantity16, T1.Quantity17, T1.Quantity18, T1.Quantity19, T1.Quantity20
		, T1.Quantity21, T1.Quantity22, T1.Quantity23, T1.Quantity24, T1.Quantity25, T1.Quantity26, T1.Quantity27, T1.Quantity28, T1.Quantity29, T1.Quantity30
		, T11.Distance, W95.RDAddressID, W99.S01ID, W99.S02ID, W99.S03ID, W99.S04ID, W96.APK, A02.Notes01
		ORDER BY T1.DivisionID
				--, T1.DeliveryDate
				, O03_MT.[Date]
				, O03.ObjectID
				, T3.ObjectName
				, O03_MT.Address


		-- Xử lý điều phối theo hàng bảo hành
		SELECT ROW_NUMBER () OVER (ORDER BY O03_MT.Date) AS Orders
		,T1.DivisionID
		, CASE WHEN (ST76.TransactionID IS NOT NULL) THEN 1 ELSE 0 END AS Lock
		, T2.VoucherID AS SOrderID
		, T2.VoucherNo
		--, T1.VoucherID
		, CONVERT(VARCHAR(50), MAX(W96.APK)) AS [TransactionID]
		, T1.InventoryID
		, T11.RouteID
		, O03.ObjectID
		, T3.ObjectName
		, O03_MT.[Date] AS DeliveryDate
		, O03_MT.Address AS DeliveryAddress
		, CASE O03_MT.Quantity 
			WHEN 'Quantity01' THEN T1.Quantity01
			WHEN 'Quantity02' THEN T1.Quantity02
			WHEN 'Quantity03' THEN T1.Quantity03
			WHEN 'Quantity04' THEN T1.Quantity04
			WHEN 'Quantity05' THEN T1.Quantity05
			WHEN 'Quantity06' THEN T1.Quantity06
			WHEN 'Quantity07' THEN T1.Quantity07
			WHEN 'Quantity08' THEN T1.Quantity08
			WHEN 'Quantity09' THEN T1.Quantity09
			WHEN 'Quantity10' THEN T1.Quantity10
			WHEN 'Quantity11' THEN T1.Quantity11
			WHEN 'Quantity12' THEN T1.Quantity12
			WHEN 'Quantity13' THEN T1.Quantity13
			WHEN 'Quantity14' THEN T1.Quantity14
			WHEN 'Quantity15' THEN T1.Quantity15
			WHEN 'Quantity16' THEN T1.Quantity16
			WHEN 'Quantity17' THEN T1.Quantity17
			WHEN 'Quantity18' THEN T1.Quantity18
			WHEN 'Quantity19' THEN T1.Quantity19
			WHEN 'Quantity20' THEN T1.Quantity20
			WHEN 'Quantity21' THEN T1.Quantity21
			WHEN 'Quantity22' THEN T1.Quantity22
			WHEN 'Quantity23' THEN T1.Quantity23
			WHEN 'Quantity24' THEN T1.Quantity24
			WHEN 'Quantity25' THEN T1.Quantity25
			WHEN 'Quantity26' THEN T1.Quantity26
			WHEN 'Quantity27' THEN T1.Quantity27
			WHEN 'Quantity28' THEN T1.Quantity28
			WHEN 'Quantity29' THEN T1.Quantity29
			WHEN 'Quantity30' THEN T1.Quantity30
		ELSE 0 END AS OrderQuantity
		--, T1.OrderQuantity AS OrderQuantity
		, 1.0 AS Weight
		, W99.S03ID AS Height
		, W99.S01ID AS Length
		, W99.S02ID AS Width
		, W99.S04ID AS Color
		, 1 AS TypeOrder
		, T11.Distance
		, W95.RDAddressID
		, A02.Notes01 AS Volume
		INTO #SOP2176_NKC_2
		FROM SOT2191 T1 WITH (NOLOCK)
		LEFT JOIN SOT2190 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.VoucherID = T2.VoucherID
		LEFT JOIN WT0096 W96 WITH (NOLOCK) ON W96.InheritTransactionID = CONVERT(VARCHAR(50), T1.APK) AND W96.DivisionID IN ('@@@', T1.DivisionID)
		LEFT JOIN WT0095 W95 WITH (NOLOCK) ON W95.VoucherID = W96.VoucherID
		LEFT JOIN OT2003 O03 WITH (NOLOCK) ON T2.VoucherID = O03.WarrantyID AND O03.DivisionID IN ('@@@', T2.DivisionID)
		LEFT JOIN OT2003_MT O03_MT WITH (NOLOCK) ON O03_MT.InheritTransactionID = O03.APK 
													AND O03_MT.WarrantyID = T2.VoucherID
													AND CONVERT(VARCHAR(50), W96.APK) = O03_MT.DInheritVoucherID
		LEFT JOIN WT8899 W99 WITH (NOLOCK) ON W99.TransactionID = W96.TransactionID AND W99.TableID = N'WT0096' AND W99.VoucherID = W96.VoucherID
		LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.InventoryID = T1.InventoryID AND A02.DivisionID IN ('@@@', T1.DivisionID)
		LEFT JOIN AT1202 T3 WITH (NOLOCK) ON T3.DivisionID IN ('@@@', T2.DivisionID) AND T3.ObjectID = O03.ObjectID
		LEFT JOIN CRMT101011 T11 WITH (NOLOCK) ON T11.DivisionID IN (T1.DivisionID, '@@@') AND CONVERT(VARCHAR(50), T11.APK) = W95.RDAddressID --AND T11.APKMaster = T3.APK
		LEFT JOIN CT0143 T43 WITH (NOLOCK) ON T43.DivisionID IN ('@@@', T2.DivisionID) AND T43.RouteID = T11.RouteID
		LEFT JOIN SOT2170 ST70 WITH (NOLOCK) ON ST70.DivisionID = T1.DivisionID AND ST70.TransactionID = CONVERT(VARCHAR(50), W96.APK)
		LEFT JOIN #SOP2176_NKC_IgnoresOrder ST76 WITH (NOLOCK) ON ST76.SOrderID = W96.WarrantyID AND ST76.TransactionID = CONVERT(VARCHAR(50), W96.APK) AND ST76.TypeOrder = 1
		LEFT JOIN SOT2202 ST02 WITH (NOLOCK) ON ST02.DivisionID = T1.DivisionID AND ST02.TransactionVoucher = CONVERT(VARCHAR(50), T1.APK)
		LEFT JOIN OOT9000 O90 WITH (NOLOCK) ON O90.APK = W95.APKMaster_9000
		LEFT JOIN OOT9001 O91 WITH (NOLOCK) ON O91.APKMaster = CONVERT(VARCHAR(50), O90.APK)
		WHERE
			T2.DivisionID IN ('@@@', @DivisionID)
			AND ISNULL(O91.Status, 0) = 1 
			AND O03_MT.[Date] IS NOT NULL 
			AND O03_MT.[Address] IS NOT NULL
			AND T11.RouteID IS NOT NULL

			-- Chưa phát sinh điều phối trước đó.
			-- Hoặc thông tin giao hàng đã bị Từ chối thì mới cho phép Điều phối mới.
			AND ( 
					ST70.APK IS NULL 
					OR ISNULL(ST02.[Status], 0) = 2					
				)
			 --Các đơn bị Lock thì loại bỏ ra.
			AND ISNULL(ST76.TransactionID, '') = ''
			AND T2.VoucherTypeID = N'BH'
			AND W95.TranMonth = @TranMonth AND W95.TranYear = @TranYear
		GROUP BY T1.DivisionID, ST76.TransactionID, T2.VoucherID, T2.VoucherNo--, W96.APK --T1.VoucherID,
		, T1.InventoryID, T11.RouteID, O03.ObjectID, T3.ObjectName, O03_MT.[Date], O03_MT.Address, O03_MT.Quantity
		, T1.Quantity01, T1.Quantity02, T1.Quantity03, T1.Quantity04, T1.Quantity05, T1.Quantity06, T1.Quantity07, T1.Quantity08, T1.Quantity09, T1.Quantity10
		, T1.Quantity11, T1.Quantity12, T1.Quantity13, T1.Quantity14, T1.Quantity15, T1.Quantity16, T1.Quantity17, T1.Quantity18, T1.Quantity19, T1.Quantity20
		, T1.Quantity21, T1.Quantity22, T1.Quantity23, T1.Quantity24, T1.Quantity25, T1.Quantity26, T1.Quantity27, T1.Quantity28, T1.Quantity29, T1.Quantity30
		, T11.Distance, W95.RDAddressID, W99.S01ID, W99.S02ID, W99.S03ID, W99.S04ID, A02.Notes01
		ORDER BY T1.DivisionID
				--, T1.DeliveryDate
				, O03_MT.[Date]
				, O03.ObjectID
				, T3.ObjectName
				, O03_MT.Address

		-- Xử lý điều phối theo hàng hồi
		SELECT ROW_NUMBER () OVER (ORDER BY T2.VoucherDate) AS Orders
		,T1.DivisionID
		, CASE WHEN (ST76.TransactionID IS NOT NULL) THEN 1 ELSE 0 END AS Lock
		, T2.VoucherID AS SOrderID
		, T2.VoucherNo
		--, T1.VoucherID
		, CONVERT(VARCHAR(50), T1.APK) AS [TransactionID]
		, T1.InventoryID
		, T11.RouteID
		, T2.ObjectType AS ObjectID
		, T3.ObjectName
		, T2.VoucherDate AS DeliveryDate
		, T2.Address2 AS DeliveryAddress
		, T1.Quantity AS OrderQuantity
		, 1 AS Weight
		, T1.High AS Height
		, T1.Long AS [Length]
		, T1.Weight AS Width
		, T1.Color
		, 2 AS TypeOrder
		, T11.Distance
		, T2.AddressID2 AS RDAddressID
		, A02.Notes01 AS Volume
		INTO #SOP2176_NKC_3
		FROM SOT2191 T1 WITH (NOLOCK)
		LEFT JOIN SOT2190 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.VoucherID = T2.VoucherID
		LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.InventoryID = T1.InventoryID AND A02.DivisionID IN ('@@@', T1.DivisionID)
		LEFT JOIN AT1202 T3 WITH (NOLOCK) ON T3.DivisionID IN ('@@@', T2.DivisionID) AND T3.ObjectID = T2.ObjectType
		LEFT JOIN CRMT101011 T11 WITH (NOLOCK) ON T11.DivisionID IN (T1.DivisionID, '@@@') AND CONVERT(VARCHAR(50), T11.APK) = T2.AddressID2 --AND T11.APKMaster = T3.APK
		LEFT JOIN CT0143 T43 WITH (NOLOCK) ON T43.DivisionID IN ('@@@', T2.DivisionID) AND T43.RouteID = T11.RouteID
		LEFT JOIN SOT2170 ST70 WITH (NOLOCK) ON ST70.DivisionID = T1.DivisionID AND ST70.TransactionID = CONVERT(VARCHAR(50), T1.APK)
		LEFT JOIN #SOP2176_NKC_IgnoresOrder ST76 WITH (NOLOCK) ON ST76.SOrderID = T1.VoucherID AND ST76.TransactionID = CONVERT(VARCHAR(50), T1.APK) AND ST76.TypeOrder = 2
		LEFT JOIN SOT2202 ST02 WITH (NOLOCK) ON ST02.DivisionID = T1.DivisionID AND ST02.TransactionVoucher = CONVERT(VARCHAR(50), T1.APK)
		WHERE
			T2.DivisionID IN ('@@@', @DivisionID)
			--AND ISNULL(T2.Status, 0) = 1 
			AND T2.[VoucherDate] IS NOT NULL 
			AND T11.DeliveryAddress IS NOT NULL

			-- Chưa phát sinh điều phối trước đó.
			-- Hoặc thông tin giao hàng đã bị Từ chối thì mới cho phép Điều phối mới.
			AND ( 
					ST70.APK IS NULL 
					OR ISNULL(ST02.[Status], 0) = 2					
				)
			 --Các đơn bị Lock thì loại bỏ ra.
			AND ISNULL(ST76.TransactionID, '') = ''
			AND T2.VoucherTypeID = N'HH' -- Phiếu BH-SC (loại hàng hồi)
			AND T2.TranMonth = @TranMonth AND T2.TranYear = @TranYear
		ORDER BY T1.DivisionID
				--, T1.DeliveryDate
				, T2.VoucherDate
				, T2.ObjectType
				, T3.ObjectName
				, T2.Address2

		-- Trả về dữ liệu điều phối (YCXK-ĐHB, YCXK-SC/BH, HH)
		SELECT * FROM #SOP2176_NKC_1
		UNION ALL
		SELECT * FROM #SOP2176_NKC_2
		UNION ALL
		SELECT * FROM #SOP2176_NKC_3

	END
		
END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO