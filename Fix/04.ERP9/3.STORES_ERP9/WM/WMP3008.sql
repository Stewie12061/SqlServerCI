IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP3008]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP3008]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



--- Created by Phương Thảo on 08/12/2022:  [2022/12/TA/0010] Báo cáo tồn kho theo nhà phân phối (BẢO BẢO AN(BBA))
--- Modified by Phương Thảo on 09/12/2022: update cho chọn tất cả nhà phân phối
--- Modified by Phương Thảo on 09/12/2022: update group mã mặt hàng khi cho chọn tất cả nhà phân phối
--- Modified by Phương Thảo on 09/01/2023: Update group theo nhà phân phối khi cho chọn tất cả nhà phân phối 
--- Modified by Phương Thảo on 10/01/2023: Update lấy bảng giá theo division
--- Modified by Thành Sang  on 13/04/2023: Sửa lại cách lấy số lượng cuối kỳ



 

CREATE PROCEDURE [dbo].[WMP3008] 
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
		@sSQL4 NVARCHAR(MAX) = '',
		@sWhere NVARCHAR(MAX) = '',
		@StrObjectID	NVARCHAR(MAX),
		@StrI08ID	NVARCHAR(MAX),
		@Month NVARCHAR (10),
		@Year NVARCHAR (10),
		@OrderBy NVARCHAR(MAX) = ''

SET @OrderBy = N'ORDER BY AV7000.WareHouseID, AV7000.I08ID, AV7000.I04ID, AV7000.InventoryID'
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
	SET @StrObjectID = N' LIKE N''%'''
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
SELECT DivisionID, ''B'' AS D_C, I08ID, I08Name, I04ID, I04Name,InventoryID, InventoryName, ObjectID, WareHouseID, --lây thêm để group theo NPP
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
LEFT JOIN OT1302 WITH(NOLOCK) ON OT1302.DivisionID = D17.DivisionID AND OT1302.InventoryID = D17.InventoryID AND OT1302.ID = (SELECT TOP 1 ID FROM OT1301 WITH(NOLOCK) WHERE ('+@Month+' + '+@Year+' * 100 BETWEEN Month(FromDate) + Year(FromDate) * 100 AND Month(ToDate) + Year(ToDate) * 100) and OT1301.DivisionID ='''+@DivisionID+''' )
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
LEFT JOIN OT1302 WITH(NOLOCK) ON OT1302.DivisionID = D17.DivisionID AND OT1302.InventoryID = D17.InventoryID AND OT1302.ID = (SELECT TOP 1 ID FROM OT1301 WITH(NOLOCK) WHERE ('+@Month+' + '+@Year+' * 100 BETWEEN Month(FromDate) + Year(FromDate) * 100 AND Month(ToDate) + Year(ToDate) * 100) and OT1301.DivisionID ='''+@DivisionID+''' )
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
LEFT JOIN OT1302 WITH(NOLOCK) ON OT1302.DivisionID = D07.DivisionID AND OT1302.InventoryID = D07.InventoryID AND OT1302.ID = (SELECT TOP 1 ID FROM OT1301 WITH(NOLOCK) WHERE ('+@Month+' + '+@Year+' * 100 BETWEEN Month(FromDate) + Year(FromDate) * 100 AND Month(ToDate) + Year(ToDate) * 100) and OT1301.DivisionID ='''+@DivisionID+''' )
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
LEFT JOIN OT1302 WITH(NOLOCK) ON OT1302.DivisionID = D07.DivisionID AND OT1302.InventoryID = D07.InventoryID AND OT1302.ID = (SELECT TOP 1 ID FROM OT1301 WITH(NOLOCK) WHERE ('+@Month+' + '+@Year+' * 100 BETWEEN Month(FromDate) + Year(FromDate) * 100 AND Month(ToDate) + Year(ToDate) * 100) and OT1301.DivisionID ='''+@DivisionID+''' )
WHERE D06.KindVoucherID in (2,3,4,6,8,10,14,20) ) AV7000
WHERE '+@sWhere+'
	   AND ObjectID '+@StrObjectID+' 
	   AND CASE WHEN '+@Month+' = (SELECT TOP 1 BeginMonth FROM AT1101 WITH(NOLOCK) WHERE DivisionID = '''+@DivisionID+''') AND  --Nếu là kì đầu tiên +1 để lấy được số dư đầu kì(ActualQuantity)
					 '+@Year+' = (SELECT TOP 1 BeginYear FROM AT1101 WITH(NOLOCK) WHERE DivisionID = '''+@DivisionID+''') 
		   THEN ('+@Month+' + '+@Year+' * 100) + 1
		   ELSE '+@Month+' + '+@Year+' * 100 END > TranMonth + TranYear * 100
GROUP BY DivisionID, I08ID, I08Name, I04ID, I04Name,InventoryID, InventoryName, ObjectID, UnitPrice, WarehouseID'

SET @sSQL2 = N'

SELECT AV7000.DivisionID, AV7000.ObjectID, AV7000.ObjectName, AV7000.TranMonth, AV7000.TranYear, AV7000.D_C, AV7000.EmployeeID, AV7000.EmployeeName, AV7000.I08ID, AV7000.I08Name, AV7000.I04ID, AV7000.I04Name, 
	  AV7000.WareHouseID, AV7000.InventoryID, AV7000.InventoryName,
	  ISNULL(AV7000.UnitPrice,0) AS UnitPrice,
	  CASE WHEN AV7000.TranMonth + AV7000.TranYear * 100  = '+@Month+' + '+@Year+' * 100 THEN SUM(ISNULL(AV7000.ActualQuantity,0)) ELSE 0 END AS ActualQuantity,
	  CASE WHEN AV7000.D_C = ''D'' AND (AV7000.TranMonth + AV7000.TranYear * 100  = '+@Month+' + '+@Year+' * 100) THEN  SUM(ISNULL(AV7000.ActualQuantity,0)) ELSE 0 END AS DebitActualQuantity,
	  CASE WHEN AV7000.D_C = ''C'' AND (AV7000.TranMonth + AV7000.TranYear * 100  = '+@Month+' + '+@Year+' * 100) THEN  SUM(ISNULL(AV7000.ActualQuantity,0)) ELSE 0 END AS CreditActualQuantity,
	  CASE WHEN AV7000.TranMonth + AV7000.TranYear * 100  = '+@Month+' + '+@Year+' * 100 THEN SUM(ISNULL(AV7000.ConvertedQuantity,0)) ELSE 0 END AS ConvertedQuantity,
	  (SELECT SUM(ISNULL(#AV7002.ActualQuantity,0)) --lấy số đầu kì theo kho
	   FROM #AV7002 
	   WHERE #AV7002.DivisionID = AV7000.DivisionID 
			 AND #AV7002.InventoryID = AV7000.InventoryID 
			 AND #AV7002.ObjectID = AV7000.ObjectID 
			 AND #AV7002.WareHouseID = AV7000.WareHouseID) AS BeginQuantity
	  INTO #AV7000Temp
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
LEFT JOIN OT1302 WITH(NOLOCK) ON OT1302.DivisionID = D17.DivisionID AND OT1302.InventoryID = D17.InventoryID AND OT1302.ID = (SELECT TOP 1 ID FROM OT1301 WITH(NOLOCK) WHERE ('+@Month+' + '+@Year+' * 100 BETWEEN Month(FromDate) + Year(FromDate) * 100 AND Month(ToDate) + Year(ToDate) * 100) and OT1301.DivisionID ='''+@DivisionID+''' )
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
INNER JOIN AT1015 I08 WITH (NOLOCK) ON I08.DivisionID = D02.DivisionID AND I08.AnaID = D02.I08ID AND I08.AnaTypeID = ''I08'''

SET @sSQL3 = N' 
LEFT JOIN OT1302 WITH(NOLOCK) ON OT1302.DivisionID = D17.DivisionID AND OT1302.InventoryID = D17.InventoryID AND OT1302.ID = (SELECT TOP 1 ID FROM OT1301 WITH(NOLOCK) WHERE ('+@Month+' + '+@Year+' * 100 BETWEEN Month(FromDate) + Year(FromDate) * 100 AND Month(ToDate) + Year(ToDate) * 100) and OT1301.DivisionID ='''+@DivisionID+''' )
WHERE ISNULL(CreditAccountID,'''') <>''''

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
LEFT JOIN OT1302 WITH(NOLOCK) ON OT1302.DivisionID = D07.DivisionID AND OT1302.InventoryID = D07.InventoryID AND OT1302.ID = (SELECT TOP 1 ID FROM OT1301 WITH(NOLOCK) WHERE ('+@Month+' + '+@Year+' * 100 BETWEEN Month(FromDate) + Year(FromDate) * 100 AND Month(ToDate) + Year(ToDate) * 100) and OT1301.DivisionID ='''+@DivisionID+''' )
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
LEFT JOIN OT1302 WITH(NOLOCK) ON OT1302.DivisionID = D07.DivisionID AND OT1302.InventoryID = D07.InventoryID AND OT1302.ID = (SELECT TOP 1 ID FROM OT1301 WITH(NOLOCK) WHERE ('+@Month+' + '+@Year+' * 100 BETWEEN Month(FromDate) + Year(FromDate) * 100 AND Month(ToDate) + Year(ToDate) * 100) and OT1301.DivisionID ='''+@DivisionID+''' )
WHERE D06.KindVoucherID in (2,3,4,6,8,10,14,20) ) AV7000
--LEFT JOIN #AV7002 ON #AV7002.DivisionID = AV7000.DivisionID AND #AV7002.InventoryID = AV7000.InventoryID AND #AV7002.ObjectID = AV7000.ObjectID
WHERE '+@sWhere+'
	   AND AV7000.ObjectID '+@StrObjectID+' 
	   AND AV7000.I08ID '+@StrI08ID+'
	   AND AV7000.TranMonth + AV7000.TranYear * 100  <= '+@Month+' + '+@Year+' * 100
GROUP BY AV7000.DivisionID, AV7000.ObjectID, AV7000.ObjectName, AV7000.TranMonth, AV7000.TranYear, AV7000.D_C, AV7000.EmployeeID, AV7000.EmployeeName, AV7000.I08ID, AV7000.I08Name, AV7000.I04ID, AV7000.I04Name,
AV7000.WareHouseID, AV7000.InventoryID, AV7000.InventoryName, AV7000.UnitPrice
'+@OrderBy+''

SET @sSQL4 = N'

SELECT DISTINCT NULL AS IndexNumber, ObjectID  --group theo NPP
INTO #TEMP
FROM #AV7000temp

SELECT ROW_NUMBER() OVER (ORDER BY ObjectID) AS IndexNumber, ObjectID --group theo NPP
INTO #ObjectID
FROM #TEMP

Declare @TotalRow INT,
		@counter INT = 1

SET @TotalRow = (SELECT Count(ObjectID) FROM #ObjectID) -- group theo NPP

WHILE @counter <= @TotalRow
BEGIN
	SELECT 
	ObjectID,
	ObjectName,
	I08ID, I08Name,	InventoryID, InventoryName, UnitPrice,
	SUM(BeginQuantity) AS BeginQuantity,
	SUM(CreditActualQuantity) AS CreditActualQuantity,
	SUM(DebitActualQuantity) AS DebitActualQuantity,
	(SUM(BeginQuantity) + SUM(DebitActualQuantity) - SUM(CreditActualQuantity)) as EndQuantity,
	--SUM(EndQuantity) AS EndQuantity,
	SUM(EndAmount) AS EndAmount,
	SUM(BeginProQuantity) AS BeginProQuantity,
	SUM(CreditProActualQuantity) AS CreditProActualQuantity,
	SUM(DebitProActualQuantity) AS DebitProActualQuantity,
	(SUM(BeginProQuantity) + SUM(DebitProActualQuantity) - SUM(CreditProActualQuantity)) as EndProQuantity,
	--SUM(EndProQuantity) AS EndProQuantity,
	SUM(EndProAmount) AS EndProAmount
	FROM (
		SELECT	AVTemp.DivisionID, AVTemp.ObjectID, AVTemp.ObjectName, AVTemp.TranMonth, AVTemp.TranYear, AVTemp.D_C, AVTemp.EmployeeID, AVTemp.EmployeeName, AVTemp.I08ID, AVTemp.I08Name, AVTemp.I04ID,					  AVTemp.I04Name, AVTemp.WareHouseID, AVTemp.InventoryID, AVTemp.InventoryName, ISNULL(AVTemp.UnitPrice,0) AS UnitPrice, AVTemp.ConvertedQuantity,
				CASE WHEN AVTemp.WareHouseID = ''BBA-SO''THEN ISNULL(AVTemp.BeginQuantity,0) ELSE 0 END AS BeginQuantity,
				CASE WHEN AVTemp.WareHouseID = ''BBA-SO'' THEN ISNULL(AVTemp.DebitActualQuantity,0) ELSE 0 END AS DebitActualQuantity,
				CASE WHEN AVTemp.WareHouseID = ''BBA-SO'' THEN ISNULL(AVTemp.CreditActualQuantity,0) ELSE 0 END AS CreditActualQuantity,
				CASE WHEN AVTemp.WareHouseID = ''BBA-SO''THEN (AVTemp.BeginQuantity + AVTemp.DebitActualQuantity) - AVTemp.CreditActualQuantity ELSE 0 END AS EndQuantity,
				CASE WHEN AVTemp.WareHouseID = ''BBA-SO''THEN ((AVTemp.BeginQuantity + AVTemp.DebitActualQuantity) - AVTemp.CreditActualQuantity) * AVTemp.UnitPrice ELSE 0 END AS EndAmount,
				CASE WHEN AVTemp.WareHouseID = ''BBA-SO-KM''THEN ISNULL(AVTemp.BeginQuantity,0) ELSE 0 END AS BeginProQuantity,
				CASE WHEN AVTemp.WareHouseID = ''BBA-SO-KM'' THEN ISNULL(AVTemp.DebitActualQuantity,0) ELSE 0 END AS DebitProActualQuantity,
				CASE WHEN AVTemp.WareHouseID = ''BBA-SO-KM'' THEN ISNULL(AVTemp.CreditActualQuantity,0) ELSE 0 END AS CreditProActualQuantity,
				CASE WHEN AVTemp.WareHouseID = ''BBA-SO-KM''THEN (AVTemp.BeginQuantity + AVTemp.DebitActualQuantity) - AVTemp.CreditActualQuantity ELSE 0 END AS EndProQuantity,
				CASE WHEN AVTemp.WareHouseID = ''BBA-SO-KM''THEN ((AVTemp.BeginQuantity + AVTemp.DebitActualQuantity) - AVTemp.CreditActualQuantity) * AVTemp.UnitPrice ELSE 0 END AS EndProAmount
		FROM #AV7000temp AVTemp
	) A
	WHERE ObjectID = (SELECT ObjectID FROM #ObjectID WHERE IndexNumber = @counter)
	Group by ObjectID, ObjectName, I08ID, I08Name, InventoryID, InventoryName, UnitPrice -- group theo NPP
	Order By A.ObjectID, I08ID, InventoryID

	SET @counter = @counter + 1
END


'

--PRINT @sSQL
--PRINT @sSQL1
--PRINT @sSQL2
--PRINT @sSQL3
--PRINT @sSQL4
EXEC (@sSQL + @sSQL1 + @sSQL2 + @sSQL3 + @sSQL4)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO