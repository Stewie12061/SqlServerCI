-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1360- CI
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
SET @ModuleID = 'CRM';
SET @FormID = 'CIF1360';

SET @LanguageValue = N'Danh mục hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Report', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Ana01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Ana02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Ana03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Ana04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Ana05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Ana06ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Ana07ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Ana08ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Ana09ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Ana10ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.ContractName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày ký hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.SignDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.BeginDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.ContractType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị HĐ Nguyên tệ (trước thuế)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị HĐ quy đổi (trước thuế)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.ConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Contactor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ lục';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.IsAppendixContract', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.ContractID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.AnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.AnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.AnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.AnaName.CB', @FormID, @LanguageValue, @Language;

-- Hoài Phong [03/03/2021] Bổ sung ngôn ngũ cho gói  hợp đồng
SET @LanguageValue = N'Gói hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.ContractPackageID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị HĐ Nguyên tệ (sau thuế)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.MasterVATOriginalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị HĐ quy đổi (sau thuế)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.MasterVATConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị HĐ Nguyên tệ (sau thuế)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.VATOriginalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị HĐ quy đổi (sau thuế)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.VATConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.AssignedToUserName', @FormID, @LanguageValue, @Language;

