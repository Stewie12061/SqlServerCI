IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP30081]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP30081]
GO
SET QUOTED_IDENTIFIER ON
GO

-- <Summary>
----In báo cáo Phân tích khách hàng tiềm năng từ nguồn cơ hội
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Thị Phượng on 07/06/2017
--- Đưa vào bảng tạm rồi join lại với nhau
--- Modify by Thị Phượng, Date 04/07/2017: Bổ sung phân quyền
--- Modify by Hoàng vũ, Date 25/09/2018: Convert chuyển lấy dữ liệu khách hàng CRM (CRMT10101)-> Khách hàng POS (POST0011)
--- Modify by Kiều Nga, Date 15/02/2022: Fix lỗi không có dữ liệu @cols, @cols1
--- Modify by Hoài Bảo, Date 05/10/2022: Thay đổi control điều kiện lọc báo cáo, fix sai số liệu cột tổng đầu mối,cơ hôi,khách hàng
--- Modify by Hoài Bảo, Date 11/10/2022: Xóa câu lệnh left join không dùng trong query lấy danh sách cơ hội -> do join vào dẫn đến đếm sai số cơ hội
-- <Example>
----    EXEC CRMP30081 'AS','',1,'2017-01-03 00:00:00','2017-06-30 00:00:00','06/2017','','','','','','', 'ASOFTADMIN', 'VU', 'VU', 'VU'
CREATE PROCEDURE [dbo].[CRMP30081] ( 
        @DivisionID     VARCHAR(50),  --Biến môi trường
		@DivisionIDList NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
		@IsDate			TINYINT,		--1: Theo ngày; 0: Theo kỳ
		@FromDate       DATETIME,
		@ToDate         DATETIME,
		@PeriodIDList	NVARCHAR(2000),
		@LeadTypeID NVARCHAR(MAX),
		@StageID NVARCHAR(MAX),
		@EmployeeID NVARCHAR(MAX),
		@UserID			VARCHAR(50),
		@ConditionLeadID NVARCHAR(MAX),
		@ConditionOpportunityID NVARCHAR(MAX),
		@ConditionObjectID NVARCHAR(MAX)
)
AS
DECLARE
		@sSQL NVARCHAR (MAX),
		@sSQL1 NVARCHAR (MAX),
		@sSQL2 NVARCHAR (MAX),
		@sWhere1 NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX),
		@sWhere2 NVARCHAR(MAX),
		@sWhere3 NVARCHAR(MAX),
		@sWhere4 NVARCHAR(MAX),
		@sWhere5 NVARCHAR(MAX),
		@sWhere6 NVARCHAR(MAX),
		@sJoin NVARCHAR(MAX),
		@Columns NVARCHAR(MAX),
@cols NVARCHAR(MAX),
@cols1 NVARCHAR(MAX)

SET @sWhere1 = ''
SET @sWhere2 = ''
SET @sWhere3 = ''
SET @sWhere4 = ''
SET @sWhere5 = ''
SET @sWhere6 = ''
SET @sJoin = ''
--Search theo điều điện thời gian
	IF @IsDate = 1	
	BEGIN
		SET @sWhere = ' AND (CONVERT(VARCHAR(10),CR01.CreateDate,112) BETWEEN '''+ CONVERT(VARCHAR(20),@FromDate,112)+''' AND ''' + CONVERT(VARCHAR(20),@ToDate,112) +''')'
		SET @sWhere3 = ' AND (CONVERT(VARCHAR(10),A.CreateDate,112) BETWEEN '''+ CONVERT(VARCHAR(20),@FromDate,112)+''' AND ''' + CONVERT(VARCHAR(20),@ToDate,112) +''') AND'
		SET @sWhere4 = ' AND (CONVERT(VARCHAR(10),A.CreateDate,112) BETWEEN '''+ CONVERT(VARCHAR(20),@FromDate,112)+''' AND ''' + CONVERT(VARCHAR(20),@ToDate,112) +''') AND'
		SET @sWhere5 = ' AND (CONVERT(VARCHAR(10),A.CreateDate,112) BETWEEN '''+ CONVERT(VARCHAR(20),@FromDate,112)+''' AND ''' + CONVERT(VARCHAR(20),@ToDate,112) +''') AND'
	END
	ELSE
	BEGIN
		SET @sWhere = ' AND (CASE WHEN MONTH(CR01.CreateDate) < 10 THEN ''0'' + RTRIM(LTRIM(STR(MONTH(CR01.CreateDate)))) + ''/'' + LTRIM(RTRIM(STR(YEAR(CR01.CreateDate)))) 
										ELSE RTRIM(LTRIM(STR(MONTH(CR01.CreateDate)))) + ''/'' + LTRIM(RTRIM(STR(YEAR(CR01.CreateDate)))) END) IN ('''+@PeriodIDList+''')'

		SET @sWhere3 = ' AND (CASE WHEN MONTH(A.CreateDate) < 10 THEN ''0'' + RTRIM(LTRIM(STR(MONTH(A.CreateDate)))) + ''/'' + LTRIM(RTRIM(STR(YEAR(A.CreateDate)))) 
										ELSE RTRIM(LTRIM(STR(MONTH(A.CreateDate)))) + ''/'' + LTRIM(RTRIM(STR(YEAR(A.CreateDate)))) END) IN ('''+@PeriodIDList+''') AND'

		SET @sWhere4 = ' AND (CASE WHEN MONTH(A.CreateDate) < 10 THEN ''0'' + RTRIM(LTRIM(STR(MONTH(A.CreateDate)))) + ''/'' + LTRIM(RTRIM(STR(YEAR(A.CreateDate)))) 
										ELSE RTRIM(LTRIM(STR(MONTH(A.CreateDate)))) + ''/'' + LTRIM(RTRIM(STR(YEAR(A.CreateDate)))) END) IN ('''+@PeriodIDList+''') AND'

		SET @sWhere5 = ' AND (CASE WHEN MONTH(A.CreateDate) < 10 THEN ''0'' + RTRIM(LTRIM(STR(MONTH(A.CreateDate)))) + ''/'' + LTRIM(RTRIM(STR(YEAR(A.CreateDate)))) 
										ELSE RTRIM(LTRIM(STR(MONTH(A.CreateDate)))) + ''/'' + LTRIM(RTRIM(STR(YEAR(A.CreateDate)))) END) IN ('''+@PeriodIDList+''') AND'
	END

--Check Para DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL OR @DivisionIDList = ''
	BEGIN	
		SET @sWhere2 =@sWhere2+ ' (CR01.DivisionID = '''+ @DivisionID+''' OR CR01.IsCommon = 1)'
		SET @sWhere3 =@sWhere3+ ' (A.DivisionID = '''+ @DivisionID+''' OR A.IsCommon = 1)'
		SET @sWhere4 =@sWhere4+ ' (A.DivisionID = '''+ @DivisionID+''' OR A.IsCommon = 1)'
		SET @sWhere5 =@sWhere5+ ' (A.DivisionID = '''+ @DivisionID+''' OR A.IsCommon = 1)'
	END
	ELSE 
	BEGIN
		SET @sWhere2 = @sWhere2+ ' (CR01.DivisionID IN ('''+@DivisionIDList+''') OR CR01.IsCommon = 1)'
		SET @sWhere3 =@sWhere3+ ' (A.DivisionID IN ('''+ @DivisionID+''') OR A.IsCommon = 1)'
		SET @sWhere4 =@sWhere4+ ' (A.DivisionID IN ('''+ @DivisionID+''') OR A.IsCommon = 1)'
		SET @sWhere5 =@sWhere5+ ' (A.DivisionID IN ('''+ @DivisionID+''') OR A.IsCommon = 1)'
	END

	IF (ISNULL(@StageID, '') !='')
	BEGIN
		SET @sWhere = @sWhere + ' AND CR01.StageID IN (''' + @StageID + ''')'
		SET @sWhere4 = @sWhere4 + ' AND A.StageID IN (''' + @StageID + ''')'
		SET @sJoin = 'AND C.StageID IN (''' + @StageID + ''')'
	END
	
	IF (ISNULL(@EmployeeID, '') !='')
	BEGIN
		SET @sWhere = @sWhere +' AND CR01.AssignedToUserID IN (SELECT Value FROM [dbo].StringSplit(''' +@EmployeeID+ ''', '','')) '
		SET @sWhere6 = @sWhere6 +' AND C.DefAssignedToUserID IN (SELECT Value FROM [dbo].StringSplit(''' +@EmployeeID+ ''', '','')) '
	END

	IF ISNULL(@LeadTypeID, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND CR01.SourceID IN (SELECT Value FROM [dbo].StringSplit(''' +@LeadTypeID+ ''', '','')) '
		SET @sWhere6 = @sWhere6 + ' AND C.LeadTypeID IN (SELECT Value FROM [dbo].StringSplit(''' +@LeadTypeID+ ''', '','')) '
	END

	IF ISNULL(@ConditionLeadID,'')!=''
		SET @sWhere3 = @sWhere3 + ' AND ISNULL(A.AssignedToUserID,A.CreateUserID) IN ('''+@ConditionLeadID+''' )'
	IF ISNULL(@ConditionOpportunityID, '') != ''
	BEGIN
		SET @sWhere4 = @sWhere4 + ' AND ISNULL(A.AssignedToUserID,A.CreateUserID) IN (N'''+@ConditionOpportunityID+''' )'
		SET @sWhere2 = @sWhere2 + ' AND ISNULL(CR01.AssignedToUserID,CR01.CreateUserID) IN (N'''+@ConditionOpportunityID+''' )'
	END
	IF ISNULL(@ConditionObjectID,'')!=''
		SET @sWhere5 = @sWhere5 + ' AND (CASE WHEN ISNULL(A.AssignedToUserID,'''') != '''' THEN A.AssignedToUserID ELSE A.CreateUserID END ) IN ('''+@ConditionObjectID+''' )'

----Chuyển dòng thành cột
DECLARE @CRMT2051 TABLE (
							StageName NVARCHAR(MAX),
							TotalRow INT)
		
		SELECT StageName, ROW_NUMBER() OVER (ORDER BY z.StageID) AS RowNum INTO #CRMT2051 
		FROM 		
		(SELECT CR01.StageID, CR02.StageName
		 FROM CRMT20501 CR01 WITH (NOLOCK)
		 LEFT JOIN CRMT10401 CR02 WITH (NOLOCK) ON CR01.StageID = CR02.StageID
		--WHERE (CONVERT(VARCHAR(10),CRMT20301.CreateDate,112) BETWEEN CONVERT(VARCHAR(20),@FromDate,112) AND CONVERT(VARCHAR(20),@ToDate,112))
		--AND (CRMT20301.StageID between @FromStageID and @ToStageID or ISNULL(CRMT20301.StageID,'')='')
		GROUP BY CR02.StageName, CR01.StageID)z
		GROUP BY z.StageID, StageName
		ORDER BY z.StageID
		
		INSERT INTO @CRMT2051
		(
			StageName,
			TotalRow
		)
	SELECT StageName,  RowNum
    FROM #CRMT2051 
	ORDER BY RowNum
      	
SELECT @cols= 
STUFF((SELECT  ','+ QUOTENAME(StageName)
FROM @CRMT2051 AS a
ORDER BY a.TotalRow
FOR XML PATH(''), TYPE ).value('.', 'NVARCHAR(MAX)')  ,1,1,'')

SELECT @cols1= 
STUFF((SELECT ','+ QUOTENAME(N'GT '+StageName)
FROM @CRMT2051 AS a
ORDER BY a.TotalRow
FOR XML PATH(''), TYPE ).value('.', 'NVARCHAR(MAX)')  ,1,1,'')

 IF( ISNULL(@cols,'') ='' OR ISNULL(@cols1,'') ='')
	RETURN

 SET @sSQL ='
			SELECT * INTO #Temp01 FROM 
			(
				SELECT x.DivisionID, x.EmployeeID, x.LeadTypeID1, x.StageName, x.StageID, Count(OpportunityID) AS Quantity
				FROM
				(
					SELECT CR01.DivisionID, CR01.OpportunityID, CR01.OpportunityName, CR01.AssignedToUserID AS EmployeeID
					, CASE WHEN ISNULL(CR01.SourceID,'''') != '''' THEN CR01.SourceID END LeadTypeID1
					, CR01.StageID
					, CR02.StageName
					FROM CRMT20501 CR01 WITH (NOLOCK)
					LEFT JOIN CRMT10401 CR02 WITH (NOLOCK) ON CR01.StageID = CR02.StageID
					WHERE ISNULL(CR01.DeleteFlg, 0) = 0 AND' + @sWhere2 + @sWhere + '
				) x
				GROUP BY x.DivisionID, x.EmployeeID, x.LeadTypeID1,  x.StageName, x.StageID
		) D	
		PIVOT (SUM(D.Quantity) FOR D.StageName IN ('+@cols+')) AS PivotedOrder'
Set @sSQL1 =
' 
	SELECT * INTO #Temp02 FROM
	(
		SELECT x.ValuesDivisionID, x.AssignedToUserID, x.LeadTypeID2, x.ValuesStageName, x.ValuesStageID, SUM(ISNULL(ExpectAmount,0)) AS ExpectAmount From
		(
			SELECT CR01.DivisionID as ValuesDivisionID, CR01.OpportunityID, CR01.OpportunityName, CR01.AssignedToUserID, CR01.ExpectAmount
			, CASE WHEN ISNULL(CR01.SourceID,'''') != '''' THEN CR01.SourceID END LeadTypeID2
			, CR01.StageID ValuesStageID
			, CASE WHEN ISNULL(CR01.StageID,'''') != '''' THEN N''GT ''+CR02.StageName END ValuesStageName
			FROM CRMT20501 CR01 WITH (NOLOCK)
			LEFT JOIN CRMT10401 CR02 WITH (NOLOCK) ON CR01.StageID = CR02.StageID
			WHERE ISNULL(CR01.DeleteFlg, 0) = 0 AND' + @sWhere2 + @sWhere + '
		) x
		GROUP BY x.ValuesDivisionID, x.AssignedToUserID, x.LeadTypeID2, x.ValuesStageName, x.ValuesStageID
	) y	
	PIVOT (SUM(y.ExpectAmount) FOR y.ValuesStageName IN ('+@cols1+')) AS PivotedOrderA'

SET @sSQL2 = '  
	SELECT * 
	FROM 
	(
		SELECT C.DefDivisionID, AT01.DivisionName, C.DefAssignedToUserID, AT03.FullName AS EmployeeName, ISNULL(C.LeadTypeID, '''') LeadTypeID, ISNULL(CR03.LeadTypeName, '''') LeadTypeName
				, SUM(C.Lead) AS Lead, SUM(C.Opp) AS Opp, SUM(C.Customer) AS Customer
				, CASE WHEN SUM(C.Lead) = 0 THEN 0 ELSE SUM(C.Opp)/SUM(C.Lead) END AS OL
				, CASE WHEN SUM(C.Lead) = 0 THEN 0 ELSE SUM(C.Customer)/SUM(C.Lead) END AS CL
				, CASE WHEN SUM(C.Opp) = 0 THEN 0 ELSE SUM(C.Customer)/SUM(C.Opp) END AS CO
		FROM
		(
			SELECT A.DivisionID AS DefDivisionID, A.AssignedToUserID AS DefAssignedToUserID, A.LeadTypeID, CAST(COUNT(A.LeadID) AS DECIMAL(28,1)) AS Lead, 0 AS Opp, 0 AS Customer 
			FROM CRMT20301 A WITH (NOLOCK)
			WHERE ISNULL(A.DeleteFlg, 0) = 0 '+@sWhere3+'
			GROUP BY A.DivisionID, A.AssignedToUserID, A.LeadTypeID 
			UNION ALL
			SELECT A.DivisionID, A.AssignedToUserID, A.SourceID LeadTypeID, 0 AS Lead, CAST(COUNT(A.OpportunityID) AS DECIMAL(28,1)) AS Opp, 0 AS Customer 
			FROM CRMT20501 A WITH (NOLOCK) 
			--LEFT JOIN CRMT20501_CRMT20301_REL B WITH (NOLOCK) ON A.APK = B.OpportunityID
			WHERE ISNULL(A.DeleteFlg, 0) = 0 '+@sWhere4+'
			GROUP BY A.DivisionID, A.AssignedToUserID, A.SourceID, A.SourceID
			UNION ALL
			SELECT A.DivisionID, A.AssignedToUserID, ISNULL(B.LeadTypeID, C.SourceID) LeadTypeID, 0 AS Lead, 0 AS Opp, CAST(COUNT(A.MemberID) AS DECIMAL(28,1)) AS Customer 
			FROM POST0011 A WITH (NOLOCK)
			LEFT JOIN CRMT20301 B WITH (NOLOCK) ON A.InheritConvertID = B.LeadID AND ISNULL(B.DeleteFlg, 0) = 0
			LEFT JOIN CRMT20501 C WITH (NOLOCK) ON A.InheritConvertID = C.OpportunityID AND ISNULL(C.DeleteFlg, 0) = 0 ' + @sJoin + '
			WHERE ISNULL(A.DeleteFlg, 0) = 0 '+@sWhere5+' AND A.InheritConvertID IS NOT NULL
			GROUP BY A.DivisionID, A.AssignedToUserID,ISNULL(B.LeadTypeID, C.SourceID)
		) C
		LEFT JOIN AT1101 AT01 WITH (NOLOCK) ON AT01.DivisionID = C.DefDivisionID
		LEFT JOIN AT1103 AT03 WITH (NOLOCK) ON C.DefAssignedToUserID = AT03.EmployeeID
		LEFT JOIN CRMT10201 CR03 WITH (NOLOCK) ON C.LeadTypeID = CR03.LeadTypeID
		WHERE 1=1' + @sWhere6 + '
		GROUP BY C.DefDivisionID, C.DefAssignedToUserID, AT01.DivisionName, AT03.FullName, C.LeadTypeID, CR03.LeadTypeName
	) D
	LEFT JOIN #Temp01 A ON D.DefDivisionID = A.DivisionID AND D.DefAssignedToUserID = A.EmployeeID AND A.LeadTypeID1 = D.LeadTypeID
	LEFT JOIN #Temp02 B ON D.DefDivisionID = B.ValuesDivisionID AND D.DefAssignedToUserID = B.AssignedToUserID AND A.StageID = B.ValuesStageID AND A.LeadTypeID1 = B.LeadTypeID2
	ORDER BY D.DefDivisionID, D.DefAssignedToUserID, D.LeadTypeID
'

PRINT (@sSQL)
PRINT (@sSQL1)
PRINT (@sSQL2)
EXEC (@sSQL+ @sSQL1+ @sSQL2)