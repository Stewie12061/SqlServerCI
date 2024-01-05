-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1060- OO
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
SET @FormID = 'OOF1060';

SET @LanguageValue = N'List of tasks';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task sample ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.TaskSampleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task sample name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.TaskSampleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Execution time (hour)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.ExecutionTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Percent Progress (%)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.PercentProgress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task type';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.TaskTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Target type';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.TargetTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Block type ';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.TaskBlockTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.TargetTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.TargetTypeName.CB', @FormID, @LanguageValue, @Language;