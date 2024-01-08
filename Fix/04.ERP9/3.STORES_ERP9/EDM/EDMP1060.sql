IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1060]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP1060]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load danh mục loại hoạt động (màn hình truy vấn)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- ASOFT - EDM \ Danh mục \ Danh mục loại hoạt động 
-- <History>
----Created by: Hồng Thảo, Date: 25/08/2018
-- <Example>
---- 
/*-- <Example>
---Lọc thường 
	EXEC EDMP1060 @DivisionID = 'BE', @DivisionList = 'BE', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @ActivityTypeID = '', 
	@ActivityTypeName = '', @IsCommon = '', @Disabled = '', @SearchWhere = N''

---Lọc nâng cao
	EXEC EDMP1060 @DivisionID = 'BE', @DivisionList = 'BE', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @ActivityTypeID = '', 
	@ActivityTypeName = '', @IsCommon = '', @Disabled = '',@SearchWhere = N' WHERE ISNULL(ActivityTypeID,'''') = N''DANGOAI'''
	
	EDMP1060 @DivisionID, @DivisionList, @UserID, @PageNumber, @PageSize, @ActivityTypeID, @ActivityTypeName, @IsCommon, @Disabled,@SearchWhere 
----*/

CREATE PROCEDURE EDMP1060
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @ActivityTypeID VARCHAR(50),
	 @ActivityTypeName NVARCHAR(250),
	 @IsCommon VARCHAR(50),
	 @Disabled VARCHAR(50),
	 @SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
        @OrderBy NVARCHAR(500) = N'',
        @TotalRow NVARCHAR(50) = N'' 


SET @OrderBy = 'ActivityTypeID'

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
SET @sWhere = ' 1 = 1 '

IF ISNULL(@SearchWhere, '') = '' --Lọc thường 
	BEGIN
		IF ISNULL(@DivisionList, '') <> ''
			SET @sWhere = @sWhere + 'AND EDMT1060.DivisionID IN ('''+@DivisionList+''',''@@@'') ' 
		ELSE 
		SET @sWhere = @sWhere + 'AND EDMT1060.DivisionID IN ('''+@DivisionID+''',''@@@'') '
		 
		IF ISNULL(@ActivityTypeID,'') <> '' 
			SET @sWhere = @sWhere + ' AND EDMT1060.ActivityTypeID LIKE N''%'+@ActivityTypeID+'%'' '		
		IF ISNULL(@ActivityTypeName,'') <> '' 
			SET @sWhere = @sWhere + ' AND EDMT1060.ActivityTypeName LIKE N''%'+@ActivityTypeName+'%'' '
		IF ISNULL(@Disabled, '') <> '' 
			SET @sWhere = @sWhere + N'AND EDMT1060.Disabled = '+@Disabled+''
		IF ISNULL(@IsCommon, '') <> '' 
			SET @sWhere = @sWhere + N' AND EDMT1060.IsCommon = '+@IsCommon+''
	
END 

	SET @sSQL = @sSQL + N'
	SELECT 
	EDMT1060.APK, EDMT1060.DivisionID,EDMT1060.ActivityTypeID, EDMT1060.ActivityTypeName,
	EDMT1060.Disabled, EDMT1060.IsCommon
	INTO #EDMP1060 
	FROM EDMT1060 WITH (NOLOCK)
	WHERE '+@sWhere +'
	ORDER BY '+@OrderBy+' 
	
	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * 
	FROM #EDMP1060 AS Temp
	'+@SearchWhere +'
	ORDER BY '+@OrderBy+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'



--PRINT(@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
