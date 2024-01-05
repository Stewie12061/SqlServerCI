-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1031- OO
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
SET @ModuleID = 'OO';
SET @FormID = 'OOF1031';

SET @LanguageValue = N'Update process steps';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Step ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.StepID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Step Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.StepName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task Type';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.TaskTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task Type';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.TaskTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.TaskSampleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.DescriptionT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.TaskSampleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Implementation time (hours)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.ExecutionTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Orders';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.Orders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.TaskSampleID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.TaskSampleName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TargetTypeID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.TargetTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Target Type Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.TargetTypeName', @FormID, @LanguageValue, @Language;
