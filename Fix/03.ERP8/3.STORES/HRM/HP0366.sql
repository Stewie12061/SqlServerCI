IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0366]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0366]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load dữ liệu lên màn hình duyệt đề nghị ký hợp đồng (ANGEL)
-- <History>
---- Created by Tiểu Mai on 09/03/2016
---- Modified by Tiểu Mai on 27/07/2016: Bổ sung trường
---- Modified by Tiểu Mai on 01/08/2016: Bổ sung Isnull
---- Modified by Phương Thảo on 18/05/2017: Sửa danh mục dùng chung
-- <Example>
/*
	EXEC HP0366 'TH', '03/09/2016', '03/09/2016', 'L2', 'NV', '100', 0
	
 */


CREATE PROCEDURE [dbo].[HP0366] 	
	@DivisionID NVARCHAR(50),
	@FromDate DATETIME,
	@ToDate DATETIME,
	@ContractTypeID NVARCHAR(50),
	@DepartmentID NVARCHAR(50),
	@EmployeeID NVARCHAR(50),
	@Type INT		--- 0: Chưa duyệt
					--- 1: Đã duyệt
AS
DECLARE @sSQL NVARCHAR(MAX)
SET @sSQL = ''
IF @Type = 0
	SET @sSQL = N'
			SELECT HT0374.SuggestID, HT0374.SuggestDate, HT0374.[Description],
			HT0374.EmployeeID AS EmployeeID1, Ltrim(RTrim(isnull(H00.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(H00.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(H00.FirstName,''''))) AS EmployeeName1,
			HT0375.TransactionID, HT0375.Orders, HT0375.ContractID, HT0375.ContractTypeID,
			HT0375.EmployeeID,  Ltrim(RTrim(isnull(HT1400.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT1400.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT1400.FirstName,''''))) AS EmployeeName,
			HT0375.BaseSalaryOld, HT0375.BaseSalaryNew, HT0375.DutyID, HT0375.Notes, HT0375.StatusSuggest, HT0375.DescriptionConfirm, HT0375.ConfirmUserID,
			HT0375.DepartmentID,AT0099.Description as StatusSuggestName, AT1102.DepartmentName, HT1102.DutyName,HT1105.ContractTypeName,
			HT0375.ContractNo,
			HT0375.ContractTypeID,
			HT0375.WorkDate,
			HT0375.WorkEndDate,
			HT0375.WorkAddress,
			HT0375.BaseSalaryNew
			FROM HT0375
			INNER JOIN HT0374 ON HT0374.DivisionID = HT0375.DivisionID AND HT0374.SuggestID = HT0375.SuggestID
			LEFT JOIN HT1400 ON HT1400.DivisionID = HT0375.DivisionID AND HT1400.EmployeeID = HT0375.EmployeeID
			LEFT JOIN HT1400 H00 ON H00.DivisionID = HT0374.DivisionID AND H00.EmployeeID = HT0374.EmployeeID
			LEFT JOIN AT0099 ON AT0099.ID = HT0375.StatusSuggest AND AT0099.CodeMaster = ''AT00000008''
			LEFT JOIN AT1102 ON AT1102.DepartmentID = HT0375.DepartmentID
			LEFT JOIN HT1102 ON HT1102.DivisionID = HT0375.DivisionID AND HT1102.DutyID = HT0375.DutyID
			LEFT JOIN HT1105 ON HT1105.DivisionID = HT0375.DivisionID AND HT1105.ContractTypeID = HT0375.ContractTypeID
			WHERE HT0375.DivisionID = '''+@DivisionID+'''
				AND HT0375.StatusSuggest = 0
				AND ISNULL(HT0375.DepartmentID,'''') LIKE '''+@DepartmentID+'''
				AND ISNULL(HT0375.EmployeeID,'''') LIKE '''+@EmployeeID+'''	
				AND ISNULL(HT0375.ContractTypeID,'''') LIKE '''+@ContractTypeID+'''
				AND HT0374.SuggestDate BETWEEN '''+CONVERT(NVARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(NVARCHAR(10),@ToDate,21) +''' '
				
		
ELSE 
	SET @sSQL = '
			SELECT HT0374.SuggestID, HT0374.SuggestDate, HT0374.[Description],
			HT0374.EmployeeID AS EmployeeID1, Ltrim(RTrim(isnull(H00.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(H00.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(H00.FirstName,''''))) AS EmployeeName1,
			HT0375.TransactionID, HT0375.Orders, HT0375.ContractID, HT0375.ContractTypeID,
			HT0375.EmployeeID,  Ltrim(RTrim(isnull(HT1400.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT1400.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT1400.FirstName,''''))) AS EmployeeName,
			HT0375.BaseSalaryOld, HT0375.BaseSalaryNew, HT0375.DutyID, HT0375.Notes, HT0375.StatusSuggest, HT0375.DescriptionConfirm, HT0375.ConfirmUserID,
			HT0375.DepartmentID, AT0099.Description as StatusSuggestName, AT1102.DepartmentName, HT1102.DutyName,HT1105.ContractTypeName,
			HT0375.ContractNo,
			HT0375.ContractTypeID,
			HT0375.WorkDate,
			HT0375.WorkEndDate,
			HT0375.WorkAddress,
			HT0375.BaseSalaryNew
			FROM HT0375
			INNER JOIN HT0374 ON HT0374.DivisionID = HT0375.DivisionID AND HT0374.SuggestID = HT0375.SuggestID
			LEFT JOIN HT1400 ON HT1400.DivisionID = HT0375.DivisionID AND HT1400.EmployeeID = HT0375.EmployeeID
			LEFT JOIN HT1400 H00 ON H00.DivisionID = HT0374.DivisionID AND H00.EmployeeID = HT0374.EmployeeID
			LEFT JOIN AT0099 ON AT0099.ID = HT0375.StatusSuggest AND AT0099.CodeMaster = ''AT00000008''
			LEFT JOIN AT1102 ON AT1102.DepartmentID = HT0375.DepartmentID
			LEFT JOIN HT1102 ON HT1102.DivisionID = HT0375.DivisionID AND HT1102.DutyID = HT0375.DutyID
			LEFT JOIN HT1105 ON HT1105.DivisionID = HT0375.DivisionID AND HT1105.ContractTypeID = HT0375.ContractTypeID
			WHERE HT0375.DivisionID = '''+@DivisionID+'''
				AND HT0375.StatusSuggest <> 0
				AND ISNULL(HT0375.DepartmentID,'''') LIKE '''+@DepartmentID+'''
				AND ISNULL(HT0375.EmployeeID,'''') LIKE '''+@EmployeeID+'''
				AND ISNULL(HT0375.ContractTypeID,'''') LIKE '''+@ContractTypeID+'''
				AND HT0374.SuggestDate BETWEEN '''+CONVERT(NVARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(NVARCHAR(10),@ToDate,21)	+''' '
			
EXEC (@sSQL)
--PRINT @sSQL

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

