IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7408]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP7408]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---- In chi tiet cong no phai tra
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
-----Created by Nguyen Van Nhan, Date 29/08/2003
-----
-----Edited by Nguyen Thi Ngoc Minh, Date 27/04/2004
-----Purpose: Cho phep chon loai ngay len bao cao theo ngay  va theo ky
-----Edited by Nguyen Quoc Huy, Date 27/04/2007
-----Edited by Dang Le Bao Quynh, Date 29/12/2008
-----Purpose: Bo sung view phuc in chi tiet phai tra theo ma phan tich
-----Edited by Dang Le Bao Quynh, Date 03/11/2009
-----Purpose: Bo sung Ana01 trong cau lenh full join tao view AV7428
---- Modified on 16/01/2012 by Le Thi Thu Hien : Chinh sua where ngay
---- Modified on 27/10/2012 by Bao Anh: Bo sung TableID, Status
---- Modified on 05/03/2013 by Khanh Van: Bo sung lay len tu tai khoan den tai khoan cho Sieu Thanh 
---- Modified on 25/07/2013 by Lê Thị Thu Hiền : Bổ sung thêm Ana06ID --> Ana10ID
---- Modified by on 15/10/2014 by Huỳnh Tấn Phú : Bổ sung điều kiện lọc theo 10 mã phân tích. 0022752: [VG] In số dư đầu kỳ lên sai dẫn đến số dư cuối kỳ sai. 
---- Modified on 13/11/2014 by Mai Duyen : Bổ sung thêm DatabaseName (tinh năng In báo cao chi tiet no phai tra 2 Database, KH SIEUTHANH)
---- Modified on 04/12/2014 by Mai Duyen : Fix loi convert Ana
---- Modified on 05/12/2014 by Mai Duyen : Bo sung field DB (Customized bao cao 2 DB cho SIEU THANH)
---- Modified on 08/12/2014 by Mai Duyen : Fix sum  so du dau cua 2 DB
---- Modified on 30/12/2014 by Mai Duyen : Sua lai dieu kien ket du lieu cua view AV7408a, AV7429a
---- Modified on 30/12/2014 by Thanh Sơn: Bổ sung định danh trường ObjectID
---- Modified on 10/09/2015 by Tiểu Mai: Bổ sung tên 10 MPT, 10 tham số Parameter.
---- Modified on 16/12/2015 by Tiểu Mai: fix bug
---- Modified on 07/04/2016 by Hoàng Vũ: Bổ sung Điều kiện lọc nhiều DivisionIDvới biến truyền vào @StrDivisionID (CuatomizeIndex = 51 hoàng trần)
---- Modified on 10/05/2016 by Hoàng Vũ: Gọi Store AP7408_HT, AP7417_HT và AP7407_HT để load số dư và số phát sinh không phân theo DivisionID (CuatomizeIndex = 51 hoàng trần)
---- Modified by Quốc Tuấn on 9/06/2016:Bổ sung thêm trường  Amount01Ana04ID
---- Modified by Tiểu Mai on 21/06/2016: Fix bug bị double dữ liệu do AV7417.AnaxxID
---- Modified by Hải Long on 19/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Phương Thảo on 20/06/2017: Fix lỗi in 2 DB của SieuThanh
---- Modified on 04/03/2018 by Bảo Anh: Sửa cách lấy BDescription như báo cáo chi tiết nợ phải thu
---- Modified by Bảo Thy on 09/03/2018: Fix lỗi double dữ liệu http://192.168.0.204:8069/web?db=ASERP#id=3268&view_type=form&model=project.issue&action=390
---- Modified by Tra Giang on 28/02/2019: Bổ sung Điều kiện lọc nhiều DivisionIDvới biến truyền vào @StrDivisionID (CuatomizeIndex = 91 bluesky)
---- Modified by Hồng Thảo on 3/5/2019: Sửa điều lọc tài khoản, đối tượng cho chọn nhiều, bổ sung load thêm cột Contactor (CuatomizeIndex = 103 CBD)
---- Modified on 12/12/2019 by Văn Tài : Customize cho Mạnh Phương sử dụng [AV7408].[BDescription] = [AT9000].[BDescription]
---- Modified on 07/04/2021 by Huỳnh Thử : Tách Store [TienTien] -- Bổ sung xuất execl nhiều Division
---- Modified on 14/12/2021 by Nhật Thanh: Customize cho Angel
---- Modified on 24/03/2022 by Xuân Nguyên: Bổ sung Sum OpeningOriginalAmount và OpeningConvertedAmount để Fix lỗi double dữ liệu
---- Modified on 24/03/2022 by Xuân Nguyên: Bỏ sum SignConvertedAmount,SignOriginalAmount,DebitOriginalAmount,DebitConvertedAmount,CreditOriginalAmount,CreditConvertedAmount,
---- Modified by Văn Minh on 28/11/2019: Fix lỗi AV7407 và AV7417 không bound column
---- Modified on 19/05/2022 by Xuân Nguyên: [Customize CBD][2022/05/IS/0089] Bổ sung lại SUM các cột thành tiền
---- Modified on 25/05/2022 by Nhựt Trường: Fix lỗi sai cú pháp khi bổ sung sum các cột thành tiền cho CBD.
---- Modified on 07/06/2022 by Thành Sang: Bổ sung CustomizeIndex cho CBD.
---- Modified on 09/06/2022 by Thành Sang: Bổ sung GroupBy một số thuộc tính cho CBD.
---- Modified on 09/06/2022 by Thành Sang: Bổ sung thuộc tính TransactionID để Fix lỗi Sum xong Group bị gộp dòng.
---- Modified on 01/08/2022 by Nhựt Trường: [2022/07/IS/0181] - Bổ sung customize Tiến Hưng khi lấy thêm trường TransactionID ở vấn đề [2022/06/IS/0071].
---- Modified on 15/08/2022 by Nhật Thanh: Fix lại customize Tiến Hưng
---- Modified on 30/09/2033 by Thành Sang: Bỏ Group các cột đã Sum tránh double dòng
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified by Văn Tài on 02/06/2023: [2023/05/IS/0154] - [HICP] Customize: Bổ sung GroupRowNum khi load dữ liệu từng group.
---- Modified by Nhựt Trường on 08/12/2023: 2023/12/IS/0076, Fix lỗi không sum được dữ liệu do điều kiện Group by chưa chính xác khi tạo view AV7418.
-- <Example>
---- exec AP7408 @DivisionID=N'TMQ3',@FromMonth=6,@FromYear=2022,@ToMonth=6,@ToYear=2022,@TypeD=2,@FromDate='2022-06-04 09:13:43',@ToDate='2022-06-04 09:13:43',@CurrencyID=N'VND',@FromAccountID=N'3311',@ToAccountID=N'3311',@FromObjectID=N'02CNESTLE',@ToObjectID=N'02CNESTLE',@SqlFind=N'1=1',@DatabaseName=N'',@StrDivisionID=N'TMQ3',@ReportDate='2022-09-30 00:00:00'


CREATE PROCEDURE [dbo].[AP7408]
					@DivisionID AS nvarchar(50),
					@FromMonth AS int,
					@FromYear  AS int,
					@ToMonth  AS int,
					@ToYear  AS int,
					@TypeD AS tinyint,  
					@FromDate AS datetime,
					@ToDate AS datetime,
					@CurrencyID AS nvarchar(50),
					@FromAccountID AS nvarchar(50),
					@ToAccountID AS nvarchar(50),
					@FromObjectID  AS nvarchar(50),
					@ToObjectID  AS nvarchar(50),
					@SqlFind AS NVARCHAR(MAX),
					@DatabaseName as nvarchar(250) ='',
					@StrDivisionID AS NVARCHAR(4000) = null,
					@ReportDate AS DATETIME = NULL
 AS
Declare @sqlSelect nvarchar(Max),
		@sqlFrom nvarchar(Max),
        @sqlGroupBy nvarchar(Max);
Declare @sqlSelect1 nvarchar(Max),
		@sqlFrom1 nvarchar(Max),
        @sqlGroupBy1 nvarchar(Max);
Declare @sSQL AS nvarchar(Max),
		@SQLwhere AS nvarchar(Max),
		@SQLwhere1 AS nvarchar(Max),
		@sSQLUnion AS nvarchar(Max),
		@sSQLUnion1 AS nvarchar(Max),
		@SQLwhereAna AS nvarchar(Max),
		@TypeDate AS nvarchar(50),
		@FromPeriod AS int,
		@ToPeriod AS int,
		@TmpDivisionID AS nvarchar(50),
        @SQLWhereAna04_CBD01 AS nvarchar(50) = '',
        @SQLWhereAna04_CBD02 AS nvarchar(50) = ''
Declare @CustomerName INT
--Tao bang tam de kiem tra day co phai la khach hang Sieu Thanh khong (CustomerName = 16)
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

IF @CustomerName = 51 --Customize hoàng trần
Begin
	EXEC AP7408_HT @DivisionID, @FromMonth, @FromYear, @ToMonth, @ToYear, @TypeD, @FromDate,  @ToDate, 
	@CurrencyID, @FromAccountID,@ToAccountID, @FromObjectID, @ToObjectID, @SqlFind, @DatabaseName, @StrDivisionID
end
ELSE IF @CustomerName = 91 --Customize Bluesky
Begin
	EXEC AP7408_BL @DivisionID, @FromMonth, @FromYear, @ToMonth, @ToYear, @TypeD, @FromDate,  @ToDate, 
	@CurrencyID, @FromAccountID,@ToAccountID, @FromObjectID, @ToObjectID, @SqlFind, @DatabaseName, @StrDivisionID
END
ELSE IF @CustomerName = 13 --Customize TienTien
Begin
	EXEC AP7408_TienTien @DivisionID, @FromMonth, @FromYear, @ToMonth, @ToYear, @TypeD, @FromDate,  @ToDate, 
	@CurrencyID, @FromAccountID,@ToAccountID, @FromObjectID, @ToObjectID, @SqlFind, @DatabaseName, @StrDivisionID, @ReportDate
end
Else
Begin	
	
		
						IF @TypeD = 1 	---- Ngay Hoa don
							SET @TypeDate = 'InvoiceDate'
						ELSE IF @TypeD = 2 	---- Ngay chung tu
							SET @TypeDate = 'VoucherDate'
							   ELSE IF @TypeD = 3 	---- Theo Ngay dao han
								SET @TypeDate = 'DueDate'

						SET @FromPeriod = (@FromMonth + @FromYear * 100)	
						SET @ToPeriod = (@ToMonth + @ToYear * 100)	

						IF @TypeD in (1, 2, 3)   -- Theo ngay	
							SET @SQLwhere = ' AND (CONVERT(DATETIME,CONVERT(varchar(10),' + LTRIM(RTRIM(@TypeDate)) + ',101),101) BETWEEN ''' +	CONVERT(NVARCHAR(10), @FromDate, 101) + ''' AND ''' + CONVERT(NVARCHAR(10), @ToDate, 101)+''')  '
						ELSE    ---Theo ky
							SET @SQLwhere = ' AND (D3.TranMonth + 100 * D3.TranYear BETWEEN ' + str(@FromPeriod) + ' AND ' + str(@ToPeriod) + ') '

						----------	 Xac dinh so phat sinh
						EXEC AP7407  @DivisionID, @CurrencyID, @FromAccountID, @ToAccountID, @FromObjectID, @ToObjectID, @SQLwhere, @StrDivisionID

						----------	  Xac dinh so du 
						EXEC AP7417 @DivisionID, @FromObjectID, @ToObjectID, @FromAccountID, @ToAccountID, @CurrencyID, @FromPeriod,  @FromDate, @TypeD, @TypeDate,@SqlFind, @StrDivisionID

						IF @CustomerName = 103 --Customize CBD
						BEGIN 

						SET @SQLwhere = '
							WHERE (isnull(AV7407.ObjectID, AV7417.ObjectID) IN (SELECT ObjectID FROM AT0401_CBD WHERE (ID = '''+@FromObjectID+''' OR (ObjectID = '''+@FromObjectID+''' AND ID = '''+@FromAccountID+''')) AND ISNULL(ObjectID,'''') != '''')) 
									AND (isnull(AV7407.AccountID, AV7417.AccountID) IN (SELECT AccountID FROM AT0401_CBD WHERE ID = '''+@FromAccountID+''' AND ISNULL(AccountID,'''') != '''')) '
		
						SET @SQLwhereAna = '
							WHERE (isnull(AV7407.ObjectID, AV7427.ObjectID) IN (SELECT ObjectID FROM AT0401_CBD WHERE (ID = '''+@FromObjectID+''' OR (ObjectID = '''+@FromObjectID+''' AND ID = '''+@FromAccountID+''')) AND ISNULL(ObjectID,'''') != ''''))
								  AND (isnull(AV7407.AccountID, AV7427.AccountID) IN (SELECT AccountID FROM AT0401_CBD WHERE ID = '''+@FromAccountID+''' AND ISNULL(AccountID,'''') != ''''))'
								
                        SET @SQLWhereAna04_CBD01 = ' AND AV7417.Ana04ID = AV7407.Ana04ID'
                        SET @SQLWhereAna04_CBD02 = ' AND AV7427.Ana04ID = AV7407.Ana04ID'

						END 
						ELSE 
						BEGIN 

						SET @SQLwhere = '
							WHERE (isnull(AV7407.ObjectID, AV7417.ObjectID) between ''' + @FromObjectID + ''' and ''' + @ToObjectID + ''')  and (isnull(AV7407.AccountID, AV7417.AccountID) between ''' + @FromAccountID + ''' and ''' + @ToAccountID + ''')  '
		
						SET @SQLwhereAna = '
							WHERE (isnull(AV7407.ObjectID, AV7427.ObjectID) between ''' + @FromObjectID + ''' and ''' + @ToObjectID + ''')  and (isnull(AV7407.AccountID, AV7427.AccountID) between ''' + @FromAccountID + ''' and ''' + @ToAccountID + ''') '
		
						END 

		
						IF @CurrencyID <> '%'
							BEGIN
								SET @SQLwhere = @SQLwhere + ' and  isnull(AV7407.CurrencyIDCN, AV7417.CurrencyIDCN) like  ''' + @CurrencyID + '''  ' 
								SET @SQLwhereAna = @SQLwhereAna + ' and  isnull(AV7407.CurrencyIDCN, AV7427.CurrencyIDCN) like ''' + @CurrencyID + '''  ' 
							END

							--Khong co ma phan tich
							SET @sqlSelect = N'
							SELECT (ltrim(rtrim(isnull(AV7407.ObjectID, AV7417.ObjectID))) + ltrim(rtrim(isnull(AV7407.AccountID, AV7417.AccountID)))) AS GroupID,
									BatchID, 
									' + CASE WHEN @CustomerName = 90 THEN 'TransactionID' ELSE '''''' END +' AS TransactionID,
									VoucherID,
									AV7407.TableID, AV7407.Status,
									isnull(AV7407.DivisionID,AV7417.DivisionID) as DivisionID,
									TranMonth,
									TranYear, 
									Cast(Isnull(AV7407.AccountID, AV7417.AccountID) AS char(20)) + 
										cast(isnull(AV7407.ObjectID, AV7417.ObjectID)  AS char(20)) + 
										cast(isnull(AV7407.CurrencyIDCN, AV7417.CurrencyIDCN) AS char(20)) + 
										cast(Day(VoucherDate) + Month(VoucherDate)* 100 +
										Year(VoucherDate)*10000 AS char(8)) + 
										cast(VoucherID AS char(20)) + 
										(Case when RPTransactionType = ''00'' then ''0'' ELSE ''1'' end) AS Orders,
									RPTransactionType , TransactionTypeID,
									Isnull(AV7407.ObjectID, AV7417.ObjectID) AS ObjectID,
									isnull(AT1202.ObjectName,AV7417.ObjectName)  AS ObjectName,
									AT1202.Note,
									AT1202.Address, AT1202.VATNo,AT1202.Contactor,
									AT1202.S1, AT1202.S2, AT1202.S3, AT1202.Tel, AT1202.Fax, AT1202.Email,
									AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID,
									DebitAccountID, CreditAccountID, 
									Isnull(AV7407.AccountID, AV7417.AccountID) AS AccountID, 
									Isnull(AT1005.AccountName, AV7417.AccountName) AS AccountName,
									VoucherTypeID,
									VoucherNo,
									VoucherDate,
									InvoiceNo,
									InvoiceDate,
									Serial,
									VDescription,
									' + CASE WHEN @CustomerName = 69 THEN 'BDescription' ELSE 'ISNULL(TDescription,ISNULL(BDescription,VDescription))' END +' AS BDescription,
									TDescription, 
									AV7407.Ana01ID,
									AV7407.Ana02ID,
									AV7407.Ana03ID,
									AV7407.Ana04ID,
									AV7407.Ana05ID,
									AV7407.Ana06ID,
									AV7407.Ana07ID,
									AV7407.Ana08ID,
									AV7407.Ana09ID,
									AV7407.Ana10ID,
									AV7407.Ana01Name,AV7407.Ana02Name,AV7407.Ana03Name,AV7407.Ana04Name,AV7407.Ana05Name,AV7407.Ana06Name,AV7407.Ana07Name,AV7407.Ana08Name,AV7407.Ana09Name,AV7407.Ana10Name,
									isnull(AV7407.CurrencyIDCN, AV7417.CurrencyIDCN) AS CurrencyID,
									ExchangeRate,
									AV7407.CreateDate, -- = (Select distinct max(AV7407.Createdate) From AV7407 V07 where V07.VoucherID = AV7407.VoucherID),
									Sum(isnull(SignConvertedAmount, 0)) AS SignConvertedAmount,
									Sum(isnull(SignOriginalAmount, 0)) AS SignOriginalAmount,
									Sum(Case When RPTransactionType = ''00'' then isnull(OriginalAmount, 0) ELSE 0 End )as DebitOriginalAmount,
									Sum(Case When RPTransactionType = ''01'' then isnull(OriginalAmount, 0) ELSE 0 End) AS CreditOriginalAmount,
									Sum(Case When RPTransactionType = ''00'' then isnull(ConvertedAmount, 0) ELSE 0 End) AS DebitConvertedAmount,
									Sum(Case When RPTransactionType = ''01'' then isnull(ConvertedAmount, 0) ELSE 0 End) AS CreditConvertedAmount,
									isnull(OpeningOriginalAmount,0) AS OpeningOriginalAmount,
									isnull(OpeningConvertedAmount,0) AS OpeningConvertedAmount,
									cast(0 as decimal(28,8)) AS ClosingOriginalAmount,
									cast(0 as decimal(28,8)) AS ClosingConvertedAmount,Duedate,
									AV7407.Parameter01, AV7407.Parameter02, AV7407.Parameter03, AV7407.Parameter04, AV7407.Parameter05, AV7407.Parameter06, AV7407.Parameter07, AV7407.Parameter08, AV7407.Parameter09, AV7407.Parameter10,AV7407.Amount01Ana04ID '
			
						SET @sqlFrom  = ' 
							FROM		AV7407 WITH (NOLOCK) 
							' + case when @CustomerName = 57 
							then 'LEFT' else 'FULL' end 
							+ ' JOIN	AV7417 WITH (NOLOCK) ON AV7417.ObjectID = AV7407.ObjectID and AV7417.AccountID = AV7407.AccountID And AV7417.DivisionID = AV7407.DivisionID '+ @SQLWhereAna04_CBD01 +'
							LEFT JOIN 	AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = Isnull(AV7407.ObjectID, AV7417.ObjectID) --AV7407.ObjectID 
							LEFT JOIN	AT1005 WITH (NOLOCK) ON AT1005.AccountID = AV7407.AccountID ' 
							SET @sqlWhere  = @SQLwhere
							SET @sqlGroupBy =' 
							GROUP BY 	BatchID,										
										' + CASE WHEN @CustomerName = 90 THEN 'TransactionID,' ELSE '' END +'
										VoucherID, AV7407.TableID, AV7407.Status, AV7407.DivisionID,AV7417.DivisionID, TranMonth, TranYear, 
										RPTransactionType, TransactionTypeID, Isnull(AV7407.ObjectID, AV7417.ObjectID),
										AT1202.Address, AT1202.VATNo,AT1202.Contactor, AT1202.S1, AT1202.S2, AT1202.S3, AT1202.Tel, AT1202.Fax, AT1202.Email,
										AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID,
										DebitAccountID, CreditAccountID, Isnull(AV7407.AccountID, AV7417.AccountID), 
										VoucherTypeID, VoucherNo, VoucherDate, AV7417.OpeningOriginalAmount,AV7417.OpeningConvertedAmount,
										InvoiceNo, InvoiceDate, Serial, VDescription, ISNULL(TDescription,ISNULL(BDescription,VDescription)), TDescription,
										AV7407.Ana01ID,
										AV7407.Ana02ID,
										AV7407.Ana03ID,
										AV7407.Ana04ID,
										AV7407.Ana05ID,
										AV7407.Ana06ID,
										AV7407.Ana07ID,
										AV7407.Ana08ID,
										AV7407.Ana09ID,
										AV7407.Ana10ID,
										AV7407.Ana01Name,AV7407.Ana02Name,AV7407.Ana03Name,AV7407.Ana04Name,AV7407.Ana05Name,AV7407.Ana06Name,AV7407.Ana07Name,AV7407.Ana08Name,AV7407.Ana09Name,AV7407.Ana10Name,
										isnull(AV7407.CurrencyIDCN, AV7417.CurrencyIDCN), ExchangeRate, AV7407.CreateDate,
										isnull(AT1202.ObjectName,AV7417.ObjectName), AT1202.Note, Isnull(AT1005.AccountName, AV7417.AccountName),Duedate,
										AV7407.Parameter01, AV7407.Parameter02, AV7407.Parameter03, AV7407.Parameter04, AV7407.Parameter05, AV7407.Parameter06, AV7407.Parameter07, AV7407.Parameter08, AV7407.Parameter09, AV7407.Parameter10 ,AV7407.Amount01Ana04ID '
							-- Lấy số dư của đối tường mà không có phát sinh trong kỳ
								--Khong co ma phan tich
								--PRINT @sqlFrom
								SET @sqlSelect1 = ' 
								UNION 
								SELECT (ltrim(rtrim(isnull(AV7407.ObjectID, AV7417.ObjectID))) + ltrim(rtrim(isnull(AV7407.AccountID, AV7417.AccountID)))) AS GroupID,
									BatchID,
									' + CASE WHEN @CustomerName = 90 THEN 'TransactionID' ELSE '''''' END +' AS TransactionID,
									VoucherID,
									TableID, Status,
									AV7417.DivisionID,
									TranMonth,
									TranYear, 
									Cast(Isnull(AV7407.AccountID, AV7417.AccountID) AS char(20)) + 
										cast(isnull(AV7407.ObjectID, AV7417.ObjectID)  AS char(20)) + 
										cast(isnull(AV7407.CurrencyIDCN, AV7417.CurrencyIDCN) AS char(20)) + 
										cast(Day(VoucherDate) + Month(VoucherDate)* 100 +
										Year(VoucherDate)*10000 AS char(8)) + 
										cast(VoucherID AS char(20)) + 
										(Case when RPTransactionType = ''00'' then ''0'' ELSE ''1'' end) AS Orders,
									RPTransactionType , TransactionTypeID,
									Isnull(AV7407.ObjectID, AV7417.ObjectID) AS ObjectID,
									isnull(AT1202.ObjectName,AV7417.ObjectName)  AS ObjectName,
									AT1202.Note,
									AT1202.Address, AT1202.VATNo,AT1202.Contactor,
									AT1202.S1, AT1202.S2, AT1202.S3, AT1202.Tel, AT1202.Fax, AT1202.Email,
									AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID,
									DebitAccountID, CreditAccountID, 
									Isnull(AV7407.AccountID, AV7417.AccountID) AS AccountID, 
									Isnull(AT1005.AccountName, AV7417.AccountName) AS AccountName,
									VoucherTypeID,
									VoucherNo,
									VoucherDate,
									InvoiceNo,
									InvoiceDate,
									Serial,
									--NULL AS VDescription,
									--NULL AS BDescription,
									--NULL AS TDescription,
									AV7407.VDescription,
									' + CASE WHEN @CustomerName = 69 THEN 'BDescription' ELSE 'ISNULL(TDescription,ISNULL(BDescription,VDescription))' END +' AS BDescription,
									AV7407.TDescription,
									--convert(varchar,AV7417.Ana01ID),
									--convert(varchar,AV7417.Ana02ID),
									--convert(varchar,AV7417.Ana03ID),
									--convert(varchar,AV7417.Ana04ID),
									--convert(varchar,AV7417.Ana05ID),
									--convert(varchar,AV7417.Ana06ID),
									--convert(varchar,AV7417.Ana07ID),
									--convert(varchar,AV7417.Ana08ID),
									--convert(varchar,AV7417.Ana09ID),
									--convert(varchar,AV7417.Ana10ID),
			
									Cast (AV7407.Ana01ID as nvarchar(50)),
									Cast (AV7407.Ana02ID as nvarchar(50)),
									Cast (AV7407.Ana03ID as nvarchar(50)),
									Cast (AV7407.Ana04ID as nvarchar(50)),
									Cast (AV7407.Ana05ID as nvarchar(50)),
									Cast (AV7407.Ana06ID as nvarchar(50)),
									Cast (AV7407.Ana07ID as nvarchar(50)),
									Cast (AV7407.Ana08ID as nvarchar(50)),
									Cast (AV7407.Ana09ID as nvarchar(50)),
									Cast (AV7407.Ana10ID as nvarchar(50)),
									AV7407.Ana01Name,AV7407.Ana02Name,AV7407.Ana03Name,AV7407.Ana04Name,AV7407.Ana05Name,AV7407.Ana06Name,AV7407.Ana07Name,AV7407.Ana08Name,AV7407.Ana09Name,AV7407.Ana10Name,
									isnull(AV7407.CurrencyIDCN, AV7417.CurrencyIDCN) AS CurrencyID,
									ExchangeRate,
									AV7407.CreateDate, -- = (Select distinct max(AV7407.Createdate) From AV7407 V07 where V07.VoucherID = AV7407.VoucherID),
									Sum(isnull(SignConvertedAmount, 0)) AS SignConvertedAmount,
									Sum(isnull(SignOriginalAmount, 0)) AS SignOriginalAmount,
									Sum(Case When RPTransactionType = ''00'' then isnull(OriginalAmount, 0) ELSE 0 End )as DebitOriginalAmount,
									Sum(Case When RPTransactionType = ''01'' then isnull(OriginalAmount, 0) ELSE 0 End) AS CreditOriginalAmount,
									Sum(Case When RPTransactionType = ''00'' then isnull(ConvertedAmount, 0) ELSE 0 End) AS DebitConvertedAmount,
									Sum(Case When RPTransactionType = ''01'' then isnull(ConvertedAmount, 0) ELSE 0 End) AS CreditConvertedAmount,
									isnull(OpeningOriginalAmount,0) AS OpeningOriginalAmount,
									isnull(OpeningConvertedAmount,0) AS OpeningConvertedAmount,
									cast(0 as decimal(28,8)) AS ClosingOriginalAmount,
									cast(0 as decimal(28,8)) AS ClosingConvertedAmount,Duedate,
									AV7407.Parameter01, AV7407.Parameter02, AV7407.Parameter03, AV7407.Parameter04, AV7407.Parameter05, AV7407.Parameter06, AV7407.Parameter07, AV7407.Parameter08, AV7407.Parameter09, AV7407.Parameter10,AV7407.Amount01Ana04ID'
								SET @sqlFrom1  = ' 
								FROM AV7417 WITH (NOLOCK)
								LEFT JOIN AV7407 WITH (NOLOCK) on AV7417.ObjectID = AV7407.ObjectID and AV7417.AccountID = AV7407.AccountID And AV7417.DivisionID = AV7407.DivisionID ' + @SQLWhereAna04_CBD01 + '
								LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV7417.ObjectID
								LEFT JOIN AT1005 WITH (NOLOCK) on AT1005.AccountID = AV7417.AccountID ' 
								SET @sqlGroupBy1 =' 
								GROUP BY	BatchID,
											' + CASE WHEN @CustomerName = 90 THEN 'TransactionID,' ELSE '' END +'
											VoucherID, TableID, Status, AV7417.DivisionID, TranMonth, TranYear, 
											RPTransactionType, TransactionTypeID, Isnull(AV7407.ObjectID, AV7417.ObjectID),
											AT1202.Address, AT1202.VATNo,AT1202.Contactor, AT1202.S1, AT1202.S2, AT1202.S3, AT1202.Tel, AT1202.Fax, AT1202.Email,
											AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID,
											DebitAccountID, CreditAccountID, Isnull(AV7407.AccountID, AV7417.AccountID), 
											VoucherTypeID, VoucherNo, VoucherDate, AV7417.OpeningOriginalAmount,AV7417.OpeningConvertedAmount,
											InvoiceNo, InvoiceDate, Serial,--- VDescription, ISNULL(TDescription,ISNULL(BDescription,VDescription)),  TDescription,
											AV7407.Ana01ID,
											AV7407.Ana02ID,
											AV7407.Ana03ID,
											AV7407.Ana04ID,
											AV7407.Ana05ID,
											AV7407.Ana06ID,
											AV7407.Ana07ID,
											AV7407.Ana08ID,
											AV7407.Ana09ID,
											AV7407.Ana10ID,
											AV7407.Ana01Name,AV7407.Ana02Name,AV7407.Ana03Name,AV7407.Ana04Name,AV7407.Ana05Name,AV7407.Ana06Name,AV7407.Ana07Name,AV7407.Ana08Name,AV7407.Ana09Name,AV7407.Ana10Name,
											isnull(AV7407.CurrencyIDCN, AV7417.CurrencyIDCN), ExchangeRate, AV7407.CreateDate,
											isnull(AT1202.ObjectName,AV7417.ObjectName), AT1202.Note, Isnull(AT1005.AccountName, AV7417.AccountName),Duedate,
											AV7407.Parameter01, AV7407.Parameter02, AV7407.Parameter03, AV7407.Parameter04, AV7407.Parameter05, AV7407.Parameter06, AV7407.Parameter07, AV7407.Parameter08, AV7407.Parameter09, AV7407.Parameter10,AV7407.Amount01Ana04ID,
											AV7407.TDescription, AV7407.BDescription, AV7407.VDescription'
	--PRINT @sqlSelect
	--							PRINT @sqlFrom
	--							PRINT @sqlWhere
	--							PRINT @sqlGroupBy
	--							PRINT @sqlSelect1
	--							PRINT @sqlFrom1
	--							PRINT @sqlWhere
								PRINT @sqlGroupBy1
						IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7418]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
							EXEC ('  CREATE VIEW AV7418 	--Created by AP7408
								AS ' +  @sqlSelect + @sqlFrom + @sqlWhere + @sqlGroupBy +  
								@sqlSelect1 + @sqlFrom1 + @sqlWhere + @sqlGroupBy1)
						ELSE
							 EXEC ('  ALTER VIEW AV7418  	--Created by AP7408
								AS ' + @sqlSelect + @sqlFrom + @sqlWhere + @sqlGroupBy + 
								@sqlSelect1 + @sqlFrom1 + @sqlWhere + @sqlGroupBy1)

					



								--In co ma phan tich
								SET @sqlSelect='
								SELECT (ltrim(rtrim(isnull(AV7407.ObjectID, AV7427.ObjectID))) + ltrim(rtrim(isnull(AV7407.AccountID, AV7427.AccountID)))) AS GroupID,
										BatchID,
										' + CASE WHEN @CustomerName = 90 THEN 'TransactionID' ELSE '''''' END +' AS TransactionID,
										VoucherID,
										AV7407.TableID, AV7407.Status,
										AV7407.DivisionID,
										TranMonth,
										TranYear, 
										Cast(Isnull(AV7407.AccountID, AV7427.AccountID)  AS char(20)) + 
										cast(isnull(AV7407.ObjectID, AV7427.ObjectID)  AS char(20)) + 
										cast(isnull(AV7407.CurrencyIDCN, AV7427.CurrencyIDCN) AS char(20)) + 
										cast(Day(VoucherDate) + Month(VoucherDate)* 100 +
										Year(VoucherDate)*10000 AS char(8)) + 
										cast(VoucherID AS char(20)) + 
										(Case when RPTransactionType = ''00'' then ''0'' ELSE ''1'' end) AS Orders,
										RPTransactionType , TransactionTypeID,
										Isnull(AV7407.ObjectID, AV7427.ObjectID) AS ObjectID,
										isnull(AT1202.ObjectName,AV7427.ObjectName)  AS ObjectName,
										AT1202.Note,
										AT1202.Address,
										AT1202.VATNo,
										AT1202.Contactor,
										AT1202.S1, 
										AT1202.S2,
										AT1202.S3, 
										AT1202.Tel,
										AT1202.Fax, 
										AT1202.Email,
										AT1202.O01ID,
										AT1202.O02ID,
										AT1202.O03ID,
										AT1202.O04ID,
										AT1202.O05ID,
										DebitAccountID,
										CreditAccountID, 
										Isnull(AV7407.AccountID, AV7427.AccountID) AS AccountID, 
										Isnull(AT1005.AccountName, AV7427.AccountName) AS AccountName,
										VoucherTypeID,
										VoucherNo,
										VoucherDate,
										InvoiceNo,
										InvoiceDate,
										Serial,
										VDescription,
										' + CASE WHEN @CustomerName = 69 THEN 'BDescription' ELSE 'ISNULL(TDescription,ISNULL(BDescription,VDescription))' END +' AS BDescription,
										TDescription,
										Isnull(AV7407.Ana01ID,AV7427.Ana01ID) AS Ana01ID,
										AV7407.Ana02ID, AV7407.Ana03ID, AV7407.Ana04ID, AV7407.Ana05ID,
										AV7407.Ana06ID,AV7407.Ana07ID,AV7407.Ana08ID,AV7407.Ana09ID,AV7407.Ana10ID,
										isnull(AV7407.CurrencyIDCN, AV7427.CurrencyIDCN) AS CurrencyID,
										ExchangeRate,
										AV7407.CreateDate, -- = (Select distinct max(AV7407.Createdate) From AV7407 V07 where V07.VoucherID = AV7407.VoucherID),
										Sum(isnull(SignConvertedAmount, 0)) AS SignConvertedAmount,
										Sum(isnull(SignOriginalAmount, 0)) AS SignOriginalAmount,
										Sum(Case When RPTransactionType = ''00'' then isnull(OriginalAmount, 0) ELSE 0 End )as DebitOriginalAmount,
										Sum(Case When RPTransactionType = ''01'' then isnull(OriginalAmount, 0) ELSE 0 End) AS CreditOriginalAmount,
										Sum(Case When RPTransactionType = ''00'' then isnull(ConvertedAmount, 0) ELSE 0 End) AS DebitConvertedAmount,
										Sum(Case When RPTransactionType = ''01'' then isnull(ConvertedAmount, 0) ELSE 0 End) AS CreditConvertedAmount,
										isnull(OpeningOriginalAmount, 0) AS OpeningOriginalAmount,
										isnull(OpeningConvertedAmount, 0) AS OpeningConvertedAmount,
										isnull(AV7427.OpeningOriginalAmountAna01ID, 0)  AS OpeningOriginalAmountAna01ID,
										isnull(AV7427.OpeningConvertedAmountAna01ID, 0) AS OpeningConvertedAmountAna01ID,
										cast(0 as decimal(28,8)) AS ClosingOriginalAmount,
										cast(0 as decimal(28,8)) AS ClosingConvertedAmount '
								SET @sqlFrom = ' 
								FROM AV7407 WITH (NOLOCK)
								' + case when @CustomerName = 57 
								then 'LEFT' else 'FULL' end 
								+ ' JOIN AV7427 WITH (NOLOCK) on AV7427.ObjectID = AV7407.ObjectID and AV7427.AccountID = AV7407.AccountID and AV7427.Ana01ID = AV7407.Ana01ID and AV7427.DivisionID = AV7407.DivisionID
								LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = Isnull(AV7407.ObjectID, AV7427.ObjectID) --AV7407.ObjectID
								LEFT JOIN AT1005 WITH (NOLOCK) on AT1005.AccountID = AV7407.AccountID ' 
								SET @sqlWhere = @SQLwhereAna
								SET @sqlGroupBy = ' 
								GROUP BY BatchID,
										' + CASE WHEN @CustomerName = 90 THEN 'TransactionID,' ELSE '' END +'
										VoucherID, AV7407.TableID, AV7407.Status, AV7407.DivisionID, TranMonth, TranYear, 
										RPTransactionType, TransactionTypeID, AV7407.ObjectID, AV7427.ObjectID,
										AT1202.Address, AT1202.VATNo,AT1202.Contactor, AT1202.S1, AT1202.S2, AT1202.S3, AT1202.Tel, AT1202.Fax, AT1202.Email,
										AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID,
										DebitAccountID, CreditAccountID, AV7407.AccountID, AV7427.AccountID, 
										VoucherTypeID, VoucherNo, VoucherDate, AV7427.OpeningOriginalAmount,AV7427.OpeningConvertedAmount, AV7427.OpeningOriginalAmountAna01ID, AV7427.OpeningConvertedAmountAna01ID,
										InvoiceNo, InvoiceDate, Serial, VDescription, BDescription,  TDescription,
										AV7427.Ana01ID, AV7407.Ana01ID, 
										AV7407.Ana02ID, AV7407.Ana03ID, AV7407.Ana04ID, AV7407.Ana05ID,
										AV7407.Ana06ID,AV7407.Ana07ID,AV7407.Ana08ID,AV7407.Ana09ID,AV7407.Ana10ID,
										AV7407.CurrencyIDCN, AV7427.CurrencyIDCN, ExchangeRate, AV7407.CreateDate,
										AV7427.ObjectName, AT1202.ObjectName, AT1202.Note, AT1005.AccountName, AV7427.AccountName '
							-- Lấy số dư của đối tường mà không có phát sinh trong kỳ
								--In co ma phan tich
								SET @sqlSelect1=' 
								UNION
								SELECT (ltrim(rtrim(isnull(AV7407.ObjectID, AV7427.ObjectID))) + ltrim(rtrim(isnull(AV7407.AccountID, AV7427.AccountID)))) AS GroupID,
										BatchID,
										' + CASE WHEN @CustomerName = 90 THEN 'TransactionID' ELSE '''''' END +' AS TransactionID,
										VoucherID,
										TableID, Status,
										AV7427.DivisionID,
										TranMonth,
										TranYear, 
										Cast(Isnull(AV7407.AccountID, AV7427.AccountID)  AS char(20)) + 
										cast(isnull(AV7407.ObjectID, AV7427.ObjectID)  AS char(20)) + 
										cast(isnull(AV7407.CurrencyIDCN, AV7427.CurrencyIDCN) AS char(20)) + 
										cast(Day(VoucherDate) + Month(VoucherDate)* 100 +
										Year(VoucherDate)*10000 AS char(8)) + 
										cast(VoucherID AS char(20)) + 
										(Case when RPTransactionType = ''00'' then ''0'' ELSE ''1'' end) AS Orders,
										RPTransactionType , TransactionTypeID,
										Isnull(AV7407.ObjectID, AV7427.ObjectID) AS ObjectID,
										isnull(AT1202.ObjectName,AV7427.ObjectName)  AS ObjectName,
										AT1202.Note,
										AT1202.Address,
										AT1202.VATNo,
										AT1202.Contactor,
										AT1202.S1, 
										AT1202.S2,
										AT1202.S3, 
										AT1202.Tel,
										AT1202.Fax, 
										AT1202.Email,
										AT1202.O01ID,
										AT1202.O02ID,
										AT1202.O03ID,
										AT1202.O04ID,
										AT1202.O05ID,
										DebitAccountID,
										CreditAccountID, 
										Isnull(AV7407.AccountID, AV7427.AccountID) AS AccountID, 
										Isnull(AT1005.AccountName, AV7427.AccountName) AS AccountName,
										VoucherTypeID,
										VoucherNo,
										VoucherDate,
										InvoiceNo,
										InvoiceDate,
										Serial,
										AV7407.VDescription,
										' + CASE WHEN @CustomerName = 69 THEN 'BDescription' ELSE 'ISNULL(TDescription,ISNULL(BDescription,VDescription))' END +' AS BDescription,
										AV7407.TDescription,
										--NULL as VDescription,
										--NULL as BDescription,
										--NULL as TDescription,
										Isnull(AV7407.Ana01ID,AV7427.Ana01ID) AS Ana01ID,
										AV7407.Ana02ID, AV7407.Ana03ID, AV7407.Ana04ID, AV7407.Ana05ID,
										AV7407.Ana06ID,AV7407.Ana07ID,AV7407.Ana08ID,AV7407.Ana09ID,AV7407.Ana10ID,
										isnull(AV7407.CurrencyIDCN, AV7427.CurrencyIDCN) AS CurrencyID,
										ExchangeRate,
										AV7407.CreateDate, -- = (Select distinct max(AV7407.Createdate) From AV7407 V07 where V07.VoucherID = AV7407.VoucherID),
										Sum(isnull(SignConvertedAmount, 0)) AS SignConvertedAmount,
										Sum(isnull(SignOriginalAmount, 0)) AS SignOriginalAmount,
										Sum(Case When RPTransactionType = ''00'' then isnull(OriginalAmount, 0) ELSE 0 End )as DebitOriginalAmount,
										Sum(Case When RPTransactionType = ''01'' then isnull(OriginalAmount, 0) ELSE 0 End) AS CreditOriginalAmount,
										Sum(Case When RPTransactionType = ''00'' then isnull(ConvertedAmount, 0) ELSE 0 End) AS DebitConvertedAmount,
										Sum(Case When RPTransactionType = ''01'' then isnull(ConvertedAmount, 0) ELSE 0 End) AS CreditConvertedAmount,
										isnull(OpeningOriginalAmount, 0) AS OpeningOriginalAmount,
										isnull(OpeningConvertedAmount, 0) AS OpeningConvertedAmount,
										isnull(AV7427.OpeningOriginalAmountAna01ID, 0)  AS OpeningOriginalAmountAna01ID,
										isnull(AV7427.OpeningConvertedAmountAna01ID, 0) AS OpeningConvertedAmountAna01ID,
										cast(0 as decimal(28,8)) AS ClosingOriginalAmount,
										cast(0 as decimal(28,8)) AS ClosingConvertedAmount '
								SET @sqlFrom1 = ' 
								FROM AV7427 WITH (NOLOCK) 
								LEFT JOIN AV7407 WITH (NOLOCK) on AV7427.ObjectID = AV7407.ObjectID and AV7427.AccountID = AV7407.AccountID And AV7427.DivisionID = AV7407.DivisionID
								LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV7427.ObjectID
								LEFT JOIN AT1005 WITH (NOLOCK) on AT1005.AccountID = AV7427.AccountID ' 
								SET @sqlGroupBy1 = ' 
								GROUP BY BatchID,
										' + CASE WHEN @CustomerName = 90 THEN 'TransactionID,' ELSE '' END +'
										VoucherID, TableID, Status, AV7427.DivisionID, TranMonth, TranYear, 
										RPTransactionType, TransactionTypeID, AV7407.ObjectID, AV7427.ObjectID,
										AT1202.Address, AT1202.VATNo,AT1202.Contactor, AT1202.S1, AT1202.S2, AT1202.S3, AT1202.Tel, AT1202.Fax, AT1202.Email,
										AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID,
										DebitAccountID, CreditAccountID, AV7407.AccountID, AV7427.AccountID, 
										VoucherTypeID, VoucherNo, VoucherDate, AV7427.OpeningOriginalAmount,AV7427.OpeningConvertedAmount, AV7427.OpeningOriginalAmountAna01ID, AV7427.OpeningConvertedAmountAna01ID,
										InvoiceNo, InvoiceDate, Serial,--- VDescription, BDescription,  TDescription,
										AV7427.Ana01ID, AV7407.Ana01ID, 
										AV7407.Ana02ID, AV7407.Ana03ID, AV7407.Ana04ID, AV7407.Ana05ID,
										AV7407.Ana06ID,AV7407.Ana07ID,AV7407.Ana08ID,AV7407.Ana09ID,AV7407.Ana10ID,
										AV7407.CurrencyIDCN, AV7427.CurrencyIDCN, ExchangeRate, AV7407.CreateDate,
										AV7427.ObjectName, AT1202.ObjectName, AT1202.Note, AT1005.AccountName, AV7427.AccountName,AV7407.TDescription,AV7407.BDescription,AV7407.VDescription '

						IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7428]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
							 EXEC ('  CREATE VIEW AV7428 	--Created by AP7408
								AS ' + @sqlSelect + @sqlFrom + @sqlWhere + @sqlGroupBy
								+  @sqlSelect1 + @sqlFrom1 + @sqlWhere + @sqlGroupBy1)
						ELSE
							 EXEC ('  ALTER VIEW AV7428  	--Created by AP7408
								AS ' + @sqlSelect + @sqlFrom + @sqlWhere + @sqlGroupBy
								+  @sqlSelect1 + @sqlFrom1 + @sqlWhere + @sqlGroupBy1)

						--PRINT @sqlSelect
						--		PRINT @sqlFrom
						--		PRINT @sqlWhere
						--		PRINT @sqlGroupBy
						--		PRINT @sqlSelect1
						--		PRINT @sqlFrom1
						--		PRINT @sqlWhere
						--		PRINT @sqlGroupBy1



						--Khong co ma phan tich
						IF @CustomerName = 16 --(Customized KH SIEU THANH)
							SET @sqlSelect = ' SELECT 1 as DB , '
						ELSE
							SET @sqlSelect =' SELECT  '

						--- Customize HIPC -- GROUP theo đối tượng để đánh dấu Row
						IF (@CustomerName = 158) -- HIPC
						BEGIN
							SET @sqlSelect = @sqlSelect + '
								ROW_NUMBER() OVER(PARTITION BY V18.ObjectID ORDER BY V18.GroupID, V18.ObjectID, V18.VoucherDate, V18.VoucherNo) AS GroupRowNum,
							'
						END 

						SET @sqlSelect = @sqlSelect + '
							GroupID,BatchID, 
							' + CASE WHEN @CustomerName = 90 THEN 'TransactionID' ELSE '''''' END +' AS TransactionID,
							VoucherID,TableID, Status,DivisionID,TranMonth,TranYear,RPTransactionType,TransactionTypeID,
							ObjectID,ObjectName, (SELECT TOP 1 Note FROM AT1202 WHERE DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND ObjectID = V18.ObjectID) Note,Address,VATNo,Contactor,S1,S2,S3,Tel,Fax,Email,O01ID,O02ID,O03ID,O04ID,O05ID,DebitAccountID,CreditAccountID,
							AccountID,AccountName, (SELECT TOP 1 AccountNameE FROM AT1005 WHERE DivisionID = V18.DivisionID AND AccountID = V18.AccountID) AccountNameE,
							VoucherTypeID,VoucherNo,VoucherDate,InvoiceNo,InvoiceDate, Serial,VDescription,BDescription,TDescription,
							Ana01ID,Ana02ID,Ana03ID,Ana04ID,Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,
							Ana01Name,Ana02Name,Ana03Name,Ana04Name,Ana05Name,Ana06Name,Ana07Name,Ana08Name,Ana09Name,Ana10Name,CurrencyID,ExchangeRate, 
							'+ CASE WHEN @CustomerName = 130 
							THEN 'isnull(DebitOriginalAmount, 0) AS DebitOriginalAmount,isnull(CreditOriginalAmount, 0) AS CreditOriginalAmount,isnull(DebitConvertedAmount, 0) AS DebitConvertedAmount, isnull(CreditConvertedAmount, 0) AS CreditConvertedAmount, SUM(isnull(OpeningOriginalAmount, 0)) AS OpeningOriginalAmount,SUM(isnull(OpeningConvertedAmount, 0)) AS OpeningConvertedAmount, isnull(SignConvertedAmount, 0) AS SignConvertedAmount,isnull(SignOriginalAmount, 0) AS SignOriginalAmount,' 
							ELSE 'SUM(isnull(DebitOriginalAmount, 0)) AS DebitOriginalAmount,SUM(isnull(CreditOriginalAmount, 0)) AS CreditOriginalAmount, SUM(isnull(DebitConvertedAmount, 0)) AS DebitConvertedAmount, SUM(isnull(CreditConvertedAmount, 0)) AS CreditConvertedAmount,isnull(OpeningOriginalAmount, 0) AS OpeningOriginalAmount, isnull(OpeningConvertedAmount, 0) AS OpeningConvertedAmount, SUM(isnull(SignConvertedAmount, 0)) AS SignConvertedAmount, SUM(isnull(SignOriginalAmount, 0)) AS SignOriginalAmount,' END +'
							ClosingOriginalAmount,ClosingConvertedAmount,
							CAST (TranMonth AS nvarchar)  + ''/'' + CAST (TranYear AS nvarchar) AS MonthYear,
							convert (varchar(20), Duedate,103) AS duedate,
							''' + convert(varchar(10), @FromDate, 103) + ''' AS Fromdate,
							(case when' + str(@TypeD) + '= 4 then ''30/' + Ltrim (str(@ToMonth)) 
							+ '/'+ltrim(str(@ToYear)) + ''' ELSE ''' + convert(varchar(10), @ToDate, 103) + ''' end) AS Todate,
							Parameter01,Parameter02,Parameter03,Parameter04,Parameter05,Parameter06,Parameter07,Parameter08,Parameter09,Parameter10,Amount01Ana04ID '
						SET @sqlFrom = ' 
						FROM AV7418 V18 WITH (NOLOCK)				
						'
						SET @sqlWhere = ' 
						WHERE	DebitOriginalAmount <> 0 OR CreditOriginalAmount <> 0 OR DebitConvertedAmount <> 0 
								OR CreditConvertedAmount <> 0 OR OpeningOriginalAmount <> 0 OR OpeningConvertedAmount <> 0  '
						SET @sqlGroupBy = ' 
						GROUP BY GroupID, BatchID,
								' + CASE WHEN @CustomerName = 90 THEN 'TransactionID,' ELSE '' END +'
								VoucherID, TableID, Status, DivisionID, TranMonth, TranYear, RPTransactionType, TransactionTypeID, 
								ObjectID, ObjectName,Note, Address, VATNo,Contactor,S1,S2, S3, Tel, Fax, Email,O01ID, O02ID, O03ID, O04ID, O05ID,
								DebitAccountID, CreditAccountID, AccountID, 
								VoucherTypeID, VoucherNo, VoucherDate,
								'+ CASE WHEN @CustomerName = 130 then 'DebitOriginalAmount,DebitConvertedAmount,CreditOriginalAmount,CreditConvertedAmount,SignConvertedAmount,SignOriginalAmount,' ELSE 'OpeningOriginalAmount,OpeningConvertedAmount,' END +'
								InvoiceNo, InvoiceDate, Serial, VDescription, BDescription, TDescription, 
								Ana01ID,Ana02ID,Ana03ID,Ana04ID,Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,
								CurrencyID, ExchangeRate, ObjectName, AccountName, ClosingOriginalAmount, ClosingConvertedAmount,Duedate,
								Ana01Name,Ana02Name,Ana03Name,Ana04Name,Ana05Name,Ana06Name,Ana07Name,Ana08Name,Ana09Name,Ana10Name,
								Parameter01,Parameter02,Parameter03,Parameter04,Parameter05,Parameter06,Parameter07,Parameter08,Parameter09,Parameter10,Amount01Ana04ID
						'
     
						--Co ma phan tich
						IF @CustomerName = 16 --(Customized KH SIEU THANH)
							SET @sqlSelect1 = ' SELECT 1 as DB, '
						ELSE
							SET @sqlSelect1 =' SELECT  '
 

						SET @sqlSelect1 = @sqlSelect1 + '
							GroupID,BatchID,
							' + CASE WHEN @CustomerName = 90 THEN 'TransactionID' ELSE '''''' END +' AS TransactionID,
							VoucherID,TableID, Status,AV7428.DivisionID,TranMonth,TranYear,RPTransactionType,TransactionTypeID,
							AV7428.ObjectID,ObjectName, (SELECT TOP 1 Note FROM AT1202 WHERE DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND ObjectID = AV7428.ObjectID) Note,Address,VATNo,Contactor,S1,S2,S3,Tel,Fax,Email,O01ID,O02ID,O03ID,O04ID,O05ID,DebitAccountID,	CreditAccountID,
							AV7428.AccountID, AccountName, (SELECT TOP 1 AccountNameE FROM AT1005 WHERE DivisionID = AV7428.DivisionID AND AccountID = AV7428.AccountID) AccountNameE,
							VoucherTypeID,VoucherNo,VoucherDate,InvoiceNo,InvoiceDate, Serial,VDescription,BDescription,TDescription,
							AV7428.Ana01ID,AV7428.Ana02ID,AV7428.Ana03ID,AV7428.Ana04ID,AV7428.Ana05ID,AV7428.Ana06ID,AV7428.Ana07ID,AV7428.Ana08ID,AV7428.Ana09ID,AV7428.Ana10ID,
							A11.AnaName AS Ana01Name,CurrencyID,ExchangeRate, 
							Sum(isnull(DebitOriginalAmount, 0)) AS DebitOriginalAmount,Sum(isnull(CreditOriginalAmount, 0)) AS CreditOriginalAmount,
							Sum(isnull(DebitConvertedAmount, 0)) AS DebitConvertedAmount,Sum(isnull(CreditConvertedAmount, 0)) AS CreditConvertedAmount,
							OpeningOriginalAmount,OpeningConvertedAmount,OpeningOriginalAmountAna01ID,OpeningConvertedAmountAna01ID,
							sum(isnull(SignConvertedAmount,0)) AS SignConvertedAmount,sum(isnull(SignOriginalAmount,0)) AS SignOriginalAmount,
							ClosingOriginalAmount,ClosingConvertedAmount,
							CAST(TranMonth AS nvarchar) + ''/'' + CAST(TranYear AS nvarchar) AS MonthYear '
						SET @sqlFrom1 = ' 
						FROM AV7428	WITH (NOLOCK)
						LEFT JOIN AT1011 A11 WITH (NOLOCK) on A11.AnaID=AV7428.Ana01ID And A11.AnaTypeID = ''A01''						
						'

						SET @sqlWhere1 = ' 
						WHERE DebitOriginalAmount <> 0 OR CreditOriginalAmount <> 0 
							OR DebitConvertedAmount <> 0 OR CreditConvertedAmount <> 0 
							OR OpeningOriginalAmount <> 0 OR OpeningConvertedAmount <> 0 '
						SET @sqlGroupBy1 = ' 
						GROUP BY GroupID, BatchID,
							' + CASE WHEN @CustomerName = 90 THEN 'TransactionID,' ELSE '' END +'
							VoucherID, TableID, Status, AV7428.DivisionID, TranMonth, TranYear, RPTransactionType, TransactionTypeID, AV7428.ObjectID, 
							Address, VATNo,Contactor,S1,S2, S3, Tel, Fax, Email,O01ID, O02ID, O03ID, O04ID, O05ID,DebitAccountID, CreditAccountID, AV7428.AccountID, 
							VoucherTypeID, VoucherNo, VoucherDate, OpeningOriginalAmount, 
							OpeningConvertedAmount, OpeningOriginalAmountAna01ID, OpeningConvertedAmountAna01ID,
							InvoiceNo, InvoiceDate, Serial, VDescription, BDescription, TDescription, 
							AV7428.Ana01ID,AV7428.Ana02ID,AV7428.Ana03ID,AV7428.Ana04ID,AV7428.Ana05ID,AV7428.Ana06ID,AV7428.Ana07ID,AV7428.Ana08ID,AV7428.Ana09ID,AV7428.Ana10ID,
							A11.AnaName, CurrencyID, ExchangeRate, ObjectName, Note, ObjectName, AccountName, ClosingOriginalAmount, ClosingConvertedAmount
						'

     
							IF @CustomerName = 16  AND @DatabaseName <>'' --- Customize Sieu Thanh in du lieu 2 database
								BEGIN
									EXEC AP7408_ST  @DivisionID, @FromMonth, @FromYear, @ToMonth, @ToYear,@TypeD, @FromDate, @ToDate,@CurrencyID,@FromAccountID,@ToAccountID, @FromObjectID, @ToObjectID,@SqlFind,@DatabaseName 
									SET @sSQLUnion = '
									UNION ALL
										SELECT 2 as DB, GroupID,BatchID,
										' + CASE WHEN @CustomerName = 90 THEN 'TransactionID' ELSE '''''' END +' AS TransactionID,
										VoucherID,TableID, Status,DivisionID,TranMonth,TranYear,RPTransactionType,TransactionTypeID,
										ObjectID,ObjectName, (SELECT TOP 1 Note FROM AT1202 WHERE DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND ObjectID = AV7428_ST.ObjectID) Note,Address,VATNo,Contactor,S1,S2,S3,Tel,Fax,Email,O01ID,O02ID,O03ID,O04ID,O05ID,DebitAccountID,CreditAccountID,
										AccountID,AccountName,(SELECT TOP 1 AccountNameE FROM AT1005 WHERE DivisionID = AV7408_ST.DivisionID AND AccountID = AV7408_ST.AccountID) AccountNameE,VoucherTypeID,VoucherNo,VoucherDate,InvoiceNo,InvoiceDate, Serial,VDescription,BDescription,TDescription,
										Ana01ID,Ana02ID,Ana03ID,Ana04ID,Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,
										Ana01Name, Ana02Name,Ana03Name,Ana04Name,Ana05Name,Ana06Name,Ana07Name,Ana08Name,Ana09Name,Ana10Name,
										CurrencyID,ExchangeRate, 
										DebitOriginalAmount, CreditOriginalAmount,
										DebitConvertedAmount, CreditConvertedAmount,
										OpeningOriginalAmount,	OpeningConvertedAmount,
										SignConvertedAmount,  SignOriginalAmount,
										ClosingOriginalAmount,ClosingConvertedAmount,
										MonthYear,duedate,Fromdate,Todate ,
										'''' AS Parameter01, '''' AS Parameter02, '''' AS Parameter03, '''' AS Parameter04, '''' AS Parameter05,
										'''' AS Parameter06, '''' AS Parameter07, '''' AS Parameter08, '''' AS Parameter09, '''' AS Parameter10, 0 AS Amount01Ana04ID
										FROM AV7408_ST '
				
				
									SET @sSQLUnion1 = '
									UNION ALL
										SELECT 2 as DB, GroupID,BatchID,
										' + CASE WHEN @CustomerName = 90 THEN 'TransactionID' ELSE '''''' END +' AS TransactionID,
										VoucherID,TableID, Status,DivisionID,TranMonth,TranYear,RPTransactionType,TransactionTypeID,
										ObjectID,ObjectName, (SELECT TOP 1 Note FROM AT1202 WHERE DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND ObjectID = AV7429_ST.ObjectID) Note,Address,VATNo,Contactor,S1,S2,S3,Tel,Fax,Email,O01ID,O02ID,O03ID,O04ID,O05ID,DebitAccountID,CreditAccountID,
										AccountID,AccountName, (SELECT TOP 1 AccountNameE FROM AT1005 WHERE DivisionID = AV7429_ST.DivisionID AND AccountID = AV7429_ST.AccountID) AccountNameE,
										VoucherTypeID,VoucherNo,VoucherDate,InvoiceNo,InvoiceDate, Serial,VDescription,BDescription,TDescription,
										Ana01ID,Ana02ID,Ana03ID,Ana04ID,Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,Ana01Name,CurrencyID,ExchangeRate, 
										DebitOriginalAmount, CreditOriginalAmount,
										DebitConvertedAmount, CreditConvertedAmount,
										OpeningOriginalAmount,OpeningConvertedAmount,OpeningOriginalAmountAna01ID,OpeningConvertedAmountAna01ID,
										SignConvertedAmount, SignOriginalAmount,ClosingOriginalAmount,ClosingConvertedAmount,MonthYear 
										FROM AV7429_ST '
					
										---view temp AV7408a khong co ma phan tich
										IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7408a]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
											 EXEC ('  CREATE VIEW AV7408a --Created by AP7408
											 AS '  + @sqlSelect + @sqlFrom + @sqlWhere + @sqlGroupBy +  @sSQLUnion )
										ELSE
											 EXEC ('  ALTER VIEW AV7408a  --Created by AP7408
											 AS ' + @sqlSelect + @sqlFrom + @sqlWhere + @sqlGroupBy + @sSQLUnion)	
					 
										--view temp AV7429a Co ma phan tich			
										IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7429a]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
											EXEC ('  CREATE VIEW AV7429a --Created by AP7408
											AS ' + @sqlSelect1 + @sqlFrom1 + @sqlWhere1 + @sqlGroupBy1 + @sSQLUnion1)
										ELSE
											EXEC ('  ALTER VIEW AV7429a  --Created by AP7408
											AS ' + @sqlSelect1 + @sqlFrom1 + @sqlWhere1 + @sqlGroupBy1 + @sSQLUnion1)
						

						
								--PRINT @sqlSelect
								--PRINT @sqlFrom
								--PRINT @sqlWhere
								--PRINT @sqlGroupBy
								--PRINT @sSQLUnion
								--PRINT '-- @sqlSelect1'+ @sqlSelect1
								--PRINT '-- @sqlFrom1'+@sqlFrom1
								--PRINT '-- @sqlWhere'+@sqlWhere
								--PRINT '-- @sqlGroupBy1'+@sqlGroupBy1
								--PRINT '-- @sSQLUnion1'+@sSQLUnion1

						
										SET @sqlSelect = '
											SELECT  DB, AV7408a.GroupID,BatchID,
											' + CASE WHEN @CustomerName = 90 THEN 'TransactionID' ELSE '''''' END +' AS TransactionID,
											VoucherID,TableID, Status,DivisionID,TranMonth,TranYear,RPTransactionType,TransactionTypeID,
											ObjectID,ObjectName,Note,Address,VATNo,Contactor,S1,S2,S3,Tel,Fax,Email,O01ID,O02ID,O03ID,O04ID,O05ID,DebitAccountID,CreditAccountID,
											AccountID,AccountName,VoucherTypeID,VoucherNo,VoucherDate,InvoiceNo,InvoiceDate, Serial,VDescription,BDescription,TDescription,
											Ana01ID,Ana02ID,Ana03ID,Ana04ID,Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,CurrencyID,ExchangeRate, 
											DebitOriginalAmount, CreditOriginalAmount,
											DebitConvertedAmount, CreditConvertedAmount,
											--OpeningOriginalAmount,	OpeningConvertedAmount,
											SignConvertedAmount,  SignOriginalAmount,
											ClosingOriginalAmount,ClosingConvertedAmount,
											MonthYear,duedate,Fromdate,Todate ,
											(T08.OpeningOriginalAmount +  T09.OpeningOriginalAmount )  as  OpeningOriginalAmount,
											(T08.OpeningConvertedAmount +  T09.OpeningConvertedAmount )  as  OpeningConvertedAmount 
											FROM AV7408a WITH (NOLOCK)
											Left Join (Select Distinct  GroupID, OpeningOriginalAmount,OpeningConvertedAmount  From AV7408a Where DB =1 ) T08 On AV7408a.GroupID = T08.GroupID  
											Left Join (Select Distinct  GroupID , OpeningOriginalAmount,OpeningConvertedAmount  From AV7408a Where DB =2 ) T09 On AV7408a.GroupID = T09.GroupID 
											'
				
				
										SET @sqlSelect1='
										SELECT  DB, AV7429a.GroupID,BatchID,
										' + CASE WHEN @CustomerName = 90 THEN 'TransactionID' ELSE '''''' END +' AS TransactionID,
										VoucherID,TableID, Status,DivisionID,TranMonth,TranYear,RPTransactionType,TransactionTypeID,
										ObjectID,ObjectName,Note,Address,VATNo,Contactor,S1,S2,S3,Tel,Fax,Email,O01ID,O02ID,O03ID,O04ID,O05ID,DebitAccountID,CreditAccountID,
										AccountID,AccountName,VoucherTypeID,VoucherNo,VoucherDate,InvoiceNo,InvoiceDate, Serial,VDescription,BDescription,TDescription,
										Ana01ID,Ana02ID,Ana03ID,Ana04ID,Ana05ID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,Ana01Name,CurrencyID,ExchangeRate, 
										DebitOriginalAmount, CreditOriginalAmount,
										DebitConvertedAmount, CreditConvertedAmount,
										--OpeningOriginalAmount,OpeningConvertedAmount,
										OpeningOriginalAmountAna01ID,OpeningConvertedAmountAna01ID,
										SignConvertedAmount, SignOriginalAmount,ClosingOriginalAmount,ClosingConvertedAmount,MonthYear ,
										(T08.OpeningOriginalAmount +  T09.OpeningOriginalAmount )  as  OpeningOriginalAmount,
										(T08.OpeningConvertedAmount +  T09.OpeningConvertedAmount )  as  OpeningConvertedAmount 
										FROM AV7429a
										Left Join (Select Distinct  GroupID, OpeningOriginalAmount,OpeningConvertedAmount  From AV7429a Where DB =1 ) T08 On AV7429a.GroupID = T08.GroupID  
										left Join (Select Distinct  GroupID , OpeningOriginalAmount,OpeningConvertedAmount  From AV7429a Where DB =2 ) T09 On AV7429a.GroupID = T09.GroupID 
											'	
					
										print 	@sqlSelect
										print 	@sqlSelect1
										--Khong co ma phan tich		
										IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7408]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
											 EXEC ('  CREATE VIEW AV7408 --Created by AP7408
											 AS '  + @sqlSelect )
										ELSE
											 EXEC ('  ALTER VIEW AV7408  --Created by AP7408
											 AS ' + @sqlSelect )	
					 	
				
										--Co ma phan tich			
										IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7429]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
											EXEC ('  CREATE VIEW AV7429 --Created by AP7408
											AS ' + @sqlSelect1 )
										ELSE
											EXEC ('  ALTER VIEW AV7429  --Created by AP7408
											AS ' + @sqlSelect1 )	
								END
		
							ELSE 
							BEGIN
	
								--PRINT '-- @sqlSelect'+ @sqlSelect
								--PRINT '-- @sqlFrom'+@sqlFrom
								--PRINT '-- @sqlWhere'+@sqlWhere
								--PRINT '-- @sqlGroupBy'+@sqlGroupBy
								--PRINT '-- @sSQLUnion'+@sSQLUnion

									--Khong co ma phan tich		
									IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7408]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
										 EXEC ('  CREATE VIEW AV7408 --Created by AP7408
										 AS '  + @sqlSelect + @sqlFrom + @sqlWhere + @sqlGroupBy +  @sSQLUnion )
									ELSE
										 EXEC ('  ALTER VIEW AV7408  --Created by AP7408
										 AS ' + @sqlSelect + @sqlFrom + @sqlWhere + @sqlGroupBy + @sSQLUnion)		
					 
									--Co ma phan tich			
									IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7429]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
										EXEC ('  CREATE VIEW AV7429 --Created by AP7408
										AS ' + @sqlSelect1 + @sqlFrom1 + @sqlWhere1 + @sqlGroupBy1 + @sSQLUnion1)
									ELSE
										EXEC ('  ALTER VIEW AV7429  --Created by AP7408
										AS ' + @sqlSelect1 + @sqlFrom1 + @sqlWhere1 + @sqlGroupBy1 + @sSQLUnion1)
								END	
	
		End

		--print @sqlSelect
		--print @sqlFrom
		--print @sqlWhere
		--print @sqlGroupBy
		--print @sSQLUnion








GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
