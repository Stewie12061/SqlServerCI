IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0069]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0069]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Kiểm tra sửa /xóa xác nhận hoàn thành của BOURBON
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 29/09/2014 by Le Thi Thu Hien
---- Modified by Tiểu Mai on 22/03/2017: Bổ sung kiểm tra dữ liệu đã chuyển chấm công sản phẩm
---- Modified by Kiều Nga on 26/07/2023: Bổ sung kiểm tra dữ liệu chi tiết trong XNHT nếu đã có tick [Đã quyết toán] thì không thể sửa/ xóa
---- Modified by Thành Sang on 09/08/2023: [2023/08/IS/0087] - Bổ sung @SOrderID để check đơn hàng mua kế thừa hết chưa
-- <Example>
---- 
CREATE PROCEDURE OP0069
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),
	@TranMonth AS TINYINT,
	@TranYear AS INT,
	@VoucherID AS NVARCHAR(50),
	@SOrderID AS NVARCHAR(50) = NULL,
	@Mode TINYINT	----0: Sửa
					----1: Xóa	
) 
AS 
DECLARE @Status AS tinyint, 
		@EngMessage as NVARCHAR(2000), 
		@VieMessage as NVARCHAR(2000),
		@CustomerIndex INT = -1,
		@IsExistsPONotInherit INT = -1  -- Nếu tồn tại đơn hàng mua chưa được kế thừa >
										-- @IsExistsPONotInherit = 1: Vẫn cho phép chỉnh sửa. 
										-- @IsExistsPONotInherit = 0: Show cảnh báo


SET @CustomerIndex = (SELECT TOP 1 CustomerName FROM CustomerIndex)

IF (@CustomerIndex = 38) -- BOURBON
BEGIN 
	EXEC OP0069_BBL @DivisionID, @UserID, @TranMonth, @TranYear, @VoucherID, @SOrderID, @Mode
END 
ELSE
BEGIN 
	SELECT 	@Status = 0, 
			@EngMessage = '',
			@VieMessage = ''
	
	IF @Mode = 0
BEGIN 

	IF EXISTS (SELECT TOP 1 1 FROM OT3002 WITH (NOLOCK) WHERE POrderID = @VoucherID AND TransactionID IN (SELECT HT0410.InheritPTransactionID FROM HT0410 WITH (NOLOCK)))
		AND EXISTS (SELECT TOP 1 1 FROM OT3002 WITH (NOLOCK) WHERE POrderID = @VoucherID AND TransactionID NOT IN (SELECT HT0410.InheritPTransactionID FROM HT0410 WITH (NOLOCK)))
	BEGIN
      
		SELECT	@Status = 3, 
				@VieMessage = N'OFML000276',
				@EngMessage = N'OFML000276'
                                                 
		GOTO LB_RESULT
	END
	IF NOT EXISTS (SELECT TOP 1 1 FROM OT3002 WITH (NOLOCK) WHERE POrderID = @VoucherID AND TransactionID NOT IN (SELECT HT0410.InheritPTransactionID FROM HT0410 WITH (NOLOCK)))
	BEGIN
      
		 SELECT	@Status = 1, 
				@VieMessage = N'OFML000267',
				@EngMessage = N'OFML000267'
                                                 
		GOTO LB_RESULT
	END

END
ELSE
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM OT3002 WITH (NOLOCK) WHERE POrderID = @VoucherID AND TransactionID IN (SELECT HT0410.InheritPTransactionID FROM HT0410 WITH (NOLOCK)))
	BEGIN
		 SELECT	@Status = 1, 
				@VieMessage = N'OFML000267',
				@EngMessage = N'OFML000267'
                                                 
		GOTO LB_RESULT
	END
END

	LB_RESULT:
	SELECT @Status AS Status, @EngMessage AS EngMessage, @VieMessage as VieMessage
END 



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
