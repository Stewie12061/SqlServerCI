IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2160]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2160]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Grid  Master phiếu dự thu học phí (Màn hình truy vấn)
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo , Date: 17/10/2018
-- <Example>
/*
---Lọc nâng cao 


---Lọc thường 
EXEC EDMP2160 @DivisionID = 'Be', @DivisionList = '',@EstimateID = '',@FromDate = '',@ToDate = '',
@GradeID= '',@ClassID= '',@SchoolYearID= '',@UserID = '', @PageNumber = 1, @PageSize = 25,@LanguageID= 'vi-VN', @SearchWhere = ''

EXEC EDMP2160 @DivisionID, @DivisionList,@EstimateID,@FromDate,@ToDate,@GradeID,@ClassID,@SchoolYearID,
@UserID, @PageNumber, @PageSize,@LanguageID, @SearchWhere

*/
CREATE PROCEDURE EDMP2160 ( 
        @DivisionID VARCHAR(50), 
		@DivisionList VARCHAR(MAX), 
		@EstimateID VARCHAR(50) ,
		@GradeID VARCHAR(50),
		@ClassID VARCHAR(50) ,
		@SchoolYearID  VARCHAR(50),
		@TranMonth VARCHAR(50),
		@TranYear VARCHAR(50),
		@FromDate DATETIME,
		@ToDate DATETIME ,
		@UserID  VARCHAR(50),
		@PageNumber INT,
		@PageSize INT,
		@LanguageID VARCHAR(50),
		@SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường
) 
AS 

DECLARE @sSQL NVARCHAR(MAX)= N'',
		@sWhere NVARCHAR(MAX) = N'',
		@OrderBy NVARCHAR(500) = N'', 
		@TotalRow NVARCHAR(50) = N''

SET @OrderBy = 'CreateDate DESC' 

SET @TotalRow = 'COUNT(*) OVER ()' 
SET @sWhere = ' 1 = 1 '

	IF ISNULL(@SearchWhere, '') = '' --Lọc thường 
	BEGIN 
IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + 'AND T01.DivisionID IN ('''+@DivisionList+''', ''@@@'') ' 
ELSE
	SET @sWhere = @sWhere + 'AND T01.DivisionID IN ('''+@DivisionID+''', ''@@@'') ' 
IF ISNULL(@EstimateID, '') <> '' 
	SET @sWhere = @sWhere + N' AND T01.EstimateID LIKE N''%'+@EstimateID+'%'''
IF ISNULL(@GradeID, '') <> '' 
	SET @sWhere = @sWhere + N' AND T01.GradeID  LIKE N''%'+@GradeID +'%'' '
IF ISNULL(@ClassID, '') <> '' 
	SET @sWhere = @sWhere + N' AND T01.ClassID  LIKE N''%'+@ClassID +'%'' '
IF ISNULL(@SchoolYearID, '') <> '' 
	SET @sWhere = @sWhere + N' AND T01.SchoolYearID  LIKE N''%'+@SchoolYearID +'%'' '
IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '') SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE, T01.EstimateDate,120), 126) >= '''+CONVERT(VARCHAR(10),@FromDate,126)+''' '
IF (ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '') SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE, T01.EstimateDate,120), 126) <= '''+CONVERT(VARCHAR(10),@ToDate,126)+''' '
IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '') SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE, T01.EstimateDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,126)+''' '


IF @TranMonth <> ''
	SET @sWhere = @sWhere + ' AND T01.TranMonth = '''+@TranMonth +''''

IF @TranYear <> '' 
	SET @sWhere = @sWhere + N' AND T01.TranYear = '''+@TranYear +''''


	--nếu giá trị NULL thì set về rổng 
	SET @SearchWhere = Isnull(@SearchWhere, '')
	END 

SET @sSQL =@sSQL + N'
SELECT 
T01.APK,T01.DivisionID,T01.EstimateID,T01.EstimateDate,T01.GradeID, T03.GradeName,
T01.ClassID, T04.ClassName,
T01.SchoolYearID + '' ('' + CONVERT(VARCHAR(10), T07.DateFrom, 103) + '' - '' + CONVERT(VARCHAR(10), T07.DateTo, 103) + '')'' AS SchoolYearID,
CAST (T01.TranMonth AS nvarchar)  + ''/'' + CAST (T01.TranYear AS nvarchar) AS MonthID, T01.CreateDate 
INTO #EDMP2160
FROM EDMT2160 T01 WITH (NOLOCK)
LEFT JOIN EDMT1000 T03  WITH (NOLOCK) ON T03.DivisionID IN (T01.DivisionID,''@@@'') AND T03.GradeID = T01.GradeID
LEFT JOIN EDMT1020 T04 WITH (NOLOCK) ON T04.DivisionID IN (T01.DivisionID,''@@@'') AND T04.ClassID = T01.ClassID
LEFT JOIN EDMT1040 T07 WITH(NOLOCK) ON T01.SchoolYearID = T07.SchoolYearID
WHERE '+@sWhere+' AND T01.DeleteFlg = 0
---ORDER BY '+@OrderBy+' 


SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * FROM #EDMP2160  AS Temp
'+@SearchWhere +'
ORDER BY '+@OrderBy+'
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

--PRINT @sSQL
EXEC (@sSQL)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
