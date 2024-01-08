IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP20503]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP20503]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- CRMP20503 In/xuất excel danh muc cơ hội
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Phan thanh hoàng vũ, Date: 13/03/2017
----Edited by: Phan thanh hoàng vũ, Date: 05/05/2017: Bổ sung điều kiện search phân quyền xem
----Edited by: Phan thanh hoàng vũ, Date: 12/06/2017: Bổ sung @@@ để load dữ liệu dùng chung
----Edited by: Cao Thị Phượng, Date: 05/07/2017: Cải tiến tốc độ
----Edited by: Hoàng Vũ, Date: 06/07/2017: Cải tiến tốc độ
----Edited by: Hoài Bảo, Date: 17/08/2022: Cập nhật điều kiện search LIKE -> IN cho các combobox chọn nhiều
----Edited by: Anh Đô, Date: 14/12/2022: Bổ sung lọc theo ListAPK
-- <Example> EXEC CRMP20503 'AS' ,'','' ,'' ,'' ,'' ,'' ,'' ,'' ,'' , 'NV01' , N'ASOFTADMIN'', ''DANH'', ''HOANG'', ''HUYEN'', ''LIEN'', ''LUAN'', ''PHUONG'', ''QUI'', ''QUYNH'', ''VU'

CREATE PROCEDURE CRMP20503 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@DivisionIDList NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
        @OpportunityID nvarchar(50),
        @OpportunityName nvarchar(250),
		@StageID nvarchar(250),
		@NextActionID nvarchar(250),
		@PriorityID nvarchar(250),
		@AssignedToUserID nvarchar(250),
		@IsCommon nvarchar(100),
		@Disabled nvarchar(100),
		@UserID  VARCHAR(50), --Biến môi trường
		@ConditionOpportunityID nvarchar(max), --Biến môi trường
		@ListAPK VARCHAR(MAX) = ''
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX)
		
	SET @sWhere = ''
	--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' M.DivisionID IN ('''+@DivisionIDList+''', ''@@@'')'
	Else 
		SET @sWhere = @sWhere + ' M.DivisionID IN ('''+@DivisionID+''', ''@@@'')'

	IF Isnull(@OpportunityID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.OpportunityID, '''') LIKE N''%'+@OpportunityID+'%'' '
	IF Isnull(@OpportunityName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.OpportunityName,'''') LIKE N''%'+@OpportunityName+'%''  '
	IF Isnull(@StageID, '') != ''
		SET @sWhere = @sWhere +  'AND ISNULL(M.StageID,'''') IN ('''+@StageID+''') ' --LIKE N''%'+@StageID+'%'' '
	IF Isnull(@NextActionID, '') != ''
		SET @sWhere = @sWhere +  'AND ISNULL(M.NextActionID,'''') LIKE N''%'+@NextActionID+'%'' '
	IF Isnull(@PriorityID, '') != '' 
		SET @sWhere = @sWhere +  'AND ISNULL(M.PriorityID,'''') IN ('''+@PriorityID+''') ' --LIKE N''%'+@PriorityID+'%'' '
	IF Isnull(@AssignedToUserID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.AssignedToUserID,'''') LIKE N''%'+@AssignedToUserID+'%''  '
	IF Isnull(@IsCommon, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.IsCommon,'''') LIKE N''%'+@IsCommon+'%'' '
	IF Isnull(@Disabled, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled,'''') LIKE N''%'+@Disabled+'%'' '
	IF Isnull(@ConditionOpportunityID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.AssignedToUserID,M.CreateUserID) in (N'''+@ConditionOpportunityID+''' )'
	IF ISNULL(@ListAPK, '') != ''
		SET @sWhere = @sWhere + ' AND M.APK IN ('''+ @ListAPK +''') '

SET @sSQL = ' SELECT M.APK, Case when M.IsCommon = 1 then '''' else M.DivisionID end as DivisionID
					, M.OpportunityID
					, M.OpportunityName
					, M.StageID, D1.StageName
					, M.NextActionID, D7.NextActionName
					, M.PriorityID, D6.Description as PriorityName
					, M.AssignedToUserID, D4.FullName as AssignedToUserName
					, M.Disabled, M.IsCommon
					, M.ExpectAmount
					, M.Notes
					, ISNULL(M.Rate, 0) / 100 AS Rate
			FROM CRMT20501 M With (NOLOCK)   
					left join CRMT10401 D1 With (NOLOCK) on M.StageID = D1.StageID
					left join AT1103 D4 With (NOLOCK) on M.AssignedToUserID = D4.EmployeeID and D4.DivisionID = N'''+ @DivisionID+'''
					left join CRMT0099 D6 With (NOLOCK) on M.PriorityID = D6.ID and D6.CodeMaster = ''CRMT00000006''
					left join CRMT10801 D7 With (NOLOCK) on M.NextActionID = D7.NextActionID
			WHERE '+@sWhere+' 
			ORDER BY OpportunityID'
		
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
