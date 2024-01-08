IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'KPIP10471') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE KPIP10471
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form KPIP10471 Danh mục công thức tính chỉ tiêu KPI
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 22/02/2019 by Bảo Anh
-- <Example> EXEC KPIP10471 'NTY', '', '', '', '', '', '', '', 1, 20

CREATE PROCEDURE KPIP10471 ( 
          @DivisionID VARCHAR(50),  
		  @DivisionIDList VARCHAR(2000), 
		  @FormulaID varchar(50),
		  @FormulaName nvarchar(250),
		  @FormulaDes varchar(250),
		  @IsCommon TINYINT,
		  @Disabled TINYINT,
		  @UserID VARCHAR(50),
		  @PageNumber INT,
		  @PageSize INT
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500)
		
	SET @sWhere = ''
	SET @OrderBy = ' M.CreateDate DESC, M.FormulaID '

		--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' (M.DivisionID IN ('''+@DivisionIDList+''', ''@@@'')) '
	Else 
		SET @sWhere = @sWhere + ' (M.DivisionID in ('''+@DivisionID+''', ''@@@'')) '
		
		
	IF Isnull(@FormulaID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.FormulaID, '''') LIKE N''%'+@FormulaID+'%'' '
	IF Isnull(@FormulaName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.FormulaName, '''') LIKE N''%'+@FormulaName+'%'' '
	IF Isnull(@FormulaDes, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.FormulaDes,'''') LIKE N''%'+@FormulaDes+'%''  '
	IF @IsCommon IS NOT NULL AND @IsCommon <>''
		SET @sWhere = @sWhere + ' AND ISNULL(M.IsCommon,0) = '+LTRIM(@IsCommon)
	IF @Disabled IS NOT NULL AND @Disabled <>''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled,0) = '+LTRIM(@Disabled)

SET @sSQL = ' 
			SELECT M.APK, M.DivisionID 
					, M.FormulaID, M.FormulaName
					, M.FormulaDes, M.IsCommon, M.Disabled
					, M.CreateUserID, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
					 into #TempKPIT10471
			FROM KPIT10471 M With (NOLOCK) 
			WHERE '+@sWhere+'

			DECLARE @count int
			Select @count = Count(FormulaID) From #TempKPIT10471 With (NOLOCK) 

			SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @count AS TotalRow
					, M.APK, Case when isnull(M.IsCommon,0) =1 then '''' else M.DivisionID end As DivisionID 
					, M.FormulaID, M.FormulaName
					, M.FormulaDes, M.IsCommon, M.Disabled
					, M.CreateUserID, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
			FROM #TempKPIT10471 M  With (NOLOCK) 
			ORDER BY '+@OrderBy+'
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
EXEC (@sSQL)

