IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP0129]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP0129]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
--- Load danh sách nhân viên theo biến phân quyền dữ liệu ConditionTaskID
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Tấn Lộc on 25/05/2021
----Modify by: Hoài Bảo on 17/06/2021 - Thêm code load danh sách nhân viên theo biến phân quyền dữ liệu ConditionLeadID và ConditionOpportunityID
----Modify by: Hoài Bảo on 09/07/2021 - Đổi cách load danh sách nhân viên từ bảng hồ sơ nhân viên và thay đổi điều kiện lấy dữ liệu loại user hệ thống, users đã khóa, users đã nghỉ bị khóa
----Modify by: Hoài Bảo on 10/08/2021 - Thêm điều kiện load dữ liệu EmployeeStatus <> 9: Loại nhân viên đã nghỉ làm.
-- <Example>
/*
    EXEC OOP0129 @DivisionID=N'',@UserID=N'ASOFTADMIN',@ConditionTaskID=N'ASOFTADMIN'',''D11001'',''D16001'',''D21001'',''D26001'',''D26002'',''D31001'',''D31002'',''D31003'',''D31004'',''D31006'',''D31007'',''D31008'',''D31009'',''D36001'',''D41001'',''D41002'',''D46001'',''D51001'',''D51002'',''D51003'',''D51004'',''D51005'',''DGD001'',''DKS001'',''DQT001'',''NGA'',''NGA002'',''NV01'',''NV02'',''NV03'',''NV04'',''SUPPORT'',''T000001'',''T000007'',''T000008'',''T000009'',''T000010'',''T000011'',''T000013'',''T000016'',''TANLOC'',''TANLOC1'',''TANTHANH'',''THANHTHANH'',''TOAN'',''TOAN_PRV'',''TRUONGLAM'',''UNASSIGNED'',''USER01'',''USER02'',''USER03'',''USER04'',''USER05'',''USERTEST'',''USERTESTROLE1'
*/

 CREATE PROCEDURE [dbo].[OOP0129] (
     @DivisionID NVARCHAR(2000),
	 @UserID VARCHAR(50),
	 @ConditionTaskID VARCHAR(MAX) = NULL,
	 @ConditionLeadID VARCHAR(MAX) = NULL,
	 @ConditionOpportunityID VARCHAR(MAX) = NULL
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@CustomerIndex int 

	select @CustomerIndex = CustomerName from CustomerIndex
	SET @sWhere = ''
	SET @TotalRow = ''
	SET @OrderBy = 'H1.EmployeeID, A1.FullName'

	IF ISNULL(@ConditionTaskID, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND H1.EmployeeID IN (''' + @ConditionTaskID + ''')'
	END

	IF ISNULL(@ConditionLeadID, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND H1.EmployeeID IN (''' + @ConditionLeadID + ''')'
	END

	IF ISNULL(@ConditionOpportunityID, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND H1.EmployeeID IN (''' + @ConditionOpportunityID + ''')'
	END

	IF(ISNULL(@ConditionTaskID,'') != '')
	BEGIN
		SET @sSQL = ' SELECT H1.EmployeeID AS AssignedToUserIDList, A1.FullName AS AssignedToUserNameList
					FROM HT1400 H1 WITH (NOLOCK)
					INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = H1.EmployeeID
					WHERE H1.EmployeeID NOT IN (SELECT EmployeeID FROM HT1380 WHERE IsFired = 1) AND H1.EmployeeID NOT IN (''ASOFTADMIN'',''UNASSIGNED'') 
					AND H1.EmployeeID NOT IN (SELECT UserID FROM AT1405 WHERE IsLock = 1 OR Disabled = 1) AND H1.EmployeeStatus <> 9' + @sWhere + '
					ORDER BY ' + @OrderBy + ''
	END

	IF(ISNULL(@ConditionLeadID,'') != '')
	BEGIN
		SET @sSQL = ' SELECT H1.EmployeeID AS LeadToUserID, A1.FullName AS LeadToUserName
					FROM HT1400 H1 WITH (NOLOCK)
					INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = H1.EmployeeID
					WHERE H1.EmployeeID NOT IN (SELECT EmployeeID FROM HT1380 WHERE IsFired = 1) AND H1.EmployeeID NOT IN (''ASOFTADMIN'',''UNASSIGNED'') 
					AND H1.EmployeeID NOT IN (SELECT UserID FROM AT1405 WHERE IsLock = 1 OR Disabled = 1) AND H1.EmployeeStatus <> 9' + @sWhere + '
					ORDER BY ' + @OrderBy + ''
	END

	IF(ISNULL(@ConditionOpportunityID,'') != '')
	BEGIN
		SET @sSQL = ' SELECT H1.EmployeeID AS OpportunityToUserID, A1.FullName AS OpportunityToUserName
					FROM HT1400 H1 WITH (NOLOCK)
					INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = H1.EmployeeID
					WHERE H1.EmployeeID NOT IN (SELECT EmployeeID FROM HT1380 WHERE IsFired = 1) AND H1.EmployeeID NOT IN (''ASOFTADMIN'',''UNASSIGNED'') 
					AND H1.EmployeeID NOT IN (SELECT UserID FROM AT1405 WHERE IsLock = 1 OR Disabled = 1) AND H1.EmployeeStatus <> 9' + @sWhere + '
					ORDER BY ' + @OrderBy + ''
	END

EXEC (@sSQL)
PRINT(@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
