IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2241]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2241]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
--- Load form OOF2240 - Load Danh sách quản lí thiết bị
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Trần Đình Hoà ON 15/10/2020
----Update by: Đức Tuyên ON 20/07/2022 Bổ sung cho phép người theo dõi sử dụng
-- <Example>

CREATE PROCEDURE [dbo].[OOP2241]
(
	@DivisionID NVARCHAR(250),
	@DivisionIDList NVARCHAR(MAX),
	@BookingID NVARCHAR(250),
	@BookingUserID NVARCHAR(250),
	@UseUserID NVARCHAR(250),
	@EquipmentTypeID NVARCHAR(250),
	@EquipmentNameID NVARCHAR(250),
	@IsDate TINYINT,--0: theo ngày, 1: Theo kỳ
	@FromDate Datetime,
	@ToDate Datetime,
	@Period NVARCHAR(4000), --Chọn trong DropdownChecklist Chọn kỳ
	@Mode INT,							--1: Kanban, 2: List, 3: Gantt, 4: Calendar
	@UserID NVARCHAR(250),
	@ConditionTaskID VARCHAR(MAX),
	@PageNumber INT,
	@PageSize INT
)
AS
BEGIN
	DECLARE @sSQL NVARCHAR(MAX),
			@sSQL2 NVARCHAR(MAX),
			@sSQLPermission NVARCHAR(MAX),
			@sWhere NVARCHAR(MAX),
			@OrderBy NVARCHAR(500),
			@Confirmed NVARCHAR(50),
			@Tentative NVARCHAR(50),
			@FromDateText NVARCHAR(20),
			@ToDateText NVARCHAR(20)

	SET @sWhere = '' 
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 111)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 111) + ' 23:59:59'

	--Check Para DivisionIDList null then get DivisionID
	IF ISNULL(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + 'M.DivisionID IN (''' + @DivisionIDList + ''') AND ISNULL(M.DeleteFlg, 0) = 0'
	ELSE
		SET @sWhere = @sWhere + 'M.DivisionID = N''' + @DivisionID + ''' AND ISNULL(M.DeleteFlg, 0) = 0'

	-- Check Para FromDate và ToDate
	IF @IsDate = 1 
	BEGIN
		IF (ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + 'AND (M.PlanStartDate <= ''' + @ToDateText + '''
											OR M.PlanEndDate <= ''' + @ToDateText + ''' ) '
		END
		ELSE IF (ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') = '')
			 BEGIN
				SET @sWhere = @sWhere + 'AND (M.PlanStartDate >= ''' + @FromDateText + '''
											OR M.PlanEndDate >= ''' + @FromDateText + ''' ) '
			 END
		ELSE IF (ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
			BEGIN
				SET @sWhere = @sWhere + 'AND (M.PlanStartDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + '''
										OR M.PlanEndDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''' ) '
			END
	END

	-- Check Para Period
	IF @IsDate = 0 
	BEGIN
		IF ISNULL(@Period, '') != ''
		SET @sWhere = @sWhere + ' AND (CASE WHEN MONTH(M.PlanStartDate) <10 THEN ''0''+rtrim(ltrim(str(MONTH(M.PlanStartDate))))+''/''+ltrim(Rtrim(str(YEAR(M.PlanStartDate)))) 
					ELSE rtrim(ltrim(str(MONTH(M.PlanStartDate))))+''/''+ltrim(Rtrim(str(YEAR(M.PlanStartDate)))) END) in ('''+@Period +''')'
	END

	IF ISNULL(@BookingID, '') != ''
		SET @sWhere = @sWhere + ' AND (M.BookingID LIKE N''%' + @BookingID + '%'' OR M.BookingName LIKE N''%' + @BookingID + '%'') '

	IF ISNULL(@BookingUserID, '') != ''
		SET @sWhere = @sWhere + ' AND (O03_1.FullName LIKE N''%' + @BookingUserID + '%'' OR M.BookingUserID LIKE N''%' + @BookingUserID + '%'') '

	IF ISNULL(@UseUserID, '') != ''
		SET @sWhere = @sWhere + ' AND (O03_2.FullName LIKE N''%' + @UseUserID + '%'' OR M.UseUserID LIKE N''%' + @UseUserID + '%'') '

	IF ISNULL(@EquipmentTypeID, '') != ''
		SET @sWhere = @sWhere + ' AND (O99.Description LIKE N''%' + @EquipmentTypeID + '%'' OR M.EquipmentTypeID LIKE N''%' + @EquipmentTypeID + '%'') '

	IF ISNULL(@EquipmentNameID, '') != ''
		SET @sWhere = @sWhere + ' AND (O90.DeviceName LIKE N''%' + @EquipmentNameID + '%'' OR M.EquipmentNameID LIKE N''%' + @EquipmentNameID + '%'') '


	SET @Confirmed = N'Xác nhận đặt'
	SET @Tentative = N'Dự định đặt'

	SET @OrderBy = N' M.CreateDate DESC, M.BookingID DESC'

	SET @sSQL = N' SELECT M.*, O03_1.FullName AS BookingUserName, O03_2.FullName AS UseUserName, 
						O99.Description AS EquipmentTypeName, O90.DeviceName AS EquipmentName, CASE WHEN M.BookingStatus = 0 THEN N''' + @Confirmed + ''' ELSE N''' + @Tentative + ''' END AS BookingStatusName, 
						(SELECT COUNT(*) FROM OOT9020 OT90 WITH (NOLOCK) WHERE OT90.TableID = ''OOT2240'' 
							AND M.APK = OT90.APKMaster 
							AND ''' + @UserID + ''' IN (OT90.FollowerID01, OT90.FollowerID02, OT90.FollowerID03, OT90.FollowerID04, OT90.FollowerID05
														, OT90.FollowerID06, OT90.FollowerID07, OT90.FollowerID08, OT90.FollowerID09, OT90.FollowerID10
														, OT90.FollowerID11, OT90.FollowerID12, OT90.FollowerID13, OT90.FollowerID14, OT90.FollowerID15
														, OT90.FollowerID16, OT90.FollowerID17, OT90.FollowerID18, OT90.FollowerID19, OT90.FollowerID20)
						) AS IsAllowedDetails 
					INTO #TempOOT2240
					FROM OOT2240 M WITH (NOLOCK)
						LEFT JOIN AT1103 O03_1 ON M.BookingUserID = O03_1.EmployeeID
						LEFT JOIN AT1103 O03_2 ON M.UseUserID = O03_2.EmployeeID
						LEFT JOIN OOT0099 O99 ON M.EquipmentTypeID = O99.ID
						LEFT JOIN OOT1090 O90 ON M.EquipmentNameID = O90.DeviceID
					WHERE ' + @sWhere + ''

	SET @sSQL2 = N'DECLARE @count INT
				SELECT @count = COUNT(BookingID) FROM #TempOOT2240
				SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow, M.*					
				FROM #TempOOT2240 M
				ORDER BY ' + @OrderBy + '
				OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
				FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
	EXEC (@sSQL + @sSQL2)
	PRINT (@sSQL)
	PRINT (@sSQL2)
			
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
