------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2114 - CRM 
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
SET @ModuleID = 'SO';
SET @FormID = 'SOF2114';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Mã hạng mục';
EXEC ERP9AddLanguage @ModuleID, 'SOF2114.StandardID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hạng mục';
EXEC ERP9AddLanguage @ModuleID, 'SOF2114.StandardName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hạng mục (ENG)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2114.StandardNameE' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2114.UnitName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hạng mục tiêu chuẩn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2114.Title' , @FormID, @LanguageValue, @Language;