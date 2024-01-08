IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP3082]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP3082]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- BÁO CÁO SALES REPORT (Customizeindex = OKIA)
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hoàng Vũ on 28/03/2018
----Modify by: 
-- <Example> EXEC AP3082 'HCM', 1, '2017-01-01', '2018-12-31', '12', '2017','01', '2018', '50S1101', '50S1101', '','', '','' , 'ASOFTADMIN'

CREATE PROCEDURE AP3082 
(
	  @DivisionID   NVARCHAR(50),
	  @IsDate    TINYINT,  --1: Theo ngày; 0: Theo kỳ
	  @FromDate   DATETIME, 
	  @ToDate    DATETIME, 
	  @FromTranMonth  Int,
	  @FromTranYear  Int,
	  @ToTranMonth  Int,
	  @ToTranYear   Int,
	  @FromShopID   NVARCHAR(50), 
	  @ToShopID   NVARCHAR(50), 
	  @ToSaleManID  VARCHAR(MAX),
	  @FromSaleManID   VARCHAR(MAX),
	  @ToPackageID  VARCHAR(MAX),
	  @FromPackageID VARCHAR(MAX),
	  @UserID    VARCHAR(50)
)
AS
BEGIN
		DECLARE @sSQL01   NVARCHAR(MAX),  
				@sSQL02   NVARCHAR(MAX),
				@sSQL03   NVARCHAR(MAX),
				@sWhere NVARCHAR(MAX),
				@Date  NVARCHAR(MAX)
DECLARE	@FromMonthYearText NVARCHAR(20), 
				@ToMonthYearText NVARCHAR(20), 
				@FromDateText NVARCHAR(20), 
				@ToDateText NVARCHAR(20)
		SET @Date = ''
		SET @sWhere = ''
		
		--Nếu Danh sách @DivisionIDList trống thì lấy biến môi trường @DivisionID
		
		SET @FromMonthYearText = STR(@FromTranMonth + @FromTranYear * 100)
		SET @ToMonthYearText = STR(@ToTranMonth + @ToTranYear * 100)
		SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
		SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

		--Search theo thời gian
		IF @IsDate = 1	
			SET @sWhere = @sWhere + ' AND M.VoucherDate between ''' + @FromDateText + ''' and ''' + @ToDateText +''''
		ELSE
			SET @sWhere = @sWhere + ' AND M.TranMonth + M.TranYear*100 BETWEEN '+@FromMonthYearText+' AND '+@ToMonthYearText
		
		--Search theo cửa hàng
		IF Isnull(@FromShopID, '')!= '' and Isnull(@ToShopID, '') = ''
			SET @sWhere = @sWhere + ' AND M.ShopID > = N'''+@FromShopID +''''
		ELSE IF Isnull(@FromShopID, '') = '' and Isnull(@ToShopID, '') != ''
			SET @sWhere = @sWhere + ' AND M.ShopID < = N'''+@ToShopID +''''
		ELSE IF Isnull(@FromShopID, '') != '' and Isnull(@ToShopID, '') != ''
			SET @sWhere = @sWhere + ' AND M.ShopID Between N'''+@FromShopID+''' AND N'''+@ToShopID+''''

		--Search theo nhân viên bán hàng  (Dữ liệu nhân viên bán hàng nhiều nên dùng control từ nhân viên bán hàng , đến nhân viên bán hàng
		IF Isnull(@FromSaleManID, '')!= '' and Isnull(@ToSaleManID, '') = ''
			SET @sWhere = @sWhere + ' AND M.SaleManID > = N'''+@FromSaleManID +''''
		ELSE IF Isnull(@FromSaleManID, '') = '' and Isnull(@ToSaleManID, '') != ''
			SET @sWhere = @sWhere + ' AND M.SaleManID < = N'''+@ToSaleManID +''''
		ELSE IF Isnull(@FromSaleManID, '') != '' and Isnull(@ToSaleManID, '') != ''
			SET @sWhere = @sWhere + ' AND M.SaleManID Between N'''+@FromSaleManID+''' AND N'''+@ToSaleManID+''''
		
		--Search theo gói sản phẩm
		IF Isnull(@FromPackageID, '')!= '' and Isnull(@ToPackageID, '') = ''
			SET @sWhere = @sWhere + ' AND D.InventoryID > = N'''+@FromPackageID +''''
		ELSE IF Isnull(@FromPackageID, '') = '' and Isnull(@ToPackageID, '') != ''
			SET @sWhere = @sWhere + ' AND D.InventoryID < = N'''+@ToPackageID +''''
		ELSE IF Isnull(@FromPackageID, '') != '' and Isnull(@ToPackageID, '') != ''
			SET @sWhere = @sWhere + ' AND D.InventoryID Between N'''+@FromPackageID+''' AND N'''+@ToPackageID+''''


		SET @sSQL01 = N'
					SELECT M.DivisionID, M.APK, M.VoucherNo, M.VoucherDate, M.VATAmount, M.TotalAmount, M.PaymentAmount,  M.SaleManID,  M.SaleManName
								, M.ShopID, M.ShopName, M.Notes, M.DiscountAmount, M.TranMonth, M.TranYear , M.Amount, M.DeleteFlg, M.PackagePriceID
								, M.PackageID, M.InventoryID, M.InventoryName, Sum(M.Quantity) as Quantity , Sum(M.FreeGift) as FreeGift , M.UnitID
					INTO #TEMPOST3024
					From
						(
							SELECT M.DivisionID, M.APK, M.VoucherNo, M.VoucherDate, M.VATAmount, M.TotalAmount, M.PaymentAmount,  M.SaleManID, M.SaleManName
									, M.ShopID, M.ShopName, M.Notes, M.DiscountAmount, M.TranMonth, M.TranYear  , M.Amount , M.DeleteFlg, D.PackagePriceID
									, D.PackageID, D.InventoryID, D.InventoryName, D.ActualQuantity as Quantity, 0.0 as FreeGift , D.UnitID
							FROM 
								(
									SELECT M.DivisionID, M.APK, M.VoucherNo, M.VoucherDate, M.DeleteFlg,  M.Notes, M.TotalInventoryAmount as PaymentAmount
											,  M.SaleManID,  A1.FullName as SaleManName, M.ShopID, A2.ShopName, M.TotalDiscountAmount as DiscountAmount
											, M.TotalAmount as Amount , M.TotalTaxAmount as VATAmount, (M.TotalAmount + M.TotalTaxAmount) as TotalAmount, M.TranMonth, M.TranYear
									FROM POST0016 M WITH (NOLOCK) LEFT JOIN (
																				 Select D.APKMInherited as APKBanDoi, Sum(Amount) as ThuTien
																				 from POST00801 M WITH (NOLOCK) inner join POST00802 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg 
																				 Where Isnull(M.IsDeposit, 0) = 0 and  isnull(IsPayInvoice, 0) in (0, 2,3) and D.APKMInherited is not null and M.DeleteFlg = 0
																				 Group by D.APKMInherited
																			) THU on M.APK = THU.APKBanDoi
																	--Lấy phiếu thu dưới ERP kế thừa từ phiếu bán hàng
																	Left join AT9000 ERP WITH (NOLOCK) on ERP.InheritInvoicePOS = M.APK and ERP.IsInheritInvoicePOS = 1 
																	LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.SaleManID
																	LEFT JOIN POST0010 A2 WITH (NOLOCK) ON A2.DivisionID = M.DivisionID and A2.ShopID = M.ShopID
									WHERE M.CVoucherNo is null and M.PVoucherNo is null
								) M INNER JOIN POST00161 D WITH (NOLOCK) ON M.DivisionID = D.DivisionID and M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
							WHERE isnull(D.IsFreeGift,0) = 0 and M.DeleteFlg = 0 AND M.DivisionID = N'''+@DivisionID+''' '+@sWhere+'
							UNION ALL'
		SET @sSQL02 =N'
							SELECT M.DivisionID, M.APK, M.VoucherNo, M.VoucherDate, M.VATAmount, M.TotalAmount, M.PaymentAmount,  M.SaleManID,  M.SaleManName
									, M.ShopID, M.ShopName, M.Notes, M.DiscountAmount, M.TranMonth, M.TranYear , M.Amount, M.DeleteFlg, D.PackagePriceID, D.PackageID
									, D.InventoryID, D.InventoryName, D.ActualQuantity as Quantity, 0.0 as FreeGift , D.UnitID
							FROM 
								(
									SELECT M.DivisionID, M.APK, M.VoucherNo, M.VoucherDate, M.DeleteFlg,  M.Notes, M.TotalInventoryAmount as PaymentAmount,  M.SaleManID
											, A1.FullName as SaleManName, M.ShopID, A2.ShopName, M.TotalDiscountAmount as DiscountAmount, M.TotalAmount as Amount 
											, M.TotalTaxAmount as VATAmount, (M.TotalAmount + M.TotalTaxAmount) as TotalAmount, M.TranMonth, M.TranYear
									FROM POST0016 M WITH (NOLOCK) LEFT JOIN (
																				 Select D.APKMInherited as APKBanDoi, Sum(Amount) as ThuTien
																				 from POST00801 M WITH (NOLOCK) inner join POST00802 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg 
																				 Where Isnull(M.IsDeposit, 0) = 0 and  isnull(IsPayInvoice, 0) in (0, 2,3) and D.APKMInherited is not null and M.DeleteFlg = 0
																				 Group by D.APKMInherited
																			 ) THU on M.APK = THU.APKBanDoi
																	--Lấy phiếu thu dưới ERP kế thừa từ phiếu bán hàng
																	Left join AT9000 ERP WITH (NOLOCK) on ERP.InheritInvoicePOS = M.APK and ERP.IsInheritInvoicePOS = 1 
																	LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.SaleManID
																	LEFT JOIN POST0010 A2 WITH (NOLOCK) ON A2.DivisionID = M.DivisionID and A2.ShopID = M.ShopID
									WHERE M.CVoucherNo is null and M.PVoucherNo is null
								) M INNER JOIN POST00161 D WITH (NOLOCK) ON M.DivisionID = D.DivisionID and M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
							WHERE isnull(D.IsFreeGift,0) = 1 and M.DeleteFlg = 0 AND M.DivisionID = N'''+@DivisionID+''' '+@sWhere+'
						)M
					Group by M.DivisionID, M.APK, M.VoucherNo, M.VoucherDate, M.VATAmount, M.TotalAmount, M.PaymentAmount,  M.SaleManID,  M.SaleManName, M.ShopID, M.ShopName
							, M.Notes, M.DiscountAmount, M.TranMonth, M.TranYear , M.Amount, M.DeleteFlg, M.PackagePriceID, M.PackageID, M.InventoryID, M.InventoryName , M.UnitID '

		SET @sSQL03 = '	SELECT M.DivisionID, A.DivisionName, M.ShopName, M.SaleManID, M.SaleManName, M.VoucherNo, M.VoucherDate, M.TranMonth, M.TranYear 
								, M.PackagePriceID, M.PackageID, B.PackageName, M.InventoryID, M.InventoryName, M.UnitID, M.Quantity , M.FreeGift, M.Amount
								, M.DiscountAmount, M.VATAmount, M.TotalAmount, M.PaymentAmount, M.ShopID, M.Notes, M.DeleteFlg, M.APK
						FROM #TEMPOST3024 M LEFT JOIN AT1101 A WITH (NOLOCK) ON A.DivisionID = M.DivisionID
											LEFT JOIN CT0147 B WITH (NOLOCK) ON B.PackagePriceID = M.PackagePriceID and B.PackageID = M.PackageID
						ORDER BY M.ShopID, M.VoucherNo, M.InventoryID '
		EXEC (@sSQL01 +@sSQL02+ @sSQL03)
	
END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
