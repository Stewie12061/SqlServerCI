IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP2210]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP2210]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
















-- <Summary>
---- Load grid danh sách nguồn dữ liệu online
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 18/11/2021 by Tấn Lộc
----Update on 02/12/2022 by Anh Đô: Bổ sung lọc theo Người phụ trách
----Update on 13/02/2023 by Hoài Bảo: Bổ sung luồng load dữ liệu từ màn hình truy vấn ngược
----Update on 08/03/2023 by Hoài Thanh: Bổ sung lấy thêm cột Link và thêm điều kiện lọc theo Link


CREATE PROCEDURE [dbo].[CRMP2210]
( 
	 @DivisionID VARCHAR(50) = '',
	 @DivisionIDList NVARCHAR(MAX) = '',
	 @FromDate DATETIME = NULL,
	 @ToDate DATETIME = NULL,
	 @IsPeriod INT = 0,
	 @PeriodList VARCHAR(MAX) = '',
	 @SourceID NVARCHAR(250) = '',
	 @SourceName NVARCHAR(250) = '',
	 @Tel NVARCHAR(250) = '',
	 @Address NVARCHAR(250) = '',
	 @Email NVARCHAR(250) = '',
	 @JobTitle VARCHAR(250) = '',
	 @CompanyName VARCHAR(250) = '',
	 @StatusID VARCHAR(250) = '',
	 @TypeOfSource VARCHAR(250) = '',
	 @TeamID VARCHAR(250) = '',
	 @CampaignMedium VARCHAR(250) = '',
	 @CreateUserID NVARCHAR (250) = '',
	 @IsCommon NVARCHAR(100) = '', 
	 @Disabled NVARCHAR(100) = '',
	 @ConditionSourceDataOnline VARCHAR(MAX) = '',
	 @UserID VARCHAR(50) = '', 
	 @PageNumber INT = 1,
	 @PageSize INT = 25,
	 @AssignedToUserID	NVARCHAR(250) = '',
	 @RelAPK NVARCHAR(250) = '',
	 @RelTable NVARCHAR(250) = '',
	 @Link NVARCHAR(MAX) = ''
)
AS 
	DECLARE @sSQL NVARCHAR (MAX) = N'',
     		@OrderBy NVARCHAR(MAX) = N'', 
			@TotalRow NVARCHAR(50) = N'',
			@sWhere NVARCHAR(MAX),
			@sJoin NVARCHAR(MAX),
			@sSQLPermission NVARCHAR(MAX),
			@FromDateText NVARCHAR(20),
			@ToDateText NVARCHAR(20),
			@sWhere2 NVARCHAR(MAX)

	SET @OrderBy = 'C1.CreateDate DESC'
	SET @sWhere = ''
	SET @sJoin = ''
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'
	SET @sWhere2 = ''

	-- Check Para DivisionIDList null then get DivisionID
	IF ISNULL(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' C1.DivisionID IN (''@@@'',''' + @DivisionIDList + ''')'
	ELSE 
		SET @sWhere = @sWhere + ' C1.DivisionID IN (''@@@'',''' + @DivisionID + ''')'

	SET @sWhere = @sWhere + ' AND ISNULL(C1.DeleteFlg, 0) = 0'

	-- Check Para FromDate và ToDate
	-- Trường hợp search theo từ ngày đến ngày
IF @IsPeriod = 0
BEGIN
	IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + ' AND (C1.CreateDate >= ''' + @FromDateText + '''
											OR C1.CreateDate >= ''' + @FromDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (C1.CreateDate <= ''' + @ToDateText + ''' 
											OR C1.CreateDate <= ''' + @ToDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (C1.CreateDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
		END
END
ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(C1.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
	END

	IF ISNULL(@SourceID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(C1.SourceID, '''') LIKE N''%' + @SourceID + '%'' '

	IF ISNULL(@SourceName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(C1.SourceName, '''') LIKE N''%' + @SourceName + '%'' '

	IF ISNULL(@Tel, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(C1.Tel, '''') LIKE N''%' + @Tel + '%'' '

	IF ISNULL(@Address, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(C1.Address, '''') LIKE N''%' + @Address + '%'' '

	IF ISNULL(@Email, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(C1.Email, '''') LIKE N''%' + @Email + '%'' '

	IF ISNULL(@JobTitle, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(C1.JobTitle, '''') LIKE N''%' + @JobTitle + '%'' '

	IF ISNULL(@CompanyName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(C1.CompanyName, '''') LIKE N''%' + @CompanyName + '%'' '

	IF ISNULL(@StatusID,'') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(C1.StatusID, '''') IN (''' + @StatusID + ''') '

	IF ISNULL(@TypeOfSource,'') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(C1.TypeOfSource, '''') IN (''' + @TypeOfSource + ''') '

	IF ISNULL(@CreateUserID, '') != ''
		SET @sWhere = @sWhere + ' AND (C1.CreateUserID LIKE N''%' + @CreateUserID + '%'' OR A2.FullName LIKE N''%' + @CreateUserID + '%'') '

	IF ISNULL(@TeamID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(C1.TeamID, '''') LIKE N''%' + @TeamID + '%'' '

	IF ISNULL(@CampaignMedium, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(C1.CampaignMedium, '''') LIKE N''%' + @CampaignMedium + '%'' '

	IF ISNULL(@Link, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(C1.Link, '''') LIKE N''%' + @Link + '%'' '

	IF ISNULL(@AssignedToUserID, '') != ''
		SET  @sWhere2 = ' AND ISNULL(A4.FullName, '''') LIKE N''%'+ @AssignedToUserID +'%'''

	IF  @PageNumber = 1 SET @TotalRow = 'COUNT OVER ()' ELSE SET @TotalRow = 'NULL'

	IF (ISNULL(@RelAPK, '') != '' AND ISNULL(@RelTable, '') != '')
	BEGIN
		SET @sJoin = 
		CASE
			WHEN @RelTable = 'CRMT0088' THEN 'LEFT JOIN ' +@RelTable+ ' C5 WITH (NOLOCK) ON C5.APKChild = C1.APK '
			ELSE @sWhere
		END

		SET @sWhere = 
		CASE
			WHEN @RelTable = 'CRMT0088' THEN ' C5.APKParent = ''' +@RelAPK+ ''' '
			ELSE @sWhere
		END
	END

	SET @sSQLPermission = N'IF OBJECT_ID(''tempdb..#PermissionCRMT2210'') IS NOT NULL DROP TABLE #PermissionCRMT2210
								
							SELECT Value
							INTO #PermissionCRMT2210
							FROM STRINGSPLIT(''' + ISNULL(@ConditionSourceDataOnline, '') + ''', '','')

							IF OBJECT_ID(''tempdb..#FilterSourceDataOnlineAPK'') IS NOT NULL DROP TABLE #FilterSourceDataOnlineAPK

							SELECT DISTINCT C1.APK
							INTO #FilterSourceDataOnlineAPK
							FROM CRMT2210 C1 WITH (NOLOCK)
										LEFT JOIN CRMT10401 C2 WITH (NOLOCK) ON C2.StageID = C1.StatusID
										LEFT JOIN CRMT0099 C3 WITH (NOLOCK) ON C3.ID = C1.TypeOfSource AND C3.CodeMaster = ''CRMF2210.TypeOfSource''
										LEFT JOIN AT1103 A2 WITH (NOLOCK) ON A2.EmployeeID = C1.CreateUserID
										LEFT JOIN AT1103 A3 WITH (NOLOCK) ON A3.EmployeeID = C1.LastModifyUserID
										INNER JOIN #PermissionCRMT2210 T1 ON T1.Value IN (C1.CreateUserID) '
										+@sJoin+
										'
							WHERE ' + @sWhere + ' '

	SET @sSQL = @sSQL + N'
		SELECT C1.APK, C1.DivisionID, C1.SourceID, C1.SourceName, C1.Tel, C1.Address, C1.Email
       , C1.JobTitle, C1.CompanyName,  C1.StatusID, C1.TypeOfSource, C1.Disabled, C1.Description, C1.ProductInfo
	   , C1.DeleteFlg, C1.CreateUserID, C1.CreateDate, C1.LastModifyUserID, C1.LastModifyDate
	   , C2.Color, C2.StageName AS StatusName, A5.LeadTypeName AS TypeOfSourceName, C1.IsComfirmOpportunity , C1.IsComfirmCustomers, C1.IsComfirmLead
	   , C1.UserID, C1.FormID, C1.FormName, C1.DisplayID, C1.CreateDate AS WriteTime, C1.AssignedToUserID, A4.FullName AS AssignedToUserName
	   , C1.CampaignID, A6.CampaignName, C1.TeamID, C1.CampaignMedium, A8.LeadName, A7.APKParent AS FieldAPKCRMT20301, C1.SubDomain
	   , STUFF((SELECT '','' + '' '' + A1.InventoryName
				    FROM CRMT0088 C4
					    LEFT JOIN AT1302 A1 WITH (NOLOCK) ON A1.InventoryID = C4.BusinessChild
				    WHERE C4.APKParent = C1.APK
				    FOR XML PATH('''')), 1, 1, '''') AS ProductInfoName
		, C1.Link
		INTO #TempCRMT2210
		FROM CRMT2210 C1 WITH (NOLOCK)
		    INNER JOIN #FilterSourceDataOnlineAPK T1 ON T1.APK = C1.APK
			LEFT JOIN CRMT10401 C2 WITH (NOLOCK) ON C2.StageID = C1.StatusID
			LEFT JOIN CRMT0099 C3 WITH (NOLOCK) ON C3.ID = C1.TypeOfSource AND C3.CodeMaster = ''CRMF2210.TypeOfSource''
			LEFT JOIN AT1103 A2 WITH (NOLOCK) ON A2.EmployeeID = C1.CreateUserID
			LEFT JOIN AT1103 A3 WITH (NOLOCK) ON A3.EmployeeID = C1.LastModifyUserID
			LEFT JOIN AT1103 A4 WITH (NOLOCK) ON A4.EmployeeID = C1.AssignedToUserID
			LEFT JOIN CRMT10201 A5 WITH (NOLOCK) ON A5.LeadTypeID = C1.TypeOfSource
			LEFT JOIN CRMT20401 A6 WITH (NOLOCK) ON A6.CampaignID = C1.CampaignID
			LEFT JOIN CRMT0088 A7 WITH (NOLOCK) ON A7.APKChild = C1.APK
			LEFT JOIN CRMT20301 A8 WITH (NOLOCK) ON A8.APK = A7.APKParent '
			+@sJoin+
			'
		WHERE  ' + @sWhere +  @sWhere2 + ' AND C1.DivisionID IN(''@@@'' ,''' + @DivisionID + ''') AND ISNULL(C1.DeleteFlg, 0) = 0

		DECLARE @Count INT
		SELECT @Count = COUNT(*) FROM #TempCRMT2210
		
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow
			  , C1.APK
			  , C1.DivisionID
			  , C1.SourceID
			  , C1.SourceName
			  , C1.Tel
			  , C1.Address
			  , C1.Email
			  , C1.JobTitle
			  , C1.CompanyName
			  , C1.StatusID
			  , C1.TypeOfSource
			  , C1.Disabled
			  , C1.Description
			  , C1.ProductInfo
			  , C1.CreateUserID
			  , C1.CreateDate
			  , C1.LastModifyUserID
			  , C1.LastModifyDate
			  , C1.Color
			  , C1.StatusName
			  , C1.TypeOfSourceName
			  , C1.ProductInfoName
			  , C1.IsComfirmOpportunity 
			  , C1.IsComfirmCustomers
			  , C1.IsComfirmLead
			  , C1.UserID
			  , C1.FormID
			  , C1.FormName
			  , C1.DisplayID
			  , C1.WriteTime
			  , C1.AssignedToUserID
			  , C1.AssignedToUserName
			  , C1.CampaignID
			  , C1.CampaignName
			  , C1.TeamID
			  , C1.CampaignMedium
			  , C1.LeadName
			  , FieldAPKCRMT20301
			  , C1.SubDomain
			  , C1.Link
		FROM #TempCRMT2210 C1
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
	EXEC (@sSQLPermission + @sSQL)
	PRINT(@sSQLPermission + @sSQL)





















GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
