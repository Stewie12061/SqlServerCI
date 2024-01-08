IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP3202]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP3202]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Tra ra du lieu load edit  Master  ke thua nhieu phieu  don hang ban (AF3216)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 21/12/2009 by Thuy Tuyen
---- 
---- Modified on 01/10/2008 by B.Anh
---- Modified on 05/09/2012 by Le Thi Thu Hien : Bổ sung điều kiện lọc loại chứng từ nếu là khách hàng Thuận Lợi
---- Edit Tan Phu, date 12/09/2012
---- Purpose: Cải thiện tốc độ xử lý 
---- -- And OrderID not in ( Select OrderID from AV3212 )
----    thay thế = And (select COUNT(OrderID)  from AV3212 where AV1023.DivisionID = AV3212.DivisionID and AV1023.OrderID = AV3212.OrderID) = 0
---- Modify by: Hoàng Vũ, on 24/06/2015, lập hóa đơn bán hàng kế thừa từ đơn hàng bán (nhưng trừ đi số lượng xuất kho, xuất bán, điều chỉnh tăng và điều chỉnh ---- giảm của đơn hàng bán)
---- Modify on 18/01/2016 by Bảo Anh: Bổ sung VoucherNo
---- Modify on 15/05/2017 by Bảo Anh: Sửa danh mục dùng chung (bỏ kết theo DivisionID)
---- Modify on 16/04/2018 by Bảo Anh: Lấy đơn hàng chưa kế thừa hết từ AQ2901
---- Modify on 07/11/2018 by Kim Thư: Sửa convert ngày tháng
---- Modify on 02/10/2020 by Nhựt Trường: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Đức Thông on 05/10/2020: Customize SAVI: Bổ sung rẽ nhánh kiểm tra số lượng hàng trên đơn hàng và hóa đơn khi đvt khác nhau
---- Modified by Đức Thông on 13/10/2020: Customize SAVI: Bổ sung xử lí lấy số lượng đơn hàng theo đơn vị tính
-- <Example>
---- 

CREATE PROCEDURE [dbo].[AP3202]           
			@DivisionID nvarchar(50),
		    @FromMonth int,
		    @FromYear int,
		    @ToMonth int,
		    @ToYear int,  
		    @FromDate as datetime,
		    @ToDate as Datetime,
		    @IsDate as tinyint, ----0 theo k?, 1 theo ngày
		    @ObjectID nvarchar(50),
		    @VoucherID nvarchar(50)
				
 AS
Declare @sSQL as nvarchar(4000),
		@Customize AS INT,
		@sWHERE AS NVARCHAR(4000),
		@sOrderID as nvarchar(Max)
SET @sWHERE = N''

DECLARE	@TempTable table(CustomerName  int,IsExcel  int)

INSERT @TempTable
EXEC	[dbo].[AP4444]

SET @Customize = (SELECT TOP 1 CustomerName FROM @TempTable)
IF @Customize = 12 ---->> Khách hàng Thuận Lợi
	BEGIN
		SET @sWHERE = N'
			AND AV1023.VoucherTypeID not like ''BL%'''
	END

IF @Customize = 43 ---->> Khách hàng Secoin
	SET @sOrderID = N'Select AQ2901.SOrderID
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
						From OT2002 inner join OT2001 ON OT2001.DivisionID = OT2002.DivisionID AND OT2002.SOrderID = OT2001.SOrderID
									left join AT1208 ON AT1208.PaymentTermID = OT2001.PaymentTermID 	
									left join 	(
													Select AT9000.DivisionID, AT9000.OrderID, OTransactionID,
															InventoryID, CASE
                     WHEN EXISTS
     ( -- Cùng đơn vị tính --> Lấy đvt qui đổi trong AT9000
         SELECT TOP 1 1
         FROM dbo.OT2002
         WHERE OT2002.InventoryID = AT9000.InventoryID
               AND AT9000.OrderID = OT2002.SOrderID
               AND AT9000.ConvertedUnitID = OT2002.UnitID
     )
                     THEN SUM(ConvertedQuantity)
                     WHEN EXISTS -- Khác đvt, đvt trong đơn hàng là chuẩn --> Lấy đvt chuẩn trong AT9000
     (
         SELECT TOP 1 1
         FROM dbo.OT2002
         WHERE OT2002.SOrderID = AT9000.OrderID
               AND OT2002.InventoryID = AT9000.InventoryID
               AND OT2002.UnitID = AT9000.UnitID
     )
                     THEN SUM(Quantity)
                     ELSE -- Khác đvt, đvt trong đơn hàng là qui đổi --> Qui đổi đvt trong AT9000
                     CASE Operator
                         WHEN 1
                         THEN SUM(Quantity * AT1309.ConversionFactor)
                         WHEN 0
                         THEN SUM(Quantity / AT1309.ConversionFactor)
                     END
                 END AS ActualQuantity, sum(isnull(OriginalAmount,0)) as ActualOriginalAmount,
															SUM(isnull(ConvertedQuantity,Quantity)) As ActualConvertedQuantity
														From AT9000 
															LEFT JOIN AT1309 ON AT9000.InventoryID = AT309.InventoryID
														WHERE TransactionTypeID in (''T04'', ''T06'') and IsStock = 0 AND isnull(AT9000.OrderID,'''') <>''''
														Group by AT9000.DivisionID, AT9000.OrderID, AT9000.UnitID, InventoryID, OTransactionID, AT9000.InventoryID, AT1309.ConversionFactor, AT1309.Operator
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
												From OT2001 M Inner join OT2002 D on M.DivisionID = D.DivisionID and M.SOrderID = D.SOrderID
												Where M.OrderTypeID = 1
												Group by D.DivisionID, D.InventoryID, D.InheritVoucherID, D.InheritTransactionID
												) as T on T.DivisionID = OT2002.DivisionID and T.InheritVoucherID = OT2002.SOrderID 
																							and T.InheritTransactionID = OT2002.TransactionID
						Where OT2001.OrderTypeID = 0 or OT2001.OrderTypeID is null
						) AQ2901
						Where AQ2901.EndQuantity > 0 and AQ2901.DivisionID= '''+@DivisionID+''' 
									Group by AQ2901.DivisionID, AQ2901.TranMonth, AQ2901.TranYear, AQ2901.SOrderID, AQ2901.OrderStatus'
	Else
	BEGIN
			SET @sOrderID = 'Select Distinct SOrderID From AQ2901 Where DivisionID= ''' + @DivisionID + '''
						AND (CASE WHEN IsDiscount = 1 then EndOriginalAmount else EndQuantity end ) > 0'
			IF(@Customize = 110)
				SET @sOrderID = 'Select Distinct SOrderID From AQ2901 Where DivisionID= ''' + @DivisionID + '''
						AND (CASE WHEN IsDiscount = 1 then EndOriginalAmount else EndQuantity end ) >= 0'
	END

	
	Set  @sSQL =' 
	SELECT  top 100 percent AT9000.OrderID,AV1023.OrderDate, Av1023.ObjectID, AV1023.ObjectName,
			AV1023.Notes,IsCheck = 1, AV1023.VoucherTypeID, AT9000.DivisionID,
			AV1023.OrderStatus, AV1023.OrderType, AV1023.VoucherNo
	FROM	AT9000
	INNER JOIN AV1023 On AT9000.OrderID = AV1023.OrderID and AT9000.DivisionID = AV1023.DivisionID
	WHERE	AT9000.VoucherID = ''' + @VoucherID + ''' 
			AND	AT9000.DivisionID = ''' + @DivisionID + '''	
	ORDER BY AT9000.OrderID
	'
	--print @sSQL
	IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE XTYPE ='V' AND NAME = 'AV3212')
		EXEC('CREATE VIEW AV3212  --tao boi AP3202
			as '+@sSQL)
	ELSE
		EXEC('ALTER VIEW AV3212  --- tao boi AP3212
			as '+@sSQL)



	If @IsDate =0

		Set @sSQL =' 
		SELECT	AV1023.OrderID,AV1023.OrderDate, Av1023.ObjectID, AV1023.ObjectName,
				AV1023.Notes, Ischeck = 0, AV1023.VoucherTypeID, DivisionID,
				AV1023.OrderStatus, AV1023.OrderType, AV1023.VoucherNo
		FROM AV1023
		WHERE DivisionID = ''' + @DivisionID + ''' 
				'+@sWHERE+'
 			And ObjectID like '''+@ObjectID+ ''' 
			And Disabled=0  And Type=''SO'' And OrderStatus Not In (0,3,4,5,9)
			And OrderID In ('+ @sOrderID +' ) 
			And  TranMonth+TranYear*100 between    ' + cast(@FromMonth + @FromYear*100 as nvarchar(50)) + ' and ' +  cast(@ToMonth + @ToYear*100 as nvarchar(50))  + ' 
			-- And OrderID not in ( Select OrderID from AV3212 )
			And (select COUNT(OrderID)  from AV3212 where AV1023.DivisionID = AV3212.DivisionID and AV1023.OrderID = AV3212.OrderID) = 0
		Union 
		Select AV3212.OrderID,AV3212.OrderDate, AV3212.ObjectID, AV3212.ObjectName,AV3212.Notes,IsCheck = 1, AV3212.VoucherTypeID, DivisionID
		,AV3212.OrderStatus, AV3212.OrderType, AV3212.VoucherNo
		From AV3212

		'
		Else

		Set @sSQL =' 
		Select	AV1023.OrderID,AV1023.OrderDate, Av1023.ObjectID, AV1023.ObjectName,
				AV1023.Notes, Ischeck = 0, AV1023.VoucherTypeID, DivisionID,
				OrderStatus,AV1023.OrderType, AV1023.VoucherNo
		From AV1023
		Where DivisionID = ''' + @DivisionID + ''' 
				'+@sWHERE+'
 			And ObjectID like '''+@ObjectID+ ''' 
			And Disabled=0  And Type=''SO'' And OrderStatus Not In (0,3,4,5,9)
			And OrderID In ('+ @sOrderID +' ) 
			And Convert(Datetime,AV1023.OrderDate,112)  Between '''+Convert(VARCHAR(10),@FromDate,112)+' 00:00:00'' and '''+convert(VARCHAR(10), @ToDate,112)+' 23:59:59'' 
			--And OrderID not in ( Select OrderID from AV3212)
			And (select COUNT(OrderID)  from AV3212 where AV3212.DivisionID = AV1023.DivisionID and AV3212.OrderID = AV1023.OrderID) = 0
		Union 
		Select AV3212.OrderID,AV3212.OrderDate, AV3212.ObjectID, AV3212.ObjectName,AV3212.Notes,IsCheck = 1, AV3212.VoucherTypeID, DivisionID
		,AV3212.OrderStatus,AV3212.OrderType, AV3212.VoucherNo
		From AV3212
		'

print @sSQL
IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE XTYPE ='V' AND NAME = 'AV3202')
	EXEC('CREATE VIEW AV3202  --tao boi AP3202
		as '+@sSQL)
ELSE
	EXEC('ALTER VIEW AV3202  --- tao boi AP3202
		as '+@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
