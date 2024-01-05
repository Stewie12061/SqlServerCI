-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1273 - CI
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
SET @ModuleID = 'CI';
SET @FormID = 'CIF1273';

SET @LanguageValue = N'Chọn loại đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1273.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1273.ObjectTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1273.ObjectTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1273.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1273.Disabled', @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;