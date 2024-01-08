IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0138_AG]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0138_AG]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Truy vấn ngược báo cáo tổng hợp phát sinh tài khoản chi tiết (ANGEL)
---- Modified by Tiểu Mai on 07/08/2017: Lấy bổ sung Ana02ID, Ana04ID
---- Modified by Phương Thảo on 16/11/2017:  Chỉnh sửa cách lấy dữ liệu: Lấy chi tiết theo chứng từ
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Param>

CREATE PROCEDURE [dbo].[AP0138_AG] 
		@DivisionID NVARCHAR(50),
		@FromPeriod NVARCHAR(50),
		@ToPeriod NVARCHAR(50),		
		@FromDate DATETIME,
		@ToDate DATETIME,
		@FromAccountID NVARCHAR(50),
		@ToAccountID NVARCHAR(50),
		@FromCorAccountID NVARCHAR(50),
		@ToCorAccountID NVARCHAR(50),				
		@GroupID NVARCHAR(50),
		@IsDate TINYINT, -- 0: Theo kỳ, 1: Theo ngày
		@Mode TINYINT -- 0: Nhóm theo đối tương
		              -- 1: Nhóm theo khooản mục chi phí
		              -- 2: Nhóm theo thuế suất thuế TNDN									
AS

DECLARE	@sSQL1 NVARCHAR(MAX),
		@sSQL2 NVARCHAR(MAX),
		@sSQL3 NVARCHAR(MAX),	
		@sSelect NVARCHAR(MAX),	
		@sJoin NVARCHAR(MAX),		
		@sWhere NVARCHAR(MAX),	
		@sGroupBy NVARCHAR(MAX),								
		@FromPeriodText NVARCHAR(10),
		@ToPeriodText NVARCHAR(10),
		@FromDateText NVARCHAR(10),
		@ToDateText NVARCHAR(10)
		
SET @FromPeriodText = CONVERT(NVARCHAR(10), @FromPeriod)		
SET @ToPeriodText = CONVERT(NVARCHAR(10), @ToPeriod)	
SET @FromDateText = CONVERT(NVARCHAR(10), @FromDate, 21)		
SET @ToDateText = CONVERT(NVARCHAR(10), @ToDate, 21)	

IF @Mode = 0
BEGIN
	SET @sSelect = 'V01.ObjectID AS GroupID, AT1202.ObjectName AS GroupName, '
	SET @sJoin = '
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = V01.ObjectID'
	SET @sWhere = '
				AND V01.ObjectID = ''' + @GroupID + '''
				AND V01.CorAccountID BETWEEN ''' + @FromCorAccountID + ''' AND ''' + @ToCorAccountID + ''''				
	SET @sGroupBy = 'V01.ObjectID, AT1202.ObjectName, '				
END
ELSE
IF @Mode = 1
BEGIN
	SET @sSelect = 'V01.Ana04ID AS GroupID, AT1011.AnaName AS GroupName, '	
	SET @sJoin = '
	LEFT JOIN AT1011 WITH (NOLOCK) ON AT1011.DivisionID = V01.DivisionID AND AT1011.AnaID = V01.Ana04ID AND AT1011.AnaTypeID = ''A04'''
	SET @sWhere = '
				AND V01.Ana04ID = ''' + @GroupID + ''''
	SET @sGroupBy = 'V01.Ana04ID, AT1011.AnaName, '						
END	
ELSE
BEGIN
	SET @sSelect = 'V01.Ana06ID AS GroupID, AT1011.AnaName AS GroupName, '	
	SET @sJoin = '
	LEFT JOIN AT1011 WITH (NOLOCK) ON AT1011.DivisionID = V01.DivisionID AND AT1011.AnaID = V01.Ana06ID AND AT1011.AnaTypeID = ''A06'''	
	SET @sWhere = '
				AND V01.Ana06ID = ''' + @GroupID + ''''
	SET @sGroupBy = 'V01.Ana06ID, AT1011.AnaName, '								
END	

IF @IsDate = 0
BEGIN
	SET @sSQL1 = '
	SELECT		DISTINCT V01.DivisionID, V01.BatchID, V01.ConvertedAmount, V01.TranMonth, V01.TranYear, V01.TableID, V01.Status,
				CASE WHEN MAX(V01.D_C) = ''D'' THEN V01.AccountID ELSE V01.CorAccountID END AS DebitAccountID, 
				CASE WHEN MAX(V01.D_C) = ''C'' THEN V01.AccountID ELSE V01.CorAccountID END AS CreditAccountID, 				
				' + @sSelect + '
				V01.TransactionTypeID, V01.VoucherDate, V01.VoucherID, V01.VoucherNo, V01.Description, 
				--SUM(ISNULL(SignAmount, 0)) AS Closing,
				--SUM(CASE WHEN (V01.TranYear * 100 + V01.TranMonth) < ' + @FromPeriodText + '
				--				OR V01.TransactionTypeID IN(''T00'', ''Z00'') THEN ISNULL(SignAmount, 0) 
				--	ELSE 0 END) AS Opening,
				--SUM(CASE WHEN (V01.TranYear * 100 + V01.TranMonth) >= ' + @FromPeriodText + '
				--			   AND V01.D_C = ''D'' AND (V01.TransactionTypeID NOT IN(''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL) 
				--	THEN ISNULL(SignAmount, 0) ELSE 0 END) AS PeriodDebit,
				--SUM(CASE WHEN (V01.TranYear * 100 + V01.TranMonth) >= ' + @FromPeriodText + '
				--				AND V01.D_C = ''C''
				--				AND (V01.TransactionTypeID NOT IN(''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL)
				--	THEN ISNULL(SignAmount, 0) * (-1) ELSE 0 END) AS PeriodCredit,
				V01.Ana02ID, V01.Ana04ID, V01.Ana03ID			
	INTO #TEMP1					
	FROM		AV4301 AS V01
	INNER JOIN	AT1005 AS T1 with (nolock) ON T1.AccountID = V01.AccountID AND T1.DivisionID = V01.DivisionID 
	' + @sJoin + '
	WHERE		V01.DivisionID = ''' + @DivisionID + '''
				AND T1.GroupID <> ''G00''
				AND V01.AccountID BETWEEN ''' + @FromAccountID + ''' AND ''' + @ToAccountID + '''' + @sWhere + '
				AND (V01.TranYear * 100 + V01.TranMonth <= ' + @ToPeriodText + ' AND V01.TranYear * 100 + V01.TranMonth >= ' + @FromPeriodText + ')
	GROUP BY	V01.DivisionID, V01.BatchID, V01.ConvertedAmount, V01.TranMonth, V01.TranYear, V01.TableID, V01.Status,
				V01.AccountID, V01.CorAccountID, ' + @sGroupBy + '
				V01.TransactionTypeID, V01.VoucherDate, V01.VoucherID, V01.VoucherNo, V01.Description, V01.Ana02ID, V01.Ana04ID, V01.Ana03ID		
	'	
END
ELSE
BEGIN
	SET @sSQL1 = '
	SELECT		DISTINCT V01.DivisionID, V01.BatchID, V01.ConvertedAmount, V01.TranMonth, V01.TranYear, V01.TableID, V01.Status,
				CASE WHEN MAX(V01.D_C) = ''D'' THEN V01.AccountID ELSE V01.CorAccountID END AS DebitAccountID, 
				CASE WHEN MAX(V01.D_C) = ''C'' THEN V01.AccountID ELSE V01.CorAccountID END AS CreditAccountID, 
				' + @sSelect + '
				V01.TransactionTypeID, V01.VoucherDate, V01.VoucherID, V01.VoucherNo, V01.Description, 
				--SUM(ISNULL(SignAmount, 0)) AS Closing,
				--SUM(CASE WHEN V01.VoucherDate < ''' + @FromDateText + '''
				--				OR V01.TransactionTypeID IN(''T00'', ''Z00'') THEN ISNULL(SignAmount, 0) 
				--	ELSE 0 END) AS Opening,
				--SUM(CASE WHEN V01.VoucherDate >= ''' + @FromDateText + '''
				--			   AND V01.D_C = ''D'' AND (V01.TransactionTypeID NOT IN(''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL) 
				--	THEN ISNULL(SignAmount, 0) ELSE 0 END) AS PeriodDebit,
				--SUM(CASE WHEN V01.VoucherDate >= ''' + @FromDateText + '''
				--				AND V01.D_C = ''C''
				--				AND (V01.TransactionTypeID NOT IN(''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL)
				--	THEN ISNULL(SignAmount, 0) * (-1) ELSE 0 END) AS PeriodCredit,
				V01.Ana02ID, V01.Ana04ID, V01.Ana03ID		
	INTO #TEMP1							
	FROM		AV4301 AS V01
	INNER JOIN	AT1005 AS T1 with (nolock) ON T1.AccountID = V01.AccountID AND T1.DivisionID = V01.DivisionID ' + @sJoin + '
	WHERE		V01.DivisionID = ''' + @DivisionID + '''
				AND T1.GroupID <> ''G00''
				AND V01.AccountID BETWEEN ''' + @FromAccountID + ''' AND ''' + @ToAccountID + '''' + @sWhere + '
				AND (V01.VoucherDate <= ''' + @ToDateText + ''' AND V01.VoucherDate >= ''' + @FromDateText + ''' )
	GROUP BY	V01.DivisionID, V01.BatchID, V01.ConvertedAmount, V01.TranMonth, V01.TranYear, V01.TableID, V01.Status,
				V01.AccountID, V01.CorAccountID, ' + @sGroupBy + '
				V01.TransactionTypeID, V01.VoucherDate, V01.VoucherID, V01.VoucherNo, V01.Description, V01.Ana02ID, V01.Ana04ID, V01.Ana03ID		
	'		
END	

--SET @sSQL2 = '	
--	SELECT DivisionID, SUM(Opening) AS FNOpening, SUM(Closing) AS FNClosing
--	INTO #TEMP2
--	FROM #TEMP1
--	GROUP BY DivisionID
--'
SET @sSQL3 = '
	SELECT *
	FROM #TEMP1
	WHERE ConvertedAmount <> 0
	ORDER BY #TEMP1.VoucherDate
	--SELECT #TEMP1.*, #TEMP2.FNOpening, #TEMP2.FNClosing
	--FROM #TEMP2
	--LEFT JOIN #TEMP1 ON #TEMP1.DivisionID = #TEMP2.DivisionID AND (#TEMP1.ConvertedAmount <> 0)
	--ORDER BY #TEMP1.VoucherDate
'


--PRINT @sSQL1
--PRINT @sSQL2
--PRINT @sSQL3
EXEC (@sSQL1 + @sSQL2 + @sSQL3)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
