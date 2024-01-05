IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2173]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2173]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load màn hình chọn đơn hàng
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Kiều Nga 	14/09/2022
----Modified by: Văn Tài	30/05/2023 - Xử lý luồng Điều phối - Load loại bỏ các đơn đã Điều phối trước đó.
----Modified by: Viết Toàn	22/11/2023 - Customize NKC
/*
	exec SOP2173 @DivisionID=N'VNP',  @TxtSearch=N'',@UserID=N'',@PageNumber=N'1',@PageSize=N'25', @TypeID = N'BOM'
*/

 CREATE PROCEDURE [dbo].[SOP2173] (
     @DivisionID NVARCHAR(2000),
     @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT,
	 @VoucherNo VARCHAR(50) = NULL,			--- Chứng từ phiếu điều phối đang đứng lọc.
	 @IgnoreOrderTransactions XML = NULL		--- Danh sách các chi tiết đơn hàng bán loại bỏ ra. Do đã tồn tại trên lưới.		
	)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@CustomerName INT = (SELECT CustomerName FROM CustomerIndex)
IF @CustomerName = 166 -- Customize NKC
	EXEC SOP2173_NKC @DivisionID, @TxtSearch, @UserID, @PageNumber, @PageSize, @VoucherNo, @IgnoreOrderTransactions
ELSE
BEGIN

		-- Tạo bảng và đổ dữ liệu XML
		BEGIN

			--- Danh sách chi tiết đơn hàng loại bỏ.
			CREATE TABLE #SOP2173_Ignores
			(
				TransactionID VARCHAR(50)
			)

			IF @IgnoreOrderTransactions IS NOT NULL
			BEGIN
		
				--- INSERT danh sách chi tiết đơn cần loại bỏ.
				INSERT INTO #SOP2173_Ignores
						(
							TransactionID
						)
				SELECT	X.Data.query('TransactionID').value('.','VARCHAR(50)') AS TransactionID
				FROM @IgnoreOrderTransactions.nodes('//Data') AS X (Data)

			END

		END

		IF(ISNULL(@VoucherNo, '') != '')
		BEGIN

			SET @sSQL = N'
			SELECT ROW_NUMBER() OVER (ORDER BY P.DivisionID
										, P.OrderNo
										, P.DeliveryDate
										, P.ObjectID
										, P.ObjectName
										, P.DeliveryAddress
									) AS RowNum
					,  COUNT(*) OVER () AS TotalRow
					, P.*
			FROM ( 
					SELECT T1.DivisionID
							, T1.TransactionID
							, T1.DeliveryDate 
							, T11.RouteID AS Route
							, T2.ObjectID
							, T3.ObjectName
							, T1.DeliveryAddressID
							, T11.DeliveryAddress
							, T2.VoucherNo AS OrderNo
							, T1.InventoryID
							, T1.DeliveryAddress AS Address
							, T1.OrderQuantity AS Quantity
					FROM OT2002 T1 WITH (NOLOCK)
					LEFT JOIN OT2001 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.SOrderID = T2.SOrderID
					LEFT JOIN AT1202 T3 WITH (NOLOCK) ON T3.DivisionID IN (''@@@'', T2.DivisionID) AND T3.ObjectID = T2.ObjectID
					LEFT JOIN CRMT101011 T11 WITH (NOLOCK) ON T11.DivisionID IN (T1.DivisionID, ''@@@'') AND T11.APK = T1.DeliveryAddressID
					LEFT JOIN SOT2170 T70 WITH (NOLOCK) ON T70.DivisionID = T1.DivisionID 
															AND T70.VoucherNo != '''+ ISNULL(@VoucherNo, '') +'''
															AND T70.TransactionID = T1.TransactionID
					LEFT JOIN #SOP2173_Ignores T73 ON T73.TransactionID = T1.TransactionID
					WHERE T1.DeliveryDate IS NOT NULL
							AND T1.DeliveryAddress IS NOT NULL
							AND 
								(
									T70.APK IS NULL
									OR ISNULL(T70.[Status], 0) = 2
								)
							AND T73.TransactionID IS NULL
							AND ISNULL(T2.Status, 0) = 1
				) AS P
			ORDER BY P.DivisionID
					, P.OrderNo
					, P.DeliveryDate
					, P.ObjectID
					, P.ObjectName
					, P.DeliveryAddress
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

		END
		ELSE
		BEGIN
			
			SET @sSQL = N'
			SELECT ROW_NUMBER() OVER (ORDER BY P.DivisionID
										, P.OrderNo
										, P.DeliveryDate
										, P.ObjectID
										, P.ObjectName
										, P.DeliveryAddress
									) AS RowNum
					,  COUNT(*) OVER () AS TotalRow
					, P.*
			FROM ( 
					SELECT T1.DivisionID
							, T1.TransactionID
							, T1.DeliveryDate 
							, T11.RouteID AS Route
							, T2.ObjectID
							, T3.ObjectName
							, T1.DeliveryAddressID
							, T11.DeliveryAddress
							, T2.VoucherNo AS OrderNo
							, T1.InventoryID
							, T1.DeliveryAddress AS Address
							, T1.OrderQuantity AS Quantity
					FROM OT2002 T1 WITH (NOLOCK)
					LEFT JOIN OT2001 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.SOrderID = T2.SOrderID
					LEFT JOIN AT1202 T3 WITH (NOLOCK) ON T3.DivisionID IN (''@@@'', T2.DivisionID) AND T3.ObjectID = T2.ObjectID
					LEFT JOIN CRMT101011 T11 WITH (NOLOCK) ON T11.DivisionID IN (T1.DivisionID, ''@@@'') AND T11.APK = T1.DeliveryAddressID
					LEFT JOIN SOT2170 T70 WITH (NOLOCK) ON T70.DivisionID = T1.DivisionID 
															AND T70.TransactionID = T1.TransactionID
					LEFT JOIN #SOP2173_Ignores T73 ON T73.TransactionID = T1.TransactionID
					WHERE T1.DeliveryDate IS NOT NULL
							AND T1.DeliveryAddress IS NOT NULL
							AND 
								(
									T70.APK IS NULL
									OR ISNULL(T70.[Status], 0) = 2
								)
							AND T73.TransactionID IS NULL
							AND ISNULL(T2.Status, 0) = 1
				) AS P
			ORDER BY P.DivisionID
					, P.OrderNo
					, P.DeliveryDate
					, P.ObjectID
					, P.ObjectName
					, P.DeliveryAddress
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

		END

	PRINT (@sSQL)
	EXEC (@sSQL)
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
