IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP3203]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP3203]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




---- Created by: Thuy Tuyen
---- Date: 30/09/2009
---- Purpose: Tra ra du lieu load( Addnew va edit)  Master  ke thua nhieu phieu  don hang mua (AF3216)
---- Modified by Hải Long on 18/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Kiều Nga on 21/07/2021: Lấy thêm trường VoucherNo
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified by Đình Định on 05/06/2023: THIENNAM - Bổ sung trường hợp rỗng lấy tất cả đơn hàng kế thừa.
---- Modified by Nhựt Trường on 20/07/2023: [2023/07/IS/0212] - Điều chỉnh dữ liệu load PO, lấy lên các đơn chưa được kế thừa và bỏ dùng view, trả ra dữ liệu từ store.
/***************************************************************
'* Edited by : [GS] [Quoc Cuong] [29/07/2010]
'**************************************************************/
CREATE PROCEDURE [dbo].[AP3203]   
					@DivisionID nvarchar(50),
				    @FromMonth int,
	  			    @FromYear int,
				    @ToMonth int,
				    @ToYear int,  
				    @FromDate as datetime,
				    @ToDate as Datetime,
				    @IsDate as tinyint, ----0 theo k?, 1 theo ngày
				    @ObjectID nvarchar(50),
				    @VoucherID nvarchar(50) -- neu load 
				
 AS
Declare @sSQL AS NVARCHAR(4000),
        @sWhere AS NVARCHAR(4000),
		@CustomerName INT
-- Khách hàng Thiên Nam.
SET @CustomerName = (SELECT TOP 1 CustomerName FROM CustomerIndex)

IF @IsDate = 0
Set  @sWhere = '
And  TranMonth+TranYear*100 between    ' + cast(@FromMonth + @FromYear*100 as nvarchar(50)) + ' and ' +  cast(@ToMonth + @ToYear*100 as nvarchar(50))  + ' '
else
Set  @sWhere = '
And OT3001.OrderDate  Between '''+Convert(nvarchar(10),@FromDate,21)+''' and '''+convert(nvarchar(10), @ToDate,21)+''''




if isnull(@VoucherID,'')<> ''

SET @sSQL ='
SELECT OrderID
INTO #AT9000
FROM AT9000 WITH (NOLOCK)
WHERE AT9000.DivisionID = ''' + @DivisionID + ''' AND ISNULL(OrderID,'''') <> ''''

SELECT DISTINCT AQ1014.OrderID
INTO #AQ1014
FROM AQ1014 WITH (NOLOCK)
WHERE EndQuantity > 0 AND DivisionID= ''' + @DivisionID + '''

SELECT TOP 100 PERCENT AT9000.OrderID, OT3001.VoucherNo, OT3001.OrderDate, OT3001.ObjectID, AT1202.ObjectName, OT3001.Notes, IsCheck = 1, OT3001.VoucherTypeID, AT9000.DivisionID
  FROM AT9000 WITH (NOLOCK)
 INNER JOIN OT3001 WITH (NOLOCK) ON AT9000.OrderID = OT3001.POrderID AND AT9000.DivisionID = OT3001.DivisionID 
  LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID
 WHERE AT9000.VoucherID = ''' + @VoucherID + ''' 
   AND AT9000.DivisionID = ''' + @DivisionID + '''	
UNION
SELECT OT3001.POrderID AS OrderID, OT3001.VoucherNo, OT3001.OrderDate, OT3001.ObjectID, AT1202.ObjectName, OT3001.Notes, Ischeck = 0, OT3001.VoucherTypeID, OT3001.DivisionID
  FROM OT3001 WITH (NOLOCK)
  LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = OT3001.ObjectID
 WHERE OT3001.DivisionID = ''' + @DivisionID + '''  
   AND OT3001.ObjectID LIKE '''+@ObjectID+ ''' 
   AND OT3001.Disabled = 0 AND OrderStatus NOT IN (0,3,4,5,9)
   AND POrderID IN (SELECT OrderID FROM #AQ1014) 
   AND POrderID NOT IN (SELECT OrderID FROM #AT9000)
	'+@sWhere+'
'

else 

Set @sSQL =' 
SELECT DISTINCT AQ1014.OrderID
INTO #AQ1014
FROM AQ1014 WITH (NOLOCK)
WHERE EndQuantity > 0 AND DivisionID= ''' + @DivisionID + '''

Select OT3001.POrderID as OrderID ,OT3001.VoucherNo,OT3001.OrderDate, OT3001.ObjectID, AT1202.ObjectName,OT3001.Notes, Ischeck = 0, OT3001.VoucherTypeID, OT3001.DivisionID
From OT3001
Left Join AT1202 on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = OT3001.ObjectID
Where OT3001.DivisionID = ''' + @DivisionID + ''' 
 	And OT3001.ObjectID like '''+@ObjectID+ ''' 
	And OT3001.Disabled=0  And OrderStatus Not In (0,3,4,5,9)
	And POrderID In (SELECT OrderID FROM #AQ1014) 
	
	'+@sWhere+'
'

Print @sSQL
EXEC (@sSQL)

--If not Exists (Select 1 From SysObjects Where Xtype ='V' and Name = 'AV3203')
--	Exec('Create View AV3203  --tao boi AP3203
--		as '+@sSQL)

--Else
--	Exec('Alter View AV3203  --- tao boi AP3203
--		as '+@sSQL)
		
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
