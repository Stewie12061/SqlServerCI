-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2043- EDM
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
SET @FormID = 'EDMF2043';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2043.TxtSearch', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2043.APKConsultant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã xếp lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2043.ArrangeClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2043.SchoolYearID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2043.SchoolYearName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2043.GradeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2043.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2043.ClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2043.ClassName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn xếp lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2043.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2043.GradeID.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2043.GradeName.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2043.ClassID.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2043.ClassName.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2043.SchoolYearID.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2043.DateFrom.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2043.DateTo.CB', @FormID, @LanguageValue, @Language;

--delete from A00001 where ID like '%EDMF2043%'

