IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0414_MK]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0414_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Bao cao chi tiet cong no giai tru cong no phai tra
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Nguyen Van  Nhan, Date 17/11/2003
----
---- Lasted Edit by Van Nhan, 11/01/2005
---- Edited By: Nguyen Quoc Huy, Date: 15/08/2006
---- last edit : Thuy Tuyen , them cac truong O Code, date 15/07/2009
---- Modified on 24/11/2011 by Le Thi Thu Hien : Chinh sua where ngay
---- Modified on 16/01/2012 by Le Thi Thu Hien : CONVERT ngay
---- Modified on 06/03/2013 by Khanh Van: Bo sung tu tai khoan den tai khoan cho Sieu Thanh
---- Modified on 17/11/2014 by Mai Duyen: Bo sung @DatabaseName de in bao cao 2 database (Customized SIEUTHANH )
---- Modified on 05/12/2014 by Mai Duyen : Bo sung field DB (Customized bao cao 2 DB cho SIEU THANH)
---- Modified by Phương Thảo on 30/05/2016: Chỉnh sửa cách thể hiện báo cáo theo dạng: PSN/PSC
---- Modified by Phương Thảo on 01/08/2016: Bổ sung PaymentExchangeRate
---- Modified by Huỳnh Thử on 17/08/2020: Merge code: MEKI và MTE
---- Modified by Huỳnh Thử on 12/02/2021: Bổ sung cột CreatUserID, UserName
---- Modified by Xuân Nguyên on 27/06/2022: [2022/06/IS/0085]Điều chỉnh điều kiện lọc các phiếu ps giảm công nợ đã giải trừ hết
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
---- 

CREATE PROCEDURE [dbo].[AP0414_MK]  
				@DivisionID nvarchar(50), 
				@FromObjectID AS nvarchar(50),
				@ToObjectID AS nvarchar(50),
				@FromAccountID AS nvarchar(50),
				@ToAccountID AS nvarchar(50),
				@CurrencyID  AS nvarchar(50),
				@IsDate AS tinyint,
				@FromDate AS Datetime,
				@ToDate AS  Datetime,
				@FromMonth AS int,
				@FromYear AS int,
				@ToMonth AS int,
				@ToYear AS int,
				@IsZero AS int,
				@IsNotGiveUp AS int,
				@DatabaseName  as NVARCHAR(250)='',
				@IsDebitCredit AS Tinyint = 0
 AS
Declare @sSQL0 AS nvarchar(4000),
		@sSQL AS nvarchar(4000),
		@sSQLUnionAll AS nvarchar(4000),
		@sTime AS nvarchar(4000),
		@CustomerName INT,
		@sTimeD AS nvarchar(4000), --- Phan loc cho phieu goc la PSN
		@sTimeD_C AS  nvarchar(4000) ,  --- Phan loc cho phieu PSC giai tru tuong ung khi in PS tang cong no
		@sTimeC AS nvarchar(4000), --- Phan loc cho phieu goc la PSC
		@sTimeC_D AS  nvarchar(4000)   --- Phan loc cho phieu PSN giai tru tuong ung khi in PS giam cong no 


IF (@IsDebitCredit = 0)
BEGIN
	SET @sSQL = ' 	
			SELECT	DISTINCT	BatchID+ObjectID  AS LinkID, DivisionID	
			FROM	AV0402
			WHERE 	(CreditAccountID >= '''+@FromAccountID+''' AND CreditAccountID<= '''+@ToAccountID+''' )and
					DivisionID = '''+@DivisionID+''' AND 
					(ObjectID >= '''+@FromObjectID+''' AND ObjectID<= '''+@ToObjectID+''' )and
					CurrencyIDCN like '''+@CurrencyID+''' AND		
					OriginalAmountCN-GivedOriginalAmount >0   '
END
ELSE
BEGIN
	SET @sSQL = ' 	
			SELECT	DISTINCT	BatchID+ObjectID  AS LinkID, DivisionID	
			FROM	AV0401_MK
			WHERE 	(DebitAccountID >= '''+@FromAccountID+''' AND DebitAccountID<= '''+@ToAccountID+''' )and
					DivisionID = '''+@DivisionID+''' AND 
					(ObjectID >= '''+@FromObjectID+''' AND ObjectID<= '''+@ToObjectID+''' )and
					CurrencyIDCN like '''+@CurrencyID+''' 		
					 '
END
If @IsDate =0 
BEGIN
	SET @sTime ='TranMonth + 100*TranYear between '+str(@FromMonth)+' + 100*'+str(@FromYear)+'  AND  '+str(@ToMonth)+' + 100*'+str(@ToYear)+'  
	'
	if (@IsDebitCredit <> 0)
	BEGIN
	 SET @sTime = @sTime +'
	 and (OriginalAmountCN - ISNULL((Select sum(OriginalAmount) from AT0404 where 	DivisionID = AV0401_MK.DivisionID and
										ObjectID = AV0401_MK.ObjectID and
										DebitVoucherID = AV0401_MK.VoucherID and
										DebitBatchID = AV0401_MK.BatchID and
										DebitTableID = AV0401_MK.TableID and
										AccountID = AV0401_MK.DebitAccountID and
										CurrencyID = AV0401_MK.CurrencyIDCN and
										GiveUpDate <=   EOMONTH(DATEFROMPARTS('+str(@ToYear)+' ,'+str(@ToMonth)+',''01''))),0 ))>0 '
	END
END
If @IsDate =1
BEGIN
	SET @sTime ='CONVERT(DATETIME,CONVERT(varchar(10),VoucherDate,101),101)  BETWEEN '''+ convert(nvarchar(10),@FromDate,101) +''' AND '''+convert(nvarchar(10),@ToDate,101)+'''  '
	if (@IsDebitCredit <> 0)
	BEGIN
	 SET @sTime = @sTime +'
	 and (OriginalAmountCN - ISNULL((Select sum(OriginalAmount) from AT0404 where 	DivisionID = AV0401_MK.DivisionID and
										ObjectID = AV0401_MK.ObjectID and
										DebitVoucherID = AV0401_MK.VoucherID and
										DebitBatchID = AV0401_MK.BatchID and
										DebitTableID = AV0401_MK.TableID and
										AccountID = AV0401_MK.DebitAccountID and
										CurrencyID = AV0401_MK.CurrencyIDCN and
										CONVERT(DATETIME,CONVERT(varchar(10),GiveUpDate,101),101) <=   '''+convert(nvarchar(10),@ToDate,101)+'''),0 ))>0 '
	END
END
If  @IsDate =2
BEGIN
	SET @sTime ='CONVERT(DATETIME,CONVERT(varchar(10),InvoiceDate,101),101)  Between '''+ convert(nvarchar(10),@FromDate,101) +''' AND '''+convert(nvarchar(10),@ToDate,101)+'''   '
	if (@IsDebitCredit <> 0)
	BEGIN
	 SET @sTime = @sTime +'
	 and (OriginalAmountCN - ISNULL((Select sum(OriginalAmount) from AT0404 where 	DivisionID = AV0401_MK.DivisionID and
										ObjectID = AV0401_MK.ObjectID and
										DebitVoucherID = AV0401_MK.VoucherID and
										DebitBatchID = AV0401_MK.BatchID and
										DebitTableID = AV0401_MK.TableID and
										AccountID = AV0401_MK.DebitAccountID and
										CurrencyID = AV0401_MK.CurrencyIDCN and
										CONVERT(DATETIME,CONVERT(varchar(10),GiveUpDate,101),101) <=   '''+convert(nvarchar(10),@ToDate,101)+'''),0 ))>0 '
	END
END
SET @sSQL = @sSQL+' AND '+@sTime

--- View này chỉ được sử dụng cho sp AP1414_ST
IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE NAME ='AV0415')
	EXEC ('CREATE VIEW AV0415 AS '+@sSQL)
ELSE
	EXEC( 'ALTER VIEW AV0415 AS '+@sSQL)

	print @sSQL
If @IsDate =0 
BEGIN
	SET @sTime ='AV0412.TranMonth + 100*AV0412.TranYear between '+str(@FromMonth)+' + 100*'+str(@FromYear)+' AND  '+str(@ToMonth)+' + 100*'+str(@ToYear)+'  '
	SET @sTimeD ='T9.TranMonth + 100*T9.TranYear between '+str(@FromMonth)+' + 100*'+str(@FromYear)+' AND  '+str(@ToMonth)+' + 100*'+str(@ToYear)+'  '
	SET @sTimeD_C =  ' T9_C.TranMonth + 100*T9_C.TranYear <=  '+str(@ToMonth)+' + 100*'+str(@ToYear)+'  '
	SET @sTimeC ='T9.TranMonth + 100*T9.TranYear between '+str(@FromMonth)+' + 100*'+str(@FromYear)+' AND  '+str(@ToMonth)+' + 100*'+str(@ToYear)+' '
	SET @sTimeC_D =  ' T9_D.TranMonth + 100*T9_D.TranYear <=  '+str(@ToMonth)+' + 100*'+str(@ToYear)+'  '
END
If @IsDate =1
BEGIN
	SET @sTime ='CONVERT(DATETIME,CONVERT(varchar(10),AV0412.VoucherDate,101),101)  Between '''+ convert(varchar(10),@FromDate,101) +''' AND '''+convert(varchar(10),@ToDate,101)+'''   '
	SET @sTimeD = 'CONVERT(DATETIME,CONVERT(varchar(10),T9.VoucherDate,101),101)  Between '''+ convert(varchar(10),@FromDate,101) +''' AND '''+convert(varchar(10),@ToDate,101)+'''   '
	SET @sTimeD_C = ' CONVERT(DATETIME,CONVERT(varchar(10),T9_C.VoucherDate,101),101)  <= '''+convert(nvarchar(10),@ToDate,101)+'''  '  
	SET @sTimeC = 'CONVERT(DATETIME,CONVERT(varchar(10),T9.VoucherDate,101),101)  Between '''+ convert(varchar(10),@FromDate,101) +''' AND '''+convert(varchar(10),@ToDate,101)+'''   '
	SET @sTimeC_D = ' CONVERT(DATETIME,CONVERT(varchar(10),T9_D.VoucherDate,101),101)  <= '''+convert(nvarchar(10),@ToDate,101)+'''  '  
END
If  @IsDate =2
BEGIN
	SET @sTime = 'CONVERT(DATETIME,CONVERT(varchar(10),AV0412.InvoiceDate,101),101)  Between '''+ convert(varchar(10),@FromDate,101) +''' AND '''+convert(varchar(10),@ToDate,101)+'''   '
	SET @sTimeD = 'CONVERT(DATETIME,CONVERT(varchar(10),T9.InvoiceDate,101),101)  Between '''+ convert(varchar(10),@FromDate,101) +''' AND '''+convert(varchar(10),@ToDate,101)+'''   '
	SET @sTimeD_C = ' CONVERT(DATETIME,CONVERT(varchar(10),T9_C.InvoiceDate,101),101)  <= '''+convert(nvarchar(10),@ToDate,101)+'''   '    
	SET @sTimeC = 'CONVERT(DATETIME,CONVERT(varchar(10),T9.InvoiceDate,101),101)  Between '''+ convert(varchar(10),@FromDate,101) +''' AND '''+convert(varchar(10),@ToDate,101)+'''   '
	SET @sTimeC_D = ' CONVERT(DATETIME,CONVERT(varchar(10),T9_D.InvoiceDate,101),101)  <= '''+convert(nvarchar(10),@ToDate,101)+'''   '    
END
IF @CustomerName =16  --Customized In du lieu 2 database cua KH SIEUTHANH
	SET @sSQL ='SELECT   DISTINCT 1 as DB ,'
ELSE
	SET @sSQL ='SELECT DISTINCT	  '

IF (@IsDebitCredit = 0) -- PS tăng công nợ C331x
BEGIN
	SET @sSQL0 ='   
		SELECT AT0404.GiveUpDate, AT0404.GiveUpEmployeeID, AT0404.DivisionID,   
		   AT0404.ObjectID, AT0404.AccountID, AT0404.CurrencyID,   
		   AT0404.DebitVoucherID, AT0404.DebitBatchID, AT0404.DebitTableID,   
		   AT0404.CreditVoucherID, AT0404.CreditBatchID, AT0404.CreditTableID,   
		   AT0404.OriginalAmount, AT0404.ConvertedAmount, AT0404.IsExrateDiff,   
		   AT0404.CreateDate, AT0404.CreateUserID, AT0404.LastModifyDate, AT0404.LastModifyUserID
		FROM  AT0404  WITH (NOLOCK)  
		INNER JOIN AV0402 T9  
		 ON   T9.VoucherID = AT0404.CreditVoucherID AND  
		   T9.TableID = AT0404.CreditTableID AND  
		   T9.BatchID = AT0404.CreditBatchID AND  
		   T9.ObjectID = AT0404.ObjectID AND  
		   T9.CreditAccountID = AT0404.AccountID AND  
		   T9.DivisionID = AT0404.DivisionID  
		INNER JOIN AV0401_MK T9_D  
		 ON   T9_D.VoucherID = AT0404.DebitVoucherID AND  
		   T9_D.TableID = AT0404.DebitTableID AND  
		   T9_D.BatchID = AT0404.DebitBatchID AND  
		   T9_D.ObjectID = AT0404.ObjectID AND  
		   T9_D.DebitAccountID = AT0404.AccountID AND  
		   T9_D.DivisionID = AT0404.DivisionID  
		WHERE AT0404.DivisionID ='''+@DivisionID+'''  AND  
		  AT0404.ObjectID >= '''+@FromObjectID+''' AND AT0404.ObjectID<= '''+@ToObjectID+''' AND  
		  AT0404.CurrencyID like '''+@CurrencyID+''' AND  
		  AT0404.AccountID >= '''+@FromAccountID+''' AND AT0404.AccountID<= '''+@ToAccountID+''' 
		  AND '+@sTimeC+' AND' + @sTimeC_D
	  
		IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE NAME ='AV0423')  
		 EXEC ('CREATE VIEW AV0423 AS '+@sSQL0)  
		ELSE  
		 EXEC( 'ALTER VIEW AV0423 AS '+@sSQL0)  
		  --print '-- AV0423  '  + 	  @sSQL0  

	SET @sSQL = @sSQL + '
		
			T9.ObjectID+T9.CreditAccountID AS GroupID,
			T9.VoucherID, 
			T9.BatchID+T9.ObjectID+ISNULL(T9.InvoiceNo,'''')+T9.CreditAccountID AS BatchID , 
			T9.ObjectID, 
			T9.ObjectName,
			T9.CreditAccountID, 
			T9.CreditAccountName,
			T9.CurrencyID, 
			T9.CurrencyIDCN,
			T9.BDescription AS CreditDescription,
			T9.OriginalAmount,
			T9.OriginalAmountCN, 		--- So tien nguyen te theo doi cong no
			T9.ConvertedAmount,			--- So tien quy doi 
			ISNULL(AT0404.OriginalAmount,0) AS GiveUpOrAmount,	--- So tien nguyen te giai tru tuong ung
			ISNULL(AT0404.ConvertedAmount,0) AS GiveUpCoAmount,--- So tien quy doi giai tru tuong ung
			T9.VoucherNo AS CreditVoucherNo,		
			T9.VoucherDate AS CreditVoucherDate,
			T9.Serial AS CreditSerial,
			T9.InvoiceNo AS CreditInvoiceNo,
			T9.InvoiceDate AS CreditInvoiceDate,
			CONVERT(VARCHAR(10),T9.DueDate,103)   AS CreditDueDate,
			T9_D.BDescription AS DebitDescription,
			T9_D.Serial AS DebitSerial,
			T9_D.InvoiceNo AS DebitInvoiceNo,
			T9_D.VoucherNo AS DebitVoucherNo,
			T9_D.VoucherDate AS DebitVoucherDate,
			T9_D.InvoiceDate AS DebitInvoiceDate,
			T9_D.VoucherTypeID AS DebitVoucherTypeID,
			T9_D.BatchID AS DebitBatchID,
			T9.VoucherTypeID AS CreditVoucherTypeID,
			  '''+convert(varchar(10),@FromDate,103)+''' AS Fromdate,
			(CASE WHEN '+str(@IsDate)+'= 0 then ''30/'+Ltrim (str(@ToMonth))+'/'+ltrim(str(@ToYear))+'''  else   '''+convert(varchar(10),@ToDate,103)+''' end ) AS Todate,
			T9.O01ID, T9.O02ID, T9.O03ID,T9.O04ID, T9.O05ID,
			T9.O01Name , T9.O02Name ,T9.O03Name ,T9.O04Name,T9.O05Name, T9.DivisionID	
	FROM		AV0412  T9  
	LEFT JOIN   AV0423 AT0404
		ON 		T9.VoucherID = AT0404.CreditVoucherID AND
				T9.ObjectID = AT0404.ObjectID AND		
				T9.BatchID = AT0404.CreditBatchID AND
				T9.TableID = AT0404.CreditTableID AND
				T9.CreditAccountID = AT0404.AccountID AND 
				T9.DivisionID = AT0404.DivisionID 
	LEFT JOIN   AV0411 T9_D
		ON 		T9_D.VoucherID = AT0404.DebitVoucherID AND
				T9_D.ObjectID = AT0404.ObjectID AND		
				T9_D.BatchID = AT0404.DebitBatchID AND
				T9_D.TableID = AT0404.DebitTableID AND					
				T9_D.DebitAccountID =AT0404.AccountID AND
				T9_D.DivisionID = AT0404.DivisionID 					
	WHERE 		T9.DivisionID = '''+@DivisionID+''' AND 
				T9.ObjectID >= '''+@FromObjectID+''' AND T9.ObjectID<= '''+@ToObjectID+''' AND
				T9.CurrencyIDCN like '''+@CurrencyID+''' AND
				T9.CreditAccountID >= '''+@FromAccountID+''' AND T9.CreditAccountID<= '''+@ToAccountID+'''  '

	if @IsZero = 1  --khong hien thi hoa don da giai tru het
		SET @sSQL = @sSQL +' AND T9.BatchID+T9.ObjectID in (Select LinkID From AV0415 ) '

	if @IsNotGiveUp = 1 --khong hien thi hoa don chua giai tru 
		SET @sSQL = @sSQL +' AND  ( T9.Status <>0 )   '

	SET @sSQL = @sSQL +' AND '+@sTimeC
END
ELSE
BEGIN
	SET @sSQL0 ='   
		SELECT AT0404.GiveUpDate, AT0404.GiveUpEmployeeID, AT0404.DivisionID,   
		   AT0404.ObjectID, AT0404.AccountID, AT0404.CurrencyID,   
		   AT0404.DebitVoucherID, AT0404.DebitBatchID, AT0404.DebitTableID,   
		   AT0404.CreditVoucherID, AT0404.CreditBatchID, AT0404.CreditTableID,   
		   AT0404.OriginalAmount, AT0404.ConvertedAmount, AT0404.IsExrateDiff,   
		   AT0404.CreateDate, AT0404.CreateUserID, AT0404.LastModifyDate, AT0404.LastModifyUserID
		FROM  AT0404  WITH (NOLOCK)  
		INNER JOIN AV0401_MK T9  
		 ON   T9.VoucherID = AT0404.DebitVoucherID AND  
		   T9.TableID = AT0404.DebitTableID AND  
		   T9.BatchID = AT0404.DebitBatchID AND  
		   T9.ObjectID = AT0404.ObjectID AND  
		   T9.DebitAccountID = AT0404.AccountID AND  
		   T9.DivisionID = AT0404.DivisionID  
		INNER JOIN AV0402 T9_C  
		 ON   T9_C.VoucherID = AT0404.CreditVoucherID AND  
		   T9_C.TableID = AT0404.CreditTableID AND  
		   T9_C.BatchID = AT0404.CreditBatchID AND  
		   T9_C.ObjectID = AT0404.ObjectID AND  
		   T9_C.CreditAccountID = AT0404.AccountID AND  
		   T9_C.DivisionID = AT0404.DivisionID  
		WHERE AT0404.DivisionID ='''+@DivisionID+'''  AND  
		  AT0404.ObjectID >= '''+@FromObjectID+''' AND AT0404.ObjectID<= '''+@ToObjectID+''' AND  
		  AT0404.CurrencyID like '''+@CurrencyID+''' AND  
		  AT0404.AccountID >= '''+@FromAccountID+''' AND AT0404.AccountID<= '''+@ToAccountID+''' 
		  AND '+@sTimeD+' AND' + @sTimeD_C
	  
		IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE NAME ='AV0421')  
		 EXEC ('CREATE VIEW AV0421 AS '+@sSQL0)  
		ELSE  
		 EXEC( 'ALTER VIEW AV0421 AS '+@sSQL0)  
		  --print '-- AV0421  '  + 	  @sSQL0  

	SET @sSQL = @sSQL + '
		
			T9.ObjectID+T9.DebitAccountID AS GroupID,
			T9.VoucherID, 
			T9.BatchID+T9.ObjectID+ISNULL(T9.InvoiceNo,'''')+T9.DebitAccountID AS BatchID , 
			T9.ObjectID, 
			T9.ObjectName,
			T9.DebitAccountID, 
			AT1005.AccountName AS DebitAccountName,
			T9.CurrencyID, 
			T9.CurrencyIDCN,
			T9.BDescription AS DebitDescription,
			T9.OriginalAmount,
			T9.OriginalAmountCN, 		--- So tien nguyen te theo doi cong no
			T9.ConvertedAmount,			--- So tien quy doi 
			ISNULL(AT0404.OriginalAmount,0) AS GiveUpOrAmount,	--- So tien nguyen te giai tru tuong ung
			ISNULL(AT0404.ConvertedAmount,0) AS GiveUpCoAmount,--- So tien quy doi giai tru tuong ung
			T9.VoucherNo AS DebitVoucherNo,		
			T9.VoucherDate AS DebitVoucherDate,
			T9.Serial AS DebitSerial,
			T9.InvoiceNo AS DebitInvoiceNo,
			T9.InvoiceDate AS DebitInvoiceDate,
			CONVERT(VARCHAR(10),T9.DueDate,103)   AS DebitDueDate,
			T9.ExchangeRate,
			Case when Isnull(T9.PaymentExchangeRate,0) = 0 then T9.ExchangeRate else T9.PaymentExchangeRate end as PaymentExchangeRate,
			T9_C.BDescription AS CreditDescription,
			T9_C.Serial AS CreditSerial,
			T9_C.InvoiceNo AS CreditInvoiceNo,
			T9_C.VoucherNo AS CreditVoucherNo,
			T9_C.VoucherDate AS CreditVoucherDate,
			T9_C.InvoiceDate AS CreditInvoiceDate,
			T9_C.VoucherTypeID AS CreditVoucherTypeID,
			T9_C.BatchID AS CreditBatchID,
			T9.VoucherTypeID AS DebitVoucherTypeID,
			  '''+convert(varchar(10),@FromDate,103)+''' AS Fromdate,
			(CASE WHEN '+str(@IsDate)+'= 0 then ''30/'+Ltrim (str(@ToMonth))+'/'+ltrim(str(@ToYear))+'''  else   '''+convert(varchar(10),@ToDate,103)+''' end ) AS Todate,
			AT1202.O01ID, AT1202.O02ID, AT1202.O03ID,AT1202.O04ID, AT1202.O05ID,
			T01.AnaName AS O01Name , T02.AnaName AS O02Name , T03.AnaName AS O03Name , T04.AnaName AS O04Name, T05.AnaName AS O05Name, T9.DivisionID,
			'''+@FromAccountID+'''	AS FromAccountID, '''+@ToAccountID+''' AS ToAccountID,
			T9.CreateUserID,T9.UserName
	FROM		AV0411 T9    
	LEFT JOIN   AV0421 AT0404 
		ON 		T9.VoucherID = AT0404.DebitVoucherID AND
				T9.ObjectID = AT0404.ObjectID AND		
				T9.BatchID = AT0404.DebitBatchID AND
				T9.TableID = AT0404.DebitTableID AND
				T9.DebitAccountID = AT0404.AccountID AND 
				T9.DivisionID = AT0404.DivisionID 
	LEFT JOIN   AV0412 T9_C
		ON 		T9_C.VoucherID = AT0404.CreditVoucherID AND
				T9_C.ObjectID = AT0404.ObjectID AND		
				T9_C.BatchID = AT0404.CreditBatchID AND
				T9_C.TableID = AT0404.CreditTableID AND					
				T9_C.CreditAccountID =AT0404.AccountID AND
				T9_C.DivisionID = AT0404.DivisionID 		
	INNER JOIN AT1005 WITH (NOLOCK)   
		 ON   AT1005.AccountID = T9.DebitAccountID AND  AT1005.GroupID=''G04'' AND  AT1005.DivisionID = T9.DivisionID  				
	Left join AT1202 WITH(NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = T9.ObjectID
	Left Join AT1015  T01 WITH(NOLOCK) on T01.AnaID = AT1202.O01ID  and T01.AnaTypeID = ''O01''
	Left Join AT1015  T02 WITH(NOLOCK) on T02.AnaID = AT1202.O02ID  and T02.AnaTypeID = ''O02''
	Left Join AT1015  T03 WITH(NOLOCK) on T03.AnaID =  AT1202.O03ID  and T03.AnaTypeID = ''O03''
	Left Join AT1015  T04 WITH(NOLOCK) on T04.AnaID = AT1202.O04ID  and T04.AnaTypeID = ''O04''
	Left Join AT1015  T05 WITH(NOLOCK) on T05.AnaID = AT1202.O05ID  and T05.AnaTypeID = ''O05''
	WHERE 		T9.DivisionID = '''+@DivisionID+''' AND 
				T9.ObjectID >= '''+@FromObjectID+''' AND T9.ObjectID<= '''+@ToObjectID+''' AND
				T9.CurrencyIDCN like '''+@CurrencyID+''' AND
				T9.DebitAccountID >= '''+@FromAccountID+''' AND T9.DebitAccountID<= '''+@ToAccountID+'''  '

	if @IsZero = 1  --khong hien thi hoa don da giai tru het
		SET @sSQL = @sSQL +'   AND T9.BatchID+T9.ObjectID in (Select LinkID From AV0415 )  '

	if @IsNotGiveUp = 1 --khong hien thi hoa don chua giai tru 
		SET @sSQL = @sSQL +'  AND  ( T9.Status <>0 )  '

	SET @sSQL = @sSQL +' AND '+@sTimeD 
	
END
IF @CustomerName =16 AND @DatabaseName<>'' --Customized In du lieu 2 database cua KH SIEUTHANH
	BEGIN
		EXEC AP0414_ST @DivisionID,@FromObjectID,@ToObjectID,@FromAccountID,@ToAccountID,@CurrencyID,@IsDate,@FromDate,@ToDate,@FromMonth,@FromYear,@ToMonth,@ToYear,@IsZero,@IsNotGiveUp,@DatabaseName
		SET @sSQLUnionAll = '
			UNION ALL 
			SELECT  2 as DB, GroupID,VoucherID,BatchID,ObjectID,ObjectName,CreditAccountID,CreditAccountName,CurrencyID,CurrencyIDCN,CreditDescription,
			OriginalAmount, 
			OriginalAmountCN, --- So tien nguyen te theo doi cong no
			ConvertedAmount, --- So tien quy doi 
			GiveUpOrAmount, --- So tien nguyen te giai tru tuong ung
			GiveUpCoAmount, --- So tien quy doi giai tru tuong ung
			CreditVoucherNo,CreditVoucherDate,CreditSerial,CreditInvoiceNo,CreditInvoiceDate,CreditDueDate,DebitDescription,DebitSerial,		
			DebitInvoiceNo,DebitVoucherNo,DebitVoucherDate,DebitInvoiceDate,DebitVoucherTypeID,CreditVoucherTypeID,Fromdate,Todate,
			O01ID, O02ID,O03ID,O04ID,O05ID,
			O01Name ,O02Name ,O03Name ,O04Name,O05Name,DivisionID	
			FROM AV0414_ST
			'
	END		
ELSE
	SET @sSQLUnionAll = ''

--Print @sSQL
--Print @sSQLUnionAll
IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE NAME ='AV0414')
	EXEC ('CREATE VIEW AV0414 AS '+@sSQL + @sSQLUnionAll)
ELSE
	EXEC( 'ALTER VIEW AV0414 AS '+@sSQL + @sSQLUnionAll)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

