IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BP3001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BP3001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- BI-Angel: Báo cáo tình hình tài chính
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 27/06/2016 by Trương Ngọc Phương Thảo
---- Modified on 11/07/2016 by Kim Vu: Mode 2 không lấy tranyear
---- Modified by Tiểu Mai on 14/02/2017: Chỉnh sửa không lấy tk 34111
---- Modified by Phương Thảo on 08/02/2018: Bổ sung tùy chỉnh thời gian lấy dữ liệu khi lên dashboard
---- Modified by Phương Thảo on 08/03/2018: Bổ sung mode thời gian 2 năm gần nhất
---- Modified by Kim Thư on 01/04/2019: Không lấy TK 1283 (CustomizeIndex = 57 - angel)
---- Modified by Thành Luân 13/03/2020: Bổ sung điều kiện tìm kiếm với DivisionIDList.
---- Modifed by Thành Luân 23/03/2020: Bổ sung điều kiện where BankAccountID.
---- Modifed by Thành Luân 13/08/2020: Điều chỉnh tham số DivisionIDList không bắt buộc.
---- Modifed by Kiều Nga 11/09/2020: Fix lỗi hiện thị tên tài khoản
---- Modifed by Kiều Nga 03/10/2020: Lấy thêm trường BankAccountID
---- Modifed by Văn Tài  09/02/2022: Fix default giá trị FromAccountID, ToAccountID.
-- <Example>
---- EXEC BP3001 'ANG', 0, '', 1, 2016, '', 3, 2016, '', '', 0
---- EXEC BP3001 'ANG', 0, '', 1, 2016, '', 3, 2016, '', '', 2
---- EXEC BP3001 'ANG', 1, '2016-01-01', 1, 2016, '2016-02-28', 3, 2016, '', '', 2
CREATE PROCEDURE [dbo].[BP3001]
( 				 
				 @DivisionID AS VARCHAR(50), 
				 @IsDate AS TINYINT, 
				 @FromDate AS DATETIME, 
				 @FromMonth AS TINYINT, 
				 @FromYear AS INT, 
				 @ToDate AS DATETIME, 
				 @ToMonth AS TINYINT, 
				 @ToYear AS INT, 
				 @FromAccountID AS VARCHAR(50) = '', 
				 @ToAccountID AS VARCHAR(50) = '', 
				 @Mode AS TINYINT, -- 0:  Bieu do, 1: Bao cao, 2: Tat ca
				 @TimeType Tinyint = NULL,
				 @DivisionIDList AS NVARCHAR(MAX) = NULL
)
AS 
Declare @sSQL AS nvarchar(MAX),
		@sSQL1 AS nvarchar(MAX)	,
		@sSQL2 AS nvarchar(MAX)	,
		@sSQLWhere AS nvarchar(MAX),	
		@sSQLWhere1 AS nvarchar(MAX),
		@CustomerName INT,
		@sSQLWhereDivision NVARCHAR(MAX) = ''

--Check Para DivisionIDList null then get DivisionID 
IF COALESCE(@DivisionIDList, '') = ''
BEGIN
	SET @sSQLWhereDivision = @sSQLWhereDivision + ' T1.DivisionID IN ('''+ @DivisionID+''')'
END
Else
BEGIN
SET @sSQLWhereDivision = @sSQLWhereDivision + ' T1.DivisionID IN ('''+@DivisionIDList+''')'
END

SET @CustomerName = (SELECT CustomerName FROM dbo.CustomerIndex)
		
IF(@TimeType is not null)
BEGIN
	SELECT  TOP 1 @ToMonth = TranMonth, @ToYear = TranYear
	FROM AT9000 WITH(NOLOCK)
	ORDER BY TranYear desc, TranMonth desc

	IF(@TimeType = 0 ) -- 1 năm gần nhất
		SELECT	@FromMonth = MONTH(DATEADD(yyyy,-1,DATEADD(mm,1,CONVERT(Datetime,STR(@ToMonth)+'/'+'1'+'/'++STR(@ToYear))) )) ,
				@FromYear = YEAR(DATEADD(yyyy,-1,DATEADD(mm,1,CONVERT(Datetime,STR(@ToMonth)+'/'+'1'+'/'++STR(@ToYear))) )) 

	IF(@TimeType = 1) -- 6 tháng gần nhất		
		SELECT	@FromMonth = MONTH(DATEADD(mm,-6,DATEADD(mm,1,CONVERT(Datetime,STR(@ToMonth)+'/'+'1'+'/'++STR(@ToYear))) )),
				@FromYear = YEAR(DATEADD(mm,-6,DATEADD(mm,1,CONVERT(Datetime,STR(@ToMonth)+'/'+'1'+'/'++STR(@ToYear))) )) 

	IF(@TimeType = 2) -- 3 tháng gần nhất		
		SELECT	@FromMonth = MONTH(DATEADD(mm,-3,DATEADD(mm,1,CONVERT(Datetime,STR(@ToMonth)+'/'+'1'+'/'++STR(@ToYear))) )),
				@FromYear = YEAR(DATEADD(mm,-3,DATEADD(mm,1,CONVERT(Datetime,STR(@ToMonth)+'/'+'1'+'/'++STR(@ToYear))) ))

	IF(@TimeType = 3) -- 2 năm gần nhất		
			SELECT	@FromMonth = MONTH(DATEADD(yyyy,-2,DATEADD(mm,1,CONVERT(Datetime,STR(@ToMonth)+'/'+'1'+'/'++STR(@ToYear))) )) ,
					@FromYear = YEAR(DATEADD(yyyy,-2,DATEADD(mm,1,CONVERT(Datetime,STR(@ToMonth)+'/'+'1'+'/'++STR(@ToYear))) )) 

END

SET @sSQLWhere = CASE WHEN @IsDate = 0 THEN 'AND (T1.TranMonth + T1.TranYear *100 <= '+STR(@ToMonth)+'+ '+STR(@ToYear)+'*100)'
					ELSE 'AND ( T1.VoucherDate <= '''+Convert(Varchar(50),@ToDate,101)+''')' END


SET @sSQL = N''
IF(@Mode in (0,2))  -- Tra du lieu Bieu Do
BEGIN
	SELECT @sSQL =
	N'	
	SELECT	TranMonth, TranYear, SUM(SignAmount) AS Amount
	INTO	#AV5000_TH_1
	FROM	AV5000 T1
	WHERE '+@sSQLWhereDivision+'
	AND (AccountID LIKE ''111%'' OR AccountID LIKE ''1411'' OR AccountID LIKE ''1412'' OR AccountID LIKE ''1414%''
		OR AccountID LIKE ''112%'' OR AccountID LIKE ''128%'' OR AccountID LIKE ''113%'' OR AccountID LIKE ''121%'' )
	' + CASE WHEN @CustomerName = 57 THEN 'AND (T1.AccountID NOT LIKE ''1283%'')' ELSE '' END + '
	AND VoucherDate <= GETDATE() ' + @sSQLWhere + '
	GROUP BY TranMonth, TranYear
	ORDER BY TranMonth, TranYear

	SELECT T1.TranMonth, T1.TranYear, SUM(T2.Amount)  AS Amount
	INTO	#AV5000_TH_2
	FROM	#AV5000_TH_1 T1
	LEFT JOIN #AV5000_TH_1 T2 ON T1.TranYear *100 + T1.TranMonth >= T2.TranYear *100 + T2.TranMonth 
	GROUP BY T1.TranMonth, T1.TranYear
	
	SELECT LTRIM(RTRIM(TranMonth))+''/''+LTRIM(RTRIM(TranYear)) as ChartLabel, Amount FROM  #AV5000_TH_2 WHERE  1 = 1 AND '+ 
	CASE WHEN @IsDate = 0 THEN 'TranYear*100 + TranMonth BETWEEN '+STR(@FromMonth)+'+ '+STR(@FromYear)+'*100 AND '+STR(@ToMonth)+'+ '+STR(@ToYear)+'*100
	' ELSE 'TranYear*100 + TranMonth BETWEEN '+STR(Month(@FromDate))+'+ '+STR(Year(@FromDate))+'*100 AND '+STR(Month(@ToDate))+'+ '+STR(Year(@ToDate))+'*100' END 


	--print @sSQL
	EXEC (@sSQL)

END
IF(@Mode in (1,2)) -- Tra du lieu Bang bao cao chi tiet
BEGIN
	SELECT @sSQL =
	N'
	SELECT  row_number( )over(partition by  GroupAccountID, IsGroup order by  GroupAccountID, IsGroup Desc, AccountID) As OrderNo,
			AccountID,BankAccountID, AccountName, Amount, GroupAccountID, GroupAccountName, IsGroup, ID, ObjectID
	INTO #BP3001_AV5000
	FROM 
	(
		-- Du lieu tien mat (chi tiet)
		SELECT	T1.AccountID,'''' as BankAccountID, T2.AccountName, SUM(T1.SignAmount) AS Amount,  ''111'' AS GroupAccountID, N''Tiền mặt'' AS GroupAccountName, 0 AS IsGroup, 
				T1.AccountID AS ID, ''%'' AS ObjectID
		FROM	AV5000 T1
		LEFT JOIN AT1005 T2 WITH(NOLOCK) ON T2.DivisionID IN (''@@@'',T1.DivisionID) AND T1.AccountID = T2.AccountID
		WHERE  '+@sSQLWhereDivision+'
		AND (T1.AccountID LIKE ''111%'' OR T1.AccountID LIKE ''1411'' OR T1.AccountID LIKE ''1412'' OR T1.AccountID LIKE ''1414'' )
		AND T1.VoucherDate <= GETDATE() ' + @sSQLWhere + N'
		GROUP BY T1.AccountID, T2.AccountName
		UNION ALL
		SELECT	T1.AccountID,T2.BankAccountID as BankAccountID, T2.BankName AS AccountName, SUM(T1.SignAmount) AS Amount,  ''112'' AS GroupAccountID, N''Tiền ngân hàng'' AS GroupAccountName, 0 AS IsGroup,
				T1.AccountID AS ID, ''%'' AS ObjectID
		FROM	AV5000 T1
		LEFT JOIN AT1016 T2 WITH(NOLOCK) ON T2.DivisionID IN (''@@@'',T1.DivisionID) AND T1.AccountID = T2.AccountID AND T1.BankAccountID = T2.BankAccountID
		WHERE  '+@sSQLWhereDivision+'
		AND (T1.AccountID LIKE ''112%'')
		AND T1.VoucherDate <= GETDATE() ' + @sSQLWhere + N'
		GROUP BY T1.AccountID,T2.BankAccountID, T2.BankName
		UNION ALL
		SELECT	T1.AccountID,'''' as BankAccountID, T2.AccountName AS AccountName, SUM(T1.SignAmount) AS Amount,  ''128'' AS GroupAccountID, N''Tiền gửi tiết kiệm'' AS GroupAccountName, 0 AS IsGroup,
				T1.AccountID AS ID, ''%'' AS ObjectID
		FROM	AV5000 T1
		LEFT JOIN AT1005 T2 WITH(NOLOCK) ON T2.DivisionID IN (''@@@'',T1.DivisionID) AND T1.AccountID = T2.AccountID
		WHERE  '+@sSQLWhereDivision+'
		AND (T1.AccountID LIKE ''128%'') ' + CASE WHEN @CustomerName = 57 THEN 'AND (T1.AccountID NOT LIKE ''1283%'')' ELSE '' END + '
		AND T1.VoucherDate <= GETDATE() ' + @sSQLWhere + N'
		GROUP BY T1.AccountID, T2.AccountName
		UNION ALL
		SELECT	T1.AccountID,'''' as BankAccountID, T2.AccountName AS AccountName, SUM(T1.SignAmount) AS Amount,  ''113'' AS GroupAccountID, N''Tiền đang chuyển'' AS GroupAccountName, 0 AS IsGroup,
				T1.AccountID AS ID, ''%'' AS ObjectID
		FROM	AV5000 T1
		LEFT JOIN AT1005 T2 WITH(NOLOCK) ON T2.DivisionID IN (''@@@'',T1.DivisionID) AND T1.AccountID = T2.AccountID
		WHERE  '+@sSQLWhereDivision+' 
		AND (T1.AccountID LIKE ''113%'')
		AND T1.VoucherDate <= GETDATE() ' + @sSQLWhere + N'
		GROUP BY T1.AccountID, T2.AccountName		
		UNION ALL
		SELECT	T1.AccountID,'''' as BankAccountID, T2.AccountName AS AccountName, SUM(T1.SignAmount) AS Amount,  ''121'' AS GroupAccountID, N''Chứng khoán kinh doanh'' AS GroupAccountName, 0 AS IsGroup,
				T1.AccountID AS ID, ''%'' AS ObjectID
		FROM	AV5000 T1
		LEFT JOIN AT1005 T2 WITH(NOLOCK) ON T2.DivisionID IN (''@@@'',T1.DivisionID) AND T1.AccountID = T2.AccountID
		WHERE  '+@sSQLWhereDivision+' 
		AND (T1.AccountID LIKE ''121%'')
		AND T1.VoucherDate <= GETDATE() ' + @sSQLWhere + N'
		GROUP BY T1.AccountID, T2.AccountName
		UNION ALL
		'

	SELECT @sSQL1 = N' 
		SELECT  T1.AccountID+ISNULL(T1.ObjectID,'''') AS AccountID,'''' as BankAccountID,
				T2.ObjectName, 			
				SUM(ISNULL(T1.ConvertedAmount, 0)) AS Amount,
				 ''341'' AS GroupAccountID, N''Tiền vay'' AS GroupAccountName, 0 AS IsGroup,
				 T1.AccountID AS ID, ISNULL(T1.ObjectID,'''') AS ObjectID			
		FROM
		(
			SELECT	ObjectID,    ---- PHAT SINH NO  				 
					T1.DivisionID, DebitAccountID AS AccountID,
					SUM(isnull(ConvertedAmount,0)*-1) AS ConvertedAmount,   
					sum(isnull(OriginalAmountCN,0)*-1) AS OriginalAmount,  
					TranMonth,TranYear,   
					CreditAccountID AS CorAccountID,   -- tai khoan doi ung  
					''D'' AS D_C, TransactionTypeID ,
					AT1005.GroupID 
			FROM	AT9000 T1 with (nolock)
			inner join AT1005 with (nolock) on AT1005.AccountID = T1.DebitAccountID and AT1005.DivisionID = T1.DivisionID  
			WHERE	T1.DebitAccountID IS NOT NULL 
					AND (T1.DebitAccountID LIKE ''34112%'')
					AND '+@sSQLWhereDivision+'
					AND T1.VoucherDate <= GETDATE()					
					' + @sSQLWhere + N'
			GROUP BY ObjectID, T1.DivisionID, DebitAccountID,   
					TranMonth, TranYear, CreditAccountID, TransactionTypeID, AT1005.GroupID     
			UNION ALL  
			------------------- So phat sinh co, lay am  
			SELECT    ---- PHAT SINH CO   
					(Case when TransactionTypeID =''T99'' then CreditObjectID else ObjectID end) as ObjectID,   				
					T1.DivisionID, CreditAccountID AS AccountID, 
					SUM(isnull(ConvertedAmount,0)) AS ConvertedAmount,   
					sum(isnull(OriginalAmountCN,0)) AS OriginalAmount,  
					TranMonth, TranYear,   
					DebitAccountID AS CorAccountID,   
					''C'' AS D_C, TransactionTypeID,
					AT1005.GroupID  
			FROM AT9000 T1 with (nolock) inner join AT1005 with (nolock) on AT1005.AccountID = T1.CreditAccountID and AT1005.DivisionID = T1.DivisionID  
			WHERE	CreditAccountID IS NOT NULL  
					AND (T1.CreditAccountID LIKE ''34112%'')
					AND '+@sSQLWhereDivision+'
					AND T1.VoucherDate <= GETDATE()		
					' + @sSQLWhere + N'
			GROUP BY (Case when TransactionTypeID =''T99'' then CreditObjectID else ObjectID end), T1.DivisionID, CreditAccountID,   
			TranMonth, TranYear, DebitAccountID, TransactionTypeID, AT1005.GroupID 
		)	T1
		LEFT JOIN AT1202 T2 ON T1.DivisionID = T2.DivisionID AND T1.ObjectID = T2.ObjectID	
		GROUP BY T1.ObjectID, T1.AccountID, T2.ObjectName
	) T
	'

	SELECT @sSQL2 =
	N'
	INSERT INTO #BP3001_AV5000
	SELECT ROW_NUMBER() OVER (ORDER BY GroupAccountID) AS OrderNo, 
			GroupAccountID AS AccountID,'''' as BankAccountID, GroupAccountName AS AccountName, SUM(Amount) AS Amount, 
			GroupAccountID AS GroupAccountID, GroupAccountName AS GroupAccountName, 1 AS IsGroup,
			GroupAccountID AS ID, ''%'' AS ObjectID
	FROM  #BP3001_AV5000
	WHERE IsGroup = 0
	GROUP BY GroupAccountID, GroupAccountName

	SELECT 	 * 
	FROM #BP3001_AV5000 
	WHERE	AccountID NOT LIKE ''341%''
	ORDER BY  GroupAccountID, IsGroup Desc, AccountID


	SELECT 	 * 
	FROM #BP3001_AV5000 
	WHERE	AccountID LIKE ''341%''
	ORDER BY  GroupAccountID, IsGroup Desc, AccountID
	'

	print @sSQL
	print @sSQL1
	print @sSQL2
	EXEC (@sSQL + @sSQL1 + @sSQL2)

END






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
