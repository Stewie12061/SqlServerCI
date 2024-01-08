IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP30221]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP30221]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
----In báo cáo Báo cáo khách hàng không tương tác với dịch vụ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Kiều Nga on 27/03/2023
-- <Example>
----    EXEC CRMP30221 'AS','',0,'2017-01-03 00:00:00','2017-06-30 00:00:00','06/2017','','','','', 'ASOFTADMIN','PHUONG'', ''QUI'', ''QUYNH'', ''VU'
CREATE PROCEDURE [dbo].[CRMP30221] ( 
        @DivisionID       VARCHAR(50),  --Biến môi trường
		@DivisionIDList    NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
		@ReportDate       VARCHAR(50), -- Ngày báo cáo
		@InteractDate      VARCHAR(50) = '30', -- Số ngày không/có tương tác
		@CheckInteract      TINYINT = 0,  --Check KH có tương tác : 1 có , 0 không
		@EmployeeID      NVARCHAR(MAX),
		@UserID  VARCHAR(50),
		@ConditionObjectID NVARCHAR(MAX) 		
)
AS
DECLARE
		@sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX) ='',
		@sWhere1 NVARCHAR(MAX) ='',
		@sWhere2 NVARCHAR(MAX)=''

	SET @InteractDate = ISNULL(@InteractDate,'30')

    --Check Para DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere1 =@sWhere1+ ' M.DivisionID IN ( '''+ @DivisionID+''',''@@@'')'
	ELSE 
		SET @sWhere1 = @sWhere1+ ' M.DivisionID IN ('''+@DivisionIDList+''',''@@@'')'

	IF (ISNULL(@EmployeeID, '') ='' OR ISNULL(@EmployeeID, '') ='%')
	BEGIN
		SET @sWhere = @sWhere1 +' 
		AND M.AssignedToUserID IN (''' +@ConditionObjectID+ ''') '
	END
	ELSE IF (ISNULL(@EmployeeID, '') !='')
	BEGIN
		SET @sWhere = @sWhere1 +' 
		AND M.AssignedToUserID IN (''' +@EmployeeID+ ''') '
	END

	-- Check tương tác
	IF(@CheckInteract = 1)
	BEGIN
			SET @sWhere2 = @sWhere2 +' 
		AND DATEADD(dd,+'+@InteractDate+',CAST(CONVERT(VARCHAR,TimeRequest,102) AS DATETIME)) >= CAST(CONVERT(VARCHAR,'''+@ReportDate+''',102) AS DATETIME) '
	END
	ELSE
	BEGIN
			SET @sWhere2 = @sWhere2 +' 
		AND DATEADD(dd,+'+@InteractDate+',CAST(CONVERT(VARCHAR,TimeRequest,102) AS DATETIME)) < CAST(CONVERT(VARCHAR,'''+@ReportDate+''',102) AS DATETIME) '
	END

---Load danh sách cơ hội theo giai đoạn
SET @sSQL ='
	SELECT * FROM (
	    SELECT ROW_NUMBER() OVER (PARTITION BY M.AccountID ORDER BY TimeRequest DESC) AS rn
			, M.APK, M.DivisionID, M.SupportRequiredID, M.SupportRequiredName, M.PriorityID, M.StatusID, M.TimeRequest, M.DeadlineRequest, M.ReleaseVerion, M.CreateDate
			, M.AccountID
			, M.ContactID
			, M.InventoryID
			, M.AssignedToUserID  
			, C1.ObjectName AS AccountName
			, C2.ContactName AS ContactName
			, C2.HomeMobile AS Phone
			, C3.InventoryName AS InventoryName
			, C4.FullName AS AssignedToUserName
			, C5.StatusName AS StatusName
			, (CASE WHEN [dbo].GetStatusQualityOfWork(M.DeadlineRequest,M.ActualEndDate,'''',M.AccountID,C5.StatusName) = ''0'' THEN NCHAR(272) + NCHAR(7841)+ N''t'' 
				WHEN [dbo].GetStatusQualityOfWork(M.DeadlineRequest,M.ActualEndDate,'''',M.AccountID,C5.StatusName) = ''1'' THEN N''Không '' + NCHAR(273) + NCHAR(7841)+ N''t'' 
				ELSE N'''' END) AS StatusQualityOfWork
			, C6.Description AS PriorityName
			, C7.Description AS TypeOfRequest
		FROM OOT2170 M WITH (NOLOCK)
		LEFT JOIN AT1202 C1 WITH (NOLOCK) ON C1.ObjectID = M.AccountID AND M.DivisionID = C1.DivisionID								-- Khách hàng
		LEFT JOIN CRMT10001 C2 WITH (NOLOCK) ON C2.ContactID = M.ContactID AND M.DivisionID = C2.DivisionID							-- Liên hệ
		LEFT JOIN AT1302 C3 WITH (NOLOCK) ON C3.InventoryID = M.InventoryID AND M.DivisionID = C3.DivisionID						-- Mặt hàng
		LEFT JOIN AT1103 C4 WITH (NOLOCK) ON C4.EmployeeID = M.AssignedToUserID	AND M.DivisionID = C4.DivisionID					-- nhân viên
		LEFT JOIN OOT1040 C5 WITH (NOLOCK) ON C5.StatusID = M.StatusID										-- Trạng thái 
		LEFT JOIN CRMT0099 C6 WITH (NOLOCK) ON M.PriorityID = C6.ID AND C6.CodeMaster = N''CRMT00000006''   -- Độ ưu tiên
		LEFT JOIN CRMT0099 C7 WiTH (NOLOCK) ON C7.ID = M.TypeOfRequest AND C7.CodeMaster = ''CRMF2160.TypeOfRequest''
		WHERE '+@sWhere+' 
		) A
	WHERE rn = 1 '+@sWhere2+'
	ORDER BY AssignedToUserID,AssignedToUserName,AccountID,AccountName
		'

PRINT (@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO