-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF3028- OO
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
SET @FormID = 'OOF3028';

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF3028.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF3028.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự án/Nhóm công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF3028.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF3028.DepartmentID_ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'OOF3028.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'OOF3028.GroupReport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dữ liệu báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'OOF3028.GroupReport1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'OOF3028.ReportID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'OOF3028.ReportName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiêu đề báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'OOF3028.ReportTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Báo cáo công việc theo dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF3028.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'OOF3028.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Báo cáo theo nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'AsoftOO.GRP_Employee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Báo cáo theo công việc';
EXEC ERP9AddLanguage @ModuleID, 'AsoftOO.GRP_Project', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'OOF3029.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dữ liệu in';
EXEC ERP9AddLanguage @ModuleID, 'OOF3028.PrintData', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái vấn đề';
EXEC ERP9AddLanguage @ModuleID, 'OOF3028.StatusIS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái milestone';
EXEC ERP9AddLanguage @ModuleID, 'OOF3028.StatusMT', @FormID, @LanguageValue, @Language;