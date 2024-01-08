IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7911_MK]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP7911_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Tinh toan ket qua de lay gia tri tra ve bao cao BCDKT
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on by 
---- 
---- Modified on 29/07/2010 by Minh Lâm
---- Modified on 22/12/2011 by Nguyễn Bình Minh : Bổ sung các mode 102, 104, 121, 122
---- Modified on 22/10/2012 by Lê Thị Thu Hiền : Bổ sung in nhiều đơn vị
---- Modified by on 02/01/2013 by Lê Thị Thu Hiền : Thay đổi INSERT #DivisionID bằng Bảng tạm A00007
---- Modified by on 19/08/2015 by Bảo Anh : Bỏ group by DivisionID để lấy số liệu tổng các DivisionID rồi mới xét Dư nợ hoặc có
---- Modified by on 15/06/2016 by Bảo Anh : Sửa lỗi số đầu năm lên sai khi niên độ tài chính không phải bắt đầu từ tháng 1
---- Modified by on 28/09/2016 by Phương Thảo :  Bổ sung lấy số phát sinh nợ, co (Customize Meiko)
---- Modified by on 10/02/2020 by Mỹ Tuyền: Fix lỗi in kỳ đầu tiên của dữ liệu lấy sai số phát sinh (số phát sinh cộng luôn số đầu kỳ)
---- Modified by on 19/08/2020 by Huỳnh Thử: Merge Code: MEKIO và MTE
-- <Example>/
---- 
CREATE PROCEDURE [dbo].[AP7911_MK]
(
       @DivisionID AS nvarchar(50) ,
       @AccountIDFrom AS nvarchar(50) ,
       @AccountIDTo AS nvarchar(50) ,
       @TranMonthFrom AS int ,
       @TranYearFrom AS int ,
       @TranMonthTo AS int ,
       @TranYearTo AS int ,
       @Mode AS int ,
       @OutputAmount AS decimal(28,8) OUTPUT,
       @StrDivisionID AS NVARCHAR(4000) = '',
       @AV4201 As TypeOfAV4201 READONLY
)       
AS

DECLARE @PeriodFrom  INT,
        @PeriodTo    INT,
		@Year int

DECLARE @Amount AS DECIMAL(28, 4)

--------------->>>> Chuỗi DivisionID
DECLARE @StrDivisionID_New AS NVARCHAR(4000)
	
SELECT @StrDivisionID_New = CASE WHEN @StrDivisionID = '%' THEN ' LIKE ''' + 
@StrDivisionID + '''' ELSE ' IN (''' + replace(@StrDivisionID, ',',''',''') + ''')' END
		
DELETE FROM	A00007 WHERE SPID = LTRIM(@@SPID)
INSERT INTO A00007(SPID, DivisionID) 
EXEC('SELECT '''+@@SPID+''', DivisionID FROM AT1101 WHERE DivisionID '+@StrDivisionID_New+'')

---------------------<<<<<<<<<< Chuỗi DivisionID

SET @Amount = 0
SELECT Top 1 @Year = cast(Right(LTrim(RTrim(Quarter)),4) as int) FROM AV9999 WHERE DivisionID = @DivisionID
AND TranMonth = @TranMonthFrom and TranYear = @TranYearFrom

SET @PeriodFrom = @TranYearFrom * 100 + @TranMonthFrom
SET @PeriodTo = @TranYearTo * 100 + @TranMonthTo
--If @AccountIDFrom  like '111%' 
--Print ' van Nhan @AccountIDFrom :' +@AccountIDFrom+' @Mode ' +str(@Mode)
SET @Amount = 0

IF @Mode = 1 -------- Con so tong hop, So Cuoi ky, Lay so du No
BEGIN
    SELECT	@Amount = SUM(V01.ConvertedAmount)
    FROM	@AV4201 AS V01
    WHERE	(V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))
			AND (V01.AccountID >= @AccountIDFrom AND V01.AccountID <= @AccountIDTo)
			AND (V01.TranYear * 100 + V01.TranMonth <= @PeriodTo)
    --If @Amount<0
    --Set @Amount = @Amount*(-1)	
    GOTO RETURN_VALUES
END

IF @Mode = 2 ------- Lay so dau nam, Lay so du No
BEGIN
    SELECT @Amount = SUM(V01.ConvertedAmount)
    FROM   @AV4201 AS V01
    WHERE  ((V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))AND (V01.AccountID >= @AccountIDFrom) AND (V01.AccountID <= @AccountIDTo))
           AND ((V01.TranYear < @Year) OR (TransactionTypeID = 'T00'))
    --      If @Amount<0
    --Set @Amount = @Amount*(-1)	
    GOTO RETURN_VALUES
END

IF @Mode = 102 ------- Lấy số đầu kỳ, Lấy số dư Nợ
BEGIN
    SELECT @Amount = SUM(V01.ConvertedAmount)
    FROM   @AV4201 AS V01
    WHERE  ((V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))AND (V01.AccountID >= @AccountIDFrom) AND (V01.AccountID <= @AccountIDTo))
           AND ((V01.TranMonth + V01.TranYear * 100 < @PeriodFrom) OR (TransactionTypeID = 'T00'))
    --      If @Amount<0
    --Set @Amount = @Amount*(-1)	
    GOTO RETURN_VALUES
END

IF @Mode = 3 -------- Con so tong hop, So Cuoi ky, Lay so du Co
BEGIN
    SELECT @Amount = SUM(V01.ConvertedAmount * (-1))
    FROM   @AV4201 AS V01
    WHERE  (V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))
			AND (V01.AccountID >= @AccountIDFrom AND V01.AccountID <= @AccountIDTo)
			AND (V01.TranYear * 100 + V01.TranMonth <= @PeriodTo)
    --If @Amount<0
    --Set @Amount = @Amount*(-1)	
    GOTO RETURN_VALUES
END

IF @Mode = 4 ------- Lay so dau nam, lay so du Co
BEGIN
    SELECT @Amount = SUM(V01.ConvertedAmount * (-1))
    FROM   @AV4201 AS V01
    WHERE  ((V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))
			AND (V01.AccountID >= @AccountIDFrom) AND (V01.AccountID <= @AccountIDTo))
           AND ((V01.TranYear < @Year) OR (TransactionTypeID = 'T00'))
    --- If @Amount<0
    ---	Set @Amount = @Amount*(-1)	
    GOTO RETURN_VALUES
END

IF @Mode = 104 ------- Lấy số đầu kỳ, Lấy số dư Có
BEGIN
    SELECT @Amount = SUM(V01.ConvertedAmount * (-1))
    FROM   @AV4201 AS V01
    WHERE  ((V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))
			AND (V01.AccountID >= @AccountIDFrom) AND (V01.AccountID <= @AccountIDTo))
			AND ((V01.TranMonth + V01.TranYear * 100 < @PeriodFrom) OR (TransactionTypeID = 'T00'))
    --- If @Amount<0
    ---	Set @Amount = @Amount*(-1)	
    GOTO RETURN_VALUES
END

IF @Mode = 11 ------- So chi tiet theo tai khoan (Du No) , so cuoi ky
BEGIN
    ---Print ' Begin ' 
    SELECT @Amount = SUM(X.ConvertedAmount)
    FROM   (	SELECT		V01.AccountID,
							SUM(V01.ConvertedAmount) AS ConvertedAmount
               FROM			@AV4201 AS V01
               WHERE		(V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))
							AND (V01.AccountID >= @AccountIDFrom AND V01.AccountID <= @AccountIDTo)
							AND (V01.TranYear * 100 + V01.TranMonth <= @PeriodTo)
            	GROUP BY	V01.AccountID
           ) AS X
    WHERE  X.ConvertedAmount >= 0 ---- Phai la du No
    SET @Amount = ISNULL(@Amount, 0)
    --Print ' Nhan' 
    GOTO RETURN_VALUES
END

IF @Mode = 21 ----- So chi tiet tai khoan (Du No), So dau nam
BEGIN
    SELECT @Amount = SUM(X.ConvertedAmount)
    FROM   (	SELECT		V01.AccountID,
							SUM(V01.ConvertedAmount) AS ConvertedAmount
               FROM			@AV4201 AS V01
               WHERE		((V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))AND (V01.AccountID >= @AccountIDFrom AND V01.AccountID <= @AccountIDTo))
							AND ((V01.TranYear < @Year) OR (TransactionTypeID = 'T00'))
            	GROUP BY	V01.AccountID
           ) AS X
    WHERE  X.ConvertedAmount >= 0 --- Phai la du No
    GOTO RETURN_VALUES
END

IF @Mode = 121 ----- Sổ chi tiết tài khoản (Dư Nợ), Số đầu kỳ
BEGIN
    SELECT @Amount = SUM(X.ConvertedAmount)
    FROM   (	SELECT		V01.AccountID,
							SUM(V01.ConvertedAmount) AS ConvertedAmount
				FROM		@AV4201 AS V01
				WHERE		((V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))AND (V01.AccountID >= @AccountIDFrom AND V01.AccountID <= @AccountIDTo))
							--AND ((V01.TranMonth + V01.TranYear * 100 < @PeriodFrom) OR (TransactionTypeID = 'T00'))
							AND ((V01.TranMonth + V01.TranYear * 100 < @PeriodFrom) )
            	GROUP BY	V01.AccountID
           ) AS X
    WHERE  X.ConvertedAmount >= 0 --- Phai la du No
    GOTO RETURN_VALUES
END

IF @Mode = 12 ------ Chi tiet theo tai khoan ( du Co), so du cuoi  ky
BEGIN
    --If @AccountIDFrom ='331'
    ---Print ' Nhan test '+ @AccountIDTo
    SELECT @Amount = -SUM(X.ConvertedAmount)
    FROM   (	SELECT	V01.AccountID,
						SUM(V01.ConvertedAmount) AS ConvertedAmount
               FROM		@AV4201 AS V01
               WHERE	(V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))
						AND (V01.AccountID >= @AccountIDFrom AND V01.AccountID <= @AccountIDTo)
						AND (V01.TranYear * 100 + V01.TranMonth <= @PeriodTo)
               GROUP BY	V01.AccountID
           ) AS X
    WHERE  X.ConvertedAmount < 0
    
    GOTO RETURN_VALUES
END

IF @Mode = 22 ------- Chi tiet so du tai khoan (du Co), so du dau nam
BEGIN
    SELECT @Amount = -SUM(X.ConvertedAmount)
    FROM   (	SELECT		V01.AccountID,
							SUM(V01.ConvertedAmount) AS ConvertedAmount
               FROM			@AV4201 AS V01
               WHERE		((V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))
							AND (V01.AccountID >= @AccountIDFrom AND V01.AccountID <= @AccountIDTo))
							--AND ((V01.TranYear < @Year) OR (TransactionTypeID = 'T00'))
							AND ((V01.TranYear < @Year) )
            	GROUP BY	V01.AccountID
           ) AS X
    WHERE  X.ConvertedAmount <= 0 --- The hien so du Co
    
    GOTO RETURN_VALUES
END

IF @Mode = 122 ------- Lấy chi tiết số dư tài khoản (dư Có), số dư đầu kỳ
BEGIN
    SELECT @Amount = -SUM(X.ConvertedAmount)
    FROM   (	SELECT		V01.AccountID,
							SUM(V01.ConvertedAmount) AS ConvertedAmount
               FROM			@AV4201 AS V01
               WHERE		((V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))
							AND (V01.AccountID >= @AccountIDFrom AND V01.AccountID <= @AccountIDTo))
							--AND ((V01.TranMonth + V01.TranYear * 100 < @PeriodFrom) OR (TransactionTypeID = 'T00'))
							AND ((V01.TranMonth + V01.TranYear * 100 < @PeriodFrom) )
            	GROUP BY	V01.AccountID
           ) AS X
    WHERE  X.ConvertedAmount <= 0 --- The hien so du Co
    
    GOTO RETURN_VALUES
END  


IF @Mode = 5 -------- Lấy phát sinh Nợ  (tổng hợp)
BEGIN
    SELECT	@Amount = SUM(V01.ConvertedAmount)
    FROM	@AV4201 AS V01
    WHERE	(V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))
			AND (V01.AccountID >= @AccountIDFrom AND V01.AccountID <= @AccountIDTo)
			AND (V01.TranYear * 100 + V01.TranMonth Between @PeriodFrom and @PeriodTo)
			AND TransactionTypeID<>'T00'
			AND D_C = 'D'	
    GOTO RETURN_VALUES
END

IF @Mode = 6 ------- Lay phát sinh Có (tổng hợp)
BEGIN
    SELECT	@Amount = SUM(V01.ConvertedAmount * (-1))
    FROM	@AV4201 AS V01
    WHERE	(V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))
			AND (V01.AccountID >= @AccountIDFrom AND V01.AccountID <= @AccountIDTo)
			AND (V01.TranYear * 100 + V01.TranMonth Between @PeriodFrom and @PeriodTo)
			AND TransactionTypeID<>'T00'
			AND D_C = 'C'		
    GOTO RETURN_VALUES
END


IF @Mode = 7 -------- Lấy phát sinh Nợ (chi tiết tài khoản)
BEGIN
    SELECT @Amount = -SUM(X.ConvertedAmount)
    FROM   (	SELECT	V01.AccountID,
						SUM(V01.ConvertedAmount) AS ConvertedAmount
               FROM		@AV4201 AS V01
               WHERE	(V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))
						AND (V01.AccountID >= @AccountIDFrom AND V01.AccountID <= @AccountIDTo)
						AND (V01.TranYear * 100 + V01.TranMonth Between @PeriodFrom and @PeriodTo)
						AND TransactionTypeID<>'T00'
						AND D_C = 'D'
               GROUP BY	V01.AccountID
           ) AS X    
	
    GOTO RETURN_VALUES
END

IF @Mode = 8 ------- Lay phát sinh Có (chi tiết tài khoản)
BEGIN
     SELECT @Amount = -SUM(X.ConvertedAmount)
     FROM   (	SELECT	V01.AccountID,
						SUM(V01.ConvertedAmount) AS ConvertedAmount
               FROM		@AV4201 AS V01
               WHERE	(V01.DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID))
						AND (V01.AccountID >= @AccountIDFrom AND V01.AccountID <= @AccountIDTo)
						AND (V01.TranYear * 100 + V01.TranMonth Between @PeriodFrom and @PeriodTo)
						AND D_C = 'C'
						AND TransactionTypeID<>'T00'
               GROUP BY	V01.AccountID
           ) AS X    

    GOTO RETURN_VALUES
END
  

RETURN_VALUES:
----Print ' From '+@AccountIDFrom+' @Mode'+str(@Mode)+' To : @AccountIDTo ' +@AccountIDTo
---Print ' @Amount ='+str(@Amount)
SET @OutputAmount = @Amount
RETURN

DELETE FROM	A00007 WHERE SPID = @@SPID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
