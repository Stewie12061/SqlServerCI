IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP20431]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP20431]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load danh sách yêu cầu chuyển kho cho grid master của màn hình chọn
-- <History>
----Created on 27/12/2022 by Anh Đô
-- <Example>
--EXEC [WMP20431] @DivisionID = N'1B', @IsPeriod = N'0', @FromDate = N'', @ToDate = N'', @FromPeriod = N'', @ToPeriod = N'', @ObjectID = N'', @VoucherNo = N'', @ImWareHouseName = N'', @ExWareHouseName = N''

CREATE PROC WMP20431
			@DivisionID			VARCHAR(50)
			,@IsPeriod			TINYINT
			,@FromDate			DATETIME
			,@ToDate			DATETIME
			,@FromPeriod		VARCHAR(50)
			,@ToPeriod			VARCHAR(50)
			,@ImWareHouseName	NVARCHAR(250)
			,@ExWareHouseName	NVARCHAR(250)
			,@ObjectID			VARCHAR(50)
			,@VoucherNo			VARCHAR(50)
			,@PageNumber		INT = 1
			,@PageSize			INT = 25
			,@CustomSearch		NVARCHAR(MAX) = ''
AS
BEGIN
	DECLARE  @sSql					NVARCHAR(MAX)
			,@sSqlApproveLevel		NVARCHAR(MAX)
			,@TotalRow				VARCHAR(10)
			,@sWhere				NVARCHAR(MAX)
			,@ApproveLevel			INT

	SET		@sWhere = ''
	SET		@sSqlApproveLevel = ''

	IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

	-- Lọc theo thời gian
	IF ISNULL(@IsPeriod, 1) = 0
	BEGIN
		IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '') SET @sWhere = @sWhere + N'
		AND ISNULL(CONVERT(VARCHAR, W.VoucherDate, 120),'''') >= '''+ISNULL(CONVERT(VARCHAR, @FromDate, 120),'')+''''
		IF (ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '') SET @sWhere = @sWhere + N'
		AND ISNULL(CONVERT(VARCHAR, W.VoucherDate, 120),'''') <= '''+ISNULL(CONVERT(VARCHAR, @ToDate, 120),'')+''''
		IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '') SET @sWhere = @sWhere + N'
		AND ISNULL(CONVERT(VARCHAR, W.VoucherDate, 120),'''') BETWEEN '''+ISNULL(CONVERT(VARCHAR, @FromDate, 120),'')+''' AND '''+ISNULL(CONVERT(VARCHAR, @ToDate, 120),'')+'''	'
	END
	ELSE
	BEGIN
		SET @sWhere = @sWhere + N'
		AND W.TranMonth + W.TranYear * 100 BETWEEN '+ STR(SUBSTRING(@FromPeriod, 4, 4) * 100 + SUBSTRING(@FromPeriod, 1, 2)) +' AND '+ STR(SUBSTRING(@ToPeriod, 4, 4) * 100 + SUBSTRING(@ToPeriod, 1, 2)) +''
	END

	IF ISNULL(@ImWareHouseName, '') != ''
		SET @sWhere += ' AND A3.WareHouseName LIKE N''%'+ @ImWareHouseName +'%'''
	IF ISNULL(@ExWareHouseName, '') != ''
		SET @sWhere += ' AND A2.WareHouseName LIKE N''%'+ @ExWareHouseName +'%'' '
	IF ISNULL(@ObjectID, '') != ''
		SET @sWhere += ' AND W.ObjectID IN (SELECT Value FROM [dbo].StringSplit('''+ @ObjectID +''', '',''))  '
	IF ISNULL(@VoucherNo, '') != ''
		SET @sWhere += ' AND W.VoucherNo = '''+ @VoucherNo +''' '

	--SELECT @ApproveLevel = S.Levels FROM ST0010 S WITH (NOLOCK) WHERE S.TypeID = 'YCVCNB' AND S.DivisionID IN (@DivisionID, '@@@')
	--IF ISNULL(@ApproveLevel, 0) != 0
	--BEGIN	
	--	IF @ApproveLevel = 1
	--		SET @sSqlApproveLevel = ' AND ISNULL(W.IsConfirm01, 0) != 0 '
	--	ELSE IF @ApproveLevel = 2
	--		SET @sSqlApproveLevel = ' AND ISNULL(W.IsConfirm01, 0) != 0 AND ISNULL(W.IsConfirm02, 0) != 0 '
	--END

	SET @sSql = N'
		SELECT
			 W.DivisionID
			,W.VoucherNo
			,W.VoucherDate
			,A2.WareHouseName AS ExWareHouseName
			,A3.WareHouseName AS ImWareHouseName
			,A1.ObjectName
		INTO #TmpWT0095
		FROM WT0095 W
		LEFT JOIN AT1202 A1 WITH (NOLOCK) ON A1.ObjectID = W.ObjectID AND A1.DivisionID IN ('''+ @DivisionID +''', ''@@@'')
		LEFT JOIN AT1303 A2 WITH (NOLOCK) ON A2.WareHouseID = W.WareHouseID AND A2.DivisionID IN ('''+ @DivisionID +''', ''@@@'')
		LEFT JOIN AT1303 A3 WITH (NOLOCK) ON A3.WareHouseID = W.WareHouseID2 AND A2.DivisionID IN ('''+ @DivisionID +''', ''@@@'')
		WHERE W.DivisionID IN ('''+ @DivisionID +''', ''@@@'') AND W.KindVoucherID = 3
		' + @sWhere + ' ' + @sSqlApproveLevel + ' ' + @CustomSearch + '

		DECLARE @Count INT
		SELECT @Count = COUNT(Voucherno) FROM #TmpWT0095
		SELECT 
			  ROW_NUMBER() OVER(ORDER BY #TmpWT0095.VoucherDate) AS RowNum
			  ,@Count AS TotalRow
			  ,#TmpWT0095.*
		FROM #TmpWT0095
		ORDER BY #TmpWT0095.VoucherDate, #TmpWT0095.VoucherNo
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '

	EXEC(@sSql)
	PRINT(@sSql)
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
