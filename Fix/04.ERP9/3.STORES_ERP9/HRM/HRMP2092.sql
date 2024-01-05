IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2092]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HRMP2092]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Đổ nguồn màn hình cập nhật đề xuất đào tạo
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hải Long, Date: 20/09/2017
----Modified by Trọng Kiên on 06/08/2020: Fix lỗi trùng dữ liệu trả về
-- <Example>
---- 
/*-- <Example>
	EXEC HRMP2092 @DivisionID='AS',@UserID='ASOFTADMIN',@TrainingProposeID='TP0001',@Mode=1
----*/

CREATE PROCEDURE [HRMP2092] 
( 
	@DivisionID NVARCHAR(50),
	@UserID NVARCHAR(50),
	@TrainingProposeID NVARCHAR(50),
	@Mode TINYINT -- 0: Load Master, 1: Load Detail	
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)

IF @Mode = 0
BEGIN
	SET @sSQL = ' 
	SELECT HRMT2090.APK, HRMT2090.DivisionID, HRMT2090.TrainingProposeID, HRMT2090.DepartmentID, AT1102.DepartmentName,
	HRMT2090.ProposeAmount, HRMT2090.Description1, HRMT2090.Description2, HRMT2090.Description3, HRMT2090.InheritID1, HRMT2090.InheritID2, HRMT2090.IsAll,
	HRMT2090.AssignedToUserID, (SELECT TOP 1 FullName FROM AT1103 WHERE EmployeeID = HRMT2090.AssignedToUserID) AS AssignedToUserName,
	HRMT2090.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2090.CreateUserID) CreateUserID, HRMT2090.CreateDate, 
	HRMT2090.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2090.LastModifyUserID) LastModifyUserID, HRMT2090.LastModifyDate
	FROM HRMT2090 WITH (NOLOCK)
	LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = HRMT2090.DepartmentID
	WHERE HRMT2090.DivisionID = '''+@DivisionID+''' 
	AND HRMT2090.TrainingProposeID = '''+@TrainingProposeID+''''			
END
ELSE
BEGIN
	SET @sSQL = ' 
	SELECT HRMT2091.DivisionID, HRMT2091.TransactionID, HRMT2091.TrainingProposeID, HRMT2091.EmployeeID, HV1400.FullName AS EmployeeName, HV1400.DutyName, HRMT2091.DepartmentID, HV1400.DepartmentName,
	HRMT2091.TrainingFieldID, HRMT1040.TrainingFieldName, HRMT2091.ProposeAmount_DT AS ProposeAmount, HRMT2091.FromDate, HRMT2091.ToDate, HRMT2091.Notes, HRMT2091.InheritID, HRMT2091.InheritTableID, HRMT2091.ID,
	HRMT2091.TranQuarter, HRMT2091.TranYear, HRMT2091.Orders
	FROM HRMT2091 WITH (NOLOCK)
	LEFT JOIN HV1400 ON HV1400.DivisionID = HRMT2091.DivisionID AND HV1400.EmployeeID = HRMT2091.EmployeeID
	LEFT JOIN HRMT1040 WITH (NOLOCK) ON HRMT1040.TrainingFieldID = HRMT2091.TrainingFieldID
	WHERE HRMT2091.DivisionID = '''+@DivisionID+''' 
	AND HRMT2091.TrainingProposeID = '''+@TrainingProposeID+'''
	GROUP BY HRMT2091.DivisionID, HRMT2091.TransactionID, HRMT2091.TrainingProposeID, HRMT2091.EmployeeID, HV1400.FullName, HV1400.DutyName, HRMT2091.DepartmentID, HV1400.DepartmentName,
			 HRMT2091.TrainingFieldID, HRMT1040.TrainingFieldName, HRMT2091.ProposeAmount_DT, HRMT2091.FromDate, HRMT2091.ToDate, HRMT2091.Notes, HRMT2091.InheritID, HRMT2091.InheritTableID, HRMT2091.ID,
			 HRMT2091.TranQuarter, HRMT2091.TranYear, HRMT2091.Orders
	ORDER BY HRMT2091.Orders'	
END


		
EXEC (@sSQL)
PRINT @sSQL	

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

