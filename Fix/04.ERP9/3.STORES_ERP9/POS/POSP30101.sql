IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP30101]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP30101]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- ĐỐI CHIẾU DOANH SỐ BÁN VỚI THỰC TẾ THU TIỀN VÀ CÔNG NỢ – POSR3010
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hoàng Vũ on 16/08/2017
----Modify by: Thị Phượng ON 01/02/218: Chỉnh sửa số tiền lấy từ phiếu thu không lấy từ phiếu bán hàng
----Modify by: Hoàng Vũ ON 17/05/2019: Chuyển từ bên MINHSANG qua Chuẩn, nhân ngọc, xử lý trừ đi phiếu qua quà tặng, lấy thêm phiếu đổi hàng có thu tiền
----Modify on 18/11/2019 by Trà Giang: Bổ sung các trường trả lại, đã thu, tiền thừa, còn phải thu.

-- <Example> EXEC POSP30101 'MS', 'MS', 'CH001', 'CH001', 1, '2017-01-01', '2017-12-30', '12/2016'',''01/2017'',''02/2017', '', '', 'ASOFTADMIN'
/*
exec sp_executesql N'POSP30101 @DivisionID=N''TD'',@DivisionIDList=''TD'',@ShopID=N''CHBD01'',@ShopIDList=''CHBD01'',@IsDate=0,@FromDate='''',@ToDate='''',@PeriodIDList=''11/2019'',@FromMemberID=null,@ToMemberID=null,@UserID=N''TANTT'',@ListMemberID=N''01234512345''',N'@CreateUserID nvarchar(5),
@LastModifyUserID nvarchar(5),@DivisionID nvarchar(2)',@CreateUserID=N'TANTT',@LastModifyUserID=N'TANTT',@DivisionID=N'TD'
*/
CREATE PROCEDURE POSP30101 
(
	@DivisionID			VARCHAR(50),
	@DivisionIDList		NVARCHAR(MAX),
	@ShopID				VARCHAR(50),
	@ShopIDList			NVARCHAR(MAX),
	@IsDate				TINYINT,  --1: Theo ngày; 0: Theo kỳ
	@FromDate			DATETIME, 
	@ToDate				DATETIME, 
	@PeriodIDList		NVARCHAR(2000),
	@ToMemberID			VARCHAR(MAX) ='',
	@FromMemberID		VARCHAR(MAX) ='',
	@UserID				VARCHAR(50),
	@ListMemberID	    VARCHAR(MAX) =''
)
AS
BEGIN
		DECLARE @sSQL   NVARCHAR(MAX),  
				@sSQL1   NVARCHAR(MAX),  
				@sWhere NVARCHAR(MAX),
				@Date  NVARCHAR(MAX)

		SET @Date = ''
		SET @sWhere = ''

		--Nếu Danh sách @DivisionIDList trống thì lấy biến môi trường @DivisionID
		IF Isnull(@DivisionIDList, '') != ''
			SET @sWhere = @sWhere + ' AND M.DivisionID IN ('''+@DivisionIDList+''')'
		ELSE 
			SET @sWhere = @sWhere + ' AND M.DivisionID = N'''+@DivisionID+''''	
	
		--Nếu Danh sách @ShopIDList trống thì lấy biến môi trường @ShopID
		IF Isnull(@ShopIDList, '')!= ''
			SET @sWhere = @sWhere + ' AND M.ShopID IN ('''+@ShopIDList+''')'
		ELSE 
			SET @sWhere = @sWhere + ' AND M.ShopID = N'''+@ShopID+''''

		IF @IsDate = 1	
			SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR,M.VoucherDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
		ELSE
			SET @sWhere = @sWhere + ' AND (Case When  M.TranMonth <10 then ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) 
											Else rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) End) IN ('''+@PeriodIDList+''')'

		--Search theo hội viên  (Dữ liệhội viên nhiều nên dùng control từ hội viên , đến hội viên
		IF Isnull(@FromMemberID, '')!= '' and Isnull(@ToMemberID, '') = ''
			SET @sWhere = @sWhere + ' AND M.MemberID > = N'''+@FromMemberID +''''
		ELSE IF Isnull(@FromMemberID, '') = '' and Isnull(@ToMemberID, '') != ''
			SET @sWhere = @sWhere + ' AND M.MemberID < = N'''+@ToMemberID +''''
		ELSE IF Isnull(@FromMemberID, '') != '' and Isnull(@ToMemberID, '') != ''
			SET @sWhere = @sWhere + ' AND M.MemberID Between N'''+@FromMemberID+''' AND N'''+@ToMemberID+''''

		IF Isnull(@ListMemberID, '')!= ''
		SET @sWhere = @sWhere + ' AND  M.MemberID IN (N'''+@ListMemberID+''')'
 	    
		SET @sSQL = N'
			Select  M.DivisionID, A01.DivisionName, M.ShopID, P10.ShopName, M.TranMonth, M.TranYear
					, Case When M.CVoucherNo is not null then M.CVoucherNo else M.VoucherNo end as VoucherNo
					, M.VoucherDate, M.ObjectID, M.ObjectName
					, Isnull(M.SaleManID, M.EmployeeID) as EmployeeID, Isnull(A03.FullName, M.EmployeeName) as EmployeeName
					, M.MemberID, M.MemberName, M.CurrencyID
					, M.CurrencyName, M.ExchangeRate, M.TotalAmount, M.TotalTaxAmount, M.TotalDiscountAmount
					, M.TotalInventoryAmount, PromoteChangeAmount
					, M.Change, M.TotalDiscountRate, M.TotalRedureRate
					, M.TotalRedureAmount, M.PaymentObjectAmount01, M.PaymentObjectAmount02
					, M.ChangeAmount, M.Description, M.SaleManID, A03.FullName as SaleManName
					, Isnull(M.BookingAmount, 0) as BookingAmount
					, Isnull(M.TotalGiftVoucherAmount, 0) as TotalGiftVoucherAmount
					, Isnull((Case when M.PvoucherNo is null and M.CVoucherNo is null then M.TotalInventoryAmount - Isnull(M.TotalGiftVoucherAmount, 0)
									when M.CVoucherNo is not null and ChangeAmount > 0 then M.ChangeAmount
									end), 0) as RevenueAmount
					, P.TotalAmount as ReturnAmount
					, case when (M.PaymentObjectAmount01 + M.PaymentObjectAmount02) > Isnull(THU.ThuTien, 0) + Isnull(M.BookingAmount, 0) + Isnull(ERP.OriginalAmount, 0) then (M.PaymentObjectAmount01 + M.PaymentObjectAmount02)
					else  Isnull(THU.ThuTien, 0) + Isnull(M.BookingAmount, 0) + Isnull(ERP.OriginalAmount, 0) end as MemberPay
					,case when POST0006.PaymentID01 = ''TRAGOP'' then Isnull(M.PaymentObjectAmount01,0) 
					when POST0006.PaymentID02 = ''TRAGOP'' then Isnull(M.PaymentObjectAmount02,0) 
					when POST0006.PaymentID01 = ''TRAGOP'' and POST0006.PaymentID02 = ''TRAGOP'' then  Isnull(M.PaymentObjectAmount01,0) + Isnull(M.PaymentObjectAmount02,0) 
					else 0 end as InstallmentAmount
	'
SET @sSQL1 = N'				
			From POST0016 M  WITH (NOLOCK) Left join (
														Select D.APKMInherited as APKBanDoi, Sum(Amount) as ThuTien
														from POST00801 M WITH (NOLOCK) inner join POST00802 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg 
														Where Isnull(M.IsDeposit, 0) = 0 and  isnull(IsPayInvoice, 0) in (0, 2,3) and D.APKMInherited is not null and M.DeleteFlg = 0
														Group by D.APKMInherited
													  ) THU on M.APK = THU.APKBanDoi
											--Lấy phiếu thu dưới ERP kế thừa từ phiếu bán hàng
											Left join AT9000 ERP WITH (NOLOCK) on ERP.InheritInvoicePOS = Cast(M.APK as nvarchar(50)) and ERP.IsInheritInvoicePOS = 1 
											Left join POST00802 P8  WITH (NOLOCK) on M.APK = P8.APKMInherited and M.DeleteFlg = P8.DeleteFlg
											Left join POST0010 P10 WITH (NOLOCK) on M.DivisionID = P10.DivisionID and M.ShopID = P10.ShopID
											Left join AT1101 A01 WITH (NOLOCK) on M.DivisionID = A01.DivisionID
											Left join AT1103 A03 WITH (NOLOCK) on M.SaleManID = A03.EmployeeID
											LEFT JOIN ( SELECT VoucherNo,PVoucherNo,TotalAmount,TotalInventoryAmount 
														FROM  POST0016 WITH (NOLOCK) WHERE PVoucherNo IS NOT NULL and DeleteFlg = 0) P on M.VoucherNo = P.VoucherNo 
											LEFT JOIN POST0006 On M.APKPaymentID = POST0006.APK
			Where M.DeleteFlg = 0 and ((M.CVoucherNo is null and M.PVoucherNo is null) or M.CVoucherNo is not null)  '+@sWhere+'
			Group by M.DivisionID, A01.DivisionName, M.ShopID, P10.ShopName, M.TranMonth, M.TranYear, M.VoucherNo
					, M.VoucherDate, M.ObjectID, M.ObjectName
					, M.EmployeeID, M.EmployeeName, M.MemberID, M.MemberName, M.CurrencyID
					, M.CurrencyName, M.ExchangeRate, M.TotalAmount, M.TotalTaxAmount, M.TotalDiscountAmount
					, M.TotalInventoryAmount, PromoteChangeAmount
					, M.Change, M.TotalDiscountRate, M.TotalRedureRate
					, M.TotalRedureAmount, M.PaymentObjectAmount01, M.PaymentObjectAmount02
					, M.ChangeAmount, M.Description, M.SaleManID, A03.FullName, M.PvoucherNo, M.CVoucherNo, Isnull(M.TotalGiftVoucherAmount, 0)
					, Isnull(M.BookingAmount, 0), Isnull(THU.ThuTien, 0), Isnull(ERP.OriginalAmount, 0), P.TotalAmount,POST0006.PaymentID01,POST0006.PaymentID02
			Order by M.ShopID, M.VoucherDate
			'
		EXEC (@sSQL+ @sSQL1)
		Print (@sSQL)
		Print (@sSQL1)
END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
