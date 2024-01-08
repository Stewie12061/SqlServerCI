IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1070]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP1070]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load danh mục điều tra tâm lý (màn hình truy vấn)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----	
-- <History>
----Created by: Hồng Thảo, Date: 27/08/2018
---- Modified by on
-- <Example>
---- 
/*-- <Example>
---Lọc thường 
	EXEC EDMP1070 @DivisionID = 'BE', @DivisionList = 'BE', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @PsychologizeType = '', 
	@PsychologizeID = '',@PsychologizeName = '',@PsychologizeGroup = '', @IsCommon = '', @Disabled = '',@LanguageID = 'vi-VN',@SearchWhere = N''
---Lọc nâng cao 
	EXEC EDMP1070 @DivisionID = 'BE', @DivisionList = 'BE', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @PsychologizeType = '', 
	@PsychologizeID = '',@PsychologizeName = '',@PsychologizeGroup = '', @IsCommon = '', @Disabled = '',@LanguageID = 'vi-VN',@SearchWhere = N' WHERE ISNULL(PsychologizeID,'''') = N''DC123'''
	
	EDMP1070 @DivisionID, @DivisionList, @UserID, @PageNumber, @PageSize, @IsSearch, @PsychologizeType,@PsychologizeID,@PsychologizeName,@PsychologizeGroup, @IsCommon, @Disabled,@LanguageID,@SearchWhere
----*/

CREATE PROCEDURE EDMP1070
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @PsychologizeType VARCHAR(50),
	 @PsychologizeID VARCHAR(50),
	 @PsychologizeName NVARCHAR(250),
	 @PsychologizeGroup VARCHAR(50),
	 @Disabled VARCHAR(50),
	 @IsCommon VARCHAR(50),
	 @LanguageID VARCHAR(50),
	 @SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
        @OrderBy NVARCHAR(500) = N'',
        @TotalRow NVARCHAR(50) = N''
        
SET @OrderBy = 'PsychologizeID'

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
SET @sWhere = ' 1 = 1 '

IF ISNULL(@SearchWhere, '') = '' --Lọc thường 
	BEGIN 
IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + 'AND EDMT1070.DivisionID IN ('''+@DivisionList+''', ''@@@'') ' 
ELSE
	SET @sWhere = @sWhere + 'AND EDMT1070.DivisionID IN ('''+@DivisionID+''', ''@@@'') ' 

IF ISNULL(@PsychologizeType,'') <> '' SET @sWhere = @sWhere + '
AND EDMT1070.PsychologizeType LIKE N''%'+@PsychologizeType+'%'' '	
IF ISNULL(@PsychologizeID,'') <> '' SET @sWhere = @sWhere + '
AND EDMT1070.PsychologizeID LIKE N''%'+@PsychologizeID+'%'' '
IF ISNULL(@PsychologizeName,'') <> '' SET @sWhere = @sWhere + '
AND EDMT1070.PsychologizeName LIKE N''%'+@PsychologizeName+'%'' '
IF ISNULL(@PsychologizeGroup,'') <> '' SET @sWhere = @sWhere + '
AND EDMT1070.PsychologizeGroup LIKE N''%'+@PsychologizeGroup+'%'' '
IF ISNULL(@Disabled, '') <> '' SET @sWhere = @sWhere + N'
AND EDMT1070.Disabled LIKE N''%'+@Disabled+'%'' '
IF ISNULL(@IsCommon, '') <> '' SET @sWhere = @sWhere + N'
AND EDMT1070.IsCommon LIKE N''%'+@IsCommon+'%'' '

	--nếu giá trị NULL thì set về rổng 
	SET @SearchWhere = Isnull(@SearchWhere, '')
END 

SET @sSQL = @sSQL + N'
SELECT 
EDMT1070.APK, EDMT1070.DivisionID, EDMT1070.PsychologizeType, '+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'E03.Description' ELSE 'E03.DescriptionE' END+' AS PsychologizeTypeName,
EDMT1070.PsychologizeID,EDMT1070.PsychologizeName,EDMT1070.PsychologizeGroup, E04.PsychologizeName AS PsychologizeGroupName, EDMT1070.IsCommon, EDMT1070.[Disabled]
INTO #EDMP1070 
FROM EDMT1070 WITH (NOLOCK)
LEFT JOIN EDMT0099 E03 WITH (NOLOCK) ON EDMT1070.PsychologizeType = E03.ID AND E03.CodeMaster = ''PsychologizeType''
LEFT JOIN EDMT1070 E04 WITH (NOLOCK) ON E04.DivisionID IN (EDMT1070.DivisionID,''@@@'') AND EDMT1070.PsychologizeGroup = E04.PsychologizeID
WHERE '+@sWhere +'
ORDER BY '+@OrderBy+' 
	
SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * 
FROM #EDMP1070 AS Temp
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
