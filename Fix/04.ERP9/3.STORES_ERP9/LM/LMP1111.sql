IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP1111]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP1111]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load thông tin cảnh báo ở màn hình Dashboard Asoft-LM
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 30/07/2017 by Bảo Anh
----Modify on
-- <Example>
/*  
 EXEC LMP1111 'AS','01/03/2017'
*/
----
CREATE PROCEDURE LMP1111 ( 
        @DivisionID VARCHAR(50),
		@LoginDate DATETIME		
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@IsWarnPayment BIT,	--- cảnh báo đến hạn thanh toán khoản vay
		@BeforeDays INT,	--- cảnh báo trước bao nhiêu ngày
		@PaymentNums INT,	--- số khoản thanh toán đến hạn
		@Message NVARCHAR(MAX),	--- nội dung cảnh báo
		@FormID VARCHAR(20)	--- mã màn hình được gọi lên khi click vào cảnh báo
   
SET @Message = ''
SET @FormID = ''

SELECT @IsWarnPayment = IsWarnPayment, @BeforeDays = ISNULL(BeforeDays,0)
FROM LMT0001 WITH (NOLOCK) WHERE DivisionID = @DivisionID 

--- cảnh báo đến hạn thanh toán khoản vay
IF @IsWarnPayment = 1
BEGIN
	SELECT @PaymentNums = COUNT(TransactionID)
	FROM LMT2022 WITH (NOLOCK)
	WHERE DivisionID = @DivisionID And (PaymentDate between @LoginDate and dateadd(d,@BeforeDays,@LoginDate))
	AND ISNULL(IsNotPayment,0) = 0
	AND LMT2022.PaymentOriginalAmount - ISNULL((Select SUM(ActualOriginalAmount) From LMT2031 WITH (NOLOCK)
										Where DivisionID = @DivisionID And PaymentPlanTransactionID = LMT2022.TransactionID),0) > 0

	IF @PaymentNums > 0
	BEGIN
		SET @Message = '(' + LTRIM(@PaymentNums) + ')' + ' ' + 'LMFML000014'
		SET @FormID = 'LMF2023'
	END
	GOTO Mess
END

Mess:
SELECT @Message as [Message], @FormID as FormID


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

