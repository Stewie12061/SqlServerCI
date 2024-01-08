-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF1002- PO
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
SET @FormID = 'POF1002';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF1002.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'POF1002.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Plan step code';
EXEC ERP9AddLanguage @ModuleID, 'POF1002.PlanID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of plan step';
EXEC ERP9AddLanguage @ModuleID, 'POF1002.PlanName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'POF1002.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'POF1002.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'POF1002.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'POF1002.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'POF1002.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'POF1002.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'POF1002.LastModifyDate', @FormID, @LanguageValue, @Language;

