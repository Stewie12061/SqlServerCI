IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP3107]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP3107]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO













---- Created by: Kim Thư on 16/01/2019
---- Purpose: Load dữ liệu kế thừa phiếu chiết khấu
---- Modify on 20/06/2019  by Kim Thư: Bổ sung UnitID
---- Modify on 05/07/2019  by Kim Thư: Bổ sung điều kiện join InheritTransactionID
---- Modify on  12/08/2019 by Khánh Đoan : Bổ sung 2 trường InheritVoucherID, BatchID
---- Modify on  24/03/2022 by Nhật Thanh : Bổ sung điều kiện lọc theo thời gian cho mode 0
---- Modify on  19/04/2022 by Nhật Thanh : Tách store angel


-- EXEC AP3107 @DivisionID = 'ANG', @FromMonth = 1, @FromYear = 2019, @ToMonth = 1, @ToYear = 2019, @FromDate = '2019-01-18 00:00:00', @ToDate = '2019-01-18 23:59:59', 
--	@IsDate=0, @ObjectID = '%', @DiscountType=1, @DVoucherID='', @VoucherID='', @Mode = 1

CREATE PROCEDURE [dbo].[AP3107] @DivisionID nvarchar(50),
								@FromMonth int,
  								@FromYear int,
								@ToMonth int,
								@ToYear int,  
								@FromDate as datetime,
								@ToDate as Datetime,
								@IsDate as tinyint, ----0 theo ky, 1 theo ng�y
								@ObjectID AS VARCHAR(50),
								@DiscountType TINYINT, -- 1: CK thương mại / 2: CK thanh toán			
								@DVoucherID varchar(MAX),-- VoucherID của phiếu chiết khấu
								@DTransactionID varchar(MAX),-- TransactionID của phiếu chiết khấu
								@VoucherID varchar(50), -- ID của  hóa đơn bán hàng
								@Mode TINYINT --0: Load dữ liệu khi click hiển thị / 1: Load dữ liệu Detail khi click chọn phiếu Master / 2: Load dữ liệu khi click Chọn

AS
Declare @sqlSelect as nvarchar(Max),
		@sqlWhere  as nvarchar(4000),
		@CustomerName int

		select @CustomerName = CustomerName from CustomerIndex
IF @CustomerName=57
BEGIN
	exec AP3107_AG @DivisionID ,@FromMonth ,@FromYear ,@ToMonth ,@ToYear ,@FromDate ,@ToDate,@IsDate,@ObjectID,@DiscountType,@DVoucherID ,@DTransactionID,@VoucherID ,	@Mode
END
ELSE
BEGIN
	IF @IsDate = 0
		Set  @sqlWhere = N'
			And  TranMonth+TranYear*100 between ' + cast(@FromMonth + @FromYear*100 as nvarchar(50)) + ' and ' +  cast(@ToMonth + @ToYear*100 as nvarchar(50))  + ' '
	else
		Set  @sqlWhere = N'
			And VoucherDate  Between '''+Convert(nvarchar(10),@FromDate,21)+' 00:00:00'' and '''+convert(nvarchar(10), @ToDate,21)+' 23:59:59'''

	IF @Mode = 0
	BEGIN
		 -- show ra phiếu đã được kế thừa (nếu edit) cùng với phiếu đc chỉ định
		SET @sqlSelect = '
			SELECT TOP 1 A31.VoucherID, A31.VoucherDate, A31.VoucherTypeID, A31.VoucherNo, A31.EmployeeID, A31.Description, A31.Note, 
			(SELECT SUM(AT3101.DiscountAmount) FROM AT3101 WITH (NOLOCK) WHERE AT3101.VoucherID = A31.VoucherID) AS TotalDiscountAmount, 
			A03.Fullname AS EmployeeName
			FROM AT3101 A31 WITH (NOLOCK) LEFT JOIN AT1103 A03 WITH (NOLOCK) ON A31.DivisionID = A03.DivisionID AND A31.EmployeeID = A03.EmployeeID
			WHERE A31.DivisionID = '''+@DivisionID+''' 
				AND ISNULL(A31.InheritVoucherID,'''') = '''+@VoucherID+''' 
				' + @sqlWhere +'
			GROUP BY A31.VoucherID, A31.VoucherDate, A31.VoucherTypeID, A31.VoucherNo, A31.EmployeeID, A31.Description, A31.Note, A03.Fullname
			UNION ALL
			select voucherid, voucherdate,VoucherTypeID,VoucherNo, EmployeeID,Description,Note,SUM(DiscountAmount) AS TotalDiscountAmount,Fullname as EmployeeName
			FROM 
			(SELECT 
				A31.DivisionID, A31.TranMonth, A31.TranYear, A31.VoucherID, A31.VoucherDate, A31.VoucherTypeID, A31.VoucherNo, A31.EmployeeID, A31.Description, A31.Note, A03.FullName, A31.DiscountAmount,-- K.DTransactionID, DiscountAmount, ConvertedAmount
				(isnull(DiscountAmount, 0) - isnull(K.ConvertedAmount,0)) as EndAmount
			FROM AT3101 A31 WITH (NOLOCK) LEFT JOIN AT1103 A03 WITH (NOLOCK) ON A31.DivisionID = A03.DivisionID AND A31.EmployeeID = A03.EmployeeID
			LEFT JOIN (
				SELECT AT9000.DivisionID, AT9000.DVoucherID, AT9000.DTransactionID, sum(AT9000.ConvertedAmount) As ConvertedAmount
				FROM AT9000 WITH (NOLOCK)
				WHERE AT9000.DivisionID = '''+@DivisionID+''' and Isnull(AT9000.ObjectID,'''') like '''+@ObjectID+'''
					and isnull(AT9000.DVoucherID,'''') <> '''' --and AT9000.TransactionTypeID IN (''T04'')
				GROUP BY AT9000.DivisionID, AT9000.DVoucherID,AT9000.DTransactionID
				) as K  on A31.DivisionID = K.DivisionID 
						AND A31.VoucherID = K.DVoucherID 
						AND A31.TransactionID = K.DTransactionID	
				WHERE A31.DivisionID like '''+@DivisionID+''' AND A31.ObjectID like '''+@ObjectID+''' 
				AND ' + CASE WHEN @DiscountType = 1 THEN 'A31.DiscountType = 1' ELSE 'A31.DiscountType = 2' end +
				') A
			WHERE EndAmount > 0
				' + @sqlWhere +'
			Group by VoucherID,voucherdate,VoucherTypeID,VoucherNo, EmployeeID,Description,Note,Fullname
			Order by voucherdate, VoucherNo'


			------SELECT A31.VoucherID, A31.VoucherDate, A31.VoucherTypeID, A31.VoucherNo, A31.EmployeeID, A31.Description, A31.Note, 
			------	SUM(A31.DiscountAmount) AS TotalDiscountAmount, A03.Fullname AS EmployeeName
			------FROM AT3101 A31 WITH (NOLOCK) LEFT JOIN AT1103 A03 WITH (NOLOCK) ON A31.DivisionID = A03.DivisionID AND A31.EmployeeID = A03.EmployeeID
			------WHERE A31.DivisionID = '''+@DivisionID+''' AND A31.ObjectID LIKE '''+@ObjectID+'''
			------	AND ' + CASE WHEN @DiscountType = 1 THEN 'A31.DiscountType = 1' ELSE 'A31.DiscountType = 2' END
			------	+ @sqlWhere+'
			------GROUP BY A31.VoucherID, A31.VoucherDate, A31.VoucherTypeID, A31.VoucherNo, A31.EmployeeID, A31.Description, A31.Note, A03.Fullname
	
	END
	ELSE 
	IF @Mode = 1-- Load dữ liệu Detail của phiếu đc chọn ra lưới dưới
		SET @sqlSelect = '
			SELECT A31.VoucherID AS DVoucherID, A31.TransactionID AS DTransactionID, A31.InvoiceNo, A31.InvoiceDate, A31.ReceivedDate, 
			A31.InventoryID, A31.InventoryName, A31.Amount, A31.AfterVATAmount, A31.DiscountRate,
				A31.DiscountAmount, A31.ObjectID, A31.ObjectName, A31.TDescription
			FROM AT3101 A31 WITH (NOLOCK)
			WHERE A31.DivisionID = '''+@DivisionID+''' 
				AND A31.VoucherID = '''+@DVoucherID+''' 
				ORDER BY A31.InvoiceNo
		'
	ELSE
		SET @sqlSelect = '
			SELECT DISTINCT A31.VoucherID AS InheritVoucherID, A31.TransactionID AS InheritTransactionID, ''AT3101'' AS InheritTableID, A31.TranMonth, A31.TranYear, A31.VoucherDate, A31.VoucherTypeID, A31.VoucherNo, A31.EmployeeID, A31.Description, A31.Note, 
				A31.DiscountType, A31.InvoiceNo, A31.InvoiceDate, A31.ReceivedDate, A31.InventoryID, A31.InventoryName, A31.Amount, A31.AfterVATAmount, A31.DiscountRate,
				A31.DiscountAmount, (SELECT SUM(AT3101.DiscountAmount) FROM AT3101 WITH (NOLOCK) WHERE AT3101.VoucherID = A31.VoucherID) AS TotalDiscountAmount, A31.ObjectID, A31.ObjectName, A31.TDescription, A03.Fullname AS EmployeeName,
				A02.VATNo, A90.DebitAccountID, ''1311'' AS CreditAccountID, AT1302.UnitID,  A31.InheritVoucherID,A90.BatchID  
			FROM AT3101 A31 WITH (NOLOCK) LEFT JOIN AT1103 A03 WITH (NOLOCK) ON A31.DivisionID = A03.DivisionID AND A31.EmployeeID = A03.EmployeeID
			LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID in (''@@@'',A31.DivisionID) AND A31.ObjectID = A02.ObjectID
			LEFT JOIN AT9000 A90 WITH (NOLOCK) ON A31.DivisionID = A90.DivisionID AND A31.InheritVoucherID = A90.VoucherID ' 
												+CASE WHEN @DiscountType=1 THEN 'AND A31.InheritTransactionID = A90.TransactionID' ELSE '' END + '
												AND A90.TransactionTypeID = ''T04''
			LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = A31.InventoryID

			WHERE A31.DivisionID = '''+@DivisionID+''' 
				AND A31.TransactionID in ( '''+@DTransactionID+''' )
			GROUP BY A31.VoucherID, A31.TransactionID, A31.TranMonth, A31.TranYear, A31.VoucherDate, A31.VoucherTypeID, A31.VoucherNo, A31.EmployeeID, A31.Description, A31.Note, 
				A31.DiscountType, A31.InvoiceNo, A31.InvoiceDate, A31.ReceivedDate, A31.InventoryID, A31.InventoryName, A31.Amount, A31.AfterVATAmount, A31.DiscountRate,
				A31.DiscountAmount, A31.ObjectID, A31.ObjectName, A31.TDescription, A03.Fullname, A02.VATNo, A90.DebitAccountID, A90.CreditAccountID, AT1302.UnitID,
				A31.InheritVoucherID,A90.BatchID  
				ORDER BY A31.InvoiceNo , A31.VoucherID
		'


	PRINT @sqlSelect

	EXEC (@sqlSelect)






END








GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
