IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP203601]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP203601]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid: màn hình kế thừa dự trù NVL sản xuất
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Kiều Nga on 16/07/2020
----Updated by Nhật Thanh on 28/03/2023: Bổ sung điều kiện chỉ load những phiếu đã duyệt
----Updated by Nhật Thanh on 17/04/2023: Bổ sung điều kiện không load phiếu đã xóa và phiếu đã kế thừa hết
-- <Example>
---- 
/*-- <Example>
	POP203601 @DivisionID = 'AIC', @UserID = '' , @PageNumber = 1, @PageSize = 25, @IsDate = 1, @FromDate = '', @ToDate = '', @FromMonth = 1, @FromYear = 2018, @ToMonth = 12, @ToYear = 2018, @PriorityID = ''

----*/

CREATE PROCEDURE POP203601
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
	 @VoucherNo VARCHAR(50)=''
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',
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

IF ISNULL(@VoucherNo,'') <> ''
BEGIN
	SET @sWhere = @sWhere + ' AND T1.VoucherNo like ''%' + @VoucherNo + '%'''
END

SET @sSQL =@sSQL +'
SELECT DISTINCT 
T1.APK, T1.DivisionID,T1.VoucherNo,T1.EstimateID,T1.VoucherDate,T1.DepartmentID,T2.DepartmentName,T1.EmployeeID,T3.FullName as EmployeeName
,T1.ObjectID,T4.ObjectName,T1.Description,T1.PeriodID,T5.Description as ObjectTHCP,T1.InventoryTypeID
INTO #OT2201
FROM OT2201 T1 WITH(NOLOCK)
LEFT JOIN OT2202 T12 WITH(NOLOCK) ON T1.APK = T12.APKMaster
LEFT JOIN AT1102 T2 WITH(NOLOCK) ON T1.DepartmentID = T2.DepartmentID
LEFT JOIN AT1103 T3 WITH(NOLOCK) ON T1.EmployeeID = T3.EmployeeID
LEFT JOIN AT1202 T4 WITH(NOLOCK) ON T1.ObjectID = T4.ObjectID
LEFT JOIN MT1601 T5 WITH(NOLOCK) ON T1.PeriodID = T5.PeriodID
WHERE T1.DivisionID = '''+@DivisionID+''' AND T1.DeleteFlg <> 1' + @sWhere +'
AND StatusID = 1
AND NOT EXISTS (SELECT TOP 1 1 from MT2141 WHERE MT2141.InheritTransactionID = convert(nvarchar(50),T12.APK) and ISNULL(DeleteFlg,0)!=1)

SELECT ROW_NUMBER() OVER (ORDER BY T1.VoucherDate desc, '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * FROM #OT2201 T1
ORDER BY '+@OrderBy+' 
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
'
Print @sSQL
Exec (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
