-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2130- OO
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
SET @FormID = 'OOF2130';

SET @LanguageValue = N'Đánh giá công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu (kế hoạch)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.PlanStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kế thúc (kế hoạch)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.PlanEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.TaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.TaskTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.TaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc (thực tế)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.ActualEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu (thực tế)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.ActualStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.TargetsGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.TargetsGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.AssessUserName', @FormID, @LanguageValue, @Language;
