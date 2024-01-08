IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP1100]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP1100]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load grid master danh mục Tổ hợp
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
--
-- <History>
---- Created  on 05/08/2022 by Tuyên
-- <Example> exec OOP1100 @DivisionID=N'CHP',@ScreenID=N'OOF1100',@PageNumber=1,@PageSize=25,@DivisionIDList=N'',@UserID=N'GIANGNG',@FromDate='2022-06-01 00:00:00',@ToDate='2022-08-31 00:00:00',@IsPeriod=0,@PeriodList=N'',@GroupID=N'',@GroupName=N'',@CreateUserID=N''

CREATE PROCEDURE [dbo].[OOP1100]
( 
	 @DivisionID VARCHAR(50),
	 @ScreenID VARCHAR(50),

	 @PageNumber INT,
	 @PageSize INT,
	 @DivisionIDList NVARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @IsPeriod INT,
	 @PeriodList VARCHAR(MAX),

	 @GroupID NVARCHAR(250),
	 @GroupName NVARCHAR(250),
	 @CreateUserID VARCHAR(50),

	 @ConditionDocumentManagement  VARCHAR(MAX) = NULL
)
AS 
	DECLARE @sSQL NVARCHAR (MAX) = N'',
			@sSQL02 NVARCHAR (MAX) = N'',
			@OrderBy NVARCHAR(MAX) = N'', 
			@TotalRow NVARCHAR(50) = N'',
			@sWhere NVARCHAR(MAX),
			@sSQLPermission NVARCHAR(MAX) = '',
			@FromDateText NVARCHAR(20),
			@ToDateText NVARCHAR(20),
			@sJoin VARCHAR(MAX) = ''

	SET @OrderBy = 'M.CreateDate DESC'
	SET @sWhere = ''
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 111)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 111) + ' 23:59:59'

	-- Check Para DivisionIDList null then get DivisionID:
	IF ISNULL(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' M.DivisionID IN (''' + @DivisionIDList + ''')'
	ELSE 
		SET @sWhere = @sWhere + ' M.DivisionID IN (''' + @DivisionID + ''')'
	

	-- From Date:
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
	-- Period:
	IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
		BEGIN
			SET @sWhere = @sWhere + ' AND (SELECT FORMAT(M.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
		END

	-- Data Filter:
	IF ISNULL(@GroupID, '') != ''
		SET @sWhere = @sWhere + ' AND M.GroupID IN ( ''' + @GroupID + ''') '

	IF ISNULL(@GroupName, '') != ''
		SET @sWhere = @sWhere + ' AND M.GroupName IN ( ''' + @GroupName + ''') '

	IF ISNULL(@CreateUserID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.CreateUserID, '''') LIKE N''%' + @CreateUserID + '%'' '

	-- Page:
	IF  @PageNumber = 1 SET @TotalRow = 'COUNT OVER ()' ELSE SET @TotalRow = 'NULL'

	SET @sSQL = @sSQL + N'SELECT * INTO #TempOOT1100 FROM (
							 SELECT
								    M.APK
								  , M.GroupID
								  , M.GroupName
								  , M.CreateUserID
								  , M.UserMarkedID
								  , M.DivisionID
								  , M.CreateDate
								  , M.LastModifyDate
								  , M.LastModifyUserID
								  , A1.FullName AS CreateUserName 
								  , ROW_NUMBER() OVER (PARTITION BY M.GroupID ORDER BY M.GroupID) AS RowNumber

		 
		FROM CIT1210 M WITH (NOLOCK) 
			' + @sJoin + ' 
			LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.CreateUserID 
		WHERE  ' + @sWhere + ' 
		AND M.DivisionID = ''' + @DivisionID + ''' ) AS tmp WHERE tmp.RowNumber =1  
		'
	SET @sSQL02 = '
		DECLARE @Count INT 
		SELECT @Count = COUNT(*) FROM #TempOOT1100 

		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, 
			@Count AS TotalRow 
			, M.APK
			, M.GroupID
			, M.GroupName
			, M.CreateUserID
			, M.UserMarkedID
			, M.DivisionID
			, M.CreateDate
			, M.LastModifyDate
			, M.LastModifyUserID
			, M.CreateUserName 
		FROM #TempOOT1100 M 
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY
		'

	PRINT (@sSQL)
	--PRINT (@sSQL)
	--PRINT (@sSQL02)
	EXEC ( @sSQL+ @sSQL02)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
