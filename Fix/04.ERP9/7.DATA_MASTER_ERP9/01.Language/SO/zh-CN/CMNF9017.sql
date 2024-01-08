-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CMNF9017- SO
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
SET @Language = 'zh-CN' 
SET @ModuleID = 'SO';
SET @FormID = 'CMNF9017';

SET @LanguageValue = N'員工程式碼';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9017.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'員工姓名';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9017.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門名稱';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9017.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9017.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電話號碼';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9017.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子郵件';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9017.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9017.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9017.ContactPersonID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9017.ContactPersonName', @FormID, @LanguageValue, @Language;

