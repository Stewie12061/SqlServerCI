IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2060]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2060]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Nghiệp vụ Kết quả dự giờ (Màn hình truy vấn) Class observation
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Minh Hòa , Date: 5/11/2018
-- <Example>
/*
---Lọc thường 
EXEC EDMP2060  @DivisionID='BE', @DivisionList='BE', @UserID ='',@LanguageID ='',@PageNumber ='1',@PageSize ='25',@DateFrom ='',@DateTo ='',@EvaluetionID ='',@GradeID ='',@ClassID ='',@Teacher ='',
@SearchWhere =''
---Lọc nâng cao 
EXEC EDMP2060  @DivisionID='BE', @DivisionList='BE', @UserID ='',@LanguageID ='',@PageNumber ='1',@PageSize ='25',@DateFrom ='',@DateTo ='',@EvaluetionID ='',@GradeID ='',@ClassID ='',@Teacher ='',
@SearchWhere =N'WHERE ISNULL(EvaluetionID,'''') = N''DGDG/2019/01/0006'''

*/

CREATE PROCEDURE EDMP2060 ( 
        @DivisionID VARCHAR(50), 
		@DivisionList VARCHAR(MAX), 
		@UserID VARCHAR(50),
	    @LanguageID VARCHAR(50),
		@PageNumber INT,
		@PageSize INT,
		@DateFrom DATETIME,-- Từ Ngày đánh giá 
		@DateTo DATETIME, -- Đến ngày
		@EvaluetionID VARCHAR(50), -- Mã đánh giá
		@GradeID VARCHAR(50),
		@ClassID VARCHAR(50),
		@Teacher NVARCHAR(250),-- Giá trị có thể Mã hoặc Tên Giáo viên
		@SearchWhere NVARCHAR(MAX) = NULL -- Lọc nâng cao
		
) 
AS 

DECLARE
	@sSQL NVARCHAR(MAX),
	@sWhere NVARCHAR(MAX) = N'',
	@OrderBy NVARCHAR(500) = N'', 
	@TotalRow NVARCHAR(50) = N''

	IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	SET @OrderBy = 'EvaluetionID'
	SET @sWhere = ' 1 = 1 '

	IF ISNULL(@SearchWhere, '') = '' --Lọc thường 
	BEGIN 
	IF ISNULL(@DivisionList, '') <> ''
		SET @sWhere = @sWhere + N'AND T1.DivisionID IN ('''+@DivisionList+''')'
	ELSE 
		SET @sWhere = @sWhere + N'AND T1.DivisionID = '''+@DivisionID+''''
	
	IF (ISNULL(@DateFrom, '') <> '' AND ISNULL(@DateTo, '') = '') 
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.EvaluetionDate,120), 126) >= '''+CONVERT(VARCHAR(10),@DateFrom,126)+''' '
	IF (ISNULL(@DateFrom, '') = '' AND ISNULL(@DateTo, '') <> '') 
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.EvaluetionDate,120), 126) <= '''+CONVERT(VARCHAR(10),@DateTo,126)+''' '
	IF (ISNULL(@DateFrom, '') <> '' AND ISNULL(@DateTo, '') <> '') 
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.EvaluetionDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@DateFrom,126)+''' AND '''+CONVERT(VARCHAR(10),@DateTo,126)+''' '
		
	IF ISNULL(@EvaluetionID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.EvaluetionID  LIKE ''%'+@EvaluetionID +'%'''
	IF ISNULL(@GradeID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.GradeID  LIKE ''%'+@GradeID +'%'''
	IF ISNULL(@ClassID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.ClassID  LIKE ''%'+@ClassID +'%'''
	IF ISNULL(@Teacher, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.TeacherID  LIKE ''%'+@Teacher +'%'' OR A1.FullName LIKE ''%'+@Teacher +'%'''

	--nếu giá trị NULL thì set về rổng 
	SET @SearchWhere = Isnull(@SearchWhere, '')
	END 

----Select tập thành viên dự giờ
SET @sSQL =  N' SELECT T1.APK INTO #EDMT2060 FROM EDMT2060 T1 WITH(NOLOCK) 
LEFT JOIN AT1103  A1 WITH (NOLOCK) ON T1.TeacherID = A1.EmployeeID AND A1.DivisionID IN (T1.DivisionID,''@@@'')
WHERE T1.DeleteFlg = 0 AND ' + @sWhere

SET @sSQL = @sSQL + N'
	SELECT A.APKMaster, A.MemberID, H1.FullName AS MemberName  
	INTO #EDMT2061 
	FROM EDMT2061 A WITH(NOLOCK) LEFT JOIN AT1103 H1 WITH(NOLOCK) ON H1.EmployeeID = A.MemberID
	WHERE EXISTS (SELECT TOP 1 1 FROM #EDMT2060 B WHERE B.APK = A.APKMaster AND A.DeleteFlg = 0)

SELECT T1.APKMaster,
	STUFF((  
			SELECT '','' + T2.MemberName
			FROM #EDMT2061 T2  
			WHERE T1.APKMaster = T2.APKMaster  
			ORDER BY T2.MemberID

			FOR XML PATH ('''')  
        ),1,1,'''')  AS MemberName
	INTO #MemberName
FROM #EDMT2061 T1 
GROUP BY T1.APKMaster
'

SET @sSQL = @sSQL + N'
	SELECT 
	T1.APK,T1.DivisionID,T1.EvaluetionID, T1.EvaluetionDate, 
	T1.SchoolYearID,
	T3.GradeName, T4.ClassName, 
	T1.TeacherID, A1.FullName AS TeacherName,  
	A2.MemberName AS MemberName,
	Time, 
	'+ CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T5.Description' ELSE 'T5.DescriptionE' END +' as ResultName, 
	T1.Content
	INTO #EDMP2060 
	FROM EDMT2060 T1  WITH (NOLOCK)
	LEFT JOIN EDMT1000 T3 WITH (NOLOCK) ON T1.GradeID = T3.GradeID 
	LEFT JOIN EDMT1020 T4 WITH (NOLOCK) ON T1.ClassID = T4.ClassID
	LEFT JOIN EDMT0099 T5 WITH (NOLOCK) ON T1.ResultID = T5.ID AND T5.Disabled = 0 AND T5.CodeMaster=''EvaluetionResult''
	LEFT JOIN AT1103  A1 WITH (NOLOCK) ON T1.TeacherID = A1.EmployeeID AND A1.DivisionID IN (T1.DivisionID,''@@@'')
	LEFT JOIN #MemberName A2 ON T1.APK = A2.APKMaster
	WHERE '+@sWhere+' AND T1.DeleteFlg =0 
	ORDER BY '+@OrderBy+'

	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * 
	FROM #EDMP2060 AS Temp
	'+@SearchWhere +'
	ORDER BY '+@OrderBy+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY

	DROP TABLE #MemberName


	'



PRINT @sSQL
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


