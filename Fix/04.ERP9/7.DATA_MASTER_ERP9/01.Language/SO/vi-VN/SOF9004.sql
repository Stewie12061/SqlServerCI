------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF9004 - CRM 
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
SET @FormID = 'SOF9004';
------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Chọn Target chương trình khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'SOF9004.Title' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF9004.DivisionID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã target';
EXEC ERP9AddLanguage @ModuleID, 'SOF9004.TargetID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên target';
EXEC ERP9AddLanguage @ModuleID, 'SOF9004.TargetName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Loại target';
EXEC ERP9AddLanguage @ModuleID, 'SOF9004.Type' , @FormID, @LanguageValue, @Language;