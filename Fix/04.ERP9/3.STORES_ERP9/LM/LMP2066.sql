IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP2066]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP2066]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Cập nhật trạng thái cho danh mục tài sản thế chấp trong trường hợp giải chấp hết
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 20/10/2017 by Hải Long
----Modify on
-- <Example>
/*  
 EXEC LMP2066 @DivisionID = 'AS', @UserID = 'ASOFTADMIN',@VoucherID = 'a92b4c20-1351-43a2-b06c-eec5bd40c7fa'
*/
----
CREATE PROCEDURE [LMP2066] 
( 
	@DivisionID NVARCHAR(50),
	@UserID NVARCHAR(50),
	@VoucherID NVARCHAR(50),
	@Mode Int --0: Luu, 1: Xoa		
) 
AS

SELECT TB1.AssetID
INTO #TEMP
FROM
(
	SELECT DISTINCT LMT2061.DivisionID, LMT2061.AssetID
	FROM LMT2061 WITH (NOLOCK)	
	WHERE LMT2061.DivisionID = @DivisionID
	AND LMT2061.VoucherID = @VoucherID
) TB1
--INNER JOIN
--(
--	SELECT LMT2003.DivisionID, LMT2003.AssetID, SUM(LMT2003.ConvertedAmount) - SUM(LMT2061.UnwindAmount) AS ConvertedAmount 
--	FROM LMT2003 WITH (NOLOCK)
--	INNER JOIN 
--	(SELECT LMT2061.DivisionID, LoanVoucherID, AssetID, SUM(LMT2061.UnwindAmount) AS UnwindAmount
--	FROM LMT2061 WITH (NOLOCK) 
--	INNER JOIN LMT2003 WITH(NOLOCK) ON LMT2003.DivisionID = LMT2061.DivisionID AND LMT2003.TransactionID = LMT2061.LoanTransactionID AND LMT2003.VoucherID = LMT2061.LoanVoucherID
--	GROUP BY LMT2003.DivisionID, LMT2003.AssetID, LoanVoucherID
--	) LMT2061 ON  LMT2003.DivisionID = LMT2061.DivisionID  AND LMT2003.VoucherID = LMT2061.LoanVoucherID
--	HAVING SUM(LMT2003.ConvertedAmount - ISNULL(LMT2061.UnwindAmount, 0)) = 0
--) TB2 ON TB2.DivisionID = TB1.DivisionID AND TB2.AssetID = TB1.AssetID

INNER JOIN
(
	SELECT LMT2003.DivisionID, LMT2003.AssetID, SUM(LMT2003.ConvertedAmount-LMT2061.UnwindAmount) AS ConvertedAmount 
	FROM LMT2003 WITH (NOLOCK)
	INNER JOIN 
	(SELECT LMT2061.DivisionID, LoanVoucherID, LoanTransactionID, SUM(LMT2061.UnwindAmount) AS UnwindAmount
	FROM LMT2061 WITH (NOLOCK) 
	INNER JOIN LMT2003 WITH(NOLOCK) ON LMT2003.DivisionID = LMT2061.DivisionID AND LMT2003.TransactionID = LMT2061.LoanTransactionID AND LMT2003.VoucherID = LMT2061.LoanVoucherID	
	WHERE @Mode = 0 OR (@Mode = 1 AND LMT2061.VoucherID <> @VoucherID)
	GROUP BY LMT2061.DivisionID, LMT2061.LoanTransactionID, LoanVoucherID
	) LMT2061 ON   LMT2003.DivisionID = LMT2061.DivisionID AND LMT2003.TransactionID = LMT2061.LoanTransactionID AND LMT2003.VoucherID = LMT2061.LoanVoucherID	
	GROUP BY LMT2003.DivisionID, LMT2003.AssetID
	HAVING SUM(LMT2003.ConvertedAmount - ISNULL(LMT2061.UnwindAmount, 0)) = 0
) TB2 ON TB2.DivisionID = TB1.DivisionID AND TB2.AssetID = TB1.AssetID

IF EXISTS (SELECT TOP 1 1 FROM #TEMP)
BEGIN
	UPDATE LMT1020
	SET STATUS = 0
	WHERE DivisionID = @DivisionID
	AND AssetID IN (SELECT AssetID FROM #TEMP)	
END 
ELSE
BEGIN
	UPDATE LMT1020
	SET STATUS = 1
	WHERE DivisionID = @DivisionID
	AND AssetID IN (SELECT AssetID FROM LMT2061 WITH (NOLOCK) WHERE VoucherID = @VoucherID)	
END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

