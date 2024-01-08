IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0266_QC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0266_QC]
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
--- Modified by Lê Thị Hanh on 15/10/2014: Lấy thêm DiscountPercent,
--		DiscountConvertedAmount,nvarchar01, nvarchar02, nvarchar03: theo dõi chiết khấu
--- Modified by Tiểu Mai on 16/12/2015: Bổ sung trường hợp có thiết lập quản lý mặt hàng theo quy cách
--- Modified by Hải Long on 16/05/2017: Chỉnh sửa danh mục dùng chung
--- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
--- Modified by Văn Tài		on 08/09/2022: [2022/08/IS/0183] Lấy thông tin chiết khấu từ Đơn hàng bán.
--- EXEC AP0266 'TL','AD20130000007511,AD20130000007624,AD20130000007761','AV20130000016447','((''''))', '((0 = 0))'

CREATE PROCEDURE [dbo].[AP0266_QC] @DivisionID nvarchar(50),				
				@lstWOrderID nvarchar(4000),
				@VoucherID nvarchar(50), --- Addnew   truyen ''; Load Edit :  so chung tu vua duoc chon sua
				@ConditionIV nvarchar(max),
				@IsUsedConditionIV nvarchar(20)			
AS
Declare @sSQL  nvarchar(4000),
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
	DivisionID nvarchar(50),
	VoucherID nvarchar(50),
	TransactionID nvarchar(50),
	ActualQuantity decimal(28,8),
	EndQuantity decimal(28,8)
)

Set  @sSQL = '
INSERT INTO #TAM (DivisionID, VoucherID, TransactionID, ActualQuantity, EndQuantity)
Select 
	AT2006.DivisionID, AT2007.VoucherID, AT2007.TransactionID, AT2007.ActualQuantity,
	(isnull(ActualQuantity, 0) - isnull(ActualQuantityHD,0)) as EndQuantity
From AT2006  WITH (NOLOCK)
inner join AT2007 WITH (NOLOCK) on AT2007.DivisionID = AT2006.DivisionID and AT2007.VoucherID = AT2006.VoucherID

Left join (
	Select AT9000.DivisionID, AT9000.WOrderID, WTransactionID, InventoryID, sum(Quantity) As ActualQuantityHD
	From AT9000 WITH (NOLOCK)
	Where isnull(AT9000.WOrderID,'''') <>'''' and TransactionTypeID IN (''T04'')
	Group by AT9000.DivisionID, AT9000.WOrderID, InventoryID, WTransactionID
	) as K  on AT2006.DivisionID = K.DivisionID and AT2007.DivisionID = K.DivisionID and
			AT2007.VoucherID = K.WOrderID and AT2007.InventoryID = K.InventoryID and
			AT2007.TransactionID = K.WTransactionID	

WHERE AT2006.DivisionID = ''' + @DivisionID + ''' and AT2006.VoucherID in (''' + @lstWOrderID + ''')
'
EXEC(@sSQL)

Set @sSQL ='
	Select 
		T00.ObjectID, T00.VATObjectID,
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
		NULL AS RefInfor, T00.StandardPrice, T00.StandardAmount, 
		OT22.DiscountPercent,
		OT22.DiscountAmount AS SODiscountAmount,
		OT22.DiscountConvertedAmount,
		OT22.nvarchar01, OT22.nvarchar02, OT22.nvarchar03,			
		NULL S01ID, NULL S02ID, NULL S03ID, NULL S04ID, NULL S05ID, NULL S06ID, NULL S07ID, NULL S08ID, NULL S09ID, NULL S10ID,
		NULL S11ID, NULL S12ID, NULL S13ID, NULL S14ID, NULL S15ID, NULL S16ID, NULL S17ID, NULL S18ID, NULL S19ID, NULL S20ID, 
			OT22.nvarchar04, OT22.nvarchar05, OT22.nvarchar06, OT22.nvarchar07, OT22.nvarchar08, OT22.nvarchar09,
		OT22.nvarchar10, OT22.SaleOffPercent01,OT22.SaleOffAmount01 ,OT22.SaleOffPercent02,OT22.SaleOffAmount02 ,OT22.SaleOffPercent03,OT22.SaleOffAmount03 ,
		OT22.SaleOffPercent04,OT22.SaleOffAmount04 ,OT22.SaleOffPercent05,OT22.SaleOffAmount05 
	From AT9000  T00 WITH (NOLOCK)
		Inner join AT1302 T01 WITH (NOLOCK) on T01.DivisionID IN (T00.DivisionID,''@@@'') AND T00.InventoryID = T01.InventoryID
		Left Join AT1309 WQ1309 WITH (NOLOCK) On WQ1309.InventoryID = T00.InventoryID AND WQ1309.UnitID = T00.ConvertedUnitID
		Left Join AT1319 WITH (NOLOCK) on WQ1309.FormulaID = AT1319.FormulaID
		Inner join AT2006 T06 WITH (NOLOCK) on T06.DivisionID = T00.DivisionID and T06.VoucherID = T00.WOrderID
		LEFT JOIN OT2002 OT22 WITH (NOLOCK) ON OT22.DivisionID = T00.DivisionID AND OT22.InventoryID = T00.InventoryID AND OT22.SOrderID = T00.MOrderID AND OT22.TransactionID = T00.MTransactionID
	Where  T00.DivisionID = ''' + @DivisionID + '''  and 
		T00.VoucherID =  '''+@VoucherID+'''  
		and TransactionTypeID = ''T04''
		and  isnull(WTransactionID,'''')  <>''''
		
	UNION'

	
SET @sSQL1 = '
	Select T02.ObjectID, T02.ObjectID as VATObjectID,
		T00.VoucherID as WOrderID, T02.VoucherNo,
		T00.TransactionID as WTransactionID,
		T00.InventoryID,		
		T01.InventoryName, 
		Isnull(T00.UnitID,T01.UnitID) as UnitID,
		Isnull(T00.ConvertedUnitID,T00.UnitID) as ConvertedUnitID,
		V00.EndQuantity as Quantity,	
			T00.UnitPrice as UnitPrice,
			T00.ConvertedQuantity, T00.ConvertedPrice,
		case when IsNull(V00.EndQuantity,0) = IsNull(V00.ActualQuantity,0) then IsNull(T00.OriginalAmount,0) else
		IsNull(V00.EndQuantity,0) * IsNull(T00.UnitPrice,0) End As OriginalAmount , 	  
		case when  IsNull(V00.EndQuantity,0) = IsNull(V00.ActualQuantity,0) then  IsNull(T00.ConvertedAmount,0) else 
		IsNull(V00.EndQuantity,0) * IsNull(T00.UnitPrice,0) End As ConvertedAmount,
		T01.IsSource, 
		T01.IsLocation, T01.PurchaseAccountID, T01.IsLimitDate, 
		T01.AccountID, T01.MethodID, T01.IsStocked,
		T00.Ana01ID, T00.Ana02ID, T00.Ana03ID, T00.Ana04ID, T00.Ana05ID, 
		T00.Ana06ID, T00.Ana07ID, T00.Ana08ID, T00.Ana09ID, T00.Ana10ID,
		T00.Orders, cast(0 as tinyint) as IsCheck, T02.Description as BDescription, T00.Notes As TDescription, T00.DivisionID,
		WQ1309.ConversionFactor, WQ1309.Operator, WQ1309.DataType, AT1319.FormulaDes,
		T00.Parameter01, T00.Parameter02, T00.Parameter03, T00.Parameter04, T00.Parameter05, T00.RefInfor,
		T00.StandardPrice, T00.StandardAmount, 
		OT22.DiscountPercent,
		OT22.DiscountAmount AS SODiscountAmount,
		OT22.DiscountConvertedAmount,
		OT22.nvarchar01, OT22.nvarchar02,OT22.nvarchar03,			
		O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
		O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
			OT22.nvarchar04, OT22.nvarchar05, OT22.nvarchar06, OT22.nvarchar07, OT22.nvarchar08, OT22.nvarchar09,
		OT22.nvarchar10, OT22.SaleOffPercent01,OT22.SaleOffAmount01 ,OT22.SaleOffPercent02,OT22.SaleOffAmount02 ,OT22.SaleOffPercent03,OT22.SaleOffAmount03 ,
		OT22.SaleOffPercent04,OT22.SaleOffAmount04 ,OT22.SaleOffPercent05,OT22.SaleOffAmount05 
	From AT2007 T00 WITH (NOLOCK)  inner join AT2006 T02 WITH (NOLOCK) on T00.VoucherID =  T02.VoucherID and T00.DivisionID =T02.DivisionID
		inner join #TAM V00 on T00.DivisionID = V00.DivisionID and V00.VoucherID = T00.VoucherID and V00.TransactionID = T00.TransactionID 
		inner  join AT1302 T01 WITH (NOLOCK) on T01.DivisionID IN (T00.DivisionID,''@@@'') AND T00.InventoryID = T01.InventoryID
		Left Join AT1309 WQ1309 WITH (NOLOCK) On WQ1309.InventoryID = T00.InventoryID AND WQ1309.UnitID = T00.ConvertedUnitID
		Left Join AT1319 WITH (NOLOCK) on WQ1309.FormulaID = AT1319.FormulaID
		LEFT JOIN OT2002 OT22 WITH (NOLOCK) ON OT22.DivisionID = T00.DivisionID AND OT22.InventoryID = T00.InventoryID AND OT22.SOrderID = T00.MOrderID AND OT22.TransactionID = T00.MTransactionID
		left join WT8899 O99 WITH (NOLOCK) on O99.DivisionID = T00.DivisionID and O99.VoucherID = T00.VoucherID and O99.TransactionID = T00.TransactionID
	Where  T02.DivisionID = ''' + @DivisionID + ''' and V00.EndQuantity > 0
		and (ISNULL(T00.InventoryID, ''#'') IN (' + @ConditionIV + ') Or ' + @IsUsedConditionIV + ')'

If isnull (@VoucherID,'') <> '' --- truong hop edit
	EXEC('SELECT * FROM (' + @sSQL + @sSQL1 + ') A ' + 'Order by Orders')
Else 	--- truong hop add new
	EXEC('SELECT * FROM (' +@sSQL1 + ') A ' + 'Order by Orders')
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
