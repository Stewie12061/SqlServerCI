-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CSMF2031- CSM
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
SET @FormID = 'CSMF2031';

SET @LanguageValue = N'Số PSC';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2031.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tham chiếu';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2031.DispatchID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Model';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2031.Model', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số Serial';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2031.SerialNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số IMEI';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2031.IMEINumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SymptomCode';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2031.SymptomCode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều phối kỹ thuật hàng loạt';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2031.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn phiếu sửa chữa';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2031.DispatchID_M', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2031.EmployeeName', @FormID, @LanguageValue, @Language;