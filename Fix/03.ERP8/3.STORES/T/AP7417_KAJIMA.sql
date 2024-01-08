IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7417_KAJIMA]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP7417_KAJIMA]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Tra ra View xac dinh so du cong no phai tra - chỉ Group theo 1 Mã Phân Tích
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
-----Created by Thành Sang, Date 28/07/2023

-----
-- <Example>
---- 

CREATE PROCEDURE  [dbo].[AP7417_KAJIMA] 
			@DivisionID AS NVARCHAR(50), 
			@FromObjectID AS  NVARCHAR(50),  
			@ToObjectID AS  NVARCHAR(50),  
			@FromAccountID AS NVARCHAR(50),  
			@ToAccountID AS NVARCHAR(50),  
			@CurrencyID NVARCHAR(50),  
			@FromPeriod AS int, 			
			@FromDate AS Datetime, 		
			@IsDate AS tinyint,
			@TypeDate AS NVARCHAR(20),
			@SqlFind AS NVARCHAR(MAX),
			@StrDivisionID AS NVARCHAR(4000)

AS
DECLARE @sSQL AS nvarchar(max),
		@TempCurrID AS NVARCHAR(50),
		@TempCurrIDAna AS NVARCHAR(50),
		@AnaSQL_COLUMN AS NVARCHAR(max),
		@AnaSQL_GROUPBY AS NVARCHAR(max)

		Declare @CustomerName INT
		CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
		INSERT #CustomerName EXEC AP4444
		SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)
--------------->>>> Chuỗi DivisionID
		DECLARE @StrDivisionID_NewAV4202 AS NVARCHAR(4000)
		DECLARE @StrDivisionID_NewAV4203 AS NVARCHAR(4000)
		DECLARE @StrDivisionID_NewV03 AS NVARCHAR(4000)
	
		Set @StrDivisionID_NewAV4202 = ' AV4202.DivisionID LIKE ''' + @DivisionID + '''' 
		Set @StrDivisionID_NewAV4203 = ' AV4203.DivisionID LIKE ''' + @DivisionID + '''' 
		Set @StrDivisionID_NewV03 = ' V03.DivisionID LIKE ''' + @DivisionID + '''' 
---------------<<<< Chuỗi DivisionID


--PRINT 'AP7417_KAJIMA'
--PRINT @SqlFind

-- Tìm AnaID đang được tìm kiếm 
DECLARE @StartPosition INT
DECLARE @EndPosition INT
DECLARE @AnaID NVARCHAR(10)

SET @StartPosition = CHARINDEX('Ana', @SqlFind) + 3 -- Đặt vị trí bắt đầu của chuỗi "AnaID"
SET @EndPosition = CHARINDEX('ID', @SqlFind, @StartPosition) -- Đặt vị trí kết thúc của chuỗi "AnaID"
IF (@StartPosition <> 3 AND @EndPosition <> 0) -- Kiểm tra điều kiện xem có tồn tại AnaID không
SET @AnaID = ',Ana' + SUBSTRING(@SqlFind, @StartPosition, @EndPosition - @StartPosition) + 'ID'


IF @CurrencyID ='%'
	BEGIN
		SET @TempCurrID ='''%'''
		SET @TempCurrIDAna ='''%'''
	END
Else
	BEGIN
		SET @TempCurrID =' AV4202.CurrencyIDCN '
		SET @TempCurrIDAna =' AV4203.CurrencyIDCN '
	End
SET @AnaSQL_COLUMN = ''
SET @AnaSQL_GROUPBY = ''
if @SqlFind <> '1=1'
	BEGIN
		SET @AnaSQL_COLUMN = @AnaID
		SET @AnaSQL_GROUPBY = @AnaSQL_COLUMN
	END
ELSE
	SET @AnaSQL_COLUMN = ',NULL Ana01ID,NULL Ana02ID,NULL Ana03ID,NULL Ana04ID,NULL Ana05ID, NULL Ana06ID, NULL Ana07ID, NULL Ana08ID, NULL Ana09ID, NULL Ana10ID '
	
IF @IsDate not in  (1,2,3)   ---- Xac dinh theo ky	
	Begin
		SET @sSQL =' 
		SELECT 		AV4202.DivisionID,
					AV4202.ObjectID,
					AV4202.AccountID, 		
					' + @TempCurrID+' AS CurrencyIDCN,
					AT1202.ObjectName AS ObjectName,
					AT1005.AccountName AS AccountName,
					SUM(ISNULL(AV4202.OriginalAmountCN,0)) AS OpeningOriginalAmount,
					Sum(ConvertedAmount) AS OpeningConvertedAmount'
					+@AnaSQL_COLUMN+'
		FROM		AV4202	 
		INNER JOIN	AT1202  WITH (NOLOCK) 
			ON		AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV4202.ObjectID
		INNER JOIN	AT1005  WITH (NOLOCK) 
			ON		AT1005.AccountID = AV4202.AccountID
		WHERE		' + @StrDivisionID_NewAV4202 + ' AND
					(AV4202.TranMonth + 100 * AV4202.TranYear < ' + str(@FromPeriod) + ' or (AV4202.TranMonth + 100 * AV4202.TranYear = ' + str(@FromPeriod) + ' AND AV4202.TransactionTypeID =''T00'')) AND
					(AV4202.ObjectID BETWEEN ''' + @FromObjectID + ''' AND ''' + @ToObjectID + ''') AND
					AV4202.CurrencyIDCN like ''' + @CurrencyID + ''''+'	AND '+@SqlFind
			
		IF (@FromAccountID <> '%' AND @ToAccountID <> '%')
			SET @sSQL = @sSQL + ' AND (AV4202.AccountID BETWEEN  ''' + @FromAccountID + ''' AND ''' + @ToAccountID + ''')'
		
		SET @sSQL = @sSQL + ' GROUP BY AV4202.DivisionID, AV4202.ObjectID, AV4202.AccountID, AT1202.ObjectName, AT1005.AccountName '+@AnaSQL_GROUPBY
		
		IF @CurrencyID <> '%'
		SET @sSQL = @sSQL + ' , AV4202.CurrencyIDCN '
	
	End
Else
	 Begin
		SET @sSQL =' 
		SELECT 
					AV4202.DivisionID,
					AV4202.ObjectID,
					AV4202.AccountID,
					' + @TempCurrID + ' AS CurrencyIDCN,
					AT1202.ObjectName,
					AT1005.AccountName AS AccountName,
					SUM(ISNULL(AV4202.OriginalAmountCN,0)) AS OpeningOriginalAmount,
					Sum(ConvertedAmount) AS OpeningConvertedAmount--,
					--Sum(OriginalAmount) AS OpeningOriginalAmount'+@AnaSQL_COLUMN+'
		FROM		AV4202  
		INNER JOIN	AT1202  WITH (NOLOCK) 
			ON		AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV4202.ObjectID
		INNER JOIN	AT1005  WITH (NOLOCK) on AT1005.AccountID = AV4202.AccountID
		WHERE		' + @StrDivisionID_NewAV4202 + ' AND
					((CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) < ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''') or
					 (CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= ''' + convert(NVARCHAR(10), @FromDate, 101) + ''' AND TransactionTypeID = ''T00'')) AND
					(AV4202.ObjectID BETWEEN ''' + @FromObjectID + ''' AND ''' + @ToObjectID + ''')  AND
					(AV4202.AccountID BETWEEN ''' + @FromAccountID + ''' AND ''' + @ToAccountID + ''')  AND
					AV4202.CurrencyIDCN like ''' + @CurrencyID + ''' AND '+@SqlFind+'
		GROUP BY	AV4202.DivisionID, AV4202.ObjectID, AV4202.AccountID, AT1202.ObjectName, AT1005.AccountName '+@AnaSQL_GROUPBY
		IF @CurrencyID <> '%'
		SET @sSQL = @sSQL + ' , AV4202.CurrencyIDCN '
	End	

IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7417]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
	EXEC ('  CREATE VIEW AV7417 AS ' + @sSQL)
ELSE
	EXEC ('  ALTER VIEW AV7417  AS ' + @sSQL)
PRINT @sSQL
IF @IsDate not in ( 1,2,3)   ---- Tinh theo Ky 
	Begin
		SET @sSQL =' 
		SELECT 		AV4203.ObjectID, 
					AV4203.Ana01ID,
					AV4203.AccountID , 
					' + @TempCurrIDAna + ' AS CurrencyIDCN,
					AV4203.DivisionID,
					AT1202.ObjectName ,
					AT1005.AccountName ,
					(SELECT Sum(ConvertedAmount) 
						FROM AV4203 V03
						WHERE ' + @StrDivisionID_NewV03 + ' AND
						(V03.TranMonth + 100*V03.TranYear < '+str(@FromPeriod)+'  or (V03.TranMonth + 100*V03.TranYear = '+str(@FromPeriod)+'  AND V03.TransactionTypeID =''T00'' ) ) AND
						(V03.ObjectID = AV4203.ObjectID) AND
						(V03.AccountID BETWEEN  '''+@FromAccountID+''' AND  '''+@ToAccountID+''' ) AND
						V03.CurrencyIDCN like '''+@CurrencyID+ '''
					) AS OpeningConvertedAmount,
					(SELECT Sum(OriginalAmountCN) 
						FROM AV4203 V03 
						WHERE ' + @StrDivisionID_NewV03 + ' AND
						( V03.TranMonth + 100*V03.TranYear < '+str(@FromPeriod)+'  or (V03.TranMonth + 100*V03.TranYear = '+str(@FromPeriod)+'  AND V03.TransactionTypeID =''T00'' ) ) AND
						(V03.ObjectID = AV4203.ObjectID) AND
						(V03.AccountID BETWEEN  '''+@FromAccountID+''' AND  '''+@ToAccountID+''' ) AND
						V03.CurrencyIDCN like '''+@CurrencyID+ '''
					) AS OpeningOriginalAmount,
					--Sum(ConvertedAmount) AS OpeningConvertedAmountAna01ID,
					Sum(OriginalAmountCN * ExchangeRateCN) AS OpeningConvertedAmountAna01ID,
					Sum(OriginalAmountCN) AS OpeningOriginalAmountAna01ID
		FROM		AV4203	
		INNER JOIN	AT1202  WITH (NOLOCK) 
			ON		AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV4203.ObjectID
		INNER JOIN	AT1005  WITH (NOLOCK) on AT1005.AccountID = AV4203.AccountID
		WHERE	' + @StrDivisionID_NewAV4203 + ' AND
					( AV4203.TranMonth + 100*AV4203.TranYear < '+str(@FromPeriod)+'  or (AV4203.TranMonth + 100*AV4203.TranYear = '+str(@FromPeriod)+'  AND AV4203.TransactionTypeID =''T00'' ) ) AND
					(AV4203.ObjectID BETWEEN '''+ @FromObjectID + ''' AND ''' + @ToObjectID + ''') AND
					(AV4203.AccountID BETWEEN  '''+@FromAccountID+''' AND  '''+@ToAccountID+''' ) AND
					AV4203.CurrencyIDCN like '''+@CurrencyID+'''	
		GROUP BY	AV4203.DivisionID, AV4203.ObjectID,  AV4203.Ana01ID, AV4203.AccountID ,  AT1202.ObjectName, AT1005.AccountName '
		IF @CurrencyID<>'%'
			SET @sSQL =@sSQL +',  AV4203.CurrencyIDCN '
	End
Else
	Begin
		SET @sSQL =' 
		SELECT 		AV4203.ObjectID, AV4203.Ana01ID, AV4203.AccountID , 
					--AV4203.CurrencyID,
					'+@TempCurrIDAna+' AS CurrencyIDCN,
					AV4203.DivisionID,
					AT1202.ObjectName,
					AT1005.AccountName,
					(SELECT Sum(ConvertedAmount) 
						FROM AV4203 V03
						WHERE ' + @StrDivisionID_NewV03 + ' AND
						( (CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) < '''+convert(NVARCHAR(10),@FromDate,101)+'''  )  
						or ( CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= '''+convert(NVARCHAR(10),@FromDate,101)+''' 
						AND TransactionTypeID =''T00'' ) )  AND
						(V03.ObjectID = AV4203.ObjectID) AND
						(V03.AccountID BETWEEN  '''+@FromAccountID+''' AND  '''+@ToAccountID+''' ) AND
						V03.CurrencyIDCN like '''+@CurrencyID+''' 
					) AS OpeningConvertedAmount,
					(SELECT Sum(OriginalAmountCN) 
						FROM AV4203 V03 
						WHERE ' + @StrDivisionID_NewV03 + ' AND
						( (CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) < '''+convert(NVARCHAR(10),@FromDate,101)+'''  )  
						or ( CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= '''+convert(NVARCHAR(10),@FromDate,101)+''' AND TransactionTypeID =''T00'' ) )  AND
						(V03.ObjectID = AV4203.ObjectID) AND
						(V03.AccountID BETWEEN  '''+@FromAccountID+''' AND  '''+@ToAccountID+''' ) AND
						V03.CurrencyIDCN like '''+@CurrencyID+''' 
					) AS OpeningOriginalAmount,
					--Sum(ConvertedAmount) AS OpeningConvertedAmountAna01ID,
					Sum(OriginalAmountCN * ExchangeRateCN) AS OpeningConvertedAmountAna01ID,
					Sum(OriginalAmountCN) AS OpeningOriginalAmountAna01ID
		FROM		AV4203  	
		INNER JOIN	AT1202  WITH (NOLOCK) 
			ON		AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV4203.ObjectID
		INNER JOIN	AT1005  WITH (NOLOCK) 
			ON		AT1005.AccountID = AV4203.AccountID
		WHERE	' + @StrDivisionID_NewAV4203 + ' AND
					( (CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) < '''+convert(NVARCHAR(10),@FromDate,101)+'''  )  
					or ( CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) <= '''+convert(NVARCHAR(10),@FromDate,101)+''' AND TransactionTypeID =''T00'' ) )  AND
					(AV4203.ObjectID BETWEEN '''+ @FromObjectID + ''' AND ''' + @ToObjectID + ''') AND
					(AV4203.AccountID BETWEEN  '''+@FromAccountID+''' AND  '''+@ToAccountID+''' ) AND
					AV4203.CurrencyIDCN like '''+@CurrencyID+'''	
		GROUP BY AV4203.DivisionID, AV4203.ObjectID ,  AV4203.Ana01ID, AV4203.AccountID,    AT1202.ObjectName, AT1005.AccountName '
		IF @CurrencyID<>'%'
			SET @sSQL =@sSQL +',  AV4203.CurrencyIDCN '
	End
	

IF not exists (Select name from sysobjects Where id = Object_id(N'[dbo].[AV7427]') AND OBJECTPROPERTY(id, N'IsView') = 1)
	Exec ('  Create View AV7427 AS ' + @sSQL)
Else
	Exec ('  Alter View AV7427  AS ' + @sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

