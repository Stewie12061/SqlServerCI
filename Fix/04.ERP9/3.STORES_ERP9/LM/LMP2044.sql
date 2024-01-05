IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP2044]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP2044]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Xử lý khi xóa Điều chỉnh lịch trả nợ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 03/08/2017 by Bảo Anh
----Modify on
-- <Example>
/*  
 EXEC LMP2044 'AS','3154c0de-02e7-4987-b97f-6957865e213c','ASOFTADMIN'
*/

CREATE PROCEDURE LMP2044 ( 
        @DivisionID VARCHAR(50),
		@VoucherID VARCHAR(50),
		@UserID VARCHAR(50)
) 
AS 
DECLARE @FromDate DATETIME,
		@AdjustTypeID TINYINT,
		@DisburseVoucherID VARCHAR(50),
		@AdjustFromDate DATETIME,
		@BeforeOriginalAmount DECIMAL(28,8),
		@AdjustRate DECIMAL(28,8),
		@RateBy TINYINT, --- 0: theo tháng; 1: theo năm
		@ExchangeRate DECIMAL(28,8)
	
SELECT @FromDate = AdjustFromDate, @AdjustTypeID = AdjustTypeID, @DisburseVoucherID = DisburseVoucherID
FROM LMT2041 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID

IF @AdjustTypeID = 1
BEGIN
	--- Xóa chứng từ thanh toán trả trước
	DELETE LMT2031
	WHERE DivisionID = @DivisionID AND DisburseVoucherID = @DisburseVoucherID AND ActualDate >= @FromDate AND PaymentType = 0 AND IsPrePayment = 1

	--- Update lại trạng thái của khoản tiền lãi trong lịch trả nợ
	UPDATE LMT2022
	SET IsNotPayment = 0
	WHERE DivisionID = @DivisionID AND DisburseVoucherID = @DisburseVoucherID AND PaymentDate >= @FromDate AND PaymentType = 1 AND IsNotPayment = 1
END

--- Tính lại tiền lãi
SELECT TOP 1	@AdjustTypeID = AdjustTypeID, @AdjustFromDate = AdjustFromDate, @BeforeOriginalAmount = BeforeOriginalAmount,
				@AdjustRate = AdjustRate, @RateBy = RateBy, @ExchangeRate = ExchangeRate
FROM LMT2041 WITH (NOLOCK)
WHERE DivisionID = @DivisionID AND DisburseVoucherID = @DisburseVoucherID AND VoucherID <> @VoucherID
ORDER BY VoucherDate DESC

IF @AdjustTypeID IS NOT NULL	--- nếu có phiếu điều chỉnh trước thì tính lãi theo phiếu này
	EXEC LMP2042 @DivisionID, @DisburseVoucherID, @AdjustFromDate, @AdjustTypeID, @BeforeOriginalAmount, @AdjustRate, @RateBy, @ExchangeRate, @UserID
ELSE	--- tính lãi theo chứng từ giải ngân
	EXEC LMP2022 @DivisionID, @DisburseVoucherID, @UserID



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

