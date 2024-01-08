IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7920]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP7920]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-------- Created by Nguyen Minh Thuy, Date 10.10.2006
-------- In bang can doi ke toan theo ma phan tich (thang, quy, nam)
----- Modified on 19/10/2012 by Lê Thị Thu Hiền : Bổ sung in nhiều đơn vị
----- Modified on 31/03/2016 by Phương Thảo: Bổ sung số đầu năm


CREATE PROCEDURE [dbo].[AP7920]
		@DivisionID AS nvarchar(50),
		@TranMonthFrom AS INT,
		@TranYearFrom AS INT,
		@TranMonthTo AS INT,
		@TranYearTo AS INT,
		@ReportCode AS nvarchar(50),
		@AmountUnit AS TINYINT,
		@TypeOfTime as nvarchar(1),   --- M, Q, Y
		@StrDivisionID AS NVARCHAR(4000) = ''
AS
DECLARE	@ConvertAmountUnit AS decimal(28,8),
		@AT7902Cursor AS CURSOR,
		@LineCode AS nvarchar(50),
		@LineDescription AS nvarchar(250),
		@LineDescriptionE AS nvarchar(250),
		@AccountIDFrom AS nvarchar(50),
		@AccountIDTo AS nvarchar(50),
		@D_C AS TINYINT,		
		@Detail AS TINYINT,
		@Accumulator AS nvarchar(100),
		@Level1 AS TINYINT,
		@PrintStatus AS TINYINT,
		@Type AS tinyint,
		@LineID as nvarchar(50),
		@Notes as nvarchar(250),
		@Step as int,
		@PeriodNumber int,
		@Index int,		
		@Amount decimal(28,8), 
		@sSQL nvarchar(1000),
		@TranMonth int,
		@TranYear int

SET NOCOUNT ON

DECLARE @StrDivisionID_New AS NVARCHAR(4000)
SELECT @StrDivisionID_New = CASE WHEN @StrDivisionID = '%' THEN ' LIKE ''' + 
@StrDivisionID + '''' ELSE ' IN (''' + REPLACE(@StrDivisionID, ',',''',''') + ''')' END

DELETE AT7925

IF @AmountUnit = 1
	SET @ConvertAmountUnit =1
IF @AmountUnit = 2
	SET @ConvertAmountUnit =10
IF @AmountUnit = 3
	SET @ConvertAmountUnit =1000
IF @AmountUnit = 4
	SET @ConvertAmountUnit =10000
IF @AmountUnit = 5
	SET @ConvertAmountUnit =100000

		If @TypeOfTime ='M'
		  Begin	
			set @Step = 1
			Set @PeriodNumber = (@TranYearTo*12 + @TranMonthTo) - (@TranYearFrom*12 + @TranMonthFrom) +1   
		   End
		If @TypeOfTime ='Q'
		   Begin
			set @Step = 3
			Set @PeriodNumber = ((@TranYearTo*12 + @TranMonthTo) - (@TranYearFrom*12 + @TranMonthFrom) +1 )/3
		  End	
		If @TypeOfTime ='Y'
		  Begin	
			set @Step = 12
			Set @PeriodNumber = ((@TranYearTo*12 + @TranMonthTo) - (@TranYearFrom*12 + @TranMonthFrom)+1)/12
		  End	

SET @AT7902Cursor = CURSOR SCROLL KEYSET FOR
SELECT	T12.LineID, T12.LineCode,T12.LineDescription, T12.LineDescriptionE, T12.AccountIDFrom,T12.AccountIDTo, T12.Detail,T12.D_C,T12.Accumulator,T12.Level1,T12.PrintStatus,T12.Notes
FROM AT7902 AS T12
WHERE	T12.ReportCode = @ReportCode 
and T12.DivisionID = @DivisionID --hoangphuoc them ngay 28/12/2010

OPEN @AT7902Cursor
FETCH NEXT FROM @AT7902Cursor INTO @LineID, @LineCode,@LineDescription, @LineDescriptionE, @AccountIDFrom,@AccountIDTo,@Detail,@D_C,@Accumulator,@Level1,@PrintStatus,@Notes
   
WHILE @@FETCH_STATUS = 0
    BEGIN	
	INSERT INTO AT7925 (DivisionID,	LineCode,LineID, LineDescription, LineDescriptionE, PrintStatus,Amount1, Amount2, Amount3, Amount4, Amount5, Amount6, Amount7, Amount8, Amount9, Amount10, Amount11, Amount12, Amount13, Amount14, Amount15, Amount16, Amount17, Amount18, Amount19, Amount20, Level1,Type,Accumulator, Notes)
	    VALUES (@DivisionID, @LineCode,@LineID, @LineDescription, @LineDescriptionE, @PrintStatus,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,@Level1,@Type,@Accumulator,@Notes)     	
	FETCH NEXT FROM @AT7902Cursor INTO @LineID, @LineCode,@LineDescription, @LineDescriptionE, @AccountIDFrom,@AccountIDTo,@Type,@D_C,@Accumulator,@Level1,@PrintStatus,@Notes
    END
CLOSE @AT7902Cursor
DEALLOCATE @AT7902Cursor

SET @AT7902Cursor = CURSOR SCROLL KEYSET FOR
	SELECT	T12.LineID, T12.LineCode, T12.LineDescription, T12.LineDescriptionE, T12.AccountIDFrom,T12.AccountIDTo,T12.Detail,
			T12.D_C,T12.Accumulator,T12.Level1,T12.PrintStatus, T12.Notes
	FROM AT7902 AS T12
	WHERE	T12.ReportCode = @ReportCode
	and T12.DivisionID = @DivisionID --hoangphuoc them ngay 28/12/2010

OPEN @AT7902Cursor
FETCH NEXT FROM @AT7902Cursor INTO @LineID, @LineCode,@LineDescription, @LineDescriptionE, @AccountIDFrom,
	@AccountIDTo,@Detail,@D_C,@Accumulator,@Level1,@PrintStatus,@Notes
WHILE @@FETCH_STATUS = 0
BEGIN
	IF (@AccountIDTo IS NULL) OR (@AccountIDTO ='' )
		SET @AccountIDTo = @AccountIDFrom
	IF (@AccountIDFrom IS NOT NULL) AND (@AccountIDFrom <>'' )
	Begin    
		If @TypeOfTime ='M'
		  Begin	
			Set @TranMonth = @TranMonthFrom
			Set @TranYear = @TranYearFrom
		   End
		If @TypeOfTime ='Q'
		   Begin
			Set @TranMonth = @TranMonthFrom+2
			Set @TranYear = @TranYearFrom
		  End	
		If @TypeOfTime ='Y'
		  Begin	
			Set @TranMonth =@TranMonthFrom+11
			Set @TranYear = @TranYearFrom			 End	
		Set @Index = 1

		While @Index <=@PeriodNumber
		BEGIN	
			IF @Detail = 0  and @D_C =1 ---- Truong hop1:  lay tong hop, Lay so du No (mode=1)
			    BEGIN
				EXEC AP7921 @DivisionID, @AccountIDFrom, @AccountIDTo, @TranMonth, @TranYear, 1,  @Amount OUTPUT  
				SET @sSQL = 'UPDATE AT7925 SET Amount' + ltrim(@Index) + ' = ' + ltrim(cast(@Amount/@ConvertAmountUnit as Numeric))
					+ ' WHERE LineID = ''' + @LineID + ''' AND DivisionID '+@StrDivisionID_New+''
				EXEC (@sSQL)
			    END

			IF @Detail = 0   and @D_C =2 ---- Truong hop lay tong hop, Lay so du Co
			    BEGIN
				EXEC AP7921 @DivisionID, @AccountIDFrom, @AccountIDTo, @TranMonth, @TranYear, 2,  @Amount OUTPUT  
				SET @sSQL = 'UPDATE AT7925 SET Amount' + ltrim(@Index) + ' = ' + ltrim(cast(@Amount/@ConvertAmountUnit as Numeric))
					+ ' WHERE LineID = ''' + @LineID + ''' AND DivisionID '+@StrDivisionID_New+''
				EXEC (@sSQL)	
			    END
				
			IF @Detail = 1 AND @D_C = 1 --'D'   ---- So du No, lay chi tiet theo tai khoan
			    BEGIN	
				EXEC AP7921 @DivisionID, @AccountIDFrom, @AccountIDTo, @TranMonth, @TranYear, 3, @Amount OUTPUT  
				SET @sSQL = 'UPDATE AT7925 SET Amount' + ltrim(@Index) + ' = ' + ltrim(cast(@Amount/@ConvertAmountUnit as Numeric))
					+ ' WHERE LineID = ''' + @LineID + ''' AND DivisionID '+@StrDivisionID_New+''
				EXEC (@sSQL)
			    END

			IF @Detail = 1 AND @D_C = 2 --'C'  -- So du Co, lay chi tiet theo tai khoan
			    BEGIN
				EXEC AP7921 @DivisionID, @AccountIDFrom, @AccountIDTo, @TranMonth, @TranYear, 4,  @Amount OUTPUT  
				SET @sSQL = 'UPDATE AT7925 SET Amount' + ltrim(@Index) + ' = ' + ltrim(cast(@Amount/@ConvertAmountUnit as Numeric))
					+ ' WHERE LineID = ''' + @LineID + ''' AND DivisionID '+@StrDivisionID_New+''
				EXEC (@sSQL)
			    END
			
			IF @Detail = 2 and @D_C = 1-- 'D'   ---- So du No, lay chi tiet theo tai khoan va theo doi tuong
			  BEGIN
				EXEC AP7922 @DivisionID, @AccountIDFrom, @AccountIDTo, @TranMonth, @TranYear, 5,  @Amount OUTPUT  
				SET @sSQL = 'UPDATE AT7925 SET Amount' + ltrim(@Index) + ' = ' + ltrim(cast(@Amount/@ConvertAmountUnit as Numeric))
					+ ' WHERE LineID = ''' + @LineID + ''' AND DivisionID '+@StrDivisionID_New+''
				EXEC (@sSQL)
			  END	
			 
			IF @Detail = 2 and @D_C =2 --'C'   ---- So du Co, lay chi tiet theo tai khoan va theo doi tuong
			  BEGIN
				EXEC AP7922 @DivisionID, @AccountIDFrom, @AccountIDTo, @TranMonth, @TranYear, 6,  @Amount OUTPUT  
				SET @sSQL = 'UPDATE AT7925 SET Amount' + ltrim(@Index) + ' = ' + ltrim(cast(@Amount/@ConvertAmountUnit as Numeric))
					+ ' WHERE LineID = ''' + @LineID + ''' AND DivisionID '+@StrDivisionID_New+''
				EXEC (@sSQL)
			  END
			
			Set @Index = @Index + 1
			Set @TranMonth = @TranMonth + @Step
				If @TranMonth>12 
			Begin
				Set @TranMonth = @Step
				Set @TranYear = @TranYear  + 1	
			End		
		END


		---- Cap nhat so dau nam
		Declare @BeginYear Decimal(28,8)
		IF @Detail = 0  and @D_C =1 ---- Truong hop1:  lay tong hop, Lay so du No (mode=1)
			    BEGIN
					SELECT @BeginYear = SUM(V01.ConvertedAmount)
					FROM   AV4201 AS V01
					WHERE  ((V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))AND (V01.AccountID >= @AccountIDFrom) AND (V01.AccountID <= @AccountIDTo))
						   AND ((V01.TranYear < @TranYearFrom) OR (TransactionTypeID = 'T00'))					
			    END

			IF @Detail = 0   and @D_C =2 ---- Truong hop lay tong hop, Lay so du Co
			    BEGIN
					SELECT @BeginYear = SUM(V01.ConvertedAmount * (-1))
					FROM   AV4201 AS V01
					WHERE  ((V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))
							AND (V01.AccountID >= @AccountIDFrom) AND (V01.AccountID <= @AccountIDTo))
							AND ((V01.TranYear < @TranYearFrom) OR (TransactionTypeID = 'T00'))					
			    END
				
			IF @Detail = 1 AND @D_C = 1 --'D'   ---- So du No, lay chi tiet theo tai khoan
			    BEGIN	
					SELECT @BeginYear = SUM(X.ConvertedAmount)
					FROM   (	SELECT		V01.AccountID,
											SUM(V01.ConvertedAmount) AS ConvertedAmount
							   FROM			AV4201 AS V01
							   WHERE		((V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))AND (V01.AccountID >= @AccountIDFrom AND V01.AccountID <= @AccountIDTo))
											AND ((V01.TranYear < @TranYearFrom) OR (TransactionTypeID = 'T00'))
            					GROUP BY	V01.AccountID
						   ) AS X
					WHERE  X.ConvertedAmount >= 0
			    END

			IF @Detail = 1 AND @D_C = 2 --'C'  -- So du Co, lay chi tiet theo tai khoan
			    BEGIN
					SELECT @BeginYear = -SUM(X.ConvertedAmount)
					FROM   (	SELECT		V01.AccountID,
											SUM(V01.ConvertedAmount) AS ConvertedAmount
							   FROM			AV4201 AS V01
							   WHERE		((V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))
											AND (V01.AccountID >= @AccountIDFrom AND V01.AccountID <= @AccountIDTo))
											AND ((V01.TranYear < @TranYearFrom) OR (TransactionTypeID = 'T00'))
            					GROUP BY	V01.AccountID
						   ) AS X
					WHERE  X.ConvertedAmount <= 0 --- The hien so du Co
			    END
			
			IF @Detail = 2 and @D_C = 1-- 'D'   ---- So du No, lay chi tiet theo tai khoan va theo doi tuong
			  BEGIN
				SELECT	@BeginYear = SUM(B.ConvertedAmount)
				FROM	(	SELECT		V02.AccountID,
										ObjectID,
										SUM(V02.ConvertedAmount) AS ConvertedAmount
						   FROM			AV4202 AS V02
						   WHERE		(V02.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID)) 
										AND (V02.AccountID >= @AccountIDFrom AND V02.AccountID <= @AccountIDTo)
										AND ((V02.TranYear < @TranYearFrom) OR (TransactionTypeID = 'T00'))
            				GROUP BY	V02.DivisionID, V02.AccountID,
										V02.ObjectID
						) AS B
					   ---Having  SUM(V02.ConvertedAmount) >=0
				WHERE	B.ConvertedAmount >= 0 
			  END	
			 
			IF @Detail = 2 and @D_C =2 --'C'   ---- So du Co, lay chi tiet theo tai khoan va theo doi tuong
			  BEGIN
				SELECT	@BeginYear = SUM(B.ConvertedAmount)
				FROM	(	SELECT		V02.AccountID,
										ObjectID,
										SUM(V02.ConvertedAmount) AS ConvertedAmount
						   FROM			AV4202 AS V02
						   WHERE		(V02.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))
										AND (V02.AccountID >= @AccountIDFrom AND V02.AccountID <= @AccountIDTo)
										AND ((V02.TranYear < @TranYearFrom) OR (TransactionTypeID = 'T00'))
            				GROUP BY	V02.DivisionID, V02.AccountID,
            							V02.ObjectID
						) AS B
					   ---Having  SUM(V02.ConvertedAmount) >=0
				WHERE	B.ConvertedAmount < 0 --- Phai la du Co

				SET @BeginYear = @BeginYear * (-1)
			  END

			SET @sSQL = 'UPDATE AT7925 SET BeginYear = ' + ltrim(cast(@BeginYear/@ConvertAmountUnit as Numeric))
					+ ' WHERE LineID = ''' + @LineID + ''' AND DivisionID '+@StrDivisionID_New+''
			EXEC (@sSQL)
					
	   EXEC AP7926 @LineID,@PeriodNumber,@DivisionID

	End

	FETCH NEXT FROM @AT7902Cursor INTO @LineID , @LineCode, @LineDescription,  @LineDescriptionE, @AccountIDFrom,@AccountIDTo,@Detail, @D_C,@Accumulator,@Level1,@PrintStatus, @Notes
END

CLOSE @AT7902Cursor
DEALLOCATE @AT7902Cursor

SET NOCOUNT Off


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

