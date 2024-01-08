IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP3029_ASOFT]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP3029_ASOFT]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
---- Báo cáo công việc theo nhân viên
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Tấn Lộc, Date: 08/06/2020
-- <Example>
----
/*-- <Example>
	OOP3029 @DivisionID = 'KY', @PlanStartDate = '2019-05-14', @PlanEndDate = '2019-05-14', @AssignedToUserID = 'DANH', @StatusID = ''
 */

CREATE PROCEDURE [dbo].[OOP3029_ASOFT]
(
	@DivisionID VARCHAR(250),
	@PlanStartDate NVARCHAR(3000),
	@PlanEndDate NVARCHAR(3000),
	@AssignedToUserID NVARCHAR(MAX),
	@StatusID NVARCHAR(500),
	@StatusIS NVARCHAR(500),
	@StatusHD NVARCHAR(500),
	@StatusMT NVARCHAR(500)
)
AS
BEGIN
	DECLARE @sSQL NVARCHAR(MAX),
			@sWhere NVARCHAR(MAX),
			@PlanStartDateText NVARCHAR(20),
			@PlanEndDateText NVARCHAR(20),
			@Language NVARCHAR(250)

    SET @PlanStartDateText = CONVERT(NVARCHAR(20), @PlanStartDate, 111)
    SET @PlanEndDateText = CONVERT(NVARCHAR(10), @PlanEndDate, 111) + ' 23:59:59'

	-- Tạo bảng tổng chứa dữ liệu của những bảng con @TableTask, @TableIssues, @TableHelpDesk. @TableMilestone, @TableRelease
	DECLARE @TableData AS TABLE (
			STT NVARCHAR(MAX),
	        TypeData INT,
			Description NVARCHAR(MAX),
			AssignedToUserID VARCHAR(50),
			AssignedToUserName NVARCHAR(MAX),
			ProjectID NVARCHAR(MAX),
			ValueID VARCHAR(50),
			ValueName NVARCHAR(MAX),
			PlanStartDate Datetime,
			PlanEndDate Datetime,
			ActualStartDate DATETIME,
			ActualEndDate DATETIME,
			PlanTime DECIMAL(28,8),
			ActualTime DECIMAL(28,8),
			PercentProgress DECIMAL(28,8),
			StatusName NVARCHAR(250),
			TypeOf NVARCHAR(250),
			SumPlanTime DECIMAL(28,8),
			SumActualTime DECIMAL(28,8)
	)

	-- Insert dữ liệu Milestone vào bảng tạm @TableMilestone
	INSERT INTO @TableData (STT, TypeData, Description, AssignedToUserID, AssignedToUserName, ProjectID, ValueID, ValueName
	                                ,PlanStartDate, PlanEndDate, ActualStartDate, ActualEndDate, PlanTime, ActualTime, PercentProgress, StatusName, TypeOf, SumPlanTime, SumActualTime)
	SELECT NULL AS STT
	       , 2 AS TypeData
		   , N'Milestone' AS Description
		   , A4.AssignedToUserID
		   , CONCAT(N'Họ và tên: ',O2.FullName)  AS AssignedToUserName
		   ,  CASE
				WHEN ISNULL(O1.ProjectName, '') != '' AND ISNULL(A4.ProjectID, '') != ''
					THEN CONCAT(O1.ProjectID, ' - ', O1.ProjectName)
				ELSE A4.ProjectID
				END 
			, A4.MilestoneID
			, A4.MilestoneName
			, A4.TimeRequest
			, A4.DeadlineRequest
			, A4.ActualStartDate
			, A4.ActualEndDate
			, NULL AS PlanTime
			, A4.ActualTime
			, A4.PercentProgress
			, O3.StatusName
			, O4.Description
			, NULL AS SumPlanTime
			, NULL AS ActualTime
	FROM OOT2190 A4 WITH (NOLOCK)
		LEFT JOIN OOT2100 O1 WITH (NOLOCK) ON O1.ProjectID = A4.ProjectID
		LEFT JOIN AT1103  O2 WITH (NOLOCK) ON O2.EmployeeID = A4.AssignedToUserID
		LEFT JOIN OOT1040 O3 WITH (NOLOCK) ON O3.StatusID = A4.StatusID 
		LEFT JOIN OOT0099 O4 WiTH (NOLOCK) ON O4.ID = A4.TypeOfMilestone AND O4.CodeMaster = 'OOF2190.TypeOfMilestone'
	WHERE (A4.TimeRequest BETWEEN @PlanStartDateText AND @PlanEndDateText
			OR A4.DeadlineRequest BETWEEN @PlanStartDateText AND @PlanEndDateText)
			AND A4.DivisionID IN (@DivisionID)
			-- Kiểm tra trạng thái Milestone đã được chọn trên màn hình báo cáo
			AND (ISNULL(@StatusMT, '') = '' OR A4.StatusID IN (SELECT * FROM StringSplit(REPLACE(@StatusMT, '''', ''), ',')))
			AND A4.AssignedToUserID IN (SELECT * FROM StringSplit(REPLACE(@AssignedToUserID, '''', ''), ','))  AND ISNULL(A4.DeleteFlg,0) = 0
	ORDER BY A4.AssignedToUserID, A4.MilestoneID ASC, A4.TimeRequest ASC

	-- Insert dữ liệu công việc vào bảng tạm @TableTask
	INSERT INTO @TableData (STT, TypeData, Description, AssignedToUserID, AssignedToUserName, ProjectID, ValueID, ValueName
	                                ,PlanStartDate, PlanEndDate, ActualStartDate, ActualEndDate, PlanTime, ActualTime, PercentProgress, StatusName, TypeOf, SumPlanTime, SumActualTime)
	SELECT NULL AS STT
           , 3 AS TypeData
		   , N'Công việc' AS Description
		   , A1.AssignedToUserID
		   , CONCAT(N'Họ và tên: ',O2.FullName)  AS AssignedToUserName
		   , CASE
				WHEN ISNULL(O1.ProjectName, '') != '' AND ISNULL(A1.ProjectID, '') != ''
					THEN CONCAT(O1.ProjectID, ' - ', O1.ProjectName)
				ELSE A1.ProjectID
				END 
		   , A1.TaskID
		   , A1.TaskName
		   , A1.PlanStartDate
		   , A1.PlanEndDate
		   , A1.ActualStartDate
		   , A1.ActualEndDate
		   , A1.PlanTime
		   , A1.ActualTime
		   , A1.PercentProgress
		   , O3.StatusName
		   , NULL AS TypeOf
		   , NULL AS SumPlanTime 
		   , NULL AS SumActualTime
	FROM OOT2110 A1 WITH (NOLOCK)
		LEFT JOIN OOT2100 O1 WITH (NOLOCK) ON O1.ProjectID = A1.ProjectID AND ISNULL(O1.DeleteFlg, 0) = 0
		LEFT JOIN AT1103  O2 WITH (NOLOCK) ON A1.AssignedToUserID = O2.EmployeeID
		LEFT JOIN OOT1040 O3 WITH (NOLOCK) ON A1.StatusID = O3.StatusID
	WHERE A1.DivisionID IN (@DivisionID) AND
		  (A1.PlanStartDate BETWEEN @PlanStartDateText AND @PlanEndDateText 
		  OR A1.PlanEndDate BETWEEN @PlanStartDateText AND @PlanEndDateText
		  OR A1.ActualStartDate BETWEEN @PlanStartDateText AND @PlanEndDateText 
		  OR A1.ActualEndDate BETWEEN @PlanStartDateText AND @PlanEndDateText)
		  -- Kiểm tra với Trạng thái đã chọn trên màn hình Báo cáo
		  AND (ISNULL(@StatusID, '') = '' OR A1.StatusID IN (SELECT * FROM StringSplit(REPLACE(@StatusID, '''', ''), ',')))
		  AND A1.AssignedToUserID IN (SELECT * FROM StringSplit(REPLACE(@AssignedToUserID, '''', ''), ','))  AND ISNULL(A1.DeleteFlg,0) = 0
	ORDER BY A1.AssignedToUserID ASC, A1.TaskID ASC, A1.PlanStartDate ASC

	--- Tính tổng số giờ kế hoạch và thực tế từ bảng @TableTask và insert vào bảng @DataSum
	INSERT INTO @TableData (TypeData, AssignedToUserID, PlanTime, ActualTime)
	SELECT  1 AS TypeData 
	      , AssignedToUserID AS AssignedToUserID
		  , SUM(A1.PlanTime) AS PlanTime 
		  , SUM(A1.ActualTime) AS ActualTime
	FROM @TableData A1
	where TypeData = 3
	GROUP BY AssignedToUserID

		--- Tính tổng số giờ kế hoạch và thực tế từ bảng @TableTask và insert vào bảng @DataSum
	--INSERT INTO @TableData (TypeData, Description)
	--SELECT  0 AS TypeData 
	--		, COUNT(TypeData) AS Description
	--FROM @TableData A1
	

	-- Update giá trị cột SumPlanTime từ bảng @DataSum cho cột SumPlanTime của bảng @TaskTask
	--UPDATE @TableTask 
	--SET SumPlanTime = T2.SumPlanTime
	--FROM @TableTask T1
	--LEFT JOIN @DataSum T2 ON T1.AssignedToUserID = T2.AssignedToUserID

	-- Update giá trị cột SumActualTime từ bảng @DataSum cho cột SumActualTime của bảng @TaskTask
	--UPDATE @TableTask 
	--SET SumActualTime = T4.SumActualTime
	--FROM @TableTask T3
	--LEFT JOIN @DataSum T4 ON T3.AssignedToUserID = T4.AssignedToUserID

	-- Insert dữ liệu Release vào bảng tạm @TableRelease
	INSERT INTO @TableData (STT, TypeData, Description, AssignedToUserID, AssignedToUserName, ProjectID, ValueID, ValueName
	                                ,PlanStartDate, PlanEndDate, ActualStartDate, ActualEndDate, PlanTime, ActualTime, PercentProgress, StatusName, TypeOf, SumPlanTime, SumActualTime)
	SELECT NULL AS STT
	       , 4 AS TypeData
		   , N'Release' AS Description
		   , O5.AssignedToUserID AS AssignedToUserID
		   , CONCAT(N'Họ và tên: ',O2.FullName)  AS AssignedToUserName
		   , CASE
				WHEN ISNULL(O1.ProjectName, '') != '' AND ISNULL(A5.ProjectID, '') != ''
					THEN CONCAT(O1.ProjectID, ' - ', O1.ProjectName)
				ELSE A5.ProjectID
				END
			, A5.ReleaseID
			, A5.ReleaseName
			, NULL AS PlanStartDate
			, NULL AS PlanEndDate
			, NULL AS ActualStartDate
			, NULL AS ActualEndDate
			, NULL AS PlanTime
			, NULL AS ActualTime
			, NULL AS PercentProgress
			, NULL AS StatusName
			, O4.Description
			, NULL AS SumPlanTime
			, NULL AS SumActualTime
	FROM OOT2210 A5 WITH (NOLOCK)
		LEFT JOIN OOT2100 O1 WITH (NOLOCK) ON O1.ProjectID = A5.ProjectID
		LEFT JOIN OOT0099 O4 WiTH (NOLOCK) ON O4.ID = A5.TypeOfRelease AND O4.CodeMaster = 'OOF2210.TypeOfRelease'
		LEFT JOIN OOT2190 O5 WITH (NOLOCK) ON O5.MilestoneID = A5.MilestoneID AND O5.ProjectID = A5.ProjectID
		LEFT JOIN AT1103  O2 WITH (NOLOCK) ON O2.EmployeeID = O5.AssignedToUserID
	Where (A5.CreateDate BETWEEN @PlanStartDateText AND @PlanEndDateText)
			AND A5.DivisionID IN (@DivisionID) AND ISNULL(A5.DeleteFlg,0) = 0 
			AND O5.AssignedToUserID IN (SELECT * FROM StringSplit(REPLACE(@AssignedToUserID, '''', ''), ','))
	ORDER BY A5.ReleaseID, A5.CreateDate

	-- Insert dữ liệu yêu cầu hỗ trợ vào bảng tạm @TableHelpDesk
	INSERT INTO @TableData (STT, TypeData, Description, AssignedToUserID, AssignedToUserName, ProjectID, ValueID, ValueName
	                                ,PlanStartDate, PlanEndDate, ActualStartDate, ActualEndDate, PlanTime, ActualTime, PercentProgress, StatusName, TypeOf, SumPlanTime, SumActualTime)
	SELECT NULL AS STT
	       , 5 AS TypeData
		   , N'Yêu cầu hỗ trợ' AS Description
		   , A3.AssignedToUserID
		   , CONCAT(N'Họ và tên: ',O2.FullName)  AS AssignedToUserName
		   , NULL AS ProjectID
		   , A3.SupportRequiredID
		   , A3.SupportRequiredName
		   , A3.TimeRequest
		   , A3.DeadlineRequest
		   , A3.ActualStartDate
		   , A3.ActualEndDate
		   , NULL AS PlanTime
		   , A3.ActualTime
		   , A3.PercentProgress
		   , O3.StatusName
		   , O4.Description
		   , NULL AS SumPlanTime
		   , NULL AS SumActualTime
	FROM OOT2170 A3 WITH (NOLOCK)
		LEFT JOIN AT1103  O2 WITH (NOLOCK) ON O2.EmployeeID = A3.AssignedToUserID
		LEFT JOIN OOT1040 O3 WITH (NOLOCK) ON O3.StatusID = A3.StatusID 
		LEFT JOIN OOT0099 O4 WiTH (NOLOCK) ON O4.ID = A3.TypeOfRequest AND O4.CodeMaster = 'OOF2170.TypeOfRequest'
	WHERE (A3.TimeRequest BETWEEN @PlanStartDateText AND @PlanEndDateText
			OR A3.DeadlineRequest BETWEEN @PlanStartDateText AND @PlanEndDateText)
			AND A3.DivisionID IN (@DivisionID)
			-- Kiểm tra trạng thái yêu cầu hỗ trợ đã được chọn trên màn hình báo cáo
			AND (ISNULL(@StatusHD, '') = '' OR A3.StatusID IN (SELECT * FROM StringSplit(REPLACE(@StatusHD, '''', ''), ',')))
			AND A3.AssignedToUserID IN (SELECT * FROM StringSplit(REPLACE(@AssignedToUserID, '''', ''), ','))  AND ISNULL(A3.DeleteFlg,0) = 0
	ORDER BY A3.AssignedToUserID ASC, A3.SupportRequiredID ASC, A3.TimeRequest ASC

	-- Insert dữ liệu vấn đề vào bảng tạm @TableIssues
	INSERT INTO @TableData (STT, TypeData, Description, AssignedToUserID, AssignedToUserName, ProjectID, ValueID, ValueName
	                                ,PlanStartDate, PlanEndDate, ActualStartDate, ActualEndDate, PlanTime, ActualTime, PercentProgress, StatusName, TypeOf, SumPlanTime, SumActualTime)
	SELECT NULL AS STT
	       , 6 AS TypeData
		   , N'Vấn đề' AS Description
		   , A2.AssignedToUserID
		   , CONCAT(N'Họ và tên: ',O2.FullName)  AS AssignedToUserName
		   , CASE
				WHEN ISNULL(O1.ProjectName, '') != '' AND ISNULL(A2.ProjectID, '') != ''
					THEN CONCAT(O1.ProjectID, ' - ', O1.ProjectName)
				ELSE A2.ProjectID
				END 
			, A2.IssuesID
			, A2.IssuesName
			, A2.TimeRequest
			, A2.DeadlineRequest
			, A2.ActualStartDate
			, A2.ActualEndDate
			, NULL AS PlanTime
			, A2.ActualTime
			, A2. PercentProgress
			, O3.StatusName
			, O4.Description
			, NULL AS SumPlanTime
			, NULL AS SumActualTime
	FROM OOT2160 A2 WITH (NOLOCK)
		LEFT JOIN OOT2100 O1 WITH (NOLOCK) ON O1.ProjectID = A2.ProjectID
		LEFT JOIN AT1103  O2 WITH (NOLOCK) ON O2.EmployeeID = A2.AssignedToUserID
		LEFT JOIN OOT1040 O3 WITH (NOLOCK) ON O3.StatusID = A2.StatusID 
		LEFT JOIN OOT0099 O4 WITH (NOLOCK) ON O4.ID = A2.TypeOfIssues AND O4.CodeMaster = N'OOF2160.TypeOfIssues'
	WHERE (A2.TimeRequest BETWEEN @PlanStartDateText AND @PlanEndDateText
			OR A2.DeadlineRequest BETWEEN @PlanStartDateText AND @PlanEndDateText)
			AND A2.DivisionID IN (@DivisionID)
			-- Kiểm tra trạng thái vấn đề đã chọn trên màn hình báo cáo
			AND (ISNULL(@StatusIS, '') = '' OR A2.StatusID IN (SELECT * FROM StringSplit(REPLACE(@StatusIS, '''', ''), ',')))
			AND A2.AssignedToUserID IN (SELECT * FROM StringSplit(REPLACE(@AssignedToUserID, '''', ''), ','))  AND ISNULL(A2.DeleteFlg,0) = 0
	ORDER BY A2.AssignedToUserID ASC, A2.IssuesID ASC, A2.TimeRequest ASC
	
	-- Select tất cả dữ liệu từ bảng tổng
	SELECT *
	FROM @TableData
	ORDER BY AssignedToUserID, TypeData 

END






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
