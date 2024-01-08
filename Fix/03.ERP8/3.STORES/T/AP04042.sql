IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP04042]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP04042]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Kiểm tra trước khi bỏ giải trừ
-- <Param>
---- Chứng từ đã đi giải trừ tại kỳ khóa sổ thì không cho bỏ giải trừ
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 09/09/2016 by Phương Thảo
---- Modified on 09/09/2016 by Phương Thảo
-- <Example>


CREATE PROCEDURE [dbo].[AP04042] 
		@DivisionID nvarchar(50), 
		@VoucherID nvarchar(50),
		@BatchID AS nvarchar(50),
		@TableID AS  nvarchar(50),
		@ObjectID nvarchar(50),
		@CurrencyID nvarchar(50),
		@AccountID nvarchar(50),
		@Mode Tinyint --0: Phải thu, 1: Phải trả		
 AS

IF (@Mode = 0)
BEGIN
	IF EXISTS (
	 SELECT TOP 1 1
	 FROM	AT0303
	 WHERE	DivisionID = @DivisionID AND DebitVoucherID = @VoucherID 
			AND DebitBatchID = @BatchID AND DebitTableID = @TableID
			AND ObjectID = @ObjectID AND CurrencyID = @CurrencyID 
			AND AccountID = @AccountID
			AND EXISTS (SELECT TOP 1 1 FROM AT9999 WHERE Closing = 1 AND AT0303.GiveUpDate BETWEEN AT9999.BeginDate AND AT9999.EndDate) )
	OR 
		EXISTS (
	 SELECT TOP 1 1
	 FROM	AT0303
	 WHERE	DivisionID = @DivisionID AND CreditVoucherID = @VoucherID 
			AND CreditBatchID = @BatchID AND CreditTableID = @TableID
			AND ObjectID = @ObjectID AND CurrencyID = @CurrencyID 
			AND AccountID = @AccountID
			AND EXISTS (SELECT TOP 1 1 FROM AT9999 WHERE Closing = 1 AND AT0303.GiveUpDate BETWEEN AT9999.BeginDate AND AT9999.EndDate) )
	BEGIN
		SELECT 1 AS Status, 'AFML000414' AS Message
		RETURN
	END
END
ELSE
BEGIN
	IF EXISTS (
	 SELECT TOP 1 1
	 FROM	AT0404
	 WHERE	DivisionID = @DivisionID AND DebitVoucherID = @VoucherID 
			AND DebitBatchID = @BatchID AND DebitTableID = @TableID
			AND ObjectID = @ObjectID AND CurrencyID = @CurrencyID 
			AND AccountID = @AccountID
			AND EXISTS (SELECT TOP 1 1 FROM AT9999 WHERE Closing = 1 AND AT0404.GiveUpDate BETWEEN AT9999.BeginDate AND AT9999.EndDate) )
	OR 
		EXISTS (
	 SELECT TOP 1 1
	 FROM	AT0404
	 WHERE	DivisionID = @DivisionID AND CreditVoucherID = @VoucherID 
			AND CreditBatchID = @BatchID AND CreditTableID = @TableID
			AND ObjectID = @ObjectID AND CurrencyID = @CurrencyID 
			AND AccountID = @AccountID
			AND EXISTS (SELECT TOP 1 1 FROM AT9999 WHERE Closing = 1 AND AT0404.GiveUpDate BETWEEN AT9999.BeginDate AND AT9999.EndDate) )

	BEGIN
		SELECT 1 AS Status, 'AFML000414' AS Message
		RETURN
	END

END
	
	SELECT 0 AS Status, '' AS Message
	



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

