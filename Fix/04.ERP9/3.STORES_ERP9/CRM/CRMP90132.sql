IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP90132]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP90132]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load màn hình lọc cơ hội
-- <Param>
----DivisionID : Đơn vị
----TxtSearch : Thông tin tìm kiếm cơ hội
----InventoryID : Mã mặt hàng
----AddressID : Địa điểm (khu vực)
----UserID : User thao tác
----PageNumber : Số trang
----PageSize : Số dòng trong 1 trang
----ConditionOpportunityID : Phân quyền
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by:Bảo Toàn Date 01/08/2019
-- <Example>

 CREATE PROCEDURE CRMP90132 (
     @DivisionID NVARCHAR(3),
     @TxtSearch NVARCHAR(250),
	 @InventoryID VARCHAR(50),
	 @AddressID varchar(50),
	 @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT,
	 @ConditionOpportunityID nvarchar(max)
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@sSQLJOIN NVARCHAR(max)
	begin
		SET @sWhere = ''
		SET @OrderBy = ' M.OpportunityID, M.OpportunityName'
	
		IF Isnull(@TxtSearch,'') != ''  
			SET @sWhere = @sWhere +'
				AND (M.OpportunityID LIKE N''%'+@TxtSearch+'%'' 
				OR M.OpportunityName LIKE N''%'+@TxtSearch+'%'' 
				OR M.AccountID LIKE N''%'+@TxtSearch+'%'' 
				OR M.StageID LIKE N''%'+@TxtSearch+'%'' 
				OR M.SourceID LIKE N''%'+@TxtSearch + '%'' 
				OR M.AssignedToUserID LIKE N''%'+@TxtSearch+'%'')'
	
		IF Isnull(@ConditionOpportunityID, '') != ''
			SET @sWhere = @sWhere + ' AND ISNULL(M.AssignedToUserID,M.CreateUserID) in (N'''+@ConditionOpportunityID+''' )'

		IF Isnull(@InventoryID,'') != ''  
			BEGIN
				SET @sSQLJOIN = '
				(
				select Ana02ID from OT3102 With (NOLOCK) where InventoryID = @InventoryID and isnull(Ana02ID,'''')<>'''' and DivisionID = @DivisionID
				union																			  
				select Ana02ID from OT3002 With (NOLOCK) where InventoryID = @InventoryID and isnull(Ana02ID,'''')<>'''' and DivisionID = @DivisionID
				union																		   
				select Ana02ID from OT2102 With (NOLOCK) where InventoryID = @InventoryID and isnull(Ana02ID,'''')<>'''' and DivisionID = @DivisionID
				union																			  
				select Ana02ID from OT2002 With (NOLOCK) where InventoryID = @InventoryID and isnull(Ana02ID,'''')<>'''' and DivisionID = @DivisionID
				) T inner join CRMT20501 M With (NOLOCK) on T.Ana02ID = M.OpportunityID and M.DivisionID = @DivisionID
				'
			END
		ELSE
			BEGIN
				SET @sSQLJOIN = '
					CRMT20501 M With (NOLOCK)   
				'
			END

		IF Isnull(@AddressID, '') != ''
			SET @sWhere = @sWhere + ' AND M.AreaID = '''+@AddressID+''''

		SET @sSQL = '
					SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, Count(1) Over() AS TotalRow
						,M.APK, M.DivisionID
						, M.OpportunityID, M.OpportunityName
						, M.StageID, D1.StageName
						, M.CampaignID
						, M.ExpectAmount
						, M.PriorityID, D6.Description as PriorityName
						, M.CauseID
						, M.Notes, M.AccountID
						, M.AssignedToUserID, D4.FullName as AssignedToUserName
						, M.SourceID, D2.LeadTypeName
						, M.StartDate, M.ExpectedCloseDate, M.Rate
						, M.NextActionID, D7.NextActionName, M.NextActionDate
						, M.Disabled, M.IsCommon
						, M.CreateUserID, M.CreateDate
						, M.LastModifyUserID, M.LastModifyDate
				FROM '+@sSQLJOIN+'
					left join CRMT10401 D1 With (NOLOCK) on M.StageID = D1.StageID
					left join CRMT10201 D2 With (NOLOCK) on M.SourceID = D2.LeadTypeID
					left join AT1103 D4 With (NOLOCK) on M.AssignedToUserID = D4.EmployeeID
					left join CRMT0099 D6 With (NOLOCK) on M.PriorityID = D6.ID and D6.CodeMaster = ''CRMT00000006''
					left join CRMT10801 D7 With (NOLOCK) on M.NextActionID = D7.NextActionID '
					+'WHERE M.DivisionID = @DivisionID ' + @sWhere + 
					' ORDER BY M.OpportunityID, M.OpportunityName
					OFFSET (@PageNumber-1) * @PageSize ROWS
					FETCH NEXT @PageSize ROWS ONLY '

		print @sSQL
		declare @paraSQL nvarchar(500)
		set @paraSQL = '
			@DivisionID NVARCHAR(3),
			@InventoryID VARCHAR(50),
			@PageNumber INT,
			@PageSize INT,
			@OrderBy NVARCHAR(500)
		'
		exec sp_executesql @sSQL, @paraSQL,
			@DivisionID = @DivisionID, 
			@InventoryID = @InventoryID,
			@PageNumber = @PageNumber,
			@PageSize = @PageSize,
			@OrderBy = @OrderBy
	end
	
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
