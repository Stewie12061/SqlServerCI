------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF0005 - CRM 
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
SET @Language = 'ja-JP';
SET @ModuleID = 'SO';
SET @FormID = 'SOF0005';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Chọn người dùng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0005.SOF0005Title' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Mã người dùng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0005.UserID' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Tên người dùng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0005.UserName' , @FormID, @LanguageValue, @Language;


 