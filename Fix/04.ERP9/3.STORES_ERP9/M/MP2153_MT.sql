IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2153_MT]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2153_MT]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Tính dự trù customize khách hàng MAITHU
-- <Param> listAPK
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Đức Tuyên Date: 28/11/2022

Create PROCEDURE [dbo].[MP2153_MT]
(
    @DivisionID VARCHAR(50),
	@APK_SOT2080 VARCHAR(50) = '',
	@MOrderID VARCHAR(MAX) = '',
	@ProductID VARCHAR(50) = '',
	@ProductQuantity DECIMAL(28,8) = 0,
	@APK_BomVersion VARCHAR(50) = '',
	@APK_OT2202 VARCHAR(50) = ''
)
AS

--- Bảng dữ liệu để chưa danh sách TP or BTP, NVL Tab tính dự trù
BEGIN
	CREATE TABLE #MP2153_RESULTS
	(
		VoucherNo VARCHAR(50) NULL
		, ProductID VARCHAR(50) NULL
		, SemiProduct VARCHAR(50) NULL
		, S01ID VARCHAR(50) NULL
		, S02ID VARCHAR(50) NULL
		, S03ID VARCHAR(50) NULL
		, MaterialID VARCHAR(50) NULL
		, MaterialName NVARCHAR(250) NULL
		, UnitID VARCHAR(50) NULL
		, UnitName NVARCHAR(250) NULL
		, Quantity DECIMAL(28,8) NULL
		, Specification NVARCHAR(MAX) NULL

		, APKNode VARCHAR(50) NULL
		, NodeID VARCHAR(50) NULL
		, NodeTypeID VARCHAR(50) NULL
		, NodeLevel INT NULL
		, NodeParent VARCHAR(50) NULL
		, NodeOrder INT NULL
		, OutsourceID VARCHAR(50) NULL
		, DictatesID VARCHAR(50) NULL
		, DisplayName NVARCHAR(500) NULL
		, QuantitativeTypeID VARCHAR(50) NULL
		, RoutingID VARCHAR(50) NULL
		, PhaseID VARCHAR(50) NULL
		, LossValue DECIMAL(28,8) NULL
		, AmountLoss DECIMAL(28,8) NULL
		, InventoryID VARCHAR(50) NULL
		, MaterialGroupID VARCHAR(50) NULL
		, MaterialIDChange VARCHAR(50) NULL
		, MaterialNameChange NVARCHAR(250) NULL
		, MaterialConstant VARCHAR(50) NULL

		, QuantitativeValue DECIMAL(28,8) NULL
		, APK_OT2202 VARCHAR(50) NULL
	);
END

--- Bảng dữ liệu để chưa danh sách BTP truyền vào
BEGIN
	CREATE TABLE #MP2153_SEMI_PRODUCTS
	(
		DivisionID			VARCHAR(50) NULL
		, APK_SOT2081		VARCHAR(50) NULL
		, SemiProduct		VARCHAR(50) NULL
		, SemiProductName	NVARCHAR(250) NULL
		, [Length]			VARCHAR(50) NULL
		, [Width]			VARCHAR(50) NULL
		, [Height]			VARCHAR(50) NULL
		, ActualQuantity	DECIMAL(28,8) NULL
		, PercentLoss		DECIMAL(28,8) NULL
		, AmountLoss		DECIMAL(28,8) NULL
		, OffsetQuantity	DECIMAL(28,8) NULL
		, Orders			INT NULL
	)
END

--- Đổ dữ liệu vào bảng tạm BTP.
BEGIN
	INSERT INTO #MP2153_SEMI_PRODUCTS 
	(
		DivisionID
		, APK_SOT2081
		, SemiProduct
		, SemiProductName	
		, [Length]	
		, [Width]
		, [Height]
		, ActualQuantity
		, PercentLoss
		, AmountLoss
		, OffsetQuantity
		, Orders
	)
	SELECT 
		ST81.DivisionID
		, ST81.APK
		, ST81.SemiProduct
		, AT02.InventoryName
		, ST81.[Length]
		, ST81.[Width]
		, ST81.[Height]
		, ST81.ActualQuantity
		, ST81.PercentLoss
		, ST81.AmountLoss
		, ST81.OffsetQuantity
		, ST81.Orders
	FROM SOT2081 ST81 WITH (NOLOCK)
	LEFT JOIN AT1302 AT02 WITH (NOLOCK) ON AT02.DivisionID IN ('@@@', @DivisionID)
										AND AT02.InventoryID = ST81.SemiProduct
	LEFT JOIN MT2123 MT23 WITH (NOLOCK) ON MT23.DivisionID = ST81.DivisionID
										AND MT23.APK_2120 = @APK_BomVersion
										AND MT23.NodeID = ST81.SemiProduct
	-- Loại bỏ TP/ BTP chỉ có NVL đã gia công--
	OUTER APPLY(
		SELECT TOP 1 MT231.NodeID 
		FROM MT2123 MT231 WITH(NOLOCK) 
		WHERE MT231.NodeParent = MT23.APK 
				AND ISNULL(MT231.OutsourceID, '0') <> '1'
				AND ISNULL(MT231.NodeTypeID, '2') = '2'
	) AS A1
	WHERE	ST81.DivisionID = @DivisionID
			AND CONVERT(VARCHAR(50), ST81.APKMaster) = @APK_SOT2080 
			AND ISNULL(A1.NodeID, '') <> ''
	ORDER BY ST81.Orders
END

--SELECT *FROM #MP2153_SEMI_PRODUCTS

--- Đổ dữ liệu bộ BTP đã tính toán ở dự toán vào.
BEGIN
	DECLARE @rowAPK_SOT2081 VARCHAR(50) = NULL;
	DECLARE @rowSemiProduct	VARCHAR(50) = NULL;
	--- Chạy từng dòng BTP.
	WHILE EXISTS(SELECT TOP 1 1 FROM #MP2153_SEMI_PRODUCTS)
	BEGIN    
		SET @rowAPK_SOT2081	= NULL;
		SET @rowSemiProduct = NULL;

		-- Lấy key dòng
		SELECT TOP 1 @rowAPK_SOT2081 = APK_SOT2081, @rowSemiProduct = SemiProduct FROM #MP2153_SEMI_PRODUCTS  ORDER BY Orders;
		
		PRINT 'BTP => APK_SOT2081:' + CAST(@rowAPK_SOT2081 AS VARCHAR(50))

		-- Xử lý đổ dữ liệu BTP: SOT2080
		BEGIN
			INSERT INTO #MP2153_RESULTS
			(
				VoucherNo
				, ProductID
				, SemiProduct
				, S01ID
				, S02ID
				, S03ID
				, MaterialID
				, MaterialName
				, UnitID
				, UnitName
				, Quantity
				, Specification

				, APKNode
				, NodeID
				, NodeTypeID
				, NodeLevel
				, NodeParent
				, NodeOrder
				, OutsourceID
				, DictatesID
				, DisplayName
				, QuantitativeTypeID
				, RoutingID
				, PhaseID
				, LossValue
				, AmountLoss
				, InventoryID
				, MaterialGroupID
				, MaterialIDChange
				, MaterialNameChange
				, MaterialConstant

				, QuantitativeValue
				, APK_OT2202
			)
			SELECT TOP 1
				@MOrderID
				, @ProductID
				, MP53_SEMI.SemiProduct
				, MP53_SEMI.Length
				, MP53_SEMI.Width
				, MP53_SEMI.Height
				, MP53_SEMI.SemiProduct AS MaterialID
				, MP53_SEMI.SemiProductName AS MaterialName
				, A2.UnitID
				, A4.UnitName
				, MP53_SEMI.OffsetQuantity AS Quantity
				, A2.Specification

				, MT23.APK
				, MT23.NodeID
				, MT23.NodeTypeID
				, MT23.NodeLevel
				, MT23.NodeParent
				, MT23.NodeOrder
				, MT23.OutsourceID
				, MT23.DictatesID
				, MT23.DisplayName
				, MT23.QuantitativeTypeID 
				, MT22.RoutingID
				, MT23.PhaseID
				, MP53_SEMI.PercentLoss AS LossValue
				, MP53_SEMI.AmountLoss AS AmountLoss
				, @ProductID AS InventoryID
				, MT23.MaterialGroupID
				, MT23.MaterialID AS MaterialIDChange
				, A2.InventoryName AS MaterialNameChange
				, MT23.MaterialConstant

				, MP53_SEMI.OffsetQuantity AS QuantitativeValue
				, @APK_OT2202
				--, A1.NodeID
			FROM #MP2153_SEMI_PRODUCTS MP53_SEMI WITH (NOLOCK)
				LEFT JOIN AT1302 A2 WITH (NOLOCK) ON A2.DivisionID IN ('@@@', MP53_SEMI.DivisionID)
													AND A2.InventoryID = MP53_SEMI.SemiProduct
				LEFT JOIN AT1304 A4 WITH (NOLOCK) ON A2.DivisionID IN ('@@@', MP53_SEMI.DivisionID)
													AND A2.UnitID = A4.UnitID
				LEFT JOIN MT2122 MT22 WITH (NOLOCK) ON MT22.DivisionID = MP53_SEMI.DivisionID
													AND MT22.APK = @APK_BomVersion
				LEFT JOIN MT2123 MT23 WITH (NOLOCK) ON MT23.DivisionID = MP53_SEMI.DivisionID
													AND MT23.APK_2120 = MT22.APK
													AND MT23.NodeID = MP53_SEMI.SemiProduct
			WHERE MP53_SEMI.APK_SOT2081 = @rowAPK_SOT2081
		END

		-- Xử lý đổ dữ liệu NVL: SOT2082
		BEGIN
			INSERT INTO #MP2153_RESULTS
			(
				VoucherNo
				, ProductID
				, SemiProduct
				, S01ID
				, S02ID
				, S03ID
				, MaterialID
				, MaterialName
				, UnitID
				, UnitName
				, Quantity
				, Specification

				, APKNode
				, NodeID
				, NodeTypeID
				, NodeLevel
				, NodeParent
				, NodeOrder
				, OutsourceID
				, DictatesID
				, DisplayName
				, QuantitativeTypeID
				, RoutingID
				, PhaseID
				, LossValue
				, AmountLoss
				, InventoryID
				, MaterialGroupID
				, MaterialIDChange
				, MaterialNameChange
				, MaterialConstant

				, QuantitativeValue
				, APK_OT2202
			)
			SELECT
				@MOrderID
				, @ProductID
				, '' AS SemiProduct
				, '' AS Length
				, '' AS Width
				, '' AS Height
				, ST82.MaterialID AS MaterialID
				, A2.InventoryName AS MaterialName
				, A2.UnitID
				, A4.UnitName
				, ST82.Quantity AS Quantity
				, A2.Specification

				, MT23.APK
				, MT23.NodeID
				, MT23.NodeTypeID
				, MT23.NodeLevel
				, MT23.NodeParent
				, MT23.NodeOrder 
				, MT23.OutsourceID
				, MT23.DictatesID
				, MT23.DisplayName
				, MT23.QuantitativeTypeID 
				, MT22.RoutingID
				, MT23.PhaseID
				, ST82.PercentLoss AS LossValue
				, ST82.AmountLoss AS AmountLoss
				, @ProductID AS InventoryID
				, MT23.MaterialGroupID
				, MT23.MaterialID AS MaterialIDChange
				, A2.InventoryName AS MaterialNameChange
				, MT23.MaterialConstant

				, ST82.Quantity AS QuantitativeValue
				, @APK_OT2202

			FROM SOT2082 ST82 WITH (NOLOCK)
				LEFT JOIN AT1302 A2 WITH (NOLOCK) ON A2.DivisionID IN ('@@@', ST82.DivisionID)
													AND A2.InventoryID = ST82.MaterialID
				LEFT JOIN AT1304 A4 WITH (NOLOCK) ON A2.DivisionID IN ('@@@', ST82.DivisionID)
													AND A2.UnitID = A4.UnitID
				LEFT JOIN MT2122 MT22 WITH (NOLOCK) ON MT22.DivisionID = ST82.DivisionID
													AND MT22.APK = @APK_BomVersion
				LEFT JOIN MT2123 MT23 WITH (NOLOCK) ON MT23.DivisionID = ST82.DivisionID
													AND MT23.APK_2120 = MT22.APK
													AND MT23.NodeID = ST82.MaterialID
													AND MT23.DisplayName = ST82.DisplayName
													AND MT23.NodeParent = (SELECT TOP 1 MT232.APK FROM MT2123 MT232 WITH (NOLOCK) WHERE MT232.APK_2120 = @APK_BomVersion AND MT232.NodeID = @rowSemiProduct )
			WHERE	ST82.DivisionID = @DivisionID
					AND ST82.APK_SOT2081 = @rowAPK_SOT2081
			ORDER BY MT23.NodeOrder
		END

		--- Xóa dòng dữ liệu.
		DELETE #MP2153_SEMI_PRODUCTS WHERE APK_SOT2081 = @rowAPK_SOT2081
	END
END

--- Hoàn tất dữ liệu tính dự trù Tab OT2202
	SELECT *FROM #MP2153_RESULTS ORDER BY NodeOrder

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
