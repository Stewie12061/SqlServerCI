-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HF0393- OO
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
SET @FormID = 'EDMF2053';

SET @LanguageValue = N'Danh sách thông báo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2053.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã HS';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2053.StudentId' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2053.StudentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã PH';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2053.ParentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phụ huynh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2053.ParentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2053.Telephone' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2053.GradeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2053.ClassID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã dự thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2053.EstimateID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày dự thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2053.EstimateDate' , @FormID, @LanguageValue, @Language;