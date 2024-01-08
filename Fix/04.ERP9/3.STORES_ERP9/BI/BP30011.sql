IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BP30011]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BP30011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- BI-Angel: Báo cáo tình hình tài chính: Chi tiết tài khoản
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 27/06/2016 by Trương Ngọc Phương Thảo
---- Modified by Tiểu Mai on 27/02/2017: Sửa cách lấy dữ liệu cho trường OriginalAmount
---- Modified by Tiểu Mai on 15/03/2017: Sửa lại lấy số dư đầu kỳ
---- Modifed by Kiều Nga on 11/09/2020: Fix lỗi đk lọc BankAccountID
---- Modifed by Nhựt Trường on 29/09/2022: [2022/09/IS/0150] - Điều chỉnh lại cách update dữ liệu trường BalanceAmount.

-- <Example>
---- EXEC BP30011 'ANG', 0, '', 1, 2016, '', 3, 2016, '1111','%'
---- EXEC BP30011 'ANG', 0, '', 1, 2016, '', 3, 2016, '34111','00405'
---- exec BP30011 @DivisionID=N'CM',@IsDate=0,@FromDate='2020-03-20 00:00:00',@ToDate='2020-03-20 00:00:00',@FromMonth=1,@FromYear=2020,@ToMonth=1,@ToYear=2020,@AccountID=N'1121111',@ObjectID=N'%', @BankAccountID ='VTB.VND.001'

CREATE PROCEDURE [dbo].[BP30011]
( 
				 @DivisionID AS VARCHAR(50), 
				 @IsDate AS TINYINT, 
				 @FromDate AS DATETIME, 
				 @FromMonth AS TINYINT, 
				 @FromYear AS INT, 
				 @ToDate AS DATETIME, 
				 @ToMonth AS TINYINT, 
				 @ToYear AS INT, 
				 @AccountID AS VARCHAR(50),
				 @ObjectID AS VARCHAR(50) = '',
				 @BankAccountID AS VARCHAR(50) = ''
) 
AS 
Declare @sSQL AS nvarchar(MAX),
		@sSQL1 AS nvarchar(MAX)	,
		@sSQL2 AS nvarchar(MAX)	,
		@sSQLWhere AS nvarchar(MAX),	
		@sSQLWhere1 AS nvarchar(MAX) = '',
		@AccountName AS nvarchar(250),
		@ObjectName AS NVarchar(250),
		@FirstDate AS DATETIME,
		@BaseCurrencyID NVARCHAR(50)

SET @BaseCurrencyID = ISNULL((SELECT TOP 1 BaseCurrencyID FROM AT1101 WITH (NOLOCK) WHERE	DivisionID = @DivisionID), 'VND')

SELECT @FirstDate = CONVERT(Datetime,STR(@ToMonth)+'/'+'1'+'/'++STR(@ToYear)) 

SELECT	@AccountName = AccountName
FROM	AT1005
WHERE	AccountID = @AccountID
		
IF @ObjectID <> '%'
BEGIN
	SELECT	@ObjectName = ObjectName
	FROM	AT1202
	WHERE	ObjectID = @ObjectID

	SET @AccountName = @AccountName + '-' + @ObjectName
END	


SET @sSQLWhere = CASE WHEN @IsDate = 0 THEN 'AND ( (T1.TranMonth + T1.TranYear *100 < '+STR(@FromMonth)+'+ '+STR(@FromYear)+'*100) OR T1.TransactionTypeID IN (''T00'',''Z00''))'
					ELSE 'AND ( ( T1.VoucherDate < '''+Convert(Varchar(50),@FromDate,101)+''') OR T1.TransactionTypeID IN (''T00'',''Z00''))' END

IF COALESCE(@BankAccountID, '') <> ''
BEGIN 
SET @sSQLWhere1 = 'And T1.BankAccountID = ''' + @BankAccountID + ''''
END
ELSE
BEGIN
	SET @sSQLWhere1 = ''
END

SET @sSQL = N''

SELECT @sSQL =
N'	
DECLARE @OpeningAmount Decimal(28,8), @AccumulateAmount Decimal(28,8), @ClosingAmount Decimal(28,8)  ,
		@DebitAmount Decimal(28,8), @CreditAmount Decimal(28,8), @BalanceAmount Decimal(28,8), @OrderNo INT 

SELECT	@OpeningAmount = SUM(CASE WHEN T1.AccountID LIKE ''341%'' THEN (-1)* OriginalAmount ELSE OriginalAmount END)			
FROM
		(
			SELECT	ISNULL(ObjectID,'''') AS ObjectID,    ---- PHAT SINH NO  				 
					T1.DivisionID, DebitAccountID AS AccountID,
					SUM(isnull(ConvertedAmount,0)) AS ConvertedAmount,   
					SUM(( 	CASE WHEN  TransactionTypeID = ''T16'' AND T1.CurrencyID = '''+@BaseCurrencyID+''' 
						THEN  ConvertedAmount
				ELSE 
						CASE WHEN  TransactionTypeID = ''T16''   
									AND T1.CurrencyID <> '''+@BaseCurrencyID+''' THEN  OriginalAmount                             
						ELSE T1.OriginalAmount  
						END 
				END)) AS OriginalAmount 								
			FROM	AT9000 T1 with (nolock)			
			WHERE	T1.DebitAccountID IS NOT NULL 					
					AND T1.DivisionID = '''+@DivisionID+''' 
					AND T1.VoucherDate <= GETDATE()	
					AND DebitAccountID LIKE '''+@AccountID+'''
					AND ISNULL(ObjectID,'''') LIKE '''+@ObjectID+'''				
					' + @sSQLWhere + N'
			GROUP BY ISNULL(ObjectID,''''), T1.DivisionID, DebitAccountID     
			UNION ALL  
			------------------- So phat sinh co, lay am  
			SELECT    ---- PHAT SINH CO   
					(Case when T1.TransactionTypeID =''T99'' then ISNULL(T1.CreditObjectID,'''') else ISNULL(T1.ObjectID,'''') end) as ObjectID,   				
					T1.DivisionID, CreditAccountID AS AccountID, 
					SUM(isnull(ConvertedAmount,0)*(-1)) AS ConvertedAmount,   
					SUM(( 	CASE WHEN  TransactionTypeID = ''T16'' AND T1.CurrencyID = '''+@BaseCurrencyID+''' 
						THEN  OriginalAmount
				ELSE 
						CASE WHEN  TransactionTypeID = ''T16''   
									AND T1.CurrencyID <> '''+@BaseCurrencyID+''' THEN  ConvertedAmount      
						ELSE T1.OriginalAmount                     
						END 
				END)*(-1)) AS OriginalAmount										
			FROM AT9000 T1 with (nolock) 
			WHERE	T1.CreditAccountID IS NOT NULL  
					AND T1.DivisionID = '''+@DivisionID+''' 
					AND T1.CreditAccountID LIKE '''+@AccountID+'''
					AND (Case when T1.TransactionTypeID =''T99'' then ISNULL(T1.CreditObjectID,'''') else ISNULL(T1.ObjectID,'''') end) LIKE '''+@ObjectID+'''
					AND T1.VoucherDate <= GETDATE() ' + @sSQLWhere + N'
			GROUP BY (Case when T1.TransactionTypeID =''T99'' then ISNULL(T1.CreditObjectID,'''') else ISNULL(T1.ObjectID,'''') end), T1.DivisionID, CreditAccountID
		)	T1

'
SET @sSQL1 = N'
SET @AccumulateAmount = @OpeningAmount

SELECT	T1.VoucherNo, T1.VoucherDate, T1.AccountID, T1.BankAccountID,
		'+CASE WHEN @ObjectID <> '%'  THEN 'T2.AccountName + '' - '' + '''+@ObjectName+''' ' ELSE  'T2.AccountName' END + ' AS AccountName, 
		T1.CurrencyID AS CurrencyID, T1.VDescription AS Description,
		SUM(CASE WHEN T1.D_C = ''D'' THEN CASE WHEN T1.AccountID LIKE ''341%'' THEN  T1.OriginalAmount * (-1) ELSE  T1.OriginalAmount END ELSE 0 END) AS DebitAmount,
		SUM(CASE WHEN T1.D_C = ''C'' THEN CASE WHEN T1.AccountID LIKE ''341%'' THEN  T1.OriginalAmount   ELSE  T1.OriginalAmount * (-1) END  ELSE 0 END) AS CreditAmount,
		Convert(Decimal(28,8),0) AS BalanceAmount, IDENTITY(int, 1, 1) AS OrderNo
INTO	#BP30011	
FROM
		(
			SELECT	T1.VoucherNo,  T1.VoucherDate,  ---- PHAT SINH NO  
					T1.DebitBankAccountID as BankAccountID,
					T1.DivisionID, DebitAccountID AS AccountID,
					CurrencyIDCN AS CurrencyID, VDescription,					
					( 	CASE WHEN  TransactionTypeID = ''T16'' AND T1.CurrencyID = '''+@BaseCurrencyID+''' 
						THEN  ConvertedAmount
				ELSE 
						CASE WHEN  TransactionTypeID = ''T16''   
									AND T1.CurrencyID <> '''+@BaseCurrencyID+''' THEN  OriginalAmount                             
						ELSE T1.OriginalAmount  
						END 
				END) AS OriginalAmount, 
					TranMonth,TranYear,   					
					''D'' AS D_C, TransactionTypeID,
					0 AS Type
			FROM	AT9000 T1 with (nolock)			
			WHERE  T1.DivisionID = '''+@DivisionID+''' 
					AND DebitAccountID IS NOT NULL  
					AND (T1.DebitAccountID LIKE '''+@AccountID+''')
					AND T1.VoucherDate <= GETDATE() AND 
					ISNULL(T1.TransactionTypeID,'''') NOT IN (''T00'',''Z00'')
					AND ISNULL(ObjectID,'''') LIKE '''+@ObjectID+'''	
					'+
					CASE WHEN @IsDate = 0 THEN ' AND T1.TranYear*100 + T1.TranMonth BETWEEN '+STR(@FromMonth)+'+ '+STR(@FromYear)+'*100 AND '+STR(@ToMonth)+'+ '+STR(@ToYear)+'*100' 
						ELSE ' -- AND T1.TranYear*100 + T1.TranMonth BETWEEN '+STR(Month(@FirstDate))+'+ '+STR(Year(@FromDate))+'*100 AND '+STR(Month(@ToDate))+'+ '+STR(Year(@ToDate))+'*100
						AND T1.VoucherDate BETWEEN '''+Convert(Varchar(50),@FromDate,101)+''' AND '''+Convert(Varchar(50),@ToDate,101)+'''
						' 
						
						
						END +'		 			
			UNION ALL  
			------------------- So phat sinh co, lay am  
			SELECT    ---- PHAT SINH CO   
					T1.VoucherNo,  T1.VoucherDate,  ---- PHAT SINH NO  
					T1.CreditBankAccountID as BankAccountID,
					T1.DivisionID, CreditAccountID AS AccountID,
					CurrencyIDCN AS CurrencyID, VDescription,					
					( 	CASE WHEN  TransactionTypeID = ''T16'' AND T1.CurrencyID = '''+@BaseCurrencyID+''' 
						THEN  OriginalAmount
				ELSE 
						CASE WHEN  TransactionTypeID = ''T16''   
									AND T1.CurrencyID <> '''+@BaseCurrencyID+''' THEN  ConvertedAmount                             
						ELSE T1.OriginalAmount 
						END 
				END) AS OriginalAmount,  
					TranMonth,TranYear,   					
					''C'' AS D_C, TransactionTypeID	,
					CASE WHEN CreditAccountID LIKE ''341%'' THEN 0 ELSE 1 END AS Type
			FROM AT9000 T1 with (nolock) -- inner join AT1005 with (nolock) on AT1005.AccountID = T1.CreditAccountID and AT1005.DivisionID = T1.DivisionID  
			WHERE	CreditAccountID IS NOT NULL  
					AND (T1.CreditAccountID LIKE  '''+@AccountID+''')
					AND T1.DivisionID = '''+@DivisionID+''' 
					AND T1.VoucherDate <= GETDATE()		
					AND ISNULL(T1.TransactionTypeID,'''') NOT IN (''T00'',''Z00'')
					'+
					CASE WHEN @IsDate = 0 THEN ' AND T1.TranYear*100 + T1.TranMonth BETWEEN '+STR(@FromMonth)+'+ '+STR(@FromYear)+'*100 AND '+STR(@ToMonth)+'+ '+STR(@ToYear)+'*100' 
						ELSE ' -- AND T1.TranYear*100 + T1.TranMonth BETWEEN '+STR(Month(@FromDate))+'+ '+STR(Year(@FromDate))+'*100 AND '+STR(Month(@ToDate))+'+ '+STR(Year(@ToDate))+'*100
						AND T1.VoucherDate BETWEEN '''+Convert(Varchar(50),@FromDate,101)+''' AND '''+Convert(Varchar(50),@ToDate,101)+'''						
						' END 
						
						+ N'		 			
				AND (Case when TransactionTypeID =''T99'' then ISNULL(CreditObjectID,'''') else ISNULL(ObjectID,'''') end) LIKE '''+@ObjectID+'''		
		)	T1
LEFT JOIN AT1005 T2 ON T1.DivisionID = T2.DivisionID AND T1.AccountID = T2.AccountID
GROUP BY T1.VoucherNo,T1. VoucherDate, T1.AccountID, T2.AccountName, T1.CurrencyID, T1.VDescription, T1.Type,T1.BankAccountID
ORDER BY T1.VoucherDate, Type, T1.VoucherNo
'
SET @sSQL2 = '
DECLARE @cCURSOR AS CURSOR

SET @cCURSOR = CURSOR STATIC FOR
	SELECT DebitAmount, CreditAmount, BalanceAmount, OrderNo
	FROM #BP30011 
	ORDER BY OrderNo

OPEN @cCURSOR
FETCH NEXT FROM @cCURSOR INTO @DebitAmount, @CreditAmount, @BalanceAmount, @OrderNo
WHILE @@FETCH_STATUS = 0
BEGIN
	
	UPDATE	T1
	SET		@AccumulateAmount = Isnull(@AccumulateAmount,0) + Isnull(@DebitAmount,0) + Isnull(@CreditAmount,0),
			T1.BalanceAmount = Isnull(@AccumulateAmount,0)
	FROM	#BP30011 T1 WHERE OrderNo = @OrderNo '+@sSQLWhere1+'

	FETCH NEXT FROM @cCURSOR INTO @DebitAmount, @CreditAmount, @BalanceAmount, @OrderNo
END

SELECT @OpeningAmount AS OpeningAmount

SELECT	T1.VoucherNo, T1.VoucherDate, T1.AccountID, T1.AccountName, T1.CurrencyID, T1.Description, OrderNo,
		ABS(DebitAmount) AS DebitAmount, ABS(CreditAmount) AS CreditAmount, BalanceAmount,T1.BankAccountID
FROM	#BP30011 T1
where 1=1 '+@sSQLWhere1+'
ORDER BY OrderNo


SELECT  @ClosingAmount = BalanceAmount
FROM	#BP30011 T1
WHERE OrderNo = (SELECT MAX(OrderNo) From #BP30011)'+@sSQLWhere1+'

SELECT ISNULL(@ClosingAmount,@OpeningAmount) AS ClosingAmount, N'''+@AccountName+''' AS AccountName

'
PRINT @sSQL
PRINT @sSQL1
PRINT @sSQL2
EXEC (@sSQL + @sSQL1 + @sSQL2)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
