IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2090]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2090]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load thông báo newsfeed 
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Update by Anh Tuấn on 23/03/2022 - Bổ sung tên người tạo thông báo, phòng ban người tạo thông báo
----Update by Đoàn Duy on 30/03/2022 - Bổ sung DepartmentName
----Update by Anh Tuấn on 06/04/2022 - Bổ sung mã loại thông báo InformTypeID
----Update by Hoài Bảo on 16/06/2022 - Cập nhật load DepartmentName theo list
-- <Example>

CREATE PROCEDURE [dbo].[OOP2090] (
	@DivisionID VARCHAR(50), 
	@DivisionIDList NVARCHAR(MAX), 
	@FromDate DATETIME,
	@ToDate DATETIME,
	@IsPeriod INT,
	@PeriodList VARCHAR(MAX),
	@EffectDate NVARCHAR(100), 
	@ExpiryDate NVARCHAR(100), 
	@InformType VARCHAR(50), 
	@CreateUserID NVARCHAR(100), 
	@DepartmentID NVARCHAR(100),
	@IsAdmin TINYINT,
	@IsCommon Nvarchar(100), 
	@Disabled NVARCHAR(100), 
	@UserID VARCHAR(50), 
	@PageNumber INT, 
	@PageSize INT
 ) 
AS
DECLARE @sSQL VARCHAR (MAX),
		@sSQL1 VARCHAR (MAX),
		@sWhere NVARCHAR(MAX), 
		@OrderBy NVARCHAR(500),
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)
		
	SET @sWhere = ''
	SET @OrderBy = ' M.CreateDate DESC'
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 111)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 111) + ' 23:59:59'

	-- Check Para DivisionIDList null then get DivisionID 
	IF ISNULL(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' M.DivisionID IN (''' + @DivisionIDList + ''', ''@@@'')'
	Else 
		SET @sWhere = @sWhere + ' M.DivisionID IN (''' + @DivisionID + ''', ''@@@'')'	
		
			-- Check Para FromDate và ToDate
IF @IsPeriod = 0
BEGIN
	IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + ' AND (M.EffectDate >= ''' + @FromDateText + '''
											OR M.ExpiryDate >= ''' + @FromDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (M.EffectDate <= ''' + @ToDateText + ''' 
											OR M.ExpiryDate <= ''' + @ToDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (M.EffectDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + '''
									OR M.ExpiryDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
		END
END
ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(M.EffectDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
	END
	
		

	IF ISNULL(@InformType, '') != ''
		SET @sWhere = @sWhere + ' AND M.InformType LIKE N''%' + @InformType + '%'' '
	
	IF ISNULL(@EffectDate, '') != ''
		SET @sWhere = @sWhere + ' AND (CONVERT(VARCHAR(10), M.EffectDate, 103) = ''' + CONVERT(VARCHAR(10), @EffectDate, 103) + ''' OR (''' + CONVERT(VARCHAR(10), @EffectDate, 103) + ''' Between CONVERT(VARCHAR(10), M.EffectDate, 103) AND CONVERT(VARCHAR(10), M.ExpiryDate, 103)))'
	
	IF ISNULL(@ExpiryDate, '') != ''
		SET @sWhere = @sWhere + ' AND (CONVERT(VARCHAR(10), M.ExpiryDate, 103) = ''' + CONVERT(VARCHAR(10), @ExpiryDate, 103) + ''' OR (''' + CONVERT(VARCHAR(10), @ExpiryDate, 103) + ''' Between CONVERT(VARCHAR(10), M.EffectDate, 103) AND CONVERT(VARCHAR(10), M.ExpiryDate, 103)))'
	
	IF ISNULL(@Disabled, '')!= '' 
		SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled, '''') LIKE N''%' + @Disabled + '%'' '

	IF ISNULL(@CreateUserID, '')!= '' 
		SET @sWhere = @sWhere + ' AND ISNULL(A4.FullName, '''') LIKE N''%' + @CreateUserID + '%'' '

	IF ISNULL(@DepartmentID, '')!= '' 
		SET @sWhere = @sWhere + ' AND ISNULL(M.DepartmentID, '''') LIKE N''%' + @DepartmentID + '%'' '
		
SET @sSQL =	N'

				--1: Select những thông báo có loại thông báo là: "Thông báo chung"
				SELECT M.APK,  M.DivisionID, M.InformID, M.InformName, M.EffectDate, M.ExpiryDate, M.Description, 
				A1.Description AS InformType, M.InformDivisionID, M.Disabled
				, A2.Description AS DisableName, M.CreateDate, M.CreateUserID, A7.DepartmentName AS CreateUserDepartment
				,(SELECT TOP 1 A13.DepartmentID FROM AT1103 A13 with (nolock)  WHERE A13.EmployeeID =  M.CreateUserID) as CreateUserDepartmentID
				, A4.FullName AS CreateUserName, M.LastModifyDate, M.InformType AS InformTypeID
				, M.LastModifyUserID, M.LastModifyUserID + ''_'' + A5.FullName AS LastModifyUserName
				, STUFF((
					SELECT '','' + A1.FullName
					FROM OOT0098 O1 WITH (NOLOCK)
						LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = O1.ObjectID
					WHERE M.APK = O1.APKRel
					FOR XML PATH('''')
					), 1, 1, '''') AS EmployeeID
				, STUFF((
				SELECT '', '' + A1.DepartmentName
				FROM OOT0098 O1 WITH (NOLOCK)
					LEFT JOIN AT1102 A1 WITH (NOLOCK) ON A1.DepartmentID = O1.ObjectID
				WHERE M.APK = O1.APKRel
				FOR XML PATH('''')
				), 1, 1, '''') AS DepartmentName
				INTO #TempOOT2090
				FROM OOT2090 M WITH (NOLOCK) 
					LEFT JOIN AT0099 A1 WITH (NOLOCK) ON M.InformType = A1.ID AND A1.CodeMaster = ''AT00000045''
					LEFT JOIN AT0099 A2 WITH (NOLOCK) ON M.Disabled = A2.ID AND A2.CodeMaster = ''AT00000004''
					LEFT JOIN AT1103 A4 WITH (NOLOCK) ON M.CreateUserID = A4.EmployeeID
					LEFT JOIN AT1103 A5 WITH (NOLOCK) ON M.LastModifyUserID = A5.EmployeeID
					--LEFT JOIN AT1102 A6 WITH (NOLOCK) ON A6.DepartmentID = M.DepartmentID
					LEFT JOIN AT1102 A7 WITH (NOLOCK) ON A7.DepartmentID = A4.DepartmentID
				WHERE ' + @sWhere +   'AND ISNULL(M.DeleteFlag, 0) = 0 AND (M.CreateUserID <> ''' + @UserID + N''' AND InformType = 0) 
									   AND M.EffectDate <= (SELECT FORMAT(GETDATE(), ''yyyy/MM/dd 00:00:00:000'')) AND ISNULL(M.Disabled, 0) = 0 
									   AND (M.ExpiryDate >= (SELECT FORMAT(GETDATE(), ''yyyy/MM/dd 00:00:00:000'')) OR M.ExpiryDate IS NULL)
					
			  --2: Select những thông báo của nhân viên thuộc phòng ban 
					UNION ALL
				SELECT M.APK,  M.DivisionID, M.InformID, M.InformName, M.EffectDate, M.ExpiryDate, M.Description, 
				A1.Description AS InformType, M.InformDivisionID, M.Disabled
				, A2.Description AS DisableName, M.CreateDate, M.CreateUserID, A8.DepartmentName AS CreateUserDepartment
				,(SELECT TOP 1 A13.DepartmentID FROM AT1103 A13 with (nolock)  WHERE A13.EmployeeID =  M.CreateUserID) as CreateUserDepartmentID
				, A4.FullName AS CreateUserName, M.LastModifyDate, M.InformType AS InformTypeID
				, M.LastModifyUserID, M.LastModifyUserID + ''_'' + A5.FullName AS LastModifyUserName
				, STUFF((
					SELECT '','' + A1.FullName
					FROM OOT0098 O1 WITH (NOLOCK)
						LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = O1.ObjectID
					WHERE M.APK = O1.APKRel
					FOR XML PATH('''')
					), 1, 1, '''') AS EmployeeID
				, STUFF((
					SELECT '', '' + A1.DepartmentName
					FROM OOT0098 O1 WITH (NOLOCK)
						LEFT JOIN AT1102 A1 WITH (NOLOCK) ON A1.DepartmentID = O1.ObjectID
					WHERE M.APK = O1.APKRel
					FOR XML PATH('''')
					), 1, 1, '''') AS DepartmentName
				FROM OOT2090 M WITH (NOLOCK) 
					LEFT JOIN AT0099 A1 WITH (NOLOCK) ON M.InformType = A1.ID AND A1.CodeMaster = ''AT00000045''
					LEFT JOIN AT0099 A2 WITH (NOLOCK) ON M.Disabled = A2.ID AND A2.CodeMaster = ''AT00000004''
					LEFT JOIN AT1103 A4 WITH (NOLOCK) ON M.CreateUserID = A4.EmployeeID
					LEFT JOIN AT1103 A5 WITH (NOLOCK) ON M.LastModifyUserID = A5.EmployeeID
					LEFT JOIN AT1102 A8 WITH (NOLOCK) ON A8.DepartmentID = A4.DepartmentID
					--INNER JOIN AT1102 A7 WITH (NOLOCK) ON A7.DepartmentID = M.DepartmentID
					INNER JOIN (SELECT DepartmentID FROM AT1103 WITH (NOLOCK) WHERE EmployeeID = ''' + @UserID + N''') A6 ON A6.DepartmentID IN (SELECT Value FROM StringSplit(M.DepartmentID, '',''))
				WHERE ' + @sWhere + N' AND ISNULL(M.DeleteFlag, 0) = 0 
									  AND M.EffectDate <= (SELECT FORMAT(GETDATE(), ''yyyy/MM/dd 00:00:00:000'')) 
									  AND ISNULL(M.Disabled, 0) = 0 
									  AND (M.ExpiryDate >= (SELECT FORMAT(GETDATE(), ''yyyy/MM/dd 00:00:00:000'')) OR M.ExpiryDate IS NULL)

				--3: Đối với User tạo thông báo thì hiển thị những thông báo do User đó tạo để có thể quản lí xem/xóa/sửa
					UNION ALL
					SELECT M.APK,  M.DivisionID, M.InformID, M.InformName, M.EffectDate, M.ExpiryDate, M.Description, 
				A1.Description AS InformType, M.InformDivisionID, M.Disabled
				, A2.Description AS DisableName, M.CreateDate, M.CreateUserID, A7.DepartmentName AS CreateUserDepartment
				,(SELECT TOP 1 A13.DepartmentID FROM AT1103 A13 with (nolock)  WHERE A13.EmployeeID =  M.CreateUserID) as CreateUserDepartmentID
				, A4.FullName AS CreateUserName, M.LastModifyDate, M.InformType AS InformTypeID
				, M.LastModifyUserID, M.LastModifyUserID + ''_'' + A5.FullName AS LastModifyUserName
				, STUFF((
					SELECT '','' + A1.FullName
					FROM OOT0098 O1 WITH (NOLOCK)
						LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = O1.ObjectID
					WHERE M.APK = O1.APKRel
					FOR XML PATH('''')
					), 1, 1, '''') AS EmployeeID
				, STUFF((
					SELECT '', '' + A1.DepartmentName
					FROM OOT0098 O1 WITH (NOLOCK)
						LEFT JOIN AT1102 A1 WITH (NOLOCK) ON A1.DepartmentID = O1.ObjectID
					WHERE M.APK = O1.APKRel
					FOR XML PATH('''')
					), 1, 1, '''') AS DepartmentName
				FROM OOT2090 M WITH (NOLOCK) 
					LEFT JOIN AT0099 A1 WITH (NOLOCK) ON M.InformType = A1.ID AND A1.CodeMaster = ''AT00000045''
					LEFT JOIN AT0099 A2 WITH (NOLOCK) ON M.Disabled = A2.ID AND A2.CodeMaster = ''AT00000004''
					LEFT JOIN AT1103 A4 WITH (NOLOCK) ON M.CreateUserID = A4.EmployeeID
					LEFT JOIN AT1103 A5 WITH (NOLOCK) ON M.LastModifyUserID = A5.EmployeeID
					--LEFT JOIN AT1102 A6 WITH (NOLOCK) ON A6.DepartmentID = M.DepartmentID
					LEFT JOIN AT1102 A7 WITH (NOLOCK) ON A7.DepartmentID = A4.DepartmentID
				WHERE ' + @sWhere + ' AND ISNULL(M.DeleteFlag, 0) = 0 AND M.CreateUserID = ''' + @UserID + '''
									 AND (M.ExpiryDate >= (SELECT FORMAT(GETDATE(),''yyyy/MM/dd 00:00:00:000'')) OR M.ExpiryDate IS NULL)
									 
				-- 4: Select những thông báo của nhân viên được nhận thông báo
				UNION ALL
				SELECT M.APK,  M.DivisionID, M.InformID, M.InformName, M.EffectDate, M.ExpiryDate, M.Description, 
				A1.Description AS InformType, M.InformDivisionID, M.Disabled
				, A2.Description AS DisableName, M.CreateDate, M.CreateUserID, A7.DepartmentName AS CreateUserDepartment
				,(SELECT TOP 1 A13.DepartmentID FROM AT1103 A13 with (nolock)  WHERE A13.EmployeeID =  M.CreateUserID) as CreateUserDepartmentID
				, A4.FullName AS CreateUserName, M.LastModifyDate, M.InformType AS InformTypeID
				, M.LastModifyUserID, M.LastModifyUserID + ''_'' + A5.FullName AS LastModifyUserName
				, STUFF((
					SELECT '','' + A1.FullName
					FROM OOT0098 O1 WITH (NOLOCK)
						LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = O1.ObjectID
					WHERE M.APK = O1.APKRel
					FOR XML PATH('''')
					), 1, 1, '''') AS EmployeeID
				, STUFF((
					SELECT '', '' + A1.DepartmentName
					FROM OOT0098 O1 WITH (NOLOCK)
						LEFT JOIN AT1102 A1 WITH (NOLOCK) ON A1.DepartmentID = O1.ObjectID
					WHERE M.APK = O1.APKRel
					FOR XML PATH('''')
					), 1, 1, '''') AS DepartmentName
				FROM OOT2090 M WITH (NOLOCK) 
					LEFT JOIN AT0099 A1 WITH (NOLOCK) ON M.InformType = A1.ID AND A1.CodeMaster = ''AT00000045''
					LEFT JOIN AT0099 A2 WITH (NOLOCK) ON M.Disabled = A2.ID AND A2.CodeMaster = ''AT00000004''
					LEFT JOIN AT1103 A4 WITH (NOLOCK) ON M.CreateUserID = A4.EmployeeID
					LEFT JOIN AT1103 A5 WITH (NOLOCK) ON M.LastModifyUserID = A5.EmployeeID
					--LEFT JOIN AT1102 A6 WITH (NOLOCK) ON A6.DepartmentID = M.DepartmentID
					LEFT JOIN AT1102 A7 WITH (NOLOCK) ON A7.DepartmentID = A4.DepartmentID
					INNER JOIN OOT0098 O1 WITH (NOLOCK) ON O1.APKRel = M.APK
				WHERE ' + @sWhere + ' 
					AND ISNULL(M.DeleteFlag, 0) = 0 
					AND O1.ObjectID = ''' + @UserID + ''' AND M.CreateUserID <> ''' + @UserID + N'''
					AND (M.ExpiryDate >= (SELECT FORMAT(GETDATE(),''yyyy/MM/dd 00:00:00:000'')) OR M.ExpiryDate IS NULL) 					  

				DECLARE @count INT
				SELECT @count = COUNT(*) FROM #TempOOT2090

				-- Lọc lại danh sách thông báo trường hợp load trùng thông báo khi UNION giữa các trường hợp
				SELECT DISTINCT * INTO #TempOOT2090_Data FROM #TempOOT2090

				SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow
					, M.APK, M.DivisionID, M.InformID, M.InformName, M.EffectDate, M.ExpiryDate, M.Description
					, M.InformType, M.InformDivisionID, M.DepartmentName AS DepartmentID, M.Disabled, M.DisableName, M.InformTypeID
					, M.CreateDate, M.CreateUserID, M.CreateUserName, M.CreateUserDepartmentID, M.CreateUserDepartment, M.LastModifyDate, M.LastModifyUserID, M.LastModifyUserName, M.EmployeeID				FROM #TempOOT2090_Data M
				ORDER BY ' + @OrderBy + '
				OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
				FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '


SET @sSQL1 =	N'
				-- Nếu User đăng nhập vào thuộc quyền Admin thì lấy hết tất cả các thông báo
				SELECT M.APK,  M.DivisionID, M.InformID, M.InformName, M.EffectDate, M.ExpiryDate, M.Description, 
				A1.Description AS InformType, M.InformDivisionID, M.Disabled
				, A2.Description AS DisableName, M.CreateDate, M.CreateUserID, A7.DepartmentName AS CreateUserDepartment
				,(SELECT TOP 1 A13.DepartmentID FROM AT1103 A13 with (nolock)  WHERE A13.EmployeeID =  M.CreateUserID) as CreateUserDepartmentID
				, A4.FullName AS CreateUserName, M.LastModifyDate, M.InformType AS InformTypeID
				, M.LastModifyUserID, M.LastModifyUserID + ''_'' + A5.FullName AS LastModifyUserName
				, STUFF((
					SELECT '','' + A1.FullName
					FROM OOT0098 O1 WITH (NOLOCK)
						LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = O1.ObjectID
					WHERE M.APK = O1.APKRel
					FOR XML PATH('''')
					), 1, 1, '''') AS EmployeeID
				, STUFF((
					SELECT '', '' + A1.DepartmentName
					FROM OOT0098 O1 WITH (NOLOCK)
						LEFT JOIN AT1102 A1 WITH (NOLOCK) ON A1.DepartmentID = O1.ObjectID
					WHERE M.APK = O1.APKRel
					FOR XML PATH('''')
					), 1, 1, '''') AS DepartmentName
				INTO #TempOOT2090
				FROM OOT2090 M WITH (NOLOCK) 
					LEFT JOIN AT0099 A1 WITH (NOLOCK) ON M.InformType = A1.ID AND A1.CodeMaster = ''AT00000045''
					LEFT JOIN AT0099 A2 WITH (NOLOCK) ON M.Disabled = A2.ID AND A2.CodeMaster = ''AT00000004''
					LEFT JOIN AT1103 A4 WITH (NOLOCK) ON M.CreateUserID = A4.EmployeeID
					LEFT JOIN AT1103 A5 WITH (NOLOCK) ON M.LastModifyUserID = A5.EmployeeID
					--LEFT JOIN AT1102 A6 WITH (NOLOCK) ON A6.DepartmentID = M.DepartmentID
					LEFT JOIN AT1102 A7 WITH (NOLOCK) ON A7.DepartmentID = A4.DepartmentID
				WHERE  '+@sWhere +' AND ISNULL(M.DeleteFlag, 0) = 0
				
				DECLARE @count INT
				SELECT @count = COUNT(*) FROM #TempOOT2090

				SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow
					, M.APK, M.DivisionID, M.InformID, M.InformName, M.EffectDate, M.ExpiryDate, M.Description
					, M.InformType, M.InformDivisionID, M.DepartmentName AS DepartmentID, M.Disabled, M.DisableName, M.InformTypeID
					, M.CreateDate, M.CreateUserID, M.CreateUserName,M.CreateUserDepartmentID, M.CreateUserDepartment, M.LastModifyDate, M.LastModifyUserID, M.LastModifyUserName, M.EmployeeID				
				FROM #TempOOT2090 M
				ORDER BY ' + @OrderBy + '
				OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
				FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY ' 

-- Kiểm tra user đăng nhập có thuộc Admin không bằng biến IsAdmin
-- 0: False
-- 1: True
IF(@IsAdmin = 0)
BEGIN
	EXEC (@sSQL)
	PRINT (@sSQL)

END
ELSE
BEGIN
	EXEC (@sSQL1)
	PRINT (@sSQL1)
END




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
