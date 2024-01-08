IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2180]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2180]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load grid danh mục lịch sử cuộc gọi
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 29/11/2019 by Tấn Lộc
----Modified on 04/06/2021 by Hoài Bảo : Mapping với bảng đầu mối theo sđt để lấy APKLead và LeadName
----Modified on 03/07/2021 by Hoài Bảo : Chỉnh sửa mapping với bảng đầu mối thông qua LeadID
----Modified on 08/07/2021 by Hoài Bảo : Đổi tên cho cột Liên hệ/Đầu mối
----Modified on 22/07/2021 by Hoài Bảo : Thay thế join với bảng khách hàng POST0011 thay cho AT1202 (bảng tổng hợp bao gồm khách hàng và đối tượng) để lấy APK cho đường dẫn vào chi tiết khách hàng.
----Modified on 07/01/2022 by Anh Tuấn : Bổ sung điều kiện lọc theo kỳ
----Modified on 10/01/2023 by Hoài Thanh : Bổ sung luồng load dữ liệu từ dashboard.
----Modified on 09/02/2023 by Hoài Bảo : Bổ sung luồng load dữ liệu từ màn hình truy vấn ngược

CREATE PROCEDURE [dbo].[OOP2180]
( 
	 @DivisionID VARCHAR(50) = '',
	 @DivisionIDList NVARCHAR(MAX) = '',
	 @FromDate DATETIME = NULL,
	 @ToDate DATETIME = NULL,
	 @DID NVARCHAR(250) = '',
	 @Source NVARCHAR(250) = '',
	 @Destination NVARCHAR(250) = '',
	 @StatusID NVARCHAR(250) = '',
	 @Duration INT = 100,
	 @TypeOfCall NVARCHAR(250) = '',
	 @RequestStatus NVARCHAR(250) = '',
	 @Extend NVARCHAR(250) = '',
	 @AccountID NVARCHAR(50) = '',
	 @ContactID NVARCHAR(50) = '',
	 @ConditionCallsHistory VARCHAR(MAX) = '',
	 @IsCommon NVARCHAR(100) = '', 
	 @Disabled NVARCHAR(100) = '',
	 @UserID VARCHAR(50) = '', 
	 @PageNumber INT = 1,
	 @PageSize INT = 25,
	 @IsDate TINYINT = 0,--1: theo ngày, 0: Theo kỳ
	 @Period NVARCHAR(4000) = '', --Chọn trong DropdownChecklist Chọn kỳ
	 @Type INT = 2, -- Type = 6: từ dashboard -> danh mục
	 @IsSuccess INT = 0, --1: số cuộc gọi thành công
	 @RelAPK NVARCHAR(250) = '',
	 @RelTable NVARCHAR(250) = ''
)
AS 
	DECLARE @sSQL NVARCHAR (MAX) = N'',
     		@OrderBy NVARCHAR(MAX) = N'', 
			@TotalRow NVARCHAR(50) = N'',
			@sWhere NVARCHAR(MAX),
			@sWhere1 NVARCHAR(MAX),
			@sWhereDashboard NVARCHAR(MAX) = '',
			@sSQLPermission NVARCHAR(MAX),
			@FromDateText NVARCHAR(20),
			@ToDateText NVARCHAR(20),
			@WhereDivision NVARCHAR(MAX)

	SET @OrderBy = 'M.CallDate DESC'
	SET @sWhere = ''
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 111)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 111) + ' 23:59:59'

	-- Check Para DivisionIDList null then get DivisionID
	IF ISNULL(@DivisionIDList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' M.DivisionID IN (''' + @DivisionIDList + ''',''@@@'')'
		SET @sWhereDashboard = @sWhereDashboard + ' M.DivisionID IN (''' + @DivisionIDList + ''',''@@@'')'
		SET @WhereDivision = @DivisionIDList
	END
	ELSE
	BEGIN
		SET @sWhere = @sWhere + ' M.DivisionID IN (''' + @DivisionID + ''', ''@@@'')'
		SET @WhereDivision = @DivisionID
	END

	SET @sWhere = @sWhere + ' AND ISNULL(M.DeleteFlg, 0) = 0'
	SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(M.DeleteFlg, 0) = 0'

	-- Check Para FromDate và ToDate
	IF @IsDate = 1 
	BEGIN
		IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (M.CallDate >= ''' + @FromDateText + '''
											OR M.CallDate >= ''' + @FromDateText + ''')'
		END
		ELSE IF(ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (M.CallDate <= ''' + @ToDateText + '''
										  OR M.CallDate <= ''' + @ToDateText + ''' )'
		END
		ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND M.CallDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''''
		END
	END

	-- Check Para Period
	IF @IsDate = 0 
		BEGIN
			IF ISNULL(@Period, '') != ''
				SET @sWhere = @sWhere + ' AND (CASE WHEN MONTH(M.CallDate) <10 THEN ''0''+rtrim(ltrim(str(MONTH(M.CallDate))))+''/''+ltrim(Rtrim(str(YEAR(M.CallDate)))) 
						ELSE rtrim(ltrim(str(MONTH(M.CallDate))))+''/''+ltrim(Rtrim(str(YEAR(M.CallDate)))) END) in ('''+@Period +''')'
				SET @sWhereDashboard = @sWhereDashboard + ' AND (CASE WHEN MONTH(M.CallDate) <10 THEN ''0''+rtrim(ltrim(str(MONTH(M.CallDate))))+''/''+ltrim(Rtrim(str(YEAR(M.CallDate)))) 
						ELSE rtrim(ltrim(str(MONTH(M.CallDate))))+''/''+ltrim(Rtrim(str(YEAR(M.CallDate)))) END) in ('''+@Period +''')'
		END

	IF ISNULL(@Source, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Source, '''') LIKE N''%' + @Source + '%'' '

	IF ISNULL(@Destination, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Destination, '''') LIKE N''%' + @Destination + '%'' '

	IF ISNULL(@AccountID, '') != ''
		SET @sWhere = @sWhere + ' AND (M.AccountID LIKE N''%' + @AccountID + '%'' OR M.AccountName LIKE N''%' + @AccountID + '%'') '

	IF ISNULL(@ContactID, '') != ''
		SET @sWhere = @sWhere + ' AND (M.ContactID LIKE N''%' + @ContactID + '%'' OR M.ContactName LIKE N''%' + @ContactID + '%'') '

	IF ISNULL(@StatusID,'') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.StatusID, '''') IN (''' + @StatusID + ''') '

	IF ISNULL(@Extend, '') != ''
		SET @sWhere = @sWhere + ' AND (ISNULL(C3.FullName, '''') LIKE N''%' + @Extend + '%'' OR ISNULL(C7.UserName, '''') LIKE N''%' + @Extend + '%'') '

	IF ISNULL(@TypeOfCall,'') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.TypeOfCall, '''') IN (''' + @TypeOfCall + ''') '

	IF @Type = 6
		BEGIN
			IF @IsSuccess = 1
				SET @sWhereDashboard = @sWhereDashboard + ' AND M.StatusID = ''ANSWERED'' '
			SET @sWhere1 = 'WHERE ' + @sWhereDashboard + ' '
		END
	ELSE --@Type = 2
	BEGIN
		IF (ISNULL(@RelAPK, '') != '' AND ISNULL(@RelTable, '') != '')
		BEGIN
			SET @sWhere1 = 
			CASE
				WHEN @RelTable = 'CRMT0088' THEN 'LEFT JOIN ' +@RelTable+ ' C9 WITH (NOLOCK) ON C9.APKChild = M.APK 
											WHERE ''' +@RelAPK+''' IN (CONVERT(VARCHAR(50), C8.APK),CONVERT(VARCHAR(50), C9.APKParent))
											AND M.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') 
											AND ISNULL(M.DeleteFlg, 0) = 0'
				WHEN @RelTable = 'OOT2170' THEN 'LEFT JOIN ' +@RelTable+ ' C9 WITH (NOLOCK) ON C9.SupportRequiredID = M.RequestSupportID
											WHERE C9.APK = ''' +@RelAPK+'''
											AND M.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') 
											AND ISNULL(M.DeleteFlg, 0) = 0'
				ELSE 'WHERE ' + @sWhere + ' '
			END
		END
		ELSE
			SET @sWhere1 = 'WHERE ' + @sWhere + ' '
	END

	IF  @PageNumber = 1 SET @TotalRow = 'COUNT OVER ()' ELSE SET @TotalRow = 'NULL'

		SET @sSQLPermission = N'IF OBJECT_ID(''tempdb..#PermissionOOT2180'') IS NOT NULL DROP TABLE #PermissionOOT2180
								
							SELECT Value
							INTO #PermissionOOT2180
							FROM STRINGSPLIT(''' + ISNULL(@ConditionCallsHistory, '') + ''', '','')

							IF OBJECT_ID(''tempdb..#FilterCallHistoryAPK'') IS NOT NULL DROP TABLE #FilterCallHistoryAPK

							SELECT DISTINCT M.APK
							INTO #FilterCallHistoryAPK
							FROM OOT2180 M WITH (NOLOCK)
									--LEFT JOIN AT1202 C1 WITH (NOLOCK) ON C1.ObjectID = M.AccountID
									LEFT JOIN POST0011 C1 WITH (NOLOCK) ON C1.MemberID = M.AccountID						-- Thay đổi join với bảng thông tin khách hàng
									LEFT JOIN CRMT10001 C2 WITH (NOLOCK) ON C2.ContactID = M.ContactID
									LEFT JOIN AT1103 C3 WITH (NOLOCK) ON C3.EmployeeID = M.CreateUserID AND C3.DivisionID IN (''' + @WhereDivision + ''',''@@@'')
									LEFT JOIN AT1405 C7 WITH (NOLOCK) ON C7.UserID = M.CreateUserID AND C7.DivisionID IN (''' + @WhereDivision + ''',''@@@'')
									LEFT JOIN CRMT0099 C5 WITH (NOLOCK) ON C5.ID = M.StatusID AND C5.CodeMaster = ''CRMF2150.StatusCall''
									LEFT JOIN CRMT0099 C6 WITH (NOLOCK) ON C6.ID = M.TypeOfCall AND C6.CodeMaster = ''CRMF2150.TypeOfCall''
									LEFT JOIN CRMT20301 C8 WITH (NOLOCK) ON C8.LeadID = M.LeadID							--Mapping với đầu mối thông qua LeadID
									INNER JOIN #PermissionOOT2180 T1 ON T1.Value IN (M.CreateUserID)
							' + @sWhere1 + ' '

	
	SET @sSQL = @sSQL + N'
	SELECT M.APK
			, C1.APK AS APKAccountID
			, C2.APK AS APKContactID
			, C4.APK AS APKSupportRequiredID
			, C8.APK AS APKLeadID
			, M.DivisionID
			, M.CallDate
			, M.DID
			, M.Source
			, M.Destination
			, M.StatusID
			, C5.Description AS StatusName
			, M.Note
			, CONVERT(char(8), DATEADD(SECOND, ISNULL(M.Duration, 0), ''''), 114) AS Duration
			, M.TypeOfCall
			, C6.Description AS TypeOfCallName
			, M.RequestStatus
			, M.Extend
			, IIF(ISNULL(M.CreateUserID, '''') != ''ASOFTADMIN'', C3.FullName, C7.UserName) AS ExtendName
			, M.AccountID
			, M.ContactID
			, M.AccountName
			, IIF(ISNULL(M.ContactName, '''') != '''', M.ContactName, C8.LeadName) AS ContactOrLead --Đổi tên cho cột Liên hệ/Đầu mối
			, M.RequestSupportID
			, IIF(ISNULL(M.RequestSupportID, '''') != '''', CONCAT(M.RequestSupportID, '' - '' , C4.SupportRequiredName), '''') AS RequestSupportName
			, M.Download
			, M.CreateDate
		INTO #TempOOT2180
		FROM OOT2180 M WITH (NOLOCK)
			INNER JOIN #FilterCallHistoryAPK T1 ON T1.APK = M.APK
			--LEFT JOIN AT1202 C1 WITH (NOLOCK) ON C1.ObjectID = M.AccountID									-- Khách hàng
			LEFT JOIN POST0011 C1 WITH (NOLOCK) ON C1.MemberID = M.AccountID									-- Thay đổi join với bảng thông tin khách hàng
			LEFT JOIN CRMT10001 C2 WITH (NOLOCK) ON C2.ContactID = M.ContactID									-- Liên hệ
			LEFT JOIN AT1103 C3 WITH (NOLOCK) ON C3.EmployeeID = M.CreateUserID AND C3.DivisionID IN (''' + @WhereDivision + ''',''@@@'')
			LEFT JOIN AT1405 C7 WITH (NOLOCK) ON C7.UserID = M.CreateUserID AND C7.DivisionID IN (''' + @WhereDivision + ''',''@@@'')
			LEFT JOIN OOT2170 C4 WITH (NOLOCK) ON C4.SupportRequiredID = M.RequestSupportID
			LEFT JOIN CRMT0099 C5 WITH (NOLOCK) ON C5.ID = M.StatusID AND C5.CodeMaster = ''CRMF2150.StatusCall''
			LEFT JOIN CRMT0099 C6 WITH (NOLOCK) ON C6.ID = M.TypeOfCall AND C6.CodeMaster = ''CRMF2150.TypeOfCall''  
			LEFT JOIN CRMT20301 C8 WITH (NOLOCK) ON C8.LeadID = M.LeadID										--Mapping với đầu mối thông qua LeadID

		DECLARE @Count INT
		SELECT @Count = COUNT(*) FROM #TempOOT2180
		
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow
			, M.APK
			, M.APKContactID
			, M.APKAccountID
			, M.APKSupportRequiredID
			, M.APKLeadID
			, M.DivisionID
			, M.CallDate
			, M.DID
			, M.Source
			, M.Destination
			, M.StatusID
			, M.StatusName
			, M.Note
			, M.Duration
			, M.TypeOfCall
			, M.TypeOfCallName
			, M.RequestStatus
			, M.Extend
			, M.ExtendName
			, M.AccountID
			, M.ContactID
			, M.AccountName
			, M.ContactOrLead
			, M.RequestSupportID
			, M.RequestSupportName
			, M.Download
			, M.CreateDate
		FROM #TempOOT2180 M
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
	--PRINT(@sSQLPermission + @sSQL)
	EXEC (@sSQLPermission + @sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
