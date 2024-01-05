-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ NMF2031- NM
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000),

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT


------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
------------------------------------------------------------------------------------------------------
/*
 - Tieng Viet: vi-VN 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'vi-VN' 
SET @ModuleID = 'NM';
SET @FormID = 'NMF2031';

SET @LanguageValue = N'Cập nhật phiếu điều tra dinh dưỡng';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điều tra';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.InvestigateVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày điều tra';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.InvestigateVoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu kê chợ';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.MarketVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thực đơn';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.MenuVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng học sinh';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.TotalStudent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số học sinh thực tế';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.RealityStudent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá định mức';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.QuotaUnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá thực tế';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.RealityUnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chênh lệch';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.DifferenceAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu kê chợ';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.MarketVoucherNoName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thực đơn';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.MenuVoucherNoName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguyên liệu';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.MaterialsID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐVT';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SL quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.ConvetedQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thái bỏ (%)';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.Thrown', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SL thực tế';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.RealityQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.InheritAPK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.InheritAPKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.InheritTableID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguyên liệu';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.MaterialsName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐVT';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.UnitID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.UnitName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dịch vụ';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.ServiceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dịch vụ';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.ServiceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá/người';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.PeopleUnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguyên liệu';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.TabNMT2032', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dịch vụ';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.TabNMT2033', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành phần';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.SystemName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thực tế';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.Ingredient', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định mức';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.QuotaStandard', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ lệ đạt (%)';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.Ratio', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành phần dinh dưỡng';
EXEC ERP9AddLanguage @ModuleID, 'NMF2031.NutritionalIngredients', @FormID, @LanguageValue, @Language;


