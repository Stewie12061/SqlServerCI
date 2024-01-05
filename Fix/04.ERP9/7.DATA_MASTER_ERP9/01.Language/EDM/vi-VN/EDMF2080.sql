-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2080- EDM
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
SET @ModuleID = 'EDM';
SET @FormID = 'EDMF2080';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày nghỉ học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.LeaveDateFromTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày quyết định';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.DecisiveDateFromTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số quyết định';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.VoucherLeaveSchool', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày quyết định';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.DecisiveDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.ProponentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.ProponentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.SchoolID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.SchoolName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.StudentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.StudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày nghỉ học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.LeaveDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lý do';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.Reason', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người quyết định';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.DeciderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người quyết định';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.DeciderName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày nghỉ học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.lblLeaveDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày quyết định';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.lblDecisiveDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quyết định nghỉ học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.SchoolYearID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.GradeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.ClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ra trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.IsGraduate', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.SchoolYearID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.DateFrom.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.DateTo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.GradeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.GradeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.ClassID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.ClassName.CB', @FormID, @LanguageValue, @Language;

-- Đình Hòa - [12/04/2021] - Bổ sung ngôn ngữ
SET @LanguageValue = N'Chuyển lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2080.IsClassUp', @FormID, @LanguageValue, @Language;


