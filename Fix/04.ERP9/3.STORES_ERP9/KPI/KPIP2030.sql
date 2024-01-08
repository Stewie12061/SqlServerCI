IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[KPIP2030]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[KPIP2030]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load form xem thông tin H? s? luong m?m (Detail)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 1/8/2019 by T?n L?c
-- <Example> EXEC KPIP2030 @DivisionID = 'DTI', @DivisionIDList = '', @UserID = 'TANLOC', @PageNumber='1', @PageSize='25','VANTOAI',0,0

CREATE PROCEDURE [dbo].[KPIP2030]
( 
	 @DivisionID VARCHAR(50),
	 @DivisionIDList NVARCHAR(MAX), 
	 @UserID VARCHAR(50), 
	 @PageNumber INT,
	 @PageSize INT,
	 @TableID VARCHAR(25),
	 @TableName NVARCHAR(250),
	 @IsCommon NVARCHAR(100), 
	 @Disabled NVARCHAR(100),
	 @CreateDate DateTime
)
AS 
	DECLARE @sSQL NVARCHAR (MAX) = N'',
     		@OrderBy NVARCHAR(MAX) = N'', 
			@TotalRow NVARCHAR(50) = N'',
			@sWhere NVARCHAR(MAX),
			@CreateDateText NVARCHAR(20)

	SET @OrderBy = 'K.CreateDate DESC'
	SET @sWhere = ''
	SET @CreateDateText = CONVERT(VARCHAR(10), @CreateDate, 120)
	PRINT(@CreateDateText)

	--Check Para DivisionIDList null then get DivisionID
	IF ISNULL(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' K.DivisionID IN (''' + @DivisionIDList + ''')'
	Else 
		SET @sWhere = @sWhere + ' K.DivisionID IN (''' + @DivisionID + ''')'
	IF ISNULL(@CreateDateText, '') != ''
			SET @sWhere = @sWhere + 'AND CONVERT(VARCHAR(10), K.CreateDate, 120) IN (''' + @CreateDateText + ''')'		
		
	IF ISNULL(@TableID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(K.TableID, '''') LIKE N''%' + @TableID + '%'' '
	IF ISNULL(@TableName, '') != ''
		SET @sWhere = @sWhere + 'AND ISNULL(K.TableName, '''') LIKE N''%' + @TableName + '%'' '
	IF ISNULL(@Disabled, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(K.Disabled, '''') = ' + @Disabled
	IF ISNULL(@IsCommon, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(K.IsCommon, '''') = ' + @IsCommon

	IF  @PageNumber = 1 SET @TotalRow = 'COUNT OVER ()' ELSE SET @TotalRow = 'NULL'

	SET @sSQL = @sSQL + N'
		SELECT K.APK, K.DivisionID, K.TableID, K.TableName, K.Disabled, K.IsCommon, K.CreateDate
		INTO #TempKPIT2030
		FROM KPIT2030 K WITH (NOLOCK)
		WHERE  ' + @sWhere +   ' AND K.DivisionID = ''' + @DivisionID + ''' 

		DECLARE @Count INT
		SELECT @Count = COUNT(*) FROM #TempKPIT2030
		
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow
			  ,	K.APK
			  ,	K.DivisionID
			  , K.TableID
			  , K.TableName
			  , K.Disabled
			  , K.IsCommon
			  , K.CreateDate
		FROM #TempKPIT2030 K
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
	EXEC (@sSQL)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
