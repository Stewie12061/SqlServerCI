IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0345]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0345]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




--- Created on 21/05/2015 by Bảo Anh
--- In báo cáo kết quả kinh doanh nhiều kỳ
--- exec AP0345 @DivisionID=N'ANG',@TranMonthFrom=1,@TranYearFrom=2016,@TranMonthTo=3,@TranYearTo=2016, @StrDivisionID=N'ANG'
---- Modified by Hải Long on 06/09/2017: Sửa lại cách lấy dữ liệu theo yêu cầu của khách hàng
---- Modified by Hải Long on 02/10/2017: Làm tròn tỉ lệ

CREATE PROCEDURE [dbo].[AP0345]
			@DivisionID AS nvarchar(50),
			@FromPeriod AS INT,
			@ToPeriod AS INT

AS

DECLARE	@ConvertAmountUnit AS decimal(28,8),
		@D90T4222Cursor AS CURSOR,
		@LineCode AS nvarchar(50),
		@LineDescription AS nvarchar(250),
		@LineDescriptionE AS nvarchar(250),
		@AccountIDFrom AS nvarchar(50),
		@AccountIDTo AS nvarchar(50),
		@CorAccountIDFrom AS nvarchar(50),
		@CorAccountIDTo AS nvarchar(50),
		@AmountSign AS TINYINT,
		@D_C AS TINYINT,
		@AccuSign AS nvarchar(5),
		@Accumulator AS nvarchar(100),
		@PrintStatus AS TINYINT,
		@PrintCode AS nvarchar(50),
		@Level1 AS tinyint,
		@Notes AS nvarchar(50),
		@DisplayedMark AS TINYINT,
		@I05IDCursor AS CURSOR,
		@Amount AS decimal(28,8),
		@I05ID AS nvarchar(50),
		@CorAccountIDFrom1 AS nvarchar(50),
		@CorAccountIDTo1 AS nvarchar(50),
        @ReportCode AS nvarchar(50) = N'B01-KQKD_V_TT200',
		@AmountUnit AS TINYINT = 1							

----------------->>>> Chuỗi DivisionID
--DECLARE @StrDivisionID_New AS NVARCHAR(4000)

--SELECT @StrDivisionID_New = CASE WHEN @StrDivisionID = '%' THEN ' LIKE ''' + 
--@StrDivisionID + '''' ELSE ' IN (''' + replace(@StrDivisionID, ',',''',''') + ''')' END

--DELETE FROM	A00007 WHERE SPID = @@SPID
--INSERT INTO A00007(SPID, DivisionID) 
--EXEC('SELECT '''+@@SPID+''', DivisionID FROM AT1101 WHERE DivisionID '+@StrDivisionID_New+'')	
 
SELECT * 
INTO #TEMP
FROM 
(
	-------------- So phat sinh No, lay so duong
	SELECT AT9000.DivisionID, DebitAccountID AS AccountID, 
		SUM(ConvertedAmount) AS ConvertedAmount, 
		TranMonth,TranYear, 
		CreditAccountID AS CorAccountID,  
		'D' AS D_C, TransactionTypeID, ISNULL(AT1302.I05ID, '99') AS I05ID	
	FROM AT9000 with (nolock)
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID = AT9000.DivisionID AND AT1302.InventoryID = AT9000.InventoryID
	WHERE isnull(DebitAccountID,'') <> ''
		  AND (AT9000.DivisionID = @DivisionID)
		  AND (AT9000.TranYear*100+AT9000.TranMonth BETWEEN @FromPeriod AND @ToPeriod)
	GROUP BY AT9000.DivisionID, DebitAccountID, TranMonth, TranYear, CreditAccountID, TransactionTypeID, ISNULL(AT1302.I05ID, '99')			  
	UNION ALL
	------------------- So phat sinh co, lay am
	SELECT AT9000.DivisionID, CreditAccountID AS AccountID, 
		SUM(ConvertedAmount*-1) AS ConvertedAmount, 
		TranMonth, TranYear, 
		DebitAccountID AS CorAccountID, 
		'C' AS D_C, TransactionTypeID, ISNULL(AT1302.I05ID, '99') AS I05ID
	FROM AT9000 with (nolock)
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID = AT9000.DivisionID AND AT1302.InventoryID = AT9000.InventoryID
	WHERE isnull(CreditAccountID,'')<> ''
		  AND (AT9000.DivisionID = @DivisionID)
		  AND (AT9000.TranYear*100+AT9000.TranMonth BETWEEN @FromPeriod AND @ToPeriod)
	GROUP BY AT9000.DivisionID, CreditAccountID, TranMonth, TranYear, DebitAccountID, TransactionTypeID, ISNULL(AT1302.I05ID, '99')
) A	

--SELECT * FROM #TEMP

DELETE AT7614

IF @AmountUnit = 1 SET @ConvertAmountUnit = 1
IF @AmountUnit = 2 SET @ConvertAmountUnit = 10
IF @AmountUnit = 3 SET @ConvertAmountUnit = 100
IF @AmountUnit = 4 SET @ConvertAmountUnit = 1000
IF @AmountUnit = 5 SET @ConvertAmountUnit = 10000
IF @AmountUnit = 6 SET @ConvertAmountUnit = 100000
IF @AmountUnit = 7 SET @ConvertAmountUnit = 1000000

INSERT INTO AT7614 (
			DivisionID, LineCode, LineDescription, LineDescriptionE, PrintStatus, 		
			Amount, AccuSign, Accumulator, PrintCode, Level1, Notes, DisplayedMark, TypeID, I05ID
)
SELECT		@DivisionID AS DivisionID, '' AS LineCode, N'Tỉ lệ doanh thu theo nhóm hàng' AS LineDescription, N'Tỉ lệ doanh thu theo nhóm hàng' AS LineDescriptionE, 0 AS PrintStatus,
			0, NULL AS AccuSign, NULL AS Accumulator, '10a' AS PrintCode, NULL AS Level1, NULL AS Notes, NULL AS DisplayedMark, NULL AS TypeID, AT1015.AnaID
FROM 
(
	SELECT @DivisionID AS DivisionID, '99' AS AnaID
	UNION ALL
	SELECT DivisionID, AnaID
	FROM AT1015 WITH (NOLOCK)
	WHERE DivisionID = @DivisionID
	AND AT1015.Disabled = 0
	AND AT1015.AnaTypeID = N'I05'	
) AT1015  
		
UNION ALL

SELECT		@DivisionID, T22.LineCode,	T22.LineDescription, T22.LineDescriptionE, T22.PrintStatus,
			0, T22.AccuSign, T22.Accumulator, T22.PrintCode, isnull(T22.Level1,3), T22.Notes, T22.DisplayedMark,
			(case when Isnull(AccountIDFrom,'') like '51%' or Isnull(AccountIDFrom,'') like '7%' then 'A'
				else case when Isnull(AccountIDFrom,'') like '6%' or Isnull(AccountIDFrom,'') like '8%' or Isnull(AccountIDFrom,'') like '333%' then 'B' else '' end
			end), AT1015.AnaID
FROM	AT7602 AS T22
INNER JOIN
(
	SELECT @DivisionID AS DivisionID, '99' AS AnaID
	UNION ALL
	SELECT DivisionID, AnaID
	FROM AT1015 WITH (NOLOCK)
	WHERE DivisionID = @DivisionID
	AND AT1015.Disabled = 0
	AND AT1015.AnaTypeID = N'I05'	
) AT1015 ON T22.DivisionID = AT1015.DivisionID
WHERE	T22.DivisionID = @DivisionID
		AND T22.ReportCode = @ReportCode 
		AND T22.Type = '01'		-- Part I of the report	
				
--SELECT * FROM AT7614

--- Update dòng lợi nhuận sau thuế với TypeID = 'C': lãi/lỗ
UPDATE AT7614 Set TypeID = 'C' WHERE DivisionID = @DivisionID
AND LineCode = (Select top 1 LineCode From AT7614 Where DivisionID = @DivisionID Order by LineCode DESC)

SET @I05IDCursor = CURSOR SCROLL KEYSET FOR
				   SELECT '99' AS AnaID
				   UNION ALL
				   SELECT AnaID 
				   FROM AT1015
				   WHERE AnaTypeID = N'I05'
				   AND Disabled = 0
				   AND DivisionID = @DivisionID
OPEN @I05IDCursor
FETCH NEXT FROM @I05IDCursor INTO @I05ID
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @D90T4222Cursor = CURSOR SCROLL KEYSET FOR
		SELECT	T22.LineCode, 	T22.LineDescription,	T22.LineDescriptionE, 	T22.PrintStatus,		
				T22.AccuSign,	T22.Accumulator,		T22.PrintCode,			T22.Level1,			T22.Notes, T22.DisplayedMark,
				T22.AccountIDFrom ,	T22.AccountIDTo,	T22.CorAccountIDFrom,
				T22.CorAccountIDTo,	T22.D_C,			T22.AmountSign
		FROM	AT7602 AS T22
		WHERE	T22.ReportCode = @ReportCode AND
				T22.Type = '01'		-- Part I of the report
				and DivisionID = @DivisionID
	OPEN @D90T4222Cursor
	FETCH NEXT FROM @D90T4222Cursor INTO
				@LineCode,		@LineDescription, 	@LineDescriptionE, 	@PrintStatus,		@AccuSign,	
				@Accumulator,		@PrintCode,  @Level1, @Notes, @DisplayedMark,
				@AccountIDFrom,	@AccountIDTo,		@CorAccountIDFrom,	
				@CorAccountIDTo,	@D_C,			@AmountSign
	WHILE @@FETCH_STATUS = 0
	BEGIN	
		SET @Amount = 0
		SET @CorAccountIDFrom1 = @CorAccountIDFrom
		SET @CorAccountIDTo1 = @CorAccountIDTo
		IF (@CorAccountIDTo1 = '' OR @CorAccountIDTo1 IS NULL)
			SET @CorAccountIDTo1 = @CorAccountIDFrom1	
		
		IF @LineCode = '25'
		BEGIN
			PRINT 'I05ID: ' + @I05ID
			PRINT 'LineCode: ' + @LineCode
			PRINT '@AmountSign: ' + Convert(nvarchar(10),@AmountSign)
			PRINT 'CorAccountIDFrom1: ' + @CorAccountIDFrom1	
			PRINT 'CorAccountIDTo1: ' + @CorAccountIDTo1	
			PRINT 'AccountIDFrom: ' + @AccountIDFrom	
			PRINT 'AccountIDTo: ' + @AccountIDTo	
			PRINT 'DC: ' + Convert(nvarchar(10), @D_C)					
		END			
		
											
		IF @LineCode = '02'
		BEGIN
			SELECT @Amount = SUM(isnull(ConvertedAmount,0)), @I05ID = I05ID
			FROM
			(
				SELECT ISNULL(ConvertedAmount,0) AS ConvertedAmount, CASE WHEN I05ID = '99' THEN '9' ELSE I05ID END I05ID
				FROM #TEMP
				WHERE AccountID LIKE '521%' 
				AND D_C = 'D'
			) TB
			GROUP BY I05ID  	
			HAVING I05ID = @I05ID										
		END	
		ELSE		
		IF @LineCode = '11'
		BEGIN
			SELECT @Amount = SUM(isnull(V01.ConvertedAmount,0)), @I05ID = V01.I05ID
			FROM #TEMP AS V01
			WHERE AccountID LIKE '632%' 
			AND V01.I05ID <> '99'
			GROUP BY I05ID	
			HAVING I05ID = @I05ID		
		END	
		ELSE
		IF @LineCode = '21'
		BEGIN
			IF @I05ID = '99'
			BEGIN
				SELECT 	@Amount = SUM(V01.ConvertedAmount)
				FROM	#TEMP AS V01
				WHERE 	(V01.TransactionTypeID <>'T00') 
						AND V01.AccountID = '5154'
						AND (V01.D_C = 'D') 
						AND (V01.CorAccountID >= '911' AND V01.CorAccountID <= '911z')			
				
				PRINT 'HAHAHAHAHAHAHHAHAHAHHAHAHAHAHAHAHHAHAHAH:' +  convert(nvarchar(50),@Amount) 							
			END	
			ELSE
			BEGIN
				SET @Amount = 0
			END					
		END	
		ELSE
		BEGIN
			IF @AmountSign = 2 		----- truong hop lay ca hai ben;  
			BEGIN
				IF (@CorAccountIDFrom1 ='%' OR @CorAccountIDFrom1 ='' OR @CorAccountIDFrom1 IS NULL)
					SELECT 	@Amount = SUM(isnull(V01.ConvertedAmount,0)), @I05ID = V01.I05ID
					FROM	#TEMP AS V01
					WHERE 	(V01.AccountID >=@AccountIDFrom AND V01.AccountID <=@AccountIDTo) AND
							V01.I05ID = @I05ID
					GROUP BY V01.I05ID							
				ELSE
					SELECT 	@Amount = SUM(Isnull(V01.ConvertedAmount,0)), @I05ID = V01.I05ID
					FROM	#TEMP AS V01
					WHERE 	(V01.AccountID >=@AccountIDFrom AND V01.AccountID <=@AccountIDTo) AND
							(V01.CorAccountID >=@CorAccountIDFrom1 AND V01.CorAccountID <=@CorAccountIDTo1) AND
							V01.I05ID = @I05ID
					GROUP BY V01.I05ID						
			END		

			IF @AmountSign = 1 		-------Lay so phat sinh No
			BEGIN
				IF (@CorAccountIDFrom1 ='%' OR @CorAccountIDFrom1 ='' OR @CorAccountIDFrom1 IS NULL)
					SELECT 	@Amount = SUM(V01.ConvertedAmount)
					FROM	#TEMP AS V01
					WHERE 	(V01.TransactionTypeID <>'T00') AND
							(V01.AccountID >=@AccountIDFrom AND V01.AccountID <=@AccountIDTo) AND				
							(V01.D_C = 'D') AND
							V01.I05ID = @I05ID						
				ELSE
					SELECT 	@Amount = SUM(V01.ConvertedAmount)
					FROM	#TEMP AS V01
					WHERE 	(V01.TransactionTypeID <>'T00') AND
							(V01.AccountID >=@AccountIDFrom AND V01.AccountID <=@AccountIDTo) AND
							(V01.D_C = 'D') AND
							(V01.CorAccountID >=@CorAccountIDFrom1 AND V01.CorAccountID <=@CorAccountIDTo1) AND
							V01.I05ID = @I05ID					
			END

			IF @AmountSign = 0 		------ Lay so phat sinh co
			BEGIN
				IF (@CorAccountIDFrom1 ='%' OR @CorAccountIDFrom1 ='' OR @CorAccountIDFrom1 IS NULL)
					SELECT 	@Amount = SUM(V01.ConvertedAmount)
					FROM	#TEMP AS V01
					WHERE 	(V01.TransactionTypeID <>'T00') AND
							(V01.AccountID >=@AccountIDFrom AND V01.AccountID <=@AccountIDTo) AND
							(V01.D_C = 'C') AND
							V01.I05ID = @I05ID					
				ELSE
					SELECT 	@Amount = SUM(V01.ConvertedAmount)
					FROM	#TEMP AS V01
					WHERE 	(V01.TransactionTypeID <>'T00') AND
							(V01.AccountID >=@AccountIDFrom AND V01.AccountID <=@AccountIDTo) AND
							(V01.D_C = 'C') AND
							(V01.CorAccountID >=@CorAccountIDFrom1 AND V01.CorAccountID <=@CorAccountIDTo1) AND
							V01.I05ID = @I05ID						
			END		
			
			IF @D_C = 1
				SET @Amount = @Amount*-1					
		END	
		
	
					
	
		SET @Amount = @Amount/@ConvertAmountUnit
			
		IF @LineCode = '21'
		BEGIN			
			print 'Amount: ' + Convert(nvarchar(50), @Amount)
			PRINT '--------------------------------'	
		END 	
		
			IF @Amount<>0  ---- cap nhat vao bang luu ket qua
				EXEC AP7615 @DivisionID, @ReportCode, @LineCode, @I05ID, @Amount, '+', @LineCode
	
		FETCH NEXT FROM @D90T4222Cursor INTO
				@LineCode,		@LineDescription, 	@LineDescriptionE, 	@PrintStatus,		@AccuSign,	
				@Accumulator,		@PrintCode,  @Level1, @Notes, @DisplayedMark,
				@AccountIDFrom,	@AccountIDTo,		@CorAccountIDFrom,	
				@CorAccountIDTo,	@D_C,			@AmountSign

	END
	FETCH NEXT FROM @I05IDCursor INTO @I05ID
END
	
CLOSE @D90T4222Cursor
CLOSE @I05IDCursor

DEALLOCATE @D90T4222Cursor
DEALLOCATE @I05IDCursor


-- Xử lý lấy dòng tỉ lệ
DECLARE @LineCodeAmount10 AS DECIMAL(28, 8),
		@LineCodeAmount25 AS DECIMAL(28, 8),
		@LineCodeAmount26 AS DECIMAL(28, 8),
		@LineCodeAmount31 AS DECIMAL(28, 8),
		@LineCodeAmount32 AS DECIMAL(28, 8),
		@LineCodeAmount21 AS DECIMAL(28, 8),	
		@LineCodeAmount22 AS DECIMAL(28, 8),						
		@MaxRow AS TINYINT

SELECT @MaxRow = COUNT(I05ID)
FROM AT7614 WITH (NOLOCK)
WHERE PrintCode = '10a'

SELECT @LineCodeAmount10 = SUM(Amount)
FROM AT7614
WHERE LineCode = '10'  	

SELECT @LineCodeAmount22 = SUM(Amount)
FROM AT7614
WHERE LineCode = '22' 

SELECT @LineCodeAmount25 = SUM(Amount)
FROM AT7614
WHERE LineCode = '25'  	

SELECT @LineCodeAmount26 = SUM(Amount)
FROM AT7614
WHERE LineCode = '26'  	

SELECT @LineCodeAmount31 = SUM(Amount)
FROM AT7614
WHERE LineCode = '31'  	

SELECT @LineCodeAmount32 = SUM(Amount)
FROM AT7614
WHERE LineCode = '32'  

SELECT 	@LineCodeAmount21 = SUM(V01.ConvertedAmount)
FROM	#TEMP AS V01
WHERE 	(V01.TransactionTypeID <>'T00') AND
		(V01.AccountID >= '515' AND V01.AccountID <= '515z' AND V01.AccountID <> '5154') AND
		(V01.D_C = 'D') AND
		(V01.CorAccountID >= '911' AND V01.CorAccountID <= '911z')

UPDATE A
SET Amount = B.Amount/@LineCodeAmount10*100
FROM AT7614 A 
INNER JOIN AT7614 B ON A.I05ID = B.I05ID AND B.PrintCode = '10'
WHERE A.PrintCode = '10a' 

UPDATE A
SET Amount = ROUND(B.Amount/100*@LineCodeAmount25, 0)
FROM AT7614 A 
INNER JOIN AT7614 B ON A.I05ID = B.I05ID AND B.PrintCode = '10a'
WHERE A.PrintCode = '25' 

UPDATE A
SET Amount = ROUND(B.Amount/100*@LineCodeAmount26, 0)
FROM AT7614 A 
INNER JOIN AT7614 B ON A.I05ID = B.I05ID AND B.PrintCode = '10a'
WHERE A.PrintCode = '26' 

UPDATE A
SET Amount = ROUND(B.Amount/100*@LineCodeAmount31, 0)
FROM AT7614 A 
INNER JOIN AT7614 B ON A.I05ID = B.I05ID AND B.PrintCode = '10a'
WHERE A.PrintCode = '31' 

UPDATE A
SET Amount = ROUND(B.Amount/100*@LineCodeAmount32, 0)
FROM AT7614 A 
INNER JOIN AT7614 B ON A.I05ID = B.I05ID AND B.PrintCode = '10a'
WHERE A.PrintCode = '32' 

UPDATE A
SET Amount = ROUND(B.Amount/100*@LineCodeAmount21, 0)
FROM AT7614 A 
INNER JOIN AT7614 B ON A.I05ID = B.I05ID AND B.PrintCode = '10a'
WHERE A.PrintCode = '21'
AND B.I05ID <> '99' 

UPDATE A
SET Amount = ROUND(B.Amount/100*@LineCodeAmount22, 0)
FROM AT7614 A 
INNER JOIN AT7614 B ON A.I05ID = B.I05ID AND B.PrintCode = '10a'
WHERE A.PrintCode = '22' 

-- Làm tròn
SELECT ROW_NUMBER() OVER (PARTITION BY PrintCode ORDER BY Amount, I05ID DESC) RowNum, ROUND(Amount, 2) AS AmountRound, * 
INTO #TEMP2
FROM AT7614 
WHERE PrintCode IN ('10a','25','26','31','32','21','22') 

UPDATE AT7614
SET Amount = CASE WHEN B.RowNum <> @MaxRow THEN ROUND(A.Amount, 2) ELSE 100 - (SELECT SUM(#TEMP2.AmountRound) FROM #TEMP2 WITH (NOLOCK) WHERE RowNum < @MaxRow AND PrintCode = '10a') END
FROM AT7614 A 
INNER JOIN #TEMP2 B ON A.APK = B.APK
WHERE A.PrintCode = '10a' 

UPDATE AT7614
SET Amount = CASE WHEN B.RowNum = @MaxRow THEN @LineCodeAmount25 - (SELECT SUM(#TEMP2.AmountRound) FROM #TEMP2 WITH (NOLOCK) WHERE RowNum < @MaxRow AND PrintCode = '25') ELSE A.Amount END
FROM AT7614 A 
INNER JOIN #TEMP2 B ON A.APK = B.APK
WHERE A.PrintCode = '25' 

UPDATE AT7614
SET Amount = CASE WHEN B.RowNum = @MaxRow THEN @LineCodeAmount26 - (SELECT SUM(#TEMP2.AmountRound) FROM #TEMP2 WITH (NOLOCK) WHERE RowNum < @MaxRow AND PrintCode = '26') ELSE A.Amount END
FROM AT7614 A 
INNER JOIN #TEMP2 B ON A.APK = B.APK
WHERE A.PrintCode = '26' 

UPDATE AT7614
SET Amount = CASE WHEN B.RowNum = @MaxRow THEN @LineCodeAmount31 - (SELECT SUM(#TEMP2.AmountRound) FROM #TEMP2 WITH (NOLOCK) WHERE RowNum < @MaxRow AND PrintCode = '31') ELSE A.Amount END
FROM AT7614 A 
INNER JOIN #TEMP2 B ON A.APK = B.APK
WHERE A.PrintCode = '31' 

UPDATE AT7614
SET Amount = CASE WHEN B.RowNum = @MaxRow THEN @LineCodeAmount32 - (SELECT SUM(#TEMP2.AmountRound) FROM #TEMP2 WITH (NOLOCK) WHERE RowNum < @MaxRow AND PrintCode = '32') ELSE A.Amount END
FROM AT7614 A 
INNER JOIN #TEMP2 B ON A.APK = B.APK
WHERE A.PrintCode = '32' 

UPDATE AT7614
SET Amount = CASE WHEN B.RowNum = @MaxRow THEN @LineCodeAmount21 - (SELECT SUM(#TEMP2.AmountRound) FROM #TEMP2 WITH (NOLOCK) WHERE RowNum < @MaxRow AND PrintCode = '21' AND I05ID <> '99') ELSE A.Amount END
FROM AT7614 A 
INNER JOIN #TEMP2 B ON A.APK = B.APK
WHERE A.PrintCode = '21' 
AND A.I05ID <> '99'

UPDATE AT7614
SET Amount = CASE WHEN B.RowNum = @MaxRow THEN @LineCodeAmount22 - (SELECT SUM(#TEMP2.AmountRound) FROM #TEMP2 WITH (NOLOCK) WHERE RowNum < @MaxRow AND PrintCode = '22') ELSE A.Amount END
FROM AT7614 A 
INNER JOIN #TEMP2 B ON A.APK = B.APK
WHERE A.PrintCode = '22' 

PRINT @MaxRow
PRINT @LineCodeAmount10
PRINT @LineCodeAmount25
PRINT @LineCodeAmount26
PRINT @LineCodeAmount31
PRINT @LineCodeAmount32
PRINT @LineCodeAmount21
PRINT @LineCodeAmount22

-- Tính toán lại tất cả các cột
UPDATE AT7614
SET Amount = 0
WHERE DivisionID = @DivisionID
AND LineCode IN ('10','20','30','40','50','60')

--SELECT * 
--FROM AT7614
--WHERE DivisionID = @DivisionID
--AND LineCode IN ('10','20','30','40','50','60')
--ORDER BY LineCode, I05ID


DECLARE @CurrentAccumulator nvarchar(100),
		@TempLineCode nvarchar(100),
		@TempParrentID nvarchar(100),
		@TempSign nvarchar(5),
		@OldSign nvarchar(5) = '+',
		@Sign nvarchar(5),
		@Bug nvarchar(4000)

SET @I05IDCursor = CURSOR SCROLL KEYSET FOR
				   SELECT '99' AS AnaID
				   UNION ALL
				   SELECT AnaID 
				   FROM AT1015
				   WHERE AnaTypeID = N'I05'
				   AND Disabled = 0
				   AND DivisionID = @DivisionID
OPEN @I05IDCursor
FETCH NEXT FROM @I05IDCursor INTO @I05ID
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @D90T4222Cursor = CURSOR SCROLL KEYSET FOR
		SELECT	LineCode, Amount
		FROM	AT7614
		WHERE	DivisionID = @DivisionID
				--AND LineCode NOT IN ('10','20','30','40','50','60')
				AND I05ID = @I05ID
		ORDER BY PrintCode		
	OPEN @D90T4222Cursor
	FETCH NEXT FROM @D90T4222Cursor INTO @LineCode, @Amount
	WHILE @@FETCH_STATUS = 0
	BEGIN	
			
		SELECT 	@CurrentAccumulator = Accumulator,
				@TempSign  = AccuSign			
		FROM		AT7614
		WHERE	DivisionID = @DivisionID and LineCode = @LineCode and I05ID = @I05ID
		
		Set @TempLineCode  =   isnull(@CurrentAccumulator,'')
		SET @OldSign = '+'

		--IF @CurrentAccumulator = '20' AND @I05ID = '1'
		--BEGIN
			--SELECT @LineCode AS LineCode, @I05ID AS I05ID, Amount AS A 
			--FROM AT7614	
			--WHERE	DivisionID = @DivisionID
			--	and LineCode = '20'
			--	and I05ID = @I05ID	
		--END	
		
		IF @TempLineCode <>''
			Begin
				--- Update TypeID của dòng cấp cha để nhận biết là doanh thu hay chi phí
				UPDATE AT7614 Set TypeID = (Select TypeID From AT7614 Where DivisionID = @DivisionID and LineCode = @LineCode and I05ID = @I05ID)
				WHERE DivisionID = @DivisionID And LineCode = @TempLineCode and I05ID = @I05ID and Isnull(TypeID,'') = ''
 
				if @OldSign<> @TempSign  Set @Sign = '-' Else   Set @Sign = '+'
				--Print @OldSign+ @TempSign
				Set @OldSign = @Sign
				
				IF @Sign = '+'	---- lan dau tien phai cong vao dong chinh no
				BEGIN
					IF @CurrentAccumulator = '20' AND @I05ID = '1'
					BEGIN
						PRINT '+: ' + CONVERT(NVARCHAR(100), @Amount)
					END
					
					If ISNULL((Select DisplayedMark From AT7614 Where DivisionID = @DivisionID and LineCode = @LineCode and I05ID = @I05ID),0) = 1	
						UPDATE 	AT7614
						SET		Amount = -(isnull(Amount,0) + isnull(@Amount,0))
						WHERE	DivisionID = @DivisionID
							and LineCode = @TempLineCode
							and I05ID = @I05ID
					ELSE
						BEGIN
							UPDATE 	AT7614
							SET	Amount = isnull(Amount,0) + isnull(@Amount,0)
							WHERE	DivisionID = @DivisionID
								and LineCode = @TempLineCode
								and I05ID = @I05ID			
								
							--IF @CurrentAccumulator = '20' AND @I05ID = '1'
							--BEGIN
							--	SELECT Amount 
							--	FROM AT7614	
							--	WHERE	DivisionID = @DivisionID
							--		and LineCode = @TempLineCode
							--		and I05ID = @I05ID	
							--END																				
						END		
				End
				ELSE
				BEGIN
					IF @CurrentAccumulator = '20' AND @I05ID = '1'
					BEGIN
						PRINT '-: ' + CONVERT(NVARCHAR(100), @Amount)
					END					
					If ISNULL((Select DisplayedMark From AT7614 Where DivisionID = @DivisionID and LineCode = @LineCode and I05ID = @I05ID),0) = 1	
							UPDATE 	AT7614
							SET		Amount = -(isnull(Amount,0) - isnull(@Amount,0))
							WHERE	DivisionID = @DivisionID
							and LineCode = @TempLineCode
							and I05ID = @I05ID
					ELSE
						BEGIN
							UPDATE 	AT7614
							SET		Amount = isnull(Amount,0) - isnull(@Amount,0)
							WHERE	DivisionID = @DivisionID
							and LineCode = @TempLineCode
							and I05ID = @I05ID		
							
							--IF @CurrentAccumulator = '20' AND @I05ID = '1'
							--BEGIN
							--	SELECT Amount 
							--	FROM AT7614	
							--	WHERE	DivisionID = @DivisionID
							--		and LineCode = @TempLineCode
							--		and I05ID = @I05ID	
							--END																			
						END
				End
				--Set @TempParrentID=''		
				
				--Select  	@TempParrentID = Accumulator,
				--	@TempSign = ltrim(rtrim(AccuSign))
				--From 	AT7614 
				--Where DivisionID = @DivisionID
				--and LineCode = @TempLineCode
				--and I05ID = @I05ID
				
				--Set 	@TempLineCode = isnull(@TempParrentID,'')
				
			End
			
		FETCH NEXT FROM @D90T4222Cursor INTO @LineCode, @Amount

	END
	FETCH NEXT FROM @I05IDCursor INTO @I05ID
END



SELECT LineCode, LineDescription, PrintCode, MonthYear, Amount, AccuSign, Accumulator,
Level1, PrintStatus, LineDescriptionE, Notes, DisplayedMark, TypeID, 
CASE WHEN I05ID = '99' THEN N'Thu nhập khác' ELSE 'Nhóm: ' + I05ID END AS I05ID 
FROM AT7614 WITH (NOLOCK)
WHERE PrintStatus = 0
ORDER BY PrintCode, I05ID 




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
