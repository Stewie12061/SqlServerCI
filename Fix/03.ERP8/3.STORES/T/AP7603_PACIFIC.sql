IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7603_PACIFIC]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP7603_PACIFIC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

------	Customize PACIFIC: Xu ly so lieu; tinh toan len bang ke qua kinh doanh; phan lai+lo. 
------ 	Duoc goi tu AP7604
------ 	Created by Nguyen Van Nhan, Date 12.09.2003.
-------	Last Update 25.02.2005

/**********************************************
** Edited by: [GS] [Cáº©m Loan] [30/07/2010]
***********************************************/
---- Modified on 22/10/2012 by Lê Thị Thu Hiền : Bổ sung in nhiều đơn vị
---- Modified by on 02/01/2013 by Lê Thị Thu Hiền : Thay đổi INSERT #DivisionID bằng Bảng tạm A00007
---- Modified by on 08/05/2013 by Bao Quynh : Bo sung chi tiet theo doi tuong, @Sign=2: Ben No, @Sign=3: Ben Co
---- Modified by Bảo Anh on 27/05/2017: Sửa danh mục dùng chung

CREATE PROCEDURE [dbo].[AP7603_PACIFIC]
				@DivisionID AS nvarchar(50),			
				@AccountIDFrom AS nvarchar(50),		
				@AccountIDTo AS nvarchar(50),	
				@CorAccountIDFrom AS nvarchar(50),		
				@CorAccountIDTo AS nvarchar(50),
				@TranMonthFrom AS INT,			
				@TranYearFrom AS INT,				
				@TranMonthTo AS INT,				
				@TranYearTo AS INT,	
				@Mode AS INT,
				@Sign AS TINYINT,				
				@OutputAmount AS decimal(28,8) OUTPUT,
				@OutputAmount2 AS decimal(28,8) OUTPUT,				
				@StrDivisionID AS NVARCHAR(4000) = ''
				
AS
DECLARE @PeriodFrom INT,	
		@PeriodTo INT

DECLARE	@CorAccountIDFrom1 AS nvarchar(50),
		@CorAccountIDTo1 AS nvarchar(50)
DECLARE	@Amount AS decimal(28,8),
		@Amount2 AS decimal(28,8),
		@CustomerName INT
		
SET @PeriodFrom = @TranYearFrom*100+@TranMonthFrom
SET @PeriodTo = @TranYearTo*100+@TranMonthTo

--------------->>>> Chuỗi DivisionID
DECLARE @StrDivisionID_New AS NVARCHAR(4000)
	
SELECT @StrDivisionID_New = CASE WHEN @StrDivisionID = '%' THEN ' LIKE ''' + 
@StrDivisionID + '''' ELSE ' IN (''' + replace(@StrDivisionID, ',',''',''') + ''')' END
		
DELETE FROM	A00007 WHERE SPID = @@SPID
INSERT INTO A00007(SPID, DivisionID) 
EXEC('SELECT '''+@@SPID+''', DivisionID FROM AT1101 WHERE DivisionID '+@StrDivisionID_New+'')

---------------------<<<<<<<<<< Chuỗi DivisionID
SET @CorAccountIDFrom1 = @CorAccountIDFrom
SET @CorAccountIDTo1 = @CorAccountIDTo
IF (@CorAccountIDTo1 = '' OR @CorAccountIDTo1 IS NULL)
	SET @CorAccountIDTo1 = @CorAccountIDFrom1

SET @Amount = 0
SET @Amount2 = 0

SET @CustomerName = (SELECT TOP 1 CustomerName FROM CustomerIndex)

IF @Mode = 1 		----- So du dau nam
BEGIN
			BEGIN
				IF (@CorAccountIDFrom1 ='%' OR @CorAccountIDFrom1 ='' OR @CorAccountIDFrom1 IS NULL)
				BEGIN
					SELECT 	V01.SignAmount, (V01.SignAmount/ISNULL(TB.ExchangeRate, AT1004.ExchangeRate)) AS SignAmount2
					INTO #TEMP				
					FROM	AV4301 AS V01
					LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = 'USD'
					LEFT JOIN 
					(
						SELECT MAX(ExchangeRate) AS ExchangeRate, DivisionID, ExchangeDate
						FROM AT1012 WITH (NOLOCK)
						WHERE AT1012.CurrencyID = 'USD'
						GROUP BY DivisionID, ExchangeDate
					) TB ON TB.DivisionID = V01.DivisionID AND TB.ExchangeDate = V01.VoucherDate
					WHERE 	(V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID)) AND
							(V01.AccountID >=@AccountIDFrom AND V01.AccountID <=@AccountIDTo) AND
							( V01.TransactionTypeID='T00' or  (V01.TranYear*100+V01.TranMonth < @PeriodFrom) )	
						
					SELECT @Amount = SUM(SignAmount), @Amount2 = SUM(SignAmount2)	
					FROM #TEMP 							
				END
				ELSE
				BEGIN
					SELECT 	V01.SignAmount, (V01.SignAmount/ISNULL(TB.ExchangeRate, AT1004.ExchangeRate)) AS SignAmount2
					INTO #TEMP1				
					FROM	AV4301 AS V01
					LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = 'USD'
					LEFT JOIN 
					(
						SELECT MAX(ExchangeRate) AS ExchangeRate, DivisionID, ExchangeDate
						FROM AT1012 WITH (NOLOCK)
						WHERE AT1012.CurrencyID = 'USD'
						GROUP BY DivisionID, ExchangeDate
					) TB ON TB.DivisionID = V01.DivisionID AND TB.ExchangeDate = V01.VoucherDate
					WHERE 	(V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID)) AND
							(V01.AccountID >=@AccountIDFrom AND V01.AccountID <=@AccountIDTo) AND
							( V01.TransactionTypeID='T00' or  (V01.TranYear*100+V01.TranMonth < @PeriodFrom) ) AND
							(V01.CorAccountID >=@CorAccountIDFrom1 AND V01.CorAccountID <=@CorAccountIDTo1)		
						
					SELECT @Amount = SUM(SignAmount), @Amount2 = SUM(SignAmount2)	
					FROM #TEMP1 										
				END				
			END
	
		GOTO RETURN_VALUES
	END

IF @Mode = 3 		----- truong hop lay ca hai ben;  
BEGIN
		IF @Sign<=1
			BEGIN
				IF (@CorAccountIDFrom1 ='%' OR @CorAccountIDFrom1 ='' OR @CorAccountIDFrom1 IS NULL)
				BEGIN
					SELECT 	V01.SignAmount, (V01.SignAmount/ISNULL(TB.ExchangeRate, AT1004.ExchangeRate)) AS SignAmount2
					INTO #TEMP2				
					FROM	AV4301 AS V01
					LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = 'USD'
					LEFT JOIN 
					(
						SELECT MAX(ExchangeRate) AS ExchangeRate, DivisionID, ExchangeDate
						FROM AT1012 WITH (NOLOCK)
						WHERE AT1012.CurrencyID = 'USD'
						GROUP BY DivisionID, ExchangeDate
					) TB ON TB.DivisionID = V01.DivisionID AND TB.ExchangeDate = V01.VoucherDate
					WHERE 	(V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID)) AND
							(V01.AccountID >=@AccountIDFrom AND V01.AccountID <=@AccountIDTo) AND
							(V01.TranYear*100+V01.TranMonth >= @PeriodFrom AND V01.TranYear*100+V01.TranMonth <= @PeriodTo)	
						
					SELECT @Amount = SUM(SignAmount), @Amount2 = SUM(SignAmount2)	
					FROM #TEMP2 									
				END
				ELSE
				BEGIN
					SELECT 	V01.SignAmount, (V01.SignAmount/ISNULL(TB.ExchangeRate, AT1004.ExchangeRate)) AS SignAmount2
					INTO #TEMP3				
					FROM	AV4301 AS V01
					LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = 'USD'
					LEFT JOIN 
					(
						SELECT MAX(ExchangeRate) AS ExchangeRate, DivisionID, ExchangeDate
						FROM AT1012 WITH (NOLOCK)
						WHERE AT1012.CurrencyID = 'USD'
						GROUP BY DivisionID, ExchangeDate
					) TB ON TB.DivisionID = V01.DivisionID AND TB.ExchangeDate = V01.VoucherDate
					WHERE 	(V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID)) AND
							(V01.AccountID >=@AccountIDFrom AND V01.AccountID <=@AccountIDTo) AND
							(V01.TranYear*100+V01.TranMonth >= @PeriodFrom AND V01.TranYear*100+V01.TranMonth <= @PeriodTo) AND
							(V01.CorAccountID >=@CorAccountIDFrom1 AND V01.CorAccountID <=@CorAccountIDTo1)	
						
					SELECT @Amount = SUM(SignAmount), @Amount2 = SUM(SignAmount2)	
					FROM #TEMP3 										
				END				
			END
		ELSE
			BEGIN
				IF (@CorAccountIDFrom1 ='%' OR @CorAccountIDFrom1 ='' OR @CorAccountIDFrom1 IS NULL)
				BEGIN				
					SELECT 	SUM(V01.SignAmount) AS SignAmount, SUM(V01.SignAmount/ISNULL(TB.ExchangeRate, AT1004.ExchangeRate)) AS SignAmount2
					INTO #TEMP4			
					FROM	AV4301 AS V01
					LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = 'USD'
					LEFT JOIN 
					(
						SELECT MAX(ExchangeRate) AS ExchangeRate, DivisionID, ExchangeDate
						FROM AT1012 WITH (NOLOCK)
						WHERE AT1012.CurrencyID = 'USD'
						GROUP BY DivisionID, ExchangeDate
					) TB ON TB.DivisionID = V01.DivisionID AND TB.ExchangeDate = V01.VoucherDate
					WHERE		(V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))
								AND (V01.AccountID >= @AccountIDFrom AND V01.AccountID <= @AccountIDTo)
								AND (V01.TranYear*100+V01.TranMonth >= @PeriodFrom AND V01.TranYear*100+V01.TranMonth <= @PeriodTo)
					GROUP BY	V01.AccountID, V01.ObjectID							
        	 	
					SELECT @Amount = SUM(SignAmount), @Amount2 = SUM(SignAmount2)	
					FROM #TEMP4 	
					WHERE (@Sign=2 AND SignAmount>=0) OR (@Sign=3 AND SignAmount<0)					        	 						
				END
				ELSE
				BEGIN							
					SELECT 	SUM(V01.SignAmount) AS SignAmount, SUM(V01.SignAmount/ISNULL(TB.ExchangeRate, AT1004.ExchangeRate)) AS SignAmount2
					INTO #TEMP5			
					FROM	AV4301 AS V01
					LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = 'USD'
					LEFT JOIN 
					(
						SELECT MAX(ExchangeRate) AS ExchangeRate, DivisionID, ExchangeDate
						FROM AT1012 WITH (NOLOCK)
						WHERE AT1012.CurrencyID = 'USD'
						GROUP BY DivisionID, ExchangeDate
					) TB ON TB.DivisionID = V01.DivisionID AND TB.ExchangeDate = V01.VoucherDate
					WHERE		(V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))
								AND (V01.AccountID >= @AccountIDFrom AND V01.AccountID <= @AccountIDTo)
								AND (V01.TranYear*100+V01.TranMonth >= @PeriodFrom AND V01.TranYear*100+V01.TranMonth <= @PeriodTo)
								AND (V01.CorAccountID >=@CorAccountIDFrom1 AND V01.CorAccountID <=@CorAccountIDTo1)
        	 		GROUP BY	V01.AccountID, V01.ObjectID						
        	 	
					SELECT @Amount = SUM(SignAmount), @Amount2 = SUM(SignAmount2)	
					FROM #TEMP5 	
					WHERE (@Sign=2 AND SignAmount>=0) OR (@Sign=3 AND SignAmount<0)								
				END					
			END				
		GOTO RETURN_VALUES
	END

IF @Mode = 4 		-------Lay so phat sinh No
BEGIN
		IF @Sign<=1
			BEGIN
				IF (@CorAccountIDFrom1 ='%' OR @CorAccountIDFrom1 ='' OR @CorAccountIDFrom1 IS NULL)
				BEGIN
					SELECT 	V01.SignAmount, (V01.SignAmount/ISNULL(TB.ExchangeRate, AT1004.ExchangeRate)) AS SignAmount2
					INTO #TEMP6				
					FROM	AV4301 AS V01
					LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = 'USD'
					LEFT JOIN 
					(
						SELECT MAX(ExchangeRate) AS ExchangeRate, DivisionID, ExchangeDate
						FROM AT1012 WITH (NOLOCK)
						WHERE AT1012.CurrencyID = 'USD'
						GROUP BY DivisionID, ExchangeDate
					) TB ON TB.DivisionID = V01.DivisionID AND TB.ExchangeDate = V01.VoucherDate
					WHERE 	(V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID)) AND
							(V01.TransactionTypeID <>'T00') AND
							(V01.AccountID >=@AccountIDFrom AND V01.AccountID <=@AccountIDTo) AND				
							(V01.TranYear*100+V01.TranMonth >= @PeriodFrom AND V01.TranYear*100+V01.TranMonth <= @PeriodTo) AND
							(V01.D_C = 'D')	
						
					SELECT @Amount = SUM(SignAmount), @Amount2 = SUM(SignAmount2)	
					FROM #TEMP6 									
				END
				ELSE
				BEGIN
					SELECT 	V01.SignAmount, (V01.SignAmount/ISNULL(TB.ExchangeRate, AT1004.ExchangeRate)) AS SignAmount2
					INTO #TEMP7				
					FROM	AV4301 AS V01
					LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = 'USD'
					LEFT JOIN 
					(
						SELECT MAX(ExchangeRate) AS ExchangeRate, DivisionID, ExchangeDate
						FROM AT1012 WITH (NOLOCK)
						WHERE AT1012.CurrencyID = 'USD'
						GROUP BY DivisionID, ExchangeDate
					) TB ON TB.DivisionID = V01.DivisionID AND TB.ExchangeDate = V01.VoucherDate
					WHERE 	(V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID)) AND
							(V01.TransactionTypeID <>'T00') AND
							(V01.AccountID >=@AccountIDFrom AND V01.AccountID <=@AccountIDTo) AND
							(V01.TranYear*100+V01.TranMonth >= @PeriodFrom AND V01.TranYear*100+V01.TranMonth <= @PeriodTo) AND
							(V01.D_C = 'D') AND
							(V01.CorAccountID >=@CorAccountIDFrom1 AND V01.CorAccountID <=@CorAccountIDTo1)	
						
					SELECT @Amount = SUM(SignAmount), @Amount2 = SUM(SignAmount2)	
					FROM #TEMP7									
				END	
			END
		ELSE
			BEGIN
				IF (@CorAccountIDFrom1 ='%' OR @CorAccountIDFrom1 ='' OR @CorAccountIDFrom1 IS NULL)
				BEGIN
					SELECT 	V01.SignAmount, (V01.SignAmount/ISNULL(TB.ExchangeRate, AT1004.ExchangeRate)) AS SignAmount2
					INTO #TEMP8			
					FROM	AV4301 AS V01
					LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = 'USD'
					LEFT JOIN 
					(
						SELECT MAX(ExchangeRate) AS ExchangeRate, DivisionID, ExchangeDate
						FROM AT1012 WITH (NOLOCK)
						WHERE AT1012.CurrencyID = 'USD'
						GROUP BY DivisionID, ExchangeDate
					) TB ON TB.DivisionID = V01.DivisionID AND TB.ExchangeDate = V01.VoucherDate
					WHERE		(V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))
								AND (V01.AccountID >= @AccountIDFrom AND V01.AccountID <= @AccountIDTo)
								AND (V01.TranYear*100+V01.TranMonth >= @PeriodFrom AND V01.TranYear*100+V01.TranMonth <= @PeriodTo)
								AND (V01.D_C = 'D')
				
					SELECT @Amount = SUM(SignAmount), @Amount2 = SUM(SignAmount2)	
					FROM #TEMP8										
				END
				ELSE
				BEGIN
					SELECT 	V01.SignAmount, (V01.SignAmount/ISNULL(TB.ExchangeRate, AT1004.ExchangeRate)) AS SignAmount2
					INTO #TEMP9		
					FROM	AV4301 AS V01
					LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = 'USD'
					LEFT JOIN 
					(
						SELECT MAX(ExchangeRate) AS ExchangeRate, DivisionID, ExchangeDate
						FROM AT1012 WITH (NOLOCK)
						WHERE AT1012.CurrencyID = 'USD'
						GROUP BY DivisionID, ExchangeDate
					) TB ON TB.DivisionID = V01.DivisionID AND TB.ExchangeDate = V01.VoucherDate
					WHERE		(V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))
								AND (V01.AccountID >= @AccountIDFrom AND V01.AccountID <= @AccountIDTo)
								AND (V01.TranYear*100+V01.TranMonth >= @PeriodFrom AND V01.TranYear*100+V01.TranMonth <= @PeriodTo)
								AND (V01.D_C = 'D')
								AND (V01.CorAccountID >=@CorAccountIDFrom1 AND V01.CorAccountID <=@CorAccountIDTo1)
				
					SELECT @Amount = SUM(SignAmount), @Amount2 = SUM(SignAmount2)	
					FROM #TEMP9										
				END

			END			
		GOTO RETURN_VALUES
	END

IF @Mode = 5 		------ Lay so phat sinh co
BEGIN
		IF @Sign<=1
			BEGIN
				IF (@CorAccountIDFrom1 ='%' OR @CorAccountIDFrom1 ='' OR @CorAccountIDFrom1 IS NULL)
				BEGIN
					SELECT 	V01.SignAmount, (V01.SignAmount/ISNULL(TB.ExchangeRate, AT1004.ExchangeRate)) AS SignAmount2
					INTO #TEMP10	
					FROM	AV4301 AS V01
					LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = 'USD'
					LEFT JOIN 
					(
						SELECT MAX(ExchangeRate) AS ExchangeRate, DivisionID, ExchangeDate
						FROM AT1012 WITH (NOLOCK)
						WHERE AT1012.CurrencyID = 'USD'
						GROUP BY DivisionID, ExchangeDate
					) TB ON TB.DivisionID = V01.DivisionID AND TB.ExchangeDate = V01.VoucherDate
					WHERE 	(V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID)) AND
							(V01.TransactionTypeID <>'T00') AND
							(V01.AccountID >=@AccountIDFrom AND V01.AccountID <=@AccountIDTo) AND
							(V01.TranYear*100+V01.TranMonth >= @PeriodFrom AND V01.TranYear*100+V01.TranMonth <= @PeriodTo) AND
							(V01.D_C = 'C')		
						
					SELECT @Amount = SUM(SignAmount), @Amount2 = SUM(SignAmount2)	
					FROM #TEMP10								
				END
				ELSE
				BEGIN					
					SELECT 	V01.SignAmount, (V01.SignAmount/ISNULL(TB.ExchangeRate, AT1004.ExchangeRate)) AS SignAmount2
					INTO #TEMP11	
					FROM	AV4301 AS V01
					LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = 'USD'
					LEFT JOIN 
					(
						SELECT MAX(ExchangeRate) AS ExchangeRate, DivisionID, ExchangeDate
						FROM AT1012 WITH (NOLOCK)
						WHERE AT1012.CurrencyID = 'USD'
						GROUP BY DivisionID, ExchangeDate
					) TB ON TB.DivisionID = V01.DivisionID AND TB.ExchangeDate = V01.VoucherDate
					WHERE 	(V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID)) AND
							(V01.TransactionTypeID <>'T00') AND
							(V01.AccountID >=@AccountIDFrom AND V01.AccountID <=@AccountIDTo) AND
							(V01.TranYear*100+V01.TranMonth >= @PeriodFrom AND V01.TranYear*100+V01.TranMonth <= @PeriodTo) AND
							(V01.D_C = 'C') AND
							(V01.CorAccountID >=@CorAccountIDFrom1 AND V01.CorAccountID <=@CorAccountIDTo1)		
						
					SELECT @Amount = SUM(SignAmount), @Amount2 = SUM(SignAmount2)	
					FROM #TEMP11									
				END	
			END
		ELSE
			BEGIN
				IF (@CorAccountIDFrom1 ='%' OR @CorAccountIDFrom1 ='' OR @CorAccountIDFrom1 IS NULL)
				BEGIN
					SELECT 	V01.SignAmount, (V01.SignAmount/ISNULL(TB.ExchangeRate, AT1004.ExchangeRate)) AS SignAmount2
					INTO #TEMP12	
					FROM	AV4301 AS V01
					LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = 'USD'
					LEFT JOIN 
					(
						SELECT MAX(ExchangeRate) AS ExchangeRate, DivisionID, ExchangeDate
						FROM AT1012 WITH (NOLOCK)
						WHERE AT1012.CurrencyID = 'USD'
						GROUP BY DivisionID, ExchangeDate
					) TB ON TB.DivisionID = V01.DivisionID AND TB.ExchangeDate = V01.VoucherDate
					WHERE	(V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))
							AND (V01.AccountID >= @AccountIDFrom AND V01.AccountID <= @AccountIDTo)
							AND (V01.TranYear*100+V01.TranMonth >= @PeriodFrom AND V01.TranYear*100+V01.TranMonth <= @PeriodTo)
							AND (V01.D_C = 'C')	
						
					SELECT @Amount = SUM(SignAmount), @Amount2 = SUM(SignAmount2)	
					FROM #TEMP12										
				END
				ELSE
				BEGIN
					SELECT 	V01.SignAmount, (V01.SignAmount/ISNULL(TB.ExchangeRate, AT1004.ExchangeRate)) AS SignAmount2
					INTO #TEMP13	
					FROM	AV4301 AS V01
					LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = 'USD'
					LEFT JOIN 
					(
						SELECT MAX(ExchangeRate) AS ExchangeRate, DivisionID, ExchangeDate
						FROM AT1012 WITH (NOLOCK)
						WHERE AT1012.CurrencyID = 'USD'
						GROUP BY DivisionID, ExchangeDate
					) TB ON TB.DivisionID = V01.DivisionID AND TB.ExchangeDate = V01.VoucherDate
					WHERE	(V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))
							AND (V01.AccountID >= @AccountIDFrom AND V01.AccountID <= @AccountIDTo)
							AND (V01.TranYear*100+V01.TranMonth >= @PeriodFrom AND V01.TranYear*100+V01.TranMonth <= @PeriodTo)
							AND (V01.D_C = 'C')
							AND (V01.CorAccountID >=@CorAccountIDFrom1 AND V01.CorAccountID <=@CorAccountIDTo1)
						
					SELECT @Amount = SUM(SignAmount), @Amount2 = SUM(SignAmount2)	
					FROM #TEMP13										
				END	
			END
		GOTO RETURN_VALUES
	END

IF @Mode = 6 		
BEGIN
		IF @Sign <= 1
		BEGIN
			IF (@CorAccountIDFrom1 ='%' OR @CorAccountIDFrom1 ='' OR @CorAccountIDFrom1 IS NULL)
			BEGIN				
				SELECT 	V01.SignAmount, (V01.SignAmount/ISNULL(TB.ExchangeRate, AT1004.ExchangeRate)) AS SignAmount2
				INTO #TEMP14	
				FROM	AV4301 AS V01
				LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = 'USD'
				LEFT JOIN 
				(
					SELECT MAX(ExchangeRate) AS ExchangeRate, DivisionID, ExchangeDate
					FROM AT1012 WITH (NOLOCK)
					WHERE AT1012.CurrencyID = 'USD'
					GROUP BY DivisionID, ExchangeDate
				) TB ON TB.DivisionID = V01.DivisionID AND TB.ExchangeDate = V01.VoucherDate
				WHERE 	(V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID)) AND
						(V01.AccountID >=@AccountIDFrom AND V01.AccountID <=@AccountIDTo) AND
						((V01.TranYear*100+V01.TranMonth <= @TranYearTo*100+@TranMonthTo) OR 
						V01.TransactionTypeID = 'T00' )		
					
				SELECT @Amount = SUM(SignAmount), @Amount2 = SUM(SignAmount2)	
				FROM #TEMP14						
			END
			ELSE
			BEGIN					
				SELECT 	V01.SignAmount, (V01.SignAmount/ISNULL(TB.ExchangeRate, AT1004.ExchangeRate)) AS SignAmount2
				INTO #TEMP15	
				FROM	AV4301 AS V01
				LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = 'USD'
				LEFT JOIN 
				(
					SELECT MAX(ExchangeRate) AS ExchangeRate, DivisionID, ExchangeDate
					FROM AT1012 WITH (NOLOCK)
					WHERE AT1012.CurrencyID = 'USD'
					GROUP BY DivisionID, ExchangeDate
				) TB ON TB.DivisionID = V01.DivisionID AND TB.ExchangeDate = V01.VoucherDate
				WHERE 	(V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID)) AND
						(V01.AccountID >=@AccountIDFrom AND V01.AccountID <=@AccountIDTo) AND
								 ((V01.TranYear*100+V01.TranMonth <= @TranYearTo*100+@TranMonthTo) OR 
						V01.TransactionTypeID = 'T00') AND
						(V01.CorAccountID >=@CorAccountIDFrom1 AND V01.CorAccountID <=@CorAccountIDTo1)		
					
				SELECT @Amount = SUM(SignAmount), @Amount2 = SUM(SignAmount2)	
				FROM #TEMP15								
			END	
		END
		ELSE
		BEGIN
			IF (@CorAccountIDFrom1 ='%' OR @CorAccountIDFrom1 ='' OR @CorAccountIDFrom1 IS NULL)
			BEGIN	
				SELECT 	SUM(V01.SignAmount) AS SignAmount, SUM(V01.SignAmount/ISNULL(TB.ExchangeRate, AT1004.ExchangeRate)) AS SignAmount2
				INTO #TEMP16	
				FROM	AV4301 AS V01
				LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = 'USD'
				LEFT JOIN 
				(
					SELECT MAX(ExchangeRate) AS ExchangeRate, DivisionID, ExchangeDate
					FROM AT1012 WITH (NOLOCK)
					WHERE AT1012.CurrencyID = 'USD'
					GROUP BY DivisionID, ExchangeDate
				) TB ON TB.DivisionID = V01.DivisionID AND TB.ExchangeDate = V01.VoucherDate
				WHERE		(V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))
							AND (V01.AccountID >= @AccountIDFrom AND V01.AccountID <= @AccountIDTo)
							AND (V01.TransactionTypeID='T00' or (V01.TranYear * 100 + V01.TranMonth < @TranYearFrom*100+@TranMonthFrom))
        		GROUP BY	V01.AccountID, V01.ObjectID	
        	
				SELECT 	SUM(V01.SignAmount) AS SignAmount, SUM(V01.SignAmount/ISNULL(TB.ExchangeRate, AT1004.ExchangeRate)) AS SignAmount2
				INTO #TEMP17	
				FROM	AV4301 AS V01
				LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = 'USD'
				LEFT JOIN 
				(
					SELECT MAX(ExchangeRate) AS ExchangeRate, DivisionID, ExchangeDate
					FROM AT1012 WITH (NOLOCK)
					WHERE AT1012.CurrencyID = 'USD'
					GROUP BY DivisionID, ExchangeDate
				) TB ON TB.DivisionID = V01.DivisionID AND TB.ExchangeDate = V01.VoucherDate
				WHERE		(V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))
							AND (V01.AccountID >= @AccountIDFrom AND V01.AccountID <= @AccountIDTo)
							AND (V01.TransactionTypeID='T00' or (V01.TranYear * 100 + V01.TranMonth < @TranYearFrom*100+@TranMonthFrom))
        		GROUP BY	V01.AccountID, V01.ObjectID	        		
					
				SET @Amount = 
				(SELECT	SUM(isnull(SignAmount,0))
				FROM #TEMP16
				WHERE (@Sign=2 AND SignAmount>=0) OR (@Sign=3 AND SignAmount<0))			
				-
				(SELECT	SUM(isnull(SignAmount,0))
				FROM #TEMP17
				WHERE (@Sign=2 AND SignAmount>=0) OR (@Sign=3 AND SignAmount<0))		
			
				SET @Amount2 = 
				(SELECT	SUM(isnull(SignAmount2,0))
				FROM #TEMP16
				WHERE (@Sign=2 AND SignAmount2>=0) OR (@Sign=3 AND SignAmount2<0))			
				-
				(SELECT	SUM(isnull(SignAmount2,0))
				FROM #TEMP17
				WHERE (@Sign=2 AND SignAmount2>=0) OR (@Sign=3 AND SignAmount2<0))							
			END	
			ELSE
			BEGIN		
				SELECT 	SUM(V01.SignAmount) AS SignAmount, SUM(V01.SignAmount/ISNULL(TB.ExchangeRate, AT1004.ExchangeRate)) AS SignAmount2
				INTO #TEMP18	
				FROM	AV4301 AS V01
				LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = 'USD'
				LEFT JOIN 
				(
					SELECT MAX(ExchangeRate) AS ExchangeRate, DivisionID, ExchangeDate
					FROM AT1012 WITH (NOLOCK)
					WHERE AT1012.CurrencyID = 'USD'
					GROUP BY DivisionID, ExchangeDate
				) TB ON TB.DivisionID = V01.DivisionID AND TB.ExchangeDate = V01.VoucherDate
				WHERE		(V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))
							AND (V01.AccountID >= @AccountIDFrom AND V01.AccountID <= @AccountIDTo)
							AND (V01.TransactionTypeID='T00' or (V01.TranYear * 100 + V01.TranMonth <= @TranYearTo*100+@TranMonthTo))
							AND (V01.CorAccountID >=@CorAccountIDFrom1 AND V01.CorAccountID <=@CorAccountIDTo1)
        		GROUP BY	V01.AccountID, V01.ObjectID		
        	 	
				SELECT 	SUM(V01.SignAmount) AS SignAmount, SUM(V01.SignAmount/ISNULL(TB.ExchangeRate, AT1004.ExchangeRate)) AS SignAmount2
				INTO #TEMP19	
				FROM	AV4301 AS V01
				LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = 'USD'
				LEFT JOIN 
				(
					SELECT MAX(ExchangeRate) AS ExchangeRate, DivisionID, ExchangeDate
					FROM AT1012 WITH (NOLOCK)
					WHERE AT1012.CurrencyID = 'USD'
					GROUP BY DivisionID, ExchangeDate
				) TB ON TB.DivisionID = V01.DivisionID AND TB.ExchangeDate = V01.VoucherDate
				WHERE		(V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))
							AND (V01.AccountID >= @AccountIDFrom AND V01.AccountID <= @AccountIDTo)
							AND (V01.TransactionTypeID='T00' or (V01.TranYear * 100 + V01.TranMonth < @TranYearFrom*100+@TranMonthFrom))
							AND (V01.CorAccountID >=@CorAccountIDFrom1 AND V01.CorAccountID <=@CorAccountIDTo1)
        		GROUP BY	V01.AccountID, V01.ObjectID	 
        	
				SET @Amount = 
				(SELECT	SUM(isnull(SignAmount,0))
				FROM #TEMP18
				WHERE (@Sign=2 AND SignAmount>=0) OR (@Sign=3 AND SignAmount<0))			
				-
				(SELECT	SUM(isnull(SignAmount,0))
				FROM #TEMP19
				WHERE (@Sign=2 AND SignAmount>=0) OR (@Sign=3 AND SignAmount<0))		
			
				SET @Amount2 = 
				(SELECT	SUM(isnull(SignAmount2,0))
				FROM #TEMP18
				WHERE (@Sign=2 AND SignAmount2>=0) OR (@Sign=3 AND SignAmount2<0))			
				-
				(SELECT	SUM(isnull(SignAmount2,0))
				FROM #TEMP19
				WHERE (@Sign=2 AND SignAmount2>=0) OR (@Sign=3 AND SignAmount2<0))        	       			
			END			
		END			
		GOTO RETURN_VALUES
	END

--Chi tiet theo tai khoan
IF @Mode = 7 		
BEGIN
		IF @Sign <= 1
		BEGIN	
			IF (@CorAccountIDFrom1 ='%' OR @CorAccountIDFrom1 ='' OR @CorAccountIDFrom1 IS NULL)
			BEGIN
				SELECT 	SUM(V01.SignAmount) AS SignAmount, SUM(V01.SignAmount/ISNULL(TB.ExchangeRate, AT1004.ExchangeRate)) AS SignAmount2
				INTO #TEMP20	
				FROM	AV4301 AS V01
				LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = 'USD'
				LEFT JOIN 
				(
					SELECT MAX(ExchangeRate) AS ExchangeRate, DivisionID, ExchangeDate
					FROM AT1012 WITH (NOLOCK)
					WHERE AT1012.CurrencyID = 'USD'
					GROUP BY DivisionID, ExchangeDate
				) TB ON TB.DivisionID = V01.DivisionID AND TB.ExchangeDate = V01.VoucherDate
				WHERE		(V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))
							AND (V01.AccountID >= @AccountIDFrom AND V01.AccountID <= @AccountIDTo)
							AND (V01.TransactionTypeID='T00' or (V01.TranYear * 100 + V01.TranMonth <= @TranYearTo*100+@TranMonthTo))
        		GROUP BY	V01.AccountID	
        	 	
				SELECT 	SUM(V01.SignAmount) AS SignAmount, SUM(V01.SignAmount/ISNULL(TB.ExchangeRate, AT1004.ExchangeRate)) AS SignAmount2
				INTO #TEMP21	
				FROM	AV4301 AS V01
				LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = 'USD'
				LEFT JOIN 
				(
					SELECT MAX(ExchangeRate) AS ExchangeRate, DivisionID, ExchangeDate
					FROM AT1012 WITH (NOLOCK)
					WHERE AT1012.CurrencyID = 'USD'
					GROUP BY DivisionID, ExchangeDate
				) TB ON TB.DivisionID = V01.DivisionID AND TB.ExchangeDate = V01.VoucherDate
				WHERE		(V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))
							AND (V01.AccountID >= @AccountIDFrom AND V01.AccountID <= @AccountIDTo)
							AND (V01.TransactionTypeID='T00' or (V01.TranYear * 100 + V01.TranMonth < @TranYearFrom*100+@TranMonthFrom))
        		GROUP BY	V01.AccountID
        	
				SET @Amount = 
				(SELECT	SUM(isnull(SignAmount,0))
				FROM #TEMP20
				WHERE (@Sign=2 AND SignAmount>=0) OR (@Sign=3 AND SignAmount<0))			
				-
				(SELECT	SUM(isnull(SignAmount,0))
				FROM #TEMP21
				WHERE (@Sign=2 AND SignAmount>=0) OR (@Sign=3 AND SignAmount<0))		
			
				SET @Amount2 = 
				(SELECT	SUM(isnull(SignAmount2,0))
				FROM #TEMP20
				WHERE (@Sign=2 AND SignAmount2>=0) OR (@Sign=3 AND SignAmount2<0))			
				-
				(SELECT	SUM(isnull(SignAmount2,0))
				FROM #TEMP21
				WHERE (@Sign=2 AND SignAmount2>=0) OR (@Sign=3 AND SignAmount2<0))        					
			END		
			ELSE
			BEGIN	
				SELECT 	SUM(V01.SignAmount) AS SignAmount, SUM(V01.SignAmount/ISNULL(TB.ExchangeRate, AT1004.ExchangeRate)) AS SignAmount2
				INTO #TEMP22	
				FROM	AV4301 AS V01
				LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = 'USD'
				LEFT JOIN 
				(
					SELECT MAX(ExchangeRate) AS ExchangeRate, DivisionID, ExchangeDate
					FROM AT1012 WITH (NOLOCK)
					WHERE AT1012.CurrencyID = 'USD'
					GROUP BY DivisionID, ExchangeDate
				) TB ON TB.DivisionID = V01.DivisionID AND TB.ExchangeDate = V01.VoucherDate
				WHERE		(V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))
							AND (V01.AccountID >= @AccountIDFrom AND V01.AccountID <= @AccountIDTo)
							AND (V01.TransactionTypeID='T00' or (V01.TranYear * 100 + V01.TranMonth <= @TranYearTo*100+@TranMonthTo))
							AND (V01.CorAccountID >=@CorAccountIDFrom1 AND V01.CorAccountID <=@CorAccountIDTo1)
        		GROUP BY	V01.AccountID	
        	 	
				SELECT 	SUM(V01.SignAmount) AS SignAmount, SUM(V01.SignAmount/ISNULL(TB.ExchangeRate, AT1004.ExchangeRate)) AS SignAmount2
				INTO #TEMP23	
				FROM	AV4301 AS V01
				LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = 'USD'
				LEFT JOIN 
				(
					SELECT MAX(ExchangeRate) AS ExchangeRate, DivisionID, ExchangeDate
					FROM AT1012 WITH (NOLOCK)
					WHERE AT1012.CurrencyID = 'USD'
					GROUP BY DivisionID, ExchangeDate
				) TB ON TB.DivisionID = V01.DivisionID AND TB.ExchangeDate = V01.VoucherDate
				WHERE		(V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))
							AND (V01.AccountID >= @AccountIDFrom AND V01.AccountID <= @AccountIDTo)
							AND (V01.TransactionTypeID='T00' or (V01.TranYear * 100 + V01.TranMonth < @TranYearFrom*100+@TranMonthFrom))
							AND (V01.CorAccountID >=@CorAccountIDFrom1 AND V01.CorAccountID <=@CorAccountIDTo1)
        		GROUP BY	V01.AccountID		
        	
				SET @Amount = 
				(SELECT	SUM(isnull(SignAmount,0))
				FROM #TEMP22
				WHERE (@Sign=2 AND SignAmount>=0) OR (@Sign=3 AND SignAmount<0))			
				-
				(SELECT	SUM(isnull(SignAmount,0))
				FROM #TEMP23
				WHERE (@Sign=2 AND SignAmount>=0) OR (@Sign=3 AND SignAmount<0))		
			
				SET @Amount2 = 
				(SELECT	SUM(isnull(SignAmount2,0))
				FROM #TEMP22
				WHERE (@Sign=2 AND SignAmount2>=0) OR (@Sign=3 AND SignAmount2<0))			
				-
				(SELECT	SUM(isnull(SignAmount2,0))
				FROM #TEMP23
				WHERE (@Sign=2 AND SignAmount2>=0) OR (@Sign=3 AND SignAmount2<0))         				
			END			
		END			
		GOTO RETURN_VALUES
	END

RETURN_VALUES:
				
IF @Amount IS NULL
	SET @Amount = 0
IF @Amount2 IS NULL
	SET @Amount2 = 0	

IF @Sign In (1,3)
	SET @Amount = @Amount*-1
	
IF @Sign In (1,3)
	SET @Amount2 = @Amount2*-1	


SET @OutputAmount = @Amount
SET @OutputAmount2 = @Amount2
RETURN

DELETE FROM	A00007 WHERE SPID = @@SPID


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

