IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1090]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP1090]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load danh mục biểu phí (màn hình truy vấn)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- ASOFT - EDM \ Danh mục \ Danh mục biểu phí
-- <History>
----Created by: Hồng Thảo on 06/09/2018
-- <Example>
---- 
/*-- <Example>
---Lọc thường 
	EXEC EDMP1090 @DivisionID ='BE',@DivisionList = 'BE',@UserID = '',@PageNumber = '1',@PageSize = '25', @FeeID = '',@FeeName = N'',@GradeID ='', @FromDate ='',@ToDate = '',
	@IsCommon ='',@Disabled ='',@SearchWhere=''
---Lọc nâng cao 
	EXEC EDMP1090 @DivisionID ='BE',@DivisionList = 'BE',@UserID = '',@PageNumber = '1',@PageSize = '25', @FeeID = '',@FeeName = N'',@GradeID ='', @FromDate ='',@ToDate = '',
	@IsCommon ='',@Disabled ='',@SearchWhere=N' WHERE ISNULL(FeeID,'''') = N''2222222222'''
	EDMP1090 @DivisionID,@DivisionList,@UserID,@PageNumber,@PageSize,@IsSearch, @FeeID,@FeeName,@GradeID, @FromDate,@ToDate,@IsCommon,@Disabled

	EDMP1090 @DivisionID,@DivisionList,@UserID ,@PageNumber,@PageSize, @FeeID ,@FeeName ,@GradeID, @FromDate,@ToDate,@IsCommon,@Disabled,@SearchWhere
----*/

CREATE PROCEDURE EDMP1090
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @FeeID VARCHAR(50),
	 @FeeName NVARCHAR(250),
	 @GradeID VARCHAR(50),
	 @SchoolYearID VARCHAR(50),
	 @IsCommon VARCHAR(50),
	 @Disabled VARCHAR(50),
	 @SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
        @OrderBy NVARCHAR(500) = N'',
        @TotalRow NVARCHAR(50) = N''
        
SET @OrderBy = 'FeeID'

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
SET @sWhere = '1 = 1 '

IF ISNULL(@SearchWhere, '') = '' --Lọc thường 
	BEGIN 
IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + 'AND EDMT1090.DivisionID IN ('''+@DivisionList+''',''@@@'') ' 
ELSE 
	SET @sWhere = @sWhere + 'AND EDMT1090.DivisionID IN ('''+@DivisionID+''',''@@@'') ' 

	IF ISNULL(@FeeID,'') <> '' SET @sWhere = @sWhere + '
	AND EDMT1090.FeeID LIKE N''%'+@FeeID+'%'' '	

	IF ISNULL(@FeeName,'') <> '' SET @sWhere = @sWhere + '
	AND EDMT1090.FeeName LIKE N''%'+@FeeName+'%'' '

	IF ISNULL(@SchoolYearID,'') <> '' SET @sWhere = @sWhere + '
	AND EDMT1090.SchoolYearID LIKE N''%'+@SchoolYearID+'%'' '

	IF ISNULL(@GradeID,'') <> '' SET @sWhere = @sWhere + '
	AND EDMT1090.GradeID LIKE N''%'+@GradeID+'%'' '

	IF ISNULL(@Disabled, '') <> '' SET @sWhere = @sWhere + N'
	AND EDMT1090.Disabled = '+@Disabled+''

	IF ISNULL(@IsCommon, '') <> '' SET @sWhere = @sWhere + N'
	AND EDMT1090.IsCommon = '+@IsCommon+''


	--nếu giá trị NULL thì set về rổng 
	SET @SearchWhere = Isnull(@SearchWhere, '')
END 

	SET @sSQL = @sSQL + N'
	 SELECT 
	 EDMT1090.APK, EDMT1090.DivisionID, EDMT1090.FeeID,EDMT1090.FeeName,
	 EDMT1090.SchoolYearID, E02.GradeName AS GradeID,
	 EDMT1090.[Disabled], EDMT1090.IsCommon
	 INTO #EDMP1090 
	 FROM EDMT1090 WITH (NOLOCK)
	 LEFT JOIN EDMT1000 E02 WITH (NOLOCK) ON E02.DivisionID IN ('''+@DivisionID+''',''@@@'') AND E02.GradeID = EDMT1090.GradeID
	 WHERE '+@sWhere +'
	 ORDER BY '+@OrderBy+' 
	
	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * 
	FROM #EDMP1090 AS Temp
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
