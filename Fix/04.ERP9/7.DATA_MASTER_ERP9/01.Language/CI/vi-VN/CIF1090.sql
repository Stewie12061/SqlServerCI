------------------------------------------------------------------------------------------------------
-- Script t?o ngôn ng? CIF1090 
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
SET @ModuleID = 'CI';
SET @FormID = 'CIF1090';
------------------------------------------------------------------------------------------------------
--- Title
-----------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Danh mục loại mã đối tượng tăng tự động';
EXEC ERP9AddLanguage @ModuleID, 'CIF1090.Title' , @FormID, @LanguageValue, @Language;

--- TAB
-----------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1090.DivisionID' , @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Phân loại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1090.STypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân loại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1090.S' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phân loại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1090.SName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1090.IsCommon' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1090.Disabled' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1090.TypeID' , @FormID, @LanguageValue, @Language;


------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;