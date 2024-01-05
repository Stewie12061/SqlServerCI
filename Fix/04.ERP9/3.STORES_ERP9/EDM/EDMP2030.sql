IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2030]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2030]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Grid Form EDMF2030: phan cong giao vien
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Văn Tình, Date: 23/10/2018
-- <Example>
/*
---Lọc thường
EXEC EDMP2030 @DivisionID = 'BE',@DivisionList='',@UserID='',@LanguageID='',@PageNumber='1',@PageSize='25',@VoucherNo='',@SchoolYearID='',@GradeID='',@ClassID='',@TeacherID='',@NannyID='',
@SearchWhere=''

---Lọc nâng cao 
EXEC EDMP2030 @DivisionID = 'BE',@DivisionList='',@UserID='',@LanguageID='vi-VN',@PageNumber='1',@PageSize='25',@VoucherNo='',@SchoolYearID='',@GradeID='',@ClassID='',@TeacherID='',@NannyID='',
@SearchWhere=N'WHERE ISNULL(VoucherNo,'''') = N''PCGV/2019/02/0003'''

*/


CREATE PROCEDURE [dbo].[EDMP2030]
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @LanguageID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @VoucherNo VARCHAR(50),
	 @SchoolYearID VARCHAR(50),
	 @GradeID VARCHAR(50),
	 @ClassID VARCHAR(50),
	 @TeacherID NVARCHAR(250),
	 @NannyID NVARCHAR(250),
	 @SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường
)
AS 
SET NOCOUNT ON

DECLARE @cLan VARCHAR(1)
DECLARE @sSQL NVARCHAR (MAX) = '',
        @sWhere NVARCHAR(4000),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
                
SET @TotalRow = ''
SET @OrderBy = 'VoucherNo'
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
SET @sWhere = 'AND 1 = 1 '



SELECT TOP 0 APKMaster INTO #TeacherFilter FROM EDMT2031 A WITH(NOLOCK)


IF ISNULL(@SearchWhere, '') = '' --Lọc thường 
BEGIN 
	
	IF ISNULL(@DivisionList, '') <> ''
		SET @sWhere = @sWhere + N'AND A.DivisionID IN ('''+@DivisionList+''')'
	ELSE 
		SET @sWhere = @sWhere + N'AND A.DivisionID = '''+@DivisionID+''''

	IF @VoucherNo <> ''
		SET @sWhere = @sWhere + ' AND A.VoucherNo LIKE ''' + @VoucherNo+'%'' '
	IF @GradeID <> ''
		SET @sWhere = @sWhere + ' AND A.GradeID LIKE ''' + @GradeID + '%'' '
	IF @ClassID <> ''
		SET @sWhere = @sWhere + ' AND A.ClassID LIKE ''' + @ClassID + '%'' '
	IF @SchoolYearID <> ''
		SET @sWhere = @sWhere + ' AND A.SchoolYearID LIKE ''' + @SchoolYearID + '%'' '

	-- Loc theo giao vien, bao mau
	IF @TeacherID <> ''
	BEGIN
		SET @sSQL = 'INSERT INTO #TeacherFilter(APKMaster) 
		SELECT APKMaster FROM EDMT2031 WITH(NOLOCK) WHERE TeacherID LIKE ''' + @TeacherID + '%''
		UNION ALL
		SELECT APKMaster FROM EDMT2031 A WITH(NOLOCK) WHERE EXISTS (SELECT TOP 1 1 FROM AT1103 B WITH(NOLOCK) WHERE FullName LIKE ''%' + @TeacherID + '%'' AND A.TeacherID = B.EmployeeID)
		'
		EXEC (@sSQL)
	END
	IF @NannyID <> ''
	BEGIN
		SET @sSQL = 'INSERT INTO #TeacherFilter(APKMaster) 
		SELECT APKMaster FROM EDMT2032 WITH(NOLOCK) WHERE NannyID LIKE ''' + @NannyID + '%'' 
		UNION ALL
		SELECT APKMaster FROM EDMT2032 A WITH(NOLOCK) WHERE EXISTS (SELECT TOP 1 1 FROM AT1103 B WITH(NOLOCK) WHERE FullName LIKE ''%' + @TeacherID + '%'' AND A.NannyID = B.EmployeeID)
		'
		EXEC (@sSQL)
	END

	SET @sSQL = ''

	IF (@TeacherID <> '' OR @NannyID <> '')
		SET @sWhere = @sWhere + ' AND A.APK IN (SELECT APKMaster FROM #TeacherFilter WHERE A.APK = #TeacherFilter.APKMaster)'
	-- END Loc theo giao vien, bao mau

END 


SET @sSQL = @sSQL + ' SELECT A.APK INTO #EDMT2030 FROM EDMT2030 A WITH(NOLOCK) WHERE A.DeleteFlg = 0 ' + @sWhere

SET @sSQL = @sSQL + '
SELECT A.APKMaster, A.TeacherID, H1.FullName AS TeacherName
	INTO #EDMT2031 
	FROM EDMT2031 A WITH(NOLOCK) LEFT JOIN AT1103 H1 WITH(NOLOCK) ON H1.EmployeeID = A.TeacherID
	WHERE EXISTS (SELECT TOP 1 1 FROM #EDMT2030 B WHERE B.APK = A.APKMaster AND A.DeleteFlg = 0)

SELECT A.APKMaster, A.NannyID, H1.FullName AS NannyName
	INTO #EDMT2032 
	FROM EDMT2032 A WITH(NOLOCK) LEFT JOIN AT1103 H1 WITH(NOLOCK) ON H1.EmployeeID = A.NannyID
	WHERE EXISTS (SELECT TOP 1 1 FROM #EDMT2030 B WHERE B.APK = A.APKMaster AND A.DeleteFlg = 0)

SELECT T1.APKMaster,
	STUFF((  
			SELECT '',''  + T2.TeacherName  
			FROM #EDMT2031 T2  
			WHERE T1.APKMaster = T2.APKMaster  
			FOR XML PATH ('''')  
        ),1,1,'''')  AS TeacherName
	INTO #TeacherName
FROM #EDMT2031 T1 
GROUP BY T1.APKMaster

SELECT T1.APKMaster, 
	STUFF((  
			SELECT '','' + T2.NannyName  
			FROM #EDMT2032 T2  
			WHERE T1.APKMaster = T2.APKMaster  
			FOR XML PATH ('''')  
        ),1,1,'''')  AS NannyName
	INTO #NannyIDName
FROM #EDMT2032 T1 
GROUP BY T1.APKMaster

'

SET @sSQL = @sSQL + '
SELECT 
	  A.DivisionID, A.APK, A.VoucherNo, A.SchoolYearID, A.SchoolYearID + '' ('' + CONVERT(VARCHAR(10), E.DateFrom, 103) + '' - '' + CONVERT(VARCHAR(10), E.DateTo, 103) + '')'' AS SchoolYearName
	, A.ApprovalID01, A.ApprovalID02, A.ApprovalID03, A.ApprovalID04, A.ApprovalID05
	, A.GradeID, C.GradeName, A.ClassID, D.ClassName
	, H1.FullName AS ApprovalName01, H2.FullName AS ApprovalName02
	, A.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = A.CreateUserID) AS CreateUserID, A.CreateDate
	, A.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = A.LastModifyUserID) AS LastModifyUserID, A.LastModifyDate
	, K1.TeacherName, K2.NannyName
INTO #EDMP2030 
FROM EDMT2030 A WITH(NOLOCK) INNER JOIN #EDMT2030 Z ON A.APK = Z.APK
	LEFT JOIN (SELECT GradeID, GradeName FROM EDMT1000 WITH(NOLOCK) WHERE DivisionID IN ('''+@DivisionID+''', ''@@@'') AND [Disabled] = 0) AS C ON A.GradeID = C.GradeID
	LEFT JOIN (SELECT ClassID, ClassName FROM EDMT1020 WITH(NOLOCK) WHERE DivisionID IN ('''+@DivisionID+''', ''@@@'') AND [Disabled] = 0) AS D ON D.ClassID = A.ClassID
	LEFT JOIN EDMT1040 E WITH(NOLOCK) ON A.SchoolYearID = E.SchoolYearID
	LEFT JOIN HV1400 H1 WITH(NOLOCK) ON H1.EmployeeID = A.[ApprovalID01]
	LEFT JOIN HV1400 H2 WITH(NOLOCK) ON H2.EmployeeID = A.[ApprovalID02]
	LEFT JOIN #TeacherName K1 ON A.APK = K1.APKMaster
	LEFT JOIN #NannyIDName K2 ON A.APK = K2.APKMaster
ORDER BY ' + @OrderBy + '

SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * 
FROM #EDMP2030  AS Temp
'+@SearchWhere +'
ORDER BY '+@OrderBy+'
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY

DROP TABLE #TeacherName
DROP TABLE #NannyIDName
DROP TABLE #EDMT2031
DROP TABLE #EDMT2032
DROP TABLE #EDMT2030

'

PRINT(@sSQL)
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
