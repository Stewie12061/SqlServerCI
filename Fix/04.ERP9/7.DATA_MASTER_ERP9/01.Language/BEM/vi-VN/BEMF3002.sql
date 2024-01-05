-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF3002 - BEM
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
SET @FormID = 'BEMF3002';

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3002.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3002.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3002.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3002.CountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3002.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Báo cáo công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3002.Title', @FormID, @LanguageValue, @Language;