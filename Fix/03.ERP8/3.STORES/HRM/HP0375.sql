IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0375]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0375]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load dữ liệu lập đề nghị ký hợp đồng (ANGEL)
-- <History>
---- Created by Tiểu Mai on 07/03/2016
---- Modified on ... by 
-- <Example>
/*
	EXEC HP0375 'TH', 'HD201302000002'',''HD201302000001'
	
 */


CREATE PROCEDURE [dbo].[HP0375] 	
	@DivisionID NVARCHAR(50),
	@ListContractID NVARCHAR(MAX)
AS
DECLARE @sSQL NVARCHAR(MAX), @sSQL1 NVARCHAR(MAX)
SET @sSQL = ''

SET @sSQL = N'
		SELECT HT1360.DivisionID, HT1360.ContractID, HT1360.EmployeeID, HT1360.DepartmentID, HT1360.TeamID, HT1360.SignPersonID,
		HT1360.SignDate, HT1360.ContractNo, HT1360.ContractTypeID, HT1360.WorkDate, HT1360.WorkEndDate, HT1360.TestFromDate, HT1360.TestEndDate,
		HT1360.DutyID, HT1360.Works, HT1360.BaseSalary AS BaseSalaryOld, HT1360.Salary01, HT1360.Salary02, HT1360.Salary03, HT1360.WorkAddress, HT1360.WorkTime,
		HT1360.IssueTool, HT1360.Conveyance, HT1360.PayForm, HT1360.RestRegulation, HT1360.Notes, HT1360.CreateDate, HT1360.TitleID, HT1360.Allowance,
		HT1360.PayDate, HT1360.Bonus, HT1360.SalaryRegulation, HT1360.SafetyEquiment, HT1360.SI, HT1360.TrainingRegulation, HT1360.OtherAgreement,
		HT1360.Compensation, HT1360.IsSLSendEmail, HT1360.IsAppendix, HT1360.CContractID, HT1360.S1, HT1360.S2, HT1360.S3 , 
		Ltrim(RTrim(isnull(HT1400.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT1400.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT1400.FirstName,''''))) AS EmployeeName, 
		ISNULL(HT0375.StatusSuggest,0) AS StatusSuggest,
		CASE WHEN ISNULL(HT0375.StatusSuggest,0) = 0 THEN N''Chưa duyệt'' ELSE AT0099.Description END as StatusSuggestName ,
		ISNULL(HT0375.DescriptionConfirm,'''') AS  DescriptionConfirm,
		ISNULL(HT0375.ConfirmUserID,'''') AS ConfirmUserID

	FROM HT1360
	LEFT JOIN HT1400 ON HT1400.DivisionID = HT1360.DivisionID AND HT1400.EmployeeID = HT1360.EmployeeID
	LEFT JOIN HT0375 ON HT0375.DivisionID = HT1360.DivisionID AND HT0375.EmployeeID = HT1360.EmployeeID AND HT0375.ContractID = HT1360.ContractID
	LEFT JOIN AT0099 ON HT0375.StatusSuggest = AT0099.ID AND AT0099.CodeMaster = ''AT00000008''
	WHERE HT1360.DivisionID = '''+@DivisionID+'''
		AND HT1360.ContractID IN ('''+@ListContractID+''')
	ORDER BY HT1360.EmployeeID
	'
EXEC (@sSQL)
--PRINT @sSQL

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

