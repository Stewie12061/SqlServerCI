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
SET @ModuleID = 'NM';
SET @FormID = 'NMF1051';

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'NMF1051.DivisionID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã món ăn';
EXEC ERP9AddLanguage @ModuleID, 'NMF1051.DishID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Tên món ăn';
EXEC ERP9AddLanguage @ModuleID, 'NMF1051.DishName', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã loại món ăn';
EXEC ERP9AddLanguage @ModuleID, 'NMF1051.DishTypeID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'NMF1051.IsCommon', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'NMF1051.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'NMF1051.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguyên liệu';
EXEC ERP9AddLanguage @ModuleID, 'NMF1051.MaterialsID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'NMF1051.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối lượng';
EXEC ERP9AddLanguage @ModuleID, 'NMF1051.Mass', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối lượng QĐ';
EXEC ERP9AddLanguage @ModuleID, 'NMF1051.ConvertedMass', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật món ăn';
EXEC ERP9AddLanguage @ModuleID, 'NMF1051.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'NMF1051.DishTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'NMF1051.DishTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguyên liệu';
EXEC ERP9AddLanguage @ModuleID, 'NMF1051.MaterialsName', @FormID, @LanguageValue, @Language;

