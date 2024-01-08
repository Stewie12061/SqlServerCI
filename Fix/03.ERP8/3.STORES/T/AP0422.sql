IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0422]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0422]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Tính khoản thu lô đất
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
-- <History>
----Created by: Kiều Nga, Date: 06/04/2022
----Modify by: Kiều Nga, Date: 14/04/2022 : Thay đổi cột số lượng của phí quản lý lấy theo thông tin diện tích
----Modify by: Kiều Nga, Date: 28/09/2022 : Bổ sung cho phép chỉnh sửa ngày tính PQL tại màn hình các khoản thu lô đất
----Modify by: Kiều Nga, Date: 05/01/2023 : Lấy giá trị thay đổi ngày tính PQL,đơn giá PQL ở màn hình tính khoản thu
----Modify by: Kiều Nga, Date: 09/01/2023 : Điều chỉnh cách tính số tiền = Tổng cộng phí + Lãi phí - Giảm giá
----Modify by: Kiều Nga, Date: 16/01/2023 : [2023/01/IS/0105] Fix lỗi phí quản lý
----Modify by: Kiều Nga, Date: 17/01/2023 :  Bổ sinh tự động voucherno 
----Modify by: Kiều Nga, Date: 07/02/2023 : [2023/02/IS/0029] Thêm 2 cột tiền thuế và số tiền trước thuê tại khoản thu lô đất
----Modify by: Văn Tài,  Date: 23/02/2023 : [2023/02/IS/0081] Điều chỉnh hỗ trợ làm tròn số theo thiết lập Decimals dành cho các cột: Thành tiền, Thuế, tổng cộng.
----Modify by: Văn Tài,  Date: 02/03/2023 : [2023/02/IS/0143] Bổ sung Xử lý chênh lệch 1 / -1 đồng vì ảnh hưởng làm tròn thập phân.
-- <Example>
---- 
/*-- <Example>
		EXEC AP0422 @DivisionID = 'CBD', @UserID = 'ASOFTADMIN', @BlockID = '%',@StoreID='',@CostTypeID='DIEN',@ObjectID = '%',@ContractType = '%',@TranferID = '%',@TranMonth = '2',@TranYear= '2019'

		AP0422 @DivisionID,@UserID,@BlockID,@StoreID,@CostTypeID,@ObjectID,@ContractType,@TranferID,@TranMonth,@TranYear
----*/

CREATE PROCEDURE AP0422 ( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @TranMonth AS INT,
     @TranYear AS INT 	 
)
AS 
Begin

DECLARE @CurTemp CURSOR,
		@Cur CURSOR,
		@CostTypeID VARCHAR(50),
		@ContractNo VARCHAR(50),
		@Quantity Decimal(28,8),
		@TypeID INT,
		@FromValue Decimal(28,8),
		@ToValue Decimal(28,8),
		@UnitPrice Decimal(28,8),
		@ExchangeRate Decimal(28,8),
		@CurrencyID VARCHAR(50),
		@Amount Decimal(28,8),
		@PreToValue Decimal(28,8),
		@OriginalAmount Decimal(28,8),
		@VATGroupID VARCHAR(50),
		@VATRate Decimal(28,8),
		@VoucherNo VARCHAR(50) = '',
		@StringKey1 NVARCHAR(50) = '',
		@StringKey2 NVARCHAR(50) = '',
		@TableName NVARCHAR(50) = '',
		@IncreaseInterestRates Decimal(28,8),
		@DiscountAmount Decimal(28,8),
		@ConvertedDecimal TINYINT

SET @ConvertedDecimal = ISNULL((SELECT TOP 1 ConvertedDecimals FROM AT1101 WITH (NOLOCK) WHERE DivisionID = @DivisionID), 0)

---- Xử lý tính phí điện, nước, nước xả thải ---
SET @CurTemp  = CURSOR SCROLL KEYSET FOR
SELECT T1.VoucherNo,T1.ContractNo,T1.CostTypeID,T1.Quantity,ISNULL(T1.CurrencyID,T2.CurrencyID) as CurrencyID,ISNULL(T1.ExchangeRate,T2.ExchangeRate) as ExchangeRate
,ISNULL(T1.VATGroupID,'T10') as VATGroupID, ISNULL(T1.VATRate,10) as VATRate
,ISNULL(T1.IncreaseInterestRates,0) AS IncreaseInterestRates,ISNULL(T1.DiscountAmount,0) AS DiscountAmount
FROM AT0420 T1 WITH (NOLOCK)
LEFT JOIN CT0155 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.ContractNo = T2.ContractNo
WHERE T1.TranMonth = @TranMonth AND T1.TranYear = @TranYear AND CostTypeID <> 'PQL'
OPEN @curTemp

FETCH NEXT FROM @CurTemp INTO  @VoucherNo,@ContractNo, @CostTypeID,@Quantity,@CurrencyID,@ExchangeRate,@VATGroupID,@VATRate,@IncreaseInterestRates,@DiscountAmount
WHILE @@Fetch_Status = 0
BEGIN
      IF @CostTypeID = 'NUOC' SET @TypeID =1
	  ELSE IF @CostTypeID = 'DIEN' SET @TypeID =2
	  ELSE IF @CostTypeID = 'XLNTHAI' SET @TypeID =3

	  SET @Amount = 0
	  SET @OriginalAmount = 0
	  SET @PreToValue = 0

	  SET @Cur  = CURSOR SCROLL KEYSET FOR
	  SELECT T2.FromValue,T2.ToValue,T2.UnitPrice
	  FROM CT0155 T1 WITH (NOLOCK)
	  INNER JOIN CT0158 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.APK = T2.APKMaster AND T2.TypeID =@TypeID
	  WHERE T1.DivisionID = @DivisionID AND T1.ContractNo = @ContractNo 
	  ORDER BY Orders

	  OPEN @Cur
      FETCH NEXT FROM @Cur INTO  @FromValue, @ToValue,@UnitPrice
	  WHILE @@Fetch_Status = 0 AND (@Quantity - @PreToValue) > 0
	  BEGIN
		    IF(@Quantity <= @ToValue)
			BEGIN
				SET @Amount = @Amount + @UnitPrice * (@Quantity - @PreToValue)* @ExchangeRate
				SET @OriginalAmount = @OriginalAmount + @UnitPrice * (@Quantity - @PreToValue)
			END
			ELSE IF (@Quantity > @ToValue)
			BEGIN
				SET @Amount = @Amount + @UnitPrice * (@ToValue - @PreToValue)* @ExchangeRate
				SET @OriginalAmount = @OriginalAmount + @UnitPrice * (@ToValue - @PreToValue)
			END

			SET @PreToValue = @ToValue

	  FETCH NEXT FROM @Cur INTO @FromValue, @ToValue,@UnitPrice
	  END            
	  CLOSE @Cur
	  DEALLOCATE @Cur

	  IF(ISNULL(@VoucherNo,'') = '')
	  BEGIN
	  		--- Sinh số chứng từ tự động
			SET @StringKey1 = CASE WHEN @TranMonth < 10 THEN '0'+ RTRIM(LTRIM(STR(@TranMonth))) ELSE RTRIM(LTRIM(STR(@TranMonth))) END
			SET @StringKey2 = RTRIM(LTRIM(STR(@TranYear)))
			SET @TableName = CASE WHEN @CostTypeID = 'DIEN' THEN 'AF0423PI03Report'
								  WHEN @CostTypeID = 'NUOC' THEN 'AF0423PI04Report'
								  WHEN @CostTypeID = 'XLNTHAI' THEN 'AF0423PI02Report' END

			DECLARE @Text VARCHAR(50) =(CASE WHEN @CostTypeID = 'DIEN' THEN 'TD'  
										WHEN @CostTypeID = 'NUOC' THEN 'TN'  
										WHEN @CostTypeID = 'XLNTHAI' THEN 'NXT' END) +'-'

			EXEC AP0000 @DivisionID,@VoucherNo Output, @TableName, @StringKey1, @StringKey2, '', 12,0,1,'/'

			SET @VoucherNo = @Text +@VoucherNo
	  END

	  UPDATE AT0420 
	  SET Amount = ROUND(@Amount + @Amount *(@VATRate/100) + @IncreaseInterestRates - @DiscountAmount, @ConvertedDecimal),
		  CurrencyID = @CurrencyID,
		  ExchangeRate = @ExchangeRate,
		  OriginalAmount = @OriginalAmount + @OriginalAmount *(@VATRate/100),
		  VATConvertedAmount =ROUND(@Amount *(@VATRate/100), @ConvertedDecimal),
		  ConvertedAmount = ROUND(@Amount, @ConvertedDecimal),
		  VATGroupID = @VATGroupID,
		  VATRate = @VATRate,                                                  
		  VoucherNo = @VoucherNo
	  WHERE ContractNo = @ContractNo 
			AND CostTypeID = @CostTypeID

FETCH NEXT FROM @curTemp INTO @VoucherNo,@ContractNo, @CostTypeID,@Quantity,@CurrencyID,@ExchangeRate,@VATGroupID,@VATRate,@IncreaseInterestRates,@DiscountAmount
END            
CLOSE @curTemp
DEALLOCATE @curTemp
-----------------------------------------------

DECLARE @CurTemp2 CURSOR,
		@BeginDate Datetime,
		@EndDate Datetime,
		@AdministrativeExpensesDate Datetime,
		@AdministrativeExpenses Decimal(28,8),
		@Area Decimal(28,8),
		@CountMonth Decimal(28,8),
		@ObjectID VARCHAR(50),
		@CostTypeName NVARCHAR(max),
		@DBeginDate Decimal(28,8),
		@DEndDate Decimal(28,8),
		@VATConvertedAmount Decimal(28,8),
		@FromDate Datetime,
		@ToDate Datetime,
		@EndAdministrativeExpensesDate Datetime

---Tính phí quản lý ---------------------------
SET @CurTemp2  = CURSOR SCROLL KEYSET FOR
SELECT T1.ContractNo,T1.ObjectID,T1.BeginDate,T1.EndDate
,(CASE WHEN T4.AdministrativeExpenses IS NOT NULL THEN T4.AdministrativeExpenses ELSE T1.AdministrativeExpenses END) as AdministrativeExpenses
,ISNULL(T4.CurrencyID,T1.CurrencyID) as CurrencyID,ISNULL(T4.ExchangeRate,T1.ExchangeRate) as ExchangeRate
,(CASE WHEN T4.AdministrativeExpensesDate IS NOT NULL THEN T4.AdministrativeExpensesDate ELSE T1.AdministrativeExpensesDate END) as AdministrativeExpensesDate
, ISNULL(T4.IncreaseInterestRates,0) AS IncreaseInterestRates,ISNULL(T4.DiscountAmount,0) AS DiscountAmount
, T4.EndAdministrativeExpensesDate AS EndAdministrativeExpensesDate
,SUM(T3.Area) as Area
FROM CT0155 T1 WITH (NOLOCK)
LEFT JOIN CT0156 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster
LEFT JOIN AT0416 T3 WITH (NOLOCK) ON T3.DivisionID IN (T2.DivisionID, '@@@') AND T2.PlotID = T3.StoreID
LEFT JOIN AT0420 T4 WITH (NOLOCK) ON T4.DivisionID = T1.DivisionID AND T4.ContractNo = T1.ContractNo AND T4.CostTypeID ='PQL' AND T4.TranMonth =@TranMonth AND T4.TranYear =@TranYear 
LEFT JOIN AT0418 T5 WITH (NOLOCK) ON T5.DivisionID = T1.DivisionID AND T5.ContractNo = T1.ContractNo 
WHERE T1.DivisionID =@DivisionID AND T1.ContractType =  3 AND T1.AdministrativeExpensesDate is not null AND T5.ContractNo is null
AND ((MONTH(T1.AdministrativeExpensesDate) <= @TranMonth OR MONTH(T4.AdministrativeExpensesDate) <= @TranMonth) AND (Year(T1.AdministrativeExpensesDate) = @TranYear OR Year(T4.AdministrativeExpensesDate) = @TranYear)) 
OR (Year(T1.AdministrativeExpensesDate) < @TranYear OR Year(T4.AdministrativeExpensesDate) < @TranYear)
GROUP BY T1.ContractNo,T1.ObjectID,T1.BeginDate,T1.EndDate,T1.AdministrativeExpenses,T1.CurrencyID,T1.ExchangeRate,T1.AdministrativeExpensesDate,T4.CurrencyID,T4.ExchangeRate
,T4.AdministrativeExpensesDate,T4.AdministrativeExpenses,T4.IncreaseInterestRates,T4.DiscountAmount,T4.EndAdministrativeExpensesDate

OPEN @curTemp2

FETCH NEXT FROM @CurTemp2 INTO  @ContractNo,@ObjectID,@BeginDate,@EndDate,@AdministrativeExpenses,@CurrencyID,@ExchangeRate,@AdministrativeExpensesDate,@IncreaseInterestRates,@DiscountAmount,@EndAdministrativeExpensesDate,@Area
WHILE @@Fetch_Status = 0
BEGIN
		PRINT @ContractNo
		SET @VATGroupID = 'T10'
		SET @VATRate = 10
		IF(ISNULL(@EndAdministrativeExpensesDate,'') = '') -- Tính PQL theo hợp đồng
		BEGIN
			-- Lấy số ngày trong tháng
			SET @CountMonth = 0
			IF(MONTH(@AdministrativeExpensesDate) IN (1,3,5,7,8,10,12))
				SET @DBeginDate = 31
			ELSE IF (MONTH(@AdministrativeExpensesDate) IN (4,6,9,11))
				SET @DBeginDate = 30
			ELSE IF (MONTH(@AdministrativeExpensesDate)= 2)
			BEGIN
				IF(YEAR(@AdministrativeExpensesDate) % 4 =0)
					SET @DBeginDate = 29
				ELSE
					SET @DBeginDate = 28
			END

			-- Lấy số tháng tính PQL (3 tháng tính 1 lần bắt đầu từ tháng của ngày tính phí)
			-- Lấy thời gian @FromDate của PQL
			IF(MONTH(@AdministrativeExpensesDate) = @TranMonth)
			BEGIN
				SET @CountMonth = (@DBeginDate -DAY(@AdministrativeExpensesDate)+1)/@DBeginDate  + 2
				SET @FromDate = @AdministrativeExpensesDate
			END
			ELSE IF (MONTH(@AdministrativeExpensesDate) < @TranMonth AND Year(@AdministrativeExpensesDate) = @TranYear AND (@TranMonth - MONTH(@AdministrativeExpensesDate)) % 3 =0)
					OR (Year(@AdministrativeExpensesDate) < @TranYear AND (@TranMonth + 12*(Year(@AdministrativeExpensesDate) -@TranYear) - MONTH(@AdministrativeExpensesDate)) % 3 =0)
			BEGIN
				SET @CountMonth = 3
				SET @FromDate = LTRIM(STR(@TranYear)) +'-' +LTRIM(STR(@TranMonth))+'-01'
			END

			-- Lấy thời gian @ToDate của PQL
			IF(MONTH(@AdministrativeExpensesDate) = @TranMonth)
				OR ((MONTH(@AdministrativeExpensesDate) < @TranMonth AND Year(@AdministrativeExpensesDate) = @TranYear AND (@TranMonth - MONTH(@AdministrativeExpensesDate)) % 3 =0))
				OR (Year(@AdministrativeExpensesDate) < @TranYear AND (@TranMonth + 12*(Year(@AdministrativeExpensesDate) -@TranYear) - MONTH(@AdministrativeExpensesDate)) % 3 =0)
			BEGIN
				DECLARE @ToTranMonth INT 
				DECLARE @ToTranYear INT 
				DECLARE @ToDateTemp Datetime
				IF  (@TranMonth + 2) <= 12
				BEGIN
					SET @ToTranMonth = @TranMonth + 2
					SET @ToTranYear = @TranYear
				END
				ELSE IF (@TranMonth + 2) >12
				BEGIN
					SET @ToTranMonth = (@TranMonth + 2) - 12
					SET @ToTranYear = @TranYear + 1
				END

				SET @ToDateTemp = LTRIM(STR(@ToTranYear)) +'-' +LTRIM(STR(@ToTranMonth))+'-01'
				SET @ToDate = DATEADD(d,-1, DATEADD(mm, DATEDIFF(mm, 0 ,@ToDateTemp)+1, 0))
			END

			SET @EndAdministrativeExpensesDate = @ToDate
		END
		ELSE -- Nếu cập nhật ngày kết thúc tính PQL tại màn hình các khoản thu
		BEGIN
			-- Lấy số ngày trong tháng @DBeginDate
			SET @CountMonth = 0
			IF(MONTH(@AdministrativeExpensesDate) IN (1,3,5,7,8,10,12))
				SET @DBeginDate = 31
			ELSE IF (MONTH(@AdministrativeExpensesDate) IN (4,6,9,11))
				SET @DBeginDate = 30
			ELSE IF (MONTH(@AdministrativeExpensesDate)= 2)
			BEGIN
				IF(YEAR(@AdministrativeExpensesDate) % 4 =0)
					SET @DBeginDate = 29
				ELSE
					SET @DBeginDate = 28
			END

			-- Lấy số ngày trong tháng @DEndDate
			IF(MONTH(@EndAdministrativeExpensesDate) IN (1,3,5,7,8,10,12))
				SET @DEndDate = 31
			ELSE IF (MONTH(@EndAdministrativeExpensesDate) IN (4,6,9,11))
				SET @DEndDate = 30
			ELSE IF (MONTH(@EndAdministrativeExpensesDate)= 2)
			BEGIN
				IF(YEAR(@EndAdministrativeExpensesDate) % 4 =0)
					SET @DEndDate = 29
				ELSE
					SET @DEndDate = 28
			END

			-- Lấy số tháng PQL------
			IF(YEAR(@EndAdministrativeExpensesDate) > YEAR(@AdministrativeExpensesDate)) 
			BEGIN
			  SET @CountMonth = (YEAR(@EndAdministrativeExpensesDate) - YEAR(@AdministrativeExpensesDate))*12 + MONTH(@EndAdministrativeExpensesDate) - MONTH(@AdministrativeExpensesDate) -1
			END
			ELSE
			BEGIN
			  SET @CountMonth = MONTH(@EndAdministrativeExpensesDate) - MONTH(@AdministrativeExpensesDate) -1
			END

			SET @CountMonth = @CountMonth +(@DBeginDate -DAY(@AdministrativeExpensesDate)+1)/@DBeginDate +  DAY(@EndAdministrativeExpensesDate)/@DEndDate
			-- Lấy số tháng PQL------------
		END

		-- Insert dữ liệu vào khoản thu lô đất
		IF(@CountMonth > 0)
		BEGIN
			SET @Amount = @CountMonth * @Area * @AdministrativeExpenses * @ExchangeRate
			SET @OriginalAmount = @CountMonth * @Area * @AdministrativeExpenses
			SET @VATConvertedAmount = @Amount *(@VATRate/100)

			SET @CostTypeName = (SELECT Description FROM AT0099 WITH (NOLOCK) WHERE CodeMaster = 'CostTypeID' AND Disabled =0 AND ID ='PQL')

			IF NOT EXISTS (SELECT TOP 1 1 FROM AT0420 T1 WITH (NOLOCK) 
							WHERE T1.DivisionID =@DivisionID AND T1.TranMonth = @TranMonth AND T1.TranYear = @TranYear AND T1.CostTypeID = 'PQL' AND T1.ContractNo = @ContractNo)
			BEGIN
			--- Sinh số chứng từ tự động
			SET @StringKey1 = CASE WHEN @TranMonth < 10 THEN '0'+ RTRIM(LTRIM(STR(@TranMonth))) ELSE RTRIM(LTRIM(STR(@TranMonth))) END
			SET @StringKey2 = RTRIM(LTRIM(STR(@TranYear)))
			EXEC AP0000 @DivisionID,@VoucherNo Output, 'AF0423PIReport', @StringKey1, @StringKey2, '', 12,0,1,'/'

			INSERT INTO AT0420 (DivisionID,VoucherNo,ObjectID,ContractNo,CostTypeID,TranMonth,TranYear,Quantity,Amount,CurrencyID,ExchangeRate,OriginalAmount,AdministrativeExpensesDate,VATGroupID,VATRate
			,CountMonth,VATConvertedAmount,ConvertedAmount,FromDate,ToDate,AdministrativeExpenses,EndAdministrativeExpensesDate,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate,Description)
			VALUES (@DivisionID,'PQL-'+@VoucherNo,@ObjectID,@ContractNo,'PQL',@TranMonth,@TranYear,@Area,@Amount + @VATConvertedAmount,@CurrencyID,@ExchangeRate,@OriginalAmount + @OriginalAmount *(@VATRate/100),@FromDate,@VATGroupID,@VATRate
			,@CountMonth,@VATConvertedAmount,@Amount,@FromDate,@ToDate,@AdministrativeExpenses,@EndAdministrativeExpensesDate,@UserID,GETDATE(),@UserID,GETDATE(), @CostTypeName)
			END
			ELSE
			BEGIN
			UPDATE AT0420
			SET Amount = ROUND(@Amount + @VATConvertedAmount + @IncreaseInterestRates - @DiscountAmount, @ConvertedDecimal),
				Quantity = @Area,
				OriginalAmount = ROUND(@OriginalAmount + @OriginalAmount *(VATRate/100), @ConvertedDecimal),
				AdministrativeExpensesDate = @AdministrativeExpensesDate,
				CountMonth =@CountMonth,
				VATConvertedAmount = ROUND(@VATConvertedAmount, @ConvertedDecimal),
				ConvertedAmount =ROUND(@Amount, @ConvertedDecimal),
				FromDate = @FromDate,
				ToDate = @ToDate,
				AdministrativeExpenses = @AdministrativeExpenses,
				LastModifyUserID = @UserID,
				LastModifyDate = GETDATE()
			WHERE DivisionID =@DivisionID AND TranMonth = @TranMonth AND TranYear = @TranYear AND CostTypeID = 'PQL' AND ContractNo = @ContractNo
			END
		END 
FETCH NEXT FROM @curTemp2 INTO @ContractNo,@ObjectID,@BeginDate,@EndDate,@AdministrativeExpenses,@CurrencyID,@ExchangeRate,@AdministrativeExpensesDate,@IncreaseInterestRates,@DiscountAmount,@EndAdministrativeExpensesDate,@Area
END            
CLOSE @curTemp2
DEALLOCATE @curTemp2

-----------------------------------------------
-- Xử lý chênh lệch 1 / -1 đồng vì ảnh hưởng làm tròn thập phân
UPDATE AT0420
			SET ConvertedAmount = ConvertedAmount + (Amount - (ConvertedAmount + VATConvertedAmount))
WHERE DivisionID = @DivisionID 
		AND TranYear = @TranYear
		AND TranMonth = @TranMonth 
		AND ABS(Amount - (ConvertedAmount + VATConvertedAmount)) =1
	
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
