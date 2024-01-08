IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2105]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2105]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
-- Load EditTreeList cho màn hình OOF2101 - Cập nhật dự án/nhóm công việc
-- Load TreeList cho màn hình OOF2102 - Xem chi tiết dự án/nhóm công việc
-- <Param>
-- <Return>
-- <Reference>
-- <History>
----Created by: Khâu Vĩnh Tâm ON 10/05/2019
----Edited by: Khâu Vĩnh Tâm ON 05/04/2020: Bổ sung load Trạng thái công việc, kiểm tra quyền Xem công việc Dự án
----Edited by: Đình Hòa ON 19/02/2021 : Thay đổi thứ tự lấy dữ liệu của ObjectID, ObjectName (line 47,48)
----Edited by: Văn Tài  ON 20/07/2021 : Tách store cho DTI, quyền xem chi tiết công việc cho nhân sự KDTT.
-- <Example>
/*
	EXEC OOP2105 'DTI', '1', 'DA-BIG-ERP-2019', '42255288-7b4d-46ba-bba3-ed95c2d43913', 'VINHTAM'
*/

CREATE PROCEDURE [dbo].[OOP2105]
(
	@DivisionID VARCHAR(50),
	@IsFirstRun TINYINT,
	@ProjectSampleID VARCHAR(50),
	@APKMaster VARCHAR(50),
	@UserID VARCHAR(50),
	@ConditionTaskID VARCHAR(MAX)
)
AS
BEGIN
	DECLARE @sSQL NVARCHAR(MAX),
			@sSQL2 NVARCHAR(MAX),
			@CustomerIndex INT = -1

	SET @CustomerIndex = (SELECT TOP 1 CustomerIndex.CustomerName FROM CustomerIndex WITH (NOLOCK))

	IF (@CustomerIndex = 114) -- Đức Tín
	BEGIN
		EXEC OOP2105_DTI @DivisionID  = @DivisionID
						 , @IsFirstRun = @IsFirstRun
						 , @ProjectSampleID = @ProjectSampleID
						 , @APKMaster = @APKMaster
						 , @UserID = @UserID
						 , @ConditionTaskID = @ConditionTaskID
	END
	ELSE
	BEGIN
	
	-- Load dữ liệu Mẫu dự án ở màn hình Cập nhật công việc (Tạo mới)
	IF ISNULL(@IsFirstRun, 1) = 0 AND ISNULL(@ProjectSampleID, '') != ''
	BEGIN
		SET @sSQL = N' SELECT CONVERT(VARCHAR(40), O1.APK) AS APK, CONVERT(VARCHAR(40), O1.APKMaster) AS APKMaster
							, IIF(CONVERT(VARCHAR(40), O1.NodeParent) = ''00000000-0000-0000-0000-000000000000'', '''', CONVERT(VARCHAR(40), O1.NodeParent)) AS NodeParent
							, O1.NodeLevel, O1.NodeOrder
							, COALESCE(O1.TaskSampleID, O1.ProcessID, O1.StepID) AS ObjectID
							, COALESCE(O1.TaskSampleName, O1.ProcessName, O1.StepName) AS ObjectName
							--, COALESCE(O1.DescriptionP, O1.DescriptionS, O1.DescriptionT) AS Description
							, O2.ObjectTypeID, O5.Description AS ObjectTypeName
							, O1.TaskTypeID, O3.Description AS TaskTypeName
							, O1.TargetTypeID, O4.TargetsName AS TargetTypeName
							, O1.PriorityID, C1.Description AS PriorityName, O1.ExecutionTime AS PlanTime
							--, O1.CreateUserID, O1.CreateDate, O1.LastModifyUserID, O1.LastModifyDate
							, 0 AS IsUpdate
						FROM OOT1050 O WITH (NOLOCK)
							LEFT JOIN OOT1051 O1 WITH (NOLOCK) ON O.APK = O1.APKMaster
							LEFT JOIN 
								(SELECT S1.APK, S1.APKMaster
									, CASE
										WHEN S1.TaskSampleID IS NOT NULL THEN ''0''
										WHEN S1.StepID IS NOT NULL THEN ''1''
										WHEN S1.ProcessID IS NOT NULL THEN ''2''
										END AS ObjectTypeID
								FROM OOT1050 S WITH (NOLOCK) LEFT JOIN OOT1051 S1 WITH (NOLOCK) ON S.APK = S1.APKMaster
								WHERE ProjectSampleID = ''' + @ProjectSampleID + '''
								) O2 ON O1.APK = O2.APK
							LEFT JOIN OOT0099 O3 WITH (NOLOCK) ON O3.CodeMaster = ''OOF1060.TaskType'' AND O1.TaskTypeID = O3.ID
							LEFT JOIN KPIT10501 O4 WITH (NOLOCK) ON O1.TargetTypeID = O4.TargetsID
							LEFT JOIN OOT0099 O5 WITH (NOLOCK) ON O5.CodeMaster = ''OOF2101.ObjectType'' AND O2.ObjectTypeID = O5.ID
							LEFT JOIN CRMT0099 C1 WITH (NOLOCK) ON C1.CodeMaster = ''CRMT00000006'' AND O1.PriorityID = C1.ID
						WHERE O.ProjectSampleID = ''' + @ProjectSampleID + ''' AND ISNULL(O.Disabled, 0) = 0
						ORDER BY O1.NodeLevel, O1.NodeOrder'
		EXEC (@sSQL)
	END

	-- Load dữ liệu khi update
	ELSE IF ISNULL(@APKMaster, '') != ''
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

		-- Mode = 1: Lấy tên Nhóm chỉ tiêu từ bảng Thiết lập đánh giá công việc
		EXEC OOP21301 @DivisionID = @DivisionID, @APK = NULL, @TableName = @TableName, @UserID = @UserID, @Mode = 1, @ListGroup = @ListGroup OUTPUT
			, @ListFieldId = @ListFieldId OUTPUT, @ListFieldName = @ListFieldName OUTPUT, @ListColumn = @ListColumn OUTPUT, @JoinString = @JoinString OUTPUT

		IF ISNULL(@ListFieldId, '') != '' AND ISNULL(@ListFieldName, '') != ''
		BEGIN
			SET @ListField = CONCAT(', ', @ListFieldId, ', ', @ListFieldName)
			SET @JoinAssess = '
					LEFT JOIN (
							SELECT T2.APK, ' + @ListGroup + '
							FROM
							(
								SELECT O2.APK, REPLACE(O3.TargetsGroupID, ''.'', '''') AS TargetsGroupID, O3.AssessUserID
								FROM OOT2100 O1 WITH (NOLOCK)
									INNER JOIN OOT2110 O2 WITH (NOLOCK) ON O1.APK = O2.APKMaster AND ISNULL(O2.DeleteFlg, 0) = 0 
									INNER JOIN OOT2130 O3 WITH (NOLOCK) ON O2.APK = O3.APKMaster
								WHERE O1.APK = ''' + @APKMaster + '''
							) AS T1
							PIVOT (
								MAX(T1.AssessUserID)
								FOR T1.TargetsGroupID IN (' + @ListGroup + ')
							) AS T2
					) AS ' + @TableName + ' ON O.APK = ' + @TableName + '.APK
					' + @JoinString

			SET @ListColumn = ',' + @ListColumn
			SET @ListColumn = REPLACE(@ListColumn, ',', ', NULL AS ')
		END

		-- 05/04/2020 - [Vĩnh Tâm] - Begin add
		-- Trường hợp đã tồn tại bảng tạm thì xóa bảng
		IF OBJECT_ID('tempdb..#PermissionOOT2110') IS NOT NULL DROP TABLE #PermissionOOT2110

		-- Chuyển phân quyền xem Công việc thành bảng tạm
		SELECT Value
		INTO #PermissionOOT2110
		FROM STRINGSPLIT(ISNULL(@ConditionTaskID, ''), ',')

		SELECT DISTINCT O1.APK
		INTO #FilterTaskAPK
		FROM OOT2110 O1 WITH (NOLOCK)
			INNER JOIN #PermissionOOT2110 T1 ON T1.Value IN (O1.AssignedToUserID, O1.SupportUserID, O1.ReviewerUserID, O1.CreateUserID)
		WHERE O1.APKMaster = @APKMaster
		-- 05/04/2020 - [Vĩnh Tâm] - End add

		-- Lấy dữ liệu Quy trình, Bước quy trình
		SET @sSQL = N'
					SELECT *
					FROM
					(
					SELECT --ROW_NUMBER() OVER (ORDER BY A.ProcessID, A.Orders) AS RowNum, COUNT(*) OVER () AS TotalRow,
						  CONVERT(VARCHAR(40), O1.APK) AS APK, CONVERT(VARCHAR(40), O1.APKMaster) AS APKMaster, O.DivisionID
						, IIF(CONVERT(VARCHAR(40), O1.NodeParent) = ''00000000-0000-0000-0000-000000000000'', '''', CONVERT(VARCHAR(40), O1.NodeParent)) AS NodeParent
						, O1.NodeLevel, O1.NodeOrder, O1.ObjectID, O1.ObjectName
						--, O1.Description
						, O1.ObjectTypeID, O2.Description AS ObjectTypeName
						, O1.TaskTypeID, O3.Description AS TaskTypeName
					    , O1.TargetTypeID, O4.TargetsName AS TargetTypeName
						, O1.PriorityID, C1.Description AS PriorityName
						, O1.AssignedToUserID, A1.FullName AS AssignedToUserName
						, O1.SupportUserID, A2.FullName AS SupportUserName
						, O1.ReviewerUserID, A3.FullName AS ReviewerUserName
						, NULL AS PlanTime, NULL AS PlanStartDate, NULL AS PlanEndDate
						, NULL AS ActualEndDate, NULL AS ActualStartDate, NULL AS ActualTime
						, NULL AS StatusID, NULL AS StatusName, NULL AS Orders, NULL AS PercentProgress
						, NULL AS ParentTaskID, NULL AS PreviousTaskID
						, NULL AS IsRepeat, NULL AS APKSettingTime, NULL AS RelatedToTypeID
						, NULL AS IsViolated, NULL AS IsAssessor, NULL AS APKRel, NULL AS TypeRel, O1.DeleteFlg
						, O1.CreateDate, O1.CreateUserID, O1.LastModifyDate, O1.LastModifyUserID
						, 1 AS IsUpdate
						, CAST(0 AS TINYINT) AS ViewTask
						' + @ListColumn + '
					FROM OOT2100 O WITH (NOLOCK)
						INNER JOIN OOT2102 O1 WITH (NOLOCK) ON O.APK = O1.APKMaster
						LEFT JOIN OOT0099 O2 WITH (NOLOCK) ON O2.CodeMaster = ''OOF2101.ObjectType'' AND O1.ObjectTypeID = O2.ID
						LEFT JOIN OOT0099 O3 WITH (NOLOCK) ON O3.CodeMaster = ''OOF1060.TaskType'' AND O1.TaskTypeID = O3.ID
					    LEFT JOIN KPIT10501 O4 WITH (NOLOCK) ON O1.TargetTypeID = O4.TargetsID
						LEFT JOIN CRMT0099 C1 WITH (NOLOCK) ON C1.CodeMaster = ''CRMT00000006'' AND O1.PriorityID = C1.ID
						LEFT JOIN AT1103 A1 WITH (NOLOCK) ON O1.AssignedToUserID = A1.EmployeeID
						LEFT JOIN AT1103 A2 WITH (NOLOCK) ON O1.SupportUserID = A2.EmployeeID
						LEFT JOIN AT1103 A3 WITH (NOLOCK) ON O1.ReviewerUserID = A3.EmployeeID
					WHERE O.APK = ''' + @APKMaster + ''' AND ISNULL(O.DeleteFlg, 0) = 0 AND ISNULL(O1.DeleteFlg, 0) = 0
					--ORDER BY O1.NodeLevel, O1.NodeOrder
					UNION ALL '
		-- Lấy dữ liệu Công việc
		SET @sSQL2 = N'SELECT
						  CONVERT(VARCHAR(40), O.APK) AS APK, CONVERT(VARCHAR(40), O.APKMaster) AS APKMaster, O.DivisionID
						, IIF(CONVERT(VARCHAR(40), O.NodeParent) = ''00000000-0000-0000-0000-000000000000'', '''', CONVERT(VARCHAR(40), O.NodeParent)) AS NodeParent
						, O.NodeLevel, O.NodeOrder, O.TaskID, O.TaskName
						--, O.Description
						, ''0'' AS ObjectTypeID, O2.Description AS ObjectTypeName
						, O.TaskTypeID, O3.Description AS TaskTypeName
						, O.TargetTypeID, O4.TargetsName AS TargetTypeName
						, O.PriorityID, C1.Description AS PriorityName
						, O.AssignedToUserID, A1.FullName AS AssignedToUserName
						, O.SupportUserID, A2.FullName AS SupportUserName
						, O.ReviewerUserID, A3.FullName AS ReviewerUserName
						, O.PlanTime, O.PlanStartDate, O.PlanEndDate
						, O.ActualEndDate, O.ActualStartDate, O.ActualTime
						, O.StatusID, O5.StatusName, O.Orders, O.PercentProgress
						, O.ParentTaskID, O.PreviousTaskID
						, O.IsRepeat, O.APKSettingTime, O.RelatedToTypeID
						, O.IsViolated, O.IsAssessor, CONVERT(VARCHAR(40), O.APKRel) AS APKRel, O.TypeRel, O.DeleteFlg
						, O.CreateDate, O.CreateUserID, O.LastModifyDate, O.LastModifyUserID
						, 1 AS IsUpdate
						, CAST(IIF(ISNULL(CAST(T1.APK AS VARCHAR(50)), '''') != '''', 1, 0) AS TINYINT) AS ViewTask
						' + @ListField + '
					FROM OOT2110 O WITH (NOLOCK)
						INNER JOIN OOT2100 O1 WITH (NOLOCK) ON O.APKMaster = O1.APK
						LEFT JOIN OOT0099 O2 WITH (NOLOCK) ON O2.CodeMaster = ''OOF2101.ObjectType'' AND ''0'' = O2.ID
						LEFT JOIN OOT0099 O3 WITH (NOLOCK) ON O3.CodeMaster = ''OOF1060.TaskType'' AND O.TaskTypeID = O3.ID
					    LEFT JOIN KPIT10501 O4 WITH (NOLOCK) ON O.TargetTypeID = O4.TargetsID
						LEFT JOIN OOT1040 O5 WITH (NOLOCK) ON O.StatusID = O5.StatusID AND O5.DivisionID IN (O.DivisionID, ''@@@'')
						LEFT JOIN CRMT0099 C1 WITH (NOLOCK) ON C1.CodeMaster = ''CRMT00000006'' AND O.PriorityID = C1.ID
						LEFT JOIN AT1103 A1 WITH (NOLOCK) ON O.AssignedToUserID = A1.EmployeeID
						LEFT JOIN AT1103 A2 WITH (NOLOCK) ON O.SupportUserID = A2.EmployeeID
						LEFT JOIN AT1103 A3 WITH (NOLOCK) ON O.ReviewerUserID = A3.EmployeeID
						LEFT JOIN #FilterTaskAPK T1 ON T1.APK = O.APK
						' + @JoinAssess + '
					WHERE O.APKMaster = ''' + @APKMaster + ''' AND ISNULL(O.DeleteFlg, 0) = 0 AND ISNULL(O1.DeleteFlg, 0) = 0
					) AS TEMP
					ORDER BY TEMP.NodeLevel, TEMP.NodeParent, TEMP.NodeOrder'
		EXEC (@sSQL + @sSQL2)
	END

	END

END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
