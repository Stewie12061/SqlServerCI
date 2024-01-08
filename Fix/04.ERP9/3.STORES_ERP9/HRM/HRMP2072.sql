IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2072]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HRMP2072]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Đổ nguồn màn hình cập nhật kế hoạch đào tạo định kỳ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hải Long, Date: 15/09/2017
-- <Example>
---- 
/*-- <Example>
	HRMP2072 @DivisionID='AS',@UserID='ASOFTADMIN',@TrainingPlanID='000001'
----*/

CREATE PROCEDURE [HRMP2072] 
( 
	@DivisionID NVARCHAR(50),
	@UserID NVARCHAR(50),
	@TrainingPlanID NVARCHAR(50)
) 
AS 
DECLARE @sSQL1 NVARCHAR(MAX),
		@sSQL2 NVARCHAR(MAX)

-- Load Master
SET @sSQL1 = '
SELECT HRMT2070.APK,HRMT2070.DivisionID, HRMT2070.TrainingPlanID, Description, 
AssignedToUserID, (SELECT TOP 1 FullName FROM AT1103 WHERE EmployeeID = HRMT2070.AssignedToUserID) AS AssignedToUserName, HRMT2070.CreateUserID, 
HRMT2070.CreateDate, HRMT2070.LastModifyUserID, HRMT2070.LastModifyDate
FROM HRMT2070 WITH (NOLOCK)
WHERE HRMT2070.DivisionID IN ('''+@DivisionID+''', ''@@@'')
AND HRMT2070.TrainingPlanID = '''+@TrainingPlanID+''''

-- Load Detail
SET @sSQL2 = '
SELECT HRMT2071.TransactionID, HRMT2071.IsAll, HRMT2071.DepartmentID, AT1102.DepartmentName, HRMT2071.TrainingFieldID, HRMT1040.TrainingFieldName, StartDate,
DurationPlan, HRMT2071.RepeatTypeID, HRMV2070.RepeatTypeName, HRMT2071.RepeatTime, HRMV2071.RepeatTimeName, HRMV2071.Notes
FROM HRMT2071 WITH (NOLOCK)
LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = HRMT2071.DepartmentID
LEFT JOIN HRMT1040 WITH (NOLOCK) ON HRMT1040.TrainingFieldID = HRMT2071.TrainingFieldID
LEFT JOIN HRMV2070 WITH (NOLOCK) ON HRMV2070.RepeatTypeID = HRMT2071.RepeatTypeID
LEFT JOIN HRMV2071 WITH (NOLOCK) ON HRMV2071.RepeatTime = HRMT2071.RepeatTime
WHERE HRMT2071.DivisionID IN ('''+@DivisionID+''', ''@@@'')
AND HRMT2071.TrainingPlanID = '''+@TrainingPlanID+''''

--PRINT @sSQL1
--PRINT @sSQL2			
EXEC (@sSQL1 + @sSQL2)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

