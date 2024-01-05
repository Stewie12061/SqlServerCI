-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2051- EDM
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
SET @FormID = 'EDMF2051';

SET @LanguageValue = N'Cập nhật kết quả học tập';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.ResultDateFromTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số kết quả';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.VoucherResult', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết quả';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.ResultDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.SchoolYearID ', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.SchoolID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.SchoolName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.GradeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.ClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.ClassName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.StudentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.StudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung hoạt động trong ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.Content', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Feeling';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.FeelingID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Feeling';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.FeelingName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.DishName1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng 1';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.EatingStatusID1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng 1';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.EatingStatusName1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.DishName2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng 2';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.EatingStatusID2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng 2';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.EatingStatusName2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.DishName3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng 3';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.EatingStatusID3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng 3';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.EatingStatusName3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.DishName4', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng 4';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.EatingStatusID4', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng 4';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.EatingStatusName4', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.DishName5', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng 5';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.EatingStatusID5', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng 5';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.EatingStatusName5', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ giờ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.HoursFrom', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến giờ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.HoursTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ vựng tiếng Anh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.EnglishVocabulary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú của giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.TeacherNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú của phụ huynh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.ParentNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung hoạt động hằng ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.lblContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thực đơn';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.lblMenu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian nghỉ trưa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.lblTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ vựng anh văn';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.lblVocabulary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.lblTeacherNote', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi chú phụ huynh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.lblParentNote', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.SchoolYearID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.DateFrom.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.DateTo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.ClassID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.ClassName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.GradeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2051.GradeName.CB', @FormID, @LanguageValue, @Language;