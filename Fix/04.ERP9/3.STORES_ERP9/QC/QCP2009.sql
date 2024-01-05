IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP2009]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[QCP2009]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Master màn hình kế thừa phiếu kiểm tra chất lượng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Nhật Thanh on 19/09/2023
----Modified by ... on ... :


CREATE PROCEDURE [dbo].[QCP2009]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsDate TINYINT, ---- 0: Radiobutton từ ngày có check
					  ---- 1: Radiobutton từ kỳ có check
	 @FromDate DATETIME, 
	 @ToDate DATETIME, 
	 @FromMonth INT, 
	 @FromYear INT, 
	 @ToMonth INT, 
	 @ToYear INT, 
	 @ObjectID VARCHAR(50), 
	 @APK VARCHAR(50)  ----- Addnew truyền ''
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',
@sSQL1 NVARCHAR(MAX) = N'',
			@OrderBy NVARCHAR(MAX) = N'', 
			@TotalRow NVARCHAR(50) = N'',
			@sWhere  NVARCHAR(max) = '',
			@Level INT,
			@i INT = 1, @s VARCHAR(2)

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

SET @sWhere = @sWhere + N'
QCT2000.DivisionID = '''+@DivisionID+''' 
AND QCT2000.[DeleteFlg] != 1 '

IF ISNULL(@ObjectID,N'')<>N''
	SET @SWhere=@SWhere+' AND ISNULL(QCT2000.ObjectID, '''') = '''+@ObjectID+''' '
 

IF @IsDate = 0 
BEGIN
	SET @sWhere = @sWhere + N'
	AND QCT2000.TranMonth + QCT2000.TranYear * 100 BETWEEN '+STR(@FromMonth + @FromYear * 100)+' AND '+STR(@ToMonth + @ToYear * 100)+''
END
ELSE
BEGIN
	IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '') SET @sWhere = @sWhere + N'
	AND ISNULL(CONVERT(VARCHAR, QCT2000.VoucherDate, 120),'''') >= '''+ISNULL(CONVERT(VARCHAR, @FromDate, 120),'')+''''
	IF (ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '') SET @sWhere = @sWhere + N'
	AND ISNULL(CONVERT(VARCHAR, QCT2000.VoucherDate, 120),'''') <= '''+ISNULL(CONVERT(VARCHAR, @ToDate, 120),'')+''''
	IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '') SET @sWhere = @sWhere + N'
	AND ISNULL(CONVERT(VARCHAR, QCT2000.VoucherDate, 120),'''') BETWEEN '''+ISNULL(CONVERT(VARCHAR, @FromDate, 120),'')+''' AND '''+ISNULL(CONVERT(VARCHAR, @ToDate, 120),'')+'''	'
END 

	SET @sSQL =N'SELECT ROW_NUMBER() OVER (ORDER BY QCT2000.VoucherNo) AS RowNum, '+@TotalRow+' AS TotalRow, QCT2000.APK, QCT2000.DivisionID, QCT2000.VoucherDate, QCT2000.VoucherNo, QCT2000.ObjectID, A02.ObjectName, Case when ISNULL(QCT2000.InheritTable,'''')=''MT2210'' THEN M10.VoucherNo when ISNULL(QCT2000.InheritTable,'''')=''OT3001'' THEN O01.VoucherNo end as InheritVoucher 
				From QCT2000
				LEFT JOIN AT1202 A02 ON A02.DivisionID in (QCT2000.DivisionID, ''@@@'') and A02.ObjectID = QCT2000.ObjectID
				LEFT JOIN MT2210 M10 ON QCT2000.DivisionID = M10.DivisionID 
				and CASE WHEN ISNULL(QCT2000.InheritVoucher,'''')='''' then newid() else  CAST(QCT2000.InheritVoucher AS UNIQUEIDENTIFIER) end = M10.APK
				LEFT JOIN OT3001 O01 ON QCT2000.DivisionID = O01.DivisionID 
				and CASE WHEN ISNULL(QCT2000.InheritVoucher,'''')='''' then newid() else  CAST(QCT2000.InheritVoucher AS UNIQUEIDENTIFIER) end = O01.APK
		 WHERE '+@sWhere+'
		 ORDER BY VOUCHERNO
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY		
'

		EXEC (@sSQL)
		PRINT (@sSQL)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO