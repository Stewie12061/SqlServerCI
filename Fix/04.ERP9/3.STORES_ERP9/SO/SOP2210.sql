IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2210]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2210]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load danh mục tài khoản kích hoạt
-- <Param>
---- 
-- <Return>
---- 
-- <History>
----Created by: Hoàng Long, Date: 01/12/2023
-- <Example>

CREATE PROCEDURE SOP2210 (
	@DivisionID VARCHAR(50),	-- Biến môi trường
	@DivisionIDList NVARCHAR(2000),	-- Chọn trong DropdownChecklist DivisionID
	@FromDate DATETIME,
	@ToDate DATETIME,
	@IsPeriod INT,
	@PeriodList VARCHAR(MAX),
	@SeriNo NVARCHAR(50) = N'',
	@TAccount NVARCHAR(50) =N'',
	@DAccount NVARCHAR(50)=N'',
	@Tel NVARCHAR(50) =N'',
	@Province NVARCHAR(50)=N'',
	@PageNumber INT,
	@PageSize INT
)
AS
DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)

SET @sWhere = 'WHERE S1.SeriNo IS NOT NULL AND '
SET @OrderBy = ' S1.SeriNo DESC '
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

-- Kiểm tra DivisionIDList nếu null sẽ lấy Division hiện tại
IF ISNULL(@DivisionIDList, '') != ''
	SET @sWhere = 'AND S1.DivisionID IN (''' + @DivisionIDList + ''', ''@@@'')'
ELSE
	SET @sWhere = 'AND S1.DivisionID IN (''' + @DivisionID + ''', ''@@@'')'

IF ISNULL(@SeriNo, '') != ''
SET @sWhere = 'AND S1.SeriNo IN (''' + @SeriNo + ''', ''@@@'')'

IF ISNULL(@Tel, '') != ''
SET @sWhere = 'AND S1.Tel IN (''' + @Tel + ''', ''@@@'')'

IF ISNULL(@TAccount, '') != ''
SET @sWhere = 'AND S1.TAccount IN (''' + @TAccount + ''')'

IF ISNULL(@DAccount, '') != ''
SET @sWhere = 'AND S1.DAccount IN (''' + @DAccount + ''')'

IF ISNULL(@Province, '') != ''
SET @sWhere = 'AND S1.Province LIKE (N''%' + @Province + '%'')'

-- Check Para FromDate và ToDate
-- Trường hợp search theo từ ngày đến ngày
IF @IsPeriod = 0
BEGIN
	IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + ' AND (ISNULL(S1.TAccountDate, GETDATE()) >= ''' + @FromDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (ISNULL(S1.TAccountDate, GETDATE()) <= ''' + @ToDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (ISNULL(S1.TAccountDate, GETDATE()) BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
		END
END
ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (CASE WHEN Month(S1.TAccountDate) < 10 THEN ''0'' + RTRIM(LTRIM(Month(S1.TAccountDate))) + ''/'' + LTRIM(RTRIM(Year(S1.TAccountDate)))
									ELSE RTRIM(LTRIM(Month(S1.TAccountDate))) + ''/'' + LTRIM(RTRIM(Year(S1.TAccountDate))) END) IN ( ''' + @PeriodList + ''') '
	END

SET @sSQL = N'
		SELECT ROW_NUMBER() OVER (Order BY '+@OrderBy+N') AS RowNum, COUNT(*) OVER () AS TotalRow
				  , S1.APK, S1.DivisionID, S1.TranMonth, S1.TranYear, S1.SeriNo, S1.TAccount, S1.TAccountNumber, S1.TAccountDate, S1.Enduser, S1.Tel, S1.Apartment, S1.Road
				  , S1.Ward, S1.District, S1.Province, S1.DAccount, S1. DAccountNumber, S1.DAccountDate
			FROM SOT2210 (NOLOCK) AS S1
			WHERE 1=1 '+ @sWhere +'
			ORDER BY '+@OrderBy+'
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

		PRINT (@sSQL)
		EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
