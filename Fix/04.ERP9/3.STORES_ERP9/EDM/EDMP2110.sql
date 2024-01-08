IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2110]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2110]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid tổng khung chương trình (Màn hình truy vấn)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo , Date: 14/09/2018
-- <Example>
/*
----Lọc nâng cao 
EXEC EDMP2110 @DivisionID = 'BE', @DivisionList = '', @ProgramID = '',@TermID = '', @FromVoucherDate = '',@ToVoucherDate = '', @UserID = '', @PageNumber = 1, @PageSize = 25, 
@SearchWhere =N' WHERE ISNULL(ProgramID,'''') = N''TKCT/2019/02/0002'''

--Lọc thường 
EXEC EDMP2110 @DivisionID = 'BE', @DivisionList = '', @ProgramID = '',@TermID = '', @FromVoucherDate = '',@ToVoucherDate = '', @UserID = '', @PageNumber = 1, @PageSize = 25, @SearchWhere = ''


EXEC EDMP2110 @DivisionID, @DivisionList,@ProgramID,@TermID,@FromVoucherDate,@ToVoucherDate, @UserID, @PageNumber, @PageSize, @SearchWhere

*/
CREATE PROCEDURE EDMP2110 ( 
        @DivisionID VARCHAR(50), 
		@DivisionList VARCHAR(MAX), 
		@ProgramID VARCHAR(50), 
		@TermID VARCHAR(50), 
		@FromVoucherDate DATETIME,
		@ToVoucherDate DATETIME,  
		@UserID  VARCHAR(50),
		@PageNumber INT,
		@PageSize INT,
		@SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường
) 
AS 

DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX) = N'',
		@OrderBy NVARCHAR(500) = N'', 
		@TotalRow NVARCHAR(50) = N''

	IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	SET @OrderBy = 'ProgramID'
	SET @sWhere = ' 1 = 1 '

	IF ISNULL(@SearchWhere, '') = '' --Lọc thường 
	BEGIN 
	IF ISNULL(@DivisionList, '') <> ''
		SET @sWhere = @sWhere + N'AND T1.DivisionID IN ('''+@DivisionList+''')'
	ELSE 
		SET @sWhere = @sWhere + N'AND T1.DivisionID = '''+@DivisionID+''''
	IF ISNULL(@ProgramID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.ProgramID LIKE N''%'+@ProgramID+'%'''
	IF ISNULL(@TermID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.TermID LIKE N''%'+@TermID+'%'''
	IF (ISNULL(@FromVoucherDate, '') <> '' AND ISNULL(@ToVoucherDate, '') = '') SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.VoucherDate,120), 126) >= '''+CONVERT(VARCHAR(10),@FromVoucherDate,126)+''' '
	IF (ISNULL(@FromVoucherDate, '') = '' AND ISNULL(@ToVoucherDate, '') <> '') SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.VoucherDate,120), 126) <= '''+CONVERT(VARCHAR(10),@ToVoucherDate,126)+''' '
	IF (ISNULL(@FromVoucherDate, '') <> '' AND ISNULL(@ToVoucherDate, '') <> '') SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.VoucherDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromVoucherDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToVoucherDate,126)+''' '

	--nếu giá trị NULL thì set về rổng 
	SET @SearchWhere = Isnull(@SearchWhere, '')
	END 

SET @sSQL = N'
SELECT T1.APK,T1.DivisionID,T1.ProgramID,T1.VoucherDate,T1.FromDate,T1.ToDate, T1.[Description],
T1.TermID + '' ('' + CONVERT(VARCHAR(10), T2.DateFrom, 103) + '' - '' + CONVERT(VARCHAR(10), T2.DateTo, 103) + '')'' AS TermID
INTO #EDMP2110 
FROM EDMT2110 T1  WITH (NOLOCK)
LEFT JOIN EDMT1040 T2 WITH(NOLOCK) ON T1.TermID = T2.SchoolYearID
WHERE '+@sWhere+' AND T1.DeleteFlg = 0
GROUP BY T1.APK,T1.DivisionID,T1.ProgramID,T1.VoucherDate,T1.TermID,T1.FromDate,T1.ToDate, T1.[Description],T2.DateFrom,T2.DateTo

SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * FROM #EDMP2110  AS Temp
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


