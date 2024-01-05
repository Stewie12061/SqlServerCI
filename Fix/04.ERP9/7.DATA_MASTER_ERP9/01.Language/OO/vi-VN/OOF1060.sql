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
SET @Language = 'vi-VN' 
SET @ModuleID = 'OO';
SET @FormID = 'OOF1060';

SET @LanguageValue = N'Danh mục mẫu công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mẫu công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.TaskSampleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mẫu công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.TaskSampleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian thực hiện (giờ)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.ExecutionTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiến độ (%)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.PercentProgress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.TaskTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.TargetTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chốt chặn';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.TaskBlockTypeID', @FormID, @LanguageValue, @Language;
