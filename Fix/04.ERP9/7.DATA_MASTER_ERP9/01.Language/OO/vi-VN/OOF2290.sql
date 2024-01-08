-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2290- OO
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
SET @FormID = 'OOF2290';

SET @LanguageValue = N'Danh mục chỉ tiêu/công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2290.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2290.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2290.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2290.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chỉ tiêu/công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2290.TargetTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên chỉ tiêu/công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2290.TargetTaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'OOF2290.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời điểm bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2290.BeginDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hạn hoàn thành';
EXEC ERP9AddLanguage @ModuleID, 'OOF2290.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người giao';
EXEC ERP9AddLanguage @ModuleID, 'OOF2290.RequestUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người giao';
EXEC ERP9AddLanguage @ModuleID, 'OOF2290.RequestUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiến độ (%)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2290.Progress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2290.AssignedDepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổ nhóm phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2290.AssignedTeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2290.AssignedUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2290.AssignedUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2290.TypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phân loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2290.TypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2290.DepartmentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2290.DepartmentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tổ nhóm';
EXEC ERP9AddLanguage @ModuleID, 'OOF2290.TeamID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên tổ nhóm';
EXEC ERP9AddLanguage @ModuleID, 'OOF2290.TeamName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2290.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2290.StatusName', @FormID, @LanguageValue, @Language;
