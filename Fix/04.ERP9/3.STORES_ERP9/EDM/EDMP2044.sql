IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2044]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2044]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Chọn Xếp lớp (Màn hình chọn): khi tìm kiếm
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Văn Tình , Date: 01/11/2018
-- <Example>
/*

EXEC EDMP2044 @DivisionID= 'BE', @UserID = '', @LanguageID = '', @PageNumber = 1, @PageSize = 25, 
	@SchoolYearID  ='', @GradeID  ='', @ClassID  ='', @ArrangeClassID =''

*/

CREATE PROCEDURE EDMP2044 ( 
        @DivisionID VARCHAR(50), 
		@UserID VARCHAR(50),
	    @LanguageID VARCHAR(50),
		@PageNumber INT,
		@PageSize INT,
		@SchoolYearID VARCHAR(50),
		@GradeID VARCHAR(50),
		@ClassID VARCHAR(50),
		@ArrangeClassID VARCHAR(50)
) 
AS 

DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX) = N'',
		@OrderBy NVARCHAR(500) = N'', 
		@TotalRow NVARCHAR(50) = N''

	IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	SET @OrderBy = 'ArrangeClassID'

	SET @sWhere = ' T1.DivisionID = '''+@DivisionID+''''
	
	IF ISNULL(@SchoolYearID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.SchoolYearID  LIKE ''%'+@SchoolYearID +'%'''
	IF ISNULL(@GradeID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.GradeID  LIKE ''%'+@GradeID +'%'''
	IF ISNULL(@ClassID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.ClassID  LIKE ''%'+@ClassID +'%'''
	IF ISNULL(@ArrangeClassID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.ArrangeClassID  LIKE ''%'+@ArrangeClassID +'%'''
	
SET @sSQL = '
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
	T1.APK,T1.DivisionID,T6.DivisionName AS SchoolName,T1.ArrangeClassID, T1.SchoolYearID, 
	T1.SchoolYearID + '' ('' + CONVERT(VARCHAR(10), T5.DateFrom, 103) + '' - '' + CONVERT(VARCHAR(10), T5.DateTo, 103) + '')'' AS SchoolYearName,
	T1.GradeID,T3.GradeName,T1.ClassID, T4.ClassName
FROM EDMT2020 T1  WITH (NOLOCK)
LEFT JOIN EDMT1000 T3 WITH (NOLOCK) ON T1.GradeID = T3.GradeID 
LEFT JOIN EDMT1020 T4 WITH (NOLOCK) ON T1.ClassID = T4.ClassID
LEFT JOIN EDMT1040 T5 WITH(NOLOCK) ON T1.SchoolYearID = T5.SchoolYearID
LEFT JOIN AT1101   T6 WITH(NOLOCK) ON T1.DivisionID = T6.DivisionID
WHERE '+@sWhere+' AND T1.DeleteFlg = 0
ORDER BY '+@OrderBy+'

OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
'
--PRINT @sSQL
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


