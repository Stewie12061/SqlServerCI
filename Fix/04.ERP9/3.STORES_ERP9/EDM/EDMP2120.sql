IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2120]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2120]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid chương trình học theo tháng (Màn hình truy vấn)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo , Date: 06/10/2018
-- <Example>
/*
----Lọc thường 
EXEC EDMP2120 @DivisionID = 'BE', @DivisionList = '', @ProgrammonthID = '',@TermID = '', @FromDate = '',@ToDate = '',@GradeID = '', 
 @UserID = '', @PageNumber = 1, @PageSize = 25, @SearchWhere = '',@LanguageID = ''

 ---Lọc nâng cao 
 EXEC EDMP2120 @DivisionID = 'BE', @DivisionList = '', @ProgrammonthID = '',@TermID = '', @FromDate = '',@ToDate = '',@GradeID = '', 
 @UserID = '', @PageNumber = 1, @PageSize = 25,@LanguageID = '', @SearchWhere = N' WHERE ISNULL(ProgrammonthID,'''') = N''CTTT/2019/01/0001'''

EXEC EDMP2120 @DivisionID, @DivisionList, @ProgrammonthID, @TermID, @FromDate,@ToDate,@GradeID,@UserID, @PageNumber, @PageSize, @SearchWhere,@LanguageID

*/
CREATE PROCEDURE EDMP2120 ( 
        @DivisionID VARCHAR(50), 
		@DivisionList VARCHAR(MAX), 
		@ProgrammonthID VARCHAR(50), 
		@TermID VARCHAR(50), 
		@FromDate DATETIME,
		@ToDate DATETIME,  
		@GradeID VARCHAR(50),
		@ClassID VARCHAR(50),
		@UserID  VARCHAR(50),
		@PageNumber INT,
		@PageSize INT,
		@SearchWhere NVARCHAR(MAX) = NULL, --#NULL: Lọc nâng cao; =NULL: Lọc thường
		@LanguageID VARCHAR(50) 
) 
AS 

DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX) = N'',
		@OrderBy NVARCHAR(500) = N'', 
		@TotalRow NVARCHAR(50) =N''

    SET @TotalRow = 'COUNT(*) OVER ()' 
	SET @OrderBy = 'DivisionID, ProgrammonthID, VoucherDate'
	SET @sWhere = ' 1 = 1 '

	IF ISNULL(@SearchWhere, '') = '' --Lọc thường 
	BEGIN 
	IF ISNULL(@DivisionList, '') <> ''
		SET @sWhere = @sWhere + N'AND T01.DivisionID IN ('''+@DivisionList+''')'
	ELSE 
		SET @sWhere = @sWhere + N'AND T01.DivisionID = '''+@DivisionID+''''

	IF ISNULL(@ProgrammonthID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T01.ProgrammonthID LIKE N''%'+@ProgrammonthID+'%'''

	IF ISNULL(@TermID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T01.TermID LIKE N''%'+@TermID+'%'''

	IF ISNULL(@GradeID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T01.GradeID  LIKE N''%'+@GradeID +'%'''

	IF ISNULL(@ClassID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T01.ClassID  LIKE N''%'+@ClassID +'%'''

	IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '') SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE, T01.VoucherDate,120), 126) >= '''+CONVERT(VARCHAR(10),@FromDate,126)+''' '

	IF (ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '') SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE, T01.VoucherDate,120), 126) <= '''+CONVERT(VARCHAR(10),@ToDate,126)+''' '

	IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '') SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE, T01.VoucherDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,126)+''' '

	--nếu giá trị NULL thì set về rổng 
	SET @SearchWhere = Isnull(@SearchWhere, '')
	END

SET @sSQL = N'
SELECT 
T01.APK, T01.DivisionID,T01.ProgrammonthID,T01.VoucherDate,T01.TermID,
CASE WHEN T01.TranMonth < 10 THEN ''0''+CAST (T01.TranMonth AS nvarchar)+''/''+CAST (T01.TranYear AS nvarchar) Else CAST (T01.TranMonth AS nvarchar)+''/''+CAST (T01.TranYear AS nvarchar) END AS MonthID,
T01.GradeID, T02.GradeName, T01.ClassID, T04.ClassName, T01.Description
INTO #EDMP2120 
FROM EDMT2120 T01  WITH (NOLOCK)
LEFT JOIN EDMT1000 T02 WITH (NOLOCK) ON T02.DivisionID IN (T01.DivisionID,''@@@'') AND T02.GradeID = T01.GradeID
LEFT JOIN EDMT1040 T03 WITH(NOLOCK) ON T01.TermID = T03.SchoolYearID
LEFT JOIN EDMT1020 T04 WITH(NOLOCK) ON T01.ClassID = T04.ClassID

WHERE '+@sWhere+' AND T01.DeleteFlg = 0

SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow, * FROM #EDMP2120  AS Temp
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



