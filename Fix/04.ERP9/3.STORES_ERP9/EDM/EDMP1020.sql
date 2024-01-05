IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[EDMP1020]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[EDMP1020]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Danh mục Lớp EDMF1020 
-- <Param>
---- 
-- <Return>r
---- 
-- <Reference>
---- 
-- <History>
----Created by: Minh Hòa, Date: 11/09/2018
--- Modify by ...: Bổ sung ...
-- <Example>

/*-- <Example>
	----Lọc thường 
	EXEC EDMP1020 @DivisionID='BE', @DivisionList='',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,
	 @LevelID=NULL,@GradeID=NULL,@QuotaID =NULL,@ClassID= NULL,@ClassName=NULL, @Disabled='', @IsCommon ='', @LanguageID ='vi-VN', @SearchWhere = ''
	 --Lọc nâng cao
	 EXEC EDMP1020 @DivisionID='BE', @DivisionList='BE',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,
	 @LevelID=NULL,@GradeID=NULL,@QuotaID =NULL,@ClassID= NULL,@ClassName=NULL, @Disabled=0, @IsCommon =0, @LanguageID ='vi-VN', @SearchWhere = N' WHERE ISNULL(ClassID,'''') = N''EST111'''

----*/

CREATE PROCEDURE EDMP1020
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @LevelID VARCHAR(50),
	 @GradeID VARCHAR(50),
     @QuotaID VARCHAR(50),
	 @ClassID VARCHAR(50),
	 @ClassName NVARCHAR(250),
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
            

SET @OrderBy = 'ClassID'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
SET @sWhere = ' 1 = 1 '

	IF ISNULL(@SearchWhere, '') = '' --Lọc thường 
	BEGIN 
IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + 'AND EDMT1020.DivisionID IN ('''+@DivisionList+''', ''@@@'') ' 
ELSE
	SET @sWhere = @sWhere + 'AND EDMT1020.DivisionID IN ('''+@DivisionID+''', ''@@@'') ' 

IF ISNULL(@LevelID, '') <> '' 
	SET @sWhere = @sWhere + N' AND EDMT1020.LevelID LIKE N''%'+@LevelID+'%'''

IF ISNULL(@GradeID, '') <> '' 
	SET @sWhere = @sWhere + N' AND EDMT1020.GradeID LIKE N''%'+@GradeID+'%'''

IF ISNULL(@QuotaID, '') <> '' 
	SET @sWhere = @sWhere + N' AND EDMT1020.QuotaID LIKE N''%'+@QuotaID+'%'''


IF ISNULL(@ClassID, '') <> '' 
SET @sWhere = @sWhere + N' AND EDMT1020.ClassID LIKE ''%'+@ClassID+'%'' '
IF ISNULL(@ClassName, '') <> '' 
SET @sWhere = @sWhere + ' AND EDMT1020.ClassName LIKE N''%'+@ClassName+'%'' '
IF ISNULL(@Disabled, '') <> '' 
SET @sWhere = @sWhere + N' AND EDMT1020.Disabled = '+@Disabled+''
IF ISNULL(@IsCommon, '') <> '' 
SET @sWhere = @sWhere + N' AND EDMT1020.IsCommon = '+@IsCommon+''

	--nếu giá trị NULL thì set về rổng 
	SET @SearchWhere = Isnull(@SearchWhere, '')
END 

SET @sSQL = '
	SELECT 
	EDMT1020.DivisionID, EDMT1020.APK, EDMT1020.ClassID, EDMT1020.ClassName, 
	'+ CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'EDMT0099.Description' ELSE 'EDMT0099.DescriptionE' END +' as LevelName, 
	EDMT1000.GradeName as GradeName,
	EDMT1020.QuotaID,
	EDMT1020.Disabled, EDMT1020.IsCommon
	INTO #EDMP1020 
	FROM EDMT1020 WITH (NOLOCK)
	LEFT JOIN EDMT0099 ON EDMT1020.LevelID = EDMT0099.ID AND EDMT0099.Disabled = 0 AND EDMT0099.CodeMaster=''Level''
	LEFT JOIN EDMT1000 ON EDMT1020.GradeID = EDMT1000.GradeID 
	--LEFT JOIN EDMT1010 ON EDMT1020.QuotaID= EDMT1010.QuotaID
	WHERE '+@sWhere +'
	ORDER BY '+@OrderBy+'

SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * 
FROM #EDMP1020 AS Temp
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

