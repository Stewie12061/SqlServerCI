IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2061]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2061]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load dữ liệu Details màn hình xem/sửa Book Cont đơn hàng xuất khẩu - POF2061 - POF2061
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- CREATE BY Văn Tài ON 31/12/2019
---- Modified by Văn Tài on 07/01/2020 - Bổ sung các cột S01Name
---- Modified by Văn Tài on 24/02/2020 - Bổ sung hiển thị tên đối tượng, loại tiền.
-- <Example>
/* 
	EXEC POP2061
	@DivisionID = N'MTH'
	, @UserID = N'ASOFTADMIN'
	, @APK = N'720768D9-99F8-4F25-B895-BB6E6F05FF18'
	, @PageNumber = 1
	, @PageSize = 25
	, @Mode = 0
*/

CREATE PROCEDURE POP2061
( 
		@DivisionID NVARCHAR(50),
		@UserID NVARCHAR(50),
		@APK NVARCHAR(50),		
		@PageNumber INT,
		@PageSize INT,
		@Mode INT -- 0: View, 1: Edit
) 
AS 
BEGIN
DECLARE @sSQL NVARCHAR(MAX)

--- Trường hợp xem phân trang
IF(ISNULL(@Mode, 0) = 0)
BEGIN
	SET @sSQL = N'SELECT   
	ROW_NUMBER() OVER (ORDER BY T1.APK ) AS RowNum
	, COUNT(*) OVER () AS TotalRow 
	, T1.*
	, T1.CurrencyID AS CurrencyName
	, T04.UnitName AS UnitName
	, T05.ObjectName AS ObjectName
	--, CONCAT(T05.ObjectID, '' - '', T05.ObjectName) AS ObjectName
	, T1.S01ID AS S01Name
	, T1.S02ID AS S02Name
	, T1.S03ID AS S03Name
	, T1.S04ID AS S04Name
	, T1.S05ID AS S05Name
	, T1.S06ID AS S06Name
	, T1.S07ID AS S07Name
	, T1.S08ID AS S08Name
	, T1.S09ID AS S09Name
	, T1.S10ID AS S10Name
	, T1.S11ID AS S11Name
	, T1.S12ID AS S12Name
	, T1.S13ID AS S13Name
	, T1.S14ID AS S14Name
	, T1.S15ID AS S15Name
	, T1.S16ID AS S16Name
	, T1.S17ID AS S17Name
	, T1.S18ID AS S18Name
	, T1.S19ID AS S19Name
	, T1.S20ID AS S20Name
	FROM POT2062 T1
	LEFT JOIN AT1304 T04 WITH(NOLOCK) ON T1.UnitID = T04.UnitID
	LEFT JOIN AT1202 T05 WITH(NOLOCK) ON T1.ObjectID = T05.ObjectID
	WHERE T1.DivisionID = N''' + @DivisionID + N'''
			AND APKMaster = N''' + @APK + N'''
	ORDER BY T1.Orders
	OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
	FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '

	-- PRINT(@sSQL)
	EXEC(@sSQL)
END
ELSE
BEGIN
	SELECT ROW_NUMBER() OVER (ORDER BY T1.APK ) AS RowNum
	, COUNT(*) OVER () AS TotalRow 
	, T1.*
	, T1.CurrencyID AS CurrencyName
	, T04.UnitName AS UnitName
	, T05.ObjectName AS ObjectName
	--, CONCAT(T05.ObjectID, ' - ', T05.ObjectName) AS ObjectName
	, T1.S01ID AS S01Name
	, T1.S02ID AS S02Name
	, T1.S03ID AS S03Name
	, T1.S04ID AS S04Name
	, T1.S05ID AS S05Name
	, T1.S06ID AS S06Name
	, T1.S07ID AS S07Name
	, T1.S08ID AS S08Name
	, T1.S09ID AS S09Name
	, T1.S10ID AS S10Name
	, T1.S11ID AS S11Name
	, T1.S12ID AS S12Name
	, T1.S13ID AS S13Name
	, T1.S14ID AS S14Name
	, T1.S15ID AS S15Name
	, T1.S16ID AS S16Name
	, T1.S17ID AS S17Name
	, T1.S18ID AS S18Name
	, T1.S19ID AS S19Name
	, T1.S20ID AS S20Name
	FROM POT2062 T1			
	LEFT JOIN AT1304 T04 WITH(NOLOCK) ON T1.UnitID = T04.UnitID
	LEFT JOIN AT1202 T05 WITH(NOLOCK) ON T1.ObjectID = T05.ObjectID
	WHERE T1.DivisionID = @DivisionID 
	AND T1.APKMaster = @APK 
	ORDER BY T1.Orders
END


END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


