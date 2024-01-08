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
SET @FormID = 'NMF1040';

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'NMF1040.DivisionID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã loại món ăn';
EXEC ERP9AddLanguage @ModuleID, 'NMF1040.DishTypeID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Tên loại món ăn';
EXEC ERP9AddLanguage @ModuleID, 'NMF1040.DishTypeName', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'NMF1040.IsCommon', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'NMF1040.Disabled', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'NMF1040.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh mục loại món ăn';
EXEC ERP9AddLanguage @ModuleID, 'NMF1040.Title', @FormID, @LanguageValue, @Language;

