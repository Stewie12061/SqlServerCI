-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2213- EDM
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
SET @FormID = 'EDMF2213';

SET @LanguageValue = N'Thiết lập mức đóng phí đầu năm hàng loạt';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2213.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2213.StudentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2213.StudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2213.SchoolYearID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2213.ClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2213.GradeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu phí mới';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2213.FeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học mới';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2213.NewSchoolYearID ', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối mới';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2213.NewGradeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2213.DivisionID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2213.DivisionName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2213.GradeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2213.GradeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2213.ClassID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2213.ClassName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2213.SchoolYearID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2213.DateFrom.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2213.DateTo.CB', @FormID, @LanguageValue, @Language;







