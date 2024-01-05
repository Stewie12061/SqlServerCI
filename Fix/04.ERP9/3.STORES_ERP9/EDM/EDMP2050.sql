IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2050]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2050]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Grid Nghiệp vụ Kết quả học tập (Màn hình truy vấn)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Minh Hòa , Date: 23/11/2018
-- <Example>
/*


--Lọc thường 
EXEC EDMP2050 @DivisionID= 'BE', @DivisionList = 'BE', @UserID = '', @LanguageID = 'vi-VN', @PageNumber = 1, @PageSize = 25,@DateFrom ='',@DateTo ='',@VoucherResult='', @GradeID  ='', 
@ClassID  ='', @Student  ='', @SearchWhere = '' 
 
 ---Lọc nâng cao 
 EXEC EDMP2050 @DivisionID= 'BE', @DivisionList = 'BE', @UserID = '', @LanguageID = 'vi-VN', @PageNumber = 1, @PageSize = 25,@DateFrom ='',@DateTo ='',@VoucherResult='', @GradeID  ='', 
@ClassID  ='', @Student  ='', @SearchWhere =N'WHERE ISNULL(VoucherResult,'''') = N''KQHT/2019/03/0001'''

*/

CREATE PROCEDURE EDMP2050 ( 
        @DivisionID VARCHAR(50), 
		@DivisionList VARCHAR(MAX), 
		@UserID VARCHAR(50),
	    @LanguageID VARCHAR(50),
		@PageNumber INT,
		@PageSize INT,
		@DateFrom DATETIME,-- Từ Ngày kết quả
		@DateTo DATETIME, -- Đến ngày
		@VoucherResult VARCHAR(50), -- Số kết quả
		@GradeID VARCHAR(50),
		@ClassID VARCHAR(50),
		@Student NVARCHAR(250),-- Giá trị có thể Mã hoặc Tên Học sinh
		@SearchWhere NVARCHAR(MAX) = NULL -- Lọc nâng cao
		
) 
AS 

DECLARE 
	@sSQL NVARCHAR(MAX),
	@sWhere NVARCHAR(MAX) = N'',
	@OrderBy NVARCHAR(500) = N'', 
	@TotalRow NVARCHAR(50) = N''

	IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	SET @OrderBy = 'VoucherResult'
	SET @sWhere = ' 1 = 1 '

	IF ISNULL(@SearchWhere, '') = '' --Lọc thường 
	BEGIN 
	IF ISNULL(@DivisionList, '') <> ''
		SET @sWhere = @sWhere + N'AND T1.DivisionID IN ('''+@DivisionList+''')'
	ELSE 
		SET @sWhere = @sWhere + N'AND T1.DivisionID = '''+@DivisionID+''''
	
	IF (ISNULL(@DateFrom, '') <> '' AND ISNULL(@DateTo, '') = '') 
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.ResultDate,120), 126) >= '''+CONVERT(VARCHAR(10),@DateFrom,126)+''' '
	IF (ISNULL(@DateFrom, '') = '' AND ISNULL(@DateTo, '') <> '') 
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.ResultDate,120), 126) <= '''+CONVERT(VARCHAR(10),@DateTo,126)+''' '
	IF (ISNULL(@DateFrom, '') <> '' AND ISNULL(@DateTo, '') <> '') 
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.ResultDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@DateFrom,126)+''' AND '''+CONVERT(VARCHAR(10),@DateTo,126)+''' '
		
	IF ISNULL(@VoucherResult, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.VoucherResult  LIKE ''%'+@VoucherResult +'%'''
	IF ISNULL(@GradeID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.GradeID  LIKE ''%'+@GradeID +'%'''
	IF ISNULL(@ClassID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.ClassID  LIKE ''%'+@ClassID +'%'''
	IF ISNULL(@Student, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.StudentID  LIKE ''%'+@Student +'%'' '

	--nếu giá trị NULL thì set về rổng 
	SET @SearchWhere = Isnull(@SearchWhere, '')
	END 

SET @sSQL =  N'
	SELECT 
	T1.APK,T1.DivisionID,T1.VoucherResult, T1.ResultDate, 
	T1.SchoolYearID, 
	T3.GradeName, T4.ClassName, 
	T1.StudentID, T5.StudentName AS StudentName,  T1.Content
	INTO #EDMP2050
	FROM EDMT2050 T1  WITH (NOLOCK)
	LEFT JOIN EDMT1000 T3 WITH (NOLOCK) ON T1.GradeID = T3.GradeID 
	LEFT JOIN EDMT1020 T4 WITH (NOLOCK) ON T1.ClassID = T4.ClassID
	LEFT JOIN EDMT2010 T5 WITH (NOLOCK) ON T1.StudentID = T5.StudentID AND T5.DeleteFlg=0
	WHERE '+@sWhere+' AND T1.DeleteFlg =0 
	ORDER BY '+@OrderBy+'

	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * 
	FROM #EDMP2050 AS Temp
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
