-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2061- EDM
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
SET @FormID = 'EDMF2061';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.EvaluetionDateFromTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.EvaluetionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.EvaluetionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.EvaluetionDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.SchoolID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.SchoolName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.GradeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.ClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.ClassName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.TeacherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.TeacherName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành viên tham dự';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.EDMT2061_MemberID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành viên tham dự';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.MemberID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành viên tham dự';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.MemberName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành viên tham dự';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.Member', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian dự giờ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.Time', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết quả đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.ResultID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết quả đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.ResultName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung dự giờ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.Content', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.lblVoteDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật kết quả dự giờ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.SchoolYearID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.SchoolYearID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.DateFrom.CB', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.DateTo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.ClassID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.ClassName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.GradeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.GradeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.TeacherID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2061.TeacherName.CB', @FormID, @LanguageValue, @Language;