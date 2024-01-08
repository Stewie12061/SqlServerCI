IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP3199]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP3199]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load combo Đơn hàng cho màn hình kế thừa nhiều đơn hàng bán (AF0105)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 08/05/2016 by Bảo Anh
---- Modified by Tiểu Mai on 23/05/2016: Fix bug OrderDate không có trong table OT2006
---- Modified by Hải Long on 18/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Kim Thư on 20/12/2018: Bổ sung WITH (NOLOCK)
---- Modified by Đức Thông  on 05/10/2020: Customize SAVI: Bổ sung rẽ nhánh kiểm tra số lượng hàng trên đơn hàng và hóa đơn khi đvt khác nhau
---- Modified by Đức Thông  on 13/10/2020: Customize SAVI: Bổ sung: Chỉnh sửa xử lí lấy số lượng mặt hàng theo đơn vị tính
---- Modified by Thành Sang on 14/06/2022: [2022/05/IS/0195] Bổ sung Load theo ngày và kỳ...
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example> AP3199 'QTC',1,2016,1,2016,'01/01/2016','01/31/2016',0

CREATE PROCEDURE [dbo].[AP3199] 
		@DivisionID nvarchar(50),
		@FromMonth int,
		@FromYear int,
		@ToMonth int,
		@ToYear int,
		@FromDate datetime,
		@ToDate datetime,
		@IsDate tinyint
				
AS
Declare @sSQL1  nvarchar(Max),
		@sSQL2  nvarchar(Max),
		@sSQL3  nvarchar(Max),
		@Time nvarchar(max)

If @IsDate = 0
	Set @Time = ' And OT2001.TranMonth + 100*OT2001.TranYear between ' + ltrim(@FromMonth + 100*@FromYear) + ' and ' + ltrim(@ToMonth + 100*@ToYear)
Else
	Set @Time = ' And CONVERT(varchar(20),OrderDate,112) between ''' + ltrim(CONVERT(varchar(20),@FromDate,112)) + ''' and ''' + ltrim(CONVERT(varchar(20),@ToDate,112)) + ''''
	
Set @sSQL1 = '	
Select OT2001.DivisionID, OT2002.SOrderID,
		case when OT2002.Finish = 1 then 0 else isnull(OrderQuantity, 0)- isnull(G.ActualQuantity, 0) end as EndQuantity
Into #TAM
From OT2002  WITH (NOLOCK) inner join OT2001  WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2002.SOrderID = OT2001.SOrderID
left join 	(Select OTransactionID, CASE
                     WHEN EXISTS
     ( -- Cùng đơn vị tính --> Lấy đvt qui đổi trong AT9000
         SELECT TOP 1 1
         FROM dbo.OT2002
         WHERE OT2002.InventoryID = AT9000.InventoryID
               AND AT9000.OrderID = OT2002.SOrderID
               AND AT9000.ConvertedUnitID = OT2002.UnitID
     )
                     THEN SUM(AT9000.ConvertedQuantity)
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
                 END AS ActualQuantity
			From AT9000  WITH (NOLOCK)
			LEFT JOIN AT1309 ON AT9000.InventoryID = AT1309.InventoryID
			LEFT JOIN OT2002 WITH (NOLOCK) on OT2002.TransactionID = AT9000.OTransactionID
			INNER JOIN OT2001  WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2002.SOrderID = OT2001.SOrderID
	        WHERE AT9000.DivisionID = ''' + @DivisionID + ''' And TransactionTypeID =''T04'' AND isnull(AT9000.OrderID,'''') <>'''' ' + @Time + '
			Group by OTransactionID, AT9000.OrderID, AT9000.UnitID, AT9000.InventoryID, AT1309.Operator, AT9000.ConvertedUnitID ,AT1309.ConversionFactor) as G
			on 	OT2002.TransactionID = G.OTransactionID
Where OT2002.DivisionID = ''' + @DivisionID + '''' + @Time + '
And (case when OT2002.Finish = 1 then 0 else isnull(OrderQuantity, 0)- isnull(G.ActualQuantity, 0) end) > 0
'

Set @sSQL2 = '
Select  Top 100 percent  DivisionID, TranMonth, TranYear,  OrderID, OrderStatus, DataType, InventoryID,
	OrderQuantity, AdjustPrice,	

	case when DataType = 2 then  sum(isnull(EndQuantity,0)) else 0 end as EndQuantity
Into #TAM1
From OV2904
Where  EndQuantity >  case when DataType = 2 then 0 else -1 end  and
	EndOriginalAmount > case when DataType = 1 then 0 else -1 end and
	 EndConvertedAmount > case when DataType = 1 then 0 else -1 end
Group by DivisionID, TranMonth, TranYear, OrderID, OrderStatus, DataType, InventoryID, OrderQuantity, AdjustPrice
'
Set @sSQL3 = '
Select SOrderID as OrderID, VoucherNo, OrderDate, AT1202.ObjectName, Notes, ContractNo,''SO'' AS Type
	FROM	OT2001  WITH (NOLOCK)
	LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND OT2001.ObjectID = AT1202.ObjectID
	Where OT2001.DivisionID = ''' + @DivisionID + ''' And OrderType = 0
	and OrderStatus not in (0,3,4,5,9) and OT2001.Disabled = 0' + @Time + '
	and exists (
	Select Top 1 1
	From #TAM
	Where SOrderID = OT2001.SOrderID)
Union All
	Select VoucherID as OrderID,VoucherNo,VoucherDate as OrderDate,AT1202.ObjectName,Description AS Notes,'''' as ContractNo,''AS'' AS Type
	FROM	OT2006  WITH (NOLOCK)
	LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND OT2006.ObjectID = AT1202.ObjectID
	Where OT2006.DivisionID = ''' + @DivisionID + '''
	And OrderStatus not in(0,2,3,9) AND OT2006.Disabled = 0' + CASE WHEN @IsDate = 0 THEN REPLACE(@Time, 'OT2001.','') ELSE ' And CONVERT(varchar(20),VoucherDate,112) between ' + ltrim(CONVERT(varchar(20),@FromDate,112)) + ' and ' + ltrim(CONVERT(varchar(20),@ToDate,112)) + '' END + '
	And exists (
	Select Top 1 1
	From #TAM1
	Where OrderID = OT2006.VoucherID and ((DataType=2 and OrderQuantity>0) OR (DataType=1 and AdjustPrice>0))
	AND DivisionID = ''' + @DivisionID + ''')
---Order by VoucherNo,OrderDate
'

print @sSQL1
print @sSQL2
print @sSQL3

EXEC (@sSQL1 + @sSQL2 + @sSQL3)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON