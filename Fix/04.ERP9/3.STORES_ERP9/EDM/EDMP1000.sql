IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[EDMP1000]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[EDMP1000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid Danh mục khối EDMF1000 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Minh Hòa, Date: 28/08/2018
--- Modify by ...: Bổ sung ...
-- <Example>

/*-- <Example>
----Lọc thường 
EXEC EDMP1000 @DivisionID='BE', @DivisionList = 'BE' , @UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,
@LevelID=NULL,@GradeID='',@GradeName =NULL,@Notes=NULL, @IsCommon=0, @Disabled=0, @LanguageID ='vi-VN',@SearchWhere ='' 
--Lọc nâng cao 
EXEC EDMP1000 @DivisionID='BE', @DivisionList = 'BE' , @UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,
@LevelID=NULL,@GradeID=NULL,@GradeName =NULL,@Notes=NULL, @IsCommon=0, @Disabled=0, @LanguageID ='vi-VN',@SearchWhere =N'WHERE ISNULL(GradeID,'''') = N''56533'''
----*/

CREATE PROCEDURE EDMP1000
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @LevelID VARCHAR(50),
	 @GradeID VARCHAR(50),
	 @GradeName NVARCHAR(250),
	 @Notes NVARCHAR(250),
	 @Disabled VARCHAR(1),
	 @IsCommon VARCHAR(1),
	 @LanguageID VARCHAR(50),
	 @SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường

)
AS 
DECLARE @sSQL NVARCHAR (MAX)= N'',
        @sWhere NVARCHAR(MAX)= N'',
        @OrderBy NVARCHAR(500)= N'',
        @TotalRow NVARCHAR(50)= N''

                
SET @OrderBy = 'GradeID'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
SET @sWhere = ' 1 = 1 '

IF ISNULL(@SearchWhere, '') = '' --Lọc thường 
BEGIN 
	IF ISNULL(@DivisionList, '') <> ''
		SET @sWhere = @sWhere + 'AND EDMT1000.DivisionID IN ('''+@DivisionList+''', ''@@@'') ' 
	ELSE
		SET @sWhere = @sWhere + 'AND EDMT1000.DivisionID IN ('''+@DivisionID+''', ''@@@'') ' 

	IF ISNULL(@LevelID,'') != '' SET @sWhere = @sWhere + '
	AND EDMT1000.LevelID LIKE ''%'+@LevelID+'%'' '
	IF ISNULL(@GradeID, '') <> '' SET @sWhere = @sWhere + '
	AND EDMT1000.GradeID LIKE ''%'+@GradeID+'%'' '
	IF ISNULL(@GradeName, '') <> '' SET @sWhere = @sWhere + '
	AND EDMT1000.GradeName LIKE N''%'+@GradeName+'%'' '
	IF ISNULL(@Disabled, '') <> '' SET @sWhere = @sWhere + '
	AND EDMT1000.Disabled = '+@Disabled
	IF ISNULL(@IsCommon, '') <> '' SET @sWhere = @sWhere + '
	AND EDMT1000.IsCommon = '+ @IsCommon

	--nếu giá trị NULL thì set về rổng 
	SET @SearchWhere = Isnull(@SearchWhere, '')
END 

SET @sSQL = '
	SELECT 
	EDMT1000.DivisionID, EDMT1000.APK, '+ CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'EDMT0099.Description' ELSE 'EDMT0099.DescriptionE' END +' as LevelName, EDMT1000.GradeID, 
	EDMT1000.GradeName, EDMT1000.Notes,EDMT1000.Disabled, EDMT1000.IsCommon
	INTO #EDMP1000 
	FROM EDMT1000 WITH (NOLOCK)
	LEFT JOIN EDMT0099 ON EDMT1000.LevelID = EDMT0099.ID AND EDMT0099.Disabled = 0 AND EDMT0099.CodeMaster=''Level''
	WHERE '+@sWhere +'
	ORDER BY '+@OrderBy+'


	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * 
	FROM #EDMP1000 AS Temp
	'+@SearchWhere +'
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

