IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0223]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP0223]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---- Load dữ liệu chênh lệch tỷ giá
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 14/01/2016 by Phương Thảo
---- 
---- Modified on 28/03/2016 by Phương Thảo: Bổ sung TK ngân hàng
-- <Example>EXEC AP0223 1,1
---- 
/*
INSERT INTO AT0999 (UserID, KeyID, Str02, Str03, Str04, Num01)
VALUES ('AS031', '11', '331','111','0000000001',-10000)

EXEC AP0223 'GS','AS031', 0
*/
CREATE PROCEDURE AP0223
(	
	@DivisionID NVarchar(50),
	@UserID NVarchar(50),

	@Mode Tinyint -- 0: Phieu Thu, 1: Phieu Chi
	
) 
AS 

SET NOCOUNT ON

DECLARE @LostAccountID Nvarchar(50),
		@ProfitAccountID NVarchar(50)


SELECT	@LostAccountID = LossExchangeAccID,
		@ProfitAccountID = InterestExchangeAccID
FROM AT0000
-- WHERE DivisionID = @DivsionID



SELECT	KeyID as IdentityBatchID, 
		CASE WHEN @Mode = 0 THEN 
				CASE WHEN Num01 < 0 THEN @LostAccountID ELSE Str02 END
		ELSE 
				CASE WHEN Num01 < 0 THEN Str02 ELSE @LostAccountID END END AS DebitAccountID,
		CASE WHEN @Mode = 0 THEN 
				CASE WHEN Num01 < 0 THEN Str03 ELSE @ProfitAccountID END
		ELSE
				CASE WHEN Num01 < 0 THEN @ProfitAccountID ELSE Str03 END END AS CreditAccountID,
		Str04 AS Object,
		CASE WHEN @Mode = 0 and  Num01 >  0 THEN Str05 	ELSE '' END  AS DebitBankAccountID , 
		CASE WHEN @Mode = 1 and  Num01 >  0  THEN Str05 ELSE '' END  AS CreditBankAccountID,
		0 AS OriginalAmount,		
		ABS(Num01) AS ConvertedAmount		
FROM AT0999 
WHERE UserID = @UserID


DELETE AT0999 WHERE UserID = @UserID





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

