IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'KPIP10401') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE KPIP10401
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form KPIP10401 Danh muc đơn vị tính KPI
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: hoàng vũ, Date: 15/08/2017
-- <Example> EXEC KPIP10401 'AS', '', '', '', '', '', '', '', 1, 20

CREATE PROCEDURE KPIP10401 ( 
          @DivisionID VARCHAR(50),  
		  @DivisionIDList NVARCHAR(2000), 
		  @UnitKpiID nvarchar(50),
		  @UnitKpiName nvarchar(50),
		  @Note nvarchar(250),
		  @IsCommon nvarchar(100),
		  @Disabled nvarchar(100),
		  @UserID  VARCHAR(50),
		  @PageNumber INT,
		  @PageSize INT
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500)
		
	SET @sWhere = ''
	SET @OrderBy = ' M.CreateDate DESC, M.UnitKpiID '

		--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' (M.DivisionID IN ('''+@DivisionIDList+''', ''@@@'')) '
	Else 
		SET @sWhere = @sWhere + ' (M.DivisionID in ('''+@DivisionID+''', ''@@@'')) '
		
		
	IF Isnull(@UnitKpiID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.UnitKpiID, '''') LIKE N''%'+@UnitKpiID+'%'' '
	IF Isnull(@UnitKpiName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.UnitKpiName, '''') LIKE N''%'+@UnitKpiName+'%'' '
	IF Isnull(@Note, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Note,'''') LIKE N''%'+@Note+'%''  '
	IF Isnull(@IsCommon, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.IsCommon,'''') LIKE N''%'+@IsCommon+'%'' '
	IF Isnull(@Disabled, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled,'''') LIKE N''%'+@Disabled+'%'' '

SET @sSQL = ' 
			SELECT M.APK, M.DivisionID 
					, M.UnitKpiID, M.UnitKpiName
					, M.Note, M.IsCommon, M.Disabled
					, M.CreateUserID, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
					 into #TempKPIT10401
			FROM KPIT10401 M With (NOLOCK) 
			WHERE '+@sWhere+'

			DECLARE @count int
			Select @count = Count(UnitKpiID) From #TempKPIT10401 With (NOLOCK) 

			SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @count AS TotalRow
					, M.APK, Case when isnull(M.IsCommon,0) =1 then '''' else M.DivisionID end As DivisionID 
					, M.UnitKpiID, M.UnitKpiName
					, M.Note, M.IsCommon, M.Disabled
					, M.CreateUserID, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
			FROM #TempKPIT10401 M  With (NOLOCK) 
			ORDER BY '+@OrderBy+'
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
EXEC (@sSQL)

