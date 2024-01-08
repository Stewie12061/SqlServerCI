IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7405]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP7405]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- In chi tiet no phai thu
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 27/08/2003 by Nguyen Van Nhan
----
----- Edited by Nguyen Thi Ngoc Minh, Date 27/04/2004
----- Purpose: Cho phep chon loai ngay len bao cao theo ngay  va theo ky
----- Last Edited by Van Nhan, Date 15/09/2004
----- Last Edited by Quoc Huy, Date 26/07/2006
----- Last Edited by Thuy Tuyen, Date 24/08/2007 -- Lay Ten Tai Khoan
----- Edited by Dang Le Bao Quynh, Date 04/07/2008
----- Purpose: Bo sung view phuc in chi tiet phai thu theo ma phan tich
---- Modified on 13/01/2011 by Le Thi Thu Hien : Sua in theo ngay
---- Modified on 15/03/2012 by Le Thi Thu Hien : B? sung tr??ng h?p in không có phát sinh thì không lên ??u k?
---- Modified on 25/10/2012 by Bao Anh : B? sung TableID, Status
---- Modified on 05/03/2013 by Khanh Van : In tu tai khoan den tai khoan cho Sieu Thanh
---- Modified on 27/05/2013 by Lê Th? Thu Hi?n : B? sung thêm Ana06ID --> Ana10ID
---- Modified by on 15/10/2014 by Hu?nh T?n Phú : B? sung ?i?u ki?n l?c theo 10 mã phân tích. 0022751: [VG] In s? d? ??u k? lên sai d?n ??n s? d? cu?i k? sai. 
---- Modified by on 31/10/2014 by Mai Duyen : Sua loi khong in duoc bao cao
---- Modified on 12/11/2014 by Mai Duyen : B? sung thêm DatabaseName (tinh n?ng In báo cao chi tiet no phai thu 2 Database, KH SIEUTHANH)
---- Modified on 05/12/2014 by Mai Duyen : Bo sung field DB (Customized bao cao 2 DB cho SIEU THANH)
---- Modified on 08/12/2014 by Mai Duyen : Fix sum  so du dau cua 2 DB
---- Modified on 30/12/2014 by Mai Duyen : Sua lai dieu kien ket du lieu cua view AV7405a
---- Modified on 06/04/2015 by Thanh Sơn: Bổ sung trường AccountNameE
---- Modified on 10/09/2015 by Tiểu Mai: Bổ sung tên 10 MPT, 10 tham số
---- Modified on 07/04/2016 by Hoàng Vũ: Bổ sung Điều kiện lọc nhiều DivisionIDvới biến truyền vào @StrDivisionID (CuatomizeIndex = 51 hoàng trần)
---- Modified on 10/05/2016 by Hoàng Vũ: Gọi Store AP7404_HT, AP7414_HT và AP7405_HT để load số dư và số phát sinh không phân theo DivisionID (CuatomizeIndex = 51 hoàng trần)
---- Modified on 07/10/2016 by Phương Thảo: Sửa lỗi bị double dòng nếu lọc theo mã phân tích
---- Modified by Hải Long on 18/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Phương Thảo on 19/06/2017: Fix lỗi union không khớp trường
---- Modified by Bảo Thy on 11/07/2017: Fix lỗi thiếu chuỗi Group By khi exec AV7405
---- Modified by Bảo Anh on 13/04/2018: Bổ sung OrderNo
---- Modified by Kim Thư on 14/11/2018: CustomizeIndex=69 - Mạnh Phương, Phiếu bán hàng ko có thành tiền (hàng tặng) và định khoản 131 vẫn được lên báo cáo.
---- Modified on 14/01/2019 by Kim Thư: Bổ sung WITH (NOLOCK) 
---- Modified on 07/05/2019 by Kim Thư: Sửa store trả thẳng dữ liệu, không trả ra view (cải thiện tốc độ)
---- Modified on 29/05/2019 by Kim Thư: Không đưa điều kiện lọc vào AP7414 do store ko có cột VoucherNo (cột này có trong điều kiện lọc)
---- Modified on 25/06/2019 by Kim Thư: Bổ sung sắp xếp theo Đối tượng, ngày chứng từ
---- Modified by Kim Thư on 27/06/2019: Lấy BDescription theo đúng diễn giải hóa đơn, ko theo công thức (CustomizeIndex = 109 - Trong Suốt, Seaborne, SCE, JCL - Song Bình)
---- Modified by Kim Thư on 9/7/2019: Bổ sung Order by  AV7415.GroupID, AV7415.ObjectID, AV7415.VoucherDate, AV7415.VoucherNo
---- Modified by Văn Tài on 30/07/2019: Bổ sung lấy OriginalDecimals - format số thập phân
---- Modified by Văn Minh on 24/12/2019: Bổ sung thêm Variable tránh trường hợp quá ký tự cho phép của variable - Bổ sung thêm trường GiveOriginalAmount - GiveOriginalAmountCN
---- Modified by Huỳnh Thử on 19/01/2020: Check điệu kiện where Null.
---- Modified by Văn Minh on 20/02/2020: Bổ sung lọc thời gian AT0303
---- Modified by Văn Minh on 10/04/2020: [SONG BINH] Thay DueDate = OrderDate 
---- Modified by Cường Thịnh  on 15/05/2020: Bổ sung lấy At1202.Contactor.
---- Modified by Huỳnh Thử  on 20/05/2020: Group by ObjectID, AccountID
---- Modified by Huỳnh Thử  on 22/05/2020: Set Parameter = ''
---- Modified by Huỳnh Thử  on 26/05/2020:Đưa Group by ObjectID, AccountID vào Customer SongBinh
---- Modified by Huỳnh Thử  on 10/06/2020:Đưa Group by CreditObjectID vào Customer SongBinh
---- Modified on 07/04/2021 by Huỳnh Thử : Tách Store [TienTien] -- Bổ sung xuất execl nhiều Division
---- Modified on 23/04/2021 by Hoài Phong : PL- Nếu Đầu kỳ có dữ liệu mà trong kỳ không có phát sinh , thì nó sẽ k lấy đc dữ liệu
---- Modified by Huỳnh Thử on 04/05/2021: Bổ sung cột ContactPerson
---- Modified by Huỳnh Thử on 16/07/2021: GiveOriginalAmount và GiveOriginalAmountCN sẽ lấy sai khi hóa đơn bán hàng có xuất kho: ngày của phiếu xuất kho và ngày của hóa đơn bán hàng khác nhau sẽ bị tách dòng
---- Modified by Nhựt Trường on 02/11/2021: Bổ sung thêm điều kiện mã phân tích khi JOIN AV7414.
---- Modified by Nhật Thanh on 02/11/2021: xóa điều kiện mã phân tích khi JOIN AV7414 vì in báo cáo bị lỗi
---- Modified by Nhật Thanh on 22/03/2022: Bổ sung cột RDescription
---- Modified by Thành Sang on 21/09/2022: Bổ sung thêm điều kiện DivisionID khi join các bảng dùng chung.
---- Modified by Thanh Lượng on 07/21/2022: [2022/12/IS/0029] - Bổ sung thêm điều kiện ISNULL và Group by fix lỗi DivisionID NULL ở bảng tạm #AV7415
---- Modified by Kiều Nga on 09/01/2023:	[2023/01/IS/0034] - Fix lỗi không hiển thị tên mã phân tích
---- Modified by Nhựt Trường on 13/01/2023: [2023/01/IS/0085] - Điều chỉnh lại cách group DivisionID.
---- Modified by Kiều Nga on 17/03/2023:	[2023/03/IS/0048][2023/03/IS/0047] - Bổ lấy thêm trường OpeningOriginalAmountAna01ID, OpeningConvertedAmountAna01ID
---- Modified by Xuân Nguyên on 08/04/2023: [2023/04/IS/0211] - Tách store Thiên Nam
---- Modified by Xuân Nguyên on 01/06/2023: [2023/05/IS/0053] - Bồ sung with(nolock) khi join AT9000
---- Modified by Văn Tài	 on 02/06/2023: [2023/05/IS/0153] - Hỗ trợ bổ sung cột GroupRowNum để đánh STT theo từng dòng Group.
---- Modified by Nhựt Trường on 24/07/2023: [2023/05/IS/0053] - Cải tiến tốc độ load dữ liệu.
---- Modified by Nhựt Trường on 20/11/2023: Customize Song Bình, fix lỗi chưa khớp số liệu do có đặc thù debit note (không load các phiếu có loại 'T22', 'T99').
-- <Example>
---- 

CREATE PROCEDURE [dbo].[AP7405]
				 	@DivisionID AS nvarchar(50) ,
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
					@SqlFind AS NVARCHAR(500),
					@DatabaseName as varchar(250)='',
					@StrDivisionID AS NVARCHAR(4000),
					@ReportDate AS DATETIME = NULL
 AS
 SET NOCOUNT OFF 
DECLARE @sSQL AS nvarchar(MAX)='',
		@sSQL_1 AS nvarchar(MAX)='',
		@sSQL1 AS nvarchar(MAX)='',
		@sSQL2 AS nvarchar(MAX)='',
		@sSQL3 AS nvarchar(MAX)='',
		@sSQL4 AS nvarchar(MAX)='',
		@sSQLUnionAll AS nvarchar(MAX),
		@SQLwhere AS nvarchar(MAX) = '',
		@SQLwhereAna AS nvarchar(MAX) = '',
		@sSQLwhere2 AS nvarchar(MAX) = '',
		@TypeDate AS nvarchar(20)='',
		@SQLObject AS nvarchar(MAX)='',
		@sSQLGroupBy AS nvarchar(MAX)='',
		@FromPeriod AS int,
		@ToPeriod AS int,
		@sSQLWhere3 nvarchar(MAX)='',
		@sSQLCustomize AS NVARCHAR(MAX)='',
		@sSQLWhere4 AS nvarchar(MAX) = '',
		@sSQLWhereDateTime AS nvarchar(MAX) = ''

		Declare @CustomerName INT
		--Tao bang tam de kiem tra day co phai la khach hang Sieu Thanh khong (CustomerName = 16)
		CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
		INSERT #CustomerName EXEC AP4444
		SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

IF @CustomerName = 110 -- SONG BÌNH
BEGIN
	SET @sSQLCustomize = '					
					, (CASE WHEN TransactionTypeID = ''T00'' THEN 0 ELSE SUM(CASE WHEN RPTransactionType = ''00'' THEN ISNULL(OriginalAmount, 0) ELSE 0 END) END) AS DebitOriginalAmount
					, (CASE WHEN TransactionTypeID = ''T00'' THEN 0 ELSE SUM(CASE WHEN RPTransactionType = ''01'' THEN ISNULL(OriginalAmount, 0) ELSE 0 END) END) AS CreditOriginalAmount
					, (CASE WHEN TransactionTypeID = ''T00'' THEN 0 ELSE SUM(CASE WHEN RPTransactionType = ''00'' THEN ISNULL(ConvertedAmount, 0) ELSE 0 END) END) AS DebitConvertedAmount
					, (CASE WHEN TransactionTypeID = ''T00'' THEN 0 ELSE SUM(CASE WHEN RPTransactionType = ''01'' THEN ISNULL(ConvertedAmount, 0) ELSE 0 END) END) AS CreditConvertedAmount
	'
	IF @TypeD = 4
		SET @sSQLWhere4 = @sSQLWhere4 + 'AND (MONTH(AT0303.CreditVoucherDate) + 100 * YEAR(AT0303.CreditVoucherDate) BETWEEN 
		' + CONVERT(NVARCHAR(5),@FromMonth) + ' + 100 *'+CONVERT(NVARCHAR(10),@FromYear)+' AND '+ CONVERT(NVARCHAR(5),@ToMonth) + ' + 100 * '+CONVERT(NVARCHAR(10),@ToYear)+')' 
	ELSE
		SET @sSQLWhere4 = @sSQLWhere4+ '
			AND AT0303.CreditVoucherDate BETWEEN '''+ CONVERT(NVARCHAR(30),@FromDate,101) +''' AND ''' + CONVERT(NVARCHAR(30),@ToDate,101)+'''
		'
END
ELSE
BEGIN
	SET @sSQLCustomize = '					
					, SUM(CASE WHEN RPTransactionType = ''00'' THEN ISNULL(OriginalAmount, 0) ELSE 0 END) AS DebitOriginalAmount
					, SUM(CASE WHEN RPTransactionType = ''01'' THEN ISNULL(OriginalAmount, 0) ELSE 0 END) AS CreditOriginalAmount
					, SUM(CASE WHEN RPTransactionType = ''00'' THEN ISNULL(ConvertedAmount, 0) ELSE 0 END) AS DebitConvertedAmount
					, SUM(CASE WHEN RPTransactionType = ''01'' THEN ISNULL(ConvertedAmount, 0) ELSE 0 END) AS CreditConvertedAmount
	'
END
--PRINT @sSQLWhere4

IF @CustomerName = 51 --Customize hoàng trần
Begin
	EXEC AP7405_HT @DivisionID, @FromMonth, @FromYear, @ToMonth, @ToYear, @TypeD, @FromDate,  @ToDate, 
	@CurrencyID, @FromAccountID,@ToAccountID, @FromObjectID, @ToObjectID, @SqlFind, @DatabaseName, @StrDivisionID
END
ELSE
IF @CustomerName = 13 --Customize Tiên Tiến
BEGIN
    EXEC AP7405_TIENTIEN @DivisionID, @FromMonth, @FromYear, @ToMonth, @ToYear, @TypeD, @FromDate,  @ToDate, 
	@CurrencyID, @FromAccountID,@ToAccountID, @FromObjectID, @ToObjectID, @SqlFind, @DatabaseName, @StrDivisionID, @ReportDate
END
Else if @CustomerName= 92
begin
	EXEC AP7405_TN @DivisionID, @FromMonth, @FromYear, @ToMonth, @ToYear, @TypeD, @FromDate,  @ToDate, 
	@CurrencyID, @FromAccountID,@ToAccountID, @FromObjectID, @ToObjectID,@SqlFind,@DatabaseName ,@StrDivisionID ,@ReportDate 
end

Else
Begin	

		IF @TypeD = 1   --- Ngay HT
			BEGIN
			SET @TypeDate ='InvoiceDate'
			SET @sSQLWhere3 = 'InvoiceDate BETWEEN ''' + CONVERT(VARCHAR(10), @FromDate, 101) + ''' AND ''' + CONVERT(VARCHAR(10), @ToDate, 101) + ''''
			END
		ELSE IF @TypeD=2  --- Ngay HD
			BEGIN
			SET @TypeDate = 'VoucherDate'
			SET @sSQLWhere3 = 'VoucherDate BETWEEN ''' + CONVERT(VARCHAR(10), @FromDate, 101) + ''' AND ''' + CONVERT(VARCHAR(10), @ToDate, 101) + ''''
			END
		ELSE IF @TypeD=3   --Ngay Dao han
			BEGIN
			SET @TypeDate = 'DueDate'
			SET @sSQLWhere3 = 'DueDate BETWEEN ''' + CONVERT(VARCHAR(10), @FromDate, 101) + ''' AND ''' + CONVERT(VARCHAR(10), @ToDate, 101) + ''''
				IF @CustomerName = 110 -- SONG BINH
				BEGIN
					SET @TypeDate = 'OrderDate'
					SET @sSQLWhere3 = 'OrderDate BETWEEN ''' + CONVERT(VARCHAR(10), @FromDate, 101) + ''' AND ''' + CONVERT(VARCHAR(10), @ToDate, 101) + ''''
					SET @sSQLWhereDateTime =  'VoucherDate BETWEEN ''' + CONVERT(VARCHAR(10), @FromDate, 101) + ''' AND ''' + CONVERT(VARCHAR(10), @ToDate, 101) + ''''
				END
			END

		SET @FromPeriod = (@FromMonth + @FromYear * 100)	
		SET @ToPeriod = (@ToMonth + @ToYear * 100)	

		--------------->>>> Chuỗi DivisionID
		DECLARE @StrDivisionID_New AS NVARCHAR(4000)
		DECLARE @StrDivisionID_New1 AS NVARCHAR(4000)

		If @CustomerName = 51 OR @CustomerName = 13--Customize khách hàng Hoàng trần
		begin
			IF isnull(@StrDivisionID, '') = Isnull(@DivisionID, '') 
			BEGIN
				SET @StrDivisionID_New = ' AND AV7404.DivisionID LIKE ''' + @DivisionID + '''' 
				SET @StrDivisionID_New1 = ' AND AV7414.DivisionID LIKE ''' + @DivisionID + '''' 
			END
			ELSE
			BEGIN
				SET @StrDivisionID_New = ' AND AV7404.DivisionID IN (''' + replace(@StrDivisionID, ',',''',''') + ''')'
				SET @StrDivisionID_New1 = ' AND AV7414.DivisionID IN (''' + replace(@StrDivisionID, ',',''',''') + ''')'

			END
		End
		Else
				Set @StrDivisionID_New = ' AND (AV7404.DivisionID LIKE ''' + @DivisionID + ''' OR AV7414.DivisionID LIKE ''' + @DivisionID + ''')' 
		---------------<<<< Chuỗi DivisionID		

		IF @TypeD in (1, 2, 3)   -- Theo ngay
		BEGIN
			SET @SQLwhere = ' AND (CONVERT(DATETIME,CONVERT(varchar(10),D3.' + LTRIM(RTRIM(@TypeDate)) + ',101),101) BETWEEN ''' + CONVERT(VARCHAR(10), @FromDate, 101) + ''' AND ''' + CONVERT(VARCHAR(10), @ToDate, 101) + ''') '
			IF @CustomerName = 110 AND @TypeD = 3 -- song binh
			BEGIN
				SET @SQLwhere = ' AND (ISNULL(CONVERT(DATETIME,CONVERT(varchar(10),OT2001.' + LTRIM(RTRIM(@TypeDate)) + ',101),101),CONVERT(DATETIME,CONVERT(varchar(10),D3.VoucherDate,101),101)) BETWEEN ''' + CONVERT(VARCHAR(10), @FromDate, 101) + ''' AND ''' + CONVERT(VARCHAR(10), @ToDate, 101) + ''') '
			END
		END
		ELSE    ---Theo ky
		BEGIN
			SET @SQLwhere = ' AND (D3.TranMonth + 100 * D3.TranYear BETWEEN ' + STR(@FromPeriod) + ' AND '+ STR(@ToPeriod) + ')'
		END
	
		------ Loc ra cac phan tu
		EXEC AP7404  @DivisionID, @CurrencyID, @FromAccountID, @ToAccountID, @FromObjectID, @ToObjectID, @SQLwhere, @StrDivisionID
			--PRINT @DivisionID 
			--PRINT @CurrencyID
			--PRINT @FromAccountID
			--PRINT @ToAccountID
			--PRINT @FromObjectID
			--PRINT @ToObjectID
			--PRINT @SQLwhere
			--PRINT @StrDivisionID
		------- Xac dinh so du co cac doi tuong
		EXEC AP7414 @DivisionID, @FromObjectID, @ToObjectID, @FromAccountID, @ToAccountID, @CurrencyID, @FromPeriod,  @FromDate, @TypeD, @TypeDate,'1=1', @StrDivisionID

		IF @TypeD = 4 ---  Tinh tu ky den ky	
			  BEGIN	
	
				SET @SQLwhere = '
					WHERE (ISNULL(AV7404.ObjectID, AV7414.ObjectID) BETWEEN ''' + @FromObjectID + ''' AND ''' + @ToObjectID + ''') 
					 '+ @StrDivisionID_New + ' AND (ISNULL(AV7404.AccountID, AV7414.AccountID) BETWEEN ''' + @FromAccountID+ ''' AND ''' + @ToAccountID + ''')'
				SET @SQLwhereAna ='
					WHERE (ISNULL(AV7404.ObjectID, AV7424.ObjectID) BETWEEN ''' + @FromObjectID + ''' AND ''' + @ToObjectID + ''')
					 '+ @StrDivisionID_New + ' AND (ISNULL(AV7404.AccountID, AV7424.AccountID) BETWEEN ''' + @FromAccountID + ''' AND ''' + @ToAccountID + ''')'
				SET @sSQLWhere3 = '(TranMonth + 100 * TranYear BETWEEN ' + STR(@FromPeriod) + ' AND '+ STR(@ToPeriod) + ')'

				IF @CurrencyID <> '%'
					Begin
						SET @SQLwhere = @SQLwhere + ' AND ISNULL(AV7404.CurrencyID, AV7414.CurrencyID) LIKE ''' + @CurrencyID + ''' ' 
						SET @SQLwhereAna = @SQLwhereAna + ' AND  ISNULL(AV7404.CurrencyID, AV7424.CurrencyID) LIKE  ''' + @CurrencyID + ''' ' 
					End
	
			   END
		ELSE    ---- Xac dinh theo Ngay
			  BEGIN
	
				SET @SQLwhere = '
					WHERE (ISNULL(AV7404.ObjectID, AV7414.ObjectID) BETWEEN ''' + @FromObjectID + ''' AND ''' + @ToObjectID + ''')
					 '+ @StrDivisionID_New + '	AND (ISNULL(AV7404.AccountID, AV7414.AccountID) BETWEEN ''' + @FromAccountID + ''' AND ''' + @ToAccountID + ''') '

				SET @SQLwhereAna = '
					WHERE (ISNULL(AV7404.ObjectID, AV7424.ObjectID) between ''' + @FromObjectID + ''' AND ''' + @ToObjectID + ''') 
					 '+ @StrDivisionID_New + '	AND (ISNULL(AV7404.AccountID, AV7424.AccountID) BETWEEN ''' + @FromAccountID + ''' AND ''' + @ToAccountID + ''')'
	
				IF @CurrencyID <> '%'
					Begin
						SET @SQLwhere = @SQLwhere + ' AND ISNULL(AV7404.CurrencyID, AV7414.CurrencyID) LIKE ''' + @CurrencyID + ''' ' 
						SET @SQLwhereAna = @SQLwhereAna + ' AND ISNULL(AV7404.CurrencyID, AV7424.CurrencyID) LIKE ''' + @CurrencyID + ''' ' 
					End
			  END

		IF @CustomerName = 110
		BEGIN
			SET @SQLwhere = @SQLwhere + N' 
						AND AV7404.TransactionTypeID NOT IN (''T22'',''T99'')'
			SET @StrDivisionID_New1 = @StrDivisionID_New1 + N'
						AND AV7414.TransactionTypeID NOT IN (''T22'',''T99'')'
		END

		---In khong co ma phan tich 1
		SET @sSQL = '

		            '+
					CASE WHEN @CustomerName = 110 THEN 
					'
					SELECT DISTINCT VoucherID
						   , VoucherDate
						   , CASE WHEN TransactionTypeID <> ''T99'' OR (TransactionTypeID = ''T99'' AND DebitAccountID BETWEEN '''+ @FromAccountID +''' AND ''' + @ToAccountID +''') THEN ObjectID ELSE NULL END AS ObjectID
						   , CASE WHEN TransactionTypeID = ''T99'' AND CreditAccountID BETWEEN '''+ @FromAccountID +''' AND ''' + @ToAccountID +''' THEN CreditObjectID ELSE ObjectID END AS CreditObjectID 
					INTO #A90
					FROM AT9000 WITH (NOLOCK)
					WHERE '+ CASE WHEN @CustomerName = 110 AND ISNULL(@sSQLWhereDateTime,'') <> '' THEN @sSQLWhereDateTime ELSE @sSQLWhere3 END+'
						  AND (DebitAccountID BETWEEN '''+ @FromAccountID +''' AND ''' + @ToAccountID +''' OR CreditAccountID BETWEEN '''+ @FromAccountID +''' AND ''' + @ToAccountID +''')
					
					SELECT * 
					INTO #DONG
					FROM (
						SELECT SUM(ISNULL(AT0303.OriginalAmount, 0)) AS GiveOriginalAmount
							   , SUM(ISNULL(AT0303.ConvertedAmount, 0)) AS GiveOriginalAmountCN
							   , A.VoucherID 
							   , A.ObjectID AS DebitObjectID 
							   , A.CreditObjectID
							   , AT0303.ObjectID
							   , AT0303.AccountID
						FROM AT0303 WITH (NOLOCK)
						LEFT JOIN #A90 A ON	A.VoucherID = AT0303.CreditVoucherID AND A.CreditObjectID = AT0303.ObjectID
						WHERE AT0303.DivisionID = '''+ @DivisionID +'''  
								AND AT0303.ObjectID >= ''' + @FromObjectID + ''' 
								AND AT0303.ObjectID <= ''' + @ToObjectID + ''' 
								AND AT0303.CurrencyID LIKE ''' + @CurrencyID + '''
								'+@sSQLWhere4+'
						GROUP BY A.VoucherID, A.ObjectID, A.CreditObjectID, AT0303.ObjectID, AT0303.AccountID
						UNION ALL
						SELECT SUM(ISNULL(AT0303.OriginalAmount, 0)) AS GiveOriginalAmount
							   , SUM(ISNULL(AT0303.ConvertedAmount, 0)) AS GiveOriginalAmountCN
							   , A.VoucherID 
							   , A.ObjectID AS DebitObjectID 
							   , A.CreditObjectID
							   , AT0303.ObjectID
							   , AT0303.AccountID
						FROM AT0303 WITH (NOLOCK)
						LEFT JOIN #A90 A ON	A.ObjectID = AT0303.ObjectID AND A.VoucherID = AT0303.DebitVoucherID
						WHERE AT0303.DivisionID = '''+ @DivisionID +'''  
								AND AT0303.ObjectID >= ''' + @FromObjectID + ''' 
								AND AT0303.ObjectID <= ''' + @ToObjectID + ''' 
								AND AT0303.CurrencyID LIKE ''' + @CurrencyID + '''
								'+@sSQLWhere4+'
						GROUP BY A.VoucherID, A.ObjectID, A.CreditObjectID, AT0303.ObjectID, AT0303.AccountID
					) A
					WHERE ISNULL(VoucherID,'''') <> ''''
					' ELSE '' END
					+'

			SELECT AV7404.ContactPerson
					, (ISNULL(AV7404.ObjectID, AV7414.ObjectID) + ISNULL(AV7404.AccountID, AV7414.AccountID)) AS GroupID
					, BatchID
					, AV7404.VoucherID
					, TableID
					, Status
					, ISNULL(AV7404.DivisionID, AV7414.DivisionID) AS DivisionID
					, TranMonth
					, TranYear
					, CAST(ISNULL(AV7404.AccountID, AV7414.AccountID) AS CHAR(20)) 
						+ CAST(ISNULL(AV7404.ObjectID, AV7414.ObjectID) AS CHAR(20)) 
						+ CAST(ISNULL(AV7404.CurrencyID, AV7414.CurrencyID) AS CHAR(20)) 
						+ CAST(DAY(VoucherDate) + MONTH(VoucherDate) * 100 
						+ YEAR(VoucherDate) * 10000 AS CHAR(8)) 
						+ CAST(AV7404.VoucherID AS CHAR(20)) 
						+ (CASE WHEN RPTransactionType = ''00'' THEN ''0'' ELSE ''1'' END) AS Orders
					, RPTransactionType
					, TransactionTypeID
					, ISNULL(AV7404.ObjectID, AV7414.ObjectID) AS ObjectID
					, ISNULL(AT1202.ObjectName, AV7414.ObjectName) AS ObjectName
					, AT1202.Address
					, AT1202.VATNo
					, AT1202.TradeName
					, AT1202.Contactor
					, DebitAccountID
					, CreditAccountID
					, ISNULL(AV7404.AccountID, AV7414.AccountID) AS AccountID
					, ISNULL(AT1005.AccountName, AV7414.AccountName) AS AccountName
					, ISNULL(AT1005.AccountNameE, AV7414.AccountNameE) AS AccountNameE
					, VoucherTypeID
					, VoucherNo
					, VoucherDate
					, InvoiceNo
					, InvoiceDate
					, Serial
					, VDescription
					, ' + CASE WHEN @CustomerName = 109 THEN 'AV7404.BDescription' ELSE 'ISNULL(AV7404.TDescription, ISNULL(AV7404.BDescription, AV7404.VDescription))' END + ' AS BDescription
					, TDescription
					, case when AV7404.TransactionTypeID in (''T14'') then AV7404.TDescription else AV7404.VDescription end as RDescription
					, AV7404.Ana01ID
					, AV7404.Ana02ID
					, AV7404.Ana03ID
					, AV7404.Ana04ID
					, AV7404.Ana05ID
					, AV7404.Ana06ID
					, AV7404.Ana07ID
					, AV7404.Ana08ID
					, AV7404.Ana09ID
					, AV7404.Ana10ID
					, ISNULL(AV7404.CurrencyID, AV7414.CurrencyID) AS CurrencyID
					, ExchangeRate
					, AV7404.CreateDate
					'+ @sSQLCustomize +'
					, ISNULL(AV7414.OpeningOriginalAmount, 0)  AS OpeningOriginalAmount
					, ISNULL(AV7414.OpeningConvertedAmount, 0) AS OpeningConvertedAmount
					, SUM(ISNULL(SignConvertedAmount, 0)) AS SignConvertedAmount
					, SUM(ISNULL(SignOriginalAmount, 0)) AS SignOriginalAmount
					, CAST(0 AS DECIMAL(28,8)) AS ClosingOriginalAmount
					, CAST(0 AS DECIMAL(28,8)) AS ClosingConvertedAmount
					, Duedate
					, Parameter01
					, Parameter02
					, Parameter03
					, Parameter04
					, Parameter05
					, Parameter06
					, Parameter07
					, Parameter08
					, Parameter09
					, Parameter10
					, AV7404.OrderID AS OrderNo
					, AV7404.Orderdate AS OrderDate
					, AV7404.ClassifyID
					, 2 AS OriginalDecimals
					'+CASE WHEN @CustomerName = 110 THEN '
					, #DONG.GiveOriginalAmount
					, #DONG.GiveOriginalAmountCN' ELSE '' END +'
					
		INTO #AV7415
		FROM	AV7404'
SET @sSQL_1 = ' 
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (AV7404.DivisionID,''@@@'') AND AT1202.ObjectID = AV7404.ObjectID
		FULL JOIN AV7414 WITH (NOLOCK) ON AV7414.ObjectID = AV7404.ObjectID 
					AND AV7414.AccountID = AV7404.AccountID 
					AND AV7414.DivisionID = AV7404.DivisionID
					--AND ISNULL(AV7414.Ana01ID,'''') = ISNULL(AV7404.Ana01ID,'''')
					--AND ISNULL(AV7414.Ana02ID,'''') = ISNULL(AV7404.Ana02ID,'''')
					--AND ISNULL(AV7414.Ana03ID,'''') = ISNULL(AV7404.Ana03ID,'''')
					--AND ISNULL(AV7414.Ana04ID,'''') = ISNULL(AV7404.Ana04ID,'''')
					--AND ISNULL(AV7414.Ana05ID,'''') = ISNULL(AV7404.Ana05ID,'''')
					--AND ISNULL(AV7414.Ana06ID,'''') = ISNULL(AV7404.Ana06ID,'''')
					--AND ISNULL(AV7414.Ana07ID,'''') = ISNULL(AV7404.Ana07ID,'''')
					--AND ISNULL(AV7414.Ana08ID,'''') = ISNULL(AV7404.Ana08ID,'''')
					--AND ISNULL(AV7414.Ana09ID,'''') = ISNULL(AV7404.Ana09ID,'''')
					--AND ISNULL(AV7414.Ana10ID,'''') = ISNULL(AV7404.Ana10ID,'''')
	    '+CASE WHEN @CustomerName = 110 THEN 
		'
		LEFT JOIN #DONG ON #DONG.VoucherID = AV7404.VoucherID AND #DONG.ObjectID = AV7404.ObjectID AND #DONG.AccountID = AV7404.AccountID 
		
		' ELSE '' END +'		
		LEFT JOIN AT1005 WITH (NOLOCK) ON AT1005.AccountID = AV7404.AccountID ' + @SQLwhere + '
		GROUP BY 
				 AV7404.ContactPerson
				, ISNULL(AV7404.DivisionID, AV7414.DivisionID)
				, BatchID
				, AV7404.VoucherID
				, TableID
				, Status
				, AV7404.DivisionID
				, TranMonth
				, TranYear,'

		SET @sSQLGroupBy = 'RPTransactionType
				, TransactionTypeID
				, AV7404.ObjectID
				, AV7414.ObjectID
				, DebitAccountID
				, CreditAccountID
				, AV7404.AccountID
				, AV7414.AccountID
				, VoucherTypeID
				, VoucherNo
				, VoucherDate
				, AV7414.OpeningOriginalAmount
				, AV7414.OpeningConvertedAmount
				, InvoiceNo
				, InvoiceDate
				, Serial
				, VDescription
				, BDescription
				, TDescription
				, AV7404.Ana01ID
				, AV7404.Ana02ID
				, AV7404.Ana03ID
				, AV7404.Ana04ID
				, AV7404.Ana05ID
				, AV7404.Ana06ID
				, AV7404.Ana07ID
				, AV7404.Ana08ID
				, AV7404.Ana09ID
				, AV7404.Ana10ID
				, AV7404.CreateDate
				, AV7404.CurrencyID
				, AV7414.CurrencyID
				, ExchangeRate
				, AT1202.ObjectName
				, AT1202.Address
				, AT1202.VATNo
				, AT1202.TradeName
				, AT1202.Contactor
				, AV7404.Orderdate
				'+CASE WHEN @CustomerName = 110 THEN '
				, #DONG.GiveOriginalAmount
				, #DONG.GiveOriginalAmountCN' ELSE '' END +'
				, AV7414.ObjectName
				, AT1005.AccountName
				, AT1005.AccountNameE
				, AV7414.AccountName
				, AV7414.AccountNameE
				, Duedate
				, AV7404.ClassifyID
				, Parameter01
				, Parameter02
				, Parameter03
				, Parameter04
				, Parameter05
				, Parameter06
				, Parameter07
				, Parameter08
				, Parameter09
				, Parameter10
				, AV7404.OrderID'
		SET @sSQL1 = '
			UNION ALL
			SELECT	 NULL AS ContactPerson
					, (ISNULL( AV7414.ObjectID, '''') + ISNULL( AV7414.AccountID, '''')) AS GroupID
					, NULL AS BatchID
					, NULL AS VoucherID
					, NULL AS TableID
					, NULL AS Status
					, AV7414.DivisionID
					, NULL AS TranMonth
					, NULL AS TranYear
					, CAST(ISNULL(AV7414.AccountID , '''') AS CHAR(20)) 
						+ CAST(ISNULL(AV7414.ObjectID, '''')  AS char(20)) 
						+ CAST(ISNULL(AV7414.CurrencyID, '''') AS char(20)) AS Orders
					, NULL AS RPTransactionType
					, NULL AS TransactionTypeID
					, ISNULL(AV7414.ObjectID,'''') AS ObjectID
					, ISNULL(AV7414.ObjectName , '''') AS ObjectName
					, AT1202.Address
					, AT1202.VATNo
					, AT1202.TradeName
					, AT1202.Contactor
					, NULL AS DebitAccountID
					, NULL AS CreditAccountID
					, ISNULL(AV7414.AccountID, '''') AS AccountID
					, ISNULL(AV7414.AccountName, '''' ) AS AccountName
					, ISNULL(AV7414.AccountNameE, '''' ) AS AccountNameE,
					NULL AS VoucherTypeID,
					NULL AS VoucherNo,
					CONVERT(DATETIME, NULL) AS VoucherDate,
					NULL AS InvoiceNo,
					CONVERT(DATETIME, NULL) AS InvoiceDate,
					NULL AS Serial,
					NULL AS VDescription, 
					NULL AS BDescription,
					NULL AS TDescription,
					NULL AS RDescription,
					NULL AS Ana01ID, 		
					NULL AS Ana02ID,
					NULL AS Ana03ID,
					NULL AS Ana04ID,
					NULL AS Ana05ID,
					NULL AS Ana06ID,
					NULL AS Ana07ID,
					NULL AS Ana08ID,
					NULL AS Ana09ID,
					NULL AS Ana10ID,
					AV7414.CurrencyID AS CurrencyID,
					0 AS ExchangeRate,
					CONVERT(DATETIME, NULL)CreateDate,
					0 AS DebitOriginalAmount,
					0 AS CreditOriginalAmount,
					0 AS DebitConvertedAmount,
					0 AS CreditConvertedAmount,
					ISNULL(AV7414.OpeningOriginalAmount, 0)  AS OpeningOriginalAmount,
					ISNULL(AV7414.OpeningConvertedAmount, 0) AS OpeningConvertedAmount,
					0 AS SignConvertedAmount,
					0 AS SignOriginalAmount,
					cast(0 as decimal(28,8)) AS ClosingOriginalAmount,
					cast(0 as decimal(28,8)) AS ClosingConvertedAmount,
					CONVERT(DATETIME, NULL) AS Duedate,
					NULL AS Parameter01, NULL as Parameter02,
					NULL AS Parameter03, NULL as Parameter04,
					NULL AS Parameter05, NULL as Parameter06,
					NULL AS Parameter07, NULL as Parameter08,
					NULL AS Parameter09, NULL as Parameter10, 
					NULL AS OrderNo, 
					NULL AS OrderDate, 
					NULL AS ClassifyID,
					2 AS OriginalDecimals
					'+CASE WHEN @CustomerName = 110 THEN ',
					0 AS GiveOriginalAmount,
					0 AS GiveOriginalAmountCN' ELSE '' END +'
			FROM	AV7414 WITH (NOLOCK)
			LEFT JOIN AT1202 ON AT1202.DivisionID IN (AV7414.DivisionID,''@@@'') AND AT1202.ObjectID = AV7414.ObjectID
			WHERE	AV7414.ObjectID + AV7414.AccountID NOT IN ( SELECT DISTINCT ObjectID+AccountID FROM AV7404 )
			' + @StrDivisionID_New1

		--IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7415]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
		--	 EXEC ('  CREATE VIEW AV7415 AS ' + @sSQL + @sSQL1)
		--ELSE
		--	 EXEC ('  ALTER VIEW AV7415  AS ' + @sSQL + @sSQL1)

	 --print (@sSQL)
	 --print (@sSQLGroupBy)
	 --Print (@sSQL1)

	 set @sSQL2 = ''
		--In khong co ma phan tich 1
		IF @CustomerName = 16   --- Customize Sieu Thanh in du lieu 2 database
			SET @sSQL2 = ' SELECT 1 as DB , '
		ELSE
			SET @sSQL2 = ' SELECT '

		IF @CustomerName = 110 -- KH SONG BÌNH
		BEGIN
			SET @sSQLCustomize = '						 
						, (CASE WHEN AV7415.TransactionTypeID = ''T00'' THEN 0 ELSE SUM(DebitOriginalAmount) END) AS DebitOriginalAmount
						, (CASE WHEN AV7415.TransactionTypeID = ''T00'' THEN 0 ELSE SUM(CreditOriginalAmount) END) AS CreditOriginalAmount
						, (CASE WHEN AV7415.TransactionTypeID = ''T00'' THEN 0 ELSE SUM(DebitConvertedAmount) END) AS DebitConvertedAmount
						, (CASE WHEN AV7415.TransactionTypeID = ''T00'' THEN 0 ELSE SUM(CreditConvertedAmount) END) AS CreditConvertedAmount
			'
		END
		ELSE
		BEGIN
					SET @sSQLCustomize = '						 
						 , SUM(DebitOriginalAmount) AS DebitOriginalAmount
						 , SUM(CreditOriginalAmount) AS CreditOriginalAmount
						 , SUM(DebitConvertedAmount) AS DebitConvertedAmount
						 , SUM(CreditConvertedAmount) AS CreditConvertedAmount
			'
		END

		SET @sSQL3 = ''
		SET @sSQL2 =  @sSQL2 + '
						 ROW_NUMBER() OVER(PARTITION BY AV7415.ObjectID ORDER BY AV7415.GroupID, AV7415.ObjectID, AV7415.VoucherDate, AV7415.VoucherNo) AS GroupRowNum
						 , AV7415.ContactPerson
						 , AV7415.GroupID
						 , AV7415.BatchID
						 , AV7415.VoucherID
						 , AV7415.TableID
						 , AV7415.Status
						 , AV7415.DivisionID
						 , AV7415.TranMonth
						 , AV7415.TranYear
						 , AV7415.RPTransactionType
						 , AV7415.TransactionTypeID
						 , AV7415.ObjectID
						 , AV7415.ObjectName
						 , AV7415.Address
						 , AV7415.VATNo
						 , AT1202.S1
						 , AT1202.S2
						 , AT1202.S3
						 , AT1202.Tel
						 , AT1202.Fax
						 , AT1202.Email
						 , AT1202.TradeName
						 , AT1202.Contactor
						 , AV7415.DebitAccountID
						 , A01.AccountName AS DebitAccountName
						 , AV7415.CreditAccountID
						 , A02.AccountName AS CreditAccountName
						 , AV7415.AccountID
						 , AV7415.AccountName
						 , AV7415.AccountNameE
						 , AV7415.VoucherTypeID
						 , AV7415.VoucherNo
						 , AV7415.VoucherDate
						 , AV7415.InvoiceNo
						 , AV7415.InvoiceDate
						 , AV7415.Serial
						 , AV7415.VDescription
						 , AV7415.BDescription
						 , AV7415.TDescription
						 , AV7415.RDescription
						 , AV7415.Ana01ID
						 , AV7415.Ana02ID
						 , AV7415.Ana03ID
						 , AV7415.Ana04ID
						 , AV7415.Ana05ID
						 , AV7415.Ana06ID
						 , AV7415.Ana07ID
						 , AV7415.Ana08ID
						 , AV7415.Ana09ID
						 , AV7415.Ana10ID
						 , A11.AnaName AS Ana01Name
						 , A12.AnaName AS Ana02Name
						 , A13.AnaName AS Ana03Name
						 , A14.AnaName AS Ana04Name
						 , A15.AnaName AS Ana05Name
						 , A16.AnaName AS Ana06Name
						 , A17.AnaName AS Ana07Name
						 , A18.AnaName AS Ana08Name
						 , A19.AnaName AS Ana09Name
						 , A10.AnaName AS Ana10Name
						 , O01ID
						 , O02ID
						 , O03ID
						 , O04ID
						 , O05ID
						 , AV7415.CurrencyID
						 , AV7415.ExchangeRate
						 '+ @sSQLCustomize +'
						 , AV7415.OpeningOriginalAmount
						 , AV7415.OpeningConvertedAmount
						 , SUM(ISNULL(SignConvertedAmount, 0)) AS SignConvertedAmount
						 , SUM(ISNULL(SignOriginalAmount, 0)) AS SignOriginalAmount
						 , ClosingOriginalAmount,ClosingConvertedAmount 
						 , CAST (AV7415.TranMonth AS Varchar)  + ''/'' + CAST (AV7415.TranYear AS Varchar) AS MonthYear
						 , CONVERT(varchar(20), AV7415.Duedate, 103) AS Duedate
						 , ''' + CONVERT(varchar(10), @FromDate, 103) + ''' AS Fromdate
						 , (CASE WHEN' + STR(@TypeD) + ' = 0 THEN ''30/' + LTRIM (STR(@ToMonth)) + '/' + LTRIM(STR(@ToYear)) + ''' ELSE ''' + CONVERT(VARCHAR(10), @ToDate,103) + ''' end) AS Todate
						 , Parameter01
						 , Parameter02
						 , Parameter03
						 , Parameter04
						 , Parameter05
						 , Parameter06
						 , Parameter07
						 , Parameter08
						 , Parameter09
						 , Parameter10
						 , OrderNo
						 , AV7415.OrderDate
						 , AV7415.ClassifyID
						 , 2 AS OriginalDecimals
						 ,isnull(AV7424.OpeningOriginalAmountAna01ID, 0)  AS OpeningOriginalAmountAna01ID
						 ,isnull(AV7424.OpeningConvertedAmountAna01ID, 0) AS OpeningConvertedAmountAna01ID
						'+CASE WHEN @CustomerName = 110 then 
						', ISNULL(AV7415.GiveOriginalAmount,0) as GiveOriginalAmount
						 , ISNULL(AV7415.GiveOriginalAmountCN,0) as GiveOriginalAmountCN' else '' end

			SET @sSQLWhere2 = '
				FROM #AV7415 AV7415 
				INNER JOIN AT1202  WITH (NOLOCK) on AT1202.DivisionID IN (AV7415.DivisionID,''@@@'') AND  AT1202.ObjectID = AV7415.ObjectID
				LEFT JOIN AT1005 A01  WITH (NOLOCK) on A01.AccountID  = AV7415.DebitAccountID 
				LEFT JOIN AT1005 A02  WITH (NOLOCK) on A02.AccountID  = AV7415.CreditAccountID
				LEFT JOIN AT1011 A11  WITH (NOLOCK) on A11.AnaID = AV7415.Ana01ID AND A11.AnaTypeID = ''A01''
				LEFT JOIN AT1011 A12  WITH (NOLOCK) on A12.AnaID = AV7415.Ana02ID AND A12.AnaTypeID = ''A02''
				LEFT JOIN AT1011 A13  WITH (NOLOCK) on A13.AnaID = AV7415.Ana03ID AND A13.AnaTypeID = ''A03''
				LEFT JOIN AT1011 A14  WITH (NOLOCK) on A14.AnaID = AV7415.Ana04ID AND A14.AnaTypeID = ''A04''
				LEFT JOIN AT1011 A15  WITH (NOLOCK) on A15.AnaID = AV7415.Ana05ID AND A15.AnaTypeID = ''A05''
				LEFT JOIN AT1011 A16  WITH (NOLOCK) on A16.AnaID = AV7415.Ana06ID AND A16.AnaTypeID = ''A06''
				LEFT JOIN AT1011 A17  WITH (NOLOCK) on A17.AnaID = AV7415.Ana07ID AND A17.AnaTypeID = ''A07''
				LEFT JOIN AT1011 A18  WITH (NOLOCK) on A18.AnaID = AV7415.Ana08ID AND A18.AnaTypeID = ''A08'' 
				LEFT JOIN AT1011 A19  WITH (NOLOCK) on A19.AnaID = AV7415.Ana09ID AND A19.AnaTypeID = ''A09''
				LEFT JOIN AT1011 A10  WITH (NOLOCK) on A10.AnaID = AV7415.Ana10ID AND A10.AnaTypeID = ''A10''
				LEFT JOIN AV7424 WITH (NOLOCK) on AV7424.DivisionID = AV7415.DivisionID AND AV7424.ObjectID = AV7415.ObjectID AND AV7424.AccountID = AV7415.AccountID AND AV7424.Ana01ID = AV7415.Ana01ID 
				' + CASE WHEN @CustomerName = 69 AND (@FromAccountID='131' OR @ToAccountID = '131') 
						THEN '' 
						ELSE ' WHERE (DebitOriginalAmount <> 0 OR CreditOriginalAmount <> 0 
						OR DebitConvertedAmount <> 0 OR CreditConvertedAmount <> 0 
						OR AV7415.OpeningOriginalAmount <> 0 OR AV7415.OpeningConvertedAmount <> 0
						OR SignOriginalAmount <> 0 OR SignConvertedAmount <> 0)  
						AND ' + @SqlFind + '' END
			SET @sSQL3 = '
				GROUP BY AV7415.ContactPerson
						, AV7415.GroupID
						, AV7415.BatchID
						, AV7415.VoucherID
						, AV7415.TableID
						, AV7415.Status
						, AV7415.DivisionID
						, AV7415.TranMonth
						, AV7415.TranYear
						, AV7415.RPTransactionType
						, AV7415.TransactionTypeID
						, AV7415.ObjectID
						, AV7415.Address
						, AV7415.VATNo
						, AT1202.S1
						, AT1202.S2
						, AT1202.S3
						, AT1202.Tel
						, AT1202.Fax
						, AT1202.Email
						, AT1202.TradeName
						, AT1202.Contactor
						, AV7415.DebitAccountID
						, AV7415.CreditAccountID
						, AV7415. AccountID
						, AV7415.VoucherTypeID
						, AV7415.VoucherNo
						, AV7415.VoucherDate
						, AV7415.OpeningOriginalAmount
						, AV7415.OpeningConvertedAmount
						, AV7415.InvoiceNo
						, AV7415.InvoiceDate
						, AV7415.Serial
						, AV7415.VDescription
						, AV7415.BDescription
						, AV7415.TDescription
						, AV7415.RDescription
						, AV7415.Ana01ID
						, AV7415.Ana02ID
						, AV7415.Ana03ID
						, AV7415.Ana04ID
						, AV7415.Ana05ID
						, AV7415.Ana06ID
						, AV7415.Ana07ID
						, AV7415.Ana08ID
						, AV7415.Ana09ID
						, AV7415.Ana10ID
						, A11.AnaName
						, AV7415.OrderDate
						, AV7415.ClassifyID
						, O01ID
						, O02ID
						, O03ID
						, O04ID
						, O05ID
						, AV7415.CurrencyID
						, AV7415.ExchangeRate
						, AV7415.ObjectName
						, AV7415.AccountName
						, AV7415.AccountNameE
						, ClosingOriginalAmount
						, ClosingConvertedAmount
						, A01.AccountName
						, A02.AccountName
						, AV7415.Duedate
						, A11.AnaName
						, A12.AnaName
						, A13.AnaName 
						, A14.AnaName
						, A15.AnaName
						, A16.AnaName
						, A17.AnaName
						, A18.AnaName
						, A19.AnaName
						, A10.AnaName
						, Parameter01
						, Parameter02
						, Parameter03
						, Parameter04
						, Parameter05
						, Parameter06
						, Parameter07
						, Parameter08
						, Parameter09
						, Parameter10
						, OrderNo
						, OriginalDecimals
						, AV7424.OpeningOriginalAmountAna01ID
						, AV7424.OpeningConvertedAmountAna01ID
						'+CASE WHEN @CustomerName = 110 then 
						', GiveOriginalAmount
						, GiveOriginalAmountCN' else '' end + '
				ORDER BY AV7415.GroupID, AV7415.ObjectID, AV7415.VoucherDate, AV7415.VoucherNo'


		IF @CustomerName = 16  AND @DatabaseName <>'' --- Customize Sieu Thanh in du lieu 2 database
			BEGIN
				Exec AP7405_ST @DivisionID, @FromMonth, @FromYear,@ToMonth,@ToYear,@TypeD,@FromDate,@ToDate,@CurrencyID,@FromAccountID,@ToAccountID,@FromObjectID,@ToObjectID,@SqlFind,@DatabaseName
				SET @sSQLUnionAll ='		 
					UNION ALL
						SELECT  2 as DB 
						, GroupID
						,  BatchID
						, VoucherID
						, TableID
						, Status
						, DivisionID
						, TranMonth
						, TranYear
						, RPTransactionType
						, TransactionTypeID
						, ObjectID
						, ObjectName
						, Address
						, VATNo
						, S1
						, S2
						, S3
						, Tel
						, Fax
						, Email
						, DebitAccountID
						, DebitAccountName
						, CreditAccountID
						, CreditAccountName
						, AccountID
						, AccountName
						, AccountNameE
						, VoucherTypeID
						, VoucherNo
						, VoucherDate
						, InvoiceNo
						, InvoiceDate
						, Serial
						, VDescription
						, BDescription
						, TDescription
						, Ana01ID
						, Ana02ID
						, Ana03ID
						, Ana04ID
						, Ana05ID
						, Ana06ID
						, Ana07ID
						, Ana08ID
						, Ana09ID
						, Ana10ID
						, Ana01Name
						, Ana02Name
						, Ana03Name
						, Ana04Name
						, Ana05Name
						, Ana06Name
						, Ana07Name
						, Ana08Name
						, Ana09Name
						, Ana10Name
						, O01ID
						, O02ID
						, O03ID
						, O04ID
						, O05ID
						, CurrencyID
						, ExchangeRate
						, DebitOriginalAmount
						, CreditOriginalAmount
						, DebitConvertedAmount
						, CreditConvertedAmount
						, OpeningOriginalAmount
						, OpeningConvertedAmount
						, SignConvertedAmount
						, SignOriginalAmount
						, ClosingOriginalAmount
						, ClosingConvertedAmount 
						, MonthYear
						, Duedate
						, Fromdate
						, Todate 
						, NULL as Parameter01
						, NULL as Parameter02
						, NULL as Parameter03
						, NULL as Parameter04
						, NULL as Parameter05
						, NULL as Parameter06
						, NULL as Parameter07
						, NULL as Parameter08
						, NULL as Parameter09
						, NULL as Parameter10 
						FROM AV7405_ST '
					--print @sSQL
					--print @sSQL1
					--print @sSQLUnionAll
					IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7405a]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
						EXEC ('  CREATE VIEW AV7405a AS ' + @sSQL + @sSQL1 + @sSQL2 + @sSQL3 + @sSQLUnionAll)
					ELSE
						EXEC ('  ALTER VIEW AV7405a  AS ' + @sSQL + @sSQL1 + @sSQL2 + @sSQL3 + @sSQLUnionAll)
					
					
					SET @sSQL4 = 'SELECT DB
						, AV7405a.GroupID AS GroupID
						, BatchID
						, Contactor
						, VoucherID
						, TableID
						, Status
						, DivisionID
						, TranMonth
						, TranYear
						, RPTransactionType
						, TransactionTypeID
						, ObjectID
						, ObjectName
						, Address
						, VATNo
						, S1
						, S2
						, S3
						, Tel
						, Fax
						, Email
						, DebitAccountID
						, DebitAccountName
						, CreditAccountID
						, CreditAccountName
						, AccountID
						, AccountName
						, VoucherTypeID
						, VoucherNo
						, VoucherDate
						, InvoiceNo
						, InvoiceDate
						, Serial
						, VDescription
						, BDescription
						, TDescription
						, Ana01ID
						, Ana02ID
						, Ana03ID
						, Ana04ID
						, Ana05ID
						, Ana06ID
						, Ana07ID
						, Ana08ID
						, Ana09ID
						, Ana10ID
						, O01ID
						, O02ID
						, O03ID
						, O04ID
						, O05ID
						, CurrencyID
						, ExchangeRate
						, DebitOriginalAmount
						, CreditOriginalAmount
						, DebitConvertedAmount
						, CreditConvertedAmount
						, 
						--OpeningOriginalAmount, OpeningConvertedAmount,
						SignConvertedAmount
						,SignOriginalAmount
						, ClosingOriginalAmount
						, ClosingConvertedAmount 
						, MonthYear
						, Duedate
						, Fromdate
						, Todate  
						, (T08.OpeningOriginalAmount + T09.OpeningOriginalAmount) AS OpeningOriginalAmount
						, (T08.OpeningConvertedAmount + T09.OpeningConvertedAmount) AS OpeningConvertedAmount
						FROM AV7405a 
						LEFT JOIN (SELECT DISTINCT GroupID, OpeningOriginalAmount, OpeningConvertedAmount FROM AV7405a Where DB = 1) T08 On AV7405a.GroupID = T08.GroupID  
						LEFT JOIN (SELECT DISTINCT GroupID, OpeningOriginalAmount, OpeningConvertedAmount FROM AV7405a Where DB = 2) T09 On AV7405a.GroupID = T09.GroupID 
						WHERE '+ @SqlFind + ''
			END 

			PRINT(@sSQL)
			PRINT(@sSQL_1)
			PRINT(@sSQLGroupBy)
			PRINT(@sSQL1)
			PRINT(@sSQL2)
			PRINT(@sSQLWhere2)
			PRINT(@sSQL3)
			PRINT(@sSQL4)
			 EXEC (@sSQL + @sSQL_1 + @sSQLGroupBy + @sSQL1 + @sSQL2 + @sSQLWhere2 + @sSQL3 + @sSQL4)
			--IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7405]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
			--	EXEC ('  CREATE VIEW AV7405 AS ' + @sSQL + @sSQL1)
			--ELSE
			--	EXEC ('  ALTER VIEW AV7405  AS ' + @sSQL + @sSQL1)
End






















GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
