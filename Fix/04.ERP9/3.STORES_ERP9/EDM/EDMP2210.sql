IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2210]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2210]
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

CREATE PROCEDURE EDMP2210 ( 
        @DivisionID VARCHAR(50), 
		@DivisionList VARCHAR(MAX), 
		@UserID VARCHAR(50),
	    @LanguageID VARCHAR(50),
		@PageNumber INT,
		@PageSize INT,
		@SchoolYearID VARCHAR(50),
		@StudentID VARCHAR(50),
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
	
	IF ISNULL(@StudentID, '') <> '' 
		SET @sWhere = @sWhere + N' AND (T1.StudentID  LIKE ''%'+ @StudentID +'%'' OR T2.StudentName  LIKE ''%'+@StudentID +'%'')'
						
	--nếu giá trị NULL thì set về rổng 
	SET @SearchWhere = Isnull(@SearchWhere, '')
	END 		


SET @sSQL =  N'
SELECT T1.*,
T2.StudentName,
T3.FeeName

INTO #Table
FROM EDMT2210 T1  WITH (NOLOCK)
LEFT JOIN EDMT2010  T2 WITH (NOLOCK) ON T2.StudentID = T1.StudentID
LEFT JOIN EDMT1090  T3 WITH (NOLOCK) ON T3.FeeID = T1.FeeID

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


