IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[HP0500]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP0500]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Tra cứu khoản mục lương
-- <Param>
---- 
-- <Return>
---- 
-- <Reference> 
---- ASOFT-HRM/Nghiệp vụ/Tính lương/Tra cứu khoản mục lương - HF0500
-- <History>
---- Create on 17/07/2017 by Phương Thảo
---- Modified on 17/07/2017 by Phương Thảo
---- Modified on 08/09/2020 by Văn Tài : Move qua từ source MEIKO.
-- <Example>
---- exec HP0500 'mk', 3, 2017, '002904', 'I42', 0
---- exec HP0500 'mk', 3, 2017, '002904', 'I42', 1
---- exec HP0500 'mk', 3, 2017, '002904', 'I42', 2
  
CREATE PROCEDURE [dbo].[HP0500]
    @DivisionID NVarchar(50), 
    @TranMonth Int, 
    @TranYear Int, 	
	@EmployeeID NVarchar(50),
	@CriteriaID NVarchar(50),
	@Mode Int -- 0: Master, 1: Grid1, 2: Grid2
      
 AS  

 DECLARE @PayrollMethodID Varchar(50),
		 @GeneralCoID AS nvarchar(50),
		 @GeneralAbsentID AS nvarchar(50),
		 @MethodID AS nvarchar(50),
		 @BaseSalaryField  AS nvarchar(50),
		 @BaseSalary AS decimal (28,8),
		 @sSQL01 NVarchar(4000) = '',
		 @CustomerIndex INT,
		 @OrderNum Varchar(20) = '',
		 @TimeConvert AS decimal(28,8) 

 DECLARE @curHP0500_Coefficient CURSOR,
		 @C01ID VARCHAR(20), 
		 @C02ID VARCHAR(20), 
		 @C03ID VARCHAR(20), 
		 @C04ID VARCHAR(20), 
		 @C05ID VARCHAR(20),
		 @CoefficientID VARCHAR(20),
		 @CoefficientName NVARCHAR(250),
		 @Type INT,
		 @IsMonth INT		

SELECT @PayrollMethodID = PayrollMethodID
FROM	HT3400
WHERE EmployeeID = @EmployeeID AND TranMonth = @TranMonth AND TranYear = @TranYear

SELECT TOP 1 @CustomerIndex = CustomerName
FROM CustomerIndex


SELECT	@TimeConvert = TimeConvert
FROM    HT0000

 
SELECT @OrderNum = CASE WHEN CONVERT(INT,STUFF(@CriteriaID,1,1,'')) <10 
				THEN LTRIM(RTRIM('0'+CONVERT(VARCHAR(5),CONVERT(INT,STUFF(@CriteriaID,1,1,''))))) 
				ELSE LTRIM(RTRIM(CONVERT(VARCHAR(5),CONVERT(INT,STUFF(@CriteriaID,1,1,'')))))  END

CREATE TABLE #HP0500_1 (DivisionID Varchar(50), PayrollMethodID Varchar(50), PayrollMethodName NVarchar(250), ConditionCode NVarchar(250),
						MethodID Varchar(50), BaseSalaryField Varchar(50), BaseSalary decimal(28, 8),
						Amount decimal(28, 8), BaseSalaryName NVarchar(250), BaseSalaryAmount decimal(28, 8),
						GeneralCoID  Varchar(50), GeneralCoName NVarchar(250), GeneralCoAmount decimal(28, 8),
						GeneralAbsentID  Varchar(50), GeneralAbsentName NVarchar(250), GeneralAbsentAmount decimal(28, 8) )


IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N'tempdb.dbo.#HV5002')) 
	DROP TABLE #HV5002

IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N'tempdb.dbo.#HV5003')) 
	DROP TABLE #HV5003

CREATE TABLE #HV5002 (DivisionID nvarchar(50),
					ProjectID nvarchar(50),
					TranMonth int,
					TranYear int,
					EmployeeID nvarchar(50),
					DepartmentID nvarchar(50),
					BaseSalary decimal(28,8),
					TeamID nvarchar(50),
					GeneralCo decimal(28,8)
)

CREATE TABLE #HV5003 (DivisionID nvarchar(50),
					ProjectID nvarchar(50),
					TranMonth int,
					TranYear int,
					EmployeeID nvarchar(50),
					DepartmentID nvarchar(50),
					AbsentAmount decimal(28,8),
					TeamID nvarchar(50)
)


IF(LEFT(@CriteriaID,1) = 'I')
BEGIN	
	INSERT INTO #HP0500_1 
	SELECT	T1.DivisionID, T1.PayrollMethodID, T2.Description AS PayrollMethodName, T1.ConditionCode, 
			T1.MethodID, T1.BaseSalaryField, T1.BaseSalary,
			Convert(Decimal(28,8),0) AS Amount,
			Convert(NVarchar(250),'') AS BaseSalaryName, Convert(Decimal(28,8),0) AS BaseSalaryAmount,
			GeneralCoID, Convert(NVarchar(250),'') AS GeneralCoName, Convert(Decimal(28,8),0) AS GeneralCoAmount,
			GeneralAbsentID,  Convert(NVarchar(250),'') AS GeneralAbsentName, Convert(Decimal(28,8),0) AS GeneralAbsentAmount	
	FROM	HT5005 T1
	INNER JOIN HT5000 T2 ON T1.PayrollMethodID = T2.PayrollMethodID
	WHERE T1.PayrollMethodID = @PayrollMethodID AND IncomeID = @CriteriaID
	
END
ELSE
IF(LEFT(@CriteriaID,1) = 'S')
BEGIN	
	INSERT INTO #HP0500_1 						
	SELECT	T1.DivisionID,  T1.PayrollMethodID, T2.Description AS PayrollMethodName, T1.ConditionCode, 
			T1.MethodID, T1.BaseSalaryField, T1.BaseSalary,
			Convert(Decimal(28,8),0) AS Amount,
			Convert(NVarchar(250),'') AS BaseSalaryName, Convert(Decimal(28,8),0) AS BaseSalaryAmount,
			GeneralCoID,  Convert(NVarchar(250),'') AS GeneralCoName, Convert(Decimal(28,8),0) AS GeneralCoAmount,
			GeneralAbsentID,  Convert(NVarchar(250),'') AS  GeneralAbsentName, Convert(Decimal(28,8),0) AS GeneralAbsentAmount
	FROM	HT5006 T1
	INNER JOIN HT5000 T2 ON T1.PayrollMethodID = T2.PayrollMethodID
	WHERE T1.PayrollMethodID = @PayrollMethodID AND T1.SubID = @CriteriaID
	
END

IF (@CustomerIndex = 50)
BEGIN
	IF(LEFT(@CriteriaID,1) = 'I')
	BEGIN	
	---- Cap nhat gia tri tinh ra		
	SET @sSQL01 = @sSQL01 + N'
	UPDATE #HP0500_1
	SET	#HP0500_1.Amount = Income'+@OrderNum+'
	FROM HT3400 T2
	LEFT JOIN HT3499 T3 ON T2.TransactionID = T3.TransactionID AND T2.DivisionID = T3.DivisionID
	WHERE T2.EmployeeID = '''+@EmployeeID+''' AND T2.TranMonth = '+STR(@TranMonth)+' AND T2.TranYear = '+STR(@TranYear)+'			
	'		
	-- print @sSQL01		
	END
	ELSE
	BEGIN
	---- Cap nhat gia tri tinh ra		
	SET @sSQL01 = @sSQL01 + N'
	UPDATE #HP0500_1
	SET	#HP0500_1.Amount = SubAmount'+@OrderNum+'
	FROM HT3400 T2
	LEFT JOIN HT3499 T3 ON T2.TransactionID = T3.TransactionID AND T2.DivisionID = T3.DivisionID
	WHERE T2.DivisionID = '''+@DivisionID+''' AND T2.EmployeeID = '''+@EmployeeID+''' AND T2.TranMonth = '+STR(@TranMonth)+' AND T2.TranYear = '+STR(@TranYear)+'			
	'			
	END
END
ELSE
BEGIN
	IF(LEFT(@CriteriaID,1) = 'I')
	BEGIN
	---- Cap nhat gia tri tinh ra		
	SET @sSQL01 = @sSQL01 +  N'
	UPDATE #HP0500_1 
	SET	#HP0500_1.Amount = T2.Income'+@OrderNum+'
	FROM HT3400 T2		
	WHERE T2.DivisionID = '''+@DivisionID+''' AND T2.EmployeeID = '''+@EmployeeID+''' AND T2.TranMonth = '+STR(@TranMonth)+' AND T2.TranYear = '+STR(@TranYear)+'			
	'	
	END
	ELSE
	BEGIN		
	---- Cap nhat gia tri tinh ra		
	SET @sSQL01 = @sSQL01 +  N'
	UPDATE #HP0500_1 
	SET	#HP0500_1.Amount = T2.SubAmount'+@OrderNum+'
	FROM HT3400 T2		
	WHERE T2.DivisionID = '''+@DivisionID+''' AND T2.EmployeeID = '''+@EmployeeID+''' AND T2.TranMonth = '+STR(@TranMonth)+' AND T2.TranYear = '+STR(@TranYear)+'			
	'	
	END
END
-- PRINT @sSQL01 
EXEC (@sSQL01)

---- Cap nhat ten he so chung
UPDATE T1
SET		T1.GeneralCoName = T2.Description
FROM #HP0500_1 T1
INNER JOIN 
(SELECT DISTINCT DivisionID, GeneralCoID, Description
 FROM HT5001 
 WHERE DivisionID = @DivisionID
 ) T2 ON T1.GeneralCoID = T2.GeneralCoID AND T1.DivisionID = T2.DivisionID

---- Cap nhat ten Ngay cong tong hop
UPDATE T1
SET		T1.GeneralAbsentName = T2.Description
FROM #HP0500_1 T1
INNER JOIN HT5002 T2 ON T1.GeneralAbsentID = T2.GeneralAbsentID AND T1.DivisionID = T2.DivisionID

---- Cap nhat ten Thu nhap tong hop
UPDATE T1
SET		T1.BaseSalaryName = T2.Description
FROM #HP0500_1 T1
LEFT JOIN HT5007 T2 ON T1.BaseSalaryField = T2.GeneralIncomeID AND T1.DivisionID = T2.DivisionID
WHERE T1.MethodID = 'P10'

UPDATE T1
SET		T1.BaseSalaryName = CASE  T1.BaseSalaryField	WHEN 'BaseSalary' THEN N'Lương căn bản'
													WHEN 'InsuranceSalary' THEN N'Lương BHXH'
													WHEN 'SuggestSalary' THEN N'Lương cố định'
													WHEN 'Salary01' THEN N'Mức lương 1'
													WHEN 'Salary02' THEN N'Mức lương 2'
													WHEN 'Salary03' THEN N'Mức lương 3'
													ELSE N'Khác' END
FROM #HP0500_1 T1
WHERE T1.MethodID <> 'P10' AND T1.BaseSalaryField in (SELECT BaseSalaryFieldID FROM HV1112 WHERE DivisionID = @DivisionID)

SELECT	
	@GeneralCoID = GeneralCoID,
	@MethodID = MethodID,
	@BaseSalaryField = BaseSalaryField,
	@BaseSalary = BaseSalary,
	@GeneralAbsentID = GeneralAbsentID
FROM #HP0500_1

---- Tinh gia tri he so chung
IF (ISNULL(@GeneralCoID,'') <> '')
BEGIN	
	EXEC HP5002 @DivisionID, @TranMonth, @TranYear, @PayrollMethodID, @GeneralCoID, @MethodID, @BaseSalaryField, @BaseSalary, '%', '%', @EmployeeID

	UPDATE #HP0500_1 
	SET GeneralCoAmount = GeneralCo
	FROM #HV5002
END		
---- Tinh gia tri thu nhap tong hop
IF (@MethodID <> 'P10')
BEGIN
	UPDATE #HP0500_1 
	SET #HP0500_1.BaseSalaryAmount = #HV5002.BaseSalary
	FROM #HV5002			
END
ELSE
BEGIN	

	SELECT @EmployeeID AS EmployeeID, Convert(Decimal(28,8),0) AS BaseSalary
	INTO #HP5103_HT3400

	IF(LEFT(@CriteriaID,1) = 'I')
	BEGIN
		EXEC HP5104 @PayrollMethodID, @TranMonth, @TranYear, @EmployeeID, @CriteriaID, 1, @DivisionID, '%', '%', '', @BaseSalary OUTPUT
	END
	ELSE
		EXEC HP5104 @PayrollMethodID, @TranMonth, @TranYear, @EmployeeID, @CriteriaID, 0, @DivisionID, '%', '%', '', @BaseSalary OUTPUT

	UPDATE #HP0500_1
	SET	#HP0500_1.BaseSalaryAmount = #HP5103_HT3400.BaseSalary
	FROM #HP5103_HT3400
END

---- Tinh Ngay cong tong hop
IF (ISNULL(@GeneralAbsentID,'') <> '')
BEGIN	
	EXEC HP5003 @DivisionID, @TranMonth, @TranYear, @PayrollMethodID, @GeneralAbsentID, '%', '%', @EmployeeID

	UPDATE #HP0500_1 
	SET GeneralAbsentAmount = AbsentAmount
	FROM #HV5003
END
	
IF(@Mode = 0)
BEGIN
	SELECT * FROM #HP0500_1
END
ElSE
IF (@Mode = 1)
BEGIN
	CREATE TABLE #HP0500_2 (CoefficientID Varchar(20), CoefficientName NVarchar(250), Value Decimal(28,8) )
	
	SET @curHP0500_Coefficient =  CURSOR SCROLL KEYSET FOR 
	SELECT C01ID, C02ID, C03ID, C04ID, C05ID	
	FROM HT5001
	WHERE DivisionID = @DivisionID AND GeneralCoID = @GeneralCoID
	OPEN @curHP0500_Coefficient
	FETCH NEXT FROM @curHP0500_Coefficient INTO @C01ID, @C02ID, @C03ID, @C04ID, @C05ID
	WHILE @@FETCH_STATUS = 0
	BEGIN
	
	IF(ISNULL(@C01ID,'')<>'')
	BEGIN
		
		SELECT @CoefficientID = @C01ID,
				@CoefficientName = Caption
		FROM HT0003
		WHERE CoefficientID = @C01ID			

		SET	@sSQL01 =N'
		INSERT INTO #HP0500_2 
		SELECT '''+@CoefficientID+''', N'''+@CoefficientName+''', '+@C01ID+'
		FROM	HT2400 
		LEFT JOIN HT2499 ON HT2400.EmpFileID = HT2499.EmpFileID AND HT2400.DivisionID = HT2499.DivisionID
		WHERE HT2400.DivisionID = '''+@DivisionID+''' AND HT2400.TranMonth = '+STR(@TranMonth)+' AND HT2400.TranYear = '+STR(@TranYear)+'
		AND HT2400.EmployeeID = '''+@EmployeeID+'''	
		'		
		-- print @sSQL01
		EXEC(@sSQL01)
	END


	IF(ISNULL(@C02ID,'')<>'')
	BEGIN
		SELECT @CoefficientID = @C02ID,
				@CoefficientName = Caption
		FROM HT0003
		WHERE CoefficientID = @C02ID

		SET	@sSQL01 =N'
		INSERT INTO #HP0500_2 
		SELECT '''+@CoefficientID+''', N'''+@CoefficientName+''', '+@C02ID+'
		FROM	HT2400 
		WHERE DivisionID = '''+@DivisionID+''' AND TranMonth = '+STR(@TranMonth)+' AND TranYear = '+STR(@TranYear)+'	
		AND EmployeeID = '''+@EmployeeID+'''	
		'
		EXEC(@sSQL01)
	END
	

	IF(ISNULL(@C03ID,'')<>'')
	BEGIN
		SELECT @CoefficientID = @C03ID,
				@CoefficientName = Caption
		FROM HT0003
		WHERE CoefficientID = @C03ID

		SET	@sSQL01 =N'
		INSERT INTO #HP0500_2 
		SELECT '''+@CoefficientID+''', N'''+@CoefficientName+''', '+@C03ID+'
		FROM	HT2400 
		WHERE DivisionID = '''+@DivisionID+''' AND TranMonth = '+STR(@TranMonth)+' AND TranYear = '+STR(@TranYear)+'	
		AND EmployeeID = '''+@EmployeeID+'''	
		'
		EXEC(@sSQL01)
	END
	

	IF(ISNULL(@C04ID,'')<>'')
	BEGIN
		SELECT @CoefficientID = @C04ID,
				@CoefficientName = Caption
		FROM HT0003
		WHERE CoefficientID = @C04ID

		SET	@sSQL01 =N'
		INSERT INTO #HP0500_2 
		SELECT '''+@CoefficientID+''', N'''+@CoefficientName+''', '+@C04ID+'
		FROM	HT2400 
		WHERE DivisionID = '''+@DivisionID+''' AND TranMonth = '+STR(@TranMonth)+' AND TranYear = '+STR(@TranYear)+'	
		AND EmployeeID = '''+@EmployeeID+'''	
		'
		EXEC(@sSQL01)
	END
	

	IF(ISNULL(@C05ID,'')<>'')
	BEGIN
		SELECT @CoefficientID = @C05ID,
				@CoefficientName = Caption
		FROM HT0003
		WHERE CoefficientID = @C05ID

		SET	@sSQL01 =N'
		INSERT INTO #HP0500_2 
		SELECT '''+@CoefficientID+''', N'''+@CoefficientName+''', '+@C05ID+'
		FROM	HT2400 
		WHERE DivisionID = '''+@DivisionID+''' AND TranMonth = '+STR(@TranMonth)+' AND TranYear = '+STR(@TranYear)+'
		AND EmployeeID = '''+@EmployeeID+'''		
		'
		EXEC(@sSQL01)
	END
	

	FETCH NEXT FROM @curHP0500_Coefficient INTO @C01ID, @C02ID, @C03ID, @C04ID, @C05ID
	END
	CLOSE @curHP0500_Coefficient
	Print @sSQL01
	SELECT * FROM #HP0500_2 
END
ELSE
IF(@Mode = 2)
BEGIN
	SELECT	@Type = Type,
			@IsMonth = IsMonth
	FROM HT5002
	WHERE DivisionID = @DivisionID AND GeneralAbsentID = @GeneralAbsentID

	CREATE TABLE #HP0500_3 (AbsentTypeID Varchar(50), AbsentTypeName NVarchar(250), Value Decimal(28,8))

	IF(@IsMonth = 1)
	BEGIN
		IF (@Type = 0)
		BEGIN
			INSERT INTO #HP0500_3
			SELECT	HT2402.AbsentTypeID, HT1013.AbsentName, 
					Sum(AbsentAmount*HT1013.ConvertUnit/CASE WHEN HT1013.UnitID = 'H' THEN @TimeConvert  ELSE 1 END ) as AbsentAmount
			FROM	HT2402
			INNER JOIN HT1013 on HT2402.AbsentTypeID = HT1013.AbsentTypeID AND HT2402.DivisionID = HT1013.DivisionID
			LEFT JOIN HT1013 H3 on H3.ParentID = HT1013.AbsentTypeID AND H3.DivisionID = HT1013.DivisionID
			WHERE  HT2402.DivisionID = @DivisionID AND HT2402.TranMonth = @TranMonth AND HT2402.TranYear = @TranYear
					AND HT2402.EmployeeID = @EmployeeID 
					AND EXISTS (SELECT TOP 1 1 
								FROM HT5002 T1
								INNER JOIN HT5003 T2 ON T1.DivisionID = T2.DivisionID AND T1.GeneralAbsentID = T2.GeneralAbsentID
								WHERE T1.DivisionID = @DivisionID AND T1.GeneralAbsentID = @GeneralAbsentID
								AND HT2402.AbsentTypeID = T2.AbsentTypeID)
			GROUP BY HT2402.AbsentTypeID, HT1013.AbsentName
		END
		ELSE
		BEGIN
			INSERT INTO #HP0500_3
			SELECT	HT2402.AbsentTypeID, HT1013.AbsentName, 
					Sum(Case when ISNULL(TypeID,'') in ( 'G', 'P' )  then - ISNULL(AbsentAmount*ConvertUnit,0) ELSE 
								 Case When  ISNULL(TypeID,'') = 'T' then ISNULL(AbsentAmount*ConvertUnit,0) ELSE 0 end  end/ 
								CASE WHEN UnitID = 'H' THEN @TimeConvert ELSE 1 END ) as AbsentAmount
			FROM	HT2402
			INNER JOIN HT1013 on HT2402.AbsentTypeID = HT1013.AbsentTypeID AND HT2402.DivisionID = HT1013.DivisionID			
			WHERE  HT2402.DivisionID = @DivisionID AND HT2402.TranMonth = @TranMonth AND HT2402.TranYear = @TranYear
					AND HT2402.EmployeeID = @EmployeeID 
					AND EXISTS (SELECT TOP 1 1 
								FROM HT5002 T1
								INNER JOIN HT5003 T2 ON T1.DivisionID = T2.DivisionID AND T1.GeneralAbsentID = T2.GeneralAbsentID
								WHERE T1.DivisionID = @DivisionID AND T1.GeneralAbsentID = @GeneralAbsentID
								AND HT2402.AbsentTypeID = T2.AbsentTypeID)
			GROUP BY HT2402.AbsentTypeID, HT1013.AbsentName
		END

	END
	ELSE
	BEGIN
		IF (@Type = 0)
		BEGIN
			INSERT INTO #HP0500_3
			SELECT	HT2401.AbsentTypeID, HT1013.AbsentName, 
					Sum(AbsentAmount*HT1013.ConvertUnit/ CASE WHEN HT1013.UnitID = 'H' THEN @TimeConvert ELSE 1 END) as AbsentAmount
			FROM		HT2401 
			INNER JOIN	HT1013 ON HT2401.AbsentTypeID = HT1013.AbsentTypeID AND HT2401.DivisionID = HT1013.DivisionID
			LEFT JOIN HT1013 H3 on H3.ParentID = HT1013.AbsentTypeID AND H3.DivisionID = HT1013.DivisionID
			WHERE  HT2401.DivisionID = @DivisionID AND HT2401.TranMonth = @TranMonth AND HT2401.TranYear = @TranYear
					AND HT2401.EmployeeID = @EmployeeID 
					AND EXISTS (SELECT TOP 1 1 
								FROM HT5002 T1
								INNER JOIN HT5003 T2 ON T1.DivisionID = T2.DivisionID AND T1.GeneralAbsentID = T2.GeneralAbsentID
								WHERE T1.DivisionID = @DivisionID AND T1.GeneralAbsentID = @GeneralAbsentID
								AND HT2401.AbsentTypeID = T2.AbsentTypeID)
			GROUP BY HT2401.AbsentTypeID, HT1013.AbsentName
		END
		ELSE
		BEGIN
			INSERT INTO #HP0500_3
			SELECT	HT2401.AbsentTypeID, HT1013.AbsentName, 
					Sum( Case when ISNULL(TypeID,'') in ( 'G', 'P' )  then - ISNULL(AbsentAmount*ConvertUnit, 0) ELSE 
						 Case When  ISNULL(TypeID,'') = 'T' then ISNULL(AbsentAmount*ConvertUnit,0) ELSE 0 end  end/ 
						CASE WHEN UnitID = 'H' THEN @TimeConvert ELSE 1 END) as AbsentAmount
			FROM		HT2401 
			INNER JOIN	HT1013 ON HT2401.AbsentTypeID = HT1013.AbsentTypeID AND HT2401.DivisionID = HT1013.DivisionID			
			WHERE  HT2401.DivisionID = @DivisionID AND HT2401.TranMonth = @TranMonth AND HT2401.TranYear = @TranYear
					AND HT2401.EmployeeID = @EmployeeID 
					AND EXISTS (SELECT TOP 1 1 
								FROM HT5002 T1
								INNER JOIN HT5003 T2 ON T1.DivisionID = T2.DivisionID AND T1.GeneralAbsentID = T2.GeneralAbsentID
								WHERE T1.DivisionID = @DivisionID AND T1.GeneralAbsentID = @GeneralAbsentID
								AND HT2401.AbsentTypeID = T2.AbsentTypeID)
			GROUP BY HT2401.AbsentTypeID, HT1013.AbsentName
		END
	END
		
	SELECT * FROM #HP0500_3
END

 

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

