﻿-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF9003- CI
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
SET @Language = 'en-US' 
SET @ModuleID = 'CI';
SET @FormID = 'CIF9003';

SET @LanguageValue = N'Employee code';
EXEC ERP9AddLanguage @ModuleID, 'CIF9003.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Staff is name';
EXEC ERP9AddLanguage @ModuleID, 'CIF9003.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'CIF9003.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CIF9003.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phone number';
EXEC ERP9AddLanguage @ModuleID, 'CIF9003.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CIF9003.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'CIF9003.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact person code ';
EXEC ERP9AddLanguage @ModuleID, 'CIF9003.ContactPersonID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact person name ';
EXEC ERP9AddLanguage @ModuleID, 'CIF9003.ContactPersonName', @FormID, @LanguageValue, @Language;

