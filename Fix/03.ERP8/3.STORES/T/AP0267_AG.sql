IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0267_AG]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0267_AG]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Create by Bao Anh	Date: 17/09/2012
---- Purpose: Loc danh sach phieu tam chi qua ngan hang
---- Modified by Phương Thảo on 16/11/2017:  Chỉnh sửa theo hướng kế thừa nhiều lần
---- Modified by Bảo Anh on 10/01/2018: Sửa cách lấy dữ liệu đã kế thừa (do sửa cách lưu vết kế thừa ở AT9000 và không lưu cùng VoucherID, BatchID)
---- Modified by Bảo Anh on 26/03/2018: Bổ sung InheritTypeID
---- Modified by Kim Thư on 26/10/2018: Bổ sung ObjectID null
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example> AP0267 'AS',1,2012,1,2012,'01/01/2012','01/31/2012',0,'%','T22',''
 
CREATE PROCEDURE AP0267_AG
( 
		@DivisionID AS VARCHAR(20),
		@FromMonth int,
	    @FromYear int,
	    @ToMonth int,
	    @ToYear int,  
	    @FromDate as datetime,
	    @ToDate as Datetime,
	    @IsDate as tinyint, ----0 theo ky, 1 theo ng�y
	    @ObjectID nvarchar(50),
	    @TransactionTypeID as nvarchar(50),
	    @VoucherID nvarchar(50) --- Addnew: truyen ''; Edit:  so chung tu vua duoc chon sua
) 
AS 

DECLARE @sSQL AS VARCHAR(8000) = '',
		@sSQL1 AS VARCHAR(8000) = '',
		@sWhere  as nvarchar(4000)	

IF @IsDate = 0
	Set  @sWhere = '
	And  TranMonth+TranYear*100 between ' + cast(@FromMonth + @FromYear*100 as nvarchar(50)) + ' and ' +  cast(@ToMonth + @ToYear*100 as nvarchar(50))  + ' '
else
	Set  @sWhere = '
	And VoucherDate Between '''+Convert(nvarchar(10),@FromDate,21)+''' and '''+convert(nvarchar(10), @ToDate,21)+''''

SET @sSQL = '	
	SELECT	CONVERT(tinyint, 0) AS Choose, T90.VoucherID, T90.BatchID, T90.TransactionID, T90.Orders, T90.VoucherNo, T90.VoucherDate, T90.DueDate,
			T90.ObjectID, (Case when  isnull(AT1202.IsUpdateName,0) <> 0 then VATObjectName else AT1202.ObjectName end) as ObjectName,
			isnull(AT1202.IsUpdateName,0) as IsUpdateName, VoucherTypeID, T90.EmployeeID, AT1103.FullName as EmployeeName,
			T90.SenderReceiver, SRDivisionName, SRAddress, RefNo01, RefNo02, T90.CreditBankAccountID, T90.DebitBankAccountID,
			AT1016.BankName as CreditBankAccountName, AT1016.BankAccountNo, AT1016.AccountID,
			T90.CurrencyID, T90.ExchangeRate, T90.VDescription, T90.Serial, T90.InvoiceNo, T90.InvoiceDate, T90.DebitAccountID, T90.CreditAccountID,
			ISNULL(T90.OriginalAmount,0)-ISNULL(A91.OriginalAmount,0) AS OriginalAmount, ISNULL(T90.ConvertedAmount,0) - ISNULL(A91.ConvertedAmount,0) AS ConvertedAmount, 
			T90.VATObjectID, VATObjectName, VATObjectAddress,
			(Case when  isnull(AT1202.IsUpdateName,0) <> 0 then T90.VATNo else AT1202.VATNo  end) as VATNo, VATTypeID, T90.VATGroupID,
			BDescription,TDescription, T90.OrderID, T90.PeriodID, M01.Description as PeriodName, OTransactionID, ProductID, AT1302.InventoryName as ProductName,
			Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
			TVoucherID, TBatchID, ISNULL(T90.InheritTypeID,'''') AS InheritTypeID
	INTO	#AP0267_AT9010					
	FROM		AT9010 T90 WITH (NOLOCK) 
	LEFT JOIN	AT1202 WITH (NOLOCK)  on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND  T90.ObjectID = AT1202.ObjectID
	LEFT JOIN	AT1103 WITH (NOLOCK)  on T90.EmployeeID = AT1103.EmployeeID And T90.DivisionID = AT1103.DivisionID
	LEFT JOIN	AT1016 WITH (NOLOCK)  on T90.CreditBankAccountID = AT1016.BankAccountID And T90.DivisionID = AT1016.DivisionID
	LEFT JOIN	AT1302 WITH (NOLOCK)  on T90.ProductID = AT1302.InventoryID And T90.DivisionID = AT1302.DivisionID
	LEFT JOIN	MT1601 M01 WITH (NOLOCK)  on M01.PeriodID = T90.PeriodID and M01.DivisionID = T90.DivisionID
	LEFT JOIN (SELECT DivisionID, InheritVoucherID, InheritTransactionID, SUM(OriginalAmount) as OriginalAmount, SUM(ConvertedAmount) as ConvertedAmount FROM AT9000 A91 WITH (NOLOCK) 
			WHERE A91.DivisionID = ''' + @DivisionID + ''' AND A91.InheritTableID = ''AT9010'' AND A91.TransactionTypeID = ''' + @TransactionTypeID + ''' AND ISNULL(A91.InheritTransactionID,'''') <> '''' AND A91.VoucherID <> ''' + @VoucherID + '''
			GROUP BY DivisionID, InheritVoucherID, InheritTransactionID) A91 on A91.DivisionID = T90.DivisionID AND A91.InheritVoucherID = T90.VoucherID AND A91.InheritTransactionID = T90.TransactionID	
	WHERE		T90.DivisionID = ''' + @DivisionID + '''
				AND ISNULL(T90.ObjectID,'''') like ''' + @ObjectID + '''
				AND Isnull(T90.Status,0) = 1 AND TransactionTypeID = ''' + @TransactionTypeID + '''
				-- AND Isnull(T90.ReVoucherID,'''') = ''''
				AND ISNULL(T90.OriginalAmount,0)-ISNULL(A91.OriginalAmount,0) <> 0
				'				
				+ @sWhere 

--if isnull(@VoucherID,'') <> ''	--- khi load edit	
--BEGIN
--	SET @sSQL1 = ' UNION	
--		SELECT	CONVERT(tinyint, 1) AS Choose, T90.VoucherID, T90.BatchID, T90.TransactionID, T90.Orders, T90.VoucherNo, T90.VoucherDate, T90.DueDate,
--			T90.ObjectID, (Case when  isnull(AT1202.IsUpdateName,0) <> 0 then VATObjectName else AT1202.ObjectName end) as ObjectName,
--			isnull(AT1202.IsUpdateName,0) as IsUpdateName, VoucherTypeID, T90.EmployeeID, AT1103.FullName as EmployeeName,
--			SenderReceiver, SRDivisionName, SRAddress, RefNo01, RefNo02, CreditBankAccountID, DebitBankAccountID,
--			AT1016.BankName as CreditBankAccountName, AT1016.BankAccountNo, AT1016.AccountID,
--			T90.CurrencyID, ExchangeRate, VDescription, Serial, InvoiceNo, InvoiceDate, DebitAccountID, CreditAccountID,
--			ISNULL(T90.OriginalAmount,0)-ISNULL(A91.OriginalAmount,0) AS OriginalAmount, ISNULL(T90.ConvertedAmount,0) - ISNULL(A91.ConvertedAmount,0) AS ConvertedAmount, 
--			T90.VATObjectID, VATObjectName, VATObjectAddress,
--			(Case when  isnull(AT1202.IsUpdateName,0) <> 0 then T90.VATNo else AT1202.VATNo  end) as VATNo, VATTypeID, T90.VATGroupID,
--			BDescription,TDescription, T90.OrderID, T90.PeriodID, M01.Description as PeriodName, OTransactionID, ProductID, AT1302.InventoryName as ProductName,
--			Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
--			TVoucherID, TBatchID			
--		FROM		AT9010 T90
-- 		LEFT JOIN	AT1202 on T90.ObjectID = AT1202.ObjectID And T90.DivisionID = AT1202.DivisionID
-- 		LEFT JOIN	AT1103 on T90.EmployeeID = AT1103.EmployeeID And T90.DivisionID = AT1103.DivisionID
-- 		LEFT JOIN	AT1016 on T90.CreditBankAccountID = AT1016.BankAccountID And T90.DivisionID = AT1016.DivisionID
-- 		LEFT JOIN	AT1302 on T90.ProductID = AT1302.InventoryID And T90.DivisionID = AT1302.DivisionID
-- 		LEFT JOIN	MT1601 M01 on M01.PeriodID = T90.PeriodID and M01.DivisionID = T90.DivisionID 		
--		LEFT JOIN (SELECT DivisionID, VoucherID, BatchID, SUM(OriginalAmount) as OriginalAmount, SUM(ConvertedAmount) as ConvertedAmount FROM AT9000 A91 WITH (NOLOCK) 
--					WHERE A91.DivisionID = ''' + @DivisionID + ''' AND A91.VoucherID <> ''' + @VoucherID + '''
--					GROUP BY DivisionID, VoucherID, BatchID) A91 on A91.DivisionID = T90.DivisionID AND A91.VoucherID = T90.VoucherID AND A91.BatchID = T90.BatchID	
-- 		WHERE		T90.DivisionID = ''' + @DivisionID + ''' AND T90.ReVoucherID = ''' + @VoucherID + ''''
--END 
if isnull(@VoucherID,'') <> ''	--- khi load edit	
BEGIN 		
SET @sSQL1 = @sSQL1 + '
UPDATE T1
SET T1.Choose = 1
FROM  #AP0267_AT9010 T1
WHERE T1.VoucherID = '''+@VoucherID+'''
'
END 
SET @sSQL1 = @sSQL1 +'
SELECT * FROM #AP0267_AT9010 ORDER BY VoucherDate, VoucherID, Orders
'

--print @sSQL			
--print @sSQL1
EXEC (@sSQL+@sSQL1)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
