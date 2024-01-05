-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF3000 - BEM
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

SET @Language = 'en-US'
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF3000';

SET @LanguageValue = N'Report';
EXEC ERP9AddLanguage @ModuleID, 'BEMF3000.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business Expense Management';
EXEC ERP9AddLanguage @ModuleID, 'AsoftBEM.GRP_BaoCao_BEM', @FormID, @LanguageValue, @Language;