IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'POSP00831') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE POSP00831
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form POSF0083 (Phiếu thu) Kế thừa phiếu bán hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Thị Phượng, Date 07/08/2017
----Modified by: Hoàng Vũ, Date 16/11/2017, Điều chỉnh cách lấy số liệu số tiền phải thu
----Modified by: Thị Phượng, Date 16/11/2017: Bổ sung điều kiện kiểm tra kho
----Modified by: Thị Phượng, Date 25/12/2017: Bổ sung trừ thêm tiền booking amount với các phiếu có kế thừa phiếu cọc và customize Minh sang để tránh lỗi số liệu
----Modified by: Hoàng Vũ, Date 18/01/2018: Load thêm hình thức thanh toán
----Modified by: Hoàng Vũ, Date 19/06/2018: Lấy số chứng từ Của phiếu đổi, nhầm số chứng từ bán hàng
----Modified by: Hoàng Vũ, Date 24/04/2019: Bổ sung loại trừ phần Phiếu quà tăng không tinh
----Modified by: Hoàng Vũ, Date 07/05/2019: Fixbug thiếu Having thiếu TotalGiftVoucherAmount
-- <Example>
/* 
EXEC POSP00831 'HCM','CH-HCM001','','', 0, '2015-01-01', '2017-12-30', '11/2017'',''08/2017' ,'NV01',1,20
*/
----
CREATE PROCEDURE POSP00831 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@ShopID  NVARCHAR(250),--Biến môi trường
        @VoucherNo  NVARCHAR(250),
		@MemberID  NVARCHAR(250),
		@IsDate TINYINT,--0: theo ngày, 1: Theo kỳ
		@FromDate Datetime,
		@ToDate Datetime,
		@Period NVARCHAR(4000), --Chọn trong DropdownChecklist Chọn kỳ
		@UserID  VARCHAR(50),
		@PageNumber INT,
		@PageSize INT
		
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
	IF Isnull(@VoucherNo, '') != '' 
		SET @sWhere = @sWhere + ' AND ISNULL(M.VoucherNo, '''') LIKE N''%'+@VoucherNo+'%'' '
	IF Isnull(@MemberID, '') != ''
		SET @sWhere = @sWhere + ' AND (ISNULL(M.MemberID, '''') LIKE N''%'+@MemberID+'%''  or ISNULL(M.MemberName, '''') LIKE N''%'+@MemberID+'%'')'
	IF Isnull(@ShopID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.ShopID, '''') = '''+@ShopID+''''
	

	If @CustomerName = 79
	Begin
	SET @sSQL = '
			SELECT M.APK, M.DivisionID, M.ShopID, M.VoucherTypeID, M.VoucherNo, convert(varchar(20), M.VoucherDate, 103) as VoucherDate
			, M.MemberID, M.MemberName , M.CreateDate, M.CreateUserID, M.LastModifyUserID, M.LastModifyDate, M.TranMonth, M.TranYear
			, (M.TotalInventoryAmount - M.PaymentObjectAmount01 - M.PaymentObjectAmount02- Sum(Isnull(A.Amount, 0))) as SumAmount
			, M.APKPaymentID
			Into #TemPOST0016
			FROM POST0016 M With (NOLOCK)LEFT JOIN 	
									(
										Select D.APKMInherited, D.Amount 
										FROM POST00801 M  With (NOLOCK) Inner join POST00802 D  With (NOLOCK) On M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
										Where M.DeleteFlg = 0
									)A  ON A.APKMInherited = M.APK
			WHERE '+@sWhere+' and M.DeleteFlg =0 
			Group by M.APK, M.DivisionID, M.ShopID, M.VoucherTypeID, M.VoucherNo, M.VoucherDate, M.APKPaymentID
			, M.MemberID, M.MemberName , M.CreateDate, M.CreateUserID, M.LastModifyUserID, M.LastModifyDate, M.TranMonth, M.TranYear
			, M.TotalInventoryAmount, M.PaymentObjectAmount01, M.PaymentObjectAmount02
			Having  (M.TotalInventoryAmount - M.PaymentObjectAmount01 - M.PaymentObjectAmount02- Sum(Isnull(A.Amount, 0)))>0
			Declare @Count int
			Select @Count = Count(VoucherNo) From  #TemPOST0016

			SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @Count AS TotalRow,
			M.APK, M.DivisionID, M.ShopID, M.VoucherTypeID, M.VoucherNo
			, M.VoucherDate, M.MemberID, M.MemberName , M.APKPaymentID
			, M.CreateDate, M.CreateUserID, M.LastModifyUserID, M.LastModifyDate, M.TranMonth, M.TranYear, M.SumAmount
			From  #TemPOST0016 M
			ORDER BY '+@OrderBy+'
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	end
	Else 
	Begin
	SET @sSQL = '
			SELECT M.APK, M.DivisionID, M.ShopID, M.VoucherTypeID
					, Case when M.CVoucherNo is not null then M.CVoucherNo
						   when M.CVoucherNo is null then M.VoucherNo
						   Else NULL end as VoucherNo
					, convert(varchar(20), M.VoucherDate, 103) as VoucherDate
					, M.MemberID, M.MemberName , M.CreateDate, M.CreateUserID, M.LastModifyUserID, M.LastModifyDate, M.TranMonth, M.TranYear
					, Isnull((Case when M.PvoucherNo is null and M.CVoucherNo is null then Isnull(M.TotalInventoryAmount, 0) - Isnull(M.TotalGiftVoucherAmount, 0)
								   when M.CVoucherNo is not null and ChangeAmount > 0 then M.ChangeAmount
								   end), 0) - Isnull(THU.ThuTien, 0) - Isnull(M.BookingAmount, 0)- Isnull(ERP.OriginalAmount, 0)  as SumAmount
					, M.APKPaymentID
			INTO  #TemPOST0016
			From POST0016 M WITH (NOLOCK) Left join (
														Select D.APKMInherited as APKBanDoi, Sum(Amount) as ThuTien
														from POST00801 M WITH (NOLOCK) inner join POST00802 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg 
														Where Isnull(M.IsDeposit, 0) = 0 and  isnull(IsPayInvoice, 0) in (0, 2,3) and D.APKMInherited is not null and M.DeleteFlg = 0
														Group by D.APKMInherited
													) THU on M.APK = THU.APKBanDoi
											--Lấy phiếu thu dưới ERP kế thừa từ phiếu bán hàng
											Left join AT9000 ERP WITH (NOLOCK) on ERP.InheritInvoicePOS = M.APK and ERP.IsInheritInvoicePOS = 1 
			WHERE '+@sWhere+' and M.DeleteFlg =0 
			Group by M.APK, M.DivisionID, M.ShopID, M.VoucherTypeID, M.VoucherNo, M.VoucherDate, M.APKPaymentID, M.MemberID, M.MemberName 
					, M.CreateDate, M.CreateUserID, M.LastModifyUserID, M.LastModifyDate, M.TranMonth, M.TranYear
					, Isnull(M.TotalInventoryAmount, 0), M.ChangeAmount, M.PvoucherNo, M.CVoucherNo , THU.ThuTien, M.BookingAmount, ERP.OriginalAmount, Isnull(M.TotalGiftVoucherAmount, 0)
			Having  Isnull((Case when M.PvoucherNo is null and M.CVoucherNo is null then Isnull(M.TotalInventoryAmount, 0) - Isnull(M.TotalGiftVoucherAmount, 0)
						   when M.CVoucherNo is not null and ChangeAmount > 0 then M.ChangeAmount
						   end), 0) - Isnull(THU.ThuTien, 0) - Isnull(M.BookingAmount, 0) >0
			
			Declare @Count int
			Select @Count = Count(VoucherNo) From  #TemPOST0016

			SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @Count AS TotalRow, M.APK, M.DivisionID, M.ShopID, M.VoucherTypeID
					, M.VoucherNo, M.VoucherDate, M.MemberID, M.MemberName , M.APKPaymentID, M.CreateDate, M.CreateUserID, M.LastModifyUserID
					, M.LastModifyDate, M.TranMonth, M.TranYear, M.SumAmount
			From  #TemPOST0016 M
			ORDER BY '+@OrderBy+'
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	end
EXEC (@sSQL)
Print (@sSQL)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
