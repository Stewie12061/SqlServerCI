IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP30051]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP30051]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
----In báo cáo Tổng hợp tỷ lệ chuyển đổi từ cơ hội
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
--- Modify by Anh Đô, Date 04/11/2022: Chỉnh sửa điều kiện lọc
--- Modify by Anh Đô, Date 23/11/2022: Fix lỗi sai số cột Tổng số đầu mối và Tổng số cơ hội
-- <Example>
----    EXEC CRMP30051 'AS','',0,'2017-01-03 00:00:00','2017-06-30 00:00:00','06/2017','','','','', 'ASOFTADMIN', 'VU', 'VU', 'VU'

CREATE PROCEDURE [dbo].[CRMP30051] ( 
        @DivisionID				VARCHAR(50),		--Biến môi trường
		@DivisionIDList			NVARCHAR(2000),		--Chọn trong DropdownChecklist DivisionID
		@IsDate					TINYINT,			--1: Theo ngày; 0: Theo kỳ
		@FromDate				DATETIME,
		@ToDate					DATETIME,
		@PeriodIDList			NVARCHAR(2000),
		@EmployeeID				NVARCHAR(MAX),
		@StageID				NVARCHAR(MAX),
		@UserID					VARCHAR(50),
		@ConditionLeadID		nvarchar(max),
		@ConditionOpportunityID nvarchar(max),
		@ConditionObjectID		nvarchar(max),
		@FromStageID			NVarchar(50) = '',
		@ToStageID				NVarchar(50) = '',
		@FromEmployeeID			NVarchar(50) = '',
		@ToEmployeeID			NVarchar(50) = ''
		
)
AS
DECLARE
		@sSQL NVARCHAR (MAX),
		@sSQL1 NVARCHAR (MAX),
		@sSQL2 NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@sWhere1 Nvarchar(Max),
		@sWhere2 Nvarchar(Max),
		@sWhere3 Nvarchar(Max),
		@sWhere4 Nvarchar(Max),
		@sWhere5 Nvarchar(Max),
		@Columns Nvarchar(Max),
@cols NVARCHAR(Max),
@cols1 NVARCHAR(Max)

SET @sWhere1 = ''
SET @sWhere2 = ''
SET @sWhere3 = ''
SET @sWhere4 = ''
SET @sWhere5 = ''
--Search theo điều điện thời gian
	IF @IsDate = 1
	Begin
		SET @sWhere = ' AND (CONVERT(VARCHAR(10),CR01.CreateDate,112) BETWEEN'''+ CONVERT(VARCHAR(20),@FromDate,112)+''' AND''' + CONVERT(VARCHAR(20),@ToDate,112) +''')'

	End
	ELSE
	Begin
		SET @sWhere = ' AND (Case When  Month(CR01.CreateDate) <10 then ''0''+rtrim(ltrim(str(Month(CR01.CreateDate))))+''/''+ltrim(Rtrim(str(Year(CR01.CreateDate)))) 
										Else rtrim(ltrim(str(Month(CR01.CreateDate))))+''/''+ltrim(Rtrim(str(Year(CR01.CreateDate)))) End) IN ('''+@PeriodIDList+''')'
		End

--Check Para DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
	Begin	
		SET @sWhere2 =@sWhere2+ ' (CR01.DivisionID = '''+ @DivisionID+''' Or CR01.IsCommon =1)'
		SET @sWhere3 =@sWhere3+ ' (A.DivisionID = '''+ @DivisionID+''' Or A.IsCommon =1)'
		SET @sWhere4 =@sWhere4+ ' (A.DivisionID = '''+ @DivisionID+''' Or A.IsCommon =1)'
		SET @sWhere5 =@sWhere5+ ' (A.DivisionID = '''+ @DivisionID+''' Or A.IsCommon =1)'
	End
	Else 
	Begin
		SET @sWhere2 = @sWhere2+ ' (CR01.DivisionID IN ('''+@DivisionIDList+''') Or CR01.IsCommon =1)'
		SET @sWhere3 =@sWhere3+ ' (A.DivisionID in ('''+ @DivisionIDList+''') Or A.IsCommon =1)'
		SET @sWhere4 =@sWhere4+ ' (A.DivisionID in ('''+ @DivisionIDList+''') Or A.IsCommon =1)'
		SET @sWhere5 =@sWhere5+ ' (A.DivisionID in ('''+ @DivisionIDList+''') Or A.IsCommon =1)'
	End
	IF ((Isnull(@FromStageID, '') !='')and (Isnull(@ToStageID, '') !=''))
		SET @sWhere = @sWhere +' AND (CR01.StageID between N'''+@FromStageID+''' and N'''+@ToStageID+''')'
	IF ((Isnull(@FromStageID, '') !='')and (Isnull(@ToStageID, '') =''))
		SET @sWhere = @sWhere +'AND cast(CR01.StageID as Nvarchar(50)) >= N'''+cast(@FromStageID as Nvarchar(50))+''''
	IF ((Isnull(@FromStageID, '') ='')and (Isnull(@ToStageID, '') !=''))
		SET @sWhere = @sWhere +'AND cast(CR01.StageID as Nvarchar(50)) <= N'''+cast(@ToStageID as Nvarchar(50))+'''' 
	IF ISNULL(@StageID, '') != ''
		SET @sWhere = @sWhere + ' AND cast(CR01.StageID as Nvarchar(50)) IN ('''+ @StageID +''')'
	
	IF ((Isnull(@FromEmployeeID, '') !='')and (Isnull(@ToEmployeeID, '') !=''))
	Begin
		SET @sWhere = @sWhere +' AND (CR01.AssignedToUserID between N'''+@FromEmployeeID+''' and N'''+@ToEmployeeID+''')'
		SET @sWhere1 = @sWhere1 +' AND (A.AssignedToUserID between N'''+@FromEmployeeID+''' and N'''+@ToEmployeeID+''')'
		End
	IF ((Isnull(@FromEmployeeID, '') !='')and (Isnull(@ToEmployeeID, '') =''))
	begin
		SET @sWhere = @sWhere +'AND cast(CR01.AssignedToUserID as Nvarchar(50)) >= N'''+cast(@FromEmployeeID as Nvarchar(50))+''''
		SET @sWhere1 = @sWhere1 +'AND cast(A.AssignedToUserID as Nvarchar(50)) >= N'''+cast(@FromEmployeeID as Nvarchar(50))+''''
		End
	IF ((Isnull(@FromEmployeeID, '') ='')and (Isnull(@ToEmployeeID, '') !=''))
	Begin
		SET @sWhere = @sWhere +' AND cast(CR01.AssignedToUserID as Nvarchar(50)) <= N'''+cast(@ToEmployeeID as Nvarchar(50))+''''
		SET @sWhere1 = @sWhere1 +' AND cast(A.AssignedToUserID as Nvarchar(50)) <= N'''+cast(@ToEmployeeID as Nvarchar(50))+''''
		End
	IF ISNULL(@EmployeeID, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND cast(CR01.AssignedToUserID as Nvarchar(50)) IN (SELECT Value FROM [dbo].StringSplit('''+ @EmployeeID +''', '',''))'
		SET @sWhere1 = @sWhere1 + ' AND cast(A.AssignedToUserID as Nvarchar(50)) IN (SELECT Value FROM [dbo].StringSplit('''+ @EmployeeID +''', '',''))'
	END

	IF Isnull(@ConditionLeadID,'')!=''
		SET @sWhere3 = @sWhere3 + ' AND ISNULL(A.AssignedToUserID,A.CreateUserID) in ('''+@ConditionLeadID+''' )'
	IF Isnull(@ConditionOpportunityID, '') != ''
	Begin
		SET @sWhere4 = @sWhere4 + ' AND ISNULL(A.AssignedToUserID,A.CreateUserID) in (N'''+@ConditionOpportunityID+''' )'
		SET @sWhere2 = @sWhere2 + ' AND ISNULL(CR01.AssignedToUserID,CR01.CreateUserID) in (N'''+@ConditionOpportunityID+''' )'
	End
	IF Isnull(@ConditionObjectID,'')!=''
		SET @sWhere5 = @sWhere5 + ' AND (Case When ISNULL(A.AssignedToUserID,'''') != '''' then A.AssignedToUserID Else A.CreateUserID End ) in ('''+@ConditionObjectID+''' )'

----Chuyển dòng thành cột
Declare @CRMT2051 table (
							StageName nvarchar(Max),
							TotalRow int)	
		
		SELECT  StageName, ROW_NUMBER() OVER (ORDER BY z.StageID) AS RowNum  Into #CRMT2051 
		FROM 		
		(SELECT CRMT20501.StageID 
		, CR02.StageName 
		 FROM CRMT20501 WITH (NOLOCK)
		 Left join CRMT10401 CR02 With (NOLOCK) On CRMT20501.StageID = CR02.StageID
		--WHERE (CONVERT(VARCHAR(10),CRMT20301.CreateDate,112) BETWEEN CONVERT(VARCHAR(20),@FromDate,112) AND CONVERT(VARCHAR(20),@ToDate,112))
		--AND (CRMT20301.StageID between @FromStageID and @ToStageID or isnull(CRMT20301.StageID,'')='')
		GROUP BY CR02.StageName, CRMT20501.StageID)z
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
STUFF((select  ','+ QUOTENAME(StageName)
FROM @CRMT2051 AS a
       ORDER BY a.TotalRow
 FOR XML PATH(''), TYPE ).value('.', 'NVARCHAR(MAX)')  ,1,1,'')

 SELECT @cols1= 
STUFF((select  ','+ QUOTENAME(N'GT '+StageName)
FROM @CRMT2051 AS a
       ORDER BY a.TotalRow
 FOR XML PATH(''), TYPE ).value('.', 'NVARCHAR(MAX)')  ,1,1,'')

IF( ISNULL(@cols,'') ='' OR ISNULL(@cols1,'') ='')
	RETURN

 SET @sSQL ='
Select * Into #Temp01 from 
	(
			Select x.DivisionID, x.EmployeeID, x.StageName, x.StageID, Count(OpportunityID) as Quantity From
			(
				Select CR01.DivisionID,  CR01.OpportunityID, CR01.OpportunityName, CR01.AssignedToUserID as EmployeeID
				, CR01.StageID
				, CR02.StageName
				From CRMT20501 CR01 With (NOLOCK)
				Left join CRMT10401 CR02 With (NOLOCK) On CR01.StageID = CR02.StageID
				Where   '+@sWhere2+ @sWhere+'
			)x
				Group by x.DivisionID, x.EmployeeID, x.StageName, x.StageID
		)D	
		Pivot (sum(D.Quantity) for D.StageName in ('+@cols+')) AS PivotedOrder'
Set @sSQL1 =
' Select * Into #Temp02 From
	(
			Select x.ValuesDivisionID, x.AssignedToUserID, x.ValuesStageName, x.ValuesStageID, sum(Isnull(ExpectAmount,0)) as ExpectAmount From
			(
				Select CR01.DivisionID as ValuesDivisionID, CR01.OpportunityID, CR01.OpportunityName, CR01.AssignedToUserID ,  CR01.ExpectAmount
				, CR01.StageID ValuesStageID
				, case when isnull(CR01.StageID,'''') != '''' then N''GT ''+CR02.StageName end ValuesStageName
				From CRMT20501 CR01 With (NOLOCK)
				Left join CRMT10401 CR02 With (NOLOCK) On CR01.StageID = CR02.StageID
				Where   '+@sWhere2+ @sWhere+'
			)x
				Group by x.ValuesDivisionID, x.AssignedToUserID, x.ValuesStageName, x.ValuesStageID
		)y	
		Pivot (sum(y.ExpectAmount) for y.ValuesStageName in ('+@cols1+')) AS PivotedOrderA'

SET @sSQL2 = ' SELECT * FROM 
(SELECT C.DefDivisionID, AT01.DivisionName
, C.DefAssignedToUserID, AT03.FullName as EmployeeName,
	SUM(C.SLead) AS SLead, SUM(C.SOpp) AS SOpp, SUM(C.SCustomer) AS SCustomer,
	CASE WHEN SUM(C.SLead) = 0 THEN 0 ELSE SUM(C.SOpp)/SUM(C.SLead) END AS OL, 
	CASE WHEN SUM(C.SLead) = 0 THEN 0 ELSE SUM(C.SCustomer)/SUM(C.SLead) END AS CL,
	CASE WHEN SUM(C.SOpp) = 0 THEN 0 ELSE SUM(C.SCustomer)/SUM(C.SOpp) END AS CO
	FROM
	(SELECT A.DivisionID as DefDivisionID, A.AssignedToUserID as DefAssignedToUserID, CAST(COUNT(A.LeadID) AS DECIMAL(28,1)) AS SLead, 0 as SOpp, 0 AS SCustomer FROM CRMT20301 A WITH (NOLOCK)
	Where '+@sWhere3+@sWhere1+' AND A.DeleteFlg != 1
	GROUP BY A.DivisionID, A.AssignedToUserID
	UNION ALL
	SELECT A.DivisionID, A.AssignedToUserID, 0 AS SLead, CAST(COUNT(DISTINCT A.OpportunityID) AS DECIMAL(28,1)) AS SOpp, 0 AS SCustomer FROM CRMT20501 A WITH (NOLOCK)
	LEFT JOIN CRMT20501_CRMT20301_REL B WITH (NOLOCK) ON A.APK = B.OpportunityID
	Where '+@sWhere4+@sWhere1+' AND A.DeleteFlg != 1
	GROUP BY A.DivisionID, A.AssignedToUserID
	UNION ALL
	SELECT A.DivisionID, A.AssignedToUserID, 0 AS SLead, 0 AS SOpp, CAST(COUNT(A.MemberID) AS DECIMAL(28,1)) AS SCustomer FROM POST0011 A WITH (NOLOCK)
	WHERE '+@sWhere5+@sWhere1+' AND A.InheritConvertID IS NOT NULL AND A.DeleteFlg != 1
	GROUP BY A.DivisionID, A.AssignedToUserID)C
	Left join AT1101 AT01 With (NOLOCK) On AT01.DivisionID = C.DefDivisionID
	Left join AT1103 AT03 With (NOLOCK) On C.DefAssignedToUserID = AT03.EmployeeID
	GROUP BY C.DefDivisionID, C.DefAssignedToUserID, AT01.DivisionName, AT03.FullName)D 
	LEFT JOIN #Temp01 A ON D.DefDivisionID = A.DivisionID and D.DefAssignedToUserID = A.EmployeeID
	Left join #Temp02  B ON D.DefDivisionID = B.ValuesDivisionID and  D.DefAssignedToUserID = B.AssignedToUserID AND A.StageID = B.ValuesStageID
	Order by D.DefDivisionID, D.DefAssignedToUserID
'
EXEC (@sSQL+ @sSQL1+ @sSQL2)
--
print (@sSQL)
Print ( @sSQL1)
Print (@sSQL2)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
