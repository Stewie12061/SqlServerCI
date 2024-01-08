IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7913]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP7913]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Lay so lieu tu tai khoan ngoai bang do vao bang cdkt
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 28/05/2007 by Van Nhan
---- Modified on 29/07/2010 by Hoàng Phước
---- Modified on 22/12/2011 by Nguyễn Bình Minh: Bổ sung 
---- Modified on 22/10/2012 by Lê Thị Thu Hiền : Bổ sung in nhiều đơn vị
---- Modified by on 02/01/2013 by Lê Thị Thu Hiền : Thay đổi INSERT #DivisionID bằng Bảng tạm A00007
---- Modified by Khả Vi on 02/11/2017: Customize cho khách hàng Figla (CustomizeIndex = 49)
-- <Example>
---- 
CREATE PROCEDURE [dbo].[AP7913]
(
	@DivisionID AS NVARCHAR(50),			
	@AccountIDFrom AS NVARCHAR(50),		
	@AccountIDTo AS NVARCHAR(50),	
	@TranMonthFrom AS INT,			
	@TranYearFrom AS INT,				
	@TranMonthTo AS INT,				
	@TranYearTo AS INT,	
	@Mode AS INT,			
	@OutputAmount AS DECIMAL(28, 8) OUTPUT,
	@StrDivisionID AS NVARCHAR(4000) = ''
)
AS

DECLARE @PeriodFrom  INT,
        @PeriodTo    INT,
		@Period INT,
		@CustomerName AS INT	        

DECLARE @Amount AS DECIMAL(28, 8)

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

--------------->>>> Chuỗi DivisionID
DECLARE @StrDivisionID_New AS NVARCHAR(4000)
	
SELECT @StrDivisionID_New = CASE WHEN @StrDivisionID = '%' THEN ' LIKE ''' + 
@StrDivisionID + '''' ELSE ' IN (''' + replace(@StrDivisionID, ',',''',''') + ''')' END
		
DELETE FROM	A00007 WHERE SPID = @@SPID
INSERT INTO A00007(SPID, DivisionID) 
EXEC('SELECT '''+@@SPID+''', DivisionID FROM AT1101 WHERE DivisionID '+@StrDivisionID_New+'')

---------------------<<<<<<<<<< Chuỗi DivisionID

SET @Amount = 0
SET @PeriodFrom = @TranYearFrom * 100 + @TranMonthFrom
SET @PeriodTo = @TranYearTo * 100 + @TranMonthTo
SET @Amount = 0
IF @CustomerName = 49
BEGIN
	IF @TranMonthFrom >= 10 SET @TranYearFrom = @TranYearFrom
	IF @TranMonthFrom < 10 SET @TranYearFrom = @TranYearFrom - 1
	SET @Period = @TranYearFrom * 100 + 10
END


IF @Mode = 1 -------- Con so tong hop, So Cuoi ky, Lay so du No
BEGIN
	IF(@CustomerName = 75)
	BEGIN
		SELECT @Amount = SUM(CASE WHEN D_C = 'D' THEN V01.OriginalAmount ELSE - V01.OriginalAmount END)
		FROM   AT9004 AS V01
		WHERE  (V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))
			   AND (V01.AccountID >= @AccountIDFrom AND V01.AccountID <= @AccountIDTo)
			   AND (V01.TranYear * 100 + V01.TranMonth BETWEEN @PeriodFrom AND @PeriodTo)    
		GOTO RETURN_VALUES			
	END
	ELSE
	BEGIN
		SELECT @Amount = SUM(CASE WHEN D_C = 'D' THEN V01.OriginalAmount ELSE - V01.OriginalAmount END)
		FROM   AT9004 AS V01
		WHERE  (V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))
			   AND (V01.AccountID >= @AccountIDFrom AND V01.AccountID <= @AccountIDTo)
			   AND (V01.TranYear * 100 + V01.TranMonth <= @PeriodTo)    
		GOTO RETURN_VALUES		
	END			
END

IF @Mode = 2 ------- Lay do dau nam, Lay so du No
BEGIN
	IF @CustomerName = 49
	BEGIN
		SELECT @Amount = SUM(CASE WHEN D_C = 'D' THEN V01.OriginalAmount ELSE -V01.OriginalAmount END)
		FROM   AT9004 AS V01
		WHERE  ((V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))
					AND (V01.AccountID >= @AccountIDFrom) AND (V01.AccountID <= @AccountIDTo))
				AND (V01.TranYear * 100 + V01.TranMonth < @Period OR (TransactionTypeID = 'T00'))
    
		GOTO RETURN_VALUES
	END
	ELSE
	BEGIN
		SELECT @Amount = SUM(CASE WHEN D_C = 'D' THEN V01.OriginalAmount ELSE -V01.OriginalAmount END)
		FROM   AT9004 AS V01
		WHERE  ((V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))
					AND (V01.AccountID >= @AccountIDFrom) AND (V01.AccountID <= @AccountIDTo))
				AND (V01.TranYear < @TranYearFrom OR (TransactionTypeID = 'T00'))
    
		GOTO RETURN_VALUES
	END
END

IF @Mode = 102 ------- Lấy số đầu kỳ, Số dư Nợ
BEGIN
    SELECT @Amount = SUM(CASE WHEN D_C = 'D' THEN V01.OriginalAmount ELSE -V01.OriginalAmount END)
    FROM   AT9004 AS V01
    WHERE  ((V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))
				AND (V01.AccountID >= @AccountIDFrom) AND (V01.AccountID <= @AccountIDTo))
			AND (V01.TranYear * 100 + V01.TranMonth < @PeriodFrom OR (TransactionTypeID = 'T00'))
    
    GOTO RETURN_VALUES
END

RETURN_VALUES:

SET @OutputAmount = @Amount
RETURN

DELETE FROM	A00007 WHERE SPID = @@SPID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
