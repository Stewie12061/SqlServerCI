IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2220]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2220]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO












-- <Summary>
---- Load grid danh mục Email
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 10/08/2020 by Tấn Lộc

CREATE PROCEDURE [dbo].[OOP2220]
( 
	 @DivisionID VARCHAR(50),
	 @DivisionIDList NVARCHAR(MAX),
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @IsPeriod INT,
	 @PeriodList VARCHAR(MAX),
	 @SubjectName NVARCHAR(250),
	 @From NVARCHAR(250),
	 @To NVARCHAR(250),
	 @Cc NVARCHAR(250),
	 @Bcc NVARCHAR(250),
	 @StatusID NVARCHAR(250),
	 @CreateUserID NVARCHAR (250),
	 @IsCommon NVARCHAR(100), 
	 @Disabled NVARCHAR(100),
	 @ConditionReceiveEmailManagement VARCHAR(MAX),
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


	SET @OrderBy = 'M.SendMailDate DESC'
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

	IF ISNULL(@SubjectName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.SubjectName, '''') LIKE N''%' + @SubjectName + '%'' '

	IF ISNULL(@From, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.[From], '''') LIKE N''%' + @From + '%'' '

	IF ISNULL(@To, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.[To], '''') LIKE N''%' + @To + '%'' '

	IF ISNULL(@Cc, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Cc, '''') LIKE N''%' + @Cc + '%'' '

	IF ISNULL(@Bcc, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Bcc, '''') LIKE N''%' + @Bcc + '%'' '

	IF ISNULL(@CreateUserID, '') != ''
		SET @sWhere = @sWhere + ' AND (M.CreateUserID LIKE N''%' + @CreateUserID + '%'' OR A1.FullName LIKE N''%' + @CreateUserID + '%'') '

	IF ISNULL(@StatusID,'') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.StatusID, '''') IN (''' + @StatusID + ''') '

	IF  @PageNumber = 1 SET @TotalRow = 'COUNT OVER ()' ELSE SET @TotalRow = 'NULL'

	SET @sSQLPermission = N'IF OBJECT_ID(''tempdb..#PermissionOOT2220'') IS NOT NULL DROP TABLE #PermissionOOT2220
								
							SELECT Value
							INTO #PermissionOOT2220
							FROM STRINGSPLIT(''' + ISNULL(@ConditionReceiveEmailManagement, '') + ''', '','')

							IF OBJECT_ID(''tempdb..#FilterReceiveEmailAPK'') IS NOT NULL DROP TABLE #FilterReceiveEmailAPK

							SELECT DISTINCT M.APK
							INTO #FilterReceiveEmailAPK
							FROM CMNT90051 M WITH (NOLOCK)
									LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.CreateUserID
									LEFT JOIN OOT1040 O2 WITH (NOLOCK) ON M.StatusID = O2.StatusID
									INNER JOIN #PermissionOOT2220 T1 ON T1.Value IN (M.CreateUserID)
							WHERE ' + @sWhere + ' '

	
	SET @sSQL = @sSQL + N'
		SELECT M.APK, M.DivisionID, M.UIDMail, M.SubjectName, M.[From]
			   , M.[To], M.Cc, M.Bcc, M.UserID, M.CreateDate, O2.Color, O2.StatusName AS StatusName, M.StatusID
			   , M.CreateUserID, A1.FullName AS CreateUserName, M.TypeOfEmail, M.CreateDate AS Date, M.SendMailDate
			   , M.Description, M.ReplyTo, M.References_ReplyTo, M.APKEmail_ChooseReply, M.Forward, M.References_Forward, M.APKEmail_ChooseForward
		INTO #TempCMNT90051
		FROM CMNT90051 M WITH (NOLOCK)
			INNER JOIN #FilterReceiveEmailAPK T1 ON T1.APK = M.APK
			LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.CreateUserID
			LEFT JOIN OOT1040 O2 WITH (NOLOCK) ON M.StatusID = O2.StatusID
			INNER JOIN AT14052 A2 WITH (NOLOCK) ON M.UserID = A2.UserID
		WHERE  ' + @sWhere +   ' AND M.DivisionID = ''' + @DivisionID + ''' 
			AND ISNULL(M.DeleteFlg, 0) = 0 
			AND M.UserID = ''' +@UserID +''' 
			--AND A2.Email in (M.[From], M.[To], M.Cc)
			AND M.TypeOfEmail = 2

		DECLARE @Count INT
		SELECT @Count = COUNT(*) FROM #TempCMNT90051
		
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow
			  , M.APK
			  , M.DivisionID
			  , M.UIDMail
			  , M.SubjectName
			  , M.[From]
			  , M.[To]
			  , M.Cc
			  , M.Bcc
			  , M.UserID
			  , M.CreateDate
			  , M.CreateUserID
			  , M.CreateUserName
			  , M.Color
			  , M.StatusID
			  , M.StatusName
			  , M.TypeOfEmail
			  , M.Date
			  , M.SendMailDate
			  , M.Description
			  , M.ReplyTo
			  , M.References_ReplyTo
			  , M.APKEmail_ChooseReply
			  , M.Forward
			  , M.References_Forward
			  , M.APKEmail_ChooseForward
		FROM #TempCMNT90051 M
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
