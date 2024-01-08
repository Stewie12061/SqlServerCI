IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP3209]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP3209]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Tra ra du lieu load edit Master ke thua nhieu phieu don hang ban o MH nhap kho (WF0028)
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
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified by Đình Định on 01/08/2023: BBL - Bổ sung điều kiện lọc theo loại chứng từ.
---- Modified by Thành Sang on 18/09/2023: KINGCOM - Bổ sung Load thêm phiếu xuất.
-- <Example>
---- EXEC 

CREATE PROCEDURE [dbo].[AP3209]      
			@DivisionID nvarchar(50),
		    @FromMonth int,
		    @FromYear int,
		    @ToMonth int,
		    @ToYear int,  
		    @FromDate as datetime,
		    @ToDate as Datetime,
		    @IsDate as tinyint, ----0 theo kỳ, 1 theo ngày
		    @ObjectID nvarchar(50),
		    @VoucherID nvarchar(50)	--- add new: truyen ''			
				
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
		@AV1023WHERE4 AS NVARCHAR(MAX),
		@KindVoucherID AS NVARCHAR(50)
		
SET @sWHERE = N''
SET @sWHERE1 = N''
SET @AV1023WHERE1 = N''
SET @AV1023WHERE2 = N''
SET @AV1023WHERE3 = N''
SET @AV1023WHERE4 = N''

		
DECLARE	@TempTable table(CustomerName  int,IsExcel  int)

INSERT @TempTable
EXEC	[dbo].[AP4444]

SET @Customize = (SELECT TOP 1 CustomerName FROM @TempTable)

IF @Customize = 57	--- ANGEL
	EXEC AP3205_AG @DivisionID, @FromMonth, @FromYear, @ToMonth, @ToYear, @FromDate, @ToDate, @IsDate, @ObjectID, @VoucherID
ELSE
IF @Customize = 38	--- Bourbon
	EXEC AP3209_BBL @DivisionID, @FromMonth, @FromYear, @ToMonth, @ToYear, @FromDate, @ToDate, @IsDate, @ObjectID, @VoucherID
ELSE
BEGIN
IF @Customize = 12 ---->> Khách hàng Thuận Lợi
BEGIN
	SET @sWHERE = N'
		AND AV1023x.VoucherTypeID not like ''BL%'''

			
	SET @sWHERE1 = N'
		AND AV1023x.VoucherTypeID not like ''BL%''
		AND (	SELECT	COUNT(OT.VoucherID)
				FROM	OT2007 OT
				LEFT JOIN AT1302 ON AT1302.DivisionID IN (OT.DivisionID,''@@@'') AND AT1302.InventoryID = OT.InventoryID
				WHERE	AT1302.IsStocked = 1
						AND OT.VoucherID = AT2007.VoucherID 
						AND OT.DivisionID = AT2007.DivisionID
			) >0'

	SET @AV1023WHERE1 = N'
		AND (	SELECT	COUNT(OT.SOrderID)
				FROM	OT2002 OT
				LEFT JOIN AT1302 ON AT1302.DivisionID IN (OT.DivisionID,''@@@'') AND AT1302.InventoryID = OT.InventoryID
				WHERE	AT1302.IsStocked = 1
						AND OT.SOrderID = T00.SOrderID 
						AND OT.DivisionID = T00.DivisionID
			) >0 '
			
	SET @AV1023WHERE2 = N'
		AND (	SELECT	COUNT(OT.VoucherID)
				FROM	OT2007 OT
				LEFT JOIN AT1302 ON AT1302.DivisionID IN (OT.DivisionID,''@@@'') AND AT1302.InventoryID = OT.InventoryID
				WHERE	AT1302.IsStocked = 1
						AND OT.VoucherID = T00.VoucherID 
						AND OT.DivisionID = T00.DivisionID
			) >0 '
			
	SET @AV1023WHERE3 = N'
		AND (	SELECT	COUNT(OT.POrderID)
				FROM	OT3002 OT
				LEFT JOIN AT1302 ON AT1302.DivisionID IN (OT.DivisionID,''@@@'') AND AT1302.InventoryID = OT.InventoryID
				WHERE	AT1302.IsStocked = 1
						AND OT.POrderID = T00.POrderID 
						AND OT.DivisionID = T00.DivisionID
			) >0 '
		
END
IF @Customize = 43 ---->> Khách hàng Secoin
BEGIN
	SET @AV1023WHERE4 = N' 
		AND T00.OrderTypeID = 0  
		and T00.SOrderID in (
				Select AQ2901.SOrderID
				from
				(		--Begin View Cu AQ2901
						Select OT2001.DivisionID, OT2001.TranMonth, OT2001.TranYear, OT2002.SOrderID,  OT2001.OrderStatus, 
								OT2002.TransactionID, OT2001.Duedate, OT2001.Shipdate, OT2002.InventoryID, 
								Isnull(OT2002.OrderQuantity,0) as OrderQuantity  ,Isnull( G.ActualQuantity,0) as ActualQuantity, 
								OT2001.PaymentTermID,AT1208.Duedays,
								case when OT2002.Finish = 1 
									then NULL else isnull(OT2002.OrderQuantity, 0)
										- isnull(G.ActualQuantity, 0) 
										+ isnull(T.OrderQuantity ,0) end as EndQuantity, 
								G.OrderID as T9OrderID,
								case when OT2002.Finish = 1 
									then NULL else isnull(OT2002.ConvertedQuantity, 0)
													- isnull(G.ActualConvertedQuantity, 0) 
													+ Isnull(T.ConvertedQuantity,0)
								end as EndConvertedQuantity,
								( isnull(OT2002.OriginalAmount,0) - isnull(G.ActualOriginalAmount,0 ) + isnull(T.OriginalAmount,0))  as EndOriginalAmount
						From OT2002 WITH (NOLOCK) inner join OT2001 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2002.SOrderID = OT2001.SOrderID
									left join AT1208 WITH (NOLOCK) ON AT1208.PaymentTermID = OT2001.PaymentTermID 	
									left join 	(
													Select AT9000.DivisionID, AT9000.OrderID, OTransactionID,
															InventoryID, sum(Quantity) As ActualQuantity, sum(isnull(OriginalAmount,0)) as ActualOriginalAmount,
															SUM(isnull(ConvertedQuantity,Quantity)) As ActualConvertedQuantity
														From AT9000  WITH (NOLOCK)
														WHERE TransactionTypeID in (''T04'', ''T06'') and IsStock = 0 AND isnull(AT9000.OrderID,'''') <>''''
														Group by AT9000.DivisionID, AT9000.OrderID, InventoryID, OTransactionID
													) as G  --- (co nghia la Giao  hang)
													on 	OT2001.DivisionID = G.DivisionID AND OT2002.SOrderID = G.OrderID 
														and OT2002.InventoryID = G.InventoryID AND OT2002.TransactionID = G.OTransactionID
						--End View Cu AQ2901
									Left join (
												Select D.DivisionID, D.InventoryID, 
														Sum(D.OrderQuantity) as OrderQuantity, 
														Sum(D.ConvertedQuantity) as ConvertedQuantity, 
														Sum(D.OriginalAmount) as OriginalAmount,
														D.InheritVoucherID, D.InheritTransactionID 
												From OT2001 M WITH (NOLOCK) Inner join OT2002 D WITH (NOLOCK) on M.DivisionID = D.DivisionID and M.SOrderID = D.SOrderID
												Where M.OrderTypeID = 1
												Group by D.DivisionID, D.InventoryID, D.InheritVoucherID, D.InheritTransactionID
												) as T on T.DivisionID = OT2002.DivisionID and T.InheritVoucherID = OT2002.SOrderID 
																							and T.InheritTransactionID = OT2002.TransactionID
						Where OT2001.OrderTypeID = 0 or OT2001.OrderTypeID is null
						) AQ2901
						Where AQ2901.EndQuantity > 0)
					'
END

IF @Customize = 25	--- KINGCOM
	SET @KindVoucherID = N'AT2006.KindVoucherID IN (1,2)'
ELSE 
	SET @KindVoucherID = N'AT2006.KindVoucherID = 1'



SET @AV1023 = N'
SELECT	T00.DivisionID, SOrderID AS OrderID, VoucherNo, OrderDate, T00.OrderStatus, 
		T00.ObjectID, T01.ObjectName, Notes, ShipDate,
		T00.TranMonth, T00.TranYear, T00.OrderType, T00.ContractNo, T00.PaymentID,
		T00.Disabled, T00.DeliveryAddress AS Address , ''SO'' AS Type , T00.VoucherTypeID, 
		T00.Transport -- Dùng cho khách hàng SGPT
FROM	OT2001 T00 WITH (NOLOCK) 
LEFT JOIN AT1202 T01 WITH (NOLOCK) on T01.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T00.ObjectID = T01.ObjectID
WHERE	OrderStatus not in (0, 9) AND T00.Disabled = 0 --- not in (0, 3, 4, 9) 
		AND T00.DivisionID = '''+@DivisionID+'''
		'+@AV1023WHERE1+''+@AV1023WHERE4+'
UNION ALL--Don hang hieu chinh
SELECT	T00.DivisionID, VoucherID AS OrderID, VoucherNo, VoucherDate, T00.OrderStatus, 
		T00.ObjectID, T01.ObjectName, Description AS Notes,NULL as ShipDate,
		T00.TranMonth, T00.TranYear, 0 AS OrderType, '''' AS ContractNo, '''' AS PaymentID,
		T00.Disabled, T00.DeliveryAddress AS Address , ''AS'' AS Type , T00.VoucherTypeID,
		NULL as Transport -- Dùng cho khách hàng SGPT
FROM	OT2006 T00  WITH (NOLOCK)
LEFT JOIN AT1202 T01 WITH (NOLOCK) on T01.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T00.ObjectID = T01.ObjectID
WHERE	OrderStatus not in (2, 3, 9) AND T00.Disabled = 0 --- not in (0, 3, 4, 9) 
		AND T00.DivisionID = '''+@DivisionID+'''
		'+@AV1023WHERE2+'
UNION ALL --- Don hang mua
SELECT	T00.DivisionID, POrderID AS OrderID, VoucherNo, OrderDate, T00.OrderStatus, 
		T00.ObjectID, T01.ObjectName, Notes,NULL as ShipDate,
		T00.TranMonth, T00.TranYear, T00.OrderType, T00.ContractNo, T00.PaymentID,
		T00.Disabled, T00.ReceivedAddress AS Address , ''PO'' AS Type , T00.VoucherTypeID,
		NULL as Transport -- Dùng cho khách hàng SGPT
From	OT3001 T00 WITH (NOLOCK) 
LEFT JOIN AT1202 T01 WITH (NOLOCK) on T01.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T00.ObjectID = T01.ObjectID
WHERE	OrderStatus not in (0, 9) AND T00.Disabled = 0 --- not in (0, 3, 4, 9)
		AND T00.DivisionID = '''+@DivisionID+'''
		'+@AV1023WHERE3+'
'

IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE XTYPE ='V' AND NAME = 'AV1023X')
	EXEC('CREATE VIEW AV1023X  --tao boi AP3209
		as '+@AV1023)
ELSE
	EXEC('ALTER VIEW AV1023X  --- tao boi AP3209
		as '+@AV1023)


SELECT @IsType= CASE WHEN CustomerName<>1 THEN 0 ELSE 1 END  FROM @TempTable

SET  @sSQL =' 
SELECT  TOP 100 percent AT2007.OrderID, AV1023X.OrderDate, AV1023X.ObjectID, 
		AV1023X.ObjectName, AV1023X.Notes,IsCheck = 1, AV1023X.VoucherTypeID,  
		AT2006.RDAddress as Address, AT2007.DivisionID, AV1023X.Transport
FROM	AT2007 WITH (NOLOCK)
INNER JOIN AT2006 WITH (NOLOCK) on AT2007.VoucherID = AT2006. VoucherID AND AT2007.DivisionID = AT2006. DivisionID
INNER JOIN AV1023X On AT2007.OrderID = AV1023X.OrderID AND AT2007.DivisionID = AV1023X.DivisionID 
WHERE	AT2007.VoucherID = ''' + @VoucherID + ''' 
		AND  AT2007.DivisionID = ''' + @DivisionID + '''
		'+@sWHERE1+'	
ORDER BY AT2007.OrderID 
'

IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE XTYPE ='V' AND NAME = 'AV3215')
	EXEC('CREATE VIEW AV3215  --tao boi AP3209
		as '+@sSQL)
ELSE
	EXEC('ALTER VIEW AV3215  --- tao boi AP3209
		as '+@sSQL)



If @IsDate =0
Begin
	Set @sSQL =' 
	SELECT	AV1023X.OrderID,AV1023X.VoucherNo ,AV1023X.OrderDate, AV1023X.ObjectID, AV1023X.ObjectName, AV1023X.Notes, 
			Ischeck = 0, AV1023X.VoucherTypeID, AV1023X.Address, DivisionID, AV1023X.Transport,AV1023X.ShipDate
	FROM	AV1023X
	WHERE	DivisionID = ''' + @DivisionID + ''' 
			'+@sWHERE+'	
 		AND ObjectID like '''+@ObjectID+ ''' 
		AND Disabled = 0  AND Type = ''SO'' AND OrderType = ' + str(@IsType) + ' AND OrderStatus Not In (0,3,4,5,9)
		AND OrderID In (SELECT Distinct AQ1023.OrderID 
		                FROM (Select OT2001.DivisionID, TranMonth, TranYear, OT2002.SOrderID as OrderID,  OT2001.OrderStatus, TransactionID, OT2001.Duedate, OT2001.Shipdate,
							OT2002.InventoryID, Isnull(OrderQuantity,0) as OrderQuantity  ,Isnull( ActualQuantity,0) as ActualQuantity, OT2001.PaymentTermID,AT1208.Duedays,
							case when OT2002.Finish = 1 then NULL else isnull(OrderQuantity, 0)- isnull(ActualQuantity, 0) end as EndQuantity, 0 as EndConvertedQuantity,
						 ( isnull(OriginalAmount,0) - isnull(ActualOriginalAmount,0 ))  as EndOriginalAmount
						From OT2002 with (nolock) inner join OT2001 with (nolock) on OT2002.SOrderID = OT2001.SOrderID
	left join AT1208 with (nolock) on AT1208.PaymentTermID = OT2001.PaymentTermID 	
	left join 
		(Select AT2007.DivisionID, AT2007.OrderID, OTransactionID,
		InventoryID, sum(ActualQuantity) As ActualQuantity, sum(isnull(OriginalAmount,0)) as ActualOriginalAmount
		From AT2007 with (nolock) inner join AT2006 with (nolock) on AT2007.VoucherID = AT2006.VoucherID
		Where isnull(AT2007.OrderID,'''') <>'''' AND ' + @KindVoucherID + '
		Group by AT2007.DivisionID, AT2007.OrderID, InventoryID, OTransactionID) as G  --- (co nghia la Giao  hang)
		on 	OT2001.DivisionID = G.DivisionID and
			OT2002.SOrderID = G.OrderID and
			OT2002.InventoryID = G.InventoryID and
			OT2002.TransactionID = G.OTransactionID) AQ1023 Where EndQuantity>0 AND DivisionID= ''' + @DivisionID + '''   ) 
		AND  TranMonth+TranYear*100 between ' + cast(@FromMonth + @FromYear*100 as nvarchar(50)) + ' AND ' +  cast(@ToMonth + @ToYear*100 as nvarchar(50))  
		
    If isnull (@VoucherID,'') <> ''
    Begin	
	Set @sSQL = @sSQL + '  
		AND OrderID NOT IN ( SELECT OrderID FROM AV3215 )
		UNION 
		SELECT	AV3215.OrderID, AV3215.OrderDate, AV3215.ObjectID, AV3215.ObjectName, AV3215.Notes, 
				IsCheck = 1, AV3215.VoucherTypeID, AV3215.Address, AV3215.DivisionID, AV3215.Transport
		FROM	AV3215'
    End
End

Else
Begin
	Set @sSQL =' 
	SELECT	AV1023X.OrderID,AV1023X.VoucherNo, AV1023X.OrderDate, AV1023X.ObjectID, AV1023X.ObjectName, AV1023X.ShipDate,
			AV1023X.Notes, Ischeck = 0, AV1023X.VoucherTypeID, AV1023X.Address, DivisionID, 
			AV1023X.Transport -- Dùng cho khách hàng SGPT
	FROM	AV1023X
	WHERE	DivisionID = ''' + @DivisionID + '''
			'+@sWHERE+'	 
	 	AND ObjectID like '''+@ObjectID+ ''' 
		AND Disabled=0  AND Type=''SO'' AND OrderType = ' + str(@IsType) + ' AND OrderStatus Not In (0,3,4,5,9)
		AND OrderID In (SELECT Distinct  AQ1023.OrderID FROM (Select OT2001.DivisionID, TranMonth, TranYear, OT2002.SOrderID as OrderID,  OT2001.OrderStatus, TransactionID, OT2001.Duedate, OT2001.Shipdate,
							OT2002.InventoryID, Isnull(OrderQuantity,0) as OrderQuantity  ,Isnull( ActualQuantity,0) as ActualQuantity, OT2001.PaymentTermID,AT1208.Duedays,
							case when OT2002.Finish = 1 then NULL else isnull(OrderQuantity, 0)- isnull(ActualQuantity, 0) end as EndQuantity, 0 as EndConvertedQuantity,
						 ( isnull(OriginalAmount,0) - isnull(ActualOriginalAmount,0 ))  as EndOriginalAmount
						From OT2002 with (nolock) inner join OT2001 with (nolock) on OT2002.SOrderID = OT2001.SOrderID
	left join AT1208 with (nolock) on AT1208.PaymentTermID = OT2001.PaymentTermID 	
	left join 
		(Select AT2007.DivisionID, AT2007.OrderID, OTransactionID,
		InventoryID, sum(ActualQuantity) As ActualQuantity, sum(isnull(OriginalAmount,0)) as ActualOriginalAmount
		From AT2007 with (nolock) inner join AT2006 with (nolock) on AT2007.VoucherID = AT2006.VoucherID
		Where isnull(AT2007.OrderID,'''') <>'''' AND ' + @KindVoucherID + '
		Group by AT2007.DivisionID, AT2007.OrderID, InventoryID, OTransactionID) as G  --- (co nghia la Giao  hang)
		on 	OT2001.DivisionID = G.DivisionID and
			OT2002.SOrderID = G.OrderID and
			OT2002.InventoryID = G.InventoryID and
			OT2002.TransactionID = G.OTransactionID) AQ1023 Where EndQuantity>0 AND DivisionID= ''' + @DivisionID + '''   ) 
		AND AV1023X.OrderDate  Between '''+Convert(nvarchar(10),@FromDate,21)+''' AND '''+convert(nvarchar(10), @ToDate,21)+''''
	    If isnull (@VoucherID,'') <> ''
	    Begin
		Set @sSQL = @sSQL + ' AND OrderID not in ( SELECT OrderID FROM AV3215 )
					Union 
					SELECT AV3215.OrderID, AV3215.OrderDate, AV3215.ObjectID, AV3215.ObjectName, AV3215.Notes, IsCheck = 1, AV3215.VoucherTypeID, AV3215.Address, AV3215.DivisionID,
					AV3215.Transport
					FROM AV3215'
	    End
End

--IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE XTYPE ='V' AND NAME = 'AV3209')
--	EXEC('CREATE VIEW AV3209  --tao boi AP3209
--		as '+@sSQL)
--ELSE
--	EXEC('ALTER VIEW AV3209  --- tao boi AP3209
--		as '+@sSQL)

PRINT @sSQL
EXEC (@sSQL)

END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON