IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP1302]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP1302]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Lay gia ban cua mat hang cho man hinh lap don hang ban - QUAN LY GIA
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 18/08/2005 by Vo Thanh Huong
---- Modified on 24/06/2009,03/09/2009 by Thuy Tuyen
---- Modified on 03/08/2010 by Thanh Trẫm
---- Modified on 15/09/2011 by Nguyễn Bình Minh
------ 1. Sửa lỗi lấy tùy chọn và dữ liệu bảng giá không theo đơn vị
------ 2. Bổ sung lấy thêm mã bảng giá để dùng đổ dữ liệu combo bảng giá
---- Modified on 16/02/2012 by Lê Thị Thu Hiền : Bổ sung CurrencyID
---- Modified on 28/05/2012 by Lê Thị Thu Hiền : Load bảng giá theo bậc thang
---- Modified on 06/06/2012 by Bao Anh: Lay thong tin QL gia trong truong hop mat hang nhieu DVT
---- Modified on 25/06/2012 by Bao Anh: Sua cach lay SalePrice khi dung DVT quy doi
---- Modified on 26/06/2012 by Bao Anh: Gan SalePrice = 0 khi gia tri NULL
---- Modified on 27/06/2012 by Bao Anh: Sua loi khi cau SQL tao view vuot qua 4000 ky tu
---- Modified on 16/01/2013 by Lê Thị Thu Hiền : Bổ sung thêm DiscountAmount1->10
---- Modified on 06/02/2013 by Lê Thị Thu Hiền : Bổ sung ISNULL(BaseCurrencyID,0)
---- Modified on 14/10/2015 by Nguyễn Thanh Thịnh : Bổ sung thêm trường đơn giá theo số lượng
---- Modified on 20/01/2016 by Tiểu Mai: Bổ sung cột IsPlanPrice
---- Modified on 16/02/2016 by Tiểu Mai: Revert về version cũ, fix lỗi ko lấy được dữ liệu cho Angel
---- Modified on 20/10/2016 by Hải Long: Sửa AV1004.ExchangeRate thành ISNULL(AV1004.ExchangeRate, 1)
---- Modified on 28/11/2016 by Phương Thảo: Cải tiến tốc độ
---- Modified on 07/12/2016 by Phương Thảo: Bổ sung thêm thông tin thuế
---- Modified on 26/12/2016 by Bảo Thy: fix lỗi view OV1302 (thay #TAM bẳng bảng OV1302)
---- Modified on 05/05/2017 by Thị Phượng: fix lỗi lấy trùng trường NRTClassifyID 2 lần và trường SETID
---- Modified on 10/05/2017 by Phương Thảo: Customize Dong Duong phan lay gia
---- Modified on 12/05/2017 by Tiểu Mai: Bổ sung chỉnh sửa danh mục dùng chung
---- Modified on 09/06/2017 by Bảo Thy: Bổ sung IsPriceID phân biệt những mặt hàng có trong bảng giá => ko cho sửa (GODREJ)
---- Modified on 27/09/2017 by Hải Long: Sửa lỗi store do thiêu AddCost01 -> AddCost15
---- Modified on 2018/05/04 by Phát Danh: Sửa lỗi trùng dữ liệu trường hợp nhiều Division thiết lập định dạng số lẻ khác nhau
---- Modified on 14/01/2019 by Kim Thư: Bổ sung WITH (NOLOCK) 
---- Modified on 28/02/2019 by Kim Thư: Store trả thẳng dữ liệu ko qua view 
---- Modified on 14/03/2019 by Kim Thư: Tạo bảng tạm thay cho OV1302 - cải thiện tốc độ
---- Modified on 02/05/2019 by Kim Thư: Sửa lỗi collate
---- Modified on 20/05/2019 by Kim Thư: Sửa UnitID của bảng tạm kiểu NVARCHAR(50) do có DB UnitID tiếng việt
---- Modified on 27/05/2019 by Kim Thư: Lấy mã tham chiếu của mặt hàng làm cột Ghi chú 1 (CustomizeIndex = 74 - Godrej)
---- Modified on 2020/04/09 by Huỳnh Thử: Thiết lập bảng giá sau thuế (CustomerIndex = 44 SaVi)
---- Modified on 2020/07/27 by Huỳnh Thử: Bỏ điều kiện sau thuế (CustomerIndex = 44 SaVi)
---- Modified on 2020/08/07 by Văn Tài: [SAVI] Bổ sung điều kiện không có bảng giá sẽ chạy theo chuẩn.
---- Modified on 2020/09/09 by Lê Hoàng: Bổ sung @TypeID phân biệt Mua và Bán khi không có bảng giá truyền vào
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Trọng Kiên on 02/11/2020: Fix lỗi tạo cột Specification có độ dài không trùng với cột bảng chính AT1302
---- Modified by Thành Sang on 30/09/2022: Thêm tính năng Load mặt hàng theo nhóm hàng
---- Modified by Văn Tài	on 10/11/2022: Loại bỏ phần rem chạy store.
---- Modified by Văn Tài	on 11/11/2022: Điều chỉnh DivisionID và xử lý Dùng chung.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified by Nhựt Trường on 29/03/2023: [2023/03/TA/0121] - Bourbon : Chỉnh lại bảng giá thuê kho,đơn hàng bán lấy dữ liệu từ mã phân tích nghiệp vụ thay vì mặt hàng trong danh mục mặt hàng.
-- <Example>
--- EXEC OP1302 'mp', '%', '05-05-2012', '0', 'VND'

CREATE PROCEDURE [dbo].[OP1302]
(
    @DivisionID NVARCHAR(50),
    @ObjectID NVARCHAR(50),
    @VoucherDate DATETIME,
    @PriceListID NVARCHAR(50) = '',
    @CurrencyID NVARCHAR(50) = '',
	@TypeID TINYINT = 0 --0 : Bán; 1 : Mua
) 
AS
DECLARE 
    @sSQL NVARCHAR(max),
    @OTypeID NVARCHAR(50),
    @ID_Price NVARCHAR(50),
    @ID_Quantity NVARCHAR(50),
    @IsQuantityControl TINYINT,
    @IsPriceControl TINYINT,
    @IsConvertedPrice TINYINT,
    @OriginalCurrencyID TINYINT,
    @ExchangeRate DECIMAL(28,8),
    @BaseCurrencyID NVARCHAR(50),
    @Operator TINYINT,
    @IsConvertedUnit AS TINYINT,
	@sSQL01 NVARCHAR(max),
	@sSQL02 NVARCHAR(max),
	@sSQL03 NVARCHAR(max),
    @sSQL1 NVARCHAR(max),
    @sSQL2 NVARCHAR(max),
    @sSQL3 NVARCHAR(max),
    @sJOIN NVARCHAR(max) = '',
	@CustomerIndex int,
	@ISInventoryToPrice AS TINYINT,
	@IsTaxIncluded AS TINYINT,
	@IsPriceGroup AS TINYINT

SET @sSQL = ''
SET @sSQL1 = ''
SET @sSQL2 = ''
SET @BaseCurrencyID = (SELECT TOP 1 ISNULL(BaseCurrencyID,0) FROM AV1004 WITH(NOLOCK) WHERE DivisionID IN ( @DivisionID, '@@@'))
SET @IsConvertedUnit = (SELECT TOP 1 ISNULL(IsConvertUnit,0) AS IsConvertUnit FROM OT0000 WITH (NOLOCK) WHERE DivisionID = @DivisionID)

SELECT @IsPriceGroup = (CASE WHEN EXISTS (SELECT 1  
                          FROM CT0152
                          WHERE CT0152.ID = @PriceListID) THEN  1 ELSE 0 END)

DECLARE @CustomerName INT
SET @CustomerName = (SELECT TOP 1 CustomerName FROM CustomerIndex)

--IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OV1302]') AND  OBJECTPROPERTY(ID, N'IsView') = 1)			
--DROP VIEW [DBO].[OV1302]

--IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OV1302]') AND  OBJECTPROPERTY(ID, N'IsTable') = 1)			
--DROP TABLE [DBO].[OV1302]

----------->>> Thiết lập bảng giá
--SELECT @OriginalCurrencyID = CurrencyID,
-- @IsConvertedPrice = IsConvertedPrice 
--FROM OT1301
--WHERE DivisionID = @DivisionID
-- AND ID = @PriceListID
----------<<< 
--SET @ExchangeRate = 1
--SET @Operator = 1

--IF @IsConvertedPrice = 1 AND @OriginalCurrencyID = @BaseCurrencyID
--SELECT @ExchangeRate = ExchangeRate ,
-- @Operator = Operator
--FROM AV1004 
--WHERE CurrencyID = @OriginalCurrencyID AND DivisionID = @DivisionID

--TypeQuantityControl 0: Khong
--1 Toi thieu
--2 Toi da
--3 Toi thieu va toi da 

--TypePriceControl 0: Khong
--1 Toi thieu
--2 Toi da
--3 Toi thieu va toi da 

SET @VoucherDate = DATEADD(dd, DATEDIFF(dd, 0, @VoucherDate), 1)
SELECT TOP 1 @CustomerIndex = CustomerName From CustomerIndex
SELECT TOP 1 @ISInventoryToPrice =  ISNULL(ISInventoryToPrice,0), @IsTaxIncluded = ISNULL(IsTaxIncluded,0) FROM OT1301 WITH (NOLOCK) 
                                    WHERE @VoucherDate BETWEEN FromDate AND CASE WHEN ToDate = '01/01/1900' THEN '12/30/9999' ELSE ToDate END
								    AND ID = @PriceListID
SELECT @OTypeID = OPriceTypeID + 'ID',
	   @IsPriceControl = ISNULL(IsPriceControl, 0),
	   @IsQuantityControl = ISNULL(IsQuantityControl,0)
FROM OT0000 WITH (NOLOCK) 
WHERE DivisionID = @DivisionID

IF(@IsPriceGroup = 1 AND @CustomerName <> 38 )
BEGIN
	SET @sJOIN = N'INNER JOIN CT0153 WITH (NOLOCK) ON CT0153.InventoryID = AT1302.InventoryID AND CT0153.ID = ''' + ISNULL(@ID_Price, '') + ''' '
END
ELSE IF (@IsPriceGroup = 1 AND @CustomerName = 38 )
BEGIN
	SET @sJOIN = N'LEFT JOIN CT0153 WITH (NOLOCK) ON CT0153.InventoryID = AT1302.InventoryID AND CT0153.ID = ''' + ISNULL(@PriceListID, '') + ''' '
END

/*
SET @sSQL01 = ' 
SELECT TOP 1
AT1302.DivisionID,
AT1302.InventoryID,
AT1302.InventoryName,
AT1302.Specification,
AT1302.UnitID,
AT1304.UnitName,
AT1302.InventoryTypeID,
AT1302.IsStocked,
AT1302.VATGroupID,
AT1302.VATPercent,
ISNULL((CASE WHEN AV1004.Operator = 0 THEN AT1302.SalePrice01 * AV1004.ExchangeRate 
				ELSE AT1302.SalePrice01 / AV1004.ExchangeRate END), 0) AS SalePrice,
CAST(0 AS DECIMAL(28,8)) AS UnitPrice,
CAST(0 AS DECIMAL(28,8)) AS MinPrice , 
CAST(0 AS DECIMAL(28,8)) AS MaxPrice,
CAST(0 AS DECIMAL(28,8)) AS MinQuantity, 
CAST(0 AS DECIMAL(28,8)) AS MaxQuantity,
0 AS TypePriceControl,
0 AS TypeQuantityControl,
ISNULL(AT1302.SalePrice01, 0) As SalePrice01,
ISNULL(AT1302.SalePrice02, 0) As SalePrice02,
ISNULL(AT1302.SalePrice03, 0) As SalePrice03,
ISNULL(AT1302.SalePrice04, 0) As SalePrice04,
ISNULL(AT1302.SalePrice05, 0) As SalePrice05,
CAST(NULL AS NVARCHAR(250)) AS Notes,
CAST(NULL AS NVARCHAR(250)) AS Notes01,
CAST(NULL AS NVARCHAR(250)) AS Notes02,
AT1302.Barcode,
'
SET @sSQL02 = '
CAST(0 AS DECIMAL(28,8)) AS DiscountPercent,
CAST(0 AS DECIMAL(28,8)) AS DiscountAmount,
CAST(0 AS DECIMAL(28,8)) AS SaleOffPercent01,
CAST(0 AS DECIMAL(28,8)) AS SaleOffAmount01,
CAST(0 AS DECIMAL(28,8)) AS SaleOffPercent02,
CAST(0 AS DECIMAL(28,8)) AS SaleOffAmount02,
CAST(0 AS DECIMAL(28,8)) AS SaleOffPercent03,
CAST(0 AS DECIMAL(28,8)) AS SaleOffAmount03,
CAST(0 AS DECIMAL(28,8)) AS SaleOffPercent04,
CAST(0 AS DECIMAL(28,8)) AS SaleOffAmount04,
CAST(0 AS DECIMAL(28,8)) AS SaleOffPercent05,
CAST(0 AS DECIMAL(28,8)) AS SaleOffAmount05,
ISNULL(OT0117.FromQuantity1, 0) As FromQuantity1, ISNULL(OT0117.ToQuantity1, 0) As ToQuantity1, ISNULL(OT0117.Price1, 0) As Price1,ISNULL(OT0117.DiscountAmount1, 0) As DiscountAmount1,
ISNULL(OT0117.FromQuantity2, 0) As FromQuantity2, ISNULL(OT0117.ToQuantity2, 0) As ToQuantity2, ISNULL(OT0117.Price2, 0) As Price2,ISNULL(OT0117.DiscountAmount2, 0) As DiscountAmount2,
ISNULL(OT0117.FromQuantity3, 0) As FromQuantity3, ISNULL(OT0117.ToQuantity3, 0) As ToQuantity3, ISNULL(OT0117.Price3, 0) As Price3,ISNULL(OT0117.DiscountAmount3, 0) As DiscountAmount3,
ISNULL(OT0117.FromQuantity4, 0) As FromQuantity4, ISNULL(OT0117.ToQuantity4, 0) As ToQuantity4, ISNULL(OT0117.Price4, 0) As Price4,ISNULL(OT0117.DiscountAmount4, 0) As DiscountAmount4,
ISNULL(OT0117.FromQuantity5, 0) As FromQuantity5, ISNULL(OT0117.ToQuantity5, 0) As ToQuantity5, ISNULL(OT0117.Price5, 0) As Price5,ISNULL(OT0117.DiscountAmount5, 0) As DiscountAmount5,
ISNULL(OT0117.FromQuantity6, 0) As FromQuantity6, ISNULL(OT0117.ToQuantity6, 0) As ToQuantity6, ISNULL(OT0117.Price6, 0) As Price6,ISNULL(OT0117.DiscountAmount6, 0) As DiscountAmount6,
ISNULL(OT0117.FromQuantity7, 0) As FromQuantity7, ISNULL(OT0117.ToQuantity7, 0) As ToQuantity7, ISNULL(OT0117.Price7, 0) As Price7,ISNULL(OT0117.DiscountAmount7, 0) As DiscountAmount7,
ISNULL(OT0117.FromQuantity8, 0) As FromQuantity8, ISNULL(OT0117.ToQuantity8, 0) As ToQuantity8, ISNULL(OT0117.Price8, 0) As Price8,ISNULL(OT0117.DiscountAmount8, 0) As DiscountAmount8,
ISNULL(OT0117.FromQuantity9, 0) As FromQuantity9, ISNULL(OT0117.ToQuantity9, 0) As ToQuantity9, ISNULL(OT0117.Price9, 0) As Price9,ISNULL(OT0117.DiscountAmount9, 0) As DiscountAmount9,
ISNULL(OT0117.FromQuantity10, 0) As FromQuantity10,ISNULL(OT0117.ToQuantity10, 0) As ToQuantity10,ISNULL(OT0117.Price10, 0) As Price10,ISNULL(OT0117.DiscountAmount10, 0) As DiscountAmount10,
ISNULL(OT0117.Price, 0) AS OT0117Price,
ISNULL(OT0117.Discount, 0) AS OT0117Discount,
CAST(NULL AS NVARCHAR(250)) AS O01ID,
	0 TrayPrice, 0 DecreaseTrayPrice,NULL Qtyfrom,NULL QtyTo,
OT1301.IsPlanPrice,
AT1302.RecievedPrice, AT1302.S1, AT1302.S2, AT1302.S3, AT1302.AccountID, 
AT1302.IsSource,AT1302.IsLocation,AT1302.IsLimitDate,isnull(AT1302.IsDiscount,0) as IsDiscount ,AT1302.SalesAccountID,
AT1302.PurchaseAccountID, AT1302.PrimeCostAccountID, AT1302.MethodID,AT1302.DeliveryPrice,
AT1302.ETaxID, 
AT1302.ETaxConvertedUnit, 
AT1302.NRTClassifyID, AT1302.SETID,
Convert(Decimal(28,8),0) AS [AddCost01],
Convert(Decimal(28,8),0) AS [AddCost02],
Convert(Decimal(28,8),0) AS [AddCost03],
Convert(Decimal(28,8),0) AS [AddCost04],
Convert(Decimal(28,8),0) AS [AddCost05],
Convert(Decimal(28,8),0) AS [AddCost06],
Convert(Decimal(28,8),0) AS [AddCost07],
Convert(Decimal(28,8),0) AS [AddCost08],
Convert(Decimal(28,8),0) AS [AddCost09],
Convert(Decimal(28,8),0) AS [AddCost10],
Convert(Decimal(28,8),0) AS [AddCost11],
Convert(Decimal(28,8),0) AS [AddCost12],
Convert(Decimal(28,8),0) AS [AddCost13],
Convert(Decimal(28,8),0) AS [AddCost14],
Convert(Decimal(28,8),0) AS [AddCost15], 0 AS IsPriceID
'

SET @sSQL03 = '
INTO #OP1302 
FROM AT1302 WITH (NOLOCK)
LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT1302.UnitID
LEFT JOIN OT1301 WITH (NOLOCK) ON OT1301.ID = ''' + @PriceListID + '''
LEFT JOIN (
	SELECT AV1004.CurrencyID,AV1004.DivisionID, AV1004.Operator, 
	COALESCE(AT1012.ExchangeRate, AV1004.ExchangeRate) AS ExchangeRate
	FROM AV1004 
	LEFT JOIN ( 
				SELECT Top 1 DivisionID , CurrencyID, ExchangeRate, ExchangeDate
				FROM AT1012 WITH (NOLOCK)  
				WHERE DATEDIFF(dd, ExchangeDate, ''' + CONVERT(VARCHAR(10),@VoucherDate,101) + ''') >= 0
				ORDER BY ExchangeDate DESC
				)AT1012 ON AT1012.CurrencyID = AV1004.CurrencyID
	) AV1004 ON AV1004.CurrencyID = ' + CASE WHEN @CurrencyID = @BaseCurrencyID THEN 'ISNULL(OT1301.CurrencyID, ''' + @BaseCurrencyID + ''')' 
										ELSE '''' + @BaseCurrencyID + '''' END + ' 
LEFT JOIN OT0117 WITH (NOLOCK) ON OT0117.InventoryID = AT1302.InventoryID AND OT0117.ID = ''' + @PriceListID + '''

WHERE 1 = 0

--IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N''[dbo].[OV1302]'') AND name = N''OV1302_Index1'')
--DROP INDEX [OV1302_Index1] ON [dbo].[OV1302] WITH ( ONLINE = OFF )

--CREATE NONCLUSTERED INDEX [AT9000_Index1] ON [dbo].[OV1302] 
--(
--	[DivisionID] ASC,
--	[InventoryID] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

'
*/

CREATE TABLE #OP1302 (DivisionID VARCHAR(50) COLLATE DATABASE_DEFAULT, InventoryID VARCHAR(50) COLLATE DATABASE_DEFAULT, InventoryName NVARCHAR(MAX) COLLATE DATABASE_DEFAULT, Specification NVARCHAR(MAX) COLLATE DATABASE_DEFAULT, UnitID NVARCHAR(50) COLLATE DATABASE_DEFAULT, UnitName NVARCHAR(250) COLLATE DATABASE_DEFAULT,
InventoryTypeID VARCHAR(50) COLLATE DATABASE_DEFAULT, IsStocked TINYINT, VATGroupID VARCHAR(50) COLLATE DATABASE_DEFAULT, VATPercent DECIMAL(28,8), SalePrice DECIMAL(28,8), UnitPrice DECIMAL(28,8) DEFAULT(0), MinPrice DECIMAL(28,8) DEFAULT(0),
MaxPrice DECIMAL(28,8) DEFAULT(0), MinQuantity DECIMAL(28,8) DEFAULT(0), MaxQuantity DECIMAL(28,8) DEFAULT(0), TypePriceControl DECIMAL(28,8) DEFAULT(0), TypeQuantityControl DECIMAL(28,8) DEFAULT(0), 
SalePrice01 DECIMAL(28,8), SalePrice02 DECIMAL(28,8), SalePrice03 DECIMAL(28,8), SalePrice04 DECIMAL(28,8), SalePrice05 DECIMAL(28,8), 
Notes NVARCHAR(250) COLLATE DATABASE_DEFAULT, Notes01 NVARCHAR(250) COLLATE DATABASE_DEFAULT, Notes02 NVARCHAR(250) COLLATE DATABASE_DEFAULT,
Barcode NVARCHAR(50) COLLATE DATABASE_DEFAULT, DiscountPercent DECIMAL(28,8) DEFAULT(0), DiscountAmount DECIMAL(28,8) DEFAULT(0), 
SaleOffPercent01 DECIMAL(28,8) DEFAULT(0), SaleOffAmount01 DECIMAL(28,8) DEFAULT(0), SaleOffPercent02 DECIMAL(28,8) DEFAULT(0), SaleOffAmount02 DECIMAL(28,8) DEFAULT(0), 
SaleOffPercent03 DECIMAL(28,8) DEFAULT(0), SaleOffAmount03 DECIMAL(28,8) DEFAULT(0), SaleOffPercent04 DECIMAL(28,8) DEFAULT(0), SaleOffAmount04 DECIMAL(28,8) DEFAULT(0), 
SaleOffPercent05 DECIMAL(28,8) DEFAULT(0), SaleOffAmount05 DECIMAL(28,8) DEFAULT(0), 
FromQuantity1 DECIMAL(28,8) DEFAULT(0), ToQuantity1 DECIMAL(28,8) DEFAULT(0), Price1 DECIMAL(28,8) DEFAULT(0), DiscountAmount1 DECIMAL(28,8) DEFAULT(0), 
FromQuantity2 DECIMAL(28,8) DEFAULT(0), ToQuantity2 DECIMAL(28,8) DEFAULT(0), Price2 DECIMAL(28,8) DEFAULT(0), DiscountAmount2 DECIMAL(28,8) DEFAULT(0), 
FromQuantity3 DECIMAL(28,8) DEFAULT(0), ToQuantity3 DECIMAL(28,8) DEFAULT(0), Price3 DECIMAL(28,8) DEFAULT(0), DiscountAmount3 DECIMAL(28,8) DEFAULT(0), 
FromQuantity4 DECIMAL(28,8) DEFAULT(0), ToQuantity4 DECIMAL(28,8) DEFAULT(0), Price4 DECIMAL(28,8) DEFAULT(0), DiscountAmount4 DECIMAL(28,8) DEFAULT(0), 
FromQuantity5 DECIMAL(28,8) DEFAULT(0), ToQuantity5 DECIMAL(28,8) DEFAULT(0), Price5 DECIMAL(28,8) DEFAULT(0), DiscountAmount5 DECIMAL(28,8) DEFAULT(0), 
FromQuantity6 DECIMAL(28,8) DEFAULT(0), ToQuantity6 DECIMAL(28,8) DEFAULT(0), Price6 DECIMAL(28,8) DEFAULT(0), DiscountAmount6 DECIMAL(28,8) DEFAULT(0), 
FromQuantity7 DECIMAL(28,8) DEFAULT(0), ToQuantity7 DECIMAL(28,8) DEFAULT(0), Price7 DECIMAL(28,8) DEFAULT(0), DiscountAmount7 DECIMAL(28,8) DEFAULT(0), 
FromQuantity8 DECIMAL(28,8) DEFAULT(0), ToQuantity8 DECIMAL(28,8) DEFAULT(0), Price8 DECIMAL(28,8) DEFAULT(0), DiscountAmount8 DECIMAL(28,8) DEFAULT(0), 
FromQuantity9 DECIMAL(28,8) DEFAULT(0), ToQuantity9 DECIMAL(28,8) DEFAULT(0), Price9 DECIMAL(28,8) DEFAULT(0), DiscountAmount9 DECIMAL(28,8) DEFAULT(0), 
FromQuantity10 DECIMAL(28,8) DEFAULT(0), ToQuantity10 DECIMAL(28,8) DEFAULT(0), Price10 DECIMAL(28,8) DEFAULT(0), DiscountAmount10 DECIMAL(28,8) DEFAULT(0), 
OT0117Price DECIMAL(28,8) DEFAULT(0), OT0117Discount DECIMAL(28,8) DEFAULT(0), O01ID VARCHAR(50), TrayPrice DECIMAL(28,8) DEFAULT(0), DecreaseTrayPrice DECIMAL(28,8) DEFAULT(0), Qtyfrom DECIMAL(28,8), QtyTo DECIMAL(28,8),
IsPlanPrice TINYINT, ReceivedPrice DECIMAL(28,8), S1 VARCHAR(50) COLLATE DATABASE_DEFAULT, S2 VARCHAR(50) COLLATE DATABASE_DEFAULT, S3 VARCHAR(50) COLLATE DATABASE_DEFAULT, AccountID VARCHAR(50) COLLATE DATABASE_DEFAULT, IsSource TINYINT, IsLocation TINYINT, IsLimitDate TINYINT,
IsDiscount TINYINT, SalesAccountID VARCHAR(50) COLLATE DATABASE_DEFAULT, PurchaseAccountID VARCHAR(50) COLLATE DATABASE_DEFAULT, PrimeCostAccountID VARCHAR(50) COLLATE DATABASE_DEFAULT, MethodID TINYINT, DeliveryPrice DECIMAL(28,8), ETaxID VARCHAR(50) COLLATE DATABASE_DEFAULT,
ETaxConvertedUnit DECIMAL(28,8), NRTClassifyID VARCHAR(50) COLLATE DATABASE_DEFAULT, SETID VARCHAR(50) COLLATE DATABASE_DEFAULT, AddCost01 DECIMAL(28,8) DEFAULT(0), AddCost02 DECIMAL(28,8) DEFAULT(0), 
AddCost03 DECIMAL(28,8) DEFAULT(0), AddCost04 DECIMAL(28,8) DEFAULT(0),
AddCost05 DECIMAL(28,8) DEFAULT(0), AddCost06 DECIMAL(28,8) DEFAULT(0), AddCost07 DECIMAL(28,8) DEFAULT(0), AddCost08 DECIMAL(28,8) DEFAULT(0),
AddCost09 DECIMAL(28,8) DEFAULT(0), AddCost10 DECIMAL(28,8) DEFAULT(0), AddCost11 DECIMAL(28,8) DEFAULT(0), AddCost12 DECIMAL(28,8) DEFAULT(0),
AddCost13 DECIMAL(28,8) DEFAULT(0), AddCost14 DECIMAL(28,8) DEFAULT(0), AddCost15 DECIMAL(28,8) DEFAULT(0), IsPriceID TINYINT DEFAULT(0))

IF  EXISTS (SELECT * FROM sys.indexes WHERE name = N'#OP1302_Index1')
DROP INDEX [#OP1302_Index1] ON [dbo].[#OP1302] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [#OP1302_Index1] ON [dbo].[#OP1302] 
(
	[DivisionID] ASC,
	[InventoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


--Truong hop khong QL So luong va gia ban
IF @IsPriceControl = 0 AND @IsQuantityControl = 0
BEGIN
    SET @sSQL = '
	INSERT INTO #OP1302 
	(  
		 DivisionID, InventoryID, InventoryName
		, Specification, UnitID, UnitName
		, InventoryTypeID, IsStocked, VATGroupID
		, VATPercent, SalePrice,SalePrice01
	    , SalePrice02, SalePrice03, SalePrice04
		, SalePrice05,Barcode, IsPlanPrice
		, ReceivedPrice, S1, S2, S3
		, AccountID, IsSource, IsLocation
		, IsLimitDate, IsDiscount, SalesAccountID
		, PurchaseAccountID, PrimeCostAccountID
		, MethodID, DeliveryPrice,ETaxID
		, ETaxConvertedUnit, NRTClassifyID,SETID
	)

	SELECT  AT1302.DivisionID
			,AT1302.InventoryID,AT1302.InventoryName
			,AT1302.Specification,AT1302.UnitID
			,AT1304.UnitName,AT1302.InventoryTypeID
			,AT1302.IsStocked,AT1302.VATGroupID
			,AT1302.VATPercent
			,ISNULL(
				CASE WHEN '+str(@TypeID)+' = 0 
				THEN (CASE WHEN AV1004.Operator = 0 THEN AT1302.SalePrice01 * AV1004.ExchangeRate ELSE AT1302.SalePrice01 / AV1004.ExchangeRate END)
				ELSE (CASE WHEN AV1004.Operator = 0 THEN AT1302.PurchasePrice01 * AV1004.ExchangeRate ELSE AT1302.PurchasePrice01 / AV1004.ExchangeRate END)
			END, 0) AS SalePrice
			,
			--CAST(0 AS DECIMAL(28,8)) AS UnitPrice,
			--CAST(0 AS DECIMAL(28,8)) AS MinPrice , 
			--CAST(0 AS DECIMAL(28,8)) AS MaxPrice,
			--CAST(0 AS DECIMAL(28,8)) AS MinQuantity, 
			--CAST(0 AS DECIMAL(28,8)) AS MaxQuantity,
			--0 AS TypePriceControl,
			--0 AS TypeQuantityControl,
			CASE WHEN '+str(@TypeID)+' = 0 THEN ISNULL(AT1302.SalePrice01, 0) ELSE ISNULL(AT1302.PurchasePrice01, 0) END As SalePrice01,
			CASE WHEN '+str(@TypeID)+' = 0 THEN ISNULL(AT1302.SalePrice02, 0) ELSE ISNULL(AT1302.PurchasePrice02, 0) END As SalePrice02,
			CASE WHEN '+str(@TypeID)+' = 0 THEN ISNULL(AT1302.SalePrice03, 0) ELSE ISNULL(AT1302.PurchasePrice03, 0) END As SalePrice03,
			CASE WHEN '+str(@TypeID)+' = 0 THEN ISNULL(AT1302.SalePrice04, 0) ELSE ISNULL(AT1302.PurchasePrice04, 0) END As SalePrice04,
			CASE WHEN '+str(@TypeID)+' = 0 THEN ISNULL(AT1302.SalePrice05, 0) ELSE ISNULL(AT1302.PurchasePrice05, 0) END As SalePrice05,
			'+ CASE WHEN @CustomerIndex = 74 THEN 'ISNULL(AT1302.RefInventoryID,'''') AS Notes,' ELSE '' END + '
			--CAST(NULL AS NVARCHAR(250)) AS Notes,
			--CAST(NULL AS NVARCHAR(250)) AS Notes01,
			--CAST(NULL AS NVARCHAR(250)) AS Notes02,
			AT1302.Barcode,
			'
	SET @sSQL1 = '
					--CAST(0 AS DECIMAL(28,8)) AS DiscountPercent,
					--CAST(0 AS DECIMAL(28,8)) AS DiscountAmount,
					--CAST(0 AS DECIMAL(28,8)) AS SaleOffPercent01,
					--CAST(0 AS DECIMAL(28,8)) AS SaleOffAmount01,
					--CAST(0 AS DECIMAL(28,8)) AS SaleOffPercent02,
					--CAST(0 AS DECIMAL(28,8)) AS SaleOffAmount02,
					--CAST(0 AS DECIMAL(28,8)) AS SaleOffPercent03,
					--CAST(0 AS DECIMAL(28,8)) AS SaleOffAmount03,
					--CAST(0 AS DECIMAL(28,8)) AS SaleOffPercent04,
					--CAST(0 AS DECIMAL(28,8)) AS SaleOffAmount04,
					--CAST(0 AS DECIMAL(28,8)) AS SaleOffPercent05,
					--CAST(0 AS DECIMAL(28,8)) AS SaleOffAmount05,
					--ISNULL(OT0117.FromQuantity1, 0) As FromQuantity1, ISNULL(OT0117.ToQuantity1, 0) As ToQuantity1, ISNULL(OT0117.Price1, 0) As Price1,ISNULL(OT0117.DiscountAmount1, 0) As DiscountAmount1,
					--ISNULL(OT0117.FromQuantity2, 0) As FromQuantity2, ISNULL(OT0117.ToQuantity2, 0) As ToQuantity2, ISNULL(OT0117.Price2, 0) As Price2,ISNULL(OT0117.DiscountAmount2, 0) As DiscountAmount2,
					--ISNULL(OT0117.FromQuantity3, 0) As FromQuantity3, ISNULL(OT0117.ToQuantity3, 0) As ToQuantity3, ISNULL(OT0117.Price3, 0) As Price3,ISNULL(OT0117.DiscountAmount3, 0) As DiscountAmount3,
					--ISNULL(OT0117.FromQuantity4, 0) As FromQuantity4, ISNULL(OT0117.ToQuantity4, 0) As ToQuantity4, ISNULL(OT0117.Price4, 0) As Price4,ISNULL(OT0117.DiscountAmount4, 0) As DiscountAmount4,
					--ISNULL(OT0117.FromQuantity5, 0) As FromQuantity5, ISNULL(OT0117.ToQuantity5, 0) As ToQuantity5, ISNULL(OT0117.Price5, 0) As Price5,ISNULL(OT0117.DiscountAmount5, 0) As DiscountAmount5,
					--ISNULL(OT0117.FromQuantity6, 0) As FromQuantity6, ISNULL(OT0117.ToQuantity6, 0) As ToQuantity6, ISNULL(OT0117.Price6, 0) As Price6,ISNULL(OT0117.DiscountAmount6, 0) As DiscountAmount6,
					--ISNULL(OT0117.FromQuantity7, 0) As FromQuantity7, ISNULL(OT0117.ToQuantity7, 0) As ToQuantity7, ISNULL(OT0117.Price7, 0) As Price7,ISNULL(OT0117.DiscountAmount7, 0) As DiscountAmount7,
					--ISNULL(OT0117.FromQuantity8, 0) As FromQuantity8, ISNULL(OT0117.ToQuantity8, 0) As ToQuantity8, ISNULL(OT0117.Price8, 0) As Price8,ISNULL(OT0117.DiscountAmount8, 0) As DiscountAmount8,
					--ISNULL(OT0117.FromQuantity9, 0) As FromQuantity9, ISNULL(OT0117.ToQuantity9, 0) As ToQuantity9, ISNULL(OT0117.Price9, 0) As Price9,ISNULL(OT0117.DiscountAmount9, 0) As DiscountAmount9,
					--ISNULL(OT0117.FromQuantity10, 0) As FromQuantity10,ISNULL(OT0117.ToQuantity10, 0) As ToQuantity10,ISNULL(OT0117.Price10, 0) As Price10,ISNULL(OT0117.DiscountAmount10, 0) As DiscountAmount10,
					--ISNULL(OT0117.Price, 0) AS OT0117Price,
					--ISNULL(OT0117.Discount, 0) AS OT0117Discount,
					--CAST(NULL AS NVARCHAR(250)) AS O01ID,
					 --0 TrayPrice, 0 DecreaseTrayPrice,NULL Qtyfrom,NULL QtyTo,
					OT1301.IsPlanPrice,
					AT1302.RecievedPrice, AT1302.S1, AT1302.S2, AT1302.S3, AT1302.AccountID, 
					AT1302.IsSource,AT1302.IsLocation,AT1302.IsLimitDate, ISNULL(AT1302.IsDiscount,0) AS IsDiscount ,AT1302.SalesAccountID,
					AT1302.PurchaseAccountID, AT1302.PrimeCostAccountID, AT1302.MethodID,AT1302.DeliveryPrice,
					AT1302.ETaxID, 
					AT1302.ETaxConvertedUnit, 
					AT1302.NRTClassifyID, AT1302.SETID--,
					--Convert(Decimal(28,8),0) AS [AddCost01],
					--Convert(Decimal(28,8),0) AS [AddCost02],
					--Convert(Decimal(28,8),0) AS [AddCost03],
					--Convert(Decimal(28,8),0) AS [AddCost04],
					--Convert(Decimal(28,8),0) AS [AddCost05],
					--Convert(Decimal(28,8),0) AS [AddCost06],
					--Convert(Decimal(28,8),0) AS [AddCost07],
					--Convert(Decimal(28,8),0) AS [AddCost08],
					--Convert(Decimal(28,8),0) AS [AddCost09],
					--Convert(Decimal(28,8),0) AS [AddCost10],
					--Convert(Decimal(28,8),0) AS [AddCost11],
					--Convert(Decimal(28,8),0) AS [AddCost12],
					--Convert(Decimal(28,8),0) AS [AddCost13],
					--Convert(Decimal(28,8),0) AS [AddCost14],
					--Convert(Decimal(28,8),0) AS [AddCost15], 0 AS IsPriceID
					'

	SET @sSQL2 = '
					--INTO OV1302 
					FROM AT1302 WITH (NOLOCK)
					LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.DivisionID = ''' + @DivisionID + '''
														AND AT1304.UnitID = AT1302.UnitID 
					LEFT JOIN OT1301 WITH (NOLOCK) ON OT1301.DivisionID = ''' + @DivisionID + ''' AND OT1301.ID = ''' + @PriceListID + ''' 
					LEFT JOIN (
								SELECT AV1004.CurrencyID,AV1004.DivisionID, AV1004.Operator, 
								COALESCE(AT1012.ExchangeRate, AV1004.ExchangeRate) AS ExchangeRate
								FROM AV1004 WITH (NOLOCK)
								LEFT JOIN ( 
											SELECT TOP 1 DivisionID 
														 ,CurrencyID
														 ,ExchangeRate
														 ,ExchangeDate
											FROM AT1012 WITH (NOLOCK) 
											WHERE DATEDIFF(dd, ExchangeDate, ''' + CONVERT(VARCHAR(10),@VoucherDate,101) + ''') >= 0
											ORDER BY ExchangeDate DESC
										  ) AT1012 ON AT1012.CurrencyID = AV1004.CurrencyID
							  ) AV1004 ON AV1004.DivisionID IN ('''+@DivisionID+''', ''@@@'')
											AND AV1004.CurrencyID = ' + CASE WHEN @CurrencyID = @BaseCurrencyID 
																	   THEN 'ISNULL(OT1301.CurrencyID, ''' + @BaseCurrencyID + ''')' 
																	   ELSE '''' + @BaseCurrencyID + '''' END + ' 
					--LEFT JOIN OT0117 WITH (NOLOCK) ON OT0117.InventoryID = AT1302.InventoryID 
					--								 AND OT0117.ID = ''' + @PriceListID + '''
					WHERE AT1302.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND AT1302.Disabled = 0
					'
END
ELSE IF @PriceListID <> '' AND @IsPriceControl = 1
BEGIN

	SET @ID_Price = @PriceListID

    SET @ID_Quantity = ISNULL(( 
                                SELECT TOP 1 ID FROM OT1303 WITH (NOLOCK)
                                WHERE @VoucherDate BETWEEN FromDate AND CASE WHEN ToDate = '01/01/1900' THEN '12/30/9999' ELSE ToDate END
                                AND DivisionID = @DivisionID AND [Disabled] = 0), '') 
	SET @sSQL = '
	INSERT INTO #OP1302
	SELECT  AT1302.DivisionID,
			AT1302.InventoryID, 
			AT1302.InventoryName,
			AT1302.Specification,
			ISNULL(OT1302.UnitID, AT1302.UnitID) AS UnitID, 
			AT1304.UnitName, 
			AT1302.InventoryTypeID, 
			AT1302.IsStocked,
			AT1302.VATGroupID,
			AT1302.VATPercent,
			'+CASE WHEN @CustomerName = 38 AND @IsPriceGroup = 1 
			THEN 'CT0153.UnitPrice AS SalePrice, CT0153.UnitPrice, ' 
			ELSE 'CASE WHEN ISNULL(OT1301.IsTaxIncluded, 0) = 1
				  THEN ISNULL(OT1302.UnitPrice, 0.0) - ISNULL(OT1302.VATAmount, 0.0) - ISNULL(OT1302.DiscountAmount, 0.0)
				  ELSE ISNULL(OT1302.UnitPrice, 0.0) END AS SalePrice,
				  CASE WHEN AV1004.Operator = 0 
				  THEN OT1302.UnitPrice * AV1004.ExchangeRate 
				  ELSE OT1302.UnitPrice / AV1004.ExchangeRate 
				  END  AS UnitPrice, ' END+'			
			ISNULL(OT1302.MinPrice, 0) As MinPrice, 
			ISNULL(OT1302.MaxPrice, 0) As MaxPrice,
			ISNULL(OT1304.MinQuantity, 0) As MinQuantity, 
			ISNULL(OT1304.MaxQuantity, 0) As MaxQuantity,
			CASE WHEN ISNULL(OT1302.MaxPrice, 0) <> 0 AND ISNULL(OT1302.MinPrice, 0) <> 0 THEN 3
				 WHEN ISNULL(OT1302.MaxPrice, 0) <> 0 AND ISNULL(OT1302.MinPrice, 0) = 0 THEN 2
			     WHEN ISNULL(OT1302.MaxPrice, 0) = 0 AND ISNULL(OT1302.MinPrice, 0) <> 0 THEN 1 
				ELSE 0 
			END AS TypePriceControl,
			CASE WHEN ISNULL(OT1304.MaxQuantity, 0) <> 0 AND ISNULL(OT1304.MinQuantity, 0) <> 0 THEN 3
				 WHEN ISNULL(OT1304.MaxQuantity, 0) <> 0 AND ISNULL(OT1304.MinQuantity, 0) = 0 THEN 2
				 WHEN ISNULL(OT1304.MaxQuantity, 0) = 0 AND ISNULL(OT1304.MinQuantity, 0) <> 0 THEN 1 
			   ELSE 0 
			END AS TypeQuantityControl,
			ISNULL(AT1302.SalePrice01, 0) As SalePrice01,
			ISNULL(AT1302.SalePrice02, 0) As SalePrice02,
			ISNULL(AT1302.SalePrice03, 0) As SalePrice03,
			ISNULL(AT1302.SalePrice04, 0) As SalePrice04,
			ISNULL(AT1302.SalePrice05, 0) As SalePrice05,
			ISNULL(OT1302.Notes, '''') AS Notes,
			ISNULL(OT1302.Notes01, '''') AS Notes01,
			ISNULL(OT1302.Notes02, '''') AS Notes02,
			AT1302.Barcode,
	'
	SET @sSQL1 = 'ISNULL(OT1302.DiscountPercent, 0) AS DiscountPercent,
				  ISNULL(OT1302.DiscountAmount, 0) AS DiscountAmount,
				  ISNULL(OT1302.SaleOffPercent01, 0) AS SaleOffPercent01,
				  ISNULL(OT1302.SaleOffAmount01, 0) AS SaleOffAmount01,
				  ISNULL(OT1302.SaleOffPercent02, 0) AS SaleOffPercent02,
				  ISNULL(OT1302.SaleOffAmount02, 0) AS SaleOffAmount02,
				  ISNULL(OT1302.SaleOffPercent03, 0) AS SaleOffPercent03,
				  ISNULL(OT1302.SaleOffAmount03, 0) AS SaleOffAmount03,
				  ISNULL(OT1302.SaleOffPercent04, 0) AS SaleOffPercent04,
				  ISNULL(OT1302.SaleOffAmount04, 0) AS SaleOffAmount04,
				  ISNULL(OT1302.SaleOffPercent05, 0) AS SaleOffPercent05,
				  ISNULL(OT1302.SaleOffAmount05, 0) AS SaleOffAmount05,
				  ISNULL(OT0117.FromQuantity1, 0) As FromQuantity1, ISNULL(OT0117.ToQuantity1, 0) As ToQuantity1, ISNULL(OT0117.Price1, 0) As Price1,ISNULL(OT0117.DiscountAmount1, 0) As DiscountAmount1,
				  ISNULL(OT0117.FromQuantity2, 0) As FromQuantity2, ISNULL(OT0117.ToQuantity2, 0) As ToQuantity2, ISNULL(OT0117.Price2, 0) As Price2,ISNULL(OT0117.DiscountAmount2, 0) As DiscountAmount2,
				  ISNULL(OT0117.FromQuantity3, 0) As FromQuantity3, ISNULL(OT0117.ToQuantity3, 0) As ToQuantity3, ISNULL(OT0117.Price3, 0) As Price3,ISNULL(OT0117.DiscountAmount3, 0) As DiscountAmount3,
				  ISNULL(OT0117.FromQuantity4, 0) As FromQuantity4, ISNULL(OT0117.ToQuantity4, 0) As ToQuantity4, ISNULL(OT0117.Price4, 0) As Price4,ISNULL(OT0117.DiscountAmount4, 0) As DiscountAmount4,
				  ISNULL(OT0117.FromQuantity5, 0) As FromQuantity5, ISNULL(OT0117.ToQuantity5, 0) As ToQuantity5, ISNULL(OT0117.Price5, 0) As Price5,ISNULL(OT0117.DiscountAmount5, 0) As DiscountAmount5,
				  ISNULL(OT0117.FromQuantity6, 0) As FromQuantity6, ISNULL(OT0117.ToQuantity6, 0) As ToQuantity6, ISNULL(OT0117.Price6, 0) As Price6,ISNULL(OT0117.DiscountAmount6, 0) As DiscountAmount6,
				  ISNULL(OT0117.FromQuantity7, 0) As FromQuantity7, ISNULL(OT0117.ToQuantity7, 0) As ToQuantity7, ISNULL(OT0117.Price7, 0) As Price7,ISNULL(OT0117.DiscountAmount7, 0) As DiscountAmount7,
				  ISNULL(OT0117.FromQuantity8, 0) As FromQuantity8, ISNULL(OT0117.ToQuantity8, 0) As ToQuantity8, ISNULL(OT0117.Price8, 0) As Price8,ISNULL(OT0117.DiscountAmount8, 0) As DiscountAmount8,
				  ISNULL(OT0117.FromQuantity9, 0) As FromQuantity9, ISNULL(OT0117.ToQuantity9, 0) As ToQuantity9, ISNULL(OT0117.Price9, 0) As Price9,ISNULL(OT0117.DiscountAmount9, 0) As DiscountAmount9,
				  ISNULL(OT0117.FromQuantity10, 0) As FromQuantity10,ISNULL(OT0117.ToQuantity10, 0) As ToQuantity10,ISNULL(OT0117.Price10, 0) As Price10,ISNULL(OT0117.DiscountAmount10, 0) As DiscountAmount10,
				  ISNULL(OT0117.Price, 0) AS OT0117Price,
				  ISNULL(OT0117.Discount, 0) AS OT0117Discount,
				  AT1202.O01ID,
				  ISNULL(OT1302.TrayPrice,0) [TrayPrice] , ISNULL(OT1302.DecreaseTrayPrice,0) [DecreaseTrayPrice],OT1312.Qtyfrom,OT1312.QtyTo,
				  OT1301.IsPlanPrice,
				  AT1302.RecievedPrice, AT1302.S1, AT1302.S2, AT1302.S3, AT1302.AccountID, 
				  AT1302.IsSource,AT1302.IsLocation,AT1302.IsLimitDate,isnull(AT1302.IsDiscount,0) as IsDiscount ,AT1302.SalesAccountID,
				  AT1302.PurchaseAccountID, AT1302.PrimeCostAccountID, AT1302.MethodID,AT1302.DeliveryPrice,
				  AT1302.ETaxID, 
				  AT1302.ETaxConvertedUnit, 
				  AT1302.NRTClassifyID, AT1302.SETID,	
				  OT1302.[AddCost01],
				  OT1302.[AddCost02],
				  OT1302.[AddCost03],
				  OT1302.[AddCost04],
				  OT1302.[AddCost05],
				  OT1302.[AddCost06],
				  OT1302.[AddCost07],
				  OT1302.[AddCost08],
				  OT1302.[AddCost09],
				  OT1302.[AddCost10],
				  OT1302.[AddCost11],
				  OT1302.[AddCost12],
				  OT1302.[AddCost13],
				  OT1302.[AddCost14],
				  OT1302.[AddCost15], 
				  CASE WHEN ISNULL(OT1302.InventoryID,'''') = '''' THEN 0 ELSE 1 END AS IsPriceID
	'
   SET @sSQL2 = '--INTO OV1302  
				FROM AT1302 WITH (NOLOCK)
				FULL JOIN OT1302 WITH (NOLOCK) ON OT1302.DivisionID = ''' + @DivisionID + ''' 
											   AND AT1302.InventoryID = OT1302.InventoryID
											   AND OT1302.ID = ''' + ISNULL(@ID_Price, '') + '''
				' + @sJOIN + '
				LEFT JOIN OT1312 WITH (NOLOCK) ON OT1312.ID = OT1302.DetailID
											   AND OT1312.DivisionID = OT1302.DivisionID
											   AND OT1312.PriceID = ''' + ISNULL(@ID_Price, '') + '''
				LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.DivisionID = ''' + @DivisionID + ''' AND AT1304.UnitID = AT1302.UnitID  
				LEFT JOIN OT1304 WITH (NOLOCK) ON OT1304.DivisionID = ''' + @DivisionID + ''' 
											   AND OT1304.ID = ''' + @ID_Quantity + '''
											   AND OT1304.InventoryID = AT1302.InventoryID 
				LEFT JOIN OT1301 WITH (NOLOCK) ON OT1301.ID = OT1302.ID 
				LEFT JOIN (
							SELECT AV1004.CurrencyID
								   , AV1004.DivisionID
								   , AV1004.Operator
								   ,COALESCE(AT1012.ExchangeRate,AV1004.ExchangeRate) AS ExchangeRate
							FROM AV1004 WITH (NOLOCK)
							LEFT JOIN (
										SELECT TOP 1 DivisionID
													, CurrencyID
													, ExchangeRate
													, ExchangeDate
										FROM AT1012 WITH (NOLOCK)
										WHERE DATEDIFF(dd, ExchangeDate, ''' + CONVERT(VARCHAR(10),@VoucherDate,101) + ''') >= 0
										ORDER BY ExchangeDate DESC
									  )AT1012 ON AT1012.CurrencyID = AV1004.CurrencyID
						   ) AV1004 ON AV1004.DivisionID IN (''@@@'', '''+@DivisionID+''') 
										AND AV1004.CurrencyID = ' + CASE WHEN @CurrencyID = @BaseCurrencyID THEN 'ISNULL(OT1301.CurrencyID, ''' + @BaseCurrencyID + ''')' ELSE '''' + @BaseCurrencyID + '''' END + ' 
				LEFT JOIN OT0117 WITH (NOLOCK) ON OT0117.InventoryID = AT1302.InventoryID
											   AND OT0117.ID = ''' + @PriceListID + '''
				LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = ''' + @ObjectID + '''
				WHERE AT1302.Disabled = 0 '+CASE WHEN @ISInventoryToPrice = 1 THEN ' AND OT1301.ID = '''+@ID_Price+'''' ELSE '' END +'
				AND AT1302.DivisionID IN (''@@@'', '''+@DivisionID+''')
				'
END
ELSE 
IF @IsPriceControl = 1 AND @IsQuantityControl = 1
BEGIN
    IF @PriceListID = '' -- Nếu không chọn bảng giá, sẽ lấy 1 bảng giá thỏa điều kiện đầu tiên
    BEGIN
            IF ISNULL(@ObjectID, '') = ''
			BEGIN              
			    SELECT TOP 1 @ID_Price = ISNULL(ID, '') 
                FROM OT1301 WITH (NOLOCK) 
                WHERE @VoucherDate BETWEEN FromDate AND DATEADD(dd, 1, ISNULL(ToDate, CAST('12/30/9999' AS DATETIME)))
                AND OID = '%' AND DivisionID = @DivisionID AND [Disabled] = 0
			END
            ELSE
			BEGIN		
                SELECT TOP 1 @ID_Price = ISNULL(ID, '')
                FROM OT1301 WITH (NOLOCK) 
                WHERE @VoucherDate BETWEEN FromDate AND DATEADD(dd, 1, ISNULL(ToDate, CAST('12/30/9999' AS DATETIME)))
                AND (
                    SELECT TOP 1 
                        CASE	WHEN @OTypeID = 'O01ID' THEN ISNULL(O01ID, '%')
                                WHEN @OTypeID = 'O02ID' THEN ISNULL(O02ID, '%')
                                WHEN @OTypeID = 'O03ID' THEN ISNULL(O03ID, '%')
                                WHEN @OTypeID = 'O04ID' THEN ISNULL(O04ID, '%')
                        ELSE ISNULL(O05ID, '%')
                        END AS ObjectTypeID
                    FROM AT1202 WITH (NOLOCK) 
                    WHERE ObjectID LIKE ISNULL(@ObjectID, '') AND [Disabled] = 0 AND DivisionID IN ( @DivisionID, '@@@')
                    ) LIKE OID AND DivisionID = @DivisionID AND [Disabled] = 0
                ORDER BY ID
			END
	END -- @PriceListID <> ''
	ELSE
        SET @ID_Price = @PriceListID

        SET @ID_Quantity = ISNULL(( 
                                    SELECT TOP 1 ID FROM OT1303 WITH (NOLOCK) 
                                    WHERE DivisionID = @DivisionID AND @VoucherDate BETWEEN FromDate 
									AND CASE WHEN ToDate = '01/01/1900' THEN '12/30/9999' ELSE ToDate END AND [Disabled] = 0), '') 
	SET @sSQL = 
	'
	INSERT INTO #OP1302
	SELECT  AT1302.DivisionID,
			AT1302.InventoryID, 
			AT1302.InventoryName,
			AT1302.Specification,
			ISNULL(OT1302.UnitID, AT1302.UnitID) AS UnitID, 
			AT1304.UnitName, 
			AT1302.InventoryTypeID, 
			AT1302.IsStocked,
			AT1302.VATGroupID,
			AT1302.VATPercent,
			ISNULL((CASE WHEN AV1004.Operator = 0 
			THEN ISNULL((CASE WHEN ''' + LTRIM(@IsConvertedUnit) + ''' = ''0'' 
							THEN ISNULL(OT1312.UnitPrice,OT1302.UnitPrice)
							ELSE ISNULL(OT1312.UnitPrice,OT1302.ConvertedUnitPrice) END), 
						(CASE WHEN '+str(@TypeID)+' = 0 
							THEN AT1302.SalePrice01
							ELSE AT1302.PurchasePrice01 END))* ISNULL(AV1004.ExchangeRate, 1) 
			ELSE ISNULL((CASE WHEN ''' + LTRIM(@IsConvertedUnit) + ''' = ''0'' 
							THEN ISNULL(OT1312.UnitPrice,OT1302.UnitPrice)
							ELSE ISNULL(OT1312.UnitPrice,OT1302.ConvertedUnitPrice) END), 
						(CASE WHEN '+str(@TypeID)+' = 0 
							THEN AT1302.SalePrice01
							ELSE AT1302.PurchasePrice01 END))/ ISNULL(AV1004.ExchangeRate, 1) END),0) 
			AS SalePrice,
			CASE WHEN AV1004.Operator = 0 
				THEN OT1302.UnitPrice * AV1004.ExchangeRate 
				ELSE OT1302.UnitPrice / AV1004.ExchangeRate 
			END AS UnitPrice,
			ISNULL(OT1302.MinPrice, 0) As MinPrice, 
			ISNULL(OT1302.MaxPrice, 0) As MaxPrice,
			ISNULL(OT1304.MinQuantity, 0) As MinQuantity, 
			ISNULL(OT1304.MaxQuantity, 0) As MaxQuantity,
			CASE WHEN ISNULL(OT1302.MaxPrice, 0) <> 0 AND ISNULL(OT1302.MinPrice, 0) <> 0 THEN 3
					WHEN ISNULL(OT1302.MaxPrice, 0) <> 0 AND ISNULL(OT1302.MinPrice, 0) = 0 THEN 2
					WHEN ISNULL(OT1302.MaxPrice, 0) = 0 AND ISNULL(OT1302.MinPrice, 0) <> 0 THEN 1 
					ELSE 0 
			END AS TypePriceControl,
			CASE WHEN ISNULL(OT1304.MaxQuantity, 0) <> 0 AND ISNULL(OT1304.MinQuantity, 0) <> 0 THEN 3
			WHEN ISNULL(OT1304.MaxQuantity, 0) <> 0 AND ISNULL(OT1304.MinQuantity, 0) = 0 THEN 2
			WHEN ISNULL(OT1304.MaxQuantity, 0) = 0 AND ISNULL(OT1304.MinQuantity, 0) <> 0 THEN 1 
			ELSE 0 
			END AS TypeQuantityControl,
			CASE WHEN '+str(@TypeID)+' = 0 THEN ISNULL(AT1302.SalePrice01, 0) ELSE ISNULL(AT1302.PurchasePrice01, 0) END As SalePrice01,
			CASE WHEN '+str(@TypeID)+' = 0 THEN ISNULL(AT1302.SalePrice02, 0) ELSE ISNULL(AT1302.PurchasePrice02, 0) END As SalePrice02,
			CASE WHEN '+str(@TypeID)+' = 0 THEN ISNULL(AT1302.SalePrice03, 0) ELSE ISNULL(AT1302.PurchasePrice03, 0) END As SalePrice03,
			CASE WHEN '+str(@TypeID)+' = 0 THEN ISNULL(AT1302.SalePrice04, 0) ELSE ISNULL(AT1302.PurchasePrice04, 0) END As SalePrice04,
			CASE WHEN '+str(@TypeID)+' = 0 THEN ISNULL(AT1302.SalePrice05, 0) ELSE ISNULL(AT1302.PurchasePrice05, 0) END As SalePrice05,
			'+ CASE WHEN @CustomerIndex = 74 THEN 'ISNULL(AT1302.RefInventoryID,'''') AS Notes,' ELSE 'ISNULL(OT1302.Notes, '''') AS Notes,' END + '
			ISNULL(OT1302.Notes01, '''') AS Notes01,
			ISNULL(OT1302.Notes02, '''') AS Notes02,
			AT1302.Barcode,
	'
	SET @sSQL1 = 'ISNULL(DiscountPercent, 0) AS DiscountPercent,
				  ISNULL(DiscountAmount, 0) AS DiscountAmount,
				  ISNULL(SaleOffPercent01, 0) AS SaleOffPercent01,
				  ISNULL(SaleOffAmount01, 0) AS SaleOffAmount01,
				  ISNULL(SaleOffPercent02, 0) AS SaleOffPercent02,
				  ISNULL(SaleOffAmount02, 0) AS SaleOffAmount02,
				  ISNULL(SaleOffPercent03, 0) AS SaleOffPercent03,
				  ISNULL(SaleOffAmount03, 0) AS SaleOffAmount03,
				  ISNULL(SaleOffPercent04, 0) AS SaleOffPercent04,
				  ISNULL(SaleOffAmount04, 0) AS SaleOffAmount04,
				  ISNULL(SaleOffPercent05, 0) AS SaleOffPercent05,
				  ISNULL(SaleOffAmount05, 0) AS SaleOffAmount05,
				  ' + CASE WHEN @CustomerIndex = 41 THEN '' ELSE '
				  ISNULL(OT0117.FromQuantity1, 0) As FromQuantity1, ISNULL(OT0117.ToQuantity1, 0) As ToQuantity1, ISNULL(OT0117.Price1, 0) As Price1,ISNULL(OT0117.DiscountAmount1, 0) As DiscountAmount1,
				  ISNULL(OT0117.FromQuantity2, 0) As FromQuantity2, ISNULL(OT0117.ToQuantity2, 0) As ToQuantity2, ISNULL(OT0117.Price2, 0) As Price2,ISNULL(OT0117.DiscountAmount2, 0) As DiscountAmount2,
				  ISNULL(OT0117.FromQuantity3, 0) As FromQuantity3, ISNULL(OT0117.ToQuantity3, 0) As ToQuantity3, ISNULL(OT0117.Price3, 0) As Price3,ISNULL(OT0117.DiscountAmount3, 0) As DiscountAmount3,
				  ISNULL(OT0117.FromQuantity4, 0) As FromQuantity4, ISNULL(OT0117.ToQuantity4, 0) As ToQuantity4, ISNULL(OT0117.Price4, 0) As Price4,ISNULL(OT0117.DiscountAmount4, 0) As DiscountAmount4,
				  ISNULL(OT0117.FromQuantity5, 0) As FromQuantity5, ISNULL(OT0117.ToQuantity5, 0) As ToQuantity5, ISNULL(OT0117.Price5, 0) As Price5,ISNULL(OT0117.DiscountAmount5, 0) As DiscountAmount5,
				  ISNULL(OT0117.FromQuantity6, 0) As FromQuantity6, ISNULL(OT0117.ToQuantity6, 0) As ToQuantity6, ISNULL(OT0117.Price6, 0) As Price6,ISNULL(OT0117.DiscountAmount6, 0) As DiscountAmount6,
				  ISNULL(OT0117.FromQuantity7, 0) As FromQuantity7, ISNULL(OT0117.ToQuantity7, 0) As ToQuantity7, ISNULL(OT0117.Price7, 0) As Price7,ISNULL(OT0117.DiscountAmount7, 0) As DiscountAmount7,
				  ISNULL(OT0117.FromQuantity8, 0) As FromQuantity8, ISNULL(OT0117.ToQuantity8, 0) As ToQuantity8, ISNULL(OT0117.Price8, 0) As Price8,ISNULL(OT0117.DiscountAmount8, 0) As DiscountAmount8,
				  ISNULL(OT0117.FromQuantity9, 0) As FromQuantity9, ISNULL(OT0117.ToQuantity9, 0) As ToQuantity9, ISNULL(OT0117.Price9, 0) As Price9,ISNULL(OT0117.DiscountAmount9, 0) As DiscountAmount9,
				  ISNULL(OT0117.FromQuantity10, 0) As FromQuantity10,ISNULL(OT0117.ToQuantity10, 0) As ToQuantity10,ISNULL(OT0117.Price10, 0) As Price10,ISNULL(OT0117.DiscountAmount10, 0) As DiscountAmount10,
				  ISNULL(OT0117.Price, 0) AS OT0117Price,
				  ISNULL(OT0117.Discount, 0) AS OT0117Discount, ' END + '
				  AT1202.O01ID,
				  ISNULL(OT1302.TrayPrice,0) [TrayPrice] , ISNULL(OT1302.DecreaseTrayPrice,0) [DecreaseTrayPrice],OT1312.Qtyfrom,OT1312.QtyTo,
				  OT1301.IsPlanPrice,
				  AT1302.RecievedPrice, AT1302.S1, AT1302.S2, AT1302.S3, AT1302.AccountID, 
				  AT1302.IsSource,AT1302.IsLocation,AT1302.IsLimitDate,isnull(AT1302.IsDiscount,0) as IsDiscount ,AT1302.SalesAccountID,
				  AT1302.PurchaseAccountID, AT1302.PrimeCostAccountID, AT1302.MethodID,AT1302.DeliveryPrice,
				  AT1302.ETaxID, 
				  AT1302.ETaxConvertedUnit, 
				  AT1302.NRTClassifyID, AT1302.SETID
				  ,	
				  OT1302.[AddCost01],
				  OT1302.[AddCost02],
				  OT1302.[AddCost03],
				  OT1302.[AddCost04],
				  OT1302.[AddCost05],
				  OT1302.[AddCost06],
				  OT1302.[AddCost07],
				  OT1302.[AddCost08],
				  OT1302.[AddCost09],
				  OT1302.[AddCost10],
				  OT1302.[AddCost11],
				  OT1302.[AddCost12],
				  OT1302.[AddCost13],
				  OT1302.[AddCost14],
				  OT1302.[AddCost15],
				  CASE WHEN ISNULL(OT1302.InventoryID,'''') = '''' THEN 0 ELSE 1 END AS IsPriceID
				  '
   SET @sSQL2 = '--INTO OV1302  
					FROM AT1302 WITH (NOLOCK)
					FULL JOIN OT1302 WITH (NOLOCK) ON OT1302.DivisionID = ''' + @DivisionID + '''
												   AND AT1302.InventoryID = OT1302.InventoryID 
												   AND OT1302.ID = ''' + ISNULL(@ID_Price, '') + '''
					LEFT JOIN OT1312 WITH (NOLOCK) ON OT1312.DivisionID = ''' + @DivisionID + '''
												   AND OT1312.ID = OT1302.DetailID
												   AND OT1312.DivisionID = OT1302.DivisionID
												   AND OT1312.PriceID = ''' + ISNULL(@ID_Price, '') + '''
					LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.DivisionID = ''' + @DivisionID + '''
													AND AT1304.UnitID = AT1302.UnitID  
					LEFT JOIN OT1304 WITH (NOLOCK) ON OT1304.DivisionID = ''' + @DivisionID + ''' 
														AND OT1304.ID = ''' + @ID_Quantity + ''' 
														AND OT1304.InventoryID = AT1302.InventoryID 
					LEFT JOIN OT1301 WITH (NOLOCK) ON OT1301.ID = ''' + @PriceListID + ''' 
					LEFT JOIN (
								SELECT AV1004.CurrencyID,AV1004.DivisionID, AV1004.Operator, 
									COALESCE(AT1012.ExchangeRate,AV1004.ExchangeRate) AS ExchangeRate
								FROM AV1004 WITH (NOLOCK)  
								LEFT JOIN (
											SELECT TOP 1 DivisionID
														 , CurrencyID
														 , ExchangeRate
														 , ExchangeDate
											FROM AT1012 WITH (NOLOCK)  
											WHERE DATEDIFF(dd, ExchangeDate, ''' + CONVERT(VARCHAR(10),@VoucherDate,101) + ''') >= 0
											ORDER BY ExchangeDate DESC
										  )AT1012 ON AT1012.CurrencyID = AV1004.CurrencyID
							   ) AV1004 ON AV1004.DivisionID IN (''@@@'', ''' + @DivisionID + ''') 
											AND AV1004.CurrencyID = ' + CASE WHEN @CurrencyID = @BaseCurrencyID THEN 'ISNULL(OT1301.CurrencyID, ''' + @BaseCurrencyID + ''')' ELSE '''' + @BaseCurrencyID + '''' END + ' 
					'+CASE WHEN @CustomerIndex=41 THEN '' ELSE 'LEFT JOIN OT0117 WITH (NOLOCK) ON OT0117.InventoryID = AT1302.InventoryID 
																							   AND OT0117.ID = ''' + @PriceListID + ''' ' END + '
					LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = ''' + @ObjectID + '''
					WHERE AT1302.DivisionID IN  ('''+@DivisionID+''',''@@@'') AND  AT1302.Disabled = 0
	'
	IF (@CustomerIndex = 73)
	BEGIN
		SET @sSQL2 = @sSQL2+ '
		UPDATE #OP1302
		SET		SalePrice =  SalePrice 
							+ SalePrice*Isnull([AddCost01],0)/100 
							+ SalePrice* Isnull([AddCost02],0)/100 
							+ SalePrice*Isnull([AddCost03],0)/100 
							+ SalePrice*Isnull([AddCost04],0)/100 
							+ SalePrice*Isnull([AddCost05],0)/100
							+ SalePrice*Isnull([AddCost06],0)/100 
							+ SalePrice*Isnull([AddCost07],0)/100 
							+ SalePrice*Isnull([AddCost08],0)/100 
							+ SalePrice*Isnull([AddCost09],0)/100 
							+ SalePrice*Isnull([AddCost10],0)/100
							+ SalePrice*Isnull([AddCost11],0)/100
							+ SalePrice*Isnull([AddCost12],0)/100
							+ SalePrice*Isnull([AddCost13],0)/100
							+ SalePrice*Isnull([AddCost14],0)/100
							+ SalePrice*Isnull([AddCost15],0)/100
		FROM #OP1302
		'
	END
END
ELSE IF @IsPriceControl = 1 AND @IsQuantityControl = 0
BEGIN
    IF @PriceListID = '' -- Nếu không chọn bảng giá, sẽ lấy 1 bảng giá thỏa điều kiện đầu tiên
        BEGIN 
            IF ISNULL(@ObjectID, '') = ''
                SELECT TOP 1 @ID_Price = ISNULL(ID, '') FROM OT1301 WITH (NOLOCK) 
                WHERE @VoucherDate BETWEEN FromDate AND DATEADD(dd, 1, ISNULL(ToDate, CAST('12/30/9999' AS DATETIME)))
                AND OID = '%' AND DivisionID = @DivisionID
            ELSE
                SELECT TOP 1 @ID_Price = ISNULL(ID, '') FROM OT1301 WITH (NOLOCK) 
                WHERE @VoucherDate BETWEEN FromDate AND DATEADD(dd, 1, ISNULL(ToDate, CAST('12/30/9999' AS DATETIME)))
                AND (
                        SELECT TOP 1 
                        CASE WHEN @OTypeID = 'O01ID' THEN ISNULL(O01ID, '%')
							 WHEN @OTypeID = 'O02ID' THEN ISNULL(O02ID, '%')
							 WHEN @OTypeID = 'O03ID' THEN ISNULL(O03ID, '%')
							 WHEN @OTypeID = 'O04ID' THEN ISNULL(O04ID, '%')
                        ELSE ISNULL(O05ID, '%')
                        END AS ObjectTypeID
                        FROM AT1202 WITH (NOLOCK) WHERE DivisionID IN (@DivisionID, '@@@') AND ObjectID LIKE ISNULL(@ObjectID, '')
                        AND DivisionID IN ( @DivisionID, '@@@') AND [Disabled] = 0
                    ) LIKE OID
                AND DivisionID = @DivisionID AND [Disabled] = 0
                ORDER BY ID
        END
	ELSE 
		SET @ID_Price = @PriceListID

	SET @sSQL = '
	INSERT INTO #OP1302
	SELECT  AT1302.DivisionID,
			AT1302.InventoryID,
			AT1302.InventoryName,
			AT1302.Specification,
			ISNULL(OT1302.UnitID,AT1302.UnitID) AS UnitID,
			AT1304.UnitName,
			AT1302.InventoryTypeID,
			AT1302.IsStocked,
			AT1302.VATGroupID,
			AT1302.VATPercent,
			ISNULL((CASE WHEN AV1004.Operator = 0 
				THEN ISNULL((CASE WHEN ''' + LTRIM(@IsConvertedUnit) + ''' = ''0'' 
								THEN ISNULL(OT1312.UnitPrice,OT1302.UnitPrice)
								ELSE ISNULL(OT1312.UnitPrice,OT1302.ConvertedUnitPrice) END),
							(CASE WHEN '+str(@TypeID)+' = 0 
								THEN AT1302.SalePrice01
								ELSE AT1302.PurchasePrice01 END))*ISNULL(AV1004.ExchangeRate, 1)
				ELSE ISNULL((CASE WHEN ''' + LTRIM(@IsConvertedUnit) + ''' = ''0'' 
								THEN ISNULL(OT1312.UnitPrice,OT1302.UnitPrice)
								ELSE ISNULL(OT1312.UnitPrice,OT1302.ConvertedUnitPrice) END),
							(CASE WHEN '+str(@TypeID)+' = 0 
								THEN AT1302.SalePrice01
								ELSE AT1302.PurchasePrice01 END))/ISNULL(AV1004.ExchangeRate, 1) END),0) 
			AS SalePrice,
			CASE WHEN AV1004.Operator = 0 THEN OT1302.UnitPrice*AV1004.ExchangeRate ELSE OT1302.UnitPrice/AV1004.ExchangeRate END AS UnitPrice,
			ISNULL(OT1302.MinPrice, 0) AS MinPrice,
			ISNULL(OT1302.MaxPrice, 0) AS MaxPrice,
			CAST(NULL AS DECIMAL(28, 8)) AS MinQuantity,
			CAST(NULL AS DECIMAL(28, 8)) AS MaxQuantity,
			CASE WHEN ISNULL(OT1302.MaxPrice, 0) <> 0 AND ISNULL(OT1302.MinPrice, 0) <> 0 THEN 3
				 WHEN ISNULL(OT1302.MaxPrice, 0) <> 0 AND ISNULL(OT1302.MinPrice, 0) = 0 THEN 2
				 WHEN ISNULL(OT1302.MaxPrice, 0) = 0 AND ISNULL(OT1302.MinPrice, 0) <> 0 THEN 1 
				 ELSE 0 
			END AS TypePriceControl, 
			0 AS TypeQuantityControl,
			CASE WHEN '+str(@TypeID)+' = 0 THEN ISNULL(AT1302.SalePrice01, 0) ELSE ISNULL(AT1302.PurchasePrice01, 0) END As SalePrice01,
			CASE WHEN '+str(@TypeID)+' = 0 THEN ISNULL(AT1302.SalePrice02, 0) ELSE ISNULL(AT1302.PurchasePrice02, 0) END As SalePrice02,
			CASE WHEN '+str(@TypeID)+' = 0 THEN ISNULL(AT1302.SalePrice03, 0) ELSE ISNULL(AT1302.PurchasePrice03, 0) END As SalePrice03,
			CASE WHEN '+str(@TypeID)+' = 0 THEN ISNULL(AT1302.SalePrice04, 0) ELSE ISNULL(AT1302.PurchasePrice04, 0) END As SalePrice04,
			CASE WHEN '+str(@TypeID)+' = 0 THEN ISNULL(AT1302.SalePrice05, 0) ELSE ISNULL(AT1302.PurchasePrice05, 0) END As SalePrice05,
			'+ CASE WHEN @CustomerIndex = 74 THEN 'ISNULL(AT1302.RefInventoryID,'''') AS Notes,' ELSE 'ISNULL(OT1302.Notes, '''') AS Notes,' END + '
			ISNULL(OT1302.Notes01, '''') AS Notes01,
			ISNULL(OT1302.Notes02, '''') AS Notes02,
			AT1302.Barcode,
	'
	SET @sSQL1 = 'ISNULL(DiscountPercent, 0) AS DiscountPercent,
				  ISNULL(DiscountAmount, 0) AS DiscountAmount,
				  ISNULL(SaleOffPercent01, 0) AS SaleOffPercent01,
				  ISNULL(SaleOffAmount01, 0) AS SaleOffAmount01,
				  ISNULL(SaleOffPercent02, 0) AS SaleOffPercent02,
				  ISNULL(SaleOffAmount02, 0) AS SaleOffAmount02,
				  ISNULL(SaleOffPercent03, 0) AS SaleOffPercent03,
				  ISNULL(SaleOffAmount03, 0) AS SaleOffAmount03,
				  ISNULL(SaleOffPercent04, 0) AS SaleOffPercent04,
				  ISNULL(SaleOffAmount04, 0) AS SaleOffAmount04,
				  ISNULL(SaleOffPercent05, 0) AS SaleOffPercent05,
				  ISNULL(SaleOffAmount05, 0) AS SaleOffAmount05,
				  '+ CASE WHEN @CustomerIndex = 41 THEN '' ELSE '
				  ISNULL(OT0117.FromQuantity1, 0) As FromQuantity1, ISNULL(OT0117.ToQuantity1, 0) As ToQuantity1, ISNULL(OT0117.Price1, 0) As Price1,ISNULL(OT0117.DiscountAmount1, 0) As DiscountAmount1,
				  ISNULL(OT0117.FromQuantity2, 0) As FromQuantity2, ISNULL(OT0117.ToQuantity2, 0) As ToQuantity2, ISNULL(OT0117.Price2, 0) As Price2,ISNULL(OT0117.DiscountAmount2, 0) As DiscountAmount2,
				  ISNULL(OT0117.FromQuantity3, 0) As FromQuantity3, ISNULL(OT0117.ToQuantity3, 0) As ToQuantity3, ISNULL(OT0117.Price3, 0) As Price3,ISNULL(OT0117.DiscountAmount3, 0) As DiscountAmount3,
				  ISNULL(OT0117.FromQuantity4, 0) As FromQuantity4, ISNULL(OT0117.ToQuantity4, 0) As ToQuantity4, ISNULL(OT0117.Price4, 0) As Price4,ISNULL(OT0117.DiscountAmount4, 0) As DiscountAmount4,
				  ISNULL(OT0117.FromQuantity5, 0) As FromQuantity5, ISNULL(OT0117.ToQuantity5, 0) As ToQuantity5, ISNULL(OT0117.Price5, 0) As Price5,ISNULL(OT0117.DiscountAmount5, 0) As DiscountAmount5,
				  ISNULL(OT0117.FromQuantity6, 0) As FromQuantity6, ISNULL(OT0117.ToQuantity6, 0) As ToQuantity6, ISNULL(OT0117.Price6, 0) As Price6,ISNULL(OT0117.DiscountAmount6, 0) As DiscountAmount6,
				  ISNULL(OT0117.FromQuantity7, 0) As FromQuantity7, ISNULL(OT0117.ToQuantity7, 0) As ToQuantity7, ISNULL(OT0117.Price7, 0) As Price7,ISNULL(OT0117.DiscountAmount7, 0) As DiscountAmount7,
				  ISNULL(OT0117.FromQuantity8, 0) As FromQuantity8, ISNULL(OT0117.ToQuantity8, 0) As ToQuantity8, ISNULL(OT0117.Price8, 0) As Price8,ISNULL(OT0117.DiscountAmount8, 0) As DiscountAmount8,
				  ISNULL(OT0117.FromQuantity9, 0) As FromQuantity9, ISNULL(OT0117.ToQuantity9, 0) As ToQuantity9, ISNULL(OT0117.Price9, 0) As Price9,ISNULL(OT0117.DiscountAmount9, 0) As DiscountAmount9,
				  ISNULL(OT0117.FromQuantity10, 0) As FromQuantity10,ISNULL(OT0117.ToQuantity10, 0) As ToQuantity10,ISNULL(OT0117.Price10, 0) As Price10,ISNULL(OT0117.DiscountAmount10, 0) As DiscountAmount10,
				  ISNULL(OT0117.Price, 0) AS OT0117Price,
				  ISNULL(OT0117.Discount, 0) AS OT0117Discount, ' END + '
				  AT1202.O01ID,
				  ISNULL(OT1302.TrayPrice,0) [TrayPrice] , ISNULL(OT1302.DecreaseTrayPrice,0) [DecreaseTrayPrice],OT1312.Qtyfrom,OT1312.QtyTo,
				  OT1301.IsPlanPrice,
				  AT1302.RecievedPrice, AT1302.S1, AT1302.S2, AT1302.S3, AT1302.AccountID, 
				  AT1302.IsSource,AT1302.IsLocation,AT1302.IsLimitDate,isnull(AT1302.IsDiscount,0) AS IsDiscount ,AT1302.SalesAccountID,
				  AT1302.PurchaseAccountID, AT1302.PrimeCostAccountID, AT1302.MethodID,AT1302.DeliveryPrice,
				  AT1302.ETaxID,
				  AT1302.ETaxConvertedUnit,
				  AT1302.NRTClassifyID, AT1302.SETID,
				  OT1302.[AddCost01],
				  OT1302.[AddCost02],
				  OT1302.[AddCost03],
				  OT1302.[AddCost04],
				  OT1302.[AddCost05],
				  OT1302.[AddCost06],
				  OT1302.[AddCost07],
				  OT1302.[AddCost08],
				  OT1302.[AddCost09],
				  OT1302.[AddCost10],
				  OT1302.[AddCost11],
				  OT1302.[AddCost12],
				  OT1302.[AddCost13],
				  OT1302.[AddCost14],
				  OT1302.[AddCost15], CASE WHEN ISNULL(OT1302.InventoryID,'''') = '''' THEN 0 ELSE 1 END AS IsPriceID
				  '
			SET @sSQL2 = '
	--INTO OV1302  
	FROM AT1302 WITH (NOLOCK)
	FULL JOIN OT1302 WITH (NOLOCK) ON OT1302.DivisionID = ''' + @DivisionID + '''
								   AND AT1302.InventoryID = OT1302.InventoryID 
								   AND OT1302.ID = ''' + ISNULL(@ID_Price, '') + '''
	LEFT JOIN OT1312 WITH (NOLOCK) ON OT1312.DivisionID = OT1302.DivisionID 
									AND OT1312.ID = OT1302.DetailID 
								    AND OT1312.PriceID = ''' + ISNULL(@ID_Price, '') + '''
	LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.DivisionID IN (''@@@'', AT1302.DivisionID)  
								   AND AT1304.UnitID = AT1302.UnitID
	LEFT JOIN OT1301 WITH (NOLOCK) ON OT1301.DivisionID = ''' + @DivisionID + ''' AND OT1301.ID = ''' + @PriceListID + ''' 
	LEFT JOIN (
				SELECT AV1004.CurrencyID
					  ,AV1004.DivisionID
					  ,AV1004.Operator
					  ,COALESCE(AT1012.ExchangeRate,AV1004.ExchangeRate) AS ExchangeRate
				FROM AV1004 WITH (NOLOCK) 
				LEFT JOIN (
							SELECT TOP 1 DivisionID , CurrencyID, ExchangeRate, ExchangeDate 
							FROM AT1012 WITH (NOLOCK)  
							WHERE DATEDIFF(dd, ExchangeDate, ''' + CONVERT(VARCHAR(10),@VoucherDate,101) + ''') >= 0
							ORDER BY ExchangeDate DESC
						  ) AT1012 ON AT1012.CurrencyID = AV1004.CurrencyID
			  ) AV1004 ON AV1004.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND AV1004.CurrencyID = ' + CASE WHEN @CurrencyID = @BaseCurrencyID
													   THEN 'ISNULL(OT1301.CurrencyID, ''' + @BaseCurrencyID + ''')' 
													   ELSE '''' + @BaseCurrencyID + '''' END + ' 
	'+CASE WHEN @CustomerIndex = 41 THEN '' ELSE 'LEFT JOIN OT0117 WITH (NOLOCK) ON OT0117.InventoryID = AT1302.InventoryID 
																				 AND OT0117.ID = ''' + @PriceListID + ''' ' END + '
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''@@@'', ''' + @DivisionID + ''') 
										AND AT1202.ObjectID = ''' + @ObjectID + '''
	WHERE AT1302.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1302.Disabled = 0
	'
	IF (@CustomerIndex = 73)
	BEGIN
		SET @sSQL2 = @sSQL2+ '
		UPDATE #OP1302
		SET	SalePrice =  SalePrice 
						+ SalePrice*Isnull([AddCost01],0)/100 
						+ SalePrice* Isnull([AddCost02],0)/100 
						+ SalePrice*Isnull([AddCost03],0)/100 
						+ SalePrice*Isnull([AddCost04],0)/100 
						+ SalePrice*Isnull([AddCost05],0)/100
						+ SalePrice*Isnull([AddCost06],0)/100 
						+ SalePrice*Isnull([AddCost07],0)/100 
						+ SalePrice*Isnull([AddCost08],0)/100 
						+ SalePrice*Isnull([AddCost09],0)/100 
						+ SalePrice*Isnull([AddCost10],0)/100
						+ SalePrice*Isnull([AddCost11],0)/100
						+ SalePrice*Isnull([AddCost12],0)/100
						+ SalePrice*Isnull([AddCost13],0)/100
						+ SalePrice*Isnull([AddCost14],0)/100
						+ SalePrice*Isnull([AddCost15],0)/100
		FROM #OP1302
		'
	END
END
ELSE
------------Quan ly so luong
BEGIN
	SET @ID_Quantity = ISNULL(
								(
									 SELECT TOP 1 ID FROM OT1303 WITH (NOLOCK) 
									 WHERE @VoucherDate BETWEEN FromDate AND CASE WHEN ToDate = '01/01/1900' THEN '12/30/9999' ELSE ToDate END
									 AND DivisionID = @DivisionID AND [Disabled] = 0
								 ), ''
							 )

	SET @sSQL = '
					INSERT INTO #OP1302
					SELECT  AT1302.DivisionID,
							AT1302.InventoryID,
							AT1302.InventoryName,
							AT1302.Specification,
							AT1302.UnitID,
							AT1304.UnitName,
							AT1302.InventoryTypeID,
							AT1302.IsStocked,
							AT1302.VATGroupID,
							AT1302.VATPercent,
							ISNULL
							(
								CASE WHEN '+str(@TypeID)+' = 0 
								THEN (CASE WHEN AV1004.Operator = 0 THEN AT1302.SalePrice01 * AV1004.ExchangeRate ELSE AT1302.SalePrice01 / AV1004.ExchangeRate END)
								ELSE (CASE WHEN AV1004.Operator = 0 THEN AT1302.PurchasePrice01 * AV1004.ExchangeRate ELSE AT1302.PurchasePrice01 / AV1004.ExchangeRate END)
							END, 0) AS SalePrice,
							CAST(NULL AS DECIMAL(28,8)) AS UnitPrice,
							CAST(NULL AS DECIMAL(28,8)) AS MinPrice,
							CAST(NULL AS DECIMAL(28,8)) AS MaxPrice,
							ISNULL(OT1304.MinQuantity, 0) AS MinQuantity,
							ISNULL(OT1304.MaxQuantity, 0) AS MaxQuantity,
							0 AS TypePriceControl,
							CASE WHEN ISNULL(OT1304.MaxQuantity, 0) <> 0 AND ISNULL(OT1304.MinQuantity, 0) <> 0 THEN 3
							WHEN ISNULL(OT1304.MaxQuantity, 0) <> 0 AND ISNULL(OT1304.MinQuantity, 0) = 0 THEN 2
							WHEN ISNULL(OT1304.MaxQuantity, 0) = 0 AND ISNULL(OT1304.MinQuantity, 0) <> 0 THEN 1 
							ELSE 0 
							END AS TypeQuantityControl,
							CASE WHEN '+str(@TypeID)+' = 0 THEN ISNULL(AT1302.SalePrice01, 0) ELSE ISNULL(AT1302.PurchasePrice01, 0) END As SalePrice01,
							CASE WHEN '+str(@TypeID)+' = 0 THEN ISNULL(AT1302.SalePrice02, 0) ELSE ISNULL(AT1302.PurchasePrice02, 0) END As SalePrice02,
							CASE WHEN '+str(@TypeID)+' = 0 THEN ISNULL(AT1302.SalePrice03, 0) ELSE ISNULL(AT1302.PurchasePrice03, 0) END As SalePrice03,
							CASE WHEN '+str(@TypeID)+' = 0 THEN ISNULL(AT1302.SalePrice04, 0) ELSE ISNULL(AT1302.PurchasePrice04, 0) END As SalePrice04,
							CASE WHEN '+str(@TypeID)+' = 0 THEN ISNULL(AT1302.SalePrice05, 0) ELSE ISNULL(AT1302.PurchasePrice05, 0) END As SalePrice05,
							'+ CASE WHEN @CustomerIndex = 74 THEN 'ISNULL(AT1302.RefInventoryID,'''') AS Notes,' ELSE 'CAST(NULL AS NVARCHAR(250)) AS Notes,' END + '
							CAST(NULL AS NVARCHAR(250)) AS Notes01,
							CAST(NULL AS NVARCHAR(250)) AS Notes02,
							AT1302.Barcode,
	'
	SET @sSQL1 = ' CAST(0 AS DECIMAL(28,8)) AS DiscountPercent,
				   CAST(0 AS DECIMAL(28,8)) AS DiscountAmount,
				   CAST(0 AS DECIMAL(28,8)) AS SaleOffPercent01,
				   CAST(0 AS DECIMAL(28,8)) AS SaleOffAmount01,
				   CAST(0 AS DECIMAL(28,8)) AS SaleOffPercent02,
				   CAST(0 AS DECIMAL(28,8)) AS SaleOffAmount02,
				   CAST(0 AS DECIMAL(28,8)) AS SaleOffPercent03,
				   CAST(0 AS DECIMAL(28,8)) AS SaleOffAmount03,
				   CAST(0 AS DECIMAL(28,8)) AS SaleOffPercent04,
				   CAST(0 AS DECIMAL(28,8)) AS SaleOffAmount04,
				   CAST(0 AS DECIMAL(28,8)) AS SaleOffPercent05,
				   CAST(0 AS DECIMAL(28,8)) AS SaleOffAmount05,
				   ' + CASE WHEN @CustomerIndex = 41 THEN '' ELSE '
				   ISNULL(OT0117.FromQuantity1, 0) As FromQuantity1, ISNULL(OT0117.ToQuantity1, 0) As ToQuantity1, ISNULL(OT0117.Price1, 0) As Price1,ISNULL(OT0117.DiscountAmount1, 0) As DiscountAmount1,
				   ISNULL(OT0117.FromQuantity2, 0) As FromQuantity2, ISNULL(OT0117.ToQuantity2, 0) As ToQuantity2, ISNULL(OT0117.Price2, 0) As Price2,ISNULL(OT0117.DiscountAmount2, 0) As DiscountAmount2,
				   ISNULL(OT0117.FromQuantity3, 0) As FromQuantity3, ISNULL(OT0117.ToQuantity3, 0) As ToQuantity3, ISNULL(OT0117.Price3, 0) As Price3,ISNULL(OT0117.DiscountAmount3, 0) As DiscountAmount3,
				   ISNULL(OT0117.FromQuantity4, 0) As FromQuantity4, ISNULL(OT0117.ToQuantity4, 0) As ToQuantity4, ISNULL(OT0117.Price4, 0) As Price4,ISNULL(OT0117.DiscountAmount4, 0) As DiscountAmount4,
				   ISNULL(OT0117.FromQuantity5, 0) As FromQuantity5, ISNULL(OT0117.ToQuantity5, 0) As ToQuantity5, ISNULL(OT0117.Price5, 0) As Price5,ISNULL(OT0117.DiscountAmount5, 0) As DiscountAmount5,
				   ISNULL(OT0117.FromQuantity6, 0) As FromQuantity6, ISNULL(OT0117.ToQuantity6, 0) As ToQuantity6, ISNULL(OT0117.Price6, 0) As Price6,ISNULL(OT0117.DiscountAmount6, 0) As DiscountAmount6,
				   ISNULL(OT0117.FromQuantity7, 0) As FromQuantity7, ISNULL(OT0117.ToQuantity7, 0) As ToQuantity7, ISNULL(OT0117.Price7, 0) As Price7,ISNULL(OT0117.DiscountAmount7, 0) As DiscountAmount7,
				   ISNULL(OT0117.FromQuantity8, 0) As FromQuantity8, ISNULL(OT0117.ToQuantity8, 0) As ToQuantity8, ISNULL(OT0117.Price8, 0) As Price8,ISNULL(OT0117.DiscountAmount8, 0) As DiscountAmount8,
				   ISNULL(OT0117.FromQuantity9, 0) As FromQuantity9, ISNULL(OT0117.ToQuantity9, 0) As ToQuantity9, ISNULL(OT0117.Price9, 0) As Price9,ISNULL(OT0117.DiscountAmount9, 0) As DiscountAmount9,
				   ISNULL(OT0117.FromQuantity10, 0) As FromQuantity10,ISNULL(OT0117.ToQuantity10, 0) As ToQuantity10,ISNULL(OT0117.Price10, 0) As Price10,ISNULL(OT0117.DiscountAmount10, 0) As DiscountAmount10,
				   ISNULL(OT0117.Price, 0) AS OT0117Price,
				   ISNULL(OT0117.Discount, 0) AS OT0117Discount, ' END + '
				   CAST(NULL AS NVARCHAR(250)) AS O01ID,
				   0 TrayPrice , 0 DecreaseTrayPrice,NULL Qtyfrom,NULL QtyTo,
				   OT1301.IsPlanPrice,
				   AT1302.RecievedPrice, AT1302.S1, AT1302.S2, AT1302.S3, AT1302.AccountID, 
				   AT1302.IsSource,AT1302.IsLocation,AT1302.IsLimitDate,ISNULL(AT1302.IsDiscount,0) AS IsDiscount ,AT1302.SalesAccountID,
				   AT1302.PurchaseAccountID, AT1302.PrimeCostAccountID, AT1302.MethodID,AT1302.DeliveryPrice,
				   AT1302.ETaxID, 
				   AT1302.ETaxConvertedUnit, 
				   AT1302.NRTClassifyID, AT1302.SETID,
				   Convert(Decimal(28,8),0) AS [AddCost01],
				   Convert(Decimal(28,8),0) AS [AddCost02],
				   Convert(Decimal(28,8),0) AS [AddCost03],
				   Convert(Decimal(28,8),0) AS [AddCost04],
				   Convert(Decimal(28,8),0) AS [AddCost05],
				   Convert(Decimal(28,8),0) AS [AddCost06],
				   Convert(Decimal(28,8),0) AS [AddCost07],
				   Convert(Decimal(28,8),0) AS [AddCost08],
				   Convert(Decimal(28,8),0) AS [AddCost09],
				   Convert(Decimal(28,8),0) AS [AddCost10],
				   Convert(Decimal(28,8),0) AS [AddCost11],
				   Convert(Decimal(28,8),0) AS [AddCost12],
				   Convert(Decimal(28,8),0) AS [AddCost13],
				   Convert(Decimal(28,8),0) AS [AddCost14],
				   Convert(Decimal(28,8),0) AS [AddCost15],		 
				   0 AS IsPriceID
				   '
	SET @sSQL2 = ' FROM AT1302 WITH (NOLOCK) 
				   LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.DivisionID IN (''@@@'', ''' + @DivisionID + ''')
														AND AT1304.UnitID = AT1302.UnitID
				   LEFT JOIN OT1304 WITH (NOLOCK) ON OT1304.DivisionID = ''' + @DivisionID + ''' AND OT1304.ID = ''' + @ID_Quantity + ''' AND OT1304.InventoryID = AT1302.InventoryID 
				   LEFT JOIN OT1301 WITH (NOLOCK) ON OT1301.DivisionID = ''' + @DivisionID + ''' AND OT1301.ID = ''' + @PriceListID + ''' 
				   LEFT JOIN (
				   				SELECT AV1004.CurrencyID
				   					  ,AV1004.DivisionID
				   					  ,AV1004.Operator
				   					  ,COALESCE(AT1012.ExchangeRate,AV1004.ExchangeRate) AS ExchangeRate
				   				FROM AV1004 WITH (NOLOCK)
				   	LEFT JOIN (
				   				SELECT TOP 1 DivisionID 
											,CurrencyID
											,ExchangeRate
											,ExchangeDate 
				   				FROM AT1012 WITH (NOLOCK) 
				   				WHERE DATEDIFF(dd, ExchangeDate, ''' + CONVERT(VARCHAR(10),@VoucherDate,101) + ''') >= 0
				   				ORDER BY ExchangeDate DESC
				   				)AT1012 ON AT1012.CurrencyID = AV1004.CurrencyID
				   	) AV1004 ON AV1004.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND AV1004.CurrencyID = ' + CASE WHEN @CurrencyID = @BaseCurrencyID THEN 'ISNULL(OT1301.CurrencyID, ''' + @BaseCurrencyID + ''')' ELSE '''' + @BaseCurrencyID + '''' END + ' 
				   ' + CASE WHEN @CustomerIndex = 41 THEN '' ELSE 'LEFT JOIN OT0117 WITH (NOLOCK) 
																		     ON OT0117.InventoryID = AT1302.InventoryID 
																		     AND OT0117.ID = ''' + @PriceListID + ''' ' END + '
				   WHERE AT1302.DivisionID IN  ('''+@DivisionID+''',''@@@'') AND AT1302.Disabled = 0
	'
END 
--PRINT @sSQL01
--PRINT @sSQL02
--PRINT @sSQL03
--PRINT @sSQL
--PRINT @sSQL1
--PRINT @sSQL2
--PRINT @sSQL3
--IF NOT EXISTS(SELECT TOP 1 1 FROM SysObjects WHERE XType = 'V' AND NAME = 'OV1302')
--    EXEC ('CREATE VIEW OV1302 -- Tao boi OP1302 
--        AS ' + @sSQL + @sSQL1)
--ELSE
--    EXEC ('ALTER VIEW OV1302 -- Tao boi OP1302 
--        AS ' + @sSQL + @sSQL1)

--EXEC (@sSQL+@sSQL1+@sSQL2)

SET @sSQL3 = '  SELECT OV1302.*
				, AT34.UnitID AS NRTUnitID
				, AT34.NRTClassifyName
				, AT34.TaxRate AS NRTTaxRate
				, AT36.SETName
				, AT36.UnitID AS SETUnitID
				, AT36.TaxRate AS SETTaxRate
				, AT93.ETaxName
				, AT93.UnitID AS ETaxUnitID
				FROM #OP1302 OV1302
				LEFT JOIN AT0134 AT34 WITH (NOLOCK) ON AT34.NRTClassifyID = OV1302.NRTClassifyID
				LEFT JOIN AT0136 AT36 WITH (NOLOCK) ON AT36.SETID = OV1302.SETID
				LEFT JOIN AT0293 AT93 WITH (NOLOCK) ON AT93.ETaxID = OV1302.ETaxID
				WHERE OV1302.DivisionID IN ('''+@DivisionID+''',''@@@'')
					  ORDER BY OV1302.DivisionID, OV1302.InventoryID
	----DROP TABLE OV1302
'
--EXEC (@sSQL01+@sSQL02 + @sSQL03 + @sSQL+@sSQL1+@sSQL2 + @sSQL3)
print '----------------------------'
Print @sSQL
Print @sSQL1
Print @sSQL2
Print @sSQL3

EXEC (@sSQL+@sSQL1 + @sSQL2 + @sSQL3)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
