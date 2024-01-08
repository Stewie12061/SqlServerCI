IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP12405]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CIP12405]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <summary>
--- Load dữ diệu Master/Detail cho phiếu in thông tin khuyến mãi theo mặt hàng
-- <history>
--- Created on 28/03/2023 by Anh Đô

CREATE PROC CIP12405
			@APK		VARCHAR(50),
			@Mode		INT = 0 -- 0: Load Master; 1: Khuyến mãi hàng tặng hàng; 2: Khuyến mãi hàng tặng tiền; 3: Danh sách khách hàng khuyến mãi
AS
BEGIN
	DECLARE @sSql NVARCHAR(MAX)

	IF ISNULL(@Mode, 0) = 0
	BEGIN
		-- Load dữ liệu Master
		SET @sSql = N'
			SELECT
				  M.DivisionID
				, M.PromoteID
				, M.PromoteName
				, M.FromDate
				, M.ToDate
				, M.InventoryTypeID
				, CASE WHEN M.InventoryTypeID = ''%'' THEN N''Tất cả'' ELSE A1.InventoryTypeName END AS InventoryTypeName
				, LTRIM(RTRIM(STUFF(( SELECT '', '' + AT1201.ObjectTypeName
					FROM   AT1201 WITH (NOLOCK) 
					WHERE   AT1201.ObjectTypeID in (SELECT Value from StringSplit(M.ObjectTypeID, '',''))
					ORDER BY AT1201.ObjectTypeID
					FOR XML PATH('''')), 1, 1, ''''))) AS ObjectTypeName
				, M.Description
			FROM AT1329 M WITH (NOLOCK)
			LEFT JOIN AT1301 A1 WITH (NOLOCK) ON A1.InventoryTypeID = M.InventoryTypeID
			WHERE M.APK = '''+ @APK +'''
		'
	END

	ELSE IF @Mode = 1
	BEGIN
		-- Load dữ liệu Khuyến mãi hàng tặng hàng
		SET @sSql = N'
			SELECT
				  M.DivisionID
				, M.PromoteID
				, M.InventoryID
				, A1.InventoryName
				, A2.FromQuantity
				, A2.ToQuantity
				, A2.PromoteInventoryID
				, A3.InventoryName AS PromoteInventoryName
				, CASE WHEN A2.IsCombo = ''0'' THEN N''Không''
					   WHEN A2.IsCombo = ''1'' THEN N''Có''
				  ELSE '''' END
				  AS IsCombo
				, A2.PromoteQuantity
				, A2.Notes
			FROM AT1328 M WITH (NOLOCK)
			LEFT JOIN AT1302 A1 WITH (NOLOCK) ON A1.InventoryID = M.InventoryID
			LEFT JOIN AT1338 A2 WITH (NOLOCK) ON A2.VoucherID = M.VoucherID
			LEFT JOIN AT1302 A3 WITH (NOLOCK) ON A3.InventoryID = A2.PromoteInventoryID
			WHERE M.PromoteTypeID = ''0'' AND M.PromoteId = (SELECT PromoteID FROM AT1329 WHERE APK = '''+ @APK +''')
		'
	END

	ELSE IF @Mode = 2
	BEGIN
		-- Load dữ liệu Khuyến mãi hàng tặng tiền
		SET @sSql = N'
			SELECT
				  M.DivisionID
				, M.PromoteID
				, M.InventoryID
				, A1.InventoryName
				, A2.FromQuantity
				, A2.ToQuantity
				, A2.PromotionPrice
				, A2.PromotePercent
				, A2.Notes
			FROM AT1328 M WITH (NOLOCK)
			LEFT JOIN AT1302 A1 WITH (NOLOCK) ON A1.InventoryID = M.InventoryID
			LEFT JOIN AT1338 A2 WITH (NOLOCK) ON A2.VoucherID = M.VoucherID
			LEFT JOIN AT1302 A3 WITH (NOLOCK) ON A3.InventoryID = A2.PromoteInventoryID
			WHERE M.PromoteTypeID = ''1'' AND M.PromoteId = (SELECT PromoteID FROM AT1329 WHERE APK = '''+ @APK +''')
		'
	END

	ELSE IF @Mode = 3
	BEGIN
		-- Load Danh sách khách hàng khuyến mãi
		SET @sSql = N'
				SELECT
					  A1.DivisionID
					, A1.ObjectID
					, A1.ObjectName
					, A1.Address
					, A1.Tel
					, A1.Email
				FROM CIT0088 M WITH (NOLOCK)
				LEFT JOIN AT1202 A1 WITH (NOLOCK) ON A1.ObjectID = M.BusinessChild AND TableBusinessParent = ''AT1329''
				WHERE M.APKParent = '''+ @APK +'''
				ORDER BY A1.ObjectID
			'
	END
	
	PRINT(@sSql)
	EXEC(@sSql)
END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
