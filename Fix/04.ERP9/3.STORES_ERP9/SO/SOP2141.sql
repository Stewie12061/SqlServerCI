IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2141]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2141]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load master phương án kinh doanh
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <Histor>
---- Created by: Kiều Nga on: 10/08/2021
---- <Example>
---- exec SOP2141 @DivisionID=N'SGNP',@APK=N'9dbdcd0a-f8a8-4ac0-9e38-2e7439bc3cb2',@Mode=0

CREATE PROCEDURE SOP2141
(
	@DivisionID VARCHAR(50),
	@APK VARCHAR(50),
	@APKMaster VARCHAR(50) = '',
	@Type VARCHAR(50) = ''
)
AS

DECLARE @Ssql Nvarchar(max) ='',
		@Swhere  Nvarchar(max) = '',
		@Level INT = 0,
		@sSQLSL NVARCHAR (MAX) = '',
		@i INT = 1, @s VARCHAR(2),
		@sSQLJon NVARCHAR (MAX) = ''

IF ISNULL(@Type, '') = 'PAKD' 
BEGIN
SET @Swhere = @Swhere + 'AND CONVERT(VARCHAR(50),S1.APKMaster_9000)= '''+@APKMaster+''''
SELECT @Level = MAX(Level) FROM OOT9001 WITH (NOLOCK) WHERE APKMaster = @APKMaster
END
ELSE 
BEGIN
SET @Swhere = @Swhere + 'AND S1.APK = '''+@APK+''''
SELECT @Level = MAX(Level) FROM OOT9001 WITH (NOLOCK) LEFT JOIN SOT2140 ON OOT9001.APKMaster = SOT2140.APKMaster_9000  WHERE SOT2140.APK = @APK
END
	WHILE @i <= @Level
	BEGIN
		IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
		ELSE SET @s = CONVERT(VARCHAR, @i)
		SET @sSQLSL=@sSQLSL+' , ApprovePerson'+@s+'ID, ApprovePerson'+@s+'Name, ApprovePerson'+@s+'Status, ApprovePerson'+@s+'StatusName, ApprovePerson'+@s+'Note'
		SET @sSQLJon =@sSQLJon+ '
						LEFT JOIN (SELECT ApprovePersonID ApprovePerson'+@s+'ID,OOT1.APKMaster,OOT1.DivisionID,OOT1.Status,
						 HT14.FullName As ApprovePerson'+@s+'Name, 
						OOT1.Status ApprovePerson'+@s+'Status, O99.Description ApprovePerson'+@s+'StatusName,
						OOT1.Note ApprovePerson'+@s+'Note
						FROM OOT9001 OOT1 WITH (NOLOCK)
						INNER JOIN AT1103 HT14 WITH (NOLOCK) ON HT14.EmployeeID=OOT1.ApprovePersonID --AND HT14.DivisionID=OOT1.DivisionID 
						LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1=ISNULL(OOT1.Status,0) AND O99.CodeMaster=''Status''
						WHERE OOT1.Level='+STR(@i)+'
						)APP'+@s+' ON APP'+@s+'.DivisionID= OOT90.DivisionID  AND APP'+@s+'.APKMaster=OOT90.APK'
		SET @i = @i + 1		
	END	

SET @Ssql = @Ssql + N' 
SELECT DISTINCT S1.APK,S1.TranMonth,S1.TranYear, S1.DivisionID, S1.VoucherNo, S1.VoucherDate,S1.ObjectID,S2.ObjectName,S1.CuratorID,S3.FullName as CuratorName,
S1.InvestorID,S4.ObjectName as InvestorName, S1.GeneralContractorID,S5.FullName as GeneralContractorName,S1.ContractID,S6.ContractName
,S1.AppendixContractID,S7.ContractName as AppendixContractName,S1.EmployeeID,S8.FullName as EmployeeName,S1.ProjectManagementID,S9.FullName as ProjectManagementName,
S1.ClerkID,S10.FullName as ClerkName,S1.RevenueExcludingVAT,S1.Revenue,S1.TotalCostOfGoodsSold,S1.ProfitBeforeTax,S1.ProfitMargin
,S1.CreateDate, S1.CreateUserID, S1.LastModifyUserID, S1.LastModifyDate,S1.APKMaster_9000
'+@sSQLSL+'
	 FROM SOT2140 S1 WITH(NOLOCK)
	LEFT JOIN AT1202 S2 WITH(NOLOCK) On S2.DivisionID IN (''@@@'', S1.DivisionID) AND S1.ObjectID = S2.ObjectID
	LEFT JOIN AT1103 S3 WITH(NOLOCK) On S3.DivisionID IN (''@@@'', S1.DivisionID) AND S1.CuratorID = S3.EmployeeID
	LEFT JOIN AT1202 S4 WITH(NOLOCK) On S4.DivisionID IN (''@@@'', S1.DivisionID) AND S1.InvestorID = S4.ObjectID
	LEFT JOIN AT1103 S5 WITH(NOLOCK) On S5.DivisionID IN (''@@@'', S1.DivisionID) AND S1.GeneralContractorID = S5.EmployeeID
	LEFT JOIN AT1020 S6 WITH(NOLOCK) On S6.DivisionID = S1.DivisionID AND S1.ContractID = S6.ContractNo
	LEFT JOIN AT1020 S7 WITH(NOLOCK) On S7.DivisionID = S1.DivisionID AND S1.AppendixContractID = S7.ContractNo
	LEFT JOIN AT1103 S8 WITH(NOLOCK) On S8.DivisionID IN (''@@@'', S1.DivisionID) AND S1.EmployeeID = S8.EmployeeID
	LEFT JOIN AT1103 S9 WITH(NOLOCK) On S9.DivisionID IN (''@@@'', S1.DivisionID) AND S1.ProjectManagementID = S9.EmployeeID
	LEFT JOIN AT1103 S10 WITH(NOLOCK) On S10.DivisionID IN (''@@@'', S1.DivisionID) AND S1.ClerkID = S10.EmployeeID
	LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON S1.APKMaster_9000 = OOT90.APK
	'+@sSQLJon+'
	WHERE S1.DivisionID = '''+@DivisionID+''' AND ISNULL(S1.DeleteFlag,0) = 0 '+@Swhere

EXEC (@Ssql )
PRINT (@Ssql)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
