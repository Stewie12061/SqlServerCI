IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[KPIP10301]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[KPIP10301]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form KPIP10301 Danh muc nguồn đo
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: hoàng vũ, Date: 16/08/2017
----Modified on 26/12/2023 by Thanh Hải: bổ sung lọc theo từ ngày đến ngày và theo kỳ
-- <Example> EXEC KPIP10301 'AS', '', '', '', '', '', '', '', 1, 20

CREATE PROCEDURE KPIP10301 ( 
          @DivisionID VARCHAR(50),  
		  @DivisionIDList NVARCHAR(2000), 
		  @SourceID nvarchar(50),
		  @SourceName nvarchar(50),
		  @Note nvarchar(250),
		  @IsCommon nvarchar(100),
		  @Disabled nvarchar(100),
		  @UserID  VARCHAR(50),
		  @PageNumber INT,
		  @PageSize INT,
		  @IsSearch TINYINT,
		  @FromDate DATETIME ,
		  @ToDate DATETIME ,
		  @PeriodList VARCHAR(MAX) = ''
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)
		
	SET @sWhere = ''
	SET @OrderBy = ' M.CreateDate DESC, M.SourceID '
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'	

		--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' (M.DivisionID IN ('''+@DivisionIDList+''', ''@@@'')) '
	Else 
		SET @sWhere = @sWhere + ' (M.DivisionID in ('''+@DivisionID+''', ''@@@'')) '

	-- Check Param FromDate và ToDate
	-- Trường hợp search theo từ ngày đến ngày
	IF @IsSearch = 0
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
	
	-- Trường hợp search theo kỳ
	IF  @IsSearch = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
			SET @sWhere = @sWhere + ' AND (SELECT FORMAT(M.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
	END
	
	IF Isnull(@SourceID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.SourceID, '''') LIKE N''%'+@SourceID+'%'' '
	IF Isnull(@SourceName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.SourceName, '''') LIKE N''%'+@SourceName+'%'' '
	IF Isnull(@Note, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Note,'''') LIKE N''%'+@Note+'%''  '
	IF Isnull(@IsCommon, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.IsCommon,'''') LIKE N''%'+@IsCommon+'%'' '
	IF Isnull(@Disabled, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled,'''') LIKE N''%'+@Disabled+'%'' '

SET @sSQL = ' 
			SELECT M.APK, M.DivisionID 
					, M.SourceID, M.SourceName
					, M.Note, M.IsCommon, M.Disabled
					, M.CreateUserID, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
					 into #TempKPIT10301
			FROM KPIT10301 M With (NOLOCK) 
			WHERE '+@sWhere+'

			DECLARE @count int
			Select @count = Count(SourceID) From #TempKPIT10301 With (NOLOCK) 

			SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @count AS TotalRow
					, M.APK, Case when isnull(M.IsCommon,0) =1 then '''' else M.DivisionID end As DivisionID 
					, M.SourceID, M.SourceName
					, M.Note, M.IsCommon, M.Disabled
					, M.CreateUserID, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
			FROM #TempKPIT10301 M With (NOLOCK) 
			ORDER BY '+@OrderBy+'
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


