-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2015- EDM
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
SET @FormID = 'EDMF2015';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2015.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2015.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2015.StudentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2015.StudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2015.SchoolID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2015.GradeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Câp nhật xác nhận hồ sơ học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2015.Title', @FormID, @LanguageValue, @Language;