IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP3028_ASOFT]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP3028_ASOFT]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Báo cáo công việc theo dự án
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Tấn Lộc, Date: 15/06/2020
----Modified on 31/07/2023 by Thu Hà: Bổ sung param PeriodList,IsPeriod
----Modified on 19/09/2023 by Kiều Nga: Fix in báo cáo khi chọn đk lọc theo kỳ
-- <Example>
---- 
/*-- <Example>
	OOP3028 @DivisionID = 'KY', @PlanStartDate = '2019-05-14', @PlanEndDate = '2019-05-14', @ProjectID = '', @StatusID = ''
----*/

CREATE PROCEDURE [dbo].[OOP3028_ASOFT]
(
	@DivisionID VARCHAR(50),
	@PlanStartDate NVARCHAR(3000),
	@PlanEndDate NVARCHAR(3000),
	@ProjectID NVARCHAR(MAX),
	@StatusID NVARCHAR(500) = '',
	@StatusIS NVARCHAR(500) = NULL,
	@StatusMT NVARCHAR(500) = NULL,
	@PrintData NVARCHAR(500) = NULL,
	@IsPeriod NVARCHAR(MAX),
	@PeriodList NVARCHAR(MAX)
)
AS
BEGIN
	DECLARE @sSQL NVARCHAR (MAX),
			@sWhere NVARCHAR(MAX),
			@PlanStartDateText NVARCHAR(20),
			@PlanEndDateText NVARCHAR(20),
			@curentStatusID NVARCHAR(250) = 'StatusID',
			@curentStatusIS NVARCHAR(250) = 'StatusIS',
			@curentStatusHD NVARCHAR(250) = 'StatusHD',
			@curentStatusMT NVARCHAR(250) = 'StatusMT'

	SET @PlanStartDateText = CONVERT(NVARCHAR(20), @PlanStartDate, 111)
	SET @PlanEndDateText = CONVERT(NVARCHAR(10), @PlanEndDate, 111) + ' 23:59:59'

	-- Tạo cấu trúc bảng tổng chứa dữ liệu của những bảng con Công việc, vấn đề, Milestone, Release 
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
			StepID NVARCHAR(MAX),
			StatusName NVARCHAR(250),
			TypeOf NVARCHAR(250)
	)
-- Kiểm tra Milestone có được chọn trên màn hình trước khi insert vào bảng tổng (PrintData lấy tất cả dữ liệu in được chọn trên màn hình)
IF (@curentStatusMT IN (SELECT * FROM StringSplit(REPLACE(@PrintData, '''', ''), ',')))
BEGIN
	-- Insert dữ liệu Milestone vào bảng tổng @TableData
	INSERT INTO @TableData (STT, TypeData, Description, AssignedToUserID, AssignedToUserName, ProjectID, ValueID, ValueName
	                        ,PlanStartDate, PlanEndDate, ActualStartDate, ActualEndDate, PlanTime, ActualTime, PercentProgress, StepID, StatusName, TypeOf)	
	SELECT NULL AS STT
	       , 1 AS TypeData
		   , N'Milestone' AS Description
		   , A4.AssignedToUserID
		   , O2.FullName AS AssignedToUserName
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
			, NULL AS StepID
			, O3.StatusName
			, O4.Description
	FROM OOT2190 A4 WITH (NOLOCK)
		LEFT JOIN OOT2100 O1 WITH (NOLOCK) ON O1.ProjectID = A4.ProjectID
		LEFT JOIN AT1103  O2 WITH (NOLOCK) ON O2.EmployeeID = A4.AssignedToUserID
		LEFT JOIN OOT1040 O3 WITH (NOLOCK) ON O3.StatusID = A4.StatusID 
		LEFT JOIN OOT0099 O4 WiTH (NOLOCK) ON O4.ID = A4.TypeOfMilestone AND O4.CodeMaster = 'OOF2190.TypeOfMilestone'
	WHERE CASE WHEN @IsPeriod = 0 AND (A4.TimeRequest BETWEEN @PlanStartDateText AND @PlanEndDateText OR A4.DeadlineRequest BETWEEN @PlanStartDateText AND @PlanEndDateText) THEN 1
			WHEN @IsPeriod = 1 AND ((SELECT FORMAT(ISNULL(A4.TimeRequest,A4.DeadlineRequest), 'MM/yyyy')) IN (SELECT * FROM StringSplit(REPLACE(@PeriodList, '''', ''), ','))) THEN 1
			ELSE 0 END = 1
			AND A4.DivisionID IN (@DivisionID) 
			-- Kiểm tra trạng thái Milestone đã được chọn trên màn hình báo cáo
			AND (ISNULL(@StatusMT, '') = '' OR A4.StatusID IN (SELECT * FROM StringSplit(REPLACE(@StatusMT, '''', ''), ',')))
			AND A4.ProjectID IN (SELECT * FROM StringSplit(REPLACE(@ProjectID, '''', ''), ','))  AND ISNULL(A4.DeleteFlg,0) = 0  
	ORDER BY A4.ProjectID ASC, A4.MilestoneID ASC
END

-- Kiểm tra Công việc có được chọn trên màn hình trước khi insert vào bảng tổng (PrintData lấy tất cả dữ liệu in được chọn trên màn hình)
IF (@curentStatusID IN (SELECT * FROM StringSplit(REPLACE(@PrintData, '''', ''), ',')))
BEGIN
	-- Insert dữ liệu công việc vào bảng tổng @TableData
	INSERT INTO @TableData (STT, TypeData, Description, AssignedToUserID, AssignedToUserName, ProjectID, ValueID, ValueName
	                        ,PlanStartDate, PlanEndDate, ActualStartDate, ActualEndDate, PlanTime, ActualTime, PercentProgress, StepID, StatusName, TypeOf)	
	SELECT NULL AS STT
           , 2 AS TypeData
		   , N'Công việc' AS Description
		   , A1.AssignedToUserID
		   , O2.FullName AS AssignedToUserName
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
		   , O6.ObjectName AS StepID
		   , O3.StatusName
		   , NULL AS TypeOf
	FROM OOT2110 A1 WITH (NOLOCK)
		LEFT JOIN OOT2100 O1 WITH (NOLOCK) ON O1.ProjectID = A1.ProjectID AND ISNULL(O1.DeleteFlg, 0) = 0
		LEFT JOIN AT1103  O2 WITH (NOLOCK) ON A1.AssignedToUserID = O2.EmployeeID
		LEFT JOIN OOT1040 O3 WITH (NOLOCK) ON A1.StatusID = O3.StatusID
		LEFT JOIN OOT2102 O6 WITH (NOLOCK) ON O6.ObjectID = A1.StepID AND ISNULL(O6.DeleteFlg, 0) = 0
	WHERE CASE WHEN @IsPeriod = 0 AND ((A1.PlanStartDate BETWEEN @PlanStartDateText AND @PlanEndDateText 
					OR A1.PlanEndDate BETWEEN @PlanStartDateText AND @PlanEndDateText
					OR A1.ActualStartDate BETWEEN @PlanStartDateText AND @PlanEndDateText 
					OR A1.ActualEndDate BETWEEN @PlanStartDateText AND @PlanEndDateText)) THEN 1
			WHEN @IsPeriod = 1 AND ((SELECT FORMAT(ISNULL(A1.PlanStartDate,A1.PlanEndDate), 'MM/yyyy')) IN (SELECT * FROM StringSplit(REPLACE(@PeriodList, '''', ''), ','))) THEN 1
			ELSE 0 END = 1
			AND A1.DivisionID IN (@DivisionID)
			-- Kiểm tra trạng thái công việc đã được chọn tren màn hình báo cáo
			AND (ISNULL(@StatusID, '') = '' OR A1.StatusID IN (SELECT * FROM StringSplit(REPLACE(@StatusID, '''', ''), ',')))  
			AND A1.ProjectID IN (SELECT * FROM StringSplit(REPLACE(@ProjectID, '''', ''), ','))  AND ISNULL(A1.DeleteFlg,0) = 0
	ORDER BY A1.ProjectID ASC, A1.TaskID ASC
END

	-- Insert dữ liệu Release vào bảng tổng @TableData
	INSERT INTO @TableData (STT, TypeData, Description, AssignedToUserID, AssignedToUserName, ProjectID, ValueID, ValueName
	                        ,PlanStartDate, PlanEndDate, ActualStartDate, ActualEndDate, PlanTime, ActualTime, PercentProgress, StepID, StatusName, TypeOf)	
	SELECT NULL AS STT
	       , 3 AS TypeData
		   , N'Release' AS Description
		   , O5.AssignedToUserID AS AssignedToUserID
		   , O2.FullName AS AssignedToUserName
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
			, NULL AS StepID
			, NULL AS StatusName
			, O4.Description
	FROM OOT2210 A5 WITH (NOLOCK)
		LEFT JOIN OOT2100 O1 WITH (NOLOCK) ON O1.ProjectID = A5.ProjectID
		LEFT JOIN OOT0099 O4 WiTH (NOLOCK) ON O4.ID = A5.TypeOfRelease AND O4.CodeMaster = 'OOF2210.TypeOfRelease'
		LEFT JOIN OOT2190 O5 WITH (NOLOCK) ON O5.MilestoneID = A5.MilestoneID AND O5.ProjectID = A5.ProjectID
		LEFT JOIN AT1103  O2 WITH (NOLOCK) ON O2.EmployeeID = O5.AssignedToUserID
	Where (A5.CreateDate BETWEEN @PlanStartDateText AND @PlanEndDateText)
			AND A5.DivisionID IN (@DivisionID) AND ISNULL(A5.DeleteFlg,0) = 0 
			AND A5.ProjectID IN (SELECT * FROM StringSplit(REPLACE(@ProjectID, '''', ''), ','))			
	ORDER BY A5.ProjectID ASC, A5.ReleaseID ASC

-- Kiểm tra vấn đề có được chọn trên màn hình trước khi insert vào bảng tổng (PrintData lấy tất cả dữ liệu in được chọn trên màn hình)
IF (@curentStatusIS IN (SELECT * FROM StringSplit(REPLACE(@PrintData, '''', ''), ',')))
BEGIN
	-- Insert dữ liệu vấn đề vào bảng tổng @TableData
	INSERT INTO @TableData (STT, TypeData, Description, AssignedToUserID, AssignedToUserName, ProjectID, ValueID, ValueName
	                        ,PlanStartDate, PlanEndDate, ActualStartDate, ActualEndDate, PlanTime, ActualTime, PercentProgress, StepID, StatusName, TypeOf)	
	SELECT NULL AS STT
	       , 4 AS TypeData
		   , N'Vấn đề' AS Description
		   , A2.AssignedToUserID
		   , O2.FullName AS AssignedToUserName
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
			, A2.PercentProgress
			, NULL AS StepID
			, O3.StatusName
			, O4.Description
	FROM OOT2160 A2 WITH (NOLOCK)
		LEFT JOIN OOT2100 O1 WITH (NOLOCK) ON O1.ProjectID = A2.ProjectID
		LEFT JOIN AT1103  O2 WITH (NOLOCK) ON O2.EmployeeID = A2.AssignedToUserID
		LEFT JOIN OOT1040 O3 WITH (NOLOCK) ON O3.StatusID = A2.StatusID 
		LEFT JOIN OOT0099 O4 WITH (NOLOCK) ON O4.ID = A2.TypeOfIssues AND O4.CodeMaster = N'OOF2160.TypeOfIssues'
	WHERE CASE WHEN @IsPeriod = 0 AND (A2.TimeRequest BETWEEN @PlanStartDateText AND @PlanEndDateText OR A2.DeadlineRequest BETWEEN @PlanStartDateText AND @PlanEndDateText) THEN 1
			WHEN @IsPeriod = 1 AND ((SELECT FORMAT(ISNULL(A2.TimeRequest,A2.DeadlineRequest), 'MM/yyyy')) IN (SELECT * FROM StringSplit(REPLACE(@PeriodList, '''', ''), ','))) THEN 1
			ELSE 0 END = 1
			AND A2.DivisionID IN (@DivisionID)
			-- Kiểm tra trạng thái vấn đề đã được chọn trên màn hình báo cáo 
			AND (ISNULL(@StatusIS, '') = '' OR A2.StatusID IN (SELECT * FROM StringSplit(REPLACE(@StatusIS, '''', ''), ',')))
			AND A2.ProjectID IN (SELECT * FROM StringSplit(REPLACE(@ProjectID, '''', ''), ','))  AND ISNULL(A2.DeleteFlg,0) = 0
	ORDER BY A2.ProjectID ASC, A2.IssuesID ASC
END
	-- Select tất cả dữ liệu từ bảng tổng
	SELECT * FROM @TableData
	ORDER BY ProjectID, TypeData, ValueID

END





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
