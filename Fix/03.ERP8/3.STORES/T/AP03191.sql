IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP03191]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP03191]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load luoi 1 man hinh AF0319
-- <Param>
---- 
-- <Return>
---- 
-- <Reference> T/but toan tong hop/Tap hop but toan hinh thanh TSCD
---- 
-- <History>
----- Created by Phuong Thao, Date 13/11/2015
---- Modify by Phương Thảo on 01/03/2016: Chỉnh sửa store vì kế thừa chi tiết theo bút toán và cho phép sửa lại
---- Modified by Bảo Thy on 26/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Hải Long on 18/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
----  EXEC AP03191 'MK', 0, 1, 2015, 10, 2015, NULL, NULL, '%', '%', '%'

CREATE PROCEDURE [dbo].[AP03191] 
				@DivisionID AS nvarchar(50), 
				@IsDate AS Tinyint, -- 0: Ky, 1: Ngay
				@FromMonth AS Tinyint,  
				@FromYear  AS Int,  
				@ToMonth  AS Tinyint,  
				@ToYear AS Int,  
				@FromDate AS Datetime, 
				@ToDate AS Datetime,
				@ObjectID  AS nvarchar(50),  
				@FromTaskID AS nvarchar(50),
				@ToTaskID AS nvarchar(50)
				

AS

Declare @sSQL AS varchar(max),
		@sSQL1 AS varchar(max),
		@TypeDate AS nvarchar(50),
		@FromPeriod AS int,
		@ToPeriod AS int,
		@SQLwhere AS nvarchar(4000)
	
Set @TypeDate ='VoucherDate'

Set @FromPeriod = (@FromMonth + @FromYear*100)	
Set @ToPeriod = (@ToMonth + @ToYear*100)	

IF @IsDate =0   ----- Truong hop tinh Tu ky den ky 
	Set @SQLwhere ='  AND   (AT9000.TranMonth+ AT9000.TranYear*100 Between '+str(@FromPeriod)+' and '+str(@ToPeriod)+')   '

Else
	Set @SQLwhere ='  AND (CONVERT(DATETIME,CONVERT(VARCHAR(10),AT9000.'+ltrim(Rtrim(@TypeDate))+',101),101) Between '''+convert(nvarchar(10),@FromDate,101)+''' and '''+convert(nvarchar(10),@ToDate,101)+''')  '

Set @sSQL='
SELECT 	AT9000.DivisionID,
		CASE WHEN AT9000.DebitAccountID LIKE ''241%'' THEN AT9000.ObjectID ELSE AT9000.CreditObjectID END AS ObjectID,
		CASE WHEN AT9000.DebitAccountID LIKE ''241%'' THEN Ob_D.ObjectName ELSE Ob_C.ObjectName END AS ObjectName,
		AT9000.VoucherDate, 
		AT9000.VoucherNo,
		AT9000.VoucherID,  AT9000.BatchID, AT9000.TransactionID,
		AT9000.Serial, AT9000.InvoiceNo, AT9000.InvoiceDate,
		AT9000.TDescription AS Description, 
		AT9000.CurrencyID, ExchangeRate, 
		AT9000.OriginalAmount, ConvertedAmount,
		Convert(Decimal(28,8),0) AS RemainOAmount, 
		Convert(Decimal(28,8),0) AS RemainCAmount, 
		AT9000.Ana01ID as TaskID, AT1011.AnaName as TaskName,
		AT9000.DebitAccountID,AT9000.CreditAccountID,Convert(BIT,0) IsChoose,
		CASE WHEN AT9000.DebitAccountID LIKE ''241%'' THEN DebitAccountID ELSE CreditAccountID END AS AccountID,
		CASE WHEN AT9000.DebitAccountID LIKE ''241%'' THEN ''C'' ELSE ''D'' END AS D_C
INTO	#AP03191_AT9000
FROM	AT9000  WITH (NOLOCK)	
LEFT JOIN AT1202 Ob_D WITH (NOLOCK) on Ob_D.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND Ob_D.ObjectID = AT9000.ObjectID
LEFT JOIN AT1202 Ob_C WITH (NOLOCK)on Ob_C.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND Ob_C.ObjectID = AT9000.CreditObjectID
LEFT JOIN AT1011 WITH (NOLOCK) on AT9000. Ana01ID = AT1011.AnaID and AT1011.AnaTypeID = ''A01''
Where 	AT9000.DivisionID ='''+@DivisionID+'''
		AND ISNULL(AT9000.IsInheritFA,0) = 0
		AND ISNULL(AT9000.InheritedFAVoucherID,'''') = ''''
		AND (AT9000.DebitAccountID LIKE ''241%'' OR AT9000.CreditAccountID LIKE ''241%'')
		AND ISNULL(AT9000.Ana01ID,'''') <> '''' 
		AND (AT9000.Ana01ID BETWEEN '''+@FromTaskID+''' AND '''+@ToTaskID+''')
		AND ISNULL(AT9000.ObjectID,'''') LIKE '''+@ObjectID+'''
		--AND ISNULL(IsFACost,0) = 0 
		' + @SQLwhere

SET @sSQL1 = '
UPDATE T1
SET		T1.RemainOAmount = T1.OriginalAmount - ISNULL(T2.FAOAmount,0),
		T1.RemainCAmount = T1.ConvertedAmount - ISNULL(T2.FACAmount,0)
FROM #AP03191_AT9000 T1 LEFT JOIN 
(SELECT DivisionID, InheritTransactionID, SUM(OriginalAmount) AS FAOAmount, SUM(ConvertedAmount) AS FACAmount
FROM AT9000 WITH (NOLOCK) 
WHERE ISNULL(AT9000.IsInheritFA,0) = 1
GROUP BY DivisionID, InheritTransactionID
) T2 ON T1.DivisionID = T2.DivisionID AND T1.TransactionID = T2.InheritTransactionID



SELECT 	DivisionID,	ObjectID, ObjectName, VoucherDate, VoucherNo, VoucherID, BatchID, TransactionID,
		Serial, InvoiceNo, InvoiceDate, Description, CurrencyID, ExchangeRate, 		
		RemainOAmount AS OriginalAmount, 
		RemainCAmount AS ConvertedAmount, 
		AccountID, D_C,
		TaskID, TaskName, DebitAccountID, CreditAccountID, IsChoose
FROM #AP03191_AT9000
WHERE RemainOAmount <> 0

DROP TABLE #AP03191_AT9000
'


-- Print @sSQL
--Print @sSQL1
EXEC (@sSQL+ @sSQL1)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

