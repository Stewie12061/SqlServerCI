IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0028]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0028]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





--- Created by Bảo Anh	Date: 30/09/2013
--- Purpose: Load master đơn hàng bán
--- Modify on 04/08/2014 by Bảo Anh: Bổ sung IsSalesCommission (Sinolife)
--- Modified on 29/06/2015 by Lê Thị Hạnh: Bổ sung ImpactLevel
--- Modify on 15/06/2015 by Hoàng Vũ: Bổ sung trường OrderTypeID (Secoin), Dữ liệu kế thừa Master vào trường InheritSOrderID
--- Modify on 15/01/2016 by Hoàng Vũ: Bổ sung trường RouteID, RouteName, IsInvoice (Hoàng Trần)
--- Modified by Tiểu Mai on 22/01/2016: Bổ sung trường DiscountAmountSOrder, DiscountPercentSOrder, DiscountSalesAmount
--- Modified by Tiểu Mai on 05/05/2016: Bổ sung trường ShipAmount
--- EXEC OP0028 'AS','CT/12/2015/0002'
--- Modify on 01/02/2016 by Hoàng Vũ: Bổ sung trường cần name cần thiết (Hoàng Trần)
--- Modify on 12/05/2017 by THị Phượng: Bổ sung thay đổi cách lấy CreateUserID và LastModifyUserID
--- Modified on 12/05/2017 by Tiểu Mai: Bổ sung with (nolock) và chỉnh sửa danh mục dùng chung
--- Modified on 29/05/2019 by Trà Giang: Bổ sung thông tin số điện thoại đối tượng 
--- Modified on 09/07/2020 by Kiều Nga: Bổ sung thông tin ngày tàu chạy customize MaiThu
--- Modified on 12/08/2020 by Đức Thông: Bổ sung trường số chứng từ trên APP
--- Modified on 17/08/2020 by Đình Ly: Bổ sung trường TaskID, TaskName
--- Modified on 30/08/2020 by Đình Hoà: Bổ sung điều kiện Division dùng chung(@@@) cho AT1205 (line 155)
--- Modified on 09/02/2022 by Nhựt Trường: Bổ sung các trường Ana..Name.
--- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
--- Modified by Anh Đô on 21/04/2023: Hiển thị 'Tất cả' thay cho '%' ở cột InventoryTypeName
--- Modified by Tấn Lộc on 05/07/2023: Fix lỗi trường hợp khi tạo Đơn hàng sell in chọn người duyệt là những user dùng chung @@@
--- Modified by Thanh Lượng on 30/11/2023: [2023/11/TA/0176] - Customize nghiệp vụ duyệt đồng cấp đơn hàng bán (KH GREE)

CREATE PROCEDURE [dbo].[OP0028] 
(
	@DivisionID nvarchar(50),
	@SOrderID nvarchar(50),
	@APKMaster VARCHAR(50) = '',
	@Type VARCHAR(50) = ''
)
AS

Declare @sSQL1 AS nvarchar(max),
		@sSQL2 AS nvarchar(max),
		@InventoryTypeName AS nvarchar(max),
		@Swhere  Nvarchar(max) = '',
		@Level INT,
		@sSQLSL NVARCHAR (MAX) = '',
		@i INT = 1, @s VARCHAR(2),@s2 VARCHAR(2),
		@sSQLJon NVARCHAR (MAX) = '',
		@strPromoteIDList NVARCHAR(MAX) = '',
		@SameLevels INT


IF ISNULL(@Type, '') = 'DHB' 
BEGIN
SET @Swhere = @Swhere + 'AND CONVERT(VARCHAR(50),OT2001.APKMaster_9000)= '''+@APKMaster+''''
SELECT @Level = MAX(Level) FROM OOT9001 WITH (NOLOCK) WHERE APKMaster = @APKMaster -- số Cấp duyệt chuẩn
SELECT @SameLevels = ISNULL(MAX(SameLevels),0) FROM OOT9001 WITH (NOLOCK) WHERE APKMaster = @APKMaster --số Cấp duyệt đồng cấp
END
ELSE 
BEGIN
SET @Swhere = @Swhere + 'AND OT2001.SOrderID = '''+@SOrderID+''''
SELECT @Level = MAX(Level) FROM OOT9001 WITH (NOLOCK) LEFT JOIN OT2001 ON OOT9001.APKMaster = OT2001.APKMaster_9000  WHERE OT2001.SOrderID = @SOrderID
SELECT @SameLevels = ISNULL(MAX(SameLevels),0) FROM OOT9001 WITH (NOLOCK) LEFT JOIN OT2001 ON OOT9001.APKMaster = OT2001.APKMaster_9000  WHERE OT2001.SOrderID = @SOrderID --số Cấp duyệt đồng cấp
END

	WHILE @i <= @Level
	BEGIN
		IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
		ELSE SET @s = CONVERT(VARCHAR, @i)
		IF(@i <= @SameLevels)
		SET @sSQLSL=@sSQLSL+' , ApprovePerson'+@s+'ID ApproveCheckPerson'+@s+'ID, ApprovePerson'+@s+'Name ApproveCheckPerson'+@s+'Name, 
		ApprovePerson'+@s+'Status ApproveCheckPerson'+@s+'Status, ApprovePerson'+@s+'StatusName ApproveCheckPerson'+@s+'StatusName, ApprovePerson'+@s+'Note ApproveCheckPerson'+@s+'Note'
		ELSE		
		BEGIN
		IF @i < 10 SET @s2 = '0' + CONVERT(VARCHAR, @i - @SameLevels)
		ELSE SET @s2 = CONVERT(VARCHAR, @i - @SameLevels)
		SET @sSQLSL=@sSQLSL+' , ApprovePerson'+@s+'ID as ApprovePerson'+@s2+'ID, ApprovePerson'+@s+'Name as ApprovePerson'+@s2+'Name, 
		ApprovePerson'+@s+'Status ApprovePerson'+@s2+'Status, ApprovePerson'+@s+'StatusName ApprovePerson'+@s2+'StatusName, 
		ApprovePerson'+@s+'Note ApprovePerson'+@s2+'Note'
		END		
		SET @sSQLJon =@sSQLJon+ '
						LEFT JOIN (SELECT ApprovePersonID ApprovePerson'+@s+'ID,OOT1.APKMaster,OOT1.DivisionID,OOT1.Status,
						 HT14.FullName As ApprovePerson'+@s+'Name, 
						OOT1.Status ApprovePerson'+@s+'Status, O99.Description ApprovePerson'+@s+'StatusName,
						OOT1.Note ApprovePerson'+@s+'Note
						FROM OOT9001 OOT1 WITH (NOLOCK)
						INNER JOIN AT1103 HT14 WITH (NOLOCK) ON HT14.DivisionID IN (OOT1.DivisionID,''@@@'') AND HT14.EmployeeID=OOT1.ApprovePersonID
						LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1=ISNULL(OOT1.Status,0) AND O99.CodeMaster=''Status''
						WHERE OOT1.Level='+STR(@i)+'
						)APP'+@s+' ON APP'+@s+'.DivisionID= OOT90.DivisionID  AND APP'+@s+'.APKMaster=OOT90.APK'
		SET @i = @i + 1		
	END		
print @Level
SET @sSQL1 =N' 
SELECT	TOP 1
		CASE
			WHEN (CONCAT(SOT0088.BusinessChild, '','')) LIKE '',%,'' THEN SUBSTRING((CONCAT(SOT0088.BusinessChild, '','')), 2, LEN((CONCAT(SOT0088.BusinessChild, '','')))-2)
			WHEN (CONCAT(SOT0088.BusinessChild, '','')) LIKE '',%''  THEN RIGHT((CONCAT(SOT0088.BusinessChild, '','')), LEN((CONCAT(SOT0088.BusinessChild, '','')))-1)
			WHEN (CONCAT(SOT0088.BusinessChild, '','')) LIKE ''%,''  THEN LEFT((CONCAT(SOT0088.BusinessChild, '','')), LEN((CONCAT(SOT0088.BusinessChild, '','')))-1)
			ELSE (CONCAT(SOT0088.BusinessChild, '',''))
		END AS PromoteIDList,
		OT2001.DivisionID, AT1101.DivisionName,
		OT2001.SOrderID, 
		OT2001.VoucherTypeID, A13.VoucherTypeName,
		OT2001.VoucherNo,
		OT2001.VoucherNoApp,
		OT2001.TranMonth, 
		OT2001.TranYear,
		convert(varchar(20), OT2001.OrderDate, 120) as OrderDate, 
		OT2001.ContractNo, 
		OT2001.ContractDate, 
		OT2001.InventoryTypeID,
		CASE WHEN ISNULL(OT2001.InventoryTypeID, '''') = ''%'' THEN (SELECT Name FROM A00001 WHERE ID = ''A00.All'' AND LanguageID = ''vi-VN'')
			ELSE AT1301.InventoryTypeName END 
		AS InventoryTypeName,
		OT2001.CurrencyID, AT1004.CurrencyName,
		OT2001.ExchangeRate,  
		OT2001.PaymentID,
		OT2001.ObjectID,  
		ISNULL(OT2001.ObjectName, AT1202.ObjectName)   AS ObjectName, 
		ISNULL(OT2001.VatNo, AT1202.VatNo)  AS VATNo, 
		AT1202.Tel,
		ISNULL( OT2001.Address, AT1202.Address)  AS Address,
		OT2001.DeliveryAddress, 
		OT2001.ClassifyID, OT1001.ClassifyName,
		OT2001.InheritSOrderID, --Kế thừa dữ liệu từ đơn hàng bán
		OT2001.EmployeeID,  A02.FullName as EmployeeName,
		OT2001.Transport, 
		AT1202.IsUpdateName,
		OT2001.Notes, 
		OT2001.Disabled, A92.Description as DisabledName,
		OT2001.OrderStatus, A91.Description as OrderStatusName,
		OT2001.QuotationID, 
		OT2001.OrderType,
		OT2001.OrderTypeID,--Customize secoin phân biệt đơn hàng bán và đơn hàng điều chỉnh
		Ana01ID, 
		Ana02ID, 
		Ana03ID, 
		Ana04ID, 
		Ana05ID,
		S01.AnaName AS Ana01Name,
		S02.AnaName AS Ana02Name,
		S03.AnaName AS Ana03Name,
		S04.AnaName AS Ana04Name,
		S05.AnaName AS Ana05Name,
		OT2001.SalesManID, A01.FullName as SalesManName,
		OT2001.SalesMan2ID,
		ShipDate,
		OT2001.DueDate, 
		OT2001.PaymentTermID,
		OT2001.Contact,
		OT2001.VATObjectID,
		ISNULL(OT2001.VATObjectName,T02.ObjectName) AS  VATObjectName,
		OT2001.PriceListID, O1.Description as PriceListName,
		OT2001.varchar01, OT2001.varchar02, OT2001.varchar03, OT2001.varchar04, OT2001.varchar05,
		OT2001.varchar06, OT2001.varchar07, OT2001.varchar08, OT2001.varchar09, OT2001.varchar10,
		OT2001.varchar11, OT2001.varchar12, OT2001.varchar13, OT2001.varchar14, OT2001.varchar15,
		OT2001.varchar16, OT2001.varchar17, OT2001.varchar18, OT2001.varchar19, OT2001.varchar20,
		OT2001.IsPrinted, OT2001.IsSalesCommission, ISNULL(OT2001.ImpactLevel,0) AS ImpactLevel, A93.Description as ImpactLevelName,
		OT2001.RouteID,CT0143.RouteName,
		Isnull(OT2001.IsInvoice, 0) as IsInvoice, Isnull(A94.Description, N''Không'') as  IsInvoiceName,
		OT2001.DiscountAmountSOrder, OT2001.DiscountPercentSOrder, OT2001.DiscountSalesAmount,
		OT2001.CreateUserID +''_''+ A1.FullName as CreateUserID,
		OT2001.CreateDate,
		OT2001.LastModifyUserID +''_''+ A2.FullName as LastModifyUserID,
		OT2001.LastModifyDate,
		OT2001.ShipAmount, AT1208.PaymentTermName, AT1205.PaymentName, OT2001.APKMaster_9000,OT2001.IsShipDate,OT2001.ShipStartDate,OT2001.TaskID,D24.TaskName,
		OT2001.ContactorID,CR1.ContactName AS ContactorName,CR1.TitleContact AS DutyID, A18.APK AS APKOT2003
'+@sSQLSL+''

SET @sSQL2 =N' 
FROM	OT2001 WITH (NOLOCK)
LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON OT2001.APKMaster_9000 = OOT90.APK
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = OT2001.ObjectID
LEFT JOIN AT1202 T02 WITH (NOLOCK) ON T02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T02.ObjectID = OT2001.VATObjectID
Left join CT0143 WITH (NOLOCK) on OT2001.RouteID = CT0143.RouteID
Left join AT1103 A01 WITH (NOLOCK) on A01.EmployeeID = OT2001.SalesManID
Left join AT1103 A02 WITH (NOLOCK) on A02.EmployeeID = OT2001.EmployeeID
Left join AT1004 WITH (NOLOCK) on OT2001.CurrencyID = AT1004.CurrencyID
Left join AT0099 A91 WITH (NOLOCK) on OT2001.OrderStatus = A91.ID and A91.CodeMaster = ''AT00000003''
Left join AT0099 A92 WITH (NOLOCK) on OT2001.Disabled = A92.ID and A92.CodeMaster = ''AT00000004''
Left join AT0099 A93 WITH (NOLOCK) on OT2001.ImpactLevel = A93.ID and A93.CodeMaster = ''AT00000006''
Left join AT0099 A94 WITH (NOLOCK) on OT2001.IsInvoice = A94.ID and A94.CodeMaster = ''AT00000004''
Left join AT1301 WITH (NOLOCK) on OT2001.InventoryTypeID = AT1301.InventoryTypeID
LEFT JOIN AT1208 WITH (NOLOCK) ON AT1208.PaymentTermID = OT2001.PaymentTermID AND AT1208.DivisionID = OT2001.DivisionID
LEFT JOIN AT1205 WITH (NOLOCK) ON AT1205.PaymentID = OT2001.PaymentID AND AT1205.DivisionID IN (OT2001.DivisionID, ''@@@'')
LEFT JOIN OT1001 WITH (NOLOCK) ON OT1001.ClassifyID = OT2001.ClassifyID AND OT1001.DivisionID = OT2001.DivisionID
Left join AT1103 A1 WITH (NOLOCK) on A1.EmployeeID = OT2001.CreateUserID
Left join AT1103 A2 WITH (NOLOCK) on A2.EmployeeID = OT2001.LastModifyUserID
Left join OT1301 O1 WITH (NOLOCK) on OT2001.PriceListID = O1.ID
Left join AT1101 WITH (NOLOCK) on OT2001.DivisionID = AT1101.DivisionID
Left join AT1007 A13 WITH (NOLOCK) on OT2001.VoucherTypeID = A13.VoucherTypeID
Left join OOT2110 D24 With (NOLOCK) on OT2001.TaskID = D24.TaskID and OT2001.DivisionID = D24.DivisionID
LEFT JOIN OT1002 S01 WITH (NOLOCK) on S01.DivisionID = OT2001.DivisionID AND S01.AnaID = OT2001.Ana01ID AND S01.AnaTypeID = ''S01''
LEFT JOIN OT1002 S02 WITH (NOLOCK) on S02.DivisionID = OT2001.DivisionID AND S02.AnaID = OT2001.Ana02ID AND S02.AnaTypeID = ''S02''
LEFT JOIN OT1002 S03 WITH (NOLOCK) on S03.DivisionID = OT2001.DivisionID AND S03.AnaID = OT2001.Ana03ID AND S03.AnaTypeID = ''S03''
LEFT JOIN OT1002 S04 WITH (NOLOCK) on S04.DivisionID = OT2001.DivisionID AND S04.AnaID = OT2001.Ana04ID AND S04.AnaTypeID = ''S04''
LEFT JOIN OT1002 S05 WITH (NOLOCK) on S05.DivisionID = OT2001.DivisionID AND S05.AnaID = OT2001.Ana05ID AND S05.AnaTypeID = ''S05''
Left join CRMT10001 CR1 With (NOLOCK) on OT2001.ContactorID = CR1.ContactID and OT2001.DivisionID = CR1.DivisionID
LEFT JOIN OT2003 A18 WITH (NOLOCK) ON A18.SOrderID = OT2001.SOrderID
LEFT JOIN SOT0088 WITH (NOLOCK) ON SOT0088.APKParent = OT2001.SOrderID
'+@sSQLJon+'
WHERE	OT2001.DivisionID = ''' + @DivisionID + ''' '+@Swhere+''	

EXEC('SELECT * FROM (' + @sSQL1 + @sSQL2 + ') A')

print @sSQL1
print @sSQL2




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
