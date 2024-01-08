-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2050- SO
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
SET @ModuleID = 'SO';
SET @FormID = 'SOF2050';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2050.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'SOF2050.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Staff';
EXEC ERP9AddLanguage @ModuleID, 'SOF2050.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'SOF2050.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'SOF2050.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2050.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2050.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Limit granted';
EXEC ERP9AddLanguage @ModuleID, 'SOF2050.TotalQuota', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Year';
EXEC ERP9AddLanguage @ModuleID, 'SOF2050.Year', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee code';
EXEC ERP9AddLanguage @ModuleID, 'SOF2050.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Debt limit';
EXEC ERP9AddLanguage @ModuleID, 'SOF2050.Beginning', @FormID, @LanguageValue, @Language;

