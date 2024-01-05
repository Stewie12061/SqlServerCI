IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2090]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2090]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid lịch học năm (Màn hình truy vấn)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo , Date: 11/09/2018
-- <Example>
/*
---Lọc nâng cao 
EXEC EDMP2090 @DivisionID=N'BE',@UserID=N'HONGTHAO',@DivisionList=N'',@YearlyScheduleID=N'',@TermID=N'',@FromDateSchedule=NULL,@ToDateSchedule=NULL,@PageNumber=1,@PageSize=25,
@SearchWhere=N' where IsNull(YearlyScheduleID,'''') = N''LHN/2019/02/0002'''

--Lọc thường 
EXEC EDMP2090 @DivisionID=N'BE',@UserID=N'HONGTHAO',@DivisionList=N'',@YearlyScheduleID=N'',@TermID=N'',@FromDateSchedule=NULL,@ToDateSchedule=NULL,@PageNumber=1,@PageSize=25,
@SearchWhere=N''

EXEC EDMP2090 @DivisionID, @DivisionList,@YearlyScheduleID,@TermID,@FromDateSchedule,@ToDateSchedule, @IsSearch, @UserID, @PageNumber, @PageSize, @SearchWhere

*/
CREATE PROCEDURE EDMP2090 ( 
        @DivisionID VARCHAR(50), 
		@DivisionList VARCHAR(MAX), 
		@YearlyScheduleID VARCHAR(50), 
		@TermID VARCHAR(50),  
		@FromDateSchedule DATETIME,
		@ToDateSchedule DATETIME,  
		@UserID  VARCHAR(50),
		@PageNumber INT,
		@PageSize INT,
		@SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường
) 
AS 

DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX) = N'',
		@OrderBy NVARCHAR(500) = N'', 
		@TotalRow NVARCHAR(50) = N''

	IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	SET @OrderBy = 'YearlyScheduleID'
	SET @sWhere = ' 1 = 1 '

	IF ISNULL(@SearchWhere, '') = '' --Lọc thường 
	BEGIN 
	IF ISNULL(@DivisionList, '') <> ''
		SET @sWhere = @sWhere + N'AND T1.DivisionID IN ('''+@DivisionList+''')'
	ELSE 
		SET @sWhere = @sWhere + N'AND T1.DivisionID = '''+@DivisionID+''''
	IF ISNULL(@YearlyScheduleID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.YearlyScheduleID LIKE N''%'+@YearlyScheduleID+'%'''
	IF ISNULL(@TermID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.TermID LIKE N''%'+@TermID+'%'''
	IF (ISNULL(@FromDateSchedule, '') <> '' AND ISNULL(@ToDateSchedule, '') = '') SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.DateSchedule,120), 126) >= '''+CONVERT(VARCHAR(10),@FromDateSchedule,126)+''' '
	IF (ISNULL(@FromDateSchedule, '') = '' AND ISNULL(@ToDateSchedule, '') <> '') SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.DateSchedule,120), 126) <= '''+CONVERT(VARCHAR(10),@ToDateSchedule,126)+''' '
	IF (ISNULL(@FromDateSchedule, '') <> '' AND ISNULL(@ToDateSchedule, '') <> '') SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.DateSchedule,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDateSchedule,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDateSchedule,126)+''' '

	--nếu giá trị NULL thì set về rổng 
	SET @SearchWhere = Isnull(@SearchWhere, '')
	END 

SET @sSQL = N'
SELECT T1.APK,T1.DivisionID,T1.YearlyScheduleID,T1.DateSchedule, T1.[Description],
T1.TermID + '' ('' + CONVERT(VARCHAR(10), T2.DateFrom, 103) + '' - '' + CONVERT(VARCHAR(10), T2.DateTo, 103) + '')'' AS TermID
INTO #EDMP2090
FROM EDMT2090 T1  WITH (NOLOCK)
LEFT JOIN EDMT1040 T2 WITH(NOLOCK) ON T1.TermID = T2.SchoolYearID
WHERE '+@sWhere+' AND T1.DeleteFlg = 0
GROUP BY T1.APK,T1.DivisionID,T1.YearlyScheduleID,T1.DateSchedule,T1.TermID, T1.[Description],T1.TermID,T2.DateFrom,T2.DateTo

SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * 
FROM #EDMP2090 AS Temp
'+@SearchWhere +'
ORDER BY '+@OrderBy+'
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'


PRINT @sSQL
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
