-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2024- EDM
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
SET @FormID = 'EDMF2024';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2024.TxtSearch', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2024.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2024.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã xếp lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2024.ArrangeClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2024.SchoolYearID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2024.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2024.ClassName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa xếp lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2024.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2024.SchoolYearID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2024.DateFrom.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2024.DateTo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2024.GradeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2024.ClassName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2024.GradeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2024.ClassID.CB', @FormID, @LanguageValue, @Language;

---[Đình Hoà] [23/06/2020] Thêm ngôn ngữ cho

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2024.GradeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2024.ClassID', @FormID, @LanguageValue, @Language;