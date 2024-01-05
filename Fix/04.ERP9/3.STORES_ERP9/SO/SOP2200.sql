IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2200]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2200]
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

CREATE PROCEDURE SOP2200 (
	@DivisionID VARCHAR(50),	-- Biến môi trường
	@DivisionIDList NVARCHAR(2000),	-- Chọn trong DropdownChecklist DivisionID
	@FromDate DATETIME,
	@ToDate DATETIME,
	@IsPeriod INT,
	@PeriodList VARCHAR(MAX),
	@AccountNo NVARCHAR(50) = N'',
	@Tel NVARCHAR(50) =N'',
	@Type NVARCHAR(50)=N'',
	@AccountType NVARCHAR(50) =N'',
	@Province NVARCHAR(50)=N'',
	@Status NVARCHAR(50) =N'',
	@PageNumber INT,
	@PageSize INT
)
AS
DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)

SET @sWhere = 'WHERE S1.AccountNo IS NOT NULL AND '
SET @OrderBy = ' S1.AccountNo DESC '
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

-- Kiểm tra DivisionIDList nếu null sẽ lấy Division hiện tại
IF ISNULL(@DivisionIDList, '') != ''
	SET @sWhere = 'AND S1.DivisionID IN (''' + @DivisionIDList + ''', ''@@@'')'
ELSE
	SET @sWhere = 'AND S1.DivisionID IN (''' + @DivisionID + ''', ''@@@'')'

IF ISNULL(@AccountNo, '') != ''
SET @sWhere = 'AND S1.AccountNo IN (''' + @AccountNo + ''', ''@@@'')'

IF ISNULL(@Tel, '') != ''
SET @sWhere = 'AND S1.Tel IN (''' + @Tel + ''', ''@@@'')'

IF ISNULL(@Type, '') != ''
SET @sWhere = 'AND S1.Type IN (''' + @Type + ''')'

IF ISNULL(@AccountType, '') != ''
SET @sWhere = 'AND S1.AccountType IN (''' + @AccountType + ''')'

IF ISNULL(@Province, '') != ''
SET @sWhere = 'AND S1.Province LIKE (N''%' + @Province + '%'')'

IF ISNULL(@Status, '') != ''
SET @sWhere = 'AND S1.Status IN (''' + @Status + ''')'

-- Check Para FromDate và ToDate
-- Trường hợp search theo từ ngày đến ngày
IF @IsPeriod = 0
BEGIN
	IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + ' AND (ISNULL(S1.AccountDate, GETDATE()) >= ''' + @FromDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (ISNULL(S1.AccountDate, GETDATE()) <= ''' + @ToDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (ISNULL(S1.AccountDate, GETDATE()) BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
		END
END
ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (CASE WHEN Month(S1.AccountDate) < 10 THEN ''0'' + RTRIM(LTRIM(Month(S1.AccountDate))) + ''/'' + LTRIM(RTRIM(Year(S1.AccountDate)))
									ELSE RTRIM(LTRIM(Month(S1.AccountDate))) + ''/'' + LTRIM(RTRIM(Year(S1.AccountDate))) END) IN ( ''' + @PeriodList + ''') '
	END

SET @sSQL = N'
		SELECT ROW_NUMBER() OVER (Order BY '+@OrderBy+N') AS RowNum, COUNT(*) OVER () AS TotalRow
				  , S1.APK
				  , S1.DivisionID
				  , S1.AccountNo
				  , S1.AccountName
				  , S1.Tel
				  , ( CASE WHEN S1.Type = ''0'' THEN N''T-Card''
					       WHEN S1.Type = ''1'' THEN N''D-Card'' 
					  END) AS Type
				  , ( CASE WHEN S1.AccountType = ''0'' THEN N''Doanh nghiệp''
					       WHEN S1.AccountType = ''1'' THEN N''Cá nhân'' 
					  END) AS AccountType
				  , S1.Address
				  , S1.Province
				  , ( CASE WHEN S1.Status = ''0'' THEN N''Hoạt động''
					       WHEN S1.Status = ''1'' THEN N''Không hoạt động'' 
					  END) AS Status
				  , S1.AccountDate
			FROM SOT2200 (NOLOCK) AS S1
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
