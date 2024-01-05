IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP2006]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP2006]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Kiểm tra số tiền giải chấp lớn hơn số tiền còn lại hay không
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 20/10/2017 by Hải Long
----Modify on 14/01/2019: Bổ sung trả ra các tài sản đã kiểm tra
-- <Example>
/*  
 EXEC LMP2006 @DivisionID = 'AS',@UserID = 'ASOFTADMIN', @XML=''
*/
----
CREATE PROCEDURE [LMP2006]
( 
	@DivisionID NVARCHAR(50),
	@UserID NVARCHAR(50),
	@XML XML	
) 
AS

SELECT	X.Data.query('Row').value('.', 'INT') AS Row,
		X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,	
		X.Data.query('AssetID').value('.', 'NVARCHAR(50)') AS AssetID,			
		X.Data.query('ConvertedAmount').value('.', 'DECIMAL') AS ConvertedAmount		
INTO #TEMP		
FROM @XML.nodes('//Data') AS X (Data)

IF EXISTS
(
	SELECT TOP 1 1
	FROM
	(
		SELECT DivisionID, AssetID, SUM(ConvertedAmount) AS ConvertedAmount
		FROM #TEMP
		GROUP BY DivisionID, AssetID 	
	) TB1 
	INNER JOIN LMT1020 WITH (NOLOCK) ON TB1.DivisionID = LMT1020.DivisionID AND TB1.AssetID = LMT1020.AssetID
	LEFT JOIN
	(
		SELECT LMT2003.DivisionID, LMT2003.AssetID, SUM(LMT2003.ConvertedAmount - ISNULL(LMT2061.UnwindAmount, 0)) AS ConvertedAmount 
		FROM LMT2003 WITH (NOLOCK)
		LEFT JOIN LMT2061 WITH (NOLOCK) ON LMT2003.DivisionID = LMT2061.DivisionID AND LMT2003.TransactionID = LMT2061.LoanTransactionID AND LMT2003.VoucherID = LMT2061.LoanVoucherID
		GROUP BY LMT2003.DivisionID, LMT2003.AssetID
	) TB2 ON TB2.DivisionID = TB1.DivisionID AND TB2.AssetID = TB1.AssetID
	WHERE TB1. ConvertedAmount > (LMT1020.LoanLimitAmount - ISNULL(TB2.ConvertedAmount, 0))
)
BEGIN
	SELECT 1 AS Status
END
ELSE
BEGIN
	SELECT 0 AS Status	
END


SELECT Distinct TB1.DivisionID, TB1.AssetID, TB2.VoucherNo
	FROM
	(
		SELECT DivisionID, AssetID, SUM(ConvertedAmount) AS ConvertedAmount
		FROM #TEMP
		GROUP BY DivisionID, AssetID 	
	) TB1 
	INNER JOIN LMT1020 WITH (NOLOCK) ON TB1.DivisionID = LMT1020.DivisionID AND TB1.AssetID = LMT1020.AssetID --- Danh mục TS thế chấp
	INNER JOIN
	(
		SELECT LMT2003.DivisionID, LMT2003.AssetID, T01.VoucherNo, SUM(LMT2003.ConvertedAmount - ISNULL(LMT2061.UnwindAmount, 0)) AS ConvertedAmount 
		FROM LMT2003 WITH (NOLOCK)
		INNER JOIN LMT2001 T01 WITH (NOLOCK) ON T01.VoucherID = LMT2003.VoucherID
		LEFT JOIN LMT2061 WITH (NOLOCK) ON LMT2003.DivisionID = LMT2061.DivisionID AND LMT2003.TransactionID = LMT2061.LoanTransactionID AND LMT2003.VoucherID = LMT2061.LoanVoucherID
		GROUP BY LMT2003.DivisionID, LMT2003.AssetID, T01.VoucherNo
	) TB2 ON TB2.DivisionID = TB1.DivisionID AND TB2.AssetID = TB1.AssetID


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

