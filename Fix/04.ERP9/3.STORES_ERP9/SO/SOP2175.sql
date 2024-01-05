IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2175]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2175]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---		Store phát sinh dữ liệu Giao hàng bán sỉ - APP khi lưu điều phối
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Văn Tài on [15/05/2023]
----Modified by: Văn Tài on [30/05/2023] - Bổ sung trường hợp xử lý update lại Điều phối.
----Modified by: Thành Sang on [20/12/2023] - Sửa cách insert điều phối trường hợp có nhiều ngày giao thì tách ra.
----Modified by: Thành Sang on [20/12/2023] - Bổ sung insert cho trường hợp phiếu hàng hồi

/*
	exec SOP2175 @DivisionID=N'VNP',  @VoucherNo=N'', @Mode=N'1'
*/

 CREATE PROCEDURE [dbo].[SOP2175] (
		 @DivisionID VARCHAR(50),
		 @VoucherNo VARCHAR(50),	--- Chứng từ Phiếu điều phối.
		 @Mode	INT = 1				--- 1: Xóa và insert lại dữ liệu
     )
AS
BEGIN
	DECLARE @sSQL NVARCHAR (MAX);
	DECLARE @MonitorID NVARCHAR(MAX);
	DECLARE @TypeOrder INT; -- 0 là từ đơn hàng bán /1 là phiếu bảo hành sửa chữa /2 là từ phiếu hàng hồi
	DECLARE @VoucherNoSO VARCHAR(50);

	 --  Xóa và insert lại dữ liệu
	IF @Mode = 1
	BEGIN
		SET @MonitorID = (SELECT TOP 1 MonitorID  FROM SOT2201 ST01 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND DVoucherNo = @VoucherNo);
		SET @TypeOrder = (SELECT TOP 1 @TypeOrder FROM SOT2170 ST01 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND VoucherNo = @VoucherNo);
		SET @VoucherNoSO = (SELECT TOP 1 OrderNo FROM SOT2170 ST01 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND VoucherNo = @VoucherNo);

		IF ISNULL(@MonitorID, '') != ''
		BEGIN
		
			DELETE SOT2202 WHERE DivisionID = @DivisionID AND MonitorID = @MonitorID
			DELETE SOT2201 WHERE DivisionID = @DivisionID AND MonitorID = @MonitorID

		END

		IF ISNULL(@TypeOrder, 0) = 0 OR ISNULL(@TypeOrder, 0) = 1
		BEGIN
			INSERT INTO [dbo].[SOT2201]
				   ([APK]
				   ,[DivisionID]
				   ,[DVoucherNo]
				   ,[MonitorID]
				   ,[RouteID]
				   ,[AssetID]
				   ,[DriverID]
				   ,[Shipper]
				   ,[StatusTransportation]
				   ,[OrderAssignQuanty]
				   ,[Weight]
				   ,[Description]
				   ,[Status]
				   ,[DeliveryDate]
				   ,[RouteStartDate]
				   ,[RouteEndDate]
				   ,[CreateDate]
				   ,[CreateUserID]
				   ,[LastModifyUserID]
				   ,[LastModifyDate]
				   ,[Disabled])
		SELECT 
					NEWID() AS APK
				   , ST70.DivisionID
				   , ST70.VoucherNo
				   , NEWID() AS MonitorID
				   , MIN(ST70.[Route]) AS RouteID
				   , MIN(ST70.Car) AS [AssetID]
				   , ST70.EmployeeID AS [DriverID]
				   , ST70.EmployeeID AS [Shipper]
				   , 0 AS [StatusTransportation]
				   , SUM(ST70.[Quantity]) AS [OrderAssignQuanty]
				   , SUM(ST70.[Quantity]) AS [Weight]
				   , MIN(ST70.Notes) AS [Description]
				   , 0 AS [Status]
				   , MIN(ST70.DeliveryDate) AS [DeliveryDate] 
				   , MIN(ST70.BeginDate) AS [RouteStartDate]
				   , MAX(ST70.EndDate) AS [RouteEndDate]
				   , MIN(ST70.CreateDate) AS [CreateDate]
				   , MIN(ST70.CreateUserID) AS [CreateUserID]
				   , MIN(ST70.LastModifyUserID) AS [LastModifyUserID]
				   , MIN(ST70.LastModifyDate) AS [LastModifyDate]
				   , 0 AS Disabled
		FROM SOT2170 ST70 WITH (NOLOCK)
		WHERE ST70.DivisionID = @DivisionID
				AND ST70.VoucherNo = @VoucherNo
		GROUP BY ST70.DivisionID
				, ST70.EmployeeID
				, ST70.VoucherNo
				, ST70.[Route]
				, ST70.Car
				, ST70.BeginDate

			INSERT INTO [dbo].[SOT2202]
				   ([APK]
				   ,[DivisionID]
				   ,[MonitorID]
				   ,[TransactionVoucher]
				   ,[Weight]
				   ,[DeliveryAddress]
				   ,[Status]
				   ,[VoucherNo])
		SELECT
			NEWID() AS [APK]
           , ST70.DivisionID
           , OT01.MonitorID AS [MonitorID]
           , ST70.TransactionID
           , ST70.Quantity AS [Weight]
           --, OT02.DeliveryAddressID AS [DeliveryAddress]
		   , W95.RDAddressID AS [DeliveryAddress]
           , ST70.[Status] AS [Status]
           , ST70.OrderNo AS [VoucherNo]
		FROM SOT2170 ST70 WITH (NOLOCK)
		LEFT JOIN WT0096 W96 WITH (NOLOCK) ON ST70.DivisionID = W96.DivisionID AND ST70.TransactionID = W96.APK
		LEFT JOIN WT0095 W95 WITH (NOLOCK) ON W95.VoucherID = W96.VoucherID
		LEFT JOIN OT2002 OT02 WITH (NOLOCK) ON OT02.DivisionID = ST70.DivisionID
					AND OT02.TransactionID = ST70.TransactionID
		CROSS APPLY
		(
			SELECT TOP 1 OT01.*
			FROM SOT2201 OT01 WITH (NOLOCK)
			WHERE OT01.DivisionID = ST70.DivisionID
					AND OT01.DriverID = ST70.EmployeeID
					AND OT01.DVoucherNo = ST70.VoucherNo
					AND OT01.RouteID = ST70.Route
					AND OT01.AssetID = ST70.Car
					AND OT01.RouteStartDate= ST70.BeginDate 
		) OT01
		WHERE ST70.DivisionID = @DivisionID
				AND ST70.VoucherNo = @VoucherNo
			
			UPDATE APT0001 SET OrderStatus = 3 WHERE VoucherNo = (SELECT TOP 1 VoucherNoApp FROM OT2001 WHERE VoucherNo = @VoucherNoSO)
		END

		IF ISNULL(@TypeOrder, 0) = 2
		BEGIN
			INSERT INTO [dbo].[SOT2201]
				   ([APK]
				   ,[DivisionID]
				   ,[DVoucherNo]
				   ,[MonitorID]
				   ,[RouteID]
				   ,[AssetID]
				   ,[DriverID]
				   ,[Shipper]
				   ,[StatusTransportation]
				   ,[OrderAssignQuanty]
				   ,[Weight]
				   ,[Description]
				   ,[Status]
				   ,[DeliveryDate]
				   ,[RouteStartDate]
				   ,[RouteEndDate]
				   ,[CreateDate]
				   ,[CreateUserID]
				   ,[LastModifyUserID]
				   ,[LastModifyDate]
				   ,[Disabled])
		SELECT 
					NEWID() AS APK
				   , ST70.DivisionID
				   , ST70.VoucherNo
				   , NEWID() AS MonitorID
				   , MIN(ST70.[Route]) AS RouteID
				   , MIN(ST70.Car) AS [AssetID]
				   , ST70.EmployeeID AS [DriverID]
				   , ST70.EmployeeID AS [Shipper]
				   , 0 AS [StatusTransportation]
				   , SUM(ST70.[Quantity]) AS [OrderAssignQuanty]
				   , SUM(ST70.[Quantity]) AS [Weight]
				   , MIN(ST70.Notes) AS [Description]
				   , 0 AS [Status]
				   , MIN(ST70.DeliveryDate) AS [DeliveryDate] 
				   , MIN(ST70.BeginDate) AS [RouteStartDate]
				   , MAX(ST70.EndDate) AS [RouteEndDate]
				   , MIN(ST70.CreateDate) AS [CreateDate]
				   , MIN(ST70.CreateUserID) AS [CreateUserID]
				   , MIN(ST70.LastModifyUserID) AS [LastModifyUserID]
				   , MIN(ST70.LastModifyDate) AS [LastModifyDate]
				   , 0 AS Disabled
		FROM SOT2170 ST70 WITH (NOLOCK)
		WHERE ST70.DivisionID = @DivisionID
				AND ST70.VoucherNo = @VoucherNo
		GROUP BY ST70.DivisionID
				, ST70.EmployeeID
				, ST70.VoucherNo
				, ST70.[Route]
				, ST70.Car
				, ST70.BeginDate

			INSERT INTO [dbo].[SOT2202]
				   ([APK]
				   ,[DivisionID]
				   ,[MonitorID]
				   ,[TransactionVoucher]
				   ,[Weight]
				   ,[DeliveryAddress]
				   ,[Status]
				   ,[VoucherNo])
			SELECT
				NEWID() AS [APK]
			   , ST70.DivisionID
			   , OT01.MonitorID AS [MonitorID]
			   , ST70.TransactionID
			   , ST70.Quantity AS [Weight]
			   --, OT02.DeliveryAddressID AS [DeliveryAddress]
			   , T11.DeliveryAddress AS [DeliveryAddress]
			   , ST70.[Status] AS [Status]
			   , ST70.OrderNo AS [VoucherNo]
			FROM SOT2170 ST70 WITH (NOLOCK)
			LEFT JOIN SOT2191 T1 WITH (NOLOCK) ON ST70.DivisionID = T1.DivisionID AND ST70.TransactionID = CONVERT(VARCHAR(50), T1.APK)
			LEFT JOIN SOT2190 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.VoucherID = T2.VoucherID
			LEFT JOIN CRMT101011 T11 WITH (NOLOCK) ON T11.DivisionID IN (T1.DivisionID, '@@@') AND CONVERT(VARCHAR(50), T11.APK) = T2.AddressID2 --AND T11.APKMaster = T3.APK

			--LEFT JOIN WT0096 W96 WITH (NOLOCK) ON ST70.DivisionID = W96.DivisionID AND ST70.TransactionID = W96.APK
			--LEFT JOIN WT0095 W95 WITH (NOLOCK) ON W95.VoucherID = W96.VoucherID
			--LEFT JOIN OT2002 OT02 WITH (NOLOCK) ON OT02.DivisionID = ST70.DivisionID
			--			AND OT02.TransactionID = ST70.TransactionID
			CROSS APPLY
			(
				SELECT TOP 1 OT01.*
				FROM SOT2201 OT01 WITH (NOLOCK)
				WHERE OT01.DivisionID = ST70.DivisionID
						AND OT01.DriverID = ST70.EmployeeID
						AND OT01.DVoucherNo = ST70.VoucherNo
						AND OT01.RouteID = ST70.Route
						AND OT01.AssetID = ST70.Car
						AND OT01.RouteStartDate= ST70.BeginDate 
			) OT01
			WHERE ST70.DivisionID = @DivisionID
					AND ST70.VoucherNo = @VoucherNo
		END
	END

	--- Cập nhật Điều phối => Kiểm tra và cập nhật lại dữ liệu Lộ trình của Tài xế.
	IF @Mode = 2
	BEGIN

		-- Khai báo biến.
		BEGIN
			DECLARE @APK VARCHAR(50);
			DECLARE @VoucherDate DATETIME;
			DECLARE @Lock INT;
			DECLARE @Car VARCHAR(50);
			DECLARE @Transport VARCHAR(50);
			DECLARE @BeginDate DATETIME;
			DECLARE @EndDate	DATETIME;
			DECLARE @EmployeeID VARCHAR(50);
			DECLARE @Route	VARCHAR(50);
			DECLARE @ObjectID VARCHAR(50);
			DECLARE @OrderNo	VARCHAR(50);
			DECLARE @InventoryID VARCHAR(50);
			DECLARE @Quantity	DECIMAL (18, 8);
			DECLARE @Address	NVARCHAR(MAX)
			DECLARE @DeliveryDate DATETIME;
			DECLARE @Status	INT;
			DECLARE @Notes	NVARCHAR(MAX)
			DECLARE @Order	INT;      
			DECLARE @CreateDate DATETIME;
			DECLARE @CreateUserID VARCHAR(50);
			DECLARE @LastModifyUserID VARCHAR(50);
			DECLARE @LastModifyDate DATETIME;
			DECLARE @TransactionID VARCHAR(50);
			DECLARE @IsChangeCar INT = 0;
		END
		
		-- Lấy dữ liệu Điều phối sau khi cập nhật.
		SELECT ST70.*
		INTO #SOP2175_ST70_CHECK
		FROM SOT2170 ST70 WITH (NOLOCK)
		WHERE ST70.DivisionID = @DivisionID AND ST70.VoucherNo = @VoucherNo
		ORDER BY ST70.VoucherNo, ST70.[Order]

		-- Dữ liệu hiện trạng Điều phối.
		SELECT ST70.*
		INTO #SOP2175_ST70
		FROM #SOP2175_ST70_CHECK ST70

		WHILE EXISTS(SELECT TOP 1 1 FROM #SOP2175_ST70_CHECK)
		BEGIN

			SELECT TOP 1
				@APK = APK,
				@VoucherDate = VoucherDate,
				@Lock = Lock,
				@Car = Car,
				@Transport = Transport,
				@BeginDate = BeginDate,
				@EndDate = EndDate,
				@EmployeeID = EmployeeID,
				@Route = Route,
				@ObjectID = ObjectID,
				@OrderNo = OrderNo,
				@InventoryID = InventoryID,
				@Quantity = Quantity,
				@Address = Address,
				@DeliveryDate = DeliveryDate,
				@Status = [Status],
				@Notes = Notes,
				@Order = [Order],
				@CreateDate = CreateDate,
				@CreateUserID = CreateUserID,
				@LastModifyUserID = LastModifyUserID,
				@LastModifyDate = LastModifyDate,
				@TransactionID = TransactionID
			FROM #SOP2175_ST70_CHECK

			-- Kiểm tra trường hợp Đổi xe => Thay đổi thông tin lộ trình.
			BEGIN

				-- Trường hợp thay đổi xe.
				IF NOT EXISTS (SELECT TOP 1 1 FROM #SOP2175_ST70 WHERE APK = @APK AND Car = @Car)
				BEGIN
					SET @IsChangeCar = 1;

					-- Trường hợp xe này chưa tồn tại trong Lộ trình.
					IF (NOT EXISTS (
									SELECT TOP 1 1 
									FROM SOT2201 ST02 WITH (NOLOCK) 
									WHERE ST02.DivisionID = @DivisionID
											AND ST02.DVoucherNo = @VoucherNo
											AND ST02.AssetID = @Car
									)
						)
					BEGIN

						SET @MonitorID = NEWID();
						
						-- => Cần phát sinh SOT2201.MonitorID mới.
						INSERT INTO [SOT2201]
								   ([APK]
								   ,[DivisionID]
								   ,[DVoucherNo]
								   ,[MonitorID]
								   ,[RouteID]
								   ,[AssetID]
								   ,[DriverID]
								   ,[Shipper]
								   ,[StatusTransportation]
								   ,[OrderAssignQuanty]
								   ,[Weight]
								   ,[Description]
								   ,[Status]
								   ,[DeliveryDate]
								   ,[RouteStartDate]
								   ,[RouteEndDate]
								   ,[CreateDate]
								   ,[CreateUserID]
								   ,[LastModifyUserID]
								   ,[LastModifyDate]
								   ,[Disabled])
						SELECT 
									NEWID() AS APK
								   , @DivisionID
								   , @VoucherNo
								   , @MonitorID AS MonitorID
								   , @Route AS RouteID
								   , @Car AS [AssetID]
								   , @EmployeeID AS [DriverID]
								   , @EmployeeID AS [Shipper]
								   , 0 AS [StatusTransportation]
								   , SUM(ST70.[Quantity]) AS [OrderAssignQuanty]
								   , SUM(ST70.[Quantity]) AS [Weight]
								   , MIN(ST70.Notes) AS [Description]
								   , 0 AS [Status]
								   , MIN(ST70.DeliveryDate) AS [DeliveryDate] 
								   , MIN(ST70.BeginDate) AS [RouteStartDate]
								   , MAX(ST70.EndDate) AS [RouteEndDate]
								   , MIN(ST70.CreateDate) AS [CreateDate]
								   , MIN(ST70.CreateUserID) AS [CreateUserID]
								   , MIN(ST70.LastModifyUserID) AS [LastModifyUserID]
								   , MIN(ST70.LastModifyDate) AS [LastModifyDate]
								   , 0 AS Disabled
						FROM #SOP2175_ST70 ST70
						WHERE ST70.DivisionID = @DivisionID
								AND ST70.VoucherNo = @VoucherNo
								AND ST70.Car = @Car
								AND ST70.[Route] = @Route
						GROUP BY ST70.DivisionID
								, ST70.EmployeeID
								, ST70.VoucherNo
								, ST70.[Route]
								, ST70.Car

						-- Cập nhật Details Lộ trình.
						UPDATE ST02
						SET MonitorID = @MonitorID
						FROM SOT2202 ST02
						INNER JOIN #SOP2175_ST70 ST70 ON ST70.DivisionID = ST02.DivisionID 
															AND ST70.TransactionID = ST02.TransactionVoucher
						WHERE ST02.TransactionVoucher = @TransactionID

					END
					--- Đã tồn tại lộ trình liên quan điều phối và xe rồi.
					ELSE
					BEGIN
						-- => Update qua lộ trình đúng.
						SET @MonitorID = (
									SELECT TOP 1 ST01.MonitorID
									FROM SOT2201 ST01 WITH (NOLOCK) 
									WHERE ST01.DivisionID = @DivisionID
											AND ST01.DVoucherNo = @VoucherNo
											AND ST01.AssetID = @Car
									);

						-- Cập nhật Details Lộ trình.
						UPDATE ST02
						SET MonitorID = @MonitorID
						FROM SOT2202 ST02
						INNER JOIN #SOP2175_ST70 ST70 ON ST70.DivisionID = ST02.DivisionID 
															AND ST70.TransactionID = ST02.TransactionVoucher
						WHERE ST02.TransactionVoucher = @TransactionID

					END

				END

			END

			-- Kiểm tra trường hợp thay đổi Đơn hàng.
			BEGIN
				
				--- Đơn đã bị đổi thành Transaction đơn hàng khác.
				IF NOT EXISTS (SELECT TOP 1 1 FROM #SOP2175_ST70 WHERE APK = @APK AND TransactionID = @TransactionID)
				BEGIN

					-- Nếu không tồn tại trước đó.
					IF NOT EXISTS (
									SELECT TOP 1 1 
									FROM SOT2202 ST02 WITH (NOLOCK) 
									INNER JOIN SOT2201 ST01 WITH (NOLOCK) ON ST01.DivisionID = @DivisionID
																			AND ST01.MonitorID = ST02.MonitorID
									WHERE ST02.TransactionVoucher = @TransactionID
								)
					BEGIN

						-- => Update qua lộ trình đúng.
						SET @MonitorID = (
									SELECT TOP 1 ST01.MonitorID
									FROM SOT2201 ST01 WITH (NOLOCK) 
									WHERE ST01.DivisionID = @DivisionID
											AND ST01.DVoucherNo = @VoucherNo
											AND ST01.AssetID = @Car
									);
						
						INSERT INTO [dbo].[SOT2202]
					   ([APK]
					   ,[DivisionID]
					   ,[MonitorID]
					   ,[TransactionVoucher]
					   ,[Weight]
					   ,[DeliveryAddress]
					   ,[Status]
					   ,[VoucherNo])
						SELECT
							NEWID() AS [APK]
						   , ST70.DivisionID
						   , @MonitorID AS [MonitorID]
						   , ST70.TransactionID
						   , ST70.Quantity AS [Weight]
						   , OT02.DeliveryAddressID AS [DeliveryAddress]
						   , ST70.[Status] AS [Status]
						   , ST70.OrderNo AS [VoucherNo]
						FROM SOT2170 ST70 WITH (NOLOCK)
						LEFT JOIN OT2002 OT02 WITH (NOLOCK) ON OT02.DivisionID = ST70.DivisionID
									AND OT02.TransactionID = ST70.TransactionID
						WHERE ST70.DivisionID = @DivisionID
								AND ST70.VoucherNo = @VoucherNo
								AND ST70.TransactionID = @TransactionID
					END

				END

			END

			-- Xóa dữ liệu Lộ trình bị dư do chuyển đổi Tuyến, đơn hàng khi Điều phối.
			BEGIN

				DELETE ST02
				FROM SOT2202 ST02
				INNER JOIN SOT2201 ST01 ON ST01.DivisionID = ST02.DivisionID
												AND ST01.MonitorID = ST02.MonitorID
												AND ST01.DVoucherNo = @VoucherNo
				LEFT JOIN SOT2170 ST70 ON ST70.DivisionID = ST02.DivisionID
											AND ST70.VoucherNo = ST01.DVoucherNo
											AND ST70.TransactionID = ST02.TransactionVoucher
				--- Xóa SOT2202 do không còn dữ liệu điều phối liên quan.
				WHERE ST70.TransactionID IS NULL											

			END

			-- Xóa dữ liệu check.
			BEGIN
				DELETE #SOP2175_ST70_CHECK WHERE APK = @APK

				SET @APK = NULL;
				SET @VoucherDate = NULL;
				SET @Lock = NULL;
				SET @Car = NULL;
				SET @Transport = NULL;
				SET @BeginDate = NULL;
				SET @EndDate = NULL;
				SET @EmployeeID = NULL;
				SET @Route = NULL;
				SET @ObjectID = NULL;
				SET @OrderNo = NULL;
				SET @InventoryID = NULL;
				SET @Quantity = NULL;
				SET @Address = NULL;
				SET @DeliveryDate = NULL;
				SET @Status = NULL;
				SET @Notes = NULL;
				SET @Order = NULL;
				SET @CreateDate = NULL;
				SET @CreateUserID = NULL;
				SET @LastModifyUserID = NULL;
				SET @LastModifyDate = NULL;
				SET @TransactionID = NULL;

				SET @MonitorID = NULL;
				SET @IsChangeCar = 0;
			END
		END

		DELETE #SOP2175_ST70_CHECK
		DELETE #SOP2175_ST70

	END
		
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
