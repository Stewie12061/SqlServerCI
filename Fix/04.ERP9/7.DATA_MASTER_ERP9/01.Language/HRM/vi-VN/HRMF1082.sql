-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1082- HRM
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


SET @Language = 'vi-VN';
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF1082'

SET @LanguageValue  = N'Cập nhật định nghĩa các khoản thu nhập, giảm trừ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1082.Title',  @FormID, @LanguageValue, @Language;
--tab
SET @LanguageValue  = N'Các khoản thu nhập'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1082.CacKhoanThuNhap',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Các khoản giảm trừ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1082.CacKhoanGiamTru',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Tên gọi tiếng việt'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1082.Caption',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên gọi tiếng anh'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1082.CaptionE',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sử dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1082.IsUsed',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế thu nhập'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1082.Istax',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kết chuyển'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1082.IsTranfer',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính thực lãnh'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1082.IsCalculateNetIncome',  @FormID, @LanguageValue, @Language;
