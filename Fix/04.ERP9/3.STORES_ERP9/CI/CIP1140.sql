IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP1140]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP1140]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Grid Form CIF1140: Danh mục kho hàng 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by: Khả Vi, Date: 05/03/2017
----Modified by: Anh Tuấn, Date: 14/02/2022 - Bổ sung điều kiện search địa chỉ, thủ kho, kho tạm
----Modified by: Hoài Bảo, Date: 21/04/2022 - Cập nhật điều kiện kiểm tra theo đơn vị
-- <Example>
---- 
/*-- <Example>
	CIP1140 @DivisionID = 'VF', @DivisionList = 'VF', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @IsSearch = 0, @WareHouseID = '',
	@WareHouseName = '', @Address = '', @FullName = '', @IsTemp = NULL, @IsLocation = '', @IsCommon = 0, @Disabled = 0

	CIP1140 @DivisionID, @DivisionList, @UserID, @PageNumber, @PageSize, @IsSearch, @WareHouseID, 
	@WareHouseName, @Address, @Fullname, @IsTemp, @IsLocation, @Disabled
----*/

CREATE PROCEDURE CIP1140
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsSearch TINYINT,
	 @WareHouseID VARCHAR(50),
	 @WareHouseName NVARCHAR(250),
	 @Address NVARCHAR(250),
	 @FullName NVARCHAR(250),
	 @IsTemp TINYINT,
	 @IsLocation VARCHAR(1), 
	 @IsCommon VARCHAR(1), 
	 @Disabled VARCHAR(1)
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
        @OrderBy NVARCHAR(500) = N'',
        @TotalRow NVARCHAR(50) = N''
        
SET @OrderBy = 'WareHouseID'

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

--Search theo đơn vị @DivisionList trống thì lấy biến môi trường @DivisionID
IF ISNULL(@DivisionList, '') != ''
	SET @sWhere = @sWhere + ' DivisionID IN (''@@@'','''+@DivisionList+''')'
ELSE 
	SET @sWhere = @sWhere + ' DivisionID IN (''@@@'','''+@DivisionID+''')'
 

IF ISNULL(@WareHouseID,'') <> '' SET @sWhere = @sWhere + '
AND WareHouseID LIKE ''%'+@WareHouseID+'%'' '	
IF ISNULL(@WareHouseName,'') <> '' SET @sWhere = @sWhere + '
AND WareHouseName LIKE ''%'+@WareHouseName+'%'' '
IF ISNULL(@Address,'') <> '' SET @sWhere = @sWhere + '
AND Address LIKE ''%'+@Address+'%'' '
IF ISNULL(@FullName,'') <> '' SET @sWhere = @sWhere + '
AND FullName LIKE ''%'+@FullName+'%'' '
IF @IsTemp IS NOT NULL SET @sWhere = @sWhere + '
AND IsTemp = '+STR(@IsTemp)+' '
IF ISNULL(@IsLocation,'') <> '' SET @sWhere = @sWhere + '
AND IsLocation = '+@IsLocation+' '
IF ISNULL(@IsCommon, '') <> '' SET @sWhere = @sWhere + N'
AND IsCommon = '+@IsCommon+' '
IF ISNULL(@Disabled, '') <> '' SET @sWhere = @sWhere + N'
AND Disabled = '+@Disabled+' '

SET @sSQL = @sSQL + N'
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
APK, DivisionID, WareHouseID, WareHouseName, Address, FullName, IsTemp, IsLocation, IsCommon, [Disabled]
FROM AT1303 WITH (NOLOCK)
WHERE '+@sWhere +'
ORDER BY '+@OrderBy+' 
	
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

PRINT(@sSQL)
EXEC (@sSQL)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
