------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2111 - CRM 
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000)
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thuc thi truy van
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @Language = 'vi-VN';
SET @ModuleID = 'SO';
SET @FormID = 'SOF2111';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá vốn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.PriceOriginal' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉ lệ lợi nhuận mong muốn(%)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.ProfitRate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lợi nhuận mong muốn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.ProfitDesired' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá/bộ giao tại xưởng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.PriceSetFactory' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá/m2 giao tại xưởng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.PriceAcreageFactory' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá/bộ lắp đặt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.PriceSetInstall' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá/m2 lắp đặt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.PriceAcreageInstall' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá đối thủ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.PriceRival' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa BOM';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.IsInheritBOM' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Thông số kĩ thuật';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.TabSOT2111' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vật tư tiêu hao';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.TabSOT2112' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi phí trước thuế';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.TabSOT2113' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi phí';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.TabSOT2114' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hạng mục';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.StandardID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hạng mục';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.StandardName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông số';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.StandardValue' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã vật tư';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.NodeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên vật tư';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.NodeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.UnitName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.Price' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.Amount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chi phí';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.TypeOfCost' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chi phí';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.TypeOfCostName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên chi phí';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.CostID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên chi phí';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.CostName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉ lệ(%)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.Percentage' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.PriceCost' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.AmountCost' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.TypeOfCost.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.TypeOfCostName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.CostID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.CostName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số bộ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.SetNumber' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.Quantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉ lệ hao hụt(%)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.PercentageLoss' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉ trọng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.Density' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.QuantityCost' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng định mức';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.QuantityBOM' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phiếu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Màu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.ColorID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.ColorID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.ColorName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.Price.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.AccountName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.StatusSS' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.AccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chi phí';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.ItemID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên chi phí';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.TypeOfMethod' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.AnaID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.AnaName.CB' , @FormID, @LanguageValue, @Language;