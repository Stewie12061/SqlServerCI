IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP3007]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP3007]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



--- Created by Nhựt Trường on 22/07/2022: Báo cáo tồn kho theo nhà phân phối (ANGEL)
--- Modified by Nhựt Trường on 25/07/2022: Bổ sung load các mặt hàng có số dư đầu kỳ nhưng không nhập xuất trong kỳ.
--- Modified by Nhựt Trường on 28/07/2022: Bổ sung load trường ObjectID, ObjectName.
--- Modified by Nhựt Trường on 02/08/2022: Fix lỗi tách dòng khi lấy số dư đầu kỳ.
--- Modified by Nhựt Trường on 03/08/2022: Điều chỉnh lại điều kiện khi lấy đơn giá từ bảng giá.
--- Modified by Nhựt Trường on 04/08/2022: [2022/08/IS/0031] - Bổ sung order by theo thứ tự I08ID, I04ID, InventoryID.
--- Modified by Nhựt Trường on 11/08/2022: Trường hợp chọn tất cả đối tượng thì tra ra null.
--- Modified by Nhựt Trường on 11/08/2022: [2022/08/IS/0026] - Bổ sung điều kiện lọc theo mã phân tích 08.
--- Modified by Phương Thảo on 08/12/2022: [2022/12/TA/0010] - Customize báo cáo tồn kho nhà phân phối cho Bảo Bảo An (BBA) bao gồm kho hàng bán và kho hàng khuyến mãi.
--- Modified by Nhựt Trường on 03/12/2022: [2022/12/IS/0099] - Bổ sung điều kiện không lấy các nhân viên đã nghỉ việc dựa theo khai báo ở bảng Nhân viên - AT1103.
--- Modified by Nhựt Trường on 04/12/2022: [2022/12/IS/0099] - Bổ sung điều kiện kiểm tra nhân viên có tồn tại ở SELL OUT hay không:
---																+ Nếu tồn tại: Không lấy các nhân viên đã nghỉ việc dựa theo khai báo ở bảng Nhân viên - AT1103.
---																+ Nếu không tồn tại: Bỏ qua điều kiện, vẫn lấy các nhân viên đã nghỉ việc.
--- Modified by Nhựt Trường on 02/02/2023: [2023/02/IS/0010] - Bổ sung điều kiện để lấy bảng giá gần nhất nếu có nhiều bảng giá cùng có hiệu lực trong kỳ.
--- Modified by Kiều Nga on 13/03/2023: [2023/03/IS/0066] - Báo cáo tồn kho NPP trên web sellout bị lỗi: Nhân viên đã nghỉ việc không có đơn hàng, không có phiếu xuất, không có target vẫn load lên báo cáo.
/*
 * exec WMP3007 'ANGEL-SELLOUT', 1, '2022-07-01 00:00:00.000', '2022-07-30 00:00:00.000', null, 'KPP.BDI.0003'
 */
 

CREATE PROCEDURE [dbo].[WMP3007] 
(
	@DivisionID		 NVARCHAR(50),	--Biến môi trường
	@DivisionIDList	NVARCHAR(MAX),
	@PeriodIDList	 NVARCHAR(MAX), 
	@ListObjectID	NVARCHAR(MAX),
	@I08ID			NVARCHAR(MAX)
)
AS

DECLARE @sSQL  NVARCHAR(MAX) = '',
		@sSQL1 NVARCHAR(MAX) = '',
		@sSQL2 NVARCHAR(MAX) = '',
		@sSQL3 NVARCHAR(MAX) = '',
		@sWhere NVARCHAR(MAX) = '',
		@StrObjectID	NVARCHAR(MAX),
		@StrI08ID	NVARCHAR(MAX),
		@Month NVARCHAR (10),
		@Year NVARCHAR (10),
		@CustomerName INT

SET @CustomerName = (SELECT CustomerName FROM CustomerIndex)
--Customize BBA
If @CustomerName = 157
BEGIN
	Print('EXEC__WMP3008_BBA')
	EXEC dbo.WMP3008
	@DivisionID			=	@DivisionID,
	@DivisionIDList		=	@DivisionIDList,
	@PeriodIDList		=	@PeriodIDList,
	@ListObjectID		=	@ListObjectID,
	@I08ID				=	@I08ID
	
END
--Luồng chuẩn
ELSE 
BEGIN

--Nếu Danh sách @DivisionIDList trống thì lấy biến môi trường @DivisionID
IF Isnull(@DivisionIDList, '') != ''
	SET @sWhere = N'AV7000.DivisionID IN ('''+@DivisionIDList+''')'
ELSE 
Begin
	IF Isnull(@DivisionID, '') != ''
		SET @sWhere = N'AV7000.DivisionID = N'''+@DivisionID+''''	
End

---- DEALER
IF CHARINDEX('%',@ListObjectID) > 0
BEGIN
	SET @StrObjectID = N' LIKE N'''''
END
ELSE
BEGIN
	SET @StrObjectID = N'IN ('''+@ListObjectID+''')'
	SET @StrObjectID = REPLACE(@StrObjectID,',',''',''')
END

---- I08ID
IF CHARINDEX('%',@I08ID) > 0 OR ISNULL(@I08ID,'') = ''
BEGIN
	SET @StrI08ID = N' LIKE N''%'''
END
ELSE
BEGIN
	SET @StrI08ID = N'IN ('''+@I08ID+''')'
END

---- MONTH
SET @Month = SUBSTRING(@PeriodIDList,1,2)
IF (SUBSTRING(@Month,1,1) = 0)
BEGIN
	SET @Month = SUBSTRING(@Month,2,2)
END

---- YEAR
SET @Year = SUBSTRING(@PeriodIDList,4,7)



SET @sSQL = N'
---- Lấy số dư đầu kỳ
SELECT DivisionID, ''B'' AS D_C, I08ID, I08Name, I04ID, I04Name,InventoryID, InventoryName,
	  UnitPrice, SUM(ActualQuantity) AS ActualQuantity, SUM(ConvertedQuantity) AS ConvertedQuantity
INTO #AV7002
FROM (
--- So du No cua tai khoan ton kho
SELECT D17.DivisionID, D17.TranMonth, D17.TranYear, D17.DebitAccountID, D17.CreditAccountID, D16.VoucherID, D16.VoucherDate, ''B'' AS D_C,  --- So du No
D16.VoucherNo,  NULL AS EmployeeID, NULL AS EmployeeName, D16.ObjectID, AT1202.ObjectName, D16.WareHouseID, I08.AnaID AS I08ID, I08.AnaName AS I08Name, I04.AnaID AS I04ID, I04.AnaName AS I04Name,
D17.InventoryID, D02.InventoryName,	ISNULL(OT1302.UnitPrice,0) AS UnitPrice, ActualQuantity, ConvertedQuantity
FROM AT2017 AS D17 WITH (NOLOCK)
INNER JOIN AT2016 AS D16 WITH (NOLOCK) ON D16.DivisionID = D17.DivisionID AND D16.VoucherID = D17.VoucherID
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (D17.DivisionID,''@@@'') AND AT1202.ObjectID = D16.ObjectID
INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D17.DivisionID,''@@@'') AND D02.InventoryID = D17.InventoryID
INNER JOIN AT1015 I04 WITH (NOLOCK) ON I04.DivisionID = D02.DivisionID AND I04.AnaID = D02.I04ID AND I04.AnaTypeID = ''I04''
INNER JOIN AT1015 I08 WITH (NOLOCK) ON I08.DivisionID = D02.DivisionID AND I08.AnaID = D02.I08ID AND I08.AnaTypeID = ''I08''
LEFT JOIN OT1302 WITH(NOLOCK) ON OT1302.DivisionID = D17.DivisionID AND OT1302.InventoryID = D17.InventoryID AND OT1302.ID = (SELECT TOP 1 ID FROM OT1301 WITH(NOLOCK) WHERE '+@Month+' + '+@Year+' * 100 BETWEEN Month(FromDate) + Year(FromDate) * 100 AND Month(ToDate) + Year(ToDate) * 100 ORDER BY FromDate DESC, ToDate DESC)
WHERE isnull(DebitAccountID,'''') <>''''

UNION ALL --- So du co hang ton kho

SELECT D17.DivisionID, D17.TranMonth, D17.TranYear, D17.DebitAccountID, D17.CreditAccountID, D16.VoucherID, D16.VoucherDate, ''B'' AS D_C,  --- So du Co
D16.VoucherNo, NULL AS EmployeeID, NULL AS EmployeeName, D16.ObjectID, AT1202.ObjectName, D16.WareHouseID, I08.AnaID AS I08ID, I08.AnaName AS I08Name, I04.AnaID AS I04ID, I04.AnaName AS I04Name,
D17.InventoryID, D02.InventoryName,	ISNULL(OT1302.UnitPrice,0) AS UnitPrice, -ActualQuantity, ConvertedQuantity
FROM AT2017 AS D17 WITH (NOLOCK)
INNER JOIN AT2016 AS D16 WITH (NOLOCK) ON D16.DivisionID = D17.DivisionID AND D16.VoucherID = D17.VoucherID
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (D17.DivisionID,''@@@'') AND AT1202.ObjectID = D16.ObjectID
INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D17.DivisionID,''@@@'') AND D02.InventoryID = D17.InventoryID
INNER JOIN AT1015 I04 WITH (NOLOCK) ON I04.DivisionID = D02.DivisionID AND I04.AnaID = D02.I04ID AND I04.AnaTypeID = ''I04''
INNER JOIN AT1015 I08 WITH (NOLOCK) ON I08.DivisionID = D02.DivisionID AND I08.AnaID = D02.I08ID AND I08.AnaTypeID = ''I08''
LEFT JOIN OT1302 WITH(NOLOCK) ON OT1302.DivisionID = D17.DivisionID AND OT1302.InventoryID = D17.InventoryID AND OT1302.ID = (SELECT TOP 1 ID FROM OT1301 WITH(NOLOCK) WHERE '+@Month+' + '+@Year+' * 100 BETWEEN Month(FromDate) + Year(FromDate) * 100 AND Month(ToDate) + Year(ToDate) * 100 ORDER BY FromDate DESC, ToDate DESC)
WHERE ISNULL(CreditAccountID,'''') <>'''' '

SET @sSQL1 = N'

UNION ALL  -- nhap kho

SELECT D07.DivisionID, D07.TranMonth, D07.TranYear, D07.DebitAccountID, D07.CreditAccountID, D06.VoucherID, D06.VoucherDate, ''D'' AS D_C,  --- Phat sinh No
D06.VoucherNo, D06.EmployeeID, AT1103.FullName AS EmployeeName, D06.ObjectID, AT1202.ObjectName, D06.WareHouseID, I08.AnaID AS I08ID, I08.AnaName AS I08Name, I04.AnaID AS I04ID, I04.AnaName AS I04Name,
D07.InventoryID, D02.InventoryName, ISNULL(OT1302.UnitPrice,0) AS UnitPrice, ActualQuantity, ConvertedQuantity
FROM AT2007 AS D07 WITH (NOLOCK)
INNER JOIN AT2006 D06 WITH (NOLOCK) ON D06.DivisionID = D07.DivisionID AND D06.VoucherID = D07.VoucherID
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (D07.DivisionID,''@@@'') AND AT1202.ObjectID = D06.ObjectID
INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D07.DivisionID,''@@@'') AND D02.InventoryID = D07.InventoryID
INNER JOIN AT1015 I04 WITH (NOLOCK) ON I04.DivisionID = D02.DivisionID AND I04.AnaID = D02.I04ID AND I04.AnaTypeID = ''I04''
INNER JOIN AT1015 I08 WITH (NOLOCK) ON I08.DivisionID = D02.DivisionID AND I08.AnaID = D02.I08ID AND I08.AnaTypeID = ''I08''
LEFT JOIN AT1103 WITH(NOLOCK) ON AT1103.DivisionID = D06.DivisionID AND AT1103.EmployeeID = D06.EmployeeID
LEFT JOIN OT1302 WITH(NOLOCK) ON OT1302.DivisionID = D07.DivisionID AND OT1302.InventoryID = D07.InventoryID AND OT1302.ID = (SELECT TOP 1 ID FROM OT1301 WITH(NOLOCK) WHERE '+@Month+' + '+@Year+' * 100 BETWEEN Month(FromDate) + Year(FromDate) * 100 AND Month(ToDate) + Year(ToDate) * 100 ORDER BY FromDate DESC, ToDate DESC)
WHERE D06.KindVoucherID in (1,3,5,7,9,15,17) AND Isnull(D06.TableID,'''') <> ''AT0114''

UNION ALL  -- xuat kho

SELECT D07.DivisionID, D07.TranMonth, D07.TranYear, D07.DebitAccountID, D07.CreditAccountID, D06.VoucherID, D06.VoucherDate, ''C'' AS D_C,  --- Phat sinh Co
D06.VoucherNo, D06.EmployeeID, AT1103.FullName AS EmployeeName, D06.ObjectID, AT1202.ObjectName, D06.WareHouseID, I08.AnaID AS I08ID, I08.AnaName AS I08Name, I04.AnaID AS I04ID, I04.AnaName AS I04Name,
D07.InventoryID, D02.InventoryName,	ISNULL(OT1302.UnitPrice,0) AS UnitPrice, -ActualQuantity, ConvertedQuantity
FROM AT2007 AS D07 WITH (NOLOCK)
INNER JOIN AT2006 D06 WITH (NOLOCK) ON D06.DivisionID = D07.DivisionID AND D06.VoucherID = D07.VoucherID
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (D07.DivisionID,''@@@'') AND AT1202.ObjectID = D06.ObjectID
INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D07.DivisionID,''@@@'') AND D02.InventoryID = D07.InventoryID
INNER JOIN AT1015 I04 WITH (NOLOCK) ON I04.DivisionID = D02.DivisionID AND I04.AnaID = D02.I04ID AND I04.AnaTypeID = ''I04''
INNER JOIN AT1015 I08 WITH (NOLOCK) ON I08.DivisionID = D02.DivisionID AND I08.AnaID = D02.I08ID AND I08.AnaTypeID = ''I08''
LEFT JOIN AT1103 WITH(NOLOCK) ON AT1103.DivisionID = D06.DivisionID AND AT1103.EmployeeID = D06.EmployeeID
LEFT JOIN OT1302 WITH(NOLOCK) ON OT1302.DivisionID = D07.DivisionID AND OT1302.InventoryID = D07.InventoryID AND OT1302.ID = (SELECT TOP 1 ID FROM OT1301 WITH(NOLOCK) WHERE '+@Month+' + '+@Year+' * 100 BETWEEN Month(FromDate) + Year(FromDate) * 100 AND Month(ToDate) + Year(ToDate) * 100 ORDER BY FromDate DESC, ToDate DESC)
WHERE D06.KindVoucherID in (2,3,4,6,8,10,14,20) ) AV7000
WHERE '+@sWhere+'
	   AND ObjectID '+@StrObjectID+' 
	   AND TranMonth + TranYear * 100  < '+@Month+' + '+@Year+' * 100
GROUP BY DivisionID, I08ID, I08Name, I04ID, I04Name,InventoryID, InventoryName, UnitPrice'

SET @sSQL2 = N'

SELECT AV7000.DivisionID, AV7000.ObjectID, AV7000.ObjectName, AV7000.TranMonth, AV7000.TranYear
      , CASE WHEN AV7000.TranMonth + AV7000.TranYear * 100  = '+@Month+' + '+@Year+' * 100 THEN AV7000.D_C ELSE '''' END  as D_C
      , AV7000.EmployeeID, AV7000.EmployeeName, AV7000.I08ID, AV7000.I08Name, AV7000.I04ID, AV7000.I04Name, AV7000.InventoryID, AV7000.InventoryName,
	  ISNULL(AV7000.UnitPrice,0) AS UnitPrice,
	  CASE WHEN AV7000.TranMonth + AV7000.TranYear * 100  = '+@Month+' + '+@Year+' * 100 THEN SUM(ISNULL(AV7000.ActualQuantity,0)) ELSE 0 END AS ActualQuantity,
	  CASE WHEN AV7000.TranMonth + AV7000.TranYear * 100  = '+@Month+' + '+@Year+' * 100 THEN SUM(ISNULL(AV7000.ConvertedQuantity,0)) ELSE 0 END AS ConvertedQuantity,
	  ISNULL(#AV7002.ActualQuantity,0) AS BeginQuantity
	  FROM (
--- So du No cua tai khoan ton kho
SELECT D17.DivisionID, D17.TranMonth, D17.TranYear, D17.DebitAccountID, D17.CreditAccountID, D16.VoucherID, D16.VoucherDate, ''B'' AS D_C,  --- So du No
D16.VoucherNo,  NULL AS EmployeeID, NULL AS EmployeeName, D16.ObjectID, AT1202.ObjectName, D16.WareHouseID, I08.AnaID AS I08ID, I08.AnaName AS I08Name, I04.AnaID AS I04ID, I04.AnaName AS I04Name,
D17.InventoryID, D02.InventoryName,	ISNULL(OT1302.UnitPrice,0) AS UnitPrice, ActualQuantity, ConvertedQuantity
FROM AT2017 AS D17 WITH (NOLOCK)
INNER JOIN AT2016 AS D16 WITH (NOLOCK) ON D16.DivisionID = D17.DivisionID AND D16.VoucherID = D17.VoucherID
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (D17.DivisionID,''@@@'') AND AT1202.ObjectID = D16.ObjectID
INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D17.DivisionID,''@@@'') AND D02.InventoryID = D17.InventoryID
INNER JOIN AT1015 I04 WITH (NOLOCK) ON I04.DivisionID = D02.DivisionID AND I04.AnaID = D02.I04ID AND I04.AnaTypeID = ''I04''
INNER JOIN AT1015 I08 WITH (NOLOCK) ON I08.DivisionID = D02.DivisionID AND I08.AnaID = D02.I08ID AND I08.AnaTypeID = ''I08''
LEFT JOIN OT1302 WITH(NOLOCK) ON OT1302.DivisionID = D17.DivisionID AND OT1302.InventoryID = D17.InventoryID AND OT1302.ID = (SELECT TOP 1 ID FROM OT1301 WITH(NOLOCK) WHERE '+@Month+' + '+@Year+' * 100 BETWEEN Month(FromDate) + Year(FromDate) * 100 AND Month(ToDate) + Year(ToDate) * 100 ORDER BY FromDate DESC, ToDate DESC)
WHERE isnull(DebitAccountID,'''') <>''''

UNION ALL --- So du co hang ton kho

SELECT D17.DivisionID, D17.TranMonth, D17.TranYear, D17.DebitAccountID, D17.CreditAccountID, D16.VoucherID, D16.VoucherDate, ''B'' AS D_C,  --- So du Co
D16.VoucherNo, NULL AS EmployeeID, NULL AS EmployeeName, D16.ObjectID, AT1202.ObjectName, D16.WareHouseID, I08.AnaID AS I08ID, I08.AnaName AS I08Name, I04.AnaID AS I04ID, I04.AnaName AS I04Name,
D17.InventoryID, D02.InventoryName,	ISNULL(OT1302.UnitPrice,0) AS UnitPrice, ActualQuantity, ConvertedQuantity
FROM AT2017 AS D17 WITH (NOLOCK)
INNER JOIN AT2016 AS D16 WITH (NOLOCK) ON D16.DivisionID = D17.DivisionID AND D16.VoucherID = D17.VoucherID
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (D17.DivisionID,''@@@'') AND AT1202.ObjectID = D16.ObjectID
INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D17.DivisionID,''@@@'') AND D02.InventoryID = D17.InventoryID
INNER JOIN AT1015 I04 WITH (NOLOCK) ON I04.DivisionID = D02.DivisionID AND I04.AnaID = D02.I04ID AND I04.AnaTypeID = ''I04''
INNER JOIN AT1015 I08 WITH (NOLOCK) ON I08.DivisionID = D02.DivisionID AND I08.AnaID = D02.I08ID AND I08.AnaTypeID = ''I08''
LEFT JOIN OT1302 WITH(NOLOCK) ON OT1302.DivisionID = D17.DivisionID AND OT1302.InventoryID = D17.InventoryID AND OT1302.ID = (SELECT TOP 1 ID FROM OT1301 WITH(NOLOCK) WHERE '+@Month+' + '+@Year+' * 100 BETWEEN Month(FromDate) + Year(FromDate) * 100 AND Month(ToDate) + Year(ToDate) * 100 ORDER BY FromDate DESC, ToDate DESC)
WHERE ISNULL(CreditAccountID,'''') <>'''' '

SET @sSQL3 = N'

UNION ALL  -- nhap kho

SELECT D07.DivisionID, D07.TranMonth, D07.TranYear, D07.DebitAccountID, D07.CreditAccountID, D06.VoucherID, D06.VoucherDate, ''D'' AS D_C,  --- Phat sinh No
D06.VoucherNo, D06.EmployeeID, AT1103.FullName AS EmployeeName, D06.ObjectID, AT1202.ObjectName, D06.WareHouseID, I08.AnaID AS I08ID, I08.AnaName AS I08Name, I04.AnaID AS I04ID, I04.AnaName AS I04Name,
D07.InventoryID, D02.InventoryName, ISNULL(OT1302.UnitPrice,0) AS UnitPrice, ActualQuantity, ConvertedQuantity
FROM AT2007 AS D07 WITH (NOLOCK)
INNER JOIN AT2006 D06 WITH (NOLOCK) ON D06.DivisionID = D07.DivisionID AND D06.VoucherID = D07.VoucherID
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (D07.DivisionID,''@@@'') AND AT1202.ObjectID = D06.ObjectID
INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D07.DivisionID,''@@@'') AND D02.InventoryID = D07.InventoryID
INNER JOIN AT1015 I04 WITH (NOLOCK) ON I04.DivisionID = D02.DivisionID AND I04.AnaID = D02.I04ID AND I04.AnaTypeID = ''I04''
INNER JOIN AT1015 I08 WITH (NOLOCK) ON I08.DivisionID = D02.DivisionID AND I08.AnaID = D02.I08ID AND I08.AnaTypeID = ''I08''
LEFT JOIN AT1103 WITH(NOLOCK) ON AT1103.DivisionID = D06.DivisionID AND AT1103.EmployeeID = D06.EmployeeID
LEFT JOIN OT1302 WITH(NOLOCK) ON OT1302.DivisionID = D07.DivisionID AND OT1302.InventoryID = D07.InventoryID AND OT1302.ID = (SELECT TOP 1 ID FROM OT1301 WITH(NOLOCK) WHERE '+@Month+' + '+@Year+' * 100 BETWEEN Month(FromDate) + Year(FromDate) * 100 AND Month(ToDate) + Year(ToDate) * 100 ORDER BY FromDate DESC, ToDate DESC)
WHERE D06.KindVoucherID in (1,3,5,7,9,15,17) AND Isnull(D06.TableID,'''') <> ''AT0114''

UNION ALL  -- xuat kho

SELECT D07.DivisionID, D07.TranMonth, D07.TranYear, D07.DebitAccountID, D07.CreditAccountID, D06.VoucherID, D06.VoucherDate, ''C'' AS D_C,  --- Phat sinh Co
D06.VoucherNo, D06.EmployeeID, AT1103.FullName AS EmployeeName, D06.ObjectID, AT1202.ObjectName, D06.WareHouseID, I08.AnaID AS I08ID, I08.AnaName AS I08Name, I04.AnaID AS I04ID, I04.AnaName AS I04Name,
D07.InventoryID, D02.InventoryName, ISNULL(OT1302.UnitPrice,0) AS UnitPrice, ActualQuantity, ConvertedQuantity
FROM AT2007 AS D07 WITH (NOLOCK)
INNER JOIN AT2006 D06 WITH (NOLOCK) ON D06.DivisionID = D07.DivisionID AND D06.VoucherID = D07.VoucherID
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (D07.DivisionID,''@@@'') AND AT1202.ObjectID = D06.ObjectID
INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D07.DivisionID,''@@@'') AND D02.InventoryID = D07.InventoryID
INNER JOIN AT1015 I04 WITH (NOLOCK) ON I04.DivisionID = D02.DivisionID AND I04.AnaID = D02.I04ID AND I04.AnaTypeID = ''I04''
INNER JOIN AT1015 I08 WITH (NOLOCK) ON I08.DivisionID = D02.DivisionID AND I08.AnaID = D02.I08ID AND I08.AnaTypeID = ''I08''
LEFT JOIN AT1103 WITH(NOLOCK) ON AT1103.DivisionID = D06.DivisionID AND AT1103.EmployeeID = D06.EmployeeID
LEFT JOIN OT1302 WITH(NOLOCK) ON OT1302.DivisionID = D07.DivisionID AND OT1302.InventoryID = D07.InventoryID AND OT1302.ID = (SELECT TOP 1 ID FROM OT1301 WITH(NOLOCK) WHERE '+@Month+' + '+@Year+' * 100 BETWEEN Month(FromDate) + Year(FromDate) * 100 AND Month(ToDate) + Year(ToDate) * 100 ORDER BY FromDate DESC, ToDate DESC)
WHERE D06.KindVoucherID in (2,3,4,6,8,10,14,20) ) AV7000
LEFT JOIN #AV7002 ON #AV7002.DivisionID = AV7000.DivisionID AND #AV7002.InventoryID = AV7000.InventoryID
LEFT JOIN AT1103 ON AT1103.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1103.EmployeeID = AV7000.EmployeeID
WHERE '+@sWhere+'
	   AND ObjectID '+@StrObjectID+' 
	   AND AV7000.I08ID '+@StrI08ID+'
	   AND CASE WHEN AT1103.EmployeeID = AV7000.EmployeeID THEN AT1103.Disabled ELSE 0 END = 0
	   AND AV7000.TranMonth + AV7000.TranYear * 100  <= '+@Month+' + '+@Year+' * 100
	   AND (ISNULL(#AV7002.ActualQuantity,0) <> 0 OR ISNULL(AV7000.ActualQuantity,0) <> 0)
GROUP BY AV7000.DivisionID, AV7000.ObjectID, AV7000.ObjectName, AV7000.TranMonth, AV7000.TranYear, AV7000.D_C, AV7000.EmployeeID, AV7000.EmployeeName, AV7000.I08ID, AV7000.I08Name, AV7000.I04ID, AV7000.I04Name,AV7000.InventoryID, AV7000.InventoryName, AV7000.UnitPrice, #AV7002.ActualQuantity
ORDER BY AV7000.I08ID, AV7000.I04ID, AV7000.InventoryID'

--PRINT @sSQL
--PRINT @sSQL1
--PRINT @sSQL2
--PRINT @sSQL3
EXEC (@sSQL + @sSQL1 + @sSQL2 + @sSQL3)

END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO