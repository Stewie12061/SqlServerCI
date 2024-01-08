IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP2042_1]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP2042_1]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Kiểm tra đã tồn tại chứng từ thanh toán trước khi điều chỉnh lịch trả nợ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 25/01/2019 by Như Hàn
----Modify on
-- <Example>
/*  

EXEC LMP2042_1 @DivisionID = 'AIC', @DisburseVoucherID = '2638dc7b-099b-3e82-7d59-f27e5298c7bb'
 
*/

CREATE PROCEDURE LMP2042_1 ( 
        @DivisionID VARCHAR(50),
		@DisburseVoucherID VARCHAR(50)
) 
AS 

IF EXISTS 
(SELECT TOP 1 1 
FROM LMT2031 T31 WITH (NOLOCK)
INNER JOIN LMT2022 T22 WITH (NOLOCK) ON T31.InheritTransactionID = T22.TransactionID
WHERE T22.DisburseVoucherID = @DisburseVoucherID AND T31.DivisionID = @DivisionID) 

SELECT 1 As Status


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

