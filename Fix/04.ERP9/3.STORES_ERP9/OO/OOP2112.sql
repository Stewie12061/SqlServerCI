IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2112]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2112]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
--- Load form OOF2111 - Cập nhật công việc
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by Vĩnh Tâm on 09/09/2019
-- Updated by Văn Tài  on 21/06/2022 - Xử lý DivisionID @@@ khi join bảng người dùng.
-- <Example>
/*
	EXEC OOP2112 'DTI', 'f5d0be79-c485-45c1-996b-33dfde7f2848', NULL, 'VINHTAM', 0
*/

CREATE PROCEDURE [dbo].[OOP2112]
(
	@DivisionID NVARCHAR(250),
	@APK NVARCHAR(250),
	@APK2130 NVARCHAR(250),
	@UserID NVARCHAR(250),
	@Mode INT = 0		-- 0: Cập nhật công việc; 1: Đánh giá công việc
)
AS
BEGIN
	DECLARE @sSQL NVARCHAR (MAX),
			@sWhere2130 NVARCHAR (MAX) = ''

	-- Màn hình Cập nhật công việc
	IF @Mode = 0
	BEGIN
		DECLARE @ListGroup NVARCHAR(MAX) = '',
				@ListFieldId NVARCHAR(MAX) = '',
				@ListFieldName NVARCHAR(MAX) = '',
				@ListColumn NVARCHAR(MAX) = '',
				@JoinString NVARCHAR(MAX) = '',
				@TableName NVARCHAR(20) = '',

				@ListField NVARCHAR(MAX) = '',
				@JoinAssess NVARCHAR(MAX) = ''
		
		-- Tên Alias của bảng lấy dữ liệu Người đánh giá
		SET @TableName = 'O10'

		-- Mode = 0: Lấy tên Nhóm chỉ tiêu từ bảng Đánh giá công việc
		EXEC OOP21301 @DivisionID = @DivisionID, @APK = @APK, @TableName = @TableName, @UserID = @UserID, @ObjectID = 'CV', @Mode = 0, @ListGroup = @ListGroup OUTPUT
			, @ListFieldId = @ListFieldId OUTPUT, @ListFieldName = @ListFieldName OUTPUT, @ListColumn = @ListColumn OUTPUT, @JoinString = @JoinString OUTPUT

		IF ISNULL(@ListFieldId, '') != '' AND ISNULL(@ListFieldName, '') != ''
		BEGIN
			SET @ListField = CONCAT(', ', @ListFieldId, ', ', @ListFieldName)
			SET @JoinAssess = '
					LEFT JOIN (
						SELECT T2.APKMaster, T2.TaskID, ' + @ListGroup + '
						FROM (
							SELECT APKMaster, TaskID, REPLACE(TargetsGroupID, ''.'', '''') AS TargetsGroupID, AssessUserID
							FROM OOT2130 WITH (NOLOCK)
							WHERE APKMaster = ''' + @APK + '''
						) AS T1
						PIVOT (
							MAX(AssessUserID)
							FOR TargetsGroupID IN (' + @ListGroup + ')
						) AS T2
					) AS ' + @TableName + ' ON M.APK = ' + @TableName + '.APKMaster
					' + @JoinString
		END

		SET @sSQL = N'
			SELECT M.APK, M.APKMaster, M.NodeParent, M.DivisionID, M.TaskID, M.TaskName
					, M.ProjectID
					, M.ProcessID
					, M.StepID
					, M.ParentTaskID
					, M.PreviousTaskID
					, M.AssignedToUserID
					, M.IsViolated
					, M.SupportUserID
					, M.TaskTypeID
					, O9.ProjectName AS ProjectName
					, IIF (ISNULL(M.ProjectID, '''') != '''', O2.ObjectName, O4.ProcessName) AS ProcessName
					, IIF (ISNULL(M.ProjectID, '''') != '''' AND ISNULL(M.ProcessID, '''') != '''', O3.ObjectName, O5.StepName) AS StepName
					, M.APKSettingTime
					, M.TargetTypeID
					, M.RelatedToTypeID
					, M.IsRepeat
					, O6.TaskName AS ParentTaskName
					, O7.TaskName AS PreviousTaskName
					, M.ReviewerUserID
					, A1.FullName AS AssignedToUserName
					, A2.FullName AS SupportUserName
					, A3.FullName AS ReviewerUserName
					, M.PlanStartDate, M.PlanEndDate, M.PlanTime
					, M.ActualStartDate, M.ActualEndDate , M.ActualTime
					, M.PriorityID, A4.Description AS PriorityName
					, M.PercentProgress
					, ISNULL(M.StatusID, 0) AS StatusID, O8.StatusName
					, M.Description
					, O8.Orders
					, M.CreateUserID, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
					, O12.VoucherTask AS VoucherTypeID
					, M.TypeRel, M.APKRel
					, ISNULL(M.StatusID, 0) AS LastStatusID, M.PriorityID AS LastPriorityID
					, M.SupportUserID AS LastSupportUserID
					, M.ReviewerUserID AS LastReviewerUserID
					, M.AssignedToUserID AS LastAssignedToUserID
					, M.TaskSampleID
					, O11.TaskSampleName
					, IIF (EXISTS(SELECT TOP 1 1 FROM AT1102 AT1 WITH (NOLOCK) WHERE AT1.ContactPerson = M.AssignedToUserID), 1, 0) AS IsContactPerson
					' + @ListField + '
					,O13.VoucherNo as SaleOrderID
			FROM OOT2110 M WITH (NOLOCK)
					LEFT JOIN OOT2100 O1 WITH (NOLOCK) ON M.APKMaster = O1.APK
					LEFT JOIN OOT2102 O2 WITH (NOLOCK) ON M.ProcessID = O2.ObjectID AND ISNULL(O2.DeleteFlg, 0) = 0
					LEFT JOIN OOT2102 O3 WITH (NOLOCK) ON M.StepID = O3.ObjectID AND ISNULL(O3.DeleteFlg, 0) = 0
					LEFT JOIN OOT1020 O4 WITH (NOLOCK) ON M.ProcessID = O4.ProcessID
					LEFT JOIN OOT1021 O5 WITH (NOLOCK) ON M.StepID = O5.StepID
					LEFT JOIN OOT2110 O6 WITH (NOLOCK) ON M.ParentTaskID = O6.TaskID
					LEFT JOIN OOT2110 O7 WITH (NOLOCK) ON M.PreviousTaskID = O7.TaskID
					LEFT JOIN OOT1040 O8 WITH (NOLOCK) ON M.StatusID = O8.StatusID AND O8.DivisionID = M.DivisionID
					LEFT JOIN OOT2100 O9 WITH (NOLOCK) ON M.ProjectID = O9.ProjectID AND ISNULL(O9.DeleteFlg, 0) = 0
					LEFT JOIN AT1103 A1 WITH (NOLOCK) ON M.AssignedToUserID = A1.EmployeeID AND A1.DivisionID IN (M.DivisionID, ''@@@'')
					LEFT JOIN AT1103 A2 WITH (NOLOCK) ON M.SupportUserID = A2.EmployeeID AND A2.DivisionID IN (M.DivisionID, ''@@@'')
					LEFT JOIN AT1103 A3 WITH (NOLOCK) ON M.ReviewerUserID = A3.EmployeeID AND A3.DivisionID IN (M.DivisionID, ''@@@'')
					LEFT JOIN CRMT0099 A4 WITH (NOLOCK) ON M.PriorityID = A4.ID AND A4.CodeMaster = N''CRMT00000006''
					LEFT JOIN OOT2110 N WITH (NOLOCK) ON M.ParentTaskID = N.TaskID
					LEFT JOIN OOT2110 L WITH (NOLOCK) ON M.PreviousTaskID = L.TaskID
					LEFT JOIN AT1103 A5 WITH (NOLOCK) ON A5.EmployeeID = M.AssignedToUserID
					' + @JoinAssess + '
					LEFT JOIN OOT0060 O12 WITH (NOLOCK) ON M.DivisionID = O12.DivisionID
					LEFT JOIN OOT1060 O11 WITH (NOLOCK) ON M.TaskSampleID = O11.TaskSampleID
					LEFT JOIN OT2001 O13 WITH (NOLOCK) ON M.APKSaleOrderID = O13.APK
			WHERE M.APK = ''' + @APK + ''' AND M.DivisionID = N''' + @DivisionID + ''' AND ISNULL(M.DeleteFlg, 0) = 0'
	END

	-- Đánh giá công việc
	IF @Mode = 1
	BEGIN
		IF ISNULL(@APK2130, '') != ''
			SET @sWhere2130 =  'AND O10.APK = ''' + ISNULL(@APK2130, '00000000-0000-0000-0000-000000000000') + ''''
		
		SET @sSQL = N'
			SELECT M.APK, M.APKMaster, M.NodeParent, M.DivisionID, M.TaskID, M.TaskName
					, M.ProjectID
					, M.ProcessID
					, M.StepID
					, M.ParentTaskID
					, M.PreviousTaskID
					, M.AssignedToUserID
					, M.IsViolated
					, M.SupportUserID
					, M.TaskTypeID
					, O9.ProjectName AS ProjectName
					, IIF (ISNULL(M.ProjectID, '''') != '''', O2.ObjectName, O4.ProcessName) AS ProcessName
					, IIF (ISNULL(M.ProjectID, '''') != '''' AND ISNULL(M.ProcessID, '''') != '''', O3.ObjectName, O5.StepName) AS StepName
					, M.APKSettingTime
					, M.TargetTypeID
					, M.RelatedToTypeID
					, M.IsRepeat
					, O6.TaskName AS ParentTaskName
					, O7.TaskName AS PreviousTaskName
					, M.ReviewerUserID
					, A1.FullName AS AssignedToUserName
					, A2.FullName AS SupportUserName
					, A3.FullName AS ReviewerUserName
					, M.PlanStartDate, M.PlanEndDate, M.PlanTime
					, M.ActualStartDate, M.ActualEndDate , M.ActualTime
					, M.PriorityID, A4.Description AS PriorityName
					, M.PercentProgress
					, ISNULL(M.StatusID, 0) AS StatusID, O8.StatusName
					, M.Description
					, O8.Orders
					, M.CreateUserID, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
					, O10.Mark AS Mark
					, O10.Note AS Note
					, O10.StatusID AS StatusAssessor
					, O12.VoucherTask AS VoucherTypeID
					, M.TypeRel, M.APKRel
					,O13.VoucherNo as SaleOrderID
			FROM OOT2110 M WITH (NOLOCK)
					LEFT JOIN OOT2100 O1 WITH (NOLOCK) ON M.APKMaster = O1.APK
					LEFT JOIN OOT2102 O2 WITH (NOLOCK) ON M.ProcessID = O2.ObjectID
					LEFT JOIN OOT2102 O3 WITH (NOLOCK) ON M.StepID = O3.ObjectID
					LEFT JOIN OOT1020 O4 WITH (NOLOCK) ON M.ProcessID = O4.ProcessID
					LEFT JOIN OOT1021 O5 WITH (NOLOCK) ON M.StepID = O5.StepID
					LEFT JOIN OOT2110 O6 WITH (NOLOCK) ON M.ParentTaskID = O6.TaskID
					LEFT JOIN OOT2110 O7 WITH (NOLOCK) ON M.PreviousTaskID = O7.TaskID
					LEFT JOIN OOT1040 O8 WITH (NOLOCK) ON M.StatusID = O8.StatusID
					LEFT JOIN OOT2100 O9 WITH (NOLOCK) ON M.ProjectID = O9.ProjectID
					LEFT JOIN AT1103 A1 WITH (NOLOCK) ON M.AssignedToUserID = A1.EmployeeID
					LEFT JOIN AT1103 A2 WITH (NOLOCK) ON M.SupportUserID = A2.EmployeeID
					LEFT JOIN AT1103 A3 WITH (NOLOCK) ON M.ReviewerUserID = A3.EmployeeID
					LEFT JOIN CRMT0099 A4 WITH (NOLOCK) ON M.PriorityID = A4.ID AND A4.CodeMaster = N''CRMT00000006''
					LEFT JOIN OOT2110 N WITH (NOLOCK) ON M.ParentTaskID = N.TaskID
					LEFT JOIN OOT2110 L WITH (NOLOCK) ON M.PreviousTaskID = L.TaskID
					LEFT JOIN OOT2130 O10 WITH (NOLOCK) ON M.APK = O10.APKMaster ' + @sWhere2130 + '
					LEFT JOIN OOT0060 O12 WITH (NOLOCK) ON M.DivisionID = O12.DivisionID
					LEFT JOIN OT2001 O13 WITH (NOLOCK) ON M.APKSaleOrderID = O13.APK
			WHERE M.APK = ''' + @APK + ''' AND M.DivisionID = N''' + @DivisionID + ''' AND ISNULL(M.DeleteFlg, 0) = 0'
	END
	EXEC (@sSQL)
	--PRINT (@sSQL)
END






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
