IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP2190]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP2190]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO










-- <Summary>
---- Load grid danh mục chiến dịch sms
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 02/01/2019 by Tấn Lộc
----Update on 14/12/2022 by Anh Đô: Select thêm cột Color
----Update on 19/12/2022 by Anh Đô: Đổi select StatusCampaignSMSName từ CRMT0099 sang CRMT10401
----Update on 13/02/2023 by Hoài Bảo: Bổ sung luồng load dữ liệu từ màn hình truy vấn ngược
-- <Example> EXEC KPIP2030 @DivisionID = 'DTI', @DivisionIDList = '', @UserID = 'TANLOC', @PageNumber='1', @PageSize='25','VANTOAI',0,0

CREATE PROCEDURE [dbo].[CRMP2190]
( 
	 @DivisionID VARCHAR(50) = '',
	 @DivisionIDList NVARCHAR(MAX) = '',
	 @FromDate DATETIME = NULL,
	 @ToDate DATETIME = NULL,
	 @IsPeriod INT = 0,
	 @PeriodList VARCHAR(MAX) = '',
	 @CampaignSMSID NVARCHAR(250) = '',
	 @CampaignSMSName NVARCHAR(250) = '',
	 @CampaignID NVARCHAR(250) = '',
	 @GroupReceiverID NVARCHAR(250) = '',
	 @TemplateID NVARCHAR(250) = '',
	 @QuantitySendSMS VARCHAR(250) = '',
	 @CreateUserID NVARCHAR (250) = '',
	 @IsCommon NVARCHAR(100) = '', 
	 @Disabled NVARCHAR(100) = '',
	 @ConditionCampaignSMS VARCHAR(MAX) = '',
	 @UserID VARCHAR(50) = '', 
	 @PageNumber INT = 1,
	 @PageSize INT = 25,
	 @RelAPK VARCHAR(50) = '',
	 @RelTable VARCHAR(50) = ''
)
AS 
	DECLARE @sSQL NVARCHAR (MAX) = N'',
     		@OrderBy NVARCHAR(MAX) = N'', 
			@TotalRow NVARCHAR(50) = N'',
			@sWhere NVARCHAR(MAX),
			@sSQLPermission NVARCHAR(MAX),
			@FromDateText NVARCHAR(20),
			@ToDateText NVARCHAR(20),
			@sWhere2 NVARCHAR(MAX)

	SET @OrderBy = 'C1.CreateDate DESC'
	SET @sWhere = ''
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'
	SET @sWhere2 = ''

	-- Check Para DivisionIDList null then get DivisionID
	IF ISNULL(@DivisionIDList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' C1.DivisionID IN (''' + @DivisionIDList + ''') '
		SET @sWhere2 = @sWhere2 + ' C5.DivisionID IN ('''+ @DivisionIDList +''', ''@@@'')'
	END
	ELSE 
	BEGIN
		SET @sWhere = @sWhere + ' C1.DivisionID IN (''' + @DivisionID + ''') '
		SET @sWhere2 = @sWhere2 + ' C5.DivisionID IN ('''+ @DivisionID +''', ''@@@'') '
	END

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

	IF ISNULL(@CampaignSMSID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(C1.CampaignSMSID, '''') LIKE N''%' + @CampaignSMSID + '%'' '

	IF ISNULL(@CampaignSMSName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(C1.CampaignSMSName, '''') LIKE N''%' + @CampaignSMSName + '%'' '

	IF ISNULL(@CampaignID, '') != ''
		SET @sWhere = @sWhere + ' AND (C1.CampaignID LIKE N''%' + @CampaignID + '%'' OR C2.CampaignName LIKE N''%' + @CampaignID + '%'') '

	IF ISNULL(@GroupReceiverID, '') != ''
		SET @sWhere = @sWhere + ' AND (C1.GroupReceiverID LIKE N''%' + @GroupReceiverID + '%'' OR C3.GroupReceiverName LIKE N''%' + @GroupReceiverID + '%'') '

	IF ISNULL(@TemplateID, '') != ''
		SET @sWhere = @sWhere + ' AND (C1.TemplateID LIKE N''%' + @TemplateID + '%'' OR A1.TemplateName LIKE N''%' + @TemplateID + '%'') '

	IF ISNULL(@CreateUserID, '') != ''
		SET @sWhere = @sWhere + ' AND (C1.CreateUserID LIKE N''%' + @CreateUserID + '%'' OR A2.FullName LIKE N''%' + @CreateUserID + '%'') '

	IF (ISNULL(@RelAPK, '') != '' AND ISNULL(@RelTable, '') != '')
	BEGIN
		SET @sWhere = 
		CASE
			WHEN @RelTable = 'CRMT20401' THEN ' C2.APK = ''' +@RelAPK+ ''' '
			ELSE @sWhere
		END
	END

	IF  @PageNumber = 1 SET @TotalRow = 'COUNT OVER ()' ELSE SET @TotalRow = 'NULL'

	SET @sSQLPermission = N'IF OBJECT_ID(''tempdb..#PermissionCRMT2190'') IS NOT NULL DROP TABLE #PermissionCRMT2190
								
							SELECT Value
							INTO #PermissionCRMT2190
							FROM STRINGSPLIT(''' + ISNULL(@ConditionCampaignSMS, '') + ''', '','')

							IF OBJECT_ID(''tempdb..#FilterCampaignSMSAPK'') IS NOT NULL DROP TABLE #FilterCampaignSMSAPK

							SELECT DISTINCT C1.APK
							INTO #FilterCampaignSMSAPK
							FROM CRMT2190 C1 WITH (NOLOCK)
									LEFT JOIN CRMT20401 C2 WITH (NOLOCK) ON C1.CampaignID = C2.CampaignID
									LEFT JOIN CRMT10301 C3 WITH (NOLOCK) ON C1.GroupReceiverID = C3.GroupReceiverID
									LEFT JOIN AT0129 A1 WITH (NOLOCK) ON C1.TemplateID = A1.TemplateID
									LEFT JOIN AT1103 A2 WITH (NOLOCK) ON A2.EmployeeID = C1.CreateUserID
									LEFT JOIN AT1103 A3 WITH (NOLOCK) ON A3.EmployeeID = C1.LastModifyUserID
									LEFT JOIN CRMT0099 C4 WITH (NOLOCK) ON C1.StatusCampaignSMS = C4.ID AND C4.CodeMaster = ''CRMT2190.StatusCampaignSMS''
									INNER JOIN #PermissionCRMT2190 T1 ON T1.Value IN (C1.CreateUserID)
							WHERE ' + @sWhere + ' '

	SET @sSQL = @sSQL + N'
		SELECT C1.APK, C1.DivisionID, C1.CampaignSMSID, C1.CampaignSMSName, C1.CampaignID, C1.GroupReceiverID, C1.TemplateID
       ,C1.QuantitySendSMS, C1.APKSettingTime, C1.CreateDate, C1.LastModifyDate, C1.StatusCampaignSMS, C1.QuantitySendSMSSucceed
	   , C1.QuantitySendSMSFail, C1.QuantitySMSUnsubcription
	   , C2.CampaignName, A1.TemplateName, A2.FullName AS CreateUserID, A3.FullName AS LastModifyUserID
	   , C5.StageName AS StatusCampaignSMSName
	   , STUFF((SELECT '','' + '' '' + C3.GroupReceiverName
				FROM CRMT0088 C2
					LEFT JOIN CRMT10301 C3 WITH (NOLOCK) ON C3.GroupReceiverID = C2.BusinessChild
				WHERE C2.APKParent = C1.APK
				FOR XML PATH('''')), 1, 1, '''') AS GroupReceiverName
		, C5.Color
		INTO #TempCRMT2190
		FROM CRMT2190 C1 WITH (NOLOCK)
		    INNER JOIN #FilterCampaignSMSAPK T1 ON T1.APK = C1.APK
			LEFT JOIN CRMT20401 C2 WITH (NOLOCK) ON C1.CampaignID = C2.CampaignID
			LEFT JOIN CRMT10301 C3 WITH (NOLOCK) ON C1.GroupReceiverID = C3.GroupReceiverID
			LEFT JOIN AT0129 A1 WITH (NOLOCK) ON C1.TemplateID = A1.TemplateID
			LEFT JOIN AT1103 A2 WITH (NOLOCK) ON A2.EmployeeID = C1.CreateUserID
			LEFT JOIN AT1103 A3 WITH (NOLOCK) ON A3.EmployeeID = C1.LastModifyUserID
			LEFT JOIN CRMT0099 C4 WITH (NOLOCK) ON C1.StatusCampaignSMS = C4.ID AND C4.CodeMaster = ''CRMT2190.StatusCampaignSMS''
			LEFT JOIN CRMT10401 C5 WITH (NOLOCK) ON C5.StageID = C1.StatusCampaignSMS AND '+ @sWhere2 +'
		WHERE  ' + @sWhere +   ' AND C1.DivisionID = ''' + @DivisionID + ''' AND ISNULL(C1.DeleteFlg, 0) = 0

		DECLARE @Count INT
		SELECT @Count = COUNT(*) FROM #TempCRMT2190
		
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow
			  , C1.APK
			  , C1.DivisionID
			  , C1.CampaignSMSID
			  , C1.CampaignSMSName
			  , C1.CampaignID
			  , C1.GroupReceiverID
			  , C1.TemplateID
			  , C1.QuantitySendSMS
			  , C1.APKSettingTime
			  , C1.CampaignName
			  , C1.GroupReceiverName
			  , C1.TemplateName
			  , C1.StatusCampaignSMS
			  , C1.QuantitySendSMSSucceed
			  , C1.QuantitySendSMSFail
			  , C1.QuantitySMSUnsubcription
			  , C1.StatusCampaignSMSName
			  , C1.Color
		FROM #TempCRMT2190 C1
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
