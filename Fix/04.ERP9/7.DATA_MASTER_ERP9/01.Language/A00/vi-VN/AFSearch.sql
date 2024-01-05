------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CMNF9001 - CRM 
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000)
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thuc thi truy van
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @Language = 'vi-VN';
SET @ModuleID = '00';
SET @FormID = 'AFSearch';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Lưu điều kiện lọc';
 EXEC ERP9AddLanguage @ModuleID, 'AFSearch.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên lưu';
 EXEC ERP9AddLanguage @ModuleID, 'AFSearch.SearchName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chia sẻ tất cả';
 EXEC ERP9AddLanguage @ModuleID, 'AFSearch.IsAll' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mặc định';
 EXEC ERP9AddLanguage @ModuleID, 'AFSearch.IsDefault' , @FormID, @LanguageValue, @Language;







