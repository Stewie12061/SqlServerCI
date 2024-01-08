-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF1046- KPI
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
SET @ModuleID = 'KPI';
SET @FormID = 'KPIF1046';

SET @LanguageValue = N'KPI parameter View';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1046.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1046.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parameter ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1046.ParameterID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parameter name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1046.ParameterName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1046.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1046.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1046.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1046.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1046.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user id';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1046.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1046.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parameter Information';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1046.TabParameterInformation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1046.TabCRMT00002', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1046.TabCRMT00003', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1046.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1046.StatusID', @FormID, @LanguageValue, @Language;