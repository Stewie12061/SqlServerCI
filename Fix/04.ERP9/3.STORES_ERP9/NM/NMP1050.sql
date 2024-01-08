IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP1050]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP1050]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load danh mục món ăn
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----	
-- <History>
----Created by: Trà Giang, Date: 27/08/2018
---- Modified by on
-- <Example>
---- 
/*-- <Example>
--Lọc thường
	NMP1050 @DivisionID = 'BS', @DivisionList = 'BS', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @DishTypeID = '', 
	@DishID = '',@DishName = '', @IsCommon = 0, @Disabled = 0,@SearchWhere=NULL
-- Lọc nâng cao
	NMP1050 @DivisionID = 'BS', @DivisionList = 'BS', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @DishTypeID = '', 
	@DishID = '',@DishName = '', @IsCommon = 0, @Disabled = 0,@SearchWhere=N' where IsNull(DishID,'''') = N''MA05'''
	
----*/

CREATE PROCEDURE NMP1050
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @DishID VARCHAR(50),
	 @DishName VARCHAR(50),
	 @DishTypeID NVARCHAR(250),
	 @Disabled VARCHAR(1),
	 @IsCommon VARCHAR(1),
	 @SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
        @OrderBy NVARCHAR(500) = N'',
        @TotalRow NVARCHAR(50) = N'',
		@LanguageID VARCHAR(50) 
        
SET @OrderBy = 'DishID'
SET  @sWhere = ' 1 = 1 '
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
If Isnull(@SearchWhere, '') = '' --Lọc thường
		Begin
IF ISNULL(@DivisionList, '') != ''
	SET @sWhere = @sWhere + 'AND NMT1050.DivisionID IN ('''+@DivisionList+''', ''@@@'') ' 
ELSE
	SET @sWhere = @sWhere + 'AND NMT1050.DivisionID IN ('''+@DivisionID+''', ''@@@'') ' 

IF ISNULL(@DishTypeID,'') != '' SET @sWhere = @sWhere + '
AND NMT1050.DishTypeID LIKE N''%'+@DishTypeID+'%'' '	
IF ISNULL(@DishID,'') != '' SET @sWhere = @sWhere + '
AND NMT1050.DishID LIKE N''%'+@DishID+'%'' '
IF ISNULL(@DishName,'') != '' SET @sWhere = @sWhere + '
AND NMT1050.DishName LIKE N''%'+@DishName+'%'' '
IF ISNULL(@Disabled, '') != '' SET @sWhere = @sWhere + N'
AND NMT1050.Disabled = '+@Disabled+''
IF ISNULL(@IsCommon, '') != '' SET @sWhere = @sWhere + N'
AND NMT1050.IsCommon = '+@IsCommon+''
	--nếu giá trị NULL thì set về rổng 
		SET @SearchWhere = Isnull(@SearchWhere, '')
End	
	

SET @sSQL = @sSQL + N'
					SELECT NMT1050.APK, NMT1050.DivisionID,NMT1050.DishID,NMT1050.DishName,NMT1050.DishTypeID,NMT1050.Description, IsCommon, [Disabled],NMT1050.CreateUserID,
					NMT1050.CreateDate,NMT1050.LastModifyUserID,NMT1050.LastModifyDate
					INTO #NMP1050
					FROM NMT1050 WITH (NOLOCK)
					WHERE '+@sWhere +'


					SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow	
					,APK,DivisionID,DishID,DishName,DishTypeID,Description, IsCommon, Disabled,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate
					FROM #NMP1050 AS N
					'+@SearchWhere +'
					ORDER BY '+@OrderBy+'
					OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
					FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'



EXEC (@sSQL)
PRINT(@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
