IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0077]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0077]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--Created by Hoàng Trúc , Date 03/09/2019     
---- Modified by Khánh Đoan on 10/10/2019 : Bổ sung nếu không khai báo hạn mức công mức không  kiểm tra công nợ
---- Modified by Văn Minh on 01/11/2019 : Bổ sung kiểm tra CreditAccountID và thêm CreditAccountID vào Store
---- Modified by Văn Minh on 02/01/2020 : Bỏ kiểm tra kiểu cũ - Bổ sung kiểm tra có thiết lập bên CI
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
--Purpose: Kiem tra cong no khach hang (Phiếu thu)

CREATE PROCEDURE AP0077
(
	@DivisionID NVARCHAR(50), 
	@ObjectID NVARCHAR(50),	
	@CurrencyID NVARCHAR(50),
	@VoucherID VARCHAR(250)='',
	@NewOriginalAmount DECIMAL (28,8),
	@CreditAccountID VARCHAR(50) = '',
	@Status TINYINT ---0: xoa 
                    ---1: sua
)				
AS
DECLARE @ReAccountID NVARCHAR(50),
		@ReceivedAmount MONEY,
		@MaxReceivedAmount MONEY,
	    @OriginalAmount	DECIMAL (28,8),		
	    @Message NVARCHAR(250) = '',
		@CustomerName NVARCHAR(250)


SELECT @CustomerName = CustomerName from CustomerIndex

SELECT @ReAccountID = ReAccountID FROM AT1202 WITH (NOLOCK) WHERE DivisionID IN (@DivisionID, '@@@') AND ObjectID = @ObjectID
SET @ReAccountID = ISNULL(@ReAccountID, '131')

IF (@ReAccountID <> @CreditAccountID AND @CustomerName = 13)
BEGIN
	GOTO EndMess
END

IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WITH (NOLOCK) WHERE ID = OBJECT_ID(N'tempdb.dbo.#TAM')) 
	DROP TABLE #TAM	
SELECT 	VoucherID, BatchID, TableID, CurrencyIDCN, VoucherDate, DebitAccountID AccountID, ---- PHAT SINH NO
	SUM(ISNULL(OriginalAmountCN, 0)) OriginalAmount, 'D' D_C , DueDate
INTO #TAM
FROM AT9000 WITH (NOLOCK) 
WHERE DivisionID = @DivisionID AND ObjectID = @ObjectID 
AND ISNULL(DebitAccountID, '') = @ReAccountID AND CurrencyIDCN = @CurrencyID 
AND DebitAccountID IN (SELECT AccountID FROM AT1005 WITH (NOLOCK) WHERE GroupID = 'G03')
GROUP BY VoucherID, BatchID, TableID, CurrencyIDCN, VoucherDate, DebitAccountID  , DueDate		  

UNION ALL

SELECT VoucherID, BatchID, TableID, CurrencyIDCN, VoucherDate, CreditAccountID AccountID,	---- PHAT SINH CO
	SUM(ISNULL(OriginalAmountCN, 0) * -1)OriginalAmount, 'C' D_C , DueDate
FROM AT9000 WITH (NOLOCK) 
WHERE DivisionID = @DivisionID 
AND (CASE WHEN TransactionTypeID = 'T99' THEN CreditObjectID ELSE ObjectID END) = @ObjectID
AND ISNULL(CreditAccountID, '') = @ReAccountID 
AND CurrencyIDCN = @CurrencyID 
AND CreditAccountID IN (SELECT AccountID FROM AT1005 WITH (NOLOCK) WHERE GroupID = 'G03')
GROUP BY VoucherID, BatchID, TableID, CurrencyIDCN, VoucherDate, CreditAccountID , DueDate

----- Buoc 1: Lay so du no den hien tai.------------------------------------
--SELECT @ReceivedAmount = ISNULL(SUM(ISNULL(OriginalAmount, 0)), 0) 
--FROM #TAM

---- Buoc 2: Lay muc han no (so tien) --------------
SELECT @MaxReceivedAmount = ReCreditLimit 
FROM AT1202 WITH (NOLOCK)
WHERE DivisionID IN (@DivisionID, '@@@') AND ObjectID = @ObjectID

----Buoc 3 : 
select @OriginalAmount = isnull(sum(isnull(OriginalAmount,0)),0)
from #TAM
where  VoucherID <> @VoucherID

---- Buoc 4: So sanh so thuc te va so han muc-------------------------------------
IF (@Status = 1 AND ISNULL(@OriginalAmount - @NewOriginalAmount , 0) > @MaxReceivedAmount)
	BEGIN
		SET @Status = 1----Truong hop khi sua->luu phieu thu
		SET @Message = 'OFML000288'
		GOTO EndMess
	END	

	PRINT @OriginalAmount
	PRINT @MaxReceivedAmount
IF (@Status = 0 AND ISNULL(@OriginalAmount, 0) > @MaxReceivedAmount)
	BEGIN
		SET @Status = 0
		SET @Message = 'OFML000289'----Truong hop khi xoa phieu thu
		GOTO EndMess
	END	

--PRINT @Status
--PRINT @Message
---- Buoc 4: Tra ra ket qua ----------------------------------------
EndMess:
SELECT @Status [Status], @Message [Message]


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
