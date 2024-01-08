IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2122]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2122]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Đổ nguồn màn hình cập nhật ghi nhận kết quả
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hải Long, Date: 20/09/2017
----Modified by: Trọng Kiên, Date: 29/08/2020: Bổ sung load Người phụ trách và lịch đào tạo
----Modified by: Thu Hà      Date: 28/09/2020: Bổ sung  hiển thị tên người người phụ trách và fix không hiển thị tên nhân viên và chức vụ
-- <Example>
---- 
/*-- <Example>
	EXEC HRMP2122 @DivisionID='AS',@UserID='ASOFTADMIN',@TrainingResultID='3123',@Mode=0 

----*/

CREATE PROCEDURE [HRMP2122] 
( 
	@DivisionID NVARCHAR(50),
	@UserID NVARCHAR(50),
	@TrainingResultID NVARCHAR(50),
	@Mode TINYINT -- @Mode = 0: Load Master, @Mode = 1: Load Detail		
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)

IF @Mode = 0
BEGIN
	SET @sSQL = '	
	SELECT HRMT2120.APK, HRMT2120.DivisionID, HRMT2120.TrainingResultID, HRMT2120.TrainingScheduleID AS TrainingScheduleName, HRMT1050.TrainingCourseID, HRMT1050.Address,
	HRMT1050.ObjectID, 
	IIF(ISNULL(AT1202.ObjectName, '''') != '''', AT1202.ObjectName, A2.FullName) AS ObjectName,
	HRMT2100.TrainingFieldID, HRMT1040.TrainingFieldName, HRMT1050.TrainingType, HT0099.Description AS TrainingTypeName, 
	HRMT2120.ResultTypeID, HRMV2120.ResultTypeName, HRMT2120.Description1, HRMT2120.Description2, HRMT2120.TrainingScheduleID,
	HRMT2120.AssignedToUserID,
	A1.FullName AS AssignedToUserName,
	HRMT2120.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2120.CreateUserID) CreateUserID, HRMT2120.CreateDate, 
	HRMT2120.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2120.LastModifyUserID) LastModifyUserID, HRMT2120.LastModifyDate
	FROM HRMT2120 WITH (NOLOCK)
	LEFT JOIN HRMT2100 WITH (NOLOCK) ON HRMT2100.DivisionID = HRMT2120.DivisionID AND HRMT2100.TrainingScheduleID = HRMT2120.TrainingScheduleID
	LEFT JOIN HRMT1040 WITH (NOLOCK) ON HRMT1040.TrainingFieldID = HRMT2100.TrainingFieldID	
	LEFT JOIN HRMT1050 WITH (NOLOCK) ON HRMT1050.TrainingCourseID = HRMT2100.TrainingCourseID	
	LEFT JOIN HT0099 WITH (NOLOCK) ON HT0099.ID = HRMT1050.TrainingType AND HT0099.CodeMaster = ''TrainingType''
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = HRMT1050.ObjectID
	LEFT JOIN HRMV2120 ON HRMV2120.ResultTypeID = HRMT2120.ResultTypeID
	LEFT JOIN AT1103 A1  WITH (NOLOCK) ON A1.EmployeeID = HRMT2120.AssignedToUserID
	LEFT JOIN AT1103 A2 WITH (NOLOCK) ON A2.EmployeeID = HRMT1050.ObjectID
	WHERE HRMT2120.DivisionID = ''' + @DivisionID + '''
	AND HRMT2120.APK = ''' + @TrainingResultID + ''''
END
ELSE
BEGIN
	SET @sSQL = '	
	SELECT HRMT2121.APK, HRMT2121.DivisionID, HRMT2121.TransactionID, HRMT2121.TrainingResultID, HRMT2121.EmployeeID, 
	--HT1400.LastName + '' '' + HT1400.MiddleName + '' '' + HT1400.FirstName AS EmployeeName,
	AT1405.UserName AS EmployeeName,
	HRMT2121.DepartmentID, 
	AT1102.DepartmentName, 
	--HT1403.DutyID, 
	HT1102.DutyName, 
	HRMT2121.StatusTypeID, HRMV2121.StatusTypeName, 
	HRMT2121.ResultID, HRMV2122.ResultName, HRMT2121.Notes, HRMT2121.Orders, HRMT2121.InheritID, HRMT2121.InheritTransactionID
	FROM HRMT2121 WITH (NOLOCK)
	LEFT JOIN HRMV2121 ON HRMV2121.StatusTypeID = HRMT2121.StatusTypeID
	LEFT JOIN HRMV2122 ON HRMV2122.ResultID = HRMT2121.ResultID
	LEFT JOIN HT1400 WITH (NOLOCK) ON HT1400.EmployeeID = HRMT2121.EmployeeID
	--LEFT JOIN HT1403 WITH (NOLOCK) ON HT1403.DivisionID = HT1400.DivisionID AND HT1403.EmployeeID = HT1400.EmployeeID
	LEFT JOIN AT1405 WITH (NOLOCK) ON AT1405.UserID = HRMT2121.EmployeeID AND AT1405.DivisionID IN (HRMT2121.DivisionID, ''@@@'')
	--LEFT JOIN HT1102 WITH (NOLOCK) ON HT1102.DivisionID = HT1403.DivisionID AND HT1102.DutyID = HT1403.DutyID 
	LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = HRMT2121.EmployeeID AND AT1103.DivisionID IN (HRMT2121.DivisionID, ''@@@'')
	LEFT JOIN HT1102 WITH (NOLOCK) ON HT1102.DutyID = AT1103.DutyID AND HT1102.DivisionID IN (HRMT2121.DivisionID, ''@@@'')
	LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = HRMT2121.DepartmentID 
	WHERE HRMT2121.DivisionID = ''' + @DivisionID + '''
	AND HRMT2121.TrainingResultID = ''' + @TrainingResultID + '''
	ORDER BY HRMT2121.Orders'	
END

PRINT @sSQL			
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
