IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'CRMP10203') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE CRMP10203
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- CRMP10203 In Danh muc phân đầu mối
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng, Date: 20/03/2017
-- <Example>
/*
--Lưu y chưa xử lý: Phân quyền xem dữ liệu người khác, phân quyền chi tiết dữ liệu

EXEC CRMP10203 'AS' ,'','' ,'' ,'' ,'' , 'NV01' 

*/
CREATE PROCEDURE CRMP10203 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@DivisionIDList NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
        @LeadTypeID nvarchar(50),
        @LeadTypeName nvarchar(250),
		@IsCommon nvarchar(100),
		@Disabled nvarchar(100),
		@UserID  VARCHAR(50)
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500)
		
	SET @sWhere = ''
	SET @OrderBy = 'M.LeadTypeID'

	--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' M.DivisionID IN ('''+@DivisionIDList+''') or M.IsCommon =1 '
	Else 
		SET @sWhere = @sWhere + ' M.DivisionID = N'''+ @DivisionID+'''or M.IsCommon =1'
		
		
	IF Isnull(@LeadTypeID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.LeadTypeID, '''') LIKE N''%'+@LeadTypeID+'%'' '
	IF Isnull(@LeadTypeName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.LeadTypeName,'''') LIKE N''%'+@LeadTypeName+'%''  '
	IF Isnull(@IsCommon, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.IsCommon,'''') LIKE N''%'+@IsCommon+'%'' '
	IF Isnull(@Disabled, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled,'''') LIKE N''%'+@Disabled+'%'' '

SET @sSQL = ' 
DECLARE @count int
Select @count = Count(LeadTypeID) From CRMT10201 M
WHERE '+@sWhere+'
SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @count AS TotalRow
					, M.APK, Case when isnull(M.IsCommon,0) =1 then '''' else M.DivisionID end As DivisionID 
					, M.LeadTypeID, M.LeadTypeName
					, M.Disabled, D6.Description as DisabledName
					, M.IsCommon, D5.Description as IsCommonName
					, M.Description
					, M.CreateUserID, A.FullName as CreateUserName, M.CreateDate
					, M.LastModifyUserID, B.FullName as LastModifyUserName, M.LastModifyDate
			FROM CRMT10201 M With (NOLOCK) 
			left join AT0099 D5 With (NOLOCK) on M.IsCommon = D5.ID and D5.CodeMaster = ''AT00000004''
			left join AT0099 D6 With (NOLOCK) on M.Disabled = D6.ID and D6.CodeMaster = ''AT00000004''
			LEFT JOIN AT1103 A With (NOLOCK) On M.CreateUserID = A.EmployeeID
			LEFT JOIN AT1103 B With (NOLOCK) On M.LastModifyUserID = B.EmployeeID
											 
			WHERE '+@sWhere+'
			ORDER BY '+@OrderBy+''
EXEC (@sSQL)
--print (@sSQL)