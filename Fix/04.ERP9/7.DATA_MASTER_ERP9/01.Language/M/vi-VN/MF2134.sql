-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2134- M
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
SET @ModuleID = 'M';
SET @FormID = 'MF2134';

SET @LanguageValue = N'Chọn danh mục nguồn lực';
EXEC ERP9AddLanguage @ModuleID, 'MF2134.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'MF2134.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nguồn lực';
EXEC ERP9AddLanguage @ModuleID, 'MF2134.ResourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nguồn lực';
EXEC ERP9AddLanguage @ModuleID, 'MF2134.ResourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'MF2134.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'MF2134.UnitName', @FormID, @LanguageValue, @Language;


