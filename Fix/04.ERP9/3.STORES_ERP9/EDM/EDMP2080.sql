IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2080]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2080]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Nghiệp vụ Quyết định nghỉ học (Màn hình truy vấn) 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Minh Hòa , Date: 28/11/2018
-- <Example>
/*
--Lọc thường 
EXEC EDMP2080 @DivisionID= 'BE', @DivisionList = 'BE', @UserID = '', @LanguageID = 'vi-VN', @PageNumber = 1, @PageSize = 25,@LeaveDateFrom ='',@LeaveDateTo ='', 
@DecisiveDateFrom ='', @DecisiveDateTo ='',@VoucherLeaveSchool='', @Proponent='',  @Student  ='', @Decider ='',@SearchWhere = '' 

---Lọc nâng cao 
EXEC EDMP2080 @DivisionID= 'BE', @DivisionList = 'BE', @UserID = '', @LanguageID = 'vi-VN', @PageNumber = 1, @PageSize = 25,@LeaveDateFrom ='',@LeaveDateTo ='', 
@DecisiveDateFrom ='', @DecisiveDateTo ='',@VoucherLeaveSchool='', @Proponent='',  @Student  ='', @Decider ='',@SearchWhere =N'WHERE ISNULL(VoucherLeaveSchool,'''') = N''QDNH/2019/02/0003''' 

*/

CREATE PROCEDURE EDMP2080 ( 
        @DivisionID VARCHAR(50), 
		@DivisionList VARCHAR(MAX), 
		@UserID VARCHAR(50),
	    @LanguageID VARCHAR(50),
		@PageNumber INT,
		@PageSize INT,		
		@VoucherLeaveSchool VARCHAR(50), --Số quyết định
		@StudentID NVARCHAR(250),-- Giá trị có thể Mã hoặc Tên học sinh
		@SchoolYearID VARCHAR(50),
		@GradeID VARCHAR(50),
		@ClassID VARCHAR(50),
		@SearchWhere NVARCHAR(MAX) = NULL -- Lọc nâng cao
) 
AS 

DECLARE 

	@sSQL NVARCHAR(MAX),
	@sWhere NVARCHAR(MAX) = N'',
	@OrderBy NVARCHAR(500) = N'', 
	@TotalRow NVARCHAR(50) = N''

	IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	SET @OrderBy = 'CreateDate DESC,VoucherLeaveSchool'
	SET @sWhere = '1 = 1 '


	IF ISNULL(@SearchWhere, '') = '' --Lọc thường 
	BEGIN 
	IF ISNULL(@DivisionList, '') <> ''
		SET @sWhere = @sWhere + N'AND T1.DivisionID IN ('''+@DivisionList+''')'
	ELSE 
		SET @sWhere = @sWhere + N'AND T1.DivisionID = '''+@DivisionID + ''''

	-- Số chứng từ
	IF ISNULL(@VoucherLeaveSchool, '') <> ''
	BEGIN  
		SET @sWhere = @sWhere + N' AND T1.VoucherLeaveSchool  LIKE ''%'+@VoucherLeaveSchool +'%'''
	END

	-- Năm học
	IF ISNULL(@SchoolYearID, '') <> '' 
	BEGIN
		SET @sWhere = @sWhere + N' AND T1.SchoolYearID  LIKE ''%'+@SchoolYearID +'%'''
	END

	-- Khối
	IF ISNULL(@GradeID, '') <> '' 
	BEGIN
		SET @sWhere = @sWhere + N' AND T1.GradeID  LIKE ''%'+@GradeID +'%'''
	END

	-- Lớp
	IF ISNULL(@ClassID, '') <> '' 
	BEGIN
		SET @sWhere = @sWhere + N' AND T1.ClassID  LIKE ''%'+@ClassID +'%'''
	END

	IF ISNULL(@StudentID, '') <> '' 
	BEGIN
		SET @sWhere = @sWhere + N' AND ( T1.StudentID LIKE ''%'+@StudentID +'%'' OR A6.StudentName LIKE ''%'+@StudentID +'%'' )'
	END

	
	--nếu giá trị NULL thì set về rổng 
	SET @SearchWhere = Isnull(@SearchWhere, '')
	END 


SET @sSQL =  N'
SELECT DISTINCT * 
INTO #EDMP2080
FROM 
(
	SELECT  
	ISNULL(T1.APKVoucher, T1.APK) as APKVoucher ,T1.DivisionID, T1.VoucherLeaveSchool, T1.DecisiveDate,	
	A1.FullName AS ProponentName,  
	A2.FullName AS DeciderName, 
	T1.LeaveDate, T1.Reason, T1.Description,
	T1.SchoolYearID
	,A3.GradeID,A4.GradeName,
	A3.ClassID, A5.ClassName,
	T1.IsGraduate, T1.CreateDate
	, T1.IsClassUp
	FROM EDMT2080 T1  WITH (NOLOCK)
	LEFT JOIN AT1103  A1 WITH (NOLOCK) ON T1.ProponentID = A1.EmployeeID AND A1.DivisionID IN (T1.DivisionID,''@@@'')
	LEFT JOIN AT1103  A2 WITH (NOLOCK) ON T1.DeciderID = A2.EmployeeID AND A2.DivisionID IN (T1.DivisionID,''@@@'')
	LEFT JOIN EDMT2020 A3 WITH (NOLOCK) ON A3.ArrangeClassID = T1.ArrangeClassID AND A3.DeleteFlg = 0 AND A3.SchoolYearID = T1.SchoolYearID
	LEFT JOIN EDMT1000 A4 WITH (NOLOCK) ON A4.GradeID = A3.GradeID
	LEFT JOIN EDMT1020 A5 WITH (NOLOCK) ON A5.ClassID = A3.ClassID
	LEFT JOIN EDMT2010 A6 WITH (NOLOCK) ON T1.StudentID = A6.StudentID

	WHERE '+@sWhere+' AND T1.DeleteFlg =0  
 ) AS A 

	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * 
	FROM #EDMP2080 AS Temp
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


