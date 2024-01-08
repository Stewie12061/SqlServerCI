IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP21461]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP21461]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load dữ liệu lưới details nghiệp vụ Lệnh sản xuất.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Đức Tuyên on 13/03/2023
----Modify by: Thanh Lượng on 15/09/2023 - Cập nhật : [2023/09/TA/0070] - Xử lý bổ sung trường Specification (Customize PANGLOBE).
----Modify by: Hồng Thắm on 04/10/2023 - Cập nhật : Fix lỗi lấy không được một số ĐVT 
-- <Example>

CREATE PROCEDURE [dbo].[MP21461]
( 
	@DivisionID VARCHAR(50),
	@APK_MT2143 VARCHAR(MAX) = '',
	@APK_NodeParent VARCHAR(MAX) = '',
	@MaterialQuantity DECIMAL(28,8) = 0,
-- Không sử dụng
	 @APK_MT2142 VARCHAR(MAX) = '',
	 @APK_BomVersion VARCHAR(MAX) = '',
	 @MachineID VARCHAR(MAX)= ''
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',
		@sJoin NVARCHAR(MAX) = N'',
		@sWhere NVARCHAR(MAX) = N'',
		@sSQL1 NVARCHAR(MAX) = N'',
		@CustomerIndex INT = (SELECT CustomerName FROM CustomerIndex)

IF @APK_BomVersion = ''

BEGIN
	SET @sSQL = @sSQL + N'
	SELECT Distinct 
		MT43.Date, MT43.Date AS StartDate
		, CASE WHEN OT03.NodeTypeID = 1 THEN OT03.SemiProduct
			ELSE OT03.MaterialID
		END AS MaterialID
		, OT03.MaterialName AS MaterialName
		, OT03.UnitID, A2.UnitName
		, CASE WHEN OT03.NodeTypeID = 1 THEN AT12_1.Specification
		ELSE AT12.Specification END AS Specification
		, AT26.PhaseID
		, AT26.PhaseName
		, MT31.PhaseTime
		, (CASE WHEN ISNULL(CI50.MachineID, '''') = '''' THEN MT31.ResourceID ELSE CI50.MachineID END) AS MachineID
		, (CASE WHEN ISNULL(CI50.MachineName, '''') = '''' THEN MT31.ResourceName ELSE CI50.MachineName END) AS MachineName
		, CI50.MachineID
		, CI50.MachineName
		, (('+ LTRIM(@MaterialQuantity) +' * ISNULL(OT03.MaterialQuantity,0)) / NULLIF(OT02.ProductQuantity, 0)) AS MaterialQuantity
	
		, OT03.NodeOrder
		, MT41.nvarchar01

		FROM MT2142 MT42 WITH (NOLOCK)

	-- Thông tin kế hoạch
			LEFT JOIN MT2143 MT43 WITH (NOLOCK) ON MT43.DivisionID = MT42.DivisionID
													AND CONVERT(VARCHAR(50), MT43.APK) = ''' + @APK_MT2143 + '''
			LEFT JOIN MT2141 MT41 WITH (NOLOCK) ON MT41.DivisionID = MT42.DivisionID 
													AND CONVERT(VARCHAR(50), MT41.APK) = MT42.APK_MT2141
	-- Thông tin Dự trù
			LEFT JOIN OT2202 OT02 WITH (NOLOCK) ON OT02.DivisionID = MT42.DivisionID 
													AND CONVERT(VARCHAR(50), OT02.APK) = CONVERT(VARCHAR(50), MT41.InheritTransactionID)
			LEFT JOIN OT2203 OT03 WITH (NOLOCK) ON OT03.DivisionID = MT42.DivisionID 
													AND CONVERT(VARCHAR(50), OT03.APK_OT2202) = OT02.APK
													AND CONVERT(VARCHAR(50), OT03.NodeParent) = ''' + @APK_NodeParent + '''
			LEFT JOIN AT1302 AT12 WITH (NOLOCK) ON AT12.DivisionID = OT03.DivisionID AND AT12.InventoryID = OT03.MaterialID
			LEFT JOIN AT1302 AT12_1 WITH (NOLOCK) ON AT12.DivisionID = OT03.DivisionID AND AT12.InventoryID = OT03.SemiProduct
	-- Thông tin công đoạn
			LEFT JOIN MT2130 MT30 WITH (NOLOCK) ON MT30.DivisionID = MT42.DivisionID 
													AND OT03.RoutingID = MT30.RoutingID
			LEFT JOIN MT2131 MT31 WITH (NOLOCK) ON MT31.DivisionID = MT42.DivisionID
													AND OT03.PhaseID = MT31.PhaseID 
													AND CONVERT(VARCHAR(50), MT30.APK) = MT31.APKMaster 
	-- Thôn tin bổ sung
			LEFT JOIN AT1304 A2 WITH (NOLOCK) ON A2.DivisionID IN (MT42.DivisionID,''@@@'')
													AND OT03.UnitID = A2.UnitID
			LEFT JOIN AT0126 AT26 WITH (NOLOCK) ON AT26.DivisionID = MT42.DivisionID
													AND AT26.PhaseID = OT03.PhaseID
			LEFT JOIN CIT1150 CI50 WITH (NOLOCK) ON OT03.DivisionID = MT42.DivisionID 
													AND MT31.ResourceID = CI50.MachineID 

		WHERE MT42.DivisionID IN (''@@@'', ''' + @DivisionID + ''')
			AND CONVERT(VARCHAR(50), MT42.APK) = MT43.APKMaster
		ORDER BY OT03.NodeOrder
	'
END
ELSE
BEGIN
	SET @sSQL = @sSQL + N'
	SELECT Distinct 
		MT43.Date, MT43.Date AS StartDate
		, CASE WHEN OT03.NodeTypeID = 1 THEN OT03.SemiProduct
			ELSE OT03.MaterialID
		END AS MaterialID
		, OT03.MaterialName AS MaterialName
		, OT03.UnitID, A2.UnitName
		, CASE WHEN OT03.NodeTypeID = 1 THEN AT12_1.Specification
		ELSE AT12.Specification END AS Specification
		, AT26.PhaseID
		, AT26.PhaseName
		, MT31.PhaseTime
		, (CASE WHEN ISNULL(CI50.MachineID, '''') = '''' THEN MT31.ResourceID ELSE CI50.MachineID END) AS MachineID
		, (CASE WHEN ISNULL(CI50.MachineName, '''') = '''' THEN MT31.ResourceName ELSE CI50.MachineName END) AS MachineName
		, CI50.MachineID
		, CI50.MachineName
		, (('+ LTRIM(@MaterialQuantity) +' * ISNULL(OT03.MaterialQuantity,0)) / NULLIF(OT02.ProductQuantity, 0)) AS MaterialQuantity
	
		, OT03.NodeOrder
		, MT41.nvarchar01

		FROM MT2142 MT42 WITH (NOLOCK)

	-- Thông tin kế hoạch
			LEFT JOIN MT2143 MT43 WITH (NOLOCK) ON MT43.DivisionID = MT42.DivisionID
													AND CONVERT(VARCHAR(50), MT43.APK) = ''' + @APK_MT2143 + '''
			LEFT JOIN MT2141 MT41 WITH (NOLOCK) ON MT41.DivisionID = MT42.DivisionID 
													AND CONVERT(VARCHAR(50), MT41.APK) = MT42.APK_MT2141
	-- Thông tin Dự trù
			LEFT JOIN OT2202 OT02 WITH (NOLOCK) ON OT02.DivisionID = MT42.DivisionID 
													AND CONVERT(VARCHAR(50), OT02.APK) = CONVERT(VARCHAR(50), MT41.InheritTransactionID)
			LEFT JOIN OT2203 OT03 WITH (NOLOCK) ON OT03.DivisionID = MT42.DivisionID 
													AND CONVERT(VARCHAR(50), OT03.APK_OT2202) = OT02.APK
													AND CONVERT(VARCHAR(50), OT03.NodeParent) = ''' + @APK_NodeParent + '''
			LEFT JOIN AT1302 AT12 WITH (NOLOCK) ON AT12.DivisionID = OT03.DivisionID AND AT12.InventoryID = OT03.MaterialID
			LEFT JOIN AT1302 AT12_1 WITH (NOLOCK) ON AT12.DivisionID = OT03.DivisionID AND AT12.InventoryID = OT03.SemiProduct
	-- Thông tin công đoạn
			LEFT JOIN MT2130 MT30 WITH (NOLOCK) ON MT30.DivisionID = MT42.DivisionID 
													AND OT03.RoutingID = MT30.RoutingID
			LEFT JOIN MT2131 MT31 WITH (NOLOCK) ON MT31.DivisionID = MT42.DivisionID
													AND OT03.PhaseID = MT31.PhaseID 
													AND CONVERT(VARCHAR(50), MT30.APK) = MT31.APKMaster 
	-- Thôn tin bổ sung
			LEFT JOIN AT1304 A2 WITH (NOLOCK) ON A2.DivisionID = MT42.DivisionID
													AND OT03.UnitID = A2.UnitID
			LEFT JOIN AT0126 AT26 WITH (NOLOCK) ON AT26.DivisionID = MT42.DivisionID
													AND AT26.PhaseID = OT03.PhaseID
			LEFT JOIN CIT1150 CI50 WITH (NOLOCK) ON OT03.DivisionID = MT42.DivisionID 
													AND MT31.ResourceID = CI50.MachineID 

		WHERE MT42.DivisionID IN (''@@@'', ''' + @DivisionID + ''')
			AND CONVERT(VARCHAR(50), MT42.APK) = MT43.APKMaster
		ORDER BY OT03.NodeOrder
	'
END

EXEC (@sSQL + @sJoin + @sWhere + @sSQL1)
PRINT(@sSQL + @sJoin + @sWhere + @sSQL1)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
