IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0263_QC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0263_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


--- Created by: Tiểu Mai
--- Date: 25/05/2016
--- Purpose: Tách store load detail cho man hinh ke thua nhieu phieu nhap kho (AF0263) theo quy cách
--- Modified on 16/05/2017 by Hải Long: Chỉnh sửa danh mục dùng chung
--- Modified by Bảo Thy on 26/10/2017: chuyển @lstWOrderID sang XML để ko tràn chuỗi
--- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.

CREATE PROCEDURE [dbo].[AP0263_QC] @DivisionID nvarchar(50),				
				@lstWOrderID XML,
				@VoucherID nvarchar(50), --- Addnew   truyen ''; Load Edit :  so chung tu vua duoc chon sua
				@ConditionIV nvarchar(max),
				@IsUsedConditionIV nvarchar(20)
				
AS
Declare @sSQL  nvarchar(4000),
	@sSQL1  nvarchar(4000),
	@sSQL2  NVARCHAR(MAX)

SET @sSQL1 = ''
SET @sSQL2 = ''
--Set  @lstWOrderID = 	Replace(@lstWOrderID, ',', ''',''')
IF @lstWOrderID IS NOT NULL
BEGIN
	CREATE TABLE #AP0263_WOrderID (VoucherID VARCHAR(50))
	INSERT INTO #AP0263_WOrderID (VoucherID)
	SELECT X.Data.query('OrderID').value('.', 'NVARCHAR(50)') AS OrderID
	FROM @lstWOrderID.nodes('//Data') AS X (Data)
END


DECLARE @CustomerName INT
--Tao bang tam de kiem tra day co phai la khach hang ANGEL khong (CustomerName = 57)
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)


IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N'tempdb.dbo.#TAM')) 
	DROP TABLE #TAM

CREATE TABLE #TAM
(
	DivisionID nvarchar(50),
	VoucherID nvarchar(50),
	TransactionID nvarchar(50),
	ActualQuantity decimal(28,8),
	EndQuantity decimal(28,8),
	EndConvertedQuantity decimal(28,8)
)

Set  @sSQL = '
INSERT INTO #TAM (DivisionID, VoucherID, TransactionID, ActualQuantity, EndQuantity,EndConvertedQuantity)
Select 
	AT2006.DivisionID, AT2007.VoucherID, AT2007.TransactionID, AT2007.ActualQuantity,
	(isnull(ActualQuantity, 0) - isnull(ActualQuantityHD,0)) as EndQuantity,
	((CASE WHEN ISNULL(AT2007.ConvertedQuantity,0) <> 0 THEN ISNULL(AT2007.ConvertedQuantity,0) ELSE ISNULL(AT2007.ActualQuantity,0) END) - ISNULL(ConvertedQuantityHD,0)) AS EndConvertedQuantity
From AT2006
inner join AT2007 on AT2007.DivisionID = AT2006.DivisionID and AT2007.VoucherID = AT2006.VoucherID
Left join (
	Select AT9000.DivisionID, AT9000.WOrderID, WTransactionID, InventoryID, sum(Quantity) As ActualQuantityHD,
	SUM(CASE WHEN ISNULL(AT9000.ConvertedQuantity,0) <> 0 THEN ISNULL(AT9000.ConvertedQuantity,0) ELSE ISNULL(AT9000.Quantity,0) END) AS ConvertedQuantityHD
	From AT9000
	Where isnull(AT9000.WOrderID,'''') <>'''' and TransactionTypeID IN (''T03'')
	Group by AT9000.DivisionID, AT9000.WOrderID, InventoryID, WTransactionID
	) as K  on AT2006.DivisionID = K.DivisionID and AT2007.DivisionID = K.DivisionID and
			AT2007.VoucherID = K.WOrderID and AT2007.InventoryID = K.InventoryID and
			AT2007.TransactionID = K.WTransactionID	
WHERE AT2006.DivisionID = ''' + @DivisionID + ''' 
'+CASE WHEN @lstWOrderID IS NOT NULL THEN 'AND EXISTS (SELECT TOP 1 1 FROM #AP0263_WOrderID WHERE AT2006.VoucherID = #AP0263_WOrderID.VoucherID)' ELSE 'AND 1=0' END+'
'
EXEC(@sSQL)

		Set @sSQL ='
			Select 
			T00.ObjectID, T00.VATObjectID, T06.WareHouseID,
			T00.WOrderID, T06.VoucherNo, T00.WTransactionID,
			T00.InventoryID,T01.InventoryName, Isnull(T00.UnitID,T01.UnitID) as UnitID,
			Isnull(T00.ConvertedUnitID,T00.UnitID) as ConvertedUnitID,
			T00.Quantity, T00.UnitPrice,
			T00.ConvertedQuantity, T00.ConvertedPrice,
			T00.OriginalAmount, T00.ConvertedAmount, 
			T01.IsSource, T01.IsLocation, T01.PurchaseAccountID, T01.IsLimitDate, 
			T01.AccountID, T01.MethodID, T01.IsStocked,
			T00.Ana01ID, T00.Ana02ID, T00.Ana03ID, T00.Ana04ID,  T00.Ana05ID,
			T00.Ana06ID, T00.Ana07ID, T00.Ana08ID, T00.Ana09ID,  T00.Ana10ID,
			T00.Orders, cast(1 as tinyint) as IsCheck, BDescription, T00.DivisionID,
			WQ1309.ConversionFactor, WQ1309.Operator, WQ1309.DataType, AT1319.FormulaDes,
			T00.Parameter01, T00.Parameter02, T00.Parameter03, T00.Parameter04, T00.Parameter05,			
			NULL S01ID, NULL S02ID, NULL S03ID, NULL S04ID, NULL S05ID, NULL S06ID, NULL S07ID, NULL S08ID, NULL S09ID, NULL S10ID,
			NULL S11ID, NULL S12ID, NULL S13ID, NULL S14ID, NULL S15ID, NULL S16ID, NULL S17ID, NULL S18ID, NULL S19ID, NULL S20ID
			From AT9000  T00 WITH (NOLOCK)
			Inner join AT1302 T01 WITH (NOLOCK) on T01.DivisionID IN (T00.DivisionID,''@@@'') AND T00.InventoryID = T01.InventoryID
			Left Join AT1309 WQ1309 WITH (NOLOCK) On WQ1309.InventoryID = T00.InventoryID AND WQ1309.UnitID = T00.ConvertedUnitID
			Left Join AT1319 WITH (NOLOCK) on WQ1309.FormulaID = AT1319.FormulaID
			Inner join AT2006 T06 WITH (NOLOCK) on T06.DivisionID = T00.DivisionID and T06.VoucherID = T00.WOrderID
			Where  T00.DivisionID = ''' + @DivisionID + '''  and 
			T00.VoucherID =  '''+@VoucherID+'''  
			and TransactionTypeID = ''T03''
			and  isnull(WTransactionID,'''')  <> ''''
			UNION '
			
		SET @sSQL1 = '
	Select T02.ObjectID, T02.ObjectID as VATObjectID, T02.WareHouseID,
		T00.VoucherID as WOrderID, T02.VoucherNo,
		T00.TransactionID as WTransactionID,
		T00.InventoryID,		
		T01.InventoryName, 
		Isnull(T00.UnitID,T01.UnitID) as UnitID,
		Isnull(T00.ConvertedUnitID,T00.UnitID) as ConvertedUnitID,
		V00.EndQuantity as Quantity,	
		T00.UnitPrice as UnitPrice,
		--T00.ConvertedQuantity, T00.ConvertedPrice,
		V00.EndConvertedQuantity AS ConvertedQuantity, 
		(CASE WHEN ISNULL(T00.ConvertedPrice,0) <> 0 THEN ISNULL(T00.ConvertedPrice,0) ELSE ISNULL(T00.UnitPrice,0) END) AS ConvertedPrice,
		case when IsNull(V00.EndQuantity,0) = IsNull(V00.ActualQuantity,0) then IsNull(T00.OriginalAmount,0) else
		IsNull(V00.EndQuantity,0) * IsNull(T00.UnitPrice,0) End As OriginalAmount , 	  
		case when  IsNull(V00.EndQuantity,0) = IsNull(V00.ActualQuantity,0) then  IsNull(T00.ConvertedAmount,0) else 
		IsNull(V00.EndQuantity,0) * IsNull(T00.UnitPrice,0) End As ConvertedAmount,
		T01.IsSource, 
		T01.IsLocation, T01.PurchaseAccountID, T01.IsLimitDate, 
		T01.AccountID, T01.MethodID, T01.IsStocked,
		T00.Ana01ID, T00.Ana02ID, T00.Ana03ID, T00.Ana04ID, T00.Ana05ID, 
		T00.Ana06ID, T00.Ana07ID, T00.Ana08ID, T00.Ana09ID, T00.Ana10ID,
		T00.Orders, cast(0 as tinyint) as IsCheck, T02.Description as BDescription, T00.DivisionID,
		WQ1309.ConversionFactor, WQ1309.Operator, WQ1309.DataType, AT1319.FormulaDes,
		T00.Parameter01, T00.Parameter02, T00.Parameter03, T00.Parameter04, T00.Parameter05,			
		O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
		O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID	'
	
		SET @sSQL2 = '
	From AT2007 T00 WITH (NOLOCK)  inner join AT2006 T02 WITH (NOLOCK) on T00.DivisionID = T02.DivisionID and T00.VoucherID = T02.VoucherID
		inner join #TAM V00 on T00.DivisionID = V00.DivisionID and V00.VoucherID = T00.VoucherID and V00.TransactionID = T00.TransactionID 
		inner  join AT1302 T01 WITH (NOLOCK) on T01.DivisionID IN (T00.DivisionID,''@@@'') AND T00.InventoryID = T01.InventoryID
		Left Join AT1309 WQ1309 WITH (NOLOCK) On WQ1309.InventoryID = T00.InventoryID AND WQ1309.UnitID = T00.ConvertedUnitID
		Left Join AT1319 WITH (NOLOCK) on WQ1309.FormulaID = AT1319.FormulaID
		left join WT8899 O99 WITH (NOLOCK) on O99.DivisionID = T00.DivisionID and O99.VoucherID = T00.VoucherID and O99.TransactionID = T00.TransactionID
	Where  T02.DivisionID = ''' + @DivisionID + ''' and V00.EndQuantity > 0
		and (ISNULL(T00.InventoryID, ''#'') IN (' + @ConditionIV + ') Or ' + @IsUsedConditionIV + ')'
	
If isnull (@VoucherID,'') <> '' --- truong hop edit
	EXEC('SELECT * FROM (' + @sSQL + @sSQL1 + @sSQL2 + ') A ' + 'Order by WOrderID,Orders')
Else 	--- truong hop add new
	EXEC('SELECT * FROM (' +@sSQL1 + @sSQL2 + ') A ' + 'Order by WOrderID,Orders')
	
	--PRINT @sSQL
	--PRINT @sSQL1
	--PRINT @sSQL2

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
