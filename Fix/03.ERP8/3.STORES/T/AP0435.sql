IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0435]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0435]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load thông tin giá trị phân bổ tháng đầu tiên
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 28/05/2022 by Kiều Nga
-- <Example>
/*  
 AP0435 @DivisionID, @ContractNo , @Periods, @ConvertedAmount,@InheritTableID
*/
----
CREATE PROCEDURE AP0435 ( 
        @DivisionID VARCHAR(50),
		@ContractNo VARCHAR (50),
		@Periods INT,
		@ConvertedAmount decimal(28,8),
		@InheritTableID VARCHAR (50)
)
AS

Declare  @cur as Cursor,
		 @BeginDate datetime,
		 @AdministrativeExpenses as decimal(28,8),
		 @Area as decimal(28,8),
		 @DBeginDate as decimal(28,8),
		 @CountMonth Decimal(28,8),
		 @TempDepAmount Decimal(28,8),
		 @ExchangeRate Decimal(28,8),
		 @ConvertedDecimals as tinyint

	Set @ConvertedDecimals = (select top 1 ConvertedDecimals From AT1101 WITH (NOLOCK) Where DivisionID = @DivisionID)
	Set @ConvertedDecimals =isnull(@ConvertedDecimals,0)

	SET @cur = Cursor Scroll KeySet FOR 
		Select case when @InheritTableID ='AT0420' then T1.AdministrativeExpensesDate else T1.HandOverDate end as BeginDate,T1.AdministrativeExpenses,T1.ExchangeRate,SUM(T3.Area) as Area
		From 	CT0155 T1 WITH (NOLOCK)
		Left join CT0156 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.APK = T2.APKMaster
		LEFT JOIN AT0416 T3 WITH (NOLOCK) ON T3.DivisionID IN (T2.DivisionID, '@@@') AND T2.PlotID = T3.StoreID
		Where 	T1.DivisionID = @DivisionID AND T1.ContractNo = @ContractNo
		GROUP BY  T1.AdministrativeExpensesDate,T1.HandOverDate,T1.AdministrativeExpenses,T1.ExchangeRate
		
	OPEN	@cur
	FETCH NEXT FROM @cur INTO  @BeginDate, @AdministrativeExpenses, @Area, @ExchangeRate
	WHILE @@Fetch_Status = 0
		Begin	
			If(@InheritTableID = 'AT0420')
				BEGIN
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
					IF(@Periods >0)
						Set @TempDepAmount = Round (@ConvertedAmount/@Periods,@ConvertedDecimals)
					ELSE
						Set @TempDepAmount = 0
				END

			FETCH NEXT FROM @cur INTO @BeginDate, @AdministrativeExpenses, @Area, @ExchangeRate
		End
	Close @cur

	SELECT @TempDepAmount as FirstMonthValue

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
