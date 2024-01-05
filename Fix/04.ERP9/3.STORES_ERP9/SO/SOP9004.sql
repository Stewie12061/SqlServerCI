IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP9004]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP9004]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load dữ liệu màn hình chọn target chương trình khuyến mãi
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 25/07/2023 by Nhật Thanh
---- Updated on 17/11/2023 by Nhật Thanh: Customize Nệm Kim Cương lấy loại mặt hàng từ mã phân tích mặt hàng I06
-- <Example>
---- exec sp_executesql N'EXEC SOP9004 @DivisionID=N''GREE-SI'',@TypeID=N''Quantity'',@TxtSearch=N''SP131'',@PageNumber=N''1'',@PageSize=N''25''',N'@CreateUserID nvarchar(4),@LastModifyUserID nvarchar(4),@DivisionID nvarchar(7)',@CreateUserID=N'SP04',@LastModifyUserID=N'SP04',@DivisionID=N'GREE-SI'

CREATE PROCEDURE SOP9004
( 
	@DivisionID NVARCHAR(50),
	@TypeID NVARCHAR(50),
	@TxtSearch NVARCHAR(250),
	@PageNumber INT,
    @PageSize INT
)
AS
DECLARE @sSQL NVARCHAR(MAX) = '';
DECLARE @CustomerIndex int = (SELECT TOP 1 CustomerName from CustomerIndex)

IF @TypeID = 'CKTK'
BEGIN
	SET @sSQL = N'SELECT ROW_NUMBER() OVER (ORDER BY TargetID) AS RowNum, COUNT(*) OVER () AS TotalRow, '''+@DivisionID+N''' DivisionID, TargetID, TargetName, ''CKTK'' as Type
	FROM (
		SELECT ''Diem'' as TargetID, N''Điểm'' as TargetName
	) DATA
	ORDER BY DivisionID, TargetID 
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
END
ELSE
IF @TypeID = 'KIT'
BEGIN
	SET @sSQL = N'SELECT ROW_NUMBER() OVER (ORDER BY KITID) AS RowNum, COUNT(*) OVER () AS TotalRow, DivisionID, KITID as TargetID, MDescription as TargetName, ''KIT'' as Type
	FROM AT1326
	WHERE DivisionID in ('''+@DivisionID+''',''@@@'') AND KITID like N''%' + @TxtSearch +'%''
	GROUP BY DivisionID, KITID, MDescription
	ORDER BY DivisionID, KITID
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
END
ELSE 
BEGIN
	IF @CustomerIndex = 166 -- nệm kim cương
		SET @sSQL = N'
		SELECT ROW_NUMBER() OVER (ORDER BY TargetID) AS RowNum, COUNT(*) OVER () AS TotalRow, DivisionID, TargetID, TargetName, CASE WHEN Type = 1 then N''Loại mặt hàng'' else N''Mặt hàng'' end as Type
		FROM (
		SELECT DivisionID, AnaID as TargetID, AnaName as TargetName, 1 as Type
		FROM AT1015
		WHERE AnaTypeID = ''I06''
		UNION ALL
		SELECT DivisionID, InventoryID as TargetID, InventoryName as TargetName, 2 as Type
		FROM AT1302
		) A
		WHERE A.DivisionID in ('''+@DivisionID+''',''@@@'') AND TargetID like N''%' + @TxtSearch +'%''
		ORDER BY Type, DivisionID, TargetID
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	ELSE
		SET @sSQL = N'
			SELECT ROW_NUMBER() OVER (ORDER BY Type, DivisionID, TargetID) AS RowNum, COUNT(*) OVER () AS TotalRow, DivisionID, TargetID, TargetName, CASE WHEN Type = 1 then N''Loại mặt hàng'' else N''Mặt hàng'' end as Type
			FROM (
			SELECT DivisionID, InventoryTypeID as TargetID, InventoryTypeName as TargetName, 1 as Type
			FROM AT1301
			UNION ALL
			SELECT DivisionID, InventoryID as TargetID, InventoryName as TargetName, 2 as Type
			FROM AT1302
			) A
			WHERE A.DivisionID in ('''+@DivisionID+''',''@@@'') AND TargetID like N''%' + @TxtSearch +'%''
			ORDER BY Type, DivisionID, TargetID
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
END
print(@sSQL)
Exec(@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
