IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0011]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Loc ra cac don hang ban
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create ON 11/08/2004 by Vo Thanh Huong
---- Update Nguyen thi thuy Tuyen  25/09/2006 lay them truong Notes,notes01,notes02,contact
---- Last Update Thuy Tuyen them doi tong VAT
---- Last edit: Thuy Tuyen, date 06/06/2008 , them view OV0111 de load truy van( tach view load Edit khac view load truy van de  cai thien toc do),
---- Last edit : Thuy Tuyen 25/05/2009, 03/07/2009, 
---- Edited by: [GS] [Hoang Phuoc] [29/07/2010]
---- Last Edit : Thuy Tuyen 05/08/2009 thêm cac them so  load detail, 23/09/2009,15/10/2009,23/10/2009,04/10/2009,25/01/2009
---- Modified ON 19/09/2011 by Nguyễn Bình Minh: Bo sung bang gia
---- Modified ON 23/09/2011 by Le Thi Thu Hien : Them SalesMan2
---- Modified ON 26/10/2011 by Le Thi Thu Hien : Them 20 tham so
---- Modified ON 19/12/2011 by Le Thi Thu Hien : Bo sung them mot so truong
---- Modified ON 19/12/2011 by Le Thi Thu Hien : Bo sung @StrWhere
---- Modified ON 19/12/2011 by Le Thi Thu Hien : Bo sung cot ConvertedSalepriceInput
---- Modified ON 10/05/2012 by Thien Huynh : Bo sung 5 Khoan muc
---- Modified on 08/08/2012 by Bao Anh: Lay cac truong tham so Parameter01 -> 05
---- Modified on 13/08/2012 by Bao Anh: Lay truong dung sai
---- Modified ON 14/08/2012 by Bao Anh : Khong tru hoa hong khi tinh thanh tien truoc thue
---- Modified ON 06/09/2012 by Le Thi Thu Hien : Bo sung IsPrinted
---- Modified ON 07/09/2012 by Le Thi Thu Hien : Bổ sung điều kiện lọc trên master
---- Modified ON 07/09/2012 by Le Thi Thu Hien : Bổ sung @SOrderID
---- Modified ON 10/02/2015 by Phan thanh hoang vu: bổ sung phân quyền xem dữ liệu của người khác, và các trường lưu vết kế thừa (InheritTableID, InheritVoucherID, InheritTransactionID)
---- Modified by Quốc Tuấn on 21/08/2015: Chuyển Số lượng cần sản xuất qua cột PlanQuantity
---- Modified by Kim Vu on 23/11/2015 : Load quy cach View/Edit
---- Modified by Tiểu Mai on 06/06/2016: Bổ sung WITH (NOLOCK)
---- Modified by Tiểu Mai on 15/07/2016: Sửa lại cách lấy dữ liệu cho Angel (CustomizeIndex = 57)
---- Modified by Tiểu Mai on 26/07/2016: Bổ sung các trường mới cho ANGEL
---- Modified by Hải Long on 09/09/2016: Bổ sung các trường OT2002.Ana02IDAP, OT2002.ExportType, OT2002.NotesAP cho ANPHAT 
---- Modified by Bảo Thy on 08/09/2016: Bổ sung SOrderIDRecognition
---- Modified on 26/04/2017 by Bảo Anh: Sửa danh mục dùng chung (bỏ kết theo DivisionID)
---- Modified by Hải Long on 08/09/2017: Bổ sung các trường tính toán đvt quy đổi
---- Modified by Kim Thư on 05/11/2018: Cho phép Bê Tông kế thừa đơn hàng bán < 0 (CustomerName=80)
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

-- <Example>
--exec OP0011 'CTY',0,N'',N'55',0,0,N'',N'%',N'', N'ASOFTADMIN'

CREATE PROCEDURE [dbo].[OP0011] 
(
	@DivisionID nvarchar(50),
	@IsServer AS INT = 0,	--0 : Tim kiem Master
							-- 1 : Tim kiem Detail
	@StrWhere AS NVARCHAR(4000) = '', --Dieu kien tim kiem tren luoi 
	@ConnID AS NVARCHAR(100) = '',
	@IsPrinted AS INT = 0,	--- 0 : Không check
							--- 1 : Check đã in
							--- 2 : Check chưa in

	@Status AS INT = '',
	@ObjectID AS NVARCHAR(50) = '',
	@VoucherTypeID AS NVARCHAR(50) = '',
	@SOrderID AS NVARCHAR(50) = '',
	@UserID  AS NVARCHAR(50) = ''
	
)
AS

Declare @sSQL1 AS nvarchar(max),
		@sSQL11 AS NVARCHAR(MAX),
		@sSQL111 AS NVARCHAR(MAX),
		@sSQL2 AS nvarchar(max),
		@sSQL3 AS NVARCHAR(MAX),
		@sSQL4 AS NVARCHAR(MAX),
		@DivisionWhere AS NVARCHAR(MAX),
		@sWHERE AS NVARCHAR(MAX),
		@SWhereVoucherID AS NVARCHAR(50),
		@CustomerName INT

----------------->>>>>> Phân quyền xem chứng từ của người dùng khác		

DECLARE @sSQLPer AS NVARCHAR(MAX),

		@sWHEREPer AS NVARCHAR(MAX)

SET @sSQLPer = ''

SET @sWHEREPer = ''		

SET @sSQL11 = ''

SET @sSQL111 = ''

-- Gán customer Index
SET @CustomerName=(SELECT TOP 1 CustomerName FROM CustomerIndex)

IF EXISTS (SELECT TOP 1 1 FROM OT0001 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND IsPermissionView = 1 ) -- Nếu check Phân quyền xem dữ liệu tại Thiết lập hệ thống thì mới thực hiện

	BEGIN

		SET @sSQLPer = N' LEFT JOIN AT0010 WITH (NOLOCK) ON AT0010.DivisionID = OT2001.DivisionID 

											AND AT0010.AdminUserID = '''+@UserID+''' 

											AND AT0010.UserID = OT2001.CreateUserID '

		SET @sWHEREPer = N' AND (OT2001.CreateUserID = AT0010.UserID

								OR  OT2001.CreateUserID = '''+@UserID+''') '		

	END



-----------------<<<<<< Phân quyền xem chứng từ của người dùng khác		
			
SET @sSQL4 = ''
SET @sWHERE = ''
SET @SWhereVoucherID = ''
IF @StrWhere IS NOT NULL AND @StrWhere <> ''
BEGIN
	SET @sSQL4 = ' WHERE  ' + @StrWhere
END

IF @IsPrinted IS NOT NULL AND @IsPrinted = 1
BEGIN
	SET @sWHERE = @sWHERE + N' AND ISNULL(OT2001.IsPrinted, 0) = 1 '
END

IF @IsPrinted IS NOT NULL AND @IsPrinted = 2 
BEGIN
	SET @sWHERE = @sWHERE + N' AND ISNULL(OT2001.IsPrinted, 0) = 0 '
END

IF @ObjectID IS NOT NULL AND @ObjectID <> '' AND @ObjectID <> '%'
BEGIN
	SET @sWHERE = @sWHERE + N'	AND OT2001.ObjectID = '''+@ObjectID+'''	'
END

IF @Status IS NOT NULL
BEGIN
	SET @sWHERE = @sWHERE + N'	AND OT2001.OrderStatus = ' + STR(@Status) + ' '
END

IF @VoucherTypeID IS NOT NULL AND @VoucherTypeID <> '' AND @VoucherTypeID <> '%'
BEGIN
	SET @sWHERE = @sWHERE + N'	AND OT2001.VoucherTypeID = '''+@VoucherTypeID+''' '
END

SET @DivisionWhere = 'WHERE	OT2001.DivisionID = ''' + @DivisionID + ''''	

IF @SOrderID <> '' AND @SOrderID <> '%'
SET @SWhereVoucherID = N'
			AND OT2001.SOrderID = '''+@SOrderID+'''	'
			
----- Buoc  1 : Tra ra thong tin Master View OV0011 ( Load Edit)
SET @sSQL1 =N' 
SELECT	DISTINCT
		OT2001.SOrderID, 
		OT2001.VoucherTypeID, 
		OT2001.VoucherNo, 
		OT2001.DivisionID, 
		OT2001.TranMonth, 
		OT2001.TranYear,
		OT2001.OrderDate, 
		OT2001.ContractNo, 
		OT2001.ContractDate, 
		OT2001.InventoryTypeID, 
		InventoryTypeName,  
		OT2001.CurrencyID, 
		CurrencyName, 	
		OT2001.ExchangeRate,  
		OT2001.PaymentID, 
		OT2001.DepartmentID,  
		AT1102.DepartmentName, 
		OT2001.IsPeriod, 
		OT2001.IsPlan, 
		OT2001.ObjectID,  
		ISNULL(OT2001.ObjectName, AT1202.ObjectName)   AS ObjectName, 
		ISNULL(OT2001.VatNo, AT1202.VatNo)  AS VatNo, 
		ISNULL( OT2001.Address, AT1202.Address)  AS Address,
		OT2001.DeliveryAddress, 
		OT2001.ClassifyID, 
		ClassifyName, 
		OT2001.InheritSOrderID,
		OT2001.EmployeeID,  
		AT1103.FullName,  
		OT2001.Transport, 
		AT1202.IsUpdateName, 
		AT1202.IsCustomer, 
		AT1202.IsSupplier,
		ConvertedAmount = (SELECT Sum(ISNULL(ConvertedAmount,0)- ISNULL(DiscountConvertedAmount,0)- ISNULL(CommissionCAmount,0) +
		ISNULL(VATConvertedAmount, 0))  FROM OT2002 Where OT2002.SOrderID = OT2001.SOrderID),
		OriginalAmount = (SELECT Sum(ISNULL(OriginalAmount,0)- ISNULL(DiscountOriginalAmount,0) - ISNULL(CommissionOAmount, 0) +
		ISNULL(VAToriginalAmount, 0))  FROM OT2002 Where OT2002.SOrderID = OT2001.SOrderID),
		OT2001.Notes, 
		OT2001.Disabled, 
		OT2001.OrderStatus, 
		OV1001.LanguageID AS OrderStatusName, 
		OV1001.EDescription AS EOrderStatusName, 
		OT2001.QuotationID,
		OT2001.OrderType,  
		OV1002.Description AS OrderTypeName,
		ISNULL(OT2001.OrderTypeID, 0) AS OrderTypeID,
		OT0099.Description AS OrderTypeIDName,
		(CASE WHEN ISNULL(OT2001.OrderTypeID, 0) = 0 THEN N''Đơn hàng sản xuất'' ELSE N''Đơn hàng sản xuất điều chỉnh'' END) AS OrderTypeIDName2,		
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
		OT2001.CreateUserID, 
		OT2001.CreateDate, 
		OT2001.SalesManID, 
		AT1103_2.FullName AS SalesManName, 
		OT2001.SalesMan2ID,		
		AT1103_3.FullName AS SalesMan2Name, 
		OT2001.ShipDate, 
		OT2001.LastModifyUserID, 
		OT2001.LastModifyDate, 
		OT2001.DueDate, 
		OT2001.PaymentTermID,
		OT2001.contact,
		OT2001.VATObjectID,
		ISNULL(OT2001.VATObjectName,T02.ObjectName) AS  VATObjectName,
		OT2001.IsInherit,
		OT1102.Description AS  IsConfirm,
		OT1102.EDescription AS EIsConfirm,
		OT2001.DescriptionConfirm,OT2001.PeriodID, OT2001.PriceListID,
		CASE WHEN
		(SELECT Sum(OrderQuantity) FROM OT2002 WITH (NOLOCK) Where OT2002.SOrderID = OT2001.SOrderID AND OT2002.DivisionID = OT2001.DivisionID) <= 
		(SELECT Sum(OrderQuantity) FROM OT2002 WITH (NOLOCK) Where OT2002.RefSOrderID=OT2001.SOrderID AND OT2002.DivisionID=OT2001.DivisionID)
		THEN 1 ELSE 0 END AS IsFinish,
		OT2001.varchar01, OT2001.varchar02, OT2001.varchar03, OT2001.varchar04, OT2001.varchar05,
		OT2001.varchar06, OT2001.varchar07, OT2001.varchar08, OT2001.varchar09, OT2001.varchar10,
		OT2001.varchar11, OT2001.varchar12, OT2001.varchar13, OT2001.varchar14, OT2001.varchar15,
		OT2001.varchar16, OT2001.varchar17, OT2001.varchar18, OT2001.varchar19, OT2001.varchar20,
		OT2001.IsPrinted, OT2001.InheritApportionID
		'+ Case when @customerName = 57 then ', OT2001.TypeOfAdjustPlanID' 
							else ', OT2002.SOrderIDRecognition, OT2001.AdjustSOrderID' end + '
		' + CASE WHEN @CustomerName = 71 THEN ', TB.Ana01ID AS OT2002_Ana01ID, TB.Ana02ID AS OT2002_Ana02ID, TB.Ana03ID AS OT2002_Ana03ID, TB.Ana04ID AS OT2002_Ana04ID, TB.Ana05ID AS OT2002_Ana05ID,
												 TB.Ana06ID AS OT2002_Ana06ID, TB.Ana07ID AS OT2002_Ana07ID, TB.Ana08ID AS OT2002_Ana08ID, TB.Ana09ID AS OT2002_Ana09ID, TB.Ana10ID AS OT2002_Ana10ID' ELSE '' END + '
'
SET @sSQL2 =N' 
FROM	OT2001  WITH (NOLOCK)
LEFT JOIN OT2002 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID and OT2001.SOrderID = OT2002.SOrderID and OT2002.OrderQuantity >0
LEFT JOIN OT0099 WITH (NOLOCK) ON OT0099.ID = OT2001.OrderTypeID and OT0099.CodeMaster = ''OrderTypeID''
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = OT2001.ObjectID
LEFT JOIN AT1202 T02 WITH (NOLOCK) ON T02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T02.ObjectID = OT2001.VATObjectID
LEFT JOIN OT1002 OT1002_1 WITH (NOLOCK) ON OT1002_1.AnaID = OT2001.Ana01ID AND OT1002_1.AnaTypeID = ''S01'' AND OT2001.DivisionID = OT1002_1.DivisionID
LEFT JOIN OT1002 OT1002_2 WITH (NOLOCK) ON OT1002_2.AnaID = OT2001.Ana02ID AND OT1002_2.AnaTypeID = ''S02'' AND OT2001.DivisionID = OT1002_2.DivisionID
LEFT JOIN OT1002 OT1002_3 WITH (NOLOCK) ON OT1002_3.AnaID = OT2001.Ana03ID AND OT1002_3.AnaTypeID = ''S03'' AND OT2001.DivisionID = OT1002_3.DivisionID
LEFT JOIN OT1002 OT1002_4 WITH (NOLOCK) ON OT1002_4.AnaID = OT2001.Ana04ID AND OT1002_4.AnaTypeID = ''S04'' AND OT2001.DivisionID = OT1002_4.DivisionID
LEFT JOIN OT1002 OT1002_5 WITH (NOLOCK) ON OT1002_5.AnaID = OT2001.Ana05ID AND OT1002_5.AnaTypeID = ''S05'' AND OT2001.DivisionID = OT1002_5.DivisionID
LEFT JOIN AT1301 WITH (NOLOCK) ON AT1301.InventoryTypeID = OT2001.InventoryTypeID
LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = OT2001.CurrencyID

LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = OT2001.EmployeeID
LEFT JOIN AT1103 AT1103_2 WITH (NOLOCK) ON AT1103_2.EmployeeID = OT2001.SalesManID
LEFT JOIN AT1103 AT1103_3 WITH (NOLOCK) ON AT1103_3.EmployeeID = OT2001.SalesMan2ID

LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = OT2001.DepartmentID
LEFT JOIN OT1001 WITH (NOLOCK) ON OT1001.ClassifyID = OT2001.ClassifyID AND OT1001.TypeID = ''SO'' AND OT2001.DivisionID = OT1001.DivisionID
LEFT JOIN OT1101 OV1001 WITH (NOLOCK)  ON OT2001.DivisionID = OV1001.DivisionID AND OV1001.OrderStatus = OT2001.OrderStatus AND OV1001.TypeID = case when OT2001.OrderType <> 1 then ''SO'' else 
							''MO'' end 
LEFT JOIN OV1002 ON OV1002.OrderType = OT2001.OrderType AND OV1002.TypeID =''SO'' AND OT2001.DivisionID = OV1002.DivisionID
LEFT JOIN OT1102 WITH (NOLOCK) ON OT1102.Code = OT2001.IsConfirm AND OT1102.TypeID = ''SO'' AND OT2001.DivisionID = OT1102.DivisionID
'+ @sSQLPer + 
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
	GROUP BY OT2001.DivisionID, OT2001.SOrderID
) TB ON TB.DivisionID = OT2001.DivisionID AND TB.SOrderID = OT2001.SOrderID' 
ELSE '' END + '
WHERE OT2001.DivisionID = ''' + @DivisionID + ''''+ @sWHEREPer 

PRINT @sSQL1
PRINT @sSQL2

IF EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS WHERE NAME = 'OV0011' AND XTYPE = 'V') 
    EXEC ('ALTER VIEW OV0011 -- Tạo bởi OP0011
                AS ' + @sSQL1 + @sSQL2 +@SWhereVoucherID)
ELSE
    EXEC ('CREATE VIEW OV0011  -- Tạo bởi OP0011
                AS ' + @sSQL1 + @sSQL2 +@SWhereVoucherID)
                
IF EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS WHERE NAME = 'OV0011' + @ConnID AND XTYPE = 'V') 
    EXEC ('ALTER VIEW OV0011' + @ConnID + ' -- Tạo bởi OP0011
                AS ' + @sSQL1 + @sSQL2 )
ELSE
    EXEC ('CREATE VIEW OV0011' + @ConnID + '  -- Tạo bởi OP0011
                AS ' + @sSQL1 + @sSQL2 )

----- Buoc  1 .1: Tra ra thong tin Master View OV0111 ( De load truy van)
SET @sSQL1 =' 
SELECT	DISTINCT 
		OT2001.SOrderID, 
		OT2001.VoucherTypeID, 
		OT2001.VoucherNo, 
		OT2001.DivisionID, 
		OT2001.TranMonth, 
		OT2001.TranYear,
		OT2001.OrderDate, 
		OT2001.ContractNo, 
		OT2001.ContractDate, 
		OT2001.InventoryTypeID, 
		InventoryTypeName,  
		OT2001.CurrencyID, 
		CurrencyName, 	
		OT2001.ExchangeRate,  
		OT2001.PaymentID, 
		OT2001.DepartmentID,  
		AT1102.DepartmentName, 
		IsPeriod, 
		IsPlan, 
		OT2001.ObjectID,  
		ISNULL(OT2001.ObjectName, AT1202.ObjectName)   AS ObjectName, 
		ISNULL(OT2001.VatNo, AT1202.VatNo)  AS VatNo, 
		ISNULL( OT2001.Address, AT1202.Address)  AS Address,
		OT2001.DeliveryAddress, 
		OT2001.ClassifyID, 
		ClassifyName, 
		OT2001.InheritSOrderID,
		OT2001.EmployeeID,  
		AT1103.FullName,  
		OT2001.Transport, 
		AT1202.IsUpdateName, 
		AT1202.IsCustomer, 
		AT1202.IsSupplier,
		ConvertedAmount = (SELECT Sum(ISNULL(ConvertedAmount,0)- ISNULL(DiscountConvertedAmount,0)- ISNULL(CommissionCAmount,0) +
		ISNULL(VATConvertedAmount, 0))  FROM OT2002 Where OT2002.SOrderID = OT2001.SOrderID),
		OriginalAmount = (SELECT Sum(ISNULL(OriginalAmount,0)- ISNULL(DiscountOriginalAmount,0) - ISNULL(CommissionOAmount, 0) +
		ISNULL(VAToriginalAmount, 0))  FROM OT2002 Where OT2002.SOrderID = OT2001.SOrderID),
		OT2001.Notes, 
		OT2001.Disabled, 
		OT2001.OrderStatus, 
		OV1001.LanguageID AS OrderStatusName, 
		OV1001.EDescription AS EOrderStatusName, 
		OT2001.QuotationID,
		OT2001.OrderType,  
		OV1002.Description AS OrderTypeName,
		OT2001.OrderTypeID,
		OT0099.Description AS OrderTypeIDName,
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
		OT2001.CreateUserID, 
		OT2001.CreateDate, 
		OT2001.LastModifyUserID, 
		OT2001.LastModifyDate, 
		SalesManID, 
		AT1103_2.FullName AS SalesManName, 
		OT2001.SalesMan2ID,		
		AT1103_3.FullName AS SalesMan2Name, 
		OT2001.ShipDate, 
		OT2001.DueDate, 
		OT2001.PaymentTermID,
		OT2001.contact,
		OT2001.VATObjectID,
		ISNULL(OT2001.VATObjectName,T02.ObjectName) AS  VATObjectName,
		OT2001.IsInherit,
		OT1102.Description AS  IsConfirm,
		OT1102.EDescription AS EIsConfirm, OT2001.PriceListID,
		OT2001.DescriptionConfirm,
		OT2001.varchar01, OT2001.varchar02, OT2001.varchar03, OT2001.varchar04, OT2001.varchar05,
		OT2001.varchar06, OT2001.varchar07, OT2001.varchar08, OT2001.varchar09, OT2001.varchar10,
		OT2001.varchar11, OT2001.varchar12, OT2001.varchar13, OT2001.varchar14, OT2001.varchar15,
		OT2001.varchar16, OT2001.varchar17, OT2001.varchar18, OT2001.varchar19, OT2001.varchar20
		'+ case when @CustomerName = 57 then ',OT2001.TypeOfAdjustPlanID' else '' end 
		
SET @sSQL2 =' 
FROM OT2001  WITH (NOLOCK)
LEFT JOIN OT2002 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID and OT2001.SOrderID = OT2002.SOrderID and OT2002.OrderQuantity >0
LEFT JOIN OT0099 WITH (NOLOCK) ON OT0099.ID = OT2001.OrderTypeID and OT0099.CodeMaster = ''OrderTypeID''
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = OT2001.ObjectID
LEFT JOIN AT1202 T02 WITH (NOLOCK) ON T02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T02.ObjectID = OT2001.VATObjectID
LEFT JOIN OT1002 OT1002_1 WITH (NOLOCK) ON OT1002_1.AnaID = OT2001.Ana01ID AND OT1002_1.AnaTypeID = ''S01''
LEFT JOIN OT1002 OT1002_2 WITH (NOLOCK) ON OT1002_2.AnaID = OT2001.Ana02ID AND OT1002_2.AnaTypeID = ''S02''
LEFT JOIN OT1002 OT1002_3 WITH (NOLOCK) ON OT1002_3.AnaID = OT2001.Ana03ID AND OT1002_3.AnaTypeID = ''S03''
LEFT JOIN OT1002 OT1002_4 WITH (NOLOCK) ON OT1002_4.AnaID = OT2001.Ana04ID AND OT1002_4.AnaTypeID = ''S04''
LEFT JOIN OT1002 OT1002_5 WITH (NOLOCK) ON OT1002_5.AnaID = OT2001.Ana05ID AND OT1002_5.AnaTypeID = ''S05''
LEFT JOIN AT1301 WITH (NOLOCK) ON AT1301.InventoryTypeID = OT2001.InventoryTypeID
LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = OT2001.CurrencyID

LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = OT2001.EmployeeID
LEFT JOIN AT1103 AT1103_2 WITH (NOLOCK) ON AT1103_2.EmployeeID = OT2001.SalesManID
LEFT JOIN AT1103 AT1103_3 WITH (NOLOCK) ON AT1103_3.EmployeeID = OT2001.SalesMan2ID

LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = OT2001.DepartmentID
LEFT JOIN OT1001 WITH (NOLOCK) ON OT1001.ClassifyID = OT2001.ClassifyID AND OT1001.TypeID = ''SO''   AND OT2001.DivisionID = OT1001.DivisionID
LEFT JOIN OT1101 OV1001 WITH (NOLOCK)  ON  OT2001.DivisionID = OV1001.DivisionID AND  OV1001.OrderStatus = OT2001.OrderStatus AND OV1001.TypeID = case when OT2001.OrderType <> 1 then ''SO'' else ''MO'' end 
LEFT JOIN OV1002 ON OV1002.OrderType = OT2001.OrderType AND OV1002.TypeID =''SO''  AND OT2001.DivisionID = OV1002.DivisionID
LEFT JOIN OT1102 WITH (NOLOCK) ON OT1102.Code = OT2001.IsConfirm AND OT1102.TypeID = ''SO''  AND OT2001.DivisionID = OT1102.DivisionID
'
IF @IsServer = 0  
BEGIN

    IF EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS WHERE NAME = 'OV0112' AND XTYPE = 'V') 
        EXEC ('ALTER VIEW OV0112 -- Tạo bởi OP0011
                    AS ' + @sSQL1 + @sSQL2 + @DivisionWhere +@sWHERE +@SWhereVoucherID)
    ELSE
        EXEC ('CREATE VIEW OV0112  -- Tạo bởi OP0011
                    AS ' + @sSQL1 + @sSQL2 + @DivisionWhere +@sWHERE +@SWhereVoucherID)
                    
    IF EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS WHERE NAME = 'OV0112' + @ConnID AND XTYPE = 'V') 
        EXEC ('ALTER VIEW OV0112' + @ConnID + ' -- Tạo bởi OP0011
                    AS ' + @sSQL1 + @sSQL2 + @DivisionWhere +@sWHERE +@SWhereVoucherID)
    ELSE
        EXEC ('CREATE VIEW OV0112' + @ConnID + '  -- Tạo bởi OP0011
                    AS ' + @sSQL1 + @sSQL2 + @DivisionWhere +@sWHERE +@SWhereVoucherID)
	
	SET @sSQL3 = ' 
	SELECT		*
	FROM	OV0112
	'

END

IF @IsServer = 1
BEGIN
	SET @sSQL1 = @sSQL1 + '		
			,AT1302.Barcode,
			OT2002.InventoryID,
			OT2002.Notes AS DetailNotes,
			OT2002.DeliveryDate,
			OT2002.ConvertedSalepriceInput,'
			+ case when @CustomerName = 57 then '' else 'OT2002.SOrderIDRecognition' end

	SET @sSQL2 = @sSQL2 + '
	INNER JOIN OT2002 WITH (NOLOCK) ON OT2002.SOrderID = OT2001.SOrderID AND OT2002.DivisionID = OT2001.DivisionID
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', OT2002.DivisionID) AND AT1302.InventoryID= OT2002.InventoryID
	'

    IF EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS WHERE NAME = 'OV0112' AND XTYPE = 'V') 
        EXEC ('ALTER VIEW OV0112 -- Tạo bởi OP0011
                    AS ' + @sSQL1 + @sSQL2 + @DivisionWhere +@sWHERE +@SWhereVoucherID)
    ELSE
        EXEC ('CREATE VIEW OV0112  -- Tạo bởi OP0011
                    AS ' + @sSQL1 + @sSQL2 + @DivisionWhere +@sWHERE +@SWhereVoucherID)
                    
    IF EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS WHERE NAME = 'OV0112' + @ConnID AND XTYPE = 'V') 
        EXEC ('ALTER VIEW OV0112' + @ConnID + ' -- Tạo bởi OP0011
                    AS ' + @sSQL1 + @sSQL2 + @DivisionWhere +@sWHERE +@SWhereVoucherID)
    ELSE
        EXEC ('CREATE VIEW OV0112' + @ConnID + '  -- Tạo bởi OP0011
                    AS ' + @sSQL1 + @sSQL2 + @DivisionWhere +@sWHERE +@SWhereVoucherID)
			
	SET @sSQL3 = '
	SELECT	DISTINCT
			SOrderID, 		VoucherTypeID, 		VoucherNo, 
			DivisionID, 	TranMonth,			TranYear,
			OrderDate, 		ContractNo, 		ContractDate, 
			InventoryTypeID,					InventoryTypeName,  
			CurrencyID,		CurrencyName, 		ExchangeRate,  
			PaymentID,		DepartmentID,		DepartmentName, 
			IsPeriod, 		IsPlan, 
			ObjectID,		ObjectName,			VatNo,				Address,
			DeliveryAddress,ClassifyID,			ClassifyName,		InheritSOrderID,
			EmployeeID,  	FullName,			Transport, 
			IsUpdateName,	IsCustomer,			IsSupplier,
			ConvertedAmount,					OriginalAmount,
			Notes, 			Disabled, 
			OrderStatus, 	OrderStatusName, 	EOrderStatusName, 
			QuotationID,	OrderType,  		OrderTypeName,
			OrderTypeID, OrderTypeIDName,
			Ana01ID,Ana02ID, Ana03ID, Ana04ID,Ana05ID, 
			Ana01Name,Ana02Name,Ana03Name,Ana04Name,Ana05Name, 
			CreateUserID,	CreateDate,			LastModifyUserID, 	LastModifyDate, 	
			SalesManID, 	SalesManName, 		SalesMan2ID,		SalesMan2Name, 
			ShipDate,		DueDate,			PaymentTermID,		contact,
			VATObjectID,	VATObjectName,
			IsInherit,		IsConfirm,			EIsConfirm,			PriceListID,		DescriptionConfirm,
			varchar01, varchar02, varchar03, varchar04, varchar05,
			varchar06, varchar07, varchar08, varchar09, varchar10,
			varchar11, varchar12, varchar13, varchar14, varchar15,
			varchar16, varchar17, varchar18, varchar19, varchar20,
			IsPrinted, SOrderIDRecognition
	FROM	OV0112
	'
END	

IF EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS WHERE NAME = 'OV0111' AND XTYPE = 'V') 
    EXEC ('ALTER VIEW OV0111 -- Tạo bởi OP0011
                AS ' + @sSQL3 + @sSQL4 )
ELSE
    EXEC ('CREATE VIEW OV0111  -- Tạo bởi OP0011
                AS ' + @sSQL3 + @sSQL4 )
                
IF EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS WHERE NAME = 'OV0111' + @ConnID AND XTYPE = 'V') 
    EXEC ('ALTER VIEW OV0111' + @ConnID + ' -- Tạo bởi OP0011
                AS ' + @sSQL3 + @sSQL4 )
ELSE
    EXEC ('CREATE VIEW OV0111' + @ConnID + '  -- Tạo bởi OP0011
                AS ' + @sSQL3 + @sSQL4 )

	

---- Buoc  2 : Tra ra thong tin Detail View OV0012
---- Theo thiết lập thông tin quy cách
IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
	BEGIN
		SET @sSQL1= '
					SELECT DISTINCT	
					OT2002.DivisionID,	
					OT2002.SOrderID, 
					OT2002.RefSTransactionID, 
					OT2002.TransactionID,
					OT2001.VoucherTypeID, 
					OT2001.VoucherNo, 
					OrderDate,  
					ContractNo, 
					ContractDate, 
					OT2001.InventoryTypeID, 
					InventoryTypeName, 
					IsStocked,
					OT2002.InventoryID, 
					AT1302.InventoryName AS AInventoryName, 
					case when ISNULL(OT2002.InventoryCommonName, '''') = '''' then AT1302.InventoryName else OT2002.InventoryCommonName end AS 
					InventoryName, 	
					OT2002.ExtraID,
					AT1311.ExtraName,
					AT1302.Barcode,	
					ISNULL(OT2002.UnitID,AT1302.UnitID) AS  UnitID,
					ISNULL(T04.UnitName,AT1304.UnitName) AS  UnitName,
					OT2002.OrderQuantity, 
					CAST(0 AS BIT) IsSelected,
					OT2002.Parameter01, OT2002.Parameter02, OT2002.Parameter03, OT2002.Parameter04, OT2002.Parameter05,
					SalePrice, 
					OT2002.ConvertedAmount, 
					OT2002.OriginalAmount, 
					OT2002.VATConvertedAmount, 
					OT2002.VATOriginalAmount, 
					OT2002.VATPercent, 		
					OT2002.DiscountConvertedAmount,  
					OT2002.DiscountOriginalAmount,
					OT2002.DiscountPercent, 
					OT2002.CommissionPercent, 
					OT2002.CommissionCAmount, 
					OT2002.CommissionOAmount, 
		
					(ISNULL(OT2002.OriginalAmount, 0) - ISNULL(OT2002.DiscountOriginalAmount, 0) 
					- ISNULL(OT2002.OrderQuantity, 0) * (ISNULL(OT2002.SaleOffAmount01, 0) + ISNULL(OT2002.SaleOffAmount02, 0) + ISNULL(OT2002.SaleOffAmount03, 0) + ISNULL(OT2002.SaleOffAmount04, 0) + ISNULL(OT2002.SaleOffAmount05, 0))) 
					AS OriginalAmountBeforeVAT,
		        
					(Isnull(OT2002.ConvertedAmount,0) - Isnull(OT2002.DiscountConvertedAmount,0) 
					- ISNULL(OT2002.OrderQuantity, 0) * (ISNULL(OT2002.SaleOffAmount01, 0) + ISNULL(OT2002.SaleOffAmount02, 0) + ISNULL(OT2002.SaleOffAmount03, 0) + ISNULL(OT2002.SaleOffAmount04, 0) + ISNULL(OT2002.SaleOffAmount05, 0)))
					AS ConvertAmountBeforeVAT,
		
					(ISNULL(OT2002.OriginalAmount, 0) - ISNULL(OT2002.DiscountOriginalAmount, 0) 
					- ISNULL(OT2002.OrderQuantity, 0) * (ISNULL(OT2002.SaleOffAmount01, 0) + ISNULL(OT2002.SaleOffAmount02, 0) + ISNULL(OT2002.SaleOffAmount03, 0) + ISNULL(OT2002.SaleOffAmount04, 0) + ISNULL(OT2002.SaleOffAmount05, 0)) 
					- OT2002.VATOriginalAmount) AS OriginalAmountAfterVAT,
            
					(OT2002.ConvertedAmount* (1+ ISNULL(OT2002.Markup,0)/100) - OT2002.DiscountConvertedAmount - (OT2002.SaleOffAmount01 + OT2002.SaleOffAmount02 + OT2002.SaleOffAmount03 + OT2002.SaleOffAmount04 + OT2002.SaleOffAmount05) * OT2002.OrderQuantity - OT2002.VATConvertedAmount) AS ConvertedAmountAfterVAT,
				
					IsPicking, 
					OT2002.WareHouseID, 
					WareHouseName,  
					OT2002.AdjustQuantity, 
					Quantity01, Quantity02, Quantity03, Quantity04, Quantity05,
					Quantity06, Quantity07, Quantity08, Quantity09, Quantity10,
					Quantity11, Quantity12, Quantity13, Quantity14, Quantity15,
					Quantity16, Quantity17, Quantity18, Quantity19, Quantity20,
					Quantity21, Quantity22, Quantity23, Quantity24, Quantity25,
					Quantity26, Quantity27, Quantity28, Quantity29, Quantity30,		
					OT2003.Date01, OT2003.Date02, OT2003.Date03, OT2003.Date04, OT2003.Date05, 
					OT2003.Date06, OT2003.Date07, OT2003.Date08, OT2003.Date09, OT2003.Date10, 
					Date11, Date12, Date13, Date14, Date15, 
					Date16, Date17, Date18, Date19, Date20, 
					Date21, Date22, Date23, Date24, Date25, 
					Date26, Date27, Date28, Date29, Date30,
					OT2002.LinkNo, 
					OT2002.EndDate, 
					OT2002.Orders, 
					OT2002.Description, 
					OT2002.RefInfor,
					OT2002.Ana01ID, 
					OT2002.Ana02ID, 
					OT2002.Ana03ID,
					OT2002.Ana04ID, 
					OT2002.Ana05ID,
					OT2002.Ana06ID, 
					OT2002.Ana07ID, 
					OT2002.Ana08ID,
					OT2002.Ana09ID, 
					OT2002.Ana10ID,
					ActualQuantity, 
					EndQuantity AS RemainQuantity,
					OT2002.Finish ,
					'+ case when @CustomerName = 57 then '' else'
					OT2002.SOrderIDRecognition,' end
					 +'OT2002.Notes,
					OT2002.Notes01,
					OT2002.Notes02,
					OT2001.contact,
					OT2002.QuotationID,
					OT2002.VATGroupID,
					OT2002.SaleOffPercent01,
					OT2002.SaleOffAmount01,
					OT2002.SaleOffPercent02,
					OT2002.SaleOffAmount02,
					OT2002.SaleOffPercent03,
					OT2002.SaleOffAmount03,
					OT2002.SaleOffPercent04,
					OT2002.SaleOffAmount04,
					OT2002.SaleOffPercent05,
					OT2002.SaleOffAmount05,
					OT2002.QuoTransactionID,
					OT2002.Pricelist,
					OT2002.Varchar01,
					OT2002.Varchar02,
					OT2002.Varchar03,
					OT2002.Varchar04,
					OT2002.Varchar05,
					OT2002.Varchar06,
					OT2002.Varchar07,
					OT2002.Varchar08,
					OT2002.Varchar09,
					OT2002.Varchar10,
					OT2002.nvarchar01, OT2002.nvarchar02, OT2002.nvarchar03, OT2002.nvarchar04, OT2002.nvarchar05,
					OT2002.nvarchar06, OT2002.nvarchar07, OT2002.nvarchar08, OT2002.nvarchar09, OT2002.nvarchar10,

					OT2002.ConvertedQuantity, OT2002.SOKitTransactionID,OT2002.ConvertedSaleprice,
					OT2001.ObjectID, 
					(CASE WHEN '+STR(@CustomerName)+'=47 THEN ISNULL(OT2002.PlanQuantity, 0) ELSE
					(SELECT OrderQuantity FROM OT2002 T02 Where T02.TransactionID = OT2002.TransactionID AND T02.DivisionID=OT2002.DivisionID)
					- (ISNULL((SELECT Sum(OrderQuantity) FROM OT2002 T02 Where T02.RefSTransactionID = OT2002.TransactionID AND T02.DivisionID=OT2002.DivisionID),0))
					END )AS RemainOrderQuantity,
					OT2002.Markup,
					ISNULL(OT2002.OriginalAmountOutput, OT2002.OriginalAmount*(1+ISNULL(Markup,0)/100)) AS OriginalAmountOutput,
					OT2002.ConvertedAmount* (1+ ISNULL(OT2002.Markup,0)/100) AS ConvertedAmountOutput,
					OT2002.DeliveryDate,
					OT2002.ConvertedSalepriceInput,
					OT2002.ShipDate,
					OT2002.Allowance,
					OT2002.InheritTableID,
					OT2002.InheritVoucherID,
					OT2002.InheritTransactionID,
					O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID,
					O99.S08ID, O99.S09ID, O99.S10ID, O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID,
					O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID, O99.UnitPriceStandard,
					AT01.StandardName S01Name, AT02.StandardName S02Name, AT03.StandardName S03Name, AT04.StandardName S04Name, AT05.StandardName S05Name,
					AT06.StandardName S06Name, AT07.StandardName S07Name, AT08.StandardName S08Name, AT09.StandardName S09Name, AT10.StandardName S10Name,
					AT11.StandardName S11Name, AT12.StandardName S12Name, AT13.StandardName S13Name, AT14.StandardName S14Name, AT15.StandardName S15Name,
					AT16.StandardName S16Name, AT17.StandardName S17Name, AT18.StandardName S18Name, AT19.StandardName S19Name, AT20.StandardName S20Name,
					' + case when @CustomerName = 57 then 'OT2001.TypeOfAdjustPlanID' else 'OT2002.Ana02IDAP, OT2002.ExportType, OT2002.NotesAP,AT1309.Operator, AT1309.DataType, AT1309.ConversionFactor, AT1319.FormulaDes' end
					

	SET @sSQL2= '	
			FROM OT2002  WITH (NOLOCK)
			LEFT JOIN OT8899 O99 WITH (NOLOCK) ON O99.DivisionID = OT2002.DivisionID AND O99.TransactionID = OT2002.TransactionID
			LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', OT2002.DivisionID) AND AT1302.InventoryID= OT2002.InventoryID
			--LEFT JOIN AT1011 WITH (NOLOCK) ON AT1011.InventoryID= OT2002.InventoryID AND OT2002.ExtraID = AT1011.AnaID
			LEFT JOIN AT1311 WITH (NOLOCK) on OT2002.DivisionID = AT1311.DivisionID and OT2002.ExtraID = AT1311.ExtraID
			INNER JOIN OT2001 WITH (NOLOCK) ON OT2001.SOrderID = OT2002.SOrderID AND OT2002.DivisionID = OT2001.DivisionID	
			LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = OT2001.ObjectID
			LEFT JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN (''@@@'', '''+@DivisionID+''') AND AT1303.WareHouseID = OT2002.WareHouseID
			LEFT JOIN AT1301 WITH (NOLOCK) ON AT1301.InventoryTypeID = OT2001.InventoryTypeID
			LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT1302.UnitID
			LEFT JOIN AT1304  T04 WITH (NOLOCK) ON T04.UnitID = OT2002.UnitID
			LEFT JOIN OT2003 WITH (NOLOCK) ON OT2003.SOrderID = OT2001.SOrderID AND OT2002.DivisionID = OT2003.DivisionID	
			LEFT JOIN OV2901 ON OV2901.SOrderID = OT2002.SOrderID AND OV2901.TransactionID = OT2002.TransactionID AND OT2002.DivisionID = OV2901.DivisionID	
			LEFT JOIN AT0128 AT01 WITH (NOLOCK) ON AT01.StandardID = O99.S01ID AND AT01.StandardTypeID = ''S01''
			LEFT JOIN AT0128 AT02 WITH (NOLOCK) ON AT02.StandardID = O99.S02ID AND AT02.StandardTypeID = ''S02''
			LEFT JOIN AT0128 AT03 WITH (NOLOCK) ON AT03.StandardID = O99.S03ID AND AT03.StandardTypeID = ''S03''
			LEFT JOIN AT0128 AT04 WITH (NOLOCK) ON AT04.StandardID = O99.S04ID AND AT04.StandardTypeID = ''S04''
			LEFT JOIN AT0128 AT05 WITH (NOLOCK) ON AT05.StandardID = O99.S05ID AND AT05.StandardTypeID = ''S05''
			LEFT JOIN AT0128 AT06 WITH (NOLOCK) ON AT06.StandardID = O99.S06ID AND AT06.StandardTypeID = ''S06'' 
			LEFT JOIN AT0128 AT07 WITH (NOLOCK) ON AT07.StandardID = O99.S07ID AND AT07.StandardTypeID = ''S07''
			LEFT JOIN AT0128 AT08 WITH (NOLOCK) ON AT08.StandardID = O99.S08ID AND AT08.StandardTypeID = ''S08''
			LEFT JOIN AT0128 AT09 WITH (NOLOCK) ON AT09.StandardID = O99.S09ID AND AT09.StandardTypeID = ''S09''
			LEFT JOIN AT0128 AT10 WITH (NOLOCK) ON AT10.StandardID = O99.S10ID AND AT10.StandardTypeID = ''S10''
			LEFT JOIN AT0128 AT11 WITH (NOLOCK) ON AT11.StandardID = O99.S11ID AND AT11.StandardTypeID = ''S11''
			LEFT JOIN AT0128 AT12 WITH (NOLOCK) ON AT12.StandardID = O99.S12ID AND AT12.StandardTypeID = ''S12''
			LEFT JOIN AT0128 AT13 WITH (NOLOCK) ON AT13.StandardID = O99.S13ID AND AT13.StandardTypeID = ''S13''
			LEFT JOIN AT0128 AT14 WITH (NOLOCK) ON AT14.StandardID = O99.S15ID AND AT14.StandardTypeID = ''S14''
			LEFT JOIN AT0128 AT15 WITH (NOLOCK) ON AT15.StandardID = O99.S15ID AND AT15.StandardTypeID = ''S15''
			LEFT JOIN AT0128 AT16 WITH (NOLOCK) ON AT16.StandardID = O99.S16ID AND AT16.StandardTypeID = ''S16''
			LEFT JOIN AT0128 AT17 WITH (NOLOCK) ON AT17.StandardID = O99.S17ID AND AT17.StandardTypeID = ''S17''
			LEFT JOIN AT0128 AT18 WITH (NOLOCK) ON AT18.StandardID = O99.S18ID AND AT18.StandardTypeID = ''S18''
			LEFT JOIN AT0128 AT19 WITH (NOLOCK) ON AT19.StandardID = O99.S19ID AND AT19.StandardTypeID = ''S19''
			LEFT JOIN AT0128 AT20 WITH (NOLOCK) ON AT20.StandardID = O99.S20ID AND AT20.StandardTypeID = ''S20''
			' + case when @CustomerName = 57 then 'WHERE (1=1) and OT2002.OrderQuantity>0' else '
			LEFT JOIN AT1309 WITH (NOLOCK) ON AT1309.InventoryID = OT2002.InventoryID AND AT1309.UnitID = OT2002.UnitID	
			AND ISNULL(AT1309.S01ID, '''') = ISNULL(O99.S01ID, '''')
			AND ISNULL(AT1309.S02ID, '''') = ISNULL(O99.S02ID, '''')
			AND ISNULL(AT1309.S03ID, '''') = ISNULL(O99.S03ID, '''')
			AND ISNULL(AT1309.S04ID, '''') = ISNULL(O99.S04ID, '''')
			AND ISNULL(AT1309.S05ID, '''') = ISNULL(O99.S05ID, '''')
			AND ISNULL(AT1309.S06ID, '''') = ISNULL(O99.S06ID, '''')
			AND ISNULL(AT1309.S07ID, '''') = ISNULL(O99.S07ID, '''')
			AND ISNULL(AT1309.S08ID, '''') = ISNULL(O99.S08ID, '''')
			AND ISNULL(AT1309.S09ID, '''') = ISNULL(O99.S09ID, '''')
			AND ISNULL(AT1309.S10ID, '''') = ISNULL(O99.S10ID, '''')
			AND ISNULL(AT1309.S11ID, '''') = ISNULL(O99.S11ID, '''')
			AND ISNULL(AT1309.S12ID, '''') = ISNULL(O99.S12ID, '''')
			AND ISNULL(AT1309.S13ID, '''') = ISNULL(O99.S13ID, '''')
			AND ISNULL(AT1309.S14ID, '''') = ISNULL(O99.S14ID, '''')
			AND ISNULL(AT1309.S15ID, '''') = ISNULL(O99.S15ID, '''')
			AND ISNULL(AT1309.S16ID, '''') = ISNULL(O99.S16ID, '''')
			AND ISNULL(AT1309.S17ID, '''') = ISNULL(O99.S17ID, '''')
			AND ISNULL(AT1309.S18ID, '''') = ISNULL(O99.S18ID, '''')
			AND ISNULL(AT1309.S19ID, '''') = ISNULL(O99.S19ID, '''')
			AND ISNULL(AT1309.S20ID, '''') = ISNULL(O99.S20ID, '''')
			LEFT JOIN AT1319 WITH (NOLOCK) ON AT1309.FormulaID = AT1319.FormulaID			
			WHERE (1=1)' end
			 + CASE WHEN @CustomerName<>80 THEN ' and OT2002.OrderQuantity>0' ELSE '' END 
			

	END
ELSE
	BEGIN
		SET @sSQL1= '
	SELECT DISTINCT	
	OT2002.DivisionID,	
	OT2002.SOrderID, 
	OT2002.RefSTransactionID, 
	OT2002.TransactionID,
	OT2001.VoucherTypeID, 
	OT2001.VoucherNo, 
	OrderDate,  
	ContractNo, 
	ContractDate, 
	OT2001.InventoryTypeID, 
	InventoryTypeName, 
	IsStocked,
	OT2002.InventoryID, 
	AT1302.InventoryName AS AInventoryName, 
	case when ISNULL(OT2002.InventoryCommonName, '''') = '''' then AT1302.InventoryName else OT2002.InventoryCommonName end AS 
	InventoryName, 	
	OT2002.ExtraID,
	AT1311.ExtraName,
	AT1302.Barcode,	
	ISNULL(OT2002.UnitID,AT1302.UnitID) AS  UnitID,
	ISNULL(T04.UnitName,AT1304.UnitName) AS  UnitName,
	OT2002.OrderQuantity, 
	CAST(0 AS BIT) IsSelected,
	OT2002.Parameter01, OT2002.Parameter02, OT2002.Parameter03, OT2002.Parameter04, OT2002.Parameter05,
	SalePrice, 
	OT2002.ConvertedAmount, 
	OT2002.OriginalAmount, 
	OT2002.VATConvertedAmount, 
	OT2002.VATOriginalAmount, 
	OT2002.VATPercent, 		
	OT2002.DiscountConvertedAmount,  
	OT2002.DiscountOriginalAmount,
	OT2002.DiscountPercent, 
	OT2002.CommissionPercent, 
	OT2002.CommissionCAmount, 
	OT2002.CommissionOAmount, 
		
	(ISNULL(OT2002.OriginalAmount, 0) - ISNULL(OT2002.DiscountOriginalAmount, 0) 
	- ISNULL(OT2002.OrderQuantity, 0) * (ISNULL(OT2002.SaleOffAmount01, 0) + ISNULL(OT2002.SaleOffAmount02, 0) + ISNULL(OT2002.SaleOffAmount03, 0) + ISNULL(OT2002.SaleOffAmount04, 0) + ISNULL(OT2002.SaleOffAmount05, 0))) 
	AS OriginalAmountBeforeVAT,
		        
	(Isnull(OT2002.ConvertedAmount,0) - Isnull(OT2002.DiscountConvertedAmount,0) 
	- ISNULL(OT2002.OrderQuantity, 0) * (ISNULL(OT2002.SaleOffAmount01, 0) + ISNULL(OT2002.SaleOffAmount02, 0) + ISNULL(OT2002.SaleOffAmount03, 0) + ISNULL(OT2002.SaleOffAmount04, 0) + ISNULL(OT2002.SaleOffAmount05, 0)))
	AS ConvertAmountBeforeVAT,
		
	(ISNULL(OT2002.OriginalAmount, 0) - ISNULL(OT2002.DiscountOriginalAmount, 0) 
	- ISNULL(OT2002.OrderQuantity, 0) * (ISNULL(OT2002.SaleOffAmount01, 0) + ISNULL(OT2002.SaleOffAmount02, 0) + ISNULL(OT2002.SaleOffAmount03, 0) + ISNULL(OT2002.SaleOffAmount04, 0) + ISNULL(OT2002.SaleOffAmount05, 0)) 
	- OT2002.VATOriginalAmount) AS OriginalAmountAfterVAT,
            
	(OT2002.ConvertedAmount* (1+ ISNULL(OT2002.Markup,0)/100) - OT2002.DiscountConvertedAmount - (OT2002.SaleOffAmount01 + OT2002.SaleOffAmount02 + OT2002.SaleOffAmount03 + OT2002.SaleOffAmount04 + OT2002.SaleOffAmount05) * OT2002.OrderQuantity - OT2002.VATConvertedAmount) AS ConvertedAmountAfterVAT,
				
	IsPicking, 
	OT2002.WareHouseID, 
	WareHouseName,  
	OT2002.AdjustQuantity, 
	Quantity01, Quantity02, Quantity03, Quantity04, Quantity05,
	Quantity06, Quantity07, Quantity08, Quantity09, Quantity10,
	Quantity11, Quantity12, Quantity13, Quantity14, Quantity15,
	Quantity16, Quantity17, Quantity18, Quantity19, Quantity20,
	Quantity21, Quantity22, Quantity23, Quantity24, Quantity25,
	Quantity26, Quantity27, Quantity28, Quantity29, Quantity30,		
	OT2003.Date01, OT2003.Date02, OT2003.Date03, OT2003.Date04, OT2003.Date05, 
	OT2003.Date06, OT2003.Date07, OT2003.Date08, OT2003.Date09, OT2003.Date10, 
	Date11, Date12, Date13, Date14, Date15, 
	Date16, Date17, Date18, Date19, Date20, 
	Date21, Date22, Date23, Date24, Date25, 
	Date26, Date27, Date28, Date29, Date30,
	OT2002.LinkNo, 
	OT2002.EndDate, 
	OT2002.Orders, 
	OT2002.Description, 
	OT2002.RefInfor,
	OT2002.Ana01ID, 
	OT2002.Ana02ID, 
	OT2002.Ana03ID,
	OT2002.Ana04ID, 
	OT2002.Ana05ID,
	OT2002.Ana06ID, 
	OT2002.Ana07ID, 
	OT2002.Ana08ID,
	OT2002.Ana09ID, 
	OT2002.Ana10ID,
	ActualQuantity,
	'
	SET @sSQL11 = ' 
	EndQuantity AS RemainQuantity,
	OT2002.Finish ,
	'+ case when @CustomerName = 57 then '' else '
	OT2002.SOrderIDRecognition,' end + '
	OT2002.Notes,
	OT2002.Notes01,
	OT2002.Notes02,
	OT2001.contact,
	OT2002.QuotationID,
	OT2002.VATGroupID,
	OT2002.SaleOffPercent01,
	OT2002.SaleOffAmount01,
	OT2002.SaleOffPercent02,
	OT2002.SaleOffAmount02,
	OT2002.SaleOffPercent03,
	OT2002.SaleOffAmount03,
	OT2002.SaleOffPercent04,
	OT2002.SaleOffAmount04,
	OT2002.SaleOffPercent05,
	OT2002.SaleOffAmount05,
	OT2002.QuoTransactionID,
	OT2002.Pricelist,
	OT2002.Varchar01,
	OT2002.Varchar02,
	OT2002.Varchar03,
	OT2002.Varchar04,
	OT2002.Varchar05,
	OT2002.Varchar06,
	OT2002.Varchar07,
	OT2002.Varchar08,
	OT2002.Varchar09,
	OT2002.Varchar10,
	OT2002.nvarchar01, OT2002.nvarchar02, OT2002.nvarchar03, OT2002.nvarchar04, OT2002.nvarchar05,
	OT2002.nvarchar06, OT2002.nvarchar07, OT2002.nvarchar08, OT2002.nvarchar09, OT2002.nvarchar10,

	OT2002.ConvertedQuantity, OT2002.SOKitTransactionID,OT2002.ConvertedSaleprice,
	OT2001.ObjectID, 
	(CASE WHEN '+STR(@CustomerName)+'=47 THEN ISNULL(OT2002.PlanQuantity, 0) ELSE
	(SELECT OrderQuantity FROM OT2002 T02 Where T02.TransactionID = OT2002.TransactionID AND T02.DivisionID=OT2002.DivisionID)
	- (ISNULL((SELECT Sum(OrderQuantity) FROM OT2002 T02 Where T02.RefSTransactionID = OT2002.TransactionID AND T02.DivisionID=OT2002.DivisionID),0))
	END )AS RemainOrderQuantity,
	OT2002.Markup,
	ISNULL(OT2002.OriginalAmountOutput, OT2002.OriginalAmount*(1+ISNULL(Markup,0)/100)) AS OriginalAmountOutput,
	OT2002.ConvertedAmount* (1+ ISNULL(OT2002.Markup,0)/100) AS ConvertedAmountOutput,
	OT2002.DeliveryDate,
	OT2002.ConvertedSalepriceInput,
	OT2002.ShipDate,
	OT2002.Allowance,
	OT2002.InheritTableID,
	OT2002.InheritVoucherID,
	' + case when @CustomerName = 57 then 'OT2002.InheritTransactionID,OT2001.TypeOfAdjustPlanID' else '
	OT2002.InheritTransactionID, OT2002.Ana02IDAP, OT2002.ExportType, OT2002.NotesAP,
	OT2002.AdjustSOrderID, OT2002.AdjustTransactionID' end
		SET @sSQL2= '	
FROM OT2002  WITH (NOLOCK)
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', OT2002.DivisionID) AND AT1302.InventoryID= OT2002.InventoryID
--LEFT JOIN AT1011 WITH (NOLOCK) ON AT1011.InventoryID= OT2002.InventoryID AND OT2002.ExtraID = AT1011.AnaID
LEFT JOIN AT1311 WITH (NOLOCK) on OT2002.DivisionID = AT1311.DivisionID and OT2002.ExtraID = AT1311.ExtraID
INNER JOIN OT2001 WITH (NOLOCK) ON OT2001.SOrderID = OT2002.SOrderID AND OT2002.DivisionID = OT2001.DivisionID	
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = OT2001.ObjectID
LEFT JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN (''@@@'','''+@DivisionID+''') AND AT1303.WareHouseID = OT2002.WareHouseID
LEFT JOIN AT1301 WITH (NOLOCK) ON AT1301.InventoryTypeID = OT2001.InventoryTypeID
LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT1302.UnitID
LEFT JOIN AT1304  T04 WITH (NOLOCK) ON T04.UnitID = OT2002.UnitID
LEFT JOIN OT2003 WITH (NOLOCK) ON OT2003.SOrderID = OT2001.SOrderID AND OT2002.DivisionID = OT2003.DivisionID	

'

	----- Modified by Tiểu Mai on 15/07/2016: Bổ sung 20 cột quy cách cho ANGEL
	----- Do đặc thù quy trình của khách hàng nên ko thể lưu vết như cũ mà tách ra ở AT3266_AG
	IF @CustomerName = 57
	BEGIN
		SET @sSQL111 = @sSQL111 + ',
		OT2002.EstimateQuantity,
		OT2002.BeginQuantity,
		OT2002.MinQuantity,
		OT2002.InventoryEndDate,
		OT2002.PlanDate'
	
		SET @sSQL2 = @sSQL2 + '
		LEFT JOIN OV2901 ON OV2901.SOrderID = OT2002.SOrderID AND OV2901.TransactionID = OT2002.TransactionID AND OT2002.DivisionID = OV2901.DivisionID	
		WHERE (1=1) and OT2002.OrderQuantity>0	'	
		--SET @sSQL2 = @sSQL2 + '
		--left join (Select OT2001.DivisionID, TranMonth, TranYear, OT2002.SOrderID,  OT2001.OrderStatus, TransactionID, OT2001.Duedate, OT2001.Shipdate,
		--			OT2002.InventoryID, OrderQuantity, ActualQuantity, OT2001.PaymentTermID,AT1208.Duedays,
		--			case when OT2002.Finish = 1 then NULL else (  Case When  Isnull (AT1302.IsStocked,0) = 0  then 0 else  isnull(OrderQuantity, 0)- isnull(ActualQuantity, 0) end)end as EndQuantity
		--			From OT2002 WITH (NOLOCK) 
		--			inner join OT2001 WITH (NOLOCK) on OT2002.SOrderID = OT2001.SOrderID and OT2002.DivisionID = OT2001.DivisionID
		--			Inner Join AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (''@@@'', OT2002.DivisionID) AND OT2002.InventoryID = OT2002.InventoryID
		--			left join AT1208 WITH (NOLOCK) on AT1208.PaymentTermID = OT2001.PaymentTermID
		--			left join 	(Select DivisionID, OrderID, OTransactionID, sum(ActualQuantity) As ActualQuantity
		--							From AT3206_AG WITH (NOLOCK)  
		--							Group by DivisionID, OrderID, OTransactionID) as G  --- (co nghia la Giao  hang)
		--	on 	OT2001.DivisionID = G.DivisionID and
		--		OT2002.SOrderID = G.OrderID and
		--		OT2002.TransactionID = G.OTransactionID) OV2901 on OV2901.SOrderID = OT2002.SOrderID and OV2901.TransactionID = OT2002.TransactionID and OV2901.DivisionID= OT2002.DivisionID
		--WHERE (1=1) and OT2002.OrderQuantity>0		'
	END
	ELSE
	IF @CustomerName = 71
	BEGIN
		SET @sSQL2 = @sSQL2 + '
		LEFT JOIN OV2901 ON OV2901.SOrderID = OT2002.SOrderID AND OV2901.TransactionID = OT2002.TransactionID AND OT2002.DivisionID = OV2901.DivisionID'
	END	
	ELSE
	BEGIN
		SET @sSQL2 = @sSQL2 + '
		LEFT JOIN OV2901 ON OV2901.SOrderID = OT2002.SOrderID AND OV2901.TransactionID = OT2002.TransactionID AND OT2002.DivisionID = OV2901.DivisionID	
		WHERE (1=1) and OT2002.OrderQuantity>0	'	
	END 
END
	



IF EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS WHERE NAME = 'OV0012' AND XTYPE = 'V') 
    EXEC ('ALTER VIEW OV0012 -- Tạo bởi OP0011
                AS ' + @sSQL1 + @sSQL11 + @sSQL111 + @sSQL2 +@SWhereVoucherID)
ELSE
    EXEC ('CREATE VIEW OV0012  -- Tạo bởi OP0011
                AS ' + @sSQL1 + @sSQL11 + @sSQL111 + @sSQL2 +@SWhereVoucherID)
                
IF EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS WHERE NAME = 'OV0012' + @ConnID AND XTYPE = 'V') 
    EXEC ('ALTER VIEW OV0012' + @ConnID + ' -- Tạo bởi OP0011
                AS ' + @sSQL1 + @sSQL11 + @sSQL111 + @sSQL2 +@SWhereVoucherID)
ELSE
    EXEC ('CREATE VIEW OV0012' + @ConnID + '  -- Tạo bởi OP0011
                AS ' + @sSQL1 + @sSQL11 + @sSQL111 + @sSQL2 +@SWhereVoucherID)
                
--PRINT @sSQL1
--PRINT @sSQL11
--PRINT @sSQL111
--PRINT @sSQL2
--PRINT @SWhereVoucherID



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
