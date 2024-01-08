IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20081]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20081]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Master cho màn hình SOF2008 - kế thừa đơn hàng App
-- <History>
---- Create on 19/10/2023 by Hoàng Long
----  05/12/2023 - Hoàng Long - Updated  - [2023/12/IS/0011]: Fix lỗi SO/SOF2001 – Để trống Địa chỉ giao hàng (NKC)
---- Modified on 27/12/2023 by Hoàng Long - [2023/12/IS/0283] - Fix lỗi SO/SOF2001 – Hiển thị thông tin đơn hàng App
-- <Example>

CREATE PROCEDURE [dbo].[SOP20081]	
	@DivisionID NVARCHAR(50),
	@FromMonth INT,
	@FromYear INT,
	@ToMonth INT,
	@ToYear INT,
	@FromDate DATETIME,
	@ToDate DATETIME,
	@IsDate TINYINT, -- = 1: search theo ngày
	@ObjectID NVARCHAR(50),
	@SOrderID NVARCHAR(50),
	@Mode INT = 0,
	@PageNumber INT = 1,
	@PageSize INT = 25,
	@UserID varchar(50)='',
	@ScreenID nvarchar(50)='',
	@VoucherNo nvarchar(50)=''
AS
DECLARE @sSQL1 NVARCHAR(MAX),
        @sWHERE NVARCHAR(MAX),
		@TotalRow VARCHAR(50)

SET @TotalRow = ''
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
		
SET @SOrderID = ISNULL(@SOrderID,'')
SET @sWHERE = ''
	IF @ObjectID IS NOT NULL AND @ObjectID != ''
	SET @sWHERE = @sWHERE + 'AND ISNULL(A01.customer_id,'''') LIKE '''+@ObjectID+''' '
	IF LTRIM(STR(@IsDate)) = 1	SET @sWHERE = @sWHERE + '
	  AND CONVERT(VARCHAR(10),A01.order_created_date,112) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,112)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,112)+''' '
	IF LTRIM(STR(@IsDate)) = 0	SET @sWHERE = @sWHERE + '
	  AND ((year(order_created_date))*12 + (month(order_created_date))) BETWEEN '+LTRIM(STR(@FromYear*12 + @FromMonth))+' AND '+LTRIM(STR(@ToYear*12 + @ToMonth))+' 
	  '
BEGIN
	SET @sSQL1 = '
	SELECT DISTINCT ROW_NUMBER() OVER (ORDER BY P.VoucherNo ) AS RowNum, '+@TotalRow+' AS TotalRow,* 
	FROM(
		SELECT DISTINCT A01.[user_id], A01.customer_id as ObjectID, A01.order_id, A01.order_no, A02.ObjectName, A01.order_created_date as OrderDate,A01.note as [Description], A01.PriceListID, A01.[Address],A01.DeliveryAddress, MAX(A01.DeliveryStatus) AS DeliveryStatus, A01.VoucherTypeID,
			ISNULL(A01.OrderStatus, O01.OrderStatus) AS order_status, A01.VoucherNo, A01.DivisionID,A02.Tel,A01.DeliveryType
			FROM APT0001 A01
			LEFT JOIN OT2001 O01 ON O01.VoucherNoApp = A01.VoucherNo
			LEFT JOIN AT1202 A02 ON A02.ObjectID = A01.customer_id
			LEFT JOIN OT1002 OT1 ON OT1.AnaID = A01.Ana01ID
			LEFT JOIN OT2002 OT22 ON OT22.DivisionID = A01.DivisionID AND OT22.InheritTableID = ''APT0001'' 
				AND OT22.InheritVoucherID = A01.product_id AND OT22.InheritTransactionID = A01.order_id
			WHERE A01.DivisionID = '''+@DivisionID+'''  '+@sWHERE+' 
			AND NOT EXISTS (
				SELECT 1
				FROM OT2002 OT22
				WHERE A01.order_id = OT22.InheritTransactionID
				AND A01.product_id = OT22.InheritVoucherID
			)
			GROUP BY A01.[user_id],A01.customer_id, A01.order_id, A01.order_no, A02.ObjectName, A01.order_created_date,A01.note,A01.PriceListID, A01.[Address],A01.DeliveryAddress,
			A01.OrderStatus , A01.VoucherTypeID, A01.VoucherNo, O01.VoucherNoApp, A01.Address, O01.OrderStatus, A01.DeliveryAddress, A01.DivisionID,A02.Tel,A01.DeliveryType,A01.quantity
			HAVING ISNULL(A01.quantity,0) - SUM(ISNULL(OT22.OrderQuantity,0)) > 0
			) as P 
		ORDER BY P.VoucherNo, P.OrderDate DESC
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY 
	'
END

EXEC (@sSQL1)
PRINT (@sSQL1)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
