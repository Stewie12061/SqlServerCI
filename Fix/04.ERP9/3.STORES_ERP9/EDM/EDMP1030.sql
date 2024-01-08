IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[EDMP1030]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[EDMP1030]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Danh mục môn học EDMF1030 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Minh Hòa, Date: 12/09/2018
--- Modify by ...: Bổ sung ...
-- <Example>

/*-- <Example>
---Lọc thường 
	EXEC EDMP1030 @DivisionID='BE', @DivisionList = 'BE' , @UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,
	@SubjectID=NULL,@SubjectName =NULL,@Notes=NULL, @IsCommon='', @Disabled='',@LanguageID='vi-VN', @SearchWhere = N''
---Lọc nâng cao 
	EXEC EDMP1030 @DivisionID='BE', @DivisionList = 'BE' , @UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,
	@SubjectID=NULL,@SubjectName =NULL,@Notes=NULL, @IsCommon='', @Disabled='',@LanguageID='vi-VN',@SearchWhere = N' WHERE ISNULL(SubjectID,'''') = N''TDS'''

----*/

CREATE PROCEDURE EDMP1030
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @SubjectID VARCHAR(50),
	 @SubjectName NVARCHAR(250),
	 @Notes NVARCHAR(250),
	 @Disabled VARCHAR(50),
	 @IsCommon VARCHAR(50),
	 @LanguageID VARCHAR(50),
	 @SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường

)
AS 
DECLARE @sSQL NVARCHAR (MAX)= N'',
        @sWhere NVARCHAR(MAX)= N'',
        @OrderBy NVARCHAR(500)= N'',
        @TotalRow NVARCHAR(50)= N''	
		
		                
SET @OrderBy = 'SubjectID'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
SET @sWhere = ' 1 = 1 '


IF ISNULL(@SearchWhere, '') = '' --Lọc thường 
BEGIN 
		IF ISNULL(@DivisionList, '') <> ''
			SET @sWhere = @sWhere + 'AND EDMT1030.DivisionID IN ('''+@DivisionList+''', ''@@@'') ' 
		ELSE
			SET @sWhere = @sWhere + 'AND EDMT1030.DivisionID IN ('''+@DivisionID+''', ''@@@'') ' 

		IF ISNULL(@SubjectID, '') <> ''
		SET @sWhere = @sWhere + ' AND EDMT1030.SubjectID LIKE ''%'+@SubjectID+'%'' '
		IF ISNULL(@SubjectName, '') <> ''
		SET @sWhere = @sWhere + ' AND EDMT1030.SubjectName LIKE N''%'+@SubjectName+'%'' '
		IF ISNULL(@Disabled, '') <> '' 
		SET @sWhere = @sWhere + N' AND EDMT1030.Disabled = '+@Disabled+''
		IF ISNULL(@IsCommon, '') <> '' 
		SET @sWhere = @sWhere + N' AND EDMT1030.IsCommon = '+@IsCommon+''

	--nếu giá trị NULL thì set về rổng 
	SET @SearchWhere = Isnull(@SearchWhere, '')
END

SET @sSQL = '
	SELECT 
	EDMT1030.DivisionID, EDMT1030.APK, EDMT1030.SubjectID, EDMT1030.SubjectName, EDMT1030.Notes,EDMT1030.Disabled, EDMT1030.IsCommon
	INTO #EDMP1030
	FROM EDMT1030 WITH (NOLOCK)
	WHERE '+@sWhere +'
	ORDER BY '+@OrderBy+'

SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * 
FROM #EDMP1030 AS Temp
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

