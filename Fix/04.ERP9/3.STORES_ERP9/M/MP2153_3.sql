IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2153_3]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2153_3]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
--- Tính dự trù
-- <Param> listAPK
----
-- <Return>
----
-- <Reference>
----
-- <History
---- Created by: Đức Tuyên Date: 10/04/2023
---- Update by: Hồng Thắm Date: 25/09/2023 - Thêm điều kiện DivisionID để hiển thị đvt  
---- Update by: Nhật Thanh Date 05/10/2023: Tăng độ rộng cột đặt tính kĩ thuật


Create PROCEDURE [dbo].[MP2153_3]
(
    @DivisionID VARCHAR(50),
	@listAPK VARCHAR(MAX) = '',
	@ProductID VARCHAR(MAX) = '',
	@MOrderID VARCHAR(MAX) = '',
	@ProductQuantity DECIMAL(28,8) = 0,
	@APK_BomVersion VARCHAR(50) = '',
	@APK_OT2202 VARCHAR(50) = '',
	@XML XML
)
AS

CREATE TABLE #TempMP2153
(
	VoucherNo NVARCHAR(50) DEFAULT (''),
	ProductID NVARCHAR(50) DEFAULT (''),
	RoutingID NVARCHAR(50) NULL,
	PhaseID NVARCHAR(50) NULL,
	NodeTypeID NVARCHAR(50) NULL,
	SemiProduct NVARCHAR(50) NULL,
	ApporitionID INT NULL,
	MaterialID NVARCHAR(50) NULL,
	MaterialName NVARCHAR(250) NULL,
	UnitID NVARCHAR(50) NULL,
	UnitName NVARCHAR(250) NULL,
	Quantity DECIMAL(28, 8) DEFAULT 0,
	Specification NVARCHAR(250) NULL,
    LossValue DECIMAL(28, 8) DEFAULT 0,
	InventoryID NVARCHAR(50) NULL,
	NodeID NVARCHAR(50) NULL,
	MaterialGroupID NVARCHAR(50) NULL,
	MaterialIDChange NVARCHAR(50) NULL,
	MaterialNameChange NVARCHAR(250) NULL,
	MaterialConstant NVARCHAR(50) NULL,
	NodeLevel INT NULL,
	NodeParent VARCHAR(50) NULL,
	NodeOrder INT NULL,
	QuantitativeValue DECIMAL(28, 8) DEFAULT 0,
	APK_OT2202 VARCHAR(50) NULL,
)

DECLARE @sSQL NVARCHAR(MAX) = N'',
		@OrderBy NVARCHAR(MAX) = N'', 
		@TotalRow NVARCHAR(50) = N'',
		@sWhere NVARCHAR(MAX) = N'',
		@masterCursor CURSOR,
		@CustomerIndex INT = (SELECT CustomerName FROM CustomerIndex)

IF(@CustomerIndex = 158) -- Khách hàng HIPC
BEGIN
	SET @sWhere = N''
	SET @sSQL = ''
END
ELSE -- Chuẩn chung
BEGIN

	SELECT 
		X.Data.query('MOrderID').value('.','NVARCHAR(50)') AS MOrderID,
		X.Data.query('ProductID').value('.','NVARCHAR(50)') AS ProductID,
		X.Data.query('ProductQuantity').value('.','decimal(28, 8)') AS ProductQuantity,
		X.Data.query('APK_BomVersion').value('.','NVARCHAR(50)') AS APK_BomVersion,
		X.Data.query('APK_OT2202').value('.','NVARCHAR(50)') AS APK_OT2202
	INTO #Data
	FROM @XML.nodes('//Data') AS X (Data)

	SET @masterCursor = CURSOR STATIC FOR
	SELECT MOrderID, ProductID, ProductQuantity, APK_BomVersion, APK_OT2202
	FROM #Data

	OPEN @masterCursor

	FETCH NEXT FROM @masterCursor INTO @MOrderID, @ProductID, @ProductQuantity, @APK_BomVersion, @APK_OT2202

	WHILE @@FETCH_STATUS = 0
	BEGIN
	INSERT INTO #TempMP2153
	(
		VoucherNo,
		ProductID,
		RoutingID,
		PhaseID,
		NodeTypeID,
		SemiProduct,
		ApporitionID,
		MaterialID,
		MaterialName,
		UnitID,
		UnitName,
		Quantity,
		Specification,
		LossValue,
		InventoryID,
		NodeID,
		MaterialGroupID,
		MaterialIDChange,
		MaterialNameChange,
		MaterialConstant,
		NodeLevel,
		NodeParent,
		NodeOrder,
		QuantitativeValue,
		APK_OT2202
	)
	SELECT @MOrderID
			, @ProductID
			, M22.RoutingID
			, M23.PhaseID
			, M23.NodeTypeID
			, CASE WHEN  M23.NodeTypeID = '1' THEN M23.NodeID
				ELSE ''
				END AS SemiProduct
			, M22.Version
			, CASE WHEN  M23.NodeTypeID = '2' THEN M23.NodeID
				ELSE ''
				END AS MaterialID
			, M11.InventoryName
			, M23.UnitID
			, M8.UnitName
			, ((LTRIM(@ProductQuantity) * ISNULL(M23.QuantitativeValue,0)) + (((LTRIM(@ProductQuantity) * ISNULL(M23.QuantitativeValue,0))* ISNULL(M23.LossValue,0))/100)) AS Quantity
			, M11.Specification AS Specification

			, M23.LossValue
			, M22.NodeID
			, M22.NodeID
			, M23.MaterialGroupID
			, M23.MaterialID
			, M11.InventoryName
			, M23.MaterialConstant
			, M23.NodeLevel
			, M23.NodeParent
			, M23.NodeOrder
			, M23.QuantitativeValue
			, @APK_OT2202		
					
	FROM MT2122 M22 WITH (NOLOCK)
		LEFT JOIN MT2123 M23 WITH (NOLOCK) ON M22.APK = M23.APK_2120 AND M23.DivisionID IN (M22.DivisionID, '@@@') 
		LEFT JOIN AT1302 M11 WITH (NOLOCK) ON M23.NodeID = M11.InventoryID AND M11.DivisionID IN (M22.DivisionID, '@@@') 
		LEFT JOIN AT1304 M8 WITH (NOLOCK) ON M23.UnitID = M8.UnitID  AND M8.DivisionID IN (M22.DivisionID, '@@@') 
	WHERE M22.DivisionID  IN ('@@@', @DivisionID)
		AND CONVERT(VARCHAR(50), M22.APK) = @APK_BomVersion
		AND M22.NodeID = @ProductID
		AND M23.NodeID IS NOT NULL
	ORDER BY M23.NodeOrder

	FETCH NEXT FROM @masterCursor INTO @MOrderID, @ProductID, @ProductQuantity, @APK_BomVersion, @APK_OT2202
	END
	CLOSE @masterCursor
END

--SELECT MaterialID FROM #TempMP2153 GROUP BY MaterialID HAVING COUNT(MaterialID) >1
SELECT *FROM #TempMP2153


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
