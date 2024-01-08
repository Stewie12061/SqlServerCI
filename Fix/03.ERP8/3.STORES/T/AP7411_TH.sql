IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7411_TH]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP7411_TH]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--------- Created by Nguyen Van Nhan, Date 29/08/2003
---------  In bang ke, duoc goi tu AP7419
--------- Edited by Nguyen Quoc Huy, Date 06/09/2006
---------Last Edit : 14/11/2007 Thuy Tuyen, Insert dong =0,
--------- Last edit by B.Anh, date 08/12/2009	Sua cho truong hop co' nhieu nhom thue
--------- Last edit by B.Anh, date 11/01/2010	Them truong TradeName
--------- Last edit by B.Anh, date 08/04/2010	Sua loi ten doi tuong va TL thue khong hien thi
--------- Last edit by B.Anh, date 05/12/2010	Tra lai nhu cu khi chua bo sung nhieu nhom thue (bo Where voi tien thue)
--------- Last edit by B.Anh, date 30/12/2013	Order by theo ConvertedAmount khi lay du lieu dien giai

/********************************************
'* Edited by: [GS] [Ng?c Nh?t] [29/07/2010]
'********************************************/
---- Modified on 16/08/2013 on Le Thi Thu Hien : Dua bang tam ra ngoai fix khac
-----Modified on 18/03/2014 on Mai Duyen : Fix du lieu xuat nhieu phieu cho 1 HD (bo group cac field  BatchID,VoucherID,VoucherNo ) (KH IPL)
-----Modified on 26/11/2014 on Mai Duyen : Them customizedIndex (KH IPL)
-----Modified on 24/04/2015 on Mai Duyen : Fix loi doi tuong thue khong dung
-----Modified on 27/11/2015 on Phuong Thao : Fix loi tien thue nghiep vu giam gia hang ban dang len so duong
-----Modified on 08/03/2016 on Phuong Thao : Chỉnh sửa tiền thuế nguyên tệ cho TH bút toán gi?m giá hàng bán (tương tự như tiền quy đổi)
-----Modified on 14/03/2016 by Ti?u Mai: B? TK N?, Có. Fix bug tk 335 không lên b?ng kê thu? d?u vào
-----Modified by Tiểu Mai on 26/10/2016: Bổ sung lấy mã đối tượng VAT
-----Modified by Hải Long on 26/12/2016: Bổ sung lấy mặt hàng có giá trị cao nhất thay thế cho Description
---- Modified by Hải Long on 19/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Kim Thư on 15/03/2019: Bổ sung TDescription, Ana06ID và Ana06Name (Bason)
-----Modified by Kim Thư on 12/07/2019: Sửa lại bảng kê đầu ra và đầu vào
-----									ConvertedTaxAmount: Thêm điều kiện tính toán và lấy giá trị cho bút toán tổng hợp, loại chứng từ VG, ra số âm
-----									SignNetAmount: Thêm điều kiện tính toán cho bút toán tổng hợp, loại chứng từ VG, ra số âm. Bổ sung ko sum dòng thuế, chỉ lấy tiền hàng
---- Modified by Kim Thư on 12/03/2019: Bổ sung TDescription, InventoryName (Feiyeuh)
---- Modified by Huỳnh Thử on 18/02/2020 : Sửa lại đầu vào: SignNetAmount: Thêm điều kiện tính toán cho bút toán tổng hợp, loại chứng từ VG, ra số âm.
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Văn Tài	on 20/10/2020 : [BASON] Điều chỉnh TDescription chỉ lấy khi xuất báo cáo đầu ra.
---- Modified by Đức Thông	on 04/11/2020: Fix lỗi mất tên KH, mã số thuế với các hóa đơn hủy
---- Modified by Đức Thông	on 21/12/2020: [BASON] 2020/12/IS/0405 Fix bug in bảng kê thuế GTGT đầu ra không có dữ liệu: dùng LIKE phải thêm % sau chuỗi vì nếu không có % LIKE 'GTGT' không lấy được GTGT1
---- Modified by Văn Tài	on 20/05/2021: Điều chỉnh cách lấy dữ liệu OriginalNetAmount tương tự ConvertedNetAmount. Điều kiện phải giống nhau ở 2 trường này.
---- Modified by Nhựt Trường on 20/05/2021: Bổ sung lấy giá trị âm trường SignValues nếu TypeOfAdjust = 3.
---- Modified by Nhựt Trường on 21/06/2021: Fix lỗi thành tiền bị âm.
---- Modified by Nhựt Trường on 05/07/2021: Bổ sung Ana02ID và Ana02Name (Phúc Long).
---- Modified by Nhựt Trường on 05/07/2021: Mở Ana02ID và Ana02Name ra chuẩn.
---- Modified by Nhựt Trường on 13/07/2021: Fix lỗi sai cú pháp.
---- Modified by Huỳnh Thử on 26/07/2021: Bổ sung Loại chứng từ 'THDC'
---- Modified by Nhựt Trường on 03/11/2021: Tách store cho KH Phúc Long.
---- Modified by Nhật Thanh on 29/11/2021: Bổ sung điều kiện lấy đối tượng
---- Modified by Nhựt Trường on 10/01/2022: [2022/01/IS/0061] - Bổ sung VATGroupID6, VATGroupID7.
---- Modified by Nhựt Trường on 23/03/2022: Bổ sung VATTypeID6, VATTypeID7.
---- Modified by Nhựt Trường on 13/04/2022: Bổ sung InventoryID, InventoryName, UnitID, UnitPrice.
---- Modified by Xuân Nguyên on 26/05/2022: [2022/05/IS/0107]Sửa điều kiện VoucherTypeID thành like ''HG%'' khi lấy SignValues
---- Modified by Nhựt Trường on 08/06/2022: [2021/06/IS/0174] - Bỏ Ana02ID và Ana02Name ra khỏi chuẩn.
---- Modified by Nhựt Trường on 05/07/2022: Nếu là mẫu M03.T28_TT80 thì lấy chi tiết theo từng mặt hàng theo TT80.
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified by Đình Định on 10/04/2023: SAVI - Xuất Excel HTTK những hóa đơn điều chỉnh giảm đang thể hiện tiền doanh thu âm, tiền thuế dương.
---- Modified by Nhựt Trường on 26/05/2023: [2023/05/IS/0039] - CUSTOMIZE SONG BÌNH, Điều chỉnh lại điều kiện lấy dữ liệu trường ConvertedNetAmount:
----															+ Loại bỏ dòng tài khoản đối ứng tài khoản thuế.
----															+ Bổ sung điều kiện nếu TypeOfAdjust=3 thì lấy lên âm
----															+ Bổ sung điều kiện nếu là TypeOfAdjust = 3 và TransactionTypeID <> T04 (fix lỗi nếu Tài khoản nợ và có cùng nằm trong thiết lập bảng kê thuế).
---- Modified by Đình Định on 07/06/2023: SAVI - Xuất Excel HTTK hàng bán trả lại doanh thu âm, tiền thuế âm.

CREATE PROCEDURE [dbo].[AP7411_TH]
		@DivisionID AS NVARCHAR(50),
		@TaxAccountID1From AS NVARCHAR(50),
		@TaxAccountID1To AS NVARCHAR(50),
		@TaxAccountID2From AS NVARCHAR(50),
		@TaxAccountID2To AS NVARCHAR(50),
		@TaxAccountID3From AS NVARCHAR(50),
		@TaxAccountID3To AS NVARCHAR(50),
		@NetAccountID1From AS NVARCHAR(50),
		@NetAccountID1To AS NVARCHAR(50),
		@NetAccountID2From AS NVARCHAR(50),
		@NetAccountID2To AS NVARCHAR(50),
		@NetAccountID3From AS NVARCHAR(50),
		@NetAccountID3To AS NVARCHAR(50),
		@NetAccountID4From AS NVARCHAR(50),
		@NetAccountID4To AS NVARCHAR(50),
		@NetAccountID5From AS NVARCHAR(50),
		@NetAccountID5To AS NVARCHAR(50),
		@IsVATIn  AS TINYINT,
		@IsTax AS tinyint,
		@IsVATType AS tinyint,
		@IsVATGroup AS tinyint,
		@VATGroupID1 AS NVARCHAR(50),
		@VATGroupID2 AS NVARCHAR(50),
		@VATGroupID3 AS NVARCHAR(50),
		@VATGroupID4 AS NVARCHAR(50),
		@VATGroupID5 AS NVARCHAR(50),
		@VATGroupID6 AS NVARCHAR(50),
		@VATGroupID7 AS NVARCHAR(50),
		@PeriodFrom INT,
		@PeriodTo INT,
		@VATTypeID AS NVARCHAR(50),
		@VATGroupIDFrom AS NVARCHAR(50),
		@VATGroupIDTo AS NVARCHAR(50),
		@VATObjectIDFrom AS NVARCHAR(50),			
		@VATObjectIDTo AS NVARCHAR(50),
		@VATTypeID1  AS NVARCHAR(50),
		@VATTypeID2  AS NVARCHAR(50),
		@VATTypeID3  AS NVARCHAR(50),
		@VATTypeID4  AS NVARCHAR(50),
		@VATTypeID5  AS NVARCHAR(50),
		@VATTypeID6  AS NVARCHAR(50),
		@VATTypeID7  AS NVARCHAR(50),
		@VoucherTypeID AS NVARCHAR(50),
		@VoucherTypeIDFrom AS NVARCHAR(50),
		@VoucherTypeIDTo AS NVARCHAR(50),
		@ReportCode AS NVARCHAR(50)
	
AS
DECLARE @strSQL00 NVARCHAR(MAX)='',
		@strSQL NVARCHAR(MAX)='',
		@strSQL1 NVARCHAR(MAX)='',
		@strSQL2 NVARCHAR(MAX)='',
		@strSQL3 NVARCHAR(MAX)='',
		@strSQL4 NVARCHAR(MAX)='',
		@strSQL4_0 NVARCHAR(MAX)='',
		@strSQL4_1 NVARCHAR(MAX)='',
		@strSQL4_2 NVARCHAR(MAX)='',
		@strSQL5 NVARCHAR(MAX)='',
		@strSQL6 NVARCHAR(MAX)='',
		@strDeclare NVARCHAR(MAX)='',
		@strSQL_TT80 NVARCHAR(MAX)='',
		@strGroupBy_TT80 NVARCHAR(MAX)='',
		@strSQL_SNAmount NVARCHAR(MAX)='',
		@strSQL_Quantity NVARCHAR(MAX)=''

Declare @CustomerName INT
--Tao bang tam de kiem tra day co phai la khach hang Sieu Thanh khong (CustomerName = 16)
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)
		
IF (@CustomerName = 32) -- PHÚC LONG
BEGIN
	EXEC AP7411_PL @DivisionID, @TaxAccountID1From, @TaxAccountID1To, @TaxAccountID2From, @TaxAccountID2To, @TaxAccountID3From, @TaxAccountID3To, @NetAccountID1From, @NetAccountID1To, @NetAccountID2From, @NetAccountID2To, @NetAccountID3From, @NetAccountID3To,
				   @NetAccountID4From, @NetAccountID4To, @NetAccountID5From, @NetAccountID5To, @IsVATIn, @IsTax, @IsVATType, @IsVATGroup, @VATGroupID1, @VATGroupID2, @VATGroupID3, @VATGroupID4, @VATGroupID5, @PeriodFrom, @PeriodTo, @VATTypeID, @VATGroupIDFrom,
				   @VATGroupIDTo, @VATObjectIDFrom, @VATObjectIDTo, @VATTypeID1, @VATTypeID2, @VATTypeID3, @VATTypeID4, @VATTypeID5, @VoucherTypeID, @VoucherTypeIDFrom, @VoucherTypeIDTo, @ReportCode
END

-- Tạo bảng tạm #AT7419_1 
SET @strSQL00 = @strSQL00 +'
SELECT * 
INTO #AT7419_1 
FROM (
	SELECT ROW_NUMBER() OVER (PARTITION BY VoucherID,BatchID ORDER BY VoucherID,BatchID,InventoryID DESC) AS rn,* 
	FROM AT7419 WITH (NOLOCK)
) as A WHERE A.rn = 1

'

IF @TaxAccountID1To is NULL OR @TaxAccountID1To = ''
	SET @TaxAccountID1To = @TaxAccountID1From
IF @TaxAccountID2From is NULL OR @TaxAccountID2From = ''
	SET @TaxAccountID2From = @TaxAccountID1From
IF @TaxAccountID2To is NULL OR @TaxAccountID2To = ''
	SET @TaxAccountID2To = @TaxAccountID2From
IF @TaxAccountID3From is NULL OR @TaxAccountID3From = ''
	SET @TaxAccountID3From = @TaxAccountID1From
IF @TaxAccountID3To is NULL OR @TaxAccountID3To = ''
	SET @TaxAccountID3To = @TaxAccountID3From

IF @NetAccountID1To is NULL OR @NetAccountID1To = ''
	SET @NetAccountID1To = @NetAccountID1From

IF @NetAccountID2From is NULL OR @NetAccountID2From = ''
	SET @NetAccountID2From = @NetAccountID1From

IF @NetAccountID2To is NULL OR @NetAccountID2To = ''
	SET @NetAccountID2To = @NetAccountID2From

IF @NetAccountID3From is NULL OR @NetAccountID3From = ''
	SET @NetAccountID3From = @NetAccountID1From

IF @NetAccountID3To is NULL OR @NetAccountID3To = ''
	SET @NetAccountID3To = @NetAccountID3From

IF @NetAccountID4From is NULL OR @NetAccountID4From = ''
	SET @NetAccountID4From = @NetAccountID1From

IF @NetAccountID5To is NULL OR @NetAccountID5To = ''
	SET @NetAccountID5To = @NetAccountID5From

SET @strSQL = ''

IF @ReportCode = 'M03.T28_TT80'
BEGIN
	SET @strSQL_TT80 = 'T7419.InventoryID, T7419.InventoryName, T7419.UnitID, ISNULL(UnitPrice,0) AS UnitPrice,'
	SET @strGroupBy_TT80 = ',T7419.TransactionID, T7419.InventoryID, T7419.InventoryName, T7419.UnitID, UnitPrice'
END
ELSE
BEGIN
	SET @strSQL_TT80 = ' T7419_1.InventoryID, ISNULL(T7419_1.InventoryName,T7419_1.BDescription) as InventoryName, T7419_1.UnitID, T7419_1.UnitPrice,'
	SET @strGroupBy_TT80 = ''
END


SET @strSQL = @strSQL + ' 
SELECT	(CASE WHEN T7419.VATTypeID = ''VHDSD'' Then ''VGTGT1'' Else T7419.VATTypeID END) AS VATTypeID , 
		T7419.VATGroupID, (T7419.BatchID) as BatchID , (T7419.VoucherID) as VoucherID, 
		T7419.DivisionID,	(T7419.VoucherNo) as VoucherNo, 	T7419.Serial, 
		T7419.DueDate,		T7419.InvoiceDate,	T7419.InvoiceNo, T7419.InvoiceCode, T7419.InvoiceSign,T7419_1.TransactionID,
		'+@strSQL_TT80+'
		'

If @IsVATIn = 1  
	Set @strSQL = @strSQL +' Sum(CASE WHEN T7419.TransactionTypeID in (''T25'', ''T35'')  then - 1 else  1 end ) AS  SignValues, '
Else
 	Set @strSQL = @strSQL + ' SUM(
	CASE  WHEN ( T7419.TransactionTypeID IN (''T04'', ''T14'') OR TypeOfAdjust = 0) THEN 1
		  WHEN ( T7419.TransactionTypeID IN (''T24'', ''T34'') OR T7419.VoucherTypeID LIKE ''HG%'' OR TypeOfAdjust = 3) THEN - 1
	ELSE  1 END ) AS SignValues, '

If @IsTax <>0   --- Co xac dinh tien thue
Begin



If @IsVATIn = 1  --- Thue dau vao
BEGIN
SET @strSQL = @strSQL +	' SUM (
CASE WHEN ((T7419.AccountID >=''' + ISNULL( @TaxAccountID1From,'') + ''' AND T7419.AccountID <='''+ ISNULL(@TaxAccountID1To,'') +''')'

IF (@TaxAccountID2From is Not NULL OR @TaxAccountID2From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @TaxAccountID2From + ''' AND T7419.AccountID <='''+ @TaxAccountID2To +''')'

IF (@TaxAccountID3From is Not NULL OR @TaxAccountID3From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @TaxAccountID3From + ''' AND T7419.AccountID <='''+ @TaxAccountID3To +''')'

SET @strSQL = @strSQL + ') AND (T7419.D_C like ''D'' or (T7419.D_C like ''C'' and T7419.TransactionTypeID =''T35'')) THEN T7419.ConvertedAmount 
ELSE 
CASE WHEN ((T7419.AccountID >=''' + ISNULL( @TaxAccountID1From,'') + ''' AND T7419.AccountID <='''+ ISNULL(@TaxAccountID1To,'') +''')
'
IF (@TaxAccountID2From is Not NULL OR @TaxAccountID2From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @TaxAccountID2From + ''' AND T7419.AccountID <='''+ @TaxAccountID2To +''')'

IF (@TaxAccountID3From is Not NULL OR @TaxAccountID3From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @TaxAccountID3From + ''' AND T7419.AccountID <='''+ @TaxAccountID3To +''')'

SET @strSQL = @strSQL + ') AND T7419.D_C = ''C''  and ISNULL(T7419.TransactionTypeID,'''') <> ''T35'' AND (T7419.AccountID <> T7419.CorAccountID) THEN T7419.ConvertedAmount * (-1) ELSE 0 END END) AS ConvertedTaxAmount,'
END


ELSE --- Thue dau ra
BEGIN
SET @strSQL = @strSQL +	' SUM (
CASE WHEN ((T7419.AccountID >=''' + ISNULL( @TaxAccountID1From,'') + ''' AND T7419.AccountID <='''+ ISNULL(@TaxAccountID1To,'') +''')'

IF (@TaxAccountID2From is Not NULL OR @TaxAccountID2From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @TaxAccountID2From + ''' AND T7419.AccountID <='''+ @TaxAccountID2To +''')'

IF (@TaxAccountID3From is Not NULL OR @TaxAccountID3From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @TaxAccountID3From + ''' AND T7419.AccountID <='''+ @TaxAccountID3To +''')'

SET @strSQL = @strSQL + ') AND ( T7419.D_C like ''C'' or (T7419.D_C like ''D'' and (T7419.TransactionTypeID =''T34'' or  T7419.VoucherTypeID = ''HG'' or TypeOfAdjust = 3) )) THEN T7419.ConvertedAmount 
ELSE 
CASE WHEN ((T7419.AccountID >=''' + ISNULL( @TaxAccountID1From,'') + ''' AND T7419.AccountID <='''+ ISNULL(@TaxAccountID1To,'') +''')
'
IF (@TaxAccountID2From is Not NULL OR @TaxAccountID2From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @TaxAccountID2From + ''' AND T7419.AccountID <='''+ @TaxAccountID2To +''')'

IF (@TaxAccountID3From is Not NULL OR @TaxAccountID3From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @TaxAccountID3From + ''' AND T7419.AccountID <='''+ @TaxAccountID3To +''')'

SET @strSQL = @strSQL + ') AND T7419.D_C = ''D'' and Isnull(T7419.TransactionTypeID,'''') <>''T34'' 
							AND (T7419.AccountID <> T7419.CorAccountID) AND ISNULL(T7419.VoucherTypeID,'''') <> ''HG'' THEN T7419.ConvertedAmount * (-1) ELSE 0 END END ) AS ConvertedTaxAmount,'
END

End
Else
	Set 	@strSQL = @strSQL +	' 0 AS 	ConvertedTaxAmount,'

If @IsTax <>0   --- Co xac dinh tien thue
Begin


If @IsVATIn = 1  --- Thue dau vao
BEGIN
SET @strSQL = @strSQL +	' SUM (
CASE WHEN ((T7419.AccountID >=''' + ISNULL( @TaxAccountID1From,'') + ''' AND T7419.AccountID <='''+ ISNULL(@TaxAccountID1To,'') +''')'

IF (@TaxAccountID2From is Not NULL OR @TaxAccountID2From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @TaxAccountID2From + ''' AND T7419.AccountID <='''+ @TaxAccountID2To +''')'

IF (@TaxAccountID3From is Not NULL OR @TaxAccountID3From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @TaxAccountID3From + ''' AND T7419.AccountID <='''+ @TaxAccountID3To +''')'

SET @strSQL = @strSQL + ') AND (T7419.D_C like ''D''  or (T7419.D_C like ''C'' and T7419.TransactionTypeID =''T35'')) THEN T7419.OriginalAmount 
ELSE 
CASE WHEN ((T7419.AccountID >=''' + ISNULL( @TaxAccountID1From,'') + ''' AND T7419.AccountID <='''+ ISNULL(@TaxAccountID1To,'') +''')
'
IF (@TaxAccountID2From is Not NULL OR @TaxAccountID2From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @TaxAccountID2From + ''' AND T7419.AccountID <='''+ @TaxAccountID2To +''')'

IF (@TaxAccountID3From is Not NULL OR @TaxAccountID3From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @TaxAccountID3From + ''' AND T7419.AccountID <='''+ @TaxAccountID3To +''')'

SET @strSQL = @strSQL + ') AND T7419.D_C = ''C'' and ISNULL(T7419.TransactionTypeID,'''') <> ''T35'' AND (T7419.AccountID <> T7419.CorAccountID) THEN T7419.OriginalAmount * (-1) ELSE 0 END END) AS OriginalTaxAmount,'
END


ELSE --- Thue dau ra
BEGIN
SET @strSQL = @strSQL +	' SUM (
CASE WHEN ((T7419.AccountID >=''' + ISNULL( @TaxAccountID1From,'') + ''' AND T7419.AccountID <='''+ ISNULL(@TaxAccountID1To,'') +''')'

IF (@TaxAccountID2From is Not NULL OR @TaxAccountID2From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @TaxAccountID2From + ''' AND T7419.AccountID <='''+ @TaxAccountID2To +''')'

IF (@TaxAccountID3From is Not NULL OR @TaxAccountID3From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @TaxAccountID3From + ''' AND T7419.AccountID <='''+ @TaxAccountID3To +''')'

SET @strSQL = @strSQL + ') AND ( T7419.D_C like ''C'' or (T7419.D_C like ''D'' and (T7419.TransactionTypeID =''T34'' or  T7419.VoucherTypeID = ''HG'' or TypeOfAdjust = 3) )) THEN T7419.OriginalAmount 
ELSE 
CASE WHEN ((T7419.AccountID >=''' + ISNULL( @TaxAccountID1From,'') + ''' AND T7419.AccountID <='''+ ISNULL(@TaxAccountID1To,'') +''')
'
IF (@TaxAccountID2From is Not NULL OR @TaxAccountID2From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @TaxAccountID2From + ''' AND T7419.AccountID <='''+ @TaxAccountID2To +''')'

IF (@TaxAccountID3From is Not NULL OR @TaxAccountID3From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @TaxAccountID3From + ''' AND T7419.AccountID <='''+ @TaxAccountID3To +''')'

SET @strSQL = @strSQL + ') AND T7419.D_C = ''D''  and Isnull(T7419.TransactionTypeID,'''') <>''T34'' 
							AND (T7419.AccountID <> T7419.CorAccountID)  AND  Isnull(T7419.VoucherTypeID,'''') <> ''HG'' THEN T7419.OriginalAmount * (-1) ELSE 0 END END) AS OriginalTaxAmount,'
END

End
Else
	SET @strSQL = @strSQL + '0 AS OriginalTaxAmount,'

SET @strSQL = @strSQL + ' SUM (CASE WHEN 
					((T7419.AccountID >=''' + ISNULL(@NetAccountID1From,'') + ''' AND T7419.AccountID <='''+ ISNULL(@NetAccountID1To,'') +''')'
IF (@NetAccountID2From is Not NULL OR @NetAccountID2From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @NetAccountID2From + ''' AND T7419.AccountID <='''+ @NetAccountID2To +''')'
IF (@NetAccountID3From is Not NULL OR @NetAccountID3From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @NetAccountID3From + ''' AND T7419.AccountID <='''+ @NetAccountID3To +''')'
IF (@NetAccountID4From is Not NULL OR @NetAccountID4From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @NetAccountID4From + ''' AND T7419.AccountID <='''+ @NetAccountID4To +''')'
IF (@NetAccountID5From is Not NULL OR @NetAccountID5From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @NetAccountID5From + ''' AND T7419.AccountID <='''+ @NetAccountID5To +''')'

---- ConvertedNetAmount
IF (@CustomerName = 110) -- SONG BÌNH
BEGIN
	If @IsVATIn = 1  --- Xac dinh doanh so mua vao
		SET @strSQL = @strSQL +  ') AND ((T7419.D_C like ''D'' and T7419.TransactionTypeID not in (''T25'',''T35'')) or (T7419.D_C like ''C'' and T7419.TransactionTypeID =''T25'')) '
	Else		---- Xac dinh doanh so ban ra
		SET @strSQL = @strSQL +  ')  AND ( T7419.D_C like ''C'' and T7419.CorAccountID NOT BETWEEN ''3331102'' AND ''3331102'' or (T7419.D_C like ''D'' and  (T7419.TransactionTypeID in (''T24'',''T65'') or  T7419.VoucherTypeID = ''HG'' or (TypeOfAdjust = 3 AND T7419.TransactionTypeID <> ''T04'')) )) '
	
	SET @strSQL = @strSQL + ' THEN CASE WHEN TypeOfAdjust = 3 THEN - (T7419.ConvertedAmount + T7419.ImTaxConvertedAmount) 
								   ELSE T7419.ConvertedAmount + T7419.ImTaxConvertedAmount END 
							  ELSE 0 END) AS ConvertedNetAmount,'
END
ELSE -- Luồng chuẩn
BEGIN
	If @IsVATIn = 1  --- Xac dinh doanh so mua vao
		SET @strSQL = @strSQL +  ') AND ((T7419.D_C like ''D'' and T7419.TransactionTypeID not in (''T25'',''T35'')) or (T7419.D_C like ''C'' and T7419.TransactionTypeID =''T25'')) '
	Else		---- Xac dinh doanh so ban ra
		SET @strSQL = @strSQL +  ')  AND ( T7419.D_C like ''C'' or (T7419.D_C like ''D'' and  (T7419.TransactionTypeID in (''T24'',''T65'') or  T7419.VoucherTypeID = ''HG'' or TypeOfAdjust = 3) )) '
	
	SET @strSQL = @strSQL + ' THEN T7419.ConvertedAmount + T7419.ImTaxConvertedAmount ELSE 0 END) AS ConvertedNetAmount,'
END

SET @strSQL = @strSQL + ' SUM (CASE WHEN 
					((T7419.AccountID >=''' + ISNULL(@NetAccountID1From,'') + ''' AND T7419.AccountID <='''+ ISNULL(@NetAccountID1To,'') +''')'
IF (@NetAccountID2From is Not NULL OR @NetAccountID2From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @NetAccountID2From + ''' AND T7419.AccountID <='''+ @NetAccountID2To +''')'
IF (@NetAccountID3From is Not NULL OR @NetAccountID3From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @NetAccountID3From + ''' AND T7419.AccountID <='''+ @NetAccountID3To +''')'
IF (@NetAccountID4From is Not NULL OR @NetAccountID4From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @NetAccountID4From + ''' AND T7419.AccountID <='''+ @NetAccountID4To +''')'

IF  ( isnull(@NetAccountID5From,'')<> '')
--	Print ' Hello'
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @NetAccountID5From + ''' AND T7419.AccountID <='''+ @NetAccountID5To +''')'

-- Sửa theo điều kiện kiện tính tương tự ConvertedNetAmount.
If @IsVATIn = 1  --- Xac dinh doanh so mua vao
				 --- Nếu Phát sinh tăng của hóa đơn mua hàng hoặc phát sinh giảm của hàng mua trả lại.
	SET @strSQL = @strSQL +  ') AND ((T7419.D_C like ''D'' and T7419.TransactionTypeID not in (''T25'',''T35'')) or (T7419.D_C like ''C'' and T7419.TransactionTypeID =''T25'')) '
Else		---- Xac dinh doanh so ban ra
			--- Nếu Phát sinh giảm (không phân biệt đơn) hoặc phát sinh tăng của hàng bán trả lại.
	SET @strSQL = @strSQL +  ')  AND ( T7419.D_C like ''C'' or (T7419.D_C like ''D'' and  (T7419.TransactionTypeID in (''T24'',''T65'') or  T7419.VoucherTypeID = ''HG'') )) '


SET @strSQL = @strSQL + ' THEN T7419.OriginalAmount + T7419.ImTaxOriginalAmount ELSE 0 END) AS OriginalNetAmount,'


SET @strSQL_Quantity = @strSQL_Quantity + ' Sum(CASE WHEN 
					((T7419.AccountID >=''' + ISNULL(@NetAccountID1From,'') + ''' AND T7419.AccountID <='''+ ISNULL(@NetAccountID1To,'') +''')'
IF (@NetAccountID2From is Not NULL OR @NetAccountID2From <> '')
	SET @strSQL_Quantity = @strSQL_Quantity + 	' OR (T7419.AccountID >=''' + @NetAccountID2From + ''' AND T7419.AccountID <='''+ @NetAccountID2To +''')'
IF (@NetAccountID3From is Not NULL OR @NetAccountID3From <> '')
	SET @strSQL_Quantity = @strSQL_Quantity + 	' OR (T7419.AccountID >=''' + @NetAccountID3From + ''' AND T7419.AccountID <='''+ @NetAccountID3To +''')'
	IF (@NetAccountID4From is Not NULL OR @NetAccountID4From <> '')
	SET @strSQL_Quantity = @strSQL_Quantity + 	' OR (T7419.AccountID >=''' + @NetAccountID4From + ''' AND T7419.AccountID <='''+ @NetAccountID4To +''')'

IF  ( isnull(@NetAccountID5From,'')<> '')
--	Print ' Hello'
	SET @strSQL_Quantity = @strSQL_Quantity + 	' OR (T7419.AccountID >=''' + @NetAccountID5From + ''' AND T7419.AccountID <='''+ @NetAccountID5To +''')'


If @IsVATIn = 1  --- Xac dinh doanh so mua vao
	SET @strSQL_Quantity = @strSQL_Quantity +  ') AND T7419.D_C like ''D'''
Else		---- Xac dinh doanh so ban ra
	SET @strSQL_Quantity = @strSQL_Quantity +  ') AND T7419.D_C like ''C'''


SET @strSQL_Quantity = @strSQL_Quantity + ' THEN T7419.Quantity ELSE 0 END) AS Quantity, '

SET @strSQL = @strSQL + @strSQL_Quantity


If @IsVATIn = 1  --- Thue dau vao
BEGIN
SET @strSQL = @strSQL +	' SUM (
CASE WHEN ((T7419.AccountID >=''' + ISNULL( @TaxAccountID1From,'') + ''' AND T7419.AccountID <='''+ ISNULL(@TaxAccountID1To,'') +''')'

IF (@TaxAccountID2From is Not NULL OR @TaxAccountID2From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @TaxAccountID2From + ''' AND T7419.AccountID <='''+ @TaxAccountID2To +''')'

IF (@TaxAccountID3From is Not NULL OR @TaxAccountID3From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @TaxAccountID3From + ''' AND T7419.AccountID <='''+ @TaxAccountID3To +''')'

SET @strSQL = @strSQL + ') AND T7419.D_C = ''D'' THEN T7419.SignAmount 
ELSE 
CASE WHEN ((T7419.AccountID >=''' + ISNULL( @TaxAccountID1From,'') + ''' AND T7419.AccountID <='''+ ISNULL(@TaxAccountID1To,'') +''')
'
IF (@TaxAccountID2From is Not NULL OR @TaxAccountID2From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @TaxAccountID2From + ''' AND T7419.AccountID <='''+ @TaxAccountID2To +''')'

IF (@TaxAccountID3From is Not NULL OR @TaxAccountID3From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @TaxAccountID3From + ''' AND T7419.AccountID <='''+ @TaxAccountID3To +''')'

SET @strSQL = @strSQL + ') AND T7419.D_C = ''C'' THEN T7419.SignAmount * (-1) ELSE 0 END END) AS SignTaxAmount,'
END

ELSE --- Thue dau ra
BEGIN
SET @strSQL = @strSQL +	' SUM (
CASE WHEN ((T7419.AccountID >=''' + ISNULL( @TaxAccountID1From,'') + ''' AND T7419.AccountID <='''+ ISNULL(@TaxAccountID1To,'') +''')'

IF (@TaxAccountID2From is Not NULL OR @TaxAccountID2From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @TaxAccountID2From + ''' AND T7419.AccountID <='''+ @TaxAccountID2To +''')'

IF (@TaxAccountID3From is Not NULL OR @TaxAccountID3From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @TaxAccountID3From + ''' AND T7419.AccountID <='''+ @TaxAccountID3To +''')'

SET @strSQL = @strSQL + ') AND T7419.D_C = ''C'' THEN T7419.SignAmount 
ELSE 
CASE WHEN ((T7419.AccountID >=''' + ISNULL( @TaxAccountID1From,'') + ''' AND T7419.AccountID <='''+ ISNULL(@TaxAccountID1To,'') +''')
'
IF (@TaxAccountID2From is Not NULL OR @TaxAccountID2From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @TaxAccountID2From + ''' AND T7419.AccountID <='''+ @TaxAccountID2To +''')'

IF (@TaxAccountID3From is Not NULL OR @TaxAccountID3From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @TaxAccountID3From + ''' AND T7419.AccountID <='''+ @TaxAccountID3To +''')'

SET @strSQL = @strSQL + ') AND T7419.D_C = ''D'' THEN T7419.SignAmount * (-1) ELSE 0 END END) AS SignTaxAmount,'
END

SET @strSQL_SNAmount = @strSQL_SNAmount + ' SUM(CASE WHEN 
					((T7419.AccountID >=''' + ISNULL(@NetAccountID1From,'') + ''' AND T7419.AccountID <='''+ ISNULL(@NetAccountID1To,'') +''')'
IF (@NetAccountID2From is Not NULL OR @NetAccountID2From <> '')
	SET @strSQL_SNAmount = @strSQL_SNAmount + 	' OR (T7419.AccountID >=''' + @NetAccountID2From + ''' AND T7419.AccountID <='''+ @NetAccountID2To +''')'
IF (@NetAccountID3From is Not NULL OR @NetAccountID3From <> '')
	SET @strSQL_SNAmount = @strSQL_SNAmount + 	' OR (T7419.AccountID >=''' + @NetAccountID3From + ''' AND T7419.AccountID <='''+ @NetAccountID3To +''')'
IF (@NetAccountID4From is Not NULL OR @NetAccountID4From <> '')
	SET @strSQL_SNAmount = @strSQL_SNAmount + 	' OR (T7419.AccountID >=''' + @NetAccountID4From + ''' AND T7419.AccountID <='''+ @NetAccountID4To +''')'
IF  ( isnull(@NetAccountID5From,'')<> '')
	SET @strSQL_SNAmount = @strSQL_SNAmount + 	' OR (T7419.AccountID >=''' + @NetAccountID5From + ''' AND T7419.AccountID <='''+ @NetAccountID5To +''')'
	
If @IsVATIn = 1 ---- Xac dinh doanh so dau vao
	SET @strSQL_SNAmount = @strSQL_SNAmount +  ') AND ((T7419.D_C like ''D'' and T7419.TransactionTypeID not in (''T25'',''T35'') and T7419.CorAccountID NOT BETWEEN ''' + @TaxAccountID1From + ''' AND '''+ @TaxAccountID1To +''') 
									or (T7419.D_C like ''C'' and (T7419.TransactionTypeID =''T25'' or T7419.VoucherTypeID = ''THDC''))) '
Else		----- Xac dinh doanh so dau ra
	SET @strSQL_SNAmount = @strSQL_SNAmount +  ')  AND ( T7419.D_C like ''C''  and T7419.CorAccountID NOT BETWEEN ''' + @TaxAccountID1From + ''' AND '''+ @TaxAccountID1To +''' or (T7419.D_C like ''D'' and (T7419.TransactionTypeID in (''T24'',''T65'') or  T7419.VoucherTypeID = ''HG'' or T7419.TypeOfAdjust = 3) )) '

SET @strSQL_SNAmount = @strSQL_SNAmount + ' THEN CASE WHEN T7419.VoucherTypeID = ''THDC'' THEN - T7419.SignAmount ELSE T7419.SignAmount END WHEN T7419.VoucherTypeID = ''VG'' THEN - T7419.SignAmount  ELSE 0 END) AS SignNetAmount'

SET @strSQL1 =  @strSQL1 +@strSQL_SNAmount

SET @strSQL1 = @strSQL1 + '
		Into #AV7411
		FROM AT7419 AS T7419
		LEFT JOIN #AT7419_1 AS T7419_1 ON T7419_1.DivisionID = T7419.DivisionID AND T7419_1.VoucherID = T7419.VoucherID AND T7419_1.BatchID = T7419.BatchID
		'


if isnull(@VATGroupID1,'') <>'' or   isnull(@VATGroupID2,'') <>'' or  isnull(@VATGroupID3,'') <>''   or isnull(@VATGroupID4,'') <>'' or isnull(@VATGroupID5,'') <>'' or isnull(@VATGroupID6,'') <>'' or isnull(@VATGroupID7,'') <>'' or isnull(@VATTypeID1,'')<>'' or isnull(@VATTypeID2,'')<>'' or isnull(@VATTypeID3,'')<>''   or  isnull(@VATTypeID4,'')<>'' or  isnull(@VATTypeID5,'')<>'' or  isnull(@VATTypeID6,'')<>''or  isnull(@VATTypeID7,'')<>''
Set @strSQL1 = @strSQL1 + 'Where '
---SET @strSQL = @strSQL + ' AND T7419.VATTypeID IS NOT NULL ' +  ' AND T7419.VATTypeID <> ''' + ''''

IF @IsVATGroup <>0 
Begin
	If isnull(@VATGroupID1,'') <>''
		Set @strSQL1  = @strSQL1 +  '   ( T7419.VATGroupID like '''+@VATGroupID1+ '%' + ''' '  
 	If isnull(@VATGroupID2,'') <>'' and isnull(@VATGroupID1,'') <>''
			Set @strSQL1  = @strSQL1 +  '  or  T7419.VATGroupID  like  '''+@VATGroupID2+ '%' + ''' '  
	If isnull(@VATGroupID2,'') <>'' and isnull(@VATGroupID1,'') =''
			Set @strSQL1  = @strSQL1 +  '   T7419.VATGroupID  like  '''+@VATGroupID2+ '%' + ''' '  
			
 	If isnull(@VATGroupID3,'') <>'' and (isnull(@VATGroupID1,'') <>'' or isnull(@VATGroupID2,'') <>'')
			Set @strSQL1  = @strSQL1 +  '  or  T7419.VATGroupID like  '''+@VATGroupID3+ '%' + ''' '  
 	If isnull(@VATGroupID3,'') <>'' and isnull(@VATGroupID1,'') ='' and isnull(@VATGroupID2,'')= ''
			Set @strSQL1  = @strSQL1 +  '   T7419.VATGroupID like  '''+@VATGroupID3+ '%' + ''' '  
	
	If isnull(@VATGroupID4,'') <>'' and (isnull(@VATGroupID1,'') <>'' or isnull(@VATGroupID2,'') <>'' or isnull(@VATGroupID3,'') <>'')
			Set @strSQL1  = @strSQL1 +  '  or  T7419.VATGroupID like  '''+@VATGroupID4+ '%' + ''' '  
	If isnull(@VATGroupID4,'') <>'' and isnull(@VATGroupID1,'') ='' and isnull(@VATGroupID2,'') ='' and isnull(@VATGroupID3,'') =''
			Set @strSQL1  = @strSQL1 +  '    T7419.VATGroupID like  '''+@VATGroupID4+ '%' + ''' '  
	If isnull(@VATGroupID5,'') <>'' and isnull(@VATGroupID1,'') ='' and isnull(@VATGroupID2,'') ='' and isnull(@VATGroupID3,'') ='' and isnull(@VATGroupID4,'') =''
			Set @strSQL1  = @strSQL1 +  '    T7419.VATGroupID like  '''+@VATGroupID5+ '%' + ''' '  

	If isnull(@VATGroupID5,'') <>'' and (isnull(@VATGroupID1,'') <>'' or isnull(@VATGroupID2,'') <>'' or isnull(@VATGroupID3,'') <>'' or isnull(@VATGroupID4,'') <>'')
			Set @strSQL1  = @strSQL1 +  '  or  T7419.VATGroupID like  '''+@VATGroupID5+ '%' + ''' '  

	If isnull(@VATGroupID6,'') <>'' and isnull(@VATGroupID1,'') ='' and isnull(@VATGroupID2,'') ='' and isnull(@VATGroupID3,'') ='' and isnull(@VATGroupID4,'') ='' and isnull(@VATGroupID5,'') =''
			Set @strSQL1  = @strSQL1 +  '    T7419.VATGroupID like  '''+@VATGroupID6+ '%' + ''' '  

	If isnull(@VATGroupID6,'') <>'' and (isnull(@VATGroupID1,'') <>'' or isnull(@VATGroupID2,'') <>'' or isnull(@VATGroupID3,'') <>'' or isnull(@VATGroupID4,'') <>'' or isnull(@VATGroupID5,'') ='')
			Set @strSQL1  = @strSQL1 +  '  or  T7419.VATGroupID like  '''+@VATGroupID6+ '%' + ''' '

	If isnull(@VATGroupID7,'') <>'' and isnull(@VATGroupID1,'') ='' and isnull(@VATGroupID2,'') ='' and isnull(@VATGroupID3,'') ='' and isnull(@VATGroupID4,'') ='' and isnull(@VATGroupID5,'') ='' and isnull(@VATGroupID6,'') =''
			Set @strSQL1  = @strSQL1 +  '    T7419.VATGroupID like  '''+@VATGroupID7+ '%' + ''' '  

	If isnull(@VATGroupID7,'') <>'' and (isnull(@VATGroupID1,'') <>'' or isnull(@VATGroupID2,'') <>'' or isnull(@VATGroupID3,'') <>'' or isnull(@VATGroupID4,'') <>'' or isnull(@VATGroupID5,'') ='' or isnull(@VATGroupID6,'') ='')
			Set @strSQL1  = @strSQL1 +  '  or  T7419.VATGroupID like  '''+@VATGroupID7+ '%' + ''' '
			
			
	If isnull(@VATGroupID1,'') <>'' or   isnull(@VATGroupID2,'') <>'' or  isnull(@VATGroupID3,'') <>''   or isnull(@VATGroupID4,'') <>'' or isnull(@VATGroupID5,'') <>''
		Set @strSQL1  = @strSQL1 +  ' ) AND '


End

If @IsVATType <>0 
  Begin
	--Print ' Nhan res '+@VATTypeID1
	if isnull(@VATTypeID1,'')<>'' 
		SET @strSQL1 = @strSQL1 + ' (T7419.VATTypeID like ''' + @VATTypeID1 + '%' + '''' 
	if isnull(@VATTypeID2,'')<>'' and isnull(@VATTypeID1,'')<>''
		SET @strSQL1 = @strSQL1 + '  OR T7419.VATTypeID like ''' + @VATTypeID2 + '%' +'''' 
	if isnull(@VATTypeID2,'')<>'' and isnull(@VATTypeID1,'')=''
		SET @strSQL1 = @strSQL1 + '  T7419.VATTypeID like ''' + @VATTypeID2 + '%' +'''' 
	
	if isnull(@VATTypeID3,'')<>'' and (isnull(@VATTypeID2,'')<>'' or isnull(@VATTypeID1,'')<>'')
		SET @strSQL1 = @strSQL1 + '  OR T7419.VATTypeID like ''' + @VATTypeID3 + '%' +'''' 
	if isnull(@VATTypeID3,'')<>'' and isnull(@VATTypeID2,'')='' and isnull(@VATTypeID1,'')=''
		SET @strSQL1 = @strSQL1 + '  T7419.VATTypeID like ''' + @VATTypeID3 + '%' +'''' 

	if isnull(@VATTypeID4,'')<>'' and (isnull(@VATTypeID2,'')<>'' or isnull(@VATTypeID1,'')<>'' or isnull(@VATTypeID3,'')<>'')
		SET @strSQL1 = @strSQL1 + '  OR T7419.VATTypeID like ''' + @VATTypeID4 + '%' +'''' 
	if isnull(@VATTypeID4,'')<>'' and isnull(@VATTypeID2,'')='' and isnull(@VATTypeID1,'')='' and isnull(@VATTypeID3,'')=''
		SET @strSQL1 = @strSQL1 + '  T7419.VATTypeID like ''' + @VATTypeID4 + '''' 
			
	if isnull(@VATTypeID5,'')<>'' and (isnull(@VATTypeID2,'')<>'' or isnull(@VATTypeID1,'')<>'' or isnull(@VATTypeID3,'')<>'' or isnull(@VATTypeID4,'')<>'')
		SET @strSQL1 = @strSQL1 + '  OR T7419.VATTypeID like ''' + @VATTypeID5 + '%' +'''' 
	if isnull(@VATTypeID5,'')<>'' and isnull(@VATTypeID2,'')='' and isnull(@VATTypeID1,'')='' and isnull(@VATTypeID3,'')='' and isnull(@VATTypeID4,'')=''
		SET @strSQL1 = @strSQL1 + '  T7419.VATTypeID like ''' + @VATTypeID5 + '%' +'''' 

	if isnull(@VATTypeID6,'')<>'' and (isnull(@VATTypeID2,'')<>'' or isnull(@VATTypeID1,'')<>'' or isnull(@VATTypeID3,'')<>'' or isnull(@VATTypeID4,'')<>'' or isnull(@VATTypeID5,'')<>'')
		SET @strSQL1 = @strSQL1 + '  OR T7419.VATTypeID like ''' + @VATTypeID6 + '%' +'''' 
	if isnull(@VATTypeID6,'')<>'' and isnull(@VATTypeID2,'')='' and isnull(@VATTypeID1,'')='' and isnull(@VATTypeID3,'')='' and isnull(@VATTypeID4,'')='' and isnull(@VATTypeID5,'')=''
		SET @strSQL1 = @strSQL1 + '  T7419.VATTypeID like ''' + @VATTypeID6 + '%' +'''' 

	if isnull(@VATTypeID7,'')<>'' and (isnull(@VATTypeID2,'')<>'' or isnull(@VATTypeID1,'')<>'' or isnull(@VATTypeID3,'')<>'' or isnull(@VATTypeID4,'')<>'' or isnull(@VATTypeID5,'')<>'' or isnull(@VATTypeID6,'')<>'')
		SET @strSQL1 = @strSQL1 + '  OR T7419.VATTypeID like ''' + @VATTypeID7 + '%' +'''' 
	if isnull(@VATTypeID7,'')<>'' and isnull(@VATTypeID2,'')='' and isnull(@VATTypeID1,'')='' and isnull(@VATTypeID3,'')='' and isnull(@VATTypeID4,'')='' and isnull(@VATTypeID5,'')='' and isnull(@VATTypeID6,'')=''
		SET @strSQL1 = @strSQL1 + '  T7419.VATTypeID like ''' + @VATTypeID7 + '%' +'''' 

	if isnull(@VATTypeID1,'')<>'' or isnull(@VATTypeID2,'')<>'' or isnull(@VATTypeID3,'')<>''   or  isnull(@VATTypeID4,'')<>'' or  isnull(@VATTypeID5,'')<>''  or  isnull(@VATTypeID6,'')<>''  or  isnull(@VATTypeID7,'')<>'' 
		SET @strSQL1 = @strSQL1 + '  ) '
End


If isnull(@VoucherTypeID,'')<>'' 
	Set @strSQL1 = @strSQL1 + ' AND (T7419.VoucherTypeID between ''' + @VoucherTypeID + '''  and ''' + @VoucherTypeIDTo + ''' )  ' 

IF isnull(@VATObjectIDFrom,'') >''
	Set @strSQL1 = @strSQL1 + ' AND (T7419.ObjectID  between  ''' + isnull(@VATObjectIDFrom,'') + ''' and '''+isnull(@VATObjectIDTo,'')+''' ) '	


SET @strSQL1 = @strSQL1 + ' 
		GROUP BY  T7419.BatchID,   
			T7419.VoucherID,
			T7419.DivisionID,
			T7419.VoucherNo,
			T7419.Serial, T7419.DueDate, 
		T7419.InvoiceNo, T7419.InvoiceDate, T7419.VAtTypeID, T7419.VATGroupID, T7419.InvoiceCode, T7419.InvoiceSign,
		T7419_1.InventoryID,T7419_1.InventoryName,T7419_1.UnitID,T7419_1.UnitPrice,T7419_1.BDescription,T7419_1.TransactionID
		'

--Print @strSQL
--PRINT @strSQL1

DELETE AT7411 WHERE DivisionID = @DivisionID ---(D90T3010)
--Print ' test'
Set @strDeclare ='
DECLARE @D90V4001Cursor AS CURSOR,
		@VoucherID as NVARCHAR(50),
		@InvoiceNo AS NVARCHAR(50),
		@Serial AS NVARCHAR(50),
		@VoucherTypeID AS NVARCHAR(50),
		@BDescription AS NVARCHAR(250),
		@VDescription AS NVARCHAR(250),
		@VoucherNo AS NVARCHAR(50),
		@VoucherDate AS NVARCHAR(50),
		@InvoiceDate DATETIME,
		@TranMonth AS INT,
		@TranYear AS INT,
		@OriginalTaxAmount AS DECIMAL(28, 8),
		@ConvertedTaxAmount AS DECIMAL(28, 8),
		@OriginalNetAmount AS DECIMAL(28, 8),
		@ConvertedNetAmount AS DECIMAL(28, 8),
		@SignNetAmount AS DECIMAL(28, 8),
		@SignTaxAmount AS DECIMAL(28, 8),
		@ExchangeRate AS DECIMAL(28, 8),
		@CurrencyID AS NVARCHAR(50),
		@Object_Name AS NVARCHAR(250),
		@Object_Address AS NVARCHAR(250),
		@VATObjectTypeID AS NVARCHAR(50),
		@VATObjectID AS NVARCHAR(50),
		@VATNo AS NVARCHAR(50),	
		@VATTypeID AS NVARCHAR(50),
		@VATRate AS DECIMAL(28, 8),
		@VATGroupID AS NVARCHAR(50),
		@CreateUserID AS NVARCHAR(50),
		@SignValues AS INT,
		@Quantity AS DECIMAL(28, 8),
		@DueDate AS DATETIME,
		@VATTradeName AS NVARCHAR(250),
		@InvoiceCode VARCHAR(50), 
		@InvoiceSign VARCHAR(50),
		@DebitAccountID NVARCHAR(50),
		@CreditAccountID NVARCHAR(50),
		----
@INcur CURSOR,		
@VATType as NVARCHAR(50),
@Ana06ID as NVARCHAR(50),
@Ana06Name as NVARCHAR(MAX),
@TDescription as NVARCHAR(MAX),
@InventoryID as VARCHAR(50),
@InventoryName as NVARCHAR(250),
@UnitID as VARCHAR(50),
@UnitPrice AS DECIMAL(28, 8),
@TransactionID_1 AS VARCHAR(50)

SET @D90V4001Cursor = CURSOR SCROLL KEYSET FOR
		SELECT	VoucherID, VoucherNo, InvoiceNo, Serial,  InvoiceDate , 
				OriginalTaxAmount, ConvertedTaxAmount , OriginalNetAmount, ConvertedNetAmount,
				SignNetAmount,	SignTaxAmount, SignValues, Quantity,DueDate,VATTypeID, VATGroupID, InvoiceCode, InvoiceSign,
				InventoryID, InventoryName, UnitID, UnitPrice,TransactionID
		FROM #AV7411  

		OPEN @D90V4001Cursor
		FETCH NEXT FROM @D90V4001Cursor INTO
			@VoucherID, @VoucherNo, @InvoiceNo,	@Serial, @InvoiceDate, 
	 		@OriginalTaxAmount, @ConvertedTaxAmount,@OriginalNetAmount, @ConvertedNetAmount,
			@SignNetAmount,@SignTaxAmount, @SignValues, @Quantity,@DueDate,
			@VATTypeID, @VATGroupID, @InvoiceCode, @InvoiceSign,
			@InventoryID, @InventoryName, @UnitID, @UnitPrice,@TransactionID_1
			'
--Print @strDeclare	

Set @strSQL2='		
	WHILE @@FETCH_STATUS = 0

	BEGIN
			set @BDescription = ''''
			set @VDescription=''''
			set @Object_Name =''''
			set @VATNO =''''
			set @VATObjectID = ''''
		SELECT 		@VoucherNo = T2.VoucherNo, @VoucherTypeID = T2.VoucherTypeID,	
					@VoucherDate = T2.VoucherDate,
					@TranMonth = T2.TranMonth,	@TranYear = T2.TranYear,
					@ExchangeRate = T2.ExchangeRate, 
					@CurrencyID = T2.CurrencyID,
					@CreateUserID = T2.CreateUserID,
					@DebitAccountID = T2.DebitAccountID,
					@CreditAccountID = T2.CreditAccountID

		FROM AT7419 AS T2
		WHERE	
			T2.VoucherNo = @VoucherNo AND
			T2.Serial = @Serial  AND
			T2.InvoiceNo = @InvoiceNo
			
		SELECT 
			@VDescription = T2.VDescription,
			@BDescription = T2.BDescription
		FROM AT7419 AS T2
		WHERE	
				(T2.VoucherNo = @VoucherNo) AND
				(T2.Serial = @Serial) AND
				(T2.InvoiceNo = @InvoiceNo ) AND
				((T2.AccountID >= '''+@NetAccountID1From+''' AND T2.AccountID <= '''+@NetAccountID1To+''') OR
				(T2.AccountID >= '''+@NetAccountID2From+''' AND T2.AccountID <= '''+@NetAccountID2To+''') OR
				(T2.AccountID >= '''+@NetAccountID3From+''' AND T2.AccountID <= '''+@NetAccountID3To+''') OR
				(T2.AccountID >= '''+@NetAccountID4From+''' AND T2.AccountID <= '''+@NetAccountID4To+''')  OR
				(T2.AccountID >= '''+@NetAccountID5From+''' AND T2.AccountID <= '''+@NetAccountID5To+'''))
			ORDER BY T2.ConvertedAmount 
			 
			if @BDescription =''''
			SELECT 
			@VDescription = T2.VDescription,
			@BDescription = T2.BDescription
		FROM AT7419 AS T2
		WHERE	
				(T2.VoucherNo = @VoucherNo) AND
				(T2.Serial = @Serial) AND
				(T2.InvoiceNo = @InvoiceNo ) AND
				((T2.AccountID >= '''+@TaxAccountID1From+''' AND T2.AccountID <= '''+@TaxAccountID1To+''') OR
				(T2.AccountID >= '''+@TaxAccountID2From+''' AND T2.AccountID <= '''+@TaxAccountID2To+''') OR
				(T2.AccountID >= '''+@TaxAccountID3From+''' AND T2.AccountID <= '''+@TaxAccountID3To+'''))'	

--Print @strSQL1
					
Set @strSQL3='
			Set @VATRate = Null
			Select TOP 1 @VATRate  = VATRate
			FROM AT7419 AS T2 left join AT1010 on AT1010.VATGroupID = T2.VATGroupID
			WHERE	
					T2.VATGroupID = @VATGroupID AND
					(T2.VoucherNo = @VoucherNo) AND
					(T2.Serial = @Serial) AND
					(T2.InvoiceNo = @InvoiceNo ) AND
					((T2.AccountID >= '''+@TaxAccountID1From+''' AND T2.AccountID <= '''+@TaxAccountID1To+''' ) OR
					(T2.AccountID >= '''+@TaxAccountID2From+''' AND T2.AccountID <= '''+@TaxAccountID2To+''' ) OR
					(T2.AccountID >= '''+@TaxAccountID3From+''' AND T2.AccountID <= '''+@TaxAccountID3To+''' ))
			SELECT TOP 1
				@VATObjectID = T2.VATObjectID
			FROM AT7419 AS T2
			WHERE	
				T2.VoucherID = @VoucherID AND
				T2.Serial = @Serial AND
				T2.InvoiceNo = @InvoiceNo AND
				T2.VATObjectID IS NOT NULL AND T2.VATObjectID <>''''
	
				SELECT TOP 1
					@VATObjectID = T2.ObjectID
				FROM AT7419 AS T2
				WHERE	
					(T2.Serial = @Serial) AND
					(T2.InvoiceNo = @InvoiceNo ) AND
					--((T2.AccountID >= '''+@NetAccountID1From+''' AND T2.AccountID <= '''+@NetAccountID1To+''') OR
					--(T2.AccountID >= '''+@NetAccountID2From+''' AND T2.AccountID <= '''+@NetAccountID2To+''') OR
					--(T2.AccountID >= '''+@NetAccountID3From+''' AND T2.AccountID <= '''+@NetAccountID3To+'''))
					((T2.AccountID >= '''+@TaxAccountID1From+''' AND T2.AccountID <= '''+@TaxAccountID1To+''') OR
					(T2.AccountID >= '''+@TaxAccountID2From+''' AND T2.AccountID <= '''+@TaxAccountID2To+''') OR
					(T2.AccountID >= '''+@TaxAccountID3From+''' AND T2.AccountID <= '''+@TaxAccountID3To+'''))
				
			SELECT TOP 1  ---- lay ten doi tuong
				@Object_Name =Case when isnull(T43.VATObjectName,'''') ='''' then
							Case when isnull(Obj1.ObjectName,'''')=''''  then isnull(Obj2.ObjectName,'''') else Obj1.ObjectName end  
						    else T43.VATObjectName end,

				@VATNo = Case when isnull(T43.VATNo,'''')='''' then
							Case when isnull(Obj1.VATNo,'''')=''''  then isnull(Obj2.VATNo,'''') else Obj1.VATNo end  
						    else T43.VATNo end,

				@Object_Address = Case when isnull(T43.ObjectAddress,'''') ='''' then
							Case when isnull(Obj1.Address,'''')=''''  then isnull(Obj2.Address,'''') else Obj1.Address end  
						    else T43.ObjectAddress  end,

				@VATTradeName = Obj1.TradeName

From AT7419  as T43	left join AT1202 Obj1 on Obj1.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T43.VATObjectID = Obj1.ObjectID								
				left join AT1202 Obj2 on Obj2.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T43.ObjectID = Obj2.ObjectID
		              Where
						T43.VoucherNo = @VoucherNo AND
						T43.Serial = @Serial AND
						T43.InvoiceNo = @InvoiceNo	
						--((T43.AccountID >= '''+@NetAccountID1From+''' AND T43.AccountID <= '''+@NetAccountID1To+''') OR
						--(T43.AccountID >= '''+@NetAccountID2From+''' AND T43.AccountID <= '''+@NetAccountID2To+''') OR
						--(T43.AccountID >= '''+@NetAccountID3From+''' AND T43.AccountID <= '''+@NetAccountID3To+''') OR
						--(T43.AccountID >= '''+@NetAccountID4From+''' AND T43.AccountID <= '''+@NetAccountID4To+''') OR
						--(T43.AccountID >= '''+@NetAccountID5From+''' AND T43.AccountID <= '''+@NetAccountID5To+'''))
						
						--((T43.AccountID >= '''+@TaxAccountID1From+''' AND T43.AccountID <= '''+@TaxAccountID1To+''' ) OR
						--(T43.AccountID >= '''+@TaxAccountID2From+''' AND T43.AccountID <= '''+@TaxAccountID2To+''' ) OR
						--(T43.AccountID >= '''+@TaxAccountID3From+''' AND T43.AccountID <= '''+@TaxAccountID3To+''' ))
						and '

		+ case when Exists (SELECT 1 FROM AT7410 A10 INNER JOIN AT9000 A90 ON A10.DivisionID = A90.DivisionID WHERE A10.ReportCode = @ReportCode AND (A90.CreditAccountID BETWEEN ISNULL(A10.TaxAccountID1From, '') AND ISNULL(A10.TaxAccountID1To, '') OR A90.CreditAccountID BETWEEN ISNULL(A10.TaxAccountID2From, '') AND ISNULL(A10.TaxAccountID2To, '') OR A90.CreditAccountID BETWEEN ISNULL(A10.TaxAccountID3From, '') AND ISNULL(A10.TaxAccountID3To, '')))
		 then 'D_C=''C''' else 'D_C=''D''' end
--Print @strSQL2

Set @strSQL4 ='
			If @Object_Name =''''
				
				SELECT TOP 1  ---- lay ten doi tuong
				@VATObjectID =Case when isnull(T43.VATObjectID,'''') ='''' then
							Case when isnull(Obj1.ObjectID,'''')=''''  then isnull(Obj2.ObjectID,'''') else Obj1.ObjectID end  
						    else T43.VATObjectID end,
				@Object_Name =Case when isnull(T43.VATObjectName,'''') ='''' then
							Case when isnull(Obj1.ObjectName,'''')=''''  then isnull(Obj2.ObjectName,'''') else Obj1.ObjectName end  
						    else T43.VATObjectName end,
				
				@VATNo = Case when isnull(T43.VATNo,'''') ='''' then
							Case when isnull(Obj1.VATNo,'''')=''''  then isnull(Obj2.VATNo,'''') else Obj1.VATNo end  
						    else T43.VATNo end,
				@Object_Address = Case when isnull(T43.ObjectAddress,'''') ='''' then
							Case when isnull(Obj1.Address,'''')=''''  then isnull(Obj2.Address,'''') else Obj1.Address end  
						    else T43.ObjectAddress  end,

				@VATTradeName = Obj1.TradeName
				
			From AT7419  as T43	
			left join AT1202 Obj1 on Obj1.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T43.VATObjectID = Obj1.ObjectID								
						left join AT1202 Obj2 on Obj2.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T43.ObjectID = Obj2.ObjectID          
			 Where			
						T43.VoucherNo = @VoucherNo AND
						T43.Serial = @Serial AND
						T43.InvoiceNo = @InvoiceNo
						--((T43.AccountID >= '''+@TaxAccountID1From+''' AND T43.AccountID <= '''+@TaxAccountID1To+''' ) OR
						--(T43.AccountID >= '''+@TaxAccountID2From+''' AND T43.AccountID <= '''+@TaxAccountID2To+''' ) OR
						--(T43.AccountID >= '''+@TaxAccountID3From+''' AND T43.AccountID <= '''+@TaxAccountID3To+''' ))
						--((T43.AccountID >= '''+@NetAccountID1From+''' AND T43.AccountID <= '''+@NetAccountID1To+''') OR
						--(T43.AccountID >= '''+@NetAccountID2From+''' AND T43.AccountID <= '''+@NetAccountID2To+''') OR
						--(T43.AccountID >= '''+@NetAccountID3From+''' AND T43.AccountID <= '''+@NetAccountID3To+''') OR
						--(T43.AccountID >= '''+@NetAccountID4From+''' AND T43.AccountID <= '''+@NetAccountID4To+''') OR
						--(T43.AccountID >= '''+@NetAccountID5From+''' AND T43.AccountID <= '''+@NetAccountID5To+'''))
			
			and '+ case when Exists (SELECT 1 FROM AT7410 A10 INNER JOIN AT9000 A90 ON A10.DivisionID = A90.DivisionID WHERE A10.ReportCode = @ReportCode AND (A90.CreditAccountID BETWEEN ISNULL(A10.TaxAccountID1From, '') AND ISNULL(A10.TaxAccountID1To, '') OR A90.CreditAccountID BETWEEN ISNULL(A10.TaxAccountID2From, '') AND ISNULL(A10.TaxAccountID2To, '') OR A90.CreditAccountID BETWEEN ISNULL(A10.TaxAccountID3From, '') AND ISNULL(A10.TaxAccountID3To, '')))
		 then 'D_C=''C''' else 'D_C=''D''' end + ''

Set @strSQL4_0 ='			
			INSERT INTO AT7411 (TypeID,	
						DivisionID, VoucherID, Serial, InvoiceNo, VoucherNo, VoucherTypeID,
						BDescription, VDescription,
						VoucherDate, InvoiceDate,
						TranMonth, TranYear,
						OriginalTaxAmount, ConvertedTaxAmount, 
						OriginalNetAmount, ConvertedNetAmount,
						SignNetAmount, SignTaxAmount,
						ExchangeRate,	CurrencyID,
						VATObjectID,	VATNo,	VATObjectName,
						ObjectAddress,	VATGroupID, VATTypeID, VATRate,
						Quantity, DueDate, VATTradeName, InvoiceCode, InvoiceSign, DebitAccountID, CreditAccountID,
						InventoryID, InventoryName, UnitID, UnitPrice)
				SELECT 0 TypeID,
					'''+@DivisionID+''', @VoucherID, @Serial, @InvoiceNo,@VoucherNo,@VoucherTypeID,
					@BDescription,	
					@VDescription,
					@VoucherDate,	@InvoiceDate,
					@TranMonth,	@TranYear,
					Case when  @SignValues <0 then - @OriginalTaxAmount else @OriginalTaxAmount end, 
					Case when  @SignValues <0 then - @ConvertedTaxAmount else @ConvertedTaxAmount end, 
					Case when  @SignValues <0 then - @OriginalNetAmount else @OriginalNetAmount end , 
					Case when  @SignValues <0 then - @ConvertedNetAmount else @ConvertedNetAmount end,
					'+@strSQL_SNAmount+',
					@SignTaxAmount,
					@ExchangeRate,@CurrencyID,
					@VATObjectID,
					@VATNo, @Object_Name, @Object_Address,
					@VATGroupID,
					@VATTypeID,
					@VATRate,
					'+@strSQL_Quantity+'
					@DueDate, @VATTradeName,@InvoiceCode, @InvoiceSign, @DebitAccountID, @CreditAccountID,
					@InventoryID, @InventoryName, @UnitID, @UnitPrice
					FROM AT7419 T7419 WITH (NOLOCK)
					WHERE T7419.VoucherID = @VoucherID AND
						T7419.VoucherNo = @VoucherNo AND
						T7419.Serial = @Serial AND
						T7419.InvoiceNo = @InvoiceNo AND
						(T7419.TransactionID IN (@TransactionID_1) OR T7419.InventoryID IS NULL)
					GROUP BY T7419.BatchID,   
					T7419.VoucherID,
					T7419.DivisionID,
					T7419.VoucherNo,
					T7419.Serial, T7419.DueDate, 
					T7419.InvoiceNo, T7419.InvoiceDate, T7419.VAtTypeID, T7419.VATGroupID, T7419.InvoiceCode, T7419.InvoiceSign
					'

Set @strSQL4_1 ='
					-- Thêm chi tiết hóa đơn
					INSERT INTO AT7411 (TypeID,	
						DivisionID, VoucherID, Serial, InvoiceNo, VoucherNo, VoucherTypeID,
						BDescription, VDescription,
						VoucherDate, InvoiceDate,
						TranMonth, TranYear,
						OriginalTaxAmount, ConvertedTaxAmount, 
						OriginalNetAmount, ConvertedNetAmount,
						SignNetAmount, SignTaxAmount,
						ExchangeRate,	CurrencyID,
						VATObjectID,	VATNo,	VATObjectName,
						ObjectAddress,	VATGroupID, VATTypeID, VATRate,
						Quantity, DueDate, VATTradeName, InvoiceCode, InvoiceSign, DebitAccountID, CreditAccountID,
						InventoryID, InventoryName, UnitID, UnitPrice)

					SELECT 1 TypeID,'''+@DivisionID+''', T7419.VoucherID, T7419.Serial as Serial, T7419.InvoiceNo as InvoiceNo,T7419.VoucherNo,T7419.VoucherTypeID,
					T7419.BDescription as BDescription, T7419.VDescription as VDescription,
					T7419.VoucherDate,	T7419.InvoiceDate as InvoiceDate,
					T7419.TranMonth,	T7419.TranYear,
					Case when  @SignValues <0 then - @OriginalTaxAmount else @OriginalTaxAmount end, 
					Case when  @SignValues <0 then - @ConvertedTaxAmount else @ConvertedTaxAmount end, 
					Case when  @SignValues <0 then - @OriginalNetAmount else @OriginalNetAmount end , 
					Case when  @SignValues <0 then - @ConvertedNetAmount else @ConvertedNetAmount end,
					'+@strSQL_SNAmount+'
					,@SignTaxAmount,
					T7419.ExchangeRate,T7419.CurrencyID,
					T7419.VATObjectID,
					T7419.VATNo as VATNo, @Object_Name as Object_Name, @Object_Address as Object_Address,
					T7419.VATGroupID,
					T7419.VATTypeID,
					@VATRate,
					'+@strSQL_Quantity+'
					T7419.DueDate, @VATTradeName,T7419.InvoiceCode as InvoiceCode, T7419.InvoiceSign as InvoiceSign, T7419.DebitAccountID, T7419.CreditAccountID,
					T7419.InventoryID, ISNULL(T7419.InventoryName,T7419.BDescription) as InventoryName, T7419.UnitID, T7419.UnitPrice 
					FROM AT7419 T7419 WITH (NOLOCK)
					WHERE T7419.VoucherID = @VoucherID AND
						T7419.VoucherNo = @VoucherNo AND
						T7419.Serial = @Serial AND
						T7419.InvoiceNo = @InvoiceNo AND
						T7419.InventoryID IS NOT NULL AND 
						T7419.TransactionID NOT IN (@TransactionID_1)
					GROUP BY T7419.VoucherID, T7419.Serial, T7419.InvoiceNo,T7419.VoucherNo,T7419.VoucherTypeID,
							T7419.BDescription, T7419.VDescription,
							T7419.VoucherDate,	T7419.InvoiceDate,
							T7419.TranMonth,	T7419.TranYear,T7419.ExchangeRate,T7419.CurrencyID,
							T7419.VATObjectID,
							T7419.VATNo,
							T7419.VATGroupID,
							T7419.VATTypeID,
							T7419.Quantity,T7419.DueDate,T7419.InvoiceCode, T7419.InvoiceSign, T7419.DebitAccountID, T7419.CreditAccountID,
							T7419.InventoryID, T7419.InventoryName, T7419.BDescription, T7419.UnitID, T7419.UnitPrice'

Set @strSQL4_2 ='					
			FETCH NEXT FROM @D90V4001Cursor INTO	
					@VoucherID, 
					@VoucherNo, @InvoiceNo,@Serial, @InvoiceDate,
					@OriginalTaxAmount, @ConvertedTaxAmount,@OriginalNetAmount,@ConvertedNetAmount, 
					@SignNetAmount,@SignTaxAmount, @SignValues, @Quantity,@DueDate,@VATTypeID, @VATGroupID, @InvoiceCode, @InvoiceSign,
					@InventoryID, @InventoryName, @UnitID, @UnitPrice,@TransactionID_1
		END
		CLOSE @D90V4001Cursor
		DEALLOCATE @D90V4001Cursor'


---------------------------Date: 14/11/2007 Thuy Tuyen viet de in sert dong trong  -------------------
 ---Step1: TAO BANG TAM AT7412 -- T?o b?ng ? ngoài
--Print @strSQL3

Set @strSQL5 ='
declare @ReportCode1 NVARCHAR(50),
		@VATTypeid1 NVARCHAR(50),
		@VATTypeid2 NVARCHAR(50),
		@VATTypeid3 NVARCHAR(50),
		@VATTypeid4 NVARCHAR(50),
		@VATTypeid5 NVARCHAR(50),
		@VATTypeid6 NVARCHAR(50),
		@VATTypeid7 NVARCHAR(50),
		@isVATType tinyint,
		@isVATGroup tinyint,
		@IsVATI tinyint,
		@VATGroupID1 NVARCHAR(50) ,
		@VATGroupID2 NVARCHAR(50), 
		@VATGroupID3 NVARCHAR(50), 
		@VATGroupID4 NVARCHAR(50),
		@VATGroupID5 NVARCHAR(50),
		@VATGroupID6 NVARCHAR(50),
		@VATGroupID7 NVARCHAR(50),
		@i tinyint,
		@tmp AS CURSOR

Delete At7412
set @tmp = cursor scroll for 
		Select 
				reportcode,vattypeid1,vattypeid2,vattypeid3,vattypeid4,vattypeid5,vattypeid6,vattypeid7,isvattype ,IsVATIn,
				VATGroupID1,VATGroupID2,VATGroupID3,VATGroupID4,VATGroupID5,VATGroupID6,VATGroupID7, isVATGroup
		From	at7410
		Where	DivisionID = '''+@DivisionID+'''

open @tmp

FETCH NEXT FROM @tmp
INTO  @reportcode1,@VATTypeid1,@VATTypeid2,@VATTypeid3,@VATTypeid4, @VATTypeid5, @VATTypeid6, @VATTypeid7
 ,@isVATType,@IsVATI, @VATGroupID1, @VATGroupID2, @VATGroupID3, @VATGroupID4, @VATGroupID5, @VATGroupID6, @VATGroupID7
 , @isVATGroup

WHILE @@FETCH_STATUS = 0
begin
	
		set @i=1
		while @i<8
		begin
			if @i=1
			begin
				INSERT INTO AT7412 (DivisionID, ReportCode,VATTypeID,VATGroupID,IsVATIn,IsVATType,isVATGroup)
					 VALUES ('''+@DivisionID+''', @ReportCode1,@VATTypeID1,@VATGroupID1,@IsVATI,@IsVATType,@isVATGroup) 
			end
			if @i=2
			begin
				INSERT INTO AT7412 (DivisionID, ReportCode,VATTypeID,VATGroupID,IsVATIn,IsVATType,isVATGroup)
					 VALUES ('''+@DivisionID+''', @ReportCode1, @VATTypeID2, @VATGroupID2,@IsVATI,@IsVATType,@isVATGroup) 
			end
			if @i=3
			begin
				INSERT INTO AT7412 (DivisionID, ReportCode,VATTypeID,VATGroupID,IsVATIn,IsVATType,isVATGroup)
					 VALUES ('''+@DivisionID+''', @ReportCode1,@VATTypeID3,@VATGroupID3,@IsVATI,@IsVATType,@isVATGroup) 
			end
			if @i=4
			begin
				INSERT INTO AT7412 (DivisionID, ReportCode,VATTypeID,VATGroupID,IsVATIn,IsVATType,isVATGroup)
					 VALUES ('''+@DivisionID+''', @ReportCode1,@VATTypeID4,@VATGroupID4,@IsVATI,@IsVATType,@isVATGroup) 
			end
			if @i=5
			begin
				INSERT INTO AT7412 (DivisionID, ReportCode,VATTypeID,VATGroupID,IsVATIn,IsVATType,isVATGroup)
					 VALUES ('''+@DivisionID+''', @ReportCode1,@VATTypeID5,@VATGroupID5,@IsVATI,@IsVATType,@isVATGroup) 
			end

			if @i=6
			begin
				INSERT INTO AT7412 (DivisionID, ReportCode,VATTypeID,VATGroupID,IsVATIn,IsVATType,isVATGroup)
					 VALUES ('''+@DivisionID+''', @ReportCode1,@VATTypeID6,@VATGroupID6,@IsVATI,@IsVATType,@isVATGroup) 
			end

			if @i=7
			begin
				INSERT INTO AT7412 (DivisionID, ReportCode,VATTypeID,VATGroupID,IsVATIn,IsVATType,isVATGroup)
					 VALUES ('''+@DivisionID+''', @ReportCode1,@VATTypeID7,@VATGroupID7,@IsVATI,@IsVATType,@isVATGroup) 
			end
			set @i = @i + 1
		end

	FETCH NEXT FROM @tmp
	INTO 
	@reportcode1,@VATTypeid1,@VATTypeid2,@VATTypeid3,@VATTypeid4,@VATTypeid5,@VATTypeid6,@VATTypeid7,
	@isVATType, @IsVATI, @VATGroupID1, @VATGroupID2, @VATGroupID3, @VATGroupID4,@VATGroupID5,@VATGroupID6,@VATGroupID7
	,@isVATGroup
end

CLOSE @tmp
DEALLOCATE @tmp'

------------------------------------------
--Step 2 : Them dong 0 vao AT7411
--Print @strSQL4

IF @IsVATIn = 1   --In dau vao
Set @strSQL6 ='
	SET @Incur = cursor  scroll  keyset for
		 Select  VAtTypeID,VATGroupID  From AT7412 
		 Where  isnull (VAtTypeID,'''') 
		 Not in( Select isnull (VATTypeID,'''')   from AT7411 Where DivisionID = '''+@DivisionID+''' ) 
		 and ReportCode = '''+@ReportCode+'''  and isnull (VAtTypeID,'''') <> ''''
	OPEN  @Incur
	FETCH NEXT FROM @Incur INTO @VAtTypeID, @VATGroupID
	WHILE  @@FETCH_STATUS = 0
	BEGIN
		
	 	
			If  exists ( select top 1 1 from AT7412 
						Where ReportCode = '''+@ReportCode+''' and   IsVATin =1 
						and  VAtTypeID Not in( Select  isnull (VATTypeID,'''')  from AT7411  Where DivisionID = '''+@DivisionID+''')) 
				Begin
					INSERT INTO AT7411 (DivisionID, ConvertedNetAmount,ConvertedTaxAmount,VATTypeID )
					VALUES ('''+@DivisionID+''',0,0,@VATTypeID)	
				End
	FETCH NEXT FROM  @Incur INTO @VAtTypeID,@VATGroupID
	END	
	CLOSE @Incur
	DEALLOCATE @Incur'

IF @IsVATIn = 0 -- In dau ra 
Set @strSQL6 ='
	SET @Incur = cursor  scroll  keyset for
		 Select 
		 VAtTypeID,VATGroupID  From AT7412 
		 Where  isnull (VAtGroupID,'''') Not in( Select isnull (VATGroupID,'''')   from AT7411 Where DivisionID = '''+@DivisionID+''' ) 
		 and ReportCode = '''+@ReportCode+'''  and isnull (VATGroupID,'''') <> ''''
	OPEN  @Incur
	FETCH NEXT FROM @Incur INTO @VAtTypeID,@VATGroupID
	WHILE  @@FETCH_STATUS = 0
	BEGIN
		If  exists ( select top 1 1 from AT7412 Where    ReportCode = '''+@ReportCode+''' and IsVATin = 0    and  VATGroupID
			 Not in( Select  isnull (VATGroupID,'''')  from AT7411  Where DivisionID = '''+@DivisionID+''')) 
		Begin
			INSERT INTO AT7411 (DivisionID, ConvertedNetAmount,ConvertedTaxAmount,VATGroupID )
			VALUES ('''+@DivisionID+''', 0,0, @VATGroupID)	
		End
			
	FETCH NEXT FROM  @Incur INTO  @VAtTypeID,@VATGroupID
	END	
	CLOSE @Incur
	DEALLOCATE @Incur'

PRINT @strSQL00
PRINT @strSQL
PRINT @strSQL1
PRINT @strDeclare
PRINT @strSQL2 
PRINT @strSQL3 
PRINT @strSQL4 
PRINT @strSQL4_0
PRINT @strSQL4_1
PRINT @strSQL4_2
PRINT @strSQL5
PRINT @strSQL6
EXEC (@strSQL00+ @strSQL+@strSQL1+@strDeclare+@strSQL2+ @strSQL3+ @strSQL4+ @strSQL4_0+ @strSQL4_1+ @strSQL4_2 + @strSQL5+@strSQL6)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
