IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP30211]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP30211]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
----Báo cáo Marketing - sale năm
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Đình Hòa on 01/12/2020
----Updated by: Anh Đô on 06/01/2023 - Thêm xử lí load dữ liệu cho trường hợp CustomerIndex chuẩn.
-- <Example>
CREATE PROCEDURE [dbo].[CRMP30211] ( 
        @DivisionID       VARCHAR(50),  --Biến môi trường
		@DivisionIDList    NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID	
		@UserID  VARCHAR(50),
		@CampaignTypeID VARCHAR(MAX) ='',
		@Year VARCHAR(50)
)
AS
DECLARE @sSQL NVARCHAR (MAX),
		@sSQL1 NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@sWhere2 NVARCHAR(MAX),
		@CodeMaster VARCHAR(50),
		@CustomerIndex INT,
		@sSql3 NVARCHAR(MAX)

SELECT @CustomerIndex = CustomerName FROM CustomerIndex

IF (@CustomerIndex = 130)
	SET @CodeMaster = 'CRMT00000032'
ELSE IF @CustomerIndex IN (-1, 92)
	SET @CodeMaster = 'CRMT00000011'

SET @sWhere = ''
SET @sWhere2 = ''
--Check Para DivisionIDList null then get DivisionID 
	IF ISNULL(@DivisionIDList,'') <> ''
		SET @sWhere = @sWhere + ' (MM.DivisionID = '''+ @DivisionID+''' Or MM.IsCommon =1)'
	Else 
		SET @sWhere = @sWhere + ' (MM.DivisionID IN ('''+@DivisionIDList+''') Or MM.IsCommon =1)'

	IF ISNULL(@Year,'') <> ''
	    SET @sWhere = @sWhere+ ' AND ltrim(Rtrim(str(Year(MM.PlaceDate)))) = '''+@Year+''''

 	IF ISNULL(@CampaignTypeID,'') <> ''
	    SET @sWhere2 = @sWhere2+ 'WHERE T.CampaignType IN ('''+@CampaignTypeID+''')'

SET @sSQL ='
--Tính số mục tiêu theo mỗi tháng và mỗi loại chiến dịch
SELECT X.MonthPlace, X.CampaignType, SUM(X.AmountTarget) AmountTarget, SUM(X.SumLeadTarget) AS SumLeadTarget, SUM(X.BudgetCost) AS BudgetCost, SUM(X.BudgetCost)/SUM(X.SumLeadTarget) AS ChangeCostTarget
, SUM(X.LeadPortraitRate) / COUNT(AmountTarget) AS LeadPortraitRate
INTO #CRMT20401_TARGET
FROM (SELECT (Case When Month(MM.PlaceDate) < 10 then ''0''+ rtrim(ltrim(str(Month(MM.PlaceDate)))) Else rtrim(ltrim(str(Month(MM.PlaceDate)))) End) AS MonthPlace
,MM.CampaignType, COUNT(MM.CampaignID) AS AmountTarget, SUM(MM.LeadsTarget) AS SumLeadTarget, SUM(MM.BudgetCost) AS BudgetCost, SUM(MM.BudgetCost)/SUM(MM.LeadsTarget) AS ChangeCostTarget
, COUNT(MM.CampaignType) as count1, MM.LeadPortraitRate
FROM CRMT20401 MM WITH(NOLOCK)
WHERE ISNULL(MM.DeleteFlg,0) = 0 AND ' + @sWhere + '
GROUP BY  MM.PlaceDate, MM.CampaignType, MM.LeadPortraitRate) X
GROUP BY  X.MonthPlace, X.CampaignType

--Tính số thực tế theo mỗi tháng và mỗi loại chiến dịch
SELECT  X.MonthPlace, X.CampaignType, SUM(AmountActual) AS AmountActual, SUM(X.SumLeadActual) AS SumLeadActual, SUM(X.ActualCost) AS ActualCost, SUM(X.ActualCost)/SUM(X.SumLeadActual) AS ChangeCostActual
INTO #CRMT20401_ACTUAL
FROM (SELECT (Case When Month(MM.PlaceDate) < 10 then ''0''+ rtrim(ltrim(str(Month(MM.PlaceDate)))) Else rtrim(ltrim(str(Month(MM.PlaceDate)))) End) AS MonthPlace
,MM.CampaignType, COUNT(MM.CampaignID) AS AmountActual, SUM(MM.LeadsActual) AS SumLeadActual, SUM(MM.ActualCost) AS ActualCost, SUM(MM.ActualCost)/SUM(MM.LeadsActual) AS ChangeCostActual
FROM CRMT20401 MM WITH(NOLOCK)
WHERE ' + @sWhere + ' AND MM.CampaignStatus NOT IN (''1'',''5'')
GROUP BY MM.PlaceDate, MM.CampaignType) X
GROUP BY  X.MonthPlace, X.CampaignType


-- Tính số lead đúng chân dung thực tế (Status là xác nhận và chuyển lớp sau)
SELECT X.MonthPlace, X.CampaignType, SUM(X.SumLeadQualify) AS SumLeadQualify
INTO #CRMT20301_STATUS
FROM(SELECT (Case When Month(MM.PlaceDate) < 10 then ''0''+ rtrim(ltrim(str(Month(MM.PlaceDate)))) Else rtrim(ltrim(str(Month(MM.PlaceDate)))) End) AS MonthPlace
,MM.CampaignType, COUNT(ML.LeadID) SumLeadQualify
FROM CRMT20401 MM WITH(NOLOCK)
LEFT JOIN CRMT20302 DL WITH(NOLOCK) ON MM.CampaignID = DL.CampaignDetailID
LEFT JOIN CRMT20301 ML WITH(NOLOCK) ON DL.APKMaster = ML.APK 
LEFT JOIN CRMT10401 CA WITH(NOLOCK) ON DL.StatusDetailID = CA.StageID 
WHERE ' + @sWhere + ' AND MM.CampaignStatus NOT IN (''1'',''5'') AND CA.StageType = 0 AND (CA.OrderNo = 3 OR CA.OrderNo = 4)
GROUP BY  MM.PlaceDate,MM.CampaignType) X
GROUP BY  X.MonthPlace,X.CampaignType

-- Tính số % mục tiêu Serminar
SELECT X.MonthPlace, X.CampaignType, SUM(X.SumRate)/COUNT(X.ConversionTargetID) AS PerRateTargetSerminar, SUM(SumLeadAttend) AS SumLeadTargerSerminar
INTO #CRMT20401_PERCENT 
FROM (SELECT (Case When Month(MM.PlaceDate) < 10 then ''0''+ rtrim(ltrim(str(Month(MM.PlaceDate)))) Else rtrim(ltrim(str(Month(MM.PlaceDate)))) End) AS MonthPlace 
,MM.CampaignType, DM.ConversionTargetID, SUM(DM.ConversionRate) AS SumRate, SUM(DM.AttendTarget) AS SumLeadAttend
FROM CRMT20401 MM WITH(NOLOCK)
LEFT JOIN CRMT20402 DM WITH(NOLOCK) ON MM.APK = DM.APKMaster
WHERE ' + @sWhere + ' AND MM.CampaignStatus NOT IN (''1'',''5'') AND DM.ConversionTargetID LIKE ''SALE_%''
GROUP BY  MM.PlaceDate,MM.CampaignType,DM.ConversionTargetID) X
GROUP BY  X.MonthPlace, X.CampaignType

-- Tính số lead thực tế tham dự serminar
SELECT X.MonthPlace, X.CampaignType, SUM(X.SumLeadSerminar) AS SumLeadActualSerminar
INTO #CRMT20301_LEADSERMINAR
FROM (SELECT  (Case When Month(MM.PlaceDate) < 10 then ''0''+ rtrim(ltrim(str(Month(MM.PlaceDate)))) Else rtrim(ltrim(str(Month(MM.PlaceDate)))) End) AS MonthPlace 
, MM.CampaignType, COUNT(LS.LeadID) AS SumLeadSerminar
FROM CRMT20401 MM WITH(NOLOCK)
LEFT JOIN CRMT20402 DM WITH(NOLOCK) ON MM.APK = DM.APKMaster
LEFT JOIN (SELECT L.APK, L.LeadID,L.LastModifyDate, D.CampaignDetailID AS CampaignID, T.Value AS ConversionTargetID
FROM CRMT20301 L WITH(NOLOCK)
LEFT JOIN CRMT20302 D WITH(NOLOCK) ON L.APK = D.APKMAster
CROSS APPLY StringSplit(D.SerminarID, '','') T) LS ON MM.CampaignID = LS.CampaignID AND DM.ConversionTargetID = LS.ConversionTargetID
WHERE ' + @sWhere + ' AND MM.CampaignStatus NOT IN (''1'',''5'') AND DM.ConversionTargetID LIKE ''SALE_%''
GROUP BY  MM.PlaceDate,MM.CampaignType) X
GROUP BY  X.MonthPlace, X.CampaignType

-- TÍnh % mục tiêu HD_BNI
SELECT X.MonthPlace, X.CampaignType, SUM(X.SumRate)/COUNT(X.ConversionTargetID) AS PerRateTargetBNI, SUM(SumLeadAttend) AS SumLeadTargerBNI
INTO #CRMT20401_BNI
FROM (SELECT (Case When Month(MM.PlaceDate) < 10 then ''0''+ rtrim(ltrim(str(Month(MM.PlaceDate)))) Else rtrim(ltrim(str(Month(MM.PlaceDate)))) End) AS MonthPlace 
,MM.CampaignType, DM.ConversionTargetID, SUM(DM.ConversionRate) AS SumRate, SUM(DM.AttendTarget) AS SumLeadAttend
FROM CRMT20401 MM WITH(NOLOCK)
LEFT JOIN CRMT20402 DM WITH(NOLOCK) ON MM.APK = DM.APKMaster
WHERE ' + @sWhere + ' AND MM.CampaignStatus NOT IN (''1'',''5'') AND DM.ConversionTargetID = ''HD_ADZTOBNI''
GROUP BY  MM.PlaceDate,MM.CampaignType,DM.ConversionTargetID) X
GROUP BY  X.MonthPlace, X.CampaignType

-- Tính lead tham dự thực tế BNI
SELECT X.MonthPlace, X.CampaignType, SUM(X.SumLead) AS SumLeadActualBNI
INTO #CRMT20301_BNI
FROM (SELECT  (Case When Month(MM.PlaceDate) < 10 then ''0''+ rtrim(ltrim(str(Month(MM.PlaceDate)))) Else rtrim(ltrim(str(Month(MM.PlaceDate)))) End) AS MonthPlace 
, MM.CampaignType, COUNT(LS.LeadID) AS SumLead
FROM CRMT20401 MM WITH(NOLOCK)
LEFT JOIN CRMT20402 DM WITH(NOLOCK) ON MM.APK = DM.APKMaster
LEFT JOIN (SELECT L.APK, L.LeadID,L.LastModifyDate, D.CampaignDetailID AS CampaignID, T.Value AS ConversionTargetID
FROM CRMT20301 L WITH(NOLOCK)
LEFT JOIN CRMT20302 D WITH(NOLOCK) ON L.APK = D.APKMAster
CROSS APPLY StringSplit(D.SerminarID, '','') T) LS ON MM.CampaignID = LS.CampaignID AND DM.ConversionTargetID = LS.ConversionTargetID
WHERE ' + @sWhere + ' AND MM.CampaignStatus NOT IN (''1'',''5'') AND DM.ConversionTargetID LIKE ''HD_ADZTOBNI''
GROUP BY  MM.PlaceDate,MM.CampaignType) X
GROUP BY  X.MonthPlace, X.CampaignType

-- TÍnh % mục tiêu HD_PRECOACH
SELECT X.MonthPlace, X.CampaignType, SUM(X.SumRate)/COUNT(X.ConversionTargetID) AS PerRateTargetPRECOACH, SUM(SumLeadAttend) AS SumLeadTargerPRECOACH
INTO #CRMT20401_PRECOACH
FROM (SELECT (Case When Month(MM.PlaceDate) < 10 then ''0''+ rtrim(ltrim(str(Month(MM.PlaceDate)))) Else rtrim(ltrim(str(Month(MM.PlaceDate)))) End) AS MonthPlace 
,MM.CampaignType, DM.ConversionTargetID, SUM(DM.ConversionRate) AS SumRate, SUM(DM.AttendTarget) AS SumLeadAttend
FROM CRMT20401 MM WITH(NOLOCK)
LEFT JOIN CRMT20402 DM WITH(NOLOCK) ON MM.APK = DM.APKMaster
WHERE ' + @sWhere + ' AND MM.CampaignStatus NOT IN (''1'',''5'') AND DM.ConversionTargetID = ''HD_PRECOACH''
GROUP BY  MM.PlaceDate,MM.CampaignType,DM.ConversionTargetID) X
GROUP BY  X.MonthPlace, X.CampaignType

-- Tính lead tham dự thực tế PRECOACH
SELECT X.MonthPlace, X.CampaignType, SUM(X.SumLead) AS SumLeadActualPRECOACH
INTO #CRMT20301_PRECOACH
FROM (SELECT  (Case When Month(MM.PlaceDate) < 10 then ''0''+ rtrim(ltrim(str(Month(MM.PlaceDate)))) Else rtrim(ltrim(str(Month(MM.PlaceDate)))) End) AS MonthPlace 
, MM.CampaignType, COUNT(LS.LeadID) AS SumLead
FROM CRMT20401 MM WITH(NOLOCK)
LEFT JOIN CRMT20402 DM WITH(NOLOCK) ON MM.APK = DM.APKMaster
LEFT JOIN (SELECT L.APK, L.LeadID,L.LastModifyDate, D.CampaignDetailID AS CampaignID, T.Value AS ConversionTargetID
FROM CRMT20301 L WITH(NOLOCK)
LEFT JOIN CRMT20302 D WITH(NOLOCK) ON L.APK = D.APKMAster
CROSS APPLY StringSplit(D.SerminarID, '','') T) LS ON MM.CampaignID = LS.CampaignID AND DM.ConversionTargetID = LS.ConversionTargetID
WHERE ' + @sWhere + ' AND MM.CampaignStatus NOT IN (''1'',''5'') AND DM.ConversionTargetID LIKE ''HD_PRECOACH''
GROUP BY  MM.PlaceDate,MM.CampaignType) X
GROUP BY  X.MonthPlace, X.CampaignType

--Tính số trung bình % mục tiêu CIA
SELECT X.MonthPlace, X.CampaignType, COUNT(X.ConversionTargetID) AS SumConversionTarget, SUM(X.SumRate)/COUNT(X.ConversionTargetID) AS PerRateCIA 
INTO #CRMT20401_CIA
FROM (SELECT (Case When Month(MM.PlaceDate) < 10 then ''0''+ rtrim(ltrim(str(Month(MM.PlaceDate)))) Else rtrim(ltrim(str(Month(MM.PlaceDate)))) End) AS MonthPlace 
,MM.CampaignType, DM.ConversionTargetID, SUM(DM.ConversionRate) AS SumRate
FROM CRMT20401 MM WITH(NOLOCK)
LEFT JOIN CRMT20402 DM WITH(NOLOCK) ON MM.APK = DM.APKMaster
WHERE ' + @sWhere + ' AND MM.CampaignStatus NOT IN (''1'',''5'') AND DM.ConversionTargetID LIKE ''HD_%'' AND DM.ConversionTargetID NOT IN(''HD_ADZTOBNI'',''HD_PRECOACH'')
GROUP BY  MM.PlaceDate,MM.CampaignType,DM.ConversionTargetID) X
GROUP BY  X.MonthPlace, X.CampaignType, X.SumRate

-- Tính lead tham dự thực tế CIA
SELECT X.MonthPlace, X.CampaignType, SUM(X.SumLead) AS SumLeadActualCIA
INTO #CRMT20301_CIA
FROM (SELECT  (Case When Month(MM.PlaceDate) < 10 then ''0''+ rtrim(ltrim(str(Month(MM.PlaceDate)))) Else rtrim(ltrim(str(Month(MM.PlaceDate)))) End) AS MonthPlace 
, MM.CampaignType, COUNT(LS.LeadID) AS SumLead
FROM CRMT20401 MM WITH(NOLOCK)
LEFT JOIN CRMT20402 DM WITH(NOLOCK) ON MM.APK = DM.APKMaster
LEFT JOIN (SELECT L.APK, L.LeadID,L.LastModifyDate, D.CampaignDetailID AS CampaignID, T.Value AS ConversionTargetID
FROM CRMT20301 L WITH(NOLOCK)
LEFT JOIN CRMT20302 D WITH(NOLOCK) ON L.APK = D.APKMAster
CROSS APPLY StringSplit(D.SerminarID, '','') T) LS ON MM.CampaignID = LS.CampaignID AND DM.ConversionTargetID = LS.ConversionTargetID
WHERE ' + @sWhere + ' AND MM.CampaignStatus NOT IN (''1'',''5'') AND DM.ConversionTargetID LIKE ''HD_%'' AND DM.ConversionTargetID NOT IN(''HD_ADZTOBNI'',''HD_PRECOACH'')
GROUP BY  MM.PlaceDate,MM.CampaignType) X
GROUP BY  X.MonthPlace, X.CampaignType

-- Tính lead tham dự thực tế serminar 6steps
SELECT X.MonthPlace, X.CampaignType, SUM(X.SumLead) AS SumLeadActualSerminal6STEPS
INTO #CRMR20301_6STEPS
FROM (SELECT  (Case When Month(MM.PlaceDate) < 10 then ''0''+ rtrim(ltrim(str(Month(MM.PlaceDate)))) Else rtrim(ltrim(str(Month(MM.PlaceDate)))) End) AS MonthPlace 
, MM.CampaignType, COUNT(LS.LeadID) AS SumLead
FROM CRMT20401 MM WITH(NOLOCK)
LEFT JOIN CRMT20402 DM WITH(NOLOCK) ON MM.APK = DM.APKMaster
LEFT JOIN (SELECT L.APK, L.LeadID,L.LastModifyDate, D.CampaignDetailID AS CampaignID, T.Value AS ConversionTargetID
FROM CRMT20301 L WITH(NOLOCK)
LEFT JOIN CRMT20302 D WITH(NOLOCK) ON L.APK = D.APKMAster
CROSS APPLY StringSplit(D.SerminarID, '','') T) LS ON MM.CampaignID = LS.CampaignID AND DM.ConversionTargetID = LS.ConversionTargetID
WHERE ' + @sWhere + ' AND MM.CampaignStatus NOT IN (''1'',''5'') AND DM.ConversionTargetID IN (''SALE_MKTTO6STEPS'',''SALE_BNICTO6STEPS'',''SALE_CIATO6STEPS'')
GROUP BY  MM.PlaceDate,MM.CampaignType) X
GROUP BY  X.MonthPlace, X.CampaignType

SELECT X.MonthPlace, X.CampaignType, SUM(X.LeadThematicMAR) AS SumLeadThematicMAR
INTO #CRMT20301_MARKETING
FROM (SELECT (Case When Month(MM.PlaceDate) < 10 then ''0''+ rtrim(ltrim(str(Month(MM.PlaceDate)))) Else rtrim(ltrim(str(Month(MM.PlaceDate)))) End) AS MonthPlace 
, MM.CampaignType , COUNT(LS.LeadID) AS LeadThematicMAR
FROM CRMT20401 MM WITH(NOLOCK)
LEFT JOIN CRMT20402 DM WITH(NOLOCK) ON MM.APK = DM.APKMaster
LEFT JOIN (SELECT L.APK, L.LeadID,L.LastModifyDate, D.CampaignDetailID AS CampaignID, T.Value AS ThematicID
FROM CRMT20301 L WITH(NOLOCK)
LEFT JOIN CRMT20302 D WITH(NOLOCK) ON L.APK = D.APKMAster
CROSS APPLY StringSplit(D.ThematicID, '','') T) LS ON MM.CampaignID = LS.CampaignID 
WHERE ' + @sWhere + ' AND MM.CampaignStatus NOT IN (''1'',''5'') AND LS.ThematicID = ''MARKETING'' AND DM.ConversionTargetID LIKE ''%HD_%''
GROUP BY  LS.ThematicID, MM.PlaceDate, MM.CampaignType) X
GROUP BY  X.MonthPlace, X.CampaignType


SELECT X.MonthPlace, X.CampaignType, SUM(X.LeadThematicPUR) AS SumLeadThematicPUR
INTO #CRMT20301_PURPOSE
FROM (SELECT (Case When Month(MM.PlaceDate) < 10 then ''0''+ rtrim(ltrim(str(Month(MM.PlaceDate)))) Else rtrim(ltrim(str(Month(MM.PlaceDate)))) End) AS MonthPlace 
, MM.CampaignType , COUNT(LS.LeadID) AS LeadThematicPUR
FROM CRMT20401 MM WITH(NOLOCK)
LEFT JOIN CRMT20402 DM WITH(NOLOCK) ON MM.APK = DM.APKMaster
LEFT JOIN (SELECT L.APK, L.LeadID,L.LastModifyDate, D.CampaignDetailID AS CampaignID, T.Value AS ThematicID
FROM CRMT20301 L WITH(NOLOCK)
LEFT JOIN CRMT20302 D WITH(NOLOCK) ON L.APK = D.APKMAster
CROSS APPLY StringSplit(D.ThematicID, '','') T) LS ON MM.CampaignID = LS.CampaignID 
WHERE ' + @sWhere + ' AND MM.CampaignStatus NOT IN (''1'',''5'') AND LS.ThematicID = ''PURPOSE'' AND DM.ConversionTargetID LIKE ''%HD_%''
GROUP BY  LS.ThematicID, MM.PlaceDate, MM.CampaignType) X
GROUP BY  X.MonthPlace, X.CampaignType

SELECT X.MonthPlace, X.CampaignType, SUM(X.LeadThematicCAS) AS SumLeadThematicCAS
INTO #CRMT20301_CASHFLOW
FROM (SELECT (Case When Month(MM.PlaceDate) < 10 then ''0''+ rtrim(ltrim(str(Month(MM.PlaceDate)))) Else rtrim(ltrim(str(Month(MM.PlaceDate)))) End) AS MonthPlace 
, MM.CampaignType , COUNT(LS.LeadID) AS LeadThematicCAS
FROM CRMT20401 MM WITH(NOLOCK)
LEFT JOIN CRMT20402 DM WITH(NOLOCK) ON MM.APK = DM.APKMaster
LEFT JOIN (SELECT L.APK, L.LeadID,L.LastModifyDate, D.CampaignDetailID AS CampaignID, T.Value AS ThematicID
FROM CRMT20301 L WITH(NOLOCK)
LEFT JOIN CRMT20302 D WITH(NOLOCK) ON L.APK = D.APKMAster
CROSS APPLY StringSplit(D.ThematicID, '','') T) LS ON MM.CampaignID = LS.CampaignID 
WHERE ' + @sWhere + ' AND MM.CampaignStatus NOT IN (''1'',''5'') AND LS.ThematicID = ''CASHFLOW'' AND DM.ConversionTargetID LIKE ''%HD_%''
GROUP BY  LS.ThematicID, MM.PlaceDate, MM.CampaignType) X
GROUP BY  X.MonthPlace, X.CampaignType


SELECT X.MonthPlace, X.CampaignType, SUM(X.LeadThematicSPR) AS SumLeadThematicSPR
INTO #CRMT20301_SALEPHONERICH
FROM (SELECT (Case When Month(MM.PlaceDate) < 10 then ''0''+ rtrim(ltrim(str(Month(MM.PlaceDate)))) Else rtrim(ltrim(str(Month(MM.PlaceDate)))) End) AS MonthPlace 
, MM.CampaignType , COUNT(LS.LeadID) AS LeadThematicSPR
FROM CRMT20401 MM WITH(NOLOCK)
LEFT JOIN CRMT20402 DM WITH(NOLOCK) ON MM.APK = DM.APKMaster
LEFT JOIN (SELECT L.APK, L.LeadID,L.LastModifyDate, D.CampaignDetailID AS CampaignID, T.Value AS ThematicID
FROM CRMT20301 L WITH(NOLOCK)
LEFT JOIN CRMT20302 D WITH(NOLOCK) ON L.APK = D.APKMAster
CROSS APPLY StringSplit(D.ThematicID, '','') T) LS ON MM.CampaignID = LS.CampaignID 
WHERE ' + @sWhere + ' AND MM.CampaignStatus NOT IN (''1'',''5'') AND LS.ThematicID = ''SALEPHONERICH'' AND DM.ConversionTargetID LIKE ''%HD_%''
GROUP BY  LS.ThematicID, MM.PlaceDate, MM.CampaignType) X
GROUP BY  X.MonthPlace, X.CampaignType

SELECT X.MonthPlace, X.CampaignType, SUM(X.LeadThematicTR) AS SumLeadThematicTR
INTO #CRMT20301_TEAMRICH
FROM (SELECT (Case When Month(MM.PlaceDate) < 10 then ''0''+ rtrim(ltrim(str(Month(MM.PlaceDate)))) Else rtrim(ltrim(str(Month(MM.PlaceDate)))) End) AS MonthPlace 
, MM.CampaignType , COUNT(LS.LeadID) AS LeadThematicTR
FROM CRMT20401 MM WITH(NOLOCK)
LEFT JOIN CRMT20402 DM WITH(NOLOCK) ON MM.APK = DM.APKMaster
LEFT JOIN (SELECT L.APK, L.LeadID,L.LastModifyDate, D.CampaignDetailID AS CampaignID, T.Value AS ThematicID
FROM CRMT20301 L WITH(NOLOCK)
LEFT JOIN CRMT20302 D WITH(NOLOCK) ON L.APK = D.APKMAster
CROSS APPLY StringSplit(D.ThematicID, '','') T) LS ON MM.CampaignID = LS.CampaignID 
WHERE ' + @sWhere + ' AND MM.CampaignStatus NOT IN (''1'',''5'') AND LS.ThematicID = ''TEAMRICH'' AND DM.ConversionTargetID LIKE ''%HD_%''
GROUP BY  LS.ThematicID, MM.PlaceDate, MM.CampaignType) X
GROUP BY  X.MonthPlace, X.CampaignType

SELECT X.MonthPlace, X.CampaignType, SUM(X.LeadThematicSR) AS SumLeadThematicSR
INTO #CRMT20301_SYSTEMRICH
FROM (SELECT (Case When Month(MM.PlaceDate) < 10 then ''0''+ rtrim(ltrim(str(Month(MM.PlaceDate)))) Else rtrim(ltrim(str(Month(MM.PlaceDate)))) End) AS MonthPlace 
, MM.CampaignType , COUNT(LS.LeadID) AS LeadThematicSR
FROM CRMT20401 MM WITH(NOLOCK)
LEFT JOIN CRMT20402 DM WITH(NOLOCK) ON MM.APK = DM.APKMaster
LEFT JOIN (SELECT L.APK, L.LeadID,L.LastModifyDate, D.CampaignDetailID AS CampaignID, T.Value AS ThematicID
FROM CRMT20301 L WITH(NOLOCK)
LEFT JOIN CRMT20302 D WITH(NOLOCK) ON L.APK = D.APKMAster
CROSS APPLY StringSplit(D.ThematicID, '','') T) LS ON MM.CampaignID = LS.CampaignID 
WHERE ' + @sWhere + ' AND MM.CampaignStatus NOT IN (''1'',''5'') AND LS.ThematicID = ''SYSTEMRICH'' AND DM.ConversionTargetID LIKE ''%HD_%''
GROUP BY  LS.ThematicID, MM.PlaceDate, MM.CampaignType) X
GROUP BY  X.MonthPlace, X.CampaignType

SELECT X.MonthPlace, X.CampaignType, SUM(X.LeadThematicLG) AS SumLeadThematicLG
INTO #CRMT20301_LEVERAGAME
FROM (SELECT (Case When Month(MM.PlaceDate) < 10 then ''0''+ rtrim(ltrim(str(Month(MM.PlaceDate)))) Else rtrim(ltrim(str(Month(MM.PlaceDate)))) End) AS MonthPlace 
, MM.CampaignType , COUNT(LS.LeadID) AS LeadThematicLG
FROM CRMT20401 MM WITH(NOLOCK)
LEFT JOIN CRMT20402 DM WITH(NOLOCK) ON MM.APK = DM.APKMaster
LEFT JOIN (SELECT L.APK, L.LeadID,L.LastModifyDate, D.CampaignDetailID AS CampaignID, T.Value AS ThematicID
FROM CRMT20301 L WITH(NOLOCK)
LEFT JOIN CRMT20302 D WITH(NOLOCK) ON L.APK = D.APKMAster
CROSS APPLY StringSplit(D.ThematicID, '','') T) LS ON MM.CampaignID = LS.CampaignID 
WHERE ' + @sWhere + ' AND MM.CampaignStatus NOT IN (''1'',''5'') AND LS.ThematicID = ''LEVERAGAME'' AND DM.ConversionTargetID LIKE ''%HD_%''
GROUP BY  LS.ThematicID, MM.PlaceDate, MM.CampaignType) X
GROUP BY  X.MonthPlace, X.CampaignType

--Tính số trung bình % mục tiêu COD
SELECT X.MonthPlace, X.CampaignType, SUM(X.SumRate)/COUNT(X.ConversionTargetID) AS PerRateCOD 
INTO #CRMT20401_COD
FROM (SELECT (Case When Month(MM.PlaceDate) < 10 then ''0''+ rtrim(ltrim(str(Month(MM.PlaceDate)))) Else rtrim(ltrim(str(Month(MM.PlaceDate)))) End) AS MonthPlace 
,MM.CampaignType, DM.ConversionTargetID, SUM(DM.ConversionRate) AS SumRate
FROM CRMT20401 MM WITH(NOLOCK)
LEFT JOIN CRMT20402 DM WITH(NOLOCK) ON MM.APK = DM.APKMaster
WHERE ' + @sWhere + ' AND MM.CampaignStatus NOT IN (''1'',''5'') AND DM.ConversionTargetID = ''COD''
GROUP BY  MM.PlaceDate,MM.CampaignType,DM.ConversionTargetID, MM.CampaignStatus) X
GROUP BY  X.MonthPlace, X.CampaignType

-- Tổng thực tế cơ hội qua giai đoạn COD
SELECT  (Case When Month(MM.PlaceDate) < 10 then ''0''+ rtrim(ltrim(str(Month(MM.PlaceDate)))) Else rtrim(ltrim(str(Month(MM.PlaceDate)))) End) AS MonthPlace 
, MM.CampaignType, COUNT(OP.StageID) AS SumOpportunityCOD
INTO #CRMT20501_COD
FROM CRMT20401 MM WITH(NOLOCK)
LEFT JOIN (SELECT M.OpportunityID, M.CampaignID ,D.StageID
			FROM CRMT20501 M WITH(NOLOCK)
			LEFT JOIN CRMT20502 D WITH(NOLOCK) ON M.APK = D.APKMaster) OP ON OP.CampaignID = MM.CampaignID
WHERE ' + @sWhere + ' AND MM.CampaignStatus NOT IN (''1'',''5'') AND OP.StageID = ''COD''
GROUP BY MM.PlaceDate, MM.CampaignType

--Tính số trung bình % mục tiêu DIAGS
SELECT X.MonthPlace, X.CampaignType, SUM(X.SumRate)/COUNT(X.ConversionTargetID) AS PerRateDIAGS 
INTO #CRMT20401_DIAGS
FROM (SELECT (Case When Month(MM.PlaceDate) < 10 then ''0''+ rtrim(ltrim(str(Month(MM.PlaceDate)))) Else rtrim(ltrim(str(Month(MM.PlaceDate)))) End) AS MonthPlace 
,MM.CampaignType, DM.ConversionTargetID, SUM(DM.ConversionRate) AS SumRate
FROM CRMT20401 MM WITH(NOLOCK)
LEFT JOIN CRMT20402 DM WITH(NOLOCK) ON MM.APK = DM.APKMaster
WHERE ' + @sWhere + ' AND MM.CampaignStatus NOT IN (''1'',''5'') AND DM.ConversionTargetID = ''DIAGS''
GROUP BY  MM.PlaceDate,MM.CampaignType,DM.ConversionTargetID, MM.CampaignStatus) X
GROUP BY  X.MonthPlace, X.CampaignType

-- Tổng thực tế cơ hội qua giai đoạn DIAGS
SELECT  (Case When Month(MM.PlaceDate) < 10 then ''0''+ rtrim(ltrim(str(Month(MM.PlaceDate)))) Else rtrim(ltrim(str(Month(MM.PlaceDate)))) End) AS MonthPlace 
, MM.CampaignType, COUNT(OP.StageID) AS SumOpportunityDIAGS
INTO #CRMT20501_DIAGS
FROM CRMT20401 MM WITH(NOLOCK)
LEFT JOIN (SELECT M.OpportunityID, M.CampaignID ,D.StageID
FROM CRMT20501 M WITH(NOLOCK)
LEFT JOIN CRMT20502 D WITH(NOLOCK) ON M.APK = D.APKMaster) OP ON OP.CampaignID = MM.CampaignID
WHERE ' + @sWhere + ' AND MM.CampaignStatus NOT IN (''1'',''5'') AND OP.StageID = ''DIAGS''
GROUP BY MM.PlaceDate, MM.CampaignType

-- Tính số bộ kit đã gửi 
SELECT X.MonthPlace, X.CampaignType, SUM(X.SumTaskKIT) AS SumWELCCOMBACK
INTO #WELCOMBACK_KIT
FROM (SELECT  (Case When Month(MM.PlaceDate) < 10 then ''0''+ rtrim(ltrim(str(Month(MM.PlaceDate)))) Else rtrim(ltrim(str(Month(MM.PlaceDate)))) End) AS MonthPlace 
, MM.CampaignType, COUNT(CV.TaskID) AS SumTaskKIT
FROM CRMT20401 MM WITH(NOLOCK)
LEFT JOIN (SELECT M.CampaignID,C.TaskID, C.TaskSampleID, C.StatusID
FROM CRMT20501 M WITH(NOLOCK)
LEFT JOIN OOT2100 D WITH(NOLOCK) ON M.OpportunityID = D.OpportunityID
LEFT JOIN OOT2110 C WITH(NOLOCK) ON D.ProjectID = C.ProjectID
WHERE C.TaskSampleID = ''MCVDA.CBD.GUIBOKIT'' AND C.StatusID = ''TTCV0003'')
CV ON CV.CampaignID = MM.CampaignID
WHERE ' + @sWhere + ' AND MM.CampaignStatus NOT IN (''1'',''5'') 
GROUP BY MM.PlaceDate, MM.CampaignType) X
GROUP BY X.MonthPlace, X.CampaignType

'

SET @sSQL1 = '
SELECT T.MonthPlace,T.CampaignType, DA.Description AS CampaignTypeName, T.AmountTarget, T.SumLeadTarget, T.BudgetCost, T.ChangeCostTarget, T.LeadPortraitRate
, A.AmountActual, A.SumLeadActual, A.ActualCost, A.ChangeCostActual, S.SumLeadQualify, P.PerRateTargetSerminar, P.SumLeadTargerSerminar,LS.SumLeadActualSerminar
, P_BNI.PerRateTargetBNI, P_BNI.SumLeadTargerBNI, L_BNI.SumLeadActualBNI,P_PRE.PerRateTargetPRECOACH, P_PRE.SumLeadTargerPRECOACH, L_PRE.SumLeadActualPRECOACH, P_CIA.PerRateCIA, L_CIA.SumLeadActualCIA
, L_6ST.SumLeadActualSerminal6STEPS, L_PUR.SumLeadThematicPUR, L_CAS.SumLeadThematicCAS, L_MAR.SumLeadThematicMAR, L_TR.SumLeadThematicTR, L_SPR.SumLeadThematicSPR
, L_SR.SumLeadThematicSR, L_LG.SumLeadThematicLG, P_COD.PerRateCOD, L_COD.SumOpportunityCOD,  P_DIAGS.PerRateDIAGS, L_DIAGS.SumOpportunityDIAGS,WB.SumWELCCOMBACK 
INTO #CRMT20401_TARGET_TMP
FROM #CRMT20401_TARGET T WITH(NOLOCK)
LEFT JOIN #CRMT20401_ACTUAL A WITH(NOLOCK) ON T.MonthPlace = A.MonthPlace AND T.CampaignType = A.CampaignType
LEFT JOIN #CRMT20301_STATUS S WITH(NOLOCK) ON A.MonthPlace = S.MonthPlace AND A.CampaignType = S.CampaignType
LEFT JOIN #CRMT20401_PERCENT P WITH(NOLOCK) ON A.MonthPlace = P.MonthPlace AND A.CampaignType = P.CampaignType
LEFT JOIN #CRMT20301_LEADSERMINAR LS WITH(NOLOCK) ON A.MonthPlace = LS.MonthPlace AND A.CampaignType = LS.CampaignType
LEFT JOIN #CRMT20401_BNI P_BNI WITH(NOLOCK) ON A.MonthPlace = P_BNI.MonthPlace AND A.CampaignType = P_BNI.CampaignType
LEFT JOIN #CRMT20301_BNI L_BNI WITH(NOLOCK) ON A.MonthPlace = L_BNI.MonthPlace AND A.CampaignType = L_BNI.CampaignType
LEFT JOIN #CRMT20401_PRECOACH P_PRE WITH(NOLOCK) ON A.MonthPlace = P_PRE.MonthPlace AND A.CampaignType = P_PRE.CampaignType
LEFT JOIN #CRMT20301_PRECOACH L_PRE WITH(NOLOCK) ON A.MonthPlace = L_PRE.MonthPlace AND A.CampaignType = L_PRE.CampaignType
LEFT JOIN #CRMT20401_CIA P_CIA WITH(NOLOCK) ON A.MonthPlace = P_CIA.MonthPlace AND A.CampaignType = P_CIA.CampaignType
LEFT JOIN #CRMT20301_CIA L_CIA WITH(NOLOCK) ON A.MonthPlace = L_CIA.MonthPlace AND A.CampaignType = L_CIA.CampaignType
LEFT JOIN #CRMR20301_6STEPS L_6ST WITH(NOLOCK) ON A.MonthPlace = L_6ST.MonthPlace AND A.CampaignType = L_6ST.CampaignType
LEFT JOIN #CRMT20301_PURPOSE L_PUR WITH(NOLOCK) ON A.MonthPlace = L_PUR.MonthPlace AND A.CampaignType = L_PUR.CampaignType
LEFT JOIN #CRMT20301_CASHFLOW L_CAS WITH(NOLOCK) ON A.MonthPlace = L_CAS.MonthPlace AND A.CampaignType = L_CAS.CampaignType
LEFT JOIN #CRMT20301_MARKETING L_MAR WITH(NOLOCK) ON A.MonthPlace = L_MAR.MonthPlace AND A.CampaignType = L_MAR.CampaignType
LEFT JOIN #CRMT20301_TEAMRICH L_TR WITH(NOLOCK) ON A.MonthPlace = L_TR.MonthPlace AND A.CampaignType = L_TR.CampaignType
LEFT JOIN #CRMT20301_SALEPHONERICH L_SPR WITH(NOLOCK) ON A.MonthPlace = L_SPR.MonthPlace AND A.CampaignType = L_SPR.CampaignType
LEFT JOIN #CRMT20301_SYSTEMRICH L_SR WITH(NOLOCK) ON A.MonthPlace = L_SR.MonthPlace AND A.CampaignType = L_SR.CampaignType
LEFT JOIN #CRMT20301_LEVERAGAME L_LG WITH(NOLOCK) ON A.MonthPlace = L_LG.MonthPlace AND A.CampaignType = L_LG.CampaignType
LEFT JOIN #CRMT20401_COD P_COD WITH(NOLOCK) ON A.MonthPlace = P_COD.MonthPlace AND A.CampaignType = P_COD.CampaignType
LEFT JOIN #CRMT20501_COD L_COD WITH(NOLOCK) ON A.MonthPlace = L_COD.MonthPlace AND A.CampaignType = L_COD.CampaignType
LEFT JOIN #CRMT20401_DIAGS P_DIAGS WITH(NOLOCK) ON A.MonthPlace = P_DIAGS.MonthPlace AND A.CampaignType = P_DIAGS.CampaignType
LEFT JOIN #CRMT20501_DIAGS L_DIAGS WITH(NOLOCK) ON A.MonthPlace = L_DIAGS.MonthPlace AND A.CampaignType = L_DIAGS.CampaignType
LEFT JOIN #WELCOMBACK_KIT WB WITH(NOLOCK) ON A.MonthPlace = WB.MonthPlace AND A.CampaignType = WB.CampaignType
INNER JOIN CRMT0099 DA WITH(NOLOCK) ON T.CampaignType = DA.ID AND DA.CodeMaster = '''+ @CodeMaster +'''
' + @sWhere2 + ' ORDER BY T.MonthPlace ASC 

SELECT * FROM  #CRMT20401_TARGET_TMP T ORDER BY T.MonthPlace,T.CampaignType
'

IF @CustomerIndex IN (-1, 92)
BEGIN
	DECLARE @Cols NVARCHAR(MAX)
	SET @Cols = STUFF((SELECT ',' + QUOTENAME(C.Description) 
	FROM CRMT0099 C WHERE C.CodeMaster = 'CRMT00000033' ORDER BY C.OrderNo
				FOR XML PATH(''), TYPE
				).value('.', 'NVARCHAR(MAX)') 
			,1,1,'')

	SET @sSql3 = N'
			SELECT 
				 T.MonthPlace
				,T.CampaignType
				,T.CampaignTypeName
			INTO #TMP FROM #CRMT20401_TARGET_TMP T
	
			SELECT * 
			INTO #PIVOTED_TMP
			FROM (
					SELECT
						T.MonthPlace
						,T.CampaignType
						,T.CampaignTypeName
						,C4.Description AS ConversionActualName
						,SUM(C3.AttendActual) AS AttendActual
					FROM #TMP T 
					INNER JOIN CRMT20401 C1 WITH (NOLOCK) ON T.MonthPlace = MONTH(C1.PlaceDate) AND T.CampaignType = C1.CampaignType
					LEFT JOIN CRMT20402 C2 WITH (NOLOCK) ON C2.APKMaster = C1.APK
					LEFT JOIN CRMT20403 C3 WITH (NOLOCK) ON C3.APKMaster = C1.APK
					LEFT JOIN CRMT0099 C4 WITH (NOLOCK) ON C4.ID = c2.ConversionTargetID AND C4.CodeMaster = ''CRMT00000033'' 
					GROUP BY T.MonthPlace, T.CampaignType, C4.Description, T.CampaignTypeName 
			) x PIVOT (SUM(x.AttendActual) FOR x.ConversionActualName IN ('+ @Cols +')) p

			SELECT * FROM #PIVOTED_TMP ORDER BY MonthPlace, CampaignType
	'

END

print (@sSQL1)
EXEC (@sSQL + @sSQL1 + @sSql3)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
