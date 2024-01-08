IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2100]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2100]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid lịch học cơ sở (Màn hình truy vấn)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo , Date: 12/09/2018
-- <Example>
/*
----Lọc nâng cao 
EXEC EDMP2100 @DivisionID = 'BE', @DivisionList = '', @DailyScheduleID = '',@TermID = '', @GradeID ='', @FromDateSchedule = '',@ToDateSchedule = '', @UserID = '', @PageNumber = 1, @PageSize = 25, 
@SearchWhere =N' WHERE ISNULL(DailyScheduleID,'''') = N''LHN/2019/03/0001'''

----Lọc thường 
EXEC EDMP2100 @DivisionID = 'BE', @DivisionList = '', @DailyScheduleID = '',@TermID = '', @GradeID ='', @FromDateSchedule = '',@ToDateSchedule = '', @UserID = '', @PageNumber = 1, @PageSize = 25, @SearchWhere = ''
*/
CREATE PROCEDURE EDMP2100 ( 
        @DivisionID VARCHAR(50), 
		@DivisionList VARCHAR(MAX), 
		@DailyScheduleID VARCHAR(50), 
		@TermID VARCHAR(50), 
		@GradeID VARCHAR(50),
		@ClassID VARCHAR(50),
		@FromDateSchedule DATETIME,
		@ToDateSchedule DATETIME,  
		@UserID  VARCHAR(50),
		@PageNumber INT,
		@PageSize INT,
		@SearchWhere NVARCHAR(MAX) = NULL--#NULL: Lọc nâng cao; =NULL: Lọc thường
) 
AS 

DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX) = N'',
		@OrderBy NVARCHAR(500) = N'', 
		@TotalRow NVARCHAR(50) = N''

	IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	SET @OrderBy = 'DailyScheduleID'
	SET @sWhere = ' 1 = 1 '

IF ISNULL(@SearchWhere, '') = '' --Lọc thường
BEGIN 

	IF ISNULL(@DivisionList, '') <> ''
		SET @sWhere = @sWhere + N' AND T1.DivisionID IN ('''+@DivisionList+''')'
	ELSE 
		SET @sWhere = @sWhere + N' AND T1.DivisionID = '''+@DivisionID+''''
	IF ISNULL(@DailyScheduleID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.DailyScheduleID LIKE N''%'+@DailyScheduleID+'%'''
	IF ISNULL(@TermID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.TermID LIKE N''%'+@TermID+'%'''
	IF ISNULL(@GradeID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.GradeID  LIKE N''%'+@GradeID +'%'''
	IF ISNULL(@ClassID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.ClassID  LIKE N''%'+@ClassID +'%'''
	--IF (ISNULL(@FromDateSchedule, '') <> '' AND ISNULL(@ToDateSchedule, '') = '') SET @sWhere = @sWhere + '
	--AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.DateSchedule,120), 126) >= '''+CONVERT(VARCHAR(10),@FromDateSchedule,126)+''' '
	--IF (ISNULL(@FromDateSchedule, '') = '' AND ISNULL(@ToDateSchedule, '') <> '') SET @sWhere = @sWhere + '
	--AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.DateSchedule,120), 126) <= '''+CONVERT(VARCHAR(10),@ToDateSchedule,126)+''' '
	--IF (ISNULL(@FromDateSchedule, '') <> '' AND ISNULL(@ToDateSchedule, '') <> '') SET @sWhere = @sWhere + '
	--AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.DateSchedule,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDateSchedule,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDateSchedule,126)+''' '

	--nếu giá trị NULL thì set về rổng 
	SET @SearchWhere = Isnull(@SearchWhere, '')
END 

SET @sSQL = N' 
SELECT T1.APK,T1.DivisionID,T1.DailyScheduleID,T1.DateSchedule, 
T1.GradeID, T2.GradeName, T1.ClassID, T4.ClassName, 
T1.[Description],
T1.TermID
INTO #EDMP2100 
FROM EDMT2100 T1  WITH (NOLOCK)
LEFT JOIN EDMT1000 T2 WITH (NOLOCK) ON T2.GradeID = T1.GradeID
LEFT JOIN EDMT1040 T3 WITH(NOLOCK) ON T1.TermID = T3.SchoolYearID
LEFT JOIN EDMT1020 T4 WITH (NOLOCK) ON T4.ClassID = T1.ClassID

WHERE '+@sWhere+' AND T1.DeleteFlg = 0

SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * FROM #EDMP2100  AS Temp
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


