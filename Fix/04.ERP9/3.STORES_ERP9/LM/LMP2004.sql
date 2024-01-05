IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP2004]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP2004]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Xử lý insert dữ liệu vào tab hợp đồng vay - Hợp đồng bảo lãnh và cập nhật trạng thái của tài sản thế chấp
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 20/10/2017 by Hải Long
----Modify on
-- <Example>
/*  
 EXEC LMP2004 @DivisionID = 'AS', @UserID = 'ASOFTADMIN'
*/
----
CREATE PROCEDURE [LMP2004]
( 
	@DivisionID NVARCHAR(50),
	@UserID NVARCHAR(50),
	@VoucherID NVARCHAR(50)	 
) 
AS

DECLARE @ContractOfGuaranteeID AS NVARCHAR(50),
		@OriginalAmount AS DECIMAL(28,8), 		
		@ContractOfGuaranteeAmount AS DECIMAL(28,8),
		@LMT2053Amount AS DECIMAL(28,8),
		@ExchangeRate AS  DECIMAL(28,8),
		@Operator AS TINYINT,
		@OriginalDecimals TINYINT,
		@ConvertedDecimals TINYINT

SELECT @ConvertedDecimals = ConvertedDecimals FROM AT1101 WITH (NOLOCK) WHERE DivisionID = @DivisionID

SELECT TOP 1 @ContractOfGuaranteeID = ContractOfGuaranteeID, @OriginalAmount = OriginalAmount
FROM LMT2001 WITH (NOLOCK)
WHERE DivisionID = @DivisionID
AND VoucherID = @VoucherID 

-- Số tiền hợp đồng bảo lãnh
SELECT @ContractOfGuaranteeAmount = LMT2051.ConvertedAmount - TB.ConvertedAmount,
	   @ExchangeRate = LMT2051.ExchangeRate, @Operator = T04.Operator
FROM LMT2051 WITH (NOLOCK)
LEFT JOIN 
(
	SELECT DivisionID, VoucherID, SUM(ConvertedAmount) AS ConvertedAmount 
	FROM LMT2052 WITH (NOLOCK)
	GROUP BY DivisionID, VoucherID
) TB ON TB.DivisionID = LMT2051.DivisionID AND TB.VoucherID = LMT2051.VoucherID
LEFT JOIN AT1004 T04 WITH (NOLOCK) ON LMT2051.CurrencyID = T04.CurrencyID
WHERE LMT2051.ConvertedAmount - TB.ConvertedAmount > 0	
AND LMT2051.DivisionID = @DivisionID 
AND LMT2051.VoucherID = @ContractOfGuaranteeID

-- Insert dữ liệu vào tab hợp đồng vay - Hợp đồng bảo lãnh
IF ISNULL(@ContractOfGuaranteeID, '') <> ''
BEGIN	
	IF (@ContractOfGuaranteeAmount <= @OriginalAmount)
	BEGIN
		SELECT @LMT2053Amount = @ContractOfGuaranteeAmount
	END	
	ELSE 
	BEGIN
		SET @LMT2053Amount = @OriginalAmount
	END
			
	
	IF NOT EXISTS (SELECT TOP 1 1 FROM LMT2053 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND VoucherID = @ContractOfGuaranteeID AND ContractID = @VoucherID)
	BEGIN
		INSERT INTO LMT2053 (DivisionID, VoucherID, TransactionID, Orders, ContractID, OriginalAmount, ConvertedAmount)
		VALUES (@DivisionID, @ContractOfGuaranteeID, NEWID(), (SELECT MAX(Orders) FROM LMT2053 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND VoucherID = @ContractOfGuaranteeID) + 1,	
		@VoucherID, @LMT2053Amount, CASE WHEN @Operator = 0 THEN @LMT2053Amount * @ExchangeRate ElSE @LMT2053Amount / @ExchangeRate END)

	END
	ELSE
	BEGIN
		UPDATE LMT2053
		SET OriginalAmount = @LMT2053Amount,
		ConvertedAmount = CASE WHEN @Operator = 0 THEN @LMT2053Amount * @ExchangeRate ElSE @LMT2053Amount / @ExchangeRate END
		WHERE DivisionID = @DivisionID 
		AND VoucherID = @ContractOfGuaranteeID 
		AND ContractID = @VoucherID
	END
END

-- Cập nhật trạng thái của tài sản thế chấp
UPDATE LMT1020
SET [Status] = 1
WHERE DivisionID = @DivisionID 
AND AssetID IN (SELECT AssetID FROM LMT2003 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

