IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP1060]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP1060]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Grid Form NMF1060 : Danh mục bữa ăn
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
   EXEC NMP1060 'BS','BS','',1,25,'','',0,0,NULL
   --Lọc nâng cao
    EXEC NMP1060 'BS','BS','',1,25,'','',0,0,N' where IsNull(MealID,'''') = N''B01'''

*/

CREATE PROCEDURE NMP1060



( 
	@DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	@UserID VARCHAR(50),
	@PageNumber INT,
	@PageSize INT,
	@MealID VARCHAR(50),
	@MealName NVARCHAR(250),
	 @Disabled VARCHAR(1),
	 @IsCommon VARCHAR(1),
	 @SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường
)
AS 
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
                
SET @sWhere = ' 1 = 1 '
SET @TotalRow = ''
SET @OrderBy = 'MealID ASC'
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

        
If Isnull(@SearchWhere, '') = '' --Lọc thường
Begin

IF ISNULL(@DivisionList, '') != ''
	SET @sWhere = @sWhere + ' AND NM6.DivisionID IN ('''+@DivisionList+''', ''@@@'') ' 
ELSE 
	SET @sWhere = @sWhere + 'AND NM6.DivisionID IN ('''+@DivisionID+''', ''@@@'') '
	
	IF Isnull(@MealID, '') != '' 
		SET @sWhere = @sWhere + ' AND ISNULL(NM6.MealID, '''') LIKE N''%'+@MealID+'%'''
	IF Isnull(@MealName, '') != '' 
		SET @sWhere = @sWhere + ' AND ISNULL(NM6.MealName, '''') LIKE N''%'+@MealName+'%'''
	IF ISNULL(@Disabled, '') != '' SET @sWhere = @sWhere + N'
AND NM6.Disabled = '+@Disabled+''
IF ISNULL(@IsCommon, '') != '' SET @sWhere = @sWhere + N'
AND NM6.IsCommon = '+@IsCommon+''
	--nếu giá trị NULL thì set về rổng 
		SET @SearchWhere = Isnull(@SearchWhere, '')
End	

SET @sSQL = '
			SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
				NM6.APK,NM6.DivisionID, NM6.MealID,NM6.MealName,NM6.Description, NM6.Disabled, NM6.IsCommon   
				INTO #NMP1060   
				FROM NMT1060 NM6
				WHERE  '+@sWhere+'

			SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow	
			,APK,DivisionID, MealID,MealName,Description, Disabled, IsCommon   
			FROM #NMP1060 AS N
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
