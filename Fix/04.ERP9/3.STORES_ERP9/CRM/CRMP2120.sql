IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP2120]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP2120]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO













-- <Summary>
---- Load grid danh mục phiếu đề nghị cấp license
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 02/07/2019 by Tấn Lộc
-- <Example> EXEC KPIP2030 @DivisionID = 'DTI', @DivisionIDList = '', @UserID = 'TANLOC', @PageNumber='1', @PageSize='25','VANTOAI',0,0

CREATE PROCEDURE [dbo].[CRMP2120]
(
	 @DivisionID VARCHAR(50),
	 @DivisionIDList NVARCHAR(MAX),
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @IsPeriod INT,
	 @PeriodList VARCHAR(MAX),
	 @RequestLicenseID NVARCHAR(250),
	 @AccountID NVARCHAR(250),
	 @VATNo NVARCHAR(250),
	 @ContractNo NVARCHAR(250),
	 @ContractName NVARCHAR(MAX),
	 @ComputerName NVARCHAR(250),
	 @ElectronicBill NVARCHAR(250),
	 @CreateUserID NVARCHAR (250),
	 @IsCommon NVARCHAR(100), 
	 @Disabled NVARCHAR(100),
	 @ConditionLicenseManagement VARCHAR(MAX),
	 @UserID VARCHAR(50), 
	 @PageNumber INT,
	 @PageSize INT
)
AS 
	DECLARE @sSQL NVARCHAR (MAX) = N'',
     		@OrderBy NVARCHAR(MAX) = N'', 
			@TotalRow NVARCHAR(50) = N'',
			@sWhere NVARCHAR(MAX),
			@sSQLPermission NVARCHAR(MAX),
			@FromDateText NVARCHAR(20),
			@ToDateText NVARCHAR(20)

	SET @OrderBy = 'M.CreateDate DESC'
	SET @sWhere = ''
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

	-- Check Para DivisionIDList null then get DivisionID
	IF ISNULL(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' M.DivisionID IN (''' + @DivisionIDList + ''')'
	ELSE 
		SET @sWhere = @sWhere + ' M.DivisionID IN (''' + @DivisionID + ''')'

	SET @sWhere = @sWhere + ' AND ISNULL(M.DeleteFlg, 0) = 0'

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
	END

	IF ISNULL(@RequestLicenseID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.RequestLicenseID, '''') LIKE N''%' + @RequestLicenseID + '%'' '

	IF ISNULL(@AccountID, '') != ''
		SET @sWhere = @sWhere + ' AND (M.AccountID LIKE N''%' + @AccountID + '%'' OR A1.ObjectName LIKE N''%' + @AccountID + '%'') '

	IF ISNULL(@VATNo, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.VATNo, '''') LIKE N''%' + @VATNo + '%'' '

	IF ISNULL(@ContractNo, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.ContractNo, '''') LIKE N''%' + @ContractNo + '%'' '

	IF ISNULL(@ContractName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.ContractName, '''') LIKE N''%' + @ContractName + '%'' '

	IF ISNULL(@ComputerName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(C1.ComputerName, '''') LIKE N''%' + @ComputerName + '%'' '

	IF ISNULL(@ElectronicBill, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.ElectronicBill, '''') LIKE N''%' + @ElectronicBill + '%'' '

	IF ISNULL(@CreateUserID, '') != ''
		SET @sWhere = @sWhere + ' AND (M.CreateUserID LIKE N''%' + @CreateUserID + '%'' OR A3.FullName LIKE N''%' + @CreateUserID + '%'') '

	IF  @PageNumber = 1 SET @TotalRow = 'COUNT OVER ()' ELSE SET @TotalRow = 'NULL'

	SET @sSQLPermission = N'IF OBJECT_ID(''tempdb..#PermissionCRMT2120'') IS NOT NULL DROP TABLE #PermissionCRMT2120
								
							SELECT Value
							INTO #PermissionCRMT2120
							FROM STRINGSPLIT(''' + ISNULL(@ConditionLicenseManagement, '') + ''', '','')

							IF OBJECT_ID(''tempdb..#FilterRequestLicenseAPK'') IS NOT NULL DROP TABLE #FilterRequestLicenseAPK

							SELECT DISTINCT M.APK
							INTO #FilterRequestLicenseAPK
							FROM CRMT2120 M WITH (NOLOCK)
									LEFT JOIN AT1202 A1 WITH (NOLOCK) ON A1.ObjectID = M.AccountID
									LEFT JOIN AT1020 A2 WITH (NOLOCK) ON A2.ContractNo = M.ContractNo
									LEFT JOIN AT1103 A3 WITH (NOLOCK) ON A3.EmployeeID = M.CreateUserID
									LEFT JOIN CRMT2130 C1 WITH (NOLOCK) ON C1.APKCRMT2120 = M.APK
									LEFT JOIN AT1103 A4 WITH (NOLOCK) ON A4.EmployeeID = M.AssignedToUserID
									INNER JOIN #PermissionCRMT2120 T1 ON T1.Value IN (M.CreateUserID, M.AssignedToUserID)
							WHERE ' + @sWhere + ' '

	
	SET @sSQL = @sSQL + N'
	     SELECT M.APK, M.DivisionID, M.RequestLicenseID ,M.RequestLicenseName, M.AccountID, M.Address, M.VATNo, M.NameofLegalRepresentative, M.Position 	
		       , M.ContractNo, M.NumberOfUsers, M.NumberOfUnitsBranchesUsed, M.Tel, M.ElectronicBill, M.Fax, M.Website, M.Email, M.ContactID
		       , M.AssignedToUserID, M.IsDeadlineTime, M.NoDeadline, M.DeadlineTime, M.CreateDate
		       , A1.ObjectName AS AccountName
		       , M.ContractName
		       , A3.FullName
			   , C1.ComputerName AS ComputerName
			   , C1.APK AS FieldAPKCRMT2130
			   , A4.FullName AS AssignedToUserName
		INTO #TempCRMT2120
		FROM CRMT2120 M WITH (NOLOCK)
			INNER JOIN #FilterRequestLicenseAPK T1 ON T1.APK = M.APK
			LEFT JOIN AT1202 A1 WITH (NOLOCK) ON A1.ObjectID = M.AccountID
	        LEFT JOIN AT1020 A2 WITH (NOLOCK) ON A2.ContractNo = M.ContractNo
	        LEFT JOIN AT1103 A3 WITH (NOLOCK) ON A3.EmployeeID = M.CreateUserID
			LEFT JOIN AT1103 A4 WITH (NOLOCK) ON A4.EmployeeID = M.AssignedToUserID
			--LEFT JOIN (SELECT DISTINCT APKCRMT2120, ComputerName FROM CRMT2130 C1 WITH (NOLOCK)) AS C1 ON C1.APKCRMT2120 = M.APK
			LEFT JOIN CRMT2130 C1 WITH (NOLOCK) ON C1.APKCRMT2120 = M.APK
		WHERE  ' + @sWhere +   ' AND M.DivisionID = ''' + @DivisionID + ''' AND ISNULL(M.DeleteFlg, 0) = 0 AND ISNULL(C1.DeleteFlg,0) = 0

		DECLARE @Count INT
		SELECT @Count = COUNT(*) FROM #TempCRMT2120
		
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow
			  , M.APK
			  , M.DivisionID
			  , M.RequestLicenseID
			  , M.RequestLicenseName
			  , M.Address
			  , M.VATNo
			  , M.NameofLegalRepresentative
			  , M.Position
			  , M.ContractNo
			  , M.NumberOfUsers
			  , M.NumberOfUnitsBranchesUsed
			  , M.Tel
			  , M.ElectronicBill
			  , M.Fax
			  , M.Website
			  , M.Email
			  , M.ContactID
			  , M.AssignedToUserID
			  , M.AssignedToUserName
			  , M.IsDeadlineTime
			  , M.NoDeadline
			  , M.DeadlineTime
			  , M.AccountName
			  , M.ContractName
			  , M.FullName
			  , M.CreateDate
			  , M.ComputerName
			  , M.FieldAPKCRMT2130
		FROM #TempCRMT2120 M
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
