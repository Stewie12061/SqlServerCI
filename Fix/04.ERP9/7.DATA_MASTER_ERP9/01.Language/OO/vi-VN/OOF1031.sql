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
SET @Language = 'vi-VN' 
SET @ModuleID = 'OO';
SET @FormID = 'OOF1031';

SET @LanguageValue = N'Cập nhật bước quy trình';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bước';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.StepID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bước';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.StepName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.TaskTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.TaskTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.TaskSampleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.DescriptionT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.TaskSampleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian thực hiện (giờ)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.ExecutionTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ tự hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.Orders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.TaskSampleID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.TaskSampleName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.TargetTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.TargetTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.TargetTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'OOF1031.TargetTypeName.CB', @FormID, @LanguageValue, @Language;

