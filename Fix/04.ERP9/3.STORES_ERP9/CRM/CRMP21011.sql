IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP21011]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP21011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
--- Load dữ liệu kế thừa từ Định mức theo mặt hàng
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Updated by:  Đình Ly, date:  28/05/2021
----Updated by:  Văn Tài, date:  11/07/2023 - Bổ sung xử lý BoomVersion.
----Updated by:  Đức Tuyên, date:  21/09/2023 - Chi tiết NVL theo đúng thứ tự định mức.
-- <Example>
/*
	EXEC CRMP21011 'CB-BDC'
*/

CREATE PROCEDURE [dbo].[CRMP21011] 
(
	@InventoryID VARCHAR(50) = NULL,
	@APK_MT2122 VARCHAR(50) = NULL,
	@BoomVersion INT = NULL
)
AS

DECLARE @sSQL nvarchar(MAX) = '',
		@sSQL1 nvarchar(MAX) = ''

IF ISNULL(@BoomVersion, 0) = 0
BEGIN
	-- Load danh sách Bán thành phẩm theo Thành phẩm @InventoryID từ Bộ định mức (BOM)
	SET @sSQL = N'-- Đệ quy
	WITH Checktest (NodeTypeID, NodeID, NodeName, Location, NodeOrder, APK, NodeParent)
	AS 
	(
		SELECT MT21.NodeTypeID, MT21.NodeID, MT21.NodeName, CAST(MT21.APK AS NVARCHAR(MAX)) AS Location, MT21.NodeOrder, MT21.APK, MT21.NodeParent
		FROM MT2121 MT21
			LEFT JOIN MT2120 MT20 ON MT20.NodeID = '''+@InventoryID+'''
		WHERE MT21.NodeParent = ''00000000-0000-0000-0000-000000000000'' AND MT21.APK_2120 = MT20.APK
		UNION ALL
		SELECT M.NodeTypeID, M.NodeID, M.NodeName, CAST(CONCAT(D.location, ''.'', M.APK) AS NVARCHAR(MAX)) AS location, M.NodeOrder, M.APK, M.NodeParent
		FROM Checktest D INNER JOIN MT2121 M on D.APK = M.NodeParent
	)

	SELECT C1.NodeOrder, C1.NodeTypeID, C1.NodeID, C1.NodeName, C1.Location, C1.APK, C1.APK AS APKNodeParent, C1.NodeParent
		, MT21.NodeID AS InventoryID
		, MT21.NodeName AS MaterialName
		, MT21.UnitID, AT04.UnitName
		, MT20.RoutingID
		, A02.I02ID AS KindSuppliers
		, AT25.AnaName AS KindSupplierName
		, MT21.PhaseID, AT26.PhaseName
		, MT21.MaterialID, MT07.InventoryName
		, MT91.Description AS NodeTypeName
		, MT21.DisplayName, MT93.Description AS DisplayMember
		, MT21.CreateUserID
		, MT21.CreateDate
		, MT21.LastModifyUserID
		, MT21.LastModifyDate
	INTO #TableTemp
	FROM Checktest C1
		LEFT JOIN MT2121 MT21 ON MT21.APK = C1.APK
		LEFT JOIN AT1304 AT04 WITH (NOLOCK) ON AT04.UnitID = MT21.UnitID
		LEFT JOIN MT2120 MT20 WITH (NOLOCK) ON MT20.APK = MT21.APK_2120
		LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.InventoryID = MT21.NodeID
		LEFT JOIN AT0126 AT26 WITH (NOLOCK) ON AT26.PhaseID = MT21.PhaseID AND ISNULL(AT26.Disabled, 0)= 0
		LEFT JOIN AT1302 MT07 WITH (NOLOCK) ON MT07.InventoryID = MT21.MaterialID AND ISNULL(MT07.Disabled, 0)= 0
		LEFT JOIN MT0099 MT91 WITH (NOLOCK) ON MT91.ID = MT21.NodeTypeID AND MT91.CodeMaster = ''StuctureType'' AND ISNULL(MT91.Disabled, 0)= 0  
		LEFT JOIN MT0099 MT93 WITH (NOLOCK) ON MT93.ID = MT21.DisplayName AND ISNULL(MT93.Disabled, 0)= 0 AND MT93.CodeMaster = ''DisplayName''
		LEFT JOIN AT1015 AT25 WITH (NOLOCK) ON A02.I02ID = AT25.AnaID AND AT25.AnaTypeID = ''I02''
	WHERE C1.NodeTypeID <> 0'

	-- Do lưu trữ cha con không có số thứ tự nên phải đối chiếu cắt chuỗi để sắp xếp trường có giá trị APK.
	SET @sSQL1 = N'
	DECLARE @length INT
	SET @length = (SELECT Max(NodeTypeID) FROM #TableTemp)

	DECLARE @min INT
	SET @min = (SELECT Min(NodeTypeID) FROM #TableTemp)

	-- Trường hợp có Bán thành phẩm
	IF(@min = 1) BEGIN
		print @min
		print @length
		SELECT ROW_NUMBER() OVER (ORDER BY CASE 
			WHEN @length < 2 THEN Location
			WHEN @length = 2 THEN LEFT(Location, 73)
			WHEN @length = 3 THEN LEFT(Location, 110)
			WHEN @length = 4 THEN LEFT(Location, 147)
			WHEN @length = 5 THEN LEFT(Location, 184)
			WHEN @length = 6 THEN LEFT(Location, 221) END, NodeTypeID, NodeOrder) AS PhaseOrder
			, APK, APKNodeParent
			, NodeParent
			, NodeOrder
			, UnitID, UnitName
			, NodeTypeID, NodeTypeName
			, InventoryID, MaterialName
			, KindSuppliers, KindSupplierName
			, PhaseID, PhaseName
			, DisplayName, DisplayMember
			, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate
		FROM #TableTemp
		--ORDER BY LEFT(Location, 73)
		ORDER BY NodeOrder
	END

	-- Trường hợp không có Bán thành phẩm
	ELSE BEGIN
		SELECT ROW_NUMBER() OVER (ORDER BY NodeOrder) AS PhaseOrder
			, APK, APKNodeParent
			, NodeParent
			, NodeOrder
			, UnitID, UnitName
			, NodeTypeID, NodeTypeName
			, InventoryID, MaterialName
			, KindSuppliers, KindSupplierName
			, PhaseID, PhaseName
			, DisplayName, DisplayMember
			, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate
		FROM #TableTemp
		ORDER BY NodeOrder
	END'

	print (@sSQL + ' ' + @sSQL1)
	EXEC (@sSQL + ' ' + @sSQL1)

END
ELSE
BEGIN

	-- Load danh sách Bán thành phẩm theo Thành phẩm @InventoryID từ Bộ định mức (BOM)
	SET @sSQL = N'-- Đệ quy
	WITH Checktest (
						NodeTypeID
						, NodeID
						, NodeName
						, Location
						, NodeOrder
						, APK
						, NodeParent
					)
	AS 
	(
		SELECT MT23.NodeTypeID
				, MT23.NodeID
				, MT23.NodeName
				, CAST(MT33.APK AS NVARCHAR(MAX)) AS Location
				, MT23.NodeOrder
				, MT33.APK
				, MT23.NodeParent
		FROM MT2123 MT23
		LEFT JOIN MT2122 MT22 ON MT22.APK = ''' + @APK_MT2122 + '''
		OUTER APPLY
		(
			SELECT TOP 1
					MT23.APK
			FROM MT2123 MT233 WITH (NOLOCK)
			WHERE MT233.DivisionID = MT22.DivisionID
					AND MT233.APK_2120 = MT22.APK
					AND MT233.NodeTypeID = 0
		) MT33
		WHERE MT23.NodeParent = ''00000000-0000-0000-0000-000000000000''
				AND MT23.APK_2120 = MT22.APK

		UNION ALL

		SELECT M.NodeTypeID
				, M.NodeID
				, M.NodeName
				, CAST(CONCAT(D.location, ''.'', M.APK) AS NVARCHAR(MAX)) AS location
				, M.NodeOrder
				, M.APK
				, M.NodeParent
		FROM Checktest D 
		INNER JOIN MT2123 M on D.APK = M.NodeParent
	)

	SELECT C1.NodeOrder
		, C1.NodeTypeID
		, C1.NodeID
		, C1.NodeName
		, C1.Location
		, C1.APK
		, C1.APK AS APKNodeParent
		, C1.NodeParent
		, MT21.NodeID AS InventoryID
		, MT21.NodeName AS MaterialName
		, MT21.UnitID
		, AT04.UnitName
		, MT20.RoutingID
		, A02.I02ID AS KindSuppliers
		, AT25.AnaName AS KindSupplierName
		, MT21.PhaseID
		, AT26.PhaseName
		, MT21.MaterialID
		, MT07.InventoryName
		, MT91.Description AS NodeTypeName
		, MT21.DisplayName
		, MT93.Description AS DisplayMember
		, MT21.CreateUserID
		, MT21.CreateDate
		, MT21.LastModifyUserID
		, MT21.LastModifyDate
	INTO #TableTemp
	FROM Checktest C1
		LEFT JOIN MT2123 MT21 ON MT21.APK = C1.APK
		LEFT JOIN AT1304 AT04 WITH (NOLOCK) ON AT04.UnitID = MT21.UnitID
		LEFT JOIN MT2120 MT20 WITH (NOLOCK) ON MT20.APK = MT21.APK_2120
		LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.InventoryID = MT21.NodeID
		LEFT JOIN AT0126 AT26 WITH (NOLOCK) ON AT26.PhaseID = MT21.PhaseID AND ISNULL(AT26.Disabled, 0)= 0
		LEFT JOIN AT1302 MT07 WITH (NOLOCK) ON MT07.InventoryID = MT21.MaterialID 
												AND ISNULL(MT07.Disabled, 0)= 0
		LEFT JOIN MT0099 MT91 WITH (NOLOCK) ON MT91.ID = MT21.NodeTypeID 
												AND MT91.CodeMaster = ''StuctureType'' 
												AND ISNULL(MT91.Disabled, 0) = 0  
		LEFT JOIN MT0099 MT93 WITH (NOLOCK) ON MT93.ID = MT21.DisplayName 
												AND ISNULL(MT93.Disabled, 0) = 0 
												AND MT93.CodeMaster = ''DisplayName''
		LEFT JOIN AT1015 AT25 WITH (NOLOCK) ON AT25.AnaTypeID = ''I02'' AND A02.I02ID = AT25.AnaID
	WHERE C1.NodeTypeID <> 0'

	-- Do lưu trữ cha con không có số thứ tự nên phải đối chiếu cắt chuỗi để sắp xếp trường có giá trị APK.
	SET @sSQL1 = N'
	DECLARE @length INT
	SET @length = (SELECT Max(NodeTypeID) FROM #TableTemp)

	DECLARE @min INT
	SET @min = (SELECT Min(NodeTypeID) FROM #TableTemp)

	-- Trường hợp có Bán thành phẩm
	IF(@min = 1) BEGIN
		print @min
		print @length
		SELECT ROW_NUMBER() OVER (ORDER BY CASE 
			WHEN @length < 2 THEN Location
			WHEN @length = 2 THEN LEFT(Location, 73)
			WHEN @length = 3 THEN LEFT(Location, 110)
			WHEN @length = 4 THEN LEFT(Location, 147)
			WHEN @length = 5 THEN LEFT(Location, 184)
			WHEN @length = 6 THEN LEFT(Location, 221) END, NodeTypeID, NodeOrder) AS PhaseOrder
			, APK, APKNodeParent
			, NodeParent
			, NodeOrder
			, UnitID, UnitName
			, NodeTypeID, NodeTypeName
			, InventoryID, MaterialName
			, KindSuppliers, KindSupplierName
			, PhaseID, PhaseName
			, DisplayName, DisplayMember
			, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate
		FROM #TableTemp
		--ORDER BY LEFT(Location, 73)
		ORDER BY NodeOrder
	END

	-- Trường hợp không có Bán thành phẩm
	ELSE BEGIN
		SELECT ROW_NUMBER() OVER (ORDER BY NodeOrder) AS PhaseOrder
			, APK, APKNodeParent
			, NodeParent
			, NodeOrder
			, UnitID, UnitName
			, NodeTypeID, NodeTypeName
			, InventoryID, MaterialName
			, KindSuppliers, KindSupplierName
			, PhaseID, PhaseName
			, DisplayName, DisplayMember
			, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate
		FROM #TableTemp
		ORDER BY NodeOrder
	END'

	print (@sSQL + ' ' + @sSQL1)
	EXEC (@sSQL + ' ' + @sSQL1)

END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
