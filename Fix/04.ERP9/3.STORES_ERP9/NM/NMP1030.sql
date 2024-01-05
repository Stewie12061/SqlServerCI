IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP1030]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP1030]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load danh mục định mức dinh dưỡng (màn hình truy vấn)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
-- <History>
----Created by: Trà Giang, Date: 25/08/2018
-- <Example>
---- 
/*-- <Example>
--Lọc thường
	NMP1030 @DivisionID = 'BS', @DivisionList = 'BS', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25,  @QuotaNutritionID = '', 
	@QuotaNutritionName = '', @MenuTypeID='', @IsCommon = 0, @Disabled = 0,@SearchWhere=NULL
	
	NMP1030 @DivisionID, @DivisionList, @UserID, @PageNumber, @PageSize,  @QuotaNutritionID, @QuotaNutritionName, @IsCommon, @Disabled
--Lọc nâng cao
	NMP1030 @DivisionID = 'BS', @DivisionList = 'BS', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25,  @QuotaNutritionID = '', 
	@QuotaNutritionName = '', @MenuTypeID='', @IsCommon = 0, @Disabled = 0, @SearchWhere=N' where IsNull(QuotaNutritionID,'''') = N''asdas'''
----*/

CREATE PROCEDURE NMP1030
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @PageNumber INT,
	 @PageSize INT,
	 @QuotaNutritionID VARCHAR(50),
	 @QuotaNutritionName NVARCHAR(250),
	 @MenuTypeID VARCHAR(50),
	 @IsCommon VARCHAR(1),
	 @Disabled VARCHAR(1),
	  @UserID VARCHAR(50),
	  @SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
        @OrderBy NVARCHAR(500) = N'',
        @TotalRow NVARCHAR(50) = N'', 
		@LanguageID VARCHAR(50) 

        
SET @OrderBy = 'QuotaNutritionID'
SET @sWhere = ' 1 = 1 '
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
If Isnull(@SearchWhere, '') = '' --Lọc thường
		Begin
IF ISNULL(@DivisionList, '') != ''
	SET @sWhere = @sWhere + 'AND NMT1030.DivisionID IN ('''+@DivisionList+''',''@@@'') ' 
ELSE 
	SET @sWhere = @sWhere + 'AND NMT1030.DivisionID IN ('''+@DivisionID+''',''@@@'') ' 



	IF ISNULL(@QuotaNutritionID,'') != '' SET @sWhere = @sWhere + '
	AND NMT1030.QuotaNutritionID LIKE N''%'+@QuotaNutritionID+'%'' '		
	IF ISNULL(@QuotaNutritionName,'') != '' SET @sWhere = @sWhere + '
	AND NMT1030.QuotaNutritionName LIKE N''%'+@QuotaNutritionName+'%'' '
	IF ISNULL(@MenuTypeID,'') != '' SET @sWhere = @sWhere + '
	AND NMT1030.MenuTypeID LIKE N''%'+@MenuTypeID+'%'' '
	IF ISNULL(@Disabled, '') != '' SET @sWhere = @sWhere + N'
	AND NMT1030.Disabled = '+@Disabled+''
	IF ISNULL(@IsCommon, '') != '' SET @sWhere = @sWhere + N'
	AND NMT1030.IsCommon = '+@IsCommon+''
		--nếu giá trị NULL thì set về rổng 
		SET @SearchWhere = Isnull(@SearchWhere, '')
End	

	SET @sSQL = @sSQL + N'
	SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
	NMT1030.APK, NMT1030.DivisionID,NMT1030.QuotaNutritionID, NMT1030.QuotaNutritionName,NMT1030.MenuTypeID,NMT1020.MenuTypeName,
	NMT1030.Description,NMT1030.Disabled, NMT1030.IsCommon,NMT1030.CreateUserID,NMT1030.CreateDate,NMT1030.LastModifyUserID,NMT1030.LastModifyDate
	 INTO #NMP1030 
	FROM NMT1030 WITH (NOLOCK)
	LEFT JOIN NMT1020 WITH (NOLOCK) ON NMT1030.DivisionID=NMT1020.DivisionID AND NMT1020.MenuTypeID= NMT1030.MenuTypeID
	WHERE '+@sWhere +'

	Select  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow	
		,APK, DivisionID,QuotaNutritionID, QuotaNutritionName,MenuTypeID, 
	Description,Disabled, IsCommon,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate
			FROM #NMP1030 AS N
			'+@SearchWhere +'
			ORDER BY '+@OrderBy+'
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'



EXEC (@sSQL)
--PRINT(@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
