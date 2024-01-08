IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0096]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP0096]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- AP0096
-- <Summary>
---- Stored in báo cáo công nợ phải thu xuất excel (PACIFIC)
---- Created on 08/05/2017 Hải Long
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
---- 

CREATE PROCEDURE [dbo].[AP0096]
	@DivisionID AS nvarchar(50) ,
	@FromMonth AS int,
	@FromYear  AS int,
	@ToMonth  AS int,
	@ToYear  AS int,
	@TypeD AS tinyint,  	
	@FromDate AS datetime,
	@ToDate AS datetime,
	@CurrencyID AS nvarchar(50),
	@FromAccountID AS nvarchar(50),
	@ToAccountID AS nvarchar(50),
	@FromObjectID AS nvarchar(50),
	@ToObjectID AS nvarchar(50),
	@Groupby AS tinyint,
	@StrDivisionID AS NVARCHAR(4000) = '' ,
	@DatabaseName  AS NVARCHAR(250) = ''  
AS

DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX),
		@sSQL2 NVARCHAR(MAX),
		@sSQL2_2 NVARCHAR(MAX),		
		@sSQL3 NVARCHAR(MAX),	
		@sSQL4 NVARCHAR(MAX),		
		@sWhere NVARCHAR(MAX) = '',		
		@sWhere1 NVARCHAR(MAX) = '',							
		@cnt INT,    	      
	    @StrUpdate NVARCHAR(MAX) = '',
	    @StrUpdate1 NVARCHAR(MAX) = '',
	    @StrUpdate2 NVARCHAR(MAX) = '',
		@Count INT 


IF OBJECT_ID('tempdb..#TEMP') IS NOT NULL  
BEGIN
	DROP TABLE #TEMP	
END

CREATE TABLE #TEMP
(
	ObjectID NVARCHAR(50) NULL,
	BeginCol0 DECIMAL(28,8) NULL,
	BeginCol1 DECIMAL(28,8) NULL,	
	BeginCol2 DECIMAL(28,8) NULL,
	BeginCol3 DECIMAL(28,8) NULL,	
	BeginCol4 DECIMAL(28,8) NULL,	
	BeginCol5 DECIMAL(28,8) NULL,	
	BeginCol6 DECIMAL(28,8) NULL,	
	BeginCol7 DECIMAL(28,8) NULL,	
	BeginCol8 DECIMAL(28,8) NULL,	
	BeginCol9 DECIMAL(28,8) NULL,	
	BeginCol10 DECIMAL(28,8) NULL,	
	BeginCol11 DECIMAL(28,8) NULL,	
	BeginCol12 DECIMAL(28,8) NULL,
	BeginCredit DECIMAL(28,8) NULL,			
	BeginDebit DECIMAL(28,8) NULL,
	EndCredit DECIMAL(28,8) NULL,			
	EndDebit DECIMAL(28,8) NULL,
	PeriodCredit DECIMAL(28,8) NULL,			
	PeriodDebit DECIMAL(28,8) NULL,	
	Amount111 DECIMAL(28,8) NULL,	
	Amount112 DECIMAL(28,8) NULL,					
	CreditCol0 DECIMAL(28,8) NULL,
	CreditCol1 DECIMAL(28,8) NULL,	
	CreditCol2 DECIMAL(28,8) NULL,
	CreditCol3 DECIMAL(28,8) NULL,	
	CreditCol4 DECIMAL(28,8) NULL,	
	CreditCol5 DECIMAL(28,8) NULL,	
	CreditCol6 DECIMAL(28,8) NULL,	
	CreditCol7 DECIMAL(28,8) NULL,	
	CreditCol8 DECIMAL(28,8) NULL,	
	CreditCol9 DECIMAL(28,8) NULL,	
	CreditCol10 DECIMAL(28,8) NULL,	
	CreditCol11 DECIMAL(28,8) NULL,	
	CreditCol12 DECIMAL(28,8) NULL,		
	DebitCol0 DECIMAL(28,8) NULL,
	DebitCol1 DECIMAL(28,8) NULL,	
	DebitCol2 DECIMAL(28,8) NULL,
	DebitCol3 DECIMAL(28,8) NULL,	
	DebitCol4 DECIMAL(28,8) NULL,	
	DebitCol5 DECIMAL(28,8) NULL,	
	DebitCol6 DECIMAL(28,8) NULL,	
	DebitCol7 DECIMAL(28,8) NULL,	
	DebitCol8 DECIMAL(28,8) NULL,	
	DebitCol9 DECIMAL(28,8) NULL,	
	DebitCol10 DECIMAL(28,8) NULL,	
	DebitCol11 DECIMAL(28,8) NULL,	
	DebitCol12 DECIMAL(28,8) NULL,
	PeriodCol1 DECIMAL(28,8) NULL,
	PeriodCol2 DECIMAL(28,8) NULL,	
	PeriodCol3 DECIMAL(28,8) NULL,
	PeriodCol4 DECIMAL(28,8) NULL,	
	PeriodCol5 DECIMAL(28,8) NULL,	
	PeriodCol6 DECIMAL(28,8) NULL,	
	PeriodCol7 DECIMAL(28,8) NULL,	
	PeriodCol8 DECIMAL(28,8) NULL,	
	PeriodCol9 DECIMAL(28,8) NULL,	
	PeriodCol10 DECIMAL(28,8) NULL,	
	PeriodCol11 DECIMAL(28,8) NULL,	
	PeriodCol12 DECIMAL(28,8) NULL,	
	PeriodCol13 DECIMAL(28,8) NULL,	
	PeriodCol14 DECIMAL(28,8) NULL,
	PeriodCol15 DECIMAL(28,8) NULL,
	PeriodCol16 DECIMAL(28,8) NULL,
	PeriodCol17 DECIMAL(28,8) NULL,
	PeriodCol18 DECIMAL(28,8) NULL,
	PeriodCol19 DECIMAL(28,8) NULL,	
	PeriodCol20 DECIMAL(28,8) NULL,	
	PeriodCol21 DECIMAL(28,8) NULL,	
	PeriodCol22 DECIMAL(28,8) NULL,	
	PeriodCol23 DECIMAL(28,8) NULL,	
	PeriodCol24 DECIMAL(28,8) NULL,
	PeriodCol25 DECIMAL(28,8) NULL,
	PeriodCol26 DECIMAL(28,8) NULL,
	PeriodCol27 DECIMAL(28,8) NULL,
	PeriodCol28 DECIMAL(28,8) NULL,
	PeriodCol29 DECIMAL(28,8) NULL,	
	PeriodCol30 DECIMAL(28,8) NULL,	
	PeriodCol31 DECIMAL(28,8) NULL,				
	FlagCol0 TINYINT NULL,
	FlagCol1 TINYINT NULL,
	FlagCol2 TINYINT NULL, 
	FlagCol3 TINYINT NULL,
	FlagCol4 TINYINT NULL,
	FlagCol5 TINYINT NULL,	
	FlagCol6 TINYINT NULL,
	FlagCol7 TINYINT NULL,
	FlagCol8 TINYINT NULL, 
	FlagCol9 TINYINT NULL,
	FlagCol10 TINYINT NULL,
	FlagCol11 TINYINT NULL,	
	FlagCol12 TINYINT NULL									
)
	    

INSERT INTO #TEMP (ObjectID)
SELECT ObjectID 
FROM AT1202 
WHERE 
DivisionID IN (@DivisionID, '@@@')
AND ObjectID BETWEEN @FromObjectID AND @ToObjectID
ORDER BY ObjectID	


SET @cnt = 1
IF @TypeD <> 0 -- In theo ngày
BEGIN
	SET @ToMonth = DATEPART(M, @ToDate)
	SET @ToYear = DATEPART(YY, @ToDate)	
	SET @sWhere = ' AND VoucherDate < ''' + CONVERT(NVARCHAR(10), @FromDate, 21) + ''''	
	SET @sWhere1 = ' AND VoucherDate BETWEEN ''' + CONVERT(NVARCHAR(10), @FromDate, 21) + ''' AND ''' + CONVERT(NVARCHAR(10), @ToDate, 21) + ''''
END

--PRINT @ToMonth
--PRINT @ToYear

WHILE @cnt <= @ToMonth
BEGIN	
		
	IF @cnt = 1
	BEGIN  
		SET @sSQL = '		
		UPDATE #TEMP
		SET BeginCol1 = TB.Amount
		FROM #TEMP 
		INNER JOIN 
		(
			SELECT ObjectID, SUM(ISNULL(SignAmount, 0)) AS Amount
			FROM AV4301
			INNER JOIN AT1005 WITH (NOLOCK) ON AT1005.AccountID = AV4301.AccountID  
			WHERE AV4301.DivisionID = ''' + @DivisionID + '''
			AND AT1005.GroupID = ''G03''
			AND AV4301.AccountID BETWEEN ''' + @FromAccountID + ''' AND ''' + @ToAccountID + '''
			AND ObjectID BETWEEN ''' + @FromObjectID + ''' AND ''' + @ToObjectID + '''
			AND (TranYear*100 + TranMonth < ' + CONVERT(NVARCHAR(5), @ToYear) + '*100 + 1 OR TransactionTypeID = ''T00'')
			GROUP BY ObjectID		
		) TB ON TB.ObjectID = #TEMP.ObjectID'
					
		
		PRINT @sSQL										
		EXEC (@sSQL)				
	END		
		
		
	IF @cnt = @ToMonth
	BEGIN
		SET @sSQL1 = '
		UPDATE #TEMP
		SET PeriodCol1 = TB2.[1], 
			PeriodCol2 = TB2.[2], 
			PeriodCol3 = TB2.[3], 
			PeriodCol4 = TB2.[4], 
			PeriodCol5 = TB2.[5], 
			PeriodCol6 = TB2.[6], 
			PeriodCol7 = TB2.[7], 
			PeriodCol8 = TB2.[8], 
			PeriodCol9 = TB2.[9], 
			PeriodCol10 = TB2.[10],			
			PeriodCol11 = TB2.[11],
			PeriodCol12 = TB2.[12],
			PeriodCol13 = TB2.[13],
			PeriodCol14 = TB2.[14],
			PeriodCol15 = TB2.[15],
			PeriodCol16 = TB2.[16],
			PeriodCol17 = TB2.[17],
			PeriodCol18 = TB2.[18],
			PeriodCol19 = TB2.[19],
			PeriodCol20 = TB2.[20],
			PeriodCol21 = TB2.[21],
			PeriodCol22 = TB2.[22],
			PeriodCol23 = TB2.[23],
			PeriodCol24 = TB2.[24],
			PeriodCol25 = TB2.[25],
			PeriodCol26 = TB2.[26],
			PeriodCol27 = TB2.[27],
			PeriodCol28 = TB2.[28],
			PeriodCol29 = TB2.[29],
			PeriodCol30 = TB2.[30],
			PeriodCol31 = TB2.[31]																																														
		FROM #TEMP 
		INNER JOIN 
		(
			SELECT * 
			FROM 
			(				
				SELECT ObjectID, DATEPART(D, VoucherDate) AS Date, -SUM(ISNULL(SignAmount, 0)) AS Amount
				FROM AV4301
				WHERE AV4301.DivisionID = ''' + @DivisionID + '''
				AND AV4301.AccountID BETWEEN ''' + @FromAccountID + ''' AND ''' + @ToAccountID + '''					
				AND AV4301.CorAccountID LIKE ''112%'' 								
				AND ObjectID BETWEEN ''' + @FromObjectID + ''' AND ''' + @ToObjectID + '''
				AND TranYear*100 + TranMonth = ' + CONVERT(NVARCHAR(5), @ToYear) + '*100 + ' + CONVERT(NVARCHAR(5), @cnt) 
				+ @sWhere1 + '
				AND TransactionTypeID <> ''T00''									
				AND AV4301.D_C = ''C''		
				GROUP BY ObjectID, VoucherDate			
			) TB
			PIVOT
			(
			SUM(Amount)
			FOR Date IN (
							[0], [1], [2], [3], [4], [5], [6], [7], [8], [9], [10], 
							[11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
							[21], [22], [23], [24], [25], [26], [27], [28], [29], [30],	[31]			
						)
			) AS PivotTable					
		) TB2 ON TB2.ObjectID = #TEMP.ObjectID			
		'
			
		SET @sSQL2 = '		
		UPDATE #TEMP
		SET Amount112 = TB.Amount
		FROM #TEMP 
		INNER JOIN 
		(
			SELECT ObjectID, -SUM(ISNULL(SignAmount, 0)) AS Amount
			FROM AV4301  
			WHERE AV4301.DivisionID = ''' + @DivisionID + '''
			AND AV4301.AccountID BETWEEN ''' + @FromAccountID + ''' AND ''' + @ToAccountID + '''					
			AND AV4301.CorAccountID LIKE ''112%'' 	
			AND ObjectID BETWEEN ''' + @FromObjectID + ''' AND ''' + @ToObjectID + '''
			AND TranYear*100 + TranMonth = ' + CONVERT(NVARCHAR(5), @ToYear) + '*100 + ' + CONVERT(NVARCHAR(5), @cnt) 
			+ @sWhere1 + '	
			AND TransactionTypeID <> ''T00''							
			AND AV4301.D_C = ''C''			
			GROUP BY ObjectID		
		) TB ON TB.ObjectID = #TEMP.ObjectID
			
		UPDATE #TEMP
		SET Amount111 = TB.Amount
		FROM #TEMP 
		INNER JOIN 
		(
			SELECT ObjectID, -SUM(ISNULL(SignAmount, 0)) AS Amount
			FROM AV4301 
			WHERE AV4301.DivisionID = ''' + @DivisionID + '''
			AND AV4301.AccountID BETWEEN ''' + @FromAccountID + ''' AND ''' + @ToAccountID + '''					
			AND AV4301.CorAccountID NOT LIKE ''112%'' 		
			AND ObjectID BETWEEN ''' + @FromObjectID + ''' AND ''' + @ToObjectID + '''
			AND TranYear*100 + TranMonth = ' + CONVERT(NVARCHAR(5), @ToYear) + '*100 + ' + CONVERT(NVARCHAR(5), @cnt) 
			+ @sWhere1 + '		
			AND TransactionTypeID <> ''T00''						
			AND AV4301.D_C = ''C''			
			GROUP BY ObjectID		
		) TB ON TB.ObjectID = #TEMP.ObjectID			
		'		
		
		PRINT @sSQL1	
		PRINT @sSQL2			
		EXEC (@sSQL1 + @sSQL2)			
		
		IF @TypeD <> 0 -- In theo ngày
		BEGIN
			SET @sSQL1 = '		
			UPDATE #TEMP
			SET CreditCol' + CONVERT(NVARCHAR(5), @cnt + 1) + ' = TB.Amount
			FROM #TEMP 
			INNER JOIN 
			(
				SELECT ObjectID, -SUM(ISNULL(SignAmount, 0)) AS Amount
				FROM AV4301
				WHERE AV4301.DivisionID = ''' + @DivisionID + '''
				AND AV4301.AccountID BETWEEN ''' + @FromAccountID + ''' AND ''' + @ToAccountID + '''									
				AND ObjectID BETWEEN ''' + @FromObjectID + ''' AND ''' + @ToObjectID + '''
				AND TranYear*100 + TranMonth = ' + CONVERT(NVARCHAR(5), @ToYear) + '*100 + ' + CONVERT(NVARCHAR(5), @cnt) 
				+ @sWhere1 + '					
				AND TransactionTypeID <> ''T00''			
				AND AV4301.D_C = ''C''			
				GROUP BY ObjectID		
			) TB ON TB.ObjectID = #TEMP.ObjectID'	
		
			SET @sSQL2 = '		
			UPDATE #TEMP
			SET DebitCol' + CONVERT(NVARCHAR(5), @cnt + 1) + ' = TB.Amount
			FROM #TEMP 
			INNER JOIN 
			(
				SELECT ObjectID, SUM(ISNULL(SignAmount, 0)) AS Amount
				FROM AV4301
				INNER JOIN AT1005 WITH (NOLOCK) ON AT1005.AccountID = AV4301.AccountID  
				WHERE AV4301.DivisionID = ''' + @DivisionID + '''
				AND AT1005.GroupID = ''G03''
				AND AV4301.AccountID BETWEEN ''' + @FromAccountID + ''' AND ''' + @ToAccountID + '''
				AND ObjectID BETWEEN ''' + @FromObjectID + ''' AND ''' + @ToObjectID + '''
				AND TranYear*100 + TranMonth = ' + CONVERT(NVARCHAR(5), @ToYear) + '*100 + ' + CONVERT(NVARCHAR(5), @cnt)
				+ @sWhere1 + '				
				AND TransactionTypeID <> ''T00''				
				AND AV4301.D_C = ''D''			
				GROUP BY ObjectID		
			) TB ON TB.ObjectID = #TEMP.ObjectID'	 					
		
			PRINT @sSQL1	
			PRINT @sSQL2			
			EXEC (@sSQL1 + @sSQL2)				
		END															
	END	
			
			
	SET @sSQL1 = '		
	UPDATE #TEMP
	SET CreditCol' + CONVERT(NVARCHAR(5), @cnt) + ' = TB.Amount
	FROM #TEMP 
	INNER JOIN 
	(
		SELECT ObjectID, -SUM(ISNULL(SignAmount, 0)) AS Amount
		FROM AV4301
		WHERE AV4301.DivisionID = ''' + @DivisionID + '''
		AND AV4301.AccountID BETWEEN ''' + @FromAccountID + ''' AND ''' + @ToAccountID + '''									
		AND ObjectID BETWEEN ''' + @FromObjectID + ''' AND ''' + @ToObjectID + '''
		AND TranYear*100 + TranMonth = ' + CONVERT(NVARCHAR(5), @ToYear) + '*100 + ' + CONVERT(NVARCHAR(5), @cnt) 
		+ @sWhere + '					
		AND TransactionTypeID <> ''T00''			
		AND AV4301.D_C = ''C''			
		GROUP BY ObjectID		
	) TB ON TB.ObjectID = #TEMP.ObjectID'	
		
	SET @sSQL2 = '		
	UPDATE #TEMP
	SET DebitCol' + CONVERT(NVARCHAR(5), @cnt) + ' = TB.Amount
	FROM #TEMP 
	INNER JOIN 
	(
		SELECT ObjectID, SUM(ISNULL(SignAmount, 0)) AS Amount
		FROM AV4301
		INNER JOIN AT1005 WITH (NOLOCK) ON AT1005.AccountID = AV4301.AccountID  
		WHERE AV4301.DivisionID = ''' + @DivisionID + '''
		AND AT1005.GroupID = ''G03''
		AND AV4301.AccountID BETWEEN ''' + @FromAccountID + ''' AND ''' + @ToAccountID + '''
		AND ObjectID BETWEEN ''' + @FromObjectID + ''' AND ''' + @ToObjectID + '''
		AND TranYear*100 + TranMonth = ' + CONVERT(NVARCHAR(5), @ToYear) + '*100 + ' + CONVERT(NVARCHAR(5), @cnt)
		+ @sWhere + '				
		AND TransactionTypeID <> ''T00''				
		AND AV4301.D_C = ''D''			
		GROUP BY ObjectID		
	) TB ON TB.ObjectID = #TEMP.ObjectID'	 					
		
	PRINT @sSQL1	
	PRINT @sSQL2			
	EXEC (@sSQL1 + @sSQL2)				
   
	SET @cnt = @cnt + 1
END	


SET @cnt = 1
IF @TypeD <> 0 -- In theo ngày
BEGIN
	SET @ToMonth = @ToMonth + 1	
END
SET @sSQL1 = ''

WHILE @cnt <= @ToMonth
BEGIN
	
	IF @cnt = 1
	BEGIN
		IF @cnt = @ToMonth
		BEGIN
			SET @StrUpdate = 'ISNULL(BeginCol1,0)'					
		END
		ELSE
		BEGIN
			SET @StrUpdate = '(ISNULL(BeginCol1,0)'				
		END	
			
		SET @StrUpdate1 = 'BeginCol1 = CASE WHEN BeginCol1 < 0 THEN 0 ELSE BeginCol1 END,'
								   		
		SET @StrUpdate2 = ''											
	END
	ELSE
	BEGIN
		IF @cnt = @ToMonth
		BEGIN
			SET @StrUpdate = @StrUpdate + ' + ISNULL(BeginCol' + CONVERT(NVARCHAR(5), @cnt) + ',0))'
			
			SET @StrUpdate1 = @StrUpdate1 + '
									BeginCol' + CONVERT(NVARCHAR(5), @cnt) + ' = CASE WHEN BeginCol' + CONVERT(NVARCHAR(5), @cnt) + ' < 0 THEN 0 ELSE BeginCol' + CONVERT(NVARCHAR(5), @cnt) + ' END,'								   		
									
			SET @StrUpdate2 = @StrUpdate2 + '
									BeginCol' + CONVERT(NVARCHAR(5), @cnt - 1) + ' = CASE WHEN BeginCol' + CONVERT(NVARCHAR(5), @cnt - 1) + ' < 0 THEN 0 ELSE BeginCol' + CONVERT(NVARCHAR(5), @cnt - 1) + ' END,'									
		END	
		ELSE
		BEGIN
			SET @StrUpdate = @StrUpdate + ' + ISNULL(BeginCol' + CONVERT(NVARCHAR(5), @cnt) + ',0)'	
			
			SET @StrUpdate1 = @StrUpdate1 + '
									BeginCol' + CONVERT(NVARCHAR(5), @cnt) + ' = CASE WHEN BeginCol' + CONVERT(NVARCHAR(5), @cnt) + ' < 0 THEN 0 ELSE BeginCol' + CONVERT(NVARCHAR(5), @cnt) + ' END,'						
								   
			SET @StrUpdate2 = @StrUpdate2 + '
									BeginCol' + CONVERT(NVARCHAR(5), @cnt - 1) + ' = CASE WHEN BeginCol' + CONVERT(NVARCHAR(5), @cnt - 1) + ' < 0 THEN 0 ELSE BeginCol' + CONVERT(NVARCHAR(5), @cnt - 1) + ' END,'
																			   
		END		
	END	
	 	
	
	SET @sSQL = '
					UPDATE #TEMP
					SET FlagCol1 = CASE WHEN BeginCol1 > 0 THEN 1 ELSE 0 END							
					
					UPDATE #TEMP
					SET FlagCol2 = CASE WHEN (BeginCol2 > 0 AND FlagCol1 = 0) THEN 1 ELSE 0 END
						
					UPDATE #TEMP
					SET FlagCol3 = CASE WHEN (BeginCol3 > 0 AND FlagCol2 = 0 AND FlagCol1 = 0) THEN 1 ELSE 0 END
						
					UPDATE #TEMP
					SET FlagCol4 = CASE WHEN (BeginCol4 > 0 AND FlagCol3 = 0 AND FlagCol2 = 0 AND FlagCol1 = 0) THEN 1 ELSE 0 END
						
					UPDATE #TEMP
					SET FlagCol5 = CASE WHEN (BeginCol5 > 0 AND FlagCol4 = 0 AND FlagCol3 = 0 AND FlagCol2 = 0 AND FlagCol1 = 0) THEN 1 ELSE 0 END
					
					UPDATE #TEMP
					SET FlagCol6 = CASE WHEN (BeginCol6 > 0 AND FlagCol5 = 0 AND FlagCol4 = 0 AND FlagCol3 = 0 AND FlagCol2 = 0 AND FlagCol1 = 0) THEN 1 ELSE 0 END
					
					UPDATE #TEMP
					SET FlagCol7 = CASE WHEN (BeginCol7 > 0 AND FlagCol6 = 0 AND FlagCol5 = 0 AND FlagCol4 = 0 AND FlagCol3 = 0 AND FlagCol2 = 0 AND FlagCol1 = 0) THEN 1 ELSE 0 END
					
					UPDATE #TEMP
					SET FlagCol8 = CASE WHEN (BeginCol8 > 0 AND FlagCol7 = 0 AND FlagCol6 = 0 AND FlagCol5 = 0 AND FlagCol4 = 0 AND FlagCol3 = 0 AND FlagCol2 = 0 AND FlagCol1 = 0) THEN 1 ELSE 0 END
					
					UPDATE #TEMP
					SET FlagCol9 = CASE WHEN (BeginCol9 > 0 AND FlagCol8 = 0 AND FlagCol7 = 0 AND FlagCol6 = 0 AND FlagCol5 = 0 AND FlagCol4 = 0 AND FlagCol3 = 0 AND FlagCol2 = 0 AND FlagCol0 = 1) THEN 1 ELSE 0 END
							
					UPDATE #TEMP
					SET FlagCol10 = CASE WHEN (BeginCol10 > 0 AND FlagCol9 = 0 AND FlagCol8 = 0 AND FlagCol7 = 0 AND FlagCol6 = 0 AND FlagCol5 = 0 AND FlagCol4 = 0 AND FlagCol3 = 0 AND FlagCol2 = 0 AND FlagCol1 = 0) THEN 1 ELSE 0 END
							
					UPDATE #TEMP
					SET FlagCol11 = CASE WHEN (BeginCol11 > 0 AND FlagCol10 = 0 AND FlagCol9 = 0 AND FlagCol8 = 0 AND FlagCol7 = 0 AND FlagCol6 = 0 AND FlagCol5 = 0 AND FlagCol4 = 0 AND FlagCol3 = 0 AND FlagCol2 = 0 AND FlagCol1 = 0) THEN 1 ELSE 0 END
										
					UPDATE #TEMP
					SET FlagCol12 = CASE WHEN (BeginCol12 > 0 AND FlagCol11 = 0 AND FlagCol10 = 0 AND FlagCol9 = 0 AND FlagCol8 = 0 AND FlagCol7 = 0 AND FlagCol6 = 0 AND FlagCol5 = 0 AND FlagCol4 = 0 AND FlagCol3 = 0 AND FlagCol2 = 0 AND FlagCol1 = 0) THEN 1 ELSE 0 END																																																							
	'
	
	SET @sSQL2 = '
					UPDATE #TEMP
					SET
					' + @StrUpdate2 + '											
						FlagCol1  = 0,
						FlagCol2  = 0,
						FlagCol3  = 0,
						FlagCol4  = 0,
						FlagCol5  = 0,
						FlagCol6  = 0,
						FlagCol7  = 0,
						FlagCol8  = 0,
						FlagCol9  = 0,
						FlagCol10  = 0,
						FlagCol11  = 0,
						FlagCol12  = 0															
	'
	
	SET @sSQL2_2 = '
					UPDATE #TEMP
					SET
					' + @StrUpdate1 + '											
						FlagCol1  = 0,
						FlagCol2  = 0,
						FlagCol3  = 0,
						FlagCol4  = 0,
						FlagCol5  = 0,
						FlagCol6  = 0,
						FlagCol7  = 0,
						FlagCol8  = 0,
						FlagCol9  = 0,
						FlagCol10  = 0,
						FlagCol11  = 0,
						FlagCol12  = 0															
	'
	IF @cnt >= 2
	BEGIN
		SET @sSQL1 = ''
		SET @Count = 1	
		WHILE @Count <= @cnt
		BEGIN
			IF @Count <> @cnt
			BEGIN
				IF @Count = 1
				BEGIN
					SET @sSQL1 = @sSQL1 + '									
						UPDATE #TEMP
						SET BeginCol1 = CASE WHEN BeginCol1 > 0 THEN ISNULL(BeginCol1,0) - ISNULL(CreditCol' + CONVERT(NVARCHAR(5), @cnt - 1) + ',0) ELSE BeginCol1 END,
							FlagCol1 =  CASE WHEN BeginCol1 > 0 THEN 1 ELSE 0 END							'					
				END
				ELSE
				BEGIN
					SET @sSQL1 = @sSQL1 + '																		
						UPDATE #TEMP
						SET BeginCol' + CONVERT(NVARCHAR(5), @Count) + ' = CASE WHEN BeginCol' + CONVERT(NVARCHAR(5), @Count - 1) + ' < 0 THEN ISNULL(BeginCol' + CONVERT(NVARCHAR(5), @Count) + ',0) + ISNULL(BeginCol' + CONVERT(NVARCHAR(5), @Count - 1) + ',0) ELSE (CASE WHEN FlagCol' + CONVERT(NVARCHAR(5), @Count - 1) + ' = 0 AND BeginCol' + CONVERT(NVARCHAR(5), @Count) + ' > 0 THEN ISNULL(BeginCol' + CONVERT(NVARCHAR(5), @Count) + ',0) - ISNULL(CreditCol' + CONVERT(NVARCHAR(5), @cnt - 1) + ',0) ELSE ISNULL(BeginCol' + CONVERT(NVARCHAR(5), @Count) + ',0) END) END,
							FlagCol' + CONVERT(NVARCHAR(5), @Count) + ' =  CASE WHEN FlagCol' + CONVERT(NVARCHAR(5), @Count - 1) + ' = 1 OR (FlagCol' + CONVERT(NVARCHAR(5), @Count - 1) + ' = 0 AND BeginCol' + CONVERT(NVARCHAR(5), @Count) + ' > 0) THEN 1 ELSE 0 END'
												
				END			
			END
			ELSE
			BEGIN
				SET @sSQL1 = @sSQL1 + '																		
					UPDATE #TEMP
					SET BeginCol' + CONVERT(NVARCHAR(5), @Count) + ' = 
					CASE WHEN BeginCol' + CONVERT(NVARCHAR(5), @Count - 1) + ' < 0 AND FlagCol' + CONVERT(NVARCHAR(5), @Count - 1) + ' = 0 THEN ISNULL(BeginCol' + CONVERT(NVARCHAR(5), @Count - 1) + ',0) + ISNULL(DebitCol' + CONVERT(NVARCHAR(5), @Count - 1) + ',0) - ISNULL(CreditCol' + CONVERT(NVARCHAR(5), @Count - 1) + ',0) 
						 WHEN BeginCol' + CONVERT(NVARCHAR(5), @Count - 1) + ' < 0 AND FlagCol' + CONVERT(NVARCHAR(5), @Count - 1) + ' = 1 THEN ISNULL(BeginCol' + CONVERT(NVARCHAR(5), @Count - 1) + ',0) + ISNULL(DebitCol' + CONVERT(NVARCHAR(5), @Count - 1) + ',0)
						 WHEN FlagCol' + CONVERT(NVARCHAR(5), @Count - 1) + ' = 0 THEN ISNULL(DebitCol' + CONVERT(NVARCHAR(5), @Count - 1) + ',0) - ISNULL(CreditCol' + CONVERT(NVARCHAR(5), @Count - 1) + ',0) ELSE ISNULL(DebitCol' + CONVERT(NVARCHAR(5), @Count - 1) + ',0) END'									
			END				
				
			SET @Count = @Count + 1	
		END			
	END
		
	IF @cnt = @ToMonth
	BEGIN
		--PRINT '--' + CONVERT(NVARCHAR(5), @cnt)				
			
		SET @sSQL3 = '
		UPDATE #TEMP
		SET BeginDebit = CASE WHEN ' + @StrUpdate + ' > 0 THEN ' + @StrUpdate + ' ELSE 0 END,
			BeginCredit = CASE WHEN ' + @StrUpdate + ' < 0 THEN -' + @StrUpdate + ' ELSE 0 END,
			PeriodDebit = ISNULL(CreditCol' + CONVERT(NVARCHAR(5), @cnt) + ',0),
			PeriodCredit = ISNULL(DebitCol' + CONVERT(NVARCHAR(5), @cnt) + ',0)			
					
			UPDATE #TEMP
			SET EndDebit = CASE WHEN ISNULL(BeginDebit,0) - ISNULL(BeginCredit,0) - ISNULL(CreditCol' + CONVERT(NVARCHAR(5), @cnt) + ',0) + ISNULL(DebitCol' + CONVERT(NVARCHAR(5), @cnt) + ',0) > 0 THEN ISNULL(BeginDebit,0) - ISNULL(BeginCredit,0) - ISNULL(CreditCol' + CONVERT(NVARCHAR(5), @cnt) + ',0) + ISNULL(DebitCol' + CONVERT(NVARCHAR(5), @cnt) + ',0) ELSE 0 END,
				EndCredit = CASE WHEN ISNULL(BeginDebit,0) - ISNULL(BeginCredit,0) - ISNULL(CreditCol' + CONVERT(NVARCHAR(5), @cnt) + ',0) + ISNULL(DebitCol' + CONVERT(NVARCHAR(5), @cnt) + ',0) < 0 THEN -ISNULL(BeginDebit,0) + ISNULL(BeginCredit,0) + ISNULL(CreditCol' + CONVERT(NVARCHAR(5), @cnt) + ',0) - ISNULL(DebitCol' + CONVERT(NVARCHAR(5), @cnt) + ',0) ELSE 0 END										
		'
		
		PRINT @sSQL				
		PRINT @sSQL1	
		PRINT @sSQL2						
		PRINT @sSQL3			
		PRINT @sSQL2_2			
		EXEC (@sSQL + @sSQL1 + @sSQL2 + @sSQL3 + @sSQL2_2)				
				
	END
	ELSE
	BEGIN
		--PRINT '--' + CONVERT(NVARCHAR(5), @cnt)	
		IF @cnt >= 2
		BEGIN
			PRINT @sSQL				
			PRINT @sSQL1		
			PRINT @sSQL2			
			EXEC (@sSQL + @sSQL1 + @sSQL2)				
		END						
		
	END	
				
	--SELECT * FROM #TEMP					
	SET @cnt = @cnt + 1	
END 


DECLARE @MaxDate INT = 31

SET @sSQL1 = N''
SET @cnt = 1
WHILE @cnt <= @MaxDate
BEGIN
	SET @sSQL1 = @sSQL1 + N'SELECT ''PeriodCol' + CONVERT(NVARCHAR(5), @cnt) + ''' AS ColumnID, ''' + CASE WHEN LEN(CONVERT(NVARCHAR(5), @cnt)) = 1 THEN '0' + CONVERT(NVARCHAR(5), @cnt) ELSE CONVERT(NVARCHAR(5), @cnt) END + '/'+ CASE WHEN LEN(CONVERT(NVARCHAR(5), @ToMonth)) = 1 THEN '0' + CONVERT(NVARCHAR(5), @ToMonth) ELSE CONVERT(NVARCHAR(5), @ToMonth) END + '/'+ CONVERT(NVARCHAR(5), @ToYear) + ''' AS ColumnName 
						   UNION ALL '
	SET @cnt = @cnt + 1	
END 

SET @cnt = 1	
WHILE @cnt <= @ToMonth
BEGIN
	IF @cnt = 1
	BEGIN
		IF @cnt = @ToMonth
		BEGIN
			SET @sSQL1 = @sSQL1 + N'SELECT ''BeginCol' + CONVERT(NVARCHAR(5), @cnt) + N''' AS ColumnID, N''Cuối kỳ 12/' + CONVERT(NVARCHAR(5), @ToYear - 1) + ''' AS ColumnName'
		END
		ELSE
		BEGIN
			SET @sSQL1 = @sSQL1 + N'SELECT ''BeginCol' + CONVERT(NVARCHAR(5), @cnt) + N''' AS ColumnID, N''Cuối kỳ 12/' + CONVERT(NVARCHAR(5), @ToYear - 1) + ''' AS ColumnName
								  UNION ALL '											
		END					
	END	
	ELSE
	BEGIN
		IF @cnt = @ToMonth
		BEGIN
			SET @sSQL1 = @sSQL1 + N'SELECT ''BeginCol' + CONVERT(NVARCHAR(5), @cnt) + ''' AS ColumnID, ''' + CASE WHEN LEN(CONVERT(NVARCHAR(5), @cnt - 1)) = 1 THEN '0' + CONVERT(NVARCHAR(5), @cnt - 1)  ELSE CONVERT(NVARCHAR(5), @cnt - 1) END + '/' + CONVERT(NVARCHAR(5), @ToYear) + ''' AS ColumnName'						
		END
		ELSE
		BEGIN
			SET @sSQL1 = @sSQL1 + N'SELECT ''BeginCol' + CONVERT(NVARCHAR(5), @cnt) + ''' AS ColumnID, ''' + CASE WHEN LEN(CONVERT(NVARCHAR(5), @cnt - 1)) = 1 THEN '0' + CONVERT(NVARCHAR(5), @cnt - 1)  ELSE CONVERT(NVARCHAR(5), @cnt - 1) END + '/' + CONVERT(NVARCHAR(5), @ToYear) + ''' AS ColumnName
								  UNION ALL '											
		END	
							
	END	
	
	SET @cnt = @cnt + 1		
END 	


SET @sSQL = N'
SELECT #TEMP.*, AT1202.ObjectName, AT1202.ObjectTypeID, AT1201.ObjectTypeName
FROM #TEMP
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = #TEMP.ObjectID
LEFT JOIN AT1201 WITH (NOLOCK) ON AT1201.ObjectTypeID = AT1202.ObjectTypeID
WHERE (BeginCredit > 0 OR BeginDebit > 0 OR EndCredit> 0 OR EndDebit > 0 OR PeriodCredit> 0 OR PeriodDebit > 0) 
ORDER BY AT1202.ObjectTypeID, AT1202.ObjectID
'

--PRINT @sSQL3
--PRINT @sSQL1
--PRINT @sSQL4
--PRINT @sSQL2

--PRINT @sSQL
EXEC (@sSQL)

--PRINT @sSQL1
EXEC (@sSQL1)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

