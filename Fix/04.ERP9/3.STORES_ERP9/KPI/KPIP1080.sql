IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[KPIP1080]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[KPIP1080]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load d? li?u cho grid quy ??nh th??ng KPI
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 30/8/2019 by [T?n L?c]
-- <Example> EXEC KPIP1080 @DivisionID = 'DTI', @DivisionIDList = '', @UserID = 'TANLOC', @PageNumber='1', @PageSize='25','VANTOAI',0,0

CREATE PROCEDURE [dbo].[KPIP1080]
( 
	 @DivisionID VARCHAR(50),
	 @DivisionIDList NVARCHAR(MAX), 
	 @UserID VARCHAR(50), 
	 @PageNumber INT,
	 @PageSize INT,
	 @TableName NVARCHAR(250),
	 @FromPeriodFilter DATETIME,
	 @ToPeriodFilter DATETIME,
	 @Disabled NVARCHAR(10),
	 @IsCommon NVARCHAR(10)
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
		SET @sWhere = @sWhere + ' K.DivisionID IN (''' + @DivisionID + ''')'

	-- check Para FromPeriodFilter v? ToPeriodFilter
	IF (ISNULL(@FromPeriodFilter, '') = '' AND ISNULL (@ToPeriodFilter,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (K.ExpirationDate <= ''' + @ToPeriodFilterText + '''
											OR K.EffectiveDate <= ''' + @ToPeriodFilterText + ''')'
		END
	ELSE IF (ISNULL(@FromPeriodFilter,'') != '' AND ISNULL (@ToPeriodFilter,'') = '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (K.EffectiveDate >= ''' + @FromPeriodFilterText + '''
											OR K.ExpirationDate >= ''' +@FromPeriodFilterText+ ''')'
		END
	ELSE IF (ISNULL(@FromPeriodFilter,'') != '' AND ISNULL (@ToPeriodFilter,'') != '')
		BEGIN
			SET @sWhere = @sWhere + 'AND (K.EffectiveDate BETWEEN ''' + @FromPeriodFilterText + ''' AND ''' + @ToPeriodFilterText + '''
											OR K.ExpirationDate BETWEEN ''' + @FromPeriodFilterText + ''' AND ''' + @ToPeriodFilterText + ''' )'
		END
	
	IF ISNULL(@TableName,'') = ''
		SET @sWhere = @sWhere + '  AND ISNULL(K.TableName, '''') LIKE N''%' + @TableName + '%'' '
	IF ISNULL(@Disabled, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(K.Disabled, '''') = ' + @Disabled
	IF ISNULL(@IsCommon, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(K.IsCommon, '''') = ' + @IsCommon

	IF  @PageNumber = 1 SET @TotalRow = 'COUNT OVER ()' ELSE SET @TotalRow = 'NULL'
	SET @sSQL = @sSQL + N'
		SELECT K.APK, K.DivisionID, K.TableName, K.EffectiveDate, K.ExpirationDate, K.IsCommon, K.Disabled, K.CreateDate
		INTO #TempKPIT1080
		FROM KPIT1080 K WITH (NOLOCK)
		WHERE  ' + @sWhere +   ' AND K.DivisionID = ''' + @DivisionID + ''' 

		DECLARE @Count INT
		SELECT @Count = COUNT(*) FROM #TempKPIT1080
		
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow
			  ,	K.APK
			  ,	K.DivisionID
			  , K.TableName
			  , FORMAT(k.EffectiveDate, ''MM/yyyy'') AS EffectiveDate
			  , FORMAT(K.ExpirationDate, ''MM/yyyy'') AS ExpirationDate
			  , K.Disabled
			  , K.IsCommon
			  , K.CreateDate
		FROM #TempKPIT1080 K
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
	EXEC (@sSQL)
	PRINT (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
