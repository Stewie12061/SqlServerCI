-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF3029- OO
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
SET @FormID = 'OOF3029';

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF3029.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF3029.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự án/Nhóm công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF3029.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'OOF3029.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF3029.DepartmentID_UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'OOF3029.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'OOF3029.GroupReport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dữ liệu báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'OOF3029.GroupReport1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'OOF3029.ReportID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'OOF3029.ReportName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiêu đề báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'OOF3029.ReportTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Báo cáo công việc theo nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'OOF3029.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'OOF3029.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOR3029.IsNotViolated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cố tình vi phạm';
EXEC ERP9AddLanguage @ModuleID, 'OOR3029.IsViolated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trễ tiến độ';
EXEC ERP9AddLanguage @ModuleID, 'OOR3029.LateProgress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ và tên:';
EXEC ERP9AddLanguage @ModuleID, 'OOR3029.FullName', @FormID, @LanguageValue, @Language;
