IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2100]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2100]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









-- <Summary>
---- Load danh sách tiến độ nhận hàng ở màn hình cập nhật
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Đình Ly, Date 25/03/2020
----Updated by: Tiến Thành, Date 26/04/2023 - [2023/04/IS/0051] - Chỉnh sửa lỗi lọc theo thời gian và đơn hàng mua
-- <Example>

CREATE PROCEDURE POP2100 ( 

    @DivisionID VARCHAR(50), 
	@DivisionIDList NVARCHAR(2000),  
	@IsDate TINYINT, 
	@FromDate Datetime,
	@ToDate Datetime,
	@PeriodList NVARCHAR(4000), 
	@VoucherNo VARCHAR(50),
	@POrderID VARCHAR(50),
	@ObjectName  NVARCHAR(250),	
	@UserID VARCHAR(50),
	@strWhere NVARCHAR(MAX) = NULL,
	@PageNumber INT,
	@PageSize INT		
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)
        
SET @sWhere='WHERE O1.VoucherNo IS NOT NULL'
SET @OrderBy = ' O1.CreateDate'
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

	-- Check filter by Period/Date
	IF @IsDate = 0
		BEGIN
			IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
				BEGIN
					SET @sWhere = @sWhere + ' AND (O1.VoucherDate >= ''' + @FromDateText + '''
													OR O1.VoucherDate >= ''' + @FromDateText + ''')'
				END
			ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
				BEGIN
					SET @sWhere = @sWhere + ' AND (O1.VoucherDate <= ''' + @ToDateText + ''' 
													OR O1.VoucherDate >= ''' + @ToDateText + ''')'
				END
			ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
				BEGIN
					SET @sWhere = @sWhere + ' AND ((O1.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') OR (O1.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''')) '
				END
		END
		ELSE IF @IsDate = 1 AND ISNULL(@PeriodList, '') != ''
			BEGIN
				SET @sWhere = @sWhere + ' AND (SELECT FORMAT(O1.VoucherDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
			END

	--Check Para DivisionIDList null then get DivisionID 
	IF ISNULL(@DivisionIDList, '')!=''
		SET @sWhere = @sWhere + ' AND O1.DivisionID IN ('''+@DivisionIDList+''')'
	ELSE 
		SET @sWhere = @sWhere + ' AND O1.DivisionID IN ('''+@DivisionID+''')'

	IF ISNULL(@ObjectName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(A2.ObjectName, '''') LIKE N''%'+@ObjectName+'%'' '

	IF ISNULL(@VoucherNo, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(O1.VoucherNo, '''') LIKE N''%'+@VoucherNo+'%'' '

	IF ISNULL(@POrderID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(O2.VoucherNo, '''') LIKE N''%'+@POrderID+'%'' '

IF ISNULL(@strWhere,'')!=''
BEGIN
	IF @strWhere LIKE '%IsNull%'
	SET @strWhere = REPLACE(@strWhere,''',''',',''''')
	IF @strWhere LIKE '%DivisionID%'
	SET @strWhere = REPLACE(@strWhere,'DivisionID','O1.DivisionID')
	SET @sWhere=@strWhere;
END

SET @sSQL = 'SELECT ROW_NUMBER() OVER (Order BY '+@OrderBy+') AS RowNum, COUNT(*) OVER () AS TotalRow
				  , O1.APK
				  , O1.DivisionID
				  , O1.VoucherNo
				  , O1.VoucherDate
				  , A2.ObjectName
				  , O2.VoucherNo AS POrderID
			FROM OT3003 O1 WITH (NOLOCK)
				LEFT JOIN AT1202 A2 WITH (NOLOCK) ON A2.ObjectID = O1.ObjectID
				LEFT JOIN OT3001 O2 WITH (NOLOCK) ON O2.POrderID = O1.POrderID
			'+ @sWhere +'
			ORDER BY '+@OrderBy+'
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

EXEC (@sSQL)

PRINT (@sSQL)









GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
