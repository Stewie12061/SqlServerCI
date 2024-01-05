IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP30171]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP30171]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
----Báo cáo Chiến dịch
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Đình Hòa on 09/11/2020
-- <Example>
CREATE PROCEDURE [dbo].[CRMP30171] ( 
        @DivisionID       VARCHAR(50),  --Biến môi trường
		@DivisionIDList    NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
		@IsDate			TINYINT,		--1: Theo ngày; 0: Theo kỳ
		@FromDate       DATETIME,
		@ToDate         DATETIME,
		@PeriodIDList	NVARCHAR(2000),
		@UserID  VARCHAR(50),
		@CampaignIDList VARCHAR(MAX) ='',
		@AssignedToUserIDList VARCHAR(MAX) ='',
		@StatusIDList VARCHAR(MAX) =''
)
AS
DECLARE
		@sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX)

SET @sWhere = ''

SET @sWhere = 'ISNULL(C41.DeleteFlg,0) = 0 AND'
--Check Para DivisionIDList null then get DivisionID 
	IF ISNULL(@DivisionIDList,'') = ''
		SET @sWhere = @sWhere + ' (C41.DivisionID = '''+ @DivisionID+''' Or C41.IsCommon =1)'
	Else 
		SET @sWhere = @sWhere + ' (C41.DivisionID IN ('''+@DivisionIDList+''') Or C41.IsCommon =1)'

--Search theo điều điện thời gian
	IF @IsDate = 1	
	Begin
		SET @sWhere = @sWhere + ' AND (CONVERT(VARCHAR(10),C41.ExpectOpenDate,112) BETWEEN'''+ CONVERT(VARCHAR(20),@FromDate,112)+''' AND''' + CONVERT(VARCHAR(20),@ToDate,112)
						+''' OR CONVERT(VARCHAR(10),C41.ExpectCloseDate,112) BETWEEN'''+ CONVERT(VARCHAR(20),@FromDate,112)+''' AND''' + CONVERT(VARCHAR(20),@ToDate,112) 
						+''' OR CONVERT(VARCHAR(10),C41.PlaceDate,112) BETWEEN'''+ CONVERT(VARCHAR(20),@FromDate,112)+''' AND''' + CONVERT(VARCHAR(20),@ToDate,112) +''')'
	End
	ELSE
	Begin
		SET @sWhere = @sWhere + 'AND ((Case When Month(C41.ExpectOpenDate) <10 then ''0''+rtrim(ltrim(str(Month(C41.ExpectOpenDate))))+''/''+ltrim(Rtrim(str(Year(C41.ExpectOpenDate)))) 
										Else rtrim(ltrim(str(Month(C41.ExpectOpenDate))))+''/''+ltrim(Rtrim(str(Year(C41.ExpectOpenDate)))) End) IN ('''+@PeriodIDList+''')
						 OR (Case When Month(C41.ExpectCloseDate) <10 then ''0''+rtrim(ltrim(str(Month(C41.ExpectCloseDate))))+''/''+ltrim(Rtrim(str(Year(C41.ExpectCloseDate)))) 
										Else rtrim(ltrim(str(Month(C41.ExpectCloseDate))))+''/''+ltrim(Rtrim(str(Year(C41.ExpectCloseDate)))) End) IN ('''+@PeriodIDList+''')
						 OR (Case When Month(C41.PlaceDate) <10 then ''0''+rtrim(ltrim(str(Month(C41.PlaceDate))))+''/''+ltrim(Rtrim(str(Year(C41.PlaceDate)))) 
										Else rtrim(ltrim(str(Month(C41.PlaceDate))))+''/''+ltrim(Rtrim(str(Year(C41.PlaceDate)))) End) IN ('''+@PeriodIDList+'''))'
	End


 	IF ISNULL(@CampaignIDList,'') <> ''
	    SET @sWhere = @sWhere+ ' AND C41.CampaignID IN ('''+@CampaignIDList+''')'

	IF ISNULL(@AssignedToUserIDList,'') <> ''
	    SET @sWhere = @sWhere+ ' AND C41.AssignedToUserID IN ('''+@AssignedToUserIDList+''')'

	IF ISNULL(@StatusIDList,'') <> ''
	    SET @sWhere = @sWhere+ ' AND C41.CampaignStatus IN ('''+@StatusIDList+''')'

SET @sSQL ='SELECT C41.DivisionID, C41.CampaignID, C41.CampaignName, C99.StageName AS CampainStatusName, A03.FullName,C41.PlaceDate
, (CONVERT(VARCHAR(10),C41.ExpectOpenDate,103) + '' - '' + CONVERT(VARCHAR(10),C41.ExpectCloseDate,103)) AS OpenCloseDate
, C41.LeadsTarget, C41.BudgetCost, C41.ActualCost, C41.ChangeCostTarget, C41.ChangeCostActual, ISNULL(C41.AttendLeaderTarget,0) AS AttendLeaderTarget
, ISNULL(C41.AttendLeaderActual,0) AS AttendLeaderActual , C41.LeadsPreviousActual, ISNULL(C31.STATUS_01,0) AS STATUS_01, ISNULL(C31.STATUS_02,0) AS STATUS_02
, ISNULL(C31.STATUS_03,0) AS STATUS_03, ISNULL(C31.STATUS_04,0) AS STATUS_04
FROM CRMT20401 C41 WITH(NOLOCK)
LEFT JOIN AT1103 A03 WITH(NOLOCK) ON C41.AssignedToUserID = A03.EmployeeID
LEFT JOIN CRMT10401 C99 WITH(NOLOCK) ON C99.Disabled = 0 AND C41.CampaignStatus = C99.StageID
LEFT JOIN (SELECT CampaignID,DivisionID,
[STATUS_01], [STATUS_02], [STATUS_03] ,[STATUS_04]
FROM
(SELECT D.CampaignDetailID AS CampaignID, A.DivisionID, A.LeadID, CONCAT(''STATUS_0'',B.OrderNo) AS Status_Step
FROM CRMT20301 A WITH(NOLOCK)
LEFT JOIN CRMT20302 D WITH(NOLOCK) ON A.APK = D.APKMaster 
LEFT JOIN CRMT10401 B WITH(NOLOCK) ON D.StatusDetailID = B.StageID AND A.DivisionID = B.DivisionID
) AS CRMT20301_tmp

PIVOT 
(
 COUNT(LeadID)
 FOR Status_Step
 IN ([STATUS_01], [STATUS_02], [STATUS_03] ,[STATUS_04])
) AS Result) C31 ON C41.CampaignID = C31.CampaignID AND C41.DivisionID = C31.DivisionID
WHERE '+ @sWhere

print (@sSQL)
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
