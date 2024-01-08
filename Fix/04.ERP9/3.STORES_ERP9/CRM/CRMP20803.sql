IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP20803]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP20803]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- In Grid Form CRMF20801 Danh mục yêu cầu
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng, Date: 27/03/2017
--- Modify by Thị Phượng, Date 08/05/2017: Bổ sung phân quyền
--- Modify by Tấn Đạt, Date 26/01/2018: Bổ sung thêm trường RequestTypeID, BugTypeID
--- Modify by Hoàng vũ, Date 25/09/2018: Convert chuyển lấy dữ liệu khách hàng CRM (CRMT10101)-> Khách hàng POS (POST0011)
--= Modify by Trọng Kiên, 21/08/2020: Fix câu điều kiện RequestStatus
--- Modify by Anh Đô, Date 16/12/2022: Bổ sung lọc theo ListAPK, select thêm cột AccountName
--- Modify by Anh Đô, Date 26/12/2022: Select thêm các cột ProjectName, OpportunityName, InventoryName, ContactName; Fix lỗi load sai Mức độ ưu tiên.
--- Modify by Anh Đô, Date 29/12/2022: Fix lỗi cột InventoryName không lên dữ liệu khi yêu cầu có nhiều mặt hàng.
-- <Example> exec CRMP20803 @DivisionID=N'HCM',@DivisionIDList=N'',@RequestSubject=N'',@AccountID=N'asdaa',@AssignedToUserID=N'',@RequestStatus=N'',@PriorityID=N'',@UserID=N'HCM07',@ConditionRequestID=NULL

CREATE PROCEDURE CRMP20803 ( 
  @DivisionID VARCHAR(50),  --Biến môi trường
  @DivisionIDList NVARCHAR(2000),      --Chọn trong DropdownChecklist DivisionID
  @RequestSubject nvarchar(50),
  @AccountID nvarchar(250),
  @AssignedToUserID nvarchar(250),
  @RequestStatus nvarchar(250),
  @PriorityID nvarchar(100),
  @UserID  VARCHAR(50),
  @ConditionRequestID NVARCHAR (MAX),
  @RequestTypeID varchar(250) = NULL,
  @BugTypeID varchar(50) = NULL,
  @ListAPK	VARCHAR(MAX) = ''
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@sWhereMemberID NVARCHAR(MAX),
		@OrderBy NVARCHAR(500)
		
	SET @sWhere = ''
	Set @sWhereMemberID = ''
	SET @OrderBy = 'M.CreateDate DESC'
	
	--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' M.DivisionID IN ('''+@DivisionIDList+''') '
	Else 
		SET @sWhere = @sWhere + ' M.DivisionID = N'''+ @DivisionID+''''
		
		
	IF Isnull(@RequestSubject, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.RequestSubject, '''') LIKE N''%'+@RequestSubject+'%'' '
	IF Isnull(@AccountID, '') != ''
		SET @sWhereMemberID = @sWhereMemberID + ' AND (ISNULL(B.MemberID,'''') LIKE N''%'+@AccountID+'%'' or  ISNULL(B.MemberName,'''') LIKE N''%'+@AccountID+'%'')  '
	IF Isnull(@AssignedToUserID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.AssignedToUserID,'''') LIKE N''%'+@AssignedToUserID+'%'' '
	IF Isnull(@RequestStatus, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.RequestStatus,'''') IN ('''+@RequestStatus+''') '
	IF Isnull(@PriorityID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.PriorityID,'''') LIKE N''%'+@PriorityID+'%'' '
	IF Isnull(@ConditionRequestID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.CreateUserID,'''') In ('''+@ConditionRequestID+''') '
	IF Isnull(@RequestTypeID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.RequestTypeID,'''') LIKE N''%'+@RequestTypeID+'%'' '
	IF Isnull(@BugTypeID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.BugTypeID,'''') LIKE N''%'+@BugTypeID+'%'' '
	IF ISNULL(@ListAPK, '') != ''
		SET @sWhere = @sWhere + ' AND M.APK IN ('''+ @ListAPK +''') '

SET @sSQL = ' SELECT  M.APK
					, M.DivisionID
					, M.RequestID
					, M.RequestSubject
					, M.PriorityID
					, C02.Description as PriorityName 
					, M.RequestStatus
					, C01.Description as RequestStatusName
					, M.TimeRequest
					, M.DeadlineRequest
					, M.AssignedToUserID
					, A.FullName as AssignedToUserName
					, M.RequestDescription
					, M.FeedbackDescription
					, M.CreateDate
					, M.CreateUserID +''_''+ A1.FullName as CreateUserName
					, M.LastModifyDate
					, M.LastModifyUserID +''_''+ A2.FullName as LastModifyUserName
					, M.RequestTypeID
					, C03.Description as RequestTypeName
					, M.BugTypeID
					, C04.Description as BugTypeName
					, stuff(isnull((Select '', '' +  B.MemberID From POST0011 B WITH (NOLOCK) 
								Left join CRMT20801_CRMT10101_REL D WITH (NOLOCK)  ON D.AccountID = B.APK 
								where D.RequestID = M.RequestID '+@sWhereMemberID+'
								Group by B.MemberID
								FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 2, '''') as RelatedToID
					, stuff(isnull((Select '', '' + B.MemberName From POST0011 B WITH (NOLOCK) 
								Left join CRMT20801_CRMT10101_REL D WITH (NOLOCK)  ON D.AccountID = B.APK 
								where D.RequestID = M.RequestID '+@sWhereMemberID+'
								Group by B.MemberID, B.MemberName
								FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 2, '''') as RelatedToName
					, stuff(isnull((Select '', '' + B.ObjectName From AT1202 B WITH (NOLOCK)
								Left join CRMT20801_CRMT10101_REL D WITH (NOLOCK)  ON D.AccountID = B.APK
								where D.RequestID = M.RequestID '+ @sWhereMemberID +'
								Group by B.ObjectName, B.ObjectName
								FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 2, '''') as AccountName
					,OOT2100.ProjectName
					,CRMT20501.OpportunityName
					,CRMT10001.ContactName
					,TRIM(STUFF((SELECT '', '' + '' '' + A1.InventoryName
					FROM CRMT20802 C1 WITH (NOLOCK)
						LEFT JOIN AT1302 A1 WITH (NOLOCK) ON A1.InventoryID = C1.InventoryID
					WHERE C1.APKMaster = M.APK
					FOR XML PATH('''')), 1, 1, '''')) AS InventoryName
			  From CRMT20801 M With (Nolock)
					Left join AT1103 A With (Nolock) On A.EmployeeID = M.AssignedToUserID
					Left join CRMT0099 C01 With (Nolock) On C01.ID = M.RequestStatus and C01.CodeMaster =''CRMT00000003''
					Left join CRMT0099 C02 With (Nolock) On C02.ID = M.PriorityID and C02.CodeMaster =''CRMT00000006''
					Left join AT1103 A1 With (Nolock) On A1.EmployeeID = M.CreateUserID
					Left join AT1103 A2 With (Nolock) On A2.EmployeeID = M.LastModifyUserID
					Left join CRMT0099 C03 With (Nolock) On C03.ID = M.RequestTypeID and C03.CodeMaster =''CRMT00000025''
					Left join CRMT0099 C04 With (Nolock) On C04.ID = M.BugTypeID and C04.CodeMaster =''CRMT00000026''
					LEFT JOIN OOT2100 WITH (NOLOCK) ON OOT2100.ProjectID = M.ProjectID
					LEFT JOIN CRMT20501 WITH (NOLOCK) ON CRMT20501.OpportunityID = M.OpportunityID
					LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = M.InventoryID
					LEFT JOIN CRMT10001 WITH (NOLOCK) ON CRMT10001.ContactID = M.ContactID
			WHERE '+@sWhere+'
			ORDER BY '+@OrderBy+' '
EXEC (@sSQL)
print (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
