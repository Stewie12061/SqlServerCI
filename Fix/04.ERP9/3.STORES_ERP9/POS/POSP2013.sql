IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'POSP2013') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE POSP2013
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form POSF2013 (Phiếu thu) Kế thừa phiếu đặt cọc (Mode = 0)
---- Load Grid Form POSF2013 (Phiếu bán hàng) Kế thừa phiếu đặt cọc (Mode = 1)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Thị Phượng, Date 08/12/2017
----Modified by: Hoàng Vũ, Date 18/01/2018, load thêm Hình thức thanh toán của phiếu đặt cọc
----Modified by: Thị Phượng, Date 11/03/2018 Chỉnh sửa bổ sung trường số tiền phải thu
----Modified by: Hoàng Vũ, Date 28/03/2018: Format lại SQL và lấy hàm Round trước khi tính tổng tiền, Fix trường hợp lẻ 1 đồng
----Modified by: Hoàng Vũ, Date 28/05/2018: bổ sung kiểm tra chỉ hiển thị các phiếu chưa kế thừa bên phiếu thu ERP hoặc kế thừa nhưng chưa thu hết tiền
-- <Example> EXEC POSP2013 'HCM','CH-HCM001','','', 0, '2017-01-01', '2017-12-30', '04/2017'',''08/2017' ,'NV01',1,20

CREATE PROCEDURE POSP2013 ( 
        @DivisionID VARCHAR(50),--Biến môi trường
		@ShopID  NVARCHAR(250),	--Biến môi trường
        @VoucherNo  NVARCHAR(250),
		@MemberID  NVARCHAR(250),
		@IsDate TINYINT,		--0: theo ngày, 1: Theo kỳ
		@FromDate Datetime,
		@ToDate Datetime,
		@Period NVARCHAR(4000), --Chọn trong DropdownChecklist Chọn kỳ
		@UserID  VARCHAR(50),
		@PageNumber INT,
		@PageSize INT,
		@Mode int = 0			--0: Phiếu thu; 1: Phiếu bán hàng
) 
AS 
	DECLARE @CustomerName INT
	CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
	INSERT #CustomerName EXEC AP4444
	SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

	DECLARE @sSQL NVARCHAR (MAX),
			@sWhere NVARCHAR(MAX),
			@OrderBy NVARCHAR(500),
			@TotalRow NVARCHAR(50)
        
	SET @sWhere=''
	SET @OrderBy = 'M.VoucherNo'

	IF @IsDate = 0 
	SET @sWhere = @sWhere + '  CONVERT(VARCHAR(10),M.VoucherDate,21) BETWEEN '''+ CONVERT(VARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,21)+''''
	IF @IsDate = 1 
	SET @sWhere = @sWhere + '  (CASE WHEN M.TranMonth <10 THEN ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) 
				ELSE rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) END) in ('''+@Period +''')'
	--Check Para DivisionIDList null then get DivisionID 
	IF  Isnull(@DivisionID,'') != ''
		SET @sWhere = @sWhere + 'and M.DivisionID = '''+ @DivisionID+''''
	IF  Isnull(@ShopID,'') != ''
		SET @sWhere = @sWhere + 'and M.ShopID = '''+ @ShopID+''''
	IF Isnull(@VoucherNo, '') != '' 
		SET @sWhere = @sWhere + ' AND ISNULL(M.VoucherNo, '''') LIKE N''%'+@VoucherNo+'%'' '
	IF Isnull(@MemberID, '') != ''
		SET @sWhere = @sWhere + ' AND (ISNULL(M.MemberID, '''') LIKE N''%'+@MemberID+'%''  or ISNULL(D.MemberName, '''') LIKE N''%'+@MemberID+'%'')'
	
	IF Isnull(@Mode, 0)  = 0
	Begin
		SET @sSQL = '
			SELECT M.APK, M.DivisionID, M.ShopID, M.VoucherTypeID, B.VoucherTypeName, M.VoucherNo, convert(varchar(20), M.VoucherDate, 103) as VoucherDate, M.MemberID
					, D.MemberName, M.Tel, M.Address, M.CurrencyID, M.ExchangeRate, M.SaleManID, M.CreateDate, M.CreateUserID, M.LastModifyUserID, M.LastModifyDate
					, M.TranMonth, M.TranYear,  Isnull(A.BookingAmount, 0.0) as SumAmount, M.APKPaymentID, M.PaymentObjectAmount01, M.PaymentObjectAmount02
					, Case when Isnull(C.IsTaxIncluded, 0) = 1 
						   then SUM(ROUND(Isnull(C.ConvertInventoryAmount, 0.0),A01.ConvertedDecimals)) -Isnull(A.BookingAmount, 0.0) - SUM(ROUND(Isnull(A9.ConvertedAmount, 0.0),A01.ConvertedDecimals)) 
						   Else SUM(ROUND(Isnull(C.ConvertInventoryAmount, 0.0),A01.ConvertedDecimals)) + Sum(ROUND(C.ConvertTaxAmount,A01.ConvertedDecimals)) -Isnull(A.BookingAmount, 0.0) - SUM(ROUND(Isnull(A9.ConvertedAmount, 0.0),A01.ConvertedDecimals)) 
						   End as PayAmount
			Into #TemPOST2010
			FROM POST2010 M With (NOLOCK) INNER JOIN POST2011 C With (NOLOCK) ON C.APKMaster = M.APK and M.DeleteFlg = C.DeleteFlg
										  LEFT JOIN POST0011 D With (NOLOCK) On M.MemberID = D.MemberID
										  LEFT JOIN AT1007 B WITH (NOLOCK) ON B.VoucherTypeID = M.VoucherTypeID and M.DivisionID = B.DivisionID
										  LEFT JOIN (
														SELECT A.DivisionID, A.APKMInherited, Sum(Amount) as BookingAmount
														FROM POST00802 A With (NOLOCK) inner join POST00801 B on A.APKMaster = B.APK and A.DeleteFlg = B.DeleteFlg
														Where A.DivisionID = '''+ @DivisionID+''' and isnull(A.DeleteFlg,0) = 0 and B.IsDeposit = 1
														Group by A.DivisionID, A.APKMInherited
													 ) A On A.APKMInherited = M.APK and A.DivisionID = M.DivisionID
										  LEFT JOIN AT9000 A9 WITH (NOLOCK) on A9.DivisionID = M.DivisionID and M.APK = A9.InheritVoucherID and A9.InheritTableID = ''POST2010'' and A9.IsDeposit = 2
										  LEFT JOIN AT1101 A01 WITH (NOLOCK) ON A01.DivisionID = M.DivisionID
			WHERE '+@sWhere+' and M.DeleteFlg =0 and isnull(M.IsInvoice,0) = 0
			Group by  M.APK, M.DivisionID, M.ShopID, M.VoucherTypeID, B.VoucherTypeName, M.VoucherNo
					, M.VoucherDate	, M.MemberID,  D.MemberName , M.Tel, M.Address, M.CurrencyID, M.ExchangeRate, M.SaleManID
					, M.CreateDate, M.CreateUserID, M.LastModifyUserID, M.LastModifyDate
					, M.TranMonth, M.TranYear,  A.BookingAmount, Isnull(C.IsTaxIncluded, 0)
					, M.APKPaymentID, M.PaymentObjectAmount01, M.PaymentObjectAmount02
	
			Declare @Count int
			Select @Count = Count(VoucherNo) From  #TemPOST2010

			SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @Count AS TotalRow
					, M.APK, M.DivisionID, M.ShopID, M.VoucherTypeID, M.VoucherTypeName, M.VoucherNo, M.VoucherDate, M.MemberID
					, M.MemberName, M.Tel, M.Address, M.CurrencyID, M.ExchangeRate, M.SaleManID, M.APKPaymentID, M.PaymentObjectAmount01
					, M.PaymentObjectAmount02, M.CreateDate, M.CreateUserID, M.LastModifyUserID, M.LastModifyDate, M.TranMonth, M.TranYear, M.SumAmount, M.PayAmount
			From  #TemPOST2010 M
			Where M.PayAmount > 0
			ORDER BY '+@OrderBy+'
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
		EXEC (@sSQL)
	End

	IF Isnull(@Mode, 0)  = 1
	Begin
		SET @sSQL = '
			SELECT M.APK, M.DivisionID
					, M.ShopID, M.VoucherTypeID, B.VoucherTypeName, M.VoucherNo
					, convert(varchar(20), M.VoucherDate, 103) as VoucherDate
					, M.MemberID,  D.MemberName , M.Tel, M.Address, M.CurrencyID, M.ExchangeRate, M.SaleManID
					, M.CreateDate, M.CreateUserID, M.LastModifyUserID, M.LastModifyDate
					, M.TranMonth, M.TranYear,  Isnull(A.BookingAmount, 0.0) as SumAmount
					, M.APKPaymentID, M.PaymentObjectAmount01, M.PaymentObjectAmount02
					, Case when Isnull(C.IsTaxIncluded, 0) = 1 
						   then SUM(ROUND(Isnull(C.ConvertInventoryAmount, 0.0),A01.ConvertedDecimals)) -Isnull(A.BookingAmount, 0.0) - SUM(ROUND(Isnull(A9.ConvertedAmount, 0.0),A01.ConvertedDecimals)) 
						   Else SUM(ROUND(Isnull(C.ConvertInventoryAmount, 0.0),A01.ConvertedDecimals)) + Sum(ROUND(C.ConvertTaxAmount,A01.ConvertedDecimals)) -Isnull(A.BookingAmount, 0.0) - SUM(ROUND(Isnull(A9.ConvertedAmount, 0.0),A01.ConvertedDecimals)) 
						   End as PayAmount
			Into #TemPOST2010
			FROM POST2010 M With (NOLOCK) INNER JOIN POST2011 C With (NOLOCK) ON C.APKMaster = M.APK and M.DeleteFlg = C.DeleteFlg
										  LEFT JOIN POST0011 D With (NOLOCK) On M.MemberID = D.MemberID
										  LEFT JOIN AT1007 B WITH (NOLOCK) ON B.VoucherTypeID = M.VoucherTypeID and M.DivisionID = B.DivisionID
										  LEFT JOIN (
														SELECT A.DivisionID, A.APKMInherited, Sum(Amount) as BookingAmount
														FROM POST00802 A With (NOLOCK) inner join POST00801 B on A.APKMaster = B.APK and A.DeleteFlg = B.DeleteFlg
														Where A.DivisionID = '''+ @DivisionID+''' and isnull(A.DeleteFlg,0) = 0 and B.IsDeposit = 1
														Group by A.DivisionID, A.APKMInherited
													 ) A On A.APKMInherited = M.APK and A.DivisionID = M.DivisionID
										  LEFT JOIN AT9000 A9 WITH (NOLOCK) on A9.DivisionID = M.DivisionID and M.APK = A9.InheritVoucherID and A9.InheritTableID = ''POST2010'' and A9.IsDeposit = 2
										  LEFT JOIN AT1101 A01 WITH (NOLOCK) ON A01.DivisionID = M.DivisionID
			WHERE '+@sWhere+' and M.DeleteFlg =0 and isnull(M.IsInvoice,0) = 0
			Group by  M.APK, M.DivisionID, M.ShopID, M.VoucherTypeID, B.VoucherTypeName, M.VoucherNo
					, M.VoucherDate	, M.MemberID,  D.MemberName , M.Tel, M.Address, M.CurrencyID, M.ExchangeRate, M.SaleManID
					, M.CreateDate, M.CreateUserID, M.LastModifyUserID, M.LastModifyDate
					, M.TranMonth, M.TranYear,  A.BookingAmount, Isnull(C.IsTaxIncluded, 0)
					, M.APKPaymentID, M.PaymentObjectAmount01, M.PaymentObjectAmount02
	
			Declare @Count int
			Select @Count = Count(VoucherNo) From  #TemPOST2010

			SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @Count AS TotalRow
					, M.APK, M.DivisionID, M.ShopID, M.VoucherTypeID, M.VoucherTypeName, M.VoucherNo, M.VoucherDate, M.MemberID
					, M.MemberName, M.Tel, M.Address, M.CurrencyID, M.ExchangeRate, M.SaleManID, M.APKPaymentID, M.PaymentObjectAmount01
					, M.PaymentObjectAmount02, M.CreateDate, M.CreateUserID, M.LastModifyUserID, M.LastModifyDate, M.TranMonth, M.TranYear, M.SumAmount, M.PayAmount
			From  #TemPOST2010 M
			ORDER BY '+@OrderBy+'
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
		EXEC (@sSQL)
	End

	

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
