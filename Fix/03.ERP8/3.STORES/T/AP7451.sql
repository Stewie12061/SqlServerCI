IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7451]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP7451]
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
---- Modified by Hải Long on 19/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Kim Thư on 27/12/2018: Bổ sung lọc theo ngày tạo chứng từ
---- Modified by Hoàng Trúc on 04/07/2019: Bổ sung thêm trường Tên người nhận (SenderReceiver) 
---- Modified by Văn Minh on 18/02/2020: Bổ sung DivisionID cho AT1009
---- Modified on 27/04/2021 by Huỳnh Thử : [TienTien] -- Tách Store
---- Modified on 07/10/2022 by Nhật Quang : Bổ sung Lấy số phát sinh nợ, có theo CreditAcountID, DebitAccountID
---- Modified on 16/12/2022 by Thanh Lượng [2022/12/IS/0103]: Bổ sung thêm DivisionID khi join bảng AT1202 (SEABORNES)
---- Modified on 21/12/2022 by Kiều Nga [2022/12/IS/0070]: Bổ sung thêm trường telephone + fax 
---- Modified on 10/02/2023 by Thanh Lượng [2023/02/IS/0041]: Bổ sung thêm trường CreditAccountName,CreditAccountNameE,DebitAccountName,DebitAccountNameE
---- Modified on 30/08/2023 by Thành Sang: Bổ sung DivisionID khi Join bảng AT1011
---- Modified on 21/11/2023 by Đình Định: HUNGTHINH - Lấy InvoiceNo phiếu XK kế thừa phiếu BH. 
/********************************************
'* Edited by: [GS] [Ngọc Nhựt] [29/07/2010]
'********************************************/
---- EXEC AP7451 'AS', 1 , 2012, 12, 2012, NULL, NULL , 0
---- SELECT * FROM AV7451
CREATE PROCEDURE [dbo].[AP7451] 	
				@DivisionID AS NVARCHAR(50),
				@FromMonth AS int,
				@FromYear AS int,
				@ToMonth AS int,
				@ToYear AS int,
				@FromDate AS Datetime,
				@ToDate AS Datetime,
				@IsDate AS tinyint,
				@Type AS TINYINT,
				@StrDivisionID AS NVARCHAR(4000) = null,
				@ReportDate AS DATETIME = NULL


 AS
Declare @sSQL AS nvarchar(MAX),
	    @sSQL_1 nvarchar(MAX),
		@sSQLUnion AS nvarchar(4000),
		@strWhere nvarchar(4000),
		@strWhere1 nvarchar(4000),
		@strGroup nvarchar(MAX),
		@CustomerIndex int = (SELECT CustomerName FROM CustomerIndex WITH (NOLOCK))


IF @CustomerIndex = 13 -- Tiên Tiến
BEGIN
    EXEC dbo.AP7451_TIENTIEN @DivisionID = @DivisionID,                 -- nvarchar(50)
                    @FromMonth = @FromMonth,                    -- int
                    @FromYear = @FromYear,                     -- int
                    @ToMonth = @ToMonth,                      -- int
                    @ToYear = @ToYear,                       -- int
                    @FromDate = @FromDate, -- datetime
                    @ToDate = @ToDate,   -- datetime
                    @IsDate = @IsDate,                       -- tinyint
                    @Type = @Type ,                         -- tinyint
                    @StrDivisionID = @StrDivisionID ,                         
                    @ReportDate = @ReportDate                     
    
END
ELSE	
BEGIN
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

	If @IsDate = 1
	Begin
		IF @Type = 1 -- theo ngày chứng từ
		BEGIN
			SET @strWhere ='
			WHERE	AT9000.TransactionTypeID <>''T00'' AND
					AT9000.DivisionID = '''+@DivisionID+''' AND
					(CONVERT(DATETIME,CONVERT(VARCHAR(10),AT9000.VoucherDate,101),101) Between '''	+convert(nvarchar(10),@FromDate,101)+ ''' AND  '''+convert(nvarchar(10),@ToDate,101)+ ''') '

			SET @strWhere1 ='
			WHERE	AT9004.DivisionID = '''+@DivisionID+''' AND
					(CONVERT(DATETIME,CONVERT(VARCHAR(10),AT9004.VoucherDate,101),101) Between '''	+convert(nvarchar(10),@FromDate,101)+ ''' AND  '''+convert(nvarchar(10),@ToDate,101)+ ''') '
		END
		ELSE --theo ngày tạo chứng từ
		BEGIN
			SET @strWhere ='
			WHERE	AT9000.TransactionTypeID <>''T00'' AND
					AT9000.DivisionID = '''+@DivisionID+''' AND
					(CONVERT(DATETIME,CONVERT(VARCHAR(10),AT9000.CreateDate,101),101) Between '''	+convert(nvarchar(10),@FromDate,101)+ ''' AND  '''+convert(nvarchar(10),@ToDate,101)+ ''') '

			SET @strWhere1 ='
			WHERE	AT9004.DivisionID = '''+@DivisionID+''' AND
					(CONVERT(DATETIME,CONVERT(VARCHAR(10),AT9004.CreateDate,101),101) Between '''	+convert(nvarchar(10),@FromDate,101)+ ''' AND  '''+convert(nvarchar(10),@ToDate,101)+ ''') '

		END
	End
	
	Else
	Begin
		Select top 1 @FromMonth = TranMonth From AV9999 WITH (NOLOCK)
		Where DivisionID = @DivisionID
		and Right(ltrim(Quarter),4) = @FromYear
		Order by TranYear,TranMonth

		Select top 1 @ToMonth = TranMonth From AV9999 WITH (NOLOCK)
		Where DivisionID = @DivisionID
		and Right(ltrim(Quarter),4) = @ToYear
		Order by TranYear Desc,TranMonth Desc

		Select top 1 @FromYear = TranYear From AV9999 WITH (NOLOCK)
		Where DivisionID = @DivisionID
		and Right(ltrim(Quarter),4) = @FromYear
		Order by TranYear

		Select top 1 @ToYear = TranYear From AV9999 WITH (NOLOCK)
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
	


	SET @sSQL='
	SELECT		AT9000.DivisionID,
				AT9000.VoucherTypeID, AT9000.VoucherNo, 
				AT9000.TransactionTypeID, 
				CASE WHEN AT9000.TransactionTypeID = ''T98'' then  DateAdd(hh,1, AT9000.VoucherDate) else  AT9000.VoucherDate end AS  VoucherDate,		
				AT9000.Serial, 
				CASE WHEN AT9000.TransactionTypeID = ''T06'' THEN ISNULL(AT9.InvoiceNo,AT9000.InvoiceNo)
					 ELSE AT9000.InvoiceNo END AS InvoiceNo,
				AT9000.InvoiceDate, 
				AT9000.BDescription, 
				AT9000.VDescription,
				MAX(ISNULL(AT9000.TDescription,'''')) AS TDescription,
				AT9000.TransactionTypeID AS BatchID,	
				AT9000.DebitAccountID, 
				A2.AccountName AS DebitAccountName,A2.AccountNameE AS DebitAccountNameE,
				AT9000.CreditAccountID AS CreditAccountID,
				A1.AccountName as CreditAccountName,A1.AccountNameE as CreditAccountNameE,	
				AT9000.VATTypeID,
				AT1009.VATTypeName,
				SUM(ISNULL(AT9000.ConvertedAmount,0)) AS ConvertedAmount, 
				0 AS D_C,
				AT9000.ObjectID, CASE WHEN ISNULL(AT9000.VATObjectName,'''')='''' THEN AT1202.ObjectName  ELSE AT9000.VATObjectName END AS ObjectName,
				AT9000.CreditObjectID, CASE WHEN ISNULL(AT9000.CreditObjectName,'''')='''' THEN AT02.ObjectName  ELSE AT9000.CreditObjectName END AS CreditObjectName,
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
				AT9000.OriginalAmount, AT9000.ExchangeRate, AT9000.CurrencyID, AT1405.UserName, AT9000.SenderReceiver,
				DebitAT9000.SignAmount AS DebitConvertedAmount,
				CreditAT9000.SignAmount AS CreditConvertedAmount,
				AT1202.Fax,AT1202.Tel
				FROM AT9000 WITH (NOLOCK)
				CROSS APPLY
				(
					SELECT 	SUM(ConvertedAmount) as  SignAmount
					FROM		AT9000 AT00 WITH (NOLOCK)
					WHERE	AT00.DivisionID = AT9000.DivisionID
							AND AT00.CreditAccountID = AT9000.CreditAccountID
							AND AT00.TranMonth = AT9000.TranMonth  
							AND AT00.TranYear = AT9000.TranYear
							AND ISNULL(AT00.Ana08ID,0) = ISNULL(AT9000.Ana08ID,0)
							AND AT00.VoucherNo = AT9000.VoucherNo
							AND AT00.TransactionID = AT9000.TransactionID
							AND ISNULL(AT00.InventoryID,0) = ISNULL(AT9000.InventoryID,0)
				) CreditAT9000
				CROSS APPLY
				(
					SELECT 	SUM(ConvertedAmount) as  SignAmount
					FROM		AT9000 AT00 WITH (NOLOCK)
					WHERE	AT00.DivisionID = AT9000.DivisionID
							AND AT00.DebitAccountID = AT9000.DebitAccountID
							AND AT00.TranMonth = AT9000.TranMonth  
							AND AT00.TranYear = AT9000.TranYear
							AND ISNULL(AT00.Ana08ID,0) = ISNULL(AT9000.Ana08ID,0)
							AND AT00.VoucherNo = AT9000.VoucherNo
							AND AT00.TransactionID = AT9000.TransactionID
							AND ISNULL(AT00.InventoryID,0) = ISNULL(AT9000.InventoryID,0)
				) DebitAT9000'

	SET @sSQL_1=N'	
				LEFT JOIN AT1009 WITH (NOLOCK) ON AT1009.VATTypeID = AT9000.VATTypeID AND AT1009.DivisionID = AT9000.DivisionID
				LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.ObjectID = AT9000.ObjectID	AND AT1202.DivisionID in (AT9000.DivisionID,''@@@'')
				LEFT JOIN AT1202 AT02 WITH (NOLOCK) on AT02.ObjectID = AT9000.CreditObjectID AND AT02.DivisionID in (AT9000.DivisionID,''@@@'')
				LEFT JOIN AT1005 A1 WITH (NOLOCK) on A1.AccountID= AT9000.CreditAccountID and A1.DivisionID in (AT9000.DivisionID,''@@@'')
				LEFT JOIN AT1005 A2 WITH (NOLOCK) on A2.AccountID= AT9000.DebitAccountID and A2.DivisionID in (AT9000.DivisionID,''@@@'')
				LEFT JOIN AT1011 T1 WITH (NOLOCK) on T1.DivisionID in (AT9000.DivisionID,''@@@'') AND T1.AnaID = AT9000.Ana01ID And T1.AnaTypeID=''A01'' 
				LEFT JOIN AT1011 T2 WITH (NOLOCK) on T2.DivisionID in (AT9000.DivisionID,''@@@'') AND T2.AnaID = AT9000.Ana02ID And T2.AnaTypeID=''A02'' 
				LEFT JOIN AT1011 T3 WITH (NOLOCK) on T3.DivisionID in (AT9000.DivisionID,''@@@'') AND T3.AnaID = AT9000.Ana03ID And T3.AnaTypeID=''A03'' 
				LEFT JOIN AT1011 T4 WITH (NOLOCK) on T4.DivisionID in (AT9000.DivisionID,''@@@'') AND T4.AnaID = AT9000.Ana04ID And T4.AnaTypeID=''A04'' 
				LEFT JOIN AT1011 T5 WITH (NOLOCK) on T5.DivisionID in (AT9000.DivisionID,''@@@'') AND T5.AnaID = AT9000.Ana05ID And T5.AnaTypeID=''A05'' 
				LEFT JOIN AT1011 T6 WITH (NOLOCK) on T6.DivisionID in (AT9000.DivisionID,''@@@'') AND T6.AnaID = AT9000.Ana01ID And T6.AnaTypeID=''A06'' 
				LEFT JOIN AT1011 T7 WITH (NOLOCK) on T7.DivisionID in (AT9000.DivisionID,''@@@'') AND T7.AnaID = AT9000.Ana02ID And T7.AnaTypeID=''A07'' 
				LEFT JOIN AT1011 T8 WITH (NOLOCK) on T8.DivisionID in (AT9000.DivisionID,''@@@'') AND T8.AnaID = AT9000.Ana03ID And T8.AnaTypeID=''A08'' 
				LEFT JOIN AT1011 T9 WITH (NOLOCK) on T9.DivisionID in (AT9000.DivisionID,''@@@'') AND T9.AnaID = AT9000.Ana04ID And T9.AnaTypeID=''A09'' 
				LEFT JOIN AT1011 T10 WITH (NOLOCK) on T10.DivisionID in (AT9000.DivisionID,''@@@'') AND T10.AnaID = AT9000.Ana05ID And T10.AnaTypeID=''A10''
				LEFT JOIN AT1405 WITH (NOLOCK) on AT1405.UserID = AT9000.CreateUserID AND AT1405.DivisionID = AT9000.DivisionID
				LEFT JOIN AT9000 AT9 WITH (NOLOCK) ON AT9.DivisionID = AT9000.DivisionID AND AT9.WOrderID = AT9000.VoucherID	'

	
	SET @strGroup='
						GROUP BY AT9000.DivisionID, DebitAT9000.SignAmount,CreditAT9000.SignAmount,
						AT9000.VoucherTypeID, AT9000.VoucherNo, AT9000.VoucherDate,  
						AT9000.Serial, AT9000.InvoiceNo, AT9.InvoiceNo, AT9000.InvoiceDate, 
						AT9000.BDescription, AT9000.TDescription, AT9000.VDescription, AT9000.BatchID,
						AT9000.DebitAccountID , AT9000.CreditAccountID,  
						AT9000.VATTypeID,AT1009.VATTypeName, AT9000.TransactionTypeID ,
						AT9000.ObjectID, case when isnull(AT9000.VATObjectName,'''')='''' then AT1202.ObjectName  else AT9000.VATObjectName end,
						AT9000.CreditObjectID, CASE WHEN ISNULL(AT9000.CreditObjectName,'''')='''' then AT02.ObjectName  else AT9000.CreditObjectName END,
						AT9000.Orders,
						AT9000.Ana01ID, AT9000.Ana02ID, AT9000.Ana03ID, AT9000.Ana04ID, AT9000.Ana05ID, AT9000.Ana06ID, AT9000.Ana07ID, AT9000.Ana08ID, AT9000.Ana09ID, AT9000.Ana10ID,
						T1.AnaName, T2.AnaName, T3.AnaName, T4.AnaName, T5.AnaName,
						T6.AnaName, T7.AnaName, T8.AnaName, T9.AnaName, T10.AnaName, AT9000.OriginalAmount, AT9000.ExchangeRate, AT9000.CurrencyID,AT1405.UserName, AT9000.SenderReceiver
						,AT1202.Fax,AT1202.Tel,A1.AccountName,A2.AccountName,A1.AccountNameE,A2.AccountNameE'

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
			'''' AS DebitAccountName,'''' AS DebitAccountNameE,	
			CASE WHEN D_C =''C'' then AccountID else '''' end AS CreditAccountID,
			'''' AS CreditAccountName,'''' AS CreditAccountNameE,
			'''' AS VATTypeID,
			'''' AS VATTypeName,
			OriginalAmount AS ConvertedAmount, 
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
			OriginalAmount, ExchangeRate, CurrencyID,
			'''' As UserName,
			NULL As SenderReceiver,
			0 AS DebitConvertedAmount,
			0 AS CreditConvertedAmount,
			'''' As Fax,'''' As Tel
	FROM	AT9004	 WITH (NOLOCK)		
	'+@strWhere1+' 	
	'

	--PRINT @sSQL
	--PRINT @sSQL_1
	--PRINT @strWhere 
	--PRINT @strGroup 
	--PRINT @strWhere1
	
	select @sSQL+@strWhere+@strGroup + @sSQLUnion


	IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE SYSOBJECTS.NAME = 'AV7451' AND SYSOBJECTS.XTYPE = 'V')
		EXEC ('CREATE VIEW AV7451 AS --AP7451' + @sSQL + @sSQL_1 + @strWhere + @strGroup + @sSQLUnion)
	ELSE
		EXEC ('ALTER VIEW AV7451 AS --AP7451' + @sSQL + @sSQL_1+ @strWhere + @strGroup + @sSQLUnion)

		--select @sSQL+@strWhere+@strGroup + @sSQLUnion

	--(SELECT ISNULL (Sum(SignAmount), 0)  FROM AQ4301 WHERE AQ4301.AccountID = ''131'' AND AQ4301.ObjectID = AT9000.ObjectID ) AS DebitConvertedAmount,
	--(SELECT ISNULL (Sum(SignAmount), 0)  FROM AQ4301 WHAERE AQ4301.AccountID = ''156100'' AND AQ4301.ObjectID = AT9000.ObjectID ) AS CreditConvertedAmount
END 



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
