IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'CRMP20404') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE CRMP20404
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load số liệu mục tiêu chuyến đổi thực tế của Leads
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Trần Đình Hòa, Date: 27/11/2020
-- <Example>

CREATE PROCEDURE CRMP20404 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@APK VARCHAR(50), 
        @CampaignID nvarchar(50),
		@ExpectOpenDate Datetime,
		@ExpectCloseDate Datetime		
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@sWhere2 VARCHAR(MAX)
		
	SET @sWhere = ''
	SET @sWhere2 = ''
	SET @sSQL = ''

	IF ISNULL(@DivisionID, '') != ''
		SET @sWhere = @sWhere + ' WHERE L.DivisionID = '''+@DivisionID+''''

	SET @sWhere2 = @sWhere2 + ' CONVERT(VARCHAR(10),L.LastModifyDate,112) 
				BETWEEN ' + CONVERT(VARCHAR(10), @ExpectOpenDate, 112) + ' AND ' + CONVERT(VARCHAR(10), @ExpectCloseDate, 112) + ' '

	IF ISNULL(@APK, '') != ''
	BEGIN
	SET @sSQL =	'SELECT * 
		INTO #CRMT20402temp
		FROM CRMT20402 WITH(NOLOCK)
		WHERE APKMaster = '''+ @APK + '''

		SELECT L.APK, L.LeadID,L.LastModifyDate, D.CampaignDetailID AS CampaignID, T.Value AS ConversionTargetID
		INTO #CRMT20301temp
		FROM CRMT20301 L WITH(NOLOCK)
		LEFT JOIN CRMT20302 D WITH(NOLOCK) ON L.APK = D.APKMAster
		CROSS APPLY StringSplit(D.SerminarID, '','') T
		' + @sWhere + '

		DECLARE @countLeadMKT INT,
				@amountLead INT

		SET @countLeadMKT = (SELECT COUNT(*) 
		FROM CRMT20301 M WITH(NOLOCK) 
		LEFT JOIN CRMT20302 L WITH(NOLOCK) ON M.APK = L.APKMaster
		WHERE L.CampaignDetailID = '''+@CampaignID+''')

		IF(@countLeadMKT != '''')
		BEGIN
			--Tính gía trị rate và đếm số lead
			SELECT T.APKMaster, T.ConversionTargetID AS ID, CONVERT(DECIMAL(28,8), COUNT(L.APK))/@countLeadMKT * 100 AS Rate ,COUNT(L.APK) AS Lead
			INTO #CRMT20403temp
			FROM #CRMT20301temp L WITH(NOLOCK)
			LEFT JOIN #CRMT20402temp T WITH(NOLOCK) ON L.ConversionTargetID = T.ConversionTargetID
			WHERE L.CampaignID =  '''+@CampaignID+'''
			GROUP BY T.APKMaster, T.ConversionTargetID

			--Lấy số lượng của SALE để tính Rate thực tế cho CIA (ID LIKE ''HD_%'')
			SELECT TOP 1 @amountLead = Lead 
			FROM #CRMT20403temp WITH(NOLOCK) 
			WHERE ID LIKE ''SALE_%'' AND Lead IS NOT NULL
			 
			IF(@amountLead != '''')
			BEGIN
				--- Update giá trị Rate
				UPDATE #CRMT20403temp SET Rate = CONVERT(DECIMAL(28,8), Lead)/@amountLead * 100
				WHERE ID LIKE ''HD_%''
			
				---Xóa data CRMT20403
				DELETE CRMT20403
				FROM CRMT20403 D WITH(NOLOCK)
				INNER JOIN #CRMT20403temp D_temp WITH(NOLOCK) ON D.ConversionActualID = D_temp.ID AND D.APKMaster = D_temp.APKMaster

				---Thêm vào bảng CRMT20403
				INSERT INTO CRMT20403 (APKMaster, ConversionActualID, ConversionRateActual, AttendActual)
				SELECT APKMaster, ID, Rate, Lead
				FROM #CRMT20403temp WITH(NOLOCK);
			END
		END'
	END

EXEC (@sSQL)
print (@sSQL)