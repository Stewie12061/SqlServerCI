-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2050- EDM
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
SET @FormID = 'EDMF2050';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.ResultDateFromTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số kết quả';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.VoucherResult', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết quả';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.ResultDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.SchoolID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.SchoolName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.GradeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.GradeIDFilter', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.ClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.ClassName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.StudentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.StudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung hoạt động trong ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.Content', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.FeelingID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.FeelingName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.DishName1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng 1';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.EatingStatusID1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng 1';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.EatingStatusName1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.DishName2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng 2';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.EatingStatusID2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng 2';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.EatingStatusName2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.DishName3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng 3';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.EatingStatusID3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng 3';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.EatingStatusName3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.DishName4', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng 4';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.EatingStatusID4', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng 4';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.EatingStatusName4', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.DishName5', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng 5';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.EatingStatusID5', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng 5';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.EatingStatusName5', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ giờ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.HoursFrom', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến giờ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.HoursTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ vựng tiếng Anh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.EnglishVocabulary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú của giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.TeacherNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú của phụ huynh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.ParentNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung hoạt động hằng ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.lblContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thực đơn';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.lblMenu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian nghỉ trưa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.lblTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ vựng anh văn';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.lblVocabulary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.lblTeacherNote', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi chú phụ huynh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.lblParentNote', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết quả học tập';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.Title', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.SchoolYearID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.ClassIDFilter', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.ClassID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.ClassName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.GradeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2050.GradeName.CB', @FormID, @LanguageValue, @Language;