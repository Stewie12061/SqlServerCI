IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2150]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2150]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Bảo lưu (Màn hình truy vấn)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo , Date: 12/10/2018
-- <Example>
/*
---Lọc nâng cao 
EXEC EDMP2150 @DivisionID = 'BE', @DivisionList = '',@ReserveID = '',@ReserveDate= '',@ProposerID = '',@SchoolYearID = '',  @GradeID='',@ClassID='',
@StudentID = '',@FromDateReserve = '',@ToDateReserve = '',@UserID = '', @PageNumber = 1, @PageSize = 25, @SearchWhere =N'WHERE ISNULL(ReserveID,'''') = N''BL/0/00/0000001'''

---Lọc thường 
EXEC EDMP2150 @DivisionID = 'BE', @DivisionList = '',@ReserveID = '',@ReserveDate= '',@ProposerID = '',@SchoolYearID = '',  @GradeID='',@ClassID='',
@StudentID = '',@FromDateReserve = '',@ToDateReserve = '',@UserID = '', @PageNumber = 1, @PageSize = 25, @SearchWhere = ''

EXEC EDMP2150 @DivisionID, @DivisionList,@ReserveID,@ReserveDate,@ProposerID,@SchoolYearID,@GardeID,@CLassID,@StudentID,@FromDateReserve,@ToDateReserve,@UserID, @PageNumber, @PageSize, @SearchWhere

*/
CREATE PROCEDURE EDMP2150 ( 
        @DivisionID VARCHAR(50), 
		@DivisionList VARCHAR(MAX), 
		@ReserveID VARCHAR(50), 
		@ReserveDate DATETIME, 
		@ProposerID VARCHAR(50),
		@SchoolYearID  VARCHAR(50),
		@GradeID VARCHAR(50), 
		@ClassID VARCHAR (50),
		@StudentID VARCHAR(50),
		@FromDateReserve DATETIME,
		@ToDateReserve DATETIME,  
		@UserID  VARCHAR(50),
		@PageNumber INT,
		@PageSize INT,
		@SearchWhere NVARCHAR(MAX) = NULL  --#NULL: Lọc nâng cao; =NULL: Lọc thường
) 
AS 

DECLARE @sSQL NVARCHAR(MAX)= N'',
		@sWhere NVARCHAR(MAX) = N'',
		@OrderBy NVARCHAR(500) = N'', 
		@TotalRow NVARCHAR(50) = N''


SET @OrderBy = 'CreateDate DESC '

SET @TotalRow = 'COUNT(*) OVER ()'
SET @sWhere = ' 1 = 1 '

	IF ISNULL(@SearchWhere, '') = '' --Lọc thường 
	BEGIN 
	IF ISNULL(@DivisionList, '') <> ''
		SET @sWhere = @sWhere + N'AND T01.DivisionID IN ('''+@DivisionList+''')'
	ELSE 
		SET @sWhere = @sWhere + N'AND T01.DivisionID = '''+@DivisionID+''''
	IF ISNULL(@ReserveID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T01.ReserveID  LIKE N''%'+@ReserveID +'%'''
	IF ISNULL(@ProposerID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T01.ProposerID  LIKE N''%'+@ProposerID +'%'''
	IF ISNULL(@SchoolYearID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T01.SchoolYearID  LIKE N''%'+@SchoolYearID +'%'''
	IF ISNULL(@GradeID, '') <> '' 
	    SET @sWhere = @sWhere + N' AND T01.GradeID LIKE N''%'+@GradeID +'%'''
    IF ISNULL(@ClassID, '') <> '' 
	    SET @sWhere = @sWhere + N' AND T01.CLassID  LIKE N''%'+@ClassID +'%'' '
	IF ISNULL(@StudentID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T01.StudentID  LIKE N''%'+@StudentID +'%'''
	IF (ISNULL(@FromDateReserve, '') <> '' AND ISNULL(@ToDateReserve, '') = '') SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE, T01.ReserveDate,120), 126) >= '''+CONVERT(VARCHAR(10),@FromDateReserve,126)+''' '

	IF (ISNULL(@FromDateReserve, '') = '' AND ISNULL(@ToDateReserve, '') <> '') SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE, T01.ReserveDate,120), 126) <= '''+CONVERT(VARCHAR(10),@ToDateReserve,126)+''' '

	IF (ISNULL(@FromDateReserve, '') <> '' AND ISNULL(@ToDateReserve, '') <> '') SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE, T01.ReserveDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDateReserve,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDateReserve,126)+''' '

	--nếu giá trị NULL thì set về rổng 
	SET @SearchWhere = Isnull(@SearchWhere, '')
	END 


SET @sSQL =@sSQL + N'
SELECT 
T01.APK,T01.DivisionID,T01.ReserveID,T01.ReserveDate,T01.ProposerID,T02.FullName AS ProposerName,
T01.SchoolYearID + '' ('' + CONVERT(VARCHAR(10), T07.DateFrom, 103) + '' - '' + CONVERT(VARCHAR(10), T07.DateTo, 103) + '')'' AS SchoolYearID, 
T01.GradeID,T04.GradeName, T01.ClassID,T05.ClassName,T01.StudentID, T06.StudentName,T01.ReservePeriod,T01.FromDate, T01.ToDate, T01.CreateDate
INTO #EDMP2150
FROM EDMT2150 T01 WITH (NOLOCK)
LEFT JOIN AT1103 T02 WITH (NOLOCK) ON T02.DivisionID IN (T01.DivisionID,''@@@'') AND T01.ProposerID = T02.EmployeeID 
LEFT JOIN EDMT1000 T04 WITH (NOLOCK) ON T04.DivisionID IN (T01.DivisionID,''@@@'') AND T04.GradeID = T01.GradeID
LEFT JOIN EDMT1020 T05 WITH (NOLOCK) ON T05.DivisionID IN (T01.DivisionID,''@@@'') AND T05.ClassID = T01.ClassID 
LEFT JOIN EDMT2010 T06 WITH (NOLOCK) ON T06.DivisionID = T01.DivisionID AND T06.StudentID = T01.StudentID AND T06.DeleteFlg = 0
LEFT JOIN EDMT1040 T07 WITH(NOLOCK) ON T01.SchoolYearID = T07.SchoolYearID
WHERE '+@sWhere+' AND T01.DeleteFlg = 0



SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * FROM #EDMP2150  AS Temp
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


