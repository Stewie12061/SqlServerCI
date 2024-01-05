-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2052- EDM
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
SET @FormID = 'EDMF2052';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.Attach.GR' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.Notes.GR' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.ResultDateFromTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.DivisionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số kết quả';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.VoucherResult', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết quả';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.ResultDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.SchoolID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.SchoolName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.GradeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.ClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.ClassName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.StudentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.StudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung hoạt động trong ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.Content', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Feeling';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.FeelingID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Feeling';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.FeelingName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.DishName1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng 1';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.EatingStatusID1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng 1';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.EatingStatusName1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.DishName2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng 2';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.EatingStatusID2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng 2';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.EatingStatusName2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.DishName3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng 3';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.EatingStatusID3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng 3';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.EatingStatusName3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.DishName4', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng 4';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.EatingStatusID4', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng 4';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.EatingStatusName4', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.DishName5', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng 5';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.EatingStatusID5', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng 5';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.EatingStatusName5', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ giờ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.HoursFrom', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến giờ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.HoursTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ vựng tiếng Anh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.EnglishVocabulary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú của giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.TeacherNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú của phụ huynh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.ParentNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung hoạt động hằng ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.lblContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thực đơn';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.lblMenu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian nghỉ trưa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.lblTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ vựng anh văn';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.lblVocabulary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.lblTeacherNote', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi chú phụ huynh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.lblParentNote', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem kết quả học tập';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.Lich_su', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2052.SchoolYearID', @FormID, @LanguageValue, @Language;