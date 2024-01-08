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
SET @FormID = 'NMF1041';

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'NMF1041.DivisionID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã loại món ăn';
EXEC ERP9AddLanguage @ModuleID, 'NMF1041.DishTypeID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Tên loại món ăn';
EXEC ERP9AddLanguage @ModuleID, 'NMF1041.DishTypeName', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'NMF1041.IsCommon', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'NMF1041.Disabled', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'NMF1041.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật loại món ăn';
EXEC ERP9AddLanguage @ModuleID, 'NMF1041.Title', @FormID, @LanguageValue, @Language;

