IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP3021]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP3021]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- BẢNG KÊ BÁN KẺ HÀNG HÓA DỊCH VỤ– POSR3021
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Thị Phượng on 23/01/2018
----Modify by: Hoàng vũ- 12-06-2018 Lấy lấy giá theo bảng giá trước thuế/sau thuế
----Modify by: Hoàng vũ- 24-08-2018 Lấy trường [Mã gói, Xuất ngay, Xuất tại chi nhánh] theo yêu cầu
----Modify by: Hoàng vũ- 11-06-2019 Báo cáo này lấy Tổng tiền của phiếu bán hàng và tổng tiền phiếu đặt cọc => thể hiện số tiền phải thu khách hàng còn lại sau khi lập hóa đơn không có liên qua gì đến thu tiền

-- <Example> EXEC POSP3021 'HCM', 'HCM', '50S1101', 'CH-HCM001'',''50S1101', 1, '2017-01-01', '2018-12-31', '12/2017'',''01/2018'',''02/2018','','','','', '', 'ASOFTADMIN'

CREATE PROCEDURE POSP3021 
(
	@DivisionID			VARCHAR(50),
	@DivisionIDList		NVARCHAR(MAX),
	@ShopID				VARCHAR(50),
	@ShopIDList			NVARCHAR(MAX),
	@IsDate				TINYINT,  --1: Theo ngày; 0: Theo kỳ
	@FromDate			DATETIME, 
	@ToDate				DATETIME, 
	@PeriodIDList		NVARCHAR(2000),
	@VoucherNo          VARCHAR(50),
	@ToSaleManID		VARCHAR(MAX),
	@FromSaleManID  	VARCHAR(MAX),
	@ToInventoryID		VARCHAR(MAX),
	@FromInventoryID	VARCHAR(MAX),
	@UserID				VARCHAR(50)
)
AS
BEGIN
		DECLARE @sSQL   NVARCHAR(MAX),  
				@sSQL1   NVARCHAR(MAX),
				@sSQL2   NVARCHAR(MAX),
				@sSQL3   NVARCHAR(MAX),
				@sWhere NVARCHAR(MAX),
				@sWhere1 NVARCHAR(MAX),
				@Date  NVARCHAR(MAX)

		SET @Date = ''
		SET @sWhere = ''
		SET @sWhere1 = ''
		--Nếu Danh sách @DivisionIDList trống thì lấy biến môi trường @DivisionID
		IF Isnull(@DivisionIDList, '') != ''
			SET @sWhere = @sWhere + ' AND M.DivisionID IN ('''+@DivisionIDList+''')'
		ELSE 
			SET @sWhere = @sWhere + ' AND M.DivisionID IN ('''+ @DivisionID+''', ''@@@'')'
	
		--Nếu Danh sách @ShopIDList trống thì lấy biến môi trường @ShopID
		IF Isnull(@ShopIDList, '')!= ''
			SET @sWhere = @sWhere + ' AND M.ShopID IN ('''+@ShopIDList+''')'
		ELSE 
			SET @sWhere = @sWhere + ' And M.ShopID IN ('''+@ShopID+''')'

		IF @IsDate = 1	
			SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR,M.VoucherDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
		ELSE
			SET @sWhere = @sWhere + ' AND (Case When  M.TranMonth <10 then ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) 
											Else rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) End) IN ('''+@PeriodIDList+''')'

		--Search theo nhân viên bán hàng  (Dữ liệu nhân viên bán hàng nhiều nên dùng control từ nhân viên bán hàng , đến nhân viên bán hàng
		IF Isnull(@FromSaleManID, '')!= '' and Isnull(@ToSaleManID, '') = ''
			SET @sWhere = @sWhere + ' AND M.SaleManID > = N'''+@FromSaleManID +''''
		ELSE IF Isnull(@FromSaleManID, '') = '' and Isnull(@ToSaleManID, '') != ''
			SET @sWhere = @sWhere + ' AND M.SaleManID < = N'''+@ToSaleManID +''''
		ELSE IF Isnull(@FromSaleManID, '') != '' and Isnull(@ToSaleManID, '') != ''
			SET @sWhere = @sWhere + ' AND M.SaleManID Between N'''+@FromSaleManID+''' AND N'''+@ToSaleManID+''''
		--Search theo mặt hàng  (Dữ liệu mặt hàng nhiều nên dùng control từ mặt hàng , đến mặt hàng
		IF Isnull(@FromInventoryID, '')!= '' and Isnull(@ToInventoryID, '') = ''
			SET @sWhere = @sWhere + ' AND D.InventoryID > = N'''+@FromInventoryID +''''
		ELSE IF Isnull(@FromInventoryID, '') = '' and Isnull(@ToInventoryID, '') != ''
			SET @sWhere = @sWhere + ' AND D.InventoryID < = N'''+@ToInventoryID +''''
		ELSE IF Isnull(@FromInventoryID, '') != '' and Isnull(@ToInventoryID, '') != ''
			SET @sWhere = @sWhere + ' AND D.InventoryID Between N'''+@FromInventoryID+''' AND N'''+@ToInventoryID+''''
		IF Isnull(@VoucherNo, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.VoucherNo,'''') LIKE N''%'+@VoucherNo+'%'' '

 	   	SET @sSQL = N'SELECT M.DivisionID, M.APK, M.VoucherNo, M.VoucherDate, M.TotalAmount
		, M.TotalInventoryAmount, M.SaleManID, M.ShopID, M.ShopName, M.Notes
		, M.TotalDiscountAmount, M.BookingAmount , M.PaymentAmount , M.PaymentID, M.TranMonth, M.TranYear
		, M.DeleteFlg, M.VATPercent, M.InventoryID, M.InventoryName, Sum(M.Quantity) as Quantity , Sum(M.FreeGift) as FreeGift , M.Notes01, M.UnitID
		, M.PackagePriceID, M.IsPackage, M.PackageID, M.IsWarehouseGeneral, M.IsExportNow
		INTO #TEMPOST3021
		From
			(
				SELECT M.DivisionID, M.APK, M.VoucherNo, M.VoucherDate
						, Case when D.IsTaxIncluded = 1 Then M.TotalAmount - M.TotalTaxAmount Else M.TotalAmount End as TotalAmount
						, M.TotalInventoryAmount,  M.SaleManID+'' _ ''+ M.SaleManName as SaleManID
						, M.ShopID, M.ShopName, M.Notes, M.TotalDiscountAmount, M.BookingAmount, M.TranMonth, M.TranYear , M.PaymentAmount , M.PaymentID
						, M.DeleteFlg, A3.VATPercent, D.InventoryID, D.InventoryName, D.ActualQuantity as Quantity, 0.0 as FreeGift , A3.Notes01, D.UnitID
						, D.PackagePriceID, D.IsPackage, D.PackageID, D.IsWarehouseGeneral, D.IsExportNow
				FROM 
					(	SELECT M.DivisionID, M.APK, M.VoucherNo, M.VoucherDate, M.TotalAmount, M.TotalInventoryAmount,  M.SaleManID,  A1.FullName as SaleManName, M.ShopID, A2.ShopName
								, M.Notes, M.TotalDiscountAmount, M.BookingAmount, M.TranMonth, M.TranYear, M.TotalTaxAmount
								, (Isnull(M.TotalInventoryAmount, 0) 
									--- Isnull(THU.ThuTien, 0) 
									- Isnull(M.BookingAmount, 0)
									--- Isnull(ERP.OriginalAmount, 0) 
									) as PaymentAmount 
								, M.DeleteFlg, A4.PaymentID01+''-''+Isnull(M.PaymentObjectID01,'''') +'', ''+ isnull(A4.PaymentID02,'''')+''-''+Isnull(M.PaymentObjectID02,'''') as PaymentID
						FROM POST0016 M WITH (NOLOCK)	
														--LEFT JOIN (
														--			Select D.APKMInherited as APKBanDoi, Sum(Amount) as ThuTien
														--			from POST00801 M WITH (NOLOCK) inner join POST00802 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg 
														--			Where Isnull(M.IsDeposit, 0) != 1 and D.APKMInherited is not null and M.DeleteFlg = 0
														--			Group by D.APKMInherited
														--		) THU on M.APK = THU.APKBanDoi
														--Lấy phiếu thu dưới ERP kế thừa từ phiếu bán hàng
														--Left join AT9000 ERP WITH (NOLOCK) on ERP.InheritInvoicePOS = M.APK and ERP.IsInheritInvoicePOS = 1 
														LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.SaleManID
														LEFT JOIN POST0010 A2 WITH (NOLOCK) ON A2.DivisionID = M.DivisionID and A2.ShopID = M.ShopID
														LEFT JOIN POST0006 A4 WITH (NOLOCK) ON A4.APK = M.APKPaymentID
						WHERE M.CVoucherNo is null and M.PVoucherNo is null
					) M
						INNER JOIN POST00161 D WITH (NOLOCK) ON M.DivisionID = D.DivisionID and M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
						LEFT JOIN AT1302 A3 WITH (NOLOCK) ON A3.InventoryID = D.InventoryID
				WHERE isnull(D.IsFreeGift,0) = 0 and M.DeleteFlg = 0 '+@sWhere+'

				UNION ALL'
		SET @sSQL2 =N'
				SELECT M.DivisionID, M.APK, M.VoucherNo, M.VoucherDate
						, Case when D.IsTaxIncluded = 1 Then M.TotalAmount - M.TotalTaxAmount Else M.TotalAmount End as TotalAmount
						, M.TotalInventoryAmount,M.SaleManID+'' _ ''+ M.SaleManName as SaleManID, M.ShopID, M.ShopName
						, M.Notes, M.TotalDiscountAmount, M.BookingAmount , M.TranMonth, M.TranYear, M.PaymentAmount , M.PaymentID, M.DeleteFlg, A3.VATPercent, D.InventoryID
						, D.InventoryName, 0.0 as Quantity, D.ActualQuantity as FreeGift , A3.Notes01, D.UnitID
						, D.PackagePriceID, D.IsPackage, D.PackageID, D.IsWarehouseGeneral, D.IsExportNow
				FROM 
					(	SELECT M.DivisionID, M.APK, M.VoucherNo, M.VoucherDate, M.TotalAmount, M.TotalInventoryAmount,  M.SaleManID,  A1.FullName as SaleManName, M.ShopID, A2.ShopName
							, M.Notes, M.TotalDiscountAmount, M.BookingAmount, M.TranMonth, M.TranYear, M.TotalTaxAmount
							, (Isnull(M.TotalInventoryAmount, 0) 
								--- Isnull(THU.ThuTien, 0) 
								- Isnull(M.BookingAmount, 0)
								--- Isnull(ERP.OriginalAmount, 0) 
								) as PaymentAmount 
							, M.DeleteFlg, A4.PaymentID01+''-''+Isnull(M.PaymentObjectID01,'''') +'', ''+ isnull(A4.PaymentID02,'''')+''-''+Isnull(M.PaymentObjectID02,'''') as PaymentID
						FROM POST0016 M WITH (NOLOCK) 
														--LEFT JOIN (
														--			Select D.APKMInherited as APKBanDoi, Sum(Amount) as ThuTien
														--			from POST00801 M WITH (NOLOCK) inner join POST00802 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg 
														--			Where Isnull(M.IsDeposit, 0) = 0 and  isnull(IsPayInvoice, 0) in (0, 2,3) and D.APKMInherited is not null and M.DeleteFlg = 0
														--			Group by D.APKMInherited
														--		) THU on M.APK = THU.APKBanDoi
														--Lấy phiếu thu dưới ERP kế thừa từ phiếu bán hàng
														--Left join AT9000 ERP WITH (NOLOCK) on ERP.InheritInvoicePOS = M.APK and ERP.IsInheritInvoicePOS = 1 
														LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.SaleManID
														LEFT JOIN POST0010 A2 WITH (NOLOCK) ON A2.DivisionID = M.DivisionID and A2.ShopID = M.ShopID
														LEFT JOIN POST0006 A4 WITH (NOLOCK) ON A4.APK = M.APKPaymentID
						WHERE M.CVoucherNo is null and M.PVoucherNo is null
					) M
						INNER JOIN POST00161 D WITH (NOLOCK) ON M.DivisionID = D.DivisionID and M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
						LEFT JOIN AT1302 A3 WITH (NOLOCK) ON A3.InventoryID = D.InventoryID
						WHERE isnull(D.IsFreeGift,0) = 1 and M.DeleteFlg = 0 '+@sWhere+'
			)M
			Group by M.DivisionID, M.APK, M.VoucherNo, M.VoucherDate, M.TotalAmount, M.TotalInventoryAmount, M.SaleManID, M.ShopID, M.ShopName, M.Notes, M.TotalDiscountAmount
					, M.BookingAmount , M.PaymentAmount , M.PaymentID, M.TranMonth, M.TranYear, M.DeleteFlg, M.VATPercent, M.InventoryID, M.InventoryName, M.Notes01, M.UnitID
					, M.PackagePriceID, M.IsPackage, M.PackageID, M.IsWarehouseGeneral, M.IsExportNow
					'

	SET @sSQL3 = '
			SELECT ROW_NUMBER() OVER (ORDER BY M.ShopID, M.VoucherNo, M.InventoryID ) AS No, M.DivisionID, A.DivisionName, M.APK, M.VoucherNo, M.VoucherDate, M.TotalAmount
						, M.TranMonth, M.TranYear, M.TotalInventoryAmount, M.SaleManID, M.ShopID, M.ShopName, M.Notes, M.TotalDiscountAmount, M.BookingAmount , M.PaymentAmount 
						, M.PaymentID, M.DeleteFlg, M.VATPercent, M.InventoryID, M.InventoryName, M.Quantity, M.FreeGift , M.Notes01, M.UnitID
						, M.PackagePriceID, M.IsPackage, M.PackageID, M.IsWarehouseGeneral, M.IsExportNow
		FROM #TEMPOST3021 M LEFT JOIN AT1101 A WITH (NOLOCK) ON A.DivisionID = M.DivisionID 
		ORDER BY M.ShopID, M.VoucherNo, M.InventoryID '
		EXEC (@sSQL +@sSQL2+ @sSQL3)
		--Print (@sSQL)
		--Print (@sSQL1)
		--Print (@sSQL2)
		--Print (@sSQL3)
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
