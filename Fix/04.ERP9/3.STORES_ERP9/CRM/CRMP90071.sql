IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP90071]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP90071]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
-- Load dữ liệu màn hình calendar
-- Luu ý: Hiển thị calendar dang xử lý co bản nếu thỏa điều kiện DivisionID và thời gian load dữ liệu sự kiện và nhiệm vụ lên lịch
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by Phan thanh hoàng vu, Date 05/04/2017
-- Edited by Thị Phụng, Date 21/04/2017: Lấy dữ liệu từ 1 bảng CRMT90051
-- Edited by Phan thanh hoàng vu, Date 05/05/2017: Bổ sung điều kiện search phân quyền xem
-- Edited by Thị Phụng, Date 02/06/2017: Lấy dữ liệu từ Tình trạng sự kiện or Nhiệm vụ
-- Edited by Trường Lãm, Date 11/07/2019: Bổ sung load dữ liệu công việc lên màn hình Lịch
-- Edited by Đình Hoà, Date 15/10/2020: Bổ sung load dữ liệu quản lí thiết bị lên màn hình Lịch
-- Edited by Đình Ly, Date 22/10/2020: Xử lý lọc dữ liệu cho Calendar theo điều kiện lọc.
-- Edited by Kiều Nga, Date 29/09/2023: [2023/09/IS/0129] Xử lý lấy lại dữ liệu ConditionEventID khi ConditionEventID null.
-- Edited by Thu Hà, Date 06/10/2023: Bổ sung load dữ liệu Lịch phỏng vấn lên màn hình Lịch
-- <Example> EXEC CRMP90071 'AS', 3, '2017-04-05 00:00:00.000', '2017-04-30 00:00:00.000', 4, 2017, '', N'ASOFTADMIN'', ''DANH'', ''HOANG'', ''HUYEN'', ''LIEN'', ''LUAN'', ''PHUONG'', ''QUI'', ''QUYNH'', ''VU'

CREATE PROCEDURE [dbo].[CRMP90071] 
( 
	@DivisionID VARCHAR(50), --Biến môi trường
	@IsDate int, 			--1: Ngày, 2: Tuần; 3: Tháng
	@FromDate datetime,
	@ToDate datetime,
	@TranMonth int,
	@TranYear int,
	@UserID VARCHAR(50),
	@ConditionEventID NVARCHAR(max),
	@CalendarBusiness VARCHAR(250)
) 
AS 
BEGIN
	DECLARE @sWhere NVARCHAR(MAX),
			@sWhere2 NVARCHAR(MAX),
			@sWhere3 NVARCHAR(MAX),
			@sWhere4 NVARCHAR(MAX),
			@sSQL NVARCHAR(MAX),
			@sSQL1 NVARCHAR(MAX),
			@sSQL2 NVARCHAR(MAX),
			@sSQL3 NVARCHAR(MAX),
			@sSQL4 NVARCHAR(MAX),
			@sUni1 VARCHAR(25) = '',
			@sUni2 VARCHAR(25) = '',
			@sUni3 VARCHAR(25) = '',
			@sUni4 VARCHAR(25) = '',
			@sStatusConfirmed NVARCHAR(50),
			@sStatusTentative NVARCHAR(50),
			@sStatusInterviewConfirmed NVARCHAR(50),
			@sStatusRefusedInterviewed NVARCHAR(50)

	Set @sWhere = ' '
	--Check Para DivisionIDList null then get DivisionID 
	IF ISNULL(@DivisionID, '') != ''
		SET @sWhere = @sWhere + ' M.DivisionID = N''' + @DivisionID + ''''
	
	IF @IsDate = 1 
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10), M.EventStartDate, 112) = ' + CONVERT(VARCHAR(10), @FromDate, 112) + ' '

	IF @IsDate = 2 
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10), M.EventStartDate, 112) BETWEEN ' + CONVERT(VARCHAR(10), @FromDate, 112) + ' AND ' + CONVERT(VARCHAR(10), @ToDate, 112) + ' '
	
	IF @IsDate = 3 
		SET @sWhere = @sWhere + ' AND Year(M.EventStartDate) = ' + STR(@TranYear) + ' AND MONTH(M.EventStartDate) = ' + STR(@TranMONTH) + ' '
	

	Set @sWhere2 = ' '
	--Check Para DivisionIDList null then get DivisionID 
	IF ISNULL(@DivisionID, '') != ''
		SET @sWhere2 = @sWhere2 + ' K.DivisionID = N''' + @DivisionID + ''''
	
	IF @IsDate = 1 
		SET @sWhere2 = @sWhere2 + ' AND CONVERT(VARCHAR(10), K.PlanStartDate, 112) = ' + CONVERT(VARCHAR(10), @FromDate, 112) + ' '

	IF @IsDate = 2 
		SET @sWhere2 = @sWhere2 + ' AND CONVERT(VARCHAR(10), K.PlanStartDate, 112) BETWEEN ' + CONVERT(VARCHAR(10), @FromDate, 112) + ' AND ' + CONVERT(VARCHAR(10), @ToDate, 112) + ' '
	
	IF @IsDate = 3 
		SET @sWhere2 = @sWhere2 + ' AND Year(K.PlanStartDate) = '+STR(@TranYear)+' AND month(K.PlanStartDate) = '+STR(@TranMonth)+' AND (K.DeleteFlg = 0 OR K.DeleteFlg IS NULL)'
	
	IF ISNULL(@ConditionEventID, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND ISNULL(B.UserID, M.CreateUserID) in (N''' + @ConditionEventID + ''' )'
		SET @sWhere2 = @sWhere2 + ' AND ISNULL(K.AssignedToUserID, K.CreateUserID) in (N'''+@ConditionEventID+''' )'
	END
	ELSE
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[ConditionEventID_CRMP90071]') AND TYPE IN (N'U'))
		BEGIN
			CREATE TABLE ConditionEventID_CRMP90071(
			DateType NVARCHAR (50),
			Condition NVARCHAR (MAX))
		END

		DELETE FROM ConditionEventID_CRMP90071

		INSERT INTO ConditionEventID_CRMP90071
		exec SP10506 @DivisionID=@DivisionID,@UserID=@UserID,@ListDataID=N'<Data><DataID>EventID</DataID></Data>'

		DECLARE @EventID NVARCHAR(MAX) = (SELECT TOP 1 Condition FROM ConditionEventID_CRMP90071)

		IF ISNULL(@EventID, '') != ''
		BEGIN
			SET @sWhere = @sWhere + ' AND ISNULL(B.UserID, M.CreateUserID) in (SELECT value from dbo.StringSplit('''+@EventID+''','',''))'
			SET @sWhere2 = @sWhere2 + ' AND ISNULL(K.AssignedToUserID, K.CreateUserID) in (SELECT value from dbo.StringSplit('''+@EventID+''','',''))'
		END
	END

    Set @sWhere3 = ' '
	--Check Para DivisionIDList null then get DivisionID 
	IF ISNULL(@DivisionID, '') != ''
		SET @sWhere3 = @sWhere3 + ' O40.DivisionID = N''' + @DivisionID + ''''
	
	IF @IsDate = 1 
		SET @sWhere3 = @sWhere3 + ' AND CONVERT(VARCHAR(10), O40.PlanStartDate, 112) = ' + CONVERT(VARCHAR(10), @FromDate, 112) + ' '

	IF @IsDate = 2 
		SET @sWhere3 = @sWhere3 + ' AND CONVERT(VARCHAR(10), O40.PlanStartDate, 112) BETWEEN ' + CONVERT(VARCHAR(10), @FromDate, 112) + ' AND ' + CONVERT(VARCHAR(10), @ToDate, 112) + ' '
	
	IF @IsDate = 3 
		SET @sWhere3 = @sWhere3 + ' AND Year(O40.PlanStartDate) = '+STR(@TranYear)+' AND month(O40.PlanStartDate) = '+STR(@TranMonth)+' AND (O40.DeleteFlg = 0 OR O40.DeleteFlg IS NULL)'
	 
	 Set @sWhere4 = ' '
	--Check Para DivisionIDList null then get DivisionID 
	IF ISNULL(@DivisionID, '') != ''
		SET @sWhere4 = @sWhere4 + ' HRMT2030.DivisionID = N''' + @DivisionID + '''' 
	
	IF @IsDate = 1 
		SET @sWhere4 = @sWhere4 + ' AND CONVERT(VARCHAR(10), HRMT2031.InterviewDate, 112) = ' + CONVERT(VARCHAR(10), @FromDate, 112) + ' '

	IF @IsDate = 2 
		SET @sWhere4 = @sWhere4 + ' AND CONVERT(VARCHAR(10), HRMT2031.InterviewDate, 112) BETWEEN ' + CONVERT(VARCHAR(10), @FromDate, 112) + ' AND ' + CONVERT(VARCHAR(10), @ToDate, 112) + ' '
	
	IF @IsDate = 3 
		SET @sWhere4 = @sWhere4 + ' AND Year(HRMT2031.InterviewDate) = '+STR(@TranYear)+' AND month(HRMT2031.InterviewDate) = '+STR(@TranMonth)+' AND HRMT2031.ConfirmID=1'
		----AND (O40.DeleteFlg = 0 OR O40.DeleteFlg IS NULL)'
	-- Load dữ liệu nghiệp vụ Sự kiện.
	IF(CHARINDEX('1',@CalendarBusiness) > 0)
		BEGIN
			SET @sSQL1 = '
						SELECT Distinct M.APK, M.DivisionID, M.EventID AS ID, M.EventSubject AS Title, M.EventStatus
								, M.EventStartDate AS Start, M.EventEndDate AS [End]
								, CASE WHEN DATEPART(hour, M.EventStartDate) <10 THEN ''0'' + RTRIM(LTRIM(STR(cast(DATEPART(hour, M.EventStartDate) AS VARCHAR))))
									ELSE RTRIM(LTRIM(STR(cast(DATEPART(hour, M.EventStartDate) AS VARCHAR)))) END
									 + '':'' + 
									CASE WHEN DATEPART(MINUTE, M.EventStartDate) <10 THEN ''0'' + RTRIM(LTRIM(STR(cast(DATEPART(MINUTE, M.EventStartDate) AS VARCHAR))))
									ELSE RTRIM(LTRIM(STR(cast(DATEPART(MINUTE, M.EventStartDate) AS VARCHAR)))) END AS StartHour
								, CASE WHEN DATEPART(hour, M.EventEndDate) <10 THEN ''0'' + RTRIM(LTRIM(STR(cast(DATEPART(hour, M.EventEndDate) AS VARCHAR))))
									ELSE RTRIM(LTRIM(STR(cast(DATEPART(hour, M.EventEndDate) AS VARCHAR)))) END
									 + '':'' + 
									CASE WHEN DATEPART(MINUTE, M.EventEndDate) <10 THEN ''0'' + RTRIM(LTRIM(STR(cast(DATEPART(MINUTE, M.EventEndDate) AS VARCHAR))))
									ELSE RTRIM(LTRIM(STR(cast(DATEPART(MINUTE, M.EventEndDate) AS VARCHAR)))) END AS EndHour
								, N''CRMT90051'' AS TableID
								, M.TypeID AS RelatedToTypeID
								, CASE WHEN TypeID = 1 then D.Description
									ELSE c.Description end AS StatusName
								, ''#ffba4b'' AS Color, M.CreateUserID, M.AssignedToUserID
						 FROM CRMT90051 M WITH(NOLOCK) 
							INNER JOIN CRMT0099 D WITH(NOLOCK)  ON M.EventStatus = D.ID and D.CodeMaster = ''CRMT00000017''
							LEFT JOIN CRMT0099 C WITH(NOLOCK)  ON C.ID = M.EventStatus and C.CodeMaster = ''CRMT00000003''
							LEFT JOIN AT1103_REL B WITH (NOLOCK) ON B.RelatedToID = CONVERT(VARCHAR(50), M.EventID)
						 WHERE ' + @sWhere + ''
		END

	-- Load dữ liệu nghiệp vụ Công việc.
	IF(CHARINDEX('2',@CalendarBusiness) > 0)
		BEGIN				
			SET @sSQL2 = '
						SELECT Distinct K.APK, K.DivisionID, NULL AS ID, K.TaskName AS Title, 3 AS EventStatus
							, K.PlanStartDate AS Start, K.PlanEndDate AS [End]
							, CASE WHEN DATEPART(hour, K.PlanStartDate) <10 THEN ''0'' + RTRIM(LTRIM(STR(cast(DATEPART(hour, K.PlanStartDate) AS VARCHAR))))
									ELSE RTRIM(LTRIM(STR(cast(DATEPART(hour, K.PlanStartDate) AS VARCHAR)))) END
									 + '':'' + 
									CASE WHEN DATEPART(MINUTE, K.PlanStartDate) < 10 THEN ''0'' + RTRIM(LTRIM(STR(cast(DATEPART(MINUTE, K.PlanStartDate) AS VARCHAR))))
									ELSE RTRIM(LTRIM(STR(cast(DATEPART(MINUTE, K.PlanStartDate) AS VARCHAR)))) END AS StartHour
							, CASE WHEN DATEPART(hour, K.PlanEndDate) <10 THEN ''0'' + RTRIM(LTRIM(STR(cast(DATEPART(hour, K.PlanEndDate) AS VARCHAR))))
									ELSE RTRIM(LTRIM(STR(cast(DATEPART(hour, K.PlanEndDate) AS VARCHAR)))) END
									 + '':'' + 
									CASE WHEN DATEPART(MINUTE, K.PlanEndDate) < 10 THEN ''0'' + RTRIM(LTRIM(STR(cast(DATEPART(MINUTE, K.PlanEndDate) AS VARCHAR))))
									ELSE RTRIM(LTRIM(STR(cast(DATEPART(MINUTE, K.PlanEndDate) AS VARCHAR)))) END AS EndHour
							, N''OOT2110'' AS TableID
							, 3 AS RelatedToTypeID, ISNULL(O1.StatusName, K.StatusID) AS StatusName
							, O1.Color, K.CreateUserID, K.AssignedToUserID
							FROM OOT2110 K WITH(NOLOCK)
								LEFT JOIN OOT1040 O1 WITH(NOLOCK) ON K.StatusID = O1.StatusID AND ISNULL(O1.Disabled, 0) = 0 AND ISNULL(O1.DivisionID, 0) IN (''' + @DivisionID + ''', ''@@@'') AND O1.StatusType = 1
							WHERE ' + @sWhere2 + ''
		END

	-- Load dữ liệu cho nghiệp vụ Thiết bị.
	IF(CHARINDEX('3', @CalendarBusiness) > 0)
		BEGIN
			SET @sStatusConfirmed = N'Xác nhận đặt'
			SET @sStatusTentative = N'Dự định đặt'
			SET @sSQL3 = '
						SELECT Distinct O40.APK, O40.DivisionID, NULL AS ID, O40.BookingName AS Title, 3 AS EventStatus
							, O40.PlanStartDate AS Start, O40.PlanEndDate AS [End]
							, CASE WHEN DATEPART(hour, O40.PlanStartDate) <10 THEN ''0'' + RTRIM(LTRIM(STR(cast(DATEPART(hour, O40.PlanStartDate) AS VARCHAR))))
									ELSE RTRIM(LTRIM(STR(cast(DATEPART(hour, O40.PlanStartDate) AS VARCHAR)))) END
									 + '':'' + 
									CASE WHEN DATEPART(MINUTE, O40.PlanStartDate) < 10 THEN ''0'' + RTRIM(LTRIM(STR(cast(DATEPART(MINUTE, O40.PlanStartDate) AS VARCHAR))))
									ELSE RTRIM(LTRIM(STR(cast(DATEPART(MINUTE, O40.PlanStartDate) AS VARCHAR)))) END AS StartHour
							, CASE WHEN DATEPART(hour, O40.PlanEndDate) <10 THEN ''0'' + RTRIM(LTRIM(STR(cast(DATEPART(hour, O40.PlanEndDate) AS VARCHAR))))
									ELSE RTRIM(LTRIM(STR(cast(DATEPART(hour, O40.PlanEndDate) AS VARCHAR)))) END
									 + '':'' + 
									CASE WHEN DATEPART(MINUTE, O40.PlanEndDate) < 10 THEN ''0'' + RTRIM(LTRIM(STR(cast(DATEPART(MINUTE, O40.PlanEndDate) AS VARCHAR))))
									ELSE RTRIM(LTRIM(STR(cast(DATEPART(MINUTE, O40.PlanEndDate) AS VARCHAR)))) END AS EndHour
							, N''OOT2240'' AS TableID
							, 4 AS RelatedToTypeID, CASE WHEN O40.BookingStatus = 0 THEN N''' +@sStatusConfirmed + ''' ELSE N''' +@sStatusTentative +''' END AS StatusName
							, CASE 
								WHEN O40.BookingStatus <= 0 THEN O1.Color
								ELSE O2.Color END AS Color, O40.BookingUserID AS CreateUserID, O40.UseUserID AS AssignedToUserID
							FROM OOT2240 O40
								LEFT JOIN OOT1040 O1 WITH(NOLOCK) ON O1.StatusID = ''DTB0001'' AND ISNULL(O1.Disabled, 0) = 0 AND ISNULL(O1.DivisionID, 0) IN (''' + @DivisionID + ''', ''@@@'')
								LEFT JOIN OOT1040 O2 WITH(NOLOCK) ON O2.StatusID = ''DTB0002'' AND ISNULL(O2.Disabled, 0) = 0 AND ISNULL(O2.DivisionID, 0) IN (''' + @DivisionID + ''', ''@@@'')
							WHERE ' + @sWhere3 + ''
		END
	-- Load dữ liệu cho nghiệp vụ Lịch phỏng vấn.
	IF(CHARINDEX('4', @CalendarBusiness) > 0)
		BEGIN
			SET @sStatusInterviewConfirmed = N'Xác nhận phỏng vấn'
			SET @sStatusRefusedInterviewed = N'Từ chối phỏng vấn'
			SET @sSQL4 = '
						SELECT DISTINCT  
						HRMT2030.APK , 
						HRMT2030.DivisionID,
						NULL AS ID,
						HRMT2030.Description AS Title,3 AS EventStatus
								, HRMT2031.InterviewDate  AS Start, HRMT2031.InterviewDate AS [End]
								, CASE WHEN DATEPART(hour, HRMT2031.InterviewDate) <10 THEN ''0'' + RTRIM(LTRIM(STR(cast(DATEPART(hour, HRMT2031.InterviewDate) AS VARCHAR))))
									ELSE RTRIM(LTRIM(STR(cast(DATEPART(hour, HRMT2031.InterviewDate) AS VARCHAR)))) END
									 + '':'' + 
									CASE WHEN DATEPART(MINUTE, HRMT2031.InterviewDate) <10 THEN ''0'' + RTRIM(LTRIM(STR(cast(DATEPART(MINUTE, HRMT2031.InterviewDate) AS VARCHAR))))
									ELSE RTRIM(LTRIM(STR(cast(DATEPART(MINUTE, HRMT2031.InterviewDate) AS VARCHAR)))) END AS StartHour
								, CASE WHEN DATEPART(hour, HRMT2031.InterviewDate) <10 THEN ''0'' + RTRIM(LTRIM(STR(cast(DATEPART(hour, HRMT2031.InterviewDate) AS VARCHAR))))
									ELSE RTRIM(LTRIM(STR(cast(DATEPART(hour, HRMT2031.InterviewDate) AS VARCHAR)))) END
									 + '':'' + 
									CASE WHEN DATEPART(MINUTE, HRMT2031.InterviewDate) <10 THEN ''0'' + RTRIM(LTRIM(STR(cast(DATEPART(MINUTE, HRMT2031.InterviewDate) AS VARCHAR))))
									ELSE RTRIM(LTRIM(STR(cast(DATEPART(MINUTE, HRMT2031.InterviewDate) AS VARCHAR)))) END AS EndHour
								, N''HRMT2030'' AS TableID
								, 5 AS RelatedToTypeID
								, CASE WHEN HRMT2031.ConfirmID = 1 THEN N''' +@sStatusInterviewConfirmed + ''' ELSE N''' +@sStatusRefusedInterviewed + ''' END AS StatusName
								, CASE WHEN HRMT2031.ConfirmID > 0 THEN ''#C7744B'' ELSE ''#FFE0F7'' END AS Color
								,HRMT2030.CreateUserID,HRMT2030.AssignedToUserID
						 FROM HRMT2030 WITH (NOLOCK)
								LEFT JOIN HRMT2031 WITH (NOLOCK) ON HRMT2030.DivisionID = HRMT2031.DivisionID AND HRMT2030.APK = HRMT2031.InterviewScheduleID
							WHERE ' + @sWhere4 + ''
		END

	IF(CHARINDEX('1',@CalendarBusiness) > 0 AND CHARINDEX('2',@CalendarBusiness) > 0)
	BEGIN
		SET @sUni2 = ' UNION ALL '
	END

	IF((CHARINDEX('1',@CalendarBusiness) > 0 OR CHARINDEX('2',@CalendarBusiness) > 0) AND CHARINDEX('3',@CalendarBusiness) > 0)
	BEGIN
		SET @sUni3 = ' UNION ALL '
	END
	IF ((CHARINDEX('1', @CalendarBusiness) > 0 OR CHARINDEX('2', @CalendarBusiness) > 0 OR  CHARINDEX('3', @CalendarBusiness) > 0) AND   CHARINDEX('4', @CalendarBusiness) > 0)
	BEGIN
		SET @sUni4 = ' UNION ALL '
	END		


			PRINT (@sSQL1)
			PRINT (@sUni1)
			PRINT (@sUni2)
			PRINT (@sSQL2)
			PRINT (@sUni3)
			PRINT (@sSQL3)
			PRINT (@sUni4)
			PRINT (@sSQL4)
			EXEC (@sUni1 + @sSQL1 + @sUni2 + @sSQL2 + @sUni3 + @sSQL3 + @sUni4 + @sSQL4)
END	





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
