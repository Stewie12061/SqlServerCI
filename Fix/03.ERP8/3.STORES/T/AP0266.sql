IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0266]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0266]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--- Created by: Bao Anh
--- Date: 22/06/2012
--- Purpose: load detail cho man hinh ke thua nhieu phieu nhap kho (AF0265)
--- Edited by: Bao Anh	Date: 25/09/2013	Cai thien toc do
--- Modified by Thanh Son Date: 23/01/2014: Bổ sung load thêm trường RefInfor (bug 0022003)
--- Modified on 15/10/2014 by Lê Thị Hanh: Lấy thêm DiscountPercent,
--		DiscountConvertedAmount,nvarchar01, nvarchar02, nvarchar03: theo dõi chiết khấu
--- Modified on 16/12/2015 by Tiểu Mai: Bổ sung trường hợp có thiết lập quản lý mặt hàng theo quy cách
--- Modified on 03/06/2016 by Tiểu Mai: Sửa gọi thẳng store AP0266_AG ch khách hàng ANGEL, không chung store
--- Modified on 16/05/2017 by Hải Long: Chỉnh sửa danh mục dùng chung
--- Modified on 17/10/2017 by Hải Long: Sửa lại cách nối qua bảng mặt hàng
--- Modified on 08/11/2017 by Hải Long: Bổ sung trường IsUsedEInvoice
--- Modified on 17/01/2018 by Bảo Anh: Sửa cách lấy đơn giá là giá đơn hàng bán, bổ sung trường DueDate, PaymentID, PaymentTermID, VATGroupID
--- Modified on 19/11/2018 by Kim Thư: Sửa lỗi  COLLATE SQL_Latin1_General_CP1_CI_AS 
--- Modified on 20/12/2018 by Kim Thư: Dùng @sSQLA thay cho @sSQL do @sSQL đang lấy từ table AT9000 có Parameter khác kiểu với AT2007
--- Modified on 25/4/2019 by Kim Thư: hiển thị UnitPrice, OriginalAmount, ConvertedAmount lấy từ phiếu xuất khi tạo hóa đơn bán hàng kế thừa từ phiếu xuất kho ( CustomerIndex = 62 )
--- Modified on 02/10/2020 by Nhựt Trường: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
--- Modified on 17/11/2020 by Hoài Phong: Thêm orderby theo voucherno
--- Modified on 15/07/2022 by Thành Sang: Thêm cột bảng giá OT2001.PriceListID
--- Modified on 08/09/2022 by Văn Tài	: [2022/08/IS/0183] Lấy thông tin chiết khấu từ Đơn hàng bán.
--- Modified on 03/11/2022 by Nhật Quang : Bổ sung mã phân tích Ana08ID từ bảng OT2002 lấy số PO của đơn hàng bán khi tạo hóa đơn bán hàng kế thừa phiếu xuất kho
--- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
--- Modified by Viết Toàn on 14/06/2023: - Bổ sung lấy ngày giao hàng, chứng từ nhập và số lô
--- EXEC AP0266 'TL','AD20130000007511,AD20130000007624,AD20130000007761','AV20130000016447','((''''))', '((0 = 0))'

CREATE PROCEDURE [dbo].[AP0266] @DivisionID nvarchar(50),				
				@lstWOrderID nvarchar(4000),
				@VoucherID nvarchar(50), --- Addnew   truyen ''; Load Edit :  so chung tu vua duoc chon sua
				@ConditionIV nvarchar(max),
				@IsUsedConditionIV nvarchar(20)			
AS

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
	EXEC AP0266_QC @DivisionID, @lstWOrderID, @VoucherID, @ConditionIV, @IsUsedConditionIV
ELSE
BEGIN

	Declare @sSQL  nvarchar(4000), @sSQLA  nvarchar(4000),
		@sSQL1  nvarchar(4000),
		@sSQL2  nvarchar(4000),
		@CustomerIndex int

	SELECT @CustomerIndex = CustomerName FROM CustomerIndex

	SET @sSQL1 = ''
	SET @sSQL2 = ''
	Set  @lstWOrderID = 	Replace(@lstWOrderID, ',', ''',''')

	IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N'tempdb.dbo.#TAM')) 
		DROP TABLE #TAM

	CREATE TABLE #TAM
	(
		DivisionID nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		VoucherID nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		TransactionID nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		ActualQuantity decimal(28,8),
		EndQuantity decimal(28,8),
		ConvertedQuantity decimal(28,8),
		EndConvertedQuantity decimal(28,8)
	)

	Set  @sSQL = '
	INSERT INTO #TAM (DivisionID, VoucherID, TransactionID, ActualQuantity, ConvertedQuantity, EndQuantity, EndConvertedQuantity)
	Select 
		AT2006.DivisionID, AT2007.VoucherID, AT2007.TransactionID, AT2007.ActualQuantity, AT2007.ConvertedQuantity,
		(isnull(ActualQuantity, 0) - isnull(ActualQuantityHD,0)) as EndQuantity,
		(isnull(ConvertedQuantity, 0) - isnull(ConvertedQuantityHD,0)) as EndConvertedQuantity
	From AT2006  WITH (NOLOCK)
	inner join AT2007 WITH (NOLOCK) on AT2007.DivisionID = AT2006.DivisionID and AT2007.VoucherID = AT2006.VoucherID

	Left join (
		Select AT9000.DivisionID, AT9000.WOrderID, WTransactionID, InventoryID, sum(Quantity) As ActualQuantityHD, Sum(ConvertedQuantity) As ConvertedQuantityHD
		From AT9000 WITH (NOLOCK)
		Where isnull(AT9000.WOrderID,'''') <>'''' and TransactionTypeID IN (''T04'')
		Group by AT9000.DivisionID, AT9000.WOrderID, InventoryID, WTransactionID
		) as K  on AT2006.DivisionID = K.DivisionID and AT2007.DivisionID = K.DivisionID and
				AT2007.VoucherID = K.WOrderID and AT2007.InventoryID = K.InventoryID and
				AT2007.TransactionID = K.WTransactionID	

	WHERE AT2006.DivisionID = ''' + @DivisionID + ''' and AT2006.VoucherID in (''' + @lstWOrderID + ''')
	'
	EXEC(@sSQL)
/*
		Set @sSQL ='
	Select 
		T00.ObjectID, AT1202.IsUsedEInvoice, T00.VATObjectID,
		T00.WOrderID, T06.VoucherNo, T00.WTransactionID,
		T00.InventoryID,T01.InventoryName, Isnull(T00.UnitID,T01.UnitID) as UnitID,
		Isnull(T00.ConvertedUnitID,T00.UnitID) as ConvertedUnitID,
		T00.Quantity, T00.UnitPrice,
		T00.ConvertedQuantity, T00.ConvertedPrice,
		T00.OriginalAmount, T00.ConvertedAmount, 
		T01.IsSource, T01.IsLocation, T01.SalesAccountID, T01.IsLimitDate, 
		T01.AccountID, T01.MethodID, T01.IsStocked,
		T00.Ana01ID, T00.Ana02ID, T00.Ana03ID, T00.Ana04ID,  T00.Ana05ID,
		T00.Ana06ID, T00.Ana07ID, T00.Ana08ID, T00.Ana09ID,  T00.Ana10ID,
		T00.Orders, cast(1 as tinyint) as IsCheck, BDescription, TDescription, T00.DivisionID,
		WQ1309.ConversionFactor, WQ1309.Operator, WQ1309.DataType, AT1319.FormulaDes,
		T00.Parameter01, T00.Parameter02, T00.Parameter03, T00.Parameter04, T00.Parameter05, 
		NULL AS RefInfor, T00.StandardPrice, T00.StandardAmount, OT22.DiscountPercent,
		OT22.DiscountConvertedAmount, OT22.nvarchar01, OT22.nvarchar02,
		OT22.nvarchar03, OT22.nvarchar04, OT22.nvarchar05, OT22.nvarchar06, OT22.nvarchar07, OT22.nvarchar08, OT22.nvarchar09,
		OT22.nvarchar10, OT22.SaleOffPercent01,OT22.SaleOffAmount01 ,OT22.SaleOffPercent02,OT22.SaleOffAmount02 ,OT22.SaleOffPercent03,OT22.SaleOffAmount03 ,
		OT22.SaleOffPercent04,OT22.SaleOffAmount04 ,OT22.SaleOffPercent05,OT22.SaleOffAmount05, T00.DueDate, T00.PaymentID, T00.PaymentTermID, T00.VATGroupID
	From AT9000  T00 WITH (NOLOCK)
		Inner join AT1302 T01 WITH (NOLOCK) on T00.InventoryID = T01.InventoryID
		Left Join AT1309 WQ1309 WITH (NOLOCK) On WQ1309.InventoryID = T00.InventoryID AND WQ1309.UnitID = T00.ConvertedUnitID
		Left Join AT1319 WITH (NOLOCK) on WQ1309.FormulaID = AT1319.FormulaID
		Inner join AT2006 T06 WITH (NOLOCK) on T06.DivisionID = T00.DivisionID and T06.VoucherID = T00.WOrderID
		LEFT JOIN OT2002 OT22 WITH (NOLOCK) ON OT22.DivisionID = T00.DivisionID AND OT22.InventoryID = T00.InventoryID AND OT22.SOrderID = T00.MOrderID AND OT22.TransactionID = T00.MTransactionID
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = T00.ObjectID
	Where  T00.DivisionID = ''' + @DivisionID + '''  and 
		T00.VoucherID =  '''+@VoucherID+'''  
		and TransactionTypeID = ''T04''
		and  isnull(WTransactionID,'''')  <>''''
		
	UNION'
*/
			SET @sSQLA = '
	Select DISTINCT T02.ObjectID, AT1202.IsUsedEInvoice, T02.ObjectID as VATObjectID,
		T00.VoucherID as WOrderID, T02.VoucherNo,
		T00.TransactionID as WTransactionID,
		T00.InventoryID,		
		T01.InventoryName, 
		OT21.ShipDate AS DeliveryDate,
		T00.SourceNo,
		Isnull(T00.UnitID,T01.UnitID) as UnitID,
		Isnull(T00.ConvertedUnitID,T00.UnitID) as ConvertedUnitID,
		V00.Quantity as Quantity,	
		'+case when @CustomerIndex = 62 then 'T00.UnitPrice'  else
		'(OT22.SalePrice - ISNULL(OT22.SaleOffAmount01,0) - ISNULL(OT22.SaleOffAmount02,0) 
		- ISNULL(OT22.SaleOffAmount03,0) - ISNULL(OT22.SaleOffAmount04,0) - ISNULL(OT22.SaleOffAmount05,0))' end+' as UnitPrice,
		V00.ConvertedQuantity as ConvertedQuantity,
		(OT22.ConvertedSalePrice - ISNULL(OT22.SaleOffAmount01,0) - ISNULL(OT22.SaleOffAmount02,0) - ISNULL(OT22.SaleOffAmount03,0) - ISNULL(OT22.SaleOffAmount04,0) - ISNULL(OT22.SaleOffAmount05,0)) as ConvertedSalePrice,

		'+case when @CustomerIndex = 62 then 'T00.OriginalAmount' else '(IsNull(V00.Quantity,0) * (OT22.SalePrice - ISNULL(OT22.SaleOffAmount01,0)
		 - ISNULL(OT22.SaleOffAmount02,0) - ISNULL(OT22.SaleOffAmount03,0) - ISNULL(OT22.SaleOffAmount04,0) - ISNULL(OT22.SaleOffAmount05,0)))' end+' As OriginalAmount, 	  
		'+case when @CustomerIndex = 62 then 'T00.ConvertedAmount' else '(IsNull(V00.Quantity,0) * (OT22.SalePrice - ISNULL(OT22.SaleOffAmount01,0) - ISNULL(OT22.SaleOffAmount02,0)
		 - ISNULL(OT22.SaleOffAmount03,0) - ISNULL(OT22.SaleOffAmount04,0) - ISNULL(OT22.SaleOffAmount05,0)))' end+' As ConvertedAmount,
		
		T01.IsSource, 
		T01.IsLocation, T01.PurchaseAccountID, T01.IsLimitDate, 
		T01.AccountID, T01.MethodID, T01.IsStocked,
		T00.Ana01ID, T00.Ana02ID, T00.Ana03ID, T00.Ana04ID, T00.Ana05ID, 
		T00.Ana06ID, T00.Ana07ID, T00.Ana08ID, T00.Ana09ID, T00.Ana10ID,
		T00.Orders, cast(1 as tinyint) as IsCheck, T02.Description as BDescription, T00.Notes As TDescription, T00.DivisionID,
		WQ1309.ConversionFactor, WQ1309.Operator, WQ1309.DataType, AT1319.FormulaDes,
		T00.Parameter01, T00.Parameter02, T00.Parameter03, T00.Parameter04, T00.Parameter05, T00.RefInfor,
		OT22.DiscountConvertedAmount, OT22.nvarchar01, OT22.nvarchar02,
		T00.StandardPrice, T00.StandardAmount, 
		OT22.DiscountPercent,
		OT22.DiscountAmount AS SODiscountAmount, 
		OT22.nvarchar03,  OT22.nvarchar04, OT22.nvarchar05, OT22.nvarchar06, OT22.nvarchar07, OT22.nvarchar08, OT22.nvarchar09,
		OT22.nvarchar10, OT22.SaleOffPercent01,OT22.SaleOffAmount01 ,OT22.SaleOffPercent02,OT22.SaleOffAmount02 ,OT22.SaleOffPercent03,OT22.SaleOffAmount03 ,
		OT22.SaleOffPercent04,OT22.SaleOffAmount04 ,OT22.SaleOffPercent05,OT22.SaleOffAmount05, OT21.DueDate, OT21.PaymentID, OT21.PaymentTermID, OT22.VATGroupID, OT21.PriceListID,
		AT14.ReVoucherNo
	From AT2007 T00 WITH (NOLOCK)  inner join AT2006 T02 WITH (NOLOCK) on T00.VoucherID =  T02.VoucherID and T00.DivisionID =T02.DivisionID
		inner join AT9000 V00 on T00.DivisionID = V00.DivisionID and V00.WOrderID = T00.VoucherID and V00.WTransactionID = T00.TransactionID and V00.TransactionTypeID=''T04''
		inner  join AT1302 T01 WITH (NOLOCK) on T01.DivisionID IN (T00.DivisionID,''@@@'') AND T00.InventoryID = T01.InventoryID
		Left Join AT1309 WQ1309 WITH (NOLOCK) On WQ1309.InventoryID = T00.InventoryID AND WQ1309.UnitID = T00.ConvertedUnitID
		Left Join AT1319 WITH (NOLOCK) on WQ1309.FormulaID = AT1319.FormulaID
		LEFT JOIN OT2002 OT22 WITH (NOLOCK) ON OT22.DivisionID = T00.DivisionID AND OT22.InventoryID = T00.InventoryID AND OT22.SOrderID = T00.MOrderID AND OT22.TransactionID = T00.MTransactionID
		LEFT JOIN OT2001 OT21 WITH (NOLOCK) ON OT22.DivisionID = OT21.DivisionID AND OT22.SOrderID = OT21.SOrderID
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = T02.ObjectID
		LEFT JOIN AT0114 AT14 WITH (NOLOCK) ON AT14.ReVoucherID = T00.ReVoucherID AND AT14.DivisionID = T00.DivisionID AND AT14.ReVoucherID = T00.ReVoucherID
	Where  T02.DivisionID = ''' + @DivisionID + ''' and V00.VoucherID='''+@VoucherID+''' 
	
	UNION
	'

		SET @sSQL1 = '
	Select DISTINCT T02.ObjectID, AT1202.IsUsedEInvoice, T02.ObjectID as VATObjectID,
		T00.VoucherID as WOrderID, T02.VoucherNo,
		T00.TransactionID as WTransactionID,
		T00.InventoryID,		
		T01.InventoryName, 
		OT21.ShipDate AS DeliveryDate,
		T00.SourceNo,
		Isnull(T00.UnitID,T01.UnitID) as UnitID,
		Isnull(T00.ConvertedUnitID,T00.UnitID) as ConvertedUnitID,
		V00.EndQuantity as Quantity,	
		'+case when @CustomerIndex = 62 then 'T00.UnitPrice'  else
		'(OT22.SalePrice - ISNULL(OT22.SaleOffAmount01,0) - ISNULL(OT22.SaleOffAmount02,0) 
		- ISNULL(OT22.SaleOffAmount03,0) - ISNULL(OT22.SaleOffAmount04,0) - ISNULL(OT22.SaleOffAmount05,0))' end+' as UnitPrice,
		V00.ConvertedQuantity as ConvertedQuantity,
		(OT22.ConvertedSalePrice - ISNULL(OT22.SaleOffAmount01,0) - ISNULL(OT22.SaleOffAmount02,0) - ISNULL(OT22.SaleOffAmount03,0) - ISNULL(OT22.SaleOffAmount04,0) - ISNULL(OT22.SaleOffAmount05,0)) as ConvertedSalePrice,

		'+case when @CustomerIndex = 62 then 'T00.OriginalAmount' else '(IsNull(V00.EndQuantity,0) * (OT22.SalePrice - ISNULL(OT22.SaleOffAmount01,0)
		 - ISNULL(OT22.SaleOffAmount02,0) - ISNULL(OT22.SaleOffAmount03,0) - ISNULL(OT22.SaleOffAmount04,0) - ISNULL(OT22.SaleOffAmount05,0)))' end+' As OriginalAmount, 	  
		'+case when @CustomerIndex = 62 then 'T00.ConvertedAmount' else '(IsNull(V00.EndQuantity,0) * (OT22.SalePrice - ISNULL(OT22.SaleOffAmount01,0) - ISNULL(OT22.SaleOffAmount02,0)
		 - ISNULL(OT22.SaleOffAmount03,0) - ISNULL(OT22.SaleOffAmount04,0) - ISNULL(OT22.SaleOffAmount05,0)))' end+' As ConvertedAmount,
		
		T01.IsSource, 
		T01.IsLocation, T01.PurchaseAccountID, T01.IsLimitDate, 
		T01.AccountID, T01.MethodID, T01.IsStocked,
		T00.Ana01ID, T00.Ana02ID, T00.Ana03ID, T00.Ana04ID, T00.Ana05ID, 
		T00.Ana06ID, T00.Ana07ID, T00.Ana08ID , T00.Ana09ID, T00.Ana10ID,
		T00.Orders, cast(0 as tinyint) as IsCheck, T02.Description as BDescription, T00.Notes As TDescription, T00.DivisionID,
		WQ1309.ConversionFactor, WQ1309.Operator, WQ1309.DataType, AT1319.FormulaDes,
		T00.Parameter01, T00.Parameter02, T00.Parameter03, T00.Parameter04, T00.Parameter05, T00.RefInfor,
		OT22.DiscountConvertedAmount, OT22.nvarchar01, OT22.nvarchar02,
		T00.StandardPrice, T00.StandardAmount, 
		OT22.DiscountPercent,
		OT22.DiscountAmount AS SODiscountAmount, 
		OT22.nvarchar03,  OT22.nvarchar04, OT22.nvarchar05, OT22.nvarchar06, OT22.nvarchar07, OT22.nvarchar08, OT22.nvarchar09,
		OT22.nvarchar10, OT22.SaleOffPercent01,OT22.SaleOffAmount01 ,OT22.SaleOffPercent02,OT22.SaleOffAmount02 ,OT22.SaleOffPercent03,OT22.SaleOffAmount03 ,
		OT22.SaleOffPercent04,OT22.SaleOffAmount04 ,OT22.SaleOffPercent05,OT22.SaleOffAmount05, OT21.DueDate,
 		OT21.PaymentID, OT21.PaymentTermID, OT22.VATGroupID, OT21.PriceListID,
		AT14.ReVoucherNo
	From AT2007 T00 WITH (NOLOCK)  inner join AT2006 T02 WITH (NOLOCK) on T00.VoucherID =  T02.VoucherID and T00.DivisionID =T02.DivisionID
		inner join #TAM V00 on T00.DivisionID = V00.DivisionID and V00.VoucherID = T00.VoucherID and V00.TransactionID = T00.TransactionID 
		inner  join AT1302 T01 WITH (NOLOCK) on T01.DivisionID IN (T00.DivisionID,''@@@'') AND T00.InventoryID = T01.InventoryID
		Left Join AT1309 WQ1309 WITH (NOLOCK) On WQ1309.InventoryID = T00.InventoryID AND WQ1309.UnitID = T00.ConvertedUnitID
		Left Join AT1319 WITH (NOLOCK) on WQ1309.FormulaID = AT1319.FormulaID
		LEFT JOIN OT2002 OT22 WITH (NOLOCK) ON OT22.DivisionID = T00.DivisionID AND OT22.InventoryID = T00.InventoryID AND OT22.SOrderID = T00.MOrderID AND OT22.TransactionID = T00.MTransactionID
		LEFT JOIN OT2001 OT21 WITH (NOLOCK) ON OT22.DivisionID = OT21.DivisionID AND OT22.SOrderID = OT21.SOrderID
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = T02.ObjectID
		LEFT JOIN AT0114 AT14 WITH (NOLOCK) ON AT14.ReVoucherID = T00.ReVoucherID AND AT14.DivisionID = T00.DivisionID AND AT14.ReVoucherID = T00.ReVoucherID
	Where  T02.DivisionID = ''' + @DivisionID + ''' and V00.EndQuantity > 0
		and (ISNULL(T00.InventoryID, ''#'') IN (' + @ConditionIV + ') Or ' + @IsUsedConditionIV + ')'
				
	If isnull (@VoucherID,'') <> '' --- truong hop edit
		EXEC('SELECT * FROM (' + @sSQLA + @sSQL1 + ') A ' + 'Order by Orders')
	Else 	--- truong hop add new
		EXEC('SELECT * FROM (' +@sSQL1 + ') A ' + 'Order by VoucherNo,Orders')

END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
