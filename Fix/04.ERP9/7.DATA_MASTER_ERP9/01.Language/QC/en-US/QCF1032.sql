-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF1032- QC
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
SET @FormID = 'QCF1032';

SET @LanguageValue = N'Reason view';
EXEC ERP9AddLanguage @ModuleID, 'QCF1032.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1032.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF1032.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason name';
EXEC ERP9AddLanguage @ModuleID, 'QCF1032.ReasonName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Describe';
EXEC ERP9AddLanguage @ModuleID, 'QCF1032.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason code';
EXEC ERP9AddLanguage @ModuleID, 'QCF1032.ReasonID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stage';
EXEC ERP9AddLanguage @ModuleID, 'QCF1032.PhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'QCF1032.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'QCF1032.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'QCF1032.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'QCF1032.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'QCF1032.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Do not use';
EXEC ERP9AddLanguage @ModuleID, 'QCF1032.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'QCF1032.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason information';
EXEC ERP9AddLanguage @ModuleID, 'QCF1032.DanhMucLyDo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'QCF1032.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'QCF1032.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'QCF1032.StatusID', @FormID, @LanguageValue, @Language;