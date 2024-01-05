IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2182]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HRMP2182]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Đổ nguồn màn hình cập nhật hợp đồng lao động(HRMF2182)
---Tham khảo HRMP2082
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Phương Thảo, Date: 08/08/2023
----Updated by: Phương Thảo, Date: 16/08/2023 : bổ sung load các trường 
-- <Example>
---- 
/*-- <Example>
	EXEC HRMP2182 @DivisionID='AS',@UserID='ASOFTADMIN',@ContractID='TR0001'
----*/

CREATE PROCEDURE [HRMP2182] 
( 
	@DivisionID NVARCHAR(50),
	@UserID NVARCHAR(50),
	@ContractID NVARCHAR(50)
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)

SET @sSQL = '
		SELECT HT60.APK
		, HT60.DivisionID
		, AT39.ContractTypeName
		, HT60.DepartmentID
		, AT1102.DepartmentName AS DepartmentName
		, HT60.TeamID
		, HT01.TeamName AS TeamName
		, HT60.EmployeeID
		, AT051.UserName AS EmployeeName
		, HT60.ContractID
		, HT60.ContractNo
		, HT60.StatusRecieve
		, HT60.SignDate
		, HT60.SubContract
		, HT60.ContractTypeID 
        , HT60.SignPersonID
		, AT052.UserName AS SignPersonName
		, HT60.DutyID
        , HT1102.DutyName
        , HT60.Works
        , HT60.WorkDate
        , HT60.WorkEndDate
		, HT60.BaseSalary
        , HT60.ProbationSalary
        , HT60.Salary01
        , HT60.Salary02
        , HT60.Salary03
        , HT60.Salary04
        , HT60.Salary05
        , HT60.Salary06
        , HT60.Salary07
        , HT60.Salary08
        , HT60.Salary09
        , HT60.Salary10
        , HT60.Allowance
        , HT60.WorkAddress
        , HT60.WorkTime
        , HT60.IssueTool
        , HT60.Conveyance
        , HT60.PayForm
        , HT60.PayDate
        , HT60.Bonus
        , HT60.SalaryRegulation
        , HT60.RestRegulation
        , HT60.SafetyEquiment
        , HT60.SI
        , HT60.TrainingRegulation
        , HT60.OtherAgreement
        , HT60.Notes
           
        FROM HT1360 HT60 WITH (NOLOCK)
		LEFT JOIN AT1339 AT39 WITH (NOLOCK) ON AT39.DivisionID = HT60.DivisionID AND AT39.ContractTypeID = HT60.ContractTypeID
        LEFT JOIN AT1102 WITH (NOLOCK) ON HT60.DepartmentID = AT1102.DepartmentID    
        LEFT JOIN HT1101 HT01 WITH (NOLOCK) ON HT01.DivisionID = HT60.DivisionID AND HT01.TeamID = HT60.TeamID    
        LEFT JOIN AT1405 AT051 WITH (NOLOCK) ON AT051.DivisionID in ( HT60.DivisionID,''@@@'') AND AT051.UserID = HT60.EmployeeID
		LEFT JOIN AT1405 AT052 WITH (NOLOCK) ON AT052.DivisionID in ( HT60.DivisionID,''@@@'') AND AT052.UserID = HT60.SignPersonID
        LEFT JOIN HT1102 WITH (NOLOCK) ON HT60.DivisionID = HT1102.DivisionID AND HT60.DutyID = HT1102.DutyID
		LEFT JOIN AT1339 WITH (NOLOCK) ON HT60.ContractTypeID = AT1339.ContractTypeID
        WHERE HT60.DivisionID = '''+@DivisionID+'''
        AND HT60.ContractID = '''+@ContractID+''''



PRINT @sSQL			
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

