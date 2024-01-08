IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2122]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2122]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load master phiếu báo giá Sale
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <Histor>
---- Created by: Đình Hòa on: 22/06/2021


CREATE PROCEDURE SOP2122
(
	@DivisionID VARCHAR(50),
	@APK VARCHAR(50),
	@APKMaster VARCHAR(50) = '',
	@Type VARCHAR(50) = '',
	@Mode INT
)
AS

DECLARE @Ssql Nvarchar(max) ='', 
		@Swhere  Nvarchar(max) = '',
		@query AS NVARCHAR(MAX)='',
		@Level INT = 0,
		@sSQLSL NVARCHAR (MAX) = '',
		@i INT = 1, @s VARCHAR(2),
		@sSQLJon NVARCHAR (MAX) = ''

IF ISNULL(@Type, '') = 'PBGKD' 
BEGIN
	SET @Swhere = @Swhere + 'AND CONVERT(VARCHAR(50),S1.APKMaster_9000)= '''+@APKMaster+''''
	SELECT @Level = MAX(Level) FROM OOT9001 WITH (NOLOCK) WHERE APKMaster = @APKMaster
END
ELSE 
BEGIN
	SET @Swhere = @Swhere + 'AND (S1.APK = '''+@APK+''' OR S1.APKMaster_9000 = '''+@APK+''')'
	SELECT @Level = MAX(Level) FROM OOT9001 WITH (NOLOCK) LEFT JOIN SOT2120 S1 ON OOT9001.APKMaster = S1.APKMaster_9000  WHERE (S1.APK = @APK OR S1.APKMaster_9000 = @APK)
END

WHILE @i <= @Level
BEGIN
	IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
	ELSE SET @s = CONVERT(VARCHAR, @i)
	SET @sSQLSL=@sSQLSL+' , APP'+@s+'.ApprovePerson'+@s+'ID, APP'+@s+'.ApprovePerson'+@s+'Name, APP'+@s+'.ApprovePerson'+@s+'Status AS Status'+@s+', APP'+@s+'.ApprovePerson'+@s+'StatusName'
	SET @sSQLJon = @sSQLJon+ '
		LEFT JOIN (SELECT ApprovePersonID ApprovePerson'+@s+'ID,OOT1.APKMASter,OOT1.DivisionID,OOT1.Status,
			HT14.FullName AS ApprovePerson'+@s+'Name,
		OOT1.Status ApprovePerson'+@s+'Status, O99.Description ApprovePerson'+@s+'StatusName,
		OOT1.Note ApprovePerson'+@s+'Note
		FROM OOT9001 OOT1 WITH (NOLOCK)
		INNER JOIN AT1103 HT14 WITH (NOLOCK) ON HT14.DivisionID IN (''@@@'',OOT1.DivisionID) AND HT14.EmployeeID=OOT1.ApprovePersonID
		LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1=ISNULL(OOT1.Status,0) AND O99.CodeMASter=''Status''
		WHERE OOT1.Level='+STR(@i)+')APP'+@s+' ON APP'+@s+'.DivisionID= OOT90.DivisionID  AND APP'+@s+'.APKMASter=OOT90.APK'
	SET @i = @i + 1		
END	

IF @Mode = 0
BEGIN
SET @Ssql = @Ssql + N' 
SELECT DISTINCT S1.APK, S1.DivisionID, S1.VouCherNo, S1.VouCherDate, S1.ExchangeRate, S1.Description, S1.Tel, S1.Address, S1.DeliveryAddress, S1.Transport, S1.Attention1, S1.Dear, S1.Attention2 
	, S2.FullName AS EmployeeName, S3.ObjectName,S4.Description AS OrderStatus, S5.Description AS IsConfirm, S6.Description AS IsSO, S7.CurrencyName AS CurrencyID, S8.PaymentName AS PaymentID
	, S9.PaymentTermName AS PaymentTermID, S10.Description AS PriceListID, S1.APKMaster_9000, S1.CreateDate, S1.CreateUserID, S1.LastModifyUserID, S1.LastModifyDate, S11.AnaName AS Ana01ID, S1.ProjectAddress
	 '+@sSQLSL+'
	 FROM SOT2120 S1 WITH(NOLOCK)
	LEFT JOIN AT1103 S2 WITH(NOLOCK) On S2.DivisionID IN (''@@@'', S1.DivisionID) AND S1.EmployeeID = S2.EmployeeID
	LEFT JOIN AT1202 S3 WITH(NOLOCK) On S3.DivisionID IN (''@@@'', S1.DivisionID) AND S1.ObjectID = S3.ObjectID
	LEFT JOIN AT0099 S4 WITH(NOLOCK) On S1.OrderStatus = S4.ID AND S4.CodeMaster = ''AT00000003'' AND S4.Disabled = 0
	LEFT JOIN OOT0099 S5 WITH(NOLOCK) ON S1.IsConfirm = S5.ID AND S5.CodeMaster = ''Status'' AND S5.Disabled = 0
	LEFT JOIN AT0099 S6 WITH(NOLOCK) On S1.IsSO = S6.ID AND S6.CodeMaster = ''AT00000004'' AND S6.Disabled = 0
	LEFT JOIN AT1004 S7  WITH(NOLOCK) On S1.CurrencyID = S7.CurrencyID AND S7.DivisionID IN (''@@@'', S1.DivisionID)
	LEFT JOIN AT1205 S8  WITH(NOLOCK) On S1.PaymentID = S8.PaymentID AND S8.DivisionID IN (''@@@'', S1.DivisionID)
	LEFT JOIN AT1208 S9  WITH(NOLOCK) On S1.PaymentID = S9.PaymentTermID AND S9.DivisionID IN (''@@@'', S1.DivisionID)
	LEFT JOIN OT1301 S10  WITH(NOLOCK) On S1.PriceListID = S10.ID AND S10.DivisionID IN (''@@@'', S1.DivisionID)
	LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON S1.APKMaster_9000 = OOT90.APK
	LEFT JOIN AT1011 S11 WITH(NOLOCK) ON S11.DivisionID IN (S1.DivisionID,''@@@'') AND S1.Ana01ID = S11.AnaID AND S11.AnaTypeID = ''A01''
	'+@sSQLJon+'
	 WHERE S1.DivisionID = '''+@DivisionID+''' '+@Swhere+' AND ISNULL(S1.DeleteFlag,0) = 0'
END
ELSE
BEGIN
SET @Ssql = @Ssql + N'SELECT DISTINCT  S1.*, S2.FullName AS EmployeeName, S3.ObjectName
	 '+@sSQLSL+'
	 FROM SOT2120 S1 WITH(NOLOCK)
	LEFT JOIN AT1103 S2 WITH(NOLOCK) On S2.DivisionID IN (''@@@'', S1.DivisionID) AND S1.EmployeeID = S2.EmployeeID
	LEFT JOIN AT1202 S3 WITH(NOLOCK) On S3.DivisionID IN (''@@@'', S1.DivisionID) AND S1.ObjectID = S3.ObjectID
	LEFT JOIN AT0099 S4 WITH(NOLOCK) On S1.OrderStatus = S4.ID AND S4.CodeMaster = ''AT00000003'' AND S4.Disabled = 0
	LEFT JOIN OOT0099 S5 WITH(NOLOCK) ON S1.IsConfirm = S5.ID AND S5.CodeMaster = ''Status'' AND S5.Disabled = 0
	LEFT JOIN AT0099 S6 WITH(NOLOCK) On S1.IsSO = S6.ID AND S6.CodeMaster = ''AT00000004'' AND S6.Disabled = 0
	LEFT JOIN AT1004 S7  WITH(NOLOCK) On S1.CurrencyID = S7.CurrencyID AND S7.DivisionID IN (''@@@'', S1.DivisionID)
	LEFT JOIN AT1205 S8  WITH(NOLOCK) On S1.PaymentID = S8.PaymentID AND S8.DivisionID IN (''@@@'', S1.DivisionID)
	LEFT JOIN AT1208 S9  WITH(NOLOCK) On S1.PaymentID = S9.PaymentTermID AND S9.DivisionID IN (''@@@'', S1.DivisionID)
	LEFT JOIN OT1301 S10  WITH(NOLOCK) On S1.PriceListID = S10.ID AND S10.DivisionID IN (''@@@'', S1.DivisionID)
	LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON S1.APKMaster_9000 = OOT90.APK
	LEFT JOIN AT1011 S11 WITH(NOLOCK) ON S11.DivisionID IN (S1.DivisionID,''@@@'') AND S1.Ana01ID = S11.AnaID AND S11.AnaTypeID = ''A01''
	'+@sSQLJon+'
	 WHERE S1.DivisionID = '''+@DivisionID+''' '+@Swhere+' AND ISNULL(S1.DeleteFlag,0) = 0'
END

EXEC (@Ssql )
PRINT (@Ssql)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
