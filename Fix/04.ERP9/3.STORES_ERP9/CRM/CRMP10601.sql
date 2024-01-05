IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'CRMP10601') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE CRMP10601
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form CRMP10601 Danh muc loại hình bán hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Nguyễn Thị Lệ Huyền, Date: 22/03/2017
----Editted by: Hoàng Vũ, Date: 27/04/2017 Cải tiến tốc độ, nếu Division là @@@ thì hiển thị null
----Editted by: Phan thanh hoàng Vũ, Date: 01/09/2017 Sắp xếp thứ tự giảm dần thao ngày (Record mới nhất sẽ load lên đầu tiên)
--- Modify by Thị Phượng, Date 08/11/2017: Bổ sung thêm xử lý search nâng cao
-- <Example>
----    EXEC CRMP10601 'AS','AS','','','','','','NV01',1,20,''
----
CREATE PROCEDURE CRMP10601 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@DivisionIDList NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
        @SalesTagID nvarchar(50),
        @SalesTagName nvarchar(250),
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
SET @OrderBy = ' M.CreateDate DESC, M.SalesTagID, M.SalesTagName'
IF isnull(@SearchWhere,'') =''
Begin
--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + 'AND (M.DivisionID IN ('''+@DivisionIDList+''') or M.IsCommon = 1)'
	Else 
		SET @sWhere = @sWhere + 'AND (M.DivisionID = '''+ @DivisionID+''' or M.IsCommon = 1)'		
		
	IF isnull(@SalesTagID,'')!='' 
		SET @sWhere = @sWhere + ' AND ISNULL(M.SalesTagID, '''') LIKE N''%'+@SalesTagID+'%'' '
	IF isnull(@SalesTagName,'')!='' 
		SET @sWhere = @sWhere + ' AND ISNULL(M.SalesTagName,'''') LIKE N''%'+@SalesTagName+'%''  '
	
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
SET @sSQL =	  '	SELECT M.APK, M.DivisionID, M.SalesTagID, M.SalesTagName, M.Description
					   , M.IsCommon, M.Disabled, M.CreateDate, M.CreateUserID
					   , M.LastModifyDate, M.LastModifyUserID
					   Into #TempCRMT10601
				FROM CRMT10601 M With (NOLOCK)
				WHERE '+@sWhere+'
				
				DECLARE @count int
				Select @count = Count(SalesTagID) From #TempCRMT10601
				'+Isnull(@SearchWhere,'')+'
				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @count AS TotalRow
					, M.APK
					, Case when M.IsCommon = 1 then '''' else M.DivisionID end DivisionID
					, M.SalesTagID, M.SalesTagName, M.Description
					, M.IsCommon, M.Disabled, M.CreateDate, M.CreateUserID, M.LastModifyDate, M.LastModifyUserID
				FROM #TempCRMT10601 M
				'+Isnull(@SearchWhere,'')+'
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
EXEC (@sSQL)

