IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP3209_BBL]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP3209_BBL]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Customize Bourbon - Tra ra du lieu load edit Master ke thua nhieu phieu don hang ban o MH nhap kho (WF0028)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Tiểu Mai on 18/11/2016
---- Modified by Bảo Anh on 27/05/2017: Sửa danh mục dùng chung
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Xuân Nguyên on 21/07/2021: bổ sung load VoucherNo và shipdate
---- Modified by Nhựt Trường on 23/03/2023: Bỏ điều kiện DivisionID và VoucherTypeID.
---- Modified by Thành Sang on 31/07/2023: Bổ sung thêm điều kiện IsComplete.
---- Modified by Đình Định on 01/08/2023: Bổ sung điều kiện lọc theo loại chứng từ.
---- Modified by Đình Định on 03/08/2023: Bổ sung cột VoucherNo & ShipDate.
-- <Example>
---- EXEC 

CREATE PROCEDURE [dbo].[AP3209_BBL]      
			@DivisionID nvarchar(50),
		    @FromMonth int,
		    @FromYear int,
		    @ToMonth int,
		    @ToYear int,  
		    @FromDate as datetime,
		    @ToDate as Datetime,
		    @IsDate as tinyint, ----0 theo kỳ, 1 theo ngày
		    @ObjectID nvarchar(50),
		    @VoucherID nvarchar(50),	--- add new: truyen ''			
		    @VoucherTypeID NVARCHAR(50)			
AS

DECLARE @sSQL as nvarchar(Max),		
		@IsType as INT,
		@Customize AS INT,
		@sWHERE AS NVARCHAR(MAX),
		@sWHERE1 AS NVARCHAR(MAX),
		@AV1023 AS NVARCHAR(MAX),
		@AV1023WHERE1 AS NVARCHAR(MAX),
		@AV1023WHERE2 AS NVARCHAR(MAX),
		@AV1023WHERE3 AS NVARCHAR(MAX),
		@AV1023WHERE4 AS NVARCHAR(MAX)

SET @sWHERE =N''
SET @sWHERE1 = N''
SET @AV1023WHERE1 = N''
SET @AV1023WHERE2 = N''
SET @AV1023WHERE3 = N''
SET @AV1023WHERE4 = N''

DECLARE	@TempTable table(CustomerName  int,IsExcel  int)

INSERT @TempTable
EXEC	[dbo].[AP4444]

PRINT @VoucherTypeID
SET @AV1023 = N'
SELECT	T00.DivisionID, SOrderID AS OrderID, VoucherNo, OrderDate, T00.OrderStatus, 
		T00.ObjectID, T01.ObjectName, Notes, ShipDate,
		T00.TranMonth, T00.TranYear, T00.OrderType, T00.ContractNo, T00.PaymentID,
		T00.Disabled, T00.DeliveryAddress AS Address , ''SO'' AS Type , T00.VoucherTypeID, 
		T00.Transport -- Dùng cho khách hàng SGPT
FROM	OT2001 T00 WITH (NOLOCK) 
LEFT JOIN AT1202 T01 WITH (NOLOCK) on T00.ObjectID = T01.ObjectID
WHERE	OrderStatus not in (0, 9) AND T00.Disabled = 0 --- not in (0, 3, 4, 9) 
UNION ALL--Don hang hieu chinh
SELECT	T00.DivisionID, VoucherID AS OrderID, VoucherNo, VoucherDate, T00.OrderStatus, 
		T00.ObjectID, T01.ObjectName, Description AS Notes,NULL as ShipDate,
		T00.TranMonth, T00.TranYear, 0 AS OrderType, '''' AS ContractNo, '''' AS PaymentID,
		T00.Disabled, T00.DeliveryAddress AS Address , ''AS'' AS Type , T00.VoucherTypeID,
		NULL as Transport -- Dùng cho khách hàng SGPT
FROM	OT2006 T00  WITH (NOLOCK)
LEFT JOIN AT1202 T01 WITH (NOLOCK) on T00.ObjectID = T01.ObjectID
WHERE	OrderStatus not in (2, 3, 9) AND T00.Disabled = 0 --- not in (0, 3, 4, 9) 
UNION ALL --- Don hang mua
SELECT	T00.DivisionID, POrderID AS OrderID, VoucherNo, OrderDate, T00.OrderStatus, 
		T00.ObjectID, T01.ObjectName, Notes,NULL as ShipDate,
		T00.TranMonth, T00.TranYear, T00.OrderType, T00.ContractNo, T00.PaymentID,
		T00.Disabled, T00.ReceivedAddress AS Address , ''PO'' AS Type , T00.VoucherTypeID,
		NULL as Transport -- Dùng cho khách hàng SGPT
From	OT3001 T00 WITH (NOLOCK) 
LEFT JOIN AT1202 T01 WITH (NOLOCK) on T00.ObjectID = T01.ObjectID
WHERE	OrderStatus not in (0, 9) AND T00.Disabled = 0 --- not in (0, 3, 4, 9)
'
--PRINT @AV1023
IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE XTYPE ='V' AND NAME = 'AV1023X')
	EXEC('CREATE VIEW AV1023X  --tao boi AP3209_BBL
		as '+@AV1023)
ELSE
	EXEC('ALTER VIEW AV1023X  --- tao boi AP3209_BBL
		as '+@AV1023)

SELECT @IsType= CASE WHEN CustomerName<>1 THEN 0 ELSE 1 END  FROM @TempTable

SET  @sSQL = N' 
SELECT  TOP 100 PERCENT AT2007.OrderID, AV1023X.OrderDate, AV1023X.ObjectID, 
		AV1023X.ObjectName, AV1023X.Notes,IsCheck = 1, AV1023X.VoucherTypeID,  
		AT2006.RDAddress as Address, AT2007.DivisionID, AV1023X.Transport, AV1023X.VoucherNo, AV1023X.ShipDate
FROM	AT2007 WITH (NOLOCK)
INNER JOIN AT2006 WITH (NOLOCK) ON AT2007.DivisionID = AT2006.DivisionID AND AT2007.VoucherID = AT2006. VoucherID
INNER JOIN AV1023X WITH (NOLOCK) ON AT2007.DivisionID = AV1023X.DivisionID AND AT2007.OrderID = AV1023X.OrderID  
WHERE	AT2007.VoucherID = ''' + @VoucherID + ''' 
ORDER BY AT2007.OrderID   '
--PRINT @sSQL
IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE XTYPE ='V' AND NAME = 'AV3215')
	EXEC('CREATE VIEW AV3215  --tao boi AP3209_BBL
		as '+@sSQL)
ELSE
	EXEC('ALTER VIEW AV3215  --- tao boi AP3209_BBL
		as '+@sSQL)

		

If @IsDate =0
Begin
	Set @sSQL =' 
	SELECT	AV1023X.OrderID, AV1023X.VoucherNo ,AV1023X.OrderDate, AV1023X.ObjectID, AV1023X.ObjectName, AV1023X.Notes, 
			Ischeck = 0, AV1023X.VoucherTypeID, AV1023X.Address, DivisionID, AV1023X.Transport, AV1023X.ShipDate
	FROM	AV1023X WITH (NOLOCK)
	WHERE	ObjectID like '''+@ObjectID+ '''
			'+@sWHERE+'	
		AND VoucherTypeID = '''+@VoucherTypeID+'''
		AND Disabled = 0  AND Type = ''SO'' AND OrderType = ' + str(@IsType) + ' AND OrderStatus Not In (0,3,4,5,9)
		AND OrderID In (SELECT Distinct AQ1023.OrderID 
		                FROM (Select OT2001.DivisionID, TranMonth, TranYear, OT2002.SOrderID as OrderID,  OT2001.OrderStatus, TransactionID, OT2001.Duedate, OT2001.Shipdate,
							OT2002.InventoryID, Isnull(OrderQuantity,0) as OrderQuantity  ,Isnull( ActualQuantity,0) as ActualQuantity, OT2001.PaymentTermID,AT1208.Duedays,
							case when OT2002.Finish = 1 then NULL else isnull(OrderQuantity, 0)- isnull(ActualQuantity, 0) end as EndQuantity, 0 as EndConvertedQuantity,
						 ( isnull(OriginalAmount,0) - isnull(ActualOriginalAmount,0 ))  as EndOriginalAmount, ISNULL(OT2001.IsComplete,0) as IsComplete
						From OT2002 with (nolock) inner join OT2001 with (nolock) on OT2002.SOrderID = OT2001.SOrderID
	left join AT1208 with (nolock) on AT1208.PaymentTermID = OT2001.PaymentTermID 	
	left join 
		(Select AT2007.DivisionID, AT2007.OrderID, OTransactionID,
		InventoryID, sum(ActualQuantity) As ActualQuantity, sum(isnull(OriginalAmount,0)) as ActualOriginalAmount
		From AT2007 with (nolock) inner join AT2006 with (nolock) on AT2007.VoucherID = AT2006.VoucherID
		Where isnull(AT2007.OrderID,'''') <>'''' and AT2006.KindVoucherID = 1
		Group by AT2007.DivisionID, AT2007.OrderID, InventoryID, OTransactionID) as G  --- (co nghia la Giao  hang)
		on 	OT2001.DivisionID = G.DivisionID and
			OT2002.SOrderID = G.OrderID and
			OT2002.InventoryID = G.InventoryID and
			OT2002.TransactionID = G.OTransactionID) AQ1023 Where EndQuantity>0 AND IsComplete <> 1)
		AND  TranMonth+TranYear*100 between ' + cast(@FromMonth + @FromYear*100 as nvarchar(50)) + ' AND ' +  cast(@ToMonth + @ToYear*100 as nvarchar(50))  
		
    If isnull (@VoucherID,'') <> ''
    Begin	
	Set @sSQL = @sSQL + '  
		AND OrderID NOT IN ( SELECT OrderID FROM AV3215 WITH (NOLOCK) )
		UNION 
		SELECT	AV3215.OrderID, VoucherNo, AV3215.OrderDate, AV3215.ObjectID, AV3215.ObjectName, AV3215.Notes, 
				IsCheck = 1, AV3215.VoucherTypeID, AV3215.Address, AV3215.DivisionID, AV3215.Transport, ShipDate
		FROM	AV3215 WITH (NOLOCK)'
    End

End

Else
Begin
	Set @sSQL =' 
	SELECT	AV1023X.OrderID, AV1023X.VoucherNo, AV1023X.OrderDate, AV1023X.ObjectID, AV1023X.ObjectName, AV1023X.ShipDate,
			AV1023X.Notes, Ischeck = 0, AV1023X.VoucherTypeID, AV1023X.Address, DivisionID, 
			AV1023X.Transport -- Dùng cho khách hàng SGPT
	FROM	AV1023X WITH (NOLOCK)
	WHERE	ObjectID like '''+@ObjectID+ ''' 
		AND VoucherTypeID = '''+@VoucherTypeID+'''
		AND Disabled=0  AND Type=''SO'' AND OrderType = ' + str(@IsType) + ' AND OrderStatus Not In (0,3,4,5,9)
		AND OrderID In (SELECT Distinct  AQ1023.OrderID FROM (Select OT2001.DivisionID, TranMonth, TranYear, OT2002.SOrderID as OrderID,  OT2001.OrderStatus, TransactionID, OT2001.Duedate, OT2001.Shipdate,
							OT2002.InventoryID, Isnull(OrderQuantity,0) as OrderQuantity  ,Isnull( ActualQuantity,0) as ActualQuantity, OT2001.PaymentTermID,AT1208.Duedays,
							case when OT2002.Finish = 1 then NULL else isnull(OrderQuantity, 0)- isnull(ActualQuantity, 0) end as EndQuantity, 0 as EndConvertedQuantity,
						 ( isnull(OriginalAmount,0) - isnull(ActualOriginalAmount,0 ))  as EndOriginalAmount, ISNULL(OT2001.IsComplete,0) as IsComplete
						From OT2002 with (nolock) inner join OT2001 with (nolock) on OT2002.SOrderID = OT2001.SOrderID
	left join AT1208 with (nolock) on AT1208.PaymentTermID = OT2001.PaymentTermID 	
	left join 
		(Select AT2007.DivisionID, AT2007.OrderID, OTransactionID,
		InventoryID, sum(ActualQuantity) As ActualQuantity, sum(isnull(OriginalAmount,0)) as ActualOriginalAmount
		From AT2007 with (nolock) inner join AT2006 with (nolock) on AT2007.VoucherID = AT2006.VoucherID
		Where isnull(AT2007.OrderID,'''') <>'''' and AT2006.KindVoucherID = 1
		Group by AT2007.DivisionID, AT2007.OrderID, InventoryID, OTransactionID) as G  --- (co nghia la Giao  hang)
		on 	OT2001.DivisionID = G.DivisionID and
			OT2002.SOrderID = G.OrderID and
			OT2002.InventoryID = G.InventoryID and
			OT2002.TransactionID = G.OTransactionID) AQ1023 Where EndQuantity>0 And IsComplete <> 1)
		AND AV1023X.OrderDate  Between '''+Convert(nvarchar(10),@FromDate,21)+''' AND '''+convert(nvarchar(10), @ToDate,21)+''''
	    If isnull (@VoucherID,'') <> ''
	    Begin
		Set @sSQL = @sSQL + ' AND OrderID not in ( SELECT OrderID FROM AV3215 WITH (NOLOCK) )
					Union 
					SELECT AV3215.OrderID, VoucherNo, AV3215.OrderDate, AV3215.ObjectID, AV3215.ObjectName, ShipDate, AV3215.Notes, IsCheck = 1, AV3215.VoucherTypeID, AV3215.Address, AV3215.DivisionID,
					AV3215.Transport
					FROM AV3215 WITH (NOLOCK)'
	    End
End

--IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE XTYPE ='V' AND NAME = 'AV3209')
--	EXEC('CREATE VIEW AV3209  --tao boi AP3209_BBL
--		as '+@sSQL)
--ELSE
--	EXEC('ALTER VIEW AV3209  --- tao boi AP3209_BBL
--		as '+@sSQL)

PRINT @sSQL
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO