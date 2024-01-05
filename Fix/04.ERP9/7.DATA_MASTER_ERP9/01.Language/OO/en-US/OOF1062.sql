-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1062- OO
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
SET @FormID = 'OOF1062';

SET @LanguageValue = N'Task sample view';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task sample ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.TaskSampleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task sample name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.TaskSampleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Execution time (hour)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.ExecutionTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Percent Progress (%)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.PercentProgress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task type';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.TaskTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Target type';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.TargetTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Block type ';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.TaskBlockTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Checklist name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.ChecklistName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.LichSu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Checklist details';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.ThongTinChecklist', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task Sample Information';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.ThongTinMauCongViec', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.ThongTinMoTa', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.StatusID', @FormID, @LanguageValue, @Language;