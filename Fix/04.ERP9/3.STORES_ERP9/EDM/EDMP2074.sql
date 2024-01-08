IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[EDMP2074]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[EDMP2074]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Chọn phân công giáo viên
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Văn Tình, Date: 26/11/2018
----Modified by 
-- <Example>
---- 
/*-- <Example>
	EDMP2074 @DivisionID = 'VS', @UserID = '', @LanguageID ='vi-VN', @PageNumber = 1, @PageSize = 25, @ExcludeListTeacher = '', @txtSearch = ''
		 
----*/
CREATE PROCEDURE EDMP2074
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @LanguageID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @ExcludeListTeacher VARCHAR(250), 
	 @txtSearch NVARCHAR(100)
)

AS 
SET NOCOUNT ON
DECLARE @sSQL NVARCHAR(MAX) = N'', 
		@OrderBy NVARCHAR(MAX) = N'', 
		@TotalRow NVARCHAR(50) = N'',
		@sWhere NVARCHAR(MAX) =  '',
		@sWhereExcludeList NVARCHAR(512) =  '',
		@sWhereExcludeList2 NVARCHAR(512) =  '',
		@Top0 VARCHAR(50) = ''

IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

SET @OrderBy = ' B.TeacherID'
SET @TotalRow = 'COUNT(*) OVER ()' 

--IF @txtSearch = '' 
--	SET @Top0 = ' TOP 0 '
--ELSE
--	SET @Top0 = ''

IF ISNULL(@ExcludeListTeacher, '') <> ''
BEGIN 
	SET @sWhereExcludeList = ' AND B.TeacherID NOT IN (''' +@ExcludeListTeacher+ ''')'
	SET @sWhereExcludeList2 = ' AND B.NannyID NOT IN (''' +@ExcludeListTeacher+ ''')'
END

SET @sWhere = '
	OR A.GradeID LIKE ''%' + @txtSearch + '%''
	OR C.GradeName LIKE ''%' + @txtSearch + '%''
	OR A.ClassID LIKE ''%' + @txtSearch + '%''
	OR D.ClassName LIKE ''%' + @txtSearch + '%''
'

SET @sSQL = '
SELECT TOP 0 EmployeeID INTO #Teacher FROM AT1103 WITH(NOLOCK)
INSERT INTO #Teacher(EmployeeID) 
	SELECT EmployeeID FROM AT1103 WITH(NOLOCK) WHERE DivisionID IN (''' + @DivisionID + ''', ''@@@'') AND EmployeeID LIKE ''%' + @txtSearch + '%'' 
INSERT INTO #Teacher(EmployeeID) 
	SELECT EmployeeID FROM AT1103 WITH(NOLOCK) WHERE DivisionID IN (''' + @DivisionID + ''', ''@@@'') AND FullName LIKE ''%' + @txtSearch + '%'' 

SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY Z.TeacherID)) AS RowNum, '+@TotalRow+' AS TotalRow, Z.*
FROM (
	SELECT ' + @Top0 + ' B.TeacherID, H1.FullName AS TeacherName, A.DivisionID, A.GradeID, A.ClassID, C.GradeName, D.ClassName
	FROM EDMT2031 B WITH(NOLOCK) 
		INNER JOIN EDMT2030 A WITH(NOLOCK) ON A.APK = B.APKMaster
		LEFT JOIN AT1103 H1 WITH(NOLOCK) ON H1.EmployeeID = B.TeacherID
		LEFT JOIN (SELECT GradeID, GradeName FROM EDMT1000 WITH(NOLOCK) WHERE DivisionID IN (''' + @DivisionID + ''', ''@@@'') AND [Disabled] = 0) AS C ON C.GradeID = A.GradeID
		LEFT JOIN (SELECT ClassID, ClassName FROM EDMT1020 WITH(NOLOCK) WHERE DivisionID IN (''' + @DivisionID + ''', ''@@@'') AND [Disabled] = 0) AS D ON D.ClassID = A.ClassID
	WHERE B.DivisionID = '''+ @DivisionID +''' AND B.DeleteFlg = 0 AND A.DeleteFlg = 0
		AND (
			EXISTS (SELECT TOP 1 1 FROM #Teacher T WHERE T.EmployeeID = B.TeacherID) 
			' + @sWhere + '
		)
		' + @sWhereExcludeList + '
	UNION
	SELECT ' + @Top0 + ' B.NannyID AS TeacherID, H1.FullName AS TeacherName, A.DivisionID, A.GradeID, A.ClassID, C.GradeName, D.ClassName
	FROM EDMT2032 B WITH(NOLOCK) 
		INNER JOIN EDMT2030 A WITH(NOLOCK) ON A.APK = B.APKMaster
		LEFT JOIN AT1103 H1 WITH(NOLOCK) ON H1.EmployeeID = B.NannyID
		LEFT JOIN (SELECT GradeID, GradeName FROM EDMT1000 WITH(NOLOCK) WHERE DivisionID IN (''' + @DivisionID + ''', ''@@@'') AND [Disabled] = 0) AS C ON C.GradeID = A.GradeID
		LEFT JOIN (SELECT ClassID, ClassName FROM EDMT1020 WITH(NOLOCK) WHERE DivisionID IN (''' + @DivisionID + ''', ''@@@'') AND [Disabled] = 0) AS D ON D.ClassID = A.ClassID
	WHERE B.DivisionID = '''+ @DivisionID +''' AND B.DeleteFlg = 0 AND A.DeleteFlg = 0
		AND (
			EXISTS (SELECT TOP 1 1 FROM #Teacher T WHERE T.EmployeeID = B.NannyID) 
			' + @sWhere + '
		)
		' + @sWhereExcludeList2 + '
) AS Z
ORDER BY RowNum
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

