IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2140]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2140]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load dữ liệu màn hình định mức dự án
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 09/08/2019 by Mr.Ly

CREATE PROCEDURE [dbo].[OOP2140]
( 
	 @DivisionID VARCHAR(50),
	 @DivisionIDList NVARCHAR(MAX), 
	 @UserID VARCHAR(50), 
	 @PageNumber INT,
	 @PageSize INT,
	 @Disabled NVARCHAR(100),
	 @ProjectID varchar(25),
	 @CreateUserName nvarchar(25),
	 @ProjectName nvarchar(250),
	 @CreateDate DateTime
)
AS 
	DECLARE @sSQL NVARCHAR (MAX) = N'',
     		@OrderBy NVARCHAR(MAX) = N'', 
			@TotalRow NVARCHAR(50) = N'',
			@sWhere NVARCHAR(MAX),
			@CreateDateText NVARCHAR(20)

	SET @sWhere = ''
	SET @OrderBy = 'K.CreateDate DESC'
	-- SET @CreateDateText = CONVERT(NVARCHAR(20), @CreateDate) + ' 23:59:59'
	 SET @CreateDateText = CONVERT(VARCHAR(10), @CreateDate, 120)
	 PRINT(@CreateDateText)
	--Check Para DivisionIDList null then get DivisionID
	IF ISNULL(@DivisionIDList, '') != ''
		BEGIN
			SET @sWhere = @sWhere + ' K.DivisionID IN (''' + @DivisionIDList + ''') AND  K.Disabled IN (''' + @Disabled + ''')'
			IF ISNULL(@CreateDateText, '') != ''
				BEGIN
					SET @sWhere = @sWhere + 'AND CONVERT(VARCHAR(10), K.CreateDate, 120) IN (''' + @CreateDateText + ''')'		
				END
			ELSE 
				BEGIN
					SET @sWhere = @sWhere
				END
		END
	Else 
		BEGIN
			SET @sWhere = @sWhere + ' K.DivisionID IN (''' + @DivisionID + ''') AND  K.Disabled IN (''' + @Disabled + ''')'
			IF ISNULL(@CreateDateText, '') != ''
				BEGIN
					SET @sWhere = @sWhere + 'AND CONVERT(VARCHAR(10), K.CreateDate, 120) IN (''' + @CreateDateText + ''')'		
				END
			ELSE 
				BEGIN
					SET @sWhere = @sWhere
				END
		END
	IF ISNULL(@ProjectID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(K.ProjectID, '''') LIKE N''%' + @ProjectID + '%'' '
	IF ISNULL(@CreateUserName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(A1.FullName, '''') LIKE N''%' + @CreateUserName + '%'' '
	IF ISNULL(@ProjectName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(O1.ProjectName, '''') LIKE N''%' + @ProjectName + '%'' '

	IF  @PageNumber = 1 SET @TotalRow = 'COUNT OVER ()' ELSE SET @TotalRow = 'NULL'

	SET @sSQL = @sSQL + N'
		SELECT K.APK, K.DivisionID, K.ProjectID, A1.FullName AS CreateUserName, K.CreateDate, K.Disabled, O1.ProjectName
		INTO #TempOOT2140
		FROM OOT2140 K WITH (NOLOCK)
			LEFT JOIN OOT2100 O1 WITH (NOLOCK) ON O1.ProjectID = K.ProjectID
			LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = k.CreateUserID
		WHERE  ' + @sWhere +   ' AND K.DivisionID = ''' + @DivisionID + '''

		DECLARE @Count INT
		SELECT @Count = COUNT(*) FROM #TempOOT2140
		
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow
			  ,	K.APK
			  ,	K.DivisionID
			  , K.ProjectID
			  , K.ProjectName
			  , K.CreateUserName
			  , K.CreateDate
			  , K.Disabled
		FROM #TempOOT2140 K
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
