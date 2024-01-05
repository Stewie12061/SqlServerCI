IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[EDMP1040]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[EDMP1040]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Danh mục năm học EDMF1040 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Minh Hòa, Date: 15/09/2018
--- Modify by ...: Bổ sung ...
-- <Example>

/*-- <Example>
--Lọc thường 
   EXEC EDMP1040 @DivisionID='BE', @DivisionList = 'BE' , @UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,
	@SchoolYearID=NULL,@DateFrom =NULL, @DateTo =NULL, @IsCommon='', @Disabled='',@LanguageID ='vi-VN', @SearchWhere = N''

--Lọc nâng cao 
	EXEC EDMP1040 @DivisionID='BE', @DivisionList = 'BE' , @UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,
	@SchoolYearID=NULL,@DateFrom =NULL, @DateTo =NULL, @IsCommon='', @Disabled='',@LanguageID ='vi-VN', @SearchWhere = N' WHERE ISNULL(SchoolYearID,'''') = N''2015-2016'''

----*/

CREATE PROCEDURE EDMP1040
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @SchoolYearID VARCHAR(50),
	 @DateFrom DATETIME,
	 @DateTo DATETIME,
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


                
SET @OrderBy = 'SchoolYearID'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
SET @sWhere = '1 = 1 '

IF ISNULL(@SearchWhere, '') = '' --Lọc thường 
BEGIN 
		IF ISNULL(@DivisionList, '') <> ''
			SET @sWhere = @sWhere + 'AND EDMT1040.DivisionID IN ('''+@DivisionList+''', ''@@@'') ' 
		ELSE
			SET @sWhere = @sWhere + 'AND EDMT1040.DivisionID IN ('''+@DivisionID+''', ''@@@'') ' 

		IF @SchoolYearID IS NOT NULL 
		SET @sWhere = @sWhere + ' AND EDMT1040.SchoolYearID LIKE ''%'+@SchoolYearID+'%'' '


		IF ISNULL(@DateFrom, '') <> ''
		SET @sWhere = @sWhere + ' AND EDMT1040.DateFrom >= ''' + CONVERT(VARCHAR(10), @DateFrom, 112)+''' '
	
		IF ISNULL(@DateTo, '') <> ''
		SET @sWhere = @sWhere + ' AND EDMT1040.DateTo <= ''' + CONVERT(VARCHAR(10), @DateTo, 112) + ''' '

		IF ISNULL(@Disabled, '') <> ''
		SET @sWhere = @sWhere + ' AND EDMT1040.Disabled = '+@Disabled
		IF  ISNULL(@IsCommon, '') <> '' 
		SET @sWhere = @sWhere + ' AND EDMT1040.IsCommon = '+ @IsCommon

	--nếu giá trị NULL thì set về rổng 
	SET @SearchWhere = Isnull(@SearchWhere, '')
END 

SET @sSQL = '
	SELECT 
	EDMT1040.DivisionID, EDMT1040.APK, EDMT1040.SchoolYearID, EDMT1040.DateFrom, EDMT1040.DateTo, EDMT1040.Disabled, EDMT1040.IsCommon
	INTO #EDMP1040 
	FROM EDMT1040 WITH (NOLOCK)
	WHERE '+@sWhere +'
	ORDER BY '+@OrderBy+'

SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * 
FROM #EDMP1040 AS Temp
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

