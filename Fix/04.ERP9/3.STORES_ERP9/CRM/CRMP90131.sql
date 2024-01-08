IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP90131]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP90131]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
--- Load màn hình chọn cơ hội
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by:Thị Phượng Date 30/03/2017
--- Modify by Thị Phượng, Date 08/05/2017: Bổ sung phân quyền
--- Modify by Bảo Toàn, Date 05/03/2020: Bổ sung trạng thái duyệt customer ĐỨC TÍN
--- Modify by Đình Hòa, Date 26/05/2021: Bổ sung load thêm đơn vị dùng chung 
-- <Example>
/*
	exec 
	CRMP90131 @DivisionID=N'AS',@TxtSearch=N'',@UserID=N'CALL002',@PageNumber=N'1',@PageSize=N'10', 
	@ConditionOpportunityID = N'ASOFTADMIN'', ''DANH'', ''HOANG'', ''HUYEN'', ''LIEN'', ''LUAN'', ''PHUONG'', ''QUI'', ''QUYNH'', ''VU'
*/

 CREATE PROCEDURE CRMP90131 (
     @DivisionID NVARCHAR(2000),
     @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT,
	 @ConditionOpportunityID nvarchar(max),
	 @ContactID VARCHAR(MAX)='',
	 @ScreenID NVARCHAR(50)=''
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@CustomerName VARCHAR(10)

	SELECT top 1 @CustomerName  = CustomerName FROM CustomerIndex
	SET @sWhere = ''
	SET @OrderBy = ' M.OpportunityID, M.OpportunityName'
	
	IF Isnull(@TxtSearch,'') != ''  SET @sWhere = @sWhere +'
							AND (M.OpportunityID LIKE N''%'+@TxtSearch+'%'' 
							OR M.OpportunityName LIKE N''%'+@TxtSearch+'%'' 
							OR M.AccountID LIKE N''%'+@TxtSearch+'%'' 
							OR M.StageID LIKE N''%'+@TxtSearch+'%'' 
							OR M.SourceID LIKE N''%'+@TxtSearch + '%'' 
							OR M.AssignedToUserID LIKE N''%'+@TxtSearch+'%'')'

	IF Isnull(@ConditionOpportunityID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.AssignedToUserID,M.CreateUserID) in (N'''+@ConditionOpportunityID+''' )'

	IF ISNULL(@ContactID, '') != ''
		SET @sWhere = @sWhere + ' AND C1.ContactID LIKE N''%'+@ContactID+'%''  '

    IF Isnull(@ScreenID, '') = 'CRMF2081'
	   SET @sWhere = @sWhere + 'AND M.OpportunityID NOT IN (select CRMT20801.OpportunityID from CRMT20801 where CRMT20801.OpportunityID is not null AND CRMT20801.DeleteFlg = 0)'
	
	--- Customize ĐỨC TÍN
	IF ISNULL(@CustomerName,'') = '114'
	BEGIN
		--- Xác định thời gian áp dụng 06/03/2020
		SET @sWhere = @sWhere + ' AND( (ISNULL(M.Status,0) = 0 AND M.CreateDate < ''20200306'') OR (M.Status = 1 AND M.CreateDate >= ''20200306'')) '
	END

	SET @sSQL = '
				SELECT DISTINCT M.APK, M.DivisionID
					, M.OpportunityID, M.OpportunityName
					, M.StageID, D1.StageName
					, M.CampaignID
					, M.ExpectAmount
					, M.PriorityID, D6.Description as PriorityName
					, M.CauseID
					, M.Notes, M.AccountID, PT11.MemberName as AccountName
					, M.AssignedToUserID, D4.FullName as AssignedToUserName
					, M.SourceID, D2.LeadTypeName
					, M.StartDate, M.ExpectedCloseDate, M.Rate
					, M.NextActionID, D7.NextActionName, M.NextActionDate
					, M.Disabled, M.IsCommon
					, M.CreateUserID, M.CreateDate
					, M.LastModifyUserID, M.LastModifyDate
			Into #TemCRMT20501
			FROM CRMT20501 M With (NOLOCK)  left join CRMT10401 D1 With (NOLOCK) on M.StageID = D1.StageID
											left join CRMT10201 D2 With (NOLOCK) on M.SourceID = D2.LeadTypeID
											 left join AT1103 D4 With (NOLOCK) on M.AssignedToUserID = D4.EmployeeID
											 left join CRMT0099 D6 With (NOLOCK) on M.PriorityID = D6.ID and D6.CodeMaster = ''CRMT00000006''
											 left join CRMT10801 D7 With (NOLOCK) on M.NextActionID = D7.NextActionID
											 left join POST0011 PT11 With (NOLOCK) on PT11.MemberID = M.AccountID
											 LEFT JOIN CRMT20501_CRMT10001_REL C1 WITH (NOLOCK) ON M.APK = C1.OpportunityID
				WHERE M.DivisionID IN ('''+@DivisionID+''', ''@@@'') '+@sWhere+'
			
			DECLARE @count int
			Select @count = Count(OpportunityID) From #TemCRMT20501 
			SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @count AS TotalRow
					, M.APK, M.DivisionID
					, M.OpportunityID, M.OpportunityName
					, M.StageName as StageID
					, M.CampaignID
					, M.ExpectAmount
					, M.PriorityID, M.PriorityName
					, M.CauseID
					, M.Notes, M.AccountID, M.AccountName
					, M.AssignedToUserID, M.AssignedToUserName
					, M.LeadTypeName as SourceID
					, M.StartDate, M.ExpectedCloseDate, M.Rate
					, M.NextActionName as NextActionID, M.NextActionName, M.NextActionDate
					, M.Disabled, M.IsCommon
					, M.CreateUserID, M.CreateDate
					, M.LastModifyUserID, M.LastModifyDate
				From  #TemCRMT20501 M
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	EXEC (@sSQL)

	Print  @sSQL



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
