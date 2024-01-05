-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF1002 - BEM
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),

------------------------------------------------------------------------------------------------------
-- Tham số gen tự động
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000),

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT

------------------------------------------------------------------------------------------------------
-- Gán giá trị tham số và thực thi truy vấn
------------------------------------------------------------------------------------------------------
/*
    - Tiếng Việt: vi-VN 
    - Tiếng Anh: en-US 
    - Tiếng Nhật: ja-JP
    - Tiếng Trung: zh-CN
*/

SET @Language = 'vi-VN' 
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF1002';

SET @LanguageValue = N'APK';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1002.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1002.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1002.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1002.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1002.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1002.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1002.FeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1002.FeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1002.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1002.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1002.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1002.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin Loại phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1002.ThongTinLoaiphi', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem chi tiết Loại phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1002.Title', @FormID, @LanguageValue, @Language;

