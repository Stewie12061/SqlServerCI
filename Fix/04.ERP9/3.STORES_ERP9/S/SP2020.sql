IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SP2020]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SP2020]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load grid danh mục rules
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 13/10/2020 by Tấn Lộc
----Update on 24/11/2020 by Huỳnh Thử -- Bổ sung điều kiện lọc theo Loại Rule 

CREATE PROCEDURE [dbo].[SP2020]
( 
	 @DivisionID VARCHAR(50),
	 @DivisionIDList NVARCHAR(MAX),
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @RuleID NVARCHAR(250),
	 @RuleName NVARCHAR(250),
	 @IsCommon NVARCHAR(100), 
	 @Disabled NVARCHAR(100),
	 @UserID VARCHAR(50), 
	 @TypeRules NVARCHAR(100), 
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

	IF ISNULL(@RuleID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.RuleID, '''') LIKE N''%' + @RuleID + '%'' '

	IF ISNULL(@RuleName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.RuleName, '''') LIKE N''%' + @RuleName + '%'' '

	IF ISNULL(@TypeRules, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.TypeRules, '''') LIKE N''%' + @TypeRules + '%'' '
		
	IF  @PageNumber = 1 SET @TotalRow = 'COUNT OVER ()' ELSE SET @TotalRow = 'NULL'

	
	SET @sSQL = @sSQL + N'
		SELECT M.APK, M.DivisionID, M.RuleID, M.RuleName, M.EffectDate, M.ExpiryDate, M.CreateDate, M.TypeRules
		INTO #TempST2020
		FROM ST2020 M WITH (NOLOCK)
		WHERE  ' + @sWhere +   ' AND M.DivisionID = ''' + @DivisionID + ''' AND ISNULL(M.DeleteFlg, 0) = 0

		DECLARE @Count INT
		SELECT @Count = COUNT(*) FROM #TempST2020
		
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow
			  , M.APK
			  , M.DivisionID
			  , M.RuleID
			  , M.RuleName
			  ,	M.EffectDate
			  , M.ExpiryDate
			  , M.CreateDate
			  , CASE WHEN ISNULL(M.TypeRules,0) = 1 THEN ''Email'' ELSE ''Black List'' END AS TypeRulesName
		FROM #TempST2020 M
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
	EXEC (@sSQL)
	PRINT(@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
