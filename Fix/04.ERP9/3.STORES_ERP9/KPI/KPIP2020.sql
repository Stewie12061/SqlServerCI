IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[KPIP2020]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[KPIP2020]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
-- Load grid danh mục Quy chuẩn Up-Down đánh giá KPI (Detail)
-- <Param>
-- <Return>
-- <Reference>
-- <History>
---- Create on 1/8/2019 by Tấn Lộc
---- Modified on 1/8/2019 by Vĩnh Tâm: Bổ sung Bảng quy định giờ công vi phạm vào điều kiện tìm kiếm
-- <Example> EXEC KPIP2020 @DivisionID = 'DTI', @DivisionIDList = '', @UserID = 'TANLOC', @PageNumber='1', @PageSize='25', '', '', '', '', '', 0, 0

CREATE PROCEDURE [dbo].[KPIP2020]
( 
	 @DivisionID VARCHAR(50),
	 @DivisionIDList NVARCHAR(MAX), 
	 @UserID VARCHAR(50), 
	 @PageNumber INT,
	 @PageSize INT,	
	 @EmployeeID VARCHAR(25),
	 @EmployeeName NVARCHAR(250),
	 @TableID NVARCHAR(250),
	 @TableViolatedID NVARCHAR(250),
	 @FromPeriodFilter DATETIME,
	 @ToPeriodFilter DATETIME,
	 @IsCommon NVARCHAR(100), 
	 @Disabled NVARCHAR(100) 
)
AS 
	DECLARE @sSQL NVARCHAR (MAX) = N'',
     		@OrderBy NVARCHAR(MAX) = N'', 
			@TotalRow NVARCHAR(50) = N'',
			@sWhere NVARCHAR(MAX),
			@FromPeriodFilterText NVARCHAR(30),
			@ToPeriodFilterText NVARCHAR(30)

	SET @OrderBy = 'K.CreateDate DESC'
	SET @sWhere = ''
	SET @FromPeriodFilterText = CONVERT(NVARCHAR(20), @FromPeriodFilter, 111)
	SET @ToPeriodFilterText = CONVERT(NVARCHAR(20), @ToPeriodFilter, 111)


	--Check Para DivisionIDList null then get DivisionID
	IF ISNULL(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' K.DivisionID IN (''' + @DivisionIDList + ''')'
	Else 
		SET @sWhere = @sWhere + ' K.DivisionID IN (''' + @DivisionID + ''', ''@@@'')'

	-- check Para FromPeriodFilter v? ToPeriodFilter
	IF (ISNULL(@FromPeriodFilter,'') != '' AND ISNULL(@ToPeriodFilter,'') = '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (K.EffectDate >= ''' + @FromPeriodFilterText + '''
											OR K.ExpiryDate >= '''+ @FromPeriodFilterText + ''')'
		END
	ELSE IF (ISNULL(@FromPeriodFilter,'') = '' AND ISNULL(@ToPeriodFilter,'') != '' )
		BEGIN
			SET @sWhere = @sWhere + 'AND (K.ExpiryDate <= ''' + @ToPeriodFilterText + '''
											OR K.ExpiryDate <= '''+ @ToPeriodFilterText + ''')'
		END
	ELSE IF (ISNULL(@FromPeriodFilter,'') != '' AND ISNULL(@ToPeriodFilter,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (K.EffectDate BETWEEN ''' + @FromPeriodFilterText + ''' AND ''' + @ToPeriodFilterText + '''
											OR K.ExpiryDate BETWEEN ''' + @FromPeriodFilterText + ''' AND ''' + @ToPeriodFilterText + '''
											OR ''' + @FromPeriodFilterText + ''' BETWEEN K.EffectDate AND K.ExpiryDate
											OR ''' + @ToPeriodFilterText + ''' BETWEEN K.EffectDate AND K.ExpiryDate)' 
		END

	IF ISNULL(@EmployeeID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(K.EmployeeID, '''') LIKE N''%' + @EmployeeID + '%'' '

	IF ISNULL(@EmployeeName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(A1.FullName, '''') LIKE N''%' + @EmployeeName + '%'' '

	IF ISNULL(@TableID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(K.TableID, '''') IN (''' + @TableID + ''') '

	IF ISNULL(@TableViolatedID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(K.TableViolatedID, '''') IN (''' + @TableViolatedID + ''') '

	IF  @PageNumber = 1 SET @TotalRow = 'COUNT OVER ()' ELSE SET @TotalRow = 'NULL'

	SET @sSQL = @sSQL + N'
		SELECT K.APK, K.DivisionID, K.EmployeeID, A1.FullName AS EmployeeName, K1.TableName AS TableID, O1.TableName AS TableViolatedID, K.FixedSalary, 
					  K.EffectiveSalary, K.TargetSales, K.TargetSalesRate, K.RedLimit, K.WarningLimit, K.EffectDate, K.ExpiryDate , K.CreateDate
		INTO #TempKPIT2020
		FROM KPIT2020 K WITH (NOLOCK)
			LEFT JOIN AT1103 A1 WITH (NOLOCK) ON K.EmployeeID = A1.EmployeeID
			LEFT JOIN KPIT2030 K1 WITH (NOLOCK) ON K.TableID = K1.TableID
			LEFT JOIN OOT1080 O1 WITH (NOLOCK) ON K.TableViolatedID = O1.TableViolatedID
		WHERE  ' + @sWhere +   ' AND K.DivisionID = ''' + @DivisionID + '''

		DECLARE @Count INT
		SELECT @Count = COUNT(*) FROM #TempKPIT2020
		
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow
			  , K.APK
			  , K.DivisionID
			  , K.EmployeeID
			  , K.EmployeeName
			  ,	K.TableID
			  ,	K.TableViolatedID
			  , K.FixedSalary
			  , K.EffectiveSalary
			  , K.TargetSales
			  , K.TargetSalesRate
			  , K.RedLimit
			  , K.WarningLimit
			  , FORMAT(K.EffectDate, ''MM/yyyy'') AS EffectDate
			  , FORMAT(K.ExpiryDate, ''MM/yyyy'') AS ExpiryDate
		FROM #TempKPIT2020 K
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
	EXEC (@sSQL)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
