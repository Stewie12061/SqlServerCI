IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP2110]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP2110]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---		Load màn hình Danh mục dự toán (CRMF2110)
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Kiều Nga, Date: 05/02/2020
--- Modified by :  Đình Hòa, Date: 17/06/2021 : Bổ sung lọc theo kỳ
--- Modified by: Kiều Nga Date: 18/10/2022 : Lấy thêm cột TotalProfitCost,TotalAmount
--- Modified by: Nhật Quang Date: 09/02/2023 : Bổ sung Customize HIPC
--- Modified by: Nhật Quang Date: 17/02/2023 : Bổ sung thêm địa chỉ giao hàng vào điều kiện lọc
--- Modified by: Nhật Quang Date: 20/03/2023 : Bổ sung select trường ghi chú ( Notes)
--- Modified by: Trọng Phúc Date: 12/07/2023 : Bổ sung lọc theo ghi chú
--- Modified by: Viết Toàn Date: 11/08/2023 : Bổ sung lọc theo bán thành phẩm - MAITHU
/* <Example>
EXEC CRMP2110 @DivisionID=N'MTH',@DivisionIDList=N'',
	@FromDate='2020-01-06 00:00:00',@ToDate='2020-01-06 00:00:00',
	@PeriodIDList=N'',@VoucherNo=N'',@ObjectID=N'',@InventoryID=N'',@UnitPrice=N'',
	@PageNumber=1,@PageSize=25,@SearchWhere=N''
*/
 CREATE PROCEDURE CRMP2110
(
 	@DivisionID VARCHAR(50),
    @DivisionIDList NVARCHAR(2000),
    @PageNumber INT,
    @PageSize INT,
	@IsPeriod TINYINT, -- 1:Datetime; 0:Period
    @FromDate DATETIME,
    @ToDate DATETIME,
	@PeriodIDList NVARCHAR(MAX),
	@VoucherNo NVARCHAR(50),
	@InventoryID NVARCHAR(250),
	@UnitPrice NVARCHAR(250),
	@Status NVARCHAR(250) ='',
	@ObjectID NVARCHAR(250)='',
	@DeliveryAddress NVARCHAR(250)='',
	@Notes NVARCHAR(250)='',
	@SearchWhere NVARCHAR(MAX) = NULL, --- # NULL: Lọc nâng cao; = NULL: Lọc thường
	@SemiProductName NVARCHAR(250) = ''
)
AS
DECLARE @sSQL01 NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
		@TotalRow NVARCHAR(50) = N'',
		@sQuery AS NVARCHAR(MAX)=''

DECLARE @CustomerName INT = (SELECT TOP 1 CustomerIndex.CustomerName FROM CustomerIndex)

		IF  @PageNumber = 1 
			SET @TotalRow = 'COUNT(*) OVER ()' 
		ELSE 
			SET @TotalRow = 'NULL'
      	SET @sWhere = ' 1 = 1 '
	    SET @OrderBy = 'CreateDate DESC'

		SET @sQuery = ''

IF @CustomerName = 158 -- Customize cho HIPC
	BEGIN
	SET @sQuery = '
		,T2.ScrapPercent
		,T2.ScrapAdjustment
		,T2.SetupTimeBase
		,T2.UpPercent
		,T2.DutyPercent
		,T2.Fee
		,T2.PercentAdjustment
		,T2.SetupTime500
		,T2.SetupTimePercent
		,T2.TotalSellingPrice
		,T2.TotalCostDutyPercent
		,T2.TotalDutyPercent
		,T2.TotalDuty
		,T2.Duty
		,T2.TotalShipping
		,T2.ShippingFee
		,T2.BoxSize
		,T2.TotalAdjustmentPercent
		,T2.AdjustmentPercent
		,T2.TotalAdjustment
		,T2.Notes
		,T1.OriginalQuantityProduct
		'
	END

IF @CustomerName = 117
	SET @sQuery = N', T5.InventoryName AS SemiProductName'

IF ISNULL(@SearchWhere, '') = '' --Lọc thường
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

		IF ISNULL(@Notes, '') != ''
			SET @sWhere = @sWhere + ' 
		AND ISNULL(T2.Notes, '''') LIKE N''%' + @Notes + '%'' '

		IF ISNULL(@InventoryID, '') != ''
			SET @sWhere = @sWhere + ' 
		AND ( ISNULL(T1.InventoryID, '''') LIKE N''%' + @InventoryID + '%'' OR  ISNULL(T4.InventoryName, '''') LIKE N''%' + @InventoryID + '%'' ) '

		IF ISNULL(@ObjectID, '') != ''
			SET @sWhere = @sWhere + ' 
		AND ( ISNULL(T1.ObjectID, '''') LIKE N''%' + @ObjectID + '%'' OR  ISNULL(T3.ObjectName, '''') LIKE N''%' + @ObjectID + '%'' ) '

		IF ISNULL(@DeliveryAddress, '') != ''
			SET @sWhere = @sWhere + ' 
		AND ( ISNULL(T1.DeliveryAddressName, '''') LIKE N''%' + @DeliveryAddress + '%'' OR  ISNULL(T3.Address, '''') LIKE N''%' + @DeliveryAddress + '%'' ) '

		IF ISNULL(@UnitPrice, '') != ''
		SET @sWhere = @sWhere + ' 
		AND ISNULL(T2.InvenUnitPrice, 0) = ' + @UnitPrice + ''

		-- Nếu giá trị NULL thì set về rỗng
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

		IF ISNULL(@SemiProductName, '') <> ''
			SET @sWhere = @sWhere + N' AND ISNULL(T5.InventoryID, '''') LIKE N''%' + @SemiProductName + '%'' OR ISNULL(T5.InventoryName, '''') LIKE N''%' + @SemiProductName + '%''  '
	END

--Lấy Distinct
SET @sSQL01 = N'	
	SELECT DISTINCT T1.APK
		, T1.DivisionID
		, T1.VoucherNo
		, T1.VoucherDate
		, T1.ObjectID
		, T3.ObjectName
		, T2.TotalVariableFee
		, T2.Cost, T2.Profit
		, T2.TotalProfitCost
		, T2.TotalAmount
		, T1.InventoryID
		, T4.InventoryName 
		, T2.InvenUnitPrice as UnitPrice
		, C99.Description AS PaperTypeID, T2.ActualQuantity
		, T1.CreateDate, B.Description as StatusName 
		'+@sQuery+'
		Into #CRMP2110
	FROM CRMT2110 T1 WITH (NOLOCK) 
		LEFT JOIN CRMT2111 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster
		LEFT JOIN AT1202 T3 WITH (NOLOCK) ON T1.ObjectID = T3.ObjectID AND T3.DivisionID IN (''@@@'',T1.DivisionID)
		LEFT JOIN AT1302 T4 WITH (NOLOCK) ON T1.InventoryID = T4.InventoryID AND T4.DivisionID IN (''@@@'',T1.DivisionID)
		LEFT JOIN AT1302 T5 WITH (NOLOCK) ON T1.SemiProduct = T5.InventoryID AND T5.DivisionID IN (''@@'', T1.DivisionID)
		LEFT JOIN CRMT0099 C99 WITH (NOLOCK) ON C99.CodeMaster = ''CRMT00000022'' AND ISNULL(C99.Disabled, 0)= 0 AND C99.ID = T2.PaperTypeID
		LEFT JOIN OOT0099 B With (NOLOCK) on isnull(T1.Status,0) = B.ID and B.CodeMaster = ''Status'' and B.Disabled = 0 AND T1.DeleteFlg = 0 
		WHERE ' + @sWhere + ' AND T1.DeleteFlg = 0 

	SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, ' + @TotalRow + ' AS TotalRow,*
	FROM #CRMP2110 	' + @SearchWhere + '
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
