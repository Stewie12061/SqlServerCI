IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2131]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2131]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load master phiếu báo giá (kỹ thuật)
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <Histor>
---- Created by: Kiều Nga on: 06/08/2021
---- <Example>
---- exec SOP2131 @DivisionID=N'SGNP',@APK=N'9dbdcd0a-f8a8-4ac0-9e38-2e7439bc3cb2',@Mode=0

CREATE PROCEDURE SOP2131
(
	@DivisionID VARCHAR(50),
	@APK VARCHAR(50),
	@Mode INT
)
AS

DECLARE @Ssql Nvarchar(max) =''

IF @Mode = 0
BEGIN
SET @Ssql = @Ssql + N' 
SELECT DISTINCT S1.APK, S1.DivisionID, S1.VouCherNo, S1.VouCherDate, S1.ExchangeRate, S1.Description, S1.Tel, S1.Address, S1.DeliveryAddress, S1.Transport, S1.Attention1, S1.Dear, S1.Attention2 
	, S2.FullName AS EmployeeName, S3.ObjectName,S4.Description AS OrderStatus,S7.CurrencyName AS CurrencyID, S8.PaymentName AS PaymentID
	, S9.PaymentTermName AS PaymentTermID, S10.Description AS PriceListID,S1.CreateDate, S1.CreateUserID, S1.LastModifyUserID, S1.LastModifyDate,S1.Ana01ID
	, S11.AnaName as Ana01Name,S1.ProjectAddress
	 FROM SOT2120 S1 WITH(NOLOCK)
	LEFT JOIN AT1103 S2 WITH(NOLOCK) On S2.DivisionID IN (''@@@'', S1.DivisionID) AND S1.EmployeeID = S2.EmployeeID
	LEFT JOIN AT1202 S3 WITH(NOLOCK) On S3.DivisionID IN (''@@@'', S1.DivisionID) AND S1.ObjectID = S3.ObjectID
	LEFT JOIN AT0099 S4 WITH(NOLOCK) On S1.OrderStatus = S4.ID AND S4.CodeMaster = ''AT00000003'' AND S4.Disabled = 0
	LEFT JOIN AT1004 S7  WITH(NOLOCK) On S1.CurrencyID = S7.CurrencyID AND S7.DivisionID IN (''@@@'', S1.DivisionID)
	LEFT JOIN AT1205 S8  WITH(NOLOCK) On S1.PaymentID = S8.PaymentID AND S8.DivisionID IN (''@@@'', S1.DivisionID)
	LEFT JOIN AT1208 S9  WITH(NOLOCK) On S1.PaymentID = S9.PaymentTermID AND S9.DivisionID IN (''@@@'', S1.DivisionID)
	LEFT JOIN OT1301 S10  WITH(NOLOCK) On S1.PriceListID = S10.ID AND S10.DivisionID IN (''@@@'', S1.DivisionID)
	LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON S1.APKMaster_9000 = OOT90.APK
	LEFT JOIN AT1011 S11 WITH(NOLOCK) ON S11.DivisionID IN (S1.DivisionID,''@@@'') AND S1.Ana01ID = S11.AnaID AND S11.AnaTypeID = ''A01''
	 WHERE S1.DivisionID = '''+@DivisionID+''' AND S1.APK ='''+@APK+'''  AND ISNULL(S1.DeleteFlag,0) = 0'
END
ELSE
BEGIN
SET @Ssql = @Ssql + N'SELECT DISTINCT  S1.*, S2.FullName AS EmployeeName, S3.ObjectName
	 FROM SOT2120 S1 WITH(NOLOCK)
	LEFT JOIN AT1103 S2 WITH(NOLOCK) On S2.DivisionID IN (''@@@'', S1.DivisionID) AND S1.EmployeeID = S2.EmployeeID
	LEFT JOIN AT1202 S3 WITH(NOLOCK) On S3.DivisionID IN (''@@@'', S1.DivisionID) AND S1.ObjectID = S3.ObjectID
	WHERE S1.DivisionID = '''+@DivisionID+''' AND S1.APK ='''+@APK+''' AND ISNULL(S1.DeleteFlag,0) = 0'
END

EXEC (@Ssql )
PRINT (@Ssql)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
