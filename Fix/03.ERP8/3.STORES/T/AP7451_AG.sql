IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7451_AG]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP7451_AG]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-------Created by Nguyen Van Nhan
-------In Nhat ky chung
-------Edit by Nguyen Quoc Huy
-------Edit by: Dang Le Bao Quynh; Date: 29/09/2009
-------Purpose: Sua cach du lieu cot BDescription
---- Modified on 13/09/2011 by Le Thi Thu Hien : Bo sung Orders
---- Modified on 18/01/2012 by Le Thi Thu Hien : Sua dieu kien loc theo ngay
---- Modified on 11/05/2012 by Lê Thị Thu Hiền : Bổ sung BDescription, TDescription
---- Modified on 03/08/2012 by Thiên Huỳnh : Bổ sung Đối tượng, Khoản mục
---- Modified on 30/03/2015 by Thanh Sơn: Lấy thêm trường nguyên tệ và tỉ giá
---- Modified on 10/06/2015 by Bảo Anh: Lấy dữ liệu năm theo niên độ TC người dùng thiết lập
---- Modified on 17/08/2015 by Quôc Tuấn: Bổ sung thêm trường CreditObjectID và CreditObjectName
---- Modified by Bảo Thy on 30/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
/********************************************
'* Edited by: [GS] [Ngọc Nhựt] [29/07/2010]
'********************************************/
---- EXEC AP7451 'AS', 1 , 2012, 12, 2012, NULL, NULL , 0
---- SELECT * FROM AV7451
CREATE PROCEDURE [dbo].[AP7451_AG] 	
				@DivisionID AS NVARCHAR(50),
				@FromMonth AS int,
				@FromYear AS int,
				@ToMonth AS int,
				@ToYear AS int,
				@FromDate AS Datetime,
				@ToDate AS Datetime,
				@IsDate AS tinyint

 AS
Declare @sSQL AS nvarchar(MAX),
		@sSQLUnion AS nvarchar(4000),
		@strWhere nvarchar(4000),
		@strWhere1 nvarchar(4000),
		@strGroup nvarchar(MAX)

If @IsDate = 0 
BEGIN
	SET @strWhere ='
		WHERE	AT9000.TransactionTypeID <>''T00'' AND
				AT9000.DivisionID = '''+@DivisionID+''' AND
				(AT9000.TranMonth + AT9000.TranYear*100 Between '+str(@FromMonth)+' + 100*'+str(@FromYear)+' AND  '+str(@ToMonth)+' + 100*'+str(@ToYear)+') '

	SET @strWhere1 ='
		WHERE	AT9004.DivisionID = '''+@DivisionID+''' AND
				(AT9004.TranMonth + AT9004.TranYear*100 Between '+str(@FromMonth)+' + 100*'+str(@FromYear)+' AND  '+str(@ToMonth)+' + 100*'+str(@ToYear)+') '
End

Else

BEGIN
   If @IsDate = 1
   Begin
		SET @strWhere ='
		WHERE	AT9000.TransactionTypeID <>''T00'' AND
				AT9000.DivisionID = '''+@DivisionID+''' AND
				(CONVERT(DATETIME,CONVERT(VARCHAR(10),AT9000.VoucherDate,101),101) Between '''	+convert(nvarchar(10),@FromDate,101)+ ''' AND  '''+convert(nvarchar(10),@ToDate,101)+ ''') '

		SET @strWhere1 ='
		WHERE	AT9004.DivisionID = '''+@DivisionID+''' AND
				(CONVERT(DATETIME,CONVERT(VARCHAR(10),AT9004.VoucherDate,101),101) Between '''	+convert(nvarchar(10),@FromDate,101)+ ''' AND  '''+convert(nvarchar(10),@ToDate,101)+ ''') '
	End
	
	Else
	Begin
		Select top 1 @FromMonth = TranMonth From AV9999
		Where DivisionID = @DivisionID
		and Right(ltrim(Quarter),4) = @FromYear
		Order by TranYear,TranMonth

		Select top 1 @ToMonth = TranMonth From AV9999
		Where DivisionID = @DivisionID
		and Right(ltrim(Quarter),4) = @ToYear
		Order by TranYear Desc,TranMonth Desc

		Select top 1 @FromYear = TranYear From AV9999
		Where DivisionID = @DivisionID
		and Right(ltrim(Quarter),4) = @FromYear
		Order by TranYear

		Select top 1 @ToYear = TranYear From AV9999
		Where DivisionID = @DivisionID
		and Right(ltrim(Quarter),4) = @ToYear
		Order by TranYear Desc

		SET @strWhere ='
		WHERE	AT9000.TransactionTypeID <>''T00'' AND
				AT9000.DivisionID = '''+@DivisionID+''' AND
				(AT9000.TranMonth + AT9000.TranYear*100 Between '+str(@FromMonth)+' + 100*'+str(@FromYear)+' AND  '+str(@ToMonth)+' + 100*'+str(@ToYear)+') '

		SET @strWhere1 ='
		WHERE	AT9004.DivisionID = '''+@DivisionID+''' AND
				(AT9004.TranMonth + AT9004.TranYear*100 Between '+str(@FromMonth)+' + 100*'+str(@FromYear)+' AND  '+str(@ToMonth)+' + 100*'+str(@ToYear)+') '
	End
	
END

SET @sSQL='
SELECT		AT9000.DivisionID,
			VoucherTypeID, VoucherNo, 
			TransactionTypeID, 
			CASE WHEN TransactionTypeID = ''T98'' then  DateAdd(hh,1, VoucherDate) else  VoucherDate end AS  VoucherDate,		
			Serial, InvoiceNo,
			InvoiceDate, 
			AT9000.BDescription, 
			AT9000.VDescription,
			MAX(ISNULL(AT9000.TDescription,'''')) AS TDescription,
			TransactionTypeID AS BatchID,	
			DebitAccountID, 
			CreditAccountID AS CreditAccountID,
			AT9000.VATTypeID,
			AT1009.VATTypeName,
			SUM(ConvertedAmount) AS ConvertedAmount, 
			0 AS DebitConvertedAmount,
			0 AS CreditConvertedAmount,
			0 AS D_C,
			AT9000.ObjectID, CASE WHEN ISNULL(AT9000.VATObjectName,'''')='''' THEN AT1202.ObjectName  ELSE VATObjectName END AS ObjectName,
			AT9000.CreditObjectID, CASE WHEN ISNULL(AT9000.CreditObjectName,'''')='''' THEN AT02.ObjectName  ELSE CreditObjectName END AS CreditObjectName,
			AT9000.Orders, 
			MAX(AT9000.Ana01ID) as Ana01ID,
			MAX(AT9000.Ana02ID) as Ana02ID,
			MAX(AT9000.Ana03ID) as Ana03ID,
			MAX(AT9000.Ana04ID) as Ana04ID,
			MAX(AT9000.Ana05ID) as Ana05ID,
			MAX(AT9000.Ana06ID) as Ana06ID,
			MAX(AT9000.Ana07ID) as Ana07ID,
			MAX(AT9000.Ana08ID) as Ana08ID,
			MAX(AT9000.Ana09ID) as Ana09ID,
			MAX(AT9000.Ana10ID) as Ana10ID,
			T1.AnaName as AnaName01, T2.AnaName as AnaName02, T3.AnaName as AnaName03, T4.AnaName as AnaName04, T5.AnaName as AnaName05,
			T6.AnaName as AnaName06, T7.AnaName as AnaName07, T8.AnaName as AnaName08, T9.AnaName as AnaName09, T10.AnaName as AnaName10,
			AT9000.OriginalAmount, AT9000.ExchangeRate, AT9000.CurrencyID
FROM		AT9000 WITH (NOLOCK)
LEFT JOIN	AT1009  WITH (NOLOCK)
	ON		AT1009.VATTypeID = AT9000.VATTypeID AND AT1009.DivisionID = AT9000.DivisionID
			left join AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID
			left join AT1202 AT02 WITH (NOLOCK) on AT02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT02.ObjectID = AT9000.CreditObjectID
			left join AT1011	T1 WITH (NOLOCK) on T1.AnaID = AT9000.Ana01ID And T1.AnaTypeID=''A01'' AND T1.DivisionID = AT9000.DivisionID
			left join AT1011	T2 WITH (NOLOCK) on T2.AnaID = AT9000.Ana02ID And T2.AnaTypeID=''A02'' AND T2.DivisionID = AT9000.DivisionID
			left join AT1011	T3 WITH (NOLOCK) on T3.AnaID = AT9000.Ana03ID And T3.AnaTypeID=''A03'' AND T3.DivisionID = AT9000.DivisionID
			left join AT1011	T4 WITH (NOLOCK) on T4.AnaID = AT9000.Ana04ID And T4.AnaTypeID=''A04'' AND T4.DivisionID = AT9000.DivisionID
			left join AT1011	T5 WITH (NOLOCK) on T5.AnaID = AT9000.Ana05ID And T5.AnaTypeID=''A05'' AND T5.DivisionID = AT9000.DivisionID
			left join AT1011	T6 WITH (NOLOCK) on T6.AnaID = AT9000.Ana01ID And T6.AnaTypeID=''A06'' AND T6.DivisionID = AT9000.DivisionID
			left join AT1011	T7 WITH (NOLOCK) on T7.AnaID = AT9000.Ana02ID And T7.AnaTypeID=''A07'' AND T7.DivisionID = AT9000.DivisionID
			left join AT1011	T8 WITH (NOLOCK) on T8.AnaID = AT9000.Ana03ID And T8.AnaTypeID=''A08'' AND T8.DivisionID = AT9000.DivisionID
			left join AT1011	T9 WITH (NOLOCK) on T9.AnaID = AT9000.Ana04ID And T9.AnaTypeID=''A09'' AND T9.DivisionID = AT9000.DivisionID
			left join AT1011	T10 WITH (NOLOCK) on T10.AnaID = AT9000.Ana05ID And T10.AnaTypeID=''A10'' AND T10.DivisionID = AT9000.DivisionID'
	
SET @strGroup='
					GROUP BY    AT9000.DivisionID, 
					VoucherTypeID, VoucherNo, VoucherDate,  
					Serial, InvoiceNo, InvoiceDate, 
					BDescription, TDescription, VDescription, BatchID,
					DebitAccountID , CreditAccountID,  
					AT9000.VATTypeID,AT1009.VATTypeName, AT9000.TransactionTypeID ,
					AT9000.ObjectID, case when isnull(AT9000.VATObjectName,'''')='''' then AT1202.ObjectName  else VATObjectName end,
					AT9000.CreditObjectID, CASE WHEN ISNULL(AT9000.CreditObjectName,'''')='''' then AT02.ObjectName  else CreditObjectName END,
					AT9000.Orders,
					Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
					T1.AnaName, T2.AnaName, T3.AnaName, T4.AnaName, T5.AnaName,
					T6.AnaName, T7.AnaName, T8.AnaName, T9.AnaName, T10.AnaName, AT9000.OriginalAmount, AT9000.ExchangeRate, AT9000.CurrencyID'

SET @sSQLUnion = ' 
UNION ALL
SELECT 	AT9004.DivisionID,
		VoucherTypeID, VoucherNo, 
		'''' AS TransactionTypeID, 
		VoucherDate,		
		'''' AS Serial, 
		'''' AS InvoiceNo,
		null AS InvoiceDate, 
		TDescription AS BDescription, 
		VDescription, 
		TDescription, 
		'''' AS BatchID,	
		CASE WHEN D_C =''D'' then AccountID else '''' end AS DebitAccountID, 
		CASE WHEN D_C =''C'' then AccountID else '''' end AS CreditAccountID,
		'''' AS VATTypeID,
		'''' AS VATTypeName,
		OriginalAmount AS ConvertedAmount, 
		0 AS DebitConvertedAmount,
		0 AS CreditConvertedAmount,
		0 AS D_C,
		'''' As ObjectID,
		'''' As ObjectName,
		'''' AS CreditObjectID,
		'''' AS CreditObjectName,
		0 AS Orders,
		'''' AS Ana01ID,
		'''' AS Ana02ID,
		'''' AS Ana03ID,
		'''' AS Ana04ID,
		'''' AS Ana05ID,
		'''' AS Ana06ID,
		'''' AS Ana07ID,
		'''' AS Ana08ID,
		'''' AS Ana09ID,
		'''' AS Ana10ID,
		'''' As AnaName01,
		'''' As AnaName02,
		'''' As AnaName03,
		'''' As AnaName04,
		'''' As AnaName05,
		'''' As AnaName06,
		'''' As AnaName07,
		'''' As AnaName08,
		'''' As AnaName09,
		'''' As AnaName10,
		OriginalAmount, ExchangeRate, CurrencyID
FROM	AT9004	 WITH (NOLOCK)		
'+@strWhere1+' 	
'

--PRINT @sSQL + @sSQLUnion

IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE SYSOBJECTS.NAME = 'AV7451' AND SYSOBJECTS.XTYPE = 'V')
	EXEC ('CREATE VIEW AV7451 AS --AP7451' + @sSQL+@strWhere+@strGroup + @sSQLUnion)
ELSE
	EXEC ('ALTER VIEW AV7451 AS --AP7451' + @sSQL+@strWhere+@strGroup + @sSQLUnion)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON