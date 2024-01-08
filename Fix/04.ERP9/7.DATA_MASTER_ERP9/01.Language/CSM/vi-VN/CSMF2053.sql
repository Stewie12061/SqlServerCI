-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CSMF2053- CSM
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
SET @ModuleID = 'CSM';
SET @FormID = 'CSMF2053';

SET @LanguageValue = N'Cập nhật PSC vào biên bản trả hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2053.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số PSC';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2053.VoucherNo_REL', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2053.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái xác nhận';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2053.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu tham chiếu';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2053.DispatchID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2053.ProductID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2053.ProductName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số IMEI mới';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2053.IMEINoNew', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số IMEI';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2053.IMEINo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số Serial mới';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2053.SerialNoNew', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số Serial';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2053.SerialNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin lỗi';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2053.ErrorInformation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2053.CustomerGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái xác nhận';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2053.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Model';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2053.Model', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên ASP';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2053.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số AWB';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2053.AWBNo', @FormID, @LanguageValue, @Language;

