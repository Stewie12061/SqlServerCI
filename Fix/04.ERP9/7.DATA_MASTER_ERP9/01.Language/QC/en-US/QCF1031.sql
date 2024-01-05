-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF1031- QC
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
SET @ModuleID = 'QC';
SET @FormID = 'QCF1031';

SET @LanguageValue = N'Update reasons';
EXEC ERP9AddLanguage @ModuleID, 'QCF1031.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF1031.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason name';
EXEC ERP9AddLanguage @ModuleID, 'QCF1031.ReasonName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'QCF1031.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF1031.ReasonID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'QCF1031.PhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'QCF1031.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'QCF1031.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'QCF1031.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1031.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1031.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Non-use';
EXEC ERP9AddLanguage @ModuleID, 'QCF1031.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'QCF1031.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF1031.DepartmentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'QCF1031.DepartmentName.CB', @FormID, @LanguageValue, @Language

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF1031.PhaseIDSetting.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'QCF1031.PhaseNameSetting.CB', @FormID, @LanguageValue, @Language;