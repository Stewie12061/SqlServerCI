IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP1040]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP1040]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Grid Form NMP1040 : Danh mục loại món ăn
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Trà Giang Date: 21/08/2018
-- <Example>
---- 
/*
--Lọc thường
   EXEC NMP1040 'BE','','',1,25,'','',0,0,NULL
   --Lọc nâng cao
    EXEC NMP1040 'BE','','',1,25,'','',0,0,N' where IsNull(DishTypeID,'''') = N''M'''
	
*/

CREATE PROCEDURE NMP1040
( 
	@DivisionID VARCHAR(50),
	@DivisionList VARCHAR(MAX),
	@UserID VARCHAR(50),
	@PageNumber INT,
	@PageSize INT,
	@DishTypeID VARCHAR(50),
	@DishTypeName NVARCHAR(250),
	 @Disabled VARCHAR(1),
	 @IsCommon VARCHAR(1),
	@SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường
)
AS 
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
                
SET @TotalRow = ''
SET @sWhere = ' 1 = 1 '
SET @OrderBy = 'NM4.DishTypeID ASC'
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

If Isnull(@SearchWhere, '') = '' --Lọc thường
		Begin

IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + 'AND NM4.DivisionID IN ('''+@DivisionList+''',''@@@'') ' 
ELSE 
	SET @sWhere = @sWhere + 'AND NM4.DivisionID IN ('''+@DivisionID+''',''@@@'') ' 
	IF ISNULL(@DishTypeID,'') <> '' 
		SET @sWhere = @sWhere + 'AND NM4.DishTypeID LIKE N''%'+@DishTypeID+'%'' '		
	 IF Isnull(@DishTypeName, '') != '' 
		SET @sWhere = @sWhere + ' AND ISNULL(NM4.DishTypeName, '''') LIKE N''%'+@DishTypeName+'%'''
	IF ISNULL(@Disabled, '') <> '' SET @sWhere = @sWhere + '
	AND NM4.Disabled = '+@Disabled
	IF ISNULL(@IsCommon, '') <> '' SET @sWhere = @sWhere + '
	AND NM4.IsCommon = '+ @IsCommon
	
	--nếu giá trị NULL thì set về rổng 
		SET @SearchWhere = Isnull(@SearchWhere, '')
End	

SET @sSQL = '
	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
	NM4.APK,NM4.DivisionID,NM4.DishTypeID,NM4.DishTypeName,NM4.Description, NM4.[Disabled], NM4.IsCommon    
	INTO #NMP1040  
	FROM NMT1040 NM4
	WHERE  '+@sWhere+'

	Select  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow	
	,APK,DivisionID	,DishTypeID,DishTypeName,Description, Disabled, IsCommon    
			FROM #NMP1040 AS NM4
			'+@SearchWhere +'
		ORDER BY '+@OrderBy+'
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

EXEC (@sSQL)
--PRINT @sSQL


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
