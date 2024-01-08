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
SET @FormID = 'NMF1060';

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'NMF1060.DivisionID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã bữa ăn';
EXEC ERP9AddLanguage @ModuleID, 'NMF1060.MealID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Tên bữa ăn';
EXEC ERP9AddLanguage @ModuleID, 'NMF1060.MealName', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'NMF1060.IsCommon', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'NMF1060.Disabled', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'NMF1060.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh mục bữa ăn';
EXEC ERP9AddLanguage @ModuleID, 'NMF1060.Title', @FormID, @LanguageValue, @Language;

