IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2176]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2176]
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
/*
	exec SOP2176 @DivisionID = N'VNA', @IgnoreOrderTransactions = N''

	Status:
	0	Chờ nhận hàng
	1	Hoàn tất
	2	Từ chối
	3	Đang giao hàng
	3	Hủy đơn
*/

 CREATE PROCEDURE [dbo].[SOP2176] (
		 @DivisionID VARCHAR(50),
		 @IgnoreOrderTransactions XML NULL	--- Danh sách các chi tiết đơn hàng bán loại bỏ ra. 
											--- Do đã được dùng lock, không cần load lại để điều phối.
											--- Sử dụng đánh dấu Locked.
     )
AS
BEGIN
	DECLARE @sSQL NVARCHAR (MAX);
	
	-- Tạo bảng và đổ dữ liệu XML
	BEGIN

		--- Danh sách chi tiết đơn hàng loại bỏ.
		CREATE TABLE #SOP2176_Ignores
		(
			SOrderID VARCHAR(50) NULL,
			TransactionID VARCHAR(50)
		)

		IF @IgnoreOrderTransactions IS NOT NULL
		BEGIN
		
			--- INSERT danh sách chi tiết đơn cần loại bỏ.
			INSERT INTO #SOP2176_Ignores
					(
						SOrderID
						, TransactionID
					)
			SELECT	X.Data.query('SOrderID').value('.','VARCHAR(50)') AS SOrderID,
					X.Data.query('TransactionID').value('.','VARCHAR(50)') AS TransactionID
			FROM @IgnoreOrderTransactions.nodes('//Data') AS X (Data)

		END

	END

	--- Xử lý lấy dữ liệu.
	BEGIN

		SELECT 
		T1.DivisionID
		, CASE WHEN (ST76.TransactionID IS NOT NULL) THEN 1 ELSE 0 END AS Lock
		, T2.SOrderID
		, T2.VoucherNo
		, T1.Orders
		, T1.TransactionID
		, T1.InventoryID
		, T11.RouteID
		, T2.ObjectID
		, T3.ObjectName
		, T1.DeliveryDate
		, T1.DeliveryAddress
		, T1.DeliveryAddressID
		, T1.OrderQuantity AS OrderQuantity
		, 1.0 AS Weight
		, 1.0 AS Height
		, 1.0 AS Length
		, 1.0 AS Width
		FROM OT2002 T1 WITH (NOLOCK)
		LEFT JOIN OT2001 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.SOrderID = T2.SOrderID
		LEFT JOIN AT1202 T3 WITH (NOLOCK) ON T3.DivisionID IN ('@@@', T2.DivisionID) AND T3.ObjectID = T2.ObjectID
		LEFT JOIN CRMT101011 T11 WITH (NOLOCK) ON T11.DivisionID = T1.DivisionID AND T11.APK = T1.DeliveryAddressID
		LEFT JOIN CT0143 T43 WITH (NOLOCK) ON T43.DivisionID IN ('@@@', T2.DivisionID) AND T43.RouteID = T11.RouteID
		LEFT JOIN SOT2170 ST70 WITH (NOLOCK) ON ST70.DivisionID = T1.DivisionID AND ST70.TransactionID = T1.TransactionID
		LEFT JOIN #SOP2176_Ignores ST76 WITH (NOLOCK) ON ST76.SOrderID = T1.SOrderID AND ST76.TransactionID = T1.TransactionID
		LEFT JOIN SOT2202 ST02 WITH (NOLOCK) ON ST02.DivisionID = T1.DivisionID AND ST02.TransactionVoucher = T1.TransactionID
		WHERE
			T2.DivisionID = @DivisionID
			AND ISNULL(T2.Status, 0) = 1 
			AND T1.DeliveryDate IS NOT NULL 
			AND T1.DeliveryAddress IS NOT NULL

			-- Chưa phát sinh điều phối trước đó.
			-- Hoặc thông tin giao hàng đã bị Từ chối thì mới cho phép Điều phối mới.
			AND ( 
					ST70.APK IS NULL 
					OR ISNULL(ST02.[Status], 0) = 2					
				)
			-- Các đơn bị Lock thì loại bỏ ra.
			AND ISNULL(ST76.TransactionID, '') = ''
		ORDER BY T1.DivisionID
				, T1.DeliveryDate
				, T2.CreateDate
				, T2.ObjectID
				, T3.ObjectName
				, T1.DeliveryAddress 

	END
		
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
