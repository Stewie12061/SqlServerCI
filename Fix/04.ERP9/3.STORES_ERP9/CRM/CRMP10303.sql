IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP10303]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP10303]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- In/Xuất excel Danh mục nhóm người nhận
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Phan thanh hoàng Vũ on 17/03/2017
----Edited by: Phan thanh hoàng vũ, Date: 05/05/2017: Bổ sung điều kiện search phân quyền xem
----Edited by: Trọng Kiên, Date: 22/09/2020: Bổ sung load STT báo cáo
-- <Example> EXEC CRMP10303 'AS', 'AS'',''GS'',''GSC','' ,'' ,'' , '', '', 'NV01', N'ASOFTADMIN'', ''DANH'', ''HOANG'', ''HUYEN'', ''LIEN'', ''LUAN'', ''PHUONG'', ''QUI'', ''QUYNH'', ''VU'

CREATE PROCEDURE CRMP10303 
(	@DivisionID VARCHAR(50),		--Biến môi trường
	@DivisionIDList NVARCHAR(MAX),	--Chọn trong DropdownChecklist DivisionID	
    @GroupReceiverID nvarchar(50),
	@GroupReceiverName nvarchar(250),
	@Description nvarchar(250), 
	@IsCommon nvarchar(100),
	@Disabled nvarchar(100),
	@UserID  VARCHAR(50),			--Biến môi trường
	@ConditionGroupReceiverID nvarchar(max)			--Biến môi trường
)
AS
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500)
		
	SET @sWhere = ''
	SET @OrderBy = 'M.GroupReceiverID'
	
	--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' M.DivisionID IN ('''+@DivisionIDList+''', ''@@@'')'
	Else 
		SET @sWhere = @sWhere + ' M.DivisionID IN ('''+ @DivisionID+''', ''@@@'')'	

	IF isnull(@GroupReceiverID, '') != ''
		SET @sWhere = @sWhere + ' AND M.GroupReceiverID LIKE N''%'+@GroupReceiverID+'%''  '
	
	IF isnull(@GroupReceiverName, '') != ''
		SET @sWhere = @sWhere + ' AND M.GroupReceiverName LIKE N''%'+@GroupReceiverName+'%'' '

	IF isnull(@Description, '') != ''
		SET @sWhere = @sWhere + ' AND M.Description LIKE N''%'+@Description+'%'' '
	
	IF Isnull(@IsCommon, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.IsCommon,'''') LIKE N''%'+@IsCommon+'%'' '
	
	IF Isnull(@Disabled, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled,'''') LIKE N''%'+@Disabled+'%'' '

	IF Isnull(@ConditionGroupReceiverID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.CreateUserID, '''') in (N'''+@ConditionGroupReceiverID+''' )'


SET @sSQL =	  ' SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, M.APK, M.DivisionID, M.GroupReceiverID, M.GroupReceiverName, M.Description
					   , M.IsCommon, M.Disabled, M.CreateDate, M.CreateUserID, M.LastModifyDate, M.LastModifyUserID
				FROM CRMT10301 M With (NOLOCK) 
				WHERE '+@sWhere+'
				ORDER BY M.GroupReceiverID, M.GroupReceiverName '
				
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
