IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0262_MK]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP0262_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Kết chuyển lương chi thiết theo Mã phân tích - Customize Meiko
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- Noi goi: sp AP0262
-- <History>
---- Create on 29/04/2016 by Phuong Thao: 
-- Modified by Bảo Thy on 25/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Hải Long on 16/05/2017: Chỉnh sửa danh mục dùng chung

CREATE PROCEDURE [dbo].[AP0262_MK] 	
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
						@IsDetailByDep Tinyint = 0
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
		@sSQL01 as NVarchar(4000),
		@DepartmentID AS NVARCHAR(50),
		@TeamID AS NVARCHAR(50),       
		@SessionID AS NVARCHAR(50),
		@ProcessID AS NVARCHAR(50)
        
SET @TransactionTypeID = 'T99'
SET @TableID = 'HV3400' + ltrim(rtrim(@PeriodID))
SET @IsTranByReportSetup = 0 --- Meiko không kết chuyển theo thiết lập báo cáo tính lương
-- SET giá trị Orders ban đầu
SET @Orders = 1


--SELECT @AnaType = 'Ana'+RIGHT(DepartmentAnaTypeID,2)+'ID'
--FROM	AT0000
--WHERE ISNULL(DepartmentAnaTypeID,'') <> ''

--SELECT @AnaType01 = 'Ana'+RIGHT(TeamAnaTypeID,2)+'ID'
--FROM	AT0000
--WHERE ISNULL(TeamAnaTypeID,'') <> ''

IF (ISNULL(@CurrencyID,'') = '')
BEGIN
	--SET loại tiền trong AT0001
	SET @CurrencyID = (SELECT TOP 1 BASECURRENCYID FROM AT1101 WITH (NOLOCK) WHERE DivisionID = @DivisionID)
	SET @ExchangeRate = 1
END

-- FORMAT số lẻ  
SELECT @ConvertedDecimal = (SELECT TOP 1 ISNULL(ConvertedDecimals,0) FROM AT1101 WITH (NOLOCK) WHERE DivisionID = @DivisionID)

SELECT @OriginalDecimal = (SELECT ISNULL(ExchangeRateDecimal,0) FROM AT1004 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND CurrencyID = @CurrencyID)

SELECT @Operator = (SELECT ISNULL(Operator,0) FROM AT1004 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND CurrencyID = @CurrencyID)

--Xoá dữ liệu AT9000 (tổng hợp) trước khi insert
DELETE AT9000 WHERE TransactionTypeID = @TransactionTypeID And TableID = @TableID 
And DivisionID = @DivisionID And TranMonth = @TranMonth and TranYear = @TranYear

IF @IsTranByReportSetup <> 0 --- trả về dữ liệu theo thiết lập báo cáo lương
BEGIN
	Declare @FromDepartmentID nvarchar(50),
			@ToDepartmentID nvarchar(50),
			@FromEmployeeID nvarchar(50),
			@ToEmployeeID nvarchar(50),
			@lstPayrollMethodID nvarchar(50)
							
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
		SELECT @lstPayrollMethodID = ltrim(STUFF((SELECT distinct ', ' + PayrollMethodID from HT5000 WITH (NOLOCK)
		WHERE DivisionID = @DivisionID AND Isnull(PeriodID,'') = @PeriodID
		for xml path('')),1,1,''))
	
	EXEC HP7008 @DivisionID,@ReportCode,@FromDepartmentID,@ToDepartmentID,'%',@FromEmployeeID,@ToEmployeeID,@TranMonth,@TranYear,@TranMonth,@TranYear,@lstPayrollMethodID
END

-- Trạng thái kết chuyển tổng hợp 
IF @IsTranferGeneral = 1
	BEGIN
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
				
				--VoucherID, BatchID, TransactionID mã sinh tự động từ AP0000
				EXEC AP0000 @DivisionID, @VoucherID OUTPUT , 'AT9000' , 'AV' , @TranYear , '' , 15 , 3 , 0 , '-'
				EXEC AP0000 @DivisionID, @BatchID OUTPUT , 'AT9000' , 'BT' , @TranYear , '' , 15 , 3 , 0 , '-'
				
				--Nếu có dữ liệu mới Insert vào AT9000	
				IF Isnull(@TotalSalaryBeforeMinusTax,0) <> 0
				BEGIN
						EXEC AP0000 @DivisionID, @TransactionID OUTPUT , 'AT9000' , 'AT' , @TranYear , '' , 15 , 3 , 0 , '-'

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
							EXEC AP0000 @DivisionID, @TransactionID OUTPUT , 'AT9000' , 'AT' , @TranYear , '' , 15 , 3 , 0 , '-' 
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
ELSE -- Trạng thái kết chuyển chi tiết
	BEGIN				
			--VoucherID, BatchID, TransactionID mã sinh tự động từ AP0000		
			EXEC AP0000 @DivisionID, @VoucherID OUTPUT , 'AT9000' , 'AV' , @TranYear , '' , 15 , 3 , 0 , '-'
			EXEC AP0000 @DivisionID, @BatchID OUTPUT , 'AT9000' , 'BT' , @TranYear , '' , 15 , 3 , 0 , '-'
			
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
				
				OPEN @cur
				FETCH next FROM @cur INTO @EmployeeID, @ExpenseAccountID, @PayableAccountID, @PerInTaxID, @SalaryBeforeMinusTax , @TaxAmount
				WHILE @@Fetch_Status = 0
					BEGIN	
						--VoucherID, BatchID, TransactionID mã sinh tự động từ AP0000		
						--EXEC AP0000 @DivisionID, @VoucherID OUTPUT , 'AT9000' , 'AV' , @TranYear , '' , 15 , 3 , 0 , '-'
						IF Isnull(@SalaryBeforeMinusTax,0) <> 0
						BEGIN
							EXEC AP0000 @DivisionID, @TransactionID OUTPUT , 'AT9000' , 'AT' , @TranYear , '' , 15 , 3 , 0 , '-'
							--EXEC AP0000 @DivisionID, @BatchID OUTPUT , 'AT9000' , 'BT' , @TranYear , '' , 15 , 3 , 0 , '-'

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
							EXEC AP0000 @DivisionID, @TransactionID OUTPUT , 'AT9000' , 'AT' , @TranYear , '' , 15 , 3 , 0 , '-' 
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
			ELSE -- @IsDetailByDep = 1
			BEGIN
				--Lấy từng phòng ban, mỗi phòng ban có 2 dòng (DepartmentID,CreditAccountID, DebitAccountID, OriginalAmount)
				IF @IsTranByReportSetup = 0 --- kết chuyển theo dữ liệu tính lương
				BEGIN
					IF @PeriodID = ''
					begin
						SET @cur = CURSOR SCROLL KEYSET FOR 
											Select	HV00.DepartmentID, HV00.TeamID,
													HV00.Ana04ID AS SessionID, HV00.Ana05ID AS ProcessID, 
													CASE WHEN HT03.IsManager = 0 THEN AT02.AccountID ELSE AT02.ManagerExpAccountID END AS ExpenseAccountID, 
													AT02.PayableAccountID, AT02.PITAccountID, 
													SUM(HV00.SalaryBeforeMinusTax) AS SalaryBeforeMinusTax, SUM(HV00.TaxAmount) AS TaxAmount
											From HV3400 HV00 
											INNER JOIN AT1102 AT02 WITH (NOLOCK) ON HV00.DepartmentID = AT02.DepartmentID And HV00.DivisionID = AT02.DivisionID		
											INNER JOIN HT1403 HT03 WITH (NOLOCK) ON HV00.EmployeeID = HT03.EmployeeID AND HV00.DivisionID = HT03.DivisionID										
											Where AT02.AccountID is not null 
											And AT02.PayableAccountID is not null 
											And AT02.PITAccountID is not null 
											And HV00.TranMonth = @TranMonth And HV00.TranYear = @TranYear
											And AT02.DivisionID = @DivisionID							
											GROUP BY HV00.DepartmentID, HV00.TeamID, HV00.Ana04ID, HV00.Ana05ID,
													 CASE WHEN HT03.IsManager = 0 THEN AT02.AccountID ELSE AT02.ManagerExpAccountID END, AT02.PayableAccountID, AT02.PITAccountID, HT03.IsManager
											Order by HV00.DepartmentID, HV00.TeamID Asc										
					end
					ELSE
					begin
						
						SET @cur = CURSOR SCROLL KEYSET FOR 
											Select	HV00.DepartmentID, HV00.TeamID,
													HV00.Ana04ID AS SessionID, HV00.Ana05ID AS ProcessID,
													CASE WHEN HT03.IsManager = 0 THEN AT02.AccountID ELSE AT02.ManagerExpAccountID END AS ExpenseAccountID, 
													AT02.PayableAccountID, AT02.PITAccountID, 
													SUM(HV00.SalaryBeforeMinusTax) AS SalaryBeforeMinusTax, SUM(HV00.TaxAmount) AS TaxAmount
											From  HV3400 HV00 
											INNER JOIN AT1102 AT02 WITH (NOLOCK) ON HV00.DepartmentID = AT02.DepartmentID And HV00.DivisionID = AT02.DivisionID
											INNER JOIN HT1403 HT03 WITH (NOLOCK) ON HV00.EmployeeID = HT03.EmployeeID AND HV00.DivisionID = HT03.DivisionID	
											Where AT02.AccountID is not null 
											And AT02.PayableAccountID is not null 
											And AT02.PITAccountID is not null 											
											And HV00.TranMonth = @TranMonth And HV00.TranYear	= @TranYear
											And AT02.DivisionID = @DivisionID							
											And HV00.PayrollMethodID in (Select PayrollMethodID From HT5000 WITH (NOLOCK) Where DivisionID = @DivisionID And Isnull(PeriodID,'') = @PeriodID)
											GROUP BY HV00.DepartmentID, HV00.TeamID, 
													 HV00.Ana04ID, HV00.Ana05ID,
													 CASE WHEN HT03.IsManager = 0 THEN AT02.AccountID ELSE AT02.ManagerExpAccountID END, AT02.PayableAccountID, AT02.PITAccountID, HT03.IsManager
											Order by HV00.DepartmentID Asc
					end
				END				
				OPEN @cur
				FETCH next FROM @cur INTO @DepartmentID, @TeamID, @SessionID, @ProcessID, @ExpenseAccountID, @PayableAccountID, @PerInTaxID, @SalaryBeforeMinusTax , @TaxAmount
				WHILE @@Fetch_Status = 0
					BEGIN	
						
						--VoucherID, BatchID, TransactionID mã sinh tự động từ AP0000		
						--EXEC AP0000 @DivisionID, @VoucherID OUTPUT , 'AT9000' , 'AV' , @TranYear , '' , 15 , 3 , 0 , '-'
						IF Isnull(@SalaryBeforeMinusTax,0) <> 0
						BEGIN
							EXEC AP0000 @DivisionID, @TransactionID OUTPUT , 'AT9000' , 'AT' , @TranYear , '' , 15 , 3 , 0 , '-'
							--EXEC AP0000 @DivisionID, @BatchID OUTPUT , 'AT9000' , 'BT' , @TranYear , '' , 15 , 3 , 0 , '-'
							set @sSQL01 = ''
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
								  VoucherDate,
								  Ana02ID, 
								  Ana03ID,
								  Ana04ID,
								  Ana05ID )
								  
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
								  ROUND ('+STR(Isnull(@SalaryBeforeMinusTax,0))+', '+STR(Isnull(@OriginalDecimal,0))+') ,
								  '+STR(@ExchangeRate)+' ,
								  CASE WHEN '+STR(@Operator)+' = 0 THEN ROUND('+STR(Isnull(@SalaryBeforeMinusTax,0))+' * '+STR(@ExchangeRate)+','+STR(Isnull(@ConvertedDecimal,0))+') 
										ELSE ROUND('+STR(@SalaryBeforeMinusTax)+'/'+STR(@ExchangeRate)+', '+STR(@ConvertedDecimal)+') END,								  
								  '''+Isnull(@DivisionID,'')+''',
								  '''+Convert(char,Isnull(@VoucherDate,''),101)+''',
								  ''' +Isnull(@DepartmentID,'')+''', 
								  ''' +Isnull(@TeamID,'')+''',
								  ''' +Isnull(@SessionID,'')+''', 
								  ''' +Isnull(@ProcessID,'')+'''
								  )							
							'							
							--print @sSQL01
							EXEC(@sSQL01)
						END
					
						IF ISNULL(@TaxAmount,0) <> 0
						BEGIN	
							EXEC AP0000 @DivisionID, @TransactionID OUTPUT , 'AT9000' , 'AT' , @TranYear , '' , 15 , 3 , 0 , '-' 
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
							  VoucherDate,
							  Ana02ID, 
							  Ana03ID,
							  Ana04ID,
							  Ana05ID)
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
							  ROUND ('+STR(Isnull(@TaxAmount,0))+', '+STR(Isnull(@OriginalDecimal,0))+') ,
							  '+STR(@ExchangeRate)+' ,
							  CASE WHEN '+STR(@Operator)+' = 0 THEN ROUND('+STR(Isnull(@TaxAmount,0))+'*'+STR(@ExchangeRate)+','+STR(Isnull(@ConvertedDecimal,0))+') 
								ELSE ROUND('+STR(Isnull(@TaxAmount,0))+'/'+STR(@ExchangeRate)+', '+STR(Isnull(@ConvertedDecimal,0))+') END,								  
							  '''+Isnull(@DivisionID,'')+''',
							  '''+Convert(Char,@VoucherDate,101)+'''
							  ''' +Isnull(@DepartmentID,'')+''', 
							  ''' +Isnull(@TeamID,'')+''',
							  ''' +Isnull(@SessionID,'')+''', 
							  ''' +Isnull(@ProcessID,'')+'''
								)	'
							  --print @sSQL01
							  EXEC(@sSQL01)	
								
									
						END
					
					Fetch next from @cur into @DepartmentID, @TeamID, @SessionID, @ProcessID, @ExpenseAccountID, @PayableAccountID, @PerInTaxID, @SalaryBeforeMinusTax , @TaxAmount
					END
				Close @cur
				Deallocate @cur
			END					
	END




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

