IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0035]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0035]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- AP0035
-- <Summary>
---- Stored cập nhật tỉ giá USD (PACIFIC)
---- Created on 10/04/2017 Hải Long
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- [ASOFT-T] - Nghiệp vụ - Tiền tại quỹ - Cập nhật tỉ giá
-- <History>
---- Modified on 11/08/2014 by 
-- <Example>
----

CREATE PROCEDURE [DBO].[AP0035]
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),		
	@TranMonth AS INT,
	@TranYear AS INT,
	@ExchangeRate AS DECIMAL(28),
	@ExchangeDate AS DATETIME
) 
AS

-- Loại bỏ giờ phút giây
SET @ExchangeDate = CONVERT(DATE, @ExchangeDate)

IF EXISTS (SELECT TOP 1 1 FROM AT1012 WHERE DivisionID = @DivisionID AND TranMonth = @TranMonth AND TranYear = @TranYear AND CurrencyID = 'USD' AND ExchangeDate = @ExchangeDate)
BEGIN
	DELETE AT1012
	WHERE DivisionID = @DivisionID 
	AND TranMonth = @TranMonth 
	AND TranYear = @TranYear 
	AND CurrencyID = 'USD' 
	AND ExchangeDate = @ExchangeDate
	
	INSERT INTO AT1012 (DivisionID, ExchangeRateID, CurrencyID, ExchangeRate, TranMonth, TranYear, ExchangeDate, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, IsDefault)
	VALUES (@DivisionID, NEWID(), 'USD', @ExchangeRate, @TranMonth, @TranYear, @ExchangeDate, @UserID, GETDATE(), @UserID, GETDATE(), 0)
END
ELSE
BEGIN
	INSERT INTO AT1012 (DivisionID, ExchangeRateID, CurrencyID, ExchangeRate, TranMonth, TranYear, ExchangeDate, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, IsDefault)
	VALUES (@DivisionID, NEWID(), 'USD', @ExchangeRate, @TranMonth, @TranYear, @ExchangeDate, @UserID, GETDATE(), @UserID, GETDATE(), 0)
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
