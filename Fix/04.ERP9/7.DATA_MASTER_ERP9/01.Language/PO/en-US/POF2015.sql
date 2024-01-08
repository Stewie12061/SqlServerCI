-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2015- PO
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
SET @ModuleID = 'PO';
SET @FormID = 'POF2015';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2015.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'POF2015.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Leadtime_MOQ number';
EXEC ERP9AddLanguage @ModuleID, 'POF2015.LeadTimeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Commodity group';
EXEC ERP9AddLanguage @ModuleID, 'POF2015.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Established staff';
EXEC ERP9AddLanguage @ModuleID, 'POF2015.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Apply from';
EXEC ERP9AddLanguage @ModuleID, 'POF2015.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Apply to';
EXEC ERP9AddLanguage @ModuleID, 'POF2015.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2015.InventoryTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'POF2015.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'POF2015.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'POF2015.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'POF2015.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'POF2015.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'POF2015.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Group code';
EXEC ERP9AddLanguage @ModuleID, 'POF2015.GroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2015.Priority1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2015.Priority2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2015.Priority3', @FormID, @LanguageValue, @Language;

