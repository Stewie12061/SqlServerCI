IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP3033]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP3033]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Báo cáo quản lý văn bản.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
--
-- <History>
---- Created on 03/06/2022 by Văn Tài
---- Modifile on 09/06/2011 by Đức Tuyên: lấy theo thông tin trường Người có thẩm quyền DecidedToUserName 
---- Modifile on 28/06/2022 by Văn Tài	: Lấy thông tin người duyệt OUTER để tránh INNER JOIN.
---- Modified on 08/07/2022 by Đức Tuyên- Bổ sung dữ liệu cho các trường.
---- Modified on 15/07/2022 by Đức Tuyên- Load danh sách theo ngày tạo văn bản lên hệ thống.
----Editted by: Nhật Quang , Date: 04/08/2022: Bổ sung thêm số lượng người theo dõi từ 20 lên 50.
-- <Example> EXEC KPIP2030 @DivisionID = 'DTI', @DivisionIDList = '', @UserID = 'TANLOC', @PageNumber='1', @PageSize='25','VANTOAI',0,0
CREATE PROCEDURE [dbo].[OOP3033]
( 
	 @DivisionID VARCHAR(50),
	 @DivisionIDList NVARCHAR(MAX),	 
	 @UserID VARCHAR(50), 
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @IsPeriod INT,
	 @CheckListPeriodControl VARCHAR(MAX) = NULL,
	 @DocumentMode VARCHAR(MAX) = NULL,
	 @DocumentTypeID NVARCHAR(250) = NULL,
	 @ConditionDocumentManagement  VARCHAR(MAX) = NULL
)
AS
	DECLARE @sSQL VARCHAR (MAX) = N'',
     		@OrderBy NVARCHAR(MAX) = N'', 
			@TotalRow NVARCHAR(50) = N'',
			@sWhere NVARCHAR(MAX),
			@sSQLPermission NVARCHAR(MAX) = '',
			@FromDateText NVARCHAR(20),
			@ToDateText NVARCHAR(20),
			@sJoin VARCHAR(MAX) = ''

	SET @OrderBy = 'M.DivisionID, M.CreateDate DESC'
	SET @sWhere = ''
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 111)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 111) + ' 23:59:59'

	-- Check Para DivisionIDList null then get DivisionID
	IF ISNULL(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' M.DivisionID IN (''' + @DivisionIDList + ''')'
	ELSE 
		SET @sWhere = @sWhere + ' M.DivisionID IN (''' + @DivisionID + ''')'

	SET @sWhere = @sWhere + ' AND ISNULL(M.DeleteFlg, 0) = 0'
	
	-- Từ ngày.
	IF @IsPeriod = 0
	BEGIN
		IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
			BEGIN
				SET @sWhere = @sWhere + ' AND 
				(
					M.CreateDate >= ''' + @FromDateText + '''
				)'
			END
		ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (
					M.CreateDate <= ''' + @ToDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (
				M.CreateDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
			END
	END
	ELSE 
	-- Chọn kỳ
	IF @IsPeriod = 1 AND ISNULL(@CheckListPeriodControl, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(ISNULL(M.ReceivedDate,  M.SentDate), ''MM/yyyy'')) IN ( ''' + @CheckListPeriodControl + ''') '
	END
	
	IF ISNULL(@DocumentMode, '') != ''
		SET @sWhere = @sWhere + ' AND M.DocumentMode IN ( ''' + @DocumentMode + ''') '

	IF ISNULL(@DocumentTypeID, '') != ''
		SET @sWhere = @sWhere + ' AND M.DocumentTypeID IN ( ''' + @DocumentTypeID + ''') '

	IF (ISNULL(@ConditionDocumentManagement, '') != '')
	BEGIN
		SET @sSQLPermission = N'IF OBJECT_ID(''tempdb..#PermissionOOT2340'') IS NOT NULL DROP TABLE #PermissionOOT2340
								
							SELECT UserID Value
							INTO #PermissionOOT2340
							FROM AT1405
							WHERE 
							UserID IN (''' + ISNULL(@ConditionDocumentManagement, '') + ''')

							SELECT DISTINCT M.APK
							INTO #FilterIssuesAPK
							FROM OOT2340 M WITH (NOLOCK)
							LEFT JOIN #PermissionOOT2340 T1 ON M.AssignedToUserID = T1.Value 
																	OR M.CreateUserID = T1.Value
																	OR M.DecidedToUserID = T1.Value
							LEFT JOIN OOT2341 OT41 WITH (NOLOCK) ON OT41.DivisionID = M.DivisionID 
																	AND OT41.DocumentID = M.DocumentID
																	AND OT41.FollowerID = ''' + @UserID + '''
							LEFT JOIN OOT9020 OT92 WITH (NOLOCK) ON OT92.DivisionID = M.DivisionID
																	AND ''' + @UserID + '''
																		IN
																		(
																			FollowerID01
																			, FollowerID02
																			, FollowerID03
																			, FollowerID04
																			, FollowerID05
																			, FollowerID06
																			, FollowerID07
																			, FollowerID08
																			, FollowerID09
																			, FollowerID10
																			, FollowerID11
																			, FollowerID12
																			, FollowerID13
																			, FollowerID14
																			, FollowerID15
																			, FollowerID16
																			, FollowerID17
																			, FollowerID18
																			, FollowerID19
																			, FollowerID20
																			, FollowerID21
																			, FollowerID22
																			, FollowerID23
																			, FollowerID24
																			, FollowerID25
																			, FollowerID26
																			, FollowerID27
																			, FollowerID28
																			, FollowerID29
																			, FollowerID30
																			, FollowerID31
																			, FollowerID32
																			, FollowerID33
																			, FollowerID34
																			, FollowerID35
																			, FollowerID36
																			, FollowerID37
																			, FollowerID38
																			, FollowerID39
																			, FollowerID40
																			, FollowerID41
																			, FollowerID42
																			, FollowerID43
																			, FollowerID44
																			, FollowerID45
																			, FollowerID46
																			, FollowerID47
																			, FollowerID48
																			, FollowerID49
																			, FollowerID50
																		)

							WHERE  ' + @sWhere + ' 
							AND (
									OT41.APK IS NOT NULL
									OR
									OT92.APK IS NOT NULL
									OR
									ISNULL(T1.Value, '''')  <> ''''
								)
							AND ISNULL(M.DeleteFlg, 0) = 0
							'
		SET @sJoin = ' 
			INNER JOIN #FilterIssuesAPK T1 ON CONVERT(VARCHAR(50), T1.APK) = CONVERT(VARCHAR(50), M.APK)
			'
	END
	ELSE
	BEGIN
		SET @sSQLPermission = N'
							SELECT '''' AS APK
							INTO #FilterIssuesAPK
							'
	END

	SET @sSQL = @sSQL + N' SELECT
								    M.APK
								  , M.APKMaster_9000
								  , M.DivisionID
								  , M.TranYear
								  , M.TranMonth
								  , M.DocumentID
								  , M.DocumentNumberInto
								  , M.DocumentName
								  , M.DocumentMode
								  , M.UseDocumentTypeName
								  , M.DocumentTypeID
								  , M.IsInternal
								  , M.Status
								  , M.SignedStatus
								  , M.ComposePlace
								  , M.PublishPlace
								  , CASE WHEN (M.DocumentMode = ''VBDEN'') 
										 THEN M.ReceivedDate
										 ELSE M.SentDate
										END
										AS ReceivedDate
								  ,  CASE WHEN (M.DocumentMode = ''VBDEN'') 
										 THEN M.SentPlace
										 ELSE M.ReceivedPlace
										END
										AS ReceivedPlace
								 , CASE WHEN (M.DocumentMode = ''VBDEN'') 
										 THEN M.ReceivedDate
										 ELSE M.SentDate
										END
										AS SentDate
								  ,  CASE WHEN (M.DocumentMode = ''VBDEN'') 
										 THEN M.SentPlace
										 ELSE M.ReceivedPlace
										END
										AS SentPlace
								  , M.DocumentSignDate
								  , M.UseSignerName
								  , M.UseSignerDutyName
								  , M.UseSignerAuthority
								  , M.OutOfDate
								  , M.Summary
								  , M.AssignedToUserID
								  , M.DecidedToUserID
								  , M.HardStoreDepartmentID
								  , A0.DepartmentName AS HardStoreDepartmentName
								  , M.DeleteFlg
								  , M.CreateUserID
								  , M.CreateDate
								  , M.LastModifyUserID
								  , M.LastModifyDate
								  , OT90.Description AS DocumentTypeName
								  , OT92.Description AS StatusName
								  , OT91.Description AS SignedStatusName								  
								  , CONCAT(M.AssignedToUserID, '' - '', A1.FullName) AS AssignedToUserName
								  , A2.FullName AS DecidedToUserName
								  , ISNULL(A4.FullName, A3.FullName) AS Signer
		INTO #TempOOT2340
		FROM OOT2340 M WITH (NOLOCK)
			' + @sJoin + '
			LEFT JOIN OOT0099 OT90 WITH (NOLOCK) ON OT90.CodeMaster = N''OOF2340.DocumentType'' AND OT90.ID = M.DocumentTypeID
			LEFT JOIN OOT0099 OT91 WITH (NOLOCK) ON OT91.CodeMaster = N''OOF2340.SignedStatus'' AND OT91.ID = M.SignedStatus
			LEFT JOIN OOT0099 OT92 WITH (NOLOCK) ON OT92.CodeMaster = N''Status'' AND OT92.ID = M.Status
			LEFT JOIN AT1102 A0 WITH (NOLOCK) ON A0.DivisionID = M.DivisionID AND A0.DepartmentID = M.HardStoreDepartmentID
			LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.AssignedToUserID
			LEFT JOIN AT1103 A2 WITH (NOLOCK) ON A2.EmployeeID = M.DecidedToUserID
			OUTER APPLY 
			   ( 
				   SELECT TOP 1 OT41.FollowerID
								, AT1.FullName
				   FROM OOT2341 OT41 WITH (NOLOCK)
				   LEFT JOIN AT1103 AT1 WITH (NOLOCK) ON AT1.EmployeeID = OT41.FollowerID
				   WHERE 
						OT41.DivisionID = M.DivisionID
						AND OT41.APKMaster = M.APK
					ORDER BY OT41.Steps
			   ) A3
			 OUTER APPLY 
			   ( 
				   SELECT TOP 1 OT41.FollowerID
								, AT1.FullName
				   FROM OOT2341 OT41 WITH (NOLOCK)
				   LEFT JOIN AT1103 AT1 WITH (NOLOCK) ON AT1.EmployeeID = OT41.FollowerID
				   WHERE 
						OT41.DivisionID = M.DivisionID
						AND OT41.APKMaster = M.APK
						AND ISNULL(OT41.UseESign, 0) = 1
					ORDER BY OT41.Steps
			   ) A4
		WHERE  ' + @sWhere + ' 
		AND ISNULL(M.DeleteFlg, 0) = 0

		DECLARE @Count INT
		SELECT @Count = COUNT(*) FROM #TempOOT2340
		
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow
			, M.APK
			, M.APKMaster_9000
			, M.DivisionID
			, M.TranYear
			, M.TranMonth
			, M.DocumentID
			, M.DocumentNumberInto
			, M.DocumentName
			, M.DocumentMode
			, M.UseDocumentTypeName
			, M.DocumentTypeID
			, M.DocumentTypeName
			, M.Status
			, M.StatusName
			, M.SignedStatus
			, M.SignedStatusName
			, M.ReceivedDate
			, M.ReceivedPlace
			, M.SentDate
			, M.SentPlace
			, M.ComposePlace
			, M.PublishPlace
			, M.UseSignerName
			, M.UseSignerDutyName
			, M.UseSignerAuthority
			, M.DocumentSignDate
			, M.OutOfDate
			, M.Summary
			, M.AssignedToUserID
			, M.AssignedToUserName
			, M.DecidedToUserName
			, M.DecidedToUserID
			, M.HardStoreDepartmentID
			, M.HardStoreDepartmentName
			, M.DeleteFlg
			, M.CreateUserID
			, M.CreateDate
			, M.LastModifyUserID
			, M.LastModifyDate
			, ISNULL(M.Signer, M.UseSignerName) AS Signer
		FROM #TempOOT2340 M
		ORDER BY ' + @OrderBy + '
		'
		
	PRINT(@sSQLPermission)
	PRINT (@sSQL)
	EXEC (@sSQLPermission + @sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
