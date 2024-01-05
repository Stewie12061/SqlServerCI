IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP20801]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP20801]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid Form CRMF2080 Danh mục yêu cầu
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng, Date: 27/03/2017
--- Modify by Thị Phượng, Date 08/05/2017: Bổ sung phân quyền
--- Modify by Thị Phượng, Date 30/08/2017: Thay đổi cách sắp xếp order by theo CreateDate
--- Modify by Thị Phượng, Date 08/11/2017: Bổ sung thêm xử lý search nâng cao
--- Modify by Tấn Đạt, Date 08/02/2018: Bổ sung thêm các trường: RequestTypeID, RequestTypeName, BugTypeID, BugTypeName, DeadlineExpect, CompleteDate, DurationTime, RealTime
--- Modify by Tấn Đạt, Date 08/02/2018: Bổ sung thêm các trường: ProjectID, ProjectName
--- Modify by Hoàng vũ, Date 25/09/2018: Convert chuyển lấy dữ liệu khách hàng CRM (CRMT10101)-> Khách hàng POS (POST0011)
--- Modify by Bảo Toàn, Date 04/07/2019: Bổ sung field cơ hội (OpportunityID)
--- Modify by Kiều Nga, Date 06/05/2020: Tách chuỗi @sSQL 
--- Modify by Vĩnh Tâm, Date 12/01/2021: Fix lỗi mất phân quyền dữ liệu khi dùng search nâng cao
--- Modify by Anh Tuấn, Date 31/12/2021: Bổ sung điều kiện chỉ lấy những phiếu có DeleteFlg = 0
--- Modify by Hoài Thanh, Date 10/01/2023: Bổ sung luồng load dữ liệu từ dashboard
--- Modify by Hoài Bảo, Date 07/02/2023: Bổ sung luồng load dữ liệu từ màn hình truy vấn ngược
-- <Example> exec CRMP20801 @DivisionID=N'HCM', @DivisionIDList=N'', @RequestSubject=N'', @AccountID=N'asdaa', @AssignedToUserID=N'', @RequestStatus=N'', @PriorityID=N'', @UserID=N'HCM07', @PageNumber=1, @PageSize=25, @ConditionRequestID=NULL, @SearchWhere=N''

CREATE PROCEDURE CRMP20801 ( 
	@DivisionID VARCHAR(50) = '',  --Biến môi trường
	@DivisionIDList NVARCHAR(2000) = '',    --Chọn trong DropdownChecklist DivisionID
	@FromDate DATETIME = NULL,
	@ToDate DATETIME = NULL,
	@IsPeriod INT = 0,
	@PeriodList VARCHAR(MAX) = '',
	@RequestSubject NVARCHAR(50) = '',
	@AccountID NVARCHAR(250) = '',
	@AssignedToUserID NVARCHAR(250) = '',
	@RequestStatus NVARCHAR(250) = '',
	@KindID VARCHAR(50) = '',
	@PriorityID VARCHAR(MAX) = '',
	@SupportDictionaryID VARCHAR(50) = '',
	@UserID VARCHAR(50) = '',
	@ConditionRequestID NVARCHAR(MAX) = '',
	@PageNumber INT = 1,
	@PageSize INT = 25,
	@SearchWhere NVARCHAR(MAX) = NULL,
	@RequestTypeID NVARCHAR(250) = NULL,
	@BugTypeID VARCHAR(50) = NULL,
	@DeadlineExpect VARCHAR(50) = NULL,
	@CompleteDate VARCHAR(50) = NULL,
	@DurationTime VARCHAR(50) = NULL,
	@RealTime VARCHAR(50) = NULL,
	@ProjectID NVARCHAR(MAX) = NULL,
	@ContactID NVARCHAR(50) = NULL,
	@InventoryID NVARCHAR(50) = NULL,
	@RequestCustomerID NVARCHAR(50) = NULL,
	@OpportunityID NVARCHAR(50) = NULL,
	@Type INT = 2, -- Type = 6: từ dashboard -> danh mục
	@IsLate INT = 0, -- 1: lấy dữ liệu yêu cầu trễ
	@DepartmentIDList VARCHAR(MAX) = NULL,
	@EmployeeIDList VARCHAR(MAX) = NULL,
	@RelAPK NVARCHAR(250) = '',
	@RelTable NVARCHAR(250) = ''
) 
AS 
DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX)='',
		@sWhere NVARCHAR(MAX),
		@sWhere1 NVARCHAR(MAX) = '',
		@sWhereDashboard NVARCHAR(MAX) = '1 = 1',
		@sSQLPermission NVARCHAR(MAX),
		@sWhereMemberID NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
		@TotalRow NVARCHAR(50),
		@subQuery NVARCHAR(MAX),
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)

	SET @sWhere = '1 = 1'
	SET @sWhereMemberID = ''
	SET @TotalRow = ''
	SET @OrderBy = ' M.CreateDate DESC'
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'


IF ISNULL(@subQuery, '') = ''
BEGIN
	IF (SELECT CustomerName FROM CustomerIndex) = 114
		SET @subQuery = N'STUFF(ISNULL((SELECT '', '' +  B.MemberID FROM POST0011 B WITH (NOLOCK) 
									LEFT JOIN CRMT20801_CRMT10101_REL D WITH (NOLOCK) ON D.AccountID = B.APK 
									WHERE D.RequestID = M.RequestID ' + @sWhereMemberID + '
									GROUP BY B.MemberID
									FOR XML PATH (''''), TYPE).value(''.'', ''NVARCHAR(MAX)''), ''''), 1, 2, '''') AS RelatedToID
						 , STUFF(ISNULL((SELECT '', '' + B.MemberName FROM POST0011 B WITH (NOLOCK) 
									LEFT JOIN CRMT20801_CRMT10101_REL D WITH (NOLOCK) ON D.AccountID = B.APK 
									WHERE D.RequestID = M.RequestID ' + @sWhereMemberID + '
									GROUP BY B.MemberID, B.MemberName
									FOR XML PATH (''''), TYPE).value(''.'', ''NVARCHAR(MAX)''), ''''), 1, 2, '''') AS RelatedToName'
	IF (SELECT CustomerName FROM CustomerIndex) != 114
		SET @subQuery = N'STUFF(ISNULL((SELECT '', '' +  B.ObjectID FROM AT1202 B WITH (NOLOCK) 
									LEFT JOIN CRMT20801_CRMT10101_REL D WITH (NOLOCK) ON D.AccountID = B.APK 
									WHERE D.RequestID = M.RequestID ' + @sWhereMemberID + '
									GROUP BY B.ObjectID
									FOR XML PATH (''''), TYPE).value(''.'', ''NVARCHAR(MAX)''), ''''), 1, 2, '''') AS AccountID
						 , STUFF(ISNULL((SELECT '', '' + B.ObjectName FROM AT1202 B WITH (NOLOCK) 
									LEFT JOIN CRMT20801_CRMT10101_REL D WITH (NOLOCK) ON D.AccountID = B.APK 
									WHERE D.RequestID = M.RequestID ' + @sWhereMemberID + '
									GROUP BY B.ObjectID, B.ObjectName
									FOR XML PATH (''''), TYPE).value(''.'', ''NVARCHAR(MAX)''), ''''), 1, 2, '''') AS AccountName'
END

IF ISNULL(@SearchWhere, '') =''
BEGIN
	-- Check Para DivisionIDList NULL then get DivisionID 
	IF ISNULL(@DivisionIDList, '') != ''
		BEGIN
			SET @sWhere = @sWhere + ' AND M.DivisionID IN (''' + @DivisionIDList + ''') '
			SET @sWhereDashboard = @sWhereDashboard + ' AND M.DivisionID IN (''' + @DivisionIDList + ''') '

		END
	ELSE 
		SET @sWhere = @sWhere + ' AND M.DivisionID = N''' + @DivisionID + ''''

	-- Check Para FromDate và ToDate
	-- Trường hợp search theo từ ngày đến ngày
	IF @IsPeriod = 0
		BEGIN
			IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
				BEGIN
					SET @sWhere = @sWhere + ' AND (M.CreateDate >= ''' + @FromDateText + '''
													OR M.CreateDate >= ''' + @FromDateText + ''')'
				END
			ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
				BEGIN
					SET @sWhere = @sWhere + ' AND (M.CreateDate <= ''' + @ToDateText + ''' 
													OR M.CreateDate <= ''' + @ToDateText + ''')'
				END
			ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
				BEGIN
					SET @sWhere = @sWhere + ' AND (M.CreateDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
				END
		END
	ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
		BEGIN
			SET @sWhere = @sWhere + ' AND (SELECT FORMAT(M.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
			SET @sWhereDashboard = @sWhereDashboard + ' AND (SELECT FORMAT(M.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''')'
		END

	IF ISNULL(@RequestSubject, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.RequestSubject, '''') LIKE N''%' + @RequestSubject + '%'' '
	IF ISNULL(@AccountID, '') != ''
		SET @sWhereMemberID = @sWhereMemberID + ' AND (ISNULL(B.MemberID, '''') LIKE N''%' + @AccountID + '%'' or ISNULL(B.MemberName, '''') LIKE N''%' + @AccountID + '%'') '
	IF ISNULL(@AssignedToUserID, '') != ''
		SET @sWhere = @sWhere + ' AND (ISNULL(M.AssignedToUserID, '''') LIKE N''%' + @AssignedToUserID + '%'' or ISNULL(A.FullName, '''') LIKE N''%' + @AssignedToUserID + '%'' )'
	IF ISNULL(@RequestStatus, '') != ''
		BEGIN
			SET @sWhere = @sWhere + ' AND ISNULL(M.RequestStatus, '''') IN (''' + @RequestStatus + ''') '
			SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(M.RequestStatus, '''') IN (''' + @RequestStatus + ''') '
		END
	IF ISNULL(@KindID, '') ! = ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.KindID, '''') LIKE N''%' + @KindID + '%'' '
	IF ISNULL(@PriorityID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.PriorityID, '''') IN (''' + @PriorityID + ''') '
	IF ISNULL(@SupportDictionaryID, '') ! = ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.SupportDictionaryID, '''') IN (''' + @SupportDictionaryID + ''') '
	IF ISNULL(@RequestTypeID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.RequestTypeID, '''') LIKE N''%' + @RequestTypeID + '%'' '
	IF ISNULL(@BugTypeID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.BugTypeID, '''') LIKE N''%' + @BugTypeID + '%'' '
	IF ISNULL(@DeadlineExpect, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.DeadlineExpect, '''') LIKE N''%' + @DeadlineExpect + '%'' '
	IF ISNULL(@CompleteDate, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.CompleteDate, '''') LIKE N''%' + @CompleteDate + '%'' '
	IF ISNULL(@DurationTime, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.DurationTime, '''') LIKE N''%' + @DurationTime + '%'' '
	IF ISNULL(@RealTime, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.RealTime, '''') LIKE N''%' + @RealTime + '%'' '
	IF ISNULL(@ProjectID, '') != ''
		BEGIN
			SET @sWhere = @sWhere + ' AND ISNULL(M.ProjectID, '''') IN (''' + @ProjectID + ''') '
			SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(M.ProjectID, '''') IN (''' + @ProjectID + ''') '
		END
	IF ISNULL(@InventoryID, '') != ''
		SET @sWhere = @sWhere + ' AND (C2.InventoryName LIKE N''%' + @InventoryID + '%'' OR M.InventoryID LIKE N''%' + @InventoryID + '%'') '
	IF ISNULL(@ContactID, '') != ''
		SET @sWhere = @sWhere + ' AND (C1.ContactName LIKE N''%' + @ContactID + '%'' OR M.ContactID LIKE N''%' + @ContactID + '%'') '
	IF ISNULL(@RequestCustomerID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.RequestCustomerID, '''') LIKE N''%' + @RequestCustomerID + '%'' '
	IF ISNULL(@OpportunityID, '') != ''
		SET @sWhere = @sWhere + ' AND (M.OpportunityID LIKE N''%' + @OpportunityID + '%'' OR C07.OpportunityName LIKE N''%' + @OpportunityID + '%'') '

	IF ISNULL(@DepartmentIDList, '') != ''
		SET @sWhereDashboard = @sWhereDashboard + ' AND A02.DepartmentName IS NOT NULL AND A02.DepartmentID IN ( ''' + @DepartmentIDList + ''')'
	IF ISNULL(@EmployeeIDList, '') != ''
		SET @sWhereDashboard = @sWhereDashboard + ' AND M.AssignedToUserID IN ( ''' + @EmployeeIDList + ''') '
END

IF ISNULL(@SearchWhere, '') != ''
	BEGIN
		SET @sWhere = '1 = 1'
	END
SET @sWhere = @sWhere + ' AND ISNULL(M.DeleteFlg,0) = 0 '
SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(M.DeleteFlg,0) = 0 '

IF @Type = 6
	BEGIN
		IF @IsLate = 1
			SET @sWhereDashboard = @sWhereDashboard + ' AND M.RequestStatus NOT IN(3,5) AND M.DeadlineRequest < GETDATE()'
		SET @sWhere1 = 'WHERE ' + @sWhereDashboard + ' '

	END
ELSE --Type = 2
BEGIN
	IF (ISNULL(@RelAPK, '') != '' AND ISNULL(@RelTable, '') != '')
	BEGIN
		SET @sWhere1 = 
		CASE
			WHEN @RelTable = 'CRMT0088' THEN @sWhere1 + 'LEFT JOIN ' +@RelTable+ ' C08 WITH (NOLOCK) ON M.APK = C08.APKParent
										WHERE M.DivisionID = ''' +@DivisionID+ ''' AND M.DeleteFlg = 0 AND C08.APKChild = ''' +@RelAPK+''' '
			WHEN @RelTable = 'OOT0088' THEN @sWhere1 + 'LEFT JOIN ' +@RelTable+ ' C08 WITH (NOLOCK) ON M.APK = C08.APKChild AND C08.TableBusinessChild = ''CRMT20801''
										WHERE M.DivisionID = ''' +@DivisionID+ ''' AND C08.APKParent = ''' +@RelAPK+''' AND M.DeleteFlg = 0'
			WHEN @RelTable = 'OOT2160' THEN @sWhere1 + 'LEFT JOIN ' +@RelTable+ ' C08 WITH (NOLOCK) ON C08.RequestID = M.RequestCustomerID
										WHERE M.DivisionID = ''' +@DivisionID+ ''' AND C08.APK = ''' +@RelAPK+''' AND M.DeleteFlg = 0'
			WHEN @RelTable = 'OOT0098' THEN @sWhere1 + 'LEFT JOIN ' +@RelTable+ ' C08 WITH (NOLOCK) ON C08.APKObject = M.APK AND C08.ObjectBusiness = ''CRMT20801''
										WHERE M.DivisionID = ''' +@DivisionID+ ''' AND M.DeleteFlg = 0 AND C08.APKRel = ''' +@RelAPK+''' '
			WHEN @RelTable = 'CRMT20801_CRMT10101_REL' THEN @sWhere1 + 'LEFT JOIN ' +@RelTable+ ' C08 WITH (NOLOCK) ON C08.RequestID = M.RequestID
										WHERE M.DivisionID = ''' +@DivisionID+ ''' AND M.DeleteFlg = 0 AND C08.AccountID = ''' +@RelAPK+''' '
			WHEN @RelTable = 'OT3101' THEN @sWhere1 + 'INNER JOIN ' +@RelTable+ ' C08 WITH (NOLOCK) ON C08.RequestID = M.APK
										WHERE M.DivisionID = ''' +@DivisionID+ ''' AND C08.APK = ''' +@RelAPK+''' AND M.DeleteFlg = 0'
			WHEN @RelTable = 'CRMT20501' THEN @sWhere1 + 'INNER JOIN ' +@RelTable+ ' C08 WITH (NOLOCK) ON C08.OpportunityID = M.OpportunityID
										WHERE M.DivisionID = ''' +@DivisionID+ ''' AND C08.APK = ''' +@RelAPK+''' AND M.DeleteFlg = 0'
			ELSE ' WHERE  ' + @sWhere + ' '
		END
	END
	ELSE
		SET @sWhere1 = 'WHERE ' + @sWhere + ' '
END

SET @sSQLPermission = N'IF OBJECT_ID(''tempdb..#PermissionCRMT20801'') IS NOT NULL DROP TABLE #PermissionCRMT20801
								
				SELECT Value
				INTO #PermissionCRMT20801
				FROM STRINGSPLIT(''' + ISNULL(@ConditionRequestID, '') + ''', '', '')

				IF OBJECT_ID(''tempdb..#FilterRequestCustomerAPK'') IS NOT NULL DROP TABLE #FilterRequestCustomerAPK

				SELECT DISTINCT M.APK
				INTO #FilterRequestCustomerAPK
				FROM CRMT20801 M WITH (NOLOCK)
					LEFT JOIN OOT2100 O1 WITH (NOLOCK) ON O1.ProjectID = M.ProjectID 
					LEFT JOIN OOT2101 O2 WITH (NOLOCK) ON O2.RelatedToID = M.ProjectID
					LEFT JOIN OOT2103 O3 WITH (NOLOCK) ON O3.RelatedToID = M.ProjectID
					LEFT JOIN AT1102 A2 WITH (NOLOCK) ON A2.DepartmentID = O2.DepartmentID
					LEFT JOIN AT1103 A WITH (NOLOCK) ON A.EmployeeID = M.AssignedToUserID
					LEFT JOIN AT1102 A02 WITH (NOLOCK) ON A02.DepartmentID = A.DepartmentID
					LEFT JOIN CRMT20501 C07 WITH (NOLOCK) ON C07.OpportunityID = M.OpportunityID 
					INNER JOIN #PermissionCRMT20801 T1 ON T1.Value IN (M.AssignedToUserID, M.CreateUserID,
																	O1.LeaderID, A2.ContactPerson, O3.UserID, O1.CreateUserID)
				' + @sWhere1 + ' 
			'

SET @sSQL = N' SELECT M.APK, M.DivisionID, M.RequestID, M.RequestSubject, M.RelatedToTypeID
				, M.PriorityID, C02.Description AS PriorityName , M.RequestStatus, C01.Description AS RequestStatusName
				, M.TimeRequest, M.DeadlineRequest, M.AssignedToUserID, A.FullName AS AssignedToUserName
				, M.RequestDescription, M.FeedbackDescription
				, C05.SupportDictionarySubject AS SupportDictionaryID, C06.KindName AS KindID
				, ' + @subQuery + '
				, M.CreateDate, M.LastModifyDate
				, M.DeadlineExpect, M.CompleteDate, M.DurationTime, M.RealTime
				, M.RequestTypeID, C03.Description AS RequestTypeName
				, M.BugTypeID, C04.Description AS BugTypeName
				, M.ProjectID, O1.ProjectName AS ProjectName
				, M.OpportunityID, C07.OpportunityName
				, M.ContactID, C1.ContactName AS ContactName
				, M.InventoryID
				, STUFF((SELECT '', '' + '' '' + A1.InventoryName
					FROM CRMT20802 C1 WITH (NOLOCK)
						LEFT JOIN AT1302 A1 WITH (NOLOCK) ON A1.InventoryID = C1.InventoryID
					WHERE C1.APKMaster = M.APK
					FOR XML PATH('''')), 1, 1, '''') AS InventoryName
				, M.RequestCustomerID
			INTO #CRMT20801
			FROM CRMT20801 M WITH (NOLOCK)
				INNER JOIN #FilterRequestCustomerAPK T1 ON T1.APK = M.APK
				LEFT JOIN AT1103 A WITH (NOLOCK) ON A.EmployeeID = M.AssignedToUserID
				LEFT JOIN CRMT0099 C01 WITH (NOLOCK) ON C01.ID = M.RequestStatus AND C01.CodeMaster = ''CRMT00000003''
				LEFT JOIN CRMT0099 C02 WITH (NOLOCK) ON C02.ID = M.PriorityID AND C02.CodeMaster = ''CRMT00000006''		
				LEFT JOIN CRMT0099 C03 WITH (NOLOCK) ON C03.ID = M.RequestTypeID AND C03.CodeMaster = ''CRMT00000025''			 
				LEFT JOIN CRMT0099 C04 WITH (NOLOCK) ON C04.ID = M.BugTypeID AND C04.CodeMaster = ''CRMT00000026''	
				LEFT JOIN CRMT1090 C05 WITH (NOLOCK) ON C05.SupportDictionaryID = M.SupportDictionaryID		
				LEFT JOIN CRMT1100 C06 WITH (NOLOCK) ON C06.KindID = M.KindID 	
				LEFT JOIN CRMT20501 C07 WITH (NOLOCK) ON C07.OpportunityID = M.OpportunityID 	
				LEFT JOIN AT1015 A1 WITH (NOLOCK) ON A1.AnaID = M.ProjectID
				LEFT JOIN OOT2100 O1 WITH (NOLOCK) ON O1.ProjectID = M.ProjectID
				LEFT JOIN CRMT10001 C1 WITH (NOLOCK) ON C1.ContactID = M.ContactID
				LEFT JOIN AT1302 C2 WITH (NOLOCK) ON C2.InventoryID = M.InventoryID
				LEFT JOIN AT1102 A02 WITH (NOLOCK) ON A02.DepartmentID = A.DepartmentID
			' + @sWhere1 + '

			DECLARE @Count INT
			SELECT @Count = Count(RequestID) FROM #CRMT20801 
			' + ISNULL(@SearchWhere, '') + '
		'

SET @sSQL1 = N'SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow,
				 M.APK, M.DivisionID, M.RequestID, M.RequestSubject, M.RelatedToTypeID
					, M.PriorityID, M.PriorityName, M.RequestStatus, M.RequestStatusName
					, M.TimeRequest, M.DeadlineRequest, M.AssignedToUserID, M.AssignedToUserName
					, M.RequestDescription, M.FeedbackDescription, M.SupportDictionaryID, M.KindID
					, M.AccountID, M.AccountName
					, M.CreateDate, M.LastModifyDate
					, M.DeadlineExpect, M.CompleteDate, M.DurationTime, M.RealTime
					, M.RequestTypeID, M.RequestTypeName
					, M.BugTypeID, M.BugTypeName
					, M.ProjectID, M.ProjectName
					, M.ContactID, M.ContactName
					, M.InventoryID, M.InventoryName
					, M.OpportunityID, M.OpportunityName
					, M.RequestCustomerID
			FROM #CRMT20801 M WITH (NOLOCK)
			' + ISNULL(@SearchWhere, '') + '
			ORDER BY ' + @OrderBy + '
			OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
			FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY'
			
--PRINT(@sSQLPermission)
--PRINT(@sSQL)
--PRINT(@sSQL1)

EXEC (@sSQLPermission + @sSQL + @sSQL1)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
