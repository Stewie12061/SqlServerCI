IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0027]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0027]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Hiển thị danh sách đơn hàng bán
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 30/09/2013 by Bảo Anh
---- Modified on 28/02/2014 by Le Thi Thu Hien : Bo sung phan quyen xem du lieu cua nguoi khac
---- Modified on 04/08/2014 by Bảo Anh : Bo sung lọc theo MPT8 (Sinolife)
---- Modified on 15/06/2015 by Hoàng Vũ : Bo sung lọc theo OrderTypeID (phân loại đơn hàng bán và đơn hàng điều chỉnh) (Secoin)
---- Modified by Tiểu Mai on 04/01/2016: Bổ sung trường DiscountSalesAmount
---- Modified on 15/01/2016 by Hoàng Vũ : Load thêm column [Tuyến giao hàng](Hoàng Trần)
---- Modified by Tiểu Mai on 18/01/2016: Bổ sung columns DiscountPercentSOrder, DiscountAmountSOrder
---- Modified by Tiểu Mai on 05/05/2016: Bổ sung trường ShipAmount
---- Modified by Tiểu Mai on 23/05/2016: Bổ sung load cột IsConfirm khi duyệt 1 hoặc 2 cấp
---- Modified by Tiểu Mai on 08/06/2016: Sửa cột OriginalAmount, ConvertedAmount, bổ sung WITH (NOLOCK)
---- Modified by Tiểu Mai on 23/05/2017: Bổ sung chỉnh sửa danh mục dùng chung
---- Modified by Kim Thư on 20/12/2018: Bổ sung xử lý lọc theo ngày đến 23:59:59, sort theo ngày (không theo giờ)
---- Modified by Hồng Thảo on 20/12/2018: bổ sung  IsConfirm01,IsConfirm01Name,ConfDescription01,IsConfirm02,IsConfirm02Name,ConfDescription02 cho khách hàng Phúc Long
---- Modified by Kim Thư on 12/02/2019: Sắp xếp thứ tự điều kiện where (cải thiện tốc độ) 
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Nhật Thanh on 02/03/2022 : Làm tròn thuế khi select để ra số giống với khi truy vấn detail
---- Modified by Nhựt Trường on 08/03/2022: Bổ sung trường DealerID, DealerName.
---- Modified by Thành Sang on 14/09/2022: Bổ sung trường IsConfrimByEmployee
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- <Example>
---- 
--- exec OP0027 @DivisionID=N'AS',@FromMonth=1,@FromYear=2016,@ToMonth=1,@ToYear=2016,@FromDate='2016-01-15 00:00:00',@ToDate='2016-01-15 00:00:00',@IsDate=1,@IsPrinted=0,@Status=NULL,@ObjectID=N'',@VoucherTypeID=N'',@ConditionVT=N'('''')',@IsUsedConditionVT=N' (0=0) ',@ConditionOB=N'('''')',@IsUsedConditionOB=N' (0=0) ',@IsServer=0,@StrWhere=N'',@UserID='ASOFTADMIN',@Ana08ID='',@OrderTypeID=NULL



CREATE PROCEDURE [dbo].[OP0027] 
(
	@DivisionID nvarchar(50),
	@FromMonth int,
    @FromYear int,
    @ToMonth int,
    @ToYear int,  
    @FromDate as datetime,
    @ToDate as Datetime,
    @IsDate as tinyint, ----0 theo ky, 1 theo ngày
	@IsPrinted AS INT = 0,	--- 0 : Không check
							--- 1 : Check đã in
							--- 2 : Check chưa in
	@Status AS INT = '',
	@ObjectID AS NVARCHAR(50) = '',
	@VoucherTypeID AS NVARCHAR(50) = '',
	@ConditionVT nvarchar(max),
	@IsUsedConditionVT nvarchar(20),
	@ConditionOB nvarchar(max),
	@IsUsedConditionOB nvarchar(20),
	@IsServer AS INT = 0,	--0 : Tim kiem Master
							-- 1 : Tim kiem Detail
	@StrWhere AS NVARCHAR(4000) = '', --Dieu kien tim kiem tren luoi
	@UserID AS VARCHAR(50) = '',
	@Ana08ID AS VARCHAR(50) = '', --- Customize cho Sinolife
	@OrderTypeID AS int = ''-- Null hay '': Tất cả
							-- 0 : Đơn hàng bán
							-- 1 : Đơn hàng bán điều chỉnh
)
AS

Declare @sSQL1 AS Nvarchar(max),
		@sSQL2 AS Nvarchar(max),
		@sSQL AS Nvarchar(max),
		@DivisionWhere AS VARCHAR(MAX),
		@sWHERE AS VARCHAR(MAX),
		@IsConfirm AS TINYINT,
		@CustomerName INT,
		@FromDateText VARCHAR(50),
		@ToDateText VARCHAR(50)


-- Thiết lập lọc theo ngày
SET @FromDateText = (SELECT Convert(nvarchar(10),@FromDate,21) + ' 00:00:00')
SET @ToDateText = (SELECT Convert(nvarchar(10),@ToDate,21) + ' 23:59:59')
		
-- Gán customer Index
SET @CustomerName=(SELECT TOP 1 CustomerName FROM CustomerIndex)

----------------->>>>>> Phân quyền xem chứng từ của người dùng khác		
DECLARE @sSQLPer AS NVARCHAR(MAX),
		@sWHEREPer AS NVARCHAR(MAX)
SET @sSQLPer = ''
SET @sWHEREPer = ''		

SET @IsConfirm = (SELECT IsConfirm FROM OT0000 WITH (NOLOCK) WHERE DivisionID = @DivisionID)

IF EXISTS (SELECT TOP 1 1 FROM OT0001 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND IsPermissionView = 1 ) -- Nếu check Phân quyền xem dữ liệu tại Thiết lập hệ thống thì mới thực hiện
	BEGIN
		SET @sSQLPer = ' LEFT JOIN AT0010 WITH (NOLOCK) ON AT0010.DivisionID = OT2001.DivisionID 
											AND AT0010.AdminUserID = '''+@UserID+''' 
											AND AT0010.UserID = OT2001.CreateUserID '
		SET @sWHEREPer = ' AND (OT2001.CreateUserID = AT0010.UserID
								OR  OT2001.CreateUserID = '''+@UserID+''') '		
	END

-----------------<<<<<< Phân quyền xem chứng từ của người dùng khác		
			
SET @sWHERE = ''

IF @ObjectID IS NOT NULL AND @ObjectID <> '' AND @ObjectID <> '%'
BEGIN
	SET @sWHERE = @sWHERE + N'	AND OT2001.ObjectID = '''+@ObjectID+'''	'
END

IF @VoucherTypeID IS NOT NULL AND @VoucherTypeID <> '' AND @VoucherTypeID <> '%'
BEGIN
	SET @sWHERE = @sWHERE + N'	AND OT2001.VoucherTypeID = '''+@VoucherTypeID+''' '
END

IF @Status IS NOT NULL
BEGIN
	SET @sWHERE = @sWHERE + N'	AND Isnull(OT2001.OrderStatus,0) = ' + STR(@Status) + ' '
END

IF  @OrderTypeID IS NOT NULL
BEGIN
	SET @sWHERE = @sWHERE + N'	AND Isnull(OT2001.OrderTypeID,0) = ' + STR(@OrderTypeID) + ' '
END

IF @IsPrinted IS NOT NULL AND @IsPrinted = 1
BEGIN
	SET @sWHERE = @sWHERE + N' AND ISNULL(OT2001.IsPrinted, 0) = 1 '
END

IF @IsPrinted IS NOT NULL AND @IsPrinted = 2 
BEGIN
	SET @sWHERE = @sWHERE + N' AND ISNULL(OT2001.IsPrinted, 0) = 0 '
END

SET @DivisionWhere = ' WHERE	OT2001.DivisionID = ''' + @DivisionID + ''' '

IF @IsDate = 0
	Set  @DivisionWhere = @DivisionWhere + '
		And (OT2001.TranMonth + OT2001.TranYear*100 between ' + cast(@FromMonth + @FromYear*100 as nvarchar(50)) + ' and ' +  cast(@ToMonth + @ToYear*100 as nvarchar(50))  + ')'
else
	Set  @DivisionWhere = @DivisionWhere + '
		And (OT2001.OrderDate  Between '''+@FromDateText+''' and '''+@ToDateText+''')'

SET @sSQL1 = N' 
SELECT	DISTINCT OT2001.DivisionID,
		OT2001.SOrderID, 
		OT2001.VoucherTypeID, 
		AV2001.Name as OrderTypeID,
		OT2001.VoucherNo,
		OT2001.OrderDate, 
		OT2001.ContractNo, 
		OT2001.ContractDate,
		OT2001.CurrencyID,
		OT2001.ExchangeRate,  
		OT2001.PaymentID,
		OT2001.ObjectID,  
		ISNULL(OT2001.ObjectName, AT1202A.ObjectName)   AS ObjectName,
		OT2001.DealerID,
		AT1202B.ObjectName AS DealerName,
		OT2001.DeliveryAddress, 
		OT2001.ClassifyID, 
		ClassifyName,
		OT2001.EmployeeID,  
		AT1103.FullName,
		ConvertedAmount = (SELECT Sum(ISNULL(ConvertedAmount,0)- ISNULL(DiscountConvertedAmount,0)- ISNULL(CommissionCAmount,0) +
		ROUND(ISNULL(VATConvertedAmount, 0),0) - ISNULL(OT2002.DiscountSaleAmountDetail,0))  FROM OT2002 WITH (NOLOCK) Where OT2002.SOrderID = OT2001.SOrderID),
		OriginalAmount = (SELECT Sum(ISNULL(OriginalAmount,0)- ISNULL(DiscountOriginalAmount,0) - ISNULL(CommissionOAmount, 0) +
		ROUND(ISNULL(VAToriginalAmount, 0),0) - ISNULL(OT2002.DiscountSaleAmountDetail,0))  FROM OT2002 WITH (NOLOCK) Where OT2002.SOrderID = OT2001.SOrderID),
		' + case when @CustomerName = 57 then '	ConvertedAmountBeforeDis = (SELECT Sum(ISNULL(ConvertedAmount,0))  FROM OT2002 WITH (NOLOCK) Where OT2002.SOrderID = OT2001.SOrderID),
		OriginalAmountBeforeDis = (SELECT Sum(ISNULL(OriginalAmount,0))  FROM OT2002 WITH (NOLOCK) Where OT2002.SOrderID = OT2001.SOrderID),
		DiscountConvertedAmount = (SELECT Sum(ISNULL(DiscountConvertedAmount,0))  FROM OT2002 WITH (NOLOCK) Where OT2002.SOrderID = OT2001.SOrderID),
		DiscountOriginalAmount = (SELECT Sum(ISNULL(DiscountOriginalAmount,0))  FROM OT2002 WITH (NOLOCK) Where OT2002.SOrderID = OT2001.SOrderID),
		DiscountSaleAmountDetail = (SELECT Sum(ISNULL(DiscountSaleAmountDetail,0))  FROM OT2002 WITH (NOLOCK) Where OT2002.SOrderID = OT2001.SOrderID),
		ConvertedAmountBeforeVAT = (SELECT Sum(ISNULL(ConvertedAmount,0)- ISNULL(DiscountConvertedAmount,0)- ISNULL(CommissionCAmount,0) - ISNULL(OT2002.DiscountSaleAmountDetail,0))  FROM OT2002 WITH (NOLOCK) Where OT2002.SOrderID = OT2001.SOrderID),
		OriginalAmountBeforeVAT = (SELECT Sum(ISNULL(OriginalAmount,0)- ISNULL(DiscountOriginalAmount,0) - ISNULL(CommissionOAmount, 0) - ISNULL(OT2002.DiscountSaleAmountDetail,0))  FROM OT2002 WITH (NOLOCK) Where OT2002.SOrderID = OT2001.SOrderID),
		VATOriginalAmount = (SELECT Sum(ISNULL(VATOriginalAmount,0))  FROM OT2002 WITH (NOLOCK) Where OT2002.SOrderID = OT2001.SOrderID),
		VATConvertedAmount = (SELECT Sum(ROUND(ISNULL(VATConvertedAmount,0),0))   FROM OT2002 WITH (NOLOCK) Where OT2002.SOrderID = OT2001.SOrderID),' else '' end + '
		OT2001.Notes, 
		OT2001.Disabled, 
		OT2001.OrderStatus,
		' + case when @CustomerName = 69 then 'OV1001.Description' else 'OV1001.LanguageID' end +' AS OrderStatusName  , 
		OV1001.EDescription AS EOrderStatusName, 
		OT2001.Ana01ID, 
		OT2001.Ana02ID, 
		OT2001.Ana03ID, 
		OT2001.Ana04ID, 
		OT2001.Ana05ID, 
		OT1002_1.AnaName AS Ana01Name, 
		OT1002_2.AnaName AS Ana02Name, 
		OT1002_3.AnaName AS Ana03Name, 
		OT1002_4.AnaName AS Ana04Name, 
		OT1002_5.AnaName AS Ana05Name, 
		OT2001.ShipDate, 
		OT2001.DueDate,		
		OT1102.Description AS  IsConfirm,
		OT1102.EDescription AS EIsConfirm,
		OT2001.DescriptionConfirm,
		' + case when @CustomerName = 69 then '0 AS IsConfirmByEmployee,' else '' end +'  
		OT2001.IsPrinted,
		Isnull(OT2001.DiscountSalesAmount,0) as DiscountSalesAmount,
		OT2001.RouteID, CT0143.RouteName,
		OT2001.DiscountPercentSOrder, 
		OT2001.DiscountAmountSOrder,
		OT2001.ShipAmount
		' + case when @CustomerName = 57 then '' else ',
		ISNULL(OT2001.IsConfirm01,0) AS IsConfirm01,
       CASE WHEN ISNULL(OT2001.IsConfirm01,0) = 0 THEN N''Chưa chấp nhận''
			WHEN ISNULL(OT2001.IsConfirm01,0) = 1 THEN N''Xác nhận''
		    WHEN ISNULL(OT2001.IsConfirm01,0) = 2 THEN N''Từ chối''
		    END AS IsConfirm01Name, 
       OT2001.ConfDescription01, ISNULL(OT2001 .IsConfirm02,0) AS IsConfirm02,
       CASE WHEN ISNULL(OT2001.IsConfirm02,0) = 0 THEN N''Chưa chấp nhận''
			WHEN ISNULL(OT2001.IsConfirm02,0) = 1 THEN N''Xác nhận''
		    WHEN ISNULL(OT2001.IsConfirm02,0) = 2 THEN N''Từ chối''
		    END AS IsConfirm02Name, OT2001.ConfDescription02' end 
			+ CASE WHEN @CustomerName = 71 THEN ', TB.Ana01ID AS OT2002_Ana01ID, TB.Ana02ID AS OT2002_Ana02ID, TB.Ana03ID AS OT2002_Ana03ID, TB.Ana04ID AS OT2002_Ana04ID, TB.Ana05ID AS OT2002_Ana05ID, 
											   TB.Ana06ID AS OT2002_Ana06ID, TB.Ana07ID AS OT2002_Ana07ID, TB.Ana08ID AS OT2002_Ana08ID, TB.Ana09ID AS OT2002_Ana09ID, TB.Ana10ID AS OT2002_Ana10ID' ELSE '' END 

SET @sSQL2 ='
FROM OT2001  WITH (NOLOCK)
LEFT JOIN CT0143 WITH (NOLOCK) on OT2001.RouteID = CT0143.RouteID
LEFT JOIN AT1202 AT1202A WITH (NOLOCK) ON AT1202A.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202A.ObjectID = OT2001.ObjectID 
LEFT JOIN AT1202 AT1202B WITH (NOLOCK) ON AT1202B.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202B.ObjectID = OT2001.DealerID 
LEFT JOIN OT1002 OT1002_1 WITH (NOLOCK) ON OT1002_1.DivisionID = OT2001.DivisionID AND OT1002_1.AnaID = OT2001.Ana01ID AND OT1002_1.AnaTypeID = ''S01''
LEFT JOIN OT1002 OT1002_2 WITH (NOLOCK) ON OT1002_2.DivisionID = OT2001.DivisionID AND OT1002_2.AnaID = OT2001.Ana02ID AND OT1002_2.AnaTypeID = ''S02''
LEFT JOIN OT1002 OT1002_3 WITH (NOLOCK) ON OT1002_3.DivisionID = OT2001.DivisionID AND OT1002_3.AnaID = OT2001.Ana03ID AND OT1002_3.AnaTypeID = ''S03''
LEFT JOIN OT1002 OT1002_4 WITH (NOLOCK) ON OT1002_4.DivisionID = OT2001.DivisionID AND OT1002_4.AnaID = OT2001.Ana04ID AND OT1002_4.AnaTypeID = ''S04''
LEFT JOIN OT1002 OT1002_5 WITH (NOLOCK) ON OT1002_5.DivisionID = OT2001.DivisionID AND OT1002_5.AnaID = OT2001.Ana05ID AND OT1002_5.AnaTypeID = ''S05''
LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = OT2001.EmployeeID 

LEFT JOIN OT1001 WITH (NOLOCK) ON OT2001.DivisionID = OT1001.DivisionID AND OT1001.ClassifyID = OT2001.ClassifyID AND OT1001.TypeID = ''SO''
LEFT JOIN OT1101 OV1001 WITH (NOLOCK)  ON  OT2001.DivisionID = OV1001.DivisionID AND  OV1001.OrderStatus = OT2001.OrderStatus AND OV1001.TypeID = case when OT2001.OrderType <> 1 then ''SO'' else ''MO'' end 
LEFT JOIN OT1102 WITH (NOLOCK) ON OT2001.DivisionID = OT1102.DivisionID AND OT1102.Code = '+ CASE WHEN  Isnull(@IsConfirm,0) = 1 THEN ' OT2001.IsConfirm' ELSE ' OT2001.IsConfirm02' END+ ' AND OT1102.TypeID = ''SO''
Left join AV2001 on AV2001.ID = OT2001.OrderTypeID
' + 
CASE WHEN @CustomerName = 71 
THEN 
'LEFT JOIN 
(
	SELECT OT2001.DivisionID, OT2001.SOrderID, 
	MAX(OT2002.Ana01ID) AS Ana01ID, MAX(OT2002.Ana02ID) AS Ana02ID, MAX(OT2002.Ana03ID) AS Ana03ID, MAX(OT2002.Ana04ID) AS Ana04ID, MAX(OT2002.Ana05ID) AS Ana05ID,
	MAX(OT2002.Ana06ID) AS Ana06ID, MAX(OT2002.Ana07ID) AS Ana07ID, MAX(OT2002.Ana08ID) AS Ana08ID, MAX(OT2002.Ana09ID) AS Ana09ID, MAX(OT2002.Ana10ID) AS Ana10ID
	FROM OT2002 WITH (NOLOCK) 
	INNER JOIN OT2001 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2001.SOrderID = OT2002.SOrderID
	WHERE OT2001.DivisionID = ''' + @DivisionID + '''
	AND OT2001.TranMonth + OT2001.TranYear*100 between ' + cast(@FromMonth + @FromYear*100 as nvarchar(50)) + ' and ' +  cast(@ToMonth + @ToYear*100 as nvarchar(50))  + '
	GROUP BY OT2001.DivisionID, OT2001.SOrderID
) TB ON TB.DivisionID = OT2001.DivisionID AND TB.SOrderID = OT2001.SOrderID' 
ELSE '' END


--Print 	@sSQL1
--Print 	@sSQL2

SET @sSQL2 =  @sSQL2 + @sSQLPer + ' ' + @DivisionWhere + @sWHEREPer +' 
	AND OT2001.OrderType <> 1 ' + @sWHERE + ' 
	AND (ISNULL(OT2001.ObjectID, ''#'') IN (' + @ConditionOB + ') Or ' + @IsUsedConditionOB + ') 
	AND (ISNULL(OT2001.VoucherTypeID, ''#'') IN (' + @ConditionVT + ') Or ' + @IsUsedConditionVT + ')'

IF @IsServer = 1
	SET @sSQL = 'SELECT DISTINCT A.*
	FROM (' + @sSQL1 + @sSQL2 + ') A 
	INNER JOIN OT2002 WITH (NOLOCK) ON OT2002.SOrderID = A.SOrderID AND OT2002.DivisionID = A.DivisionID
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', OT2002.DivisionID) AND AT1302.InventoryID= OT2002.InventoryID
	WHERE ' + @StrWhere + ' 
	ORDER BY OrderDate, VoucherNo'
ELSE IF @Ana08ID <> ''
	SET @sSQL = 'SELECT DISTINCT A.*
	FROM (' + @sSQL1 + @sSQL2 + ') A 
	INNER JOIN OT2002 WITH (NOLOCK) ON OT2002.SOrderID = A.SOrderID AND OT2002.DivisionID = A.DivisionID
	WHERE Isnull(OT2002.Ana08ID,'''') = ''' + @Ana08ID + '''
	ORDER BY OrderDate, VoucherNo'
ELSE
	SET @sSQL = 'SELECT * FROM (' + @sSQL1 + @sSQL2 + ') A ' + ' 
	             ORDER BY Convert(varchar(10),OrderDate,121), VoucherNo'
	
PRINT @sSQL
EXEC(@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
