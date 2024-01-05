IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP30191_Standard]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].CRMP30191_Standard
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <summary
--- Load dữ liệu in cho báo cáo tổng Marketing-Sales theo CustomerIndex chuẩn
--- Created on 04/01/2023 by Anh Đô
-- <example>
---EXEC CRMP30191_Standard @DivisionID=N'1B',@DivisionIDList='1B',@IsDate=0,@FromDate='',@ToDate='',@PeriodIDList='01/2023'',''12/2022'',''11/2022'',''10/2022'',''09/2022'',''08/2022'',''07/2022'',''06/2022',@UserID=N'DQT001',@CampaignIDList=null

CREATE PROC CRMP30191_Standard
			@DivisionID			VARCHAR(50),
			@DivisionIDList		NVARCHAR(2000),
			@IsDate				TINYINT,
			@FromDate			DATETIME,
			@ToDate				DATETIME,
			@PeriodIDList		NVARCHAR(2000),
			@UserID				VARCHAR(50),
			@CampaignIDList		VARCHAR(MAX) =''
AS
BEGIN
	DECLARE @sSql1		NVARCHAR(MAX)
			,@sSql2		NVARCHAR(MAX)
			,@sSql3		NVARCHAR(MAX)
			,@sWhere	NVARCHAR(MAX) = ''

	IF @IsDate = 1	
	BEGIN
		SET @sWhere = @sWhere + ' AND (CONVERT(VARCHAR(10),C1.ExpectOpenDate,112) BETWEEN'''+ CONVERT(VARCHAR(20),@FromDate,112)+''' AND''' + CONVERT(VARCHAR(20),@ToDate,112)
						+''' OR CONVERT(VARCHAR(10),C1.ExpectCloseDate,112) BETWEEN'''+ CONVERT(VARCHAR(20),@FromDate,112)+''' AND''' + CONVERT(VARCHAR(20),@ToDate,112) 
						+''' OR CONVERT(VARCHAR(10),C1.PlaceDate,112) BETWEEN'''+ CONVERT(VARCHAR(20),@FromDate,112)+''' AND''' + CONVERT(VARCHAR(20),@ToDate,112) +''')'
	END
	ELSE
	BEGIN
		SET @sWhere = @sWhere + ' AND ((CASE WHEN MONTH(C1.ExpectOpenDate) < 10 THEN ''0''+RTRIM(LTRIM(STR(MONTH(C1.ExpectOpenDate))))+''/''+LTRIM(RTRIM(STR(YEAR(C1.ExpectOpenDate)))) 
										  ELSE RTRIM(LTRIM(STR(MONTH(C1.ExpectOpenDate))))+''/''+LTRIM(RTRIM(STR(YEAR(C1.ExpectOpenDate)))) END) IN ('''+@PeriodIDList+''')
										OR (CASE WHEN MONTH(C1.ExpectCloseDate) < 10 THEN ''0''+RTRIM(LTRIM(STR(MONTH(C1.ExpectCloseDate))))+''/''+LTRIM(RTRIM(STR(YEAR(C1.ExpectCloseDate)))) 
										    ELSE RTRIM(LTRIM(STR(MONTH(C1.ExpectCloseDate))))+''/''+LTRIM(RTRIM(STR(YEAR(C1.ExpectCloseDate)))) END) IN ('''+@PeriodIDList+''')
										OR (CASE WHEN MONTH(C1.PlaceDate) < 10 THEN ''0''+RTRIM(LTRIM(STR(MONTH(C1.PlaceDate))))+''/''+LTRIM(RTRIM(STR(YEAR(C1.PlaceDate)))) 
										   ELSE RTRIM(LTRIM(STR(MONTH(C1.PlaceDate))))+''/''+LTRIM(RTRIM(STR(YEAR(C1.PlaceDate)))) END) IN ('''+@PeriodIDList+'''))'
	END

	IF ISNULL(@CampaignIDList, '') != ''
		SET @sWhere = @sWhere + ' AND C1.CampaignID IN ('''+ @CampaignIDList +''') '
	
	SET @sSql1 = N'
		DECLARE @ConversionIDs TABLE (ConversionID VARCHAR(50), ConversionName NVARCHAR(250))
		INSERT INTO @ConversionIDs (ConversionID, ConversionName)
		SELECT 
			 C.ID AS ConversionID
			,C.Description AS ConversionName
		FROM CRMT0099 C WITH (NOLOCK) WHERE C.CodeMaster = ''CRMT00000033'' AND ISNULL(C.Disabled, 0) = 0
		AND ISNULL(C.ID, '''') != ''''
		ORDER BY C.OrderNo

		SELECT * FROM @ConversionIDs
	'
	-- Tính tổng số AttendTarget
	SET @sSql2 = N'
		SELECT
			 SUM(ISNULL(C2.AttendTarget, 0)) AS SumAttendTarget
			,C2.ConversionTargetID
		FROM CRMT20401 C1 WITH (NOLOCK)
		LEFT JOIN CRMT20402 C2 WITH (NOLOCK) ON C2.APKMaster = C1.APK
		WHERE C2.ConversionTargetID IN (SELECT ConversionID FROM @ConversionIDs)
		AND C1.DivisionID IN ('''+ @DivisionID +''', ''@@@'')
		AND ISNULL(C1.DeleteFlg, 0) = 0 '+ @sWhere +'
		GROUP BY C2.ConversionTargetID
	'
	-- Tính tổng số AttendActual
	SET @sSql3 = N'
		SELECT
			 SUM(ISNULL(C2.AttendActual, 0)) AS SumAttendActual
			,C2.ConversionActualID
		FROM CRMT20401 C1 WITH (NOLOCK)
		LEFT JOIN CRMT20403 C2 WITH (NOLOCK) ON C2.APKMaster = C1.APK
		WHERE C2.ConversionActualID IN (SELECT ConversionID FROM @ConversionIDs)
		AND C1.DivisionID IN ('''+ @DivisionID +''', ''@@@'')
		AND ISNULL(C1.DeleteFlg, 0) = 0 '+ @sWhere +'
		GROUP BY C2.ConversionActualID
	'

	PRINT(@sSql1 + @sSql2 + @sSql3)
	EXEC(@sSql1 + @sSql2 + @sSql3)
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
