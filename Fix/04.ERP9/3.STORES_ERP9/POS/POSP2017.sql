IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP2017]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP2017]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Mapping sau khi chọn từ màn hình POSF2013_Kế thừa phiếu đặt cọc vào màn hình POSF00161
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hoàng Vũ, Date 05/06/2018: chuyển từ Script qua Store
----Edited by: Hoàng vũ DATE 12/06/2018: Load thêm trường APKPackageInventoryID, Quản lý bán hàng theo gói sản phẩm (1 gói sản phẩm có thể khai báo 1 mặt hàng nhiều lần): lưu vết để truy xuất ngược gói để lấy giá, thuế.
----Modify by: Hoàng Vũ 11/04/2019: Lấy các trường để kiểm tra mặt hàng có quản lý tồn kho, sử dụng quà khuyến mãi
----Modify by: Hoàng Vũ 16/04/2019: Lấy các trường bên bảng giá lưu trự qua phiếu bán hàng M.MinPrice, M.Notes01, M.Notes02, M.Notes03 để phục vụ tính điểm, tính hoa hòng theo nhân viên => KHACH HANG NHANNHOC
----Modify by: Hoàng Vũ 19/04/2019: Lấy đơn giá sỹ, đơn giá trả góp, phục vụ cho bán hàng trả góp
----Modify by: Hoàng Vũ 09/05/2019: LỖi do tách bản chuẩn và OKIA, nhưng để customize của OKIA sai nên số liệu lên Double
-- <Example> EXEC POSP2017 'HCM','CA4367FF-920B-4F53-97A9-F1D638F0C9EB'

CREATE PROCEDURE POSP2017 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@APK uniqueidentifier		
) 
AS 
BEGIN
	
	DECLARE @CustomerName INT
	CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
	INSERT #CustomerName EXEC AP4444
	SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)
	IF @CustomerName in (163,87) ------ OKIA
	Begin 		
		Select POST2011.APK, POST2011.APKMaster, POST2011.DivisionID, POST2011.ShopID, POST2011.InventoryID, POST2011.InventoryName
				, POST2011.UnitID, AT1304.UnitName, POST2011.ActualQuantity, POST2011.UnitPrice, POST2011.Amount, POST2011.DiscountRate
				, POST2011.DiscountAmount, Case when Isnull(POST2011.VATPercent, 0) =  0 then N'T00' else POST2011.VATGroupID end VATGroupID, POST2011.VATPercent, POST2011.TaxAmount, POST2011.InventoryAmount
				, POST2011.Ana01ID, POST2011.Ana02ID, POST2011.Ana03ID, POST2011.Ana04ID, POST2011.Ana05ID, POST2011.Ana06ID, POST2011.Ana07ID
				, POST2011.Ana08ID, POST2011.Ana09ID, POST2011.Ana10ID, POST2011.Notes, POST2011.OrderNo, POST2011.PackagePriceID
				, POST2011.PackageID, POST2011.IsPackage, POST2011.OrderPackage, POST2011.IsGift, POST2011.IsTaxIncluded, POST2011.BeforeVATDiscountAmount
				, POST2011.BeforeVATUnitPrice, POST2011.IsTable, POST2011.PriceTable, POST2011.IsInvoicePromotionID
				, POST2011.InvoicePromotionID, POST2011.IsPromotePriceTable, POST2011.PromotePriceTableID, POST2011.IsPromotion, POST2011.PromoteID
				, POST2011.APKPackageInventoryID, Isnull(AT1302.IsGiftVoucher, 0) as IsGiftVoucher, Isnull(AT1302.IsStocked, 0) as IsStocked
				, POST2011.MinPrice, POST2011.Notes01, POST2011.Notes02, POST2011.Notes03, POST2011.InstallmentPrice, POST2011.WholesalePrice
				--into POSP2017_test
		From 				
			(	Select POST2011.APK, POST2011.APKMaster, POST2011.DivisionID, POST2011.ShopID, POST2011.InventoryID, POST2011.InventoryName
					   , POST2011.UnitID, POST2011.ActualQuantity, POST2011.UnitPrice, POST2011.Amount, POST2011.DiscountRate
					   , POST2011.DiscountAmount, POST2011.VATGroupID, POST2011.VATPercent, POST2011.TaxAmount, POST2011.InventoryAmount
					   , POST2011.Ana01ID, POST2011.Ana02ID, POST2011.Ana03ID, POST2011.Ana04ID, POST2011.Ana05ID, POST2011.Ana06ID, POST2011.Ana07ID
					   , POST2011.Ana08ID, POST2011.Ana09ID, POST2011.Ana10ID, POST2011.Notes, POST2011.OrderNo, POST2011.PackagePriceID
					   , POST2011.PackageID, POST2011.IsPackage, POST2011.OrderPackage, Isnull(CT0148.IsGift, 0) as IsGift
					   , Isnull(POST2011.IsTaxIncluded, 0) as IsTaxIncluded, Isnull(POST2011.BeforeVATDiscountAmount, 0.0) as BeforeVATDiscountAmount
					   , Isnull(POST2011.BeforeVATUnitPrice, 0.0) as BeforeVATUnitPrice, POST2011.IsTable, POST2011.PriceTable, POST2011.IsInvoicePromotionID
					   , POST2011.InvoicePromotionID, POST2011.IsPromotePriceTable, POST2011.PromotePriceTableID, POST2011.IsPromotion, POST2011.PromoteID
					   , Isnull(POST2011.APKPackageInventoryID, CT0148.APK) as APKPackageInventoryID
					   , POST2011.MinPrice, POST2011.Notes01, POST2011.Notes02, POST2011.Notes03, 0 as InstallmentPrice, 0 as WholesalePrice
				from POST2011 with (NOLOCK) inner join CT0148 with (NOLOCK) on CT0148.PackagePriceID = POST2011.PackagePriceID and CT0148.PackageID = POST2011.PackageID 
						and (Case when Isnull(Cast(POST2011.APKPackageInventoryID as nvarchar(50)), '') != '' then  Cast(CT0148.APK as nvarchar(50)) else CT0148.InventoryID end)
						= (Case when Isnull(Cast(POST2011.APKPackageInventoryID as nvarchar(50)), '') != '' then  Cast(POST2011.APKPackageInventoryID as nvarchar(50)) Else POST2011.InventoryID end)
				Where POST2011.DivisionID = @DivisionID and POST2011.APKMaster = @APK and Isnull(POST2011.IsPackage, 0) = 1
				Union all
				Select POST2011.APK, POST2011.APKMaster, POST2011.DivisionID, POST2011.ShopID, POST2011.InventoryID, POST2011.InventoryName
					   , POST2011.UnitID, POST2011.ActualQuantity, POST2011.UnitPrice, POST2011.Amount, POST2011.DiscountRate
					   , POST2011.DiscountAmount, POST2011.VATGroupID, POST2011.VATPercent, POST2011.TaxAmount, POST2011.InventoryAmount
					   , POST2011.Ana01ID, POST2011.Ana02ID, POST2011.Ana03ID, POST2011.Ana04ID, POST2011.Ana05ID, POST2011.Ana06ID, POST2011.Ana07ID
					   , POST2011.Ana08ID, POST2011.Ana09ID, POST2011.Ana10ID, POST2011.Notes, POST2011.OrderNo, POST2011.PackagePriceID
					   , POST2011.PackageID, POST2011.IsPackage, POST2011.OrderPackage, Isnull(OT1302.IsGift, 0) as IsGift
					   , Isnull(POST2011.IsTaxIncluded, 0) as IsTaxIncluded, Isnull(POST2011.BeforeVATDiscountAmount, 0.0) as BeforeVATDiscountAmount
					   , Isnull(POST2011.BeforeVATUnitPrice, 0.0) as BeforeVATUnitPrice, POST2011.IsTable, POST2011.PriceTable, POST2011.IsInvoicePromotionID
					   , POST2011.InvoicePromotionID, POST2011.IsPromotePriceTable, POST2011.PromotePriceTableID, POST2011.IsPromotion, POST2011.PromoteID
					   , NULL as APKPackageInventoryID
					   , POST2011.MinPrice, POST2011.Notes01, POST2011.Notes02, POST2011.Notes03, OT1302.InstallmentPrice, OT1302.WholesalePrice
				from POST2011 with (NOLOCK) inner join OT1302 with (NOLOCK) on OT1302.DivisionID = POST2011.DivisionID and OT1302.ID = POST2011.PriceTable and OT1302.InventoryID = POST2011.InventoryID 
				Where POST2011.DivisionID = @DivisionID and POST2011.APKMaster = @APK  and Isnull(POST2011.IsTable, 0) = 1
				Union all
				Select POST2011.APK, POST2011.APKMaster, POST2011.DivisionID, POST2011.ShopID, POST2011.InventoryID, POST2011.InventoryName
					   , POST2011.UnitID, POST2011.ActualQuantity, POST2011.UnitPrice, POST2011.Amount, POST2011.DiscountRate
					   , POST2011.DiscountAmount, POST2011.VATGroupID, POST2011.VATPercent, POST2011.TaxAmount, POST2011.InventoryAmount
					   , POST2011.Ana01ID, POST2011.Ana02ID, POST2011.Ana03ID, POST2011.Ana04ID, POST2011.Ana05ID, POST2011.Ana06ID, POST2011.Ana07ID
					   , POST2011.Ana08ID, POST2011.Ana09ID, POST2011.Ana10ID, POST2011.Notes, POST2011.OrderNo, POST2011.PackagePriceID
					   , POST2011.PackageID, POST2011.IsPackage, POST2011.OrderPackage, Isnull(OT1302.IsGift, 0) as IsGift
					   , Isnull(POST2011.IsTaxIncluded, 0) as IsTaxIncluded, Isnull(POST2011.BeforeVATDiscountAmount, 0.0) as BeforeVATDiscountAmount
					   , Isnull(POST2011.BeforeVATUnitPrice, 0.0) as BeforeVATUnitPrice, POST2011.IsTable, POST2011.PriceTable, POST2011.IsInvoicePromotionID
					   , POST2011.InvoicePromotionID, POST2011.IsPromotePriceTable, POST2011.PromotePriceTableID, POST2011.IsPromotion, POST2011.PromoteID
					   , NULL as APKPackageInventoryID
					   , POST2011.MinPrice, POST2011.Notes01, POST2011.Notes02, POST2011.Notes03, OT1302.InstallmentPrice, OT1302.WholesalePrice
				from POST2011 with (NOLOCK) inner join OT1302 with (NOLOCK) on OT1302.DivisionID = POST2011.DivisionID and OT1302.ID = POST2011.PromotePriceTableID and OT1302.InventoryID = POST2011.InventoryID 
				Where POST2011.DivisionID = @DivisionID and APKMaster = @APK  and Isnull(IsPromotePriceTable, 0) = 1
			) POST2011 inner join AT1304 with (NOLOCK) on AT1304.UnitID = POST2011.UnitID
					   Left join AT1302 with (NOLOCK) on POST2011.InventoryID = AT1302.InventoryID
		Order by OrderNo, OrderPackage

	end
	else
	begin
		
			Select POST2011.APK, POST2011.APKMaster, POST2011.DivisionID, POST2011.ShopID, POST2011.InventoryID, POST2011.InventoryName
				, POST2011.UnitID, AT1304.UnitName, POST2011.ActualQuantity, POST2011.UnitPrice, POST2011.Amount, POST2011.DiscountRate
				, POST2011.DiscountAmount, Case when Isnull(POST2011.VATPercent, 0) =  0 then N'T00' else POST2011.VATGroupID end VATGroupID, POST2011.VATPercent, POST2011.TaxAmount, POST2011.InventoryAmount
				, POST2011.Ana01ID, POST2011.Ana02ID, POST2011.Ana03ID, POST2011.Ana04ID, POST2011.Ana05ID, POST2011.Ana06ID, POST2011.Ana07ID
				, POST2011.Ana08ID, POST2011.Ana09ID, POST2011.Ana10ID, POST2011.Notes, POST2011.OrderNo, POST2011.PackagePriceID
				, POST2011.PackageID, POST2011.IsPackage, POST2011.OrderPackage, POST2011.IsGift, POST2011.IsTaxIncluded, POST2011.BeforeVATDiscountAmount
				, POST2011.BeforeVATUnitPrice, POST2011.IsTable, POST2011.PriceTable, POST2011.IsInvoicePromotionID
				, POST2011.InvoicePromotionID, POST2011.IsPromotePriceTable, POST2011.PromotePriceTableID, POST2011.IsPromotion, POST2011.PromoteID
				, POST2011.APKPackageInventoryID, Isnull(AT1302.IsGiftVoucher, 0) as IsGiftVoucher, Isnull(AT1302.IsStocked, 0) as IsStocked
				, POST2011.MinPrice, POST2011.Notes01, POST2011.Notes02, POST2011.Notes03, POST2011.InstallmentPrice, POST2011.WholesalePrice
				into POSP2017_test
		From 				
			(	Select POST2011.APK, POST2011.APKMaster, POST2011.DivisionID, POST2011.ShopID, POST2011.InventoryID, POST2011.InventoryName
					   , POST2011.UnitID, POST2011.ActualQuantity, POST2011.UnitPrice, POST2011.Amount, POST2011.DiscountRate
					   , POST2011.DiscountAmount, POST2011.VATGroupID, POST2011.VATPercent, POST2011.TaxAmount, POST2011.InventoryAmount
					   , POST2011.Ana01ID, POST2011.Ana02ID, POST2011.Ana03ID, POST2011.Ana04ID, POST2011.Ana05ID, POST2011.Ana06ID, POST2011.Ana07ID
					   , POST2011.Ana08ID, POST2011.Ana09ID, POST2011.Ana10ID, POST2011.Notes, POST2011.OrderNo, POST2011.PackagePriceID
					   , POST2011.PackageID, POST2011.IsPackage, POST2011.OrderPackage, Cast(0 as TinyInt) as IsGift
					   , Isnull(POST2011.IsTaxIncluded, 0) as IsTaxIncluded, Isnull(POST2011.BeforeVATDiscountAmount, 0.0) as BeforeVATDiscountAmount
					   , Isnull(POST2011.BeforeVATUnitPrice, 0.0) as BeforeVATUnitPrice, POST2011.IsTable, POST2011.PriceTable, POST2011.IsInvoicePromotionID
					   , POST2011.InvoicePromotionID, POST2011.IsPromotePriceTable, POST2011.PromotePriceTableID, POST2011.IsPromotion, POST2011.PromoteID
					   , Isnull(POST2011.APKPackageInventoryID,NEWID()) as APKPackageInventoryID
					   , Isnull(POST2011.MinPrice,0) as MinPrice, POST2011.Notes01, POST2011.Notes02, POST2011.Notes03, 0 as InstallmentPrice, 0 as WholesalePrice
				from POST2011 with (NOLOCK) 
				Where POST2011.DivisionID = @DivisionID and POST2011.APKMaster = @APK
				Union all
				Select POST2011.APK, POST2011.APKMaster, POST2011.DivisionID, POST2011.ShopID, POST2011.InventoryID, POST2011.InventoryName
					   , POST2011.UnitID, POST2011.ActualQuantity, POST2011.UnitPrice, POST2011.Amount, POST2011.DiscountRate
					   , POST2011.DiscountAmount, POST2011.VATGroupID, POST2011.VATPercent, POST2011.TaxAmount, POST2011.InventoryAmount
					   , POST2011.Ana01ID, POST2011.Ana02ID, POST2011.Ana03ID, POST2011.Ana04ID, POST2011.Ana05ID, POST2011.Ana06ID, POST2011.Ana07ID
					   , POST2011.Ana08ID, POST2011.Ana09ID, POST2011.Ana10ID, POST2011.Notes, POST2011.OrderNo, POST2011.PackagePriceID
					   , POST2011.PackageID, POST2011.IsPackage, POST2011.OrderPackage, Isnull(OT1302.IsGift, 0) as IsGift
					   , Isnull(POST2011.IsTaxIncluded, 0) as IsTaxIncluded, Isnull(POST2011.BeforeVATDiscountAmount, 0.0) as BeforeVATDiscountAmount
					   , Isnull(POST2011.BeforeVATUnitPrice, 0.0) as BeforeVATUnitPrice, POST2011.IsTable, POST2011.PriceTable, POST2011.IsInvoicePromotionID
					   , POST2011.InvoicePromotionID, POST2011.IsPromotePriceTable, POST2011.PromotePriceTableID, POST2011.IsPromotion, POST2011.PromoteID
					   , NULL as APKPackageInventoryID
					   , POST2011.MinPrice, POST2011.Notes01, POST2011.Notes02, POST2011.Notes03, OT1302.InstallmentPrice, OT1302.WholesalePrice
				from POST2011 with (NOLOCK) inner join OT1302 with (NOLOCK) on OT1302.DivisionID = POST2011.DivisionID and OT1302.ID = POST2011.PriceTable and OT1302.InventoryID = POST2011.InventoryID 
				Where POST2011.DivisionID = @DivisionID and POST2011.APKMaster = @APK  and Isnull(POST2011.IsTable, 0) = 1
				Union all
				Select POST2011.APK, POST2011.APKMaster, POST2011.DivisionID, POST2011.ShopID, POST2011.InventoryID, POST2011.InventoryName
					   , POST2011.UnitID, POST2011.ActualQuantity, POST2011.UnitPrice, POST2011.Amount, POST2011.DiscountRate
					   , POST2011.DiscountAmount, POST2011.VATGroupID, POST2011.VATPercent, POST2011.TaxAmount, POST2011.InventoryAmount
					   , POST2011.Ana01ID, POST2011.Ana02ID, POST2011.Ana03ID, POST2011.Ana04ID, POST2011.Ana05ID, POST2011.Ana06ID, POST2011.Ana07ID
					   , POST2011.Ana08ID, POST2011.Ana09ID, POST2011.Ana10ID, POST2011.Notes, POST2011.OrderNo, POST2011.PackagePriceID
					   , POST2011.PackageID, POST2011.IsPackage, POST2011.OrderPackage, Isnull(OT1302.IsGift, 0) as IsGift
					   , Isnull(POST2011.IsTaxIncluded, 0) as IsTaxIncluded, Isnull(POST2011.BeforeVATDiscountAmount, 0.0) as BeforeVATDiscountAmount
					   , Isnull(POST2011.BeforeVATUnitPrice, 0.0) as BeforeVATUnitPrice, POST2011.IsTable, POST2011.PriceTable, POST2011.IsInvoicePromotionID
					   , POST2011.InvoicePromotionID, POST2011.IsPromotePriceTable, POST2011.PromotePriceTableID, POST2011.IsPromotion, POST2011.PromoteID
					   , NULL as APKPackageInventoryID
					   , POST2011.MinPrice, POST2011.Notes01, POST2011.Notes02, POST2011.Notes03, OT1302.InstallmentPrice, OT1302.WholesalePrice
				from POST2011 with (NOLOCK) inner join OT1302 with (NOLOCK) on OT1302.DivisionID = POST2011.DivisionID and OT1302.ID = POST2011.PromotePriceTableID and OT1302.InventoryID = POST2011.InventoryID 
				Where POST2011.DivisionID = @DivisionID and APKMaster = @APK  and Isnull(IsPromotePriceTable, 0) = 1
			) POST2011 inner join AT1304 with (NOLOCK) on AT1304.UnitID = POST2011.UnitID
					   Left join AT1302 with (NOLOCK) on POST2011.InventoryID = AT1302.InventoryID
		Order by OrderNo, OrderPackage
	end

END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
