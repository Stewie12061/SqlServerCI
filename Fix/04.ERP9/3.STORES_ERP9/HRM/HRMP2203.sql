IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2203]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2203]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load màn hình chi tiết thông tin kết quả thử việc (HRMF2202)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Phương Thảo on 18/10/2023
---- 
/*-- <Example>
	

	exec HRMP2203 @DivisionID=N'BBA-SI',@DivisionList=N''
	,@UserID=N'ADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1
	,@RecruitPeriodID=N'',@DepartmentID=N'',@DutyID=N''
	,@FromDate=NULL,@ToDate=NULL,@IsPeriod=1,@PeriodList=N'07/2023'
	,@ConditionRecruitPeriodID=N'ADMIN'',''ANGI-SS001'',''BBA-SELLIN'',''BRVT-SS001'',''HCQ12-SS001''
	,''MTA1-ASM001'',''NM-NV01'',''NM-NV02'',''NM-NV03'',''NMT-ASM001'',''QUNG-SS001'',''UNASSIGNED'',''VP-ADMIN'',''VP-KT04'',''VP-KT05'',''VP-KT06'',''VP-SO01'',''VP-SO02'',''VP-SO03'',''VP-SO04'',''VP-SO05'',''VP-SO06'',''VP-SO07'',''VP-SO08'',''VP-SO09'',''VP-SO10'',''VP-TGD'

----*/

CREATE PROCEDURE HRMP2203
( 	 @DivisionID VARCHAR(50),
	 @APK VARCHAR(50) 
)
AS 
DECLARE @sSQL NVARCHAR (MAX)=N''
  
SET @sSQL = N'
	SELECT HT34.APK
				, HT34.DivisionID
        , HT34.ResultNo
    		, HT34.ResultDate
    		, HT34.ContractNo
    		, AT03.FullName AS EmployeeName
    		, HT34.Status
    		, HT09.Description AS StatusName  
    		, HT34.TestFromDate
    		, HT34.TestToDate
    		, HT99.Description AS ResultName
    		, CASE
    			WHEN HT34.IsStopBeforeEndDate = 1 THEN ''có''
    			WHEN HT34.IsStopBeforeEndDate = 0 THEN ''không''
    			END AS IsStopBeforeEndDate
    		, HT34.EndDate
    		, AT031.FullName AS ReviewPersonName---Người đánh giá
    		, AT032.FullName AS DecidePersonName---Người duyệt 
    		, HT34.Notes
    		, HT34.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HT34.CreateUserID) CreateUserID
    		, HT34.CreateDate
    		, HT34.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HT34.LastModifyUserID) LastModifyUserID
    		, HT34.LastModifyDate
	FROM HT0534  HT34 WITH (NOLOCK)
	LEFT JOIN AT1103 AT03  WITH (NOLOCK) ON AT03.DivisionID IN ( HT34.DivisionID, ''@@@'') AND AT03.EmployeeID = HT34.EmployeeID
	LEFT JOIN HT0099 HT09  WITH (NOLOCK) ON HT09.ID = HT34.Status  AND HT09.CodeMaster = ''Status''
	LEFT JOIN HT0099 HT99  WITH (NOLOCK) on HT34.ResultID = HT99.ID and HT99.CodeMaster = ''ResultID''
	LEFT JOIN AT1103 AT031 WITH (NOLOCK) ON AT031.DivisionID IN ( HT34.DivisionID, ''@@@'') AND AT031.EmployeeID = HT34.ReviewPerson
	LEFT JOIN AT1103 AT032 WITH (NOLOCK) ON AT032.DivisionID IN ( HT34.DivisionID, ''@@@'') AND AT032.EmployeeID = HT34.DecidePerson
	WHERE	HT34.DivisionID = '''+@DivisionID+'''
        AND HT34.APK ='''+ @APK+''';'
PRINT(@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
