IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP30801]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP30801]
GO
SET QUOTED_IDENTIFIER ON
GO

-- <Summary>
----In báo cáo yêu cầu khách hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Thị Phượng on 27/01/2016
--- Modify by Hoàng vũ, Date 25/09/2018: Convert chuyển lấy dữ liệu khách hàng CRM (CRMT10101)-> Khách hàng POS (POST0011)
--- Modify by Hoài Bảo, Date 26/09/2022: Cập nhật biến truyền vào dạng danh sách
--- Modify by Hoài Bảo, Date 10/04/2022: Bổ sung điều kiện lọc, load dữ liệu theo template
-- <Example>
----    EXEC CRMP30801 'HCM','','','','','', 'ASOFTADMIN'

CREATE PROCEDURE [dbo].[CRMP30801] ( 
        @DivisionID       VARCHAR(50),  --Biến môi trường
		@DivisionIDList    NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
		@IsDate			TINYINT,		--1: Theo ngày; 0: Theo kỳ
		@FromDate       DATETIME,
		@ToDate         DATETIME,
		@PeriodIDList	NVARCHAR(2000),
		@AccountID    NVARCHAR(MAX),
		@EmployeeID      NVARCHAR(MAX),
		@TemplateID NVARCHAR(250),
		@UserID  VARCHAR(50)	
)
AS

DECLARE
		@sSQL NVARCHAR (MAX),
		@sSQL1 NVARCHAR (MAX),
		@sWhere Nvarchar(Max),
		@sWhere2 Nvarchar(MAX),
		@OrderBy NVARCHAR(500)

SET @sWhere = ''
SET @sWhere2 = ''
SET @OrderBy = 'C.CreateDate DESC'

--Check Para DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL OR @DivisionIDList = ''
	BEGIN
		SET @sWhere =@sWhere + ' C.DivisionID = '''+ @DivisionID+ ''' '
		SET @sWhere2 =@sWhere2 + ' (A.DivisionID = '''+ @DivisionID+''' OR A.IsCommon = 1) '
	END
	ELSE
	BEGIN
		SET @sWhere = @sWhere + ' C.DivisionID IN ('''+@DivisionIDList+''') '
		SET @sWhere2 = @sWhere2 + ' (A.DivisionID IN ('''+@DivisionIDList+''') OR A.IsCommon = 1)'
	END

--Search theo điều điện thời gian
	IF @IsDate = 1	
	BEGIN
		SET @sWhere = @sWhere + ' AND (CONVERT(VARCHAR(10),C.TimeRequest,112) BETWEEN'''+ CONVERT(VARCHAR(20),@FromDate,112)+''' AND''' + CONVERT(VARCHAR(20),@ToDate,112) +'''
									OR CONVERT(VARCHAR(10),C.CreateDate,112) BETWEEN'''+ CONVERT(VARCHAR(20),@FromDate,112)+''' AND''' + CONVERT(VARCHAR(20),@ToDate,112) +''')'
		SET @sWhere2 = @sWhere2 + ' AND (CONVERT(VARCHAR(10),C.TimeRequest,112) BETWEEN'''+ CONVERT(VARCHAR(20),@FromDate,112)+''' AND''' + CONVERT(VARCHAR(20),@ToDate,112) +'''
									OR CONVERT(VARCHAR(10),C.CreateDate,112) BETWEEN'''+ CONVERT(VARCHAR(20),@FromDate,112)+''' AND''' + CONVERT(VARCHAR(20),@ToDate,112) +''')'
	END
	ELSE
	BEGIN
		SET @sWhere = @sWhere + ' AND ((CASE WHEN  MONTH(C.TimeRequest) < 10 THEN ''0''+RTRIM(LTRIM(STR(MONTH(C.TimeRequest))))+''/''+LTRIM(RTRIM(STR(YEAR(C.TimeRequest)))) 
										ELSE RTRIM(LTRIM(STR(MONTH(C.TimeRequest))))+''/''+LTRIM(RTRIM(STR(YEAR(C.TimeRequest)))) END) IN ('''+@PeriodIDList+''')
									OR (CASE WHEN  MONTH(C.CreateDate) < 10 THEN ''0''+RTRIM(LTRIM(STR(MONTH(C.CreateDate))))+''/''+LTRIM(RTRIM(STR(YEAR(C.CreateDate)))) 
										ELSE RTRIM(LTRIM(STR(MONTH(C.CreateDate))))+''/''+LTRIM(RTRIM(STR(YEAR(C.CreateDate)))) END) IN ('''+@PeriodIDList+'''))'

		SET @sWhere2 = @sWhere2 + ' AND ((CASE WHEN  MONTH(C.TimeRequest) < 10 THEN ''0''+RTRIM(LTRIM(STR(MONTH(C.TimeRequest))))+''/''+LTRIM(RTRIM(STR(YEAR(C.TimeRequest)))) 
										ELSE RTRIM(LTRIM(STR(MONTH(C.TimeRequest))))+''/''+LTRIM(RTRIM(STR(YEAR(C.TimeRequest)))) END) IN ('''+@PeriodIDList+''')
									OR (CASE WHEN  MONTH(C.CreateDate) < 10 THEN ''0''+RTRIM(LTRIM(STR(MONTH(C.CreateDate))))+''/''+LTRIM(RTRIM(STR(YEAR(C.CreateDate)))) 
										ELSE RTRIM(LTRIM(STR(MONTH(C.CreateDate))))+''/''+LTRIM(RTRIM(STR(YEAR(C.CreateDate)))) END) IN ('''+@PeriodIDList+'''))'
	END

	--IF ((Isnull(@FromAccountID, '') !='')and (Isnull(@ToAccountID, '') !=''))
	--	SET @sWhere2 = @sWhere2 +' AND (A.MemberID between N'''+@FromAccountID+''' and N'''+@ToAccountID+''')'
	--IF ((Isnull(@FromAccountID, '') !='')and (Isnull(@ToAccountID, '') =''))
	--	SET @sWhere2 = @sWhere2 +'AND cast(A.MemberID as Nvarchar(50)) >= N'''+cast(@FromAccountID as Nvarchar(50))+''''
	--IF ((Isnull(@FromAccountID, '') ='')and (Isnull(@ToAccountID, '') !=''))
	--	SET @sWhere2 = @sWhere2 +'AND cast(A.MemberID as Nvarchar(50)) <= N'''+cast(@ToAccountID as Nvarchar(50))+''''

	IF ISNULL(@AccountID, '') != ''
		SET @sWhere2 = @sWhere2 + ' AND A.MemberID IN (SELECT Value FROM [dbo].StringSplit(''' +@AccountID+ ''', '','')) '

	IF ISNULL(@EmployeeID, '') != ''
		SET @sWhere2 = @sWhere2 + ' AND A.AssignedToUserID IN (SELECT Value FROM [dbo].StringSplit(''' +@EmployeeID+ ''', '','')) '
	
	--IF ((Isnull(@FromEmployeeID, '') !='')and (Isnull(@ToEmployeeID, '') !=''))
	--	SET @sWhere2 = @sWhere2 +' AND (A.AssignedToUserID between N'''+@FromEmployeeID+''' and N'''+@ToEmployeeID+''')'
	--IF ((Isnull(@FromEmployeeID, '') !='')and (Isnull(@ToEmployeeID, '') =''))
	--	SET @sWhere2 = @sWhere2 +'AND cast(A.AssignedToUserID as Nvarchar(50)) >= N'''+cast(@FromEmployeeID as Nvarchar(50))+''''
	--IF ((Isnull(@FromEmployeeID, '') ='')and (Isnull(@ToEmployeeID, '') !=''))
	--	SET @sWhere2 = @sWhere2 +' AND cast(A.AssignedToUserID as Nvarchar(50)) <= N'''+cast(@ToEmployeeID as Nvarchar(50))+''''

---Load danh sách khách hàng và yêu cầu
SET @sSQL =
	' SELECT A.APK, A.DivisionID, A.MemberID as AccountID, A.Membername as AccountName, A.Address, A.Tel, A.Email, A.Description
		, A.Varchar01, A.Varchar02, A.Varchar03, A.Varchar04, A.Varchar05, A.Varchar06, A.Varchar07, A.Varchar08, A.Varchar09, A.Varchar10
		, A.Varchar11, A.Varchar12, A.Varchar13, A.Varchar14, A.Varchar15, A.Varchar16, A.Varchar17, A.Varchar18, A.Varchar19, A.Varchar20
		, B.RequestID, C.RequestSubject, C.RequestDescription, C.AssignedToUserID, A1.FullName as AssignedToUserName
		, C.TimeRequest, C.DeadlineRequest, C.FeedbackDescription
		, C.LastModifyDate, A2.FullName AS LastModifyUserID
		FROM POST0011 A WITH (NOLOCK)
		INNER JOIN CRMT20801_CRMT10101_REL B WITH (NOLOCK) ON CONVERT(VARCHAR(50), A.APK) = B.AccountID
		LEFT JOIN CRMT20801 C WITH (NOLOCK) ON C.RequestID = B.RequestID
		LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = C.AssignedToUserID
		LEFT JOIN AT1103 A2 WITH (NOLOCK) ON A2.EmployeeID = C.LastModifyUserID
		WHERE '+@sWhere2+'
		'

SET @sSQL1 = N'SELECT C.APK, C.DivisionID, C.RequestID, C.RequestCustomerID, C.RequestSubject, C.RelatedToTypeID
				, C.PriorityID, C02.Description AS PriorityName , C.RequestStatus, C01.Description AS RequestStatusName
				, C.TimeRequest, C.DeadlineRequest, C.AssignedToUserID, A.FullName AS AssignedToUserName
				, C.RequestDescription, C05.SupportDictionarySubject AS SupportDictionaryID, C06.KindName AS KindID
				, C.CreateDate, C.FeedbackDescription, C.LastModifyDate, A2.FullName AS LastModifyUserID
				, C.DeadlineExpect, C.CompleteDate, C.DurationTime, C.RealTime
				, C.RequestTypeID, C03.Description AS RequestTypeName
				, C.BugTypeID, C04.Description AS BugTypeName
				, C.ProjectID, O1.ProjectName AS ProjectName
				, C.OpportunityID, C07.OpportunityName
				, C.ContactID, C1.ContactName AS ContactName
				, C.InventoryID
				, STUFF((SELECT '', '' + '' '' + A1.InventoryName
					FROM CRMT20802 C1 WITH (NOLOCK)
						LEFT JOIN AT1302 A1 WITH (NOLOCK) ON A1.InventoryID = C1.InventoryID
					WHERE C1.APKMaster = C.APK
					FOR XML PATH('''')), 1, 1, '''') AS InventoryName
			INTO #CRMT20801
			FROM CRMT20801 C WITH (NOLOCK)
				LEFT JOIN AT1103 A WITH (NOLOCK) ON A.EmployeeID = C.AssignedToUserID
				LEFT JOIN CRMT0099 C01 WITH (NOLOCK) ON C01.ID = C.RequestStatus AND C01.CodeMaster = ''CRMT00000003''
				LEFT JOIN CRMT0099 C02 WITH (NOLOCK) ON C02.ID = C.PriorityID AND C02.CodeMaster = ''CRMT00000006''
				LEFT JOIN CRMT0099 C03 WITH (NOLOCK) ON C03.ID = C.TypeOfRequest AND C03.CodeMaster = ''CRMF2080.TypeOfRequest''
				LEFT JOIN CRMT0099 C04 WITH (NOLOCK) ON C04.ID = C.BugTypeID AND C04.CodeMaster = ''CRMT00000026''
				LEFT JOIN CRMT1090 C05 WITH (NOLOCK) ON C05.SupportDictionaryID = C.SupportDictionaryID
				LEFT JOIN CRMT1100 C06 WITH (NOLOCK) ON C06.KindID = C.KindID
				LEFT JOIN CRMT20501 C07 WITH (NOLOCK) ON C07.OpportunityID = C.OpportunityID
				LEFT JOIN AT1015 A1 WITH (NOLOCK) ON A1.AnaID = C.ProjectID
				LEFT JOIN OOT2100 O1 WITH (NOLOCK) ON O1.ProjectID = C.ProjectID
				LEFT JOIN CRMT10001 C1 WITH (NOLOCK) ON C1.ContactID = C.ContactID
				LEFT JOIN AT1302 C2 WITH (NOLOCK) ON C2.InventoryID = C.InventoryID
				LEFT JOIN AT1103 A2 WITH (NOLOCK) ON A2.EmployeeID = C.LastModifyUserID
			WHERE ' + @sWhere + '

			DECLARE @Count INT
			SELECT @Count = Count(RequestID) FROM #CRMT20801

			SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow, *
			FROM #CRMT20801 C WITH (NOLOCK)
			ORDER BY ' + @OrderBy + '
			'
IF ISNULL(@TemplateID,'') = 'CRMR30801'
BEGIN
	PRINT (@sSQL1)
	EXEC (@sSQL1)
END
ELSE
BEGIN
	PRINT (@sSQL)
	EXEC (@sSQL)
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO