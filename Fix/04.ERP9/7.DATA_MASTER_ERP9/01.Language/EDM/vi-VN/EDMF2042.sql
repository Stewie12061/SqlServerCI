-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2042- EDM
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
SET @FormID = 'EDMF2042';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điểm danh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày điểm danh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.AttendanceDateFromTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày điểm danh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.AttendanceDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.SchoolYearID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.SchoolYearName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.SchoolID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.SchoolName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.GradeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.ClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.ClassName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lý do';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.Reason', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.DecisionDateFromTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.TeacherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.GradeIDTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.ClassIDTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.TeacherName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày điểm danh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.lblAttendanceDateFromTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem thông tin điểm danh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem thông tin điểm danh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.Detail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.Lich_su', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.Chi_tiet', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.Attach.GR' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.Notes.GR' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày xin phép';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.DateException' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nghỉ đặc biệt';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.IsException' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiện diện';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.DayAvailable' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vắng có phép';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.DayAbsentPermission' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vắng không phép';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.DayAbsentNotPermission' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.AvailableStatusName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.StudentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2042.StudentID' , @FormID, @LanguageValue, @Language;
