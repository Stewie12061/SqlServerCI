IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP2041]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP2041]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Edit Form LMF2041 Cập nhật phiếu điều chỉnh
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 19/07/2017 by Bảo Anh
----Modify on
-- <Example>
/*  
 EXEC LMP2041 'AS','ABCD'
*/
----
CREATE PROCEDURE LMP2041 ( 
        @DivisionID VARCHAR(50),
		@VoucherID VARCHAR(50)
) 
AS 
DECLARE @sSQL NVARCHAR (MAX)
    
SET @sSQL = N'
	SELECT 	T41.*, T21.VoucherNo as DisburseVoucherNo, T01.VoucherNo as CreditVoucherNo,T99.Description as AdjustTypeName,
			Convert(varchar(20),T21.FromDate,103) + '' - '' + Convert(varchar(20),T21.ToDate,103) as DisFromToDate,
			T04.Operator, T04.ExchangeRateDecimal
	FROM LMT2041 T41 WITH (NOLOCK)
	LEFT JOIN LMT2021 T21 WITH (NOLOCK) ON T41.DivisionID = T21.DivisionID And T41.DisburseVoucherID = T21.VoucherID
	LEFT JOIN LMT2001 T01 WITH (NOLOCK) ON T01.DivisionID = T41.DivisionID And T01.VoucherID = T41.CreditVoucherID
	LEFT JOIN LMT0099 T99 WITH (NOLOCK) ON T41.AdjustTypeID = T99.OrderNo And T99.CodeMaster = ''LMT00000009''
	LEFT JOIN AT1004  T04 WITH (NOLOCK) ON T04.CurrencyID = T21.CurrencyID	
	WHERE T41.DivisionID = ''' + @DivisionID + ''' And T41.VoucherID = ''' + @VoucherID + '''
	'

EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

