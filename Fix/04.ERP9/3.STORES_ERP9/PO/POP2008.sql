IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2008]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2008]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid: màn hình kế thừa dự trù chi phí
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Đình Hòa on 26/04/2021
----Update - Hồng Thắm - 03/10/2023 - Bổ sung điều kiện trạng thái duyệt và chưa xóa khi kế thừa 
-- <Example>
---- 
/*-- <Example>
	POP2008 @DivisionID = 'AIC', @UserID = '' , @PageNumber = 1, @PageSize = 25, @IsDate = 1, @FromDate = '', @ToDate = '', @FromMonth = 1, @FromYear = 2018, @ToMonth = 12, @ToYear = 2018'
----*/

CREATE PROCEDURE POP2008
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,	 
	 @IsDate TINYINT, ---- 0: Radiobutton từ kỳ có check
					  ---- 1: Radiobutton từ ngày có check
	 @FromDate DATETIME, 
	 @ToDate DATETIME, 
	 @FromMonth INT, 
	 @FromYear INT, 
	 @ToMonth INT, 
	 @ToYear INT,
	 @VoucherNo VARCHAR(50)	 
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',	
		@sSQL1 NVARCHAR(MAX) = N'',
		@sWhere NVARCHAR(MAX) = N'',
		@TotalRow NVARCHAR(50) = N'',
        @OrderBy NVARCHAR(500) = N''

SET @OrderBy = 'T1.VoucherNo'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF @IsDate = 0 
BEGIN
	SET @sWhere = @sWhere + N'
	AND T1.TranMonth + T1.TranYear * 100 BETWEEN '+STR(@FromMonth + @FromYear * 100)+' AND '+STR(@ToMonth + @ToYear * 100)+''
END
ELSE
BEGIN
	IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '') 
		SET @sWhere = @sWhere + N'
		AND T1.VoucherDate >= '''+CONVERT(VARCHAR(10), @FromDate, 120)+''''
	IF (ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '') 
		SET @sWhere = @sWhere + N'
		AND T1.VoucherDate <= '''+CONVERT(VARCHAR(10), @ToDate, 120)+''''
	IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '') 
		SET @sWhere = @sWhere + N'
		AND T1.VoucherDate BETWEEN '''+CONVERT(VARCHAR(10), @FromDate, 120)+''' AND '''+CONVERT(VARCHAR(10), @ToDate, 120)+''' '
END

IF (ISNULL(@VoucherNo, '') <> '' ) 
		SET @sWhere = @sWhere + N' AND T1.VoucherNo = '''+@VoucherNo+''''

SET @sSQL = @sSQL + N'
SELECT DISTINCT T1.APK, T1.VoucherNo, T1.VoucherDate, T1.ObjectID, T2.ObjectName ,T1.Description, T1.EmployeeID, T3.FullName AS EmployeeName
INTO #OT2201
FROM OT2201 T1 WITH (NOLOCK)
LEFT JOIN AT1202 T2 WITH (NOLOCK) ON T1.ObjectID = T2.ObjectID
LEFT JOIN AT1103 T3 WITH (NOLOCK) ON T1.EmployeeID = T3.EmployeeID
WHERE T1.DivisionID = '''+@DivisionID+''' AND  ISNULL(T1.StatusID, 0) = 1 AND ISNULL(T1.DeleteFlg, 1) = 0  '
 +@sWhere +'
'

SET @sSQL1 = @sSQL1 + ' SELECT ROW_NUMBER() OVER (ORDER BY T1.VoucherDate desc, '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * FROM #OT2201 T1
ORDER BY '+@OrderBy+' 
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
'

PRINT @sSQL + @sSQL1
EXEC (@sSQL + @sSQL1)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
