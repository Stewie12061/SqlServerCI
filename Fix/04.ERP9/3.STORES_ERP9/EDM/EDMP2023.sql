IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2023]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2023]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Chọn học sinh
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Minh Hòa, Date: 27/10/2018
----Modified by Hồng Thảo on 02/03/2019: 
----Modify by Đình Hoà on 24/06/2020 : Thêm điều kiện để lấy dữ liệu
-- <Example>
---- 
/*-- <Example>
	EDMP2023 @DivisionID = 'BE', @UserID = '', @LanguageID ='vi-VN', @PageNumber = 1, @PageSize = 25, @ExcludeListStudent = '', @txtSearch = '', @ScreenID = 'EDMF2021', @GradeID = '',@ClassID = '',
    @ArrangeClassID='',@SchoolYearID = '',@TranMonth ='',@TranYear = '',@ServiceTypeID = ''
	
	EDMP2023 @DivisionID = 'BE', @UserID = 'admin', @LanguageID ='vi-VN', @PageNumber = 1, @PageSize = 25, @ExcludeListStudent = 'hs01'', ''hs02', @txtSearch = '', @ScreenID = '', 
	@GradeID  ='', @ClassID  ='',@ArrangeClassID='',@SchoolYearID = '',@TranMonth ='',@TranYear = '',@ServiceTypeID = ''
	 
----*/
CREATE PROCEDURE EDMP2023
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @LanguageID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @ExcludeListStudent VARCHAR(MAX), 
	 @txtSearch NVARCHAR(100), 
	 @ScreenID VARCHAR(50), 
	 @GradeID VARCHAR(MAX)='',
	 @ClassID VARCHAR(MAX)='',
	 @ArrangeClassID VARCHAR(50) = '',
	 @SchoolYearID VARCHAR(50)= '',
	 @TranMonth VARCHAR(50) = '',
	 @TranYear VARCHAR(50) = '',
	 @ServiceTypeID VARCHAR(50) = '',
	 @VoucherDate DateTime = NULL
)

AS 
DECLARE @sSQL NVARCHAR(MAX) = N'', 
		@OrderBy NVARCHAR(MAX) = N'', 
		@TotalRow NVARCHAR(50) = N'',
		@sWhere NVARCHAR(MAX) =  ''

SET @OrderBy = ' T1.StudentID'
SET @TotalRow = 'COUNT(*) OVER ()' 

IF ISNULL(@ExcludeListStudent, '') <> ''
	BEGIN 
		SET @sWhere = 'AND T1.StudentID NOT IN (''' +@ExcludeListStudent+ ''')'
	END

IF @ScreenID = 'EDMF2021'   
BEGIN
	IF ISNULL(@GradeID, '') <> '' 
	SET @sWhere = @sWhere + N' AND T1.GradeID  LIKE ''%'+@GradeID +'%'''
	IF ISNULL(@ClassID, '') <> '' 
	SET @sWhere = @sWhere + N' AND T1.ClassID LIKE ''%'+@ClassID +'%'''

	IF ISNULL(@txtSearch, '') <> '' SET @sWhere = @sWhere + N'
	AND (T1.StudentID LIKE N''%'+@txtSearch+'%'' 
	OR T1.StudentName LIKE N''%'+@txtSearch+'%''
	OR T1.GradeID LIKE N''%'+@txtSearch+'%''
	OR T1.ClassID LIKE N''%'+@txtSearch+'%''
	)'


		SET @sSQL = @sSQL + N'
		SELECT  CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
		T1.DivisionID,T6.DivisionName,T1.StudentID, T1.StudentName, T1.DateOfBirth, 
		'+ CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T2.Description' ELSE 'T2.DescriptionE' END 
		+N' as Sex,
		T1.GradeID,T4.GradeName,T1.ClassID,T5.ClassName,
		0 as IsTransfer, N'''' as TransferName 
		From EDMT2010 T1 WITH (NOLOCK) 
		LEFT JOIN EDMT0099 T2 WITH (NOLOCK) ON T1.SexID = T2.ID AND T2.Disabled = 0 AND T2.CodeMaster=''Sex''
		LEFT JOIN EDMT1000 T4 WITH (NOLOCK) ON T4.DivisionID IN (T1.DivisionID, ''@@@'') AND T4.GradeID = T1.GradeID
		LEFT JOIN EDMT1020 T5 WITH (NOLOCK) ON T5.DivisionID IN (T1.DivisionID, ''@@@'') AND T5.ClassID = T1.ClassID
		LEFT JOIN AT1101   T6 WITH (NOLOCK) ON T6.DivisionID = T1.DivisionID
		WHERE T1.DivisionID = '''+@DivisionID+''' AND T1.DeleteFlg = 0 AND T1.StatusID IN  (0,1)
		AND NOT EXISTS (SELECT B.StudentID FROM EDMT2020 A WITH (NOLOCK) 
						LEFT JOIN EDMT2021 B WITH (NOLOCK) ON A.APK = B.APKMaster AND B.DeleteFlg = A.DeleteFlg
						WHERE A.DivisionID = '''+@DivisionID+'''  AND B.IsTransfer IN (0,2) AND B.DeleteFlg = 0 AND B.StudentID = T1.StudentID  AND A.SchoolYearID = '''+@SchoolYearID+''') 
		'
		+ @sWhere +'
	
		ORDER BY '+@OrderBy+'
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
		'
END 


IF @ScreenID = 'EDMF2131' ----Nghiệp vụ đưa đón và giữ ngoài giờ

	BEGIN
		IF ISNULL(@GradeID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T3.GradeID  = '''+@GradeID+''''
		IF ISNULL(@ClassID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T3.ClassID  = '''+@ClassID+''''
		---năm học 
		IF ISNULL(@SchoolYearID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T3.SchoolYearID  = '''+@SchoolYearID+''' '
		---Xếp lớp
		IF ISNULL(@ArrangeClassID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T3.ArrangeClassID  = '''+@ArrangeClassID+''' '

		IF ISNULL(@txtSearch, '') <> '' SET @sWhere = @sWhere + N'
	    AND (T1.StudentID LIKE N''%'+@txtSearch+'%'' 
	    OR T2.StudentName LIKE N''%'+@txtSearch+'%''
	     )'

		--- Thêm điều kiện của bảng EDMT2013 đế lấy những học sinh được theo dõi Biểu phí
		SET @sSQL = @sSQL + N'
			SELECT  CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
			T1.DivisionID,T7.DivisionName,T3.ArrangeClassID,T3.SchoolYearID,T1.StudentID, T2.StudentName, T3.GradeID,T5.GradeName, T3.ClassID, T6.ClassName
			FROM EDMT2021 T1 WITH (NOLOCK) 
			LEFT JOIN EDMT2010 T2 WITH (NOLOCK) ON T2.DivisionID = T1.DivisionID AND T2.StudentID = T1.StudentID
			LEFT JOIN EDMT2020 T3 WITH (NOLOCK) ON T3.APK = T1.APKMaster
			LEFT JOIN EDMT1000 T5 WITH (NOLOCK) ON T5.DivisionID IN (T1.DivisionID, ''@@@'') AND T5.GradeID = T3.GradeID
			LEFT JOIN EDMT1020 T6 WITH (NOLOCK) ON T6.DivisionID IN (T1.DivisionID, ''@@@'') AND T6.ClassID = T3.ClassID
			LEFT JOIN AT1101   T7 WITH (NOLOCK) ON T7.DivisionID = T1.DivisionID			
			LEFT JOIN EDMT2013 T8 WITH (NOLOCK) ON T8.DivisionID =  T3.DivisionID AND T8.SchoolYearID = T3.SchoolYearID AND T8.StudentID= T1.StudentID
			WHERE T1.DivisionID = '''+@DivisionID+''' AND T1.DeleteFlg = 0 AND  T1.IsTransfer IN (0,2) AND T2.StatusID IN  (0,1)
			AND  
			T1.StudentID NOT IN (SELECT EDMT2131.StudentID FROM EDMT2130 WITH (NOLOCK) 
								LEFT JOIN EDMT2131 WITH (NOLOCK) ON EDMT2130.APK = EDMT2131.APKMaster AND EDMT2131.DeleteFlg = 0
								WHERE EDMT2130.DivisionID = '''+@DivisionID+''' AND EDMT2130.TranMonth ='''+@TranMonth+''' 
								AND EDMT2130.TranYear ='''+@TranYear+''' AND ServiceTypeID = '''+@ServiceTypeID+'''
								AND EDMT2131.GradeID = '''+@GradeID+''' AND EDMT2131.ClassID = '''+@ClassID+''' AND EDMT2130.DeleteFlg = 0)
			'+ @sWhere +' AND T8.StudentID IS NOT NULL
	
			ORDER BY '+@OrderBy+'
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
			'

	END 

ELSE IF @ScreenID = 'EDMF2081' 
BEGIN 


	IF ISNULL(@txtSearch, '') <> '' SET @sWhere = @sWhere + N'
	AND (T1.StudentID LIKE N''%'+@txtSearch+'%'' 
	OR T1.StudentName LIKE N''%'+@txtSearch+'%''
	OR T1.GradeID LIKE N''%'+@txtSearch+'%''
	OR T1.ClassID LIKE N''%'+@txtSearch+'%''
	)'


		SET @sSQL = @sSQL + N'
		SELECT  CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
		T1.DivisionID,T6.DivisionName,T1.StudentID, T1.StudentName, T1.DateOfBirth, 
		'+ CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T2.Description' ELSE 'T2.DescriptionE' END 
		+N' as Sex,
		T1.GradeID,T4.GradeName,T1.ClassID,T5.ClassName,
		0 as IsTransfer, N''Không điều chuyển'' as TransferName 
		From EDMT2010 T1 WITH (NOLOCK) 
		LEFT JOIN EDMT0099 T2 WITH (NOLOCK) ON T1.SexID = T2.ID AND T2.Disabled = 0 AND T2.CodeMaster=''Sex''
		LEFT JOIN EDMT1000 T4 WITH (NOLOCK) ON T4.DivisionID IN (T1.DivisionID, ''@@@'') AND T4.GradeID = T1.GradeID
		LEFT JOIN EDMT1020 T5 WITH (NOLOCK) ON T5.DivisionID IN (T1.DivisionID, ''@@@'') AND T5.ClassID = T1.ClassID
		LEFT JOIN AT1101   T6 WITH (NOLOCK) ON T6.DivisionID = T1.DivisionID
		WHERE T1.DivisionID = '''+@DivisionID+''' AND T1.DeleteFlg = 0 AND T1.StatusID IN  (0,1,4)
		'
		+ @sWhere +'
	
		ORDER BY '+@OrderBy+'
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
		'

END 

ELSE IF @ScreenID = ''
BEGIN
	IF ISNULL(@GradeID, '') <> '' 
	SET @sWhere = @sWhere + N' AND T3.GradeID  IN ('''+@GradeID+''')'
	IF ISNULL(@ClassID, '') <> '' 
	SET @sWhere = @sWhere + N' AND T3.ClassID  IN ('''+@ClassID+''')'
	---năm học
	IF ISNULL(@SchoolYearID, '') <> '' 
	SET @sWhere = @sWhere + N' AND T3.SchoolYearID  = '''+@SchoolYearID+''' '
	---Xếp lớp
	IF ISNULL(@ArrangeClassID, '') <> '' 
	SET @sWhere = @sWhere + N' AND T3.ArrangeClassID  = '''+@ArrangeClassID+''' '
    
	IF ISNULL(@txtSearch, '') <> '' SET @sWhere = @sWhere + N'
	AND (T1.StudentID LIKE N''%'+@txtSearch+'%'' 
	OR T2.StudentName LIKE N''%'+@txtSearch+'%''
	)'
	   --- Thêm điều kiện của bảng EDMT2013 đế lấy những học sinh được theo dõi Biểu phí
		SET @sSQL = @sSQL + N'
		SELECT  CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
		T1.DivisionID,T7.DivisionName,T3.ArrangeClassID,T3.SchoolYearID,T1.StudentID, T2.StudentName, T3.GradeID,T5.GradeName, T3.ClassID, T6.ClassName,
		T2.DateOfBirth, '+ CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T8.Description' ELSE 'T8.DescriptionE' END 
		+N' as Sex,
		T9.FeeID, T10.FeeName
		FROM EDMT2021 T1 WITH (NOLOCK) 
		LEFT JOIN EDMT2010 T2 WITH (NOLOCK) ON T2.DivisionID = T1.DivisionID AND T2.StudentID = T1.StudentID AND T2.DeleteFlg = 0 
		LEFT JOIN EDMT2020 T3 WITH (NOLOCK) ON T3.APK = T1.APKMaster AND T3.DeleteFlg = 0
		LEFT JOIN EDMT1000 T5 WITH (NOLOCK) ON T5.DivisionID IN (T1.DivisionID, ''@@@'') AND T5.GradeID = T3.GradeID
		LEFT JOIN EDMT1020 T6 WITH (NOLOCK) ON T6.DivisionID IN (T1.DivisionID, ''@@@'') AND T6.ClassID = T3.ClassID
		LEFT JOIN AT1101   T7 WITH (NOLOCK) ON T7.DivisionID = T1.DivisionID 
		LEFT JOIN EDMT0099 T8 WITH (NOLOCK) ON T8.ID =  T2.SexID AND T8.CodeMaster = ''Sex''
		LEFT JOIN EDMT2013 T9 WITH (NOLOCK) ON T9.DivisionID =  T3.DivisionID AND T9.SchoolYearID = T3.SchoolYearID AND T9.StudentID= T1.StudentID
		LEFT JOIN EDMT1090 T10 WITH (NOLOCK) ON T10.FeeID = T9.FeeID

		WHERE T1.DivisionID = '''+@DivisionID+''' AND T1.DeleteFlg = 0  AND  T1.IsTransfer IN (0,2) AND T2.StatusID IN (0,1)
		'+ @sWhere +' AND T9.StudentID IS NOT NULL
	
		ORDER BY '+@OrderBy+'
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
		'
END
ELSE IF @ScreenID = 'EDMF30007' 
BEGIN 


	IF ISNULL(@txtSearch, '') <> '' SET @sWhere = @sWhere + N'
	AND (T1.StudentID LIKE N''%'+@txtSearch+'%'' 
	OR T1.StudentName LIKE N''%'+@txtSearch+'%''
	)'


		SET @sSQL = @sSQL + N'
		SELECT  CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
		T1.DivisionID,T3.DivisionName,T1.StudentID, T1.StudentName, T1.DateOfBirth, 
		'+ CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T2.Description' ELSE 'T2.DescriptionE' END 
		+N' as Sex 
		From EDMT2010 T1 WITH (NOLOCK) 
		LEFT JOIN EDMT0099 T2 WITH (NOLOCK) ON T1.SexID = T2.ID AND T2.Disabled = 0 AND T2.CodeMaster=''Sex''
		LEFT JOIN AT1101   T3 WITH (NOLOCK) ON T3.DivisionID = T1.DivisionID
		WHERE T1.DivisionID = '''+@DivisionID+''' AND T1.DeleteFlg = 0 
		'
		+ @sWhere +'
	
		ORDER BY '+@OrderBy+'
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
		'

END 

ELSE IF @ScreenID = 'NMF2060'
BEGIN


	IF ISNULL(@VoucherDate, '') <> '' 
	SET @sWhere = @sWhere + N' AND T3.SchoolYearID IN (SELECT SchoolYearID FROM EDMT1040 WITH (NOLOCK) 
							   WHERE DivisionID IN ('''+@DivisionID+''',''@@@'')  
							   AND  '''+CONVERT(VARCHAR(10),@VoucherDate,126)+''' BETWEEN  CONVERT(VARCHAR(10), CONVERT(DATE, DateFrom,120), 126) AND CONVERT(VARCHAR(10), CONVERT(DATE, DateTo,120), 126) )'

    

	
	IF ISNULL(@txtSearch, '') <> '' SET @sWhere = @sWhere + N'
	AND (T1.StudentID LIKE N''%'+@txtSearch+'%'' 
	OR T2.StudentName LIKE N''%'+@txtSearch+'%''
	)'


		SET @sSQL = @sSQL + N'
		SELECT  CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
		T1.DivisionID,T7.DivisionName,T3.ArrangeClassID,T3.SchoolYearID,T1.StudentID, T2.StudentName, T3.GradeID,T5.GradeName, T3.ClassID, T6.ClassName,
		T2.DateOfBirth, '+ CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T8.Description' ELSE 'T8.DescriptionE' END 
		+N' as Sex 
		FROM EDMT2021 T1 WITH (NOLOCK) 
		LEFT JOIN EDMT2010 T2 WITH (NOLOCK) ON T2.DivisionID = T1.DivisionID AND T2.StudentID = T1.StudentID AND T2.DeleteFlg = 0 
		LEFT JOIN EDMT2020 T3 WITH (NOLOCK) ON T3.APK = T1.APKMaster AND T3.DeleteFlg = 0
		LEFT JOIN EDMT1000 T5 WITH (NOLOCK) ON T5.DivisionID IN (T1.DivisionID, ''@@@'') AND T5.GradeID = T3.GradeID
		LEFT JOIN EDMT1020 T6 WITH (NOLOCK) ON T6.DivisionID IN (T1.DivisionID, ''@@@'') AND T6.ClassID = T3.ClassID
		LEFT JOIN AT1101   T7 WITH (NOLOCK) ON T7.DivisionID = T1.DivisionID 
		LEFT JOIN EDMT0099 T8 WITH (NOLOCK) ON T8.ID =  T2.SexID AND T8.CodeMaster = ''Sex''
		WHERE T1.DivisionID = '''+@DivisionID+''' AND T1.DeleteFlg = 0  AND  T1.IsTransfer IN (0,2) 
		AND T2.StatusID IN  (0,1) 
		' 
		+ @sWhere +'
	
		ORDER BY '+@OrderBy+'
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
		'
END

 PRINT @sSQL
 EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
