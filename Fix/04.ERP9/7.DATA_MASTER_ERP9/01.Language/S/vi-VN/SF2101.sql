------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF2101 - S
-- Người tạo: Tấn Thành - 21/01/2021
-----------------------------------------------------------------------------------------------------
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
SET @ModuleID = 'S';
SET @FormID = 'SF2101';
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Thiết lập biến môi trường';
EXEC ERP9AddLanguage @ModuleID, 'SF2101.Title' , @FormID, @LanguageValue, @Language;
------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SF2101.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại';
EXEC ERP9AddLanguage @ModuleID, 'SF2101.TypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên biến';
EXEC ERP9AddLanguage @ModuleID, 'SF2101.KeyName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức năng';
EXEC ERP9AddLanguage @ModuleID, 'SF2101.GroupName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kiểu dữ liệu';
EXEC ERP9AddLanguage @ModuleID, 'SF2101.DataTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị';
EXEC ERP9AddLanguage @ModuleID, 'SF2101.KeyValue' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị mặc định';
EXEC ERP9AddLanguage @ModuleID, 'SF2101.DesDefaultValue' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'SF2101.ModuleID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'SF2101.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biến môi trường';
EXEC ERP9AddLanguage @ModuleID, 'SF2101.IsEnvironment' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SF2101.DivisionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SF2101.DivisionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SF2101.DivisionName' , @FormID, @LanguageValue, @Language;