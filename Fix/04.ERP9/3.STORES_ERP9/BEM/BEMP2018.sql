IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BEMP2018]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BEMP2018]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Lấy tỷ giá theo tiền VN Module BEM
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Trương Tấn Thành, Date: 20/07/2020
-- <Example>
---- exec sp_executesql N'EXEC BEMP2018 @DivisionID=''MK'''


Create PROCEDURE [dbo].[BEMP2018]
(
	@DivisionID VARCHAR(50),
	@RequestDate DateTime
)
AS
BEGIN
	DECLARE @CurrentcyIDBEM VARCHAR(50),
			@CurrencyID VARCHAR(50),
			@CurrencyName NVARCHAR(200),
			@ExchangeRate DECIMAL(28,8) = NULL

	SELECT TOP 1 @CurrentcyIDBEM = B.ReportCurrencyID
	FROM BEMT0000 B WITH (NOLOCK)	

	SELECT @CurrencyID = CurrencyID, @CurrencyName = CurrencyName
	FROM AT1004 A WITH (NOLOCK)
	WHERE A.DivisionID = @DivisionID AND A.CurrencyID = @CurrentcyIDBEM

	IF(EXISTS (
		SELECT TOP 1 1 
		FROM AT1012 A WITH (NOLOCK)
		WHERE A.DivisionID = @DivisionID AND A.CurrencyID = @CurrentcyIDBEM AND FORMAT(ExchangeDate,'yyyy-MM-dd 00:00:00:000') = FORMAT(@RequestDate,'yyyy-MM-dd 00:00:00:000'))) 
		BEGIN
			SELECT TOP 1 @ExchangeRate = ExchangeRate 
			FROM AT1012 A WITH (NOLOCK)
			WHERE A.DivisionID = @DivisionID AND A.CurrencyID = @CurrentcyIDBEM  AND FORMAT(ExchangeDate,'yyyy-MM-dd 00:00:00:000') = FORMAT(@RequestDate,'yyyy-MM-dd 00:00:00:000')
			-- PRINT('Lấy theo đúng ngày AT1012')
		END
	ELSE IF (EXISTS (
		SELECT TOP 1 1 
		FROM AT1012 A WITH (NOLOCK)
		WHERE A.DivisionID = @DivisionID AND A.CurrencyID = @CurrentcyIDBEM  AND A.TranMonth = MONTH(@RequestDate) AND A.TranYear = YEAR(@RequestDate))) 
			BEGIN
				SELECT TOP 1 @ExchangeRate = ExchangeRate 
					FROM AT1012 A WITH (NOLOCK)
				WHERE A.DivisionID = @DivisionID AND A.CurrencyID = @CurrentcyIDBEM  AND A.TranMonth = MONTH(@RequestDate) AND A.TranYear = YEAR(@RequestDate)
				ORDER BY ExchangeDate DESC
				-- PRINT('Lấy theo đúng kỳ AT1012')
			END
	ELSE 
		BEGIN
			SELECT  @ExchangeRate = ExchangeRate 
			FROM AT1004 A WITH (NOLOCK)
			WHERE A.DivisionID = @DivisionID AND A.CurrencyID = @CurrentcyIDBEM 
			-- PRINT('Lấy theo CI')
		END

	SELECT @CurrencyID AS CurrencyID, @CurrencyName AS CurrencyName, @ExchangeRate AS ExchangeRate

END






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
