IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[FNP2000_R]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[FNP2000_R]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






----- Created by Như Hàn
---- Created Date 27/02/2019
---- Purpose: Xuất excel kế hoạch thu chi
---- Modified on ... by ...
-- <Example>
/*  
 EXEC FNP2000_R @DivisionID, @APKList

*/


CREATE PROCEDURE [dbo].[FNP2000_R] 	
				@DivisionID varchar(50),
				@APKList XML
				
AS


IF @APKList IS NOT NULL
BEGIN
	CREATE TABLE #TAM (APK VARCHAR(50))
	INSERT INTO #TAM (APK)
	SELECT X.Data.query('APK').value('.', 'VARCHAR(50)') AS APK
	FROM @APKList.nodes('//Data') AS X (Data)
END	


SELECT 
T20.TypeID, T19.Description As TypeName,
T20.APK, T20.DivisionID, T20.TranMonth, T20.TranYear, T20.VoucherTypeID, T20.VoucherNo, T20.VoucherDate, T20.EmployeeID, 
T20.TransactionType, 
T20.PayMentTypeID, T12.PaymentName As PayMentTypeName, ---- Hình thức thanh toán
T20.PayMentPlanDate, 
T20.CurrencyID, T04.CurrencyName As CurrencyName,
T20.ExchangeRate, T20.Descriptions, T20.PriorityID, 
T20.Status, T20.TypeID, T20.ApprovalDate, T20.ApprovalDescriptions, T20.CreateUserID, T20.CreateDate, T20.LastModifyUserID, 
T20.LastModifyDate, T20.DeleteFlag,
T21.APK As T21APK, T21.Orders, T21.JobName, T21.OriginalAmount, T21.ConvertedAmount, T21.ApprovalOAmount, T21.ApprovalCAmount, T21.StatusDetail, 
T21.ApprovalNotes, 
T21.ObjectTransferID, T02.ObjectName As ObjectTransferName,
T21.ObjectBeneficiaryID, T22.ObjectName As ObjectBeneficiaryName,
T21.NormID, 
T21.ResponsibleID, T03.FullName As ResponsibleName,
T21.ObjectProposalID, T01.AnaName As ObjectProposalName,
T21.Ana01ID, A01.AnaName As Ana01Name, T21.Ana02ID, A02.AnaName As Ana02Name, T21.Ana03ID, A03.AnaName As Ana03Name, 
T21.Ana04ID, A04.AnaName As Ana04Name, T21.Ana05ID, A05.AnaName As Ana05Name, 
T21.Ana06ID, A06.AnaName As Ana06Name, T21.Ana07ID, A07.AnaName As Ana07Name, T21.Ana08ID, A08.AnaName As Ana08Name, 
T21.Ana09ID, A09.AnaName As Ana09Name, T21.Ana10ID, A10.AnaName As Ana10Name, 
T21.ContractAmount, T21.Accumulated, T21.ExtantPayment, 
T21.ProvinceID, T15.AnaName As ProvinceName,
T21.Notes, 
T21.OverdueID, T00.Description As OverdueName,
T21.OverdueDay, 
T21.DateHaveFile, 
T21.StatusFileID, T09.Description As StatusFileName,
T21.AmountApproval, T21.AmountEstimation, T21.Delegacy, T21.WeekNo, T21.AmountApprovalBOD, 
T21.ApprovalDes, T21.TCKTDebt, T21.TCKTExpired, T21.TCKTDisbursement, T21.TCKTGeneral, T21.TCKTGuarantee, T21.TCKTAmountApproval, 
T21.TCKTApprovalDes, T21.DeleteFlag, T21.InheritTableID, T21.InheritVoucherID, T21.InheritTransactionID, T21.PaymentDate, 
T21.POAmount, T21.PCAmount
FROM FNT2000 T20 WITH (NOLOCK)
INNER JOIN FNT2001 T21 WITH (NOLOCK) ON T20.APK = T21.APKMaster AND T20.DivisionID = T21.DivisionID AND T20.DeleteFlag = 0
INNER JOIN #TAM ON T20.APK = #TAM.APK
LEFT JOIN AT1205 T12 WITH (NOLOCK) ON T20.PayMentTypeID = T12.PaymentID
LEFT JOIN AT1004 T04 WITH (NOLOCK) ON T04.CurrencyID = T20.CurrencyID
LEFT JOIN AT1202 T02 WITH (NOLOCK) ON T02.ObjectID = T21.ObjectTransferID
LEFT JOIN AT1202 T22 WITH (NOLOCK) ON T22.ObjectID = T21.ObjectBeneficiaryID
LEFT JOIN AT1103 T03 WITH (NOLOCK) ON T03.EmployeeID = T21.ResponsibleID
LEFT JOIN AT1011 T01 WITH (NOLOCK) ON T01.AnaID = T21.ObjectProposalID AND T01.AnaTypeID = 'A01'
LEFT JOIN AT1011 A01 WITH (NOLOCK) ON A01.AnaID = T21.Ana01ID AND A01.AnaTypeID = 'A01'
LEFT JOIN AT1011 A02 WITH (NOLOCK) ON A02.AnaID = T21.Ana02ID AND A02.AnaTypeID = 'A02'
LEFT JOIN AT1011 A03 WITH (NOLOCK) ON A03.AnaID = T21.Ana03ID AND A03.AnaTypeID = 'A03'
LEFT JOIN AT1011 A04 WITH (NOLOCK) ON A04.AnaID = T21.Ana04ID AND A04.AnaTypeID = 'A04'
LEFT JOIN AT1011 A05 WITH (NOLOCK) ON A05.AnaID = T21.Ana05ID AND A05.AnaTypeID = 'A05'
LEFT JOIN AT1011 A06 WITH (NOLOCK) ON A06.AnaID = T21.Ana06ID AND A06.AnaTypeID = 'A06'
LEFT JOIN AT1011 A07 WITH (NOLOCK) ON A07.AnaID = T21.Ana07ID AND A07.AnaTypeID = 'A07'
LEFT JOIN AT1011 A08 WITH (NOLOCK) ON A08.AnaID = T21.Ana08ID AND A08.AnaTypeID = 'A08'
LEFT JOIN AT1011 A09 WITH (NOLOCK) ON A09.AnaID = T21.Ana09ID AND A09.AnaTypeID = 'A09'
LEFT JOIN AT1011 A10 WITH (NOLOCK) ON A10.AnaID = T21.Ana10ID AND A10.AnaTypeID = 'A10'
LEFT JOIN AT1015 T15 WITH (NOLOCK) ON T21.ProvinceID = T15.AnaID AND T15.AnaTypeID = 'O01'
LEFT JOIN FNT0099 T00 WITH (NOLOCK) ON T21.OverdueID = T00.ID AND T00.CodeMaster = 'OverdueID'
LEFT JOIN FNT0099 T09 WITH (NOLOCK) ON T21.StatusFileID = T09.ID AND T09.CodeMaster = 'StatusFileID'
LEFT JOIN FNT0099 T19 WITH (NOLOCK) ON T20.TypeID = T19.ID AND T09.CodeMaster = 'TypeID'

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
