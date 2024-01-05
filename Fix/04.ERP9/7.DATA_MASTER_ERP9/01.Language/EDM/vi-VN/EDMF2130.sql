-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ 
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
SET @FormID = 'EDMF2130';

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2130.DivisionID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2130.VoucherNo', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2130.SchoolID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2130.GradeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2130.GradeIDFilter', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Loại hình thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2130.ReceiptTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hình thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2130.ReceiptTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại dịch vụ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2130.ServiceTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2130.ClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi phí/Học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2130.Cost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2130.AnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2130.AnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2130.GradeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2130.GradeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2130.ServiceTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2130.ServiceTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đăng ký dịch vụ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2130.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại dịch vụ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2130.Cbb_ServiceTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2130.ClassName', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2130.GradeName', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Loại dịch vụ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2130.ServiceTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hình thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2130.ReceiptTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2130.ClassIDFilter', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2130.ClassID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2130.ClassName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2130.ReceiptTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hình thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2130.ReceiptTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hình thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2130.ComboBoxReceiptTypeID', @FormID, @LanguageValue, @Language;

