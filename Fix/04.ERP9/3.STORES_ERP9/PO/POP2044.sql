IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2044]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2044]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load Grid: màn hình kế thừa báo giá nhà cung cấp
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Kiều Nga on 27/07/2019
----Modified by Trọng Kiên on 18/11/2020: Bổ sung Load theo mã nhà cung cấp
----Modified by ... on...
-- <Example>
---- 
/*-- <Example>
	POP2044 @DivisionID = 'DTI', @UserID = '' , @PageNumber = 1, @PageSize = 25, @IsDate = 1, @FromDate = '', @ToDate = '', @FromMonth = 1, @FromYear = 2018, @ToMonth = 12, @ToYear = 2018

----*/

CREATE PROCEDURE POP2044
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
	 @ObjectID VARCHAR(50) = NULL)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',		
		@sWhere NVARCHAR(MAX) = N'',
		@TotalRow NVARCHAR(50) = N'',
        @OrderBy NVARCHAR(500) = N'',
		@sJoin VARCHAR(MAX) = N''

SET @OrderBy = 'A.VoucherNo'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF @IsDate = 0 
BEGIN
	SET @sWhere = @sWhere + N'
	AND P21.TranMonth + P21.TranYear * 100 BETWEEN '+STR(@FromMonth + @FromYear * 100)+' AND '+STR(@ToMonth + @ToYear * 100)+''
END
ELSE
BEGIN
	IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '') 
		SET @sWhere = @sWhere + N'
		AND P21.VoucherDate >= '''+CONVERT(VARCHAR(10), @FromDate, 120)+''''
	IF (ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '') 
		SET @sWhere = @sWhere + N'
		AND P21.VoucherDate <= '''+CONVERT(VARCHAR(10), @ToDate, 120)+''''
	IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '') 
		SET @sWhere = @sWhere + N'
		AND P21.VoucherDate BETWEEN '''+CONVERT(VARCHAR(10), @FromDate, 120)+''' AND '''+CONVERT(VARCHAR(10), @ToDate, 120)+''' '
END

IF ISNULL(@ObjectID,'') != ''  SET @sWhere = @sWhere + ' AND P21.ObjectID = N'''+@ObjectID+''' '

--Phan quyen theo nghiep vu
SET @sWhere = @sWhere + dbo.GetPermissionVoucherNo(@UserID,'P21.VoucherNo')

SET @sSQL = @sSQL + N'
SELECT DISTINCT P21.APK,P21.VoucherNo,P21.VoucherDate,P21.OverDate,P21.ObjectID,T12.ObjectName,P21.EmployeeID,T13.FullName as EmployeeName,P21.[Description] 
into #POT20211
from POT2021 P21 WITH (NOLOCK)
LEFT JOIN POT2022 P22 WITH (NOLOCK) ON P22.APKMaster = P21.APK
LEFT JOIN AT1202 T12 WITH (NOLOCK) ON P21.ObjectID = T12.ObjectID
LEFT JOIN AT1103 T13 WITH (NOLOCK) ON P21.EmployeeID = T13.EmployeeID
WHERE P21.DivisionID = '''+@DivisionID+'''
AND P21.Status = 1
AND P22.APK NOT IN (SELECT InheritTransactionID FROM AT1031 WITH(NOLOCK) WHERE InheritTableID = ''POT2021'')
AND P22.APK NOT IN (SELECT InheritTransactionID FROM OT2102 WITH(NOLOCK) WHERE InheritTableID = ''POT2021'')
AND P22.APK NOT IN (SELECT InheritTransactionID FROM OT3002 WITH(NOLOCK) WHERE InheritTableID = ''POT2021'')
'+@sWhere +'


SELECT ROW_NUMBER() OVER (ORDER BY A.VoucherNo) AS RowNum, '+@TotalRow+' AS TotalRow, A.*
from #POT20211 A
ORDER BY '+@OrderBy+' 
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
'

PRINT @sSQL
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
