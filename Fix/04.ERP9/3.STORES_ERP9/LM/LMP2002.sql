IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP2002]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP2002]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Cập nhật trạng thái hợp đồng tín dụng khi xóa chứng từ giải ngân hoặc thanh toán
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
 EXEC LMP2002 'AS','ABCD',0
*/
----
CREATE PROCEDURE LMP2002 ( 
        @DivisionID VARCHAR(50),
		@VoucherID VARCHAR(50),
		@TypeID TINYINT	--- 0: giải ngân, 1: thanh toán
		
) 
AS

DECLARE @Status TINYINT,
		@CreditVoucherID VARCHAR(50)

IF @TypeID = 0
	SELECT @CreditVoucherID = CreditVoucherID FROM LMT2021 Where DivisionID = @DivisionID And VoucherID = @VoucherID
ELSE
	SELECT @CreditVoucherID = CreditVoucherID FROM LMT2031 Where DivisionID = @DivisionID And VoucherID = @VoucherID

--- Nếu không có chứng từ thanh toán nào thì set về Status trước đó là Giải ngân
IF NOT EXISTS (Select 1 From LMT2031 Where DivisionID = @DivisionID And CreditVoucherID = @CreditVoucherID)
	SET @Status = 1

--- Nếu không có chứng từ Giải ngân nào thì set về Status trước đó là tạo mới
IF NOT EXISTS (Select 1 From LMT2021 Where DivisionID = @DivisionID And CreditVoucherID = @CreditVoucherID)
	SET @Status = 0

--- Cập nhật trạng thái
UPDATE LMT2001
SET Status = @Status
WHERE DivisionID = @DivisionID And VoucherID = @CreditVoucherID


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

