IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP2013]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP2013]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load chi tiết hợp đồng tiền gửi từ nghiệp vụ phong tỏa
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Tiểu Mai on 31/10/2017
----Modify on 12/02/2019 by Như Hàn: Bổ sung giá trị Giá trị đã phong tỏa, Giá trị đã giải tỏa
-- <Example>
/*  
 EXEC LMP2013 'AS',1, 'ABC', '10/11/2017', ''
 EXEC LMP2013 'AS',0, 'ABC', '10/11/2017', ''
*/
----
CREATE PROCEDURE LMP2013 ( 
        @DivisionID VARCHAR(50),
        @AdvanceTypeID TINYINT,
        @VoucherID NVARCHAR(50),		--- LMF4444.VoucherID
        @VoucherDate DATETIME,
        @ClearanceVoucherID NVARCHAR(50) --- LMF2011.VoucherID
)	
AS

DECLARE @sSQL VARCHAR (MAX)

SET @VoucherDate = ISNULL(@VoucherDate,getdate())

IF ISNULL(@AdvanceTypeID,0) = 1
BEGIN 
	SET @sSQL = '
	SELECT	T12.Orders, T12.DepositContractNo, T12.BankID, A02.BankName, T12.EscrowAmount, T12.InterestRate, T12.FromDate, T12.ToDate, T12.InterestAmount,
		T12.EscrowAmount - ISNULL(C.ClearanceAmount,0) AS EndInterestAmount, ISNULL(C.AdvanceDate,T11.AdvanceDate) AS BlockDate
		,T12.InterestRate As EscrowAmounted, C.ClearanceAmount As ClearanceAmounted
	FROM LMT2011 T11 WITH (NOLOCK) 
	LEFT JOIN LMT2012 T12 WITH (NOLOCK) ON T11.DivisionID = T12.DivisionID AND T11.VoucherID = T12.VoucherID
	LEFT JOIN (SELECT DISTINCT BankID, BankName FROM AT1016 A02 WITH (NOLOCK) ) A02 ON A02.BankID  = T12.BankID
	LEFT JOIN (SELECT T11.DivisionID, CreditVoucherID, DepositContractNo, SUM(ISNULL(ClearanceAmount,0)) AS ClearanceAmount, MAX(T11.AdvanceDate) AS AdvanceDate FROM LMT2011 T11 WITH (NOLOCK)
				LEFT JOIN LMT2012 T12 WITH (NOLOCK) ON T11.DivisionID = T12.DivisionID AND T11.VoucherID = T12.VoucherID 
	           WHERE ISNULL(AdvanceTypeID,0) = 1 
					-- AND CONVERT(VARCHAR(50),T11.AdvanceDate,103) <= '''+CONVERT(VARCHAR(50),@VoucherDate,103)+''' 
					'+ CASE WHEN ISNULL(@ClearanceVoucherID,'') <> '' THEN ' AND T11.VoucherID <> '''+@ClearanceVoucherID+''' ' ELSE '' END + ' 
	           GROUP BY T11.DivisionID, CreditVoucherID, DepositContractNo) C ON T11.DivisionID = C.DivisionID AND T11.CreditVoucherID = C.CreditVoucherID AND T12.DepositContractNo = C.DepositContractNo	
	WHERE T11.DivisionID = ''' + @DivisionID + '''
		AND T11.CreditVoucherID = '''+@VoucherID+'''
		AND ISNULL(T11.AdvanceTypeID,0) = 0
		'
	SET @sSQL = @sSQL + '
ORDER BY T12.Orders'
END 

--PRINT @sSQL
EXEC(@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

