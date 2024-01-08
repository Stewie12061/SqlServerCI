IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2193]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2193]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form HRMF2193: hồ sơ bảo hiểm
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Phương Thảo on 17/08/2023
---- 
/*-- <Example>
	

	exec HRMP2193 @DivisionID=N'BBA-SI',@DivisionList=N''
	,@UserID=N'ADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1
	,@RecruitPeriodID=N'',@DepartmentID=N'',@DutyID=N''
	,@FromDate=NULL,@ToDate=NULL,@IsPeriod=1,@PeriodList=N'07/2023'
	,@ConditionRecruitPeriodID=N'ADMIN'',''ANGI-SS001'',''BBA-SELLIN'',''BRVT-SS001'',''HCQ12-SS001''
	,''MTA1-ASM001'',''NM-NV01'',''NM-NV02'',''NM-NV03'',''NMT-ASM001'',''QUNG-SS001'',''UNASSIGNED'',''VP-ADMIN'',''VP-KT04'',''VP-KT05'',''VP-KT06'',''VP-SO01'',''VP-SO02'',''VP-SO03'',''VP-SO04'',''VP-SO05'',''VP-SO06'',''VP-SO07'',''VP-SO08'',''VP-SO09'',''VP-SO10'',''VP-TGD'

----*/

CREATE PROCEDURE HRMP2193
( 	 @DivisionID VARCHAR(50),
	 @APK VARCHAR(50) 
)
AS 
DECLARE @sSQL NVARCHAR (MAX)=N''
  
SET @sSQL = N'
	SELECT HT60.APK
		,HT60.DivisionID
		,HT60.InsurFileID
		,AT051.UserName AS EmployeeName
		,AT02.DepartmentName AS DepartmentName
		,HT01.TeamName AS TeamName
		,HT02.DutyName AS DutyName
		,HT60.Notes
		,HT60.Basesalary
		,HT60.InsuranceSalary
		,HT60.Salary01
		,HT60.Salary02
		,HT60.Salary03
		,HT60.IsS
		,HT60.SNo
		,HT60.SBeginDate
		,HT60.CFromDate
		,HT60.CToDate
		,HT60.IsH
		,HT60.HNo
		,HT60.CNo
		,HT60.HFromDate
		,HT60.HToDate
		,HT99.Description AS HospitalName 
		,HT60.IsT
		,HT60.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HT60.CreateUserID) CreateUserID
		,HT60.CreateDate
		,HT60.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HT60.LastModifyUserID) LastModifyUserID
		,HT60.LastModifyDate
	FROM HT2460  HT60 WITH (NOLOCK)
	    LEFT JOIN AT1405 AT051 WITH (NOLOCK) ON AT051.DivisionID in ( HT60.DivisionID,''@@@'') AND AT051.UserID = HT60.EmployeeID
		LEFT JOIN AT1102 AT02 WITH (NOLOCK) ON AT02.DivisionID in ( HT60.DivisionID,''@@@'') AND HT60.DepartmentID = AT02.DepartmentID
		LEFT JOIN HT1101 HT01 WITH (NOLOCK) ON HT01.DivisionID = HT60.DivisionID AND HT01.TeamID = HT60.TeamID
		LEFT JOIN HT1102 HT02 WITH (NOLOCK) ON HT02.DivisionID = HT60.DivisionID AND HT60.DutyID = HT02.DutyID
		LEFT JOIN HT0099 HT99 WITH (NOLOCK) ON  HT99.ID = HT60.HospitalID AND  HT99.CodeMaster = ''HospitalID''
	WHERE	HT60.DivisionID = '''+@DivisionID+'''
        	AND HT60.APK ='''+ @APK+''';'
PRINT(@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
