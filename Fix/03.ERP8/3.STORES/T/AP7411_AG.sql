﻿IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7411_AG]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP7411_AG]
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
-----Modified on 08/03/2016 on Phuong Thao : CH?nh s?a ti?n Thu? nguyên t? cho TH bút toán gi?m giá hàng bán (tuong t? nhu ti?n quy d?i)
-----Modified on 14/03/2016 by Ti?u Mai: B? TK N?, Có. Fix bug tk 335 không lên b?ng kê thu? d?u vào
-----Modified by Tiểu Mai on 26/10/2016: Bổ sung lấy mã đối tượng VAT
-----Modified by Hải Long on 26/12/2016: Bổ sung lấy mặt hàng có giá trị cao nhất thay thế cho Description
-----Modified by Tiểu Mai on 19/05/2017: Bổ sung lấy doanh số cho thu tiền trả lại (đầu vào), Fix lấy đúng đối tượng thuế khi cùng số hóa đơn
---- Modified by Tiểu Mai on 30/05/2017: Bổ sung tham số @UserID cho ANGEL 
---- Modified by Tiểu Mai on 23/08/2017: Bổ sung loại chứng từ TP cho hóa đơn mua vào
---- Modified by Bảo Anh on 16/03/2018: Bổ sung trường CreateDate, sửa lỗi khi không nhóm theo Loại hóa đơn hoặc Nhóm thuế
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE PROCEDURE [dbo].[AP7411_AG]
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
		@VoucherTypeID AS NVARCHAR(50),
		@VoucherTypeIDFrom AS NVARCHAR(50),
		@VoucherTypeIDTo AS NVARCHAR(50),
		@ReportCode AS NVARCHAR(50),
		@UserID AS NVARCHAR(50)
	
AS
DECLARE @strSQL NVARCHAR(MAX)='',
		@strSQL1 NVARCHAR(MAX)='',
		@strSQL2 NVARCHAR(MAX)='',
		@strSQL3 NVARCHAR(MAX)='',
		@strSQL4 NVARCHAR(MAX)='',
		@strSQL5 NVARCHAR(MAX)='',
		@strSQL6 NVARCHAR(MAX)='',
		@strDeclare NVARCHAR(MAX)='',
		@strSQL10 NVARCHAR(MAX)=''

Declare @CustomerName INT
--Tao bang tam de kiem tra day co phai la khach hang Sieu Thanh khong (CustomerName = 16)
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)
		
		
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
IF @CustomerName =17 --(Customized IPL : 1 HD co nhieu phieu)
	SET @strSQL = @strSQL + ' 
	SELECT T7419.UserID, (CASE WHEN T7419.VATTypeID = ''VHDSD'' Then ''VGTGT1'' Else T7419.VATTypeID END) AS VATTypeID , 
		T7419.VATGroupID, Max(T7419.BatchID) as BatchID , Max(T7419.VoucherID) as VoucherID, 
		T7419.DivisionID,	Max(T7419.VoucherNo) as VoucherNo, 	T7419.Serial, 
		T7419.DueDate,		T7419.InvoiceDate,	T7419.InvoiceNo, T7419.InvoiceCode, T7419.InvoiceSign,'
ELSE

	SET @strSQL = @strSQL + ' 
	SELECT T7419.UserID, (CASE WHEN T7419.VATTypeID = ''VHDSD'' Then ''VGTGT1'' Else T7419.VATTypeID END) AS VATTypeID , 
			T7419.VATGroupID, (T7419.BatchID) as BatchID , (T7419.VoucherID) as VoucherID, 
			T7419.DivisionID,	(T7419.VoucherNo) as VoucherNo, 	T7419.Serial, 
			T7419.DueDate,		T7419.InvoiceDate,	T7419.InvoiceNo, T7419.InvoiceCode, T7419.InvoiceSign, T7419.CreateDate,'

If @IsVATIn = 1  
	Set @strSQL = @strSQL +' Sum(CASE WHEN (TransactionTypeID in (''T25'', ''T35'') or  VoucherTypeID = ''TP'') then - 1 else  1 end ) AS  SignValues, '
Else
 	Set @strSQL = @strSQL + ' Sum(CASE WHEN ( TransactionTypeID in (''T24'', ''T34'')  or  VoucherTypeID LIKE ''HG%'')   then - 1 else  1 end ) AS  SignValues, '
		


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

SET @strSQL = @strSQL + ') AND (T7419.D_C like ''D'' or (T7419.D_C like ''C'' and (T7419.TransactionTypeID =''T35'') OR VoucherTypeID = ''TP'' AND T7419.AccountID NOT IN (''6417'',''6418'',''6427'',''62770'' ) )) THEN T7419.ConvertedAmount 
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

SET @strSQL = @strSQL + ') AND ( T7419.D_C like ''C'' or (T7419.D_C like ''D'' and (T7419.TransactionTypeID =''T34'' or  VoucherTypeID LIKE ''HG%'') )) THEN T7419.ConvertedAmount 
ELSE 
CASE WHEN ((T7419.AccountID >=''' + ISNULL( @TaxAccountID1From,'') + ''' AND T7419.AccountID <='''+ ISNULL(@TaxAccountID1To,'') +''')
'
IF (@TaxAccountID2From is Not NULL OR @TaxAccountID2From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @TaxAccountID2From + ''' AND T7419.AccountID <='''+ @TaxAccountID2To +''')'

IF (@TaxAccountID3From is Not NULL OR @TaxAccountID3From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @TaxAccountID3From + ''' AND T7419.AccountID <='''+ @TaxAccountID3To +''')'

SET @strSQL = @strSQL + ') AND T7419.D_C = ''D'' and Isnull(T7419.TransactionTypeID,'''') <>''T34'' 
							AND (T7419.AccountID <> T7419.CorAccountID)  AND  Isnull(VoucherTypeID,'''') NOT IN (''HG'',''HG1'',''HG2'') THEN T7419.ConvertedAmount * (-1) ELSE 0 END END) AS ConvertedTaxAmount,'
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

SET @strSQL = @strSQL + ') AND (T7419.D_C like ''D''  or (T7419.D_C like ''C'' and (T7419.TransactionTypeID =''T35'') OR VoucherTypeID = ''TP'' AND T7419.AccountID NOT IN (''6417'',''6418'', ''6427'',''62770'' ))) THEN T7419.OriginalAmount 
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

SET @strSQL = @strSQL + ') AND ( T7419.D_C like ''C'' or (T7419.D_C like ''D'' and (T7419.TransactionTypeID =''T34'' or  VoucherTypeID LIKE ''HG%'') )) THEN T7419.OriginalAmount 
ELSE 
CASE WHEN ((T7419.AccountID >=''' + ISNULL( @TaxAccountID1From,'') + ''' AND T7419.AccountID <='''+ ISNULL(@TaxAccountID1To,'') +''')
'
IF (@TaxAccountID2From is Not NULL OR @TaxAccountID2From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @TaxAccountID2From + ''' AND T7419.AccountID <='''+ @TaxAccountID2To +''')'

IF (@TaxAccountID3From is Not NULL OR @TaxAccountID3From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @TaxAccountID3From + ''' AND T7419.AccountID <='''+ @TaxAccountID3To +''')'

SET @strSQL = @strSQL + ') AND T7419.D_C = ''D''  and Isnull(T7419.TransactionTypeID,'''') <>''T34'' 
							AND (T7419.AccountID <> T7419.CorAccountID)  AND  Isnull(VoucherTypeID,'''') NOT IN (''HG'',''HG1'',''HG2'') THEN T7419.OriginalAmount * (-1) ELSE 0 END END) AS OriginalTaxAmount,'
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



If @IsVATIn = 1  --- Xac dinh doanh so mua vao
BEGIN

	SET @strSQL = @strSQL +  ') AND (T7419.D_C like ''D'' and T7419.TransactionTypeID not in (''T25'',''T35''))  
	THEN T7419.ConvertedAmount + T7419.ImTaxConvertedAmount 
	ELSE (CASE WHEN ((T7419.AccountID >=''' + ISNULL(@NetAccountID1From,'') + ''' AND T7419.AccountID <='''+ ISNULL(@NetAccountID1To,'') +''')'
--IF (@NetAccountID2From is Not NULL OR @NetAccountID2From <> '')
--	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @NetAccountID2From + ''' AND T7419.AccountID <='''+ @NetAccountID2To +''')'
IF (@NetAccountID3From is Not NULL OR @NetAccountID3From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @NetAccountID3From + ''' AND T7419.AccountID <='''+ @NetAccountID3To +''')'

IF (@TaxAccountID1From is Not NULL OR @TaxAccountID1From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @TaxAccountID1From + ''' AND T7419.AccountID <='''+ @TaxAccountID1To +''' and VoucherTypeID = ''TP'')'

IF (@NetAccountID4From is Not NULL OR @NetAccountID4From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @NetAccountID4From + ''' AND T7419.AccountID <='''+ @NetAccountID4To +''')'
IF (@NetAccountID5From is Not NULL OR @NetAccountID5From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @NetAccountID5From + ''' AND T7419.AccountID <='''+ @NetAccountID5To +''')'

SET @strSQL = @strSQL +  ') AND (T7419.D_C like ''C'' and (T7419.TransactionTypeID IN (''T25'',''T01'',''T21'') OR VoucherTypeID = ''TP'' AND T7419.AccountID NOT IN (''6417'',''6418'', ''6427'',''62770'' ))) 
	THEN (T7419.ConvertedAmount + T7419.ImTaxConvertedAmount) * (-1) 
	ELSE 0 END) END) AS ConvertedNetAmount, '
	
END		
Else		---- Xac dinh doanh so ban ra
BEGIN 
	SET @strSQL = @strSQL +  ') or (T7419.D_C like ''D'' AND VoucherTypeID LIKE ''HD1%'' AND (DebitAccountID Like ''5211%'' Or DebitAccountID Like ''5213%''))  AND ( T7419.D_C like ''C'' or (T7419.D_C like ''D'' and  (T7419.TransactionTypeID in (''T24'',''T65'') or  VoucherTypeID LIKE ''HG%'') )) '

	SET @strSQL = @strSQL + ' THEN (T7419.ConvertedAmount + T7419.ImTaxConvertedAmount) * CASE WHen (VoucherTypeID LIKE ''HD1%'' AND (DebitAccountID Like ''5211%'' Or DebitAccountID Like ''5213%'')) then -1 else 1 end ELSE 0 END) AS ConvertedNetAmount,'
END 

SET @strSQL = @strSQL + ' SUM (CASE WHEN 
					((T7419.AccountID >=''' + ISNULL(@NetAccountID1From,'') + ''' AND T7419.AccountID <='''+ ISNULL(@NetAccountID1To,'') +''')'
IF (@NetAccountID2From is Not NULL OR @NetAccountID2From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @NetAccountID2From + ''' AND T7419.AccountID <='''+ @NetAccountID2To +''')'
IF (@NetAccountID3From is Not NULL OR @NetAccountID3From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @NetAccountID3From + ''' AND T7419.AccountID <='''+ @NetAccountID3To +''')'IF (@NetAccountID4From is Not NULL OR @NetAccountID4From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @NetAccountID4From + ''' AND T7419.AccountID <='''+ @NetAccountID4To +''')'

IF  ( isnull(@NetAccountID5From,'')<> '')
--	Print ' Hello'
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @NetAccountID5From + ''' AND T7419.AccountID <='''+ @NetAccountID5To +''')'

--PRINT '
--'+ @strSQL

IF @IsVATIn = 1  --- Xac dinh doanh so mua vao
BEGIN

	SET @strSQL = @strSQL +  ') AND (T7419.D_C like ''D'' and T7419.TransactionTypeID not in (''T25'',''T35''))  
	THEN T7419.OriginalAmount + T7419.ImTaxOriginalAmount 
	ELSE (CASE WHEN ((T7419.AccountID >=''' + ISNULL(@NetAccountID1From,'') + ''' AND T7419.AccountID <='''+ ISNULL(@NetAccountID1To,'') +''')'
	--IF (@NetAccountID2From is Not NULL OR @NetAccountID2From <> '')
	--	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @NetAccountID2From + ''' AND T7419.AccountID <='''+ @NetAccountID2To +''')'

IF (@NetAccountID3From is Not NULL OR @NetAccountID3From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @NetAccountID3From + ''' AND T7419.AccountID <='''+ @NetAccountID3To +''')'

IF (@TaxAccountID1From is Not NULL OR @TaxAccountID1From <> '')
	SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @TaxAccountID1From + ''' AND T7419.AccountID <='''+ @TaxAccountID1To +''' and VoucherTypeID = ''TP'')'

		SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @NetAccountID4From + ''' AND T7419.AccountID <='''+ @NetAccountID4To +''')'
	IF (@NetAccountID5From is Not NULL OR @NetAccountID5From <> '')
		SET @strSQL = @strSQL + 	' OR (T7419.AccountID >=''' + @NetAccountID5From + ''' AND T7419.AccountID <='''+ @NetAccountID5To +''')'
	
	SET @strSQL = @strSQL +  ') AND (T7419.D_C like ''C'' and (T7419.TransactionTypeID IN (''T25'',''T01'',''T21'') OR VoucherTypeID = ''TP'' AND T7419.AccountID NOT IN (''6417'',''6418'', ''6427'',''62770'' ))) 
	THEN (T7419.OriginalAmount + T7419.ImTaxOriginalAmount) * (-1) 
	ELSE 0 END) END) AS OriginalNetAmount,'
END
ELSE 		---- Xac dinh doanh so ban ra
BEGIN 
	SET @strSQL = @strSQL +  ') AND ( T7419.D_C like ''C'' or (T7419.D_C like ''D'' and  (T7419.TransactionTypeID in (''T24'',''T65'') or  VoucherTypeID LIKE ''HG%'') )) '

	SET @strSQL = @strSQL + ' THEN T7419.OriginalAmount + T7419.ImTaxOriginalAmount ELSE 0 END) AS OriginalNetAmount,'
END 

SET @strSQL10 = @strSQL10 + ' SUM (CASE WHEN 
					((T7419.AccountID >=''' + ISNULL(@NetAccountID1From,'') + ''' AND T7419.AccountID <='''+ ISNULL(@NetAccountID1To,'') +''')'
IF (@NetAccountID2From is Not NULL OR @NetAccountID2From <> '')
	SET @strSQL10 = @strSQL10 + 	' OR (T7419.AccountID >=''' + @NetAccountID2From + ''' AND T7419.AccountID <='''+ @NetAccountID2To +''')'
IF (@NetAccountID3From is Not NULL OR @NetAccountID3From <> '')
	SET @strSQL10 = @strSQL10 + 	' OR (T7419.AccountID >=''' + @NetAccountID3From + ''' AND T7419.AccountID <='''+ @NetAccountID3To +''')'
	IF (@NetAccountID4From is Not NULL OR @NetAccountID4From <> '')
	SET @strSQL10 = @strSQL10 + 	' OR (T7419.AccountID >=''' + @NetAccountID4From + ''' AND T7419.AccountID <='''+ @NetAccountID4To +''')'

IF  ( isnull(@NetAccountID5From,'')<> '')
--	Print ' Hello'
	SET @strSQL10 = @strSQL10 + 	' OR (T7419.AccountID >=''' + @NetAccountID5From + ''' AND T7419.AccountID <='''+ @NetAccountID5To +''')'


If @IsVATIn = 1  --- Xac dinh doanh so mua vao
	SET @strSQL10 = @strSQL10 +  ') AND T7419.D_C like ''D'''
Else		---- Xac dinh doanh so ban ra
	SET @strSQL10 = @strSQL10 +  ') AND T7419.D_C like ''C'''


SET @strSQL10 = @strSQL10 + ' THEN T7419.Quantity ELSE 0 END) AS Quantity, '


If @IsVATIn = 1  --- Thue dau vao
BEGIN
SET @strSQL10 = @strSQL10 +	' SUM (
CASE WHEN ((T7419.AccountID >=''' + ISNULL( @TaxAccountID1From,'') + ''' AND T7419.AccountID <='''+ ISNULL(@TaxAccountID1To,'') +''')'

IF (@TaxAccountID2From is Not NULL OR @TaxAccountID2From <> '')
	SET @strSQL10 = @strSQL10 + 	' OR (T7419.AccountID >=''' + @TaxAccountID2From + ''' AND T7419.AccountID <='''+ @TaxAccountID2To +''')'

IF (@TaxAccountID3From is Not NULL OR @TaxAccountID3From <> '')
	SET @strSQL10 = @strSQL10 + 	' OR (T7419.AccountID >=''' + @TaxAccountID3From + ''' AND T7419.AccountID <='''+ @TaxAccountID3To +''')'

SET @strSQL10 = @strSQL10 + ') AND T7419.D_C = ''D'' THEN T7419.SignAmount 
ELSE 
CASE WHEN ((T7419.AccountID >=''' + ISNULL( @TaxAccountID1From,'') + ''' AND T7419.AccountID <='''+ ISNULL(@TaxAccountID1To,'') +''')
'
IF (@TaxAccountID2From is Not NULL OR @TaxAccountID2From <> '')
	SET @strSQL10 = @strSQL10 + 	' OR (T7419.AccountID >=''' + @TaxAccountID2From + ''' AND T7419.AccountID <='''+ @TaxAccountID2To +''')'

IF (@TaxAccountID3From is Not NULL OR @TaxAccountID3From <> '')
	SET @strSQL10 = @strSQL10 + 	' OR (T7419.AccountID >=''' + @TaxAccountID3From + ''' AND T7419.AccountID <='''+ @TaxAccountID3To +''')'

SET @strSQL10 = @strSQL10 + ') AND T7419.D_C = ''C'' THEN T7419.SignAmount * (-1) ELSE 0 END END) AS SignTaxAmount,'
END

ELSE --- Thue dau ra
BEGIN
SET @strSQL10 = @strSQL10 +	' SUM (
CASE WHEN ((T7419.AccountID >=''' + ISNULL( @TaxAccountID1From,'') + ''' AND T7419.AccountID <='''+ ISNULL(@TaxAccountID1To,'') +''')'

IF (@TaxAccountID2From is Not NULL OR @TaxAccountID2From <> '')
	SET @strSQL10 = @strSQL10 + 	' OR (T7419.AccountID >=''' + @TaxAccountID2From + ''' AND T7419.AccountID <='''+ @TaxAccountID2To +''')'

IF (@TaxAccountID3From is Not NULL OR @TaxAccountID3From <> '')
	SET @strSQL10 = @strSQL10 + 	' OR (T7419.AccountID >=''' + @TaxAccountID3From + ''' AND T7419.AccountID <='''+ @TaxAccountID3To +''')'

SET @strSQL10 = @strSQL10 + ') AND T7419.D_C = ''C'' THEN T7419.SignAmount 
ELSE 
CASE WHEN ((T7419.AccountID >=''' + ISNULL( @TaxAccountID1From,'') + ''' AND T7419.AccountID <='''+ ISNULL(@TaxAccountID1To,'') +''')
'
IF (@TaxAccountID2From is Not NULL OR @TaxAccountID2From <> '')
	SET @strSQL10 = @strSQL10 + 	' OR (T7419.AccountID >=''' + @TaxAccountID2From + ''' AND T7419.AccountID <='''+ @TaxAccountID2To +''')'

IF (@TaxAccountID3From is Not NULL OR @TaxAccountID3From <> '')
	SET @strSQL10 = @strSQL10 + 	' OR (T7419.AccountID >=''' + @TaxAccountID3From + ''' AND T7419.AccountID <='''+ @TaxAccountID3To +''')'

SET @strSQL10 = @strSQL10 + ') AND T7419.D_C = ''D'' THEN T7419.SignAmount * (-1) ELSE 0 END END) AS SignTaxAmount,'
END



SET @strSQL1 = @strSQL1 + ' SUM (CASE WHEN 
					((T7419.AccountID >=''' + ISNULL(@NetAccountID1From,'') + ''' AND T7419.AccountID <='''+ ISNULL(@NetAccountID1To,'') +''')'
IF (@NetAccountID2From is Not NULL OR @NetAccountID2From <> '')
	SET @strSQL1 = @strSQL1 + 	' OR (T7419.AccountID >=''' + @NetAccountID2From + ''' AND T7419.AccountID <='''+ @NetAccountID2To +''')'
IF (@NetAccountID3From is Not NULL OR @NetAccountID3From <> '')
	SET @strSQL1 = @strSQL1 + 	' OR (T7419.AccountID >=''' + @NetAccountID3From + ''' AND T7419.AccountID <='''+ @NetAccountID3To +''')'
IF (@NetAccountID4From is Not NULL OR @NetAccountID4From <> '')
	SET @strSQL1 = @strSQL1 + 	' OR (T7419.AccountID >=''' + @NetAccountID4From + ''' AND T7419.AccountID <='''+ @NetAccountID4To +''')'
IF  ( isnull(@NetAccountID5From,'')<> '')
	SET @strSQL1 = @strSQL1 + 	' OR (T7419.AccountID >=''' + @NetAccountID5From + ''' AND T7419.AccountID <='''+ @NetAccountID5To +''')'
	
If @IsVATIn = 1 ---- Xac dinh doanh so dau vao
BEGIN 
	SET @strSQL1 = @strSQL1 +  ') AND ((T7419.D_C like ''D'' and T7419.TransactionTypeID not in (''T25'',''T35'')) ) 
	THEN T7419.SignAmount ELSE
	CASE WHEN 
					((T7419.AccountID >=''' + ISNULL(@NetAccountID1From,'') + ''' AND T7419.AccountID <='''+ ISNULL(@NetAccountID1To,'') +''')'
--IF (@NetAccountID2From is Not NULL OR @NetAccountID2From <> '')
--	SET @strSQL1 = @strSQL1 + 	' OR (T7419.AccountID >=''' + @NetAccountID2From + ''' AND T7419.AccountID <='''+ @NetAccountID2To +''')'

IF (@NetAccountID3From is Not NULL OR @NetAccountID3From <> '')
	SET @strSQL1 = @strSQL1 + 	' OR (T7419.AccountID >=''' + @NetAccountID3From + ''' AND T7419.AccountID <='''+ @NetAccountID3To +''')'

IF (@TaxAccountID1From is Not NULL OR @TaxAccountID1From <> '')
	SET @strSQL1 = @strSQL1 + 	' OR (T7419.AccountID >=''' + @TaxAccountID1From + ''' AND T7419.AccountID <='''+ @TaxAccountID1To +''' and VoucherTypeID = ''TP'')'

IF (@NetAccountID4From is Not NULL OR @NetAccountID4From <> '')
	SET @strSQL1 = @strSQL1 + 	' OR (T7419.AccountID >=''' + @NetAccountID4From + ''' AND T7419.AccountID <='''+ @NetAccountID4To +''')'
IF  ( isnull(@NetAccountID5From,'')<> '')
	SET @strSQL1 = @strSQL1 + 	' OR (T7419.AccountID >=''' + @NetAccountID5From + ''' AND T7419.AccountID <='''+ @NetAccountID5To +''')'
	
	SET @strSQL1 = @strSQL1 +  ') AND (T7419.D_C like ''C'' and (T7419.TransactionTypeID IN (''T25'',''T01'',''T21'') OR VoucherTypeID = ''TP'' AND T7419.AccountID NOT IN (''6417'',''6418'',''6427'',''62770'' ))) 
	THEN T7419.SignAmount * (-1) ELSE 0 END END) AS SignNetAmount'
END 
Else		----- Xac dinh doanh so dau ra
BEGIN 
	SET @strSQL1 = @strSQL1 +  ')  AND ( T7419.D_C like ''C'' or (T7419.D_C like ''D'' and (T7419.TransactionTypeID in (''T24'',''T65'') or  VoucherTypeID LIKE ''HG%'' ) )) '

	SET @strSQL1 = @strSQL1 + ' THEN T7419.SignAmount ELSE 0 END) AS SignNetAmount'
END 

SET @strSQL1 = @strSQL1 + '
		Into #AV7411
		FROM AT7419 AS T7419 WITH (NOLOCK)
		'
SET @strSQL1 = @strSQL1 + ' WHERE T7419.UserID = '''+@UserID+''' '

--if isnull(@VATGroupID1,'') <>'' or   isnull(@VATGroupID2,'') <>'' or  isnull(@VATGroupID3,'') <>''   or isnull(@VATGroupID4,'') <>'' or isnull(@VATGroupID5,'') <>'' or isnull(@VATTypeID1,'')<>'' or isnull(@VATTypeID2,'')<>'' or isnull(@VATTypeID3,'')<>''   or  isnull(@VATTypeID4,'')<>'' or  isnull(@VATTypeID5,'')<>'' 
--Set @strSQL1 = @strSQL1 + 'Where '
---SET @strSQL = @strSQL + ' AND T7419.VATTypeID IS NOT NULL ' +  ' AND T7419.VATTypeID <> ''' + ''''

IF @IsVATGroup <>0 
Begin
	If isnull(@VATGroupID1,'') <>''
		Set @strSQL1  = @strSQL1 +  ' AND  ( T7419.VATGroupID like '''+@VATGroupID1+ '%' + ''' '  
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
			
			
	If isnull(@VATGroupID1,'') <>'' or   isnull(@VATGroupID2,'') <>'' or  isnull(@VATGroupID3,'') <>''   or isnull(@VATGroupID4,'') <>'' or isnull(@VATGroupID5,'') <>''
		Set @strSQL1  = @strSQL1 +  ' ) '


End

If @IsVATType <>0 
  Begin
	--if @IsVATGroup <>0
	--SET @strSQL1 = @strSQL1 + 'AND'
	--Print ' Nhan res '+@VATTypeID1
	if isnull(@VATTypeID1,'')<>'' 
		SET @strSQL1 = @strSQL1 + ' AND (T7419.VATTypeID like ''' + @VATTypeID1 + '''' 
	if isnull(@VATTypeID2,'')<>'' and isnull(@VATTypeID1,'')<>''
		SET @strSQL1 = @strSQL1 + '  OR T7419.VATTypeID like ''' + @VATTypeID2 + '''' 
	if isnull(@VATTypeID2,'')<>'' and isnull(@VATTypeID1,'')=''
		SET @strSQL1 = @strSQL1 + '  T7419.VATTypeID like ''' + @VATTypeID2 + '''' 
	
	if isnull(@VATTypeID3,'')<>'' and (isnull(@VATTypeID2,'')<>'' or isnull(@VATTypeID1,'')<>'')
		SET @strSQL1 = @strSQL1 + '  OR T7419.VATTypeID like ''' + @VATTypeID3 + '''' 
	if isnull(@VATTypeID3,'')<>'' and isnull(@VATTypeID2,'')='' and isnull(@VATTypeID1,'')=''
		SET @strSQL1 = @strSQL1 + '  T7419.VATTypeID like ''' + @VATTypeID3 + '''' 

	if isnull(@VATTypeID4,'')<>'' and (isnull(@VATTypeID2,'')<>'' or isnull(@VATTypeID1,'')<>'' or isnull(@VATTypeID3,'')<>'')
		SET @strSQL1 = @strSQL1 + '  OR T7419.VATTypeID like ''' + @VATTypeID4 + '''' 
	if isnull(@VATTypeID4,'')<>'' and isnull(@VATTypeID2,'')='' and isnull(@VATTypeID1,'')='' and isnull(@VATTypeID3,'')=''
		SET @strSQL1 = @strSQL1 + '  T7419.VATTypeID like ''' + @VATTypeID4 + '''' 
			
	if isnull(@VATTypeID5,'')<>'' and (isnull(@VATTypeID2,'')<>'' or isnull(@VATTypeID1,'')<>'' or isnull(@VATTypeID3,'')<>'' or isnull(@VATTypeID4,'')<>'')
		SET @strSQL1 = @strSQL1 + '  OR T7419.VATTypeID like ''' + @VATTypeID5 + '''' 
	if isnull(@VATTypeID5,'')<>'' and isnull(@VATTypeID2,'')='' and isnull(@VATTypeID1,'')='' and isnull(@VATTypeID3,'')='' and isnull(@VATTypeID4,'')=''
		SET @strSQL1 = @strSQL1 + '  T7419.VATTypeID like ''' + @VATTypeID5 + '''' 

	if isnull(@VATTypeID1,'')<>'' or isnull(@VATTypeID2,'')<>'' or isnull(@VATTypeID3,'')<>''   or  isnull(@VATTypeID4,'')<>'' or  isnull(@VATTypeID5,'')<>'' 
		SET @strSQL1 = @strSQL1 + '  ) '
End


If isnull(@VoucherTypeID,'')<>'' 
	Set @strSQL1 = @strSQL1 + ' AND (T7419.VoucherTypeID between ''' + @VoucherTypeID + '''  and ''' + @VoucherTypeIDTo + ''' )  ' 

IF isnull(@VATObjectIDFrom,'') >''
	Set @strSQL1 = @strSQL1 + ' AND (T7419.ObjectID  between  ''' + isnull(@VATObjectIDFrom,'') + ''' and '''+isnull(@VATObjectIDTo,'')+''' ) '	

IF @CustomerName =17 --(Customized IPL : 1 HD co nhieu phieu)
SET @strSQL1 = @strSQL1 + ' 
			GROUP BY T7419.UserID, -- T7419.BatchID,   
			--T7419.VoucherID,
			 T7419.DivisionID,
			  --T7419.VoucherNo,
			   T7419.Serial, T7419.DueDate, 
			T7419.InvoiceNo, T7419.InvoiceDate, T7419.VAtTypeID, T7419.VATGroupID, T7419.InvoiceCode, T7419.InvoiceSign'
ELSE
	SET @strSQL1 = @strSQL1 + ' 
			GROUP BY T7419.UserID, T7419.BatchID,   
				T7419.VoucherID,
				T7419.DivisionID,
				T7419.VoucherNo,
			   T7419.Serial, T7419.DueDate, 
			T7419.InvoiceNo, T7419.InvoiceDate, T7419.VAtTypeID, T7419.VATGroupID, T7419.InvoiceCode, T7419.InvoiceSign, T7419.CreateDate'
			
--Print @strSQL
--PRINT @strSQL1
		 ---(D90T3010)
--Print ' test'
Set @strDeclare ='

DELETE FROM AT7411 WITH (ROWLOCK) WHERE DivisionID = '''+@DivisionID+''' AND UserID = '''+@UserID+'''

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
		@CreateDate DATETIME,
		----
@INcur CURSOR,		
@VATType as NVARCHAR(50)
SET @D90V4001Cursor = CURSOR SCROLL KEYSET FOR
		SELECT VoucherID, VoucherNo, InvoiceNo, Serial,  InvoiceDate , 
				OriginalTaxAmount, ConvertedTaxAmount , OriginalNetAmount, ConvertedNetAmount,
				SignNetAmount,	SignTaxAmount, SignValues, Quantity,DueDate,VATTypeID, VATGroupID, InvoiceCode, InvoiceSign, CreateDate
		FROM #AV7411  

		OPEN @D90V4001Cursor
		FETCH NEXT FROM @D90V4001Cursor INTO
			@VoucherID, @VoucherNo, @InvoiceNo,	@Serial, @InvoiceDate, 
	 		@OriginalTaxAmount, @ConvertedTaxAmount,@OriginalNetAmount, @ConvertedNetAmount,
			@SignNetAmount,@SignTaxAmount, @SignValues, @Quantity,@DueDate,
			@VATTypeID, @VATGroupID, @InvoiceCode, @InvoiceSign, @CreateDate'

--Print @strDeclare	

IF @IsVATIn = 1
BEGIN
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

				FROM AT7419 AS T2 WITH (NOLOCK)
				WHERE	T2.VoucherID = @VoucherID AND
					T2.VoucherNo = @VoucherNo AND
					T2.Serial = @Serial  AND
					T2.InvoiceNo = @InvoiceNo
			
				SELECT TOP 1
					@VDescription = AT1302.InventoryName,
					@BDescription = AT1302.InventoryName
				FROM AT7419 AS T2 WITH (NOLOCK)
				LEFT JOIN AT1302 WITH (NOLOCK) ON T2.DivisionID = AT1302.DivisionID AND T2.InventoryID = AT1302.InventoryID
				WHERE	(T2.VoucherID = @VoucherID) AND
						(T2.VoucherNo = @VoucherNo) AND
						(T2.Serial = @Serial) AND
						(T2.InvoiceNo = @InvoiceNo ) AND
						((T2.AccountID >= '''+@NetAccountID1From+''' AND T2.AccountID <= '''+@NetAccountID1To+''') OR
						(T2.AccountID >= '''+@NetAccountID2From+''' AND T2.AccountID <= '''+@NetAccountID2To+''') OR
						(T2.AccountID >= '''+@NetAccountID3From+''' AND T2.AccountID <= '''+@NetAccountID3To+''') OR
						(T2.AccountID >= '''+@NetAccountID4From+''' AND T2.AccountID <= '''+@NetAccountID4To+''')  OR
						(T2.AccountID >= '''+@NetAccountID5From+''' AND T2.AccountID <= '''+@NetAccountID5To+'''))
				 ORDER BY T2.ConvertedAmount DESC
			 
				 if @BDescription =''''
				SELECT TOP 1
					@VDescription = AT1302.InventoryName,
					@BDescription = AT1302.InventoryName
				FROM AT7419 AS T2 WITH (NOLOCK)
				LEFT JOIN AT1302 WITH (NOLOCK) ON T2.DivisionID = AT1302.DivisionID AND T2.InventoryID = AT1302.InventoryID
				WHERE	(T2.VoucherID = @VoucherID) AND
						(T2.VoucherNo = @VoucherNo) AND
						(T2.Serial = @Serial) AND
						(T2.InvoiceNo = @InvoiceNo ) AND
						((T2.AccountID >= '''+@TaxAccountID1From+''' AND T2.AccountID <= '''+@TaxAccountID1To+''') OR
						(T2.AccountID >= '''+@TaxAccountID2From+''' AND T2.AccountID <= '''+@TaxAccountID2To+''') OR
						(T2.AccountID >= '''+@TaxAccountID3From+''' AND T2.AccountID <= '''+@TaxAccountID3To+'''))
				ORDER BY T2.ConvertedAmount DESC'	
END
ELSE
BEGIN
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

			FROM AT7419 AS T2 WITH (NOLOCK)
			WHERE	
				T2.VoucherNo = @VoucherNo AND
				T2.Serial = @Serial  AND
				T2.InvoiceNo = @InvoiceNo
			
			SELECT 
				@VDescription = MAX(T2.VDescription),
				@BDescription = MAX(T2.BDescription)
			FROM AT7419 AS T2 WITH (NOLOCK)
			WHERE	
					(T2.VoucherNo = @VoucherNo) AND
					(T2.Serial = @Serial) AND
					(T2.InvoiceNo = @InvoiceNo ) AND
					((T2.AccountID >= '''+@NetAccountID1From+''' AND T2.AccountID <= '''+@NetAccountID1To+''') OR
					(T2.AccountID >= '''+@NetAccountID2From+''' AND T2.AccountID <= '''+@NetAccountID2To+''') OR
					(T2.AccountID >= '''+@NetAccountID3From+''' AND T2.AccountID <= '''+@NetAccountID3To+''') OR
					(T2.AccountID >= '''+@NetAccountID4From+''' AND T2.AccountID <= '''+@NetAccountID4To+''')  OR
					(T2.AccountID >= '''+@NetAccountID5From+''' AND T2.AccountID <= '''+@NetAccountID5To+'''))
			 
				if @BDescription =''''
				SELECT 
				@VDescription = T2.VDescription,
				@BDescription = T2.BDescription
			FROM AT7419 AS T2 WITH (NOLOCK)
			WHERE	
					(T2.VoucherNo = @VoucherNo) AND
					(T2.Serial = @Serial) AND
					(T2.InvoiceNo = @InvoiceNo ) AND
					((T2.AccountID >= '''+@TaxAccountID1From+''' AND T2.AccountID <= '''+@TaxAccountID1To+''') OR
					(T2.AccountID >= '''+@TaxAccountID2From+''' AND T2.AccountID <= '''+@TaxAccountID2To+''') OR
					(T2.AccountID >= '''+@TaxAccountID3From+''' AND T2.AccountID <= '''+@TaxAccountID3To+'''))'	
END	

--Print @strSQL1
					
Set @strSQL3='
			Set @VATRate = Null
			Select TOP 1 @VATRate  = VATRate
			FROM AT7419 AS T2 left join AT1010 on AT1010.VATGroupID = T2.VATGroupID and AT1010.DivisionID = T2.DivisionID
			WHERE	(T2.VoucherID = @VoucherID) AND
					T2.VATGroupID = @VATGroupID AND
					(T2.VoucherNo = @VoucherNo) AND
					(T2.Serial = @Serial) AND
					(T2.InvoiceNo = @InvoiceNo ) AND
					((T2.AccountID >= '''+@TaxAccountID1From+''' AND T2.AccountID <= '''+@TaxAccountID1To+''' ) OR
					(T2.AccountID >= '''+@TaxAccountID2From+''' AND T2.AccountID <= '''+@TaxAccountID2To+''' ) OR
					(T2.AccountID >= '''+@TaxAccountID3From+''' AND T2.AccountID <= '''+@TaxAccountID3To+''' ))
			SELECT TOP 1
				@VATObjectID = T2.VATObjectID
			FROM AT7419 AS T2 WITH (NOLOCK)
			WHERE	
				T2.VoucherID = @VoucherID AND
				T2.Serial = @Serial AND
				T2.InvoiceNo = @InvoiceNo AND
				T2.VATObjectID IS NOT NULL AND T2.VATObjectID <>''''
	
				SELECT TOP 1
					@VATObjectID = T2.ObjectID
				FROM AT7419 AS T2 WITH (NOLOCK)
				WHERE	(T2.VoucherID = @VoucherID) AND
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

From AT7419  as T43 WITH (NOLOCK)
						left join AT1202 Obj1 WITH (NOLOCK) on Obj1.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T43.VATObjectID = Obj1.ObjectID								
						left join AT1202 Obj2 WITH (NOLOCK) on Obj2.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T43.ObjectID = Obj2.ObjectID	
				Where   T43.VoucherID = @VoucherID AND
						T43.VoucherNo = @VoucherNo AND
						T43.Serial = @Serial AND
						T43.InvoiceNo = @InvoiceNo AND	
						--((T43.AccountID >= '''+@NetAccountID1From+''' AND T43.AccountID <= '''+@NetAccountID1To+''') OR
						--(T43.AccountID >= '''+@NetAccountID2From+''' AND T43.AccountID <= '''+@NetAccountID2To+''') OR
						--(T43.AccountID >= '''+@NetAccountID3From+''' AND T43.AccountID <= '''+@NetAccountID3To+''') OR
						--(T43.AccountID >= '''+@NetAccountID4From+''' AND T43.AccountID <= '''+@NetAccountID4To+''') OR
						--(T43.AccountID >= '''+@NetAccountID5From+''' AND T43.AccountID <= '''+@NetAccountID5To+'''))
						
						((T43.AccountID >= '''+@TaxAccountID1From+''' AND T43.AccountID <= '''+@TaxAccountID1To+''' ) OR
						(T43.AccountID >= '''+@TaxAccountID2From+''' AND T43.AccountID <= '''+@TaxAccountID2To+''' ) OR
						(T43.AccountID >= '''+@TaxAccountID3From+''' AND T43.AccountID <= '''+@TaxAccountID3To+''' ))'
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
				
			From AT7419  as T43 WITH (NOLOCK)	
						left join AT1202 Obj1 WITH (NOLOCK) on Obj1.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T43.VATObjectID = Obj1.ObjectID							
						left join AT1202 Obj2 WITH (NOLOCK) on Obj2.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T43.ObjectID = Obj2.ObjectID	           
			 Where		T43.VoucherID = @VoucherID AND	
						T43.VoucherNo = @VoucherNo AND
						T43.Serial = @Serial AND
						T43.InvoiceNo = @InvoiceNo AND	
						--((T43.AccountID >= '''+@TaxAccountID1From+''' AND T43.AccountID <= '''+@TaxAccountID1To+''' ) OR
						--(T43.AccountID >= '''+@TaxAccountID2From+''' AND T43.AccountID <= '''+@TaxAccountID2To+''' ) OR
						--(T43.AccountID >= '''+@TaxAccountID3From+''' AND T43.AccountID <= '''+@TaxAccountID3To+''' ))
						((T43.AccountID >= '''+@NetAccountID1From+''' AND T43.AccountID <= '''+@NetAccountID1To+''') OR
						(T43.AccountID >= '''+@NetAccountID2From+''' AND T43.AccountID <= '''+@NetAccountID2To+''') OR
						(T43.AccountID >= '''+@NetAccountID3From+''' AND T43.AccountID <= '''+@NetAccountID3To+''') OR
						(T43.AccountID >= '''+@NetAccountID4From+''' AND T43.AccountID <= '''+@NetAccountID4To+''') OR
						(T43.AccountID >= '''+@NetAccountID5From+''' AND T43.AccountID <= '''+@NetAccountID5To+'''))
			
			INSERT INTO AT7411 ( UserID,	
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
						Quantity, DueDate, VATTradeName, InvoiceCode, InvoiceSign, DebitAccountID, CreditAccountID, CreateDate)  
				VALUES ('''+@UserID+''',
					'''+@DivisionID+''', @VoucherID, @Serial, @InvoiceNo, 	@VoucherNo,@VoucherTypeID,
					@BDescription,	
					@VDescription,
					@VoucherDate,	@InvoiceDate,
					@TranMonth,	@TranYear,
					-- @OriginalTaxAmount, 
					Case when  @SignValues <0 then - @OriginalTaxAmount else @OriginalTaxAmount end, 
					Case when  @SignValues <0 then - @ConvertedTaxAmount else @ConvertedTaxAmount end, 
					Case when  @SignValues <0 then - @OriginalNetAmount else @OriginalNetAmount end , 
					Case when  @SignValues <0 then - @ConvertedNetAmount else @ConvertedNetAmount end,
					Case when  @SignValues <0 then - @SignNetAmount else @SignNetAmount end,
					@SignTaxAmount,
					@ExchangeRate,@CurrencyID,
					@VATObjectID,
					@VATNo, @Object_Name, @Object_Address,
					@VATGroupID,
					@VATTypeID,
					@VATRate,
					@Quantity,@DueDate, @VATTradeName,@InvoiceCode, @InvoiceSign, @DebitAccountID, @CreditAccountID, @CreateDate)
					
			FETCH NEXT FROM @D90V4001Cursor INTO	
					@VoucherID, 
					@VoucherNo, @InvoiceNo,@Serial, @InvoiceDate,
					@OriginalTaxAmount, @ConvertedTaxAmount,@OriginalNetAmount,@ConvertedNetAmount, 
									@SignNetAmount,@SignTaxAmount, @SignValues, @Quantity,@DueDate,@VATTypeID, @VATGroupID, @InvoiceCode, @InvoiceSign, @CreateDate
									
		END
		CLOSE @D90V4001Cursor
		DEALLOCATE @D90V4001Cursor
		
		DELETE FROM AT7419 WITH (ROWLOCK) WHERE UserID  = '''+@UserID+'''
		'


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
		@isVATType tinyint,
		@isVATGroup tinyint,
		@IsVATI tinyint,
		@VATGroupID1 NVARCHAR(50) ,
		@VATGroupID2 NVARCHAR(50), 
		@VATGroupID3 NVARCHAR(50), 
		@VATGroupID4 NVARCHAR(50),
		@VATGroupID5 NVARCHAR(50),
		@i tinyint,
		@tmp AS CURSOR

Delete At7412
set @tmp = cursor scroll for 
		Select 
				reportcode,vattypeid1,vattypeid2,vattypeid3,vattypeid4,vattypeid5,isvattype ,IsVATIn,
				VATGroupID1,VATGroupID2,VATGroupID3,VATGroupID4,VATGroupID5, isVATGroup
		From	at7410 WITH (NOLOCK)
		Where	DivisionID = '''+@DivisionID+'''

open @tmp

FETCH NEXT FROM @tmp
INTO  @reportcode1,@VATTypeid1,@VATTypeid2,@VATTypeid3,@VATTypeid4, @VATTypeid5
 ,@isVATType,@IsVATI, @VATGroupID1, @VATGroupID2, @VATGroupID3, @VATGroupID4, @VATGroupID5
 , @isVATGroup

WHILE @@FETCH_STATUS = 0
begin
	
		set @i=1
		while @i<6
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
			set @i = @i + 1
		end

	FETCH NEXT FROM @tmp
	INTO 
	@reportcode1,@VATTypeid1,@VATTypeid2,@VATTypeid3,@VATTypeid4,@VATTypeid5,
	@isVATType, @IsVATI, @VATGroupID1, @VATGroupID2, @VATGroupID3, @VATGroupID4,@VATGroupID5
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
		 Select  VAtTypeID,VATGroupID  From AT7412 WITH (NOLOCK) 
		 Where  isnull (VAtTypeID,'''') 
		 Not in( Select isnull (VATTypeID,'''')   from AT7411 WITH (NOLOCK) Where DivisionID = '''+@DivisionID+''' ) 
		 and ReportCode = '''+@ReportCode+'''  and isnull (VAtTypeID,'''') <> ''''
	OPEN  @Incur
	FETCH NEXT FROM @Incur INTO @VAtTypeID, @VATGroupID
	WHILE  @@FETCH_STATUS = 0
	BEGIN
		
	 	
			If  exists ( select top 1 1 from AT7412 WITH (NOLOCK) 
						Where ReportCode = '''+@ReportCode+''' and   IsVATin =1 
						and  VAtTypeID Not in( Select  isnull (VATTypeID,'''')  from AT7411  Where DivisionID = '''+@DivisionID+''')) 
				Begin
					INSERT INTO AT7411 (UserID, DivisionID, ConvertedNetAmount,ConvertedTaxAmount,VATTypeID )
					VALUES ('''+@UserID+''','''+@DivisionID+''',0,0,@VATTypeID)	
				End
	FETCH NEXT FROM  @Incur INTO @VAtTypeID,@VATGroupID
	END	
	CLOSE @Incur
	DEALLOCATE @Incur'

IF @IsVATIn = 0 -- In dau ra 
Set @strSQL6 ='
	SET @Incur = cursor  scroll  keyset for
		 Select 
		 VAtTypeID,VATGroupID  From AT7412 WITH (NOLOCK) 
		 Where  isnull (VAtGroupID,'''') Not in( Select isnull (VATGroupID,'''')   from AT7411 WITH (NOLOCK) Where DivisionID = '''+@DivisionID+''' ) 
		 and ReportCode = '''+@ReportCode+'''  and isnull (VATGroupID,'''') <> ''''
	OPEN  @Incur
	FETCH NEXT FROM @Incur INTO @VAtTypeID,@VATGroupID
	WHILE  @@FETCH_STATUS = 0
	BEGIN
		If  exists ( select top 1 1 from AT7412 Where    ReportCode = '''+@ReportCode+''' and IsVATin = 0    and  VATGroupID
			 Not in( Select  isnull (VATGroupID,'''')  from AT7411  Where DivisionID = '''+@DivisionID+''')) 
		Begin
			INSERT INTO AT7411 (UserID, DivisionID, ConvertedNetAmount,ConvertedTaxAmount,VATGroupID )
			VALUES ('''+@UserID+''','''+@DivisionID+''', 0,0, @VATGroupID)	
		End
			
	FETCH NEXT FROM  @Incur INTO  @VAtTypeID,@VATGroupID
	END	
	CLOSE @Incur
	DEALLOCATE @Incur'


PRINT @strSQL
PRINT @strSQL10
PRINT @strSQL1
PRINT @strDeclare
PRINT @strSQL2 
PRINT @strSQL3 
PRINT @strSQL4 
PRINT @strSQL5
PRINT @strSQL6
EXEC (@strSQL + @strSQL10 +@strSQL1+@strDeclare+@strSQL2+ @strSQL3+ @strSQL4+ @strSQL5+@strSQL6)
















GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
