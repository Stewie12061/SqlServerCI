IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2100]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2100]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load danh sách tiến độ giao hàng 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Đình Ly, Date 16/11/2019
----Modified by: Hoài Bảo, Date 05/04/2022 - Cập nhật điều kiện load dữ liệu theo Ngày và Kỳ
----Modified by: Hoài Bảo, Date 13/02/2023 - Bổ sung luồng load dữ liệu từ màn hình truy vấn ngược
-- <Example>

CREATE PROCEDURE SOP2100 ( 
        @DivisionID VARCHAR(50) = '',  --Biến môi trường
		@DivisionIDList NVARCHAR(2000) = '',  --Chọn trong DropdownChecklist DivisionID	     
		@IsDate TINYINT = 0, --0: theo ngày, 1: Theo kỳ
		@FromDate DATETIME = NULL,
		@ToDate DATETIME = NULL,
		@PeriodList NVARCHAR(4000) = '', --Chọn trong DropdownChecklist Chọn kỳ
		@VoucherNo VARCHAR(50) = '',
		@SOrderID VARCHAR(50) = '',
		@ObjectName  NVARCHAR(250) = '',	
		@UserID VARCHAR(50) = '',
		@strWhere NVARCHAR(MAX) = NULL,
		@PageNumber INT = 1,
		@PageSize INT = 25,
		@RelAPK NVARCHAR(250) = '',
		@RelTable NVARCHAR(250) = ''		
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)
        
SET @sWhere='WHERE S1.VoucherNo IS NOT NULL '
SET @OrderBy = ' S1.CreateDate'
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

--IF @IsDate = 0
--	SET @sWhere = @sWhere + ' CONVERT(VARCHAR(10), S1.CreateDate, 112) BETWEEN '''+ CONVERT(VARCHAR(10),@FromDate,112) + ''' AND ''' + CONVERT(VARCHAR(10),@ToDate,112) + ''' '
--ELSE 
--	SET @sWhere = @sWhere + ' (CASE WHEN MONTH(S1.CreateDate) <10 then ''0''+rtrim(ltrim(str(MONTH(S1.CreateDate))))+''/''+ltrim(Rtrim(str(YEAR(S1.CreateDate)))) 
--							ELSE rtrim(ltrim(str(MONTH(S1.CreateDate))))+''/''+ltrim(Rtrim(str(YEAR(S1.CreateDate)))) END) IN ('''+@PeriodList+''')'

-- Check Para FromDate và ToDate
-- Trường hợp search theo từ ngày đến ngày
IF @IsDate = 0
BEGIN
	IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + ' AND (S1.CreateDate >= ''' + @FromDateText + '''
											OR S1.VoucherDate >= ''' + @FromDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (S1.CreateDate <= ''' + @ToDateText + ''' 
											OR S1.VoucherDate >= ''' + @ToDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND ((S1.CreateDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') OR (S1.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''')) '
		END
END
ELSE IF @IsDate = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(S1.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
	END

	--Check Para DivisionIDList null then get DivisionID 
	IF ISNULL(@DivisionIDList, '')!=''
		SET @sWhere = @sWhere + ' AND S1.DivisionID IN ('''+@DivisionIDList+''')'
	ELSE 
		SET @sWhere = @sWhere + ' AND S1.DivisionID IN ('''+@DivisionID+''')'

	IF ISNULL(@ObjectName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(A2.ObjectName, '''') LIKE N''%'+@ObjectName+'%'' '

	IF ISNULL(@VoucherNo, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(S1.VoucherNo, '''') LIKE N''%'+@VoucherNo+'%'' '

	IF ISNULL(@SOrderID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(O1.VoucherNo, '''') LIKE N''%'+@SOrderID+'%'' '

IF ISNULL(@strWhere,'')!=''
BEGIN
	IF @strWhere LIKE '%IsNull%'
	SET @strWhere = REPLACE(@strWhere,''',''',',''''')
	IF @strWhere LIKE '%DivisionID%'
	SET @strWhere = REPLACE(@strWhere,'DivisionID','S1.DivisionID')
	SET @sWhere=@strWhere;
END

IF (ISNULL(@RelAPK, '') != '' AND ISNULL(@RelTable, '') != '')
BEGIN
	SET @sWhere = 
	CASE
		WHEN @RelTable = 'POST0011' THEN 'INNER JOIN ' +@RelTable+ ' C1 WITH (NOLOCK) ON C1.MemberID = O1.ObjectID 
									' +@sWhere+ ' AND C1.APK = ''' +@RelAPK+ '''
									AND O1.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') '
		WHEN @RelTable = 'OT2001' THEN 'LEFT JOIN ' +@RelTable+ ' C1 WITH (NOLOCK) ON C1.SOrderID = S1.SOrderID
									' +@sWhere+ ' AND C1.APK = ''' +@RelAPK+ '''
									AND O1.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') '
		ELSE @sWhere
	END
END

SET @sSQL = 'SELECT ROW_NUMBER() OVER (Order BY '+@OrderBy+') AS RowNum, COUNT(*) OVER () AS TotalRow
				  , S1.APK
				  , S1.DivisionID
				  , S1.VoucherNo
				  , S1.VoucherDate
				  , A2.ObjectName
				  , O1.VoucherNo AS SOrderID
			FROM OT2003 S1 WITH (NOLOCK)
				LEFT JOIN AT1202 A2 WITH (NOLOCK) ON A2.ObjectID = S1.ObjectID
				LEFT JOIN OT2001 O1 WITH (NOLOCK) ON CONVERT(VARCHAR(50), O1.APK) = S1.SOrderID
			'+ @sWhere +'
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
