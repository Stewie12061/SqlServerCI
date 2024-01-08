IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP30021]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP30021]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
----In báo cáo Tổng hợp cơ hội từ các nguồn đầu mối
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Thị Phượng on 07/06/2017
--- Modify by Thị Phượng, Date 04/07/2017: Bổ sung phân quyền
--- Modify by Lê Hoàng, Date 22/09/2021: Bổ sung điều kiện DivisionID
--- Modify by Lê Hoàng, Date 07/10/2021: Bổ sung điều kiện DivisionID dùng chung @@@
--- Modify by Hoài Bảo, Date 27/09/2022: Thay đổi dữ liệu truyền vào dạng danh sách, Bổ sung điều kiện DeleteFlg không lấy những cơ hội đã xóa
-- <Example>
----    EXEC CRMP30021 'AS','',1,'2017-01-03 00:00:00','2017-06-30 00:00:00','06/2017','','','','', 'ASOFTADMIN', 'PHUONG'', ''QUI'', ''QUYNH'', ''VU'
CREATE PROCEDURE [dbo].[CRMP30021] ( 
        @DivisionID     VARCHAR(50),  --Biến môi trường
		@DivisionIDList NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
		@IsDate			TINYINT,		--1: Theo ngày; 0: Theo kỳ
		@FromDate       DATETIME,
		@ToDate         DATETIME,
		@PeriodIDList	NVARCHAR(2000),
		@EmployeeIDList NVARCHAR(MAX),
		@LeadTypeIDList   NVARCHAR(MAX),
		@UserID			VARCHAR(50),
		@ConditionOpportunityID NVARCHAR(MAX)
)
AS
DECLARE
		@sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@Columns NVARCHAR(MAX),
		@cols NVARCHAR(MAX),
		@DivisionTemp NVARCHAR(MAX)

SET @sWhere = 'ISNULL(CR01.DeleteFlg, 0) = 0'
--Check Para DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL OR @DivisionIDList = ''
		SET @sWhere = @sWhere+ ' AND (CR01.DivisionID = '''+ @DivisionID+''' OR CR01.IsCommon = 1)'
	ELSE
		SET @sWhere = @sWhere+ ' AND (CR01.DivisionID IN ('''+@DivisionIDList+''') OR CR01.IsCommon = 1)'

	IF @DivisionIDList IS NULL OR @DivisionIDList = ''
		SET @DivisionTemp = @DivisionID
	ELSE
		SET @DivisionTemp = @DivisionIDList
--Search theo điều điện thời gian
	IF @IsDate = 1	
	BEGIN
		SET @sWhere = @sWhere+ ' AND (CONVERT(VARCHAR(10),CR01.CreateDate,112) BETWEEN'''+ CONVERT(VARCHAR(20),@FromDate,112)+''' AND''' + CONVERT(VARCHAR(20),@ToDate,112) +''')'
	END
	ELSE
	BEGIN
		SET @sWhere =@sWhere+ ' AND (CASE WHEN  Month(CR01.CreateDate) < 10 THEN ''0''+RTRIM(LTRIM(STR(MONTH(CR01.CreateDate))))+''/''+LTRIM(RTRIM(STR(YEAR(CR01.CreateDate)))) 
										ELSE RTRIM(LTRIM(STR(MONTH(CR01.CreateDate))))+''/''+LTRIM(RTRIM(STR(YEAR(CR01.CreateDate)))) END) IN ('''+@PeriodIDList+''')'
	END

	IF ISNULL(@LeadTypeIDList, '') != ''
		SET @sWhere = @sWhere + ' AND CR01.SourceID IN (SELECT Value FROM [dbo].StringSplit(''' +@LeadTypeIDList+ ''', '','')) '

	IF ISNULL(@EmployeeIDList, '') != ''
		SET @sWhere = @sWhere + ' AND CR01.AssignedToUserID IN (SELECT Value FROM [dbo].StringSplit(''' +@EmployeeIDList+ ''', '','')) '

	--IF ((Isnull(@FromLeadTypeID, '') !='')and (Isnull(@ToLeadTypeID, '') !=''))
	--	SET @sWhere = @sWhere +' AND (CR01.SourceID between N'''+@FromLeadTypeID+''' and N'''+@ToLeadTypeID+''')'
	--IF ((Isnull(@FromLeadTypeID, '') !='')and (Isnull(@ToLeadTypeID, '') =''))
	--	SET @sWhere = @sWhere +'AND cast(CR01.SourceID as Nvarchar(50)) >= N'''+cast(@FromLeadTypeID as Nvarchar(50))+''''
	--IF ((Isnull(@FromLeadTypeID, '') ='')and (Isnull(@ToLeadTypeID, '') !=''))
	--	SET @sWhere = @sWhere +'AND cast(CR01.SourceID as Nvarchar(50)) <= N'''+cast(@ToLeadTypeID as Nvarchar(50))+'''' 
	
	--IF ((Isnull(@FromEmployeeID, '') !='')and (Isnull(@ToEmployeeID, '') !=''))
	--	SET @sWhere = @sWhere +' AND (CR01.AssignedToUserID between N'''+@FromEmployeeID+''' and N'''+@ToEmployeeID+''')'
	--IF ((Isnull(@FromEmployeeID, '') !='')and (Isnull(@ToEmployeeID, '') =''))
	--	SET @sWhere = @sWhere +'AND cast(CR01.AssignedToUserID as Nvarchar(50)) >= N'''+cast(@FromEmployeeID as Nvarchar(50))+''''
	--IF ((Isnull(@FromEmployeeID, '') ='')and (Isnull(@ToEmployeeID, '') !=''))
	--	SET @sWhere = @sWhere +' AND cast(CR01.AssignedToUserID as Nvarchar(50)) <= N'''+cast(@ToEmployeeID as Nvarchar(50))+''''
		
	IF ISNULL(@ConditionOpportunityID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(CR01.AssignedToUserID,CR01.CreateUserID) IN (N'''+@ConditionOpportunityID+''' )'
----Chuyển dòng thành cột
	DECLARE @CRMT20501 TABLE (
							LeadTypeName NVARCHAR(MAX),
							TotalRow INT)	
		
		SELECT  LeadTypeName, ROW_NUMBER() OVER (ORDER BY z.SourceID) AS RowNum INTO #CRMT20501 
		FROM 		
		(SELECT CASE WHEN ISNULL(CRMT20501.SourceID,'') != '' THEN CRMT20501.SourceID ELSE 'Other' END SourceID
		, CASE WHEN ISNULL(CRMT20501.SourceID,'') != '' THEN CR02.LeadTypeName ELSE 'Other' END LeadTypeName
		 FROM CRMT20501 WITH (NOLOCK)
		LEFT JOIN CRMT10201 CR02 WITH (NOLOCK) ON CR02.DivisionID IN (CRMT20501.DivisionID,'@@@') AND CRMT20501.SourceID = CR02.LeadTypeID
		WHERE CONCAT('''',@DivisionTemp,''',''@@@''') LIKE CONCAT('%''',CRMT20501.DivisionID,'''%')
		--(CONVERT(VARCHAR(10),CRMT20501.CreateDate,112) BETWEEN CONVERT(VARCHAR(20),@FromDate,112) AND CONVERT(VARCHAR(20),@ToDate,112))
		 --(CRMT20501.SourceID between @FromLeadTypeID and @ToLeadTypeID or isnull(CRMT20501.SourceID,'')='')
		GROUP BY CR02.LeadTypeName, CRMT20501.SourceID)z
		GROUP BY z.SourceID, LeadTypeName
		ORDER BY z.SourceID

		INSERT INTO @CRMT20501
		(
			LeadTypeName,
			TotalRow
		)	
	SELECT LeadTypeName,  RowNum
      FROM #CRMT20501 
	ORDER BY RowNum
      	
SELECT @cols= 
STUFF((SELECT  ','+ QUOTENAME(LeadTypeName)
FROM @CRMT20501 AS a
       ORDER BY a.TotalRow
 FOR XML PATH(''), TYPE ).value('.', 'NVARCHAR(MAX)')  ,1,1,'')
---Load danh sách đầu mối theo nguồn
SET @sSQL =
	'SELECT * FROM 
	(
			SELECT x.DivisionID, x.DivisionName, x.EmployeeID, x.EmployeeName, x.LeadTypeName, COUNT(OpportunityID) AS Quantity FROM
			(
				SELECT CR01.DivisionID, AT01.DivisionName, CR01.OpportunityID, CR01.OpportunityName, CR01.AssignedToUserID as EmployeeID, AT03.FullName AS EmployeeName
				, CASE WHEN ISNULL(CR01.SourceID,'''') != '''' THEN CR01.SourceID ELSE ''Other'' END SourceID
				, CASE WHEN ISNULL(CR01.SourceID,'''') != '''' THEN CR02.LeadTypeName ELSE ''Other'' END LeadTypeName
				FROM CRMT20501 CR01 WITH (NOLOCK)
				LEFT JOIN AT1103 AT03 WITH (NOLOCK) ON CR01.AssignedToUserID = AT03.EmployeeID
				LEFT JOIN CRMT10201 CR02 WITH (NOLOCK) ON CR01.SourceID = CR02.LeadTypeID
				LEFT JOIN AT1101 AT01 WITH (NOLOCK) ON AT01.DivisionID = CR01.DivisionID
				WHERE   '+@sWhere+'
			)x
				GROUP BY x.DivisionID, x.DivisionName, x.EmployeeID, x.EmployeeName, x.LeadTypeName
		)D	
		PIVOT (SUM(D.Quantity) FOR D.LeadTypeName IN ('+@cols+')) AS PivotedOrder
		'

--PRINT (@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
