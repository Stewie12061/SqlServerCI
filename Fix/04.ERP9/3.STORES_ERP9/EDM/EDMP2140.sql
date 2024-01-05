IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2140]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2140]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid điều chuyển học sinh (Màn hình truy vấn)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo , Date: 10/10/2018
-- <Example>
/*
---Lọc nâng cao 


---Lọc thường 
EXEC EDMP2140 @DivisionID = 'BE', @DivisionList = '',@TranferStudentNo = '',@ProponentID = '',@StudentID = '',@SchoolIDTo = '', @UserID= '',@FromDateTranfer  = '',@ToDateTranfer = '', @PageNumber = 1, @PageSize = 25, @SearchWhere = ''

EXEC EDMP2140 @DivisionID = 'BE', @DivisionList = '',@TranferStudentNo = '',@ProponentID = '',@StudentID = '',@SchoolIDTo = '', @UserID= '',@FromDateTranfer  = '',@ToDateTranfer = '',
@PageNumber = 1, @PageSize = 25, @SearchWhere =N'WHERE ISNULL(StudentName,'''') = N''Phạm Minh Nghĩa'''


EXEC EDMP2140 @DivisionID, @DivisionList, @TranferStudentNo ,@ProponentID  , @StudentID ,@SchoolIDTo, @UserID,@FromDateTranfer,@ToDateTranfer,  @PageNumber, @PageSize, @SearchWhere

*/
CREATE PROCEDURE EDMP2140 ( 
        @DivisionID VARCHAR(50), 
		@DivisionList VARCHAR(MAX), 
		@TranferStudentNo VARCHAR (50),
		@ProponentID VARCHAR(50),
		@StudentID NVARCHAR(250) ,
		@SchoolIDTo VARCHAR(50),
		@UserID  VARCHAR(50),
		@FromDateTranfer DATETIME,
		@ToDateTranfer DATETIME,  
		@PageNumber INT,
		@PageSize INT,
		@SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường
) 
AS 

DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX) = N'',
		@OrderBy NVARCHAR(500) = N'', 
		@TotalRow NVARCHAR(50) = N''

SET @OrderBy = 'CreateDate DESC,TranferStudentNo' 
SET @TotalRow = 'COUNT(*) OVER ()'


IF ISNULL(@SearchWhere, '') = '' --Lọc thường 
	BEGIN 
IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + 'AND T1.DivisionID IN ('''+@DivisionList+''', ''@@@'') ' 
ELSE
	SET @sWhere = @sWhere + 'AND T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') ' 
IF ISNULL(@TranferStudentNo, '') <> '' 
	SET @sWhere = @sWhere + N' AND T1.TranferStudentNo LIKE N''%'+@TranferStudentNo+'%'''
IF ISNULL(@ProponentID, '') <> '' 
	SET @sWhere = @sWhere + N' AND T1.ProponentID LIKE N''%'+@ProponentID+'%'''
IF ISNULL(@StudentID, '') <> '' 
	SET @sWhere = @sWhere + N' AND (T1.StudentID LIKE N''%'+@StudentID+'%'' OR T3.StudentName LIKE N''%'+@StudentID +'%'' )  '
IF ISNULL(@SchoolIDTo, '') <> '' 
	SET @sWhere = @sWhere + N' AND T1.SchoolIDTo  LIKE N''%'+@SchoolIDTo +'%'''

--Ngày điều chuyển 
IF (ISNULL(@FromDateTranfer, '') <> '' AND ISNULL(@ToDateTranfer, '') = '') SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.DateTranfer,120), 126) >= '''+CONVERT(VARCHAR(10),@FromDateTranfer,126)+''' '

IF (ISNULL(@FromDateTranfer, '') = '' AND ISNULL(@ToDateTranfer, '') <> '') SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.DateTranfer,120), 126) <= '''+CONVERT(VARCHAR(10),@ToDateTranfer,126)+''' '

IF (ISNULL(@FromDateTranfer, '') <> '' AND ISNULL(@ToDateTranfer, '') <> '') SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.DateTranfer,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDateTranfer,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDateTranfer,126)+''' '

		--nếu giá trị NULL thì set về rổng 
	SET @SearchWhere = Isnull(@SearchWhere, '')
	END


SET @sSQL = N'
SELECT T1.APK,T1.DivisionID,T1.TranferStudentNo,T1.DateTranfer,T1.ProponentID,T2.FullName AS ProponentName, T1.StudentID, T3.StudentName,
T3.DivisionID AS SchoolID, T4.DivisionName AS SchoolName, T1.SchoolIDTo,T5.DivisionName AS SchoolNameTo,T1.FromEffectiveDate,T1.ToEffectiveDate,T1.Reason,
T1.CreateDate 
INTO #EDMT2140
FROM EDMT2140 T1 WITH (NOLOCK)
LEFT JOIN AT1103 T2 WITH (NOLOCK)   ON T2.DivisionID IN (T1.DivisionID,''@@@'') AND T1.ProponentID = T2.EmployeeID
LEFT JOIN EDMT2010 T3 WITH (NOLOCK) ON T3.DivisionID = T1.DivisionID AND T3.StudentID = T1.StudentID
LEFT JOIN AT1101 T4 WITH (NOLOCK)   ON T4.DivisionID = T3.DivisionID 
LEFT JOIN AT1101 T5 WITH (NOLOCK)   ON T5.DivisionID = T1.SchoolIDTo
WHERE T1.DeleteFlg = 0 
'+@sWhere+'


SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * FROM #EDMT2140  AS Temp
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
