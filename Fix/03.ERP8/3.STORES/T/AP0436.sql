IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0436]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0436]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load thông tin mẩu in thông báo khoản thu
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 16/06/2022 by Kiều Nga
-- <Example>
/*  
 AP0436 @DivisionID, @ContractNo , @Periods, @ConvertedAmount,@InheritTableID
*/
----
CREATE PROCEDURE AP0436 ( 
        @DivisionID VARCHAR(50),
		@APK NVARCHAR (50),
		@TypeID INT)
AS

Declare  @cur as Cursor,
		 @FromValue as decimal(28,8),
		 @ToValue as decimal(28,8),
		 @UnitPrice as decimal(28,8),
		 @Quantity as decimal(28,8),
		 @ExchangeRate as decimal(28,8),
		 @PreToValue Decimal(28,8),
		 @Amount Decimal(28,8),
		 @Orders INT,
		 @Content NVARCHAR(MAX),
		 @QuantityTemp as decimal(28,8),
		 @Description NVARCHAR(MAX),
		 @Coefficient Decimal(28,8),
		 @Rate Decimal(28,8)

	CREATE TABLE #AP0436 (
		Orders INT
		,[Description]  NVARCHAR(MAX)
		,Coefficient Decimal(28,8)
		,Quantity  Decimal(28,8)
		,UnitPrice Decimal(28,8)
		,ExchangeRate Decimal(28,8)
		,Amount Decimal(28,8)
		,Notes NVARCHAR(MAX)
	)

	SET @cur = Cursor Scroll KeySet FOR 
	SELECT T1.Orders,T1.FromValue, T1.ToValue, T1.UnitPrice,T3.Quantity,T2.ExchangeRate,T3.[Description],T1.Rate
	FROM CT0158 T1 WITH (NOLOCK)
	LEFT JOIN CT0155 T2 WITH (NOLOCK) ON T1.APKMaster = T2.APK
	LEFT JOIN AT0420 T3 WITH (NOLOCK) ON T3.DivisionID = T2.DivisionID AND T3.ContractNo = T2.ContractNo
	WHERE T2.DivisionID = @DivisionID AND T3.APK = @APK AND T1.TypeID = @TypeID
	ORDER BY T1.Orders
	
	SET @Amount = 0
	SET @PreToValue = 0	

	OPEN	@cur
	FETCH NEXT FROM @cur INTO  @Orders,@FromValue, @ToValue, @UnitPrice,@Quantity,@ExchangeRate,@Description,@Rate
	WHILE @@Fetch_Status = 0 AND (@Quantity - @PreToValue) > 0
		Begin	
			-- Số lượng
		    IF(@Quantity <= @ToValue)
			BEGIN
				SET @QuantityTemp = @Quantity - @PreToValue
			END
			ELSE IF (@Quantity > @ToValue)
			BEGIN
				SET @QuantityTemp = @ToValue - @PreToValue
			END
			SET @PreToValue = @ToValue

			-- Nội dung
			IF(@Orders = 1 )
			BEGIN
				SET @Content = N'Trong định mức / In the norm'
			END
			ELSE
			BEGIN
				SET @Content = N'Vượt định mức từ '+LTRIM(STR(@FromValue))+N' đến '+LTRIM(STR(@ToValue))
									+' / Over rated from '+LTRIM(STR(@FromValue))+' to '+LTRIM(STR(@ToValue))
			END

			SET @Amount = @UnitPrice * @QuantityTemp* @ExchangeRate
			SET @Coefficient = (CASE WHEN @Rate IS NOT NULL THEN  (@Rate + 100)/100 ELSE 0 END)

			INSERT INTO #AP0436 (Orders,[Description],Coefficient,Quantity,UnitPrice,ExchangeRate,Amount,Notes)
			VALUES (@Orders,@Content,@Coefficient,@QuantityTemp,@UnitPrice,@ExchangeRate,@Amount,@Description)

			FETCH NEXT FROM @cur INTO @Orders,@FromValue, @ToValue, @UnitPrice,@Quantity,@ExchangeRate,@Description,@Rate
		End
	Close @cur

	DECLARE @AmountAP0436 decimal(28,8)
	SELECT @AmountAP0436 = SUM(ISNULL(Amount,0)) FROM #AP0436 

	SELECT * FROM #AP0436 ORDER BY Orders
	SELECT @AmountAP0436 as Amount, @AmountAP0436*0.1 as VATConvertedAmount, @AmountAP0436 + @AmountAP0436*0.1 as TotalAmount
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
