﻿IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP2061]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP2061]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Edit Form LMP2061 Cập nhật giải chấp tài sản
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 25/10/2017 by Bảo Anh
----Modify by ...
-- <Example>
/*  
	EXEC LMP2061 @DivisionID = 'AS', @VoucherID = 'ABCDEF'
*/
----
CREATE PROCEDURE [LMP2061] 
( 
	@DivisionID NVARCHAR(50),
	@UserID NVARCHAR(50),	
	@VoucherID NVARCHAR(50),
	@Mode TINYINT -- 0: Load Master, 1: Load Detail	
) 
AS

DECLARE	@sSQL VARCHAR (MAX)

IF @Mode = 0
BEGIN
	-- Lấy thông tin master
	SET @sSQL = '
	SELECT LMT2060.*, LMT2001.VoucherNo	AS LoanVoucherNo, LMT2001.FromDate, LMT2001.ToDate, LMT2001.ConvertedAmount AS LoanConvertedAmount
	FROM LMT2060 WITH (NOLOCK)
	LEFT JOIN LMT2001 WITH (NOLOCK) ON LMT2060.DivisionID = LMT2001.DivisionID And LMT2060.LoanVoucherID = LMT2001.VoucherID
	WHERE LMT2060.DivisionID = ''' + @DivisionID + '''
	AND LMT2060.VoucherID = ''' + @VoucherID + ''''	
END
ELSE
BEGIN
	-- Lấy thông tin detail
	SET @sSQL = '
	SELECT LMT2061.*, LMT2003.SourceID, LMT0099.[Description] as SourceName, LMT2003.AssetID, LMT1020.AssetName, LMT2003.ConvertedAmount AS MortgageAmount,
	LMT1020.AccountingValue, LMT1020.LoanLimitRate, LMT1020.LoanLimitAmount, LMT1020.EvaluationValue,	
	A11.AnaName as Ana01Name, A12.AnaName as Ana02Name, A13.AnaName as Ana03Name, A14.AnaName as Ana04Name, A15.AnaName as Ana05Name,
	A16.AnaName as Ana06Name, A17.AnaName as Ana07Name, A18.AnaName as Ana08Name, A19.AnaName as Ana09Name, A20.AnaName as Ana10Name,
	LMT2003.ConvertedAmount - ISNULL(TB.UnwindAmount, 0) AS RemainAmount
	FROM LMT2061 WITH (NOLOCK)
	LEFT JOIN LMT2003 WITH (NOLOCK) ON LMT2003.DivisionID = LMT2061.DivisionID AND LMT2003.TransactionID = LMT2061.LoanTransactionID AND LMT2003.VoucherID = LMT2061.LoanVoucherID
	LEFT JOIN LMT1020 ON LMT1020.SourceID = LMT2003.SourceID And LMT1020.AssetID = LMT2003.AssetID
	LEFT JOIN LMT0099 ON LMT1020.SourceID = LMT0099.ID And LMT0099.CodeMaster = ''LMT00000004''
	LEFT JOIN AT1011 A11 WITH (NOLOCK) ON A11.AnaID  = LMT2003.Ana01ID AND A11.AnaTypeID = ''A01''
	LEFT JOIN AT1011 A12 WITH (NOLOCK) ON A12.AnaID  = LMT2003.Ana02ID AND A12.AnaTypeID = ''A02''
	LEFT JOIN AT1011 A13 WITH (NOLOCK) ON A13.AnaID  = LMT2003.Ana03ID AND A13.AnaTypeID = ''A03''
	LEFT JOIN AT1011 A14 WITH (NOLOCK) ON A14.AnaID  = LMT2003.Ana04ID AND A14.AnaTypeID = ''A04''
	LEFT JOIN AT1011 A15 WITH (NOLOCK) ON A15.AnaID  = LMT2003.Ana05ID AND A15.AnaTypeID = ''A05''
	LEFT JOIN AT1011 A16 WITH (NOLOCK) ON A16.AnaID  = LMT2003.Ana06ID AND A16.AnaTypeID = ''A06''
	LEFT JOIN AT1011 A17 WITH (NOLOCK) ON A17.AnaID  = LMT2003.Ana07ID AND A17.AnaTypeID = ''A07''
	LEFT JOIN AT1011 A18 WITH (NOLOCK) ON A18.AnaID  = LMT2003.Ana08ID AND A18.AnaTypeID = ''A08''
	LEFT JOIN AT1011 A19 WITH (NOLOCK) ON A19.AnaID  = LMT2003.Ana09ID AND A19.AnaTypeID = ''A09''
	LEFT JOIN AT1011 A20 WITH (NOLOCK) ON A20.AnaID  = LMT2003.Ana10ID AND A20.AnaTypeID = ''A10''
	LEFT JOIN
	(
		SELECT LMT2061.DivisionID, LMT2061.LoanVoucherID, LMT2061.LoanTransactionID, SUM(LMT2061.UnwindAmount) AS UnwindAmount 
		FROM LMT2061 WITH (NOLOCK)
		GROUP BY LMT2061.DivisionID, LMT2061.LoanVoucherID, LMT2061.LoanTransactionID
	) TB ON TB.DivisionID = LMT1020.DivisionID AND TB.LoanTransactionID = LMT2003.TransactionID AND TB.LoanVoucherID = LMT2003.VoucherID
	WHERE LMT2061.DivisionID = ''' + @DivisionID + '''
	AND LMT2061.VoucherID = ''' + @VoucherID + ''''	
END	


--PRINT @sSQL
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

