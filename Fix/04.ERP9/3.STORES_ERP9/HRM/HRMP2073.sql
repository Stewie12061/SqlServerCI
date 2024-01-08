IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2073]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2073]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load đổ nguồn màn hình xem thông tin kế hoạch đào tạo định kỳ
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Hải Long on 18/09/2017
---- <Example>
---- Exec HRMP2073 @DivisionID='AS',@UserID='ASOFTADMIN',@TrainingPlanID='000001'
---- 

CREATE PROCEDURE [dbo].[HRMP2073]
( 
  @DivisionID NVARCHAR(50),
  @UserID NVARCHAR(50),
  @TrainingPlanID NVARCHAR(50)
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)

SET @sSQL = ' 		
SELECT HRMT2070.APK, CASE WHEN HRMT2070.IsCommon = 1 THEN NULL ELSE HRMT2070.DivisionID END AS DivisionID, 
HRMT2070.TrainingPlanID, HRMT2070.AssignedToUserID, AT1103.FullName AS AssignedToUserName, HRMT2070.Description, HRMT2070.Disabled, HRMT2070.IsCommon,
CASE WHEN HRMT2070.Disabled = 1 THEN N''Có'' ELSE N''Không'' END DisabledName,
CASE WHEN HRMT2070.IsCommon = 1 THEN N''Có'' ELSE N''Không'' END IsCoName,
HRMT2071.IsAll, HRMT2071.DepartmentID, AT1102.DepartmentName, HRMT2071.TrainingFieldID, HRMT1040.TrainingFieldName, HRMT2071.StartDate,
HRMT2071.DurationPlan, HRMT2071.RepeatTypeID, HRMV2070.RepeatTypeName, HRMT2071.RepeatTime, HRMV2071.RepeatTimeName, HRMT2071.Notes,
HRMT2070.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2070.CreateUserID) CreateUserID, HRMT2070.CreateDate, 
HRMT2070.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2070.LastModifyUserID) LastModifyUserID, HRMT2070.LastModifyDate
FROM HRMT2070 WITH (NOLOCK)
INNER JOIN HRMT2071 WITH (NOLOCK) ON HRMT2071.DivisionID = HRMT2070.DivisionID AND HRMT2071.TrainingPlanID = HRMT2070.TrainingPlanID
LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = HRMT2071.DepartmentID
LEFT JOIN HRMT1040 WITH (NOLOCK) ON HRMT1040.TrainingFieldID = HRMT2071.TrainingFieldID
LEFT JOIN HRMV2070 WITH (NOLOCK) ON HRMV2070.RepeatTypeID = HRMT2071.RepeatTypeID
LEFT JOIN HRMV2071 WITH (NOLOCK) ON HRMV2071.RepeatTime = HRMT2071.RepeatTime
LEFT JOIN AT1103 WITH (NOLOCK) ON HRMT2070.AssignedToUserID = AT1103.EmployeeID AND AT1103.DivisionID IN ('''+@DivisionID+''', ''@@@'')
WHERE HRMT2070.DivisionID = ''' + @DivisionID + '''
AND HRMT2070.TrainingPlanID = ''' + @TrainingPlanID + ''''

--PRINT(@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
