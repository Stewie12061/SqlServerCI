IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP3015]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP3015]
GO
SET QUOTED_IDENTIFIER ON
GO

-- <Summary>
----In báo cáo Thống kê kết quả chiến dịch theo tháng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Tấn Đạt on 02/03/2018
-- <Example>
----    EXEC CRMP3015 'AS','',0,'2017-08-03 00:00:00','2017-012-01 00:00:00','08/2017', '',''

Create PROCEDURE [dbo].[CRMP3015] ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@DivisionIDList NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
		@IsDate	TINYINT,		--1: Theo ngày; 0: Theo kỳ
		@FromDate Datetime,
		@ToDate Datetime,
		@PeriodIDList NVARCHAR(2000),
		@FromEmployeeID NVarchar(50),
		@ToEmployeeID NVarchar(50)
		
)
AS

DECLARE
		@sSQL NVARCHAR (MAX),
		@sWhere Nvarchar(Max),
		@sWhere2  Nvarchar(Max)
SET @sWhere = ''
SET @sWhere2 = ''
IF @IsDate = 1	
	Begin
		SET @sWhere = ' AND (CONVERT(VARCHAR(10),M.CreateDate,112) BETWEEN'''+ CONVERT(VARCHAR(20),@FromDate,112)+''' AND''' + CONVERT(VARCHAR(20),@ToDate,112) +''')'
	End
	ELSE
	Begin
		SET @sWhere = ' AND (Case When  Month(M.CreateDate) <10 then ''0''+rtrim(ltrim(str(Month(M.CreateDate))))+''/''+ltrim(Rtrim(str(Year(M.CreateDate)))) 
										Else rtrim(ltrim(str(Month(M.CreateDate))))+''/''+ltrim(Rtrim(str(Year(M.CreateDate)))) End) IN ('''+@PeriodIDList+''')'
	End


--Check Para DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere2 =@sWhere2+ ' (M.DivisionID = '''+ @DivisionID+''' or M.IsCommon =1) '
	Else 
		SET @sWhere2 = @sWhere2+ ' (M.DivisionID IN ('''+@DivisionIDList+''') or M.IsCommon =1)'
	IF ((Isnull(@FromEmployeeID, '') !='')and (Isnull(@ToEmployeeID, '') !=''))
		SET @sWhere2 = @sWhere2 +' AND (M.AssignedToUserID between N'''+@FromEmployeeID+''' and N'''+@ToEmployeeID+''')'
	IF ((Isnull(@FromEmployeeID, '') !='')and (Isnull(@ToEmployeeID, '') =''))
		SET @sWhere2 = @sWhere2 +'AND cast(M.AssignedToUserID as Nvarchar(50)) >= N'''+cast(@FromEmployeeID as Nvarchar(50))+''''
	IF ((Isnull(@FromEmployeeID, '') ='')and (Isnull(@ToEmployeeID, '') !=''))
		SET @sWhere2 = @sWhere2 +' AND cast(M.AssignedToUserID as Nvarchar(50)) <= N'''+cast(@ToEmployeeID as Nvarchar(50))+''''
	
---Load danh sách 
SET @sSQL =
	' 
 Select M.DivisionID
, M.CampaignID, M.CampaignName, D5.Description as CampaignType, D6.Description as CampaignStatus
, isnull(stuff(isnull((Select  '', '' + C.FullName
 From  AT1103_REL x WITH (NOLOCK)
 Left join AT1103 c WITH (NOLOCK) On Convert(varchar(50),c.EmployeeID) = x.UserID
 Where x.RelatedToID = Convert(varchar(50),M.APK) and x.RelatedToTypeID= M.RelatedToTypeID
 Group By UserID, FullName, RelatedToTypeID
 Order by x.UserID
 FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 2, ''''), M.AssignedToUserID) as AssignedToUserID
, M.ExpectOpenDate, M.ExpectCloseDate
, D3.InventoryName as InventoryID
, M.BudgetCost, M.ExpectedRevenue, M.ExpectedSales, M.ExpectedROI
, M.ActualCost, M.ActualSales, M.ActualROI

from CRMT20401 M With (NOLOCK) 
left join AT1302 D3 With (NOLOCK) on M.InventoryID = D3.InventoryID
left join CRMT0099 D5 With (NOLOCK) on M.CampaignType = D5.ID and D5.CodeMaster = ''CRMT00000011''
left join CRMT0099 D6 With (NOLOCK) on M.CampaignStatus = D6.ID and D6.CodeMaster = ''CRMT00000012''
Where   '+@sWhere2+@sWhere+'
'
EXEC (@sSQL)
GO
