IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0274]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP0274]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




---- Created by: Bao Anh
---- Date: 03/12/2012
---- Purpose: Loc danh sach cac phieu mua hang/ban hang dung de ke thua lap phieu thu/chi
---- Modify on 20/03/2013 by Bao Anh: Bo sung WHERE DebitAccountID de len dung so tien con lai khi TK cong no va TK thue khac nhau
---- Modify on 08/04/2013 by Bao Anh: Bo sung 10 MPT
---- Modify on 14/05/2013 by Bao Anh: Gan dien giai la NULL (khong ke thua Dien giai chung tu)
---- Modify on 14/06/2013 by Khanh Van: Bo sung load them tai khoan
---- Modify on 20/09/2013 by Khanh Van: Chinh sua lai store nham cai tien toc do
---- Modify on 14/10/2015 by Phuong Thao: Bo sung ke thua chi tiet theo phong ban (Customize Sieu Thanh)
---- Modify on 17/01/2016 by Phuong Thao: Bo sung loc theo loai tien, group theo ty gia
---- Modify on 02/03/2016 by Phuong Thao: Bo sung IsWithhodingTax
---- Modify on 22/03/2016 by Phuong Thao: Thay đổi cách load dữ liệu, load số tiền còn lại dựa theo số tiền đã giải trừ
---- Modify on 28/04/2016 by Thi Phượng: bỏ Xử lý trường hợp đã giải trừ công nợ + bổ sung điều kiện phiếu giải trừ bán hàng theo bộ
---- Modify on 18/052016 by Thi Phượng:Customize Hoàng Trần 
---- Modified by Bảo Thy on 25/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Tiểu Mai on 02/06/2016: Bổ sung không quản lý giải trừ thì không hiển thị các hóa đơn đã được kế thừa
---- Modified on 10/05/2017 by Phương Thảo: Sửa danh mục dùng chung
---- Modified on 14/09/2017 by Hải Long: Bổ sung trường BDescription
---- Modified on 14/09/2017 by Hoàng vũ: Xử lý bỏ điều kiện kết DivisionID vì bảng AT1005 có dùng chung
---- Modified on 28/06/2019 by Kim Thư: CustomizeIndex = 73 - CAAN: Load thêm cột Số đơn hàng bán - OrderID khi kế thừa phiếu bán hàng
---- Modified on 02/07/2019 by Kim Thư: Thêm điều kiện DivisionID khi IsEliminateDebt = 1
---- Modified on 02/07/2019 by Khánh Đoan : Bổ sung dấu phẩy
---- Modified on 13/07/2020 by Văn Tài: Bổ sung tách store MEIKO, MTE.
---- Modified on 23/42/2021 by Nhựt Trường: Bổ sung tỷ giá đánh giá lại gần nhất
---- Modified on 20/02/2023 by Đức Duy: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified on 08/03/2023 by Nhựt Trường: [2023/03/IS/0057] - Bổ sung sum(), fix lỗi 'Subquery returned more than 1 value' ở câu truy vấn con.
---- Modified on 15/06/2023 by Nhật Thanh: Lấy max ORDERID
---- Modified on 23/06/2023 by Thành Sang - Sửa cách tính số tiền còn lại từ at0303 thay cho at9000 (customize KAJINMA)

----- Example: exec AP0274 @DivisionID=N'MK',@FromMonth=5,@FromYear=2017,@ToMonth=5,@ToYear=2017,@FromDate='2017-05-12 00:00:00',@ToDate='2017-05-12 00:00:00',@IsDate=1,@ObjectID=N'%',@TransactionTypeID=N'T03',@ConditionVT=N'('''')',@IsUsedConditionVT=N' (0=0) ',@ConditionOB=N'('''')',@IsUsedConditionOB=N' (0=0) ',@CurrencyID=N'USD'

CREATE PROCEDURE [dbo].[AP0274] @DivisionID nvarchar(50),
								@FromMonth int,
  								@FromYear int,
								@ToMonth int,
								@ToYear int,  
								@FromDate as datetime,
								@ToDate as Datetime,
								@IsDate as tinyint, ----0 theo ky, 1 theo ng�y
								@ObjectID nvarchar(50),
								@TransactionTypeID as nvarchar(50),	--- T03: ke thua phieu mua h�ng, T04: ke thua HDBH
								@ConditionVT nvarchar(1000),
								@IsUsedConditionVT nvarchar(1000),
								@ConditionOB nvarchar(1000),
								@IsUsedConditionOB nvarchar(1000),
								@CurrencyID Nvarchar(50) = '',
								@TranYear INT --- năm kỳ hiện tại đang đứng
			
 AS

Declare @sqlSelect as nvarchar(4000),
		@sqlSelect1 as nvarchar(4000),
		@sqlWhere  as nvarchar(4000),
		@CustomerName INT

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)
IF @CustomerName = 16 --- Customize Sieu Thanh
	EXEC AP0274_ST @DivisionID, @FromMonth, @FromYear,  @ToMonth, @ToYear,  @FromDate,  @ToDate,
				@IsDate, @ObjectID, @TransactionTypeID, @ConditionVT, @IsUsedConditionVT,
				@ConditionOB ,@IsUsedConditionOB
ELSE
IF @CustomerName = 50 OR @CustomerName = 115 --- Customize MEIKO | MTE
	EXEC AP0274_MK @DivisionID, @FromMonth, @FromYear,  @ToMonth, @ToYear,  @FromDate,  @ToDate,
				@IsDate, @ObjectID, @TransactionTypeID, @ConditionVT, @IsUsedConditionVT,
				@ConditionOB ,@IsUsedConditionOB
ELSE IF @CustomerName = 94 --- Customize KAJINMA
	EXEC AP0274_KJ @DivisionID, @FromMonth, @FromYear,  @ToMonth, @ToYear,  @FromDate,  @ToDate,
				@IsDate, @ObjectID, @TransactionTypeID, @ConditionVT, @IsUsedConditionVT,
				@ConditionOB ,@IsUsedConditionOB, @CurrencyID, @TranYear
ELSE
BEGIN		
	IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsEliminateDebt = 1)
	BEGIN
		IF @IsDate = 0
			Set  @sqlWhere = N'
			And  TranMonth+TranYear*100 between ' + cast(@FromMonth + @FromYear*100 as nvarchar(50)) + ' and ' +  cast(@ToMonth + @ToYear*100 as nvarchar(50))  + ' '
		else
			Set  @sqlWhere = N'
			And VoucherDate  Between '''+Convert(nvarchar(10),@FromDate,21)+''' and '''+convert(nvarchar(10), @ToDate,21)+''''

		Set @sqlWhere = @sqlWhere+'and (Isnull(AT9000.VoucherTypeID,''#'')  in ' + @ConditionVT + ' OR ' + @IsUsedConditionVT + ')
		And (Isnull(AT9000.ObjectID,''#'')  in ' + @ConditionOB + ' OR ' + @IsUsedConditionOB + ')'

		If @TransactionTypeID = 'T03'  --- Phieu Mua Hang
		BEGIN
			Set @sqlSelect = N'
			Select 
			Convert(TinyInt, 0) As Choose,
			AT9000.ExchangeRate,
			CASE WHEN 
				AT9000.TranYear = '+STR(@TranYear)+' THEN AT9000.ExChangeRate 
			ELSE
				(SELECT  TOP 1 A90.ExchangeRate FROM AT9000 A90  WITH (NOLOCK) 
				WHERE DivisionID = AT9000.DivisionID AND TransactionTypeID = ''T09''
				AND ObjectID = at9000.ObjectID AND CurrencyID = AT9000.CurrencyID AND (CreditAccountID = AT9000.CreditAccountID OR DebitAccountID = AT9000.CreditAccountID)
				AND (AT9000.TranYear <=  A90.TranYear AND A90.TranYear < '+STR(@TranYear)+' ) 
				ORDER BY AT9000.TranYear DESC)
			END AS ExchangeRateNew,
			AT9000.DivisionID, AT9000.VoucherTypeID, AT9000.VoucherID, AT9000.BatchID, 
			AT9000.VoucherDate, AT9000.VoucherNo, AT9000.Serial, AT9000.InvoiceNo, AT9000.InvoiceDate, 
			AT9000.VDescription, AT9000.BDescription, AT9000.ObjectID, AT9000.ObjectName, AT9000.VATNo, AT9000.IsUpdateName,
			AT9000.CurrencyID, AT9000.ExchangeRate, AT9000.CreditAccountID as AccountID,
			AT9000.Ana01ID, AT9000.Ana02ID, AT9000.Ana03ID, AT9000.Ana04ID, AT9000.Ana05ID,
			AT9000.Ana06ID, AT9000.Ana07ID, AT9000.Ana08ID, AT9000.Ana09ID, AT9000.Ana10ID,
			AT9000.OriginalAmount, AT9000.ConvertedAmount,
			(AT9000.OriginalAmount - ISNULL(K.OriginalAmountOffset,0)) AS EndOriginalAmount,
			(AT9000.ConvertedAmount - ISNULL(K.ConvertedAmountOffset,0)) AS EndConvertedAmount,
			AT9000.InvoiceCode, AT9000.InvoiceSign, AT9000.IsWithhodingTax
			FROM'

				Set @sqlSelect1 = N'
				(
					(Select 
						AT9000.DivisionID, AT9000.TranMonth, AT9000.TranYear, AT9000.VoucherID, AT9000.BatchID, AT9000.VoucherDate, AT9000.CreditAccountID, AT9000.TableID,
						isnull(Sum(AT9000.OriginalAmountCN), 0)  as OriginalAmount,
						isnull(Sum(AT9000.ConvertedAmount), 0)  as ConvertedAmount,
						AT9000.VoucherTypeID, AT9000.VoucherNo, AT9000.Serial, AT9000.InvoiceNo, AT9000.InvoiceDate, 
						AT9000.VDescription, AT9000.BDescription, AT9000.ObjectID, AT1202.ObjectName, AT1202.VATNo, AT1202.IsUpdateName,
						AT9000.CurrencyIDCN AS CurrencyID, AT9000.ExchangeRate,
						max(AT9000.Ana01ID) as Ana01ID, max(AT9000.Ana02ID) as Ana02ID, max(AT9000.Ana03ID) as Ana03ID, max(AT9000.Ana04ID) as Ana04ID, max(AT9000.Ana05ID) as Ana05ID,
						max(AT9000.Ana06ID) as Ana06ID, max(AT9000.Ana07ID) as Ana07ID, max(AT9000.Ana08ID) as Ana08ID, max(AT9000.Ana09ID) as Ana09ID, max(AT9000.Ana10ID) as Ana10ID,		
						AT9000.InvoiceCode, AT9000.InvoiceSign, Isnull(AT9000.IsWithhodingTax,0) AS IsWithhodingTax
					From AT9000 with(nolock)
					LEFT JOIN	AT1202  with(nolock)
							ON	 AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID
					Where AT9000.DivisionID = '''+@DivisionID+''' AND AT9000.TransactionTypeID in (''T03'',''T13'')
						AND	EXISTS (SELECT TOP 1 1 FROM AT1005 
								WHERE AT1005.GroupID = ''G04'' AND AT1005.IsObject = 1 AND AT9000.CreditAccountID = AT1005.AccountID)
						'+ case when Isnull(@CurrencyID,'') <> '' THEN 'AND AT9000.CurrencyID = '''+@CurrencyID+'''  ' ELSE '' END+'
						'+ case when Isnull(@ObjectID,'') <> '' THEN 'AND AT9000.ObjectID Like N'''+@ObjectID+N''' 'ELSE '' END+@sqlWhere+' 
					Group by AT9000.DivisionID, AT9000.TranMonth, AT9000.TranYear, AT9000.VoucherID, AT9000.BatchID, AT9000.VoucherDate, AT9000.CreditAccountID, AT9000.TableID,
							AT9000.VoucherTypeID, AT9000.VoucherNo, AT9000.Serial, AT9000.InvoiceNo, AT9000.InvoiceDate, 
							AT9000.VDescription, AT9000.BDescription, AT9000.ObjectID, AT1202.ObjectName, AT1202.VATNo, AT1202.IsUpdateName,
							AT9000.CurrencyIDCN, AT9000.ExchangeRate,AT9000.InvoiceCode, AT9000.InvoiceSign,AT9000.IsWithhodingTax
					) AT9000

					Left join 
					(
						Select	AT0404.DivisionID, AT0404.CreditVoucherID, AT0404.CreditBatchID, AT0404.CreditTableID, AT0404.AccountID, AT0404.CurrencyID,
								sum(OriginalAmount) As OriginalAmountOffset, 
								sum(ConvertedAmount) As ConvertedAmountOffset
						From AT0404	with(nolock)	
						Group by AT0404.DivisionID, AT0404.CreditVoucherID, AT0404.CreditBatchID, AT0404.CreditTableID, AT0404.AccountID, AT0404.CurrencyID
					) K  on AT9000.DivisionID = K.DivisionID and AT9000.VoucherID = K.CreditVoucherID
							AND AT9000.BatchID = K.CreditBatchID AND AT9000.CreditAccountID = K.AccountID 
							and AT9000.TableID = K.CreditTableID 
							 AND AT9000.CurrencyID = K.CurrencyID
				)
				WHERE (AT9000.OriginalAmount - ISNULL(K.OriginalAmountOffset,0)) > 0 
				ORDER BY AT9000.VoucherID, AT9000.VoucherDate, AT9000.InvoiceNo
				'
		END
		Else -- Phieu Ban Hang
		BEGIN
			Set @sqlSelect = N'
			Select 
			Convert(TinyInt, 0) As Choose,
			AT9000.ExchangeRate,
			CASE WHEN 
				AT9000.TranYear = '+STR(@TranYear)+' THEN AT9000.ExChangeRate
			ELSE
				(SELECT  TOP 1 A90.ExchangeRate FROM AT9000 A90  WITH (NOLOCK) 
				WHERE DivisionID = AT9000.DivisionID AND TransactionTypeID = ''T09''
				AND ObjectID = at9000.ObjectID AND CurrencyID = AT9000.CurrencyID AND (CreditAccountID = AT9000.DebitAccountID OR DebitAccountID = AT9000.DebitAccountID)
				AND (AT9000.TranYear <=  A90.TranYear AND A90.TranYear < '+STR(@TranYear)+' ) 
				ORDER BY AT9000.TranYear DESC)
			END AS ExchangeRateNew,
			AT9000.DivisionID, AT9000.VoucherTypeID, AT9000.VoucherID, AT9000.BatchID, 
			AT9000.VoucherDate, AT9000.VoucherNo, AT9000.Serial, AT9000.InvoiceNo, AT9000.InvoiceDate, 
			AT9000.VDescription, AT9000.BDescription, AT9000.ObjectID, AT9000.ObjectName, AT9000.VATNo, AT9000.IsUpdateName,
			AT9000.CurrencyID, AT9000.ExchangeRate, AT9000.DebitAccountID as AccountID,
			AT9000.Ana01ID, AT9000.Ana02ID, AT9000.Ana03ID, AT9000.Ana04ID, AT9000.Ana05ID,
			AT9000.Ana06ID, AT9000.Ana07ID, AT9000.Ana08ID, AT9000.Ana09ID, AT9000.Ana10ID,
			AT9000.OriginalAmount, AT9000.ConvertedAmount,
			(AT9000.OriginalAmount - ISNULL(K.OriginalAmountOffset,0)) AS EndOriginalAmount,
			(AT9000.ConvertedAmount - ISNULL(K.ConvertedAmountOffset,0)) AS EndConvertedAmount,
			AT9000.InvoiceCode, AT9000.InvoiceSign, AT9000.IsWithhodingTax,
			AT9000.OrderID
			FROM '
	
			If @CustomerName = 51--- Customize Hoàng Trần (phiếu bán hàng)
			Set @sqlSelect1 = N'
			(
				(Select 
					AT9000.DivisionID, AT9000.TranMonth, AT9000.TranYear, AT9000.VoucherID, AT9000.BatchID, AT9000.VoucherDate, AT9000.DebitAccountID, AT9000.TableID,
					isnull(Sum(AT9000.OriginalAmountCN), 0)  as OriginalAmount,
					isnull(Sum(AT9000.ConvertedAmount), 0)  as ConvertedAmount,
					AT9000.VoucherTypeID, AT9000.VoucherNo, AT9000.Serial, AT9000.InvoiceNo, AT9000.InvoiceDate, 
					AT9000.VDescription, AT9000.BDescription, AT9000.ObjectID, AT1202.ObjectName, AT1202.VATNo, AT1202.IsUpdateName,
					AT9000.CurrencyIDCN AS CurrencyID, AT9000.ExchangeRate,
					max(AT9000.Ana01ID) as Ana01ID, max(AT9000.Ana02ID) as Ana02ID, max(AT9000.Ana03ID) as Ana03ID, max(AT9000.Ana04ID) as Ana04ID, max(AT9000.Ana05ID) as Ana05ID,
					max(AT9000.Ana06ID) as Ana06ID, max(AT9000.Ana07ID) as Ana07ID, max(AT9000.Ana08ID) as Ana08ID, max(AT9000.Ana09ID) as Ana09ID, max(AT9000.Ana10ID) as Ana10ID,		
					AT9000.InvoiceCode, AT9000.InvoiceSign, Isnull(AT9000.IsWithhodingTax,0) AS IsWithhodingTax
				From AT9000 with(nolock)
				LEFT JOIN	AT1202 with(nolock)
						ON	AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID
				Where AT9000.TransactionTypeID in (''T04'',''T14'') 
					AND	EXISTS (SELECT TOP 1 1 FROM AT1005  WITH (NOLOCK)
							WHERE AT1005.GroupID = ''G03'' AND AT1005.IsObject = 1 AND AT9000.DebitAccountID = AT1005.AccountID)
					'+ case when Isnull(@CurrencyID,'') <> '' THEN 'AND AT9000.CurrencyID = '''+@CurrencyID+'''  ' ELSE '' END+'
					'+ case when Isnull(@ObjectID,'') <> '' THEN 'AND AT9000.ObjectID Like N'''+@ObjectID+N''' 'ELSE '' END+@sqlWhere+' 
				Group by AT9000.DivisionID, AT9000.TranMonth, AT9000.TranYear, AT9000.VoucherID, AT9000.BatchID, AT9000.VoucherDate, AT9000.DebitAccountID, AT9000.TableID,
						AT9000.VoucherTypeID, AT9000.VoucherNo, AT9000.Serial, AT9000.InvoiceNo, AT9000.InvoiceDate, 
						AT9000.VDescription, AT9000.BDescription, AT9000.ObjectID, AT1202.ObjectName, AT1202.VATNo, AT1202.IsUpdateName,
						AT9000.CurrencyIDCN, AT9000.ExchangeRate,AT9000.InvoiceCode, AT9000.InvoiceSign,AT9000.IsWithhodingTax
				) AT9000

				Left join 
				(
					Select	AT0303.DivisionID, AT0303.DebitVoucherID, AT0303.DebitBatchID, AT0303.DebitTableID, AT0303.AccountID, AT0303.CurrencyID,
							sum(OriginalAmount) As OriginalAmountOffset, 
							sum(ConvertedAmount) As ConvertedAmountOffset
					From AT0303	with(nolock)	
					Group by AT0303.DivisionID, AT0303.DebitVoucherID, AT0303.DebitBatchID, AT0303.DebitTableID, AT0303.AccountID, AT0303.CurrencyID
				) K  on AT9000.DivisionID = K.DivisionID and AT9000.VoucherID = K.DebitVoucherID
						AND AT9000.BatchID = K.DebitBatchID AND AT9000.DebitAccountID = K.AccountID 
						and (AT9000.TableID = K.DebitTableID or AT9000.TableID = ''AT1326'' or AT9000.TableID = ''MT1603'')---Phiếu giải trừ bán hàng theo bộ
						 AND AT9000.CurrencyID = K.CurrencyID
			)
			WHERE (AT9000.OriginalAmount - ISNULL(K.OriginalAmountOffset,0)) > 0 
			ORDER BY AT9000.VoucherID, AT9000.VoucherDate, AT9000.InvoiceNo
			'
			ELSE 
			Set @sqlSelect1 = N'
			(
				(Select 
					AT9000.DivisionID, AT9000.TranMonth, AT9000.TranYear, AT9000.VoucherID, AT9000.BatchID, AT9000.VoucherDate, AT9000.DebitAccountID, AT9000.TableID,
					isnull(Sum(AT9000.OriginalAmountCN), 0)  as OriginalAmount,
					isnull(Sum(AT9000.ConvertedAmount), 0)  as ConvertedAmount,
					AT9000.VoucherTypeID, AT9000.VoucherNo, AT9000.Serial, AT9000.InvoiceNo, AT9000.InvoiceDate, 
					AT9000.VDescription, AT9000.BDescription, AT9000.ObjectID, AT1202.ObjectName, AT1202.VATNo, AT1202.IsUpdateName,
					AT9000.CurrencyIDCN AS CurrencyID, AT9000.ExchangeRate,
					max(AT9000.Ana01ID) as Ana01ID, max(AT9000.Ana02ID) as Ana02ID, max(AT9000.Ana03ID) as Ana03ID, max(AT9000.Ana04ID) as Ana04ID, max(AT9000.Ana05ID) as Ana05ID,
					max(AT9000.Ana06ID) as Ana06ID, max(AT9000.Ana07ID) as Ana07ID, max(AT9000.Ana08ID) as Ana08ID, max(AT9000.Ana09ID) as Ana09ID, max(AT9000.Ana10ID) as Ana10ID,		
					AT9000.InvoiceCode, AT9000.InvoiceSign, Isnull(AT9000.IsWithhodingTax,0) AS IsWithhodingTax,
					AT9000.OrderID
				From AT9000 with(nolock)
				LEFT JOIN	AT1202 with(nolock) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID
				Where AT9000.DivisionID = '''+@DivisionID+''' AND AT9000.TransactionTypeID in (''T04'',''T14'') 
					AND	EXISTS (SELECT TOP 1 1 FROM AT1005 WITH (NOLOCK) 
							WHERE AT1005.GroupID = ''G03'' AND AT1005.IsObject = 1 AND AT9000.DebitAccountID = AT1005.AccountID)
					'+ case when Isnull(@CurrencyID,'') <> '' THEN 'AND AT9000.CurrencyID = '''+@CurrencyID+'''  ' ELSE '' END+'
					'+ case when Isnull(@ObjectID,'') <> '' THEN 'AND AT9000.ObjectID Like N'''+@ObjectID+N''' 'ELSE '' END+@sqlWhere+' 
				Group by AT9000.DivisionID, AT9000.TranMonth, AT9000.TranYear, AT9000.VoucherID, AT9000.BatchID, AT9000.VoucherDate, AT9000.DebitAccountID, AT9000.TableID,
						AT9000.VoucherTypeID, AT9000.VoucherNo, AT9000.Serial, AT9000.InvoiceNo, AT9000.InvoiceDate, 
						AT9000.VDescription, AT9000.BDescription, AT9000.ObjectID, AT1202.ObjectName, AT1202.VATNo, AT1202.IsUpdateName,
						AT9000.CurrencyIDCN, AT9000.ExchangeRate,AT9000.InvoiceCode, AT9000.InvoiceSign,AT9000.IsWithhodingTax,
						AT9000.OrderID
				) AT9000

				Left join 
				(
					Select	AT0303.DivisionID, AT0303.DebitVoucherID, AT0303.DebitBatchID, AT0303.DebitTableID, AT0303.AccountID, AT0303.CurrencyID,
							sum(OriginalAmount) As OriginalAmountOffset, 
							sum(ConvertedAmount) As ConvertedAmountOffset
					From AT0303	with(nolock)	
					Group by AT0303.DivisionID, AT0303.DebitVoucherID, AT0303.DebitBatchID, AT0303.DebitTableID, AT0303.AccountID, AT0303.CurrencyID
				) K  on AT9000.DivisionID = K.DivisionID and AT9000.VoucherID = K.DebitVoucherID
						AND AT9000.BatchID = K.DebitBatchID AND AT9000.DebitAccountID = K.AccountID 
						and AT9000.TableID = K.DebitTableID 
						 AND AT9000.CurrencyID = K.CurrencyID
			)
			WHERE (AT9000.OriginalAmount - ISNULL(K.OriginalAmountOffset,0)) > 0 
			ORDER BY AT9000.VoucherID, AT9000.VoucherDate, AT9000.InvoiceNo
			'
	
			END
	END
	ELSE
	BEGIN	
		IF @IsDate = 0
			Set  @sqlWhere = N'
			And  TranMonth+TranYear*100 between ' + cast(@FromMonth + @FromYear*100 as nvarchar(50)) + ' and ' +  cast(@ToMonth + @ToYear*100 as nvarchar(50))  + ' '
		else
			Set  @sqlWhere = N'
			And VoucherDate  Between '''+Convert(nvarchar(10),@FromDate,21)+''' and '''+convert(nvarchar(10), @ToDate,21)+''''

		If @TransactionTypeID = 'T03'
			Set @sqlSelect = N'
			Select AT9000.DivisionID, AT9000.VoucherID, CreditAccountID, AT9000.ExchangeRate,
			(isnull(OriginalAmount, 0) - isnull(OriginalAmountPC,0)) as EndOriginalAmount,
			(isnull(ConvertedAmount, 0) - isnull(ConvertedAmountPC,0)) as EndConvertedAmount 
			Into #Temp
			FROM(
			(Select 
				DivisionID, TranMonth, TranYear, VoucherID, VoucherDate, CreditAccountID, ExchangeRate,
				isnull(Sum(AT9000.OriginalAmount), 0)  as OriginalAmount,
				isnull(Sum(AT9000.ConvertedAmount), 0)  as ConvertedAmount
			From AT9000 WITH (NOLOCK) 
			Where TransactionTypeID in (''T03'',''T13'')
			Group by DivisionID, TranMonth, TranYear, VoucherID, VoucherDate, CreditAccountID, ExchangeRate) AT9000

			Left join (
				Select DivisionID, TVoucherID, DebitAccountID, PaymentExchangeRate, sum(OriginalAmount) As OriginalAmountPC, sum(ConvertedAmount) As ConvertedAmountPC
				From AT9000 WITH (NOLOCK) 
				Where TransactionTypeID In (''T02'',''T22'',''T99'', ''T25'', ''T35'') 
				Group by DivisionID, TVoucherID, DebitAccountID, PaymentExchangeRate
				) K  on AT9000.DivisionID = K.DivisionID and AT9000.VoucherID = K.TVoucherID 
					and AT9000.CreditAccountID = K.DebitAccountID and AT9000.ExchangeRate = K.PaymentExchangeRate	
			)
			WHERE	AT9000.DivisionID =N'''+@DivisionID+N''''+@sqlWhere
		Else
			Set @sqlSelect = N'
			Select AT9000.DivisionID, AT9000.VoucherID, DebitAccountID, 
			(isnull(OriginalAmount, 0) - isnull(OriginalAmountPT,0)) as EndOriginalAmount,
			(isnull(ConvertedAmount, 0) - isnull(ConvertedAmountPT,0)) as EndConvertedAmount
			Into #Temp
			FROM(
			(Select 
				DivisionID, TranMonth, TranYear, VoucherID, VoucherDate, DebitAccountID, ExchangeRate,
				isnull(Sum(AT9000.OriginalAmount), 0)  as OriginalAmount,
				isnull(Sum(AT9000.ConvertedAmount), 0)  as ConvertedAmount
			From AT9000 WITH (NOLOCK) 
			Where TransactionTypeID in (''T04'',''T14'')
			Group by DivisionID, TranMonth, TranYear, VoucherID, VoucherDate,DebitAccountID, ExchangeRate) AT9000

			Left join (
				Select DivisionID, TVoucherID, CreditAccountID, PaymentExchangeRate, sum(OriginalAmount) As OriginalAmountPT, sum(ConvertedAmount) As ConvertedAmountPT
				From AT9000 WITH (NOLOCK) 
				Where TransactionTypeID In (''T01'',''T21'',''T99'',''T24'',''T34'')
				Group by DivisionID, TVoucherID, CreditAccountID, PaymentExchangeRate
				) K  on AT9000.DivisionID = K.DivisionID and AT9000.VoucherID = K.TVoucherID 
					and AT9000.DebitAccountID = K.CreditAccountID and AT9000.ExchangeRate = K.PaymentExchangeRate 
			)
			WHERE	AT9000.DivisionID =N'''+@DivisionID+N''''+@sqlWhere

		SET @sqlSelect1 =N'
				SELECT 	Convert(TinyInt, 0) As Choose, AT9000.DivisionID, AT9000.VoucherTypeID, AT9000.VoucherID, AT9000.BatchID, VoucherDate, VoucherNo, Serial, InvoiceNo, InvoiceDate, 
						NULL as VDescription, BDescription, AT9000.ObjectID, ObjectName, AT1202.VATNo, AT1202.IsUpdateName,
						AT9000.CurrencyID, ExchangeRate,' + (case when @TransactionTypeID = 'T03' then 'CreditAccountID' else 'DebitAccountID' end) + ' as AccountID,
						max(AT9000.Ana01ID) as Ana01ID, max(AT9000.Ana02ID) as Ana02ID, max(AT9000.Ana03ID) as Ana03ID, max(AT9000.Ana04ID) as Ana04ID, max(AT9000.Ana05ID) as Ana05ID,
						max(AT9000.Ana06ID) as Ana06ID, max(AT9000.Ana07ID) as Ana07ID, max(AT9000.Ana08ID) as Ana08ID, max(AT9000.Ana09ID) as Ana09ID, max(AT9000.Ana10ID) as Ana10ID,
						Sum(OriginalAmount) as OriginalAmount, Sum(ConvertedAmount) as ConvertedAmount,
						(Select SUM(EndOriginalAmount) From #Temp 
						Where DivisionID = ''' + @DivisionID + ''' And VoucherID = AT9000.VoucherID And  ExchangeRate = AT9000.ExchangeRate And ' + (case when @TransactionTypeID = 'T04' then 'DebitAccountID = AT9000.DebitAccountID' else 'CreditAccountID = AT9000.CreditAccountID' end) +') as EndOriginalAmount,
						(Select SUM(EndConvertedAmount) From #Temp 
						Where DivisionID = ''' + @DivisionID + ''' And VoucherID = AT9000.VoucherID And  ExchangeRate = AT9000.ExchangeRate And ' + (case when @TransactionTypeID = 'T04' then 'DebitAccountID = AT9000.DebitAccountID' else 'CreditAccountID = AT9000.CreditAccountID' end) +') as EndConvertedAmount
						,InvoiceCode,InvoiceSign, ISNULL(IsWithhodingTax,0) AS IsWithhodingTax,
						MAX(AT9000.OrderID) OrderID
				FROM		AT9000 WITH (NOLOCK) 
				LEFT JOIN	AT1202  WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID '
					
		Set @sqlSelect1 = @sqlSelect1 + N'
				WHERE AT9000.DivisionID =N''' + @DivisionID + N''' AND
						'+ case when Isnull(@CurrencyID,'') <> '' THEN 'AT9000.CurrencyID = '''+@CurrencyID+''' AND ' ELSE '' END+'
						AT9000.ObjectID Like N'''+@ObjectID+N''' AND AT9000.TransactionTypeID in (							
						' +	
						case when @TransactionTypeID = 'T03' then '''T03'',''T13''' else '''T04'',''T14''' end + N') AND '

		IF @TransactionTypeID = 'T03'
				Set @sqlSelect1 = @sqlSelect1 + N'VoucherID in (Select VoucherID FROM #Temp Where DivisionID = N''' + @DivisionID + ''' And EndOriginalAmount>0) '
		ELSE
				Set @sqlSelect1 = @sqlSelect1 + N'VoucherID in (Select VoucherID FROM #Temp Where DivisionID = N''' + @DivisionID + ''' And EndOriginalAmount>0) '
		
		SET @sqlWhere = @sqlWhere+'and (Isnull(AT9000.VoucherTypeID,''#'')  in ' + @ConditionVT + ' OR ' + @IsUsedConditionVT + ')
		And (Isnull(AT9000.ObjectID,''#'')  in ' + @ConditionOB + ' OR ' + @IsUsedConditionOB + ')'
 
		Set @sqlSelect1 = @sqlSelect1	+@sqlWhere+
				'GROUP BY AT9000.DivisionID, AT9000.VoucherTypeID, AT9000.VoucherID, AT9000.BatchID, VoucherDate, VoucherNo, Serial, InvoiceNo,InvoiceCode,InvoiceSign, InvoiceDate, 
						AT9000.ObjectID, ObjectName, AT1202.VATNo, AT1202.IsUpdateName, IsWithhodingTax, BDescription,
						AT9000.CurrencyID, ExchangeRate,' + (case when @TransactionTypeID = 'T03' then 'CreditAccountID' else 'DebitAccountID' end) + '
				Order by VoucherID, VoucherDate, InvoiceNo'
	END
		 
	print @sqlSelect
	print @sqlSelect1	
	EXEC (@sqlSelect+@sqlSelect1)
END




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

