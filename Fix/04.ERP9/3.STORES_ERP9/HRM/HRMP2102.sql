IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2102]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2102]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Đổ nguồn màn hình cập nhật lịch đào tạo
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hải Long, Date: 20/09/2017
--- Modified on 14/02/2019 by Bảo Anh: Bổ sung trường Sessions, HoursPerSession
--- Modified on 19/07/2023 by Anh Đô: Select thêm cột IsAll
--- Modified on 13/10/2023 by Minh Trí: Cập nhật thêm điều kiện cho cột ScheduleAmount nếu null thì thay bằng 0
-- <Example>
---- 
/*-- <Example>
	EXEC HRMP2102 @DivisionID='AS',@UserID='ASOFTADMIN',@TrainingScheduleID='TS0001', @Mode = 0
----*/

CREATE PROCEDURE [HRMP2102] 
( 
	@DivisionID NVARCHAR(50),
	@UserID NVARCHAR(50),
	@TrainingScheduleID NVARCHAR(50),
	@Mode TINYINT -- @Mode = 0: Load Master, @Mode = 1: Load Detail
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)

IF @Mode = 0
BEGIN
	SET @sSQL = '
	SELECT	HRMT2100.APK
			, HRMT2100.DivisionID
			, HRMT2100.TrainingScheduleID
			, HRMT2100.TrainingFieldID
			, HRMT1040.TrainingFieldName
			, COALESCE(HRMT2100.ScheduleAmount, 0) AS ScheduleAmount
			, HRMT2100.SpecificHours
			, HRMT2100.FromDate, HRMT2100.ToDate
			, HRMT2100.TrainingCourseID
			, HRMT2100.TrainingCourseID AS TrainingCourseName
			, HRMT1050.TrainingType
			, HRMT1050.ObjectID
			, IIF(ISNULL(AT1202.ObjectName, '''') != '''', AT1202.ObjectName, AT1103.FullName) AS ObjectName
			, HT0099.[Description] AS TrainingTypeName
			, HRMT2100.Address
			, HRMT2100.Description1
			, HRMT2100.Description2
			, HRMT2100.Description3
			, CASE WHEN HRMT2100.TrainingProposeID IS NULL THEN HRMT2090.ProposeAmount
				ELSE (SELECT SUM(ProposeAmount) 
					  FROM HRMT2091 WITH (NOLOCK)
					  WHERE HRMT2091.DivisionID = HRMT2101.DivisionID AND HRMT2091.TrainingProposeID = HRMT2101.InheritID AND HRMT2091.TransactionID = HRMT2101.InheritTransactionID
			) END AS ProposeAmount_MT
			, HRMT2100.AssignedToUserID
			, (SELECT TOP 1 FullName FROM AT1103 WHERE EmployeeID = HRMT2100.AssignedToUserID) AS AssignedToUserName
			, HRMT2100.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2100.CreateUserID) CreateUserID, HRMT2100.CreateDate
			, HRMT2100.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2100.LastModifyUserID) LastModifyUserID, HRMT2100.LastModifyDate
			, HRMT2100.Sessions, HRMT2100.HoursPerSession
			, HRMT2100.IsAll
	FROM HRMT2100 WITH (NOLOCK)
		LEFT JOIN HRMT2101 WITH (NOLOCK) ON HRMT2101.DivisionID = HRMT2100.DivisionID AND HRMT2101.TrainingScheduleID = Convert(Varchar(50),HRMT2100.APK)
		LEFT JOIN HRMT2090 WITH (NOLOCK) ON HRMT2090.DivisionID = HRMT2100.DivisionID AND HRMT2090.TrainingProposeID = HRMT2100.TrainingProposeID
		LEFT JOIN HRMT1040 WITH (NOLOCK) ON HRMT1040.TrainingFieldID = HRMT2100.TrainingFieldID
		LEFT JOIN HRMT1050 WITH (NOLOCK) ON HRMT1050.TrainingCourseID = HRMT2100.TrainingCourseID
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = HRMT1050.ObjectID
		LEFT JOIN HT0099 WITH (NOLOCK) ON HT0099.ID = HRMT1050.TrainingType AND HT0099.CodeMaster = ''TrainingType''
		LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = HRMT1050.ObjectID
	WHERE HRMT2100.DivisionID = ''' + @DivisionID + '''
	AND Convert(Varchar(50),HRMT2100.APK) = ''' + @TrainingScheduleID + ''''
END
ELSE
BEGIN
	SET @sSQL = '
	SELECT HRMT2101.TransactionID, HRMT2101.TrainingScheduleID, HRMT2101.EmployeeID, AT1405.UserName AS EmployeeName, HRMT2100.SpecificHours,
	HRMT2101.DepartmentID, AT1102.DepartmentName, HT1102.DutyName, COALESCE(HRMT2100.ScheduleAmount, 0) AS ScheduleAmount, HRMT2101.Notes, HRMT2101.Orders, HRMT2101.InheritID, HRMT2101.InheritTransactionID,
	HRMT2091.FromDate AS FromDate_DT, HRMT2091.ToDate AS ToDate_DT, HRMT2091.ProposeAmount AS ProposeAmount_DT
	FROM HRMT2101 WITH (NOLOCK)
	INNER JOIN HRMT2100 WITH (NOLOCK) ON HRMT2101.DivisionID = HRMT2100.DivisionID AND HRMT2101.TrainingScheduleID = Convert(Varchar(50),HRMT2100.APK)
	LEFT JOIN HRMT2091 WITH (NOLOCK) ON HRMT2091.DivisionID = HRMT2101.DivisionID AND HRMT2091.TrainingProposeID = HRMT2101.InheritID AND HRMT2091.TransactionID = HRMT2101.InheritTransactionID
	LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = HRMT2101.DepartmentID
	LEFT JOIN AT1405 WITH (NOLOCK) ON AT1405.UserID = HRMT2101.EmployeeID AND AT1405.DivisionID IN (HRMT2101.DivisionID, ''@@@'')
	LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = AT1405.UserID AND AT1103.DivisionID IN (AT1405.DivisionID, ''@@@'')
	LEFT JOIN HT1102 WITH (NOLOCK) ON HT1102.DivisionID = AT1103.DivisionID AND HT1102.DutyID = AT1103.DutyID
	WHERE HRMT2100.DivisionID = ''' + @DivisionID + '''
	AND Convert(Varchar(50),HRMT2100.APK) = ''' + @TrainingScheduleID + ''''
END

PRINT @sSQL
EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


