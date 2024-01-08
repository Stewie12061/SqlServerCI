
IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'CRMP10201') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE CRMP10201
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form CRMP10201 Danh muc phân đầu mối
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng, Date: 14/03/2017
--- Modify by Thị Phượng, Date 08/11/2017: Bổ sung thêm xử lý search nâng cao
-- <Example>
/*
--Lưu y chưa xử lý: Phân quyền xem dữ liệu người khác, phân quyền chi tiết dữ liệu

EXEC CRMP10201 'CAN' ,'','' ,'' ,'','' , 'NV01' ,1 ,20,'where Description like '''''

*/
CREATE PROCEDURE CRMP10201 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@DivisionIDList NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
        @LeadTypeID nvarchar(50),
        @LeadTypeName nvarchar(250),
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
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
		
	SET @sWhere = '1 = 1'
	SET @TotalRow = ''
	SET @OrderBy = 'M.CreateUserID DESC, M.LeadTypeID'

IF isnull(@SearchWhere,'') =''
Begin	
	--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' AND (M.DivisionID IN ('''+@DivisionIDList+''') or M.IsCommon =1) '
	Else 
		SET @sWhere = @sWhere + ' AND (M.DivisionID = N'''+ @DivisionID+'''or M.IsCommon =1)'
		
		
	IF Isnull(@LeadTypeID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.LeadTypeID, '''') LIKE N''%'+@LeadTypeID+'%'' '
	IF Isnull(@LeadTypeName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.LeadTypeName,'''') LIKE N''%'+@LeadTypeName+'%''  '
	IF Isnull(@IsCommon, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.IsCommon,'''') LIKE N''%'+@IsCommon+'%'' '
	IF Isnull(@Disabled, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled,'''') LIKE N''%'+@Disabled+'%'' '
End
IF isnull(@SearchWhere,'') !=''
Begin
	SET  @sWhere='1 = 1'
End
SET @sSQL = ' SELECT  M.APK, Case when isnull(M.IsCommon,0) =1 then '''' else M.DivisionID end As DivisionID 
					, M.LeadTypeID, M.LeadTypeName
					, M.Disabled, D6.Description as DisabledName
					, M.IsCommon, D5.Description as IsCommonName
					, M.Description
					, M.CreateUserID, A.FullName as CreateUserName, M.CreateDate
					, M.LastModifyUserID, B.FullName as LastModifyUserName, M.LastModifyDate
			INTO #TemCRMT10201
			FROM CRMT10201 M With (NOLOCK) 
			left join AT0099 D5 With (NOLOCK) on M.IsCommon = D5.ID and D5.CodeMaster = ''AT00000004''
			left join AT0099 D6 With (NOLOCK) on M.Disabled = D6.ID and D6.CodeMaster = ''AT00000004''
			LEFT JOIN AT1103 A With (NOLOCK) On M.CreateUserID = A.EmployeeID
			LEFT JOIN AT1103 B With (NOLOCK) On M.LastModifyUserID = B.EmployeeID								 
			WHERE '+@sWhere+'

			Declare @Count int
			Select @Count = Count(LeadTypeID) From  #TemCRMT10201
			'+Isnull(@SearchWhere,'')+'

			SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @Count AS TotalRow
            , M.APK, M.DivisionID 
			, M.LeadTypeID, M.LeadTypeName
			, M.Disabled, M.DisabledName
			, M.IsCommon, M.IsCommonName
			, M.Description
			, M.CreateUserID, M.CreateUserName, M.CreateDate
			, M.LastModifyUserID, M.LastModifyUserName, M.LastModifyDate
			FROM #TemCRMT10201 M
			'+Isnull(@SearchWhere,'')+'
			ORDER BY '+@OrderBy+'
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
EXEC (@sSQL)
--print (@sSQL)