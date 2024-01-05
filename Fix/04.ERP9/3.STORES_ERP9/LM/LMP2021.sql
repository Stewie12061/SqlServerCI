IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP2021]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP2021]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Edit Form LMF2021 Giải ngân hợp đồng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 11/07/2017 by Bảo Anh
----Modify on
-- <Example>
/*  
 EXEC LMP2021 'AS',''
*/
----
CREATE PROCEDURE LMP2021 ( 
        @DivisionID VARCHAR(50),
		@VoucherID VARCHAR(50)
		
) 
AS

DECLARE @CostAnaTypeID varchar(50)

SELECT	@CostAnaTypeID = ISNULL(CostAnaTypeID,'')
FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID

SELECT		T21.*, T01.VoucherNo as CreditVoucherNo, T01.OriginalAmount as CreditOriginalAmount, T01.ConvertedAmount as CreditConvertedAmount,
			T991.Description as OriginalMethodName, T992.Description as RateMethodName,
			T051.AccountName as OriginalAccountName, T052.AccountName as RateAccountName,
			A01.AnaName as OriginalCostTypeName, A02.AnaName as RateCostTypeName,
			Convert(varchar(20),T21.FromDate,103) + ' - ' + Convert(varchar(20),T21.ToDate,103) as FromToDate, AT1016.BankName,
			T993.Description as RateByName,T03.FullName as CreateUserName, T031.FullName as LastModifyUserName, T10.BankID			
FROM		LMT2021 T21 WITH (NOLOCK)
LEFT JOIN LMT2001 T01 WITH (NOLOCK) ON T21.DivisionID = T01.DivisionID And T21.CreditVoucherID = T01.VoucherID
LEFT JOIN LMT1010 T10 WITH (NOLOCK) ON T01.DivisionID = T10.DivisionID And T01.LimitVoucherID = T10.VoucherID
LEFT JOIN (Select Distinct AT1202.ObjectID as BankID, AT1202.ObjectName as BankName
	From AT1202 WITH (NOLOCK)
	Where AT1202.DivisionID in ('@@@',@DivisionID) And AT1202.Disabled = 0) AT1016 ON T10.BankID = AT1016.BankID
LEFT JOIN LMT0099 T991 WITH (NOLOCK) ON T21.OriginalMethod = T991.OrderNo AND T991.CodeMaster = 'LMT00000006'
LEFT JOIN LMT0099 T992 WITH (NOLOCK) ON T21.RateMethod = T992.OrderNo AND T992.CodeMaster = 'LMT00000007'
LEFT JOIN LMT0099 T993 WITH (NOLOCK) ON T21.RateBy = T993.OrderNo AND T993.CodeMaster = 'LMT00000008'
LEFT JOIN AT1005 T051 WITH (NOLOCK) ON T21.OriginalAccountID = T051.AccountID
LEFT JOIN AT1005 T052 WITH (NOLOCK) ON T21.RateAccountID = T052.AccountID
LEFT JOIN AT1011 A01 WITH (NOLOCK) ON Isnull(T21.OriginalCostTypeID,'') = A01.AnaID And A01.AnaTypeID = @CostAnaTypeID
LEFT JOIN AT1011 A02 WITH (NOLOCK) ON Isnull(T21.RateCostTypeID,'') = A02.AnaID And A02.AnaTypeID = @CostAnaTypeID
LEFT JOIN AT1103 T03 WITH (NOLOCK) ON T21.CreateUserID = T03.EmployeeID
LEFT JOIN AT1103 T031 WITH (NOLOCK) ON T21.LastModifyUserID = T031.EmployeeID
WHERE		T21.DivisionID = @DivisionID
AND			T21.VoucherID = @VoucherID


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

