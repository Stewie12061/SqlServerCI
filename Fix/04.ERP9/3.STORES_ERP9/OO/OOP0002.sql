IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP0002]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP0002]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load dữ liệu biểu đồ công việc cá nhân
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create ON 28/12/2020 by Đoàn Duy
-- <Example>exec OOP0002 @PageNumber=1,@PageSize=10,@TaskFactor=1,@IssueFactor=1,@MSFactor=1,@SRFactor=1,@RQFactor=1,@DivisionID=N'DTI',@UserList=N'ADMIN,ALISSON,ALVES,ASOFTADMIN,CASILLAS,CHIMTRANG,D11001,D16001,D21001,D26001,D26002,D31001,D31002,D31003,D31004,D31006,D31007,D31008,D31009,D36001,D41001,D41002,D46001,D51001,D51002,D51003,D51004,D51005,DGD001,DKS001,DQT001,JERRY,KIEN,LY,MESSI,MODRIC,NEUER,NGA,NGA002,RAMOS,RONALDO,SUPPORT,TANLOC',@PeriodIDList=N'12/2020'',''11/2020'',''01/2021'


CREATE PROCEDURE [dbo].[OOP0002] (
				@DivisionID			NVARCHAR(50),
				@PeriodIDList		NVARCHAR(2000),
				@UserList nvarchar(max),				
				@TaskFactor int, -- Hệ số cv
				@IssueFactor int, --Hệ số vd
				@MSFactor int, --Hệ số ms
				@RQFactor int, --Hệ số yc
				@SRFactor int, --Hệ số ht
				@PageNumber int,
				@PageSize int
				)
AS
BEGIN
	DECLARE @sSQL NVARCHAR(max),
		@sWhere NVARCHAR(max),
		@sTaskTime Nvarchar(Max),
		@sIssueTime Nvarchar(Max),
		@sMSTime Nvarchar(Max),
		@sRQTime Nvarchar(Max),
		@sSRTime Nvarchar(Max),
		@sConst Nvarchar(Max),
		@sInsertUser Nvarchar(Max),
		@sInsertTask Nvarchar(Max),
		@sInsertIssue Nvarchar(Max),
		@sInsertMS Nvarchar(Max),
		@sInsertRQ Nvarchar(Max),
		@sInsertSR Nvarchar(Max),
		@factorTotal INT
Set @factorTotal = 1
Set @sInsertUser = '
	DECLARE @Temp TABLE(
	UserID VARCHAR(50)
	)

INSERT INTO @Temp (UserID) 
SELECT 
    value  
FROM 
    StringSplit('''+@UserList+''','','')' 


Set @sWhere = ' and O2.DeleteFlg != 1 AND DivisionID in ('''+@DivisionID+''', ''@@@'') '+ ' group by t1.UserID
'

--Set điều kiên thời gianc ho công việc	
SET @sTaskTime = ' AND ((Case When  Month(O2.PlanStartDate) <10 then ''0''+rtrim(ltrim(str(Month(O2.PlanStartDate))))+''/''
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
					AND O2.StatusID not in (''TTCV0004'',''TTCV0003'',''TTCV0005'') '+@sWhere

--Set điều kiên thời gian cho vấn đề	
SET @sIssueTime = ' AND ((Case When  Month(O2.TimeRequest) <10 then ''0''+rtrim(ltrim(str(Month(O2.TimeRequest))))+''/''
										+ltrim(Rtrim(str(Year(O2.TimeRequest)))) Else rtrim(ltrim(str(Month(O2.TimeRequest))))+''/''
										+ltrim(Rtrim(str(Year(O2.TimeRequest)))) End) IN ('''+@PeriodIDList+''')
					OR (Case When  Month(O2.DeadlineRequest) <10 then ''0''+rtrim(ltrim(str(Month(O2.DeadlineRequest))))+''/''
										+ltrim(Rtrim(str(Year(O2.DeadlineRequest)))) Else rtrim(ltrim(str(Month(O2.DeadlineRequest))))+''/''
										+ltrim(Rtrim(str(Year(O2.DeadlineRequest)))) End) IN ('''+@PeriodIDList+'''))
					AND O2.StatusID not in (''TTIS0006'',''TTIS0004'') '+@sWhere

--Set điều kiên thời gian cho milestone
SET @sMSTime = ' AND ((Case When  Month(O2.TimeRequest) <10 then ''0''+rtrim(ltrim(str(Month(O2.TimeRequest))))+''/''
										+ltrim(Rtrim(str(Year(O2.TimeRequest)))) Else rtrim(ltrim(str(Month(O2.TimeRequest))))+''/''
										+ltrim(Rtrim(str(Year(O2.TimeRequest)))) End) IN ('''+@PeriodIDList+''')
					OR (Case When  Month(O2.DeadlineRequest) <10 then ''0''+rtrim(ltrim(str(Month(O2.DeadlineRequest))))+''/''
										+ltrim(Rtrim(str(Year(O2.DeadlineRequest)))) Else rtrim(ltrim(str(Month(O2.DeadlineRequest))))+''/''
										+ltrim(Rtrim(str(Year(O2.DeadlineRequest)))) End) IN ('''+@PeriodIDList+'''))
					AND O2.StatusID not in (''TTMS0004'', ''TTMS0006'') '+@sWhere

--Set điều kiên thời gian cho yêu cầu
SET @sRQTime = ' AND ((Case When  Month(O2.TimeRequest) <10 then ''0''+rtrim(ltrim(str(Month(O2.TimeRequest))))+''/''
										+ltrim(Rtrim(str(Year(O2.TimeRequest)))) Else rtrim(ltrim(str(Month(O2.TimeRequest))))+''/''
										+ltrim(Rtrim(str(Year(O2.TimeRequest)))) End) IN ('''+@PeriodIDList+''')
					OR (Case When  Month(O2.DeadlineRequest) <10 then ''0''+rtrim(ltrim(str(Month(O2.DeadlineRequest))))+''/''
										+ltrim(Rtrim(str(Year(O2.DeadlineRequest)))) Else rtrim(ltrim(str(Month(O2.DeadlineRequest))))+''/''
										+ltrim(Rtrim(str(Year(O2.DeadlineRequest)))) End) IN ('''+@PeriodIDList+'''))
					AND O2.RequestStatus not in (''5'',''3'') '+@sWhere

--Set điều kiên thời gian cho yêu cầu hỗ trợ
set @sSRTime = ' AND ((Case When  Month(O2.TimeRequest) <10 then ''0''+rtrim(ltrim(str(Month(O2.TimeRequest))))+''/''
										+ltrim(Rtrim(str(Year(O2.TimeRequest)))) Else rtrim(ltrim(str(Month(O2.TimeRequest))))+''/''
										+ltrim(Rtrim(str(Year(O2.TimeRequest)))) End) IN ('''+@PeriodIDList+''')
					OR (Case When  Month(O2.DeadlineRequest) <10 then ''0''+rtrim(ltrim(str(Month(O2.DeadlineRequest))))+''/''
										+ltrim(Rtrim(str(Year(O2.DeadlineRequest)))) Else rtrim(ltrim(str(Month(O2.DeadlineRequest))))+''/''
										+ltrim(Rtrim(str(Year(O2.DeadlineRequest)))) End) IN ('''+@PeriodIDList+'''))
					AND O2.StatusID not in (''TTRQ0006'',''TTRQ0004'') '+@sWhere

set @factorTotal = @TaskFactor + @IssueFactor + @MSFactor+ @RQFactor+ @SRFactor

--Tính tỉ lệ bình quân
set @sConst = CAST(@TaskFactor as varchar(10)) + '*( ISNULL(t1.OutDateRate, 0) + ' +
CAST(@IssueFactor as varchar(10)) +'* ISNULL(t2.OutDateRate, 0) + '+
CAST(@MSFactor as varchar(10)) +'* ISNULL(t3.OutDateRate, 0) + ' +
CAST(@RQFactor as varchar(10)) +'* ISNULL(t4.OutDateRate, 0) + ' +
CAST(@SRFactor as varchar(10)) +'* ISNULL(t5.OutDateRate, 0))/ ' + 
CAST(@factorTotal as varchar(10)) + ' * 100
'

--Thêm dữ liệu công việc vào bảng tạm
set @sInsertTask = '
DECLARE @Temp1 TABLE(
	 UserID VARCHAR(50),
	 TotalTask INT,
	 CompleteTask INT,
	 OutDateTask Int,
	 UnexcuteTask INT,
	 TotalHours INT,
     OutDateRate Decimal(10,4)
	)
INSERT INTO @Temp1 (UserID,TotalTask,
 CompleteTask ,
 OutDateTask ,
 UnexcuteTask,
 TotalHours,
 OutDateRate
 ) 
select t1.UserID,
		--Công việc
		COUNT(O2.APK) as TotalTask,
		COUNT(case when O2.StatusID = ''TTCV0002'' AND CONVERT(NVARCHAR(10), O2.PlanEndDate, 111) >= CONVERT(NVARCHAR(10), GETDATE(), 111) then 1 else null end) AS CompleteTask,
		COUNT(case when O2.StatusID != ''TTCV0007'' AND ISNULL(O2.PercentProgress, 0) < 100 AND CONVERT(NVARCHAR(10), O2.PlanEndDate, 111) < CONVERT(NVARCHAR(10), GETDATE(), 111) then 1 else null end) AS OutDateTask,
		COUNT(O2.APK) - COUNT(case when O2.StatusID=''TTCV0002'' AND CONVERT(NVARCHAR(10), O2.PlanEndDate, 111) >= CONVERT(NVARCHAR(10), GETDATE(), 111) then 1 else null end) -COUNT(case when O2.StatusID != ''TTCV0007'' AND ISNULL(O2.PercentProgress, 0) < 100 AND CONVERT(NVARCHAR(10), O2.PlanEndDate, 111) < CONVERT(NVARCHAR(10), GETDATE(), 111) then 1 else null end)  as UnexcuteTask,
		Sum (O2.PlanTime) as TotalHours,
		Sum (Case when ISNULL(O2.PercentProgress, 0) < 100 AND CONVERT(NVARCHAR(10), O2.PlanEndDate, 111) < CONVERT(NVARCHAR(10), GETDATE(), 111) then DateDIFF(hh, O2.PlanEndDate, GetDate()) else 0 end) /  (case when Sum (O2.PlanTime) = 0 then 1 else Sum (O2.PlanTime) end) as OutDateRate
from @Temp t1
--Công việc
JOIN OOT2110 O2 on O2.AssignedToUserID = t1.UserID ' + @sTaskTime

--Thêm dữ liệu vấn đề vào bảng tạm
set @sInsertIssue = '
DECLARE @Temp2 TABLE(
 UserID VARCHAR(50),
 TotalIssue INT,
 CompleteIssue INT,
 OutDateIssue Int,
 UnexcuteIssue INT,
 TotalHours INT,
 OutDateRate Decimal(10,4)
)
INSERT INTO @Temp2 (UserID,TotalIssue,
 CompleteIssue ,
 OutDateIssue ,
 UnexcuteIssue,
 TotalHours,
 OutDateRate ) 
select t1.UserID,
		--Vấn đề
		COUNT(O2.APK) as TotalIssue,
		COUNT(case when O2.StatusID = ''TTIS0002'' and O2.DeadlineRequest >= CONVERT(NVARCHAR(10), GETDATE(), 111) then 1 else null end) AS CompleteIssue,
		COUNT(case when O2.StatusID != ''TTIS0003'' AND O2.DeadlineRequest < CONVERT(NVARCHAR(10), GETDATE(), 111) then 1 else null end) AS OutDateIssue,
		COUNT(O2.APK) - COUNT(case when O2.StatusID = ''TTIS0002'' and O2.DeadlineRequest >= CONVERT(NVARCHAR(10), GETDATE(), 111) then 1 else null end) - COUNT(case when O2.StatusID != ''TTIS0003'' AND O2.DeadlineRequest < CONVERT(NVARCHAR(10), GETDATE(), 111) then 1 else null end)  as UnexcuteIssue,
		Sum (DateDIFF(s, O2.TimeRequest, O2.DeadlineRequest)/60/60) as TotalHours,
		Sum (case when O2.StatusID != ''TTIS0003'' AND O2.DeadlineRequest < CONVERT(NVARCHAR(10), GETDATE(), 111) then DateDIFF(s,O2.DeadlineRequest, GetDate())/60/60 else 0 end) / (case when Sum (DateDIFF(s, O2.TimeRequest, O2.DeadlineRequest)/60.0/60.0) = 0 then 1 else Sum (DateDIFF(s, O2.TimeRequest, O2.DeadlineRequest)/60.0/60.0) end) as OutDateRate
from @Temp t1
--Vấn đề
JOIN OOT2160 O2 on O2.AssignedToUserID = t1.UserID ' + @sIssueTime

--Thêm dữ liệu milestone vào bảng tạm
set @sInsertMS = '
DECLARE @Temp3 TABLE(
 UserID VARCHAR(50),
 TotalMS INT,
 CompleteMS INT,
 OutDateMS Int,
 UnexcuteMS INT,
 TotalHours INT,
 OutDateRate Decimal (10,4)
)
INSERT INTO @Temp3 ( 
  UserID ,
 TotalMS ,
 CompleteMS ,
 OutDateMS ,
 UnexcuteMS,
 TotalHours,
 OutDateRate ) 
select t1.UserID,
		COUNT(O2.APK) as TotalMS,
		COUNT(case when O2.StatusID = ''TTMS0002'' and O2.DeadlineRequest >= CONVERT(NVARCHAR(10), GETDATE(), 111) then 1 else null end) AS CompleteMS,
		COUNT(case when O2.StatusID != ''TTMS0003'' AND O2.DeadlineRequest < CONVERT(NVARCHAR(10), GETDATE(), 111) then 1 else null end) AS OutDateMS,
		COUNT(O2.APK) - COUNT(case when O2.StatusID = ''TTMS0002'' and O2.DeadlineRequest >= CONVERT(NVARCHAR(10), GETDATE(), 111) then 1 else null end) - COUNT(case when O2.StatusID != ''TTMS0003'' AND O2.DeadlineRequest < CONVERT(NVARCHAR(10), GETDATE(), 111) then 1 else null end)  as UnexcuteMS,
		Sum (DateDIFF(s, O2.TimeRequest,O2.DeadlineRequest)/60/60) as TotalHours,
		Sum (case when O2.StatusID != ''TTMS0003'' AND O2.DeadlineRequest < CONVERT(NVARCHAR(10), GETDATE(), 111) then DateDIFF(s, O2.DeadlineRequest, GetDate())/60/60 else 0 end) / (case when Sum (DateDIFF(s, O2.TimeRequest, O2.DeadlineRequest)/60.0/60.0) = 0 then 1 else Sum (DateDIFF(s, O2.TimeRequest, O2.DeadlineRequest)/60.0/60.0) end) as OutDateRate
from @Temp1 t1
JOIN OOT2190 O2 on O2.AssignedToUserID = t1.UserID ' + @sMSTime

--Thêm dữ liệu yêu cầu vào bảng tạm
set @sInsertRQ = '
DECLARE @Temp4 TABLE(
 UserID VARCHAR(50),
 TotalRQ INT,
 CompleteRQ INT,
 OutDateRQ Int,
 UnexcuteRQ INT,
 TotalHours INT,
 OutDateRate Decimal(10,4)
)
INSERT INTO @Temp4 ( 
  UserID ,
 TotalRQ ,
 CompleteRQ ,
 OutDateRQ ,
 UnexcuteRQ,
 TotalHours,
 OutDateRate ) 
select t1.UserID,
		COUNT(O2.APK) as Total,
		COUNT(case when O2.RequestStatus = ''2'' and O2.DeadlineRequest >= CONVERT(NVARCHAR(10), GETDATE(), 111) then 1 else null end) AS Complete,
		COUNT(case when O2.RequestStatus != ''4'' AND O2.DeadlineRequest < CONVERT(NVARCHAR(10), GETDATE(), 111) then 1 else null end) AS OutDate,
		COUNT(O2.APK) - COUNT(case when O2.RequestStatus = ''2'' and O2.DeadlineRequest >= CONVERT(NVARCHAR(10), GETDATE(), 111) then 1 else null end) - COUNT(case when O2.RequestStatus != ''4'' AND O2.DeadlineRequest < CONVERT(NVARCHAR(10), GETDATE(), 111) then 1 else null end)  as Unexcute,
		Sum (DateDIFF(s, O2.TimeRequest,O2.DeadlineRequest)/60/60) as TotalHours,
		Sum (case when O2.RequestStatus != ''4'' AND O2.DeadlineRequest < CONVERT(NVARCHAR(10), GETDATE(), 111) then DateDIFF(s, O2.DeadlineRequest, GetDate())/60/60 else 0 end) / (case when Sum (DateDIFF(s, O2.TimeRequest, O2.DeadlineRequest)/60.0/60.0) = 0 then 1 else Sum (DateDIFF(s, O2.TimeRequest, O2.DeadlineRequest)/60.0/60.0) end) as OutDateRate
from @Temp1 t1
JOIN CRMT20801 O2 on O2.AssignedToUserID = t1.UserID ' + @sRQTime

--Thêm dữ liệu yêu cầu hỗ trợ vào bảng tạm
set @sInsertSR = '
DECLARE @Temp5 TABLE(
 UserID VARCHAR(50),
 TotalSR INT,
 CompleteSR INT,
 OutDateSR Int,
 UnexcuteSR INT,
 TotalHours INT,
 OutDateRate Decimal(10,4)
)
INSERT INTO @Temp5 ( 
  UserID ,
 TotalSR ,
 CompleteSR ,
 OutDateSR ,
 UnexcuteSR,
 TotalHours,
 OutDateRate  ) 
select t1.UserID,
		COUNT(O2.APK) as Total,
		COUNT(case when O2.StatusID = ''TTRQ0002'' and  O2.DeadlineRequest >= CONVERT(NVARCHAR(10), GETDATE(), 111) then 1 else null end) AS Complete,
		COUNT(case when O2.StatusID != ''TTRQ0003'' AND O2.DeadlineRequest < CONVERT(NVARCHAR(10), GETDATE(), 111) then 1 else null end) AS OutDate,
		COUNT(O2.APK) - COUNT(case when O2.StatusID = ''TTRQ0002'' and  O2.DeadlineRequest >= CONVERT(NVARCHAR(10), GETDATE(), 111) then 1 else null end) - COUNT(case when O2.StatusID != ''TTRQ0003'' AND O2.DeadlineRequest < CONVERT(NVARCHAR(10), GETDATE(), 111) then 1 else null end)  as Unexcute,
		Sum (DateDIFF(s, O2.TimeRequest,O2.DeadlineRequest)/60/60) as TotalHours,
		Sum (case when O2.StatusID != ''TTRQ0003'' AND O2.DeadlineRequest < CONVERT(NVARCHAR(10), GETDATE(), 111) then DateDIFF(s, O2.DeadlineRequest, GetDate())/60/60 else 0 end) / (case when Sum (DateDIFF(s, O2.TimeRequest, O2.DeadlineRequest)/60.0/60.0) = 0 then 1 else Sum (DateDIFF(s, O2.TimeRequest, O2.DeadlineRequest)/60.0/60.0) end) as OutDateRate
from @Temp1 t1
JOIN OOT2170 O2 on O2.AssignedToUserID = t1.UserID '+ @sSRTime

--Thêm vá select ra dữ liệu tổng hợp
	SET @sSQL =@sInsertUser + @sInsertTask + @sInsertIssue + @sInsertMS + @sInsertRQ + @sInsertSR + '   
DECLARE @Temp6 TABLE(
 UserID VARCHAR(50),
 TotalTask INT,
 CompleteTask INT,
 OutDateTask Int,
 UnexcuteTask INT,
 TotalIssue INT,
 CompleteIssue INT,
 OutDateIssue Int,
 UnexcuteIssue INT,
 TotalMS INT,
 CompleteMS INT,
 OutDateMS Int,
 UnexcuteMS INT,
 TotalRQ INT,
 CompleteRQ INT,
 OutDateRQ Int,
 UnexcuteRQ INT,
 TotalSR INT,
 CompleteSR INT,
 OutDateSR INT,
 UnexcuteSR INT,
 OutDateTaskRate Decimal(10,4),
 OutDateIssueRate Decimal(10,4),
 OutDateMSRate Decimal(10,4),
 OutDateRQRate Decimal(10,4),
 OutDateSRRate Decimal(10,4),
 TotalHours INT,
 Const Decimal(10,2)
)
INSERT INTO @Temp6 ( 
 UserID ,
 TotalTask,
 CompleteTask,
 OutDateTask,
 UnexcuteTask,
 TotalIssue ,
 CompleteIssue ,
 OutDateIssue ,
 UnexcuteIssue ,
 TotalMS ,
 CompleteMS ,
 OutDateMS ,
 UnexcuteMS ,
 TotalRQ ,
 CompleteRQ ,
 OutDateRQ ,
 UnexcuteRQ,
 TotalSR ,
 CompleteSR ,
 OutDateSR ,
 UnexcuteSR,
 OutDateTaskRate,
 OutDateIssueRate,
 OutDateMSRate,
 OutDateRQRate,
 OutDateSRRate,
 TotalHours,
 Const ) 					
Select t.UserID, IsNull(t1.TotalTask, 0) as TotalTask, IsNull(t1.CompleteTask, 0) as CompleteTask, IsNull(t1.OutDateTask, 0) as OutDateTask, IsNull(t1.UnexcuteTask, 0) as UnexcuteTask
	,IsNull(t2.TotalIssue, 0) as TotalIssue,  IsNull(t2.CompleteIssue, 0) as CompleteIssue, IsNull(t2.OutDateIssue, 0) as OutDateIssue, IsNull(t2.UnexcuteIssue, 0) as UnexcuteIssue
	,IsNull(t3.TotalMS, 0) as TotalMS, IsNull(t3.CompleteMS, 0) as CompleteMS, IsNull(t3.OutDateMS, 0) as OutDateMS, IsNull(t3.UnexcuteMS, 0) as UnexcuteMS
	,IsNull(t4.TotalRQ, 0) as TotalRQ, IsNull(t4.CompleteRQ, 0) as CompleteRQ, IsNull(t4.OutDateRQ, 0) as OutDateRQ, IsNull(t4.UnexcuteRQ, 0) as UnexcuteRQ
	,IsNull(t5.TotalSR, 0) as TotalSR, IsNull(t5.CompleteSR, 0) as CompleteSR,IsNull(t5.OutDateSR, 0) as OutDateSR, IsNull(t5.UnexcuteSR, 0) as UnexcuteSR
	,IsNull(t1.OutDateRate, 0), IsNull(t2.OutDateRate, 0),IsNull(t3.OutDateRate, 0), IsNull(t4.OutDateRate, 0), IsNull(t5.OutDateRate, 0)
	,IsNull(t1.TotalHours, 0) + IsNull(t2.TotalHours, 0) + IsNull(t3.TotalHours, 0) + IsNull(t4.TotalHours, 0) + IsNull(t5.TotalHours, 0)
	,'+@sConst+' as Cosnt
from @Temp t
Full Outer join @Temp1 t1 on t1.UserID = t.UserID
Full Outer join @Temp2 t2 on t2.UserID = t.UserID
Full Outer join @Temp3 t3 on t3.UserID = t.UserID
Full Outer join @Temp4 t4 on t4.UserID = t.UserID
Full Outer join @Temp5 t5 on t5.UserID = t.UserID
--Group by t2.UserID
Where not (IsNull(t1.TotalTask, 0) = 0 AND IsNull(t2.TotalIssue, 0)=0 AND IsNull(t3.TotalMS, 0)=0 AND IsNull(t4.TotalRQ, 0)=0 AND IsNull(t5.TotalSR, 0)=0)
 
DECLARE @count INT
SELECT @count = COUNT(*) FROM @Temp6

IF @count > 1
	SELECT 0 as TempSort, @count + 1 AS TotalRow, ''AVG'' AS UserName, ''AVG'' AS UserID
	, Sum(TotalTask) as TotalTask  
	, Sum(CompleteTask) as CompleteTask  
	, Sum(OutDateTask) as OutDateTask  
	, Sum(UnexcuteTask) as UnexcuteTask  
	, Sum(TotalIssue) as TotalIssue  
	, Sum(CompleteIssue) as CompleteIssue  
	, Sum(OutDateIssue) as OutDateIssue  
	, Sum(UnexcuteIssue) as UnexcuteIssue  
	, Sum(TotalMS) as TotalMS  
	, Sum(CompleteMS) as CompleteMS  
	, Sum(OutDateMS) as OutDateMS  
	, Sum(UnexcuteMS) as UnexcuteMS  
	, Sum(TotalRQ) as TotalRQ  
	, Sum(CompleteRQ) as CompleteRQ  
	, Sum(OutDateRQ) as OutDateRQ  
	, Sum(UnexcuteRQ) as UnexcuteRQ  
	, Sum(TotalSR) as TotalSR  
	, Sum(CompleteSR) as CompleteSR  
	, Sum(OutDateSR) as OutDateSR  
	, Sum(UnexcuteSR) as UnexcuteSR  
	, Sum(OutDateTaskRate) / (case when @count = 0 then 1 else @count end) as OutDateTaskRate  
	, Sum(OutDateIssueRate) / (case when @count = 0 then 1 else @count end) as OutDateIssueRate  
	, Sum(OutDateMSRate) / (case when @count = 0 then 1 else @count end) as OutDateMSRate  
	, Sum(OutDateRQRate) / (case when @count = 0 then 1 else @count end) as OutDateRQRate  
	, Sum(OutDateSRRate) / (case when @count = 0 then 1 else @count end) as OutDateSRRate  
	, Sum(TotalHours) as TotalHours  
	, Sum(Const) / (case when @count = 0 then 1 else @count end) as Const  
	from @Temp6
	UNION
	Select * from 
	(SELECT DISTINCT 1 as TempSort, @count + 1 AS TotalRow, a1.UserName, t6.* from @Temp6 t6
	Join AT1405 a1 on a1.UserID = t6.UserID
	) as RES
	ORDER BY TempSort, Const DESC
	OFFSET ('+ CAST(@PageNumber as varchar(10))+' - 1) * '+CAST(@PageSize as varchar(10))+'  ROWS
	FETCH NEXT '+ CAST(@PageSize as varchar(10))+' ROWS ONLY 
ELSE
	SELECT DISTINCT @count AS TotalRow, a1.UserName, t6.* from @Temp6 t6
	Join AT1405 a1 on a1.UserID = t6.UserID
	Order by t6.Const DESC
	OFFSET ('+ CAST(@PageNumber as varchar(10))+' - 1) * '+CAST(@PageSize as varchar(10))+'  ROWS
	FETCH NEXT '+ CAST(@PageSize as varchar(10))+' ROWS ONLY 
'
	PRINT(@sInsertUser)
	PRINT (@sInsertTask)
	PRINT (@sInsertIssue)
	PRINT (@sInsertMS)
	PRINT (@sInsertRQ)
	PRINT (@sInsertSR)
	PRINT (@sSQL)
	EXEC (@sSQL)
	--PRINT (@sSQL)
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
