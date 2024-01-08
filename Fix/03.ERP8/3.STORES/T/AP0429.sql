IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0429]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP0429]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

------ Created by Kiều Nga, Date 18/04/2022
------ Purpose: Tinh phan bo chi phi tra truoc va doanh thu nhan truoc

CREATE PROCEDURE [dbo].[AP0429] @DivisionID as nvarchar(50), 
				@TranMonth as int, 
				@TranYear as int,
				@D_C as nvarchar(50), 
				@VoucherTypeID nvarchar(50), 
				@VoucherNo as nvarchar(50), 
				@VoucherDate as Datetime,
				@BDescription as nvarchar(250),
				@UserID nvarchar(50),
				@JobIDInput nvarchar(50)
AS


Declare 	@Job_cur as Cursor,
		@JobID as varchar(50),
		@ConvertedAmount as money, --- Nguyen gia
		@ResidualValue as decimal(28,8), ---Gia tri con lai
		@TotalDepAmount as money,
		@RemainAmount as money,
		@Ana01ID as varchar(50),
		@Ana02ID as varchar(50),
		@Ana03ID as varchar(50),
		@Ana04ID as varchar(50),
		@Ana05ID as varchar(50),	
		@Ana06ID as varchar(50),
		@Ana07ID as varchar(50),
		@Ana08ID as varchar(50),
		@Ana09ID as varchar(50),
		@Ana10ID as varchar(50),	
		@CreditAccountID As varchar(50),
		@DebitAccountID as  varchar(50),
		@MethodID as tinyint,
		@ObjectID as varchar(50),
		@PeriodID as varchar(50),
		@SerialNo as varchar(50),
		@InvoiceNo as varchar(50),
		@InvoiceDate as datetime,
		@ApportionRate as money,
		@Periods as int, 
		@ResidualMonths as decimal(28,8),
		@BeginMonth as int,
		@BeginYear as int,
		@ConvertedDecimals as tinyint,
		@DepAmount as money,
		@DepType as tinyint,
		@TempDepAmount as money,
		@DepreciationID as varchar(50),	
		@ApportionAmount as money,
		@CurrencyID varchar(50),
		@ExchangeRate money,
		@DepOriginalAmount as money,
		@UseStatus as int, -- 0 : Chua phan bo, 1 : Dang phan bo, 8 : Ngung phan bo, 9 : Phan bo het.
		@IsMultiAccount as tinyint,

		--- Dung cho phan bo theo nhieu TK:
		@Account_cur as Cursor,
		@AccountID_D as varchar(50),
		@AccountID_C as varchar(50),
		@DepPercent as money,
		@Ana01ID_MA as varchar(50),
		@Ana02ID_MA as varchar(50),
		@Ana03ID_MA as varchar(50),
		@Ana04ID_MA as varchar(50),
		@Ana05ID_MA as varchar(50),
		@Ana06ID_MA as varchar(50),
		@Ana07ID_MA as varchar(50),
		@Ana08ID_MA as varchar(50),
		@Ana09ID_MA as varchar(50),
		@Ana10ID_MA as varchar(50),
		@PeriodID_MA as varchar(50),
		@InheritTableID as varchar(50),
		@DepMonths as int,
		@CountMonth Decimal(28,8),
		@DBeginDate as Decimal(28,8),
		@BeginDate as datetime,
		@AdministrativeExpenses as decimal(28,8),
		@ContractNo as varchar(50)

	DELETE FROM AT0422 WHERE  DivisionID =@DivisionID AND TranMonth =@TranMonth AND TranYear = @TranYear
	---------- Lay cach thuc lam tron cua he thong --------------------
	Set @ConvertedDecimals = (select top 1 ConvertedDecimals From AT1101 WITH (NOLOCK) Where DivisionID = @DivisionID)

	Set @ConvertedDecimals =isnull(@ConvertedDecimals,0)
	------------------------------------------------------------------------------------------
	SET @Job_cur = Cursor Scroll KeySet FOR 
		Select 		T1.JobID, T1.ConvertedAmount, T1.ResidualValue, T1.CreditAccountID, T1.DebitAccountID, T1.Periods, T1.ResidualMonths, 
				T1.BeginMonth, T1.BeginYear, T1.Ana01ID, T1.Ana02ID, T1.Ana03ID, T1.Ana04ID,  T1.Ana05ID, T1.Ana06ID, T1.Ana07ID, T1.Ana08ID, T1.Ana08ID, T1.Ana10ID, 
				T1.ObjectID, T1.SerialNo, T1.InvoiceNo, T1.InvoiceDate, T1.UseStatus, T1.PeriodID,T1.ApportionAmount, 
				(Select Top 1 CurrencyID From AT9000 WITH (NOLOCK) Where VoucherID = T1.VoucherID And TransactionID = T1.TransactionID and AT9000.DivisionID = @DivisionID) As CurrencyID,
				--(Select Top 1 ExchangeRate From AT9000 WITH (NOLOCK) Where VoucherID = T1.VoucherID And TransactionID = T1.TransactionID and AT9000.DivisionID = @DivisionID) As ExchangeRate,
				T2.ExchangeRate,
				Isnull(IsMultiAccount,0),T1.InheritTableID,ISNULL(T1.DepMonths,0) as DepMonths,T1.BeginDate,T2.AdministrativeExpenses,T1.ContractNo
		From 	AT0421 T1 WITH (NOLOCK)
		LEFT JOIN CT0155 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.ContractNo = T2.ContractNo
		Where 	T1.DivisionID = @DivisionID
			--And (BeginMonth + BeginYear*100)<= (@TranMonth + @TranYear*100)
			AND (MONTH(T1.BeginDate) + YEAR(T1.BeginDate) *100) <= (@TranMonth + @TranYear*100)
			And T1.D_C =@D_C
			--And T1.UseStatus not In (8,9)
			And T1.JobID Like @JobIDInput
		
	OPEN	@Job_cur
	FETCH NEXT FROM @Job_cur INTO  @JobID, @ConvertedAmount, @ResidualValue, @CreditAccountID, @DebitAccountID, @Periods, @ResidualMonths, 
						@BeginMonth, @BeginYear, @Ana01ID, @Ana02ID, @Ana03ID, @Ana04ID, @Ana05ID, @Ana06ID, @Ana07ID, @Ana08ID, @Ana09ID, @Ana10ID, 
						@ObjectID, @SerialNo, @InvoiceNo, @InvoiceDate, @UseStatus, @PeriodID,@ApportionAmount, @CurrencyID, @ExchangeRate, @IsMultiAccount
						,@InheritTableID,@DepMonths,@BeginDate,@AdministrativeExpenses,@ContractNo

	WHILE @@Fetch_Status = 0
		Begin	
			SET @ResidualValue = @ConvertedAmount - isnull((Select Sum(isnull(DepAmount,0)) From AT0422 WITH (NOLOCK) Where DivisionID =@DivisionID and JobID = @JobID),0)
			SET @ResidualMonths = @Periods - isnull((Select Count(*) From (Select 1 as A From AT0422 WITH (NOLOCK) Group By DivisionID, TranMonth, TranYear, JobID Having JobID =@JobID and DivisionID =@DivisionID) T ),0)

			If(@InheritTableID = 'AT0420') AND @ResidualMonths = @Periods
				BEGIN
					DECLARE @Area decimal(28,8) = 
					(SELECT Area FROM (SELECT T1.ContractNo,SUM(T3.Area) as Area
						FROM CT0155 T1 WITH (NOLOCK)
						LEFT JOIN CT0156 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster
						LEFT JOIN AT0416 T3 WITH (NOLOCK) ON T3.DivisionID IN (T2.DivisionID, '@@@') AND T2.PlotID = T3.StoreID
						WHERE T1.DivisionID =@DivisionID AND T1.ContractNo = @ContractNo
						GROUP BY T1.ContractNo) as P)

					IF(MONTH(@BeginDate) IN (1,3,5,7,8,10,12))
						SET @DBeginDate = 31
					ELSE IF (MONTH(@BeginDate) IN (4,6,9,11))
						SET @DBeginDate = 30
					ELSE IF (MONTH(@BeginDate)= 2)
					BEGIN
						IF(YEAR(@BeginDate) % 4 =0)
							SET @DBeginDate = 29
						ELSE
							SET @DBeginDate = 28
					END
					SET @CountMonth = (@DBeginDate -DAY(@BeginDate)+1)/@DBeginDate
					Set @TempDepAmount = @CountMonth * @Area * @AdministrativeExpenses * @ExchangeRate
				END
			ELSE
			BEGIN
				If @ResidualMonths <> 0 
					Set @TempDepAmount = Round (@ResidualValue/@ResidualMonths,@ConvertedDecimals)
				Else 
					Set @TempDepAmount  =0
			END
			If @ResidualValue >=@TempDepAmount
				Begin
					-- xu ly phat hien ky cuoi cung
					If  @ResidualMonths - 1 = 0
						Begin
				  			Set @DepAmount = @ResidualValue
							Set @UseStatus = 9
						End
					Else 
						Begin
							Set @DepAmount = @TempDepAmount
							Set @UseStatus = 1
						End
				End
			Else    
				Begin
					Set @DepAmount = @ResidualValue		
					Set @UseStatus = 1
				End

				--PRINT @DepAmount
			IF @DepAmount >0 AND @ResidualMonths >0
				Begin	
					Select @DepOriginalAmount = 	Case When Operator <> 0 Then Round(@DepAmount * ExchangeRate,ExchangeRateDecimal) 
									Else 
										Case When ExchangeRate <> 0 Then Round(@DepAmount / ExchangeRate,ExchangeRateDecimal) Else 0 End 
									End
					From AT1004 WITH (NOLOCK) Where CurrencyID = @CurrencyID
				
					SET @DepreciationID = NEWID()
							
					Insert AT0422 (
					DepreciationID, VoucherNo, VoucherDate, TranMonth, TranYear,
					DivisionID, Status, CreditAccountID, DebitAccountID, DepAmount,
					Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID, VoucherTypeID, Description,
					JobID , CreateDate, CreateUserID, LastModifyDate, LastModifyUserID,D_C, ObjectID, SerialNo, InvoiceNo, InvoiceDate,PeriodID, CurrencyID, ExchangeRate, DepOriginalAmount)
					Values (
					@DepreciationID, @VoucherNo, @VoucherDate, @TranMonth, @TranYear,
					@DivisionID, 0, @CreditAccountID, @DebitAccountID, @DepAmount,
					@Ana01ID, @Ana02ID, @Ana03ID, @Ana04ID,  @Ana05ID, @Ana06ID, @Ana07ID, @Ana08ID, @Ana09ID,  @Ana10ID,  @VoucherTypeID, @BDescription,
					@JobID, getdate(), @UserID, getdate(), @UserID,@D_C, @ObjectID, @SerialNo, @InvoiceNo, @InvoiceDate, @PeriodID, @CurrencyID, @ExchangeRate, @DepOriginalAmount)

					Update AT0421  Set UseStatus = @UseStatus Where JobID =@JobID and DivisionID = @DivisionID				
				End

		    If(@ResidualMonths = @Periods)
			BEGIN			
				  UPDATE AT0421
				  SET FirstMonthValue = @DepAmount
				  WHERE DivisionID = @DivisionID AND JobID= @JobID
			END
	
			FETCH NEXT FROM @Job_cur INTO  @JobID, @ConvertedAmount, @ResidualValue, @CreditAccountID, @DebitAccountID, @Periods, @ResidualMonths, 
						@BeginMonth, @BeginYear, @Ana01ID, @Ana02ID, @Ana03ID, @Ana04ID,  @Ana05ID, @Ana06ID, @Ana07ID, @Ana08ID, @Ana09ID, @Ana10ID, 
						@ObjectID, @SerialNo, @InvoiceNo, @InvoiceDate, @UseStatus,@PeriodID,@ApportionAmount, @CurrencyID, @ExchangeRate, @IsMultiAccount
						,@InheritTableID,@DepMonths,@BeginDate,@AdministrativeExpenses,@ContractNo
		End
	
	
	Close @Job_cur
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

