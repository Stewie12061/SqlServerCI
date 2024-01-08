IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0262]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0262]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


----Created by: Hoang Trong Khanh
-----Created date: 06/06/2012
-----purpose: Kết chuyển bút toán lương VÀ THUẾ
---- Modify on 05/08/2014 by Bảo Anh: Kết chuyển theo kỳ lương và theo thiết lập báo cáo lương
---- Modify on 27/08/2014 by Bảo Anh: Sửa TK nợ khi kết chuyển bút toán thuế TNCN
---- Modified on 08/10/2015 by Tieu Mai: Sửa phần làm tròn số lẻ, tiền hạch toán theo thiết lập đơn vị-chi nhánh
---- Modified on 08/12/2015 by Phương Thảo: Bổ sung Loại tiền và kết chuyển theo phòng ban
---- Modified on 16/03/2016 by Tiểu Mai: Bổ sung tham số truyền vào, kết chuyển theo tổ nhóm, phòng ban đã chọn (CustomizeIndex = 57 - ANGEL)
---- Modified on 29/04/2016 by Phương Thảo: Bổ sung gọi sp đặc thù Meiko (kết chuyển chi tiết theo mã pt)
---- Modified by Tiểu Mai on 16/05/2016: Bổ sung xóa kết chuyển theo tổ nhóm, phòng ban
---- Modified by Bảo Thy on 25/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Phương Thảo on 21/07/2016: Chỉnh sửa khi kết chuyển theo phòng ban, nếu không có tiền thuế thì không kiểm tra TK Thuế TNCN
---- Modified by Hải Long on 16/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Tiểu Mai on 13/07/2017: Bổ sung lưu cột AT9000.Ana03ID cho khách hàng BourBon (CustomizeIndex = 38)
---- Modified by Hải Long on 15/09/2017: Sửa lỗi @lstPayrollMethodID bị tràn chuỗi
---- Modified by Nhựt Trường on 13/07/2023: Bổ sung điều kiện DivisionID IN (@DivisionID,'@@@') cho các bảng dùng chung.

CREATE PROCEDURE [dbo].[AP0262] 	
						@DivisionID nvarchar(50) ,
						@TranMonth AS int ,
						@TranYear AS int ,
						@VoucherTypeID AS nvarchar(50) ,
						@VoucherNo AS nvarchar(50) ,
						@VoucherDate AS datetime ,  
						@BDescription AS nvarchar(250) ,
						@VDescription AS nvarchar(250) ,
						@TDescription AS nvarchar(250) ,
						@IsTranferGeneral as tinyint,
						@CreateUserID AS nvarchar(50) ,
						@LastModifyUserID AS nvarchar(50),
						@PeriodID nvarchar(50) = '',
						@IsTranByReportSetup tinyint = 0,
						@ReportCode nvarchar(50) = '',
						@CurrencyID NVarchar(50) = '',
						@ExchangeRate Money = 0,
						@IsDetailByDep Tinyint = 0,
						@DepartmentID NVARCHAR(50) = '',
						@TeamID NVARCHAR(50) = '',
						@IsDetailReport TINYINT = 0						
 AS 

DECLARE @BatchID AS nvarchar(50) ,
        @TransactionID AS nvarchar(50) ,
        @VoucherID AS nvarchar(50),
        @EmployeeID as nvarchar(50),
        @ExpenseAccountID as nvarchar(50),
        @PayableAccountID as nvarchar(50),
        @PerInTaxID as nvarchar(50),
        @TaxAmount as Decimal(28,8),
        @SalaryBeforeMinusTax as Decimal(28,8),  
        @TotalTaxAmount as Decimal(28,8),
        @TotalSalaryBeforeMinusTax as Decimal(28,8),                 
        @TransactionTypeID AS NVARCHAR(50),
        @TableID AS NVARCHAR(50),
        @OriginalDecimal AS int,
		@ConvertedDecimal AS int,
		@Operator AS Tinyint,
        ---@TestTranGeneral as nvarchar(50),
        @Orders as int,
        @cur CURSOR,
		@AnaType as Varchar(20),
		@sSQL01 as NVarchar(4000),
		@AnaType01 AS NVARCHAR(50),
		@CustomerName INT,
		@Amount as Decimal(28,8),
		@DebitAccountID AS NVARCHAR(50),
		@CreditAccountID AS NVARCHAR(50),
		@sSQL1 AS NVARCHAR(MAX),	
		@sSQL2 AS NVARCHAR(MAX),
		@sSQL3 AS NVARCHAR(MAX),
		@sSQL4 AS NVARCHAR(MAX),
		@sWhere1 AS NVARCHAR(MAX) = '',
		@sWhere2 AS NVARCHAR(MAX) = '',		
		@sWhere3 AS NVARCHAR(MAX) = '',
		@sJoin AS NVARCHAR(MAX) = '',
		@AnaID NVARCHAR(50)																	

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)        
        
SET @TransactionTypeID = 'T99'
SET @TableID = 'HV3400' + ltrim(rtrim(@PeriodID))

-- SET giá trị Orders ban đầu
SET @Orders = 1


SELECT @AnaType = 'Ana'+RIGHT(DepartmentAnaTypeID,2)+'ID'
FROM	AT0000 WITH (NOLOCK)
WHERE ISNULL(DepartmentAnaTypeID,'') <> ''

SELECT @AnaType01 = 'Ana'+RIGHT(TeamAnaTypeID,2)+'ID'
FROM	AT0000 WITH (NOLOCK)
WHERE ISNULL(TeamAnaTypeID,'') <> ''

IF (ISNULL(@CurrencyID,'') = '')
BEGIN
	--SET loại tiền trong AT0001
	SET @CurrencyID = (SELECT TOP 1 BASECURRENCYID FROM AT1101 WITH (NOLOCK) WHERE DivisionID IN (@DivisionID,'@@@'))
	SET @ExchangeRate = 1
END

-- FORMAT số lẻ  
SELECT @ConvertedDecimal = (SELECT TOP 1 ISNULL(ConvertedDecimals,0) FROM AT1101 WITH (NOLOCK) WHERE DivisionID IN (@DivisionID,'@@@'))

SELECT @OriginalDecimal = (SELECT ISNULL(ExchangeRateDecimal,0) FROM AT1004 WITH (NOLOCK) WHERE DivisionID IN (@DivisionID, '@@@') AND CurrencyID = @CurrencyID)

SELECT @Operator = (SELECT ISNULL(Operator,0) FROM AT1004 WITH (NOLOCK) WHERE DivisionID IN (@DivisionID, '@@@') AND CurrencyID = @CurrencyID)

BEGIN TRAN

IF(@CustomerName = 50)
BEGIN	
	EXEC AP0262_MK @DivisionID, @TranMonth, @TranYear, @VoucherTypeID, @VoucherNo, @VoucherDate, @BDescription, @VDescription, @TDescription, @IsTranferGeneral,
				@CreateUserID, @LastModifyUserID, @PeriodID, @IsTranByReportSetup, @ReportCode, @CurrencyID, @ExchangeRate, @IsDetailByDep
END
ELSE
BEGIN
	--Xoá dữ liệu AT9000 (tổng hợp) trước khi insert
	SET @sSQL01 = '
	DELETE AT9000 WHERE TransactionTypeID = '''+@TransactionTypeID+''' And TableID = '''+@TableID+''' 
	And DivisionID = '''+@DivisionID+''' And TranMonth = '+Convert(Nvarchar(2),@TranMonth)+' and TranYear = '+Convert(Nvarchar(5),@TranYear)+' AND '+Replace(@AnaType,'''','')+' LIKE '''+@DepartmentID+''' AND '+Replace(@AnaType01,'''','')+' LIKE '''+@TeamID+'''
	'
	EXEC (@sSQL01)
	IF @IsTranByReportSetup <> 0 --- trả về dữ liệu theo thiết lập báo cáo lương
	BEGIN
		Declare @FromDepartmentID nvarchar(50),
				@ToDepartmentID nvarchar(50),
				@FromEmployeeID nvarchar(50),
				@ToEmployeeID nvarchar(50),
				@lstPayrollMethodID nvarchar(MAX)
							
		SELECT TOP 1 @FromDepartmentID = DepartmentID From AT1102 WITH (NOLOCK)
		WHERE DivisionID IN (@DivisionID, '@@@') AND Disabled = 0
		ORDER BY DepartmentID
	
		SELECT TOP 1 @ToDepartmentID = DepartmentID From AT1102 WITH (NOLOCK)
		WHERE DivisionID IN (@DivisionID, '@@@') AND Disabled = 0
		ORDER BY DepartmentID DESC
	
		SELECT TOP 1 @FromEmployeeID = HT24.EmployeeID
		FROM HT2400 HT24 WITH (NOLOCK) Inner Join HV1400 HV14 On HT24.EmployeeID = HV14.EmployeeID and HT24.DivisionID = HV14.DivisionID
		WHERE HT24.DivisionID = @DivisionID
		AND HT24.TranYear*12 + HT24.TranMonth = @TranYear * 12 + @TranMonth
		Order by HT24.EmployeeID
	
		SELECT TOP 1 @ToEmployeeID = HT24.EmployeeID
		FROM HT2400 HT24 WITH (NOLOCK) Inner Join HV1400 HV14 On HT24.EmployeeID = HV14.EmployeeID and HT24.DivisionID = HV14.DivisionID
		WHERE HT24.DivisionID = @DivisionID
		AND HT24.TranYear*12 + HT24.TranMonth = @TranYear * 12 + @TranMonth
		Order by HT24.EmployeeID DESC
			
		IF @PeriodID = ''
			SET @lstPayrollMethodID = '%'
		ELSE
			SELECT @lstPayrollMethodID = ltrim(STUFF((SELECT distinct ',' + PayrollMethodID from HT5000 WITH (NOLOCK)
			WHERE DivisionID = @DivisionID AND Isnull(PeriodID,'') = @PeriodID
			for xml path('')),1,1,''))

		EXEC HP7008 @DivisionID,@ReportCode,@FromDepartmentID,@ToDepartmentID,'%',@FromEmployeeID,@ToEmployeeID,@TranMonth,@TranYear,@TranMonth,@TranYear,@lstPayrollMethodID
	END

	-- Trạng thái kết chuyển tổng hợp 
	IF @IsTranferGeneral = 1
		BEGIN
					--VoucherID, BatchID, TransactionID mã sinh tự động từ AP0000
					--EXEC AP0000 @DivisionID, @VoucherID OUTPUT , 'AT9000' , 'AV' , @TranYear , '' , 15 , 3 , 0 , '-'
					--EXEC AP0000 @DivisionID, @BatchID OUTPUT , 'AT9000' , 'BT' , @TranYear , '' , 15 , 3 , 0 , '-'	
					
					SET @VoucherID = NEWID()
					SET @BatchID = NEWID()
							
					--Lấy 3 tài khoản trong thiết lập hệ thống HT0000. Tài khoản nào rỗng thì lấy mặc định
					SELECT @ExpenseAccountID = ExpenseAccountID, @PayableAccountID =PayableAccountID, @PerInTaxID = PerInTaxID 
					From HT0000 WITH (NOLOCK) Where DivisionID = @DivisionID
					Set @ExpenseAccountID = Isnull(@ExpenseAccountID, '622')
					Set @PayableAccountID = Isnull(@PayableAccountID, '3341')					
					Set @PerInTaxID = Isnull(@PerInTaxID, '3335')					
					
					IF @IsTranByReportSetup = 0 --- kết chuyển theo dữ liệu tính lương
					BEGIN		
						IF @PeriodID = '' --- không phân biệt kỳ lương
						BEGIN
							SELECT @TotalSalaryBeforeMinusTax = SUM(HV00.SalaryBeforeMinusTax)
							,@TotalTaxAmount = SUM(HV00.TaxAmount)
							From HT1403 HT03 WITH (NOLOCK) Inner Join HV3400 HV00 ON HV00.EmployeeID = HT03.EmployeeID And HV00.DivisionID = HT03.DivisionID
							Where HT03.ExpenseAccountID is not null 
							And HT03.PayableAccountID is not null 
							And HT03.PerInTaxID is not null 
							And HV00.TranMonth = @TranMonth And HV00.TranYear = @TranYear
							And HT03.DivisionID = @DivisionID
							/*
							SELECT @TestTranGeneral = HT03.DivisionID
							From HT1403 HT03 Inner Join HV3400 HV00 ON HV00.EmployeeID = HT03.EmployeeID And HV00.DivisionID = HT03.DivisionID
							Where HT03.ExpenseAccountID is not null 
							And HT03.PayableAccountID is not null 
							And HT03.PerInTaxID is not null 
							And HV00.TranMonth = @TranMonth And HV00.TranYear = @TranYear
							And HT03.DivisionID = @DivisionID	*/
						END
						ELSE
						BEGIN
							SELECT @TotalSalaryBeforeMinusTax = SUM(HV00.SalaryBeforeMinusTax)
							,@TotalTaxAmount = SUM(HV00.TaxAmount)
							From HT1403 HT03 WITH (NOLOCK) Inner Join HV3400 HV00 ON HV00.EmployeeID = HT03.EmployeeID And HV00.DivisionID = HT03.DivisionID
							Where HT03.ExpenseAccountID is not null 
							And HT03.PayableAccountID is not null 
							And HT03.PerInTaxID is not null 
							And HV00.TranMonth = @TranMonth And HV00.TranYear = @TranYear
							And HT03.DivisionID = @DivisionID
							And HV00.PayrollMethodID in (Select PayrollMethodID From HT5000 WITH (NOLOCK) Where DivisionID = @DivisionID And Isnull(PeriodID,'') = @PeriodID)
							/*
							SELECT @TestTranGeneral = HT03.DivisionID
							From HT1403 HT03 Inner Join HV3400 HV00 ON HV00.EmployeeID = HT03.EmployeeID And HV00.DivisionID = HT03.DivisionID
							Where HT03.ExpenseAccountID is not null 
							And HT03.PayableAccountID is not null 
							And HT03.PerInTaxID is not null 
							And HV00.TranMonth = @TranMonth And HV00.TranYear = @TranYear
							And HT03.DivisionID = @DivisionID
							And HV00.PayrollMethodID in (Select PayrollMethodID From HT5000 Where DivisionID = @DivisionID And Isnull(PeriodID,'') = @PeriodID)
							*/
						END
					END
				
					ELSE --- kết chuyển theo thiết lập báo cáo lương
					BEGIN
						IF @IsDetailReport = 1
						BEGIN
							
							SELECT *  
							INTO #TEMP
							FROM
							(
								SELECT 
								SUM(ColumnAmount01) AS ColumnAmount01, SUM(ColumnAmount02) AS ColumnAmount02, SUM(ColumnAmount03) AS ColumnAmount03, SUM(ColumnAmount04) AS ColumnAmount04, SUM(ColumnAmount05) AS ColumnAmount05, 
								SUM(ColumnAmount06) AS ColumnAmount06, SUM(ColumnAmount07) AS ColumnAmount07, SUM(ColumnAmount08) AS ColumnAmount08, SUM(ColumnAmount09) AS ColumnAmount09, SUM(ColumnAmount10) AS ColumnAmount10,
								SUM(ColumnAmount11) AS ColumnAmount11, SUM(ColumnAmount12) AS ColumnAmount12, SUM(ColumnAmount13) AS ColumnAmount13, SUM(ColumnAmount14) AS ColumnAmount14, SUM(ColumnAmount15) AS ColumnAmount15, 
								SUM(ColumnAmount16) AS ColumnAmount16, SUM(ColumnAmount17) AS ColumnAmount17, SUM(ColumnAmount18) AS ColumnAmount18, SUM(ColumnAmount19) AS ColumnAmount19, SUM(ColumnAmount20) AS ColumnAmount20,
								SUM(ColumnAmount21) AS ColumnAmount21, SUM(ColumnAmount22) AS ColumnAmount22, SUM(ColumnAmount23) AS ColumnAmount23, SUM(ColumnAmount24) AS ColumnAmount24, SUM(ColumnAmount25) AS ColumnAmount25, 
								SUM(ColumnAmount26) AS ColumnAmount26, SUM(ColumnAmount27) AS ColumnAmount27, SUM(ColumnAmount28) AS ColumnAmount28, SUM(ColumnAmount29) AS ColumnAmount29, SUM(ColumnAmount30) AS ColumnAmount30,
								SUM(ColumnAmount31) AS ColumnAmount31, SUM(ColumnAmount32) AS ColumnAmount32, SUM(ColumnAmount33) AS ColumnAmount33, SUM(ColumnAmount34) AS ColumnAmount34, SUM(ColumnAmount35) AS ColumnAmount35, 
								SUM(ColumnAmount36) AS ColumnAmount36, SUM(ColumnAmount37) AS ColumnAmount37, SUM(ColumnAmount38) AS ColumnAmount38, SUM(ColumnAmount39) AS ColumnAmount39, SUM(ColumnAmount40) AS ColumnAmount40,
								SUM(ColumnAmount41) AS ColumnAmount41, SUM(ColumnAmount42) AS ColumnAmount42, SUM(ColumnAmount43) AS ColumnAmount43, SUM(ColumnAmount44) AS ColumnAmount44, SUM(ColumnAmount45) AS ColumnAmount45, 
								SUM(ColumnAmount46) AS ColumnAmount46, SUM(ColumnAmount47) AS ColumnAmount47, SUM(ColumnAmount48) AS ColumnAmount48, SUM(ColumnAmount49) AS ColumnAmount49, SUM(ColumnAmount50) AS ColumnAmount50
								From HT1403 HT03 WITH (NOLOCK) 
								INNER JOIN HT7110 HV00 ON HV00.EmployeeID = HT03.EmployeeID And HV00.DivisionID = HT03.DivisionID
								WHERE HT03.ExpenseAccountID is not null 
								AND HT03.PayableAccountID is not null 
								AND HT03.PerInTaxID is not null
								AND HT03.DivisionID = @DivisionID
							) TB
							UNPIVOT 
							(
								Amount FOR ColumnName IN 
								(
									ColumnAmount01, ColumnAmount02, ColumnAmount03, ColumnAmount04, ColumnAmount05, ColumnAmount06, ColumnAmount07, ColumnAmount08, ColumnAmount09, ColumnAmount10,
									ColumnAmount11, ColumnAmount12, ColumnAmount13, ColumnAmount14, ColumnAmount15, ColumnAmount16, ColumnAmount17, ColumnAmount18, ColumnAmount19, ColumnAmount20,
									ColumnAmount21, ColumnAmount22, ColumnAmount23, ColumnAmount24, ColumnAmount25, ColumnAmount26, ColumnAmount27, ColumnAmount28, ColumnAmount29, ColumnAmount30,
									ColumnAmount31, ColumnAmount32, ColumnAmount33, ColumnAmount34, ColumnAmount35, ColumnAmount36, ColumnAmount37, ColumnAmount38, ColumnAmount39, ColumnAmount40,
									ColumnAmount41, ColumnAmount42, ColumnAmount43, ColumnAmount44, ColumnAmount45, ColumnAmount46, ColumnAmount47, ColumnAmount48, ColumnAmount49, ColumnAmount50
								)
							) AS UnPVT
							
							
							SELECT (CASE WHEN (AmountType = 'SU' AND AmountTypeFrom = 'S21' AND AmountTypeTo = 'S21') THEN SAmount2
										 WHEN (AmountType = 'SU' AND AmountTypeFrom = 'S22' AND AmountTypeTo = 'S22') THEN HAmount2
										 WHEN (AmountType = 'SU' AND AmountTypeFrom = 'S23' AND AmountTypeTo = 'S23') THEN TAmount2
										 ELSE NULL END) AS Amount,			
							'ColumnAmount' + (CASE WHEN LEN(CONVERT(NVARCHAR(5),ColumnID)) = 1 THEN '0' + CONVERT(NVARCHAR(5),ColumnID) ELSE CONVERT(NVARCHAR(5),ColumnID) END) AS ColumnName,
							DebitAccountID, CreditAccountID, HT4712.AnaID
							INTO #TEMP2
							FROM HT4712 WITH (NOLOCK)
							LEFT JOIN 
							(
								SELECT HT03.DivisionID, SUM(HT2461.SAmount2) AS SAmount2, SUM(HT2461.HAmount2) AS HAmount2, SUM(HT2461.TAmount2) AS TAmount2	
								FROM HT1403 HT03 WITH (NOLOCK)
								INNER JOIN HT7110 HV00 ON HV00.EmployeeID = HT03.EmployeeID And HV00.DivisionID = HT03.DivisionID											
								LEFT JOIN HT2461 ON HT2461.DivisionID = HT03.DivisionID AND HT2461.EmployeeID = HT03.EmployeeID AND HT2461.TranMonth = @TranMonth AND HT2461.TranYear = @TranYear  
								WHERE HT03.ExpenseAccountID is not null 
								AND HT03.PayableAccountID is not null 
								AND HT03.PerInTaxID is not null
								AND HT03.DivisionID = @DivisionID
								GROUP BY HT03.DivisionID
							) TB ON TB.DivisionID = HT4712.DivisionID
							WHERE HT4712.DivisionID = @DivisionID
							AND IsSalary = 1
							AND ReportCode = @ReportCode	
							
							SET @cur = CURSOR SCROLL KEYSET FOR 
							SELECT ISNULL(#TEMP2.Amount, #TEMP.Amount) AS Amount, #TEMP2.DebitAccountID, #TEMP2.CreditAccountID, #TEMP2.AnaID 
							FROM #TEMP
							INNER JOIN #TEMP2 ON #TEMP.ColumnName = #TEMP2.ColumnName 												
						END
						ELSE
						BEGIN
							SELECT @TotalSalaryBeforeMinusTax = SUM(HV00.Total)
								,@TotalTaxAmount = SUM(HV00.TaxAmount)
								From HT1403 HT03 WITH (NOLOCK) Inner Join HT7110 HV00 ON HV00.EmployeeID = HT03.EmployeeID And HV00.DivisionID = HT03.DivisionID
								Where HT03.ExpenseAccountID is not null 
								And HT03.PayableAccountID is not null 
								And HT03.PerInTaxID is not null
								And HT03.DivisionID = @DivisionID
							/*	
							SELECT @TestTranGeneral = HT03.DivisionID
								From HT1403 HT03 Inner Join HT7110 HV00 ON HV00.EmployeeID = HT03.EmployeeID And HV00.DivisionID = HT03.DivisionID
								Where HT03.ExpenseAccountID is not null 
								And HT03.PayableAccountID is not null 
								And HT03.PerInTaxID is not null
								And HT03.DivisionID = @DivisionID	*/							
						END	
					END
					
					IF @IsDetailReport = 1 
					BEGIN		
	
						OPEN @cur
						FETCH next FROM @cur INTO @Amount, @DebitAccountID, @CreditAccountID, @AnaID
						WHILE @@Fetch_Status = 0
							BEGIN
								IF @CustomerName = 38 ----- Bổ sung lưu Mã PT 03 cho BourBon
								BEGIN
									INSERT INTO
										AT9000
										(	
										  Orders,			  
										  VoucherID ,
										  TransactionID ,				  
										  TableID ,		
										  CreateDate,		  
										  LastModifyDate ,				  
										  BatchID ,
										  TransactionTypeID ,
										  CreateUserID ,
										  LastModifyUserID ,
										  TranMonth ,
										  TranYear ,
										  Status,
										  DebitAccountID ,
										  CreditAccountID ,
										  CurrencyID ,
										  VoucherNo ,
										  VoucherTypeID ,
										  ObjectID ,
										  VDescription ,
										  BDescription ,
										  TDescription ,  
										  OriginalAmount ,  							  
										  ExchangeRate ,
										  ConvertedAmount ,
										  DivisionID ,
										  VoucherDate,
										  Ana03ID )
									VALUES
										(
										  @Orders,
										  @VoucherID,
										  NEWID(),									  
										  @TableID ,
										  CONVERT(char , getdate() , 101) ,
										  CONVERT(char , getdate() , 101) ,
										  @BatchID ,	
										  @TransactionTypeID,
										  @CreateUserID ,
										  @LastModifyUserID ,
										  @TranMonth ,
										  @TranYear ,
										  0 ,
										  ISNULL(@DebitAccountID, @ExpenseAccountID),
										  ISNULL(@CreditAccountID, @PayableAccountID),
										  @CurrencyID ,
										  @VoucherNo ,
										  @VoucherTypeID ,
										  @EmployeeID ,
										  @VDescription ,
										  @BDescription ,
										  @TDescription ,
										  ROUND (@Amount,@OriginalDecimal) ,
										  @ExchangeRate,
										  CASE WHEN @Operator = 0 THEN ROUND(@Amount*@ExchangeRate,  @ConvertedDecimal) ELSE ROUND(@Amount/@ExchangeRate,  @ConvertedDecimal) END,
										  @DivisionID,
										  @VoucherDate,
										  @AnaID)
								END
								ELSE								
									INSERT INTO
										AT9000
										(	
										  Orders,			  
										  VoucherID ,
										  TransactionID ,				  
										  TableID ,		
										  CreateDate,		  
										  LastModifyDate ,				  
										  BatchID ,
										  TransactionTypeID ,
										  CreateUserID ,
										  LastModifyUserID ,
										  TranMonth ,
										  TranYear ,
										  Status,
										  DebitAccountID ,
										  CreditAccountID ,
										  CurrencyID ,
										  VoucherNo ,
										  VoucherTypeID ,
										  ObjectID ,
										  VDescription ,
										  BDescription ,
										  TDescription ,  
										  OriginalAmount ,  							  
										  ExchangeRate ,
										  ConvertedAmount ,
										  DivisionID ,
										  VoucherDate)
									VALUES
										(
										  @Orders,
										  @VoucherID,
										  NEWID(),									  
										  @TableID ,
										  CONVERT(char , getdate() , 101) ,
										  CONVERT(char , getdate() , 101) ,
										  @BatchID ,	
										  @TransactionTypeID,
										  @CreateUserID ,
										  @LastModifyUserID ,
										  @TranMonth ,
										  @TranYear ,
										  0 ,
										  ISNULL(@DebitAccountID, @ExpenseAccountID),
										  ISNULL(@CreditAccountID, @PayableAccountID),
										  @CurrencyID ,
										  @VoucherNo ,
										  @VoucherTypeID ,
										  @EmployeeID ,
										  @VDescription ,
										  @BDescription ,
										  @TDescription ,
										  ROUND (@Amount,@OriginalDecimal) ,
										  @ExchangeRate,
										  CASE WHEN @Operator = 0 THEN ROUND(@Amount*@ExchangeRate,  @ConvertedDecimal) ELSE ROUND(@Amount/@ExchangeRate,  @ConvertedDecimal) END,
										  @DivisionID,
										  @VoucherDate)
									  														
								SET @Orders = @Orders + 1	
								FETCH NEXT FROM @cur INTO @Amount, @DebitAccountID, @CreditAccountID, @AnaID
							END 	
						CLOSE @cur
						DEALLOCATE @cur									
					END
					ELSE
					BEGIN
				
						--Nếu có dữ liệu mới Insert vào AT9000	
						IF Isnull(@TotalSalaryBeforeMinusTax,0) <> 0
						BEGIN
								--EXEC AP0000 @DivisionID, @TransactionID OUTPUT , 'AT9000' , 'AT' , @TranYear , '' , 15 , 3 , 0 , '-'

								SET @TransactionID = NEWID()

								INSERT INTO
									AT9000
									(	
									  Orders,			  
									  VoucherID ,
									  TransactionID ,				  
									  TableID ,		
									  CreateDate,		  
									  LastModifyDate ,				  
									  BatchID ,
									  TransactionTypeID ,
									  CreateUserID ,
									  LastModifyUserID ,
									  TranMonth ,
									  TranYear ,
									  Status,
									  DebitAccountID ,
									  CreditAccountID ,
									  CurrencyID ,
									  VoucherNo ,
									  VoucherTypeID ,
									  ObjectID ,
									  VDescription ,
									  BDescription ,
									  TDescription ,  
									  OriginalAmount ,  							  
									  ExchangeRate ,
									  ConvertedAmount ,
									  DivisionID ,
									  VoucherDate )
								VALUES
									(
									  @Orders,
									  @VoucherID ,
									  @TransactionID ,
									  @TableID ,
									  CONVERT(char , getdate() , 101) ,
									  CONVERT(char , getdate() , 101) ,
									  @BatchID ,
									  @TransactionTypeID,
									  @CreateUserID ,
									  @LastModifyUserID ,
									  @TranMonth ,
									  @TranYear ,
									  0 ,
									  @ExpenseAccountID ,
									  @PayableAccountID ,
									  @CurrencyID ,
									  @VoucherNo ,
									  @VoucherTypeID ,
									  @EmployeeID ,
									  @VDescription ,
									  @BDescription ,
									  @TDescription ,
									  ROUND (@TotalSalaryBeforeMinusTax,@OriginalDecimal) ,
									  @ExchangeRate,
									  CASE WHEN @Operator = 0 THEN ROUND(@TotalSalaryBeforeMinusTax*@ExchangeRate,  @ConvertedDecimal) ELSE ROUND(@TotalSalaryBeforeMinusTax/@ExchangeRate,  @ConvertedDecimal) END,
									  @DivisionID,
									  @VoucherDate)
						END
				
						IF ISNULL(@TotalTaxAmount,0) <> 0
						BEGIN
									--EXEC AP0000 @DivisionID, @TransactionID OUTPUT , 'AT9000' , 'AT' , @TranYear , '' , 15 , 3 , 0 , '-' 
									
									SET @TransactionID = NEWID()
									
									SET @Orders = @Orders + 1
									--Insert dòng thứ 2		
									INSERT INTO
									AT9000
									(	
									  Orders,			  
									  VoucherID ,
									  TransactionID ,				  
									  TableID ,		
									  CreateDate,		  
									  LastModifyDate ,				  
									  BatchID ,
									  TransactionTypeID ,
									  CreateUserID ,
									  LastModifyUserID ,
									  TranMonth ,
									  TranYear ,
									  Status,
									  DebitAccountID ,
									  CreditAccountID ,
									  CurrencyID ,
									  VoucherNo ,
									  VoucherTypeID ,
									  ObjectID ,
									  VDescription ,
									  BDescription ,
									  TDescription ,    
									  OriginalAmount ,							  
									  ExchangeRate ,
									  ConvertedAmount,
									  DivisionID ,
									  VoucherDate )
								VALUES
									(
									  @Orders,
									  @VoucherID ,
									  @TransactionID ,
									  @TableID,
									  CONVERT(char , getdate() , 101) ,
									  CONVERT(char , getdate() , 101) ,
									  @BatchID ,
									  @TransactionTypeID,
									  @CreateUserID ,
									  @LastModifyUserID ,
									  @TranMonth ,
									  @TranYear ,
									  0 ,
									  @PayableAccountID,
									  @PerInTaxID ,
									  @CurrencyID ,
									  @VoucherNo ,
									  @VoucherTypeID ,
									  @EmployeeID ,
									  @VDescription ,
									  @BDescription ,
									  @TDescription ,
									  ROUND (@TotalTaxAmount,  @OriginalDecimal) ,
									  @ExchangeRate,
									  CASE WHEN @Operator = 0 THEN ROUND(@TotalTaxAmount*@ExchangeRate,@ConvertedDecimal) ELSE ROUND(@TotalTaxAmount/@ExchangeRate, @ConvertedDecimal) END,							  
									  @DivisionID,
									  @VoucherDate)
						END						
					END	
									
		END
	ELSE -- Trạng thái kết chuyển chi tiết
		BEGIN				
				--VoucherID, BatchID, TransactionID mã sinh tự động từ AP0000		
				--EXEC AP0000 @DivisionID, @VoucherID OUTPUT , 'AT9000' , 'AV' , @TranYear , '' , 15 , 3 , 0 , '-'
				--EXEC AP0000 @DivisionID, @BatchID OUTPUT , 'AT9000' , 'BT' , @TranYear , '' , 15 , 3 , 0 , '-'
				SET @VoucherID = NEWID()
				SET @BatchID = NEWID()
				
				IF (@IsDetailByDep = 0 )
				BEGIN
					--Lấy từng nhân viên, mỗi nhân viên có 2 dòng (EmployeeID,CreditAccountID, DebitAccountID, OriginalAmount)
					IF @IsTranByReportSetup = 0 --- kết chuyển theo dữ liệu tính lương
					BEGIN
						IF @PeriodID = ''
							SET @cur = CURSOR SCROLL KEYSET FOR 
												Select HT03.EmployeeID, ExpenseAccountID, PayableAccountID, PerInTaxID, HV00.SalaryBeforeMinusTax, HV00.TaxAmount
												From HT1403 HT03 WITH (NOLOCK) Inner Join HV3400 HV00 ON HV00.EmployeeID = HT03.EmployeeID And HV00.DivisionID = HT03.DivisionID
												Where HT03.ExpenseAccountID is not null 
												And HT03.PayableAccountID is not null 
												And HT03.PerInTaxID is not null 
												And HT03.EmployeeID IN (Select ObjectID From AT1202 WITH (NOLOCK) Where DivisionID IN (@DivisionID, '@@@'))
												And HV00.TranMonth = @TranMonth And HV00.TranYear = @TranYear
												And HT03.DivisionID = @DivisionID
												Order by HT03.EmployeeID Asc										
						ELSE
							SET @cur = CURSOR SCROLL KEYSET FOR 
												Select HT03.EmployeeID, ExpenseAccountID, PayableAccountID, PerInTaxID, HV00.SalaryBeforeMinusTax, HV00.TaxAmount
												From HT1403 HT03 WITH (NOLOCK) Inner Join HV3400 HV00 ON HV00.EmployeeID = HT03.EmployeeID And HV00.DivisionID = HT03.DivisionID
												Where HT03.ExpenseAccountID is not null 
												And HT03.PayableAccountID is not null 
												And HT03.PerInTaxID is not null 
												And HT03.EmployeeID IN (Select ObjectID From AT1202 WITH (NOLOCK) Where DivisionID IN (@DivisionID, '@@@'))
												And HV00.TranMonth = @TranMonth And HV00.TranYear = @TranYear
												And HT03.DivisionID = @DivisionID
												And HV00.PayrollMethodID in (Select PayrollMethodID From HT5000 WITH (NOLOCK) Where DivisionID = @DivisionID And Isnull(PeriodID,'') = @PeriodID)
												Order by HT03.EmployeeID Asc
					END
					ELSE 				--- kết chuyển theo thiết lập báo cáo lương
					BEGIN
						
						IF @IsDetailReport = 1
						BEGIN
							
							SELECT *  
							INTO #TEMP3
							FROM
							(
								SELECT 
								ISNULL(ColumnAmount01,0) AS ColumnAmount01, ISNULL(ColumnAmount02,0) AS ColumnAmount02, ISNULL(ColumnAmount03,0) AS ColumnAmount03, ISNULL(ColumnAmount04,0) AS ColumnAmount04, ISNULL(ColumnAmount05,0) AS ColumnAmount05, 
								ISNULL(ColumnAmount06,0) AS ColumnAmount06, ISNULL(ColumnAmount07,0) AS ColumnAmount07, ISNULL(ColumnAmount08,0) AS ColumnAmount08, ISNULL(ColumnAmount09,0) AS ColumnAmount09, ISNULL(ColumnAmount10,0) AS ColumnAmount10,
								ISNULL(ColumnAmount11,0) AS ColumnAmount11, ISNULL(ColumnAmount12,0) AS ColumnAmount12, ISNULL(ColumnAmount13,0) AS ColumnAmount13, ISNULL(ColumnAmount14,0) AS ColumnAmount14, ISNULL(ColumnAmount15,0) AS ColumnAmount15, 
								ISNULL(ColumnAmount16,0) AS ColumnAmount16, ISNULL(ColumnAmount17,0) AS ColumnAmount17, ISNULL(ColumnAmount18,0) AS ColumnAmount18, ISNULL(ColumnAmount19,0) AS ColumnAmount19, ISNULL(ColumnAmount20,0) AS ColumnAmount20,
								ISNULL(ColumnAmount21,0) AS ColumnAmount21, ISNULL(ColumnAmount22,0) AS ColumnAmount22, ISNULL(ColumnAmount23,0) AS ColumnAmount23, ISNULL(ColumnAmount24,0) AS ColumnAmount24, ISNULL(ColumnAmount25,0) AS ColumnAmount25, 
								ISNULL(ColumnAmount26,0) AS ColumnAmount26, ISNULL(ColumnAmount27,0) AS ColumnAmount27, ISNULL(ColumnAmount28,0) AS ColumnAmount28, ISNULL(ColumnAmount29,0) AS ColumnAmount29, ISNULL(ColumnAmount30,0) AS ColumnAmount30,
								ISNULL(ColumnAmount31,0) AS ColumnAmount31, ISNULL(ColumnAmount32,0) AS ColumnAmount32, ISNULL(ColumnAmount33,0) AS ColumnAmount33, ISNULL(ColumnAmount34,0) AS ColumnAmount34, ISNULL(ColumnAmount35,0) AS ColumnAmount35, 
								ISNULL(ColumnAmount36,0) AS ColumnAmount36, ISNULL(ColumnAmount37,0) AS ColumnAmount37, ISNULL(ColumnAmount38,0) AS ColumnAmount38, ISNULL(ColumnAmount39,0) AS ColumnAmount39, ISNULL(ColumnAmount40,0) AS ColumnAmount40,
								ISNULL(ColumnAmount41,0) AS ColumnAmount41, ISNULL(ColumnAmount42,0) AS ColumnAmount42, ISNULL(ColumnAmount43,0) AS ColumnAmount43, ISNULL(ColumnAmount44,0) AS ColumnAmount44, ISNULL(ColumnAmount45,0) AS ColumnAmount45, 
								ISNULL(ColumnAmount46,0) AS ColumnAmount46, ISNULL(ColumnAmount47,0) AS ColumnAmount47, ISNULL(ColumnAmount48,0) AS ColumnAmount48, ISNULL(ColumnAmount49,0) AS ColumnAmount49, ISNULL(ColumnAmount50,0) AS ColumnAmount50,
								HV00.EmployeeID, HT03.ExpenseAccountID AS DebitAccountID, HT03.PayableAccountID AS CreditAccountID								
								From HT1403 HT03 WITH (NOLOCK) 
								INNER JOIN HT7110 HV00 ON HV00.EmployeeID = HT03.EmployeeID And HV00.DivisionID = HT03.DivisionID
								Where HT03.ExpenseAccountID is not null 
								And HT03.PayableAccountID is not null 
								And HT03.PerInTaxID is not null 
								And HT03.EmployeeID IN (Select ObjectID From AT1202 WITH (NOLOCK) Where DivisionID IN (@DivisionID, '@@@'))						
								And HT03.DivisionID = @DivisionID							
							) TB
							UNPIVOT 
							(
								Amount FOR ColumnName IN 
								(
									ColumnAmount01, ColumnAmount02, ColumnAmount03, ColumnAmount04, ColumnAmount05, ColumnAmount06, ColumnAmount07, ColumnAmount08, ColumnAmount09, ColumnAmount10,
									ColumnAmount11, ColumnAmount12, ColumnAmount13, ColumnAmount14, ColumnAmount15, ColumnAmount16, ColumnAmount17, ColumnAmount18, ColumnAmount19, ColumnAmount20,
									ColumnAmount21, ColumnAmount22, ColumnAmount23, ColumnAmount24, ColumnAmount25, ColumnAmount26, ColumnAmount27, ColumnAmount28, ColumnAmount29, ColumnAmount30,
									ColumnAmount31, ColumnAmount32, ColumnAmount33, ColumnAmount34, ColumnAmount35, ColumnAmount36, ColumnAmount37, ColumnAmount38, ColumnAmount39, ColumnAmount40,
									ColumnAmount41, ColumnAmount42, ColumnAmount43, ColumnAmount44, ColumnAmount45, ColumnAmount46, ColumnAmount47, ColumnAmount48, ColumnAmount49, ColumnAmount50
								)
							) AS UnPVT
							
							
							SELECT TB.EmployeeID,
							(CASE WHEN (AmountType = 'SU' AND AmountTypeFrom = 'S21' AND AmountTypeTo = 'S21') THEN SAmount2
								  WHEN (AmountType = 'SU' AND AmountTypeFrom = 'S22' AND AmountTypeTo = 'S22') THEN HAmount2
								  WHEN (AmountType = 'SU' AND AmountTypeFrom = 'S23' AND AmountTypeTo = 'S23') THEN TAmount2
								  ELSE NULL END) AS Amount,			
							'ColumnAmount' + (CASE WHEN LEN(CONVERT(NVARCHAR(5),ColumnID)) = 1 THEN '0' + CONVERT(NVARCHAR(5),ColumnID) ELSE CONVERT(NVARCHAR(5),ColumnID) END) AS ColumnName,
							DebitAccountID, CreditAccountID, HT4712.AnaID
							INTO #TEMP4
							FROM HT4712 WITH (NOLOCK)
							LEFT JOIN 
							(
								SELECT HT03.DivisionID, HT03.EmployeeID, SUM(HT2461.SAmount2) AS SAmount2, SUM(HT2461.HAmount2) AS HAmount2, SUM(HT2461.TAmount2) AS TAmount2	
								FROM HT1403 HT03 WITH (NOLOCK)
								INNER JOIN HT7110 HV00 ON HV00.EmployeeID = HT03.EmployeeID And HV00.DivisionID = HT03.DivisionID								
								LEFT JOIN HT2461 ON HT2461.DivisionID = HT03.DivisionID AND HT2461.EmployeeID = HT03.EmployeeID AND HT2461.TranMonth = @TranMonth AND HT2461.TranYear = @TranYear
								WHERE HT03.ExpenseAccountID is not null 
								AND HT03.PayableAccountID is not null 
								AND HT03.PerInTaxID is NOT NULL
								And HT03.EmployeeID IN (Select ObjectID From AT1202 WITH (NOLOCK) Where DivisionID IN (@DivisionID, '@@@'))									
								AND HT03.DivisionID = @DivisionID					
								GROUP BY HT03.DivisionID, HT03.EmployeeID 
							) TB ON TB.DivisionID = HT4712.DivisionID
							WHERE HT4712.DivisionID = @DivisionID
							AND IsSalary = 1
							AND ReportCode = @ReportCode	
							
							SET @cur = CURSOR SCROLL KEYSET FOR 
							SELECT #TEMP3.EmployeeID, ISNULL(#TEMP4.Amount, #TEMP3.Amount) AS Amount,  
							ISNULL(#TEMP4.DebitAccountID, #TEMP3.DebitAccountID), 
							ISNULL(#TEMP4.CreditAccountID, #TEMP3.CreditAccountID),
							#TEMP4.AnaID
							FROM #TEMP3
							INNER JOIN #TEMP4 ON #TEMP3.ColumnName = #TEMP4.ColumnName AND #TEMP3.EmployeeID = #TEMP4.EmployeeID	
							ORDER BY #TEMP3.EmployeeID																		
						END
						ELSE
						BEGIN
							SET @cur = CURSOR SCROLL KEYSET FOR 
												Select HT03.EmployeeID, HT03.ExpenseAccountID, HT03.PayableAccountID, HT03.PerInTaxID, HV00.Total, HV00.TaxAmount
												From HT1403 HT03 WITH (NOLOCK) Inner Join HT7110 HV00 WITH (NOLOCK) ON HV00.EmployeeID = HT03.EmployeeID And HV00.DivisionID = HT03.DivisionID
												Where HT03.ExpenseAccountID is not null 
												And HT03.PayableAccountID is not null 
												And HT03.PerInTaxID is not null 
												And HT03.EmployeeID IN (Select ObjectID From AT1202 WITH (NOLOCK) Where DivisionID IN (@DivisionID, '@@@'))						
												And HT03.DivisionID = @DivisionID
												Order by HT03.EmployeeID Asc							
						END 								
						
					END
					
					IF @IsDetailReport = 1 
					BEGIN					
						OPEN @cur
						FETCH NEXT FROM @cur INTO @EmployeeID, @Amount, @DebitAccountID, @CreditAccountID, @AnaID
						WHILE @@Fetch_Status = 0
							BEGIN	
								INSERT INTO
									AT9000
									(	
										Orders,			  
										VoucherID ,
										TransactionID ,				  
										TableID ,		
										CreateDate,		  
										LastModifyDate ,				  
										BatchID ,
										TransactionTypeID ,
										CreateUserID ,
										LastModifyUserID ,
										TranMonth ,
										TranYear ,
										Status,
										DebitAccountID ,
										CreditAccountID ,
										CurrencyID ,
										VoucherNo ,
										VoucherTypeID ,
										ObjectID ,
										VDescription ,
										BDescription ,
										TDescription ,    								  
										OriginalAmount ,
										ExchangeRate ,
										ConvertedAmount ,
										DivisionID ,
										VoucherDate,
										Ana03ID )
								VALUES
									(
										@Orders,
										@VoucherID,
										NEWID() ,
										@TableID,
										CONVERT(char , getdate() , 101) ,
										CONVERT(char , getdate() , 101) ,
										@BatchID ,
										@TransactionTypeID,
										@CreateUserID ,
										@LastModifyUserID ,
										@TranMonth ,
										@TranYear ,
										0 ,
									    ISNULL(@DebitAccountID, @ExpenseAccountID),
									    ISNULL(@CreditAccountID, @PayableAccountID),
										@CurrencyID ,
										@VoucherNo ,
										@VoucherTypeID ,
										@EmployeeID ,
										@VDescription ,
										@BDescription ,
										@TDescription ,
										ROUND (@Amount, @OriginalDecimal) ,
										@ExchangeRate ,
										CASE WHEN @Operator = 0 THEN ROUND(@Amount*@ExchangeRate,@ConvertedDecimal) ELSE ROUND(@Amount/@ExchangeRate, @ConvertedDecimal) END,								  
										@DivisionID,
										@VoucherDate,
										@AnaID)									
									
								SET @Orders = @Orders + 1	
								FETCH NEXT FROM @cur INTO @EmployeeID, @Amount, @DebitAccountID, @CreditAccountID, @AnaID
							END 	
						CLOSE @cur
						DEALLOCATE @cur		
					END
					ELSE
					BEGIN
						OPEN @cur
						FETCH next FROM @cur INTO @EmployeeID, @ExpenseAccountID, @PayableAccountID, @PerInTaxID, @SalaryBeforeMinusTax , @TaxAmount
						WHILE @@Fetch_Status = 0
							BEGIN														
								--VoucherID, BatchID, TransactionID mã sinh tự động từ AP0000		
								--EXEC AP0000 @DivisionID, @VoucherID OUTPUT , 'AT9000' , 'AV' , @TranYear , '' , 15 , 3 , 0 , '-'
								IF Isnull(@SalaryBeforeMinusTax,0) <> 0
								BEGIN
									--EXEC AP0000 @DivisionID, @TransactionID OUTPUT , 'AT9000' , 'AT' , @TranYear , '' , 15 , 3 , 0 , '-'
									--EXEC AP0000 @DivisionID, @BatchID OUTPUT , 'AT9000' , 'BT' , @TranYear , '' , 15 , 3 , 0 , '-'
									SET @TransactionID = NEWID()

									INSERT INTO
										AT9000
										(	
										  Orders,			  
										  VoucherID ,
										  TransactionID ,				  
										  TableID ,		
										  CreateDate,		  
										  LastModifyDate ,				  
										  BatchID ,
										  TransactionTypeID ,
										  CreateUserID ,
										  LastModifyUserID ,
										  TranMonth ,
										  TranYear ,
										  Status,
										  DebitAccountID ,
										  CreditAccountID ,
										  CurrencyID ,
										  VoucherNo ,
										  VoucherTypeID ,
										  ObjectID ,
										  VDescription ,
										  BDescription ,
										  TDescription ,    								  
										  OriginalAmount ,
										  ExchangeRate ,
										  ConvertedAmount ,
										  DivisionID ,
										  VoucherDate )
									VALUES
										(
										  @Orders,
										  @VoucherID ,
										  @TransactionID ,
										  @TableID,
										  CONVERT(char , getdate() , 101) ,
										  CONVERT(char , getdate() , 101) ,
										  @BatchID ,
										  @TransactionTypeID,
										  @CreateUserID ,
										  @LastModifyUserID ,
										  @TranMonth ,
										  @TranYear ,
										  0 ,
										  @ExpenseAccountID ,
										  @PayableAccountID ,
										  @CurrencyID ,
										  @VoucherNo ,
										  @VoucherTypeID ,
										  @EmployeeID ,
										  @VDescription ,
										  @BDescription ,
										  @TDescription ,
										  ROUND (@SalaryBeforeMinusTax, @OriginalDecimal) ,
										  @ExchangeRate ,
										  CASE WHEN @Operator = 0 THEN ROUND(@SalaryBeforeMinusTax*@ExchangeRate,@ConvertedDecimal) ELSE ROUND(@SalaryBeforeMinusTax/@ExchangeRate, @ConvertedDecimal) END,								  
										  @DivisionID,
										  @VoucherDate)

							
							
								END
					
								IF ISNULL(@TaxAmount,0) <> 0
								BEGIN	
									--EXEC AP0000 @DivisionID, @TransactionID OUTPUT , 'AT9000' , 'AT' , @TranYear , '' , 15 , 3 , 0 , '-' 
									SET @TransactionID = NEWID()
									SET @Orders = @Orders + 1						
							
									INSERT INTO
									AT9000
									(	
									  Orders,			  
									  VoucherID ,
									  TransactionID ,				  
									  TableID ,		
									  CreateDate,		  
									  LastModifyDate ,				  
									  BatchID ,
									  TransactionTypeID ,
									  CreateUserID ,
									  LastModifyUserID ,
									  TranMonth ,
									  TranYear ,
									  Status,
									  DebitAccountID ,
									  CreditAccountID ,
									  CurrencyID ,
									  VoucherNo ,
									  VoucherTypeID ,
									  ObjectID ,
									  VDescription ,
									  BDescription ,
									  TDescription ,    							  
									  OriginalAmount ,
									  ExchangeRate ,
									  ConvertedAmount ,
									  DivisionID ,
									  VoucherDate )
								VALUES
									(
									  @Orders,
									  @VoucherID ,
									  @TransactionID ,
									  @TableID,
									  CONVERT(char , getdate() , 101) ,
									  CONVERT(char , getdate() , 101) ,
									  @BatchID ,
									  @TransactionTypeID,
									  @CreateUserID ,
									  @LastModifyUserID ,
									  @TranMonth ,
									  @TranYear ,
									  0 ,
									  @PayableAccountID ,
									  @PerInTaxID ,
									  @CurrencyID ,
									  @VoucherNo ,
									  @VoucherTypeID ,
									  @EmployeeID ,
									  @VDescription ,
									  @BDescription ,
									  @TDescription ,
									  ROUND (@TaxAmount, @OriginalDecimal) ,
									  @ExchangeRate ,
									  CASE WHEN @Operator = 0 THEN ROUND(@TaxAmount*@ExchangeRate,@ConvertedDecimal) ELSE ROUND(@TaxAmount/@ExchangeRate, @ConvertedDecimal) END,								  
									  @DivisionID,
									  @VoucherDate)		

													  
							  	
								END
					
							Fetch next from @cur into @EmployeeID, @ExpenseAccountID, @PayableAccountID, @PerInTaxID, @SalaryBeforeMinusTax , @TaxAmount
							END
						Close @cur
						Deallocate @cur						
					END									
					
				END
				ELSE -- @IsDetailByDep = 1
				BEGIN
					SELECT @ExpenseAccountID = ExpenseAccountID, @PayableAccountID =PayableAccountID, @PerInTaxID = PerInTaxID 
					From HT0000 WITH (NOLOCK) Where DivisionID IN (@DivisionID,'@@@')
					Set @ExpenseAccountID = Isnull(@ExpenseAccountID, '622')
					Set @PayableAccountID = Isnull(@PayableAccountID, '3341')					
					Set @PerInTaxID = Isnull(@PerInTaxID, '3335')
					 

					--Lấy từng phòng ban, mỗi phòng ban có 2 dòng (DepartmentID,CreditAccountID, DebitAccountID, OriginalAmount)
					IF @IsTranByReportSetup = 0 --- kết chuyển theo dữ liệu tính lương
					BEGIN
						IF @PeriodID = ''
						begin						
							
							SET @cur = CURSOR SCROLL KEYSET FOR 
							SELECT	DepartmentID, TeamID, ExpenseAccountID, PayableAccountID, PITAccountID, 
									SalaryBeforeMinusTax, TaxAmount
							FROM
							(
								Select	HV00.DepartmentID, HV00.TeamID,
										CASE WHEN HT03.IsManager = 0 THEN AT02.AccountID ELSE AT02.ManagerExpAccountID END AS ExpenseAccountID, 
										AT02.PayableAccountID, AT02.PITAccountID, 
										SUM(HV00.SalaryBeforeMinusTax) AS SalaryBeforeMinusTax, 
										SUM(HV00.TaxAmount) AS TaxAmount
								From HV3400 HV00 
								INNER JOIN AT1102 AT02 WITH (NOLOCK) ON HV00.DepartmentID = AT02.DepartmentID	
								INNER JOIN HT1403 HT03 WITH (NOLOCK) ON HV00.EmployeeID = HT03.EmployeeID AND HV00.DivisionID = HT03.DivisionID										
								Where AT02.AccountID is not null 
								And AT02.PayableAccountID is not null 								
								And HV00.TranMonth = @TranMonth And HV00.TranYear = @TranYear
								And AT02.DivisionID IN (@DivisionID,'@@@')
								---------Tieu Mai add--------------
								AND ISNULL(HV00.DepartmentID,'') LIKE @DepartmentID
								AND ISNULL(HV00.TeamID,'') LIKE @TeamID
								---------Tieu Mai add--------------			
								GROUP BY HV00.DepartmentID, HV00.TeamID, CASE WHEN HT03.IsManager = 0 THEN AT02.AccountID ELSE AT02.ManagerExpAccountID END, 
								AT02.PayableAccountID, AT02.PITAccountID, Isnull(HT03.IsManager,0)
																
							) T							
							Order by DepartmentID, TeamID Asc		
						end
						ELSE
							SET @cur = CURSOR SCROLL KEYSET FOR 
							SELECT	DepartmentID, TeamID, ExpenseAccountID, PayableAccountID, PITAccountID, 
									SalaryBeforeMinusTax, TaxAmount
							FROM
							(
								Select HV00.DepartmentID, HV00.TeamID,
										CASE WHEN HT03.IsManager = 0 THEN AT02.AccountID ELSE AT02.ManagerExpAccountID END AS ExpenseAccountID, 
										AT02.PayableAccountID, AT02.PITAccountID, 
										SUM(HV00.SalaryBeforeMinusTax) AS SalaryBeforeMinusTax, SUM(HV00.TaxAmount) AS TaxAmount
								From  HV3400 HV00 
								INNER JOIN AT1102 AT02 WITH (NOLOCK) ON HV00.DepartmentID = AT02.DepartmentID
								INNER JOIN HT1403 HT03 WITH (NOLOCK) ON HV00.EmployeeID = HT03.EmployeeID AND HV00.DivisionID = HT03.DivisionID	
								Where AT02.AccountID is not null 
								And AT02.PayableAccountID is not null 																	
								And HV00.TranMonth = @TranMonth And HV00.TranYear	= @TranYear
								And AT02.DivisionID IN (@DivisionID,'@@@')
									---------Tieu Mai add--------------
								AND ISNULL(HV00.DepartmentID,'')  LIKE @DepartmentID
								AND ISNULL(HV00.TeamID,'')  LIKE @TeamID
									---------Tieu Mai add--------------	
								And HV00.PayrollMethodID in (Select PayrollMethodID From HT5000 WITH (NOLOCK) Where DivisionID IN (@DivisionID,'@@@') And Isnull(PeriodID,'') = @PeriodID)
								GROUP BY HV00.DepartmentID, HV00.TeamID, CASE WHEN HT03.IsManager = 0 THEN AT02.AccountID ELSE AT02.ManagerExpAccountID END, 
										 AT02.PayableAccountID, AT02.PITAccountID, Isnull(HT03.IsManager,0)
								
							) T							
							Order by DepartmentID Asc
					END
					ELSE 				--- kết chuyển theo thiết lập báo cáo lương
					BEGIN
						
						IF @IsDetailReport = 1 
						BEGIN
							
							IF OBJECT_ID('tempdb..#TEMP_AP0262') IS NOT NULL  
							BEGIN
								DROP TABLE #TEMP_AP0262	
							END
							
							CREATE TABLE #TEMP_AP0262
							(
								DepartmentID NVARCHAR(50) NULL,
								TeamID NVARCHAR(50) NULL,
								DebitAccountID NVARCHAR(50) NULL,
								CreditAccountID NVARCHAR(50) NULL,								
								Amount DECIMAL(28,8) NULL,
								AnaID NVARCHAR(50) NULL
							)		
							
							IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE ISNULL(TeamAnaTypeID,'') <> '')
							BEGIN
								SET @sWhere1 = 'HV00.TeamID,'
								SET @sWhere2 = 'TB.TeamID,'		
								SET @sWhere3 = '#TEMP5.TeamID,'			
								SET @sJoin = 'AND ISNULL(#TEMP5.TeamID, '''') = ISNULL(#TEMP6.TeamID, '''')'																			
							END	
							ELSE
							BEGIN
								SET @sWhere3 = 'NULL AS TeamID,'									
							END			
														
							SET @sSQL1 = '
							SELECT	*
							INTO #TEMP5
							FROM
							(
								SELECT
								SUM(ISNULL(ColumnAmount01,0)) AS ColumnAmount01, SUM(ISNULL(ColumnAmount02,0)) AS ColumnAmount02, SUM(ISNULL(ColumnAmount03,0)) AS ColumnAmount03, SUM(ISNULL(ColumnAmount04,0)) AS ColumnAmount04, SUM(ISNULL(ColumnAmount05,0)) AS ColumnAmount05, 
								SUM(ISNULL(ColumnAmount06,0)) AS ColumnAmount06, SUM(ISNULL(ColumnAmount07,0)) AS ColumnAmount07, SUM(ISNULL(ColumnAmount08,0)) AS ColumnAmount08, SUM(ISNULL(ColumnAmount09,0)) AS ColumnAmount09, SUM(ISNULL(ColumnAmount10,0)) AS ColumnAmount10,
								SUM(ISNULL(ColumnAmount11,0)) AS ColumnAmount11, SUM(ISNULL(ColumnAmount12,0)) AS ColumnAmount12, SUM(ISNULL(ColumnAmount13,0)) AS ColumnAmount13, SUM(ISNULL(ColumnAmount14,0)) AS ColumnAmount14, SUM(ISNULL(ColumnAmount15,0)) AS ColumnAmount15, 
								SUM(ISNULL(ColumnAmount16,0)) AS ColumnAmount16, SUM(ISNULL(ColumnAmount17,0)) AS ColumnAmount17, SUM(ISNULL(ColumnAmount18,0)) AS ColumnAmount18, SUM(ISNULL(ColumnAmount19,0)) AS ColumnAmount19, SUM(ISNULL(ColumnAmount20,0)) AS ColumnAmount20,
								SUM(ISNULL(ColumnAmount21,0)) AS ColumnAmount21, SUM(ISNULL(ColumnAmount22,0)) AS ColumnAmount22, SUM(ISNULL(ColumnAmount23,0)) AS ColumnAmount23, SUM(ISNULL(ColumnAmount24,0)) AS ColumnAmount24, SUM(ISNULL(ColumnAmount25,0)) AS ColumnAmount25, 
								SUM(ISNULL(ColumnAmount26,0)) AS ColumnAmount26, SUM(ISNULL(ColumnAmount27,0)) AS ColumnAmount27, SUM(ISNULL(ColumnAmount28,0)) AS ColumnAmount28, SUM(ISNULL(ColumnAmount29,0)) AS ColumnAmount29, SUM(ISNULL(ColumnAmount30,0)) AS ColumnAmount30,
								SUM(ISNULL(ColumnAmount31,0)) AS ColumnAmount31, SUM(ISNULL(ColumnAmount32,0)) AS ColumnAmount32, SUM(ISNULL(ColumnAmount33,0)) AS ColumnAmount33, SUM(ISNULL(ColumnAmount34,0)) AS ColumnAmount34, SUM(ISNULL(ColumnAmount35,0)) AS ColumnAmount35, 
								SUM(ISNULL(ColumnAmount36,0)) AS ColumnAmount36, SUM(ISNULL(ColumnAmount37,0)) AS ColumnAmount37, SUM(ISNULL(ColumnAmount38,0)) AS ColumnAmount38, SUM(ISNULL(ColumnAmount39,0)) AS ColumnAmount39, SUM(ISNULL(ColumnAmount40,0)) AS ColumnAmount40,
								SUM(ISNULL(ColumnAmount41,0)) AS ColumnAmount41, SUM(ISNULL(ColumnAmount42,0)) AS ColumnAmount42, SUM(ISNULL(ColumnAmount43,0)) AS ColumnAmount43, SUM(ISNULL(ColumnAmount44,0)) AS ColumnAmount44, SUM(ISNULL(ColumnAmount45,0)) AS ColumnAmount45, 
								SUM(ISNULL(ColumnAmount46,0)) AS ColumnAmount46, SUM(ISNULL(ColumnAmount47,0)) AS ColumnAmount47, SUM(ISNULL(ColumnAmount48,0)) AS ColumnAmount48, SUM(ISNULL(ColumnAmount49,0)) AS ColumnAmount49, SUM(ISNULL(ColumnAmount50,0)) AS ColumnAmount50,	
								HV00.DepartmentID, ' + @sWhere1 + 
								'CASE WHEN (HT03.IsManager = 0 AND ' + CONVERT(NVARCHAR(10), @CustomerName) + ' <> 38) THEN AT02.AccountID ELSE AT02.ManagerExpAccountID END AS DebitAccountID,
								AT02.PayableAccountID AS CreditAccountID
								FROM HT7110 HV00 WITH (NOLOCK) 
								INNER JOIN AT1102 AT02 WITH (NOLOCK) ON HV00.DepartmentID = AT02.DepartmentID
								INNER JOIN HT1403 HT03 WITH (NOLOCK) ON HV00.EmployeeID = HT03.EmployeeID AND HV00.DivisionID = HT03.DivisionID											
								Where AT02.AccountID is not null 
								And AT02.PayableAccountID is not null 																							
								And AT02.DivisionID IN ( ''' + @DivisionID + ''' , ''@@@'')
								AND ISNULL(HV00.DepartmentID,'''') LIKE ''' + @DepartmentID + '''
								AND ISNULL(HV00.TeamID,'''') LIKE ''' + @TeamID + '''
								GROUP BY ' + @sWhere1 + ' HV00.DepartmentID,   
								CASE WHEN (HT03.IsManager = 0 AND ' + CONVERT(NVARCHAR(10), @CustomerName) + ' <> 38) THEN AT02.AccountID ELSE AT02.ManagerExpAccountID END, 
								AT02.PayableAccountID																	
							) TB'
							
							SET @sSQL2 = '														
							UNPIVOT 
							(
								Amount FOR ColumnName IN 
								(
									ColumnAmount01, ColumnAmount02, ColumnAmount03, ColumnAmount04, ColumnAmount05, ColumnAmount06, ColumnAmount07, ColumnAmount08, ColumnAmount09, ColumnAmount10,
									ColumnAmount11, ColumnAmount12, ColumnAmount13, ColumnAmount14, ColumnAmount15, ColumnAmount16, ColumnAmount17, ColumnAmount18, ColumnAmount19, ColumnAmount20,
									ColumnAmount21, ColumnAmount22, ColumnAmount23, ColumnAmount24, ColumnAmount25, ColumnAmount26, ColumnAmount27, ColumnAmount28, ColumnAmount29, ColumnAmount30,
									ColumnAmount31, ColumnAmount32, ColumnAmount33, ColumnAmount34, ColumnAmount35, ColumnAmount36, ColumnAmount37, ColumnAmount38, ColumnAmount39, ColumnAmount40,
									ColumnAmount41, ColumnAmount42, ColumnAmount43, ColumnAmount44, ColumnAmount45, ColumnAmount46, ColumnAmount47, ColumnAmount48, ColumnAmount49, ColumnAmount50
								)
							) AS UnPVT'	
							
							SET @sSQL3 = '
							SELECT TB.DepartmentID, ' + @sWhere2 + 
							'(CASE WHEN (AmountType = ''SU'' AND AmountTypeFrom = ''S21'' AND AmountTypeTo = ''S21'') THEN SAmount2
								  WHEN (AmountType = ''SU'' AND AmountTypeFrom = ''S22'' AND AmountTypeTo = ''S22'') THEN HAmount2
								  WHEN (AmountType = ''SU'' AND AmountTypeFrom = ''S23'' AND AmountTypeTo = ''S23'') THEN TAmount2
								  ELSE NULL END) AS Amount,			
							''ColumnAmount'' + (CASE WHEN LEN(CONVERT(NVARCHAR(5),ColumnID)) = 1 THEN ''0'' + CONVERT(NVARCHAR(5),ColumnID) ELSE CONVERT(NVARCHAR(5),ColumnID) END) AS ColumnName,
							DebitAccountID, CreditAccountID, HT4712.AnaID 
							INTO #TEMP6
							FROM HT4712 WITH (NOLOCK)
							LEFT JOIN 
							(	
								SELECT HV00.DivisionID, HV00.DepartmentID, ' + @sWhere1 + ' SUM(HT2461.SAmount2) AS SAmount2, SUM(HT2461.HAmount2) AS HAmount2, SUM(HT2461.TAmount2) AS TAmount2		
								FROM HT7110 HV00 WITH (NOLOCK) 
								INNER JOIN AT1102 AT02 WITH (NOLOCK) ON HV00.DepartmentID = AT02.DepartmentID
								INNER JOIN HT1403 HT03 WITH (NOLOCK) ON HV00.EmployeeID = HT03.EmployeeID AND HV00.DivisionID = HT03.DivisionID	
								INNER JOIN HT2461 ON HT2461.DivisionID = HT03.DivisionID AND HT2461.EmployeeID = HT03.EmployeeID AND HT2461.TranMonth = ' + CONVERT(NVARCHAR(10), @TranMonth) + ' AND HT2461.TranYear = ' + CONVERT(NVARCHAR(10), @TranYear) + '											
								Where AT02.AccountID is not null 
								And AT02.PayableAccountID is not null 																							
								And AT02.DivisionID IN ( ''' + @DivisionID + ''' , ''@@@'')
								AND ISNULL(HV00.DepartmentID,'''') LIKE ''' + @DepartmentID + '''
								AND ISNULL(HV00.TeamID,'''') LIKE ''' + @TeamID + '''		
								GROUP BY HV00.DivisionID, ' + @sWhere1 + ' HV00.DepartmentID   	
							) TB ON TB.DivisionID = HT4712.DivisionID
							WHERE HT4712.DivisionID IN ( ''' + @DivisionID + ''' , ''@@@'')
							AND IsSalary = 1
							AND ReportCode = ''' + @ReportCode + ''''
							
							SET @sSQL4 = '
							INSERT INTO #TEMP_AP0262 (DepartmentID, TeamID, Amount, DebitAccountID, CreditAccountID, AnaID)
							SELECT #TEMP5.DepartmentID, ' + @sWhere3 +
							'ISNULL(#TEMP6.Amount, #TEMP5.Amount) AS Amount,  
							ISNULL(#TEMP6.DebitAccountID, #TEMP5.DebitAccountID) AS DebitAccountID, 
							ISNULL(#TEMP6.CreditAccountID, #TEMP5.CreditAccountID) AS CreditAccountID,
							#TEMP6.AnaID
							FROM #TEMP5
							INNER JOIN #TEMP6 ON #TEMP5.ColumnName = #TEMP6.ColumnName AND #TEMP5.DepartmentID = #TEMP6.DepartmentID ' + @sJoin + 
							'ORDER BY DepartmentID'								
							
							--PRINT @sSQL1
							--PRINT @sSQL2
							--PRINT @sSQL3		
							--PRINT @sSQL4																			
									
							EXEC (@sSQL1 + @sSQL2 + @sSQL3 + @sSQL4)													
														
							SET @cur = CURSOR SCROLL KEYSET FOR 
							SELECT DepartmentID, TeamID, Amount, DebitAccountID, CreditAccountID, AnaID  
							FROM #TEMP_AP0262
																				
						END
						ELSE
						BEGIN
							SET @cur = CURSOR SCROLL KEYSET FOR 
							SELECT	DepartmentID, TeamID, ExpenseAccountID, PayableAccountID, PITAccountID, 
									Total, TaxAmount
							FROM
							(
								Select	HV00.DepartmentID, HV00.TeamID, 
										CASE WHEN HT03.IsManager = 0 THEN AT02.AccountID ELSE AT02.ManagerExpAccountID END AS ExpenseAccountID,
										AT02.PayableAccountID, AT02.PITAccountID, 
										SUM(HV00.Total) AS Total, SUM(HV00.TaxAmount) AS TaxAmount
								From HT7110 HV00 WITH (NOLOCK) 
								INNER JOIN AT1102 AT02 WITH (NOLOCK) ON HV00.DepartmentID = AT02.DepartmentID
								INNER JOIN HT1403 HT03 WITH (NOLOCK) ON HV00.EmployeeID = HT03.EmployeeID AND HV00.DivisionID = HT03.DivisionID											
								Where AT02.AccountID is not null 
								And AT02.PayableAccountID is not null 																							
								And AT02.DivisionID IN (@DivisionID,'@@@')
								---------Tieu Mai add--------------
								AND ISNULL(HV00.DepartmentID,'') LIKE @DepartmentID
								AND ISNULL(HV00.TeamID,'') LIKE @TeamID
								---------Tieu Mai add--------------					
								GROUP BY HV00.DepartmentID, HV00.TeamID, CASE WHEN HT03.IsManager = 0 THEN AT02.AccountID ELSE AT02.ManagerExpAccountID END, 
								AT02.PayableAccountID, AT02.PITAccountID, Isnull(HT03.IsManager,0)
																		
							) T							
							Order by DepartmentID Asc								
						END		
						
					END
					
					IF @IsDetailReport = 1 
					BEGIN
						OPEN @cur
						FETCH NEXT FROM @cur INTO @DepartmentID, @TeamID, @Amount, @DebitAccountID, @CreditAccountID, @AnaID
						WHILE @@Fetch_Status = 0
							BEGIN	
								SET @sSQL01 = '
								INSERT INTO
									AT9000
									(	
										Orders,			  
										VoucherID ,
										TransactionID ,				  
										TableID ,		
										CreateDate,		  
										LastModifyDate ,				  
										BatchID ,
										TransactionTypeID ,
										CreateUserID ,
										LastModifyUserID ,
										TranMonth ,
										TranYear ,
										Status,
										DebitAccountID ,
										CreditAccountID ,
										CurrencyID ,
										VoucherNo ,
										VoucherTypeID ,
										ObjectID ,
										VDescription ,
										BDescription ,
										TDescription ,    								  
										OriginalAmount ,
										ExchangeRate ,
										ConvertedAmount ,
										DivisionID ,
										VoucherDate 
										'+CASE WHEN Isnull(@AnaType,'') <> '' THEN ', '+ @AnaType ELSE '' END+
										+CASE WHEN Isnull(@AnaType01,'') <> '' THEN ', '+ @AnaType01 ELSE '' END
										+CASE WHEN @CustomerName = 38 THEN ', Ana03ID' ELSE '' END +' )
								VALUES
									(
										'+STR(Isnull(@Orders,0))+',
										'''+Isnull(@VoucherID,'')+''' ,
										'''+CONVERT(NVARCHAR(50),NEWID())+''' ,
										'''+Isnull(@TableID,'')+''',
										CONVERT(char , getdate() , 101) ,
										CONVERT(char , getdate() , 101) ,
										'''+Isnull(@BatchID,'')+''' ,
										'''+Isnull(@TransactionTypeID,'')+''',
										'''+Isnull(@CreateUserID,'')+''' ,
										'''+Isnull(@LastModifyUserID,'')+''' ,
										'+STR(@TranMonth)+' ,
										'+STR(@TranYear)+' ,
										0 ,
										'''+ISNULL(@DebitAccountID, @ExpenseAccountID)+''' ,
										'''+ISNULL(@CreditAccountID, @PayableAccountID)+''' ,
										'''+Isnull(@CurrencyID,'')+''' ,
										'''+Isnull(@VoucherNo,'')+''' ,
										'''+Isnull(@VoucherTypeID,'')+''' ,
										'''+Isnull(@EmployeeID,'')+''' ,
										'''+Isnull(@VDescription,'')+''' ,
										'''+Isnull(@BDescription,'')+''' ,
										'''+Isnull(@TDescription,'')+''' ,
										ROUND ('+Convert(Varchar(50),Isnull(@Amount,0))+', '+CONVERT(Varchar(50),Isnull(@OriginalDecimal,0))+') ,
										'+Convert(VARCHAR(50),@ExchangeRate)+' ,
										CASE WHEN '+STR(@Operator)+' = 0 THEN ROUND('+STR(Isnull(@Amount,0))+' * '+CONVERT(Varchar(50),@ExchangeRate)+','+CONVERT(Varchar(50),Isnull(@ConvertedDecimal,0))+') 
											ELSE ROUND('+Convert(Varchar(50),Isnull(@Amount,0))+'/'+CONVERT(Varchar(50),@ExchangeRate)+', '+CONVERT(Varchar(50),@ConvertedDecimal)+') END,								  
										'''+Isnull(@DivisionID,'')+''',
										'''+Convert(char,Isnull(@VoucherDate,''),101)+'''
										'+CASE WHEN Isnull(@AnaType,'') <> '' THEN ', ''' +Isnull(@DepartmentID,'')+'''' ELSE ''  END+
										+CASE WHEN Isnull(@AnaType01,'') <> '' THEN ', ''' +Isnull(@TeamID,'')+'''' ELSE ''  END
										+CASE WHEN @CustomerName = 38 THEN ', '''+ISNULL(@AnaID,'')+''' ' ELSE '' END +' )							
								'							
								--print @sSQL01
								EXEC(@sSQL01)
																	
								SET @Orders = @Orders + 1	
								FETCH NEXT FROM @cur INTO @DepartmentID, @TeamID, @Amount, @DebitAccountID, @CreditAccountID, @AnaID								
							END
						CLOSE @cur
						DEALLOCATE @cur																			
					END
					ELSE
					BEGIN
						OPEN @cur
						FETCH next FROM @cur INTO @DepartmentID, @TeamID, @ExpenseAccountID, @PayableAccountID, @PerInTaxID, @SalaryBeforeMinusTax , @TaxAmount
						WHILE @@Fetch_Status = 0
							BEGIN	
						
								--VoucherID, BatchID, TransactionID mã sinh tự động từ AP0000		
								--EXEC AP0000 @DivisionID, @VoucherID OUTPUT , 'AT9000' , 'AV' , @TranYear , '' , 15 , 3 , 0 , '-'
								IF Isnull(@SalaryBeforeMinusTax,0) <> 0
								BEGIN
									--EXEC AP0000 @DivisionID, @TransactionID OUTPUT , 'AT9000' , 'AT' , @TranYear , '' , 15 , 3 , 0 , '-'
									--EXEC AP0000 @DivisionID, @BatchID OUTPUT , 'AT9000' , 'BT' , @TranYear , '' , 15 , 3 , 0 , '-'
									SET @TransactionID = NEWID()
									SET @sSQL01 = ''
									SET @sSQL01 = '
									INSERT INTO
										AT9000
										(	
										  Orders,			  
										  VoucherID ,
										  TransactionID ,				  
										  TableID ,		
										  CreateDate,		  
										  LastModifyDate ,				  
										  BatchID ,
										  TransactionTypeID ,
										  CreateUserID ,
										  LastModifyUserID ,
										  TranMonth ,
										  TranYear ,
										  Status,
										  DebitAccountID ,
										  CreditAccountID ,
										  CurrencyID ,
										  VoucherNo ,
										  VoucherTypeID ,
										  ObjectID ,
										  VDescription ,
										  BDescription ,
										  TDescription ,    								  
										  OriginalAmount ,
										  ExchangeRate ,
										  ConvertedAmount ,
										  DivisionID ,
										  VoucherDate 
										  '+CASE WHEN Isnull(@AnaType,'') <> '' THEN ', '+ @AnaType ELSE '' END+
										  +CASE WHEN Isnull(@AnaType01,'') <> '' THEN ', '+ @AnaType01 ELSE '' END+' )
									VALUES
										(
										  '+STR(Isnull(@Orders,0))+',
										  '''+Isnull(@VoucherID,'')+''' ,
										  '''+Isnull(@TransactionID,'')+''',
										  '''+Isnull(@TableID,'')+''',
										  CONVERT(char , getdate() , 101) ,
										  CONVERT(char , getdate() , 101) ,
										  '''+Isnull(@BatchID,'')+''' ,
										  '''+Isnull(@TransactionTypeID,'')+''',
										  '''+Isnull(@CreateUserID,'')+''' ,
										  '''+Isnull(@LastModifyUserID,'')+''' ,
										  '+STR(@TranMonth)+' ,
										  '+STR(@TranYear)+' ,
										  0 ,
										  '''+Isnull(@ExpenseAccountID,'')+''' ,
										  '''+Isnull(@PayableAccountID,'')+''' ,
										  '''+Isnull(@CurrencyID,'')+''' ,
										  '''+Isnull(@VoucherNo,'')+''' ,
										  '''+Isnull(@VoucherTypeID,'')+''' ,
										  '''+Isnull(@EmployeeID,'')+''' ,
										  '''+Isnull(@VDescription,'')+''' ,
										  '''+Isnull(@BDescription,'')+''' ,
										  '''+Isnull(@TDescription,'')+''' ,
										  ROUND ('+Convert(Varchar(50),Isnull(@SalaryBeforeMinusTax,0))+', '+CONVERT(Varchar(50),Isnull(@OriginalDecimal,0))+') ,
										  '+Convert(VARCHAR(50),@ExchangeRate)+' ,
										  CASE WHEN '+STR(@Operator)+' = 0 THEN ROUND('+STR(Isnull(@SalaryBeforeMinusTax,0))+' * '+CONVERT(Varchar(50),@ExchangeRate)+','+CONVERT(Varchar(50),Isnull(@ConvertedDecimal,0))+') 
												ELSE ROUND('+Convert(Varchar(50),Isnull(@SalaryBeforeMinusTax,0))+'/'+CONVERT(Varchar(50),@ExchangeRate)+', '+CONVERT(Varchar(50),@ConvertedDecimal)+') END,								  
										  '''+Isnull(@DivisionID,'')+''',
										  '''+Convert(char,Isnull(@VoucherDate,''),101)+'''
										  '+CASE WHEN Isnull(@AnaType,'') <> '' THEN ', ''' +Isnull(@DepartmentID,'')+'''' ELSE ''  END+
										  +CASE WHEN Isnull(@AnaType01,'') <> '' THEN ', ''' +Isnull(@TeamID,'')+'''' ELSE ''  END+'
										  )							
									'							
									--print @sSQL01
									EXEC(@sSQL01)
								END
					
								IF ISNULL(@TaxAmount,0) <> 0
								BEGIN	
									--EXEC AP0000 @DivisionID, @TransactionID OUTPUT , 'AT9000' , 'AT' , @TranYear , '' , 15 , 3 , 0 , '-' 
									SET @TransactionID = NEWID()
									SET @Orders = @Orders + 1						
							
									--Insert dòng thứ 2	
									SET @sSQL01 = '
									--Insert dòng thứ 2									
									INSERT INTO
									AT9000
									(	
									  Orders,			  
									  VoucherID ,
									  TransactionID ,				  
									  TableID ,		
									  CreateDate,		  
									  LastModifyDate ,				  
									  BatchID ,
									  TransactionTypeID ,
									  CreateUserID ,
									  LastModifyUserID ,
									  TranMonth ,
									  TranYear ,
									  Status,
									  DebitAccountID ,
									  CreditAccountID ,
									  CurrencyID ,
									  VoucherNo ,
									  VoucherTypeID ,
									  ObjectID ,
									  VDescription ,
									  BDescription ,
									  TDescription ,    							  
									  OriginalAmount ,
									  ExchangeRate ,
									  ConvertedAmount ,
									  DivisionID,
									  VoucherDate
									  '+CASE WHEN Isnull(@AnaType,'') <> '' THEN ', '+ @AnaType ELSE '' END+
									  +CASE WHEN Isnull(@AnaType01,'') <> '' THEN ', '+ @AnaType01 ELSE '' END+' )
								VALUES
									(
									  '+STR(Isnull(@Orders,0))+',
									  '''+Isnull(@VoucherID,'')+''' ,
									  '''+Isnull(@TransactionID,'')+''' ,
									  '''+Isnull(@TableID,'')+''',
									  CONVERT(char , getdate() , 101) ,
									  CONVERT(char , getdate() , 101) ,
									  '''+Isnull(@BatchID,'')+''' ,
									  '''+Isnull(@TransactionTypeID,'')+''',
									  '''+Isnull(@CreateUserID,'')+''' ,
									  '''+Isnull(@LastModifyUserID,'')+''' ,
									  '+STR(@TranMonth)+' ,
									  '+STR(@TranYear)+' ,
									  0 ,
									  '''+Isnull(@PayableAccountID,'')+''' ,
									  '''+Isnull(@PerInTaxID,'')+''',
									  '''+Isnull(@CurrencyID,'')+''',
									  '''+Isnull(@VoucherNo,'')+''' ,
									  '''+Isnull(@VoucherTypeID,'')+''' ,
									  '''+Isnull(@EmployeeID,'')+''' ,
									  '''+Isnull(@VDescription,'')+''' ,
									  '''+Isnull(@BDescription,'')+''' ,
									  '''+Isnull(@TDescription,'')+''' ,
									  ROUND ('+Convert(Varchar(50),Isnull(@TaxAmount,0))+', '+CONVERT(Varchar(50),Isnull(@OriginalDecimal,0))+') ,
									  '+CONVERT(Varchar(50),@ExchangeRate)+' ,
									  CASE WHEN '+STR(@Operator)+' = 0 THEN ROUND('+CONVERT(Varchar(50),Isnull(@TaxAmount,0))+'*'+CONVERT(Varchar(50),@ExchangeRate)+','+CONVERT(Varchar(50),Isnull(@ConvertedDecimal,0))+') 
										ELSE ROUND('+Convert(Varchar(50),Isnull(@TaxAmount,0))+'/'+CONVERT(Varchar(50),@ExchangeRate)+', '+CONVERT(Varchar(50),Isnull(@ConvertedDecimal,0))+') END,								  
									  '''+Isnull(@DivisionID,'')+''',
									  '''+Convert(Char,@VoucherDate,101)+'''
									  '+CASE WHEN Isnull(@AnaType,'') <> '' THEN ', ''' +Isnull(@DepartmentID,'')+'''' ELSE ''  END+
										+CASE WHEN Isnull(@AnaType01,'') <> '' THEN ', ''' +Isnull(@TeamID,'')+'''' ELSE ''  END+'
										)	'
									  --print @sSQL01
									  EXEC(@sSQL01)	
								
									
								END
					
							Fetch next from @cur into @DepartmentID, @TeamID, @ExpenseAccountID, @PayableAccountID, @PerInTaxID, @SalaryBeforeMinusTax , @TaxAmount
							END
						Close @cur
						Deallocate @cur						
					END							
				
				END					
		END
END	
	IF @@ERROR = 0
			COMMIT TRAN
		ELSE
			ROLLBACK TRAN



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
