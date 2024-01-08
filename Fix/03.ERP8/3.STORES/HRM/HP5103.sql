IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[HP5103]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP5103]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






----- 	Created by Dang Le Bao Quynh, Date 09/06/2004
----  	Purpose: Tinh luong theo PP luong Tong hop (Luong cong nhat
----	Cong thuc: L = LuongTH * HeSo*NgayCong/SoNgayQuyDinh

----	Edit by: Dang Le Bao Quynh; Date: 25/01/2007
----	Purpose: Tu thiet lap theo cong thuc tinh cua nguoi dung
----	Modify on 01/08/2013 by Bao Anh: Bo sung them 10 khoan thu nhap 21 -> 30 (Hung Vuong)
/********************************************
'* Edited by: [GS] [Minh Lâm] [02/08/2010]
'********************************************/
---- Modified by Phương Thảo on 05/12/2016: Bổ sung lưu S21->S100 (MEIKO)
--- Modify on 01/03/2017 by Phương Thảo: Cải tiến tốc độ (bỏ vòng lặp)
--- Modifid on 17/07/2017 by Phương Thảo: Set giá trị default cho biến @EmployeeID (%)

CREATE PROCEDURE [dbo].[HP5103]
       @DivisionID AS nvarchar(50) ,
       @TranMonth AS int ,
       @TranYear AS int ,
       @PayrollMethodID nvarchar(50) ,
       @MethodID AS nvarchar(50) ,
       @AbsentAmount AS decimal(28,8) ,
       @Orders AS Tinyint ,
       @IsIncome AS tinyint ,
       @DepartmentID1 AS nvarchar(50) ,
       @TeamID1 AS nvarchar(50) ,
       @ExchangeRate decimal(28,8) ,
       @IncomeID AS nvarchar(50)
AS
DECLARE
        @Emp_cur AS cursor ,
        @DepartmentID AS nvarchar(50) ,
        @TeamID AS nvarchar(50) ,
        @EmployeeID AS nvarchar(50) = '%' ,
        @CoValues AS decimal(28,8) ,
        @AbsentValues AS decimal(28,8) ,
        @SalaryAmount AS decimal(28,8) ,
        @BaseSalary AS decimal(28,8) ,
        @TransactionID AS nvarchar(50) ,
        @IsOtherDayPerMonth AS tinyint ,
        @OtherDayPerMonth AS decimal(28,8) ,
        @IsCondition bit ,
        @ConditionCode nvarchar(4000),		
		@sSQl NVARCHAR(MAX)='',
		@sSQl1 NVARCHAR(MAX)='',
		@OrderNum VARCHAR(5),
		@CustomerIndex INT,
		@TableHT2400 Varchar(50),
		@TableHT2402 Varchar(50),
		@sTranMonth Varchar(2)
	
SELECT @CustomerIndex = CustomerName From CustomerIndex

DECLARE	@SalaryTable TABLE (Salary DECIMAL(28,8))
--select @IncomeID as IncomeID

SELECT @OrderNum = CASE WHEN @Orders <10 THEN LTRIM(RTRIM('0'+CONVERT(VARCHAR(5),@Orders))) ELSE LTRIM(RTRIM(CONVERT(VARCHAR(5),@Orders)))  END

SELECT @OtherDayPerMonth = IsNull(OtherDayPerMonth , 0)
FROM   HT0000
WHERE  DivisionID = @DivisionID

IF @IsIncome = 1
BEGIN
	SELECT	@IsCondition = IsCondition,
			@ConditionCode = ConditionCode
	FROM   HT5005
	WHERE  PayrollMethodID = @PayrollMethodID AND CONVERT(INT,STUFF(IncomeID,1,1,''))   = @Orders
	
END
ELSE
BEGIN
	SELECT	@IsCondition = IsCondition,
			@ConditionCode = ConditionCode
	FROM   HT5006
	WHERE  PayrollMethodID = @PayrollMethodID AND CONVERT(INT,STUFF(SubID,1,1,''))  = @Orders
	
END

SELECT		HT34.DivisionID ,
            HT34.TransactionID ,
            HT34.EmployeeID ,
            HT34.DepartmentID ,
            HT34.TeamID ,
            HV54.GeneralCo ,
            HV54.AbsentAmount ,
			--HV54.BaseSalary ,
            HT34.IsOtherDayPerMonth,
			--@InComeID AS InComeID,
			--@BaseSalaryField AS BaseSalaryField,
			Convert(Decimal(28,8),0) AS BaseSalary,
			@ConditionCode AS ConditionCode,
			@IsCondition AS IsCondition,
			Convert(Decimal(28,8),0) AS Income
INTO #HP5103_HT3400
FROM HT3400 HT34 
LEFT JOIN HT3444 HV54 ON  HT34.EmployeeID = HV54.EmployeeID 
						AND HT34.DivisionID = HV54.DivisionID AND HT34.DepartmentID = HV54.DepartmentID AND isnull(HT34.TeamID,'') = isnull(HV54.TeamID , '') 
						AND HT34.TranMonth = HV54.TranMonth AND HT34.TranYear = HV54.TranYear
WHERE
	HT34.PayrollMethodID = @PayrollMethodID AND HT34.TranMonth = @TranMonth AND HT34.TranYear = @TranYear 
	AND HT34.DivisionID = @DivisionID AND HT34.DepartmentID LIKE @DepartmentID1 AND ISNull(HT34.TeamID , '') LIKE ISNULL(@TeamID1 , '') 
	AND HT34.DepartmentID IN ( SELECT DepartmentID FROM HT5004 WHERE PayrollMethodID = @PayrollMethodID AND DivisionID = @DivisionID )


-- Tinh BaseSalary - @LCB
EXEC HP5104 @PayrollMethodID , @TranMonth , @TranYear , @EmployeeID , @IncomeID , @IsIncome , @DivisionID , @DepartmentID1 , @TeamID1 , @TransactionID , @BaseSalary OUTPUT


UPDATE T1
SET		ConditionCode =  REPLACE(ConditionCode, 'If' , ' Case When ')
FROM #HP5103_HT3400 T1
WHERE	IsCondition = 1  and ISNULL(ConditionCode,'') <> ''

UPDATE T1
SET		ConditionCode =  REPLACE(ConditionCode , '@NC' , 'isnull(AbsentAmount , 0)')
FROM #HP5103_HT3400 T1
WHERE	IsCondition = 1 and ISNULL(ConditionCode,'''') <> ''''

UPDATE T1
SET		ConditionCode =  REPLACE(ConditionCode , '@HSC' , 'isnull(GeneralCo , 0)')
FROM #HP5103_HT3400 T1
WHERE	IsCondition = 1 and ISNULL(ConditionCode,'') <> ''

UPDATE T1
SET		ConditionCode =  REPLACE(ConditionCode , '@LCB' , 'isnull(BaseSalary , 0)')
FROM #HP5103_HT3400 T1
WHERE	IsCondition = 1 and ISNULL(ConditionCode,'') <> ''

UPDATE T1
SET		Income =  CASE WHEN isnull(@AbsentAmount , 0) = 0 THEN 0
                  ELSE isnull(BaseSalary , 0) * isnull(GeneralCo , 1) * isnull(AbsentAmount , 0) * isnull(@ExchangeRate , 1) / @AbsentAmount END
FROM #HP5103_HT3400 T1
WHERE	IsCondition = 0 

UPDATE T1
SET		Income =  0
FROM #HP5103_HT3400 T1
WHERE	IsCondition = 1 and ISNULL(ConditionCode,'') = ''


--select * from #HP5103_HT3400

DECLARE	@curHP5103 cursor ,
		@cConditionCode NVARCHAR(max) = '',
		@sSQLCondition NVARCHAR(max) = ''

--SET @sSQLCondition = N'
--		UPDATE T1
--		SET		InCome = '+@ConditionCode+'
--		FROM #HP5103_HT3400 T1
--		WHERE	IsCondition = 1 and ConditionCode = '''+@ConditionCode+'''
--		'


Set @curHP5103 =  cursor static for 
	Select	distinct ConditionCode
	From	#HP5103_HT3400
	WHERE	IsCondition = 1 and ISNULL(ConditionCode,'') <> ''
	Open @curHP5103
	
	Fetch Next From @curHP5103 Into @cConditionCode
	While @@Fetch_Status = 0
	Begin
		SET @sSQLCondition = @sSQLCondition+ N'
		UPDATE T1
		SET		InCome = '+@cConditionCode+'
		FROM #HP5103_HT3400 T1
		WHERE	IsCondition = 1 and ConditionCode = '''+@cConditionCode+'''

		'
		--EXEC (@sSQLCondition)
	Fetch Next From @curHP5103 Into @cConditionCode
	End
	Close @curHP5103


IF @Orders <= 30 AND @IsIncome = 1
BEGIN
	SET @sSQl = '				
		UPDATE T1 
		SET T1.Income'+@OrderNum+' = T2.Income, 
			IGAbsentAmount'+@OrderNum+' = T2.Income
		FROM HT3400 T1
		INNER JOIN #HP5103_HT3400 T2 ON T1.DivisionID = T2.DivisionID AND T1.TransactionID = T2.TransactionID
		WHERE  T1.DivisionID = '''+@DivisionID +'''
		AND T1.PayrollMethodID = '''+ISNULL(@PayrollMethodID ,'')+'''
		AND T1.TranMonth = '+STR(@TranMonth)+' AND T1.TranYear = '+STR(@TranYear )+'		
	'
END
IF @Orders <= 20 AND @IsIncome <> 1
BEGIN
	SET @sSQl = '
		UPDATE T1 
		SET SubAmount'+@OrderNum+' = T2.Income
		FROM HT3400 T1
		INNER JOIN #HP5103_HT3400 T2 ON T1.DivisionID = T2.DivisionID AND T1.TransactionID = T2.TransactionID
		WHERE  T1.DivisionID = '''+@DivisionID +'''
		AND T1.PayrollMethodID = '''+ISNULL(@PayrollMethodID ,'')+'''
		AND T1.TranMonth = '+STR(@TranMonth)+' AND T1.TranYear = '+STR(@TranYear )+'		
	'
END
			
IF @Orders > 30 AND @IsIncome = 1 
BEGIN
	SET @sSQl = '				
	UPDATE T1 
	SET Income'+@OrderNum+' = T2.Income
	FROM HT3499 T1
	INNER JOIN #HP5103_HT3400 T2 ON T1.DivisionID = T2.DivisionID AND T1.TransactionID = T2.TransactionID
	WHERE T1.DivisionID = '''+@DivisionID+''' 		
	'
END
			
IF @Orders > 20 AND @Orders <= 100 AND @IsIncome <> 1
BEGIN
	SET @sSQl = '
	UPDATE T1 
	SET SubAmount'+@OrderNum+' =  T2.Income
	FROM HT3499 T1
	INNER JOIN #HP5103_HT3400 T2 ON T1.DivisionID = T2.DivisionID AND T1.TransactionID = T2.TransactionID
	WHERE T1.DivisionID = '''+@DivisionID+''' 	
	'
END
--PRINT (@sSQLCondition)
--PRINT (@sSQl)
EXEC (@sSQLCondition+@sSQl)




-------------------------------------------------------------
--SET @Emp_cur = CURSOR SCROLL KEYSET FOR 
--		SELECT
--                TransactionID ,
--                EmployeeID ,
--                DepartmentID ,
--                TeamID ,
--   GeneralCo ,
--                AbsentAmount ,
--				BaseSalary ,
--                IsOtherDayPerMonth
--        FROM #HP5103_HT3400

--OPEN @Emp_cur
--FETCH NEXT FROM @Emp_cur INTO @TransactionID,@EmployeeID,@DepartmentID,@TeamID,@CoValues,@AbsentValues,@BaseSalary,@IsOtherDayPerMonth
--WHILE @@FETCH_STATUS = 0
--      BEGIN
--            SET @SalaryAmount = 0
--		---Thiet lap lai bien @BaseSalary tai day 
		
--	--	PRINT @PayrollMethodID 
-- --PRINT @TranMonth 
-- --PRINT @TranYear 
-- --PRINT @EmployeeID 
-- --PRINT @IncomeID 
-- --PRINT @IsIncome 
-- --PRINT @DivisionID 
-- --PRINT @DepartmentID 
-- --PRINT @TeamID 
-- --PRINT @TransactionID 
-- --PRINT @BaseSalary

	
--            --EXEC HP5104 @PayrollMethodID , @TranMonth , @TranYear , @EmployeeID , @IncomeID , @IsIncome , @DivisionID , @DepartmentID , @TeamID , @TransactionID , @BaseSalary OUTPUT

--            IF @IsIncome = 1
--               BEGIN
--                     SELECT
--                         @IsCondition = IsCondition ,
--                         @ConditionCode = ConditionCode
--                     FROM
--                         HT5005
--                     WHERE
--                         PayrollMethodID = @PayrollMethodID AND CAST(RIGHT(IncomeID , 2) AS int) = @Orders
--                     IF @IsCondition = 0
--                        BEGIN	
--						--print 'a'
--                              SET @SalaryAmount = CASE
--                                                       WHEN isnull(@AbsentAmount , 0) = 0 THEN 0
--                                                       ELSE isnull(@BaseSalary , 0) * isnull(@CoValues , 1) * isnull(@AbsentValues , 0) * isnull(@ExchangeRate , 1) / @AbsentAmount
--                                                  END
--						--if(@SalaryAmount>0)
--						--begin
--						--	print ('EmployeeID'		+ '  ' + @EmployeeID)
--						--	print ('@Orders'		+ '  ' + convert(varchar(50),@Orders)		)
--						--	print ('@BaseSalary'	+ '  ' + convert(varchar(50),@BaseSalary)	)
--						--	print ('@CoValues'		+ '  ' + convert(varchar(50),@CoValues)	)
--						--	print ('@AbsentValues'	+ '  ' + convert(varchar(50),@AbsentValues))
--						--	print ('@SalaryAmount'	+ '  ' + convert(varchar(50),@SalaryAmount))
--						--	print ('@AbsentAmount'	+ '  ' + convert(varchar(50),@AbsentAmount))
--						--end
--                        END
--                     ELSE
--                        BEGIN
--                              IF @ConditionCode IS NULL OR @ConditionCode = ''
--                                 BEGIN
--                                       SET @SalaryAmount = 0
--                                 END
--                              ELSE
--                                 BEGIN	
--									   	---- Thay thế sinh view bằng cách sử dụng biến bảng
--							 			DELETE @SalaryTable
--							 			SET @ConditionCode = REPLACE(@ConditionCode, 'If', ' CASE WHEN ')
--										SET @ConditionCode = REPLACE(@ConditionCode, '@NC', ISNULL(@AbsentValues, 0))
--										SET @ConditionCode = REPLACE(@ConditionCode, '@HSC', ISNULL(@CoValues , 1))
--										SET @ConditionCode = REPLACE(@ConditionCode, '@LCB', ISNULL(@BaseSalary , 0))
--							 			INSERT INTO @SalaryTable (Salary) EXEC('SELECT '+@ConditionCode+'')
--							 			SET @SalaryAmount = (SELECT TOP 1 Salary FROM @SalaryTable)
													
--                                       --EXEC HP5555 @AbsentValues , @CoValues , @BaseSalary , @ConditionCode , @SalaryAmount OUTPUT
--									   --select @EmployeeID, @AbsentValues , @CoValues , @BaseSalary ,@ConditionCode, @SalaryAmount
--                                 END
--                        END
--               END
--            ELSE
--               BEGIN
--                     SELECT
--                         @IsCondition = IsCondition ,
--                         @ConditionCode = ConditionCode
--                     FROM
--                         HT5006
--                     WHERE
--                         PayrollMethodID = @PayrollMethodID AND CAST(RIGHT(SubID , 2) AS int) = @Orders
--                     IF @IsCondition = 0
--                        BEGIN
--                              SET @SalaryAmount = CASE
--                                                       WHEN isnull(@AbsentAmount , 0) = 0 THEN 0
--                                                       ELSE isnull(@BaseSalary , 0) * isnull(@CoValues , 1) * isnull(@AbsentValues , 0) * isnull(@ExchangeRate , 1) / @AbsentAmount
--                                                  END
--                        END
--                     ELSE
--                        BEGIN
--                              IF @ConditionCode IS NULL OR @ConditionCode = ''
--                                 BEGIN
--                                       SET @SalaryAmount = 0
--                                 END
--                              ELSE
--                                 BEGIN						
--                                       EXEC HP5555 @AbsentValues , @CoValues , @BaseSalary , @ConditionCode , @SalaryAmount OUTPUT
--									    --select @EmployeeID, @AbsentValues , @CoValues , @BaseSalary ,@ConditionCode, @SalaryAmount
--                                 END
--                        END
--               END
--			   --print @OrderNum
--			   --print @SalaryAmount
--			--Rem by Dang Le Bao Quynh
--			--Purpose: Khong hieu muc dich cua viec kiem tra so ngay quy dinh @AbsentAmount > 20 and @AbsentAmount <32 ???????????
--			--Set @SalaryAmount = case when isnull(@AbsentAmount, 0) = 0 then 0 else isnull(@BaseSalary,0)*isnull( @CoValues,1)*isnull(@AbsentValues,0)* isnull(@ExchangeRate,1)/ case When  @AbsentAmount > 20 and @AbsentAmount <32 Then   Case When IsNull(@IsOtherDayPerMonth,0) =0 Then  @AbsentAmount    Else  @OtherDayPerMonth  End    Else  @AbsentAmount  End     End
--			IF @Orders <= 30 AND @IsIncome = 1
--			BEGIN
--				SET @sSQl = '				
--					UPDATE HT3400 
--					SET Income'+@OrderNum+' = '+CONVERT(VARCHAR(50),@SalaryAmount)+', IGAbsentAmount'+@OrderNum+' = '+CONVERT(VARCHAR(50),ISNULL(@AbsentValues , 0))+'
--					WHERE  DivisionID = '''+@DivisionID +'''
--					AND PayrollMethodID = '''+ISNULL(@PayrollMethodID ,'')+'''
--					AND TranMonth = '+STR(@TranMonth)+' AND TranYear = '+STR(@TranYear )+'
--					AND TransactionID = '''+@TransactionID +'''
--				'
--			END
--			IF @Orders <= 20 AND @IsIncome <> 1
--			BEGIN
--				SET @sSQl = '
--					UPDATE HT3400 
--					SET SubAmount'+@OrderNum+' = '+CONVERT(VARCHAR(50),@SalaryAmount)+', IGAbsentAmount'+@OrderNum+' = '+CONVERT(VARCHAR(50),ISNULL(@AbsentValues , 0))+'
--					WHERE  DivisionID = '''+@DivisionID +'''
--					AND PayrollMethodID = '''+ISNULL(@PayrollMethodID ,'')+'''
--					AND TranMonth = '+STR(@TranMonth)+' AND TranYear = '+STR(@TranYear )+'
--					AND TransactionID = '''+@TransactionID +'''
--				'
--			END
			
--			IF @Orders > 30 AND @IsIncome = 1  AND @CustomerIndex = 50 --MEIKO
--			BEGIN
--				SET @sSQl = '				
--				UPDATE HT3499 
--				SET Income'+@OrderNum+' = '+CONVERT(VARCHAR(50),@SalaryAmount)+'
--				WHERE DivisionID = '''+@DivisionID+''' 
--				AND TransactionID = '''+@TransactionID+'''					
--				'
--			END
			
--			IF @Orders > 20 AND @Orders <= 100 AND @IsIncome <> 1  AND @CustomerIndex = 50 --MEIKO
--			BEGIN
--				SET @sSQl = '
--				UPDATE HT3499 
--				SET SubAmount'+@OrderNum+' = '+CONVERT(VARCHAR(50),@SalaryAmount)+'
--				WHERE DivisionID = '''+@DivisionID+''' 
--				AND TransactionID = '''+@TransactionID+'''
--				'
--			END
--			--PRINT (@sSQl)
--			EXEC (@sSQl)

--    FETCH NEXT FROM @Emp_cur INTO @TransactionID,@EmployeeID,@DepartmentID,@TeamID,@CoValues,@AbsentValues,@BaseSalary,@IsOtherDayPerMonth
--END

--CLOSE @Emp_cur




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

