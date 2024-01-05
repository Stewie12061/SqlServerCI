IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'CRMP10701') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE CRMP10701
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form CRMP10701 Danh muc lĩnh vực kinh doanh
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng, Date: 26/06/2017
--- Modify by Thị Phượng, Date 08/11/2017: Bổ sung thêm xử lý search nâng cao
-- <Example>
----    EXEC CRMP10701 'AS','AS','G','','','','0','NV01',1,20,''
----
CREATE PROCEDURE CRMP10701 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@DivisionIDList NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
        @BusinessLinesID nvarchar(50),
        @BusinessLinesName nvarchar(250),
		@Description nvarchar(250),
        @IsCommon nvarchar(100),
        @Disabled nvarchar(100),
		@UserID  VARCHAR(50),
		@PageNumber INT,
		@PageSize INT,
		@SearchWhere NVARCHAR(Max) = null
		
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500)
    
SET @sWhere = '1 =1 '
SET @OrderBy = 'M.CreateUserID DESC, M.BusinessLinesID, M.BusinessLinesName'
 IF isnull(@SearchWhere,'') =''
Begin   
--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' AND (M.DivisionID IN ('''+@DivisionIDList+''') or M.IsCommon = 1)'
	Else 
		SET @sWhere = @sWhere + ' AND (M.DivisionID = '''+ @DivisionID+''' or M.IsCommon = 1)'		
		
	IF isnull(@BusinessLinesID,'')!='' 
		SET @sWhere = @sWhere + ' AND ISNULL(M.BusinessLinesID, '''') LIKE N''%'+@BusinessLinesID+'%'' '
	IF isnull(@BusinessLinesName,'')!='' 
		SET @sWhere = @sWhere + ' AND ISNULL(M.BusinessLinesName,'''') LIKE N''%'+@BusinessLinesName+'%''  '
	
	IF isnull(@Description,'')!='' 
		SET @sWhere = @sWhere + ' AND ISNULL(M.Description,'''') LIKE N''%'+@Description+'%''  '

	
	IF isnull(@IsCommon,'')!='' 
		SET @sWhere = @sWhere + ' AND ISNULL(M.IsCommon,'''') LIKE N''%'+@IsCommon+'%'' '
	IF isnull(@Disabled,'')!='' 
		SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled,'''') LIKE N''%'+@Disabled+'%'' '
End
IF isnull(@SearchWhere,'') !=''
Begin
	SET  @sWhere='1 = 1'
End
SET @sSQL =	  '	SELECT M.APK, M.DivisionID, M.BusinessLinesID, M.BusinessLinesName, M.Description
					   , M.IsCommon, M.Disabled, M.CreateDate, M.CreateUserID
					   , M.LastModifyDate, M.LastModifyUserID
					   Into #TempCRMT10701
				FROM CRMT10701 M With (NOLOCK)
				WHERE '+@sWhere+'

				DECLARE @count int
				Select @count = Count(BusinessLinesID) From #TempCRMT10701
					'+Isnull(@SearchWhere,'')+'
				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @count AS TotalRow
					, M.APK
					, Case when M.IsCommon = 1 then '''' else M.DivisionID end DivisionID
					, M.BusinessLinesID, M.BusinessLinesName, M.Description
					, M.IsCommon, M.Disabled, M.CreateDate, M.CreateUserID, M.LastModifyDate, M.LastModifyUserID
				FROM #TempCRMT10701 M
					'+Isnull(@SearchWhere,'')+'
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
EXEC (@sSQL)

