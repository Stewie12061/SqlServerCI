IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2028]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2028]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load dữ liệu màn hình kế thừa dự toán.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Kiều Nga on 25/02/2020.
----Modify by Kiều Nga on 01/07/2020: Load thông tin quy cách.
----Modify by Kiều Nga on 17/08/2020: Thêm điều kiện DeleteFlg = 0.
----Modify by Kiều Nga on 04/09/2020: Fix lỗi kế thừa địa chỉ giao hàng sang phiếu báo giá
----Modify by Đình Ly on 14/12/2020: Chỉnh sửa ColumnName do cấu trúc bảng thay đổi.
----Modify by Trọng Kiên on 04/01/2021: Format lại các cột số lượng và % hao hụt trên master theo thiết lập.
----Modify by Đình Hòa on 08/01/2021: Load thêm một số trường để hiển thị khi kế thừa.
----Modify by Đình Ly on 12/05/2021: Bổ sung điều kiện load dữ liệu theo Đối tượng nếu có truyền.
----Modify by Đình Ly on 25/05/2021: Load nhóm thuế mặc định của Mặt hàng.
----Modify by Đình Hòa	on 05/07/2021: Bổ sung load phân trang
----Modify by Văn Tài	on 09/01/2023: Xử lý CONVERT APK.
----Modify by Nhật Quang	on 07/02/2023: Bố sung Customize HIPC 
----Modify by Viết Toàn on 21/07/2023: Bổ sung lấy thêm số lượng của yêu cầu khách hàng - MAITHU
-- <Example>
---- 
/*-- <Example>
----*/

CREATE PROCEDURE SOP2028
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList NVARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,	
     @IsDate TINYINT, --0:Datetime; 1:Period
	 @Periods NVARCHAR(MAX),
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @VoucherNo VARCHAR(50),
	 @ObjectName NVARCHAR(250),
	 @InventoryName NVARCHAR(250),
	 @InventoryTypeID NVARCHAR(250),
	 @DeliveryAddress NVARCHAR(250) NULL
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',
		@sWhere NVARCHAR(MAX) = N'',
		@FormatQuantity INT = 0,
		@FormatPercent INT = 0,
		@sSQL1 NVARCHAR(MAX) = N'',
		@sDes1 NVARCHAR(MAX) = N'',
		@sDes2 NVARCHAR(MAX) = N'',
		@sSQL2 NVARCHAR(MAX) = N'',
		@TotalRow VARCHAR(50) ='',
		@sQuery AS NVARCHAR(MAX)='',
		@sJoin NVARCHAR(MAX) = N''

DECLARE @CustomerName INT = (SELECT TOP 1 CustomerIndex.CustomerName FROM CustomerIndex)

IF @PageNumber = 1 SET @TotalRow = ' COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
SET @sDes1 = N'Kế thừa từ số dự toán: '
SET @sDes2 = N'và ngày dự toán: '
SET @FormatQuantity = (SELECT QuantityDecimals FROM AT1101 WITH (NOLOCK) WHERE DivisionID = ''+ @DivisionID +'')
SET @FormatPercent = (SELECT PercentDecimal FROM AT1101 WITH (NOLOCK) WHERE DivisionID = ''+ @DivisionID +'')

SET @sQuery = ''

IF @CustomerName = 158 -- Customize cho HIPC
	BEGIN
	SET @sQuery = '
		,CRMT2110.PriceListID
		,CRMT2111.TotalProfitCost
		,CRMT2111.TotalAmount
		,CRMT2111.ScrapPercent
		,CRMT2111.ScrapAdjustment
		,CRMT2111.SetupTimeBase
		,CRMT2111.UpPercent
		,CRMT2111.DutyPercent
		,CRMT2111.Fee
		,CRMT2111.PercentAdjustment
		,CRMT2111.SetupTime500
		,CRMT2111.SetupTimePercent
		,CRMT2111.TotalSellingPrice
		,CRMT2111.TotalCostDutyPercent
		,CRMT2111.TotalDutyPercent
		,CRMT2111.TotalDuty
		,CRMT2111.Duty
		,CRMT2111.TotalShipping
		,CRMT2111.ShippingFee
		,CRMT2111.BoxSize
		,CRMT2111.TotalAdjustmentPercent
		,CRMT2111.AdjustmentPercent
		,CRMT2111.TotalAdjustment
		,CRMT2111.TotalSetupTime
		,CRMT2110.OriginalQuantityProduct
		, CRMT2110.DeliveryAddressName AS DeliveryAddress
		'
	END

IF @CustomerName = 117 -- Customize cho MAITHU
BEGIN
	SET @sQuery = '
		, CRMT2111.TotalAmount
		, CT01.ActualQuantity AS ActualQuantityMT
	'

	SET @sJoin = N'
		LEFT JOIN CRMT2100 CT00 WITH (NOLOCK) ON CT00.APK = CRMT2111.APKMInherited
		LEFT JOIN CRMT2101 CT01 WITH (NOLOCK) ON CT01.APKMaster = CT00.APK
	'
END

SET @sWhere = @sWhere + N' CRMT2110.DivisionID  ='''+@DivisionID+''' AND CRMT2110.DeleteFlg = 0 '

IF ISNULL(@VoucherNo,'') <> ''
	SET @sWhere = @sWhere + N'AND CRMT2110.VoucherNo LIKE ''%' +@VoucherNo+'%'''

IF ISNULL(@ObjectName,'') <> ''
	SET @sWhere = @sWhere + N'AND (CRMT2110.ObjectID LIKE N''%' +@ObjectName+'%'' OR AT1202.ObjectName LIKE N''%' +@ObjectName+'%'')'

IF ISNULL(@InventoryName,'') <> ''
	SET @sWhere = @sWhere + N'AND (CRMT2110.InventoryID LIKE N''%' +@InventoryName+'%'' OR AT1302.InventoryName LIKE N''%' +@InventoryName+'%'')'

IF ISNULL(@InventoryTypeID,'') <> ''
	SET @sWhere = @sWhere + N'AND CRMT2111.PaperTypeID LIKE N''%' +@InventoryTypeID+'%'''

IF ISNULL(@DeliveryAddress,'') <> ''
	SET @sWhere = @sWhere + N'AND CRMT2110.DeliveryAddressName LIKE N''%' +@DeliveryAddress+'%'''

IF @IsDate = 0 
	SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10), CRMT2110.VoucherDate,112) BETWEEN '+CONVERT(VARCHAR(10),@FromDate,112)+' AND '+CONVERT(VARCHAR(10),@ToDate,112)+' '
	
ELSE 
	SET @sWhere = @sWhere + ' AND (CASE WHEN CRMT2110.TranMonth <10 then ''0''+rtrim(ltrim(str(CRMT2110.TranMonth)))+''/''+ltrim(Rtrim(str(CRMT2110.TranYear))) 
								ELSE rtrim(ltrim(str(CRMT2110.TranMonth)))+''/''+ltrim(Rtrim(str(CRMT2110.TranYear))) END) IN ('''+@Periods+''')'

--Xử lý duyệt
SET @sWhere = @sWhere + ' AND ISNULL(CRMT2110.Status,0) = 1 '


SET @sSQL = @sSQL + N'SELECT ROW_NUMBER() OVER (ORDER BY CRMT2110.VoucherDate DESC, CRMT2110.VoucherNo) AS RowNum
						, COUNT(*) OVER () As TotalRow
						, CRMT2110.APK
					    , CRMT2110.DivisionID
					    , CRMT2110.VoucherTypeID
					    , CRMT2110.VoucherDate
					    , CRMT2110.VoucherNo
					    , CRMT2110.InventoryID
						, CRMT2110.SemiProduct AS SemiProductID
						, A02.InventoryName AS SemiProductName
					    , AT1302.InventoryName
					    , CRMT2110.ObjectID
					    , AT1202.ObjectName
					    , CRMT2110.DeliveryAddressName
					    , CRMT2110.DeliveryTime
					    , CRMT2111.APKMInherited
					    , CRMT2111.APKDInherited
					    , CRMT2111.PaperTypeID
						, CRMT2111.Include, CRMT2111.MTSignedSampleDate, CRMT2111.ContentSampleDate, CRMT2111.ColorSampleDate
					    , CONVERT(DECIMAL(28,'+LTRIM(STR(@FormatQuantity))+'), CRMT2111.OffsetQuantity) AS OffsetQuantity
						, AT1302.UnitID, A4.UnitName
					    , CRMT0099.Description AS PaperTypeName
					    , CONVERT(DECIMAL(28,'+LTRIM(STR(@FormatQuantity))+'), CRMT2111.ActualQuantity) AS ActualQuantity
						, CRMT2111.Length, CRMT2111.Width, CRMT2111.Height
					    , CRMT2111.PrintNumber, CRMT2111.SideColor1, CRMT2111.ColorPrint01, CRMT2111.SideColor2, CRMT2111.ColorPrint02
					    , CRMT2111.FilmDate, CRMT2111.FilmStatus, CRMT2111.FileName
						, CRMT2111.ActualQuantity as Quantity, CRMT2111.InvenUnitPrice AS UnitPrice
					    , CASE WHEN CRMT2111.FilmStatus = ''0'' THEN N''Cũ'' WHEN CRMT2111.FilmStatus = ''1'' THEN N''Mới'' ELSE '''' END AS FilmStatusName	 
					    , CRMT2111.PrintTypeID, CONVERT(DECIMAL(28,'+LTRIM(STR(@FormatQuantity))+'), CRMT2111.AmountLoss) AS AmountLoss
						, CONVERT(DECIMAL(28,'+LTRIM(STR(@FormatPercent))+'), CRMT2111.PercentLoss) AS PercentLoss, CRMT2111.Notes
					    , CRMT2111.TotalVariableFee,CRMT2111.PercentCost,CRMT2111.Cost,CRMT2111.PercentProfit
					    , CRMT2111.Profit,CRMT2111.InvenUnitPrice,CRMT2111.SquareMetersPrice,CRMT2111.ExchangeRate,CRMT2111.CurrencyID
					    , T3.UserName AS CreateUserID, CRMT2110.CreateDate, T4.UserName AS LastModifyUserID, CRMT2110.LastModifyDate, CRMT2110.APKMASter_9000
						, CONVERT(DECIMAL(28,'+LTRIM(STR(@FormatQuantity))+'), CRMT2111.FileLength) AS FileLength
						, CONVERT(DECIMAL(28,'+LTRIM(STR(@FormatQuantity))+'), CRMT2111.FileWidth) AS FileWidth
						, CONVERT(DECIMAL(28,'+LTRIM(STR(@FormatQuantity))+'), CRMT2111.FileSum) AS FileSum, CRMT2111.FileUnitID
						, AT1202.Address, AT1202.Tel, P.DeliveryAddress AS DeAddress, CONCAT(N'''+@sDes1 +''', CRMT2110.VoucherNo, '' '', N''' +@sDes2 +''',CONVERT(VARCHAR(50),CRMT2110.VoucherDate,103)) AS Description
						, AT10.VATGroupName AS VATGroupID, AT10.VATRate AS VATPercent
						'+@sQuery+'
				FROM CRMT2110 WITH (NOLOCK)
					LEFT JOIN CRMT2111 WITH (NOLOCK) ON CRMT2110.APK = CRMT2111.APKMASter
					LEFT JOIN AT1302 WITH (NOLOCK) ON CRMT2110.InventoryID = AT1302.InventoryID AND AT1302.DivisionID IN (''@@@'',CRMT2110.DivisionID)
					LEFT JOIN AT1010 AT10 WITH (NOLOCK) ON AT10.VATGroupID = AT1302.VATGroupID
					LEFT JOIN CRMT0099 WITH (NOLOCK) ON CRMT0099.CodeMaster like ''%CRMT00000022%'' AND ISNULL(CRMT0099.Disabled, 0)= 0 AND CRMT0099.ID = CRMT2111.PaperTypeID
					LEFT JOIN AT1202 WITH (NOLOCK) ON CRMT2110.ObjectID = AT1202.ObjectID AND AT1202.DivisionID IN (''@@@'',CRMT2110.DivisionID)
					LEFT JOIN AT1405 T3 WITH (NOLOCK) ON CRMT2110.CreateUserID = T3.UserID AND CRMT2110.DivisionID = T3.DivisionID
					LEFT JOIN AT1405 T4 WITH (NOLOCK) ON CRMT2110.LAStModifyUserID = T4.UserID AND CRMT2110.DivisionID = T4.DivisionID
					LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON CRMT2110.APKMASter_9000 = OOT90.APK
					LEFT JOIN AT1302 A02 WITH (NOLOCK) ON CRMT2110.SemiProduct = A02.InventoryID AND A02.DivisionID IN (''@@@'', CRMT2110.DivisionID)
					LEFT JOIN AT1304 A4 WITH (NOLOCK) ON A4.UnitID = AT1302.UnitID AND A4.Disabled = 0'
					+ @sJoin

SET @sSQL1 ='LEFT JOIN (SELECT * FROM
						(SELECT ROW_NUMBER() OVER (PARTITION BY A.MemberID ORDER BY A.MemberID DESC) as t, A.MemberID
							, CASE WHEN ISNULL(C.DeliveryAddress,'''') != '''' THEN C.DeliveryAddress ELSE '''' END  
							+ CASE WHEN ISNULL(A4.DistrictName,'''')  != '''' THEN CONCAT('', '',A4.DistrictName) ELSE '''' END
							+ CASE WHEN ISNULL(A2.CityName,'''') != '''' THEN CONCAT('', '',A2.CityName) ELSE '''' END AS DeliveryAddress
						FROM CRMT101011 C With (NOLOCK)    
							LEFT JOIN AT1001 A1 WITH(NOLOCK) ON C.DeliveryCountryID = A1.CountryID   
							INNER JOIN (select * from POST0011 With (NOLOCK) where DivisionID = '''+@DivisionID+''' ) as A ON CONVERT(VARCHAR(50), A.APK) = CONVERT(VARCHAR(50), C.APKMaster)
							LEFT JOIN AT1002 A2 WITH(NOLOCK) ON C.DeliveryCityID = A2.CityID  AND (C.DivisionID = A1.DivisionID OR C.DivisionID = ''@@@'') AND A1.Disabled = 0   
							LEFT JOIN AT1003 A3 WITH(NOLOCK) ON C.DeliveryPostalCode = A3.AreaID  AND (C.DivisionID = A1.DivisionID OR C.DivisionID = ''@@@'') AND A1.Disabled = 0   
							LEFT JOIN AT1013 A4 WITH(NOLOCK) ON C.DeliveryDistrictID = A4.DistrictID          
						AND (C.DivisionID = A1.DivisionID OR C.DivisionID = ''@@@'') AND A1.Disabled = 0  where  C.DivisionID = '''+@DivisionID+''') B
						WHERE B.t = 1) P ON P.MemberID = AT1202.ObjectID
				WHERE '+@sWhere 

SET @sSQL2 = N'ORDER BY CRMT2110.VoucherDate DESC, CRMT2110.VoucherNo
			  OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			  FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

EXEC (@sSQL + @sSQL1 + @sSQL2)
PRINT @sSQL 
PRINT @sSQL1
PRINT @sSQL2



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
