-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2291- OO
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
SET @FormID = 'OOF2291';

SET @LanguageValue = N'Cập nhật chỉ tiêu/công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2291.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2291.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chỉ tiêu/công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2291.TargetTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên chỉ tiêu/công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2291.TargetTaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'OOF2291.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời điểm bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2291.BeginDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hạn hoàn thành';
EXEC ERP9AddLanguage @ModuleID, 'OOF2291.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người giao';
EXEC ERP9AddLanguage @ModuleID, 'OOF2291.RequestUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người giao';
EXEC ERP9AddLanguage @ModuleID, 'OOF2291.RequestUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiến độ (%)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2291.Progress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2291.AssignedDepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổ nhóm phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2291.AssignedTeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2291.AssignedUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2291.AssignedUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'OOF2291.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2291.TypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phân loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2291.TypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2291.DepartmentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2291.DepartmentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tổ nhóm';
EXEC ERP9AddLanguage @ModuleID, 'OOF2291.TeamID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên tổ nhóm';
EXEC ERP9AddLanguage @ModuleID, 'OOF2291.TeamName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2291.StatusID', @FormID, @LanguageValue, @Language;
