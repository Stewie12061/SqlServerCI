IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP30172]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP30172]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Chọn đơn hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create ON 26/08/2020 by Kiều Nga
---- Modified ON 13/10/2022 by Hoài Bảo - Bổ sung điều kiện lọc theo ngày, theo kỳ
-- <Example> EXEC SOP30172 'MT','',''

CREATE PROCEDURE [dbo].[SOP30172]
(
	@DivisionID			NVARCHAR(50),	--Biến môi trường
	@DivisionIDList		NVARCHAR(MAX),	--Giá trị truyền Dropdown đơn vị
	@IsDate				TINYINT,		--1: Theo ngày; 0: Theo kỳ
	@FromDate			DATETIME,
	@ToDate				DATETIME,
	@PeriodIDList		NVARCHAR(2000)
)
AS
BEGIN
	DECLARE @sSQL NVARCHAR(max)='',
			@sWhere NVARCHAR(max)=''

	--IF @FromPeriod <> '' AND @ToPeriod <> ''
	--SET @sWhere = @sWhere +' AND TRANYEAR * 100 + TRANMONTH BETWEEN '''+STR(@FromPeriod)+''' AND  '''+STR(@ToPeriod)+''''

	--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
	IF ISNULL(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' AND DivisionID IN ('''+@DivisionIDList+''', ''@@@'')'
	ELSE 
		SET @sWhere = @sWhere + ' AND DivisionID IN ('''+@DivisionID+''', ''@@@'')'


	--Search theo điều điện thời gian
	IF @IsDate = 1
	BEGIN
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR,OrderDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
	END
	ELSE
	BEGIN
		IF ISNULL(@PeriodIDList, '') != ''
			SET @sWhere = @sWhere + ' AND (CASE WHEN TranMonth < 10 THEN ''0'' + RTRIM(LTRIM(STR(TranMonth))) + ''/'' + LTRIM(RTRIM(STR(TranYear)))
										ELSE RTRIM(LTRIM(STR(TranMonth))) + ''/'' + LTRIM(RTRIM(STR(TranYear))) END) IN (SELECT Value FROM [dbo].StringSplit(''' +@PeriodIDList+ ''', '',''))'
	END

-- Lấy dữ liệu báo cáo
SET @sSQL = 'SELECT ROW_NUMBER() OVER (ORDER BY VoucherNo) AS RowNum, COUNT(*) OVER () AS TotalRow,*
FROM OV1005
WHERE TYPE=''SO''
AND ORDERSTATUS IN(1,2,3)
'+@sWhere+'
AND ORDERTYPE=0
ORDER BY ORDERDATE,VOUCHERNO
'

PRINT @sSQL
EXEC (@sSQL)


END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


