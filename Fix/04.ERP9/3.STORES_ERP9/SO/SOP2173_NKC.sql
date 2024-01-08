IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2173_NKC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2173_NKC]
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
----Created by Viết Toàn	22/11/2023 - Customize NKC
/*
	exec SOP2173_NKC @DivisionID=N'VNP',  @TxtSearch=N'',@UserID=N'',@PageNumber=N'1',@PageSize=N'25', @TypeID = N'BOM'
*/

 CREATE PROCEDURE [dbo].[SOP2173_NKC] (
     @DivisionID NVARCHAR(2000),
     @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT,
	 @VoucherNo VARCHAR(50) = NULL,			--- Chứng từ phiếu điều phối đang đứng lọc.
	 @IgnoreOrderTransactions XML = NULL		--- Danh sách các chi tiết đơn hàng bán loại bỏ ra. Do đã tồn tại trên lưới.		
	)
AS
DECLARE @sSQL1 NVARCHAR(MAX),
		@sSQL2 NVARCHAR(MAX),
		@sSQL3 NVARCHAR(MAX),
		@sSelect NVARCHAR(MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)

		-- Tạo bảng và đổ dữ liệu XML
		BEGIN

			--- Danh sách chi tiết đơn hàng loại bỏ.
			CREATE TABLE #SOP2173_NKC_Ignores
			(
				TransactionID VARCHAR(50)
			)

			IF @IgnoreOrderTransactions IS NOT NULL
			BEGIN
		
				--- INSERT danh sách chi tiết đơn cần loại bỏ.
				INSERT INTO #SOP2173_NKC_Ignores
						(
							TransactionID
						)
				SELECT	X.Data.query('TransactionID').value('.','VARCHAR(50)') AS TransactionID
				FROM @IgnoreOrderTransactions.nodes('//Data') AS X (Data)

			END

		END

		BEGIN
			SET @sSelect = N'
				SELECT ROW_NUMBER() OVER (ORDER BY P.DivisionID, P.OrderNo, P.DeliveryDate
										, P.ObjectID, P.ObjectName, P.DeliveryAddress
									) AS RowNum
					,  COUNT(*) OVER () AS TotalRow
					, P.*
				FROM ( 
			'

			SET @OrderBy = N' ) AS P
				ORDER BY P.DivisionID, P.OrderNo, P.DeliveryDate
						, P.ObjectID, P.ObjectName, P.DeliveryAddress
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
			'
		END
		
		BEGIN
			SET @sSQL1 = N'
				SELECT T1.DivisionID
						, W96.APK AS TransactionID
						, T2.SOrderID
						, O03_MT.[Date] AS DeliveryDate 
						, T11.RouteID AS Route
						, O03.ObjectID
						, T3.ObjectName
						, T11.APK AS DeliveryAddressID
						, O03_MT.Address AS DeliveryAddress
						, O03_MT.Address
						, T2.VoucherNo AS OrderNo
						, T1.InventoryID
						--, O03_MT.Address
						, CASE O03_MT.Quantity 
							WHEN ''Quantity01'' THEN T1.Quantity01
							WHEN ''Quantity02'' THEN T1.Quantity02
							WHEN ''Quantity03'' THEN T1.Quantity03
							WHEN ''Quantity04'' THEN T1.Quantity04
							WHEN ''Quantity05'' THEN T1.Quantity05
							WHEN ''Quantity06'' THEN T1.Quantity06
							WHEN ''Quantity07'' THEN T1.Quantity07
							WHEN ''Quantity08'' THEN T1.Quantity08
							WHEN ''Quantity09'' THEN T1.Quantity09
							WHEN ''Quantity10'' THEN T1.Quantity10
							WHEN ''Quantity11'' THEN T1.Quantity11
							WHEN ''Quantity12'' THEN T1.Quantity12
							WHEN ''Quantity13'' THEN T1.Quantity13
							WHEN ''Quantity14'' THEN T1.Quantity14
							WHEN ''Quantity15'' THEN T1.Quantity15
							WHEN ''Quantity16'' THEN T1.Quantity16
							WHEN ''Quantity17'' THEN T1.Quantity17
							WHEN ''Quantity18'' THEN T1.Quantity18
							WHEN ''Quantity19'' THEN T1.Quantity19
							WHEN ''Quantity20'' THEN T1.Quantity20
							WHEN ''Quantity21'' THEN T1.Quantity21
							WHEN ''Quantity22'' THEN T1.Quantity22
							WHEN ''Quantity23'' THEN T1.Quantity23
							WHEN ''Quantity24'' THEN T1.Quantity24
							WHEN ''Quantity25'' THEN T1.Quantity25
							WHEN ''Quantity26'' THEN T1.Quantity26
							WHEN ''Quantity27'' THEN T1.Quantity27
							WHEN ''Quantity28'' THEN T1.Quantity28
							WHEN ''Quantity29'' THEN T1.Quantity29
							WHEN ''Quantity30'' THEN T1.Quantity30
						ELSE 0 END AS Quantity
						, 0 AS TypeOrder
						, T11.Distance
						, W99.S01ID AS [Length]
						, W99.S02ID AS Width
						, W99.S03ID AS Height
						, W99.S04ID AS Color
				FROM OT2002 T1 WITH (NOLOCK)
				LEFT JOIN OT2001 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.SOrderID = T2.SOrderID
				LEFT JOIN WT0096 W96 WITH (NOLOCK) ON W96.InheritTransactionID = T1.TransactionID 
														AND W96.DivisionID IN (''@@@'', T1.DivisionID) 
														AND T1.InventoryID = W96.InventoryID
				LEFT JOIN WT8899 W99 WITH (NOLOCK) ON W99.TransactionID = W96.TransactionID AND W99.TableID = N''WT0096'' AND W99.VoucherID = W96.VoucherID
				LEFT JOIN WT0095 W95 WITH (NOLOCK) ON W95.VoucherID = W96.VoucherID
				LEFT JOIN OT2003 O03 WITH (NOLOCK) ON T2.SOrderID = O03.SOrderID AND O03.DivisionID IN (''@@@'', T2.DivisionID)
				LEFT JOIN OT2003_MT O03_MT WITH (NOLOCK) ON O03_MT.InheritTransactionID = CONVERT(VARCHAR(50), O03.APK) 
															AND O03_MT.SOrderID = T2.SOrderID -- đang xử lý
															AND CONVERT(VARCHAR(50), W96.APK) = O03_MT.DInheritVoucherID
				LEFT JOIN AT1202 T3 WITH (NOLOCK) ON T3.DivisionID IN (''@@@'', T2.DivisionID) AND T3.ObjectID = O03.ObjectID
				LEFT JOIN CRMT101011 T11 WITH (NOLOCK) ON T11.DivisionID IN (T1.DivisionID, ''@@@'') AND CONVERT(VARCHAR(50), T11.APK) = W95.RDAddressID --AND T11.APKMaster = CONVERT(VARCHAR(50), T3.APK)
				LEFT JOIN #SOP2173_NKC_Ignores T73 ON T73.TransactionID = CONVERT(VARCHAR(50), W96.APK)
				LEFT JOIN SOT2170 T70 WITH (NOLOCK) ON T70.DivisionID = T1.DivisionID '	
															+CASE ISNULL(@VoucherNo, '') WHEN '' THEN ''
															ELSE ' AND T70.VoucherNo != '''+ ISNULL(@VoucherNo, '') + '' 
															END +
														' AND T70.TransactionID = CONVERT(VARCHAR(50), W96.APK)
				LEFT JOIN OOT9000 O90 WITH (NOLOCK) ON CONVERT(VARCHAR(50), O90.APK) = W95.APKMaster_9000
				LEFT JOIN OOT9001 O91 WITH (NOLOCK) ON O91.APKMaster = CONVERT(VARCHAR(50), O90.APK)
				WHERE T2.DivisionID IN (''@@@'', '''+ @DivisionID +''') 
						AND O03_MT.[Date] IS NOT NULL
						AND O03_MT.Address IS NOT NULL
						AND ISNULL(O91.Status, 0) = 1
						AND 
							(
								T70.APK IS NULL
								OR ISNULL(T70.[Status], 0) = 2
							)
						AND T73.TransactionID IS NULL
						AND ISNULL(T2.Status, 0) = 1
			'

			SET @sSQL2 = N'
				UNION ALL
				SELECT T1.DivisionID
							, W96.APK AS TransactionID
							, T2.VoucherID AS SOrderID
							, O03_MT.[Date] AS DeliveryDate 
							, T11.RouteID AS Route
							, O03.ObjectID
							, T3.ObjectName
							, T11.APK AS DeliveryAddressID
							, O03_MT.Address AS DeliveryAddress
							, O03_MT.Address
							, T2.VoucherNo AS OrderNo
							, T1.InventoryID
							--, O03_MT.Address
							, CASE O03_MT.Quantity 
								WHEN ''Quantity01'' THEN T1.Quantity01
								WHEN ''Quantity02'' THEN T1.Quantity02
								WHEN ''Quantity03'' THEN T1.Quantity03
								WHEN ''Quantity04'' THEN T1.Quantity04
								WHEN ''Quantity05'' THEN T1.Quantity05
								WHEN ''Quantity06'' THEN T1.Quantity06
								WHEN ''Quantity07'' THEN T1.Quantity07
								WHEN ''Quantity08'' THEN T1.Quantity08
								WHEN ''Quantity09'' THEN T1.Quantity09
								WHEN ''Quantity10'' THEN T1.Quantity10
								WHEN ''Quantity11'' THEN T1.Quantity11
								WHEN ''Quantity12'' THEN T1.Quantity12
								WHEN ''Quantity13'' THEN T1.Quantity13
								WHEN ''Quantity14'' THEN T1.Quantity14
								WHEN ''Quantity15'' THEN T1.Quantity15
								WHEN ''Quantity16'' THEN T1.Quantity16
								WHEN ''Quantity17'' THEN T1.Quantity17
								WHEN ''Quantity18'' THEN T1.Quantity18
								WHEN ''Quantity19'' THEN T1.Quantity19
								WHEN ''Quantity20'' THEN T1.Quantity20
								WHEN ''Quantity21'' THEN T1.Quantity21
								WHEN ''Quantity22'' THEN T1.Quantity22
								WHEN ''Quantity23'' THEN T1.Quantity23
								WHEN ''Quantity24'' THEN T1.Quantity24
								WHEN ''Quantity25'' THEN T1.Quantity25
								WHEN ''Quantity26'' THEN T1.Quantity26
								WHEN ''Quantity27'' THEN T1.Quantity27
								WHEN ''Quantity28'' THEN T1.Quantity28
								WHEN ''Quantity29'' THEN T1.Quantity29
								WHEN ''Quantity30'' THEN T1.Quantity30
							ELSE 0 END AS Quantity
							, 1 AS TypeOrder
							, T11.Distance
							, W99.S01ID AS [Length]
							, W99.S02ID AS Width
							, W99.S03ID AS Height
							, W99.S04ID AS Color
				FROM SOT2191 T1 WITH (NOLOCK)
				INNER JOIN SOT2190 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.VoucherID = T2.VoucherID
				LEFT JOIN WT0096 W96 WITH (NOLOCK) ON W96.InheritTransactionID = CONVERT(VARCHAR(50), T1.APK) AND W96.DivisionID = T1.DivisionID AND W96.DivisionID = T1.DivisionID AND T1.InventoryID = W96.InventoryID
				LEFT JOIN WT0095 W95 WITH (NOLOCK) ON W95.VoucherID = W96.VoucherID
				LEFT JOIN WT8899 W99 WITH (NOLOCK) ON W99.TransactionID = W96.TransactionID AND W99.TableID = N''WT0096'' AND W99.VoucherID = W96.VoucherID
				LEFT JOIN OT2003 O03 WITH (NOLOCK) ON T2.VoucherID = O03.WarrantyID AND O03.DivisionID = T2.DivisionID
				LEFT JOIN OT2003_MT O03_MT WITH (NOLOCK) ON O03_MT.InheritTransactionID = CONVERT(VARCHAR(50), O03.APK) AND O03_MT.WarrantyID = T2.VoucherID AND CONVERT(VARCHAR(50), W96.APK) = O03_MT.DInheritVoucherID
				LEFT JOIN AT1202 T3 WITH (NOLOCK) ON T3.DivisionID IN (''@@@'', T2.DivisionID) AND T3.ObjectID = O03.ObjectID
				LEFT JOIN CRMT101011 T11 WITH (NOLOCK) ON T11.DivisionID IN (T1.DivisionID, ''@@@'') AND CONVERT(VARCHAR(50), T11.APK) = W95.RDAddressID --AND T11.APKMaster = CONVERT(VARCHAR(50), T3.APK)
				LEFT JOIN SOT2170 T70 WITH (NOLOCK) ON T70.DivisionID = T1.DivisionID '	
															+CASE ISNULL(@VoucherNo, '') WHEN '' THEN ''
															ELSE ' AND T70.VoucherNo != '''+ ISNULL(@VoucherNo, '') + '' 
															END +
														' AND T70.TransactionID = CONVERT(VARCHAR(50), W96.APK)
				LEFT JOIN #SOP2173_NKC_Ignores T73 ON T73.TransactionID = CONVERT(VARCHAR(50), W96.APK)
				LEFT JOIN OOT9000 O90 WITH (NOLOCK) ON CONVERT(VARCHAR(50), O90.APK) = W95.APKMaster_9000
				LEFT JOIN OOT9001 O91 WITH (NOLOCK) ON O91.APKMaster = CONVERT(VARCHAR(50), O90.APK)
				WHERE T2.DivisionID IN (''@@@'', '''+@DivisionID+''')
						AND ISNULL(O91.Status, 0) = 1
						AND O03_MT.[Date] IS NOT NULL
						AND O03_MT.[Address] IS NOT NULL
						AND 
							(
								T70.APK IS NULL
								OR ISNULL(T70.[Status], 0) = 2
							)
						AND T2.VoucherTypeID = N''BH''
						AND T73.TransactionID IS NULL
			'

			SET @sSQL3 = N'
			UNION ALL
			SELECT T1.DivisionID
						, CONVERT(VARCHAR(50), T1.APK) AS [TransactionID]
						, T2.VoucherID AS SOrderID
						, T2.VoucherDate AS DeliveryDate 
						, T11.RouteID AS Route
						, T3.ObjectID
						, T3.ObjectName
						, T11.APK AS DeliveryAddressID
						, T11.DeliveryAddress--O03_MT.Address AS DeliveryAddress
						, T2.Address2 AS Address
						, T2.VoucherNo AS OrderNo
						, T1.InventoryID
						--, O03_MT.Address
						, T1.Quantity
						, 2 AS TypeOrder
						, T11.Distance
						, T1.Long AS [Length]
						, T1.Weight AS Width
						, T1.High AS Height
						, T1.Color
				FROM SOT2191 T1 WITH (NOLOCK)
				INNER JOIN SOT2190 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.VoucherID = T2.VoucherID
				LEFT JOIN AT1202 T3 WITH (NOLOCK) ON T3.DivisionID IN (''@@@'', T2.DivisionID) AND T3.ObjectID = T2.ObjectType
				LEFT JOIN CRMT101011 T11 WITH (NOLOCK) ON T11.DivisionID IN (T1.DivisionID, ''@@@'') AND CONVERT(VARCHAR(50), T11.APK) = T2.AddressID2 --AND T11.APKMaster = CONVERT(VARCHAR(50), T3.APK)
				LEFT JOIN SOT2170 T70 WITH (NOLOCK) ON T70.DivisionID = T1.DivisionID '	
														+CASE ISNULL(@VoucherNo, '') WHEN '' THEN ''
														ELSE ' AND T70.VoucherNo != '''+ ISNULL(@VoucherNo, '') + '' 
														END +
													' AND T70.TransactionID = CONVERT(VARCHAR(50), T1.APK)
				LEFT JOIN #SOP2173_NKC_Ignores T73 ON T73.TransactionID = CONVERT(VARCHAR(50), T1.APK)
				WHERE T2.DivisionID IN (''@@@'', '''+@DivisionID+''')
						AND T2.[VoucherDate] IS NOT NULL 
						AND T11.DeliveryAddress IS NOT NULL
						AND 
							(
								T70.APK IS NULL
								OR ISNULL(T70.[Status], 0) = 2
							)
						AND T2.VoucherTypeID = N''HH''
						AND T73.TransactionID IS NULL
				'
		END
PRINT (@sSelect)
PRINT (@sSQL1)
PRINT (@sSQL2)
PRINT (@sSQL3)
PRINT (@OrderBy)

EXEC (@sSelect + @sSQL1 + @sSQL2 + @sSQL3 + @OrderBy)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO