-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2041- EDM
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
SET @FormID = 'EDMF2041';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điểm danh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày điểm danh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.AttendanceDateFromTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.AvailableStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày điểm danh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.AttendanceDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.SchoolYearID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.StudentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.StudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiện diện';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.DayAvailable', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vắng có phép';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.DayAbsentPermission', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vắng không phép';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.DayAbsentNotPermission', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.SchoolYearName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.SchoolID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.SchoolName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.GradeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.ClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.ClassName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lý do';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.Reason', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.DecisionDateFromTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.TeacherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.GradeIDTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.ClassIDTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.TeacherName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày điểm danh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.lblAttendanceDateFromTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Câp nhật điểm danh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn xếp lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.btnChosseClass', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.ClassID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.ClassName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.GradeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.GradeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.SchoolYearID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.DateFrom.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.DateTo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.AvailableStatusID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.AvailableStatusName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày xin phép';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.DateException' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nghỉ đặc biệt';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.IsException' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiện diện';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.Online' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nghỉ phép';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2041.Offline' , @FormID, @LanguageValue, @Language;