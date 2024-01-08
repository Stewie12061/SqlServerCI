IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP10801]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP10801]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <History>
----Created by: Lê Thanh Lượng, Date: 05/07/2023
----Modify by: Lê Thanh Lượng, Date: 16/08/2023:[2023/08/IS/0151] - Bổ sung Load dữ liệu theo phân quyền.
----Modify by: Lê Thanh Lượng, Date: 04/10/2023: Bổ sung phân biệt Division
----Modify by: Lê Thanh Lượng, Date: 16/11/2023: [2023/11/IS/0080] - Bổ sung ref Apkmaster với Apk của ObjectID bảng chỉ tiêu.
-- <Example>
--EXEC SOP10801 @DivisionID=N'DTI',@DivisionIDList=N'',@ObjectID=N'',@EmployeeName=N'',@FromDate=NULL,@ToDate=NULL,@IsPeriod=0,@PeriodList=N'',@Year=N'',@IsPlanned=N'',@StatusSS=N'',@ConditionPlanID=N'',@PageNumber=1,@PageSize=25

CREATE PROCEDURE [dbo].[SOP10801] (
  @DivisionID VARCHAR(50),
  @DivisionIDList NVARCHAR(2000),  
  @ObjectID  NVARCHAR(250),
  @EmployeeName  NVARCHAR(250),
  @FromDate Datetime,
  @ToDate Datetime,
  @IsPeriod INT,--0: theo ngày, 1: Theo kỳ
  @PeriodList VARCHAR(MAX),
  @Year NVARCHAR(50),
  @IsPlanned NVARCHAR(50) ='',
  @StatusSS NVARCHAR(250) ='',
  @ConditionPlanID VARCHAR(MAX) = '', -- Biến phân quuyền
  @PageNumber INT,
  @PageSize INT
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sSQL1 NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20),
        @sSQLPermission NVARCHAR(MAX)

SET @sWhere = '1 = 1'
SET @TotalRow = ''
SET @OrderBy = 'x.CreateDate DESC'
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

--Check Para DivisionIDList null then get DivisionID 
	IF ISNULL(@DivisionIDList, '') = ''
		SET @sWhere = @sWhere + 'AND AT01.DivisionID = '''+ @DivisionID+''''
	ELSE 
		SET @sWhere = @sWhere + 'AND AT01.DivisionID IN ('''+@DivisionIDList+''')'

	IF Isnull(@Year, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(YEAR(AT01.ToDate),'''') ='+@Year

	IF Isnull(@ObjectID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(AT01.ObjectID,'''') ='''+ @ObjectID+''''

	IF Isnull(@EmployeeName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(AT01.EmployeeID,'''') ='''+ @EmployeeName+''''

	IF Isnull(@IsPlanned, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(AT01.IsPlanned,'''') ='''+ @IsPlanned+''''

	IF ISNULL(@StatusSS,'') !=''
		SET @sWhere = @sWhere + ' AND (ISNULL(AT01.StatusSS, '''')) = '''+@StatusSS+''''

--Biến phân quyền load danh sách theo phân quyền
			SET @sSQLPermission = N'
			IF OBJECT_ID(''tempdb..#PermissionAT0161'') IS NOT NULL DROP TABLE #PermissionAT0161						
			SELECT Value
			INTO #PermissionAT0161
			FROM STRINGSPLIT(''' + ISNULL(@ConditionPlanID, '') + ''', '','')'

 SET @sSQL = '
			SELECT DISTINCT A01.APK, A01.DivisionID, A01.ObjectID,A04.ObjectName, A01.FromDate,A01.ToDate ,A01.SalesYear, 
		(CASE WHEN A05.ObjectID IS NOT NULL THEN 1 ELSE 0 END) AS IsPlanned,A01.EmployeeID, A06.FullName AS EmployeeName ,S3.Description As StatusSS, A01.ApprovalNotes
		INTO #TempAT0161
		From AT1103 A03
		INNER JOIN AT0161 A01 WITH(NOLOCK)
		INNER JOIN #PermissionAT0161 T1 ON T1.Value IN (A01.EmployeeID, A01.CreateUserID)
		LEFT  JOIN AT1202 A04 WITH(NOLOCK) ON A01.ObjectID = A04.ObjectID
		LEFT  JOIN at0169 A05 WITH(NOLOCK) ON A05.APKMaster = A01.APK and A05.ObjectID = A01.ObjectID and A05.DivisionID = '''+@DivisionID+'''
		LEFT  JOIN AT1103 A06 WITH (NOLOCK) ON A06.EmployeeID = A01.EmployeeID
		LEFT JOIN OOT0099 S3 WITH(NOLOCK) ON A01.StatusSS = S3.ID AND S3.CodeMaster = ''Status''
		ON 1 = 1

		DECLARE @Count INT
		SELECT @Count = COUNT(ObjectID) FROM #TempAT0161

		SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @Count AS TotalRow
			, AT01.APK, AT01.DivisionID, AT01.FromDate, AT01.ObjectID, AT01.ObjectName,AT01.EmployeeID, AT01.EmployeeName, YEAR(AT01.ToDate) AS Year,AT01.SalesYear,IsPlanned, AT01.StatusSS, AT01.ApprovalNotes
			, x.CreateDate, x.CreateUserID, x.LastModifyDate, x.LastModifyUserID
		FROM #TempAT0161 AT01
			CROSS APPLY (SELECT TOP 1 A01.CreateDate, A03.FullName AS CreateUserID,
						 A01.LastModifyDate, A01.LastModifyUserID 
						 FROM AT0161 A01 WITH (NOLOCK)
						 LEFT JOIN AT1103 A03 WITH (NOLOCK) ON A03.CreateUserID = A01.EmployeeID
						) x
		WHERE '+@sWhere+'
		ORDER BY '+@OrderBy+'
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	
       PRINT  (@sSQL)
       EXEC  (@sSQLPermission + @sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
