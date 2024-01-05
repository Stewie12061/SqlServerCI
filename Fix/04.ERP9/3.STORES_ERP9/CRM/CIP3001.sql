IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP3001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP3001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- CIP3001
-- <Summary>
---- Stored in hợp đồng 
---- Created on 19/01/2022 Minh Hiếu
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <Example>
---- 

CREATE PROCEDURE [dbo].[CIP3001]
	@DivisionID AS NVARCHAR(50),		
	@ContractID AS NVARCHAR(50)
AS
DECLARE @sSQL AS NVARCHAR(MAX) = ''

SET @sSQL = '
SELECT DISTINCT A0.ContractID, A0.ContractNo, A0.SignDate, A0.ContractName, A0.ObjectID,A3.ObjectName,A3.Address,A3.VATNo,
A3.Tel,A0.ContactorID,CR01.ContactName AS ContactorName, CR01.TitleContact AS DutyID, A0.DeliveryTime,A1.StepName,CR01.Prefix,A9.Description
FROM AT1020 A0 WITH (NOLOCK)
LEFT JOIN AT1021 A1 WITH (NOLOCK) ON A1.ContractID = A0.ContractID
LEFT JOIN AT1202 A3 WITH (NOLOCK) ON A3.ObjectID = A0.ObjectID AND A3.DivisionID IN (''@@@'',A0.DivisionID)
LEFT JOIN CRMT10001 CR01 WITH (NOLOCK) ON CR01.ContactID = A0.ContactorID
LEFT JOIN AT0099 A9 WITH (NOLOCK) ON A9.ID = CR01.Prefix AND A9.CodeMaster = ''AT00000002'' and A9.Disabled = 0
WHERE A0.DivisionID = ''' + @DivisionID + '''
AND A0.ContractID = ''' + @ContractID + ''''

PRINT @sSQL
EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
