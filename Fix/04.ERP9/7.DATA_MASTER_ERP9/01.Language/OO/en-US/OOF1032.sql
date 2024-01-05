-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1032- OO
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
SET @FormID = 'OOF1032';

SET @LanguageValue = N'Process step view';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.TaskSampleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.DescriptionT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.TaskSampleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Implementation time (hours)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.ExecutionTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Orders';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.Orders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Step ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.StepID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Step Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.StepName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task Type';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.TaskTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task list';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.DanhSachMauCongViecTheoBuoc', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.LichSu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Step information';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.XemChiTietBuoc', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TargetTypeID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.TargetTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Target Type';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.TargetTypeName', @FormID, @LanguageValue, @Language;
