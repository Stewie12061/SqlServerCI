IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2089]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[SOP2089]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load thông tin nguyên vật liệu từ Đơn hàng bán và Dự toán.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Văn Tài on 12/07/2023
----Modify	by Văn Tài	on 12/04/2023 : 
----Modify by: Đức Tuyên on: 25/07/2023: Xử lý nghiệp vụ thông tin sản xuất(MAITHU)
-- <Example>
---- 
/*-- <Example>
    SOP2089 @DivisionID = 'MT', @UserID='ASOFTADMIN',@TranMonth='6',@TranYear='2021',@InsVoucherTypeID='PXK',@APKMaster_9000='94008DF8-FB91-41ED-901D-DE6E4D65CC1D'

	Node:
	- Hiện tại chỉ có mode 1 để xử lý cho MAITHU luồng kế thừa: Đơn hàng bán / Báo giá / Dự toán / Yêu cầu khách hàng.

	- Dự toán: Estimate
	- Báo giá: Quotation
*/

CREATE PROCEDURE [dbo].[SOP2089]
( 
     @DivisionID VARCHAR(50),
     @UserID VARCHAR(50),
	 @TranMonth	AS INT,
	 @TranYear	AS INT,
	 @SOrderID	VARCHAR(50),
	 @ProductID VARCHAR(50),
	 @BOMVersion AS INT = 0,
	 @APK_BomVersion VARCHAR(50) = '',
	 @Mode AS INT = 1,			--- Mode: 1 --- Đơn hàng bán -> Lấy về dự toán để rã NVL.
								--- Mode: 2 --- Thông tin sản xuất cũ.
	 @SemiProductList AS XML = NULL
)
AS 
BEGIN
	
	DECLARE @InventoryID VARCHAR(50) = NULL; --- Thành phẩm của bộ định mức.

	DECLARE @APK_MT2122 VARCHAR(50) = NULL;
	DECLARE @APK_MT2120 VARCHAR(50) = NULL;
	DECLARE @Version	VARCHAR(50) = NULL;
	DECLARE @APKMInherited	VARCHAR(50) = NULL;

	--- Bảng dữ liệu để chưa danh sách BTP truyền vào
	CREATE TABLE #SOP2089_SEMI_PRODUCTS
	(
		ID				VARCHAR(50) NULL,
		SemiOrders		INT NULL,
		APK_SOT2081		VARCHAR(50) NULL,
		VoucherID		VARCHAR(50) NULL,
		VoucherNo		VARCHAR(50) NULL,
		ProductID		VARCHAR(50) NULL,
		BOMVersion		INT NULL,
		APK_BomVersion	VARCHAR(50) NULL,
		NodeTypeID		INT NULL,			--- 0: TP, 1: BTP, 2: NVL.
		SemiProduct		VARCHAR(50) NULL,
		APKMInherited	VARCHAR(50) NULL,
		APKDInherited	VARCHAR(50) NULL
	)

	--- Bảng dữ liệu kết quả
	BEGIN

		CREATE TABLE #SOP2089_RESULTS
		(
			Orders				INT IDENTITY(1, 1)
			, PhaseID			VARCHAR(50)		NULL
			, APK_SOT2081			VARCHAR(50)		NULL
			, ProductID			VARCHAR(50)		NULL
			, SemiProduct		VARCHAR(50)		NULL
			, NodeTypeID		VARCHAR(50)		NULL
			, APKNodeParent		VARCHAR(50)		NULL
			, KindSuppliers		NVARCHAR(50)	NULL
			, MaterialID		NVARCHAR(50)	NULL
			, UnitID			NVARCHAR(50)	NULL
			, Quantity			DECIMAL(28, 8)		NULL
			, UnitPrice			DECIMAL(28, 8)		NULL
			, Amount			DECIMAL(28, 8)		NULL
			, PhaseOrder		INT				NULL
			, DisplayName		NVARCHAR(500)	NULL
			, QuantityRunWave	DECIMAL(28, 8)		NULL
			, UnitSizeID		VARCHAR(25)		NULL
			, Size				DECIMAL(28, 8)		NULL
			, Cut				DECIMAL(28, 8)		NULL
			, Child				DECIMAL(28, 8)		NULL
			, PrintTypeID		VARCHAR(25)		NULL
			, RunPaperID		VARCHAR(25)		NULL
			, RunWavePaper		VARCHAR(25)		NULL
			, SplitSheets		DECIMAL(28, 8)		NULL
			, MoldID			VARCHAR(25)		NULL
			, MoldStatusID		VARCHAR(25)		NULL
			, MoldDate			DATETIME		NULL
			, Gsm				DECIMAL(28, 8)		NULL
			, Sheets			DECIMAL(28, 8)		NULL
			, Ram				DECIMAL(28, 8)		NULL
			, Kg				DECIMAL(28, 8)		NULL
			, M2				DECIMAL(28, 8)		NULL
			, AmountLoss		DECIMAL(28, 8)		NULL
			, PercentLoss		DECIMAL(28, 8)		NULL
			, S01ID				NVARCHAR(50)	NULL
			, S02ID				NVARCHAR(50)	NULL
			, S03ID				NVARCHAR(50)	NULL
			, S04ID				NVARCHAR(50)	NULL
			, S05ID				NVARCHAR(50)	NULL
			, S06ID				NVARCHAR(50)	NULL
			, S07ID				NVARCHAR(50)	NULL
			, S08ID				NVARCHAR(50)	NULL
			, S09ID				NVARCHAR(50)	NULL
			, S10ID				NVARCHAR(50)	NULL
			, S11ID				NVARCHAR(50)	NULL
			, S12ID				NVARCHAR(50)	NULL
			, S13ID				NVARCHAR(50)	NULL
			, S14ID				NVARCHAR(50)	NULL
			, S15ID				NVARCHAR(50)	NULL
			, S16ID				NVARCHAR(50)	NULL
			, S17ID				NVARCHAR(50)	NULL
			, S18ID				NVARCHAR(50)	NULL
			, S19ID				NVARCHAR(50)	NULL
			, S20ID				NVARCHAR(50)	NULL
			, GluingTypeID		VARCHAR(25)		NULL
			, GluingTypeName	VARCHAR(250)	NULL
			, KindOfSuppliersID	NVARCHAR(50)	NULL
			, InventoryID		NVARCHAR(50)	NULL
			, InventoryName		NVARCHAR(250)	NULL
		)

	END

	--- Đơn hàng bán
	IF (@Mode = 1)
	BEGIN
		
		--- Đổ dữ liệu vào bảng tạm.
		INSERT INTO #SOP2089_SEMI_PRODUCTS 
			(
			  ID
			, SemiOrders
			, APK_SOT2081	

			--- Chứng từ Dự toán liên quan.
			, VoucherID	
			, VoucherNo

			--- Thông tin BTP.
			, ProductID
			, BOMVersion
			, APK_BomVersion	
			, NodeTypeID
			, SemiProduct

			, APKMInherited	--- Yêu cầu khách hàng.
			, APKDInherited	--- MT2123 - BOM Version.
			)
		SELECT	NEWID() AS ID,
				X.Data.query('SemiOrders').value('.','INT')					AS SemiOrders,
				X.Data.query('APK_SOT2081').value('.','VARCHAR(50)')		AS APK_SOT2081,
				X.Data.query('VoucherID').value('.','VARCHAR(50)')			AS VoucherID,
				X.Data.query('VoucherNo').value('.','VARCHAR(250)')			AS VoucherNo,
				X.Data.query('ProductID').value('.','VARCHAR(50)')			AS ProductID,
				X.Data.query('BOMVersion').value('.','INT')					AS BOMVersion,
				X.Data.query('APK_BomVersion').value('.','VARCHAR(50)')		AS APK_BomVersion,
				1															AS NodeTypeID,
				X.Data.query('SemiProduct').value('.','VARCHAR(50)')		AS SemiProduct,
				X.Data.query('APKMInherited').value('.','VARCHAR(50)')		AS APKMInherited,
				X.Data.query('APKDInherited').value('.','VARCHAR(50)')		AS APKDInherited
		FROM @SemiProductList.nodes('//Data') AS X (Data)

		PRINT (N'Kết thúc insert vào bảng tạm #SOP2089_SEMI_PRODUCTS')

		--- Phải đổ vào thông tin thành phẩm trước.
		--- Dựa vào bộ BOM.
		--BEGIN
		--	INSERT INTO #SOP2089_RESULTS
		--		(
		--			PhaseID				
		--			, NodeTypeID		
		--			, APKNodeParent		
		--			, KindSuppliers		
		--			, MaterialID		
		--			, UnitID			
		--			, Quantity			
		--			, UnitPrice			
		--			, Amount			
		--			, PhaseOrder		
		--			, DisplayName		
		--			, QuantityRunWave	
		--			, UnitSizeID		
		--			, Size				
		--			, Cut				
		--			, Child				
		--			, PrintTypeID		
		--			, RunPaperID		
		--			, RunWavePaper		
		--			, SplitSheets		
		--			, MoldID			
		--			, MoldStatusID		
		--			, MoldDate			
		--			, Gsm				
		--			, Sheets			
		--			, Ram				
		--			, Kg				
		--			, M2				
		--			, AmountLoss		
		--			, PercentLoss		
		--			, S01ID, S02ID, S03ID, S04ID, S05ID
		--			, S06ID, S07ID, S08ID, S09ID, S10ID
		--			, S11ID, S12ID, S13ID, S14ID, S15ID
		--			, S16ID, S17ID, S18ID, S19ID, S20ID
		--			, GluingTypeID		
		--			, KindOfSuppliersID	
		--			, InventoryID		
		--			, InventoryName
		--		)
		--		SELECT TOP 1
		--			MT23.PhaseID			AS PhaseID
		--			, MT23.NodeTypeID		AS NodeTypeID		
		--			, MT23.APK				AS APKNodeParent		
		--			, NULL					AS KindSuppliers
		--			, MT23.NodeID			AS MaterialID
		--			, NULL					AS UnitID			
		--			, OT02.OrderQuantity	AS Quantity			
		--			, OT02.SalePrice		AS UnitPrice			
		--			, OT02.ConvertedAmount	AS Amount
		--			, MT23.NodeOrder		AS PhaseOrder		
		--			, NULL					AS DisplayName		
		--			, NULL					AS QuantityRunWave	
		--			, NULL					AS UnitSizeID		
		--			, NULL					AS Size				
		--			, NULL					AS Cut				
		--			, NULL					AS Child				
		--			, NULL					AS PrintTypeID
		--			, NULL					AS RunPaperID		
		--			, NULL					AS RunWavePaper		
		--			, NULL					AS SplitSheets
		--			, NULL					AS MoldID			
		--			, NULL					AS MoldStatusID		
		--			, NULL					AS MoldDate			
		--			, NULL					AS Gsm				
		--			, NULL					AS Sheets			
		--			, NULL					AS Ram				
		--			, NULL					AS Kg				
		--			, NULL					AS M2				
		--			, NULL					AS AmountLoss
		--			, NULL					AS PercentLoss
		--			, NULL AS S01ID, NULL AS S02ID, NULL AS S03ID, NULL AS S04ID, NULL AS S05ID
		--			, NULL AS S06ID, NULL AS S07ID, NULL AS S08ID, NULL AS S09ID, NULL AS S10ID
		--			, NULL AS S11ID, NULL AS S12ID, NULL AS S13ID, NULL AS S14ID, NULL AS S15ID
		--			, NULL AS S16ID, NULL AS S17ID, NULL AS S18ID, NULL AS S19ID, NULL AS S20ID
		--			, NULL					AS GluingTypeID		
		--			, NULL					AS KindOfSuppliersID	
		--			, NULL					AS InventoryID		
		--			, NULL					AS InventoryName
		--		--- BTP : dự toán
		--		FROM MT2123 MT23 WITH (NOLOCK)
		--		LEFT JOIN MT2122 MT22 WITH (NOLOCK) ON MT22.DivisionID = MT23.DivisionID
		--												AND MT22.NodeTypeID = 0														
		--												AND MT22.[Version] = @BOMVersion
		--												AND MT22.NodeID = MT23.NodeID
		--												AND MT22.APK = MT23.APK_2120
		--		OUTER APPLY
		--		(
		--			SELECT TOP 1 
		--					OT02.OrderQuantity
		--					, OT02.SalePrice
		--					, OT02.ConvertedAmount
		--			FROM OT2002 OT02 WITH (NOLOCK)
		--			WHERE OT02.DivisionID = MT23.DivisionID
		--					AND OT02.APKMaster_2201 = @SOrderID
		--		) OT02
		--		WHERE MT23.DivisionID = @DivisionID
		--				AND MT23.NodeTypeID = 0 -- TP
		--				AND MT23.NodeID = @ProductID
		--END
		-- Lấy thành phẩm
		PRINT (@APK_BomVersion)
		BEGIN
			SET @InventoryID = (SELECT TOP 1 MT22.NodeID FROM MT2122 MT22 WITH (NOLOCK) WHERE MT22.DivisionID = @DivisionID AND CONVERT(VARCHAR(50), MT22.APK) = @APK_BomVersion)
		END

		DECLARE @ID				VARCHAR(50) = NULL;
		DECLARE @rowVoucherID	VARCHAR(50) = NULL;
		DECLARE @rowVoucherNo	VARCHAR(50) = NULL;
		DECLARE @rowSemiProduct	VARCHAR(50) = NULL;
		DECLARE @rowAPK_SOT2081	VARCHAR(50) = NULL;

		--- Đổ dữ liệu bộ BTP đã tính toán ở dự toán vào.
		--- Chạy từng dòng BTP.
		WHILE EXISTS(SELECT TOP 1 1 FROM #SOP2089_SEMI_PRODUCTS)
		BEGIN
							    
			SET @ID			    = NULL;
			SET @rowVoucherID   = NULL;
			SET @rowVoucherNo   = NULL;
			SET @rowSemiProduct = NULL;
			SET @rowSemiProduct = NULL;
			SET @rowAPK_SOT2081 = NULL;

			-- Lấy key dòng
			SET @ID = (SELECT TOP 1 ID FROM #SOP2089_SEMI_PRODUCTS  ORDER BY SemiOrders);

			SELECT TOP 1 
				@rowVoucherID = T89.VoucherID
				, @rowVoucherNo = T89.VoucherNo
				, @rowSemiProduct = T89.SemiProduct
				, @rowAPK_SOT2081 = T89.APK_SOT2081

			FROM #SOP2089_SEMI_PRODUCTS T89
			WHERE ID = @ID

			--- Xử lý đổ dữ liệu BTP : CRMT2111
			--BEGIN
			--	INSERT INTO #SOP2089_RESULTS
			--	(
			--		PhaseID				
			--		, NodeTypeID		
			--		, APKNodeParent		
			--		, KindSuppliers		
			--		, MaterialID		
			--		, UnitID			
			--		, Quantity			
			--		, UnitPrice			
			--		, Amount			
			--		, PhaseOrder		
			--		, DisplayName		
			--		, QuantityRunWave	
			--		, UnitSizeID		
			--		, Size				
			--		, Cut				
			--		, Child				
			--		, PrintTypeID		
			--		, RunPaperID		
			--		, RunWavePaper		
			--		, SplitSheets		
			--		, MoldID			
			--		, MoldStatusID		
			--		, MoldDate			
			--		, Gsm				
			--		, Sheets			
			--		, Ram				
			--		, Kg				
			--		, M2				
			--		, AmountLoss		
			--		, PercentLoss		
			--		, S01ID, S02ID, S03ID, S04ID, S05ID
			--		, S06ID, S07ID, S08ID, S09ID, S10ID
			--		, S11ID, S12ID, S13ID, S14ID, S15ID
			--		, S16ID, S17ID, S18ID, S19ID, S20ID
			--		, GluingTypeID		
			--		, KindOfSuppliersID	
			--		, InventoryID		
			--		, InventoryName
			--	)
			--	SELECT TOP 1
			--		NULL					AS PhaseID
			--		, 1						AS NodeTypeID		
			--		, CT11.APKDInherited	AS APKNodeParent		
			--		, NULL					AS KindSuppliers
			--		, CT10.SemiProduct		AS MaterialID
			--		, NULL					AS UnitID			
			--		, CT11.OffsetQuantity	AS Quantity			
			--		, CT11.InvenUnitPrice	AS UnitPrice			
			--		, CT11.TotalAmount		AS Amount
			--		, CT14.PhaseOrder		AS PhaseOrder		
			--		, NULL					AS DisplayName		
			--		, NULL					AS QuantityRunWave	
			--		, NULL					AS UnitSizeID		
			--		, NULL					AS Size				
			--		, NULL					AS Cut				
			--		, NULL					AS Child				
			--		, CT11.PrintTypeID		AS PrintTypeID
			--		, NULL					AS RunPaperID		
			--		, NULL					AS RunWavePaper		
			--		, CT11.SplitSheets		AS SplitSheets
			--		, NULL					AS MoldID			
			--		, NULL					AS MoldStatusID		
			--		, NULL					AS MoldDate			
			--		, NULL					AS Gsm				
			--		, NULL					AS Sheets			
			--		, NULL					AS Ram				
			--		, NULL					AS Kg				
			--		, NULL					AS M2				
			--		, CT11.AmountLoss		AS AmountLoss
			--		, CT11.PercentLoss		AS PercentLoss
			--		, NULL AS S01ID, NULL AS S02ID, NULL AS S03ID, NULL AS S04ID, NULL AS S05ID
			--		, NULL AS S06ID, NULL AS S07ID, NULL AS S08ID, NULL AS S09ID, NULL AS S10ID
			--		, NULL AS S11ID, NULL AS S12ID, NULL AS S13ID, NULL AS S14ID, NULL AS S15ID
			--		, NULL AS S16ID, NULL AS S17ID, NULL AS S18ID, NULL AS S19ID, NULL AS S20ID
			--		, NULL					AS GluingTypeID		
			--		, NULL					AS KindOfSuppliersID	
			--		, NULL					AS InventoryID		
			--		, NULL					AS InventoryName
			--	--- BTP : dự toán
			--	FROM CRMT2111 CT11 WITH (NOLOCK)
			--	INNER JOIN CRMT2110 CT10 WITH (NOLOCK) ON CT10.DivisionID = CT11.DivisionID 
			--												AND CT10.APK = @rowVoucherID
			--	OUTER APPLY
			--	(
			--		SELECT ISNULL(MIN(CT14.PhaseOrder), 0) - 1 AS PhaseOrder
			--		FROM CRMT2114 CT14 WITH (NOLOCK)
			--		WHERE CT14.DivisionID = CT11.DivisionID
			--				AND CT14.APKMaster = @rowVoucherID
			--	) CT14
			--	WHERE CT11.DivisionID = @DivisionID
			--			AND CT11.APKMaster = @rowVoucherID
			--END

			--- Xử lý đổ dữ liệu NVL theo dự toán: CRMT2114
			BEGIN
				
				INSERT INTO #SOP2089_RESULTS
				(
					PhaseID
					, APK_SOT2081
					, ProductID
					, SemiProduct				
					, NodeTypeID		
					, APKNodeParent		
					, KindSuppliers		
					, MaterialID		
					, UnitID			
					, Quantity			
					, UnitPrice			
					, Amount			
					, PhaseOrder		
					, DisplayName		
					, QuantityRunWave	
					, UnitSizeID		
					, Size				
					, Cut				
					, Child				
					, PrintTypeID		
					, RunPaperID		
					, RunWavePaper		
					, SplitSheets		
					, MoldID			
					, MoldStatusID		
					, MoldDate			
					, Gsm				
					, Sheets			
					, Ram				
					, Kg				
					, M2				
					, AmountLoss		
					, PercentLoss		
					, S01ID, S02ID, S03ID, S04ID, S05ID
					, S06ID, S07ID, S08ID, S09ID, S10ID
					, S11ID, S12ID, S13ID, S14ID, S15ID
					, S16ID, S17ID, S18ID, S19ID, S20ID
					, GluingTypeID		
					, KindOfSuppliersID	
					, InventoryID		
					, InventoryName
				)
				SELECT
				CT14.PhaseID
				, @rowAPK_SOT2081 AS APK_SOT2081
				, @InventoryID AS ProductID
				, @rowSemiProduct AS SemiProduct			
				, 2 AS NodeTypeID		
				, NULL AS APKNodeParent		
				, CT14.KindSuppliers		
				, CT14.MaterialID		
				, CT14.UnitID			
				, CT14.Quantity			
				, CT14.UnitPrice			
				, CT14.Amount			
				, CT14.PhaseOrder		
				, CT14.DisplayName		
				, CT14.QuantityRunWave	
				, CT14.UnitSizeID		
				, CT14.Size				
				, CT14.Cut				
				, CT14.Child				
				, CT14.PrintTypeID		
				, CT14.RunPaperID		
				, CT14.RunWavePaper		
				, CT14.SplitSheets		
				, CT14.MoldID			
				, CT14.MoldStatusID		
				, CT14.MoldDate			
				, CT14.Gsm				
				, CT14.Sheets			
				, CT14.Ram				
				, CT14.Kg				
				, CT14.M2				
				, CT14.AmountLoss		
				, CT14.PercentLoss		
				, CT14.S01ID, CT14.S02ID, CT14.S03ID, CT14.S04ID, CT14.S05ID
				, CT14.S06ID, CT14.S07ID, CT14.S08ID, CT14.S09ID, CT14.S10ID
				, CT14.S11ID, CT14.S12ID, CT14.S13ID, CT14.S14ID, CT14.S15ID
				, CT14.S16ID, CT14.S17ID, CT14.S18ID, CT14.S19ID, CT14.S20ID
				, CT14.GluingTypeID		
				, NULL AS KindOfSuppliersID
				, NULL AS InventoryID
				, NULL AS InventoryName
				--- NVL : dự toán
				FROM CRMT2114 CT14 WITH (NOLOCK)
				INNER JOIN CRMT2110 CT10 WITH (NOLOCK) ON CT10.DivisionID = CT14.DivisionID 
															AND CONVERT(VARCHAR(50), CT10.APK) = @rowVoucherID
				WHERE CT14.DivisionID = @DivisionID
						AND CONVERT(VARCHAR(50), CT14.APKMaster) = @rowVoucherID
				ORDER BY CT14.PhaseOrder

			END

			--- Xóa dòng dữ liệu.
			DELETE #SOP2089_SEMI_PRODUCTS WHERE ID = @ID
		END

		--- Tìm kiếm các nguyên vật liệu không thuộc BTP mà trực thuộc TP.
		--BEGIN

		--	INSERT INTO #SOP2089_RESULTS
		--			(
		--				PhaseID				
		--				, NodeTypeID		
		--				, APKNodeParent		
		--				, KindSuppliers		
		--				, MaterialID		
		--				, UnitID			
		--				, Quantity			
		--				, UnitPrice			
		--				, Amount			
		--				, PhaseOrder		
		--				, DisplayName		
		--				, QuantityRunWave	
		--				, UnitSizeID		
		--				, Size				
		--				, Cut				
		--				, Child				
		--				, PrintTypeID		
		--				, RunPaperID		
		--				, RunWavePaper		
		--				, SplitSheets		
		--				, MoldID			
		--				, MoldStatusID		
		--				, MoldDate			
		--				, Gsm				
		--				, Sheets			
		--				, Ram				
		--				, Kg				
		--				, M2				
		--				, AmountLoss		
		--				, PercentLoss		
		--				, S01ID, S02ID, S03ID, S04ID, S05ID
		--				, S06ID, S07ID, S08ID, S09ID, S10ID
		--				, S11ID, S12ID, S13ID, S14ID, S15ID
		--				, S16ID, S17ID, S18ID, S19ID, S20ID
		--				, GluingTypeID		
		--				, KindOfSuppliersID	
		--				, InventoryID		
		--				, InventoryName
		--			)
		--			SELECT
		--				MT23.PhaseID			AS PhaseID
		--				, MT23.NodeTypeID		AS NodeTypeID		
		--				, MT23.APK				AS APKNodeParent		
		--				, NULL					AS KindSuppliers
		--				, MT23.NodeID			AS MaterialID
		--				, NULL					AS UnitID			
		--				, 0						AS Quantity			
		--				, 0						AS UnitPrice			
		--				, 0						AS Amount
		--				, MT23.NodeOrder		AS PhaseOrder		
		--				, NULL					AS DisplayName		
		--				, NULL					AS QuantityRunWave	
		--				, NULL					AS UnitSizeID		
		--				, NULL					AS Size				
		--				, NULL					AS Cut				
		--				, NULL					AS Child				
		--				, NULL					AS PrintTypeID
		--				, NULL					AS RunPaperID		
		--				, NULL					AS RunWavePaper		
		--				, NULL					AS SplitSheets
		--				, NULL					AS MoldID			
		--				, NULL					AS MoldStatusID		
		--				, NULL					AS MoldDate			
		--				, NULL					AS Gsm				
		--				, NULL					AS Sheets			
		--				, NULL					AS Ram				
		--				, NULL					AS Kg				
		--				, NULL					AS M2				
		--				, NULL					AS AmountLoss
		--				, NULL					AS PercentLoss
		--				, NULL AS S01ID, NULL AS S02ID, NULL AS S03ID, NULL AS S04ID, NULL AS S05ID
		--				, NULL AS S06ID, NULL AS S07ID, NULL AS S08ID, NULL AS S09ID, NULL AS S10ID
		--				, NULL AS S11ID, NULL AS S12ID, NULL AS S13ID, NULL AS S14ID, NULL AS S15ID
		--				, NULL AS S16ID, NULL AS S17ID, NULL AS S18ID, NULL AS S19ID, NULL AS S20ID
		--				, NULL					AS GluingTypeID		
		--				, NULL					AS KindOfSuppliersID	
		--				, NULL					AS InventoryID		
		--				, NULL					AS InventoryName
		--			--- BTP : dự toán
		--	FROM MT2123 MT23
		--	INNER JOIN MT2123 MT33 WITH (NOLOCK) ON MT23.DivisionID = MT33.DivisionID 
		--											AND MT33.NodeTypeID = 0
		--											AND MT33.APK = MT23.NodeParent
		--	INNER JOIN MT2122 MT22 WITH (NOLOCK) ON MT23.APKMaster = MT22.APK
		--	where MT23.DivisionID = @DivisionID
		--			AND MT23.NodeTypeID = 2
		--			AND MT22.NodeID = @ProductID
		--			AND MT22.[Version] = @BOMVersion
		--	ORDER BY MT23.NodeOrder

		--END

		--- Trả về kết quả.
		SELECT 
			S89.Orders		
			, S89.PhaseID
			, S89.APK_SOT2081
			, AT26.PhaseName			AS PhaseName
			, S89.ProductID
			, S89.SemiProduct
			, S89.NodeTypeID
			, MT91.[Description]		AS NodeTypeName
			, S89.APKNodeParent
			, S89.KindSuppliers
			, S89.MaterialID
			, AT02.InventoryName		AS MaterialName
			, S89.UnitID
			, AT04.UnitName				AS UnitName
			, S89.Quantity			
			, S89.UnitPrice			
			, S89.Amount			
			, S89.PhaseOrder		
			, S89.DisplayName
			, MT98.[Description]		AS DisplayMember
			, S89.QuantityRunWave	
			, S89.UnitSizeID
			, MT92.[Description]		AS UnitSizeName
			, S89.Size
			, S89.Cut
			, S89.Child
			, S89.PrintTypeID
			, C2.[Description]			AS PrintTypeName
			, S89.RunPaperID		
			, MT93.[Description]		AS RunPaperName
			, S89.RunWavePaper		
			, S89.SplitSheets		
			, S89.MoldID			
			, S89.MoldStatusID	
			, (CASE WHEN S89.MoldStatusID IS NULL THEN NULL
					WHEN (ISNULL(S89.MoldStatusID, 0)) = '0' THEN N'Cũ'
					ELSE N'Mới'
					END) AS MoldStatusName
			, S89.MoldDate			
			, S89.Gsm				
			, S89.Sheets			
			, S89.Ram				
			, S89.Kg				
			, S89.M2				
			, S89.AmountLoss		
			, S89.PercentLoss		
			, S89.S01ID				
			, S89.S02ID				
			, S89.S03ID				
			, S89.S04ID				
			, S89.S05ID				
			, S89.S06ID				
			, S89.S07ID				
			, S89.S08ID				
			, S89.S09ID				
			, S89.S10ID				
			, S89.S11ID				
			, S89.S12ID				
			, S89.S13ID				
			, S89.S14ID				
			, S89.S15ID				
			, S89.S16ID				
			, S89.S17ID				
			, S89.S18ID				
			, S89.S19ID				
			, S89.S20ID				
			, S89.GluingTypeID	
			, MT94.Description			AS GluingTypeName
			, S89.KindOfSuppliersID	
			, S89.MaterialID			AS InventoryID
			, AT02.InventoryName		AS MaterialName
		FROM #SOP2089_RESULTS S89
		LEFT JOIN AT1302 AT02 WITH (NOLOCK) ON AT02.DivisionID IN ('@@@', @DivisionID)
													AND AT02.InventoryID = S89.MaterialID
		LEFT JOIN AT1304 AT04 WITH (NOLOCK) ON AT04.DivisionID IN ('@@@', @DivisionID)
													AND ISNULL(AT04.[Disabled], 0) = 0
													AND AT04.UnitID = S89.UnitID
		LEFT JOIN OOT0099 OT91 WITH (NOLOCK) ON OT91.CodeMaster = 'Status'
												AND ISNULL(OT91.[Disabled], 0) = 0
												AND OT91.ID1 = '0'
		LEFT JOIN CRMT0099 C2 WITH (NOLOCK) ON C2.CodeMaster = 'CRMF2111.PrintType'
												AND ISNULL(C2.[Disabled], 0) = 0
												AND C2.ID = S89.PrintTypeID
		LEFT JOIN AT0126 AT26 WITH (NOLOCK) ON ISNULL(AT26.[Disabled], 0) = 0
												AND AT26.PhaseID = S89.PhaseID
		LEFT JOIN MT0099 MT91 WITH (NOLOCK) ON MT91.CodeMaster ='StuctureType'
												AND ISNULL(MT91.[Disabled], 0) = 0
												AND MT91.ID = S89.NodeTypeID
		LEFT JOIN MT0099 MT92 WITH (NOLOCK) ON MT92.CodeMaster = 'UnitSize'
												AND ISNULL(MT92.[Disabled], 0) = 0
												AND MT92.ID = S89.UnitSizeID
		LEFT JOIN CRMT0099 MT93 WITH (NOLOCK) ON MT93.CodeMaster = 'CRMF2111.RunPaper' 
												AND ISNULL(MT93.[Disabled], 0) = 0
												AND MT93.ID = S89.RunPaperID
		LEFT JOIN MT0099 MT98 WITH (NOLOCK) ON MT98.ID = S89.DisplayName
												AND MT98.CodeMaster = 'DisplayName'
												AND ISNULL(MT98.Disabled, 0) = 0
		LEFT JOIN CRMT0099 MT94 WITH (NOLOCK) ON MT94.ID = S89.GluingTypeID 
												AND MT94.CodeMaster = 'GluingType' 
												AND ISNULL(MT94.Disabled, 0)= 0
	END

	IF (@Mode = 2)
	BEGIN

		--- Đổ dữ liệu vào bảng tạm.
		INSERT INTO #SOP2089_SEMI_PRODUCTS 
			(
			  ID
			, SemiOrders

			--- Chứng từ TTSX liên quan.
			, VoucherID	
			, VoucherNo

			--- Thông tin BTP.
			, ProductID
			, BOMVersion	
			, NodeTypeID
			, SemiProduct

			, APKMInherited	--- Yêu cầu khách hàng : NULL. Do không ghi vết YCKH cũ.
			, APKDInherited	--- MT2123 - BOM Version.
			)
		SELECT	NEWID() AS ID,
				X.Data.query('SemiOrders').value('.','INT')					AS SemiOrders,
				X.Data.query('VoucherID').value('.','VARCHAR(50)')			AS VoucherID,
				X.Data.query('VoucherNo').value('.','VARCHAR(250)')			AS VoucherNo,
				X.Data.query('ProductID').value('.','VARCHAR(50)')			AS ProductID,
				X.Data.query('BOMVersion').value('.','INT')					AS BOMVersion,
				1															AS NodeTypeID,
				X.Data.query('SemiProduct').value('.','VARCHAR(50)')		AS SemiProduct,
				X.Data.query('APKMInherited').value('.','VARCHAR(50)')		AS APKMInherited,
				X.Data.query('APKDInherited').value('.','VARCHAR(50)')		AS APKDInherited
		FROM @SemiProductList.nodes('//Data') AS X (Data)
		
		INSERT INTO #SOP2089_RESULTS
				(
					PhaseID				
					, NodeTypeID		
					, APKNodeParent		
					, KindSuppliers
					, MaterialID		
					, UnitID			
					, Quantity			
					, UnitPrice			
					, Amount			
					, PhaseOrder		
					, DisplayName		
					, QuantityRunWave	
					, UnitSizeID		
					, Size				
					, Cut				
					, Child				
					, PrintTypeID		
					, RunPaperID		
					, RunWavePaper		
					, SplitSheets		
					, MoldID			
					, MoldStatusID		
					, MoldDate			
					, Gsm				
					, Sheets			
					, Ram				
					, Kg				
					, M2				
					, AmountLoss		
					, PercentLoss		
					, S01ID, S02ID, S03ID, S04ID, S05ID
					, S06ID, S07ID, S08ID, S09ID, S10ID
					, S11ID, S12ID, S13ID, S14ID, S15ID
					, S16ID, S17ID, S18ID, S19ID, S20ID
					, GluingTypeID		
					, KindOfSuppliersID	
					, InventoryID		
					, InventoryName
				)
				SELECT
				CT14.PhaseID				
				, CT14.NodeTypeID AS NodeTypeID		
				, CT14.APKNodeParent AS APKNodeParent		
				, CT14.KindSuppliers				
				, CT14.MaterialID		
				, CT14.UnitID			
				, CT14.Quantity			
				, CT14.UnitPrice			
				, CT14.Amount			
				, CT14.PhaseOrder		
				, CT14.DisplayName		
				, CT14.QuantityRunWave	
				, CT14.UnitSizeID		
				, CT14.Size				
				, CT14.Cut				
				, CT14.Child				
				, CT14.PrintTypeID		
				, CT14.RunPaperID		
				, CT14.RunWavePaper		
				, CT14.SplitSheets		
				, CT14.MoldID			
				, CT14.MoldStatusID		
				, CT14.MoldDate			
				, CT14.Gsm				
				, CT14.Sheets			
				, CT14.Ram				
				, CT14.Kg				
				, CT14.M2				
				, CT14.AmountLoss		
				, CT14.PercentLoss		
				, CT14.S01ID, CT14.S02ID, CT14.S03ID, CT14.S04ID, CT14.S05ID
				, CT14.S06ID, CT14.S07ID, CT14.S08ID, CT14.S09ID, CT14.S10ID
				, CT14.S11ID, CT14.S12ID, CT14.S13ID, CT14.S14ID, CT14.S15ID
				, CT14.S16ID, CT14.S17ID, CT14.S18ID, CT14.S19ID, CT14.S20ID
				, CT14.GluingTypeID		
				, CT14.KindOfSuppliersID AS KindOfSuppliersID
				, NULL AS InventoryID
				, NULL AS InventoryName
				--- TTSX cũ.
				FROM SOT2082 CT14 WITH (NOLOCK)
				WHERE CT14.DivisionID = @DivisionID
						AND CONVERT(VARCHAR(50), CT14.APKMaster) = @SOrderID
				ORDER BY CT14.PhaseOrder

		--- Trả về kết quả.
		SELECT 
			S89.Orders		
			, S89.PhaseID
			, AT26.PhaseName			AS PhaseName
			, S89.NodeTypeID
			, MT91.[Description]		AS NodeTypeName
			, S89.APKNodeParent
			, S89.KindSuppliers
			, S89.MaterialID
			, AT02.InventoryName		AS MaterialName
			, S89.UnitID
			, AT04.UnitName				AS UnitName
			, S89.Quantity			
			, S89.UnitPrice			
			, S89.Amount			
			, S89.PhaseOrder		
			, S89.DisplayName
			, MT98.[Description]		AS DisplayMember
			, S89.QuantityRunWave	
			, S89.UnitSizeID
			, MT92.[Description]		AS UnitSizeName
			, S89.Size
			, S89.Cut
			, S89.Child
			, S89.PrintTypeID
			, C2.[Description]			AS PrintTypeName
			, S89.RunPaperID		
			, MT93.[Description]		AS RunPaperName
			, S89.RunWavePaper		
			, S89.SplitSheets		
			, S89.MoldID			
			, S89.MoldStatusID	
			, (CASE WHEN S89.MoldStatusID IS NULL THEN NULL
					WHEN (ISNULL(S89.MoldStatusID, 0)) = '0' THEN N'Cũ'
					ELSE N'Mới'
					END) AS MoldStatusName
			, S89.MoldDate			
			, S89.Gsm				
			, S89.Sheets			
			, S89.Ram				
			, S89.Kg				
			, S89.M2				
			, S89.AmountLoss		
			, S89.PercentLoss		
			, S89.S01ID				
			, S89.S02ID				
			, S89.S03ID				
			, S89.S04ID				
			, S89.S05ID				
			, S89.S06ID				
			, S89.S07ID				
			, S89.S08ID				
			, S89.S09ID				
			, S89.S10ID				
			, S89.S11ID				
			, S89.S12ID				
			, S89.S13ID				
			, S89.S14ID				
			, S89.S15ID				
			, S89.S16ID				
			, S89.S17ID				
			, S89.S18ID				
			, S89.S19ID				
			, S89.S20ID				
			, S89.GluingTypeID		
			, S89.KindOfSuppliersID	
			, S89.MaterialID			AS InventoryID
			, AT02.InventoryName		AS MaterialName
		FROM #SOP2089_RESULTS S89
		LEFT JOIN AT1302 AT02 WITH (NOLOCK) ON AT02.DivisionID IN ('@@@', @DivisionID)
													AND AT02.InventoryID = S89.MaterialID
		LEFT JOIN AT1304 AT04 WITH (NOLOCK) ON AT04.DivisionID IN ('@@@', @DivisionID)
													AND ISNULL(AT04.[Disabled], 0) = 0
													AND AT04.UnitID = S89.UnitID
		LEFT JOIN OOT0099 OT91 WITH (NOLOCK) ON OT91.CodeMaster = 'Status'
												AND ISNULL(OT91.[Disabled], 0) = 0
												AND OT91.ID1 = '0'
		LEFT JOIN CRMT0099 C2 WITH (NOLOCK) ON C2.CodeMaster = 'CRMF2111.PrintType'
												AND ISNULL(C2.[Disabled], 0) = 0
												AND C2.ID = S89.PrintTypeID
		LEFT JOIN AT0126 AT26 WITH (NOLOCK) ON ISNULL(AT26.[Disabled], 0) = 0
												AND AT26.PhaseID = S89.PhaseID
		LEFT JOIN MT0099 MT91 WITH (NOLOCK) ON MT91.CodeMaster ='StuctureType'
												AND ISNULL(MT91.[Disabled], 0) = 0
												AND MT91.ID = S89.NodeTypeID
		LEFT JOIN MT0099 MT92 WITH (NOLOCK) ON MT92.CodeMaster = 'UnitSize'
												AND ISNULL(MT92.[Disabled], 0) = 0
												AND MT92.ID = S89.UnitSizeID
		LEFT JOIN CRMT0099 MT93 WITH (NOLOCK) ON MT93.CodeMaster = 'CRMF2111.RunPaper' 
												AND ISNULL(MT93.[Disabled], 0) = 0
												AND MT93.ID = S89.RunPaperID
		LEFT JOIN MT0099 MT98 WITH (NOLOCK) ON MT98.ID = S89.DisplayName
												AND MT98.CodeMaster = 'DisplayName'
												AND ISNULL(MT98.Disabled, 0) = 0
	END

END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
