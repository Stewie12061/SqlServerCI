IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1080]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP1080]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load danh mục Feeling (Màn hình truy vấn)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- ASOFT - EDM \ Danh mục \ Danh mục Feeling
-- <History>
----Created by: Hồng Thảo, Date: 25/08/2018
-- <Example>
---- 
/*-- <Example>
----Lọc thường 
	EXEC EDMP1080 @DivisionID = 'BE', @DivisionList = 'BE', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @FeelingID = '', 
	@FeelingName = '', @IsCommon = '', @Disabled = '',@SearchWhere = N''
---Lọc nâng cao 
	EXEC EDMP1080 @DivisionID = 'BE', @DivisionList = 'BE', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @FeelingID = '', 
	@FeelingName = '', @IsCommon = '', @Disabled = '',@SearchWhere = N' WHERE ISNULL(FeelingID,'''') = N''DASDASD'''
	
	EDMP1080 @DivisionID, @DivisionList, @UserID, @PageNumber, @PageSize, @IsSearch, @FeelingID, @FeelingName, @IsCommon, @Disabled
----*/

CREATE PROCEDURE EDMP1080
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @FeelingID VARCHAR(50),
	 @FeelingName NVARCHAR(250),
	 @IsCommon VARCHAR(50),
	 @Disabled VARCHAR(50),
	 @SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
        @OrderBy NVARCHAR(500) = N'',
        @TotalRow NVARCHAR(50) = N''


        
SET @OrderBy = 'FeelingID'

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
SET @sWhere = ' 1 = 1 '

IF ISNULL(@SearchWhere, '') = '' --Lọc thường 
BEGIN 
		IF ISNULL(@DivisionList, '') <> ''
			SET @sWhere = @sWhere + 'AND EDMT1080.DivisionID IN ('''+@DivisionList+''', ''@@@'') ' 
		ELSE 
			SET @sWhere = @sWhere + 'AND EDMT1080.DivisionID IN ('''+@DivisionID+''',''@@@'') ' 

		IF ISNULL(@FeelingID,'') <> '' 
			SET @sWhere = @sWhere + ' AND EDMT1080.FeelingID LIKE N''%'+@FeelingID+'%'' '		
		IF ISNULL(@FeelingName,'') <> '' 
			SET @sWhere = @sWhere + ' AND EDMT1080.FeelingName LIKE N''%'+@FeelingName+'%'' '
		IF ISNULL(@Disabled, '') <> '' 
			SET @sWhere = @sWhere + N' AND EDMT1080.Disabled  LIKE N''%'+@Disabled+'%'' '
		IF ISNULL(@IsCommon, '') <> '' 
			SET @sWhere = @sWhere + N' AND EDMT1080.IsCommon LIKE N''%'+@IsCommon+'%'' '

	--nếu giá trị NULL thì set về rổng 
	SET @SearchWhere = Isnull(@SearchWhere, '')
	
END

	SET @sSQL = @sSQL + N'
	SELECT 
	EDMT1080.APK, EDMT1080.DivisionID,EDMT1080.FeelingID, EDMT1080.FeelingName,EDMT1080.Disabled, EDMT1080.IsCommon
	INTO #EDMP1080
	FROM EDMT1080 WITH (NOLOCK)
	WHERE '+@sWhere +'
	ORDER BY '+@OrderBy+' 
	
	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * 
	FROM #EDMP1080 AS Temp
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
