-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2190- EDM
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
SET @FormID = 'EDMF2190';

SET @LanguageValue = N'Dặn thuốc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2190.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2190.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2190.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2190.DivisionID.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2190.DivisionName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2190.StudentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2190.StudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2190.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ huynh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2190.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ huynh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2190.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2190.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2190.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bệnh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2190.SickName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2190.ClassName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2190.ClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2190.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày lọc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2190.MedicineDate', @FormID, @LanguageValue, @Language;



