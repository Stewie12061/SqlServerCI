IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2080]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2080]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load dữ liệu Thông tin sản xuất.
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Đình Ly, Date: 05/12/2019
--- Modified by :  Đình Hòa, Date: 17/06/2021 : Bổ sung lọc theo kỳ
--- Modified on ... by ...:

 CREATE PROCEDURE SOP2080
(
 	@DivisionID VARCHAR(50),
    @DivisionIDList NVARCHAR(2000),
    @PageNumber INT,
    @PageSize INT,
    @FromDate DATETIME,
    @ToDate DATETIME,
	@IsPeriod TINYINT, -- 1:Datetime; 0:Period
	@PeriodIDList NVARCHAR(MAX),
	@VoucherNo NVARCHAR(50),
	@InventoryID NVARCHAR(250),
	@UnitPrice NVARCHAR(250),
	@Status NVARCHAR(250) ='',
	@ObjectID NVARCHAR(250)='',
	@SearchWhere NVARCHAR(MAX) = NULL
)
AS
DECLARE @sSQL01 NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
		@TotalRow NVARCHAR(50) = N''

		IF  @PageNumber = 1 
			SET @TotalRow = 'COUNT(*) OVER ()' 
		ELSE 
			SET @TotalRow = 'NULL'
      	SET @sWhere = ' 1 = 1 '
	    SET @OrderBy = 'CreateDate DESC'

IF ISNULL(@SearchWhere, '') = ''
	BEGIN
		-- Nếu DivisionIDList bằng rỗng thì lấy DivisionID 
		IF ISNULL(@DivisionIDList, '') != '' 
			SET @sWhere = @sWhere + '
		AND T1.DivisionID IN (''' + @DivisionIDList + ''')'
		ELSE 
			SET @sWhere = @sWhere + '
		AND T1.DivisionID IN (''' + @DivisionID + ''')'

		IF ISNULL(@VoucherNo, '') != ''
			SET @sWhere = @sWhere + ' 
		AND ISNULL(T1.VoucherNo, '''') LIKE N''%' + @VoucherNo + '%'' '

		IF ISNULL(@InventoryID, '') != ''
			SET @sWhere = @sWhere + ' 
		AND ( ISNULL(T1.InventoryID, '''') LIKE N''%' + @InventoryID + '%'' OR  ISNULL(T4.InventoryName, '''') LIKE N''%' + @InventoryID + '%'' ) '

		IF ISNULL(@ObjectID, '') != ''
			SET @sWhere = @sWhere + ' 
		AND ( ISNULL(T1.ObjectID, '''') LIKE N''%' + @ObjectID + '%'' OR  ISNULL(T3.ObjectName, '''') LIKE N''%' + @ObjectID + '%'' ) '

		IF ISNULL(@UnitPrice, '') != ''
		SET @sWhere = @sWhere + ' 
		AND ISNULL(T2.InvenUnitPrice, 0) = ' + @UnitPrice + ''

		-- Nếu giá trị NULL thì set về rỗng.
		SET @SearchWhere = ISNULL(@SearchWhere, '')

		IF Isnull(@Status,'') !='' 
		SET @sWhere = @sWhere + ' AND ISNULL(T1.Status, '''') = N'''+@Status+''' '

		IF @IsPeriod = 0
			SET @sWhere = @sWhere + ' 
		AND CONVERT(VARCHAR(10),T1.VoucherDate,112) 
			BETWEEN ' + CONVERT(VARCHAR(10), @FromDate, 112) + ' AND ' + CONVERT(VARCHAR(10), @ToDate, 112) + ' '
		IF @IsPeriod = 1
			SET @sWhere = @sWhere + ' 
		AND 
			(
				CASE WHEN MONTH(T1.VoucherDate) < 10 THEN ''0'' 
					+ RTRIM(LTRIM(STR(MONTH(T1.VoucherDate)))) + ''/'' 
					+ LTRIM(RTRIM(STR(YEAR(T1.VoucherDate)))) 
				ELSE RTRIM(LTRIM(STR(MONTH(T1.VoucherDate))))+''/'' 
					+ LTRIM(RTRIM(STR(YEAR(T1.VoucherDate)))) END
			) IN (''' + @PeriodIDList + ''')'
	END

--Lấy Distinct
SET @sSQL01 = N'	
	SELECT DISTINCT T1.APK
		, T1.DivisionID
		, T1.VoucherNo
		, T1.VoucherDate
		, T1.ObjectID
		, T3.ObjectName
		, T1.CreateDate
		, T4.InventoryName AS InventoryID
		, T1.DeliveryTime, T1.DeliveryAddressName
		, C99.Description AS PaperTypeID
		, T1.ActualQuantity
		, B.Description AS StatusName 
	INTO #SOP2080
	FROM SOT2080 T1 WITH (NOLOCK) 
		LEFT JOIN AT1202 T3 WITH (NOLOCK) ON T1.ObjectID = T3.ObjectID AND T3.DivisionID IN (''@@@'',T1.DivisionID)
		LEFT JOIN AT1302 T4 WITH (NOLOCK) ON T1.InventoryID = T4.InventoryID AND T4.DivisionID IN (''@@@'',T1.DivisionID)
		LEFT JOIN OOT0099 B With (NOLOCK) on isnull(T1.Status,0) = B.ID and B.CodeMaster = ''Status'' and B.Disabled = 0
		LEFT JOIN CRMT0099 C99 WITH (NOLOCK) ON C99.CodeMaster = ''CRMT00000022'' AND ISNULL(C99.Disabled, 0)= 0 AND C99.ID = T1.PaperTypeID
	WHERE ' + @sWhere + ' AND T1.DeleteFlg = 0 

	SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, ' + @TotalRow + ' AS TotalRow,*
	FROM #SOP2080 	' + @SearchWhere + '
	ORDER BY ' + @OrderBy + '
	OFFSET ' + STR((@PageNumber-1) * @PageSize) + ' ROWS
	FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '

EXEC (@sSQL01)
PRINT @sSQL01



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
