IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2038]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2038]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


--  <Summary>
--		YÊU PHIẾU YÊU CẦU MUA HÀNG - NHƯ PHIẾU BÁO GIÁ STORE SOP20221
--  </Summary>
--	<History>
/*
	----Created by BẢO TOÀN on 11/09/2019 
	----Modified by BẢO TOÀN on 24/06/2020	: Điều chỉnh theo thứ tự dữ liệu theo thứ tự nhập liệu.
	----Modified by Văn Tài  on 01/12/2020	: Format sql, bổ sung lây giá trị OrderIndex để làm STTCaption.

*/
--	</History>
--	<Example>

--	</Example>
CREATE PROC POP2038 
			@DivisionID VARCHAR(50),
			@ROrderID VARCHAR(50),
			@UserID vARCHAR(50) 
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @sign_NC VARCHAR(10) = '.NC',
        @lv1 VARCHAR(10) = 'LV1',
        @lv2 VARCHAR(10) = 'LV2',
        @lv3 VARCHAR(10) = 'LV3',
        @InventoryVirual_lv1 VARCHAR(10) = 'ZZZZZZZZZZ',
        @InventoryVirual_lv2 VARCHAR(10) = 'ZZZZZZZZZY',
        @AutoIndex01 DECIMAL(5, 2) = 0.01,
        @AutoIndex02 DECIMAL(5, 2) = 0.10,
        @Caption_Total NVARCHAR(500) = N'TỔNG',
        @AnaTypeId_A09 VARCHAR(10) = 'A09';

	DECLARE @len_Sign_NC INT = LEN(@sign_NC);
	DECLARE @AmountTotal DECIMAL(28, 8), --[TỔNG TIỀN]
			@ReduceCost DECIMAL(28, 8);  --[TIỀN GIẢM TRỪ]

	-- Bảng chi tiết phiếu báo giá
	DECLARE @tableData TABLE
	(
		APK UNIQUEIDENTIFIER DEFAULT NEWID(),
		APK_QuotationID UNIQUEIDENTIFIER,
		APK_TransactionID UNIQUEIDENTIFIER,
		Specification NVARCHAR(MAX),
		InventoryID VARCHAR(50),
		UnitID VARCHAR(50),
		Quantity DECIMAL(28, 8),  -- Số lượng
		UnitPrice DECIMAL(28, 8), -- Đơn giá					
		InheritTransactionID VARCHAR(50),
		Ana09ID VARCHAR(50),
		Ana10ID VARCHAR(50),
		I03ID VARCHAR(50),
		OrderIndex DECIMAL(20, 5)
	);

	-- Add Data
	INSERT INTO @tableData
	(
		APK_TransactionID,
		InventoryID,
		UnitID,
		Quantity,
		Specification,
		InheritTransactionID,
		Ana09ID,
		Ana10ID,
		I03ID,
		OrderIndex
	)
	SELECT TransactionID,
		   InventoryID,
		   UnitID,
		   OrderQuantity,
		   Specification,
		   InheritTransactionID,
		   Ana09ID,
		   Ana10ID,
		   I03ID,
		   Orders
	FROM OT3102 WITH (NOLOCK)
	WHERE ROrderID = @ROrderID;


	-- Data result
	DECLARE @tableResult TABLE
	(
		STTCaption VARCHAR(50),        --Hiển thị số thứ tự
		InventoryID VARCHAR(50),
		Specification NVARCHAR(MAX),   -- Thông tin kỹ thuật
		AccessoryID VARCHAR(50),       -- Id phụ kiện
		UnitID VARCHAR(50),
		Desciption NVARCHAR(MAX),      -- Nội dung hiển thị
		OriginName NVARCHAR(500),      -- Mã phân tích xuất xứ
		Quantity DECIMAL(28, 8),       -- Số lượng
		UnitPrice DECIMAL(28, 8),
		OriginalAmount DECIMAL(28, 8), -- Thành tiền
		[Index] INT IDENTITY(1, 1),
		LevelOrder1 VARCHAR(10),
		LevelOrder2 VARCHAR(10),
		LevelDesciption NVARCHAR(MAX),
		TypeOrder VARCHAR(10),
		InheritTransactionID VARCHAR(50),
		Ana09ID VARCHAR(50),
		Ana10ID VARCHAR(50),
		I03ID VARCHAR(50),
		OrderIndex DECIMAL(20, 5),
		OrderInsert VARCHAR(50)
	);

	--thêm dữ liệu hiện tại
	INSERT INTO @tableResult
	(
		InventoryID,
		UnitID,
		Quantity,
		UnitPrice,
		TypeOrder,
		InheritTransactionID,
		OrderIndex,
		Ana09ID,
		Ana10ID,
		I03ID
	)
	SELECT InventoryID,
		   UnitID,
		   Quantity,
		   UnitPrice,
		   @lv3,
		   InheritTransactionID,
		   OrderIndex,
		   M.Ana09ID,
		   M.Ana10ID,
		   I03ID
	FROM @tableData M
	WHERE RIGHT(InventoryID, @len_Sign_NC) <> @sign_NC;

	--thêm thông tin kỹ thuật - customeridex = DTI
	INSERT INTO @tableResult
	(
		InventoryID,
		Specification,
		InheritTransactionID,
		OrderIndex,
		Ana09ID,
		Ana10ID,
		I03ID
	)
	SELECT M.InventoryID,
		   ISNULL(M.Specification, R01.Specification),
		   InheritTransactionID,
		   CAST(OrderIndex AS DECIMAL),
		   Ana09ID,
		   Ana10ID,
		   M.I03ID
	FROM @tableData M
		LEFT JOIN AT1302 R01 WITH (NOLOCK)
			ON M.InventoryID = R01.InventoryID
	WHERE RIGHT(M.InventoryID, @len_Sign_NC) <> @sign_NC
		  AND ISNULL(M.Specification, R01.Specification) IS NOT NULL;



	--[CẬP NHẬT MÃ PHÂN TÍCH (LEVEL CHI TIẾT)]	
	UPDATE @tableResult
	SET M.Desciption = R01.InventoryName,
		OriginName = CASE
						 WHEN TypeOrder = @lv3 THEN
							 R02_I03.AnaName
						 ELSE
							 ''
					 END,
		LevelOrder1 = R02_I01.AnaID,
		LevelOrder2 = R02_I02.AnaID
	FROM @tableResult M
		LEFT JOIN AT1302 R01 WITH (NOLOCK)
			ON M.InventoryID = R01.InventoryID
		LEFT JOIN
		(
			SELECT AnaID,
				   AnaName
			FROM AT1011 WITH (NOLOCK)
			WHERE AnaTypeID = 'A09'
		) R02_I01
			ON M.Ana09ID = R02_I01.AnaID
		LEFT JOIN
		(
			SELECT AnaID,
				   AnaName
			FROM AT1011 WITH (NOLOCK)
			WHERE AnaTypeID = 'A10'
		) R02_I02
			ON M.Ana10ID = R02_I02.AnaID
		LEFT JOIN
		(
			SELECT AnaID,
				   AnaName
			FROM AT1015 WITH (NOLOCK)
			WHERE AnaTypeID = 'I03'
		) R02_I03
			ON M.I03ID = R02_I03.AnaID
	WHERE RIGHT(M.InventoryID, @len_Sign_NC) <> @sign_NC;
	
	--[SET UP INDEX ROW THEO PARTITION]	
	SELECT ROW_NUMBER() OVER (PARTITION BY LevelOrder1,
                                       LevelOrder2
                          ORDER BY LevelOrder1,
                                   OrderIndex,
                                   LevelOrder2,
                                   InventoryID,
                                   [Index]
                         ) STT,
       LevelOrder1,
       LevelOrder2,
       InventoryID,
       [Index]
	INTO #tbl_index
	FROM @tableResult M
	WHERE Specification IS NULL;

	UPDATE @tableResult
	SET STTCaption = STT
	FROM @tableResult M
		INNER JOIN #tbl_index R01
			ON M.[Index] = R01.[Index];


	--thêm chi phí nhân công - customeridex = DTI
	INSERT INTO @tableResult
	(
		STTCaption,
		InventoryID,
		UnitID,
		Quantity,
		UnitPrice,
		OrderIndex,
		LevelOrder1,
		LevelOrder2
	)
	SELECT CONVERT(DECIMAL(28, 0), M.OrderIndex),
		   M.InventoryID,
		   M.UnitID,
		   M.Quantity,
		   M.UnitPrice,
		   M.OrderIndex,
		   Ana09ID,
		   Ana10ID
	FROM @tableData M
		LEFT JOIN AT1302 R01 WITH (NOLOCK)
			ON M.InventoryID = R01.InventoryID
	WHERE RIGHT(M.InventoryID, @len_Sign_NC) = @sign_NC;



	--Cập nhật xuất xứ - [Desciption]
	UPDATE @tableResult
	SET M.Desciption = R01.InventoryName,
		OriginName = CASE
						 WHEN TypeOrder = @lv3 THEN
							 R02_I03.AnaName
						 ELSE
							 ''
					 END
	FROM @tableResult M
		LEFT JOIN AT1302 R01 WITH (NOLOCK)
			ON M.InventoryID = R01.InventoryID
		LEFT JOIN AT1015 R02_I03 WITH (NOLOCK)
			ON R01.I03ID = R02_I03.AnaID
			   AND R02_I03.AnaTypeID = 'I03'
	WHERE M.[Specification] IS NULL;

	--[DỮ LIỆU CẤP 1]
	SELECT CHAR(64 + (ROW_NUMBER() OVER (ORDER BY LevelOrder1, LevelDesciption))) STT,
       LevelOrder1,
       LevelDesciption,
       CAST(NULL AS DECIMAL(28, 8)) AS Quantity,
       @InventoryVirual_lv1 InventoryID,
       @lv1 TypeOrder,
       CAST(00.00000 AS DECIMAL(10, 5)) AS OrderIndex
	INTO #tbl_LevelOrder1
	FROM @tableResult
	WHERE LevelOrder1 IS NOT NULL
	--AND RIGHT(InventoryID,@len_Sign_NC) <> @sign_NC		
	GROUP BY LevelOrder1,
			 LevelDesciption;

	--[BỔ SUNG DÒNG DỮ LIỆU TỔNG]
	INSERT INTO @tableResult
	(
		STTCaption,
		LevelOrder1,
		Desciption,
		Quantity,
		TypeOrder
	)
	SELECT STT,
		   LevelOrder1,
		   R02_I01.AnaName,
		   Quantity,
		   TypeOrder
	FROM #tbl_LevelOrder1 M
		LEFT JOIN
		(
			SELECT AnaID,
				   AnaName
			FROM AT1011 WITH (NOLOCK)
			WHERE AnaTypeID = @AnaTypeId_A09
		) R02_I01
			ON M.LevelOrder1 = R02_I01.AnaID;

	--[DỮ LIỆU CẤP 1]-- Cập nhật số lượng
	UPDATE #tbl_LevelOrder1
	SET Quantity = R01.Quantity,
		OrderIndex = R02.OrderIndex + @AutoIndex01
	FROM #tbl_LevelOrder1 M
		INNER JOIN
		(
			SELECT LevelOrder1,
				   SUM(Quantity) Quantity
			FROM @tableResult
			GROUP BY LevelOrder1
		) R01
			ON M.LevelOrder1 = R01.LevelOrder1
		INNER JOIN
		(
			SELECT LevelOrder1,
				   MAX(OrderIndex) OrderIndex
			FROM @tableResult
			GROUP BY LevelOrder1
		) R02
			ON M.LevelOrder1 = R02.LevelOrder1;
	
	--[DỮ LIỆU CẤP 2]
	SELECT dbo.ToRoman(   ROW_NUMBER() OVER (PARTITION BY LevelOrder1
                                         ORDER BY LevelOrder1,
                                                  A.Orders,
                                                  LevelOrder2,
                                                  LevelDesciption
                                        )
                  ) STT,
       LevelOrder1,
       LevelOrder2,
       LevelDesciption,
       CAST(NULL AS DECIMAL(28, 8)) AS Quantity,
       @InventoryVirual_lv2 InventoryID,
       @lv2 TypeOrder,
       CAST(00.00000 AS DECIMAL(10, 5)) AS OrderIndex
	INTO #tbl_LevelOrder2
	FROM @tableResult M
		-- [Toàn] - Bổ sung sắp xếp theo thứ tự nhập.
		LEFT JOIN
		(
			SELECT Ana09ID,
				   Ana10ID,
				   MIN(Orders) Orders
			FROM OT3102 WITH (NOLOCK)
			WHERE ROrderID = @ROrderID
			GROUP BY Ana09ID,
					 Ana10ID
		) A
			ON M.LevelOrder1 = A.Ana09ID
			   AND M.LevelOrder2 = A.Ana10ID
	WHERE LevelOrder1 IS NOT NULL
		  AND LevelOrder2 IS NOT NULL
	--and RIGHT(InventoryID,@len_Sign_NC) <> @sign_NC
	GROUP BY LevelOrder1,
			 A.Orders,
			 LevelOrder2,
			 LevelDesciption;
		
	--[BỔ SUNG DÒNG DỮ LIỆU TỔNG]
	INSERT INTO @tableResult
	(
		STTCaption,
		LevelOrder1,
		LevelOrder2,
		Desciption,
		Quantity,
		TypeOrder
	)
	SELECT STT,
		   LevelOrder1,
		   LevelOrder2,
		   R02_I01.AnaName,
		   Quantity,
		   TypeOrder
	FROM #tbl_LevelOrder2 M
		LEFT JOIN
		(
			SELECT AnaID,
				   AnaName
			FROM AT1011 WITH (NOLOCK)
			WHERE AnaTypeID = 'A10'
		) R02_I01
			ON M.LevelOrder2 = R02_I01.AnaID;

	--[DỮ LIỆU CẤP 2]-- Cập nhật số lượng
	UPDATE #tbl_LevelOrder2
	SET Quantity = R01.Quantity,
		OrderIndex = R02.OrderIndex + @AutoIndex02
	FROM #tbl_LevelOrder2 M
		INNER JOIN
		(
			SELECT LevelOrder1,
				   LevelOrder2,
				   SUM(Quantity) Quantity
			FROM @tableResult
			GROUP BY LevelOrder1,
					 LevelOrder2
		) R01
			ON M.LevelOrder1 = R01.LevelOrder1
			   AND M.LevelOrder2 = R01.LevelOrder2
		INNER JOIN
		(
			SELECT LevelOrder1,
				   LevelOrder2,
				   MAX(OrderIndex) OrderIndex
			FROM @tableResult
			GROUP BY LevelOrder1,
					 LevelOrder2
		) R02
			ON M.LevelOrder1 = R02.LevelOrder1
			   AND M.LevelOrder2 = R02.LevelOrder2;
	
	--[BỔ SUNG DỮ LIỆU VÀO BẢNG LƯU KẾT QUẢ]	
	INSERT INTO @tableResult
	(
		STTCaption,
		LevelOrder1,
		LevelOrder2,
		InventoryID,
		Desciption,
		Quantity,
		TypeOrder,
		OrderIndex
	)
	SELECT STT,
		   LevelOrder1,
		   InventoryID,
		   InventoryID,
		   LevelDesciption,
		   Quantity,
		   TypeOrder,
		   OrderIndex
	FROM #tbl_LevelOrder1;

	INSERT INTO @tableResult
	(
		STTCaption,
		LevelOrder1,
		LevelOrder2,
		InventoryID,
		Desciption,
		Quantity,
		TypeOrder,
		OrderIndex
	)
	SELECT STT,
		   LevelOrder1,
		   LevelOrder2,
		   InventoryID,
		   LevelDesciption,
		   Quantity,
		   TypeOrder,
		   OrderIndex
	FROM #tbl_LevelOrder2;

	-- [Toàn] - Bổ sung sắp xếp theo thứ tự nhập.
	UPDATE @tableResult
	SET OrderInsert = CASE
						  WHEN @InventoryVirual_lv1 = LevelOrder2 THEN
							  @InventoryVirual_lv1
						  ELSE
							  RIGHT('000' + ISNULL(CONVERT(VARCHAR(50), A.Orders), ''), 3) + LevelOrder2
					  END
	FROM @tableResult M
		LEFT JOIN
		(
			SELECT Ana09ID,
				   Ana10ID,
				   MIN(Orders) Orders
			FROM OT3102 WITH (NOLOCK)
			WHERE ROrderID = @ROrderID
			GROUP BY Ana09ID,
					 Ana10ID
		) A
			ON M.LevelOrder1 = A.Ana09ID
			   AND M.LevelOrder2 = A.Ana10ID;
	
	SELECT LevelOrder1,
       OrderInsert,
       LevelOrder2,
       OrderIndex,
       InventoryID,
       [Index],
       TypeOrder,
       STTCaption,
       CASE
           WHEN Specification IS NOT NULL THEN
               ''
           WHEN InventoryID IN ( @InventoryVirual_lv1, @InventoryVirual_lv2 ) THEN
               ''
           ELSE
               InventoryID
       END InventoryIDCaption,
       R01.UnitName AS UnitID,
       Specification,
       AccessoryID,
       CASE
           WHEN InventoryID IN ( @InventoryVirual_lv1, @InventoryVirual_lv2 ) THEN
               @Caption_Total + ' ' + STTCaption
           WHEN Specification IS NULL THEN
               Desciption
           ELSE
               Specification
       END AS Desciption,
       OriginName,
       Quantity,
       UnitPrice,
       CASE
           WHEN TypeOrder NOT IN ( @lv1, @lv2 ) THEN
               Quantity * UnitPrice
           WHEN TypeOrder IS NULL
                AND RIGHT(InventoryID, @len_Sign_NC) = @sign_NC THEN
               Quantity * UnitPrice
           ELSE
               OriginalAmount
       END AS OriginalAmount
	FROM @tableResult M
		LEFT JOIN AT1304 R01
			ON M.UnitID = R01.UnitID
	WHERE ISNULL(Specification, '-') <> ''
	ORDER BY LevelOrder1,
			 OrderInsert,
			 LevelOrder2,
			 OrderIndex,
			 InventoryID,
			 [Index];

	SELECT @AmountTotal AmountTotal,
		   ISNULL(@ReduceCost, 0) DiscountAmount,
		   (ISNULL(@AmountTotal, 0) - ISNULL(@ReduceCost, 0)) AS PacketTotal,
		   0 VAT10;
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
