IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2040]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2040]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form EDMF2040: điểm danh
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
EXEC EDMP2040 @DivisionID ='BE',@DivisionList ='', @UserID='',@LanguageID='',@PageNumber='1',@PageSize='25',@VoucherNo='',@AttendanceDateFrom='',@AttendanceDateTo='',@SchoolYearID='',@GradeID='',
@ClassID='',@SearchWhere=''

---Lọc nâng cao 
EXEC EDMP2040 @DivisionID ='BE',@DivisionList ='', @UserID='',@LanguageID='',@PageNumber='1',@PageSize='25',@VoucherNo='',@AttendanceDateFrom='',@AttendanceDateTo='',@SchoolYearID='',@GradeID='',
@ClassID='',@SearchWhere=N'WHERE ISNULL(VoucherNo,'''') = N''DD/2019/01/0001'''

*/


CREATE PROCEDURE [dbo].[EDMP2040]
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @LanguageID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @VoucherNo VARCHAR(50),
	 @AttendanceDateFrom DATETIME,
	 @AttendanceDateTo DATETIME,
	 @SchoolYearID VARCHAR(50),
	 @GradeID VARCHAR(50),
	 @ClassID VARCHAR(50),
	 @SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường
)
AS 
SET NOCOUNT ON

DECLARE @cLan VARCHAR(1)
DECLARE @sSQL NVARCHAR (MAX) ='',
        @sWhere NVARCHAR(4000),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
                

SET @OrderBy = 'AttendanceDate DESC,ClassID'
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
SET @sWhere = ' 1 = 1 '


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
	IF @AttendanceDateFrom <> ''
		SET @sWhere = @sWhere + ' AND A.AttendanceDate >= ''' + CONVERT(VARCHAR(8), @AttendanceDateFrom, 112) + ''' '
	IF @AttendanceDateTo <> ''
		SET @sWhere = @sWhere + ' AND A.AttendanceDate <= ''' + CONVERT(VARCHAR(8), @AttendanceDateTo, 112) + ''' '

	--nếu giá trị NULL thì set về rổng 
	SET @SearchWhere = Isnull(@SearchWhere, '')
	END  


SET @sSQL = @sSQL + '
SELECT 
	A.DivisionID, A.APK, A.VoucherNo, A.AttendanceDate, A.SchoolYearID, A.SchoolYearID + '' ('' + CONVERT(VARCHAR(10), E.DateFrom, 103) + '' - '' + CONVERT(VARCHAR(10), E.DateTo, 103) + '')'' AS SchoolYearName,
	A.GradeID, C.GradeName, A.ClassID, D.ClassName, 
	A.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = A.CreateUserID) AS CreateUserID, A.CreateDate, 
	A.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = A.LastModifyUserID) AS LastModifyUserID, A.LastModifyDate
INTO #EDMP2040
FROM EDMT2040 A WITH(NOLOCK)
	LEFT JOIN  EDMT1000 C WITH (NOLOCK) ON C.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND C.Disabled = 0 AND A.GradeID = C.GradeID
	LEFT JOIN  EDMT1020 D WITH (NOLOCK) ON D.ClassID = A.ClassID
	LEFT JOIN EDMT1040 E WITH(NOLOCK) ON A.SchoolYearID = E.SchoolYearID
WHERE ' + @sWhere + ' AND A.DeleteFlg = 0  
ORDER BY ' + @OrderBy + '

SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * 
FROM #EDMP2040 AS Temp
'+@SearchWhere +'
ORDER BY '+@OrderBy+'
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'


PRINT(@sSQL)
EXEC (@sSQL)

GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

