IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2192]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HRMP2192]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Update:Đổ dữ liệu vào màn hình cập nhật Hồ sơ bảo hiểm (HRMF2192)
---Tham khảo HRMP2082
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Phương Thảo, Date: 17/08/2023
-- <Example>
---- 
/*-- <Example>
	EXEC HRMP2192 @DivisionID='AS',@UserID='ASOFTADMIN',@APK='TR0001'
----*/

CREATE PROCEDURE [HRMP2192] 
( 
	@DivisionID NVARCHAR(50),
	@UserID NVARCHAR(50),
	@APK NVARCHAR(50)
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)

SET @sSQL = '
		SELECT HT60.APK
		,HT60.InsurFileID
		,HT60.EmployeeID
		,AT051.UserName AS EmployeeName
		,HT60.DepartmentID
		,HT60.TeamID
		,HT60.DutyID
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
		,HT60.HospitalID
		,HT60.IsT
		,HT60.TranMonth
		,HT60.TranYear
		,HT60.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HT60.CreateUserID) CreateUserID
		,HT60.CreateDate
		,HT60.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HT60.LastModifyUserID) LastModifyUserID
		,HT60.LastModifyDate
        FROM HT2460 HT60 WITH (NOLOCK)
		LEFT JOIN AT1405 AT051 WITH (NOLOCK) ON AT051.DivisionID in ( HT60.DivisionID,''@@@'') AND AT051.UserID = HT60.EmployeeID
		LEFT JOIN AT1102 AT02 WITH (NOLOCK) ON AT02.DivisionID = HT60.DivisionID AND HT60.DepartmentID = AT02.DepartmentID
		LEFT JOIN HT1101 HT01 WITH (NOLOCK) ON HT01.DivisionID = HT60.DivisionID AND HT01.TeamID = HT60.TeamID
		LEFT JOIN HT1102 HT02 WITH (NOLOCK) ON HT02.DivisionID = HT60.DivisionID AND HT60.DutyID = HT02.DutyID
		LEFT JOIN HT0099 HT99 WITH (NOLOCK) ON  HT99.ID = HT60.HospitalID AND  HT99.CodeMaster = ''HospitalID''
        WHERE HT60.DivisionID = '''+@DivisionID+'''
        AND HT60.APK = '''+@APK+''''



PRINT @sSQL			
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

