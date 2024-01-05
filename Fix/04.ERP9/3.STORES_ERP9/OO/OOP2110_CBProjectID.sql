IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2110_CBProjectID]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2110_CBProjectID]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load dữ liệu Combobox OOF2110.ProjectID  - Load Danh sách dự án/nhóm công việc
-- <Param>
-- <Return>
-- <Reference>
-- <History>
--		Created by Khâu Vĩnh Tâm ON 17/10/2019
-- <Example>
/*
    EXEC OOP2110_CBProjectID 'VF','1','VINHTAM,BAOTOAN,TRUONGLAM'
*/

CREATE PROCEDURE [dbo].[OOP2110_CBProjectID] 
(
	@DivisionID NVARCHAR(250),
	@TaskTypeID NVARCHAR(250),	-- 1: Công việc dự án; 2: Công việc định kỳ; 3: Công việc phát sinh
	@ConditionProjectID NVARCHAR(MAX)
)
AS
BEGIN
	DECLARE @ProjectTypeID INT = -1
	PRINT(@ConditionProjectID)
	-- Trường hợp Loại công việc là Công việc dự án thì load danh sách các dự án
	IF ISNULL(@TaskTypeID, '') = '1'
	BEGIN
		SET @ProjectTypeID = 1
	END
	-- Trường hợp Loại công việc là Công việc phát sinh thì load danh sách các dự án
	ELSE IF ISNULL(@TaskTypeID, '') = '3'
	BEGIN
		SET @ProjectTypeID = 2
	END

	IF OBJECT_ID('tempdb..#PermissionProject') IS NOT NULL DROP TABLE #PermissionProject
	SELECT Value
	INTO #PermissionProject
	FROM STRINGSPLIT(ISNULL(@ConditionProjectID, ''), ''',''')

	SELECT DISTINCT M.APK AS ProjectAPK, M.ProjectID, M.ProjectName, M.StartDate AS ProjectStartDate, M.EndDate AS ProjectEndDate
	FROM OOT2100 M WITH (NOLOCK)
		LEFT JOIN OOT2101 O1 WITH (NOLOCK) ON O1.RelatedToID = M.ProjectID
		LEFT JOIN OOT2103 O2 WITH (NOLOCK) ON O2.RelatedToID = M.ProjectID
		LEFT JOIN AT1102 A1 WITH (NOLOCK) ON A1.DepartmentID = O1.DepartmentID
		INNER JOIN #PermissionProject T1 ON T1.Value IN (M.LeaderID, M.CreateUserID, O2.UserID, A1.ContactPerson)
	WHERE @ProjectTypeID = -1 OR (@ProjectTypeID != -1 AND M.ProjectType = @ProjectTypeID) AND M.DeleteFlg = 0
	ORDER BY M.ProjectID
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
