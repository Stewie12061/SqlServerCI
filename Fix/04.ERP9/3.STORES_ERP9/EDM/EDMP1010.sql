IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1010]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP1010]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form EDMF1010: Danh mục định mức
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Văn Tình, Date: 28/08/2018
-- <Example>
---- 
/*
	EDMP1010 @DivisionID='MK', @DivisionList = '', @UserID='ASOFTADMIN', @LanguageID = 'vi-VN', @PageNumber=1 ,@PageSize=25,@IsSearch=1,
	@QuotaID=NULL,@Description=NULL, @Disabled=0, @IsCommon = null

	EDMP1010 @DivisionID='MK', @DivisionList = 'MK'', ''cz', @UserID='ASOFTADMIN', @LanguageID = 'vi-VN', @PageNumber=1 ,@PageSize=25,@IsSearch=1,
	@QuotaID=NULL,@Description=NULL, @Disabled=0, @IsCommon = null
*/

CREATE PROCEDURE [dbo].[EDMP1010]
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @LanguageID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @QuotaID VARCHAR(50),
	 @Disabled VARCHAR(10),
	 @IsCommon VARCHAR(10),
	 @SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường
)
AS 
SET NOCOUNT ON

DECLARE @sSQL NVARCHAR (MAX)='',
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
                

SET @OrderBy = 'QuotaID'
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
SET @sWhere = ' 1 = 1 '


IF ISNULL(@SearchWhere, '') = '' --Lọc thường 
BEGIN 
	IF ISNULL(@DivisionList, '') <> ''
		SET @sWhere = @sWhere + N'AND EDMT1010.DivisionID IN ('''+@DivisionList+''',''@@@'')'
	ELSE 
		SET @sWhere = @sWhere + N'AND EDMT1010.DivisionID IN ('''+@DivisionID+''',''@@@'')'

	IF ISNULL(@QuotaID,'') <> '' SET @sWhere = @sWhere + '
	AND EDMT1010.QuotaID LIKE N''%'+@QuotaID+'%'' '	
	IF ISNULL(@Disabled, '') <> '' SET @sWhere = @sWhere + N'
	AND EDMT1010.Disabled LIKE N''%'+@Disabled+'%'' '	
	IF ISNULL(@IsCommon, '') <> '' SET @sWhere = @sWhere + N'
	AND EDMT1010.IsCommon LIKE N''%'+@IsCommon+'%'' '

	--nếu giá trị NULL thì set về rổng 
	SET @SearchWhere = Isnull(@SearchWhere, '')
END

SET @sSQL = @sSQL + '
SELECT
	EDMT1010.DivisionID, EDMT1010.APK, EDMT1010.QuotaID, EDMT1010.Description,
	EDMT1010.CreateUserID +'' - ''+ (SELECT TOP 1 FullName FROM AT1103 WHERE EmployeeID = EDMT1010.CreateUserID) CreateUserID, EDMT1010.CreateDate, 
	EDMT1010.LastModifyUserID +'' - ''+ (SELECT TOP 1 FullName FROM AT1103 WHERE EmployeeID = EDMT1010.LastModifyUserID) LastModifyUserID, EDMT1010.LastModifyDate,
	EDMT1010.Disabled, EDMT1010.IsCommon
INTO #EDMP1010 
FROM EDMT1010 WITH (NOLOCK) 
WHERE ' + @sWhere + '
ORDER BY ' + @OrderBy + '

SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * 
FROM #EDMP1010 AS Temp
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

