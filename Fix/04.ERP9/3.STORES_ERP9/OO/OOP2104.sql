IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2104]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2104]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load màn hình chọn hợp đồng
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by:Thị Phượng Date 19/10/2017
-- <Example>
/*
	EXEC OOP2104 @DivisionID=N'KY',@TxtSearch=N'',@UserID=N'CALL002',@PageNumber=N'1',@PageSize=N'10'
*/

 CREATE PROCEDURE [dbo].[OOP2104] (
	 @DivisionID NVARCHAR(2000),
	 @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT
)
AS
DECLARE @sSQL NVARCHAR (MAX),
	 @sWhere NVARCHAR(MAX),
	 @OrderBy NVARCHAR(500),
	 @TotalRow NVARCHAR(50)

SET @sWhere = ''
SET @OrderBy = ' M.SignDate DESC, M.ContractNo'
	
IF Isnull(@TxtSearch,'') != '' SET @sWhere = @sWhere + '
						AND (M.ContractID LIKE N''%' + @TxtSearch + '%'' 
						OR M.ContractNo LIKE N''%' + @TxtSearch + '%'' 
						OR M.ContractName LIKE N''%' + @TxtSearch + '%'' 
						OR M.ObjectID LIKE N''%' + @TxtSearch + '%'' 
						OR D.ObjectName LIKE N''%' + @TxtSearch + '%'' )'

SET @sSQL = '
			SELECT M.APK, M.DivisionID
				, M.ContractID, M.ContractNo
				, M.ContractName
				, M.VoucherTypeID
				, M.ContractType
				, M.SignDate
				, M.BeginDate
				, M.EndDate, M.Amount
				, M.ObjectID, D.ObjectName
				, M.CreateUserID, M.CreateDate
				, M.LastModifyUserID, M.LastModifyDate
		INTO #TemAT1020
		FROM AT1020 M With (NOLOCK)
			LEFT JOIN AT1202 D With (NOLOCK) ON M.ObjectID = D.ObjectID
		WHERE M.DivisionID = ''' + @DivisionID + ''' ' + @sWhere + '
			
		DECLARE @count INT
		SELECT @count = COUNT(ContractNo) FROM #TemAT1020 
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow
				, M.APK, M.DivisionID
				, M.ContractID, M.ContractNo
				, M.ContractName
				, M.VoucherTypeID
				, M.ContractType
				, M.SignDate
				, M.BeginDate
				, M.EndDate, M.Amount
				, M.ObjectID, M.ObjectName
				, M.CreateUserID, M.CreateDate
				, M.LastModifyUserID, M.LastModifyDate
			FROM #TemAT1020 M
			ORDER BY ' + @OrderBy + '
			OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
			FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2105]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2105]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
-- Load TreeList cho màn hình OOF2101 - Cập nhật dự án/nhóm công việc
-- <Param>
-- <Return>
-- <Reference>
-- <History>
----Created by: Khâu Vĩnh Tâm ON 10/05/2019
-- <Example>
/*
	EXEC OOP2105 'KY', '0', 'DA-BIG-ERP-2019', '1A603EA2-7502-43E0-8E14-C74752719198'
*/

CREATE PROCEDURE [dbo].[OOP2105]
(
	@DivisionID VARCHAR(50),
	@IsFirstRun TINYINT,
	@ProjectSampleID VARCHAR(50),
	@APKMaster VARCHAR(50)
)
AS
BEGIN
	DECLARE @sSQL NVARCHAR (MAX)
	
	-- Load dữ liệu Mẫu dự án ở màn hình tạo
	IF ISNULL(@IsFirstRun, 1) = 0 AND ISNULL(@ProjectSampleID, '') != ''
	BEGIN
		SET @sSQL = N' SELECT CONVERT(VARCHAR(40), O1.APK) AS APK, CONVERT(VARCHAR(40), O1.APKMaster) AS APKMaster
							, IIF(CONVERT(VARCHAR(40), O1.NodeParent) = ''00000000-0000-0000-0000-000000000000'', '''', CONVERT(VARCHAR(40), O1.NodeParent)) AS NodeParent
							, O1.NodeLevel, O1.NodeOrder
							, COALESCE(O1.ProcessID, O1.StepID, O1.TaskSampleID) AS ObjectID
							, COALESCE(O1.ProcessName, O1.StepName, O1.TaskSampleName) AS ObjectName
							, COALESCE(O1.DescriptionP, O1.DescriptionS, O1.DescriptionT) AS Description
							, O2.ObjectTypeID, O5.Description AS ObjectTypeName
							, O1.TaskTypeID, O3.Description AS TaskTypeName, O1.TargetTypeID, O4.Description AS TargetTypeName
							, O1.PriorityID, C1.Description AS PriorityName, O1.ExecutionTime
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
							LEFT JOIN OOT0099 O3 WITH (NOLOCK) ON O3.CodeMaster = ''OOF1060.TaskType'' AND O1.TaskTypeID = O3.ID AND ISNULL(O3.Disabled, 0) = 0
							LEFT JOIN OOT0099 O4 WITH (NOLOCK) ON O4.CodeMaster = ''OOF2110.TargetType'' AND O1.TargetTypeID = O4.ID AND ISNULL(O4.Disabled, 0) = 0
							LEFT JOIN OOT0099 O5 WITH (NOLOCK) ON O5.CodeMaster = ''OOF2101.ObjectType'' AND O2.ObjectTypeID = O5.ID AND ISNULL(O5.Disabled, 0) = 0
							LEFT JOIN CRMT0099 C1 WITH (NOLOCK) ON C1.CodeMaster = ''CRMT00000006'' AND O1.PriorityID = C1.ID AND ISNULL(C1.Disabled, 0) = 0
						WHERE O.ProjectSampleID = ''' + @ProjectSampleID + '''
						ORDER BY O1.NodeLevel, O1.NodeOrder'
		EXEC (@sSQL)
	END

	-- Load dữ liệu khi update
	ELSE IF ISNULL(@APKMaster, '') != ''
	BEGIN
		SET @sSQL = N'SELECT --ROW_NUMBER() OVER (ORDER BY A.ProcessID, A.Orders) AS RowNum, COUNT(*) OVER () AS TotalRow,
						  CONVERT(VARCHAR(40), O1.APK) AS APK, CONVERT(VARCHAR(40), O1.APKMaster) AS APKMaster
						, IIF(CONVERT(VARCHAR(40), O1.NodeParent) = ''00000000-0000-0000-0000-000000000000'', '''', CONVERT(VARCHAR(40), O1.NodeParent)) AS NodeParent
						, O1.NodeLevel, O1.NodeOrder, O1.ObjectID, O1.ObjectName, O1.Description
						, O1.ObjectTypeID, O2.Description AS ObjectTypeName
						, O1.TaskTypeID, O3.Description AS TaskTypeName, O1.TargetTypeID, O4.Description AS TargetTypeName
						, O1.PriorityID, C1.Description AS PriorityName
						, O1.AssignedToUserID, A1.FullName AS AssignedToUserName
						, O1.SupportUserID, A2.FullName AS SupportUserName
						, O1.ReviewerUserID, A3.FullName AS ReviewerUserName
						--, O1.CreateUserID, O1.CreateDate, O1.LastModifyUserID, O1.LastModifyDate
						, 1 AS IsUpdate
					FROM OOT2100 O WITH (NOLOCK)
						LEFT JOIN OOT2102 O1 WITH (NOLOCK) ON O.APK = O1.APKMaster
						LEFT JOIN OOT0099 O2 WITH (NOLOCK) ON O2.CodeMaster = ''OOF2101.ObjectType'' AND O1.ObjectTypeID = O2.ID AND ISNULL(O2.Disabled, 0) = 0
						LEFT JOIN OOT0099 O3 WITH (NOLOCK) ON O3.CodeMaster = ''OOF1060.TaskType'' AND O1.TaskTypeID = O3.ID AND ISNULL(O3.Disabled, 0) = 0
						LEFT JOIN OOT0099 O4 WITH (NOLOCK) ON O4.CodeMaster = ''OOF2110.TargetType'' AND O1.TargetTypeID = O4.ID AND ISNULL(O4.Disabled, 0) = 0
						LEFT JOIN CRMT0099 C1 WITH (NOLOCK) ON C1.CodeMaster = ''CRMT00000006'' AND O1.PriorityID = C1.ID AND ISNULL(C1.Disabled, 0) = 0
						LEFT JOIN AT1103 A1 WITH (NOLOCK) ON O1.AssignedToUserID = A1.EmployeeID AND ISNULL(A1.Disabled, 0) = 0
						LEFT JOIN AT1103 A2 WITH (NOLOCK) ON O1.SupportUserID = A2.EmployeeID AND ISNULL(A1.Disabled, 0) = 0
						LEFT JOIN AT1103 A3 WITH (NOLOCK) ON O1.ReviewerUserID = A3.EmployeeID AND ISNULL(A1.Disabled, 0) = 0
					WHERE O.APK = ''' + @APKMaster + '''
					--ORDER BY O1.NodeLevel, O1.NodeOrder
					UNION ALL
					SELECT
						  CONVERT(VARCHAR(40), O.APK) AS APK, CONVERT(VARCHAR(40), O.APKMaster) AS APKMaster
						, IIF(CONVERT(VARCHAR(40), O.NodeParent) = ''00000000-0000-0000-0000-000000000000'', '''', CONVERT(VARCHAR(40), O.NodeParent)) AS NodeParent
						, NULL AS NodeLevel, NULL AS NodeOrder, O.TaskID, O.TaskName, O.Description
						, ''0'' AS ObjectTypeID, O2.Description AS ObjectTypeName
						, O.TaskTypeID, O3.Description AS TaskTypeName, O.TargetTypeID, O4.Description AS TargetTypeName
						, O.PriorityID, C1.Description AS PriorityName
						, O.AssignedToUserID, A1.FullName AS AssignedToUserName
						, O.SupportUserID, A2.FullName AS SupportUserName
						, O.ReviewerUserID, A3.FullName AS ReviewerUserName
						, 1 AS IsUpdate
					FROM OOT2110 O WITH (NOLOCK)
						LEFT JOIN OOT0099 O2 WITH (NOLOCK) ON O2.CodeMaster = ''OOF2101.ObjectType'' AND ''0'' = O2.ID AND ISNULL(O2.Disabled, 0) = 0
						LEFT JOIN OOT0099 O3 WITH (NOLOCK) ON O3.CodeMaster = ''OOF1060.TaskType'' AND O.TaskTypeID = O3.ID AND ISNULL(O3.Disabled, 0) = 0
						LEFT JOIN OOT0099 O4 WITH (NOLOCK) ON O4.CodeMaster = ''OOF2110.TargetType'' AND O.TargetTypeID = O4.ID AND ISNULL(O4.Disabled, 0) = 0
						LEFT JOIN CRMT0099 C1 WITH (NOLOCK) ON C1.CodeMaster = ''CRMT00000006'' AND O.PriorityID = C1.ID AND ISNULL(C1.Disabled, 0) = 0
						LEFT JOIN AT1103 A1 WITH (NOLOCK) ON O.AssignedToUserID = A1.EmployeeID AND ISNULL(A1.Disabled, 0) = 0
						LEFT JOIN AT1103 A2 WITH (NOLOCK) ON O.SupportUserID = A2.EmployeeID AND ISNULL(A1.Disabled, 0) = 0
						LEFT JOIN AT1103 A3 WITH (NOLOCK) ON O.ReviewerUserID = A3.EmployeeID AND ISNULL(A1.Disabled, 0) = 0
					WHERE O.APKMaster = ''' + @APKMaster + '''
					--ORDER BY O.NodeLevel, O.NodeOrder'
		EXEC (@sSQL)
	END

END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
