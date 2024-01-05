IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP2026]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP2026]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



----- Created on 17/07/2017 by Bảo Anh
----- Kiểm tra tổng số tiền thanh toán trong lịch trả nợ có vượt quá Số tiền đã giải ngân
----- EXEC [LMP2026] 'AS','ABCD','',1000000

CREATE PROCEDURE [dbo].[LMP2026]
				@DivisionID varchar(50),
				@DisburseVoucherID varchar(50),
				@TransactionID varchar(50) = '', --- '': addnew; khác '': edit
				@PaymentOriginalAmount Decimal(28,8)

AS

Declare @Status as tinyint,
		@Message as nvarchar(250),
		@DisburseOAmount Decimal(28,8),	--- Số tiền giải ngân
		@PaymentOAmount Decimal(28,8),	--- Tổng số tiền thanh toán trong lịch trả nợ
		@OldPaymentOAmount Decimal(28,8)

Select @Status =0, 	@Message =''

SELECT @DisburseOAmount = OriginalAmount
FROM LMT2021 WITH (NOLOCK)
WHERE DivisionID = @DivisionID
AND VoucherID = @DisburseVoucherID

SELECT @OldPaymentOAmount = PaymentOriginalAmount
FROM LMT2022 WITH (NOLOCK)
WHERE DivisionID = @DivisionID
AND TransactionID = @TransactionID

SELECT @PaymentOAmount = SUM(PaymentOriginalAmount)
FROM LMT2022 WITH (NOLOCK)
WHERE DivisionID = @DivisionID
AND DisburseVoucherID = @DisburseVoucherID

IF ISNULL(@TransactionID,'') <> ''
BEGIN
	SELECT @PaymentOAmount = @PaymentOAmount - Isnull(@OldPaymentOAmount,0) + @PaymentOriginalAmount
END

IF @PaymentOAmount > @DisburseOAmount
BEGIN
	SET @Status = 1
	SET @Message = 'LMFML000010'
	GOTO EndMess
END
-------------------------------------------------------------------

EndMess:
	Select @Status as Status, @Message as Message



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

