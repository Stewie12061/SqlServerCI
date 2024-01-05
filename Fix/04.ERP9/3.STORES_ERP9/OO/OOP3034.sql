IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP3034]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP3034]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
--- Load dữ liệu Báo cáo Tình hình công việc theo nhân viên
-- <Param> 
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Thanh Lượng, Date: 26/10/2022
----Modified on 20/11/2023 by Thanh Hải: Cập nhật in dữ liệu theo tất cả nhân viên khi không chọn nhân viên
-- <Example>
/*
	EXEC OOP3034 @divisionID= 'DTI', @IsDate =1, @PlanStartDate=N'09/01/2022',@PlanEndDate=N'09/30/2022',@PeriodIDList=N'09/2022',@UserList=N'D11001,D16001',@PrintData=N''
*/

 CREATE PROCEDURE [dbo].[OOP3034] (
     @DivisionID		NVARCHAR(50),	--Biến môi trường
	 @IsDate			TINYINT,		--1: Theo ngày; 0: Theo kỳ
	 @PlanStartDate		NVARCHAR(MAX),
	 @PlanEndDate		NVARCHAR(MAX),
	 @PeriodIDList		NVARCHAR(MAX),
	 @UserList			nvarchar(max),
	 @ConditionTaskID VARCHAR(MAX) = NULL,
	 @PrintData NVARCHAR(500)
)
AS

DECLARE @sSQL NVARCHAR(MAX),
			@sInsertUser NVARCHAR(MAX),
			@sWhere NVARCHAR(MAX),
			@PlanStartDateText NVARCHAR(20),
			@PlanEndDateText NVARCHAR(20),
			@sTaskTime Nvarchar(Max),
			@sIssueTime Nvarchar(Max),
			@sSRTime Nvarchar(Max),
			@sInsertTask Nvarchar(Max),
			@sInsertIssue Nvarchar(Max),
			@sInsertSR Nvarchar(Max),
			@sInsertTaskDetail Nvarchar(Max),
			@sInsertIssueDetail Nvarchar(Max),
			@sInsertSRDetail Nvarchar(Max),
			@sTaskTimeDetail Nvarchar(Max),
			@sIssueTimeDetail Nvarchar(Max),
			@sSRTimeDetail Nvarchar(Max),
			@CheckDayofMonth Nvarchar(Max), -- Check số ngày cuối cùng của tháng
			@GetLastWeek NVARCHAR(250),--Lấy số tuần,
			@sSQLWhere nvarchar(max) = '' -- Điều kiện dữ liệu in
						
SET @CheckDayofMonth = DAY(EOMONTH(SUBSTRING(@PeriodIDList,1,3)+'01/2022'))
SET @PlanStartDateText = CONVERT(NVARCHAR(20), @PlanStartDate, 111)
SET @PlanEndDateText = CONVERT(NVARCHAR(10), @PlanEndDate, 111) + ' 23:59:59'


Set @sWhere = ' AND O2.DeleteFlg != 1 AND DivisionID in ('''+@DivisionID+''', ''@@@'') 
'
--Nếu dữ liệu in là YCHT/CV thì ẩn chi tiết IS
if charindex(@PrintData,'StatusID/StatusHD',0)=0
	SET @sSQLWhere = ' WHERE ISNULL(TYPEDATA,0) != 3'
--Nếu dữ liệu in là IS/CV thì ẩn chi tiết YCHT
if charindex(@PrintData,'StatusID/StatusIS',0)=0
	SET @sSQLWhere = ' WHERE ISNULL(TYPEDATA,0) != 2'

if ISNULL(@UserList, '') = ''
BEGIN
SET @ConditionTaskID = REPLACE(REPLACE(@ConditionTaskID, '''',''), ',,', ',');
SET @sInsertUser = '
	DECLARE @Temp TABLE(
	UserID VARCHAR(50)
	)

INSERT INTO @Temp (UserID) 
SELECT 
    value  
FROM 
	StringSplit('''+@ConditionTaskID+''','','')' 
END
else 
BEGIN 
SET @sInsertUser = '
	DECLARE @Temp TABLE(
	UserID VARCHAR(50)
	)

INSERT INTO @Temp (UserID) 
SELECT 
    value  
FROM 
    StringSplit('''+@UserList+''','','')' 
END	
IF @IsDate = 1
--Theo ngày
BEGIN
set @GetLastWeek=   DATEPART(week, @PlanEndDate)
--Set điều kiên thời gian cho công việc
	SET @sTaskTime = @sWhere + ' AND (O2.PlanStartDate BETWEEN '''+@PlanStartDateText+''' AND  '''+@PlanEndDateText+''' 
								OR O2.PlanEndDate BETWEEN '''+@PlanStartDateText+''' AND  '''+@PlanEndDateText+''' 
								OR O2.ActualStartDate BETWEEN '''+@PlanStartDateText+''' AND  '''+@PlanEndDateText+'''  
								OR O2.ActualEndDate BETWEEN '''+@PlanStartDateText+''' AND  '''+@PlanEndDateText+'''  )
								AND O2.StatusID not in (''TTCV0004'',''TTCV0005'',''TTCV0007'')' +'
								Group by t1.UserID'
--Set điều kiên thời gian cho vấn đề	
	SET @sIssueTime = @sWhere + ' AND (O2.TimeRequest BETWEEN '''+@PlanStartDateText+''' AND  '''+@PlanEndDateText+''' 
								  OR O2.DeadlineRequest BETWEEN '''+@PlanStartDateText+''' AND  '''+@PlanEndDateText+'''  )
								  AND O2.StatusID not in (''TTIS0006'',''TTIS0004'') '+'
								  Group by t1.UserID'		 
--Set điều kiên thời gian cho yêu cầu hỗ trợ
	set @sSRTime = @sWhere + 'AND  (O2.TimeRequest BETWEEN '''+@PlanStartDateText+''' AND  '''+@PlanEndDateText+''' 
							  OR O2.DeadlineRequest BETWEEN '''+@PlanStartDateText+''' AND  '''+@PlanEndDateText+''' )
							  AND O2.StatusID not in (''TTRQ0006'',''TTRQ0004'') '+'
						      Group by t1.UserID'
--Set điều kiên thời gian cho công việc
	SET @sTaskTimeDetail = @sWhere + ' AND (O2.PlanStartDate BETWEEN '''+@PlanStartDateText+''' AND  '''+@PlanEndDateText+''' 
								OR O2.PlanEndDate BETWEEN '''+@PlanStartDateText+''' AND  '''+@PlanEndDateText+''' 
								OR O2.ActualStartDate BETWEEN '''+@PlanStartDateText+''' AND  '''+@PlanEndDateText+'''  
								OR O2.ActualEndDate BETWEEN '''+@PlanStartDateText+''' AND  '''+@PlanEndDateText+'''  )
								AND O2.StatusID not in (''TTCV0004'',''TTCV0005'',''TTCV0007'',''TTCV0003'')' 
--Set điều kiên thời gian cho vấn đề	
	SET @sIssueTimeDetail = @sWhere + ' AND (O2.TimeRequest BETWEEN '''+@PlanStartDateText+''' AND  '''+@PlanEndDateText+''' 
										 OR O2.DeadlineRequest BETWEEN '''+@PlanStartDateText+''' AND  '''+@PlanEndDateText+'''  )
										AND O2.StatusID not in (''TTIS0006'',''TTIS0004'') '
--Set điều kiên thời gian cho yêu cầu hỗ trợ
	set @sSRTimeDetail = @sWhere + 'AND  (O2.TimeRequest BETWEEN '''+@PlanStartDateText+''' AND  '''+@PlanEndDateText+''' 
								    OR O2.DeadlineRequest BETWEEN '''+@PlanStartDateText+''' AND  '''+@PlanEndDateText+''' )
									AND O2.StatusID not in (''TTRQ0006'',''TTRQ0004'' ,''TTRQ0003'') '
END
ELSE
--Theo kỳ
BEGIN
set @GetLastWeek=   DATEPART(week, SUBSTRING(@PeriodIDList,1,3)+''+@CheckDayofMonth+''+'/2022')
--Set điều kiên thời gian cho công việc	
SET @sTaskTime = @sWhere + ' AND  ((Case When  Month(O2.PlanStartDate) <10 then ''0''+rtrim(ltrim(str(Month(O2.PlanStartDate))))+''/''
										+ltrim(Rtrim(str(Year(O2.PlanStartDate)))) Else rtrim(ltrim(str(Month(O2.PlanStartDate))))+''/''
										+ltrim(Rtrim(str(Year(O2.PlanStartDate)))) End) IN ('''+@PeriodIDList+''')
					OR (Case When  Month(O2.PlanEndDate) <10 then ''0''+rtrim(ltrim(str(Month(O2.PlanEndDate))))+''/''
										+ltrim(Rtrim(str(Year(O2.PlanEndDate)))) Else rtrim(ltrim(str(Month(O2.PlanEndDate))))+''/''
										+ltrim(Rtrim(str(Year(O2.PlanEndDate)))) End) IN ('''+@PeriodIDList+''')
					OR (Case When  Month(O2.ActualStartDate) <10 then ''0''+rtrim(ltrim(str(Month(O2.ActualStartDate))))+''/''
										+ltrim(Rtrim(str(Year(O2.ActualStartDate)))) Else rtrim(ltrim(str(Month(O2.ActualStartDate))))+''/''
										+ltrim(Rtrim(str(Year(O2.ActualStartDate)))) End) IN ('''+@PeriodIDList+''')
					OR (Case When  Month(O2.ActualEndDate) <10 then ''0''+rtrim(ltrim(str(Month(O2.ActualEndDate))))+''/''
										+ltrim(Rtrim(str(Year(O2.ActualEndDate)))) Else rtrim(ltrim(str(Month(O2.ActualEndDate))))+''/''
										+ltrim(Rtrim(str(Year(O2.ActualEndDate)))) End) IN ('''+@PeriodIDList+'''))
					AND O2.StatusID not in (''TTCV0004'',''TTCV0005'',''TTCV0007'')' +'
					Group by t1.UserID'

--Set điều kiên thời gian cho vấn đề	
SET @sIssueTime = @sWhere + ' AND ((Case When  Month(O2.TimeRequest) <10 then ''0''+rtrim(ltrim(str(Month(O2.TimeRequest))))+''/''
										+ltrim(Rtrim(str(Year(O2.TimeRequest)))) Else rtrim(ltrim(str(Month(O2.TimeRequest))))+''/''
										+ltrim(Rtrim(str(Year(O2.TimeRequest)))) End) IN ('''+@PeriodIDList+''')
					OR (Case When  Month(O2.DeadlineRequest) <10 then ''0''+rtrim(ltrim(str(Month(O2.DeadlineRequest))))+''/''
										+ltrim(Rtrim(str(Year(O2.DeadlineRequest)))) Else rtrim(ltrim(str(Month(O2.DeadlineRequest))))+''/''
										+ltrim(Rtrim(str(Year(O2.DeadlineRequest)))) End) IN ('''+@PeriodIDList+'''))
					AND O2.StatusID not in (''TTIS0006'',''TTIS0004'') '+'
					Group by t1.UserID'

--Set điều kiên thời gian cho yêu cầu hỗ trợ
set @sSRTime = @sWhere + ' AND ((Case When  Month(O2.TimeRequest) <10 then ''0''+rtrim(ltrim(str(Month(O2.TimeRequest))))+''/''
										+ltrim(Rtrim(str(Year(O2.TimeRequest)))) Else rtrim(ltrim(str(Month(O2.TimeRequest))))+''/''
										+ltrim(Rtrim(str(Year(O2.TimeRequest)))) End) IN ('''+@PeriodIDList+''')
					OR (Case When  Month(O2.DeadlineRequest) <10 then ''0''+rtrim(ltrim(str(Month(O2.DeadlineRequest))))+''/''
										+ltrim(Rtrim(str(Year(O2.DeadlineRequest)))) Else rtrim(ltrim(str(Month(O2.DeadlineRequest))))+''/''
										+ltrim(Rtrim(str(Year(O2.DeadlineRequest)))) End) IN ('''+@PeriodIDList+'''))
					AND O2.StatusID not in (''TTRQ0006'',''TTRQ0004'') '+'
					Group by t1.UserID'

--Set điều kiên thời gian cho công việc
SET @sTaskTimeDetail = @sWhere + 'AND  ((Case When  Month(O2.PlanStartDate) <10 then ''0''+rtrim(ltrim(str(Month(O2.PlanStartDate))))+''/''
										+ltrim(Rtrim(str(Year(O2.PlanStartDate)))) Else rtrim(ltrim(str(Month(O2.PlanStartDate))))+''/''
										+ltrim(Rtrim(str(Year(O2.PlanStartDate)))) End) IN ('''+@PeriodIDList+''')
					OR (Case When  Month(O2.PlanEndDate) <10 then ''0''+rtrim(ltrim(str(Month(O2.PlanEndDate))))+''/''
										+ltrim(Rtrim(str(Year(O2.PlanEndDate)))) Else rtrim(ltrim(str(Month(O2.PlanEndDate))))+''/''
										+ltrim(Rtrim(str(Year(O2.PlanEndDate)))) End) IN ('''+@PeriodIDList+''')
					OR (Case When  Month(O2.ActualStartDate) <10 then ''0''+rtrim(ltrim(str(Month(O2.ActualStartDate))))+''/''
										+ltrim(Rtrim(str(Year(O2.ActualStartDate)))) Else rtrim(ltrim(str(Month(O2.ActualStartDate))))+''/''
										+ltrim(Rtrim(str(Year(O2.ActualStartDate)))) End) IN ('''+@PeriodIDList+''')
					OR (Case When  Month(O2.ActualEndDate) <10 then ''0''+rtrim(ltrim(str(Month(O2.ActualEndDate))))+''/''
										+ltrim(Rtrim(str(Year(O2.ActualEndDate)))) Else rtrim(ltrim(str(Month(O2.ActualEndDate))))+''/''
										+ltrim(Rtrim(str(Year(O2.ActualEndDate)))) End) IN ('''+@PeriodIDList+'''))
					AND O2.StatusID not in (''TTCV0004'',''TTCV0005'',''TTCV0007'',''TTCV0003'')'    

--Set điều kiên thời gian cho vấn đề	
SET @sIssueTimeDetail = @sWhere + ' AND ((Case When  Month(O2.TimeRequest) <10 then ''0''+rtrim(ltrim(str(Month(O2.TimeRequest))))+''/''
										+ltrim(Rtrim(str(Year(O2.TimeRequest)))) Else rtrim(ltrim(str(Month(O2.TimeRequest))))+''/''
										+ltrim(Rtrim(str(Year(O2.TimeRequest)))) End) IN ('''+@PeriodIDList+''')
					OR (Case When  Month(O2.DeadlineRequest) <10 then ''0''+rtrim(ltrim(str(Month(O2.DeadlineRequest))))+''/''
										+ltrim(Rtrim(str(Year(O2.DeadlineRequest)))) Else rtrim(ltrim(str(Month(O2.DeadlineRequest))))+''/''
										+ltrim(Rtrim(str(Year(O2.DeadlineRequest)))) End) IN ('''+@PeriodIDList+'''))
					AND O2.StatusID not in (''TTIS0006'',''TTIS0004'',''TTIS0003'')'

--Set điều kiên thời gian cho yêu cầu hỗ trợ
set @sSRTimeDetail = @sWhere + ' AND ((Case When  Month(O2.TimeRequest) <10 then ''0''+rtrim(ltrim(str(Month(O2.TimeRequest))))+''/''
										+ltrim(Rtrim(str(Year(O2.TimeRequest)))) Else rtrim(ltrim(str(Month(O2.TimeRequest))))+''/''
										+ltrim(Rtrim(str(Year(O2.TimeRequest)))) End) IN ('''+@PeriodIDList+''')
					OR (Case When  Month(O2.DeadlineRequest) <10 then ''0''+rtrim(ltrim(str(Month(O2.DeadlineRequest))))+''/''
										+ltrim(Rtrim(str(Year(O2.DeadlineRequest)))) Else rtrim(ltrim(str(Month(O2.DeadlineRequest))))+''/''
										+ltrim(Rtrim(str(Year(O2.DeadlineRequest)))) End) IN ('''+@PeriodIDList+'''))
					AND O2.StatusID not in (''TTRQ0006'',''TTRQ0004'',''TTRQ0003'')'
END


-------------------------------Bang 1---------------------------------------------
--Thêm dữ liệu tong công việc vào bảng tạm
	set @sInsertTask = '
		DECLARE @Temp1 TABLE(
			 UserID VARCHAR(50), 
			 TotalTask INT,
			 UnexcuteTask INT,
			 WorkingTask INT,
			 CompleteTask INT
		)
		INSERT INTO @Temp1 (
			 UserID,
			 TotalTask,
			 UnexcuteTask,
			 WorkingTask ,
			 CompleteTask 
		) 
		select  t1.UserID,
				COUNT(O2.APK) as TotalTask,
				COUNT(O2.APK) - COUNT(case when O2.StatusID = ''TTCV0003'' then 1 else null end) - COUNT(case when O2.StatusID = ''TTCV0002'' 
				AND CONVERT(NVARCHAR(10), O2.PlanEndDate, 111) >= CONVERT(NVARCHAR(10), GETDATE(), 111) then 1 else null end) as UnexcuteTask,
				COUNT(case when O2.StatusID = ''TTCV0002'' then 1 else null end) AS WorkingTask,
				COUNT(case when O2.StatusID = ''TTCV0003'' then 1 else null end) AS CompleteTask
		from @Temp t1
		JOIN OOT2110 O2 on O2.AssignedToUserID = t1.UserID'  
		+ @sTaskTime 
--Thêm dữ liệu tổng vấn đề vào bảng tạm
	set @sInsertIssue = '
		DECLARE @Temp2 TABLE(
		 UserID VARCHAR(50), 
			TotalIssue INT,
			UnexcuteIssue INT,
			WorkingIssue INT,
			CompleteIssue INT
			)
			INSERT INTO @Temp2 (
			UserID,
			TotalIssue ,
			UnexcuteIssue,
			WorkingIssue,
			CompleteIssue 
			) 
			select  t1.UserID,
					COUNT(O2.APK) as TotalIssue,
					COUNT(case when O2.StatusID = ''TTIS0001'' then 1 else null end)  as UnexcuteIssue,
					COUNT(case when O2.StatusID = ''TTIS0002'' then 1 else null end) AS WorkingIssue,
					COUNT(case when O2.StatusID = ''TTIS0003'' then 1 else null end) AS CompleteIssue		
		from @Temp t1
		JOIN OOT2160 O2 on O2.AssignedToUserID = t1.UserID'  
		+ @sIssueTime  
--Thêm dữ liệu tong yêu cầu hỗ trợ vào bảng tạm
	set @sInsertSR = '
		DECLARE @Temp3 TABLE(
			 UserID VARCHAR(50), 
			 TotalSR INT,
			 UnexcuteSR INT,
			 WorkingSR INT,
			 CompleteSR INT
			)
			INSERT INTO @Temp3(
			UserID,
			TotalSR,
			UnexcuteSR,
			WorkingSR,
			CompleteSR 
			) 
		select  t1.UserID,
				COUNT(O2.APK) as TotalSR,
				COUNT(case when O2.StatusID = ''TTRQ0001'' then 1 else null end)  as UnexcuteSR,
				COUNT(case when O2.StatusID = ''TTRQ0002'' then 1 else null end) AS WorkingSR,
				COUNT(case when O2.StatusID != ''TTRQ0003'' AND O2.DeadlineRequest < CONVERT(NVARCHAR(10), GETDATE(), 111) then 1 else null end) AS CompleteSR
			
		from @Temp t1
		JOIN OOT2170 O2 on O2.AssignedToUserID = t1.UserID' 
		+ @sSRTime
SET @sSQL= @sInsertUser + @sInsertTask+@sInsertIssue+@sInsertSR+N' 
DECLARE @Temp7 TABLE(
		UserID VARCHAR(50),
		TotalTask INT,
		UnexcuteTask INT,
		WorkingTask INT,	
		CompleteTask INT,
		TotalIssue INT,
		UnexcuteIssue INT,
		WorkingIssue INT,
		CompleteIssue INT,
		TotalSR INT,
		UnexcuteSR INT,
		WorkingSR INT,
		CompleteSR INT
)
	INSERT INTO @Temp7 ( 
		UserID,
		TotalTask ,
		UnexcuteTask ,
		WorkingTask ,
		CompleteTask ,
		TotalIssue ,
		UnexcuteIssue ,
		WorkingIssue ,
		CompleteIssue ,
		TotalSR ,
		UnexcuteSR ,
		WorkingSR ,
		CompleteSR 
			)			
Select  t.UserID, IsNull(t1.TotalTask, 0) as TotalTask, IsNull(t1.UnexcuteTask, 0) as UnexcuteTask,  IsNull(t1.WorkingTask, 0) as WorkingTask,IsNull(t1.CompleteTask, 0) as CompleteTask
,IsNull(t2.TotalIssue, 0) as TotalIssue, IsNull(t2.UnexcuteIssue, 0) as UnexcuteIssue, IsNull(t2.WorkingIssue, 0) as WorkingIssue,  IsNull(t2.CompleteIssue, 0) as CompleteIssue
,IsNull(t3.TotalSR, 0) as TotalSR,IsNull(t3.UnexcuteSR, 0) as UnexcuteSR,IsNull(t3.WorkingSR, 0) as WorkingSR, IsNull(t3.CompleteSR, 0) as CompleteSR
from @Temp t
Full Outer join @Temp1 t1 on t1.UserID = t.UserID
Full Outer join @Temp2 t2 on t2.UserID = t.UserID
Full Outer join @Temp3 t3 on t3.UserID = t.UserID
Where not (IsNull(t1.TotalTask, 0) = 0 AND IsNull(t2.TotalIssue, 0)=0 AND IsNull(t3.TotalSR, 0)=0)

DECLARE @count INT
SELECT @count = COUNT(*) FROM @Temp7
IF @count > 1
	SELECT 0 as TempSort, @count + 1 AS TotalRow
	, '+@GetLastWeek+N' AS WeekOfMonth 
	, N''Tổng cộng:'' AS UserName, ''AVG'' AS UserID
	, Sum(TotalTask) as TotalTask  
	, Sum(UnexcuteTask) as UnexcuteTask  
	, Sum(WorkingTask) as WorkingTask  
	, Sum(CompleteTask) as CompleteTask  
	, Sum(TotalIssue) as TotalIssue  
	, Sum(UnexcuteIssue) as UnexcuteIssue  
	, Sum(WorkingIssue) as WorkingIssue  
	, Sum(CompleteIssue) as CompleteIssue  
	, Sum(TotalSR) as TotalSR  
	, Sum(UnexcuteSR) as UnexcuteSR  
	, Sum(WorkingSR) as WorkingSR  
	, Sum(CompleteSR) as CompleteSR  
	from @Temp7
	UNION
	Select * from 
	(SELECT DISTINCT 1 as TempSort, @count + 1 AS TotalRow,'+@GetLastWeek+' AS WeekOfMonth , a1.UserName, t6.* from @Temp7 t6
	Join AT1405 a1 on a1.UserID = t6.UserID
	) as RES
	ORDER BY TempSort DESC
ELSE
	SELECT DISTINCT @count AS TotalRow, a1.UserName,'+@GetLastWeek+' AS WeekOfMonth , t6.* from @Temp7 t6
	Join AT1405 a1 on a1.UserID = t6.UserID
'
	--PRINT (@sInsertUser)
	--PRINT (@sInsertTask)
	--PRINT (@sInsertIssue)
	--PRINT (@sInsertSR)
	--PRINT (@sSQLTotal)
	--EXEC  (@sSQL)
EXEC  (@sSQL)

-------------------------------Bang 2---------------------------------------------
--Thêm dữ liệu chi tiet công việc vào bảng tạm
set @sInsertTaskDetail = N'
DECLARE @temp4 AS TABLE (		
	        TypeData INT,
			Description NVARCHAR(MAX),
			UserID VARCHAR(50),
			FullName NVARCHAR(MAX),
			ProjectID NVARCHAR(MAX),
			ValueID VARCHAR(50),
			ValueName NVARCHAR(MAX),
			PlanStartDate Datetime,
			PlanEndDate Datetime,
			PlanTime DECIMAL(28,8),
			ActualStartDate DATETIME,
			ActualEndDate DATETIME,
			ActualTime DECIMAL(28,8),
			PercentProgress DECIMAL(28,8),
			StatusName NVARCHAR(250),
			StatusQualityOfWork NVARCHAR(250),
			TypeOf NVARCHAR(250),
			SumPlanTime DECIMAL(28,8),
			SumActualTime DECIMAL(28,8)
	)
INSERT INTO @temp4 ( TypeData, Description, UserID, FullName, ProjectID, ValueID, ValueName
	                                ,PlanStartDate, PlanEndDate, PlanTime, ActualStartDate, ActualEndDate, ActualTime, PercentProgress, StatusName,StatusQualityOfWork, TypeOf, SumPlanTime, SumActualTime)
		--Công việc
			SELECT 
            1 AS TypeData
		   , N''Công việc'' AS Description
		   , t1.UserID 
		   , CONCAT(N''Họ và tên: '',a1.FullName) 
		   ,CASE
				WHEN ISNULL(O1.ProjectName, '''') != '''' AND ISNULL(O2.ProjectID, '''') != ''''
					THEN CONCAT(O1.ProjectID, '' - '', O1.ProjectName)
				ELSE O2.ProjectID
				END
		   , O2.TaskID
		   , O2.TaskName
		   , O2.PlanStartDate
		   , O2.PlanEndDate
		   , O2.PlanTime
		   , O2.ActualStartDate
		   , O2.ActualEndDate
		   , O2.ActualTime
		   , O2.PercentProgress
		   , O3.StatusName
		   , NULL  AS StatusQualityOfWork
		   , NULL AS TypeOf
		   , NULL AS SumPlanTime
		   , NULL AS SumActualTime
from @Temp t1 
--Công việc
JOIN OOT2110 O2 on O2.AssignedToUserID = t1.UserID '+@sTaskTimeDetail+'
LEFT JOIN AT1103  a1  ON O2.AssignedToUserID = a1.EmployeeID
LEFT JOIN OOT2100 O1  ON O1.ProjectID = O2.ProjectID AND ISNULL(O1.DeleteFlg, 0) = 0
LEFT JOIN OOT1040 O3  ON O2.StatusID = O3.StatusID
WHERE DATEDIFF(DAY,O2.CREATEDATE,GETDATE()) >=5
ORDER BY  t1.UserID ASC, O2.TaskID ASC, O2.PlanStartDate ASC
'
--Thêm dữ liệu chi tiet vấn đề vào bảng tạm
set @sInsertIssueDetail = N'
DECLARE @temp5 AS TABLE (
			
	        TypeData INT,
			Description NVARCHAR(MAX),
			UserID VARCHAR(50),
			FullName NVARCHAR(MAX),
			ProjectID NVARCHAR(MAX),
			ValueID VARCHAR(50),
			ValueName NVARCHAR(MAX),
			PlanStartDate Datetime,
			PlanEndDate Datetime,
			PlanTime DECIMAL(28,8),
			ActualStartDate DATETIME,
			ActualEndDate DATETIME,
			ActualTime DECIMAL(28,8),
			PercentProgress DECIMAL(28,8),
			StatusName NVARCHAR(250),
			StatusQualityOfWork NVARCHAR(250),
			TypeOf NVARCHAR(250),
			SumPlanTime DECIMAL(28,8),
			SumActualTime DECIMAL(28,8)
	)
INSERT INTO @temp5 ( TypeData, Description, UserID, FullName, ProjectID, ValueID, ValueName
	                                ,PlanStartDate, PlanEndDate, PlanTime, ActualStartDate, ActualEndDate, ActualTime, PercentProgress, StatusName,StatusQualityOfWork, TypeOf,SumPlanTime, SumActualTime)
		SELECT
			 2 AS TypeData
		   , N''Vấn đề'' AS Description
		   , t1.UserID
		   , CONCAT(N''Họ và tên: '',O5.FullName) 
		   , CASE
				WHEN ISNULL(O6.ProjectName, '''') != '''' AND ISNULL(O2.ProjectID, '''') != ''''
					THEN CONCAT(O6.ProjectID, '' - '', O6.ProjectName)
				ELSE O2.ProjectID
				END 
			, O2.IssuesID
			, O2.IssuesName
			, O2.TimeRequest
			, O2.DeadlineRequest
			, NULL AS PlanTime
			, O2.ActualStartDate
			, O2.ActualEndDate
			, O2.ActualTime
			, O2. PercentProgress
			, O3.StatusName
			, (CASE WHEN [dbo].GetStatusQualityOfWork(O2.DeadlineRequest,O2.ActualEndDate,'''','''',O2.StatusID) = ''0'' THEN N''Ðạt'' 
					 WHEN [dbo].GetStatusQualityOfWork(O2.DeadlineRequest,O2.ActualEndDate,'''','''',O2.StatusID) = ''1'' THEN N''Không đạt''
					 ELSE N''''END) AS StatusQualityOfWork
			, O4.Description
			, NULL AS SumPlanTime
			, NULL AS SumActualTime
from @Temp t1 
--Van de
JOIN OOT2160 O2 on O2.AssignedToUserID = t1.UserID '+@sIssueTimeDetail+'
LEFT JOIN OOT2100 O6 ON O6.ProjectID = O2.ProjectID
LEFT JOIN AT1103  O5 ON O2.AssignedToUserID = O5.EmployeeID
LEFT JOIN OOT0099 O4 ON O4.ID = O2.TypeOfIssues AND O4.CodeMaster = N''OOF2160.TypeOfIssues''
JOIN OOT1040 O3 ON O2.StatusID = O3.StatusID 
WHERE DATEDIFF(DAY,O2.CREATEDATE,GETDATE()) >=5
ORDER BY t1.UserID ASC, O2.IssuesID ASC, O2.TimeRequest ASC
'
--Thêm dữ liệu chi tiet yêu cầu hỗ trợ vào bảng tạm
set @sInsertSRDetail = N'
DECLARE @temp6 AS TABLE (
	        TypeData INT,
			Description NVARCHAR(MAX),
			UserID VARCHAR(50),
			FullName NVARCHAR(MAX),
			ProjectID NVARCHAR(MAX),
			ValueID VARCHAR(50),
			ValueName NVARCHAR(MAX),
			PlanStartDate Datetime,
			PlanEndDate Datetime,
			PlanTime DECIMAL(28,8),
			ActualStartDate DATETIME,
			ActualEndDate DATETIME,
			ActualTime DECIMAL(28,8),
			PercentProgress DECIMAL(28,8),
			StatusName NVARCHAR(250),
			StatusQualityOfWork NVARCHAR(250),
			TypeOf NVARCHAR(250),
			SumPlanTime DECIMAL(28,8),
			SumActualTime DECIMAL(28,8)
	)
INSERT INTO @temp6  ( TypeData, Description, UserID, FullName, ProjectID, ValueID, ValueName
	                                ,PlanStartDate, PlanEndDate, PlanTime, ActualStartDate, ActualEndDate, ActualTime, PercentProgress, StatusName,StatusQualityOfWork, TypeOf,SumPlanTime, SumActualTime)
 
	SELECT  3 AS TypeData
		   , N''Yêu cầu hỗ trợ'' AS Description
		   , t1.UserID
		   , CONCAT(N''Họ và tên: '',O5.FullName ) 
		   , NULL AS ProjectID
		   , O2.SupportRequiredID
		   , O2.SupportRequiredName
		   , O2.TimeRequest
		   , O2.DeadlineRequest
		   , NULL AS PlanTime
		   , O2.ActualStartDate
		   , O2.ActualEndDate
		   , O2.ActualTime
		   , O2.PercentProgress
		   , O3.StatusName
		   , (CASE WHEN [dbo].GetStatusQualityOfWork(O2.DeadlineRequest,O2.ActualEndDate,'''',O2.AccountID,O2.StatusID) = ''0'' THEN N''Ðạt''
					 WHEN [dbo].GetStatusQualityOfWork(O2.DeadlineRequest,O2.ActualEndDate,'''',O2.AccountID,O2.StatusID) = ''1'' THEN N''Không đạt'' 
					 ELSE N''''END) AS StatusQualityOfWork
		   , O4.Description
		   , NULL AS SumPlanTime
		   , NULL AS SumActualTime
from @Temp t1
LEFT JOIN OOT2170 O2 on O2.AssignedToUserID = t1.UserID '+@sSRTimeDetail+'
LEFT JOIN AT1103  O5 ON O5.EmployeeID = O2.AssignedToUserID
LEFT JOIN OOT1040 O3  ON O3.StatusID = O2.StatusID
LEFT JOIN OOT0099 O4 WiTH (NOLOCK) ON O4.ID = O2.TypeOfRequest AND O4.CodeMaster = ''OOF2170.TypeOfRequest''
WHERE DATEDIFF(DAY,O2.CREATEDATE,GETDATE()) >=5
ORDER BY t1.UserID ASC, O2.SupportRequiredID ASC, O2.TimeRequest ASC
'
--Thêm vá select ra dữ liệu tổng hợp Detail
SET @sSQL=@sInsertUser +@sInsertTaskDetail+@sInsertIssueDetail+@sInsertSRDetail + ' 
	DECLARE @TableData AS TABLE (
	        TypeData INT,
			Description NVARCHAR(MAX),
			UserID VARCHAR(50),
			FullName NVARCHAR(MAX),
			ProjectID NVARCHAR(MAX),
			ValueID VARCHAR(50),
			ValueName NVARCHAR(MAX),
			PlanStartDate Datetime,
			PlanEndDate Datetime,
			PlanTime DECIMAL(28,8),
			ActualStartDate DATETIME,
			ActualEndDate DATETIME,
			ActualTime DECIMAL(28,8),
			PercentProgress DECIMAL(28,8),
			StatusName NVARCHAR(250),
			StatusQualityOfWork NVARCHAR(250),
			TypeOf NVARCHAR(250),
			SumPlanTime DECIMAL(28,8),
			SumActualTime DECIMAL(28,8)
	)
BEGIN
	INSERT INTO @TableData  (TypeData, Description, UserID, FullName, ProjectID, ValueID, ValueName
	                                ,PlanStartDate, PlanEndDate, PlanTime, ActualStartDate, ActualEndDate, ActualTime, PercentProgress, StatusName,StatusQualityOfWork, TypeOf,SumPlanTime, SumActualTime)
	
		SELECT * FROM @Temp4
		UNION ALL
		SELECT * FROM  @Temp5
		UNION ALL 
		SELECT * FROM  @Temp6

	INSERT INTO @TableData (TypeData, Description, UserID, PlanTime, ActualTime)
	SELECT  
		   0 AS TypeData
		  , NULL Description
	      , UserID AS UserID
		  , SUM(O2.PlanTime) AS PlanTime 
		  , SUM(O2.ActualTime) AS ActualTime
	FROM @TableData O2
	where TypeData = 1
	GROUP BY UserID 
	Order by UserID DESC

	SELECT *
	from @TableData
	' + @sSQLWhere +'
	Order by UserID ,ValueID 
END

'
PRINT (@sInsertUser)
PRINT (@sInsertTaskDetail)
PRINT (@sInsertIssueDetail)
--PRINT (@sInsertSRDetail)
--PRINT (@sSQL)
EXEC  (@sSQL)








GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
