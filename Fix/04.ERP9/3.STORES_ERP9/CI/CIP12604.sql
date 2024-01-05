IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP12604]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CIP12604]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <summary>
--- Load dữ liệu Master/Detail/Khách hàng cho phiếu in chương trình khuyễn mãi theo giá trị hóa đơn
-- <history>
--- Created on 30/03/2023 by Anh Đô

CREATE PROC CIP12604
			@DivisionID	VARCHAR(50),
			@PromoteID	VARCHAR(50),
			@Mode		INT = 0 -- 0: Dữ liệu Master; 1: Load dữ liệu Detail; 2: Load danh sách khách hàng khuyến mãi
AS
BEGIN
	DECLARE @sSql NVARCHAR(MAX)

	IF ISNULL(@Mode, 0) = 0
	BEGIN
		-- Load dữ liệu Master
		SET @sSql = N'
			SELECT DISTINCT 
				  M.DivisionID
				, M.PromoteID
				, M.PromoteName
				, LTRIM(RTRIM(STUFF(( SELECT '', '' + AT1201.ObjectTypeName
				FROM   AT1201 WITH (NOLOCK) 
				WHERE   AT1201.ObjectTypeID IN (SELECT Value FROM dbo.StringSplit(M.ObjectTypeID, '',''))
				ORDER BY AT1201.ObjectTypeID
				FOR XML PATH('''')), 1, 1, ''''))) AS ObjectTypeName
				, M.FromDate
				, M.ToDate
				, M.PromotionTypeID
				, M.Description
			FROM AT0109 M WITH (NOLOCK)
			WHERE M.PromoteID = '''+ @PromoteID +''' AND M.DivisionID = '''+ @DivisionID +'''
		'
	END

	ELSE IF @Mode = 1
	BEGIN
		-- Load dữ liệu Detail
		SET @sSql = N'
			SELECT
			  M.DivisionID
			, M.APK
			, M.PromoteID
			, M.FromValues
			, M.ToValues
			, M.DiscountPercent
			, M.DiscountAmount
			, M.Notes
			, A1.InventoryID
			, A1.InventoryName
			, M.PromoteQuantity
			FROM AT0109 M WITH (NOLOCK)
			LEFT JOIN AT1302 A1 WITH (NOLOCK) ON A1.InventoryID = M.InventoryID
			WHERE M.PromoteID = '''+ @PromoteID +''' AND M.DivisionID = '''+ @DivisionID +'''
			ORDER BY M.FromValues
		'
	END

	ELSE IF @Mode = 2
	BEGIN
		-- Load danh sách khách hàng khuyến mãi
		SET @sSql = N'
			SELECT
			      ROW_NUMBER() OVER (ORDER BY A1.ObjectID) AS RowNum
				, M.BusinessParent AS PromoteID
				, A1.ObjectID
				, A1.ObjectName
				, A1.Address
				, A1.Tel
				, A1.Email
			FROM CIT0088 M WITH (NOLOCK)
			LEFT JOIN AT1202 A1 ON A1.ObjectID = M.BusinessChild
			WHERE M.APKParent IN (SELECT APK FROM AT0109 WHERE PromoteID = '''+ @PromoteID +''' AND DivisionID = '''+ @DivisionID +''')
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
