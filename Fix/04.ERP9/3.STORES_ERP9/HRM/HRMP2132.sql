IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2132]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2132]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Đổ nguồn màn hình cập nhật ghi nhận chi phí
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hải Long, Date: 18/09/2017
----Modified by: Trọng Kiên, Date: 28/08/2020: Fix lỗi load người phụ trách và lịch đào tạo
----Modified by: Tiến Sỹ  Date: 17/07/2023: Fix lỗi hiển thị tên nhân viên và phòng ban
----Modified by: Võ Dương Date: 22/09/2023: Fix lỗi hiển thị tên nhân viên và phòng ban khi load màn hình cập nhật
-- <Example>
---- 
/*-- <Example>
	EXEC HRMP2132 @DivisionID='AS',@UserID='ASOFTADMIN',@TrainingCostID='TC0001',@Mode=1
----*/

CREATE PROCEDURE [HRMP2132] 
( 
	@DivisionID NVARCHAR(50),
	@UserID NVARCHAR(50),
	@TrainingCostID NVARCHAR(50),
	@Mode TINYINT -- @Mode = 0: Load Master, @Mode = 1: Load Detail	
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)

IF @Mode = 0
BEGIN
	SET @sSQL = '
	SELECT HRMT2130.APK
		, HRMT2130.DivisionID
		, HRMT2130.TrainingCostID
		, HRMT2130.TrainingScheduleID
		, HRMT2130.TrainingScheduleID AS TrainingSchedule
		, HRMT2130.CostAmount
		, HRMT2130.FromDate
		, HRMT2130.ToDate
		, HRMT2130.Description
		, HRMT2100.[Address]
		, HRMT1050.TrainingCourseID
		, HRMT1050.TrainingFieldID
		, HRMT1040.TrainingFieldName
		, HRMT1050.TrainingType
		, HT0099.Description AS TrainingTypeName
		, HRMT1050.ObjectID
		, IIF(ISNULL(AT1202.ObjectName, '''') != '''', AT1202.ObjectName, A2.FullName) AS ObjectName
		, HRMT2130.AssignedToUserID
		, (SELECT TOP 1 FullName FROM AT1103 WHERE EmployeeID = HRMT2130.AssignedToUserID) AS AssignedToUserName
		, HRMT2130.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2130.CreateUserID) CreateUserID
		, HRMT2130.CreateDate, HRMT2130.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2130.LastModifyUserID) LastModifyUserID
		, HRMT2130.LastModifyDate
	FROM HRMT2130 WITH (NOLOCK)
		LEFT JOIN HRMT2100 WITH (NOLOCK) ON HRMT2100.DivisionID = HRMT2130.DivisionID AND HRMT2100.TrainingScheduleID = HRMT2130.TrainingScheduleID
		LEFT JOIN HRMT1050 WITH (NOLOCK) ON HRMT1050.TrainingCourseID = HRMT2100.TrainingCourseID	
		LEFT JOIN HT0099 WITH (NOLOCK) ON HT0099.ID = HRMT1050.TrainingType AND HT0099.CodeMaster = ''TrainingType''
		LEFT JOIN HRMT1040 WITH (NOLOCK) ON HRMT1040.TrainingFieldID = HRMT2100.TrainingFieldID
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = HRMT1050.ObjectID
		LEFT JOIN AT1103 A2 WITH (NOLOCK) ON  A2.EmployeeID = HRMT1050.ObjectID
	WHERE HRMT2130.DivisionID = ''' + @DivisionID + ''' AND HRMT2130.APK = ''' + @TrainingCostID + ''''
END
ELSE
BEGIN
	SET @sSQL = '
	SELECT HRMT2131.APK,
	HRMT2131.DivisionID,
	HRMT2131.TransactionID,
	HRMT2131.TrainingCostID,
	HRMT2131.EmployeeID,
	AT1103.Fullname AS EmployeeName,
	AT1103.DepartmentID,
	AT1102.DepartmentName,
	HT1102.DutyID,
	HT1102.DutyName,
	HRMT2131.CostAmount,
	HRMT2131.Notes,
	HRMT2131.Orders,
	HRMT2131.InheritID,
	HRMT2131.InheritTransactionID
	FROM HRMT2131 WITH (NOLOCK)
	LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = HRMT2131.EmployeeID
	LEFT JOIN HT1102 WITH (NOLOCK) ON HT1102.DivisionID = AT1103.DivisionID AND HT1102.DutyID = AT1103.DutyID 
	LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = AT1103.DepartmentID
	WHERE HRMT2131.DivisionID = ''' + @DivisionID + '''
	AND HRMT2131.TrainingCostID = ''' + @TrainingCostID + '''
	ORDER BY HRMT2131.Orders'
END	


--PRINT @sSQL			
EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
