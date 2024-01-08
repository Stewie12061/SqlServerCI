IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP5101]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP5101]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----- 	Created by Nguyen Van Nhan, Date 29/04/2004
----  	Purpose: Tinh luong theo PP luong Nhan (Luong cong nhat
----	Cong thuc: L = LCB * HeSo*NgayCong/SoNgayQuyDinh

----	Edit by: Dang Le Bao Quynh; Date: 25/01/2007
----	Purpose: Tu thiet lap theo cong thuc tinh cua nguoi dung
/********************************************
'* Edited by: [GS] [Minh Lâm] [02/08/2010]
'********************************************/

-- Edited by: [GS] [Trong Khanh] [05/03/2012] -- If @MethodID = 'P04' : Thêm phần tính phương pháp tính lương sản phẩm chỉ định
-- Edited by: [GS] [Bao Quynh] [05/03/2013] -- If @MethodID = 'P05' : Thêm phần tính phương pháp tính lương sản phẩm theo ngay  Vietroll
--- Modify on 01/08/2013 by Bao Anh: Bo sung 10 khoan thu nhap Income21 -> Income30 (Hưng Vượng)
----- Modified on 06/09/2013 by Le Thi Thu Hien : Cham cong theo ca (Neu co du lieu cham cong ca thi cham cong ca nguoc lai cham cong ngay VietRoll
----- Modified on 08/11/2013 by Le Thi Thu Hien : Sửa tính lương sản phẩm của Cảng sài gòn
----- Modified on 03/12/2013 by Bảo Anh : Sửa lỗi không cập nhật các khoản IGAbsentAmount21 -> IGAbsentAmount30
----- Modified on 24/03/2014 by Le Thi Thu Hien : Bo sung tinh luong chi dinh theo loai cong khong sum het
----- Modified on 11/08/2015 by Bảo Anh : Sửa lỗi tính lương sản phẩm theo P04, P05 không lên dữ liệu
----- Modified on 18/05/2016 by Bảo Anh : Bổ sung trường hợp tính lương sp pp chỉ định theo ca nhưng không chấm công ca (Secoin)
---- Modified by Phương Thảo on 05/12/2016: Bổ sung lưu S21->S100 (MEIKO)
--- Modify on 01/03/2017 by Phương Thảo: Cải tiến tốc độ (cho pp tính công nhật 'P01')
----- Modified on 27/06/2018 by Bảo Anh : Sửa lỗi tính sai ngày cong tổng hợp

CREATE PROCEDURE [dbo].[HP5101]
       @DivisionID AS nvarchar(50) ,
       @TranMonth AS int ,
       @TranYear AS int ,
       @PayrollMethodID nvarchar(50) ,
       @MethodID AS nvarchar(50) ,
       @AbsentAmount AS decimal(28,8) ,
       @Orders AS tinyint ,
       @IsIncome AS tinyint ,
       @DepartmentID1 AS nvarchar(50) ,
       @TeamID1 AS nvarchar(50) ,
       @ExchangeRate decimal(28,8),
       @IncomeID        AS NVARCHAR(50),
       @GeneralAbsentID AS nvarchar(50)
AS --Print 'Luong congNhat'
DECLARE
        @Emp_cur AS cursor ,
        @DepartmentID AS nvarchar(50) ,
        @TeamID AS nvarchar(50) ,
        @EmployeeID AS nvarchar(50) ,
        @CoValues AS decimal(28,8) ,
        @AbsentValues AS decimal(28,8) ,
        @SalaryAmount AS decimal(28,8) ,
        @BaseSalary AS decimal(28,8) ,
        @TransactionID AS nvarchar(50) ,
        @IsOtherDayPerMonth AS tinyint ,
        @OtherDayPerMonth AS decimal(28,8) ,
        @IsCondition bit ,
        @ConditionCode nvarchar(4000),
		@sSQL NVARCHAR(MAX) = '',
		@OrderNum VARCHAR(5)

SELECT @OrderNum = CASE WHEN @Orders <10 THEN LTRIM(RTRIM('0'+CONVERT(VARCHAR(5),@Orders))) ELSE LTRIM(RTRIM(CONVERT(VARCHAR(5),@Orders)))  END


--select @OrderNum
--Kiem tra customize cho CSG
DECLARE @AP4444 TABLE(CustomerName INT, Export INT)
DECLARE	@SalaryTable TABLE (Salary DECIMAL(28,8))

Insert Into @AP4444(CustomerName,Export) EXEC('AP4444')

SELECT @OtherDayPerMonth = IsNull(OtherDayPerMonth , 0)
FROM HT0000
WHERE DivisionID = @DivisionID

---------------- Xử lý lương công nhật 'P01' ----------------------
IF(@MethodID = 'P01')
BEGIN
	IF(@IsIncome = 1)
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

	SELECT HT34.DivisionID, HT34.TransactionID, HT34.EmployeeID, HT34.DepartmentID, HT34.TeamID, HV54.GeneralCo, HV54.AbsentAmount,
		HV54.BaseSalary, HT34.IsOtherDayPerMonth,
		@ConditionCode AS ConditionCode,
		@IsCondition AS IsCondition,
		Convert(Decimal(28,8),0) AS Income
	INTO #HP5101_HT3400
	FROM HT3400 HT34
	LEFT JOIN HT3444 HV54 ON HT34.EmployeeID = HV54.EmployeeID AND HT34.DivisionID = HV54.DivisionID
		AND HT34.DepartmentID = HV54.DepartmentID AND isnull(HT34.TeamID , '') = isnull(HV54.TeamID , '') AND HT34.TranMonth = HV54.TranMonth AND HT34.TranYear = HV54.TranYear
	WHERE
	HT34.PayrollMethodID = @PayrollMethodID 
	AND HT34.TranMonth = @TranMonth 
	AND HT34.TranYear = @TranYear 
	AND HT34.DivisionID = @DivisionID 
	AND HT34.DepartmentID LIKE @DepartmentID1 
	AND ISNull(HT34.TeamID , '') LIKE ISNULL(@TeamID1 , '') 
	AND HT34.DepartmentID IN ( SELECT   DepartmentID
								FROM     HT5004
								WHERE    PayrollMethodID = @PayrollMethodID 
										AND DivisionID = @DivisionID )
	
	
	UPDATE T1
	SET		ConditionCode =  REPLACE(ConditionCode, 'If' , ' Case When ')
	FROM #HP5101_HT3400 T1
	WHERE	IsCondition = 1  and ISNULL(ConditionCode,'') <> ''

	UPDATE T1
	SET		ConditionCode =  REPLACE(ConditionCode , '@NC' , 'isnull(AbsentAmount , 0)')
	FROM #HP5101_HT3400 T1
	WHERE	IsCondition = 1 and ISNULL(ConditionCode,'''') <> ''''

	UPDATE T1
	SET		ConditionCode =  REPLACE(ConditionCode , '@HSC' , 'isnull(GeneralCo , 0)')
	FROM #HP5101_HT3400 T1
	WHERE	IsCondition = 1 and ISNULL(ConditionCode,'') <> ''

	UPDATE T1
	SET		ConditionCode =  REPLACE(ConditionCode , '@LCB' , 'isnull(BaseSalary , 0)')
	FROM #HP5101_HT3400 T1
	WHERE	IsCondition = 1 and ISNULL(ConditionCode,'') <> ''

	UPDATE T1
	SET		Income =  CASE WHEN isnull(@AbsentAmount , 0) = 0 THEN 0
					  ELSE isnull(BaseSalary , 0) * isnull(GeneralCo , 1) * isnull(AbsentAmount , 0) * isnull(@ExchangeRate , 1) / @AbsentAmount END
	FROM #HP5101_HT3400 T1
	WHERE	IsCondition = 0 

	UPDATE T1
	SET		Income =  0
	FROM #HP5101_HT3400 T1
	WHERE	IsCondition = 1 and ISNULL(ConditionCode,'') = ''

	
DECLARE	@curHP5101 cursor ,
		@cConditionCode NVARCHAR(max) = '',
		@sSQLCondition NVARCHAR(max) = ''

--SET @sSQLCondition = N'
--		UPDATE T1
--		SET		InCome = '+@ConditionCode+'
--		FROM #HP5103_HT3400 T1
--		WHERE	IsCondition = 1 and ConditionCode = '''+@ConditionCode+'''

--		'


	Set @curHP5101 =  cursor static for 
		Select	distinct ConditionCode
		From	#HP5101_HT3400
		WHERE	IsCondition = 1 and ISNULL(ConditionCode,'') <> ''
		Open @curHP5101
	
		Fetch Next From @curHP5101 Into @cConditionCode
		While @@Fetch_Status = 0
		Begin
			SET @sSQLCondition = @sSQLCondition+ N'
			UPDATE T1
			SET		InCome = '+@cConditionCode+'
			FROM #HP5101_HT3400 T1
			WHERE	IsCondition = 1 and ConditionCode = '''+@cConditionCode+'''

			'
			--EXEC (@sSQLCondition)
		Fetch Next From @curHP5101 Into @cConditionCode
		End
		Close @curHP5101	
		
		IF @Orders <= 30 AND @IsIncome = 1
		BEGIN
			SET @sSQl = '				
				UPDATE T1 
				SET T1.Income'+@OrderNum+' = T2.Income, 
					IGAbsentAmount'+@OrderNum+' = T2.AbsentAmount
				FROM HT3400 T1
				INNER JOIN #HP5101_HT3400 T2 ON T1.DivisionID = T2.DivisionID AND T1.TransactionID = T2.TransactionID
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
				INNER JOIN #HP5101_HT3400 T2 ON T1.DivisionID = T2.DivisionID AND T1.TransactionID = T2.TransactionID
				WHERE  T1.DivisionID = '''+@DivisionID +'''
				AND T1.PayrollMethodID = '''+ISNULL(@PayrollMethodID ,'')+'''
				AND T1.TranMonth = '+STR(@TranMonth)+' AND T1.TranYear = '+STR(@TranYear )+'		
			'
		END
			
		IF @Orders > 30 AND @IsIncome = 1   --MEIKO
		BEGIN
			SET @sSQl = '				
			UPDATE T1 
			SET Income'+@OrderNum+' = T2.Income
			FROM HT3499 T1
			INNER JOIN #HP5101_HT3400 T2 ON T1.DivisionID = T2.DivisionID AND T1.TransactionID = T2.TransactionID
			WHERE T1.DivisionID = '''+@DivisionID+''' 		
			'
		END
			
		IF @Orders > 20 AND @Orders <= 100 AND @IsIncome <> 1  
		BEGIN
			SET @sSQl = '
			UPDATE T1 
			SET SubAmount'+@OrderNum+' =  T2.Income
			FROM HT3499 T1
			INNER JOIN #HP5101_HT3400 T2 ON T1.DivisionID = T2.DivisionID AND T1.TransactionID = T2.TransactionID
			WHERE T1.DivisionID = '''+@DivisionID+''' 	
			'
		END
		--PRINT (@sSQLCondition)
		--PRINT (@sSQl)
		EXEC (@sSQLCondition+@sSQl)
END

ELSE
IF (@MethodID in ('P04','P05') )
BEGIN
	SET @Emp_cur = CURSOR SCROLL KEYSET FOR
	SELECT HT34.TransactionID, HT34.EmployeeID, HT34.DepartmentID, HT34.TeamID, HV54.GeneralCo, HV54.AbsentAmount,
		HV54.BaseSalary, HT34.IsOtherDayPerMonth
	FROM HT3400 HT34
	LEFT JOIN HT3444 HV54 ON HT34.EmployeeID = HV54.EmployeeID AND HT34.DivisionID = HV54.DivisionID
		AND HT34.DepartmentID = HV54.DepartmentID AND isnull(HT34.TeamID , '') = isnull(HV54.TeamID , '') AND HT34.TranMonth = HV54.TranMonth AND HT34.TranYear = HV54.TranYear
	WHERE
	HT34.PayrollMethodID = @PayrollMethodID 
	AND HT34.TranMonth = @TranMonth 
	AND HT34.TranYear = @TranYear 
	AND HT34.DivisionID = @DivisionID 
	AND HT34.DepartmentID LIKE @DepartmentID1 
	AND ISNull(HT34.TeamID , '') LIKE ISNULL(@TeamID1 , '') 
	AND HT34.DepartmentID IN ( SELECT   DepartmentID
								FROM     HT5004
								WHERE    PayrollMethodID = @PayrollMethodID 
										AND DivisionID = @DivisionID )


	OPEN @Emp_cur
	FETCH NEXT FROM @Emp_cur INTO @TransactionID,@EmployeeID,@DepartmentID,@TeamID,@CoValues,@AbsentValues,@BaseSalary,@IsOtherDayPerMonth

	WHILE @@FETCH_STATUS = 0
		  BEGIN      	
				SET @SalaryAmount = 0                        
				If @MethodID = 'P04'------- Phương pháp chỉ định
				BEGIN
					IF (SELECT CustomerName From @AP4444) = 19 --- Cảng sài gòn
						BEGIN						
							SET @BaseSalary = ISNULL((	SELECT	SUM(ISNULL(D.ProductAmount,0)) AS ProductSalary 
														FROM	HT0324 M 
														INNER JOIN HT0325 D 
															ON M.DivisionID = D.DivisionID 
															AND M.ResultAPK = D.ResultAPK 
														WHERE M.TranMonth = @TranMonth 
																AND M.TranYear = @TranYear 
																AND M.DivisionID = @DivisionID 
																AND D.EmployeeID = @EmployeeID),0)	
						END										
												   
					ELSE
						BEGIN
							IF NOT EXISTS (SELECT TOP 1 1 FROM HT0287 WHERE DivisionID = @DivisionID 
               															AND TranMonth = @TranMonth 
               															AND TranYear = @TranYear
																		AND DepartmentID = @DepartmentID)
							SET @BaseSalary = ISNULL((SELECT SUM(ISNULL(HT2403.quantity,0)* ISNULL(HT1015.unitprice,0)) as ProductSalary 
									FROM HT2403 
									INNER JOIN HT1015 ON HT2403.ProductID=HT1015.ProductID and HT2403.DivisionID=HT1015.DivisionID 
									WHERE TranMonth=@TranMonth and TranYear=@TranYear and HT2403.DivisionID=@DivisionID and EmployeeID = @EmployeeID),0)
							ELSE
							---------- Theo ca
							--- Có chấm công ca
							IF EXISTS (SELECT TOP 1 1 FROM HT0284 WHERE DivisionID = @DivisionID 
               															AND TranMonth = @TranMonth 
               															AND TranYear = @TranYear
																		AND DepartmentID = @DepartmentID
																		AND EmployeeID = @EmployeeID
																		)
								SET @BaseSalary = ISNULL((SELECT SUM(ISNULL(HT2403.quantity,0)* ISNULL(HT1015.UnitPrice,0)) as ProductSalary 
										FROM HT0287 HT2403 
										INNER JOIN HT1015 ON HT2403.ProductID=HT1015.ProductID 
														and HT2403.DivisionID=HT1015.DivisionID 
										INNER JOIN HT0284 ON HT0284.DivisionID = HT1015.DivisionID
														AND HT0284.AbsentDate = HT2403.TrackingDate
														AND HT0284.ShiftID = HT2403.ShiftID
														AND HT0284.EmployeeID = HT2403.EmployeeID
												
										WHERE HT2403.TranMonth=@TranMonth 
												and HT2403.TranYear=@TranYear 
												and HT2403.DivisionID=@DivisionID 
												and HT2403.EmployeeID = @EmployeeID	
												AND HT0284.AbsentDate = HT2403.TrackingDate
												AND HT0284.ShiftID = HT2403.ShiftID
												AND HT0284.EmployeeID = HT2403.EmployeeID 
												AND AbsentTypeID In (SELECT AbsentTypeID ----- Check vao ngay cong tong hop
																	 FROM	HT5003 
																	 WHERE	DivisionID = @DivisionID 
																			AND GeneralAbsentID = @GeneralAbsentID)
												),0)
							ELSE --- Không chấm công ca
								SET @BaseSalary = ISNULL((SELECT SUM(ISNULL(HT2403.quantity,0)* ISNULL(HT1015.UnitPrice,0)) as ProductSalary 
										FROM HT0287 HT2403 
										INNER JOIN HT1015 ON HT2403.ProductID=HT1015.ProductID 
														and HT2403.DivisionID=HT1015.DivisionID												
										WHERE HT2403.TranMonth=@TranMonth 
												and HT2403.TranYear=@TranYear 
												and HT2403.DivisionID=@DivisionID 
												and HT2403.EmployeeID = @EmployeeID
												),0)
						END
					
				END	--- @MethodID = 'P04'------- Phương pháp chỉ định
			
				IF @MethodID = 'P05'------Phương pháp phân bổ
				BEGIN
				IF NOT EXISTS (SELECT TOP 1 1 FROM HT0289 WHERE DivisionID = @DivisionID 
               														AND TranMonth = @TranMonth 
               														AND TranYear = @TranYear
																	AND DepartmentID = @DepartmentID)
				BEGIN
					Set @BaseSalary = ISNULL((	SELECT SUM(ISNULL((CASE WHEN Total = 0 THEN 0 ELSE AbsentHour*Coefficient*TeamAmount/Total END),0))
												FROM HT2414 
												INNER JOIN (SELECT TeamID,AbsentDate, Sum(AbsentHour*Coefficient) AS Total 
															FROM HT2414
															WHERE DivisionID = @DivisionID 
															And TranMonth = @TranMonth 
															And TranYear = @TranYear 
															GROUP BY TeamID,AbsentDate
															) TeamTotal
													ON HT2414.TeamID = TeamTotal.TeamID 
													AND HT2414.AbsentDate = TeamTotal.AbsentDate
												WHERE DivisionID = @DivisionID 
												And TranMonth = @TranMonth 
												And TranYear = @TranYear 
												And EmployeeID = @EmployeeID
											),0)	
				END
				ELSE
				BEGIN
					SET @BaseSalary = ISNULL((SELECT SUM(PersonAmount) 
											 FROM HT2415 
											 WHERE DivisionID = @DivisionID 
												And TranMonth = @TranMonth 
												And TranYear = @TranYear 
												And EmployeeID = @EmployeeID),0)
				END
				
			
				END ----@MethodID = 'P05'------Phương pháp phân bổ
							
				IF @IsIncome = 1
					BEGIN
            			SELECT @IsCondition = IsCondition, @ConditionCode = ConditionCode
            			FROM HT5005
            			WHERE DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND --CAST(RIGHT(IncomeID, 2) AS INT)
						CONVERT(INT,STUFF(IncomeID,1,1,''))   = @Orders
                
						IF @IsCondition = 0
							BEGIN
                				SET @SalaryAmount = CASE WHEN ISNULL(@AbsentAmount, 0) = 0 THEN 0
														 ELSE ISNULL(@BaseSalary, 0) * ISNULL(@CoValues, 1) * ISNULL(@AbsentValues, 0) * ISNULL(@ExchangeRate, 1) / @AbsentAmount END
                                       
							END
						ELSE
							BEGIN
								IF @ConditionCode IS NULL OR @ConditionCode = ''
									BEGIN
										SET @SalaryAmount = 0
									END
								 ELSE
								 BEGIN								
							 		---- Thay thế sinh view bằng cách sử dụng biến bảng
							 		DELETE @SalaryTable
							 		SET @ConditionCode = REPLACE(@ConditionCode, 'If', ' CASE WHEN ')
									SET @ConditionCode = REPLACE(@ConditionCode, '@NC', ISNULL(@AbsentValues, 0))
									SET @ConditionCode = REPLACE(@ConditionCode, '@HSC', ISNULL(@CoValues , 1))
									SET @ConditionCode = REPLACE(@ConditionCode, '@LCB', ISNULL(@BaseSalary , 0))
							 		INSERT INTO @SalaryTable (Salary) EXEC('SELECT '+@ConditionCode+'')
							 		SET @SalaryAmount = (SELECT TOP 1 Salary FROM @SalaryTable)
									---------- EXEC HP5555 @AbsentValues , @CoValues , @BaseSalary , @ConditionCode , @SalaryAmount OUTPUT
								
									--select 'aaa', @TransactionID, * from @SalaryTable
								END
							END
					   END
				ELSE
					BEGIN
						 SELECT @IsCondition = IsCondition, @ConditionCode = ConditionCode FROM HT5006
						 WHERE DivisionID = @DivisionID and PayrollMethodID = @PayrollMethodID AND --CAST(RIGHT(SubID , 2) AS INT) 
							   CONVERT(INT,STUFF(SubID,1,1,''))  = @Orders
                     
						 IF @IsCondition = 0
						 BEGIN                     			
							SET @SalaryAmount = CASE WHEN ISNULL(@AbsentAmount, 0) = 0 THEN 0
													 ELSE ISNULL(@BaseSalary, 0) * ISNULL(@CoValues, 1) * ISNULL(@AbsentValues, 0) * ISNULL(@ExchangeRate, 1) / @AbsentAmount END
						 END
						 ELSE
							BEGIN
								IF (@ConditionCode IS NULL OR @ConditionCode = '') SET @SalaryAmount = 0
								ELSE
								BEGIN
									DELETE @SalaryTable
							 		SET @ConditionCode = REPLACE(@ConditionCode, 'If', ' CASE WHEN ')
									SET @ConditionCode = REPLACE(@ConditionCode, '@NC', ISNULL(@AbsentValues, 0))
									SET @ConditionCode = REPLACE(@ConditionCode, '@HSC', ISNULL(@CoValues , 1))
									SET @ConditionCode = REPLACE(@ConditionCode, '@LCB', ISNULL(@BaseSalary , 0))
							 		INSERT INTO @SalaryTable (Salary) EXEC('SELECT '+@ConditionCode+'')
							 		SET @SalaryAmount = (SELECT TOP 1 Salary FROM @SalaryTable)
							 		------- EXEC HP5555 @AbsentValues, @CoValues, @BaseSalary, @ConditionCode, @SalaryAmount OUTPUT
								END							
						   END
		  END
               
				--Rem by Dang Le Bao Quynh
				--Purpose: Khong hieu muc dich cua viec kiem tra so ngay quy dinh @AbsentAmount > 20 and @AbsentAmount <32 ???????????
				--Set @SalaryAmount = case when isnull(@AbsentAmount, 0) = 0 then 0 else isnull(@BaseSalary,0)*isnull( @CoValues,1)*isnull(@AbsentValues,0)* isnull(@ExchangeRate,1)/ case  When  @AbsentAmount > 20 and @AbsentAmount <32 Then   Case When IsNull(@IsOtherDayPerMonth,0) =0 Then  @AbsentAmount    Else  @OtherDayPerMonth  End    Else  @AbsentAmount  End     End
			
				--Edit by Dang Le Bao Quynh; 28/03/2013: Viet lai cau lenh update tuong ung voi tung column, thay vi update hang loat nhu truoc.

			

				IF @Orders <= 30 AND @IsIncome = 1
				BEGIN
					SET @sSQl = '				
						UPDATE HT3400 
						SET Income'+@OrderNum+' = '+CONVERT(VARCHAR(50),@SalaryAmount)+', IGAbsentAmount'+@OrderNum+' = '+CONVERT(VARCHAR(50),ISNULL(@AbsentValues , 0))+'
						WHERE DivisionID = '''+@DivisionID+''' 

						AND PayrollMethodID = '''+ISNULL(@PayrollMethodID,'')+''' 
						AND TransactionID = '''+@TransactionID+'''
					'
				END
				IF @Orders <= 20 AND @IsIncome <> 1
				BEGIN
					SET @sSQl = ' 
						UPDATE HT3400 
						SET SubAmount'+@OrderNum+' = '+CONVERT(VARCHAR(50),@SalaryAmount)+'
						WHERE DivisionID = '''+@DivisionID+''' 
						AND PayrollMethodID = '''+ISNULL(@PayrollMethodID,'')+''' 
						AND TransactionID = '''+@TransactionID+'''
					'
				END
				IF @Orders > 30 AND @IsIncome = 1  
				BEGIN
					SET @sSQl = '				
						UPDATE HT3499 
						SET Income'+@OrderNum+' = '+CONVERT(VARCHAR(50),@SalaryAmount)+'
						WHERE DivisionID = '''+@DivisionID+''' 
						AND TransactionID = '''+@TransactionID+'''				
					'
				END
			
				IF @Orders > 20 AND @Orders <= 100 AND @IsIncome <> 1 
				BEGIN
					SET @sSQl = '	
					UPDATE HT3499 
					SET SubAmount'+@OrderNum+' = '+CONVERT(VARCHAR(50),@SalaryAmount)+'
					WHERE DivisionID = '''+@DivisionID+''' 				
					AND TransactionID = '''+@TransactionID+''' '
				END
				--PRINT ('hp5101'+ @sSQl)
				EXEC (@sSQl)			

				FETCH NEXT FROM @Emp_cur INTO @TransactionID,@EmployeeID,@DepartmentID,@TeamID,@CoValues,@AbsentValues,@BaseSalary,@IsOtherDayPerMonth
		  END

	CLOSE @Emp_cur
END
ELSE

--------------------------------------------------------------------------------
--Xu ly luong cong trinh
--Xu ly luong cong trinh
--------------------------------------------------------------------------------

DECLARE @ProjectID as nvarchar(50)

IF @MethodID = 'P06'
BEGIN

SET @Emp_cur = CURSOR SCROLL KEYSET FOR
	SELECT HT34.TransactionID, HT34.EmployeeID, HT34.DepartmentID, HT34.TeamID, HV54.GeneralCo, 
		HV54.AbsentAmount, HV54.BaseSalary, HT34.IsOtherDayPerMonth, HV54.ProjectID
	FROM HT3400 HT34
		LEFT JOIN HT344401 HV54 ON HT34.EmployeeID = HV54.EmployeeID AND HT34.DivisionID = HV54.DivisionID
			AND HT34.DepartmentID = HV54.DepartmentID AND isnull(HT34.TeamID , '') = isnull(HV54.TeamID , '')
			AND HT34.TranMonth = HV54.TranMonth AND HT34.TranYear = HV54.TranYear
	WHERE HT34.PayrollMethodID = @PayrollMethodID AND HT34.TranMonth = @TranMonth AND HT34.TranYear = @TranYear
		AND HT34.DivisionID = @DivisionID AND HT34.DepartmentID LIKE @DepartmentID1 AND ISNull(HT34.TeamID , '') LIKE ISNULL(@TeamID1 , '')
		AND HT34.DepartmentID IN ( SELECT DepartmentID FROM HT5004 WHERE PayrollMethodID = @PayrollMethodID And DivisionID = @DivisionID )
		AND HV54.ProjectID IS NOT NULL
                                                                                                                                                                                                                                                                                         
OPEN @Emp_cur
FETCH NEXT FROM @Emp_cur INTO @TransactionID,@EmployeeID,@DepartmentID,@TeamID,@CoValues,@AbsentValues,@BaseSalary,@IsOtherDayPerMonth, @ProjectID

WHILE @@FETCH_STATUS = 0
      BEGIN
            SET @SalaryAmount = 0
            If not exists (Select Top 1 1 From HT340001 Where DivisionID = @DivisionID And TransactionID = @TransactionID And ProjectID = @ProjectID)
			INSERT INTO HT340001 (DivisionID, TransactionID, ProjectID) Values (@DivisionID,@TransactionID,@ProjectID)
			 
			If not exists (Select Top 1 1 From HT340001_1 Where DivisionID = @DivisionID And TransactionID = @TransactionID And ProjectID = @ProjectID)
				INSERT INTO HT340001_1 (DivisionID, TransactionID, ProjectID) Values (@DivisionID,@TransactionID,@ProjectID)
			
			          
			IF @IsIncome = 1
               BEGIN
                     SELECT @IsCondition = IsCondition, @ConditionCode = ConditionCode FROM HT5005
                     WHERE DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND CAST(RIGHT(IncomeID , 2) AS INT) = @Orders
                     
                     IF @IsCondition = 0
						SET @SalaryAmount = CASE WHEN isnull(@AbsentAmount , 0) = 0 THEN 0
												 ELSE isnull(@BaseSalary , 0) * isnull(@CoValues , 1) * isnull(@AbsentValues , 0) * isnull(@ExchangeRate , 1) / @AbsentAmount END
                        
                     ELSE
                     BEGIN
						IF (@ConditionCode IS NULL OR @ConditionCode = '') SET @SalaryAmount = 0         
                        ELSE 
                            BEGIN
                            	DELETE @SalaryTable
							 	SET @ConditionCode = REPLACE(@ConditionCode, 'If', ' CASE WHEN ')
								SET @ConditionCode = REPLACE(@ConditionCode, '@NC', ISNULL(@AbsentValues, 0))
								SET @ConditionCode = REPLACE(@ConditionCode, '@HSC', ISNULL(@CoValues , 1))
								SET @ConditionCode = REPLACE(@ConditionCode, '@LCB', ISNULL(@BaseSalary , 0))
							 	INSERT INTO @SalaryTable (Salary) EXEC('SELECT '+@ConditionCode+'')
							 	SET @SalaryAmount = (SELECT TOP 1 Salary FROM @SalaryTable)
                                ----------- EXEC HP5555 @AbsentValues , @CoValues , @BaseSalary , @ConditionCode , @SalaryAmount OUTPUT
                            END
                        END
               END
            ELSE
               BEGIN
                     SELECT
                         @IsCondition = IsCondition ,
                         @ConditionCode = ConditionCode
                     FROM
                         HT5006
                     WHERE
                         DivisionID = @DivisionID and PayrollMethodID = @PayrollMethodID AND CAST(RIGHT(SubID , 2) AS int) = @Orders
                     IF @IsCondition = 0
                        BEGIN
       
						
                              SET @SalaryAmount = CASE
                                                       WHEN isnull(@AbsentAmount , 0) = 0 THEN 0
                                                       ELSE isnull(@BaseSalary , 0) * isnull(@CoValues , 1) * isnull(@AbsentValues , 0) * isnull(@ExchangeRate , 1) / @AbsentAmount
                                                  END
                        END
                     ELSE
                        BEGIN
                              IF @ConditionCode IS NULL OR @ConditionCode = ''
                                 BEGIN
                                       SET @SalaryAmount = 0
                                 END
                              ELSE
                                 BEGIN
                                 	DELETE @SalaryTable
							 		SET @ConditionCode = REPLACE(@ConditionCode, 'If', ' CASE WHEN ')
									SET @ConditionCode = REPLACE(@ConditionCode, '@NC', ISNULL(@AbsentValues, 0))
									SET @ConditionCode = REPLACE(@ConditionCode, '@HSC', ISNULL(@CoValues , 1))
									SET @ConditionCode = REPLACE(@ConditionCode, '@LCB', ISNULL(@BaseSalary , 0))
							 		INSERT INTO @SalaryTable (Salary) EXEC('SELECT '+@ConditionCode+'')
							 		SET @SalaryAmount = (SELECT TOP 1 Salary FROM @SalaryTable)
                                    ---------	EXEC HP5555 @AbsentValues , @CoValues , @BaseSalary , @ConditionCode , @SalaryAmount OUTPUT
                                 END
                        END
               END

			IF @Orders <= 30 AND @IsIncome = 1
			BEGIN
				SET @sSQl = '				
					UPDATE HT340001 
					SET Income'+@OrderNum+' = '+CONVERT(VARCHAR(50),@SalaryAmount)+', IGAbsentAmount'+@OrderNum+' = '+CONVERT(VARCHAR(50),ISNULL(@AbsentValues , 0))+'
					WHERE DivisionID = '''+@DivisionID+''' AND ProjectID = '''+@ProjectID+''' AND TransactionID = '''+@TransactionID+'''
			'
			END
			IF @Orders <= 20 AND @IsIncome <> 1
			BEGIN
				SET @sSQl = '
					UPDATE HT340001 
					SET SubAmount'+@OrderNum+' = '+CONVERT(VARCHAR(50),@SalaryAmount)+'
					WHERE DivisionID = '''+@DivisionID+''' AND ProjectID = '''+@ProjectID+''' AND TransactionID = '''+@TransactionID+'''
				'
			END
			
			IF @Orders > 30 AND @IsIncome = 1 	
			BEGIN
				SET @sSQl = '				
					UPDATE HT340001_1 
					SET Income'+@OrderNum+' = '+CONVERT(VARCHAR(50),@SalaryAmount)+'
					WHERE DivisionID = '''+@DivisionID+''' AND ProjectID = '''+@ProjectID+''' AND TransactionID = '''+@TransactionID+'''
					'
			END

			IF @Orders > 20 AND @Orders <= 100 AND @IsIncome <> 1 
			BEGIN
				SET @sSQl = '	
					UPDATE HT340001_1 
					SET SubAmount'+@OrderNum+' = '+CONVERT(VARCHAR(50),@SalaryAmount)+'
					WHERE DivisionID = '''+@DivisionID+''' AND ProjectID = '''+@ProjectID+''' AND TransactionID = '''+@TransactionID+'''
				'
			END

			--PRINT (@sSQl)
			EXEC (@sSQl)            
		
            FETCH NEXT FROM @Emp_cur INTO @TransactionID,@EmployeeID,@DepartmentID,@TeamID,@CoValues,@AbsentValues,@BaseSalary,@IsOtherDayPerMonth, @ProjectID
      END

CLOSE @Emp_cur



--Cap nhat thu nhap tong

IF @Orders <= 30 
BEGIN
	SET @sSQl = '
		UPDATE M SET M.Income'+@OrderNum+' = (Select Isnull(Sum(Isnull(D.Income'+@OrderNum+',0)),0) From HT340001 D Where D.TransactionID = M.TransactionID)
		FROM HT3400 M 
		WHERE	M.DivisionID = '''+@DivisionID+''' AND M.PayrollMethodID = '''+ISNULL(@PayrollMethodID,'')+''' AND '+STR(@IsIncome)+' = 1 AND
				M.TranMonth = '+STR(@TranMonth)+' AND M.TranYear = '+STR(@TranYear)+' AND 
				M.DepartmentID LIKE '''+@DepartmentID1+''' AND ISNull(M.TeamID , '''') LIKE '''+ISNULL(@TeamID1 , '')+'''
	'
END
ELSE IF @Orders > 30 
BEGIN
	SET @sSQl = '
	UPDATE M SET M.Income'+@OrderNum+' = (Select Isnull(Sum(Isnull(D.Income'+@OrderNum+',0)),0) From HT340001_1 D Where D.TransactionID = M.TransactionID)
	FROM HT3499 M
	WHERE M.TransactionID IN 
	(SELECT  HT34.TransactionID FROM HT34
	 WHERE	HT34.DivisionID = '''+@DivisionID+''' AND HT34.PayrollMethodID = '''+ISNULL(@PayrollMethodID,'')+''' AND '+STR(@IsIncome)+' = 1 AND
			HT34.TranMonth = '+STR(@TranMonth)+' AND HT34.TranYear = '+STR(@TranYear)+' AND 
			HT34.DepartmentID LIKE '''+@DepartmentID1+''' AND ISNull(HT34.TeamID , '''') LIKE '''+ISNULL(@TeamID1 , '')+'''
	'
END

--PRINT (@sSQl)
EXEC (@sSQl)

END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
