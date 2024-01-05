IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP30121]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP30121]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
----In báo cáo Thực tế so với kỳ vọng của chiến dịch
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Thị Phượng on 03/07/2017
--- Modify by Thị Phượng, Date 04/07/2017: Bổ sung phân quyền
-- <Example>
----    EXEC CRMP30121 'AS','AS'',''GS'',''GC',1,'2017-01-01 00:00:00','2017-12-30 00:00:00','07/2017','','', 'ASOFTADMIN', 'PHUONG'', ''QUI'', ''QUYNH'', ''VU'
CREATE PROCEDURE [dbo].[CRMP30121] ( 
        @DivisionID       VARCHAR(50),  --Biến môi trường
		@DivisionIDList    NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
		@IsDate			TINYINT,		--1: Theo ngày; 0: Theo kỳ
		@FromDate       DATETIME,
		@ToDate         DATETIME,
		@PeriodIDList	NVARCHAR(2000),
		@FromCampaignID    NVarchar(50),
		@ToCampaignID         NVarchar(50),
		@CampaignID         NVarchar(MAX),
		@UserID  VARCHAR(50),
		@ConditionCampainID nvarchar(max)
		
)
AS
DECLARE
		@sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@sWhere2 Nvarchar(Max),
		@sWhere3 Nvarchar(Max),
		@Columns Nvarchar(Max)

SET @sWhere2 = ''
SET @sWhere3 = ''
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
		SET @sWhere2 =@sWhere2+ ' (CR01.DivisionID = '''+ @DivisionID+''' Or CR01.IsCommon =1)'
	Else 
		SET @sWhere2 = @sWhere2+ ' (CR01.DivisionID IN ('''+@DivisionIDList+''') Or CR01.IsCommon =1)'

	IF ((Isnull(@FromCampaignID, '') !='')and (Isnull(@ToCampaignID, '') !=''))
		SET @sWhere3 = @sWhere3 +' AND (CR01.CampaignID between N'''+@FromCampaignID+''' and N'''+@ToCampaignID+''')'
	IF ((Isnull(@FromCampaignID, '') !='')and (Isnull(@ToCampaignID, '') =''))
		SET @sWhere3 = @sWhere3 +'AND cast(CR01.CampaignID as Nvarchar(50)) >= N'''+cast(@FromCampaignID as Nvarchar(50))+''''
	IF ((Isnull(@FromCampaignID, '') ='')and (Isnull(@ToCampaignID, '') !=''))
		SET @sWhere3 = @sWhere3 +'AND cast(CR01.CampaignID as Nvarchar(50)) <= N'''+cast(@ToCampaignID as Nvarchar(50))+'''' 

	IF ISNULL(@CampaignID, '') != ''
		SET @sWhere3 = @sWhere3 + 'AND CR01.CampaignID IN ( SELECT * FROM StringSplit(REPLACE('''+@CampaignID+''', '''', ''''), '','') ) '

--Phân quyền dữ liệu
	IF Isnull(@ConditionCampainID, '') != ''	 
		SET @sWhere = @sWhere + 'AND ISNULL(B.UserID, CR01.CreateUserID) In ('''+@ConditionCampainID+''') '
---Load danh sách chiến dịch
SET @sSQL ='
				Select CR01.DivisionID, AT01.DivisionName, CR01.CampaignID, CR01.CampaignID +'' _ ''+ CR01.CampaignName as CampaignName
				, isnull(CR01.ExpectedRevenue,0) as ExpectedRevenue , isnull(CR01.ActualRevenue,0) ActualRevenue
				, Case When isnull(CR01.ExpectedRevenue,0) =0 then 0 else (isnull(CR01.ActualRevenue,0)/isnull(CR01.ExpectedRevenue,0)) end as RevenueRate
				, isnull(CR01.BudgetCost,0) BudgetCost, isnull(CR01.ActualCost,0) ActualCost
				, Case When isnull(CR01.BudgetCost,0) =0 then 0 else (isnull(CR01.ActualCost,0)/isnull(CR01.BudgetCost,0)) end as CostRate
				From CRMT20401 CR01 With (NOLOCK)
				Left join AT1103_REL B WITH (NOLOCK) ON B.RelatedToID =convert(Varchar(50),CR01.APK)
				Left join AT1101 AT01 With (NOLOCK) On AT01.DivisionID = CR01.DivisionID
				Where   '+@sWhere2+ @swhere3+ @sWhere+'
				Order by CR01.CampaignID
		
		'

EXEC (@sSQL)
print (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
