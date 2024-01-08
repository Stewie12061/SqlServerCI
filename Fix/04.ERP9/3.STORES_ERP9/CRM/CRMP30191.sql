IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP30191]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP30191]
GO
SET QUOTED_IDENTIFIER ON
GO

-- <Summary>
----Báo cáo tổng Marketing - sale
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Đình Hòa on 01/12/2020
-- <Example>
CREATE PROCEDURE [dbo].[CRMP30191] ( 
        @DivisionID       VARCHAR(50),  --Biến môi trường
		@DivisionIDList    NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
		@IsDate			TINYINT,		--1: Theo ngày; 0: Theo kỳ
		@FromDate       DATETIME,
		@ToDate         DATETIME,
		@PeriodIDList	NVARCHAR(2000),
		@UserID  VARCHAR(50),
		@CampaignIDList VARCHAR(MAX) =''
)
AS
DECLARE @sSQL NVARCHAR (MAX),
		@sSQL1 NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX)

SET @sWhere = ''
--Check Para DivisionIDList null then get DivisionID 
	IF ISNULL(@DivisionIDList,'') <> ''
		SET @sWhere = @sWhere + ' (M.DivisionID = '''+ @DivisionID+''' Or M.IsCommon =1)'
	Else 
		SET @sWhere = @sWhere + ' (M.DivisionID IN ('''+@DivisionIDList+''') Or M.IsCommon =1)'

--Search theo điều điện thời gian
	IF @IsDate = 1	
	Begin
		SET @sWhere = @sWhere + ' AND (CONVERT(VARCHAR(10),M.ExpectOpenDate,112) BETWEEN'''+ CONVERT(VARCHAR(20),@FromDate,112)+''' AND''' + CONVERT(VARCHAR(20),@ToDate,112)
						+''' OR CONVERT(VARCHAR(10),M.ExpectCloseDate,112) BETWEEN'''+ CONVERT(VARCHAR(20),@FromDate,112)+''' AND''' + CONVERT(VARCHAR(20),@ToDate,112) 
						+''' OR CONVERT(VARCHAR(10),M.PlaceDate,112) BETWEEN'''+ CONVERT(VARCHAR(20),@FromDate,112)+''' AND''' + CONVERT(VARCHAR(20),@ToDate,112) +''')'
	End
	ELSE
	Begin
		SET @sWhere = @sWhere + ' AND ((Case When Month(M.ExpectOpenDate) < 10 then ''0''+rtrim(ltrim(str(Month(M.ExpectOpenDate))))+''/''+ltrim(Rtrim(str(Year(M.ExpectOpenDate)))) 
										  Else rtrim(ltrim(str(Month(M.ExpectOpenDate))))+''/''+ltrim(Rtrim(str(Year(M.ExpectOpenDate)))) End) IN ('''+@PeriodIDList+''')
										OR (Case When Month(M.ExpectCloseDate) < 10 then ''0''+rtrim(ltrim(str(Month(M.ExpectCloseDate))))+''/''+ltrim(Rtrim(str(Year(M.ExpectCloseDate)))) 
										    Else rtrim(ltrim(str(Month(M.ExpectCloseDate))))+''/''+ltrim(Rtrim(str(Year(M.ExpectCloseDate)))) End) IN ('''+@PeriodIDList+''')
										OR (Case When Month(M.PlaceDate) < 10 then ''0''+rtrim(ltrim(str(Month(M.PlaceDate))))+''/''+ltrim(Rtrim(str(Year(M.PlaceDate)))) 
										   Else rtrim(ltrim(str(Month(M.PlaceDate))))+''/''+ltrim(Rtrim(str(Year(M.PlaceDate)))) End) IN ('''+@PeriodIDList+'''))'
	End

 	IF ISNULL(@CampaignIDList,'') <> ''
	    SET @sWhere = @sWhere+ ' AND M.CampaignID IN ('''+@CampaignIDList+''')'

-- Tính số thực tế của Serminar - CIA
SET @sSQL ='--Tính Serminar - HD
SELECT M.CampaignID, M.DivisionID, M.IsCommon, M.ExpectCloseDate, M.ExpectOpenDate, M.PlaceDate, D.* 
INTO #CRMT20402temp
FROM CRMT20401 M WITH(NOLOCK) 
LEFT JOIN CRMT20402 D WITH(NOLOCK) ON M.APK = D.APKMaster 

SELECT L.APK, L.LeadID,L.LastModifyDate, D.CampaignDetailID AS CampaignID, T.Value AS ConversionTargetID
INTO #CRMT20301temp
FROM CRMT20301 L WITH(NOLOCK)
LEFT JOIN CRMT20302 D WITH(NOLOCK) ON L.APK = D.APKMAster
CROSS APPLY StringSplit(D.SerminarID, '','') T

SELECT  L.CampaignID, T.DivisionID, T.IsCommon, T.ExpectCloseDate, T.ExpectOpenDate, T.PlaceDate, T.APKMaster, T.ConversionTargetID AS ID, T.AttendTarget, COUNT(L.APK) AS Lead
INTO #CRMT20403temp
FROM #CRMT20301temp L WITH(NOLOCK)
LEFT JOIN #CRMT20402temp T WITH(NOLOCK) ON L.ConversionTargetID = T.ConversionTargetID AND L.CampaignID = T.CampaignID
GROUP BY L.CampaignID, T.DivisionID, T.IsCommon, T.ExpectCloseDate, T.ExpectOpenDate, T.PlaceDate, T.APKMaster, T.ConversionTargetID, T.AttendTarget
UNION ALL 
SELECT L1.CampaignID, L1.DivisionID, L1.IsCommon, L1.ExpectCloseDate, L1.ExpectOpenDate, L1.PlaceDate, L1.APKMaster, L1.ConversionTargetID AS ID, L1.AttendTarget , 0
FROM #CRMT20402temp L1 WHERE L1.CampaignID NOT IN (SELECT T1.CampaignID FROM #CRMT20301temp T1)

--Tính lead MKT  - COST
SELECT SUM(M.LeadsTarget) AS SumLeadTaget, SUM(M.LeadsActual) AS SumLeadActual, SUM(M.BudgetCost) AS SumCostTarget, SUM(M.ActualCost) AS SumCostActual
INTO #LEADMKT
FROM CRMT20401 M WITH(NOLOCK)
WHERE '+ @sWhere +' AND M.CampaignType <> ''TYPE_RCIA''

--Tính lead CIA ref
select SUM(M.LeadsTarget) AS SumLeadTagetRefCIA, SUM(M.LeadsActual) AS SumLeadActualRefCIA
INTO #LEADRCIA
FROM CRMT20401 M WITH(NOLOCK)
WHERE '+ @sWhere +' AND M.CampaignType = ''TYPE_RCIA''

---Tính lead BNI
SELECT SUM(M.AttendTarget) AS SumSMNTagetBNI, SUM(M.Lead) AS SumSMNActualBNI
INTO #SERMINARBNI
FROM #CRMT20403temp M WITH(NOLOCK)
WHERE M.ID = ''HD_ADZTOBNI'' AND '+ @sWhere +'

---Tính lead 6S
SELECT  SUM(M.AttendTarget) AS SumSMNTaget6S, SUM(M.Lead) AS SumSMNActual6S
INTO #SERMINAR6S
FROM #CRMT20403temp M WITH(NOLOCK)
WHERE M.ID IN (''SALE_MKTTO6STEPS'',''SALE_BNICTO6STEPS'',''SALE_CIATO6STEPS'') AND '+ @sWhere +'

---Tính lead CIA
SELECT  SUM(M.AttendTarget) AS SumCIATaget, SUM(M.Lead) AS SumCIAActual
INTO #HDCIA
FROM #CRMT20403temp M WITH(NOLOCK)
WHERE M.ID <> ''HD_ADZTOBNI'' AND M.ID LIKE ''HD_%'' AND '+ @sWhere +'

---Tính lead Serminar
SELECT  SUM(M.AttendTarget) AS SumSMNTaget, SUM(M.Lead) AS SumSMNActual
INTO #SERMINAR
FROM #CRMT20403temp M WITH(NOLOCK)
WHERE M.ID LIKE ''SALE_%'' AND M.ID NOT IN (''SALE_MKTTO6STEPS'',''SALE_BNICTO6STEPS'',''SALE_CIATO6STEPS'') AND '+ @sWhere +'

'

SET @sSQL1 = '
SELECT *
FROM #LEADMKT ,#LEADRCIA, #SERMINAR, #SERMINAR6S, #SERMINARBNI, #HDCIA'

print (@sSQL)
EXEC (@sSQL + @sSQL1)
GO
