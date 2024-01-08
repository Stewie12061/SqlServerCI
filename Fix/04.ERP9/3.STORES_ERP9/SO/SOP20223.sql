IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20223]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20223]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






--  <Summary>
--		Báo giá (new) theo mẫu EXCEL
--  </Summary>
--	<History>
/*
	Ngày tạo: 11/09/2019 
		Người tạo: Bảo Toàn
	Modified on 13/05/2020 by Bảo Toàn: Bổ sung trường giảm giá.
	Modified on 26/06/2020 by Bảo Toàn: Hiển thị thêm InventoryCaption + Mapping với báo giá NHÂN CÔNG
	Modified on 09/07/2020 by Bảo Toàn: 
									+ Báo cáo nhân công: Thiếu nhóm hàng và chi tiết nhóm hàng 
									+ Báo cáo chính: thiếu thông tin kĩ thuật.
	Modified on 11/07/2020 by Bảo Toàn:  Fix sai số liệu giữa chi tiết và tổng.
	Modified on 01/10/2020 by Hoài Phong:  Bổ sung cột xuất xứ OriginName
	Modified on 23/10/2020 by Hoài Phong:  Bổ sung isnull cột xuất xứ OriginName
	Modified on 05/07/2021 by Nhựt Trường: Bảng báo giá - Bổ sung cột đơn vị tính (UnitID).
	Modified on 15/07/2021 by Nhựt Trường: Bảng báo giá thiết bị chính - Bổ sung cột tên đơn vị tính (UnitName).
	Modified on 19/07/2021 by Văn Tài	 : Xử lý tính tổng không phân biệt loại tiền. [2021/07/IS/0187]
	Modified on 30/07/2021 by Văn Tài	 : Tách store khi in báo giá SALE.
	Modified on 04/08/2021 by Văn Tài	 : Trường hợp báo giá SALE VND.
*/
--	</History>
--	<Example>
/*	
	SOP20223 'DTI', '9b5883af-54aa-48c3-a0c1-99708a391bc6', 'BAOTOAN'
*/
--	</Example>
CREATE PROC SOP20223 
	@DivisionID varchar(50),
	@APKOT2101 varchar(36),
	@UserID varchar(50),
	@ReportType tinyint = 0 -- 0: Báo giá thiết bị chính; 1: Báo giá nhân công
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @sign_NC VARCHAR(10) = '.NC'
			, @lv1 VARCHAR(10) = 'LV1'
			, @lv2 VARCHAR(10) = 'LV2'
			, @lv3 VARCHAR(10) = 'LV3'
			, @InventoryVirual_lv1 VARCHAR(10) = 'ZZZZZZZZZZ'
			, @InventoryVirual_lv2 VARCHAR(10) = 'ZZZZZZZZZY'
			, @AutoIndex01 DECIMAL(5,2) = 0.01
			, @AutoIndex02 DECIMAL(5,2) = 0.10
			, @Caption_Total NVARCHAR(500) = N'TỔNG'
			, @ClassifyID NVARCHAR(MAX) 
			, @ClassifyID_ISSALE NVARCHAR(MAX)  = 'SALE'
			, @CurrencyID_Default NVARCHAR(50) = 'VND'
			, @PBG_KHCU VARCHAR(50)= 'KHCU'

	DECLARE	@len_Sign_NC INT = LEN(@sign_NC)
	DECLARE @AmountTotal DECIMAL(28,8)	-- [TỔNG TIỀN]
			, @ReduceCost DECIMAL(28,8) -- [TIỀN GIẢM TRỪ]

	
	--[CẬP NHẬT MÃ PHÂN TÍCH (LEVEL CHI TIẾT)]	
	--[XỬ LÝ ĐẶC THÙ CHO BÁO GIÁ SALE]
	SELECT @ClassifyID = ClassifyID 
	FROM OT2101 WITH(NOLOCK) WHERE APK = @APKOT2101

	-- Báo giá SALE.
	IF ISNULL(@ClassifyID, '') = @ClassifyID_ISSALE
	BEGIN
		EXEC SOP20223_SALE
				@DivisionID = @DivisionID,
				@APKOT2101 = @APKOT2101,
				@UserID = @UserID,
				@ReportType = @ReportType
	END
	ELSE
	BEGIN

		--cấu trúc dữ liệu chi tiết phiếu báo giá
		DECLARE @tableData TABLE
							(
								APK UNIQUEIDENTIFIER default newid(),
								APK_QuotationID UNIQUEIDENTIFIER,
								APK_TransactionID UNIQUEIDENTIFIER,
								Specification NVARCHAR(MAX),
								InventoryID VARCHAR(50),
								UnitID VARCHAR(50),
								Quantity DECIMAL(28,8),			-- Số lượng
								UnitPrice DECIMAL(28,8),		-- Đơn giá					
								InheritTransactionID VARCHAR(50), 
								OrderIndex DECIMAL(20,5)
							)

		-- Dòng dữ liệu báo giá. 
		INSERT INTO @tableData
					(
						APK_QuotationID
						, APK_TransactionID
						, InventoryID,UnitID
						, Specification
						, Quantity
						, UnitPrice
						, InheritTransactionID
						, OrderIndex
					)
		SELECT  OT2102.QuotationID
				, TransactionID
				, InventoryID
				, UnitID
				, Specification
				, QuoQuantity
				, CASE WHEN OT2102.Coefficient > 0 
					   THEN UnitPrice * OT2102.Coefficient 
					   ELSE UnitPrice 
					END UnitPrice
				, InheritTransactionID
				, CAST(Orders + 0.00000 AS DECIMAL(20,5))
		FROM OT2102 WITH (NOLOCK)
			INNER JOIN OT2101 WITH (NOLOCK) ON OT2101.DivisionID = OT2102.DivisionID 
												AND  OT2102.QuotationID = OT2101.QuotationID
		WHERE OT2102.DivisionID = @DivisionID
				AND OT2102.QuotationID = @APKOT2101

		--[TÍNH TỔNG GIÁ TRỊ PHIẾU]
		SET @AmountTotal = (SELECT SUM(ISNULL(Quantity, 0) * ISNULL(UnitPrice, 0)) FROM @tableData)

		-- TEST
		PRINT ('@AmountTotal: '  + STR(@AmountTotal))

		--[TIỀN GIẢM TRỪ]
		SET @ReduceCost = (select DiscountAmount from SOT2062 with (nolock) where APK_OT2101 = @APKOT2101)

		DECLARE @tableResult TABLE (
									APK_QuotationID UNIQUEIDENTIFIER,
									STTCaption VARCHAR(50),						--Hiển thị số thứ tự
									InventoryID VARCHAR(50),
									Specification NVARCHAR(MAX),				-- Thông tin kỹ thuật
									AccessoryID	VARCHAR(50),					-- Id phụ kiện
									UnitID VARCHAR(50),
									Desciption NVARCHAR(MAX),					-- Nội dung hiển thị
									OriginName NVARCHAR(500),					-- Mã phân tích xuất xứ
									Quantity DECIMAL(28,8),						-- Số lượng
									UnitPrice DECIMAL(28,8),	
									OriginalAmount DECIMAL(28,8),				-- Thành tiền
									[Index] INT IDENTITY(1,1),
									LevelOrder1 VARCHAR(10),
									LevelOrder2 VARCHAR(10),
									LevelDesciption NVARCHAR(MAX),
									TypeOrder VARCHAR(10),
									InheritTransactionID VARCHAR(50),
									OrderIndex DECIMAL(20,5)
								)

		--thêm dữ liệu hiện tại
		INSERT INTO @tableResult
					(
						APK_QuotationID
						, InventoryID
						, UnitID
						, Quantity
						, UnitPrice
						, TypeOrder
						, InheritTransactionID
						, OrderIndex
					)
		SELECT APK_QuotationID
				, InventoryID
				, UnitID
				, Quantity
				, UnitPrice
				, @lv3
				, InheritTransactionID
				, OrderIndex
		FROM @tableData
		WHERE RIGHT(InventoryID, @len_Sign_NC) <> @sign_NC

		--thêm thông tin kỹ thuật - customeridex = DTI
		INSERT INTO @tableResult
					(
						APK_QuotationID
						, InventoryID
						, Specification
						, InheritTransactionID
						, OrderIndex
					)
		SELECT APK_QuotationID
				, M.InventoryID
				, ISNULL(M.Specification, R01.Specification)
				, InheritTransactionID
				, CAST(OrderIndex AS DECIMAL)
		FROM @tableData M 
			LEFT JOIN AT1302 R01 WITH (NOLOCK) ON M.InventoryID = R01.InventoryID
		WHERE RIGHT(M.InventoryID, @len_Sign_NC) <> @sign_NC 
			AND ISNULL(M.Specification, R01.Specification) IS NOT NULL
	
	
		IF ISNULL(@ClassifyID, '') = @ClassifyID_ISSALE
		BEGIN
			UPDATE @tableResult
			SET APK_QuotationID = R01_R.QuotationID
				, M.Desciption = R01.InventoryName
				, OriginName = CASE WHEN TypeOrder = @lv3 THEN R02_I03.AnaName ELSE ''  END
				, LevelOrder1 = R02_I01.AnaID
				, LevelOrder2 = R02_I02.AnaID			
			FROM @tableResult M 
				LEFT JOIN AT1302 R01 WITH (NOLOCK) ON M.InventoryID = R01.InventoryID
				INNER JOIN OT2102 R01_R WITH (NOLOCK) ON M.InheritTransactionID = R01_R.TransactionID
				LEFT JOIN OT3102 R02 WITH (NOLOCK) ON R01_R.InheritTransactionID = R02.TransactionID
				LEFT JOIN (SELECT AnaID, AnaName FROM AT1011 WITH (NOLOCK) WHERE AnaTypeId= 'A09') R02_I01 ON R02.Ana09ID = R02_I01.AnaID 
				LEFT JOIN (SELECT AnaID, AnaName FROM AT1011 WITH (NOLOCK) WHERE AnaTypeId= 'A10') R02_I02 ON R02.Ana10ID = R02_I02.AnaID 
				LEFT JOIN (SELECT AnaID, AnaName FROM AT1015 WITH (NOLOCK) WHERE AnaTypeId= 'I03') R02_I03 ON R02.I03ID = R02_I03.AnaID
		END
		ELSE 
		BEGIN
			UPDATE @tableResult
			SET M.Desciption = R01.InventoryName
				, OriginName = CASE WHEN TypeOrder = @lv3 THEN R02_I03.AnaName ELSE ''  END
				, LevelOrder1 = R02_I01.AnaID
				, LevelOrder2 = R02_I02.AnaID
			FROM @tableResult M 
				LEFT JOIN AT1302 R01 WITH (NOLOCK) ON M.InventoryID = R01.InventoryID
				LEFT JOIN OT3102 R02 WITH (NOLOCK) ON M.InheritTransactionID = R02.TransactionID
				LEFT JOIN (SELECT AnaID, AnaName FROM AT1011 WITH (NOLOCK) WHERE AnaTypeId= 'A09') R02_I01 ON R02.Ana09ID = R02_I01.AnaID 
				LEFT JOIN (SELECT AnaID, AnaName FROM AT1011 WITH (NOLOCK) WHERE AnaTypeId= 'A10') R02_I02 ON R02.Ana10ID = R02_I02.AnaID 
				LEFT JOIN (SELECT AnaID, AnaName FROM AT1015 WITH (NOLOCK) WHERE AnaTypeId= 'I03') R02_I03 ON R02.I03ID = R02_I03.AnaID
			WHERE RIGHT(M.InventoryID,@len_Sign_NC) <> @sign_NC
		END

		--[SET UP INDEX ROW THEO PARTITION]
		SELECT ROW_NUMBER() OVER (
									PARTITION BY OT2101.ClassifyID, LevelOrder1, LevelOrder2 
									ORDER BY OT2101.ClassifyID, LevelOrder1, OrderIndex, LevelOrder2, InventoryID, [Index]
								 ) STT
				, LevelOrder1
				, LevelOrder2
				, InventoryID
				, [Index]
		INTO #tbl_index
		FROM @tableResult M
				INNER JOIN OT2101 WITH(NOLOCK) ON M.APK_QuotationID = OT2101.QuotationID
		WHERE Specification IS NULL
		ORDER BY LevelOrder1
					, LevelOrder2
					, InventoryID
					, [Index] DESC

		-- Cập nhật STT
		UPDATE @tableResult
		SET STTCaption = STT
		FROM @tableResult M
				INNER JOIN #tbl_index R01 ON M.[Index] = R01.[Index]
		WHERE RIGHT(M.InventoryID, @len_Sign_NC) <> @sign_NC

		--thêm chi phí nhân công - customeridex = DTI
		INSERT INTO @tableResult
					(
						APK_QuotationID,
						InventoryID,
						UnitID,
						Quantity,
						UnitPrice,
						OrderIndex,
						LevelOrder1,
						LevelOrder2
					)
		SELECT CASE WHEN @ClassifyID = @ClassifyID_ISSALE 
					THEN R01_R.QuotationID 
						ELSE APK_QuotationID 
					END APK_QuotationID
				, M.InventoryID
				, M.UnitID
				, M.Quantity
				, M.UnitPrice
				, OrderIndex
				, CASE WHEN @ClassifyID = @ClassifyID_ISSALE 
						THEN R02_SALE.Ana09ID 
						ELSE R02_KHCU_NC.Ana09ID  
					END 
				, CASE WHEN @ClassifyID = @ClassifyID_ISSALE 
						THEN R02_SALE.Ana10ID 
						ELSE  R02_KHCU_NC.Ana10ID  
					END 
		FROM @tableData M 
			LEFT JOIN AT1302 R01 WITH (NOLOCK) ON M.InventoryID = R01.InventoryID
			LEFT JOIN OT2102 R01_R WITH (NOLOCK) ON M.InheritTransactionID = R01_R.TransactionID
			LEFT JOIN OT3102 R02_SALE WITH (NOLOCK) ON R01_R.InheritTransactionID = R02_SALE.TransactionID
			LEFT JOIN OT3102 R02_KHCU_NC WITH (NOLOCK) ON M.InheritTransactionID = R02_KHCU_NC.TransactionID
		WHERE RIGHT(M.InventoryID,@len_Sign_NC) = @sign_NC	


		--Cập nhật xuất xứ - [Desciption]
		UPDATE @tableResult
		SET M.Desciption = R01.InventoryName
			, OriginName = CASE WHEN TypeOrder = @lv3 THEN R02_I03.AnaName ELSE ''  END
		FROM @tableResult M 
			LEFT JOIN AT1302 R01 WITH (NOLOCK) ON M.InventoryID = R01.InventoryID
			LEFT JOIN AT1015 R02_I03 WITH (NOLOCK) ON R01.I03ID = R02_I03.AnaID AND R02_I03.AnaTypeId= 'I03'
		WHERE M.[Specification] IS NULL 
		
		SELECT CHAR(64 + (ROW_NUMBER() OVER (ORDER BY LevelOrder1, LevelDesciption))) STT
				, LevelOrder1,LevelDesciption
				, CAST(NULL AS DECIMAL(28,8)) AS OriginalAmount 
				, @InventoryVirual_lv1 InventoryID
				, @lv1 TypeOrder
				, CAST(00.00000 AS DECIMAL(10,5)) AS OrderIndex
				, APK_QuotationID
		INTO #tbl_LevelOrder1
		FROM @tableResult
		WHERE LevelOrder1 IS NOT NULL
			AND RIGHT(InventoryID,@len_Sign_NC) <> @sign_NC		
			AND APK_QuotationID IS NOT NULL
		GROUP BY APK_QuotationID,LevelOrder1,LevelDesciption	
	
		--[BỔ SUNG DÒNG DỮ LIỆU TỔNG]
		INSERT INTO @tableResult
					(
						STTCaption,
						LevelOrder1,
						Desciption,
						OriginalAmount,
						TypeOrder,
						APK_QuotationID
					)
		SELECT STT
				, LevelOrder1
				, R02_I01.AnaName
				, OriginalAmount
				, TypeOrder
				, APK_QuotationID
		FROM #tbl_LevelOrder1 M
		LEFT JOIN (SELECT AnaID, AnaName FROM AT1011 WITH (NOLOCK) WHERE AnaTypeId= 'A09') R02_I01 ON M.LevelOrder1 = R02_I01.AnaID 
				
		--[DỮ LIỆU CẤP 2]
		SELECT dbo.ToRoman(ROW_NUMBER() OVER (PARTITION BY LevelOrder1 ORDER BY LevelOrder1,LevelOrder2,LevelDesciption)) STT
				, LevelOrder1
				, LevelOrder2
				, LevelDesciption
				, CAST(NULL AS DECIMAL(28,8)) AS OriginalAmount 
				, @InventoryVirual_lv2 InventoryID
				, @lv2 TypeOrder
				, CAST(00.00000 AS DECIMAL(10,5)) AS OrderIndex
				, APK_QuotationID
		INTO #tbl_LevelOrder2
		FROM @tableResult
		WHERE LevelOrder1 IS NOT NULL 
				AND LevelOrder2 IS NOT NULL 
				AND RIGHT(InventoryID,@len_Sign_NC) <> @sign_NC
				AND APK_QuotationID IS NOT NULL
		GROUP BY APK_QuotationID
				, LevelOrder1
				, LevelOrder2
				, LevelDesciption
	
		--[BỔ SUNG DÒNG DỮ LIỆU TỔNG]
		INSERT INTO @tableResult
					(
						STTCaption
						, LevelOrder1
						, LevelOrder2
						, Desciption
						, OriginalAmount
						, TypeOrder
						, APK_QuotationID
					)
		SELECT STT
				, LevelOrder1
				, LevelOrder2
				, R02_I01.AnaName
				, OriginalAmount
				, TypeOrder
				, APK_QuotationID
		FROM #tbl_LevelOrder2 M
			LEFT JOIN (SELECT AnaID, AnaName FROM AT1011 WITH (NOLOCK) WHERE AnaTypeId= 'A10') R02_I01 ON M.LevelOrder2 = R02_I01.AnaID 
	
		-- TEST
		--SELECT 'TEST' TEST, * FROM @tableResult

		--DỮ LIỆU KHÁC KHCU
		SELECT LevelOrder1
			, LevelOrder2
			, OrderIndex
			, InventoryID
			, [Index]
			, TypeOrder
			, STTCaption	
			, CASE WHEN ISNULL(TypeOrder, '') = '' THEN NULL ELSE InventoryID END InventoryCaption
			, OriginName
			, R01.UnitName
			, CASE 
				WHEN InventoryID IN (@InventoryVirual_lv1,@InventoryVirual_lv2) THEN @Caption_Total + ' ' + STTCaption
				WHEN Specification IS NULL THEN Desciption		
				ELSE Specification
				END AS Desciption
			, Quantity
			, UnitPrice
			, CASE
				WHEN TypeOrder NOT IN (@lv1,@lv2) THEN Quantity * UnitPrice 
				WHEN TypeOrder IS NULL AND RIGHT(InventoryID,@len_Sign_NC) = @sign_NC THEN Quantity * UnitPrice 
				ELSE OriginalAmount
			  END OriginalAmount
			, M.UnitID
			, '' AS CurrencyID
		FROM @tableResult M	
			LEFT JOIN AT1304 R01 WITH (NOLOCK) ON M.UnitID = R01.UnitID
			LEFT JOIN OT2101 R02 WITH (NOLOCK) ON M.APK_QuotationID = R02.QuotationID
			LEFT JOIN AT1004 R03 WITH (NOLOCK) ON R02.CurrencyID = R03.CurrencyID
		WHERE 
			R02.ClassifyID <> @PBG_KHCU
			AND ISNULL(
						CASE 
						WHEN InventoryID IN (@InventoryVirual_lv1,@InventoryVirual_lv2) THEN @Caption_Total + ' ' + STTCaption
						WHEN Specification IS NULL THEN Desciption		
						ELSE Specification
						END, ''
					) <> '' 
		ORDER BY LevelOrder1
				, LevelOrder2
				, OrderIndex
				, InventoryID
				, [Index]

		PRINT ('@lv1 ' + @lv1)
		PRINT ('@lv2 ' + @lv2)

		-- DỮ LIỆU LÀ KHCU
		-- LÀ BÁO GIÁ THIẾT BỊ CHÍNH
		IF (@ReportType = 0)
		BEGIN
			SELECT 'TEST' AS TEST,
					  LevelOrder1
					, LevelOrder2
					, OrderIndex
					, InventoryID
					, [Index]
					, TypeOrder
					, STTCaption	
					, ISNULL(OriginName,'')  AS OriginName
					, R01.UnitName
					, CASE WHEN ISNULL(TypeOrder, '') = '' THEN NULL ELSE InventoryID END InventoryCaption		
					, CASE WHEN InventoryID IN (@InventoryVirual_lv1, @InventoryVirual_lv2) THEN @Caption_Total + ' ' + STTCaption
						   WHEN Specification IS NULL THEN Desciption		
						   ELSE Specification
						END AS Desciption
					, Quantity
					, UnitPrice
					, CASE WHEN TypeOrder NOT IN (@lv1, @lv2) THEN Quantity * UnitPrice 
						   WHEN TypeOrder IS NULL AND RIGHT(InventoryID,@len_Sign_NC) = @sign_NC THEN Quantity * UnitPrice 
						   ELSE OriginalAmount
					  END OriginalAmount
					, M.UnitID
			FROM @tableResult M	
				LEFT JOIN AT1304 R01 WITH (NOLOCK) ON M.UnitID = R01.UnitID
				LEFT JOIN OT2101 R02 WITH (NOLOCK) ON M.APK_QuotationID = R02.QuotationID
				LEFT JOIN AT1004 R03 WITH (NOLOCK) ON R02.CurrencyID = R03.CurrencyID
			WHERE R02.ClassifyID = @PBG_KHCU
				AND ISNULL(
							CASE WHEN InventoryID IN (@InventoryVirual_lv1, @InventoryVirual_lv2) THEN @Caption_Total + ' ' + STTCaption
								 WHEN Specification IS NULL THEN Desciption		
								 ELSE Specification
							END, ''
						 ) <> '' 			
			ORDER BY LevelOrder1
					, LevelOrder2
					, OrderIndex
					, InventoryID
					, [Index]

		END
		ELSE
		BEGIN

			-----------------Cập nhật giá trị = NULL nếu là thông tin kỹ thuật----------------		
			UPDATE @tableResult
			SET Quantity = NULL, UnitPrice = NULL
			WHERE ISNULL(Specification,'') <> ''

			--LÀ BÁO GIÁ NHÂN CÔNG
			SELECT    
				  ISNULL(tbl_NotNC.LevelOrder1, tbl_NC.LevelOrder1) LevelOrder1
				, ISNULL(tbl_NotNC.LevelOrder2, tbl_NC.LevelOrder2) LevelOrder2
				, ISNULL(tbl_NotNC.OrderIndex, tbl_NC.OrderIndex) OrderIndex
				, ISNULL(tbl_NotNC.InventoryID, tbl_NC.InventoryID) InventoryID
				, ISNULL(tbl_NotNC.[Index], tbl_NC.[Index]) [Index]
				, ISNULL(tbl_NotNC.TypeOrder, tbl_NC.TypeOrder) TypeOrder
				, ISNULL(tbl_NotNC.STTCaption, tbl_NC.STTCaption) STTCaption
				, ISNULL(tbl_NotNC.InventoryCaption, tbl_NC.InventoryCaption) InventoryCaption
				, ISNULL(tbl_NotNC.OriginName, tbl_NC.OriginName) OriginName
				, ISNULL(tbl_NotNC.UnitName, tbl_NC.UnitName) UnitName
				, ISNULL(tbl_NotNC.Desciption, tbl_NC.Desciption) Desciption
				, ISNULL(tbl_NotNC.Quantity, tbl_NC.Quantity) Quantity
				, tbl_NotNC.UnitPrice
				, tbl_NotNC.OriginalAmount
				, tbl_NC.UnitPrice AS UnitPriceLabor
				, tbl_NC.OriginalAmount AS OriginalAmountLabor
				, CASE 
					WHEN ISNULL(tbl_NC.OriginalAmount, 0) + ISNULL(tbl_NotNC.OriginalAmount, 0) = 0
						THEN NULL 
					ELSE
						ISNULL(tbl_NC.OriginalAmount, 0) + ISNULL(tbl_NotNC.OriginalAmount, 0)
					END TotalAmount
			FROM 
			(
				SELECT LevelOrder1
						, LevelOrder2
						, OrderIndex
						, InventoryID
						, [Index]
						, Specification
						, TypeOrder
						, STTCaption	
						, CASE WHEN ISNULL(TypeOrder, '') = '' THEN NULL ELSE InventoryID END InventoryCaption
						, ISNULL(OriginName,'')  AS OriginName
						, R01.UnitName
						, CASE WHEN InventoryID IN (@InventoryVirual_lv1, @InventoryVirual_lv2) THEN @Caption_Total + ' ' + STTCaption
							   WHEN Specification IS NULL THEN Desciption		
							   ELSE Specification
							END AS Desciption
						, Quantity
						, UnitPrice
						, CASE
							WHEN TypeOrder NOT IN (@lv1, @lv2) THEN Quantity * UnitPrice 
							WHEN TypeOrder IS NULL AND RIGHT(InventoryID, @len_Sign_NC) = @sign_NC THEN Quantity * UnitPrice 
							ELSE OriginalAmount
						  END OriginalAmount	
				FROM @tableResult M	
					LEFT JOIN AT1304 R01 WITH (NOLOCK) ON M.UnitID = R01.UnitID
					LEFT JOIN OT2101 R02 WITH (NOLOCK) ON M.APK_QuotationID = R02.QuotationID
					LEFT JOIN AT1004 R03 WITH (NOLOCK) ON R02.CurrencyID = R03.CurrencyID
				WHERE R02.ClassifyID = @PBG_KHCU
						AND ISNULL(
									CASE 
									WHEN InventoryID IN (@InventoryVirual_lv1,@InventoryVirual_lv2) THEN @Caption_Total + ' ' + STTCaption
									WHEN Specification IS NULL THEN Desciption		
									ELSE Specification
									END, ''
								) <> '' 
					AND RIGHT(ISNULL(M.InventoryID, ''), @len_Sign_NC) <> @sign_NC
			
			) AS tbl_NotNC
			FULL JOIN 
			(
				SELECT LevelOrder1
						, LevelOrder2
						, OrderIndex
						, InventoryID
						, [Index]
						, Specification
						, TypeOrder
						, STTCaption	
						, InventoryID InventoryCaption
						, ISNULL(OriginName, '') AS OriginName
						, R01.UnitName
						, CASE 
								WHEN InventoryID IN (@InventoryVirual_lv1,@InventoryVirual_lv2) THEN @Caption_Total + ' ' + STTCaption
								WHEN Specification IS NULL THEN Desciption		
								ELSE Specification
							END AS Desciption
						, Quantity, UnitPrice
						, CASE
								WHEN TypeOrder NOT IN (@lv1,@lv2) THEN Quantity*UnitPrice 
								WHEN TypeOrder IS NULL AND RIGHT(InventoryID,@len_Sign_NC) = @sign_NC	 THEN Quantity*UnitPrice 
								ELSE OriginalAmount
							END	as OriginalAmount		
				FROM @tableResult M	
					LEFT JOIN AT1304 R01 WITH (NOLOCK) ON M.UnitID = R01.UnitID
					LEFT JOIN OT2101 R02 WITH (NOLOCK) ON M.APK_QuotationID = R02.QuotationID
					LEFT JOIN AT1004 R03 WITH (NOLOCK) ON R02.CurrencyID = R03.CurrencyID
				WHERE 
					R02.ClassifyID = @PBG_KHCU
					AND ISNULL(
								CASE 
								WHEN InventoryID IN (@InventoryVirual_lv1,@InventoryVirual_lv2) THEN @Caption_Total + ' ' + STTCaption
								WHEN Specification IS NULL THEN Desciption		
								ELSE Specification
								END, '') <> '' 
					AND RIGHT(M.InventoryID,@len_Sign_NC) = @sign_NC
					AND ISNULL(M.Specification, '') = ''
			) AS tbl_NC 
			ON ISNULL(tbl_NotNC.InventoryID, '') + @sign_NC = ISNULL(tbl_NC.InventoryID, '')
				AND tbl_NotNC.LevelOrder1 = tbl_NC.LevelOrder1
				AND isnull(tbl_NotNC.LevelOrder2,'') = isnull(tbl_NC.LevelOrder2,'')
				AND ISNULL(tbl_NotNC.Specification,'') = ''
				AND tbl_NotNC.Quantity = tbl_NC.Quantity
				AND tbl_NotNC.OrderIndex + 1 = tbl_NC.OrderIndex		
			ORDER BY LevelOrder1
					, LevelOrder2
					, OrderIndex
					, tbl_NotNC.InventoryID
					, [Index]
			END

		print ('@CurrencyID_Default: ' + @CurrencyID_Default)

		-- TEST
		--SELECT 'TESTA' AS A,  R02.CurrencyID
		--				, AVG(R02.ExchangeRate) ExchangeRate
		--				, SUM(M.Quantity) Quantity
		--				, SUM(Quantity * UnitPrice) OriginalAmount
		--		FROM @tableResult M	
		--			LEFT JOIN OT2101 R02 WITH (NOLOCK) ON M.APK_QuotationID = R02.QuotationID			
		--			LEFT JOIN AT1004 R03 WITH (NOLOCK) ON R02.CurrencyID = R03.CurrencyID
		--		--WHERE R03.CurrencyID <> @CurrencyID_Default		
		--		GROUP BY R02.CurrencyID

	
		--TABLE DỮ LIỆU TỔNG
		SELECT T3.QuotationDate	
				, CASE WHEN T1.CurrencyID IS NOT NULL 
				   THEN T1.CurrencyID 
				   ELSE T2.CurrencyID 
					END AS CurrencyID
				, CASE WHEN T1.CurrencyID IS NOT NULL 
					   THEN T1.ExchangeRate 
					   ELSE T2.ExchangeRate 
					END AS ExchangeRate
				, CASE WHEN T1.CurrencyID IS NOT NULL 
					   THEN T1.Quantity 
					   ELSE T2.Quantity 
					END AS Quantity
				, CASE WHEN T1.CurrencyID IS NOT NULL 
					   THEN T1.OriginalAmount
					   ELSE T2.OriginalAmount
					END OriginalAmount
				, CASE WHEN T1.CurrencyID IS NOT NULL 
					   THEN T1.ExchangeRate * T1.OriginalAmount 
					   ELSE T2.ExchangeRate * T2.OriginalAmount 
					END AS ConvertAmount
				, T2.Quantity Quantity_Default
				, T2.OriginalAmount OriginalAmount_Default
				, T4.DiscountAmount
				, ISNULL(T1.ExchangeRate * T1.OriginalAmount, 0) 
					+ ISNULL(T2.OriginalAmount,0) 
					- ISNULL(T4.DiscountAmount,0) 
				  AS OriginalAmountTolal
		FROM (
				SELECT R02.CurrencyID
						, AVG(R02.ExchangeRate) ExchangeRate
						, SUM(M.Quantity) Quantity
						, SUM(Quantity * UnitPrice) OriginalAmount
				FROM @tableResult M	
					LEFT JOIN OT2101 R02 WITH (NOLOCK) ON M.APK_QuotationID = R02.QuotationID			
					LEFT JOIN AT1004 R03 WITH (NOLOCK) ON R02.CurrencyID = R03.CurrencyID
				WHERE R03.CurrencyID <> @CurrencyID_Default		
				GROUP BY R02.CurrencyID
		) AS T1
		FULL JOIN (
					SELECT R02.CurrencyID
							, AVG(R02.ExchangeRate) ExchangeRate
							, SUM(M.Quantity) Quantity
							, SUM(Quantity*UnitPrice) OriginalAmount
					FROM @tableResult M	
						LEFT JOIN OT2101 R02 WITH (NOLOCK) ON M.APK_QuotationID = R02.QuotationID
						LEFT JOIN AT1004 R03 WITH (NOLOCK) ON R02.CurrencyID = R03.CurrencyID
					WHERE R03.CurrencyID = @CurrencyID_Default			
					GROUP BY R02.CurrencyID
		) AS T2 ON  1 = 1
		FULL JOIN (
					SELECT M.QuotationDate
					FROM OT2101 M WITH (NOLOCK) 
					WHERE M.QuotationID = @APKOT2101 
							AND 1 = 0
		) AS T3 ON  1 = 1
		FULL JOIN (
					SELECT M.DiscountAmount
					FROM SOT2062 M WITH (NOLOCK) 
					WHERE M.APK_OT2101 = @APKOT2101		
		) AS T4 ON  1 = 1

	END
END





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
