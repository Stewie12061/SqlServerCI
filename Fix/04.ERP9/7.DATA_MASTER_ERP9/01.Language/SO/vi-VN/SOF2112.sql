------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2112 - CRM 
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
SET @FormID = 'SOF2112';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá vốn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.PriceOriginal' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉ lệ lợi nhuận mong muốn(%)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.ProfitRate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lợi nhuận mong muốn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.ProfitDesired' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá/bộ giao tại xưởng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.PriceSetFactory' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá/m2 giao tại xưởng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.PriceAcreageFactory' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá/bộ lắp đặt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.PriceSetInstall' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá/m2 lắp đặt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.PriceAcreageInstall' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá đối thủ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.PriceRival' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá đối thủ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.PriceRival' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa BOM';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.IsInheritBOM' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hạng mục';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.StandardID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hạng mục';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.StandardName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông số';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.StandardValue' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã vật tư';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.NodeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên vật tư';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.NodeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.Price' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.Amount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chi phí';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.TypeOfCostName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên chi phí';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.CostName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉ lệ(%)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.Percentage' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.PriceCost' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.AmountCost' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.LastModifyUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.LastModifyDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.StatusID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết bảng tính giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.ThongTinBangTinhGia' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông sô kĩ thuật';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.TabSOT2111' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vật tư tiêu hao';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.TabSOT2112' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi phí';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.TabSOT2114' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số bộ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.SetNumber' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.Quantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉ lệ hao hụt(%)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.PercentageLoss' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉ trọng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.Density' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.QuantityCost' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng định mức';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.QuantityBOM' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phiếu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.StatusSS' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Màu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.ColorName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.AccountName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.UnitName' , @FormID, @LanguageValue, @Language;