-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2060- EDM
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
SET @FormID = 'EDMF2060';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.EvaluetionDateFromTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.EvaluetionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.EvaluetionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.EvaluetionDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.SchoolID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.SchoolName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.GradeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.GradeIDFilter', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.ClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.ClassName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.TeacherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.TeacherName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã thành viên tham dự';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.EDMT2061_MemberID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành viên tham dự';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.MemberID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành viên tham dự';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.MemberName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành viên tham dự';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.Member', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian dự giờ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.Time', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết quả đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.ResultID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết quả đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.ResultName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung dự giờ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.Content', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.lblVoteDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết quả dự giờ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.SchoolYearID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.ClassIDFilter', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.ClassID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.ClassName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.GradeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.GradeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.TeacherID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2060.TeacherName.CB', @FormID, @LanguageValue, @Language;