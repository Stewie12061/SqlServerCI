﻿-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF9003- OO
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
SET @ModuleID = 'OO';
SET @FormID = 'OOF9003';

SET @LanguageValue = N'員工代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF9003.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'員工姓名';
EXEC ERP9AddLanguage @ModuleID, 'OOF9003.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'OOF9003.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'OOF9003.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電話';
EXEC ERP9AddLanguage @ModuleID, 'OOF9003.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子郵件';
EXEC ERP9AddLanguage @ModuleID, 'OOF9003.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF9003.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF9003.ContactPersonID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF9003.ContactPersonName', @FormID, @LanguageValue, @Language;

