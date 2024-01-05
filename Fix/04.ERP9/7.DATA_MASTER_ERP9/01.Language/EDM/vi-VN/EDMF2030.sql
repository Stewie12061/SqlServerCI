-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2030- EDM
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
SET @FormID = 'EDMF2030';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.DivisionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phân công';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.SchoolYearID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.SchoolYearName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.SchoolID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.SchoolName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.GradeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.GradeIDFilter', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.ClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.ClassName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.TeacherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.TeacherName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.EDMT2031_TeacherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.EDMT2031_TeacherName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bảo mẫu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.NannyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảo mẫu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.NannyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bảo mẫu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.EDMT2032_NannyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảo mẫu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.EDMT2032_NannyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân công giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.ClassIDFilter', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.ClassID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.ClassName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.GradeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.GradeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.SchoolYearID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.DateFrom.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2030.DateTo.CB', @FormID, @LanguageValue, @Language;
