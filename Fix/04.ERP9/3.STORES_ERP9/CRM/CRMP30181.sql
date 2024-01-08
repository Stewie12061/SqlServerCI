IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP30181]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP30181]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
----Báo cáo chi tiết Marketing - sale
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Đình Hòa on 01/12/2020
----Updated by: Anh Đô on 09/11/2022 : Fix lỗi không lên dữ liệu ở cột ConversionRateActual và AttendActual
-- <Example>
CREATE PROCEDURE [dbo].[CRMP30181] ( 
        @DivisionID			VARCHAR(50),		--Biến môi trường
		@DivisionIDList		NVARCHAR(2000),		--Chọn trong DropdownChecklist DivisionID
		@IsDate				TINYINT,			--1: Theo ngày; 0: Theo kỳ
		@FromDate			DATETIME,
		@ToDate				DATETIME,
		@PeriodIDList		NVARCHAR(2000),
		@UserID				VARCHAR(50),
		@CampaignIDList		VARCHAR(MAX) =''
)
AS
DECLARE @sSQL	NVARCHAR (MAX),
		@sSQL1	NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX)

SET @sWhere = ''
SET @sWhere = ' ISNULL(M.DeleteFlg, 0) = 0 AND'
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
SET @sSQL ='SELECT M.CampaignID, D.* 
			INTO #CRMT20402temp
			FROM CRMT20401 M WITH(NOLOCK) 
			LEFT JOIN CRMT20402 D WITH(NOLOCK) ON M.APK = D.APKMaster 

			SELECT L.APK, L.LeadID,L.LastModifyDate, D.CampaignDetailID AS CampaignID, T.Value AS ConversionTargetID
			INTO #CRMT20301temp
			FROM CRMT20301 L WITH(NOLOCK)
			LEFT JOIN CRMT20302 D WITH(NOLOCK) ON L.APK = D.APKMAster
			CROSS APPLY StringSplit(D.SerminarID, '','') T
		
			DECLARE @campaignID VARCHAR(50) 
			DECLARE @campaignIDTmp VARCHAR(50) 
			DECLARE @tmp INT = 1

			SELECT DISTINCT L.CampaignDetailID, 1 AS CountLead
			INTO #CRMT203012temp
			FROM CRMT20301 M WITH(NOLOCK) 
			LEFT JOIN CRMT20302 L WITH(NOLOCK) ON M.APK = L.APKMaster
			ORDER BY L.CampaignDetailID

			DECLARE cursorCountLead CURSOR FOR  
			SELECT L.CampaignDetailID
			FROM CRMT20301 M WITH(NOLOCK) 
			LEFT JOIN CRMT20302 L WITH(NOLOCK) ON M.APK = L.APKMaster
			ORDER BY L.CampaignDetailID
			OPEN cursorCountLead             
			FETCH NEXT FROM cursorCountLead INTO @campaignID
			SET @campaignIDTmp = ''''
			WHILE @@FETCH_STATUS = 0          
			BEGIN
				IF (@campaignIDTmp = @campaignID)
				BEGIN
					SET @tmp = @tmp + 1;

					UPDATE #CRMT203012temp
					SET CountLead = @tmp
					WHERE CampaignDetailID = @campaignID
				END
				ELSE
				BEGIN
					SET @tmp = 1;
				END       	
				SET @campaignIDTmp = @campaignID                      
				FETCH NEXT FROM cursorCountLead INTO @campaignID
			END
			CLOSE cursorCountLead            
			DEALLOCATE cursorCountLead
			
			SELECT  L.CampaignID ,T.APKMaster, T.ConversionTargetID AS ID, COUNT(L.APK) AS Lead , CONVERT(DECIMAL(28,8), COUNT(L.APK))/C.CountLead AS Rate
			INTO #CRMT20403temp
			FROM #CRMT20301temp L WITH(NOLOCK)
			INNER JOIN #CRMT20402temp T WITH(NOLOCK) ON L.ConversionTargetID = T.ConversionTargetID AND L.CampaignID = T.CampaignID
			LEFT JOIN #CRMT203012temp C WITH(NOLOCK) ON L.CampaignID = C.CampaignDetailID
			GROUP BY  C.CountLead, L.CampaignID , T.APKMaster, T.ConversionTargetID
			
			UPDATE #CRMT20403temp
			SET Rate = CONVERT(DECIMAL(28,8), T.Lead)/X.Lead
			FROM #CRMT20403temp T WITH(NOLOCK)
			LEFT JOIN (SELECT * FROM #CRMT20403temp 
					   WHERE ID LIKE ''SALE_%'' AND Lead IS NOT NULL) X ON X.CampaignID = T.CampaignID
			WHERE T.ID LIKE ''HD_%''

			'

SET @sSQL1 ='SELECT M.CampaignID
			, M.CampaignName
			, M.PlaceDate
			, M.ExpectOpenDate
			, M.ExpectCloseDate
			, D5.StageName AS CampaignStatus
			, M.LeadsTarget
			, C.CountLead AS LeadsActual
			, M.BudgetCost
			, M.ActualCost
			, D.ConversionTargetID
			, D4.Description AS ConversionName
			, D.ConversionRate
			, D.AttendTarget
			, ISNULL(M.AttendRateActual, 0) / 100 AS ConversionRateActual
			, M.AttendLeaderActual AS AttendActual

			FROM CRMT20401 M WITH(NOLOCK)
			LEFT JOIN (SELECT D1.APKMaster, D1.ConversionTargetID , D1.ConversionRate / 100 AS ConversionRate, D1.AttendTarget , D2.Rate,  D2.Lead
					   FROM CRMT20402 D1 WITH(NOLOCK)
					   LEFT JOIN #CRMT20403temp D2 WITH(NOLOCK) ON D1.APKMaster = D2.APKMaster AND D1.ConversionTargetID = D2.ID) AS D ON M.APK = D.APKMaster
			LEFT JOIN #CRMT203012temp C WITH(NOLOCK) ON C.CampaignDetailID = M.CampaignID
			LEFT JOIN CRMT0099 D3 WITH(NOLOCK) ON D3.ID = M.CampaignStatus AND (D3.CodeMaster = ''CRMT00000012'' OR D3.CodeMaster = ''CRMT00000013'')
			LEFT JOIN CRMT0099 D4 WITH(NOLOCK) ON D4.ID = D.ConversionTargetID AND D4.CodeMaster = ''CRMT00000033''
			LEFT JOIN CRMT10401 D5 WITH (NOLOCK) ON D5.StageID = M.CampaignStatus
			WHERE'+ @sWhere + '
			ORDER BY M.CampaignID, D4.OrderNo'

print (@sSQL)
print (@sSQL1)
EXEC (@sSQL + @sSQL1)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
