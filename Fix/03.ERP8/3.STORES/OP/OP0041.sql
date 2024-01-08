IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0041]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0041]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Master cho màn hình OF0138 - kế thừa đơn hàng mua [Customize ABA]
-- <History>
---- Create on 27/04/2015 by Lê Thị Hạnh 
---- Modified by Hải Long on 22/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Đình Ly on 17/08/2020: Bổ sung PageNumber, PageSize.
---- Modified by Kiều Nga on 11/09/2020: Fix lỗi bị trùng dữ liệu
---- Modified by Lê Hoàng on 07/05/2021: Bổ sung thêm trường Tên trạng thái
---- Modified by Lê Hoàng on 26/05/2021: Xử lý thêm trường hợp Phiếu tiến độ nhận hàng POF2101 chọn đơn hàng mua SOF0138
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified by Hoàng Long on 21/07/2023: [2023/07/IS/0173] - GREE-Tạo mới tiến độ nhận hàng trong màn hình Xem chi tiết đơn hàng mua
---- Modified by Anh Đô on 16/08/2023: Bổ sung xử lí cho màn hình QCF2001
-- <Example>
/*
OP0041 @DivisionID = 'VG', @FromMonth = 11, @FromYear = 2014, @ToMonth = 11, @ToYear = 2015, 
       @FromDate = '2014-11-02 14:39:51.283', @ToDate = '2014-12-02 14:39:51.283', @IsDate = 0, 
       @ObjectID = '%', @CurrencyID = '%', @SOVoucherID = 'TV20140000000002'  
 */
 
CREATE PROCEDURE [dbo].[OP0041]	
	@DivisionID NVARCHAR(50),
	@FromMonth INT,
	@FromYear INT,
	@ToMonth INT,
	@ToYear INT,
	@FromDate DATETIME,
	@ToDate DATETIME,
	@IsDate TINYINT, -- = 1: search theo ngày
	@ObjectID NVARCHAR(50),
	@CurrencyID NVARCHAR(50),
	@SOVoucherID NVARCHAR(50),
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
		
SET @SOVoucherID = ISNULL(@SOVoucherID,'')
SET @sWHERE = ''
	IF @ObjectID IS NOT NULL AND @ObjectID != ''
	SET @sWHERE = @sWHERE + 'AND ISNULL(OT31.ObjectID,'''') LIKE '''+@ObjectID+''' '
	IF @CurrencyID IS NOT NULL AND @ObjectID != ''
	SET @sWHERE = @sWHERE + ' AND OT31.CurrencyID LIKE '''+@CurrencyID+''' '	
	IF LTRIM(STR(@IsDate)) = 1	SET @sWHERE = @sWHERE + '
	  AND CONVERT(VARCHAR(10),OT31.OrderDate,112) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,112)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,112)+''' '
	IF LTRIM(STR(@IsDate)) = 0	SET @sWHERE = @sWHERE + '
	  AND (OT31.TranYear*12 + OT31.TranMonth) BETWEEN '+LTRIM(STR(@FromYear*12 + @FromMonth))+' AND '+LTRIM(STR(@ToYear*12 + @ToMonth))+' '

	--Phan quyen theo nghiep vu
	SET @sWhere = @sWhere + dbo.GetPermissionVoucherNo(@UserID,'M.QuotationID')

IF @ScreenID = 'POF2101'
BEGIN
	SET @sSQL1 = '
	SELECT DISTINCT DivisionID, POrderID, VoucherNo INTO #ReceivePO FROM OT3003

	SELECT ROW_NUMBER() OVER (ORDER BY P.VoucherNo ) AS RowNum, '+@TotalRow+' AS TotalRow,* 
	FROM(
		SELECT DISTINCT CONVERT(BIT,CASE WHEN ISNULL(RPO.VoucherNo,'''') <> '''' THEN 1 ELSE 0 END) AS [Choose],
				OT31.POrderID, OT31.VoucherNo, OT31.OrderDate,OT31.VoucherTypeID, OT31.ObjectID, AT12.ObjectName, 
				OT31.CurrencyID, ISNULL(OT31.ExchangeRate,0) AS ExchangeRate, OT31.InventoryTypeID,
				ISNULL(OT31.OrderStatus,0) AS OrderStatus, LTRIM(RTRIM(OV1.Description)) AS OrderStatusName,
				OT31.ContractNo, OT31.ContractDate, OT31.[Description] 
		FROM OT3001 OT31
		LEFT JOIN AT1202 AT12 ON AT12.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT12.ObjectID = OT31.ObjectID
		LEFT JOIN #ReceivePO RPO ON RPO.DivisionID = OT31.DivisionID AND RPO.POrderID = OT31.POrderID
		LEFT JOIN OV1101 OV1 WITH(NOLOCK) ON OV1.TypeID = ''PO'' AND OV1.DivisionID = OT31.DivisionID AND OV1.OrderStatus = ISNULL(OT31.OrderStatus,0)
		WHERE OT31.DivisionID = '''+@DivisionID+''' '+@sWHERE+' 
				AND (RPO.POrderID IS NULL OR RPO.VoucherNo = '''+@VoucherNo+''')---chưa kế thừa hoặc đang sửa phiếu cũ
				AND (OT31.VoucherNo IS NULL OR OT31.VoucherNo like ''%'+@SOVoucherID+''')
		) as P '
END
ELSE IF @ScreenID = 'QCF2001'
BEGIN
	SET @sSQL1 = '
	SELECT ROW_NUMBER() OVER (ORDER BY P.VoucherNo ) AS RowNum
			, '+@TotalRow+' AS TotalRow
			, * 
	FROM(
		SELECT DISTINCT CONVERT(BIT, 0) AS [Choose]
			, ''QCF2001'' AS FromScreen
			, OT31.POrderID
			, OT31.VoucherNo
			, OT31.OrderDate
			, OT31.VoucherTypeID
			, OT31.ObjectID
			, AT12.ObjectName
			, OT31.CurrencyID, ISNULL(OT31.ExchangeRate, 0) AS ExchangeRate
			, OT31.InventoryTypeID
			, ISNULL(OT31.OrderStatus, 0) AS OrderStatus
			, LTRIM(RTRIM(OV1.Description)) AS OrderStatusName
			, OT31.ContractNo
			, OT31.ContractDate
			, OT31.[Description]
		FROM OT3001 OT31 WITH (NOLOCK)
		INNER JOIN OT3002 OT32 WITH (NOLOCK) ON OT32.DivisionID = OT31.DivisionID AND OT32.POrderID = OT31.POrderID
		LEFT JOIN QCT2001 Q01 WITH (NOLOCK) ON Q01.InheritTransaction = OT32.TransactionID AND Q01.InheritTable = ''OT3001''
		AND Q01.DivisionID = OT32.DivisionID
		LEFT JOIN AT1202 AT12 WITH (NOLOCK) ON AT12.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT12.ObjectID = OT31.ObjectID
		LEFT JOIN OV1101 OV1 WITH (NOLOCK) ON OV1.TypeID = ''PO'' AND OV1.DivisionID = OT31.DivisionID AND OV1.OrderStatus = ISNULL(OT31.OrderStatus, 0)
		WHERE OT31.DivisionID = '''+@DivisionID+'''
		'+@sWHERE+'
		GROUP BY OT31.POrderID, OT31.VoucherNo, OT31.OrderDate,OT31.VoucherTypeID, OT31.ObjectID, AT12.ObjectName
				, OT31.CurrencyID, OT31.ExchangeRate, OT31.InventoryTypeID, OT31.OrderStatus
				, LTRIM(RTRIM(OV1.Description)), OT31.ContractNo, OT31.ContractDate
				, OT31.[Description], OT32.OrderQuantity
		HAVING ISNULL(OT32.OrderQuantity, 0) - SUM(ISNULL(Q01.QuantityInherit, 0)) > 0) AS P '
END
ELSE
BEGIN
	SET @sSQL1 = '
	SELECT ROW_NUMBER() OVER (ORDER BY P.VoucherNo ) AS RowNum, '+@TotalRow+' AS TotalRow,* 
	FROM(
		SELECT DISTINCT CONVERT(BIT,1) AS [Choose],
				OT31.POrderID, OT31.VoucherNo, OT31.OrderDate,OT31.VoucherTypeID, OT31.ObjectID, AT12.ObjectName, 
				OT31.CurrencyID, ISNULL(OT31.ExchangeRate,0) AS ExchangeRate, OT31.InventoryTypeID,
				ISNULL(OT31.OrderStatus,0) AS OrderStatus, LTRIM(RTRIM(OV1.Description)) AS OrderStatusName,
				OT31.ContractNo, OT31.ContractDate, OT31.[Description] 
		FROM OT3001 OT31
		LEFT JOIN AT1202 AT12 ON AT12.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT12.ObjectID = OT31.ObjectID
		LEFT JOIN OV1101 OV1 WITH(NOLOCK) ON OV1.TypeID = ''PO'' AND OV1.DivisionID = OT31.DivisionID AND OV1.OrderStatus = ISNULL(OT31.OrderStatus,0)
		WHERE OT31.DivisionID = '''+@DivisionID+''' '+@sWHERE+' 
				AND OT31.POrderID IN (SELECT OT22.InheritVoucherID 
									FROM OT2002 OT22 
									WHERE OT22.DivisionID = '''+@DivisionID+''' AND OT22.SOrderID = '''+@SOVoucherID+''' AND OT22.InheritTableID = ''OT3001'') 
		UNION 
		SELECT DISTINCT CONVERT(BIT,0) AS [Choose],
				OT31.POrderID, OT31.VoucherNo, OT31.OrderDate,OT31.VoucherTypeID, OT31.ObjectID, AT12.ObjectName, 
				OT31.CurrencyID, ISNULL(OT31.ExchangeRate,0) AS ExchangeRate, OT31.InventoryTypeID,
				ISNULL(OT31.OrderStatus,0) AS OrderStatus, LTRIM(RTRIM(OV1.Description)) AS OrderStatusName,
				OT31.ContractNo, OT31.ContractDate, OT31.[Description]
		FROM OT3001 OT31
		INNER JOIN OT3002 OT32 ON OT32.DivisionID = OT31.DivisionID AND OT32.POrderID = OT31.POrderID
		LEFT JOIN OT2002 OT22 ON OT22.DivisionID = OT31.DivisionID AND OT22.InheritTableID = ''OT3001'' 
				AND OT22.InheritVoucherID = OT31.POrderID AND OT22.InheritTransactionID = OT32.TransactionID
		LEFT JOIN AT1202 AT12 ON AT12.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT12.ObjectID = OT31.ObjectID
		LEFT JOIN OV1101 OV1 WITH(NOLOCK) ON OV1.TypeID = ''PO'' AND OV1.DivisionID = OT31.DivisionID AND OV1.OrderStatus = ISNULL(OT31.OrderStatus,0)
		WHERE OT31.DivisionID = '''+@DivisionID+''' AND ISNULL(OT31.OrderStatus,0) IN (1,2,3,5) '+@sWHERE+' 
				AND OT31.POrderID NOT IN (SELECT OT22.InheritVoucherID 
										FROM OT2002 OT22 
										WHERE OT22.DivisionID = '''+@DivisionID+''' AND OT22.SOrderID = '''+@SOVoucherID+''' AND OT22.InheritTableID = ''OT3001'')
		GROUP BY OT31.POrderID, OT31.VoucherNo, OT31.OrderDate,OT31.VoucherTypeID, OT31.ObjectID, AT12.ObjectName,
					OT31.CurrencyID, OT31.ExchangeRate, OT31.InventoryTypeID, OT31.OrderStatus, 
					LTRIM(RTRIM(OV1.Description)),
					OT31.ContractNo, OT31.ContractDate, OT31.[Description], OT32.OrderQuantity
		HAVING ISNULL(OT32.OrderQuantity,0) - SUM(ISNULL(OT22.OrderQuantity,0)) > 0) as P '
END

IF @Mode = 1
BEGIN
	SET @sSQL1 = @sSQL1+'
	ORDER BY [Choose], P.OrderDate, P.VoucherNo
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
END

EXEC (@sSQL1)
PRINT (@sSQL1)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
