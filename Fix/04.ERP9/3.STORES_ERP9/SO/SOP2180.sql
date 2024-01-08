IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2180]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2180]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


























-- <Summary>
---- Load danh sách dữ liệu yêu cầu sản xuất
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Đình Ly, Date 18/12/2019
-- <Example>

CREATE PROCEDURE SOP2180 ( 
    @DivisionID VARCHAR(50),
	@DivisionIDList NVARCHAR(2000), 
	@IsDate TINYINT,
	@FromDate Datetime,
	@ToDate Datetime,
	@PeriodList NVARCHAR(4000),
	@VoucherNo VARCHAR(50),
	@InventoryName NVARCHAR(250),	
	@ObjectName NVARCHAR(250),	
	@InventoryTypeID VARCHAR(50),
	@UserID VARCHAR(50),
	@strWhere NVARCHAR(MAX) = NULL,
	@PageNumber INT,
	@PageSize INT		
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
        
SET @sWhere='WHERE S1.VoucherNo IS NOT NULL AND '
SET @OrderBy = ' S1.CreateDate'
		IF @IsDate = 0
			SET @sWhere = @sWhere + ' CONVERT(VARCHAR(10), S1.CreateDate, 112) BETWEEN '''+ CONVERT(VARCHAR(10),@FromDate,112) + ''' AND ''' + CONVERT(VARCHAR(10),@ToDate,112) + ''' '
		ELSE 
			SET @sWhere = @sWhere + ' (CASE WHEN MONTH(S1.CreateDate) <10 then ''0''+rtrim(ltrim(str(MONTH(S1.CreateDate))))+''/''+ltrim(Rtrim(str(YEAR(S1.CreateDate)))) 
									ELSE rtrim(ltrim(str(MONTH(S1.CreateDate))))+''/''+ltrim(Rtrim(str(YEAR(S1.CreateDate)))) END) IN ('''+@PeriodList+''')'

	--Check Para DivisionIDList null then get DivisionID 
	IF ISNULL(@DivisionIDList, '')!=''
		SET @sWhere = @sWhere + ' AND S1.DivisionID IN ('''+@DivisionIDList+''')'
	ELSE 
		SET @sWhere = @sWhere + ' AND S1.DivisionID IN ('''+@DivisionID+''')'

	IF ISNULL(@VoucherNo, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(S1.VoucherNo, '''') LIKE N''%'+@VoucherNo+'%'' '

	IF ISNULL(@InventoryName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(S1.InventoryName, '''') LIKE N''%'+@InventoryName+'%'' '
		
	IF ISNULL(@InventoryTypeID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(S1.InventoryTypeID, '''') LIKE N''%'+@InventoryTypeID+'%'' '

	IF ISNULL(@ObjectName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(S1.ObjectName, '''') LIKE N''%'+@ObjectName+'%'' '

IF ISNULL(@strWhere,'')!=''
BEGIN
	IF @strWhere LIKE '%IsNull%'
	SET @strWhere = REPLACE(@strWhere,''',''',',''''')
	IF @strWhere LIKE '%DivisionID%'
	SET @strWhere = REPLACE(@strWhere,'DivisionID','S1.DivisionID')
	SET @sWhere=@strWhere;
END

SET @sSQL = 'SELECT ROW_NUMBER() OVER (Order BY '+@OrderBy+') AS RowNum, COUNT(*) OVER () AS TotalRow
				  , S1.APK
				  , S1.VoucherNo
				  , S1.InventoryID
				  , S1.ObjectID
				  , S1.InventoryQunantity
				  , S1.Length, S1.Width, S1.Height
				  , S1.PrintedSizeNumber
				  , S1.Cost
				  , S1.UnitPrice
			FROM SOT2080 (NOLOCK) AS S1
				LEFT JOIN AT1202 A2 ON A2.ObjectID = S1.ObjectID
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
