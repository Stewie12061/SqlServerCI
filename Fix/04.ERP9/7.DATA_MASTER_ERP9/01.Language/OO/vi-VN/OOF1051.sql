-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1051- OO
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
SET @Language = 'vi-VN' 
SET @ModuleID = 'OO';
SET @FormID = 'OOF1051';

SET @LanguageValue = N'Cập nhật mẫu dự án/nhóm công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF1051.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quy trình, Bước và Công việc trong Dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF1051.TreeViewTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1051.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mẫu';
EXEC ERP9AddLanguage @ModuleID, 'OOF1051.ProjectSampleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mẫu';
EXEC ERP9AddLanguage @ModuleID, 'OOF1051.ProjectSampleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'OOF1051.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1051.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'OOF1051.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quy trình';
EXEC ERP9AddLanguage @ModuleID, 'OOF1051.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quy trình';
EXEC ERP9AddLanguage @ModuleID, 'OOF1051.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1051.DescriptionP', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bước';
EXEC ERP9AddLanguage @ModuleID, 'OOF1051.StepID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bước';
EXEC ERP9AddLanguage @ModuleID, 'OOF1051.StepName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1051.DescriptionS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF1051.TaskSampleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF1051.TaskSampleName', @FormID, @LanguageValue, @Language;

