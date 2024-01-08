IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP2034]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP2034]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- cập nhật trạng thái hợp đồng tín dụng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 17/07/2017 by Bảo Anh
----Modify on
-- <Example>
/*  
 EXEC LMP2034 'AS','ABCD','',1,8
*/
----
CREATE PROCEDURE LMP2034 ( 
        @DivisionID VARCHAR(50),
		@CreditVoucherID VARCHAR(50)		
) 
AS 
DECLARE @DisburseOAmount DECIMAL(28,8),
		@PaymentOAmount DECIMAL(28,8)
		
--- Lấy tổng tiền giải ngân của hợp đồng
SELECT @DisburseOAmount = SUM(OriginalAmount)
FROM LMT2021 WITH (NOLOCK)
WHERE DivisionID = @DivisionID AND CreditVoucherID = @CreditVoucherID

--- Lấy tổng tiền đã thanh toán của hợp đồng
SELECT @PaymentOAmount = SUM(ActualOriginalAmount)
FROM LMT2031 WITH (NOLOCK)
WHERE DivisionID = @DivisionID AND CreditVoucherID = @CreditVoucherID AND PaymentType = 0

--- Cập nhật trạng thái của hợp đồng nếu đã thanh toán hết
IF @PaymentOAmount = @DisburseOAmount
	UPDATE LMT2001 SET Status = 9 WHERE DivisionID = @DivisionID AND VoucherID = @CreditVoucherID
ELSE
	UPDATE LMT2001 SET Status = 2 WHERE DivisionID = @DivisionID AND VoucherID = @CreditVoucherID


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

