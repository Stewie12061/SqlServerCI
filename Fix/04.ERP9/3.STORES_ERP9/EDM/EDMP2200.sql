IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2200]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2200]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Nghiệp vụ Thay đổi mức đóng phí (Màn hình truy vấn)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Lương Mỹ , Date: 11/02/2020
-- <Example>
/*

*/

CREATE PROCEDURE EDMP2200 ( 
        @DivisionID VARCHAR(50), 
		@DivisionList VARCHAR(MAX), 
		@UserID VARCHAR(50),
	    @LanguageID VARCHAR(50),
		@PageNumber INT,
		@PageSize INT,
		@SchoolYearID VARCHAR(50),
		@GradeID VARCHAR(50),
		@ClassID VARCHAR(50),
		@StudentID VARCHAR(50),
		@StudentName VARCHAR(250),
		@SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường
		
) 
AS 

DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX) = N'',
		@OrderBy NVARCHAR(500) = N'', 
		@TotalRow NVARCHAR(50) = N''

	IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	SET @OrderBy = 'CreateDate DESC'
	SET @sWhere = ' ISNULL(T1.VoucherNo, '''') <> '''' AND T1.DeleteFlg = 0 '

	IF ISNULL(@SearchWhere, '') = '' --Lọc thường 
	BEGIN 
	IF ISNULL(@DivisionList, '') <> ''
		SET @sWhere = @sWhere + N'AND T1.DivisionID IN ('''+@DivisionList+''')'
	ELSE 
		SET @sWhere = @sWhere + N'AND T1.DivisionID = '''+@DivisionID+''''

	IF ISNULL(@SchoolYearID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.SchoolYearID  LIKE ''%'+ @SchoolYearID +'%'''
	
	IF ISNULL(@GradeID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.GradeID  LIKE ''%'+ @GradeID +'%'''

	IF ISNULL(@ClassID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.ClassID  LIKE ''%'+ @ClassID +'%'''
		
	IF ISNULL(@StudentID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.StudentID  LIKE ''%'+ @StudentID +'%'''
		
	IF ISNULL(@StudentName, '') <> '' 
		SET @sWhere = @sWhere + N' AND T2.StudentName  LIKE ''%'+@StudentName +'%'''
					
	--nếu giá trị NULL thì set về rổng 
	SET @SearchWhere = Isnull(@SearchWhere, '')
	END 		


SET @sSQL =  N'
SELECT T1.*,
T2.StudentName,
T3.GradeName,
T4.ClassName

INTO #Table
FROM EDMT2200 T1  WITH (NOLOCK)
LEFT JOIN EDMT2010  T2 WITH (NOLOCK) ON T2.StudentID = T1.StudentID
LEFT JOIN EDMT1000  T3 WITH (NOLOCK) ON T3.GradeID = T1.GradeID
LEFT JOIN EDMT1020  T4 WITH (NOLOCK) ON T4.ClassID = T1.ClassID

WHERE '+@sWhere+' 
ORDER BY '+@OrderBy+'


SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * 
FROM #Table AS Temp
'+@SearchWhere +'
ORDER BY '+@OrderBy+'
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'


PRINT (@sSQL)
EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


