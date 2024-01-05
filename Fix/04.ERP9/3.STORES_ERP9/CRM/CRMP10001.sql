IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP10001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP10001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Grid Form CRMP10001 Danh muc liên hệ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Phan thanh hoàng vũ, Date: 20/11/2015
----Modify by Cao Thị Phượng Date 01/03/2017: bổ sung load IsConvert và InhertAccountID
----Modify by Cao Thị Phượng Date 05/05/2017: bổ sung Phân quyền truyền thêm biến
--- Modify by Thị Phượng, Date 09/05/2017: Ẩn đi 2 cột loại chuyển đổi và mã KH
--- Modify by Thị Phượng, Date 06/07/2017: Cải tiến tốc đội lệnh truy vấn
--- Modify by Thị Phượng, Date 30/08/2017: Thay đổi cách sắp xếp order by theo CreateDate
--- Modify by Thị Phượng, Date 08/11/2017: Bổ sung thêm xử lý search nâng cao
--- Modify by Tấn Lộc, Date 17/12/2017: Bổ sung load dữ liệu và lọc dữ liệu theo khách hàng
--- Modify by Trọng Kiên, Date 11/08/2020: Bổ sung value load dữ liệu (BusinessTel, BusinessFax)
--- Modify by Vĩnh Tâm, Date 12/01/2021: Fix lỗi mất phân quyền dữ liệu khi dùng search nâng cao
--- Modify by Anh Tuấn,   Date 31/12/2021: Bổ sung điều kiện chỉ lấy những phiếu có DeleteFlg = 0
--- Modify by Anh Đô, Date 14/12/2022: Thêm SearchWhere và select thêm cột cho trường hợp In/Export
--- Modify by Anh Đô, Date 26/12/2022: Join thêm bảng Nhân viên và select thêm cột CreateUserName cho chức năng In/Export
--- Modify by Hoài Thanh, Date 10/01/2023: Bổ sung luồng load dữ liệu từ dashboard
--- Modified by: Hoài Bảo Date 09/02/2023: Bổ sung luồng load dữ liệu từ màn hình truy vấn ngược
-- <Example>
/* 
 EXEC CRMP10001 'AS', 'AS'', ''GS', '', '', '', '', '', '', '', '', '', '', '', 'NV01', 1, 20, N'ASOFTADMIN'', ''DANH'', ''HOANG'', ''HUYEN'', ''LIEN'', ''LUAN'', ''PHUONG'', ''QUI'', ''QUYNH'', ''VU', 0, ''
*/
----
CREATE PROCEDURE CRMP10001 (
		@DivisionID VARCHAR(50) = '',
		@DivisionIDList NVARCHAR(2000) = '',
		@FromDate DATETIME = NULL,
		@ToDate DATETIME = NULL,
		@IsPeriod INT = 0,
		@PeriodList VARCHAR(MAX) = '',
		@ContactID NVARCHAR(50) = '',
		@ContactName NVARCHAR(250) = '',
		@AccountID NVARCHAR(250) = '',
		@Prefix NVARCHAR(250) = '',
		@Address NVARCHAR(100) = '',
		@HomeMobile NVARCHAR(100) = '',
		@HomeTel NVARCHAR(100) = '',
		@HomeFax NVARCHAR(100) = '',
		@HomeEmail NVARCHAR(100) = '',
		@Messenger NVARCHAR(100) = '',
		@IsCommon VARCHAR(50) = '',
		@Disabled NVARCHAR(100) = '',
		@UserID VARCHAR(50) = '',
		@PageNumber INT = 1,
		@PageSize INT = 25,
		@ConditionContactID NVARCHAR(MAX),
		@IsExcel BIT = 0, --1: thực hiện xuất file Excel; 0: Thực hiện Filter,
		@SearchWhere NVARCHAR(MAX) = NULL,
		@Type INT = 2, -- Type = 6: từ dashboard -> danh mục
		@RelAPK NVARCHAR(250) = '',
		@RelTable NVARCHAR(250) = ''
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere1 NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX),
		@sWhereDashboard NVARCHAR(MAX) = '',
		@OrderBy NVARCHAR(500),
		@TotalRow NVARCHAR(50),
		@subQuery NVARCHAR(MAX),
		@subWhere NVARCHAR(MAX),
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)

SET @sWhere = ''
SET @subQuery = ''
SET @subWhere = ''
SET @TotalRow = ''
SET @OrderBy = 'CRMT10001.CreateDate DESC'
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
--Check Para DivisionIDList NULL THEN get DivisionID 
IF ISNULL(@SearchWhere, '') = ''
BEGIN
	IF ISNULL(@DivisionIDList, '') = ''
		SET @sWhere = @sWhere + 'CRMT10001.DivisionID IN ( ''' + @DivisionID + ''', ''@@@'')'
	ELSE 
		BEGIN
			SET @sWhere = @sWhere + 'CRMT10001.DivisionID IN (''' + @DivisionIDList + ''', ''@@@'')'
			SET @sWhereDashboard = @sWhereDashboard + 'CRMT10001.DivisionID IN (''' + @DivisionIDList + ''', ''@@@'')'
		END
		
	IF ISNULL(@ContactID, '') != ''
		SET @sWhere = @sWhere + ' AND CRMT10001.ContactID LIKE N''%' + @ContactID + '%'' '
	IF ISNULL(@ContactName, '') != '' 
		SET @sWhere = @sWhere + ' AND ISNULL(CRMT10001.ContactName, '''') LIKE N''%' + @ContactName + '%'' '
	IF ISNULL(@Prefix, '') != '' 
		SET @sWhere = @sWhere + 'AND ISNULL(CRMT10001.Prefix, '''') LIKE N''%' + @Prefix + '%'' '
	IF ISNULL(@Address, '') != '' 
		SET @sWhere = @sWhere + 'AND ISNULL(CRMT10001.Address, '''') LIKE N''%' + @Address + '%'' '
	IF ISNULL(@HomeMobile, '') != ''
		SET @sWhere = @sWhere + 'AND ISNULL(CRMT10001.HomeMobile, '''') LIKE N''%' + @HomeMobile + '%'' '
	IF ISNULL(@HomeTel, '') != ''
		SET @sWhere = @sWhere + 'AND ISNULL(CRMT10001.HomeTel, '''') LIKE N''%' + @HomeTel + '%'' '
	IF ISNULL(@HomeFax, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(CRMT10001.HomeFax, '''') LIKE N''%' + @HomeFax + '%'' '
	IF ISNULL(@HomeEmail, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(CRMT10001.HomeEmail, '''') LIKE N''%' + @HomeEmail + '%'' '
	IF ISNULL(@Messenger, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(CRMT10001.Messenger, '''') LIKE N''%' + @Messenger + '%'' '
	IF ISNULL(@IsCommon, '') != ''
		SET @sWhere = @sWhere + 'AND ISNULL(CRMT10001.IsCommon, '''') LIKE N''%' + @IsCommon + '%'' '
	IF ISNULL(@Disabled, '') != '' 
		SET @sWhere = @sWhere + ' AND ISNULL(CRMT10001.Disabled, '''') LIKE N''%' + @Disabled + '%'' '
	IF ISNULL(@ConditionContactID, '') != ''
		BEGIN
			SET @sWhere = @sWhere + ' AND ISNULL(CRMT10001.CreateUserID, '''') IN (''' + @ConditionContactID + ''' )'
			SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(CRMT10001.CreateUserID, '''') IN (''' + @ConditionContactID + ''' )'
		END
	IF ISNULL(@AccountID, '') != ''
		SET @subWhere = @subWhere + ' AND (A1.ObjectName LIKE N''%' + @AccountID + '%'' OR C1.AccountID LIKE N''%' + @AccountID + '%'') '
END

	-- Check Para FromDate và ToDate
	-- Trường hợp search theo từ ngày đến ngày
IF @IsPeriod = 0
BEGIN
	IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + ' AND (CRMT10001.CreateDate >= ''' + @FromDateText + '''
											OR CRMT10001.CreateDate >= ''' + @FromDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')   
		BEGIN
			SET @sWhere = @sWhere + ' AND (CRMT10001.CreateDate <= ''' + @ToDateText + ''' 
											OR CRMT10001.CreateDate <= ''' + @ToDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (CRMT10001.CreateDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
		END
END
ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(CRMT10001.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
		SET @sWhereDashboard = @sWhereDashboard + ' AND (SELECT FORMAT(CRMT10001.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
	END

IF ISNULL(@SearchWhere, '') != ''
BEGIN
	SET @sWhere = '1 = 1'
	IF ISNULL(@ConditionContactID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(CRMT10001.CreateUserID, '''') IN (''' + @ConditionContactID + ''' )'
END

IF ISNULL(@subWhere, '') != ''
BEGIN
	SET @subQuery = 'INNER JOIN (
		SELECT ContactID, ObjectName
		FROM CRMT10102 C1 WITH (NOLOCK)
			INNER JOIN AT1202 A1 WITH (NOLOCK) ON C1.AccountID = A1.ObjectID
		WHERE 1 = 1 ' + @subWhere + '
	) C1 ON C1.ContactID = CRMT10001.ContactID '
END
SET @sWhere = @sWhere + ' AND ISNULL(CRMT10001.DeleteFlg,0) = 0 '
SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(CRMT10001.DeleteFlg,0) = 0 '

IF @Type = 6
	SET @sWhere1 = N' WHERE ' + @sWhereDashboard + ' '
ELSE --@Type = 2
BEGIN
	IF (ISNULL(@RelAPK, '') != '' AND ISNULL(@RelTable, '') != '')
	BEGIN
		SET @subQuery = 
		CASE
			WHEN @RelTable = 'CRMT20301_CRMT10001_REL' THEN 'LEFT JOIN ' +@RelTable+ ' C WITH (NOLOCK) ON CRMT10001.APK = C.ContactID '
			WHEN @RelTable = 'OOT0088' THEN 'LEFT JOIN ' +@RelTable+ ' C WITH (NOLOCK) ON CRMT10001.APK = C.APKChild '
			WHEN @RelTable = 'CRMT20501_CRMT10001_REL' THEN 'LEFT JOIN ' +@RelTable+ ' C WITH (NOLOCK) ON CRMT10001.APK = C.ContactID '
			WHEN @RelTable = 'CRMT10102' THEN 'LEFT JOIN ' +@RelTable+ ' C WITH (NOLOCK) ON C.ContactID = CRMT10001.ContactID 
											   LEFT JOIN POST0011 C2 WITH (NOLOCK) ON C.AccountID = C2.MemberID
											   '
			WHEN @RelTable = 'OOT2170' THEN 'LEFT JOIN ' +@RelTable+ ' C WITH (NOLOCK) ON CRMT10001.ContactID = C.ContactID '
			ELSE @subQuery
		END

		SET @sWhere1 = 
		CASE
			WHEN @RelTable = 'CRMT20301_CRMT10001_REL' THEN 'WHERE CRMT10001.DivisionID = ''' +@DivisionID+ ''' AND C.LeadID = ''' +@RelAPK+''' AND CRMT10001.DeleteFlg = 0'
			WHEN @RelTable = 'OOT0088' THEN 'WHERE CRMT10001.DivisionID = ''' +@DivisionID+ ''' AND C.APKParent = ''' +@RelAPK+''' AND CRMT10001.DeleteFlg = 0'
			WHEN @RelTable = 'CRMT20501_CRMT10001_REL' THEN 'WHERE CRMT10001.DivisionID = ''' +@DivisionID+ ''' AND C.OpportunityID = ''' +@RelAPK+''' AND CRMT10001.DeleteFlg = 0'
			WHEN @RelTable = 'CRMT10102' THEN 'WHERE CRMT10001.DivisionID = ''' +@DivisionID+ ''' AND C2.APK = ''' +@RelAPK+''' AND CRMT10001.DeleteFlg = 0'
			WHEN @RelTable = 'OOT2170' THEN 'WHERE CRMT10001.DivisionID = ''' +@DivisionID+ ''' AND C.APK = ''' +@RelAPK+''' AND CRMT10001.DeleteFlg = 0'
			ELSE N' WHERE ' + @sWhere + ' '
		END
	END
	ELSE
		SET @sWhere1 = N' WHERE ' + @sWhere + ' '
END

IF @IsExcel = 0
	SET @sSQL = '
		SELECT CRMT10001.APK, CASE WHEN ISNULL(CRMT10001.IsCommon, 0) = 1 THEN '''' ELSE CRMT10001.DivisionID END AS DivisionID, CRMT10001.Address
				, CRMT10001.ContactID, CRMT10001.ContactName, AT0099.Description AS Prefix
				, CRMT10001.HomeMobile, CRMT10001.HomeTel, CRMT10001.HomeFax, CRMT10001.HomeEmail, CRMT10001.Messenger
				, CRMT10001.IsCommon, CRMT10001.Disabled, CRMT10001.CreateUserID
				, CRMT10001.CreateDate, CRMT10001.LastModifyUserID, CRMT10001.LastModifyDate
				, CRMT10001.DepartmentName, CRMT10001.TitleContact, CRMT10001.BirthDate, CRMT10001.PlaceOfBirth
				, CRMT10001.HomeWardID, CRMT10001.HomeDistrictID, CRMT10001.HomeCityID, CRMT10001.HomePostalCodeID, CRMT10001.HomeCountryID 
				, D.CountryName, E.CityName, F.DistrictName, CRMT10001.BusinessTel, CRMT10001.BusinessFax
				, STUFF((SELECT '', '' + '' '' + A1.ObjectID
					FROM CRMT10102 C1 WITH (NOLOCK)
					LEFT JOIN AT1202 A1 WITH (NOLOCK) ON A1.ObjectID = C1.AccountID
					WHERE C1.ContactID = CRMT10001.ContactID
					FOR XML PATH('''')), 1, 1, '''') AS AccountID
				, STUFF((SELECT '', '' + '' '' + A1.ObjectName
					FROM CRMT10102 C1 WITH (NOLOCK)
					LEFT JOIN AT1202 A1 WITH (NOLOCK) ON A1.ObjectID = C1.AccountID
					WHERE C1.ContactID = CRMT10001.ContactID
					FOR XML PATH('''')), 1, 1, '''') AS AccountName
		INTO #TempCRMT10001
		FROM CRMT10001 WITH (NOLOCK) 
			LEFT JOIN AT1001 D WITH (NOLOCK) ON CRMT10001.HomeCountryID = D.CountryID
			LEFT JOIN AT1002 E WITH (NOLOCK) ON CRMT10001.HomeCityID = E.CityID
			LEFT JOIN AT1013 F WITH (NOLOCK) ON CRMT10001.HomeDistrictID = F.DistrictID
			LEFT JOIN AT0099 WITH (NOLOCK) ON CRMT10001.Prefix = AT0099.ID AND AT0099.CodeMaster = ''AT00000002''
			' + @subQuery + '
		' + @sWhere1 + '
		DECLARE @Count int
		SELECT @Count = COUNT(IsCommon) FROM #TempCRMT10001
		' + ISNULL(@SearchWhere, '') + '
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow, CRMT10001.APK
				, CRMT10001.DivisionID, CRMT10001.Address, CRMT10001.ContactID, CRMT10001.ContactName
				, CRMT10001.Prefix, CRMT10001.HomeMobile, CRMT10001.HomeTel, CRMT10001.HomeFax, CRMT10001.HomeEmail, CRMT10001.Messenger
				, CRMT10001.IsCommon, CRMT10001.Disabled, CRMT10001.CreateUserID
				, CRMT10001.CreateDate, CRMT10001.LastModifyUserID, CRMT10001.LastModifyDate
				, CRMT10001.DepartmentName, CRMT10001.TitleContact, CRMT10001.BirthDate, CRMT10001.PlaceOfBirth
				, CRMT10001.HomeWardID, CRMT10001.HomeDistrictID, CRMT10001.HomeCityID, CRMT10001.HomePostalCodeID, CRMT10001.HomeCountryID 
				, CRMT10001.CountryName, CRMT10001.CityName, CRMT10001.DistrictName, CRMT10001.AccountName, CRMT10001.AccountID
				, CRMT10001.BusinessTel, CRMT10001.BusinessFax
		FROM #TempCRMT10001 CRMT10001
		' + ISNULL(@SearchWhere, '') + '
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber-1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '

IF @IsExcel = 1
	SET @sSQL = '
		SELECT  CRMT10001.APK,
				CASE WHEN ISNULL(CRMT10001.IsCommon, 0) = 1 THEN '''' ELSE CRMT10001.DivisionID END AS DivisionID
				, CRMT10001.Address
				, CRMT10001.ContactID
				, CRMT10001.ContactName
				, AT0099.Description AS Prefix
				, CRMT10001.HomeMobile
				, CRMT10001.HomeTel
				, CRMT10001.HomeFax
				, CRMT10001.HomeEmail
				, CRMT10001.Messenger
				, CRMT10001.IsCommon
				, CRMT10001.Disabled
				, CRMT10001.CreateUserID
				, CRMT10001.CreateDate
				, CRMT10001.LastModifyUserID
				, CRMT10001.LastModifyDate
				, CRMT10001.BusinessTel
				, CRMT10001.BusinessFax
				, CRMT10001.TitleContact
				, CRMT10001.DepartmentName
				, CRMT10001.BirthDate
				, CRMT10001.BusinessEmail
				, CRMT10001.Description
				, A1.FullName AS CreateUserName
		INTO #TempCRMT10001
		FROM CRMT10001 WITH (NOLOCK)
			LEFT JOIN AT0099 WITH (NOLOCK) ON CRMT10001.Prefix = AT0099.ID AND AT0099.CodeMaster = ''AT00000002''
			LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = CRMT10001.CreateUserID
		WHERE ' + @sWhere + ' ' + @SearchWhere +'
		DECLARE @Count int
		SELECT @Count = COUNT(IsCommon) FROM #TempCRMT10001

		SELECT  ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow
				, CRMT10001.APK
				, CRMT10001.DivisionID
				, CRMT10001.Address
				, CRMT10001.ContactID
				, CRMT10001.ContactName
				, CRMT10001.Prefix
				, CRMT10001.HomeMobile
				, CRMT10001.HomeTel
				, CRMT10001.HomeFax
				, CRMT10001.HomeEmail
				, CRMT10001.Messenger
				, CRMT10001.IsCommon
				, CRMT10001.Disabled
				, CRMT10001.CreateUserID
				, CRMT10001.CreateDate
				, CRMT10001.LastModifyUserID
				, CRMT10001.LastModifyDate
				, CRMT10001.BusinessTel
				, CRMT10001.BusinessFax
				, CRMT10001.TitleContact
				, CRMT10001.DepartmentName
				, CRMT10001.BirthDate
				, CRMT10001.BusinessEmail
				, CRMT10001.Description
				, CRMT10001.CreateUserName
		FROM #TempCRMT10001 CRMT10001
		ORDER BY ' + @OrderBy + ''
EXEC (@sSQL)
--PRINT(@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
