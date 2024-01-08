IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0265]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0265]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




---- Created by: Bao Anh
---- Date: 22/08/2012
---- Purpose: Tra ra du lieu cho luoi Master (ke thua nhieu phieu xuat kho - AF0265)
---- Edited by: Bao Anh		Date: 18/12/2012
---- Purpose:	1/ Bo sung Isnull trong dieu kien Where ObjectID
----			2/ Sua lai khi Edit: lay chung tu nhap kho (hien tai dang lay phieu mua hang)
---- Edited by: Bao Anh		Date: 10/01/2013	Where them TableID de loai tru cac phieu xuat kho bán hang
---- Edited by: Bao Anh		Date: 24/09/2013	Cai thien toc do
---- Modify on 15/01/2016 by Bảo Anh: Gọi store customize Angel 
---- Modified by Bảo Thy on 25/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Tiểu Mai on 03/06/2016: Sửa gọi thẳng store AP0266_AG ch khách hàng ANGEL, không chung store
---- Modified by Tiểu Mai on 19/07/2016: Fix lỗi cho Angel
---- Modified by Hải Long on 16/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified on 17/01/2018 by Bảo Anh: Sửa lỗi đã kế thừa hết vẫn lên dữ liệu
---- Modified on 05/12/2019 by Văn Minh: Sửa lỗi Truy vấn không lấy ra dữ liệu như bên nghiệp vụ (T- Hóa đơn bán hàng - kế thừa phiếu xuất kho)
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- AP0265 N'CTY',9,2013,9,2013,'2013-09-01 00:00:00','2013-09-30 00:00:00',0,N'%',N'%',N'','((''''))', '((0 = 0))'

CREATE PROCEDURE [dbo].[AP0265]    @DivisionID nvarchar(50),
				    @FromMonth int,
	  			    @FromYear int,
				    @ToMonth int,
				    @ToYear int,  
				    @FromDate as datetime,
				    @ToDate as Datetime,
				    @IsDate as tinyint, ----0 theo ky, 1 theo ngày
				    @ObjectID nvarchar(50),
				    @WareHouseID NVARCHAR(50),
				    @VoucherID nvarchar(50), --- Addnew: truyen ''; Edit:  so chung tu vua duoc chon sua
					@ConditionOB nvarchar(max),
					@IsUsedConditionOB nvarchar(20)
 AS
Declare
 @sSQL as varchar(max),
 @sWhere  as nvarchar(4000),
 @CustomerIndex int

SELECT @CustomerIndex = CustomerName FROM CustomerIndex

IF @IsDate = 0
	Set  @sWhere = '
		And (AT2006.TranMonth + AT2006.TranYear*100 between ' + cast(@FromMonth + @FromYear*100 as nvarchar(50)) + ' and ' +  cast(@ToMonth + @ToYear*100 as nvarchar(50))  + ')'
else
	Set  @sWhere = '
		And (AT2006.VoucherDate  Between '''+Convert(nvarchar(10),@FromDate,21)+''' and '''+convert(nvarchar(10), @ToDate,21)+''')'

IF EXISTS (SELECT TOP 1 1 FROM tempdb.dbo.sysobjects WITH (NOLOCK) WHERE ID = OBJECT_ID(N'tempdb.dbo.#TAM')) 
	DROP TABLE #TAM

CREATE TABLE #TAM
(
	VoucherID nvarchar(50) COLLATE DATABASE_DEFAULT NULL ,
	EndQuantity decimal(28,8)
)

Set  @sSQL = '
INSERT INTO #TAM (VoucherID, EndQuantity)
Select Top 100 percent VoucherID, sum(isnull(EndQuantity,0))
FROM (
Select 
	AT2006.DivisionID, AT2006.TranMonth, AT2006.TranYear, AT2007.VoucherID,
	AT2007.TransactionID, AT2007.InventoryID, AT2007.ActualQuantity,
	(isnull(ActualQuantity, 0) - isnull(ActualQuantityHD,0)) as EndQuantity
From AT2006 WITH (NOLOCK)
inner join AT2007 WITH (NOLOCK) on AT2007.DivisionID = AT2006.DivisionID and AT2007.VoucherID = AT2006.VoucherID

Left join (
	Select AT2006.DivisionID, AT2006.WOrderID, AT2006.WTransactionID, AT2006.InventoryID, sum(AT2006.Quantity) As ActualQuantityHD
	From AT9000 AT2006 WITH (NOLOCK)
	Where AT2006.DivisionID = ''' + @DivisionID + ''' and Isnull(AT2006.ObjectID,'''') like ''' + @ObjectID + '''
		and isnull(AT2006.WOrderID,'''') <> '''' and AT2006.TransactionTypeID IN (''T04'')
		And (ISNULL(AT2006.ObjectID, ''#'') IN (' + @ConditionOB + ') Or ' + @IsUsedConditionOB + ')
	Group by AT2006.DivisionID, AT2006.WOrderID, AT2006.InventoryID, AT2006.WTransactionID
	) as K  on AT2006.DivisionID = K.DivisionID and AT2007.DivisionID = K.DivisionID and
			AT2007.VoucherID = K.WOrderID and AT2007.InventoryID = K.InventoryID and
			AT2007.TransactionID = K.WTransactionID	

WHERE AT2006.DivisionID = ''' + @DivisionID + ''' and Isnull(AT2006.ObjectID,'''') like ''' + @ObjectID + '''
 	And AT2006.WarehouseID like ''' + @WareHouseID + ''' AND AT2006.KindVoucherID = 2 And AT2006.TableID = ''AT2006''' + @sWhere + '
	And (ISNULL(AT2006.ObjectID, ''#'') IN (' + @ConditionOB + ') Or ' + @IsUsedConditionOB + ')) A
Where EndQuantity > 0
Group by VoucherID'

IF @CustomerIndex = 57 ----- ANGEL
BEGIN
	Set  @sSQL = '
	INSERT INTO #TAM (VoucherID, EndQuantity)
	Select Top 100 percent A.VoucherID, sum(isnull(EndQuantity,0))
	FROM (
	Select 
		AT2006.DivisionID, AT2006.TranMonth, AT2006.TranYear, AT2007.VoucherID,
		AT2007.TransactionID, AT2007.InventoryID, AT2007.ActualQuantity,
		(isnull(ActualQuantity, 0) - isnull(ActualQuantityHD,0)) as EndQuantity
	From AT2006 WITH (NOLOCK)
	inner join AT2007 WITH (NOLOCK) on AT2007.DivisionID = AT2006.DivisionID and AT2007.VoucherID = AT2006.VoucherID

	Left join (
		Select AT2006.DivisionID, AT2006.WOrderID, AT2006.WTransactionID, AT2006.InventoryID, sum(AT2006.Quantity) As ActualQuantityHD
		From AT9000 AT2006 WITH (NOLOCK)
		Where AT2006.DivisionID = ''' + @DivisionID + ''' and Isnull(AT2006.ObjectID,'''') like ''' + @ObjectID + '''
			and isnull(AT2006.WOrderID,'''') <> '''' and AT2006.TransactionTypeID IN (''T04'')
			And (ISNULL(AT2006.ObjectID, ''#'') IN (' + @ConditionOB + ') Or ' + @IsUsedConditionOB + ') ' + @sWhere + '
		Group by AT2006.DivisionID, AT2006.WOrderID, AT2006.InventoryID, AT2006.WTransactionID
		) as K  on AT2006.DivisionID = K.DivisionID and AT2007.DivisionID = K.DivisionID and
				AT2007.VoucherID = K.WOrderID and AT2007.InventoryID = K.InventoryID and
				AT2007.TransactionID = K.WTransactionID	

	WHERE AT2006.DivisionID = ''' + @DivisionID + ''' and Isnull(AT2006.ObjectID,'''') like ''' + @ObjectID + '''
 		And AT2006.WarehouseID like ''' + @WareHouseID + ''' AND AT2006.KindVoucherID = 2 And AT2006.TableID = ''AT2006''' + @sWhere + '
		And (ISNULL(AT2006.ObjectID, ''#'') IN (' + @ConditionOB + ') Or ' + @IsUsedConditionOB + ')
	) A
	LEFT JOIN (Select DISTINCT AT2006.DivisionID, AT2006.VoucherID, AT2007.TransactionID, AT2007.InventoryID, AT2006.TranMonth, AT2006.TranYear,
	AT2007.ActualQuantity - Isnull((Select SUM(Quantity) AS Quantity From AT0266_AG WITH (NOLOCK) Where DivisionID = AT2007.DivisionID And InheritVoucherID = AT2007.VoucherID
							and InheritTransactionID = AT2007.TransactionID),0) AS EndQuantityB
	From AT2006 WITH (NOLOCK)
	inner join AT2007 WITH (NOLOCK) on AT2007.DivisionID = AT2006.DivisionID and AT2007.VoucherID = AT2006.VoucherID
	WHERE AT2006.DivisionID = '''+@DivisionID+''' and Isnull(AT2006.ObjectID,'''') like '''+@ObjectID+'''
	And AT2006.WarehouseID like '''+@WareHouseID+''' AND AT2006.KindVoucherID = 2 And AT2006.TableID = ''AT2006''
	'+ @sWhere + '
	And (ISNULL(AT2006.ObjectID, ''#'') IN (' + @ConditionOB + ') Or ' + @IsUsedConditionOB + ')
	And AT2007.ActualQuantity - Isnull((Select SUM(Quantity) AS Quantity From AT0266_AG WITH (NOLOCK) Where DivisionID = AT2007.DivisionID And InheritVoucherID = AT2007.VoucherID
								and InheritTransactionID = AT2007.TransactionID),0) > 0) B ON A.DivisionID = B.DivisionID AND B.VoucherID = A.VoucherID AND B.TransactionID = A.TransactionID

	Where EndQuantity > 0 AND EndQuantityB > 0
	Group by A.VoucherID'	
END


EXEC(@sSQL)
PRINT @sSQL

if isnull(@VoucherID,'')<> ''	--- khi load edit

	Set  @sSQL ='SELECT * FROM ( 
	Select  top 100 percent AT9000.WOrderID, AT2006.VoucherNo, AT2006.VoucherDate, AT2006.ObjectID, AT1202.ObjectName,AT2006.Description,cast(1 as tinyint) as IsCheck, AT2006.VoucherTypeID, AT2006.DivisionID
	From AT9000 WITH (NOLOCK)
	Inner Join AT2006 WITH (NOLOCK) On AT9000.WOrderID = AT2006.VoucherID and AT9000.DivisionID = AT2006.DivisionID 
	Left Join AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT2006.ObjectID
	Where AT9000.VoucherID = ''' + @VoucherID + ''' And TransactionTypeID = ''T04''
	And  AT9000.DivisionID = ''' + @DivisionID + '''	

	union
	Select AT2006.VoucherID as WOrderID, AT2006.VoucherNo ,AT2006.VoucherDate, AT2006.ObjectID, AT1202.ObjectName,AT2006.Description, cast(0 as tinyint) as IsCheck, AT2006.VoucherTypeID, AT2006.DivisionID
	From AT2006 WITH (NOLOCK)
	Left Join AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT2006.ObjectID
	WHERE AT2006.DivisionID = ''' + @DivisionID + ''' AND VoucherID In (Select VoucherID From #TAM Where EndQuantity > 0) 
		and VoucherID not in (Select ISNULL(WOrderID,'''') from AT9000 Where DivisionID = ''' + @DivisionID + ''' And AT9000.VoucherID = ''' + @VoucherID + ''' And TransactionTypeID = ''T04'') ' + @sWhere + '
	) A'

else --- khi load add new

Set @sSQL ='SELECT * FROM ( 
	Select AT2006.VoucherID as WOrderID, AT2006.VoucherNo, AT2006.VoucherDate, AT2006.ObjectID, AT1202.ObjectName,AT2006.Description, cast(0 as tinyint) as IsCheck, AT2006.VoucherTypeID, AT2006.DivisionID
	From AT2006 WITH (NOLOCK)
	Left Join AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT2006.ObjectID
	WHERE AT2006.DivisionID = ''' + @DivisionID + ''' AND VoucherID In (Select VoucherID From #TAM Where EndQuantity>0) ' + @sWhere + '
	) A'

SET @sSQL = @sSQL + ' ' + 'Order by WOrderID, VoucherDate'
PRINT @sSQL
EXEC(@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
