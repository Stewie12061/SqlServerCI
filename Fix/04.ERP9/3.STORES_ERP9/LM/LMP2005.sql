IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP2005]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP2005]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Đổ nguồn combo mã tài sản thế chấp (gọi từ màn hình LMF2001)
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
 EXEC LMP2005 @DivisionID = 'AS',@UserID = 'ASOFTADMIN', @SourceID='FixAsset'
*/
----
CREATE PROCEDURE [LMP2005]
( 
	@DivisionID NVARCHAR(50),
	@UserID NVARCHAR(50),
	@SourceID NVARCHAR(50)	
) 
AS

DECLARE @sSQL NVARCHAR(MAX)		

SET @sSQL = '
SELECT LMT1020.AssetID, LMT1020.AssetName, LMT0099.[Description] as SourceName, LMT1020.AccountingValue, LMT1020.LoanLimitRate, LMT1020.LoanLimitAmount,
LMT1020.LoanLimitAmount - ISNULL(TB.ConvertedAmount, 0) AS RemainAmount
FROM LMT1020 WITH (NOLOCK)
LEFT JOIN
(
	SELECT LMT2003.DivisionID, LMT2003.AssetID, SUM(LMT2003.ConvertedAmount - ISNULL(LMT2061.UnwindAmount, 0)) AS ConvertedAmount 
	FROM LMT2003 WITH (NOLOCK)
	LEFT JOIN LMT2061 WITH (NOLOCK) ON LMT2003.DivisionID = LMT2061.DivisionID AND LMT2003.TransactionID = LMT2061.LoanTransactionID AND LMT2003.VoucherID = LMT2061.LoanVoucherID
	GROUP BY LMT2003.DivisionID, LMT2003.AssetID
) TB ON TB.DivisionID = LMT1020.DivisionID AND TB.AssetID = LMT1020.AssetID
LEFT JOIN LMT0099 WITH (NOLOCK) ON LMT1020.SourceID = LMT0099.ID And LMT0099.CodeMaster = ''LMT00000004''
WHERE LMT1020.DivisionID = ''' + @DivisionID + '''
AND LMT1020.SourceID = ''' + @SourceID + '''
AND LoanLimitAmount - ISNULL(ConvertedAmount, 0) > 0'

--PRINT @sSQL
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

