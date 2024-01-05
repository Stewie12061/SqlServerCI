IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2148]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2148]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Báo cáo định mức dự án - Dữ liệu phiếu báo giá
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 1/11/2019 by Đình Ly
----Modified on 12/04/2020 by Vĩnh Tâm: Bổ sung lấy dữ liệu hệ số của 3 phòng ban NC, KHCU, Sale
----Modified on 02/08/2021 by Văn Tài : Bổ sung lấy thêm Tỷ giá cho các phiếu báo giá Ngoại tệ.
----Modified on 13/06/2022 by Nhựt Trường: Trạng thái hoàn thành thì mới load dữ liệu phiếu báo giá sale.
----Modified on 23/08/2022 by Nhựt Trường: [2022/05/IS/0098] - Bỏ lấy tỷ giá khi tính thành tiền vì đơn giá đã được quy đổi.

CREATE PROCEDURE [dbo].[OOP2148]
(
	@DivisionID VARCHAR(50),
	@ProjectID VARCHAR(MAX)
)
AS
BEGIN
	DECLARE @sign_NC VARCHAR(10) = '.NC'
			, @lv1 VARCHAR(10) = 'LV1'
			, @lv2 VARCHAR(10) = 'LV2'
			, @lv3 VARCHAR(10) = 'LV3'
	DECLARE	@len_Sign_NC int = LEN(@sign_NC)

	-- Cấu trúc bảng chi tiết phiếu báo giá
	DECLARE @QuoteProject AS TABLE (
		STT INT,
		InventoryID VARCHAR(50),
		InventoryName NVARCHAR(250), 
		Origin NVARCHAR(250),
		UnitPrice DECIMAL(28, 8),
		UnitID VARCHAR(50),
		QuoQuantity INT,
		OriginalAmount DECIMAL(28, 8),
		CoefficientNC VARCHAR(10),
		CoefficientKHCU VARCHAR(10),
		CoefficientSale VARCHAR(10),
		Specification NVARCHAR(MAX),
		InventoryTypeID VARCHAR(50),
		TransactionID UNIQUEIDENTIFIER,
		ExchangeRate DECIMAL(28, 8) DEFAULT 0)

	-- Get dữ liệu phiếu báo giá sale và lưu vào bảng tạm
	SELECT ROW_NUMBER() OVER (ORDER BY O2.InventoryID) AS STT
		, O1.QuotationID
		, O2.InheritTransactionID
		, O2.InventoryID
		, A2.InventoryName
		, 'VN' AS Origin
		, O2.UnitPrice
		, O2.UnitID
		, O2.QuoQuantity
		, (O2.UnitPrice * O2.QuoQuantity) AS Amount
		, A2.Specification
		, A1.InventoryTypeID
		, O2.InheritTableID
		, CAST(0 AS VARCHAR(10)) AS CoefficientNC
		, CAST(0 AS VARCHAR(10)) AS CoefficientKHCU
		, CAST(O2.Coefficient AS VARCHAR(10)) AS CoefficientSale
	INTO #tbl_SALE
	FROM OT2101 O1 WITH (NOLOCK)
		INNER JOIN OT2102 O2 WITH (NOLOCK) ON O2.QuotationID = O1.QuotationID
		INNER JOIN OOT2140 O3 WITH (NOLOCK) ON O1.QuotationNo = O3.QuotationID
		INNER JOIN AT1302 A2 WITH (NOLOCK) ON O2.InventoryID = A2.InventoryID
		INNER JOIN AT1301 A1 WITH (NOLOCK) ON A2.InventoryTypeID = A1.InventoryTypeID
	WHERE O3.DivisionID = @DivisionID AND O3.ProjectID = @ProjectID
		-- Lấy phiếu báo giá Sale của dự án
		AND O1.ClassifyID = 'SALE'
		-- Lấy phiếu báo giá Sale có trạng thái là hoàn thành
		AND O1.QuotationStatus = 3

	-- Insert dữ liệu phiếu báo giá vào bảng chính
	INSERT INTO @QuoteProject
	(
		STT
		, InventoryID
		, InventoryName
		, Origin
		, UnitPrice
		, UnitID
		, QuoQuantity
		, OriginalAmount
		, CoefficientNC
		, CoefficientKHCU
		, CoefficientSale
		, Specification
		, InventoryTypeID
		, TransactionID
		, ExchangeRate
	)
	-- Lấy dữ liệu từ phiếu báo giá sale và chuyển thành dữ liệu nội chính
	SELECT M.STT
		, M.InventoryID
		, M.InventoryName
		, M.Origin
		, R02.UnitPrice * R01.ExchangeRate
		, M.UnitID
		, R02.QuoQuantity
		, R01.TotalConvertedAmount AS Amount
		, IIF(R01.ClassifyID = 'NC', CAST(R02.Coefficient AS VARCHAR(10)), '  -  ') AS CoefficientNC
		, IIF(R01.ClassifyID = 'KHCU', CAST(R02.Coefficient AS VARCHAR(10)), '  -  ') AS CoefficientKHCU
		, M.CoefficientSale
		, M.Specification
		, M.InventoryTypeID
		, R02.TransactionID
		, R01.ExchangeRate
	FROM #tbl_SALE M
		INNER JOIN OT2101 R01 WITH (NOLOCK) ON R01.ClassifyID = M.InheritTableID
		INNER JOIN OT2102 R02 WITH (NOLOCK) ON R01.QuotationID = R02.QuotationID 
												AND M.InventoryID = R02.InventoryID 
												AND M.InheritTransactionID = R02.TransactionID
	ORDER BY M.InventoryID
	
	-- Data result
	DECLARE @tableResult TABLE (
		STT VARCHAR(50),
		InventoryID VARCHAR(50),
		Specification NVARCHAR(MAX),
		AccessoryID	VARCHAR(50),
		Desciption NVARCHAR(MAX),
		OriginName NVARCHAR(500),
		QuoQuantity DECIMAL(28,8),
		OriginalAmount DECIMAL(28, 8),
		CoefficientNC VARCHAR(10),
		CoefficientKHCU VARCHAR(10),
		CoefficientSale VARCHAR(10),
		UnitID VARCHAR(50),
		UnitPrice DECIMAL(28,8),
		InventoryTypeID VARCHAR(50),
		[Index] INT IDENTITY(1,1),
		LevelOrder1 VARCHAR(10),
		LevelOrder2 VARCHAR(10),
		LevelDesciption NVARCHAR(MAX),
		TypeOrder VARCHAR(10),
		TypeData INT,
		ExchangeRate DECIMAL(28, 8))

	-- Thêm dữ liệu hiện tại
	INSERT INTO @tableResult
	(
		STT
		, InventoryID
		, UnitPrice
		, QuoQuantity
		, UnitID
		, CoefficientNC
		, CoefficientKHCU
		, CoefficientSale
		, InventoryTypeID
		, TypeOrder
		, ExchangeRate
	)
	SELECT ROW_NUMBER() OVER(ORDER BY InventoryID)
			, InventoryID
			, UnitPrice
			, QuoQuantity
			, UnitID
			, CoefficientNC
			, CoefficientKHCU
			, CoefficientSale
			, InventoryTypeID
			, @lv3
			, ExchangeRate
	FROM @QuoteProject
	WHERE RIGHT(InventoryID, @len_Sign_NC) <> @sign_NC

	-- Thêm dữ liệu thông số kỹ thuật - customeridex = DTI
	INSERT INTO @tableResult(STT, InventoryID,Specification, UnitID, InventoryTypeID)
	SELECT '+' AS STT
			, M.InventoryID
			, ISNULL(M.Specification, R01.Specification)
			, M.UnitID
			, R01.InventoryTypeID
	FROM @QuoteProject M 
		LEFT JOIN AT1302 R01 WITH (NOLOCK) ON M.InventoryID = R01.InventoryID
	WHERE RIGHT(M.InventoryID,@len_Sign_NC) <> @sign_NC 
			AND ISNULL(M.Specification,R01.Specification) IS NOT NULL

	-- Cập nhật mã phân tích (Level chi tiết)
	UPDATE @tableResult
	SET M.Desciption = R01.InventoryName
		, OriginName = CASE WHEN TypeOrder = @lv3 THEN R02_I03.AnaName ELSE '' END
		, LevelOrder1 = R02_I01.AnaID
		, LevelOrder2 = R02_I02.AnaID
		, M.levelDesciption = 
			(CASE WHEN R02_I02.AnaID IS NOT NULL THEN R02_I02.AnaName
				  WHEN R02_I01.AnaID IS NOT NULL THEN R02_I01.AnaName
			END)
	FROM @tableResult M
		LEFT JOIN AT1302 R01 WITH (NOLOCK) ON M.InventoryID = R01.InventoryID
		LEFT JOIN (SELECT AnaID, AnaName FROM AT1015 WITH (NOLOCK) WHERE AnaTypeId= 'I01') R02_I01 ON R01.I01ID = R02_I01.AnaID 
		LEFT JOIN (SELECT AnaID, AnaName FROM AT1015 WITH (NOLOCK) WHERE AnaTypeId= 'I02') R02_I02 ON R01.I02ID = R02_I02.AnaID 
		LEFT JOIN (SELECT AnaID, AnaName FROM AT1015 WITH (NOLOCK) WHERE AnaTypeId= 'I03') R02_I03 ON R01.I03ID = R02_I03.AnaID
	WHERE RIGHT(M.InventoryID, @len_Sign_NC) <> @sign_NC

	-- Set up index row theo Partition
	SELECT ROW_NUMBER() OVER(PARTITION BY LevelOrder1, LevelOrder2 ORDER BY LevelOrder1, LevelOrder2, InventoryID, [Index]) STT_tam
		 , LevelOrder1
		 , LevelOrder2
		 , InventoryID
		 , [Index] INTO #tbl_index
	FROM @tableResult

	-- Thêm dữ liệu chi phí nhân công - customeridex = DTI
	INSERT INTO @tableResult
	(
		STT
		, InventoryID
		, UnitPrice
		, QuoQuantity
		, UnitID
		, InventoryTypeID
		, TypeOrder
	)
	SELECT '+' AS STT
			, M.InventoryID
			, M.UnitPrice
			, M.QuoQuantity
			, M.UnitID
			, R01.InventoryTypeID
			, @lv3
	FROM @QuoteProject M
		LEFT JOIN AT1302 R01 WITH (NOLOCK) ON M.InventoryID = R01.InventoryID
	WHERE RIGHT(M.InventoryID, @len_Sign_NC) = @sign_NC	

	-- Cập nhật dữ liệu xuất xứ - [Desciption]
	UPDATE @tableResult
	SET M.Desciption = R01.InventoryName
		, OriginName = CASE WHEN TypeOrder = @lv3 THEN R02_I03.AnaName ELSE '' END
	FROM @tableResult M 
		LEFT JOIN AT1302 R01 WITH (NOLOCK) ON M.InventoryID = R01.InventoryID
		LEFT JOIN AT1015 R02_I03 WITH (NOLOCK) ON R01.I03ID = R02_I03.AnaID AND R02_I03.AnaTypeId = 'I03'
	WHERE M.[Specification] IS NULL

	-- Cập nhật Mã phân tích cho Mã nhân công (Nếu chưa có)
	UPDATE @tableResult
	SET LevelOrder1 = R01.LevelOrder1
		, LevelOrder2 = R01.LevelOrder2
	FROM @tableResult M
		INNER JOIN (SELECT InventoryID
							, LevelOrder1
							, LevelOrder2
					FROM @tableResult
					WHERE RIGHT(InventoryID,@len_Sign_NC) <> @sign_NC) R01 ON LEFT(M.InventoryID, LEN(M.InventoryID) - @len_Sign_NC) = R01.InventoryID
	WHERE RIGHT(M.InventoryID,@len_Sign_NC) = @sign_NC

	--[DỮ LIỆU CẤP 1]
	SELECT CHAR(64 + (ROW_NUMBER() OVER (ORDER BY LevelOrder1, LevelDesciption))) STT
			, LevelOrder1,LevelDesciption
			, CAST(0 AS DECIMAL(28,8)) AS OriginalAmount
			, @lv1 TypeOrder
	INTO #tbl_LevelOrder1
	FROM @tableResult
	WHERE LevelOrder1 IS NOT NULL
		AND RIGHT(InventoryID, @len_Sign_NC) <> @sign_NC
		AND LevelOrder2 IS NULL
	GROUP BY LevelOrder1, LevelDesciption

	-- Dữ liệu cấp 1 - Cập nhật tổng tiền
	UPDATE #tbl_LevelOrder1
	SET OriginalAmount = R01.OriginalAmount
	FROM #tbl_LevelOrder1 M
		INNER JOIN (SELECT LevelOrder1, SUM(QuoQuantity * UnitPrice * ISNULL(ExchangeRate, 1)) OriginalAmount
					FROM @tableResult
					GROUP BY LevelOrder1) R01 ON M.LevelOrder1 = R01.LevelOrder1

	-- Dữ liệu cấp 2
	SELECT dbo.ToRoman(ROW_NUMBER() OVER (ORDER BY LevelOrder1, LevelOrder2, LevelDesciption)) STT
			, LevelOrder1, LevelOrder2, LevelDesciption, CAST(0 AS DECIMAL(28,8)) AS OriginalAmount
			, @lv2 TypeOrder
	INTO #tbl_LevelOrder2
	FROM @tableResult
	WHERE LevelOrder1 IS NOT NULL
			AND LevelOrder2 IS NOT NULL
			AND RIGHT(InventoryID, @len_Sign_NC) <> @sign_NC
	GROUP BY LevelOrder1, LevelOrder2, LevelDesciption

	-- Dữ liệu cấp 2 - Cập nhật tổng tiền
	UPDATE #tbl_LevelOrder2
	SET OriginalAmount = R01.OriginalAmount
	FROM #tbl_LevelOrder2 M
 		INNER JOIN (SELECT LevelOrder1
							, LevelOrder2
							, SUM(QuoQuantity * UnitPrice) OriginalAmount
					FROM @tableResult
					GROUP BY LevelOrder1, LevelOrder2) R01 ON M.LevelOrder1 = R01.LevelOrder1 AND M.LevelOrder2 = R01.LevelOrder2

	-- Bổ sung dữ liệu vào bảng Lưu kết quả
	INSERT INTO @tableResult
	(
		STT
		, LevelOrder1
		, Desciption
		, OriginalAmount
		, TypeOrder
	)
	SELECT STT
			, LevelOrder1
			, LevelDesciption
			, OriginalAmount
			, TypeOrder
	FROM #tbl_LevelOrder1

	INSERT INTO @tableResult
	(
		STT
		, LevelOrder1
		, LevelOrder2
		, Desciption
		, OriginalAmount
		, TypeOrder
	)
	SELECT STT
			, LevelOrder1
			, LevelOrder2
			, LevelDesciption
			, OriginalAmount
			, TypeOrder
	FROM #tbl_LevelOrder2

	UPDATE @tableResult SET TypeData = '2'

	SELECT TypeOrder, STT, InventoryID
		, CASE
			WHEN Specification IS NULL
				THEN Desciption
			ELSE Specification
		  END AS Desciption
		, OriginName
		, UnitPrice
		, UnitID
		, QuoQuantity
		, CASE
			WHEN TypeOrder = @lv3
				THEN QuoQuantity * UnitPrice
			ELSE OriginalAmount
		  END AS OriginalAmount
		, SUBSTRING(CoefficientNC, 0, 9)
		, SUBSTRING(CoefficientKHCU, 0, 9)
		, SUBSTRING(CoefficientSale, 0, 9)
		, TypeData
	FROM @tableResult
	ORDER BY LevelOrder1, LevelOrder2, InventoryID, [Index]
END	



SET QUOTED_IDENTIFIER OFF


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

