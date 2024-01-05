IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP30031]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP30031]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
----In báo cáo Thống kê cơ hội theo giai đoạn
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Thị Phượng on 07/06/2017
--- Modify by Thị Phượng, Date 04/07/2017: Bổ sung phân quyền
--- Modify by Hoài Bảo, Date 08/09/2022: Cập nhật Convert cột ExpectAmount sang Decimal, do trong bảng CRMT20501 cột ExpectAmount định dạng Decimal
--- Modify by Hoài Bảo, Date 06/10/2022: Cập nhật param truyền vào store do thay đổi control trên màn hình lọc
-- <Example>
----    EXEC CRMP30031 'AS','',0,'2017-01-03 00:00:00','2017-06-30 00:00:00','06/2017','','','','', 'ASOFTADMIN','PHUONG'', ''QUI'', ''QUYNH'', ''VU'
CREATE PROCEDURE [dbo].[CRMP30031] ( 
        @DivisionID       VARCHAR(50),  --Biến môi trường
		@DivisionIDList    NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
		@IsDate			TINYINT,		--1: Theo ngày; 0: Theo kỳ
		@FromDate       DATETIME,
		@ToDate         DATETIME,
		@PeriodIDList	NVARCHAR(2000),
		@StageID         NVARCHAR(50),
		@EmployeeID      NVARCHAR(50),
		@UserID  VARCHAR(50),
		@ConditionOpportunityID NVARCHAR(MAX)
		
)
AS
DECLARE
		@sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@Columns NVARCHAR(MAX),
@cols NVARCHAR(MAX)

SET @sWhere = ''
--Check Para DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere =@sWhere+ ' CR01.DivisionID IN ( '''+ @DivisionID+''',''@@@'')'
	ELSE 
		SET @sWhere = @sWhere+ ' CR01.DivisionID IN ('''+@DivisionIDList+''',''@@@'')'

--Search theo điều điện thời gian
	IF @IsDate = 1	
	BEGIN
		SET @sWhere = @sWhere+' AND (CONVERT(VARCHAR(10),CR01.CreateDate,112) BETWEEN '''+ CONVERT(VARCHAR(20),@FromDate,112)+''' AND ''' + CONVERT(VARCHAR(20),@ToDate,112) + ''')'
	END
	ELSE
	BEGIN
		SET @sWhere = @sWhere+' AND (CASE WHEN MONTH(CR01.CreateDate) < 10 THEN ''0'' + RTRIM(LTRIM(STR(MONTH(CR01.CreateDate)))) + ''/'' + LTRIM(RTRIM(STR(YEAR(CR01.CreateDate)))) 
										ELSE RTRIM(LTRIM(STR(MONTH(CR01.CreateDate)))) + ''/'' + LTRIM(RTRIM(STR(YEAR(CR01.CreateDate)))) END) IN ('''+@PeriodIDList+''')'
	END

	--IF ((Isnull(@FromStageID, '') !='')and (Isnull(@ToStageID, '') !=''))
	--	SET @sWhere = @sWhere +' AND (CR01.StageID between N'''+@FromStageID+''' and N'''+@ToStageID+''')'
	--IF ((Isnull(@FromStageID, '') !='')and (Isnull(@ToStageID, '') =''))
	--	SET @sWhere = @sWhere +'AND cast(CR01.StageID as Nvarchar(50)) >= N'''+cast(@FromStageID as Nvarchar(50))+''''
	--IF ((Isnull(@FromStageID, '') ='')and (Isnull(@ToStageID, '') !=''))
	--	SET @sWhere = @sWhere +'AND cast(CR01.StageID as Nvarchar(50)) <= N'''+cast(@ToStageID as Nvarchar(50))+'''' 
	
	--IF ((Isnull(@FromEmployeeID, '') !='')and (Isnull(@ToEmployeeID, '') !=''))
	--	SET @sWhere = @sWhere +' AND (CR01.AssignedToUserID between N'''+@FromEmployeeID+''' and N'''+@ToEmployeeID+''')'
	--IF ((Isnull(@FromEmployeeID, '') !='')and (Isnull(@ToEmployeeID, '') =''))
	--	SET @sWhere = @sWhere +'AND cast(CR01.AssignedToUserID as Nvarchar(50)) >= N'''+cast(@FromEmployeeID as Nvarchar(50))+''''
	--IF ((Isnull(@FromEmployeeID, '') ='')and (Isnull(@ToEmployeeID, '') !=''))
	--	SET @sWhere = @sWhere +' AND cast(CR01.AssignedToUserID as Nvarchar(50)) <= N'''+cast(@ToEmployeeID as Nvarchar(50))+''''

	IF (ISNULL(@StageID, '') !='')
		SET @sWhere = @sWhere + ' AND CR01.StageID IN (''' + @StageID + ''')'
	
	IF (ISNULL(@EmployeeID, '') !='')
		SET @sWhere = @sWhere +' AND CR01.AssignedToUserID IN (SELECT Value FROM [dbo].StringSplit(''' +@EmployeeID+ ''', '','')) '
	
	IF ISNULL(@ConditionOpportunityID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(CR01.AssignedToUserID,CR01.CreateUserID) IN (N'''+@ConditionOpportunityID+''' )'

---Load danh sách cơ hội theo giai đoạn
SET @sSQL ='
				SELECT CR01.DivisionID, AT01.DivisionName, CR01.OpportunityID, CR01.OpportunityName, CR01.AssignedToUserID AS EmployeeID, AT03.FullName AS EmployeeName
				, CASE WHEN ISNULL(CR01.StageID,'''') != '''' THEN CR01.StageID ELSE ''Other'' END StageID
				, CASE WHEN ISNULL(CR01.StageID,'''') != '''' then CR02.StageName ELSE ''Other'' END StageName
				, CONVERT(DECIMAL,CR01.ExpectAmount) AS ExpectAmount, CR01.NextActionID, CR03.NextActionName, CR01.NextActionDate
				, PO01.MemberName AS AccountID, CR01.CreateDate, AT04.FullName AS CreateUserID, CR01.Rate, CR01.ExpectedCloseDate, CR01.SourceID, CR04.LeadTypeName AS SourceName
				FROM CRMT20501 CR01 WITH (NOLOCK)
				LEFT JOIN AT1103 AT03 WITH (NOLOCK) ON CR01.AssignedToUserID = AT03.EmployeeID
				LEFT JOIN AT1103 AT04 WITH (NOLOCK) ON CR01.CreateUserID = AT04.EmployeeID
				LEFT JOIN CRMT10401 CR02 WITH (NOLOCK) ON CR01.StageID = CR02.StageID
				LEFT JOIN CRMT10201 CR04 WITH (NOLOCK) ON CR01.SourceID = CR04.LeadTypeID
				LEFT JOIN CRMT10801 CR03 WITH (NOLOCK) ON CR01.NextActionID = CR03.NextActionID
				LEFT JOIN AT1101 AT01 WITH (NOLOCK) ON AT01.DivisionID = CR01.DivisionID
				LEFT JOIN POST0011 PO01 WITH (NOLOCK) ON PO01.MemberID = CR01.AccountID
				WHERE   '+@sWhere+'
				ORDER BY CR01.StageID
		'

PRINT (@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO