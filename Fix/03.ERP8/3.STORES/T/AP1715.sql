IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1715]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1715]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Tính các khoản trả khác
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Kiều Nga, Date: 17/05/2021 
----Update by: Kiều Nga, Date: 26/10/2021  Fix lỗi phân bổ khoản phí nhà ở xã hội không đúng kỳ theo ngày đăng ký
----Update by: Kiều Nga, Date: 13/01/2022  Fix lỗi Số tiển các khoản chi phí quỷ CEP chuyển sang hệ số bên hồ sơ lương không đúng trướng hợp có vay 2 khoản trở lên cùng 1 nhân viên.

/*-- <Example>
		exec AP1715 @DivisionID=N'MT',@UserID ='ASOFTADMIN',@TranMonth=4,@TranYear=2021,@Mode=1
----*/
CREATE PROCEDURE [dbo].[AP1715]  
	@DivisionID nvarchar(50),
	@UserID nvarchar(50),
    @TranMonth as int,  
    @TranYear as int,  
    @Mode as tinyint 
 AS  

Declare
   @TableCur CURSOR,
   @Type VARCHAR(50),   
   @EmployeeID VARCHAR(50),
   @DepartmentID VARCHAR(50),
   @ApportionID VARCHAR(50),
   @InterestPay DECIMAL(28,8),
   @ConvertedAmount DECIMAL(28,8),
   @Amount DECIMAL(28,8),
   @DepValue DECIMAL(28,8) = 0,
   @DepMonths INT = 0,
   @ResidualValue DECIMAL(28,8) = 0,
   @ResidualMonths INT = 0,
   @BeginMonth INT,
   @BeginYear INT,
   @Periods INT,
   @C24 DECIMAL(28,8) =0,
   @C25 DECIMAL(28,8) =0,
   @C26 DECIMAL(28,8) =0,
   @C27 DECIMAL(28,8) =0

   -- Lấy thông tin khai báo phân bổ chi phí khác ---
	SELECT M1.APK, M1.DivisionID,M1.[Type], M1.EmployeeID,M1.DepartmentID,M1.ApportionID,M1.BeginMonth,M1.BeginYear,
	CASE WHEN M1.[Type] = 1 OR M1.[Type] = 2 THEN M1.Amount ELSE M1.ConvertedAmount END AS Amount,M1.[Periods],M1.ConvertedAmount,ISNULL(M1.ResidualMonths,0) ResidualMonths
	,ISNULL(M1.ResidualValue,0) ResidualValue, ISNULL(M1.InterestPay,0) InterestPay
	INTO #AP1715
	FROM AT0412 M1 WITH (NOLOCK)
	WHERE DivisionID = @DivisionID 
	AND (((M1.[Type] = 1 OR M1.[Type] = 2) AND M1.StatusApportion = 1 AND ((@Mode = 1 AND (ISNULL(M1.Periods,0) - ISNULL(M1.DepMonths ,0)) > 0) OR @Mode = 0) AND ((M1.BeginMonth <= @TranMonth AND M1.BeginYear = @TranYear) OR  M1.BeginYear < @TranYear)) 
	     OR (M1.[Type] = 3 AND IsRegistration=1 AND ((Month(M1.ApportionDate) <= @TranMonth AND Year(M1.ApportionDate) = @TranYear) OR Year(M1.ApportionDate) < @TranYear)))

	select * from #AP1715

   IF(@Mode = 1) -- Tính chi phí
   BEGIN
	  SET @TableCur = CURSOR SCROLL KEYSET FOR
	  SELECT M1.[Type],M1.EmployeeID,M1.DepartmentID,M1.ApportionID,M1.Amount,M1.[Periods],M1.ConvertedAmount,M1.ResidualMonths,M1.ResidualValue,M1.InterestPay
	  FROM #AP1715 M1 WITH (NOLOCK)

	  SELECT EmployeeID ,0 as C24, 0 as C25,0 as C27
	  INTO #ListEmployeeID
	  FROM #AP1715
	  GROUP BY EmployeeID

	  OPEN @TableCur
	  FETCH NEXT FROM @TableCur INTO @Type,@EmployeeID,@DepartmentID,@ApportionID,@Amount,@Periods,@ConvertedAmount,@ResidualMonths,@ResidualValue,@InterestPay
	  WHILE @@FETCH_STATUS = 0
	  BEGIN	
		  DECLARE @Period VARCHAR(50)=''
		  SET @Period = (CASE WHEN @TranMonth <10 THEN '0' +LTRIM(STR(@TranMonth))+ '/'+ LTRIM(STR(@TranYear)) ELSE LTRIM(STR(@TranMonth))+ '/'+ LTRIM(STR(@TranYear)) END)

		  -- Kỳ phân bổ cuối cùng 
		  IF(@ResidualMonths = 1 AND @ResidualValue >0)
			 SET @Amount =(CASE WHEN @Type ='1' THEN @ResidualValue ELSE @ResidualValue + @InterestPay END);
	    
		  -- Thêm mới khoản chi phí khác vào AT0415 ---
		  INSERT INTO AT0415(DivisionID,TranMonth,TranYear,[Period],[Type],EmployeeID,ApportionID,DepartmentID,ConvertedAmount,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate)
		  VALUES (@DivisionID,@TranMonth,@TranYear,@Period,@Type,@EmployeeID,@ApportionID,@DepartmentID,@Amount,@UserID,GETDATE(),@UserID,GETDATE())

		  -- Cập nhật khai báo phân bổ ---
		  IF(@Type ='1' OR @Type ='2')
		  BEGIN
			 SET @DepValue = (SELECT ISNULL(SUM(ConvertedAmount),0) FROM AT0415 WITH (NOLOCK) WHERE ApportionID = @ApportionID AND DivisionID = @DivisionID)
			 SET @DepMonths = (SELECT Count(*) FROM AT0415 WITH (NOLOCK) WHERE ApportionID = @ApportionID AND DivisionID = @DivisionID)
			 SET @ResidualMonths = @Periods - @DepMonths;
			 SET @DepValue = (CASE WHEN @Type ='1' THEN @DepValue ELSE @DepValue - @DepMonths * @InterestPay END);
			 SET @ResidualValue = @ConvertedAmount - @DepValue;

			 UPDATE AT0412
			 SET DepValue = @DepValue,
				 DepMonths = @DepMonths,
				 ResidualMonths = @ResidualMonths,
				 ResidualValue = @ResidualValue
			 WHERE ApportionID = @ApportionID AND DivisionID= @DivisionID

		  END

		  -- Kết chuyển qua hồ sơ lương ----
		 IF(@Type='1')
			BEGIN
				UPDATE #ListEmployeeID
				SET C24 = C24 + @Amount
				WHERE EmployeeID= @EmployeeID
			END
		  ELSE IF(@Type='2')
			BEGIN
				UPDATE #ListEmployeeID
				SET C27 = C27 + @Amount
				WHERE EmployeeID= @EmployeeID
			END
		  ELSE IF(@Type='3')
			BEGIN
				UPDATE #ListEmployeeID
				SET C25 = C25 + @Amount
				WHERE EmployeeID= @EmployeeID
			END

	  FETCH NEXT FROM @TableCur INTO @Type,@EmployeeID,@DepartmentID,@ApportionID,@Amount,@Periods,@ConvertedAmount,@ResidualMonths,@ResidualValue,@InterestPay
	  END	
	  CLOSE @TableCur

	  -- Xử lý kết chuyển qua hồ sơ lương ----
		UPDATE HT2400
		SET C24 = T1.C24,
		C25 = T1.C25
		FROM HT2400 T
		INNER JOIN #ListEmployeeID T1 ON T.EmployeeID= T.EmployeeID 
		WHERE DivisionID= @DivisionID
		AND TranMonth = @TranMonth AND TranYear= @TranYear

		UPDATE HT2499
		SET C27 = T1.C27
		FROM HT2499 T
		INNER JOIN #ListEmployeeID T1 ON T.EmployeeID= T.EmployeeID 
		WHERE DivisionID= @DivisionID
		AND TranMonth = @TranMonth AND TranYear= @TranYear
	-------------------------------------------

   END
   ELSE IF (@Mode = 0) -- Bỏ chi phí
   BEGIN
     --- Xóa khoản chi phí khác vào AT0415 ---
    DELETE FROM AT0415 WHERE DivisionID= @DivisionID AND TranMonth = @TranMonth AND TranYear= @TranYear

	SET @TableCur = CURSOR SCROLL KEYSET FOR
	SELECT M1.[Type],M1.EmployeeID,M1.DepartmentID,M1.ApportionID,M1.Amount,M1.[Periods],M1.ConvertedAmount,M1.ResidualMonths,M1.ResidualValue,M1.InterestPay
	FROM #AP1715 M1 WITH (NOLOCK)

	OPEN @TableCur
	FETCH NEXT FROM @TableCur INTO @Type,@EmployeeID,@DepartmentID,@ApportionID,@Amount,@Periods,@ConvertedAmount,@ResidualMonths,@ResidualValue,@InterestPay
	WHILE @@FETCH_STATUS = 0
	BEGIN	
		 -- Cập nhật khai báo phân bổ ---
		 IF(@Type ='1' OR @Type ='2')
		 BEGIN
			 SET @DepValue = (SELECT ISNULL(SUM(ConvertedAmount),0) FROM AT0415 WITH (NOLOCK) WHERE ApportionID = @ApportionID AND DivisionID = @DivisionID)
			 SET @DepMonths = (SELECT Count(*) FROM AT0415 WITH (NOLOCK) WHERE ApportionID = @ApportionID AND DivisionID = @DivisionID)
			 SET @ResidualMonths = @Periods - @DepMonths;
			 SET @DepValue = (CASE WHEN @Type ='1' THEN @DepValue ELSE @DepValue - @DepMonths * @InterestPay END);
			 SET @ResidualValue = @ConvertedAmount - @DepValue;

			 UPDATE AT0412
			 SET DepValue = @DepValue,
				 DepMonths = @DepMonths,
				 ResidualMonths = @ResidualMonths,
				 ResidualValue = @ResidualValue
			 WHERE ApportionID = @ApportionID AND DivisionID= @DivisionID
		  END

		 -- Kết chuyển qua hồ sơ lương ----
		 IF(@Type='1' OR @Type='3')
		  BEGIN
			  UPDATE HT2400
			  SET C24 = @C24,
				  C25=@C25
			  WHERE EmployeeID= @EmployeeID AND DivisionID= @DivisionID
			  AND TranMonth = @TranMonth AND TranYear= @TranYear
		  END
		  ELSE IF(@Type='2')
		  BEGIN
			  UPDATE HT2499
			  SET C26 =@C26,
				  C27=@C27
			  WHERE EmployeeID= @EmployeeID AND DivisionID= @DivisionID
			  AND TranMonth = @TranMonth AND TranYear= @TranYear
		  END
	FETCH NEXT FROM @TableCur INTO @Type,@EmployeeID,@DepartmentID,@ApportionID,@Amount,@Periods,@ConvertedAmount,@ResidualMonths,@ResidualValue,@InterestPay
	END	
	CLOSE @TableCur
   END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
