IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2126]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2126]
GO
		
DROP FUNCTION IF EXISTS [DBO].[getTool]

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
--- Load dữ liệu xuất excel Định mức sản phẩm (HIPC, EXV)
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by Đình Định on 28/12/2022
---- Modified by Viết Toàn on 01/03/2023 : Customize theo CustomerIndex, bổ sung xuất excel chi tiết định mức sản phẩm (EXV)
---- Modified by Viết Toàn on 21/04/2023 : Cập nhật xuất excel HIPC. Thêm xuất Labour Cost Calculation nếu có check tính nhân công + Sửa lại phần cộng tool khi xuất định mức
-- <Example>

CREATE FUNCTION getTool
( @APK UNIQUEIDENTIFIER, @MaterialInventoryID NVARCHAR(MAX) )

RETURNS NVARCHAR(MAX)
AS
BEGIN
	DECLARE @MaterialTool NVARCHAR(MAX)

	SELECT @MaterialTool = MT27.InventoryID + N' + ' + COALESCE(@MaterialTool, N'')
	  FROM (
			SELECT DISTINCT
			MT27.InventoryID
			FROM MT2127 MT27
			LEFT JOIN MT2122 MT22 WITH(NOLOCK) ON MT27.APKMaster = MT22.APK
			LEFT JOIN MT2123 MT23 WITH (NOLOCK) ON  MT23.APK_2120 = MT22.APK
			WHERE MT23.APK_2120 = @APK AND MT27.MaterialInventoryID = @MaterialInventoryID
	) MT27

	RETURN SUBSTRING(@MaterialTool, 1, LEN(@MaterialTool) - 1)

END;

GO

CREATE PROCEDURE MP2126
(
	@APK NVARCHAR(MAX) = '',
	@DivisionID NVARCHAR(50),
	@UserID  NVARCHAR(50) = ''
)
AS

DECLARE @CustomerIndex INT = (SELECT CustomerName FROM CustomerIndex)

-- Khách hàng HIPC

IF @CustomerIndex = 158
BEGIN
		
		-- Lấy BOM version mới nhất
		DECLARE @APK_MaxVersion NVARCHAR(MAX) = (SELECT TOP 1 MT22.APK 
												FROM MT2122 MT22
												LEFT JOIN MT2120 MT20 ON MT22.NodeID = MT20.NodeID
												WHERE MT20.APK = @APK
												ORDER BY MT22.[Version] DESC)

		-- MASTER (Model)
		SELECT DISTINCT MT22.APK, MT22.DivisionID, MT22.[Description],
			   AT12.ObjectName, 
			   AT11.CountryName,
			   MT22.NodeID, MT22.NodeName,
			   MT22.QuantityProduct
		INTO #MT2122
		FROM MT2122 MT22 WITH (NOLOCK) 
		LEFT JOIN AT1202 AT12 WITH (NOLOCK) ON MT22.ObjectID = AT12.ObjectID
		LEFT JOIN AT1001 AT11 WITH (NOLOCK) ON AT12.CountryID = AT11.CountryID
		WHERE MT22.APK = @APK_MaxVersion AND MT22.DivisionID = @DivisionID

		SELECT * FROM #MT2122

		-- Bảng Định mức sản phẩm & Tool(Model1)
		 SELECT DISTINCT MT23.APK, MT22.DivisionID, 
			   --AT12.ObjectName, AT11.CountryName,
					MT23.NodeID, 
					MT23.NodeName, 
					MT23.QuantitativeValue, MT23.LossValue,
					MT23.LossAmount, MT23.Total, 
					MT23.SetUpTime,
					MT23.DDescription,
					[dbo].[getTool](MT22.APK, MT27.MaterialInventoryID) as MaterialTool,
					MT23.NodeOrder
					--CASE 
		INTO #MT2123
		FROM MT2123 MT23 WITH (NOLOCK) 
		LEFT JOIN MT2122 MT22 WITH (NOLOCK) ON MT22.APK = MT23.APK_2120
		LEFT JOIN MT2127 MT27 WITH (NOLOCK) ON MT23.NodeID = MT27.MaterialInventoryID
		WHERE MT22.APK = @APK_MaxVersion AND MT22.DivisionID = @DivisionID
		

		SELECT * FROM #MT2123 
		WHERE NodeOrder <> 0
		ORDER BY NodeOrder

		-- Nhân công (Model2)
		SELECT DISTINCT MT26.APK, MT26.DivisionID, MT26.InventoryID, 
			   AT13.InventoryName, MT26.Quantity, MT26.SetUpTime, MT26.Notes, MT26.Orders
		INTO #MT2126
		FROM MT2126 MT26  WITH (NOLOCK) 
		LEFT JOIN AT1302 AT13 WITH (NOLOCK) ON MT26.InventoryID = AT13.InventoryID
		LEFT JOIN #MT2123 M23 WITH (NOLOCK) ON M23.APK = MT26.APKMaster
		WHERE MT26.APKMaster = @APK_MaxVersion AND MT26.DivisionID = @DivisionID
		

		SELECT * FROM #MT2126
		ORDER BY Orders

		-- Labour Cost Calculation	(Model 3)			

		SELECT MT26.[Description],
			   MT26.InventoryID,
			   CASE WHEN (MT26.IsLabourCalculated = 1 AND (ISNULL(MT26.Quantity, 0) <> 0)) THEN CONVERT(DECIMAL(28,2), (ISNULL(MT22.QuantityProduct, 0)/MT26.Quantity)*1.25) ELSE NULL END AS Quantity, 
			   MT26.UnitID,
			   MT26.Orders
		INTO #MT2126_1
		FROM MT2126 MT26  WITH (NOLOCK) 
		LEFT JOIN #MT2122 MT22 WITH (NOLOCK) ON MT22.APK = MT26.APKMaster
		WHERE MT26.APKMaster = @APK_MaxVersion AND MT26.DivisionID = @DivisionID AND MT26.IsLabourCalculated = 1
		

		SELECT * FROM #MT2126_1
		ORDER BY Orders

END

-- Khách hàng EXV

IF @CustomerIndex = 151
BEGIN
	SELECT CONVERT(NVARCHAR(40), M0.APK) AS APK
             , M0.DivisionID
             , M0.NodeTypeID
             , MT91.Description AS NodeTypeName
             , M0.NodeID
             , M0.NodeID AS InventoryID
             , M0.NodeName
             , M0.NodeLevel
             , M0.NodeOrder
             , M0.UnitID
             , AT14.UnitName
             , 1 AS IsUpdate
             , M0.CreateUserID
             , M0.CreateDate
             , M0.LastModifyUserID
             , M0.LastModifyDate
			 , M0.MaterialConstant
             , M0.LossValue
             , M0.DisplayName
             , M0.LossAmount
             , M0.Total
             , M0.SetUpTime
             , M0.DDescription
             , AT26.PhaseID, AT26.PhaseName
			 , M0.MaterialGroupID, MT06.GroupName AS MaterialGroupName
             , M0.MaterialID, MT07.InventoryName AS MaterialName
			 , M0.OutsourceID, MT94.Description AS OutsourceName
			 , M0.DictatesID, MT95.Description AS DictatesName
             , M0.DisplayName, M93.Description AS DisplayMember
             , M0.QuantitativeTypeID, MT92.Description AS QuantitativeTypeName, M0.QuantitativeValue
             , IIF(CONVERT(VARCHAR(40), M0.NodeParent) = '00000000-0000-0000-0000-000000000000', '', CONVERT(VARCHAR(40), M0.NodeParent)) AS NodeParent
             , M1.S01ID, M1.S02ID, M1.S03ID, M1.S04ID, M1.S05ID, M1.S06ID, M1.S07ID, M1.S08ID, M1.S09ID, M1.S10ID
             , M1.S11ID, M1.S12ID, M1.S13ID, M1.S14ID, M1.S15ID, M1.S16ID, M1.S17ID, M1.S18ID, M1.S19ID, M1.S20ID
        FROM MT2121 M0 WITH(NOLOCK)
            LEFT JOIN MT8899 M1 WITH(NOLOCK) ON M1.TransactionID = CAST(M0.APK AS VARCHAR(50))
            LEFT JOIN AT1304 AT14 WITH (NOLOCK) ON AT14.UnitID = M0.UnitID
			LEFT JOIN MT2120 MT20 WITH (NOLOCK) ON MT20.APK = M0.APK_2120
            LEFT JOIN MT0099 M93 WITH (NOLOCK) ON M93.ID = M0.DisplayName AND ISNULL(M93.Disabled, 0)= 0 AND M93.CodeMaster = 'DisplayName'
			LEFT JOIN AT0126 AT26 WITH (NOLOCK) ON AT26.PhaseID = M0.PhaseID AND ISNULL(AT26.Disabled, 0)= 0
			LEFT JOIN MT0006 MT06 WITH (NOLOCK) ON MT06.MaterialGroupID = M0.MaterialGroupID AND ISNULL(MT06.Disabled, 0)= 0
			LEFT JOIN AT1302 MT07 WITH (NOLOCK) ON MT07.InventoryID = M0.MaterialID AND ISNULL(MT07.Disabled, 0)= 0
			LEFT JOIN MT0099 MT95 WITH (NOLOCK) ON MT95.ID = M0.DictatesID AND MT95.CodeMaster = 'Dictates' AND ISNULL(MT95.Disabled, 0)= 0 
			LEFT JOIN MT0099 MT94 WITH (NOLOCK) ON MT94.ID = M0.OutsourceID AND MT94.CodeMaster = 'Outsource' AND ISNULL(MT94.Disabled, 0)= 0 
			LEFT JOIN MT0099 MT91 WITH (NOLOCK) ON MT91.ID = M0.NodeTypeID AND MT91.CodeMaster = 'StuctureType' AND ISNULL(MT91.Disabled, 0)= 0  
			LEFT JOIN MT0099 MT92 WITH (NOLOCK) ON MT92.ID = M0.QuantitativeTypeID AND MT92.CodeMaster = 'QuantitativeType' AND ISNULL(MT92.Disabled, 0)= 0
		WHERE MT20.apk = CAST(@APK AS uniqueidentifier) AND MT20.DivisionID = @DivisionID
		ORDER BY M0.NodeOrder, M0.NodeLevel, M0.NodeParent


        SELECT CONVERT(VARCHAR(40), M0.APK) AS APK, M0.APK_2120
             , M0.DivisionID, M0.NodeTypeID
             , MT91.Description AS NodeTypeName
             , M0.NodeID, M0.NodeID AS InventoryID
             , M0.NodeName, M0.NodeLevel
             , M0.NodeOrder, M0.UnitID
             , AT14.UnitName, MT22.Version
             , 1 AS IsUpdate, M0.CreateUserID
             , M0.CreateDate, M0.LastModifyUserID
             , M0.LastModifyDate , M0.MaterialConstant
             , M0.LossValue, M0.DisplayName
             , M0.LossAmount , M0.Total
             , M0.SetUpTime, M0.DDescription
			 , IIF(M0.NodeTypeID = 0, AT12.ObjectName, '''') AS ObjectName
             , AT26.PhaseID, AT26.PhaseName
			 , M0.MaterialGroupID, MT06.GroupName AS MaterialGroupName
             , M0.MaterialID, MT07.InventoryName AS MaterialName
			 , M0.OutsourceID, MT94.Description AS OutsourceName
			 , M0.DictatesID, MT95.Description AS DictatesName
             , M0.DisplayName, M93.Description AS DisplayMember
             , M0.QuantitativeTypeID, MT92.Description AS QuantitativeTypeName, M0.QuantitativeValue
             , IIF(CONVERT(VARCHAR(40), M0.NodeParent) = '00000000-0000-0000-0000-000000000000', '', CONVERT(VARCHAR(40), M0.NodeParent)) AS NodeParent
             , M1.S01ID, M1.S02ID, M1.S03ID, M1.S04ID, M1.S05ID, M1.S06ID, M1.S07ID, M1.S08ID, M1.S09ID, M1.S10ID
             , M1.S11ID, M1.S12ID, M1.S13ID, M1.S14ID, M1.S15ID, M1.S16ID, M1.S17ID, M1.S18ID, M1.S19ID, M1.S20ID
        FROM MT2123 M0 WITH(NOLOCK)
            LEFT JOIN MT8899_BV M1 WITH(NOLOCK) ON M1.TransactionID = CAST(M0.APK AS VARCHAR(50))
            LEFT JOIN AT1304 AT14 WITH (NOLOCK) ON AT14.UnitID = M0.UnitID
			LEFT JOIN MT2122 MT22 WITH (NOLOCK) ON MT22.APK = M0.APK_2120
			LEFT JOIN MT2120 MT20 WITH (NOLOCK) ON MT20.NodeID = MT22.NodeID
            LEFT JOIN MT0099 M93 WITH (NOLOCK) ON M93.ID = M0.DisplayName AND ISNULL(M93.Disabled, 0)= 0 AND M93.CodeMaster = 'DisplayName'
			LEFT JOIN AT0126 AT26 WITH (NOLOCK) ON AT26.PhaseID = M0.PhaseID AND ISNULL(AT26.Disabled, 0)= 0
			LEFT JOIN MT0006 MT06 WITH (NOLOCK) ON MT06.MaterialGroupID = M0.MaterialGroupID AND ISNULL(MT06.Disabled, 0)= 0
			LEFT JOIN AT1302 MT07 WITH (NOLOCK) ON MT07.InventoryID = M0.MaterialID AND ISNULL(MT07.Disabled, 0)= 0
			LEFT JOIN MT0099 MT95 WITH (NOLOCK) ON MT95.ID = M0.DictatesID AND MT95.CodeMaster = 'Dictates' AND ISNULL(MT95.Disabled, 0)= 0 
			LEFT JOIN MT0099 MT94 WITH (NOLOCK) ON MT94.ID = M0.OutsourceID AND MT94.CodeMaster = 'Outsource' AND ISNULL(MT94.Disabled, 0)= 0 
			LEFT JOIN MT0099 MT91 WITH (NOLOCK) ON MT91.ID = M0.NodeTypeID AND MT91.CodeMaster = 'StuctureType' AND ISNULL(MT91.Disabled, 0)= 0  
			LEFT JOIN MT0099 MT92 WITH (NOLOCK) ON MT92.ID = M0.QuantitativeTypeID AND MT92.CodeMaster = 'QuantitativeType' AND ISNULL(MT92.Disabled, 0)= 0
			LEFT JOIN AT1202 AT12 WITH (NOLOCK) ON AT12.ObjectID = MT22.ObjectID 
        WHERE MT20.APK = @APK AND MT22.Version <> 0 ORDER BY MT22.Version,M0.NodeLevel, M0.NodeOrder, M0.NodeParent
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
