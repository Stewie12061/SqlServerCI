-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2062- EDM
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
SET @FormID = 'EDMF2062';

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2062.Attach.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2062.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2062.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2062.EvaluetionDateFromTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2062.EvaluetionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2062.EvaluetionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2062.EvaluetionDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2062.SchoolID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2062.SchoolName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2062.GradeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2062.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2062.ClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2062.ClassName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2062.TeacherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2062.TeacherName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành viên tham dự';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2062.EDMT2062_MemberID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành viên tham dự';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2062.MemberID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành viên tham dự';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2062.MemberName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành viên tham dự';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2062.Member', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian dự giờ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2062.Time', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết quả đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2062.ResultID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết quả đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2062.ResultName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung dự giờ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2062.Content', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2062.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2062.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2062.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2062.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2062.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2062.lblVoteDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem thông tin kết quả dự giờ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2062.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2062.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2062.Lich_su', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2062.SchoolYearID', @FormID, @LanguageValue, @Language;