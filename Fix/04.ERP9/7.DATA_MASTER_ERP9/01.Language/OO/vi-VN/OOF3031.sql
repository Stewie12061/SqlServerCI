-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF3031- OO
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
SET @ModuleID = 'OO';
SET @FormID = 'OOF3031';

SET @LanguageValue = N'Báo cáo lãi lỗ dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF3031.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF3031.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF3031.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF3031.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng GT Hợp đồng chưa thuế';
EXEC ERP9AddLanguage @ModuleID, 'OOF3031.TotalBeforeTax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng GT Hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'OOF3031.TotalAfterTax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thuế VAT';
EXEC ERP9AddLanguage @ModuleID, 'OOF3031.VATTax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi phí dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF3031.ProjectCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'OOF3031.Discount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá hàng nhập khẩu';
EXEC ERP9AddLanguage @ModuleID, 'OOF3031.ImportCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá vật tư thiết bị thầu phụ';
EXEC ERP9AddLanguage @ModuleID, 'OOF3031.SubcontractorSost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dịch vụ KHCU báo';
EXEC ERP9AddLanguage @ModuleID, 'OOF3031.KHCUService', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi phí khảo sát';
EXEC ERP9AddLanguage @ModuleID, 'OOF3031.SurveyCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi phí tiếp khách';
EXEC ERP9AddLanguage @ModuleID, 'OOF3031.GuestCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi phí hoa hồng';
EXEC ERP9AddLanguage @ModuleID, 'OOF3031.Revenue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi phí thuế hoa hồng (trên 5%)';
EXEC ERP9AddLanguage @ModuleID, 'OOF3031.TaxCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hệ số chiết khấu ({0}%)';
EXEC ERP9AddLanguage @ModuleID, 'OOF3031.DiscountFactor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lợi nhuận';
EXEC ERP9AddLanguage @ModuleID, 'OOF3031.Profit', @FormID, @LanguageValue, @Language;
