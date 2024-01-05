IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP14703]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CIP14703]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--<summary>
--- Xử lí load dữ liệu master/detail cho phiếu in màn hình CIF1470
--<history>
--- Created by Anh Đô on [09/05/2023]

CREATE PROC CIP14703
			@APK			VARCHAR(50),
			@Mode			INT -- 0: Load dữ liệu master, 1. Load dữ liệu detail
AS
BEGIN
	DECLARE @sSQL NVARCHAR(MAX)
	IF ISNULL(@Mode, 0) = 0
	BEGIN
		SET @sSQL = N'
			SELECT
					M.DivisionID
					, M.APK
					, M.ID
					, M.Description
					, M.FromDate
					, M.ToDate
					, M.OID
					, CASE WHEN M.OID = ''%'' THEN N''Tất cả'' ELSE A1.AnaName END AS OIDName
					, M.InheritID
					, A3.CurrencyName
					, CASE WHEN ISNULL(M.IsConvertedPrice, 0) = 0 THEN N''Không'' ELSE N''Có'' END AS IsConvertedPrice
					, CASE WHEN ISNULL(M.IsTaxIncluded, 0) = 0 THEN N''Không'' ELSE N''Có'' END AS IsTaxIncluded
					, CASE WHEN M.InventoryTypeID = ''%'' THEN N''Tất cả'' ELSE A2.InventoryTypeName END AS InventoryTypeName
			FROM OT1301 M WITH (NOLOCK)
			LEFT JOIN AT1015 A1 WITH (NOLOCK) ON A1.AnaID = M.OID 
			LEFT JOIN AT1301 A2 WITH (NOLOCK) ON A2.InventoryTypeID = M.InventoryTypeID
			LEFT JOIN AT1004 A3 WITH (NOLOCK) ON A3.CurrencyID = M.CurrencyID
			WHERE M.APK = '''+ @APK +'''
		'
	END
	ELSE IF @Mode = 1
	BEGIN
		SET @sSQL = N'
			SELECT
					M.ID
					, O1.InventoryID
					, A1.InventoryName
					, A3.UnitName
					, A2.CurrencyName
					, O1.UnitPrice
					, O1.MinPrice
					, O1.MaxPrice
					, O1.DiscountPercent
					, O1.DiscountAmount
					, O1.VATPercent
					, O1.VATAmount
					, O1.TotalAmount
					, O1.Notes
			FROM OT1301 M WITH (NOLOCK)
			INNER JOIN OT1302 O1 WITH (NOLOCK) ON O1.ID = M.ID
			LEFT JOIN AT1302 A1 WITH (NOLOCK) ON A1.InventoryID = O1.InventoryID
			LEFT JOIN AT1004 A2 WITH (NOLOCK) ON A2.CurrencyID = M.CurrencyID
			LEFT JOIN AT1304 A3 WITH (NOLOCK) ON A3.UnitID = O1.UnitID
			WHERE M.APK = '''+ @APK +'''
		'
	END

	PRINT(@sSQL)
	EXEC(@sSQL)
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
