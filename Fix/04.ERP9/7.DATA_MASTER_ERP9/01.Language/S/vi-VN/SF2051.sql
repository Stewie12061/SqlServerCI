-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF2051 - S
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
SET @ModuleID = 'S';
SET @FormID = 'SF2051';

SET @LanguageValue = N'Ý kiến người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.ApprovePersonNote', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trang thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2056.ApprovePersonStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Duyệt hàng loạt';
EXEC ERP9AddLanguage @ModuleID, 'SF2051.Title', @FormID, @LanguageValue, @Language;

